class FahrtsController < ApplicationController
  before_action :set_fahrt, only: [:show, :edit, :update, :destroy]

  # GET /fahrts
  # GET /fahrts.json
  def index
    @fahrts = Fahrt.all
  end

  # GET /fahrts/1
  # GET /fahrts/1.json
  def show
    @total = Mitfahrer.where(:fahrt_id => @fahrt.id, :istBestatigt => true).select("COUNT(*) AS total").first.total
    # @anfragen = Mitfahrer.where(:fahrt_id => @fahrt.id, :istBestatigt => false)
    @anfragen = Mitfahrer.where("fahrt_id = #{@fahrt.id}")
  end

  # GET /fahrts/new
  def new
    @fahrt = Fahrt.new(account: current_account)
  end

  # GET /fahrts/1/edit
  def edit
  end

  # POST /fahrts
  # POST /fahrts.json
  def create
    @fahrt = Fahrt.new(fahrt_params)

    respond_to do |format|
      if @fahrt.save
        format.html { redirect_to @fahrt, notice: 'Fahrt was successfully created.' }
        format.json { render :show, status: :created, location: @fahrt }
      else
        format.html { render :new }
        format.json { render json: @fahrt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fahrts/1
  # PATCH/PUT /fahrts/1.json
  def update
    respond_to do |format|
      if @fahrt.update(fahrt_params)
        format.html { redirect_to @fahrt, notice: 'Fahrt was successfully updated.' }
        format.json { render :show, status: :ok, location: @fahrt }
      else
        format.html { render :edit }
        format.json { render json: @fahrt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fahrts/1
  # DELETE /fahrts/1.json
  def destroy
    @fahrt.destroy
    respond_to do |format|
      format.html { redirect_to fahrts_url, notice: 'Fahrt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fahrt
      @fahrt = Fahrt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fahrt_params
      params.require(:fahrt).permit(:von, :nach, :dauer, :preisProMitfahrer, :maxMitfahrer, :account_id)
    end
end
