Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB69FC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 16:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcT3v-0003Pv-B1; Tue, 20 Feb 2024 11:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1rcT3s-0003OZ-S1
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:33:41 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1rcT3q-0001PV-Is
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:33:40 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-563ed3d221aso6879702a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 08:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708446817; x=1709051617; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9ZLzu7169Vwwm4i9x1nQEJef5YVdBcM25bwOHWlwq90=;
 b=LyAngFE8la7BZIBL4d2QYIXbvF0w4AeizFgEfg7KNDhPWw2K3dDHAI/Voie8I1oX7r
 BXo7izsKEcUIua/0wgbf+tHTpLwARVCh3TCh9YTAVvaH+POWVST2OwJ209ikbE1B6MV0
 fQTl+fxtDIaDG7c7UiEjq4a6zqc4Z5P+Cjb+sDpl8+4ffC/jh+qFdEMynA1hc3K/zzBM
 aYKFLUDnF/Ypueolgm3EKDpaRn8Jh0VZ/cmKW5IkpGD0lpOL2sdrYY3sLkjo2by5qdXz
 Es9B1pdnBACOnaKXPSCm3XSeyWdeRbwgpiiCqE/U1lCVrYLnDgKRVPiROMaM5oyA6lbn
 gm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708446817; x=1709051617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ZLzu7169Vwwm4i9x1nQEJef5YVdBcM25bwOHWlwq90=;
 b=meAhBmNYjOlGIMsOQNT6GmKiWJ8bPYiI9K+SddaoGdaOy4RyGzsdITQ4F8Z0cd/Oln
 Gl26VbdVqwOvOC6paqFqeasd9v35KMdU+TE2TA6vy1D+uY55yRl0nCz57Dapw04cEasY
 IkPETID2/fOGd0FfxqyyGl0QmD11Cnnn6NzDt4HniA8HN5WN9CkazfmEMb14F+OHeCHJ
 caM4AI+gk5P/lCkL5qQD5vcktxDvEuPHU9MOa/C5DlQa1TQwSCJUedl/N4wPx+bPyBrh
 b0Spj5scPeCORUi/cXs0/0/DaHTBxQpgKBfDHNTdguXW/rAiHNohdC5+qdhj8homeMm/
 zmgw==
X-Gm-Message-State: AOJu0YzQN1hydQS440g6rCVtjtGBIDsTeefCnFj5UDbtCirrhj21vrYq
 q+nE8OAsPsPPvWfUHkNxgrleK2v7/449zL2TQlpW+8d2vsQyA9ek0iqckfXTek++tzrUTV2pBsw
 L19TjyjvYiICmThRfrORxl3dtsXBDdlB9Hjw=
X-Google-Smtp-Source: AGHT+IFUqbbn0zP5YYQt02+Bo4nt6ev8Xlile+o+oZQi5wYosf6FuqF9xhQkScMHaGAQm8BRC5LKWtAKlXq18Hg7Aog=
X-Received: by 2002:aa7:de0e:0:b0:564:b9be:5c16 with SMTP id
 h14-20020aa7de0e000000b00564b9be5c16mr3001508edv.8.1708446816652; Tue, 20 Feb
 2024 08:33:36 -0800 (PST)
MIME-Version: 1.0
References: <CAOpGCn+KdhjnXRHup6GXVbkoZkUBc7f-2urNzmvLjK1To_pp0A@mail.gmail.com>
 <87a5nvci5n.fsf@draig.linaro.org>
In-Reply-To: <87a5nvci5n.fsf@draig.linaro.org>
From: Faiq Ali Sayed <faiqueali.109@gmail.com>
Date: Tue, 20 Feb 2024 17:33:25 +0100
Message-ID: <CAOpGCnLxVGhbJuAq+K+DNZBESEGGkSr8Sa0_cHsfMR7S-_ahkQ@mail.gmail.com>
Subject: Re: QNX VM hang on Qemu
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009ff20b0611d2c5a9"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=faiqueali.109@gmail.com; helo=mail-ed1-x530.google.com
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

--0000000000009ff20b0611d2c5a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alex thanks for the reply,

I don't know what the debug symbol is, but my target system is QNX aarch64
below are the configuration of GDB,

(gdb) show configuration
This GDB was configured as follows:
   configure --host=3Dx86_64-pc-linux-gnu
--target=3Daarch64-unknown-nto-qnx7.1.0
             --with-auto-load-dir=3D$debugdir:$datadir/auto-load
             --with-auto-load-safe-path=3D$debugdir:$datadir/auto-load
             --without-expat
             --with-gdb-datadir=3D/opt/qnx710/host/linux/x86_64/usr/share/g=
db
(relocatable)

 --with-jit-reader-dir=3D/opt/qnx710/host/linux/x86_64/usr/lib/gdb
