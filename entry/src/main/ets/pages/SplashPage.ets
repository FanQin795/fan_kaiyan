import router from '@ohos.router';
import { RouterPath } from '../router/RouterPath';
/**
 * 欢迎页
 */

@Entry
@Component
struct SplashPage {

  aboutToAppear(): void {
    setTimeout(()=>{
      //业务跳转
      router.replaceUrl({
        url:RouterPath.MainPage
      })
    },2000)
  }
  build() {
    Stack(){
      Image($r('app.media.landing_image'))
        //填充模式
        . objectFit(ImageFit.ScaleDown)
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.color_white')).alignContent(Alignment.Center)
  }
}