# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Static content', type: :system do
  # автоматически создаем значения x и y
  let(:query_number) { 10 }
  let(:query_sequence) do
    i = 1
    mas = []
    query_number.times do
      mas << (i > 3 ? (i**2) : i)
      i += 1
    end
    mas.join(' ')
  end
  let(:result) do
    array = query_sequence.split.map(&:to_i)
    number = query_number.to_i
    enum = array.slice_when do |before, after|
      before_mod = (Math.sqrt(before) % 1).zero?
      after_mod = (Math.sqrt(after) % 1).zero?
      (!before_mod && after_mod) || (before_mod && !after_mod)
    end

    sequences = enum.to_a.select { |array| array.any? { |element| (Math.sqrt(element) % 1).zero? } }
    {
      sequences: JSON.generate(sequences),
      maxsequence: JSON.generate(sequences.max_by(&:size)),
      sequences_number: sequences.size
    }
  end

  let(:query_number1) { 10 }
  let(:query_sequence1) { '2 3 5 6 7 8 10 11 12 13' }

  scenario 'visiting the index' do
    visit users_path
    expect(find('h1')).to have_text("Users")
  end

  scenario 'creating and destroying user' do
    visit users_path # переходим на страницы ввода
    click_on "New user"

    fill_in "user[username]", with: 'test_user' # заполняем поле с name="username"
    fill_in "user[password]", with: '123' # заполняем поле с name="password"
    fill_in "user[password_confirmation]", with: '123' # заполняем поле с name="password_confirmation"

    click_on "Create User"

    expect(find('body')).to have_text('User was successfully created.')

    click_on "Destroy this user"

    expect(find('body')).to have_text('User was successfully destroyed.')
  end

  # сценарий неправильного ввода формы
  scenario 'creating user and calculating' do
    visit users_path # переходим на страницы ввода
    click_on "New user"

    fill_in "user[username]", with: 'test_user' # заполняем поле с name="username"
    fill_in "user[password]", with: '123' # заполняем поле с name="password"
    fill_in "user[password_confirmation]", with: '123' # заполняем поле с name="password_confirmation"

    click_on "Create User"

    expect(find('body')).to have_text('User was successfully created.')

    visit calcs_path

    click_on "New calc"

    fill_in :query_number, with: query_number1 # заполняем поле с name="query_number"
    fill_in :query_sequence, with: query_sequence1 # заполняем поле с name="query_sequence"

    click_on "Добавить запись:"

    expect(find('body')).to have_text('Calc was successfully created.')

    click_on "Destroy this calc"

    expect(find('body')).to have_text('Calc was successfully destroyed.')

    click_on 'test_user'

    click_on "Destroy this user"

    expect(find('body')).to have_text('User was successfully destroyed.')
  end

  scenario 'when checking that there no access to calculating without login' do
    visit calcs_path # переходим на страницу с calcs
    expect(find('body')).to have_text('Требуется логин')

    visit new_calc_path # переходим на страницу создания нового вычисления
    expect(find('body')).to have_text('Требуется логин')
  end
end
