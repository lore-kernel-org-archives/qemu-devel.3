Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD594C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcocf-0006v6-78; Wed, 21 Feb 2024 10:35:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1rcoaH-0007Ho-Hm
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:32:33 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1rcmdG-0007kj-Be
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 08:27:32 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55f279dca99so818251a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 05:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708522046; x=1709126846; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ebVJB2+qZMfTNDQGp/zGxj1CNya1GgTW1rdNxb8CUPg=;
 b=J3h9AI+Il+tO6H/1YJ997y+H8EvNH/FIDAD7CZEQCI2hXCisvhe6wMiBxUhPXsSDhe
 JrLcM2f0zAmtdvS8kzlr/12u5WZvFEW2ytgtHY/fHEmbNMj7euPDXbHLOBQ9hnwUFXS1
 Ub12bEp6GKrGUjtZEIO2AbRpIe2Goc+uHaUZCNof+P1QU2ZK7CjVMo04Unu/TejiAgvi
 Vm1rZePPhOxe3yyV71VoZSP04ihZhGR3jutys1sqLQmIKNifwxfYBIIGodVMnMoPSthR
 DTPg/Rmllgl7HnEpY2K7BDb9IHBic1C1FasxFsDJ8UkfX+/0Kji7RfyLBIaegmalFgM9
 tW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708522046; x=1709126846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ebVJB2+qZMfTNDQGp/zGxj1CNya1GgTW1rdNxb8CUPg=;
 b=T24n9za2DNv+mOuWo6t6va9i9MUYbuREubKJhqsG/67tRUiQOBGaXdV5tiu7RLncM8
 iiJPhVUfr4b7mxep+bwH0K9XquaJAo6zCK0t9Rpsiooi+ByF9ADaw3BpIzcSHYMDg/IR
 iOY5esb1d1fk2qatYESYap41GyvTKhBTrTYnPQNKgOZE+l/U5jRUbSh8Nt+m7s4OKtmY
 k+e2Ugs56i499kT/TodA+CC5JpiZ852R86TvK9d74PvHBQi4WO0JC3/3kf3NGQGzorOX
 3woKKRrbK+gSZtYb2VvwVu4vQ+ILheOCSsPrKxpfGwvg+SZPrQ+veogOj7XhH1UgBC/W
 k5Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCc4RuMGPk53aK/W6ptecnYJk3DcjOlWIX4ZNHhtpz0+TBqas6umMbyRj+GSoCXeq0zcmp/V1cbEcJrCgg6zG2ZLxmCYU=
X-Gm-Message-State: AOJu0YwRldqxRWFMb/iH7xXoMI4rhbds1EJcO+7Nx96ofSGowfViEUNs
 SOsAx31uC2exjUTU/SKXXcNaQWcdpCAKFM8MRj5WaEIhcfj5Mv9+Ze8d/qRsTUpUx0DTVkJRZzX
 u5lcY5eCoHlN9RKOeRxUpVJJDNow=
X-Google-Smtp-Source: AGHT+IGyNaUXdn8p0ZAHHHY78VVSjFMYzCZ96t3aVY5jPP8Ub8V/bG83G92/CRBXN8cyBHKAteXl82LI08CMpFU9uHw=
X-Received: by 2002:aa7:d613:0:b0:564:957f:a604 with SMTP id
 c19-20020aa7d613000000b00564957fa604mr4884382edr.4.1708522045902; Wed, 21 Feb
 2024 05:27:25 -0800 (PST)
MIME-Version: 1.0
References: <CAOpGCn+KdhjnXRHup6GXVbkoZkUBc7f-2urNzmvLjK1To_pp0A@mail.gmail.com>
 <87a5nvci5n.fsf@draig.linaro.org>
 <CAOpGCnLxVGhbJuAq+K+DNZBESEGGkSr8Sa0_cHsfMR7S-_ahkQ@mail.gmail.com>
 <87y1bfawik.fsf@draig.linaro.org>
 <CAOpGCn+_=5Uxi9mt-C1V3pguNT0OUJura-H3SwBOsJnW5tyJ4g@mail.gmail.com>
 <CAFEAcA-03JYx9szd3FrQ_786gaRLWCJVHeMgjBxxvgH85f-78A@mail.gmail.com>
 <CAOpGCn+vQ7wupMqeH8ZLarT0c4gD85R6cgRqBMhVeAXtZ1F_Mg@mail.gmail.com>
In-Reply-To: <CAOpGCn+vQ7wupMqeH8ZLarT0c4gD85R6cgRqBMhVeAXtZ1F_Mg@mail.gmail.com>
From: Faiq Ali Sayed <faiqueali.109@gmail.com>
Date: Wed, 21 Feb 2024 14:27:14 +0100
Message-ID: <CAOpGCnKap-992-4WOGz7Z40YGwqPBtsk7-qck--qYPd+rSJrhw@mail.gmail.com>
Subject: Re: QNX VM hang on Qemu
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a312d20611e44930"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=faiqueali.109@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000a312d20611e44930
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,
I have created a new QNX image, particularly for Qemu, and still, both the
prompts are hanging without any further details.
Please have a look at the results of both terminals below


