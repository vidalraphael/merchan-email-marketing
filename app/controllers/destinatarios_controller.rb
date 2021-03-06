class DestinatariosController < ApplicationController
  before_action :set_destinatario, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  has_scope :by_query

  # GET /destinatarios
  # GET /destinatarios.json
  def index
    @destinatarios = apply_scopes(Destinatario).all
  end

  # GET /destinatarios/1.json
  def show
    respond_to do |format|
      format.json { render json: @destinatario }
    end
  end

  # GET /destinatarios/new
  def new
    @destinatario = Destinatario.new
  end

  # GET /destinatarios/1/edit
  def edit
  end

  # POST /destinatarios
  # POST /destinatarios.json
  def create
    @destinatario = Destinatario.new(destinatario_params)
    @destinatario.status = true
    respond_to do |format|
      if @destinatario.save
        format.html do
          redirect_to destinatarios_path, notice: {
              type: 'success',
              message: "#{@destinatario} adicionado com sucesso"
          }
        end
        format.json { render :show, status: :created, location: @destinatario }
      else
        format.html { render :new }
        format.json { render json: @destinatario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /destinatarios/1
  # PATCH/PUT /destinatarios/1.json
  def update
    respond_to do |format|
      if @destinatario.update(destinatario_params)
        format.html do
          redirect_to destinatarios_path, notice: {
              type: 'info',
              message: "#{@destinatario} atualizado com sucesso."
          }
        end
        format.json { render :show, status: :ok, location: @destinatario }
      else
        format.html { render :edit }
        format.json { render json: @destinatario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /destinatarios/1
  # DELETE /destinatarios/1.json
  def destroy
    status = @destinatario.status = !@destinatario.status
    @destinatario.save

    respond_to do |format|
      format.html do
        redirect_to destinatarios_url, notice: {
            type: "#{status ? 'success' : 'warning'}",
            message: "#{ @destinatario.to_s + (status ? ' ativado' : ' desativado') } com sucesso."
        }
      end
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_destinatario
    @destinatario = Destinatario.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def destinatario_params
    params.require(:destinatario).permit(:nome, :email, :status, :sexo)
  end
end
