Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[decimal]$Script:ShutdownTimer = '0'
$Script:OutputEncoding = [System.Text.Encoding]::UTF8

function TimerText {
	$ShutdownTimerHours = "$([math]::Floor($ShutdownTimer/60))"
	$ShutdownTimerMinutes = $($ShutdownTimer%60)
	if ("$ShutdownTimerMinutes" -eq '0' -and "$ShutdownTimerHours" -eq '1'){
		$Script:ShutdownTimerTextPrecise = "$ShutdownTimerHours hour"
	}
	elseif ("$ShutdownTimerMinutes" -eq '0'){
		$Script:ShutdownTimerTextPrecise = "$ShutdownTimerHours hours"
	}
	elseif ("$ShutdownTimerMinutes" -eq '1' -and "$ShutdownTimerHours" -eq '1'){
		$Script:ShutdownTimerTextPrecise = "$ShutdownTimerHours hour and $ShutdownTimerMinutes minute"
	}
	elseif ("$ShutdownTimerMinutes" -eq '1'){
		$Script:ShutdownTimerTextPrecise = "$ShutdownTimerHours hours and $ShutdownTimerMinutes minute"
	}
	elseif ("$ShutdownTimerHours" -eq '1'){
		$Script:ShutdownTimerTextPrecise = "$ShutdownTimerHours hour and $ShutdownTimerMinutes minutes"
	}
	else{
		$Script:ShutdownTimerTextPrecise = "$ShutdownTimerHours hours and $ShutdownTimerMinutes minutes"
	}
}

function DoneMenu {
	$DoneMenuForm = New-Object System.Windows.Forms.Form
	$DoneMenuForm.ClientSize = New-Object System.Drawing.Size(211, 168)
	$DoneMenuForm.Text = "Powershell Shutdown Timer"
	$DoneMenuForm.BackColor = 'Black'
	$DoneMenuForm.ForeColor = 'White'
	$DoneMenuForm.Font = New-Object System.Drawing.Font("Times New Roman",22,[System.Drawing.FontStyle]::Bold)
	$DoneMenuForm.StartPosition = 'CenterScreen'
	#######################################################################################################
	$DoneMenuOKButton = New-Object System.Windows.Forms.Button
	$DoneMenuOKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
	$DoneMenuOKButton.Location = New-Object System.Drawing.Point(12, 110)
	$DoneMenuOKButton.Size = New-Object System.Drawing.Size(191, 47)
	$DoneMenuOKButton.TabIndex = 1
	$DoneMenuOKButton.Text = "OK"
	$DoneMenuOKButton.Add_Click({
		TimerText
		$LabelCurrentTimerSet.Text = "Precise Timer Value is:`n$ShutdownTimer min`n`#`#`#`n $ShutdownTimerTextPrecise"
	})
	$DoneMenuOKButton.UseVisualStyleBackColor = $true
	#######################################################################################################
	$DoneMenulabel = New-Object System.Windows.Forms.Label
	$DoneMenulabel.Font = New-Object System.Drawing.Font("Times New Roman", 21.75,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point, 204)
	$DoneMenulabel.Location = New-Object System.Drawing.Point(12, 9)
	$DoneMenulabel.Size = New-Object System.Drawing.Size(191, 98)
	$DoneMenulabel.TabIndex = 0
	$DoneMenulabel.Text = "$DoneMenuText"
	$DoneMenulabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
	#######################################################################################################
	$DoneMenuForm.AcceptButton = $DoneMenuOKButton
	$DoneMenuForm.Controls.Add($DoneMenuOKButton)
	$DoneMenuForm.Controls.Add($DoneMenulabel)
	$DoneMenuForm.Topmost = $true
	#######################################################################################################
	$Script:DoneMenuResult = $DoneMenuForm.ShowDialog()
}