qemu-system-aarch64.exe -M xlnx-zcu102 -m 16G -serial mon:stdio -display
none -device loader,file=3D"C:ifs.bin",addr=3D0x00100000,cpu-num=3D0 -drive
file=3Dqemu-raw-img,format=3Draw,index=3D1,if=3Dsd -net nic,model=3Dcadence=
_gem -net
nic,model=3Dcadence_gem -net nic,model=3Dcadence_gem -net
nic,model=3Dcadence_gem,netdev=3Dxzynq0 -netdev user,id=3Dxzynq0,tftp=3D/tf=
tpboot
 -nographic -global xlnx,zynqmp-boot.cpu-num=3D0 -global
'xlnx,zynqmp-boot.use-pmufw=3Dtrue' -s -S
qemu-system-aarch64.exe: warning: hub 0 is not connected to host network
qemu-system-aarch64.exe: warning: global xlnx,zynqmp-boot.cpu-num has
invalid class name
qemu-system-aarch64.exe: warning: global 'xlnx,zynqmp-boot.use-pmufw has
invalid class name
QEMU: Terminated


GDB
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from
C:\Users\sayedf\qnx710\image-with-drivers\output\ifs.bin...(no debugging
symbols found)...done.
(gdb) target remote :1234
Remote debugging using :1234
warning: Can not parse XML target description; XML support was disabled at
compile time
0x0000000080000800 in ?? ()
(gdb) c
Continuing.
[Inferior 1 (process 1) exited normally]

Please have a look :)

On Tue, Feb 20, 2024 at 11:22=E2=80=AFPM Faiq Ali Sayed <faiqueali.109@gmai=
l.com>
wrote:

> The real hardware ( xlnx-zcu102 ) is being used for our software. The
> software is in the development phase, and for that, I need to create a VM
> for simulation purposes.
> Qemu has a machine type (-M xlnx-zcu102) which is supported with the
> board/hardware.
>
> I have two more images for the same hardware and I can create a VM using
> these two images, but in the VM some basic binaries are missing like mkdi=
r
> and virtual disk etc.
>
> Now, the image for which I want to create a VM is currently working on
> board and everything is working fine on real hardware.
> I am not sure whether I can use this image for Qemu because this is
> created particularly for hardware.
> and giving a try to create a VM.
>
> Your valuable suggestions in this regard will be appreciated and mean a
> lot to me :)
>
>
> br!
> Faiq
>
>
>
> On Tue, Feb 20, 2024 at 10:24=E2=80=AFPM Peter Maydell <peter.maydell@lin=
aro.org>
> wrote:
>
>> On Tue, 20 Feb 2024 at 20:56, Faiq Ali Sayed <faiqueali.109@gmail.com>
>> wrote:
>> >
>> > The image I am using is currently in use for real hardware, and
>> > I received it from a third party/vendor.
>>
>> OK, so what exactly is the real hardware it's for?
>>
>> > Could you please suggest to me what I can do now?
>>
>> If QEMU has a model of the hardware the image is for:
>>  - use that QEMU machine type (and issues with getting it running
>>    will be related to making sure you're loading it at the right
>>    address and starting it the way it wants to be started)
>> If QEMU does not have a model of the hardware the image is for:
>>  - ask your vendor for a build that targets some machine QEMU
>>    does have a model of
>>
>> Unfortunately in general in the Arm world guest OSes are
>> not "runs on anything", but only "runs on the hardware
>> they were built to run on". This remains true under emulation.
>>
>> thanks
>> -- PMM
>>
>
>
> --
> Kind Regard-
> Faiq Ali Sayed
>
>
>

--=20
Kind Regard-
Faiq Ali Sayed

