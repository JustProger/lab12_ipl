# frozen_string_literal: true

json.extract! calc, :id, :query_number, :query_sequence, :sequences, :maxsequence, :sequences_number, :created_at,
              :updated_at
json.url calc_url(calc, format: :json)
