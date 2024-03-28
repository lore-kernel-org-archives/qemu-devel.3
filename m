Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744C3C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 09:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpmWx-00023B-Kz; Thu, 28 Mar 2024 05:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sanj27272@gmail.com>)
 id 1rpmWi-000211-OG; Thu, 28 Mar 2024 05:58:28 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sanj27272@gmail.com>)
 id 1rpmWg-0002p2-RV; Thu, 28 Mar 2024 05:58:28 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5688eaf1165so973177a12.1; 
 Thu, 28 Mar 2024 02:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711619904; x=1712224704; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Rqtt/5cFNnzN2QbWV6d5NoOamWwzy1pDi2pN2kUXfPg=;
 b=ACBjn7+7u9b/qF49hj+P6JYNeFEmU/0dQTvda3Yhz/SxpigwJbAvsXJ6MTdLe7xRfj
 2R5pfD1RzAg+4CYfLZ+0KlehWzqPPdKECf5Ya2sj+vMPsS5At/2UdxRjtenZ7uL1qB2B
 j0sS5yDg3ySCANyCbW6y30IdBqcmKjmi2OotTGr4CC7e65EfGftc8SUSuraxkao6tYyP
 U1OeNqs6ZdieyhkNlkWOD+gKEmYzPKCgq+w+vupmvKP09bjMeKQG2XIZ/zmjg8QPaR1B
 UO2mICZX/rAlkEAAz0VdCJas7GVwUSanEdOSUb17ExlPGmc5KIMLHYvf153H9dvgHUTn
 NVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711619904; x=1712224704;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rqtt/5cFNnzN2QbWV6d5NoOamWwzy1pDi2pN2kUXfPg=;
 b=i1vu+C0owkZcNgavOhEtVhgxKCHOR5+WDGYf8omfmTTaYPiwW22hsv0+lRLhk7y/YQ
 G5JlZVL3/OBQPsTWCMTU0dVvLKpecGuBDO6D/7t1Y1oT9dDuchaTkCCPxNwg7c17B4fv
 VmEFXvXqeUFFbY5OKvJqjhtNmVecnvAopVRGxkDWE3gM6N/J4kjG/JRSwM3HOSlLiNM+
 sRQaLmu3EcWPWWNwA+d1lQpls7Nhb8TkVLyVBqzyzb/95jeUWlaw4GvWe2ClQq0mi2vJ
 hA3OSdl14Qv/BhGgQASF74oy4JpLTkqGofLeByQUIld2qo5qDoCUVHxoj5C0IbfCLtsU
 vwkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZmIE4mrYOMny+ptT3HwJzrckYKeVIgbuI08Wpw7butRRPjQ6zg/9EZ8Z8PSHGIRNEStPaddmRFcz2scWE+zg7+CLsFRUFXF1f1m1KGV0mGjdSfYgaBHtwf24=
X-Gm-Message-State: AOJu0YxXN26H0+d3kw/EUvy5G/CPUk01FzCheD5K27WqtUuYtSeJ7RoY
 dMLy56fD5gA3UAD/ZKTXcDf4NBQTXdG7DLXTKvhH5jOEUdqPb5FU8wcXK1IAz/S7PHWIIwKbE2X
 E3qEDz2bjTL/dSRsAKSYax6jmn4iXQwNH444=
X-Google-Smtp-Source: AGHT+IFA7xGPA7YtzrePK5nK8vEzA4rwP6g8a9AY7sFIkJsH3/bCs2BltoUoDpp4Yz1Nlf0eMIs2Mku9SAhc1+xMYK8=
X-Received: by 2002:a17:906:db0d:b0:a46:d79c:ef62 with SMTP id
 xj13-20020a170906db0d00b00a46d79cef62mr1787599ejb.51.1711619903710; Thu, 28
 Mar 2024 02:58:23 -0700 (PDT)
MIME-Version: 1.0
From: sanjana gogte <sanj27272@gmail.com>
Date: Thu, 28 Mar 2024 15:28:12 +0530
Message-ID: <CA+ji3pHZN0DPg4LfssBs1urgYTZy22a6b+fzjfciA_QHjngMQA@mail.gmail.com>
Subject: Gdb support for Debugging Arm M profile with Xilinx Qemu
To: vikram.garhwal@amd.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 francisco.iglesias@xilinx.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000059ef2d0614b5900d"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=sanj27272@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000059ef2d0614b5900d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greetings,

