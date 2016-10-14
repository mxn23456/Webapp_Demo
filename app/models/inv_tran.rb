class InvTran < ActiveRecord::Base
  belongs_to :inv

  def self.getMonthOfYearTrans(user,month,year)
    temp_date = Date.new(year,month,1)
    eom = temp_date.end_of_month
    bom = temp_date.beginning_of_month
    result = []
    x=0
    while (x < user.invs.length)
      y=0
      while (y < user.invs[x].inv_trans.length)
        if(user.invs[x].inv_trans[y].transaction_date >= bom and 
          user.invs[x].inv_trans[y].transaction_date <= eom)
          result.append(user.invs[x].inv_trans[y])
        end
        y = y + 1
      end
      x = x + 1
    end
    return result
  end

  #Get all of the InvTrans belonged to this user
  def self.getUserInvTrans(user)
    userInvTrans = []
    x=0
    while(x < user.invs.length)
      z=0
      while (z < user.invs[x].inv_trans.length)
        userInvTrans.append user.invs[x].inv_trans[z]
        z = z + 1
      end
      x = x + 1
    end
    return userInvTrans
  end

  def self.getRecentDisctinctInvId(user,numOfLastInvs)
    lastAskedAmountFromEndOfList = numOfLastInvs * 2
    orderedList = []
    lastList = InvTran.last(lastAskedAmountFromEndOfList)
    y = lastList.size - 1

    userInvTrans = getUserInvTrans(user)
    while orderedList.size < numOfLastInvs
      if y < 0 
        newAmount = lastAskedAmountFromEndOfList + numOfLastInvs 
        lastList = InvTran.last(newAmount) - InvTran.last(lastAskedAmountFromEndOfList)
        if lastList.size == 0
          break
        end
        lastAskedAmountFromEndOfList = newAmount
        y = lastList.size - 1
      end
      tran = lastList[y]
      if(userInvTrans.any? {|t| t == tran} and !orderedList.any? {|t| t == tran.inv_id})
        orderedList.append tran.inv_id
      end
      y = y - 1
    end
    return orderedList
  end
end