(relocatable)
             --without-libunwind-ia64
             --without-lzma
             --without-babeltrace
             --without-intel-pt
             --disable-libmcheck
             --without-mpfr
             --with-python=3D/opt/qnx710/host/linux/x86_64/usr (relocatable=
)
             --without-guile

 --with-separate-debug-dir=3D/opt/qnx710/host/linux/x86_64/usr/lib/debug
(relocatable)
             --with-sysroot=3D/opt/qnx710/target/qnx7/aarch64

while I got the below result, after executing the x/10i $pc

(gdb) x/10i $pc
=3D> 0x100000: .inst 0x5371242b ; undefined
   0x100004: fcmla v21.8h, v3.8h, v16.h[1], #270
   0x100008: .inst 0x64657472 ; undefined
   0x10000c: ldnp d26, d27, [x9, #-176]
   0x100010: .inst 0x72706974 ; undefined
   0x100014: .inst 0x7365636f ; undefined
   0x100018: .inst 0x733b2b73 ; undefined
   0x10001c: fnmls z23.h, p0/m, z19.h, z18.h
   0x100020: .inst 0x3b2b6b61 ; undefined
   0x100024: .inst 0x72627768 ; undefined

Can you please let me know how I can step in ?
When I press c it does not execute further and hangs..


Faiq

On Tue, Feb 20, 2024 at 3:41=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> Faiq Ali Sayed <faiqueali.109@gmail.com> writes:
>
> > Hi everyone,
> > I am facing an issue during booting QNX VM using Qemu,
> > I have an image to Boot the VM. and when I trigger a Qemu command to
> create a VM it is stuck.
> > I also used a debugger to investigate but I can not see any result by
> GDB.
> >
> > Here is the output of first windows
> >
> > qemu-system-aarch64 -M xlnx-zcu102 -m 16G -serial mon:stdio -display
> none -device
> > loader,file=3DQNX-IFS,addr=3D0x00100000,cpu-num=3D0 -drive
> >
> file=3D/home/faiq/Downloads/install/BootSD/qemu-boot_sd.img,if=3Dsd,forma=
t=3Draw,index=3D1
> -boot mode=3D5 -net
> > nic,model=3Dcadence_gem -net nic,model=3Dcadence_gem -net
> nic,model=3Dcadence_gem -net
> > nic,model=3Dcadence_gem,netdev=3Dxzynq0 -netdev
> user,id=3Dxzynq0,tftp=3D/tftpboot  -nographic -global
> > xlnx,zynqmp-boot.cpu-num=3D0 -global 'xlnx,zynqmp-boot.use-pmufw=3Dtrue=
' -s
> -S
> >
> > qemu-system-aarch64: warning: hub 0 is not connected to host network
>
> Is this QNX VM image built for the xlnx-zcu102 board?
>
> > on the other hand, here is the output of GDB:
> >
> > (gdb) target remote :1234
> > Remote debugging using :1234
> > warning: No executable has been specified and target does not support
> > determining executable automatically.  Try using the "file" command.
> > 0x0000000000100000 in ?? ()
> > (gdb) c
> > Continuing.
>
> You'll either want the debug symbols for your image or tell GDB what the
> target arch is. Check you are somewhere sane by doing:
>
>   x/10i $pc
>
> and step through the instructions and see where it goes. If you hit
> Ctrl-C are you executing nonsense instructions or in a tight loop
> hanging?
>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>


--=20
Kind Regard-
Faiq Ali Sayed

--0000000000009ff20b0611d2c5a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Alex thanks for the reply,</div><div><br></div><div>I=
 don&#39;t know what the debug symbol is, but my target system is QNX aarch=
64 <br></div><div>below are the configuration of GDB,</div><div><br></div><=
div><span style=3D"background-color:rgb(238,238,238)">(gdb) show configurat=
ion<br>This GDB was configured as follows:<br>=C2=A0 =C2=A0configure --host=
=3Dx86_64-pc-linux-gnu --target=3Daarch64-unknown-nto-qnx7.1.0<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--with-auto-load-dir=3D$debugdir:$=
datadir/auto-load<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--with=
-auto-load-safe-path=3D$debugdir:$datadir/auto-load<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0--without-expat<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0--with-gdb-datadir=3D/opt/qnx710/host/linux/x86_64/usr/=
share/gdb (relocatable)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
--with-jit-reader-dir=3D/opt/qnx710/host/linux/x86_64/usr/lib/gdb (relocata=
ble)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--without-libunwind=
-ia64<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--without-lzma<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--without-babeltrace<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--without-intel-pt<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--disable-libmcheck<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--without-mpfr<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--with-python=3D/opt/qnx710/host/linux/x86_6=
4/usr (relocatable)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--wi=
thout-guile<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--with-separ=
ate-debug-dir=3D/opt/qnx710/host/linux/x86_64/usr/lib/debug (relocatable)<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--with-sysroot=3D/opt/qnx=
710/target/qnx7/aarch64</span><br></div><div><br></div><div>while I got the=
 below result, after executing the <span style=3D"background-color:rgb(238,=
238,238)">x/10i $pc <br></span></div><div><span style=3D"background-color:r=
gb(238,238,238)"><br></span></div><div><span style=3D"background-color:rgb(=
238,238,238)">(gdb) x/10i $pc<br>=3D&gt; 0x100000:	.inst	0x5371242b ; undef=
ined<br>=C2=A0 =C2=A00x100004:	fcmla	v21.8h, v3.8h, v16.h[1], #270<br>=C2=
=A0 =C2=A00x100008:	.inst	0x64657472 ; undefined<br>=C2=A0 =C2=A00x10000c:	=
ldnp	d26, d27, [x9, #-176]<br>=C2=A0 =C2=A00x100010:	.inst	0x72706974 ; und=
efined<br>=C2=A0 =C2=A00x100014:	.inst	0x7365636f ; undefined<br>=C2=A0 =C2=
=A00x100018:	.inst	0x733b2b73 ; undefined<br>=C2=A0 =C2=A00x10001c:	fnmls	z=
23.h, p0/m, z19.h, z18.h<br>=C2=A0 =C2=A00x100020:	.inst	0x3b2b6b61 ; undef=
ined<br>=C2=A0 =C2=A00x100024:	.inst	0x72627768 ; undefined</span></div><di=
v><br></div><div>Can you please let me know how I can step in ?</div><div>W=
hen I press c it does not execute further and hangs..</div><div><br></div><=
div></div><div><br></div><div>Faiq<br></div><div><span style=3D"background-=
color:rgb(238,238,238)"></span></div></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 20, 2024 at 3:41=E2=80=AFP=
M Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.benne=
e@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Faiq Ali Sayed &lt;<a href=3D"mailto:faiqueali.109@gmail.com" t=
arget=3D"_blank">faiqueali.109@gmail.com</a>&gt; writes:<br>
<br>
&gt; Hi everyone, <br>
&gt; I am facing an issue during booting QNX VM using Qemu,<br>
&gt; I have an image to Boot the VM. and when I trigger a Qemu command to c=
reate a VM it is stuck.<br>
&gt; I also used a debugger to investigate but I can not see any result by =
GDB.<br>
&gt;<br>
&gt; Here is the output of first windows<br>
&gt;<br>
&gt; qemu-system-aarch64 -M xlnx-zcu102 -m 16G -serial mon:stdio -display n=
one -device<br>
&gt; loader,file=3DQNX-IFS,addr=3D0x00100000,cpu-num=3D0 -drive<br>
&gt; file=3D/home/faiq/Downloads/install/BootSD/qemu-boot_sd.img,if=3Dsd,fo=
rmat=3Draw,index=3D1 -boot mode=3D5 -net<br>
&gt; nic,model=3Dcadence_gem -net nic,model=3Dcadence_gem -net nic,model=3D=
cadence_gem -net<br>
&gt; nic,model=3Dcadence_gem,netdev=3Dxzynq0 -netdev user,id=3Dxzynq0,tftp=
=3D/tftpboot=C2=A0 -nographic -global<br>
&gt; xlnx,zynqmp-boot.cpu-num=3D0 -global &#39;xlnx,zynqmp-boot.use-pmufw=
=3Dtrue&#39; -s -S<br>
&gt;<br>
&gt; qemu-system-aarch64: warning: hub 0 is not connected to host network<b=
r>
<br>
Is this QNX VM image built for the xlnx-zcu102 board?<br>
<br>
&gt; on the other hand, here is the output of GDB:<br>
&gt;<br>
&gt; (gdb) target remote :1234<br>
&gt; Remote debugging using :1234<br>
&gt; warning: No executable has been specified and target does not support<=
br>
&gt; determining executable automatically.=C2=A0 Try using the &quot;file&q=
uot; command.<br>
&gt; 0x0000000000100000 in ?? ()<br>
&gt; (gdb) c<br>
&gt; Continuing.<br>
<br>
You&#39;ll either want the debug symbols for your image or tell GDB what th=
e<br>
target arch is. Check you are somewhere sane by doing:<br>
<br>
=C2=A0 x/10i $pc<br>
<br>
and step through the instructions and see where it goes. If you hit<br>
Ctrl-C are you executing nonsense instructions or in a tight loop<br>
hanging?<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr"><div dir=3D"ltr">
<div><span style=3D"color:rgb(34,34,34)">Kind Regard-</span><br style=3D"co=
lor:rgb(34,34,34)"><div dir=3D"ltr" style=3D"color:rgb(34,34,34)"><div dir=
=3D"ltr"><div dir=3D"ltr"><font color=3D"#073763">Faiq Ali Sayed</font></di=
v></div></div></div>
<div><font style=3D"background-color:rgb(255,255,255)" size=3D"1"><br></fon=
t></div><br></div></div></div>

--0000000000009ff20b0611d2c5a9--