--000000000000a312d20611e44930
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alex,<div>I have created a new QNX image, particularly =
for Qemu, and still, both the prompts are hanging without=C2=A0any further =
details.</div><div>Please have a look at the results of both terminals belo=
w</div><div><br></div><div><br></div><div><span style=3D"background-color:r=
gb(238,238,238)">qemu-system-aarch64.exe -M xlnx-zcu102 -m 16G -serial mon:=
stdio -display none -device loader,file=3D&quot;C:ifs.bin&quot;,addr=3D0x00=
100000,cpu-num=3D0 -drive file=3Dqemu-raw-img,format=3Draw,index=3D1,if=3Ds=
d -net nic,model=3Dcadence_gem -net nic,model=3Dcadence_gem -net nic,model=
=3Dcadence_gem -net nic,model=3Dcadence_gem,netdev=3Dxzynq0 -netdev user,id=
=3Dxzynq0,tftp=3D/tftpboot =C2=A0-nographic -global xlnx,zynqmp-boot.cpu-nu=
m=3D0 -global &#39;xlnx,zynqmp-boot.use-pmufw=3Dtrue&#39; -s -S<br>qemu-sys=
tem-aarch64.exe: warning: hub 0 is not connected to host network<br>qemu-sy=
stem-aarch64.exe: warning: global xlnx,zynqmp-boot.cpu-num has invalid clas=
s name<br>qemu-system-aarch64.exe: warning: global &#39;xlnx,zynqmp-boot.us=
e-pmufw has invalid class name<br>QEMU: Terminated<br></span></div><div><br=
></div><div><br></div><div>GDB</div><div><span style=3D"background-color:rg=
b(238,238,238)">For help, type &quot;help&quot;.<br>Type &quot;apropos word=
&quot; to search for commands related to &quot;word&quot;...<br>Reading sym=
bols from C:\Users\sayedf\qnx710\image-with-drivers\output\ifs.bin...(no de=
bugging symbols found)...done.<br>(gdb) target remote :1234<br>Remote debug=
ging using :1234<br>warning: Can not parse XML target description; XML supp=
ort was disabled at compile time<br>0x0000000080000800 in ?? ()<br>(gdb) c<=
br>Continuing.<br>[Inferior 1 (process 1) exited normally]</span><br></div>=
<div><br></div><div>Please have a look :)</div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 20, 2024 at 11:2=
2=E2=80=AFPM Faiq Ali Sayed &lt;<a href=3D"mailto:faiqueali.109@gmail.com">=
faiqueali.109@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div dir=3D"ltr">The real hardware (

xlnx-zcu102 ) is being used for our software. The software is in the develo=
pment phase, and for that, I need to create a VM for simulation purposes.<d=
iv>Qemu has a machine type (-M xlnx-zcu102) which is supported with the boa=
rd/hardware.</div><div><br></div><div>I have two more images for the same h=
ardware and I can create a VM using these two images,=C2=A0but in the VM so=
me basic binaries are missing like mkdir and virtual disk etc.</div><div><b=
r></div><div>Now, the image for which I want to create a VM is currently wo=
rking on board and everything is working fine on real hardware.</div><div>I=
 am not sure whether I can use this image for Qemu because this is created =
particularly for hardware.</div><div>and giving a try to create a VM.</div>=
<div><br></div><div>Your valuable=C2=A0suggestions in this regard will be=
=C2=A0appreciated and mean a lot to=C2=A0me :)</div><div><br></div><div><br=
></div><div>br!</div><div>Faiq</div><div><br></div><div><br></div></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, F=
eb 20, 2024 at 10:24=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.m=
aydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, 20 Feb=
 2024 at 20:56, Faiq Ali Sayed &lt;<a href=3D"mailto:faiqueali.109@gmail.co=
m" target=3D"_blank">faiqueali.109@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The image I am using is currently in use for real hardware, and<br>
&gt; I received it from a third party/vendor.<br>
<br>
OK, so what exactly is the real hardware it&#39;s for?<br>
<br>
&gt; Could you please suggest to me what I can do now?<br>
<br>
If QEMU has a model of the hardware the image is for:<br>
=C2=A0- use that QEMU machine type (and issues with getting it running<br>
=C2=A0 =C2=A0will be related to making sure you&#39;re loading it at the ri=
ght<br>
=C2=A0 =C2=A0address and starting it the way it wants to be started)<br>
If QEMU does not have a model of the hardware the image is for:<br>
=C2=A0- ask your vendor for a build that targets some machine QEMU<br>
=C2=A0 =C2=A0does have a model of<br>
<br>
Unfortunately in general in the Arm world guest OSes are<br>
not &quot;runs on anything&quot;, but only &quot;runs on the hardware<br>
they were built to run on&quot;. This remains true under emulation.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div dir=3D"ltr">
<div><span style=3D"color:rgb(34,34,34)">Kind Regard-</span><br style=3D"co=
lor:rgb(34,34,34)"><div dir=3D"ltr" style=3D"color:rgb(34,34,34)"><div dir=
=3D"ltr"><div dir=3D"ltr"><font color=3D"#073763">Faiq Ali Sayed</font></di=
v></div></div></div>
<div><font style=3D"background-color:rgb(255,255,255)" size=3D"1"><br></fon=
t></div><br></div></div></div>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div dir=3D"ltr">
<div><span style=3D"color:rgb(34,34,34)">Kind Regard-</span><br style=3D"co=
lor:rgb(34,34,34)"><div dir=3D"ltr" style=3D"color:rgb(34,34,34)"><div dir=
=3D"ltr"><div dir=3D"ltr"><font color=3D"#073763">Faiq Ali Sayed</font></di=
v></div></div></div>
<div><font style=3D"background-color:rgb(255,255,255)" size=3D"1"><br></fon=
t></div><br></div></div></div>

--000000000000a312d20611e44930--