function yesnomenu {
	$form1 = New-Object System.Windows.Forms.Form
	$form1.Text = 'Powershell Shutdown Timer'
	$form1.Size = New-Object System.Drawing.Size(400,210)
	$Form1.Font = New-Object System.Drawing.Font("Times New Roman",22,[System.Drawing.FontStyle]::Bold)
	$form1.BackColor = 'Black'
	$form1.ForeColor = 'White'
	$form1.StartPosition = 'CenterScreen'
	#######################################################################################################
	$okButton1 = New-Object System.Windows.Forms.Button
	$okButton1.Location = New-Object System.Drawing.Point(15,110)
	$okButton1.Size = New-Object System.Drawing.Size(100,46)
	$okButton1.Text = 'Yes'
	$okButton1.DialogResult = [System.Windows.Forms.DialogResult]::OK
	$okButton1.Add_Click({
		shutdown.exe -s -t 0
		$form1.Close()
	})
	#######################################################################################################
	$cancelButton1 = New-Object System.Windows.Forms.Button
	$cancelButton1.Location = New-Object System.Drawing.Point(262,110)
	$cancelButton1.Size = New-Object System.Drawing.Size(100,46)
	$cancelButton1.Text = 'No'
	$cancelButton1.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
	$okButton1.Add_Click({
		$form1.Close()
	})
	#######################################################################################################
	$label01 = New-Object System.Windows.Forms.Label
	$label01.Location = New-Object System.Drawing.Point(10,15)
	$label01.Size = New-Object System.Drawing.Size(350,90)
	$label01.Font = New-Object System.Drawing.Font("Cascadia Mono",18,[System.Drawing.FontStyle]::Regular)
	$label01.TextAlign = 'TopCenter'
	$label01.Text = "Are you sure you want to turn off your computer?"
	#######################################################################################################
	$form1.AcceptButton = $okButton1
	$form1.Controls.Add($okButton1)
	$form1.CancelButton = $cancelButton1
	$form1.Controls.Add($cancelButton1)
	$form1.Controls.Add($label01)
	$form1.Topmost = $true
	#######################################################################################################
	$Script:result1 = $form1.ShowDialog()
}

