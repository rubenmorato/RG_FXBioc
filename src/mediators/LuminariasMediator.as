/**
 * Created with IntelliJ IDEA.
 * User: barbaradominguez
 * Date: 22/04/12
 * Time: 22:17
 * To change this template use File | Settings | File Templates.
 */
package mediators {
import com.hexagonstar.util.debug.Debug;

import events.PreguntasEvent;

import flash.events.Event;

import org.robotlegs.mvcs.Mediator;

import views.LuminariasView;

public class LuminariasMediator extends Mediator {

    [Inject]
    public var vista:LuminariasView;

    public function LuminariasMediator() {
        super();
    }


    override public function onRegister():void
    {
        eventMap.mapListener(eventDispatcher, PreguntasEvent.LUMINARIAS_RECIBIDAS, lumis);
        eventMap.mapListener(vista, PreguntasEvent.TIRADOR_OCULTO, proporcion);
        eventMap.mapListener(vista, PreguntasEvent.TIRADOR_VISIBLE, proporcion);
        eventMap.mapListener(eventDispatcher, PreguntasEvent.TIRADOR_MOV, movimiento);
        eventMap.mapListener(vista, PreguntasEvent.TIRADOR_INVERSO, movimientoInverso);
        eventMap.mapListener(vista, Event.ADDED_TO_STAGE, init);
    }


    private function init(e:Event):void
    {
        eventMap.unmapListener(vista, Event.ADDED_TO_STAGE, init);

        eventDispatcher.dispatchEvent(new PreguntasEvent(PreguntasEvent.PIDE_LUMINARIAS));
    }


    private function lumis(e:PreguntasEvent):void
    {
        vista.pintaLuminarias(e.datos);
    }


    private function proporcion(e:PreguntasEvent):void
    {
        if(e.type == PreguntasEvent.TIRADOR_OCULTO){
            eventDispatcher.dispatchEvent(new PreguntasEvent(PreguntasEvent.TIRADOR_OCULTO));
        } else {
            eventDispatcher.dispatchEvent(new PreguntasEvent(PreguntasEvent.TIRADOR_VISIBLE));
        }
    }


    private function movimiento(e:PreguntasEvent):void
    {
        vista.mueveLuminarias(e.datos.movimiento);
    }
    
    private function movimientoInverso(e:PreguntasEvent):void
    {
        var evento:PreguntasEvent = new PreguntasEvent(PreguntasEvent.TIRADOR_INVERSO);
        evento.datos.movimiento = e.datos.movimiento;
        eventDispatcher.dispatchEvent(evento);
    }

}
}
