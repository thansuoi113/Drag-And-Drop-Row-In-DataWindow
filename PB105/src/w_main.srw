$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type dw_data from datawindow within w_main
end type
end forward

global type w_main from window
integer width = 2926
integer height = 1580
boolean titlebar = true
string title = "Drag And Drop Row In DataWindow"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_data dw_data
end type
global w_main w_main

type variables
Boolean  ib_down


end variables
on w_main.create
this.dw_data=create dw_data
this.Control[]={this.dw_data}
end on

on w_main.destroy
destroy(this.dw_data)
end on

event resize;dw_data.Move(4,4)
dw_data.Resize(newwidth - 15 , newheight - 15)

end event

type dw_data from datawindow within w_main
event ue_lbuttonup pbm_lbuttonup
event ue_lbuttondown pbm_lbuttondown
event ue_mousemove pbm_dwnmousemove
integer width = 2889
integer height = 1472
integer taborder = 10
string title = "none"
string dataobject = "d_examples"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_lbuttonup;ib_down = False
end event

event ue_lbuttondown;ib_down = True
end event

event ue_mousemove;If ib_down Then
	If row > 0 Then
		This.Drag (Begin!)
		This.DragIcon = "DataPipeline!"
		If row > 0 Then
			//Messagebox("Warning", "You Choose Row " + string (row))
		End If
	Else
		This.Drag (End!)
	End If
End If

end event

event dragdrop;Long li_oldr
DragObject	ldo_control
ldo_control = DraggedObject()
If Not IsValid(ldo_control) Then Return

If row <= 0 Then Return

li_oldr = This.GetRow()
If Source = This Then
	If row = li_oldr Then Return
	If row > li_oldr Then row ++
	This.RowsMove(li_oldr,li_oldr,Primary!,This, row ,Primary!)
	If row > li_oldr Then row --
	This.ScrollToRow(row)
	This.SelectRow( row,True)
	If li_oldr > row Then
		This.SelectRow( row + 1,False)
	Else
		This.SelectRow( row - 1,False)
	End If
End If
This.SetRedraw(True)



end event

event dragwithin;If ib_down Then
	This.SelectRow(0,False)
	This.SelectRow(row,True)
End If


end event

event constructor;string ls_modify
ls_modify ="DataWindow.detail.Color ='255~t if(Getrow() = currentRow(),134217752,if(mod(getrow(),2 ) =0,rgb(231, 255, 231),rgb(255,255,255)))'"
dw_data.modify(ls_modify)
end event

