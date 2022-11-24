class Movie < ApplicationRecord
  belongs_to :director

  include PgSearch::Model
  # pg_search_scope :METHOD_NAME,
  #                 against: [:column_1, :column_2, ...]
  #                 using: {
  #                   tsearch: { prefix: true } # LOOK FOR HALF WORDS
  #                 }

  pg_search_scope :search_by_title_and_synopsis,
                  against: [:title, :synopsis],
                  using: {
                    tsearch: { prefix: true } # LOOK FOR HALF WORDS
                  }

  pg_search_scope :global_search,
                  against: %i[title synopsis],
                  associated_against: {
                    director: %i[first_name last_name]
                  },
                  using: {
                    tsearch: { prefix: true } # LOOK FOR HALF WORDS
                  }

  # MULTISEARCH
  multisearchable against: %i[title synopsis]
end
