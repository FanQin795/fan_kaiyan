import { getFocusData } from "../http/ApiService";
import { FocusModelItemList } from "../model/FocusModel";
import { BaseViewModel, ResultCallback } from "./BaseViewModel";

export class FocusViewModel extends BaseViewModel{

  async getFocusData(resultCallback:ResultCallback<FocusModelItemList[]>){
   await this.httpRequest(getFocusData()).then((result)=>{
     resultCallback(result.itemList)
   })
  }
}

let focusViewModel=new FocusViewModel()
export default focusViewModel as FocusViewModel
