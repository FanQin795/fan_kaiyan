import { getRelationList } from "../http/ApiService";
import { HomeModelIssueListItemList } from "../model/HomeModel";
import { BaseViewModel, ResultCallback } from "./BaseViewModel";


export class VideoDetailViewModel extends BaseViewModel{
  relationId:number=-1

  async getRelationList(resultCallback?:ResultCallback<HomeModelIssueListItemList[]>){
    await this.httpRequest(getRelationList(this.relationId))
      .then((result)=>{
        let filterList=result.itemList.filter((item)=>item.type==='videoSmallCard')
        resultCallback?.(filterList)
      })
  }
}

let videoDetailVideoViewModel =new VideoDetailViewModel()

export default videoDetailVideoViewModel as VideoDetailViewModel