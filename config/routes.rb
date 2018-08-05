Rails.application.routes.draw do
  scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
  end
end
