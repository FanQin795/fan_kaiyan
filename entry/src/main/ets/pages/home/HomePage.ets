import { ViewStateConstant } from "../../cons/ViewStateConstant";
import { HomeModelIssueListItemList } from "../../model/HomeModel";
import { Router } from "../../router/Router";
import { RouterPath } from "../../router/RouterPath";
import { CommonTopBar } from "../../views/CommonTopBar";
import { StateComponent } from "../../views/StateComponent";
import { HomeListItemComponent } from "./component/HomeListItemComponent";

@Entry
@Component
export  default  struct HomePage {

  @State viewState: string = ViewStateConstant.VIEW_STATE_LOADING
  @State isRefreshing: boolean = false
  @State dataList: HomeModelIssueListItemList[] = []
  @State showLoading: boolean = false
  build() {
    Column(){
        CommonTopBar({title:'首页',backButton:false,alpha:1}).align(Alignment.TopStart)
        Stack(){
          StateComponent({
            viewState:this.viewState,
            showSkeleton:true,
            retryCallback:()=>{
              //this.loadNet()
            }
          }){
            Refresh({refreshing: $$this.isRefreshing,offset:100,friction:100}){
              List({space:10,initialIndex:0}){
                ForEach(this.dataList,(item:HomeModelIssueListItemList,index:number)=>{
                  ListItem(){
                    HomeListItemComponent({item:item}).onClick(()=>{

                    })
                  }
                })
              }
            }

          }
        }
    }

  }


}