import axios, { AxiosInstance,
  AxiosRequestConfig,
  AxiosRequestHeaders,
  AxiosResponse } from "@ohos/axios";
import { CommonType } from "../model/typeAlias/TypeAlias";
import { commonType } from "@kit.ArkData";

/**
 * 封装网络请求的类
 * url
 * 请求方法
 * AxiosHttpRequest 相当于axios.create
 */

// 定义一个名为 AxiosHttpRequest 的可导出类。

export class AxiosHttpRequest{
  // 定义一个名为 config 的属性，类型为 HttpRequestConfig。
  config:HttpRequestConfig
  // 定义一个可选的属性 interceptorHooks，类型为 InterceptorHooks。
  interceptorHooks?: InterceptorHooks;
  // 定义一个名为 instance 的属性，类型为 AxiosInstance。
  instance: AxiosInstance;
  // 定义类的构造函数，接收一个 HttpRequestConfig 类型的参数 options。
  constructor(options: HttpRequestConfig) {
    // 将传入的参数 options 赋值给当前实例的 config 属性。
    this.config = options;
    // 将 options 中的 interceptorHooks 赋值给当前实例的 interceptorHooks 属性。
    this.interceptorHooks = options.interceptorHooks;
    // 使用 axios.create 创建一个 Axios 实例，并将其赋值给当前实例的 instance 属性。
    this.instance = axios.create(options)
    // 调用当前实例的 setupInterceptor 方法。
    this.setupInterceptor()
  }
  // 定义一个名为 setupInterceptor 的方法，没有返回值。
  setupInterceptor(): void {
    // 设置 Axios 实例的请求拦截器。
    this.instance.interceptors.request.use(//这里主要是高版本的axios中设置拦截器的时候里面的Config属性必须是InternalAxiosRequestConfig，但是InternalAxiosRequestConfig里面的headers是必传，所以在实现的子类我设置成非必传会报错，加了个忽略注解
      // 如果 interceptorHooks 存在 requestInterceptor 方法，则作为成功的回调函数。
      this.interceptorHooks?.requestInterceptor,
      // 如果 interceptorHooks 存在 requestInterceptorCatch 方法，则作为错误的回调函数。
      this.interceptorHooks?.requestInterceptorCatch,
    );
    // 设置 Axios 实例的响应拦截器。
    this.instance.interceptors.response.use(
      // 如果 interceptorHooks 存在 responseInterceptor 方法，则作为成功的回调函数。
      this.interceptorHooks?.responseInterceptor,
      // 如果 interceptorHooks 存在 responseInterceptorCatch 方法，则作为错误的回调函数。
      this.interceptorHooks?.responseInterceptorCatch,
    );
  }

  // 类型参数的作用，T决定AxiosResponse实例中data的类型
  // 定义一个名为 request 的泛型方法，接收一个 HttpRequestConfig 类型的参数 config，返回一个 Promise<T>，T 默认是 CommonType。
  request<T = CommonType>(config: HttpRequestConfig): Promise<T> {
    // 返回一个新的 Promise 对象。
    return new Promise<T>((resolve, reject) => {
      // 使用当前实例的 instance 属性发送请求，成功时调用 resolve 函数，失败时调用 reject 函数。
      this.instance
        .request<CommonType, T>(config)
        .then(res => {
          resolve(res);
        }).catch((err:CommonType)=>{
          reject(err)
      })
    });
  }
  // 定义一个名为 get 的泛型方法，接收一个 HttpRequestConfig 类型的参数 config，返回一个 Promise<T>，T 默认是 CommonType。
  get<T = CommonType>(config: HttpRequestConfig): Promise<T> {
    // 将传入的 config 的 method 属性设置为 'GET'。
    config.method = 'GET'
    // 调用当前实例的 request 方法并返回结果。
    return this.request(config);
  }
  // 定义一个名为 post 的泛型方法，接收一个 HttpRequestConfig 类型的参数 config，返回一个 Promise<T>，T 默认是 CommonType。

  post<T = CommonType>(config: HttpRequestConfig): Promise<T> {
    // 将传入的 config 的 method 属性设置为 'POST'。
    config.method = 'POST'
    // 调用当前实例的 request 方法并返回结果。
    return this.request(config);
  }

}
// 定义一个名为 InterceptorHooks 的接口。
interface InterceptorHooks {

  requestInterceptor?: (config: HttpRequestConfig) => Promise<HttpRequestConfig>;
  requestInterceptorCatch?: (error: CommonType) => CommonType;
  responseInterceptor?: (response: AxiosResponse) => AxiosResponse | Promise<AxiosResponse>;
  responseInterceptorCatch?: (error: CommonType) => CommonType;
}


//这里主要是高版本的axios中设置拦截器的时候里面的Config属性必须是InternalAxiosRequestConfig，但是InternalAxiosRequestConfig里面的headers是必传，所以在实现的子类我设置成非必传会报错，加了个忽略注解
export interface  HttpRequestConfig extends  InternalAxiosRequestConfig {
  showLoading?: boolean; //是否展示请求loading
  checkResultCode?: boolean; //是否检验响应结果码
  checkLoginState?: boolean //校验用户登陆状态
  needJumpToLogin?: boolean //是否需要跳转到登陆页面
  // 定义一个可选的属性 interceptorHooks，类型为 InterceptorHooks。
  interceptorHooks?: InterceptorHooks
}
// 定义一个名为 InternalAxiosRequestConfig 的接口，继承自 AxiosRequestConfig<D>，其中 D 默认是 object。

export interface InternalAxiosRequestConfig<D =object> extends AxiosRequestConfig<D>{
  // 定义一个必选的属性 headers，类型为 AxiosRequestHeaders。
  headers:AxiosRequestHeaders
}
// 导出 AxiosHttpRequest 类作为默认导出。
export default AxiosHttpRequest