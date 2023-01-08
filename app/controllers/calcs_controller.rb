# frozen_string_literal: true

class CalcsController < ApplicationController
  before_action :set_calc, only: %i[show edit update destroy]

  # GET /calcs or /calcs.json
  def index
    @calcs = Calc.all
  end

  # GET /calcs/1 or /calcs/1.json
  def show; end

  # GET /calcs/new
  def new
    @calc = Calc.new
  end

  # GET /calcs/1/edit
  def edit; end

  # POST /calcs or /calcs.json
  def create
    @calc = Calc.add_number_bd(params, current_user.id)

    respond_to do |format|
      if @calc.save
        format.html { redirect_to calc_url(@calc), notice: 'Calc was successfully created.' }
        format.json { render :show, status: :created, location: @calc }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @calc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calcs/1 or /calcs/1.json
  def update
    respond_to do |format|
      if @calc.update(calc_params)
        format.html { redirect_to calc_url(@calc), notice: 'Calc was successfully updated.' }
        format.json { render :show, status: :ok, location: @calc }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @calc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calcs/1 or /calcs/1.json
  def destroy
    @calc.destroy

    respond_to do |format|
      format.html { redirect_to calcs_url, notice: 'Calc was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_calc
    @calc = Calc.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def calc_params
    params.require(:calc).permit(:query_number, :query_sequence)
  end
end