I am currently engaged in a project that involves emulating the LM3S811EVB
( M3 Core ) board using Xilinx QEMU (version 7.1.0) . While the emulation
process is successful, I am encountering difficulties in attaching GNU
Debugger (GDB) or GDB-multiarch to the ELF file being executed on the
emulated board. Interestingly, this issue does not arise when utilizing the
standard QEMU (version 8.1.5), where I am able to attach GDB and step
through the ELF file without any hindrances.


To address this issue, I have experimented with different versions of GDB,
specifically:
GNU gdb (Arm GNU Toolchain 13.2.rel1 (Build arm-13.7)) ( arm-none-eabi)
GNU gdb (Linaro_GDB-2019.12) 8.3.1.20191204-git
*Error I am facing :*
Remote debugging using localhost:1234
Remote 'g' packet reply is too long (expected 68 bytes, got 92 bytes):
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000028100020ffffffff080000000000004100000000000000=
0000000000000000000000000000000000
(gdb) b main
Breakpoint 1 at 0xc6: file main2.c, line 69.
(gdb) continue
The program is not being run.
(gdb) run
Don't know how to run. Try "help target".

*With Gdb-multiarch (12.1)*
gef=E2=9E=A4 set architecture armv7
The target architecture is set to "armv7".
gef=E2=9E=A4 target remote:1234
Remote debugging using :1234
warning: No executable has been specified and target does not support
determining executable automatically. Try using the "file" command.
Remote 'g' packet reply is too long (expected 68 bytes, got 92 bytes):
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000028100020ffffffff080000000000004100000000000000=
0000000000000000000000000000000000
gef=E2=9E=A4 file kernel2.elf
Reading symbols from kernel2.elf...
gef=E2=9E=A4 b main
Breakpoint 1 at 0xc6: file main2.c, line 69.
gef=E2=9E=A4 continue
The program is not being run.
gef=E2=9E=A4 run
Starting program:
/mnt/c/Users/Gogte/Desktop/sanjana_intern_project/Qemu_test/test3/LinkerM3/=
kernel2.elf

/bin/bash: line 1:
/mnt/c/Users/Gogte/Desktop/sanjana_intern_project/Qemu_test/test3/LinkerM3/=
kernel2.elf:
cannot execute binary file: Exec format error
/bin/bash: line 1:
/mnt/c/Users/Gogte/Desktop/sanjana_intern_project/Qemu_test/test3/LinkerM3/=
kernel2.elf:
Success
During startup program exited with code 126.

*If I do the same with Standard qemu binary the gdb works:*
Remote debugging using localhost:1234
start () at startup.s:10
--Type <RET> for more, q to quit, c to continue without paging--c
10 ldr r1, =3Dmain
(gdb) b main
Breakpoint 1 at 0xc6: file main2.c, line 69.
(gdb) continue
Continuing.

Breakpoint 1, main () at main2.c:69
69 uart_print("Inside main function");
(gdb)


My project necessitates the use of the Xilinx QEMU binary, specifically to
leverage the remote port functionality it offers.

Therefore, I am seeking guidance on which version of GDB should be used, or
any specific configurations that might enable successful GDB attachment to
the ELF file running on Xilinx QEMU.


Regards,
Sanjana

--00000000000059ef2d0614b5900d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div>Greetings,<div>





<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-kerning:auto;=
font-feature-settings:normal;font-stretch:normal;font-size:13px;line-height=
:normal;font-family:&quot;Helvetica Neue&quot;">I am currently engaged in a=
 project that involves emulating the LM3S811EVB ( M3 Core ) board using Xil=
inx QEMU (version 7.1.0) . While the emulation process is successful, I am =
encountering difficulties in attaching GNU Debugger (GDB) or GDB-multiarch =
to the ELF file being executed on the emulated board. Interestingly, this i=
ssue does not arise when utilizing the standard QEMU (version 8.1.5), where=
 I am able to attach GDB and step through the ELF file without any hindranc=
es.</p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:norma=
l;font-variant-east-asian:normal;font-variant-alternates:normal;font-kernin=
g:auto;font-feature-settings:normal;font-stretch:normal;font-size:13px;line=
-height:normal;font-family:&quot;Helvetica Neue&quot;"><br></p><p class=3D"=
gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-variant-east=
-asian:normal;font-variant-alternates:normal;font-kerning:auto;font-feature=
-settings:normal;font-stretch:normal;font-size:13px;line-height:normal;font=
-family:&quot;Helvetica Neue&quot;">





