
import { ViewStateConstant } from "../../cons/ViewStateConstant";
import { HomeModel, HomeModelIssueListItemList } from "../../model/HomeModel";

import { CommonTopBar } from "../../views/CommonTopBar";
import { StateComponent } from "../../views/StateComponent";
import { HomeListItemComponent } from "./component/HomeListItemComponent";
import http from "@ohos.net.http";
import { BusinessError } from "@kit.BasicServicesKit";
import axios, { AxiosHeaders, AxiosResponse } from "@ohos/axios";
import axiosClient from "../../http/AxiosRequest";
import HomeViewModel from '../../viewmodel/HomeViewModel';

import { CategoryRouteParams } from "../../router/RouteParams";
import { RouterPath } from "../../router/RouterPath";
import { Router } from "../../router/Router";

let baseUrl = "https://baobab.kaiyanapp.com/"
const commonHeader: AxiosHeaders = new AxiosHeaders()


@Entry
@Component
export  default  struct HomePage {
  @State viewState: string = ViewStateConstant.VIEW_STATE_LOADING
  @State isRefreshing: boolean = false
  @State dataList: HomeModelIssueListItemList[] = []
  @State showLoading: boolean = false

  isSUbscribe:boolean=true
  aboutToAppear(): void {
    HomeViewModel.getHomeList((result)=>{
      this.dataList=result
    })

  }
  // text(){
  //   axiosClient.get<HomeModel>({
  //     url: baseUrl + "api/v2/feed",
  //     showLoading: true,
  //     headers: commonHeader
  //   }).then((res=>{
  //     console.info('res'+JSON.stringify(res))
  //     console.info('list'+res.nextPageUrl)
  //   }))
  // }

  // axiosDemo(){
  //   let instance=axios.create({
  //     baseURL:"http://10.161.9.80:7012/",
  //     timeout:5000,
  //     headers:{
  //       "Content-Type":"application/json"
  //     }
  //   })
  //   instance.get("api/v2/feed?page=1").then((res:AxiosResponse)=>{
  //     if (res.status===200) {
  //       res.data
  //       console.info('Result'+JSON.stringify(res.data))
  //     }
  //   }).catch((err:BusinessError)=>{
  //
  //   }).finally(()=>{})
  // }

  // httpDemo(){
  //   let httpRequest=http.createHttp()
  //   httpRequest.request(
  //     "http://10.161.9.80:7012/api/v2/feed?page=1",
  //     {
  //       method:http.RequestMethod.GET,
  //       connectTimeout:6000,
  //       readTimeout:6000
  //     },(err:BusinessError,data:http.HttpResponse)=>{
  //       if (!err) {
  //         console.info('Result:'+JSON.stringify(data.result))
  //         console.info('code:'+JSON.stringify(data.responseCode))
  //         console.info('header:'+JSON.stringify(data.header))
  //         console.info('cookies:'+JSON.stringify(data.cookies))
  //         httpRequest.destroy()
  //       }else {
  //         console.error('error'+JSON.stringify(err))
  //         httpRequest.destroy()
  //       }
  //     })
  //
  // }
  build() {
    Column(){
      CommonTopBar({ title: "首页", backButton: false, alpha: 1 }).align(Alignment.TopStart)
      Stack(){
        Refresh({ refreshing: $$this.isRefreshing, offset: 100, friction: 100 }) {
          List({ space: 10, initialIndex: 0 }) {
            ForEach(this.dataList, (item: HomeModelIssueListItemList, index: number) => {
              ListItem() {
              HomeListItemComponent({ item: item }).onClick(() => {
                Router.push(RouterPath.DetailPage, {
                  "id": item?.data?.id,
                  "playUrl": item?.data?.playUrl
                } as CategoryRouteParams)
                })
              }
            })
          }
        }
      }.layoutWeight(1)
    }
  }
}
function getDemo() {
  return axiosClient.get<HomeModel>({
    url: baseUrl + "api/v2/feed",
    params: { "page": 1 },
    showLoading: true,
    headers: commonHeader
  })
}