function PowerShellTimerMenu {
	$form = New-Object System.Windows.Forms.Form
	$form.Text = 'Powershell Shutdown Timer'
	$form.Size = New-Object System.Drawing.Size(695,600)
	$Form.Font = New-Object System.Drawing.Font("Times New Roman",22,[System.Drawing.FontStyle]::Bold)
	$form.BackColor = 'Black'
	$form.ForeColor = 'White'
	$form.StartPosition = 'CenterScreen'
	#######################################################################################################
	$okButton = New-Object System.Windows.Forms.Button
	$okButton.Location = New-Object System.Drawing.Point(15,500)
	$okButton.Size = New-Object System.Drawing.Size(150,46)
	$okButton.Text = 'OK'
	$okButton.Add_Click({
		if ($ShutdownTimer -eq '0'){
			shutdown /a
			yesnomenu
		}
		else{
			shutdown /a
			shutdown.exe -s -t $($ShutdownTimer*60)
			$Script:DoneMenuText = "Done!`nTimer set for $([math]::round($ShutdownTimer/60,2)) hours!"
			DoneMenu
		}
	})
	#######################################################################################################
	$cancelButton = New-Object System.Windows.Forms.Button
	$cancelButton.Location = New-Object System.Drawing.Point(510,500)
	$cancelButton.Size = New-Object System.Drawing.Size(150,46)
	$cancelButton.Text = 'Exit'
	$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
	#######################################################################################################
	$30minButton = New-Object System.Windows.Forms.Button
	$30minButton.Location = New-Object System.Drawing.Point(15,85)
	$30minButton.Size = New-Object System.Drawing.Size(150,46)
	$30minButton.Text = '30 Min'
	$30minButton.Add_Click({
		shutdown /a
		shutdown.exe -s -t 1800
		$Script:ShutdownTimer = '0'
		$Script:ShutdownTimer += '30'
		$Script:DoneMenuText = "Done!`nTimer set for $([math]::round($ShutdownTimer/60,2)) hour!"
		DoneMenu
	})
	#######################################################################################################
	$60minButton = New-Object System.Windows.Forms.Button
	$60minButton.Location = New-Object System.Drawing.Point(180,85)
	$60minButton.Size = New-Object System.Drawing.Size(150,46)
	$60minButton.Text = '60 min'
	$60minButton.Add_Click({
		shutdown /a
		shutdown.exe -s -t 3600
		$Script:ShutdownTimer = '0'
		$Script:ShutdownTimer += '60'
		$Script:DoneMenuText = "Done!`nTimer set for $([math]::round($ShutdownTimer/60,2)) hour!"
		DoneMenu
	})
	#######################################################################################################
	$90minButton = New-Object System.Windows.Forms.Button
	$90minButton.Location = New-Object System.Drawing.Point(345,85)
	$90minButton.Size = New-Object System.Drawing.Size(150,46)
	$90minButton.Text = '90 min'
	$90minButton.Add_Click({
		shutdown /a
		shutdown.exe -s -t 5400
		$Script:ShutdownTimer = '0'
		$Script:ShutdownTimer += '90'
		$Script:DoneMenuText = "Done!`nTimer set for $([math]::round($ShutdownTimer/60,2)) hours!"
		DoneMenu
	})
	#######################################################################################################
	$120minButton = New-Object System.Windows.Forms.Button
	$120minButton.Location = New-Object System.Drawing.Point(510,85)
	$120minButton.Size = New-Object System.Drawing.Size(150,46)
	$120minButton.Text = '120 min'
	$120minButton.Add_Click({
		shutdown /a
		shutdown.exe -s -t 7200
		$Script:ShutdownTimer = '0'
		$Script:ShutdownTimer += '120'
		$Script:DoneMenuText = "Done!`nTimer set for $([math]::round($ShutdownTimer/60,2)) hours!"
		DoneMenu
	})
	#######################################################################################################
	$CancelTimerButton = New-Object System.Windows.Forms.Button
	$CancelTimerButton.Location = New-Object System.Drawing.Point(239,500)
	$CancelTimerButton.Size = New-Object System.Drawing.Size(197,46)
	$CancelTimerButton.Text = 'Cancel Timer'
	$CancelTimerButton.Add_Click({
		shutdown /a
		$Script:DoneMenuText = 'Timer Canceled and set to 0!'
		$Script:ShutdownTimer = '0'
		DoneMenu
	})
	#######################################################################################################
	$ResetTimerButton = New-Object System.Windows.Forms.Button
	$ResetTimerButton.Location = New-Object System.Drawing.Point(239,500)
	$ResetTimerButton.Size = New-Object System.Drawing.Size(197,46)
	$ResetTimerButton.Text = 'Cancel Timer'
	$ResetTimerButton.Add_Click({
		shutdown /a
	})
	#######################################################################################################
	$Plus1minButton = New-Object System.Windows.Forms.Button
	$Plus1minButton.Location = New-Object System.Drawing.Point(40,202)
	$Plus1minButton.Size = New-Object System.Drawing.Size(120,46)
	$Plus1minButton.Text = '+1Min'
	$Plus1minButton.Add_Click({
		$Script:ShutdownTimer += '1'
		TimerText
		$LabelCurrentTimerSet.Text = "Precise Timer Value is:`n$ShutdownTimer min`n`#`#`#`n $ShutdownTimerTextPrecise"
	})
	#######################################################################################################
	$Plus5minButton = New-Object System.Windows.Forms.Button
	$Plus5minButton.Location = New-Object System.Drawing.Point(160,202)
	$Plus5minButton.Size = New-Object System.Drawing.Size(120,46)
	$Plus5minButton.Text = '+5Min'
	$Plus5minButton.Add_Click({
		$Script:ShutdownTimer += '5'
		TimerText
		$LabelCurrentTimerSet.Text = "Precise Timer Value is:`n$ShutdownTimer min`n`#`#`#`n $ShutdownTimerTextPrecise"
	})
	#######################################################################################################
	$Plus10minButton = New-Object System.Windows.Forms.Button
	$Plus10minButton.Location = New-Object System.Drawing.Point(280,202)
	$Plus10minButton.Size = New-Object System.Drawing.Size(120,46)
	$Plus10minButton.Text = '+10Min'
	$Plus10minButton.Add_Click({
		$Script:ShutdownTimer += '10'
		TimerText
		$LabelCurrentTimerSet.Text = "Precise Timer Value is:`n$ShutdownTimer min`n`#`#`#`n $ShutdownTimerTextPrecise"
	})
	#######################################################################################################
	$Plus30minButton = New-Object System.Windows.Forms.Button
	$Plus30minButton.Location = New-Object System.Drawing.Point(400,202)
	$Plus30minButton.Size = New-Object System.Drawing.Size(120,46)
	$Plus30minButton.Text = '+30Min'
	$Plus30minButton.Add_Click({
		$Script:ShutdownTimer += '30'
		TimerText
		$LabelCurrentTimerSet.Text = "Precise Timer Value is:`n$ShutdownTimer min`n`#`#`#`n $ShutdownTimerTextPrecise"
	})
	#######################################################################################################
	$Plus60minButton = New-Object System.Windows.Forms.Button
	$Plus60minButton.Location = New-Object System.Drawing.Point(520,202)
	$Plus60minButton.Size = New-Object System.Drawing.Size(120,46)
	$Plus60minButton.Text = '+60Min'
	$Plus60minButton.Add_Click({
		$Script:ShutdownTimer += '60'
		TimerText
		$LabelCurrentTimerSet.Text = "Precise Timer Value is:`n$ShutdownTimer min`n`#`#`#`n $ShutdownTimerTextPrecise"
	})
	#######################################################################################################
	$AbortTimerButton = New-Object System.Windows.Forms.Button
	$AbortTimerButton.Location = New-Object System.Drawing.Point(255,252)
	$AbortTimerButton.Size = New-Object System.Drawing.Size(170,46)
	$AbortTimerButton.Text = 'ResetTimer'
	$AbortTimerButton.Add_Click({
		$Script:ShutdownTimer = '0'
		TimerText
		$LabelCurrentTimerSet.Text = "Precise Timer Value is:`n$ShutdownTimer min`n`#`#`#`n $ShutdownTimerTextPrecise"
	})
	#######################################################################################################
	$label1 = New-Object System.Windows.Forms.Label
	$label1.Location = New-Object System.Drawing.Point(10,15)
	$label1.Size = New-Object System.Drawing.Size(675,60)
	$label1.Font = New-Object System.Drawing.Font("Cascadia Mono",12,[System.Drawing.FontStyle]::Regular)
	$label1.TextAlign = 'TopCenter'
	$label1.Text = "Welcome to the Powershell Shutdown Timer.`nThis timer will shut down your PC after a selected period of time.`nPlease select one of the options below."
	#######################################################################################################
	$label2 = New-Object System.Windows.Forms.Label
	$label2.Location = New-Object System.Drawing.Point(10,146)
	$label2.Size = New-Object System.Drawing.Size(675,60)
	$label2.Font = New-Object System.Drawing.Font("Cascadia Mono",12,[System.Drawing.FontStyle]::Regular)
	$label2.TextAlign = 'TopCenter'
	$label2.Text = "Do you need to shut down your computer with a more precise timer?`nEnter the desired time right below."
	#######################################################################################################
	$LabelCurrentTimerSet = New-Object System.Windows.Forms.Label
	$LabelCurrentTimerSet.Location = New-Object System.Drawing.Point(10,320)
	$LabelCurrentTimerSet.Size = New-Object System.Drawing.Size(675,145)
	$LabelCurrentTimerSet.Font = New-Object System.Drawing.Font("Cascadia Mono",24,[System.Drawing.FontStyle]::Regular)
	$LabelCurrentTimerSet.TextAlign = 'TopCenter'
	$LabelCurrentTimerSet.Text = "Precise Timer Value is:`n$ShutdownTimer min`n`#`#`#`n $([math]::round($ShutdownTimer/60,2)) hours"
	#######################################################################################################
	$form.AcceptButton = $okButton
	$form.Controls.Add($okButton)
	$form.CancelButton = $cancelButton
	$form.Controls.Add($cancelButton)
	$form.AcceptButton = $CancelTimerButton
	$form.Controls.Add($CancelTimerButton)
	$form.AcceptButton = $30minButton
	$form.Controls.Add($30minButton)
	$form.AcceptButton = $60minButton
	$form.Controls.Add($60minButton)
	$form.AcceptButton = $90minButton
	$form.Controls.Add($90minButton)
	$form.AcceptButton = $120minButton
	$form.Controls.Add($120minButton)
	$form.AcceptButton = $Plus1minButton
	$form.Controls.Add($Plus1minButton)
	$form.AcceptButton = $Plus5minButton
	$form.Controls.Add($Plus5minButton)
	$form.AcceptButton = $Plus10minButton
	$form.Controls.Add($Plus10minButton)
	$form.AcceptButton = $Plus30minButton
	$form.Controls.Add($Plus30minButton)
	$form.AcceptButton = $Plus60minButton
	$form.Controls.Add($Plus60minButton)
	$form.AcceptButton = $AbortTimerButton
	$form.Controls.Add($AbortTimerButton)
	$form.Controls.Add($label1)
	$form.Controls.Add($label2)
	$form.Controls.Add($LabelCurrentTimerSet)
	$form.Topmost = $true
	#######################################################################################################
	$Script:result = $form.ShowDialog()
}

PowerShellTimerMenu