</p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;f=
ont-variant-east-asian:normal;font-variant-alternates:normal;font-kerning:a=
uto;font-feature-settings:normal;font-stretch:normal;font-size:13px;line-he=
ight:normal;font-family:&quot;Helvetica Neue&quot;">To address this issue, =
I have experimented with different versions of GDB, specifically:</p></div>=
<div>GNU gdb (Arm GNU Toolchain 13.2.rel1 (Build arm-13.7)) ( arm-none-eabi=
)<br></div><div>GNU gdb (Linaro_GDB-2019.12) 8.3.1.20191204-git<br></div><d=
iv><b>Error I am facing :</b></div><div><div style=3D"font-family:Menlo,Mon=
aco,&quot;Courier New&quot;,monospace;font-size:12px;line-height:18px;white=
-space:pre"><div style=3D""><span style=3D"background-color:rgb(255,255,255=
)"><font color=3D"#000000">Remote debugging using localhost:1234</font></sp=
an></div><div style=3D""><span style=3D"background-color:rgb(255,255,255)">=
<font color=3D"#000000">Remote &#39;g&#39; packet reply is too long (expect=
ed 68 bytes, got 92 bytes): 00000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000028100020ffffffff08=
00000000000041000000000000000000000000000000000000000000000000</font></span=
></div><div style=3D""><span style=3D"background-color:rgb(255,255,255)"><f=
ont color=3D"#000000">(gdb) b main</font></span></div><div style=3D""><span=
 style=3D"background-color:rgb(255,255,255)"><font color=3D"#000000">Breakp=
oint 1 at 0xc6: file main2.c, line 69.</font></span></div><div style=3D""><=
span style=3D"background-color:rgb(255,255,255)"><font color=3D"#000000">(g=
db) continue</font></span></div><div style=3D""><span style=3D"background-c=
olor:rgb(255,255,255)"><font color=3D"#000000">The program is not being run=
.</font></span></div><div style=3D""><span style=3D"background-color:rgb(25=
5,255,255)"><font color=3D"#000000">(gdb) run</font></span></div><div style=
=3D""><span style=3D"background-color:rgb(255,255,255)"><font color=3D"#000=
000">Don&#39;t know how to run.  Try &quot;help target&quot;.</font></span>=
</div></div></div><div><br></div><div><b>With Gdb-multiarch (12.1)</b></div=
><div><div style=3D"line-height:18px;white-space:pre"><div style=3D"font-si=
ze:12px;font-family:Menlo,Monaco,&quot;Courier New&quot;,monospace"><span s=
tyle=3D"background-color:rgb(255,255,255)"><font color=3D"#000000">gef=E2=
=9E=A4  set architecture armv7</font></span></div><div style=3D"font-size:1=
2px;font-family:Menlo,Monaco,&quot;Courier New&quot;,monospace"><span style=
=3D"background-color:rgb(255,255,255)"><font color=3D"#000000">The target a=
rchitecture is set to &quot;armv7&quot;.</font></span></div><div style=3D"f=
ont-size:12px;font-family:Menlo,Monaco,&quot;Courier New&quot;,monospace"><=
span style=3D"background-color:rgb(255,255,255)"><font color=3D"#000000">ge=
f=E2=9E=A4  target remote:1234</font></span></div><div style=3D"font-size:1=
2px;font-family:Menlo,Monaco,&quot;Courier New&quot;,monospace"><span style=
=3D"background-color:rgb(255,255,255)"><font color=3D"#000000">Remote debug=
ging using :1234</font></span></div><div style=3D"font-size:12px;font-famil=
y:Menlo,Monaco,&quot;Courier New&quot;,monospace"><span style=3D"background=
-color:rgb(255,255,255)"><font color=3D"#000000">warning: No executable has=
 been specified and target does not support</font></span></div><div style=
=3D"font-size:12px;font-family:Menlo,Monaco,&quot;Courier New&quot;,monospa=
ce"><span style=3D"background-color:rgb(255,255,255)"><font color=3D"#00000=
0">determining executable automatically.  Try using the &quot;file&quot; co=
mmand.</font></span></div><div style=3D"font-size:12px;font-family:Menlo,Mo=
naco,&quot;Courier New&quot;,monospace"><span style=3D"background-color:rgb=
(255,255,255)"><font color=3D"#000000">Remote &#39;g&#39; packet reply is t=
oo long (expected 68 bytes, got 92 bytes): 00000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000281=
00020ffffffff08000000000000410000000000000000000000000000000000000000000000=
00</font></span></div><div style=3D"font-size:12px;font-family:Menlo,Monaco=
,&quot;Courier New&quot;,monospace"><span style=3D"background-color:rgb(255=
,255,255)"><font color=3D"#000000">gef=E2=9E=A4  file kernel2.elf</font></s=
pan></div><div style=3D"font-size:12px;font-family:Menlo,Monaco,&quot;Couri=
er New&quot;,monospace"><span style=3D"background-color:rgb(255,255,255)"><=
font color=3D"#000000">Reading symbols from kernel2.elf...</font></span></d=
iv><div style=3D"font-size:12px;font-family:Menlo,Monaco,&quot;Courier New&=
quot;,monospace"><span style=3D"background-color:rgb(255,255,255)"><font co=
lor=3D"#000000">gef=E2=9E=A4  b main</font></span></div><div style=3D"font-=
size:12px;font-family:Menlo,Monaco,&quot;Courier New&quot;,monospace"><span=
 style=3D"background-color:rgb(255,255,255)"><font color=3D"#000000">Breakp=
