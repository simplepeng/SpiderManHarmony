import { hiAppEvent } from '@kit.PerformanceAnalysisKit'
import { router } from '@kit.ArkUI'
import { Const } from './Const'

export class SpiderMan {
  //
  static init() {
    hiAppEvent.addWatcher({
      name: 'SpiderMan',
      appEventFilters: [{
        domain: hiAppEvent.domain.OS,
        names: [hiAppEvent.event.APP_CRASH]
      }],
      onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
        console.error('onReceive -- ' + domain)

        if (appEventGroups.length < 1) {
          console.error('appEventGroups.length < 1')
          return
        }

        if (appEventGroups.length > 1) {
          //会有多个吗？先取第一个试试
          const appEventGroup = appEventGroups[0]
          SpiderMan.openCrashPage(appEventGroup)
          return
        }

        //单个crash跳转
        const appEventGroup = appEventGroups[0]
        SpiderMan.openCrashPage(appEventGroup)
      },
    })
  }

  static openCrashPage(appEventGroup: hiAppEvent.AppEventGroup) {
    setTimeout(() => {
      router.pushNamedRoute({
        name: Const.CRASH_PAGE,
        params: appEventGroup
      }).then(() => {
        console.error('pushNamedRoute then')
      }).catch(() => {
        console.error('pushNamedRoute catch')
      })
    }, 1000)
  }
}