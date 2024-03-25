# frozen_string_literal: true

class Node < ApplicationRecord
  has_ancestry

  has_many :birds, dependent: :restrict_with_exception
end