oint 1 at 0xc6: file main2.c, line 69.</font></span></div><div style=3D"fon=
t-size:12px;font-family:Menlo,Monaco,&quot;Courier New&quot;,monospace"><sp=
an style=3D"background-color:rgb(255,255,255)"><font color=3D"#000000">gef=
=E2=9E=A4  continue</font></span></div><div style=3D"font-size:12px;font-fa=
mily:Menlo,Monaco,&quot;Courier New&quot;,monospace"><span style=3D"backgro=
und-color:rgb(255,255,255)"><font color=3D"#000000">The program is not bein=
g run.</font></span></div><div style=3D"font-size:12px;font-family:Menlo,Mo=
naco,&quot;Courier New&quot;,monospace"><span style=3D"background-color:rgb=
(255,255,255)"><font color=3D"#000000">gef=E2=9E=A4  run</font></span></div=
><div style=3D"font-size:12px;font-family:Menlo,Monaco,&quot;Courier New&qu=
ot;,monospace"><span style=3D"background-color:rgb(255,255,255)"><font colo=
r=3D"#000000">Starting program: /mnt/c/Users/Gogte/Desktop/sanjana_intern_p=
roject/Qemu_test/test3/LinkerM3/kernel2.elf </font></span></div><div style=
=3D"font-size:12px;font-family:Menlo,Monaco,&quot;Courier New&quot;,monospa=
ce"><span style=3D"background-color:rgb(255,255,255)"><font color=3D"#00000=
0">/bin/bash: line 1: /mnt/c/Users/Gogte/Desktop/sanjana_intern_project/Qem=
u_test/test3/LinkerM3/kernel2.elf: cannot execute binary file: Exec format =
error</font></span></div><div style=3D"font-size:12px;font-family:Menlo,Mon=
aco,&quot;Courier New&quot;,monospace"><span style=3D"background-color:rgb(=
255,255,255)"><font color=3D"#000000">/bin/bash: line 1: /mnt/c/Users/Gogte=
/Desktop/sanjana_intern_project/Qemu_test/test3/LinkerM3/kernel2.elf: Succe=
ss</font></span></div><div style=3D"font-size:12px;font-family:Menlo,Monaco=
,&quot;Courier New&quot;,monospace"><span style=3D"background-color:rgb(255=
,255,255)"><font color=3D"#000000">During startup program exited with code =
126.</font></span></div><div style=3D"font-size:12px;font-family:Menlo,Mona=
co,&quot;Courier New&quot;,monospace"><br></div><div style=3D""><font face=
=3D"arial, sans-serif" style=3D""><b style=3D""><span style=3D"font-size:12=
px">I</span>f I do the same with Standard qemu binary the gdb works:</b></f=
ont></div><div style=3D""><div style=3D"line-height:18px"><div style=3D"fon=
t-size:12px;font-family:Menlo,Monaco,&quot;Courier New&quot;,monospace"><fo=
nt color=3D"#000000" style=3D"background-color:rgb(255,255,255)">Remote deb=
ugging using localhost:1234</font></div><div style=3D"font-size:12px;font-f=
amily:Menlo,Monaco,&quot;Courier New&quot;,monospace"><font color=3D"#00000=
0" style=3D"background-color:rgb(255,255,255)">start () at startup.s:10</fo=
nt></div><div style=3D"font-size:12px;font-family:Menlo,Monaco,&quot;Courie=
r New&quot;,monospace"><font color=3D"#000000" style=3D"background-color:rg=
b(255,255,255)">--Type &lt;RET&gt; for more, q to quit, c to continue witho=
ut paging--c</font></div><div style=3D"font-size:12px;font-family:Menlo,Mon=
aco,&quot;Courier New&quot;,monospace"><font color=3D"#000000" style=3D"bac=
kground-color:rgb(255,255,255)">10      ldr r1, =3Dmain</font></div><div st=
yle=3D"font-size:12px;font-family:Menlo,Monaco,&quot;Courier New&quot;,mono=
space"><font color=3D"#000000" style=3D"background-color:rgb(255,255,255)">=
(gdb) b main</font></div><div style=3D"font-size:12px;font-family:Menlo,Mon=
aco,&quot;Courier New&quot;,monospace"><font color=3D"#000000" style=3D"bac=
kground-color:rgb(255,255,255)">Breakpoint 1 at 0xc6: file main2.c, line 69=
.</font></div><div style=3D"font-size:12px;font-family:Menlo,Monaco,&quot;C=
ourier New&quot;,monospace"><font color=3D"#000000" style=3D"background-col=
or:rgb(255,255,255)">(gdb) continue</font></div><div style=3D"font-size:12p=
x;font-family:Menlo,Monaco,&quot;Courier New&quot;,monospace"><font color=
=3D"#000000" style=3D"background-color:rgb(255,255,255)">Continuing.</font>=
</div><font color=3D"#000000" style=3D"font-size:12px;font-family:Menlo,Mon=
aco,&quot;Courier New&quot;,monospace;background-color:rgb(255,255,255)"><b=
r></font><div style=3D"font-size:12px;font-family:Menlo,Monaco,&quot;Courie=
r New&quot;,monospace"><font color=3D"#000000" style=3D"background-color:rg=
b(255,255,255)">Breakpoint 1, main () at main2.c:69</font></div><div style=
=3D"font-size:12px;font-family:Menlo,Monaco,&quot;Courier New&quot;,monospa=
ce"><font color=3D"#000000" style=3D"background-color:rgb(255,255,255)">69 =
             uart_print(&quot;Inside main function&quot;);</font></div><div=
 style=3D"font-size:12px;font-family:Menlo,Monaco,&quot;Courier New&quot;,m=
