import useRequestStatus, { LoadStateResult } from "../http/userRequestStatus"


export type StateCallback = (state: string) => void
/**
 * 定义回调函数类型
 */
export type ResultCallback<T> = (result: T) => void


export class BaseViewModel{
    /**
     * 发送网络请求的功能
     */
  httpRequest():LoadStateResult{
     return useRequestStatus()
  }

}