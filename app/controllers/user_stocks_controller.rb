class UserStocksController < ApplicationController

  # verify if stock is in the DDBB other wise look for it and save it
  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "stock #{stock.name} was successfully added to your portfolio"
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
   current_user.stocks.delete(stock)
    flash[:notice] = "#{stock.ticker} was succesfully removed from portolio"
    redirect_to my_portfolio_path
  end
end