onospace"><font color=3D"#000000" style=3D"background-color:rgb(255,255,255=
)">(gdb)</font></div><div style=3D"font-size:12px;font-family:Menlo,Monaco,=
&quot;Courier New&quot;,monospace"><br></div><div style=3D"font-size:12px;f=
ont-family:Menlo,Monaco,&quot;Courier New&quot;,monospace"><p class=3D"gmai=
l-p1" style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asi=
an:normal;font-variant-alternates:normal;font-kerning:auto;font-feature-set=
tings:normal;font-stretch:normal;font-size:13px;line-height:normal;font-fam=
ily:&quot;Helvetica Neue&quot;"><br></p><p class=3D"gmail-p1" style=3D"marg=
in:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-vari=
ant-alternates:normal;font-kerning:auto;font-feature-settings:normal;font-s=
tretch:normal;font-size:13px;line-height:normal;font-family:&quot;Helvetica=
 Neue&quot;">My project necessitates the use of the Xilinx QEMU binary, spe=
cifically to leverage the remote port functionality it offers.</p><p class=
=3D"gmail-p1" style=3D"font-variant-numeric:normal;font-variant-east-asian:=
normal;font-variant-alternates:normal;font-kerning:auto;font-feature-settin=
gs:normal;font-stretch:normal;font-size:13px;line-height:normal;font-family=
:&quot;Helvetica Neue&quot;;margin:0px">Therefore, I am seeking guidance on=
 which version of GDB should be used, or any specific configurations that m=
ight enable successful GDB attachment to the ELF file running on Xilinx QEM=
U.</p><p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal=
;font-variant-east-asian:normal;font-variant-alternates:normal;font-kerning=
:auto;font-feature-settings:normal;font-stretch:normal;font-size:13px;line-=
height:normal;font-family:&quot;Helvetica Neue&quot;"><br></p></div></div><=
/div><div style=3D"font-size:12px"><font face=3D"arial, sans-serif">Regards=
,</font></div><div style=3D"font-size:12px"><font face=3D"arial, sans-serif=
">Sanjana</font></div><div style=3D"font-size:12px;font-family:Menlo,Monaco=
,&quot;Courier New&quot;,monospace"><span style=3D"background-color:rgb(255=
,255,255)"><font color=3D"#000000"><br></font></span></div><div style=3D"fo=
nt-size:12px;font-family:Menlo,Monaco,&quot;Courier New&quot;,monospace"><s=
pan style=3D"background-color:rgb(255,255,255)"><font color=3D"#000000"><br=
></font></span></div><div style=3D"font-size:12px;font-family:Menlo,Monaco,=
&quot;Courier New&quot;,monospace"><span style=3D"background-color:rgb(255,=
255,255)"><font color=3D"#000000"><br></font></span></div></div></div><div>=
<br></div></div>

--00000000000059ef2d0614b5900d--

