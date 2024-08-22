import { hiAppEvent } from '@kit.PerformanceAnalysisKit'
import { common } from '@kit.AbilityKit'
import { router } from '@kit.ArkUI'
import { Const } from './Const'

export class SpiderMan {
  //
  static init<T extends common.UIAbilityContext>(context: T) {
    hiAppEvent.addWatcher({
      name: 'SpiderMan',
      appEventFilters: [{
        domain: hiAppEvent.domain.OS,
        names: [hiAppEvent.event.APP_CRASH]
      }],
      onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
        console.error('onReceive')

        if (appEventGroups.length < 1) {
          console.error('appEventGroups.length < 1')
          return
        }

        if (appEventGroups.length > 1) {
          return
        }

        //单个crash跳转
        const appEventGroup = appEventGroups[0]
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

      },
    })
  }
}