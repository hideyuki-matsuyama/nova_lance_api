# frozen_string_literal: true

module V1
  class ExamplesController < ApplicationController
    before_action :set_example, only: %i[show update destroy]

    # GET /examples
    def index
      @examples = Example.order(:id)
      render json: V1::ExampleSerializer.new(@examples), status: :ok
    end

    # GET /examples/1
    def show
      render json: V1::ExampleSerializer.new(@example), status: :ok
    end

    # POST /examples
    def create
      @example = Example.new(example_params)

      if @example.save
        render json: V1::ExampleSerializer.new(@example), status: :created
      else
        render json: @example.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /examples/1
    def update
      if @example.update(example_params)
        render json: ExampleSerializer.new(@example), status: :ok
      else
        render json: @example.errors, status: :unprocessable_entity
      end
    end

    # DELETE /examples/1
    def destroy
      @example.destroy!
      head :ok
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_example
      @example = Example.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def example_params
      params.permit(:first_name, :last_name)
    end
  end
end
