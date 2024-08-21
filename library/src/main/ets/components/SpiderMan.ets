import { hiAppEvent } from '@kit.PerformanceAnalysisKit'
import { common } from '@kit.AbilityKit'
import { router } from '@kit.ArkUI'

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


        router.pushNamedRoute({
          name: 'MainPage'
        }).then(() => {
          console.error('pushNamedRoute then')
        }).catch(() => {
          console.error('pushNamedRoute catch')
        })
      },
    })
  }
}