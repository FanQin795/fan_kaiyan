import { TabItem } from "../model/TabItem";
import { BaseViewModel } from "./BaseViewModel";

export class FindViewModel extends BaseViewModel{

  tabTitle:Array<TabItem>=
  [
    {
      index:0,
      title:"推荐",
    },
    {
      index:1,
      title:"关注",
    },
    {
      index:2,
      title:"热门",
    }
  ]
}

let findViewModel =new FindViewModel()

export default findViewModel as FindViewModel

