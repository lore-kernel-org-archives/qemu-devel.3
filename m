Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79135CF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 15:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sskdN-0004GT-2l; Mon, 23 Sep 2024 11:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rj2814288312@gmail.com>)
 id 1sskAu-0007ms-0E; Mon, 23 Sep 2024 10:36:28 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rj2814288312@gmail.com>)
 id 1sskAr-0004tc-SK; Mon, 23 Sep 2024 10:36:27 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5e1c65eb68aso2852571eaf.2; 
 Mon, 23 Sep 2024 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727102183; x=1727706983; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uphcwsGEMMWQEhL/JXoEHNiPQNibELta0tncOu/YlL0=;
 b=PPFitLeQlZt9z3emEJ3QNPs0nRiYvDvVQOGpOjq+00t36f8sTXcwRiEYqB9I4LbaSc
 TvrSfF9WDAVnhsvpkCO3DyvtoctPuMi661zj8eXHjj7v8ZQSmSAvHZbJTLoci+7ObS4G
 HmOfErzqM0NOlkNerVsxrLSurInqbdR2oJzKG7w07Bv9DvD50H3n8gsVvQnhr/u3kWp4
 V+yR0CApRZ0X7//bQTMqBLH67/hCReryD48CoMvApTrwsXB9/VSUfyZFPrPTTHIe1/II
 488wPc6Xi6OwQ+qEgNS964LGx2zx85sR0sVbkgmPIz/1atksa8/ELKCnepVPkDv0TDeQ
 Cfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727102183; x=1727706983;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uphcwsGEMMWQEhL/JXoEHNiPQNibELta0tncOu/YlL0=;
 b=MrtbYCvjCr61f22KAhKw7VI0kHGee8niKMO+l2aMCSSe0v9P4AJVQ/vJCkY5dRrqwb
 4J4dQM24NFuvD80qaYq8wS6dJeWRdJDb0116g7U17M7WE6m7g1u9n5DpZVSrtFz5PJMk
 hvic5hv7hD6T6//I0N4lyvQsHOTj3mQfDuQAty6A8uFVmOrede5tlY2N1KTNxDpKHMaP
 JWIXkDHgFQIpqm8T272QFEkhS+nhFTt3xOtF6dCgMvFPHbcbdpZ6eQY15ToJBBlABEZI
 qCiVlhNX76k7X0WliahRUMt9EfWKRADDr8Z3xAscpwzKe1MIvdeVhzhGO4pYJlF7E0q5
 mnoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEI6AZaQOGei+AKUtDSa6oWgHFh/SYGs/n1ZmUgxJ1fFLWczwQtZ1hpHBLpxaR8C2ZF5MKnMWIBJHX@nongnu.org
X-Gm-Message-State: AOJu0Yxrz98vu75wAYRBblTAt1zBW/K1DdF5SIXuIX+FPQ1syw+4KDtU
 UrqaWTCyKpfbv11DuUUnsLajGyZePCQ4d3NcwM+0U+JQhsdfEiMuPRCjjeV/bpTfNMbdOIkr7kl
 +ur8bhZ3TMqXbeMptTbzewKgYkVJqT59z1tPmvw==
X-Google-Smtp-Source: AGHT+IGYkUSbRxTep63D8TPmRNbPSBCX5JQ0ZEWHyE74UNVjRspTtXR+/e1kMelr++5rRh/OifuyR0RZyZfS8MRFRCY=
X-Received: by 2002:a05:6358:7e91:b0:1ac:65e7:9399 with SMTP id
 e5c5f4694b2df-1bc99d18d9dmr234253355d.9.1727102182857; Mon, 23 Sep 2024
 07:36:22 -0700 (PDT)
MIME-Version: 1.0
From: jie ren <rj2814288312@gmail.com>
Date: Mon, 23 Sep 2024 22:36:11 +0800
Message-ID: <CAAsTPeaOec5UcWJOApsHxzs+-ZYotHLhiPhaWBXT9bw=Z9zjkg@mail.gmail.com>
Subject: Using ubuntu24.4 system qemu-system-aarch64 +gdb-multiarch to debug
 the kernel, setting breakpoints cannot be stopped
To: qemu-discuss@nongnu.org, qemu-devel@nongnu.org, gdb@sourceware.org
Content-Type: multipart/alternative; boundary="00000000000019a5bf0622ca50be"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=rj2814288312@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 23 Sep 2024 11:05:49 -0400
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

--00000000000019a5bf0622ca50be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, I have a question for help

    I recently  Using ubuntu24.4 system qemu-system-aarch64 +gdb-multiarch
to debug the kernel, setting breakpoints cannot be stopped.

   system information:

        ubuntu version: 22.04

        Debug kernel version:  5.0.0

        qemu version:

=C2=B7 qemu-system-aarch64 --version

=C2=B7 QEMU emulator version 8.2.2 (Debian 1:8.2.2+ds-0ubuntu1.2)

=C2=B7 Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project develop=
ers


gdb version:

=C2=B7 gdb-multiarch --version

=C2=B7 GNU gdb (Ubuntu 15.0.50.20240403-0ubuntu1) 15.0.50.20240403-git

=C2=B7 Copyright (C) 2024 Free Software Foundation, Inc.

=C2=B7 License GPLv3+: GNU GPL version 3 or later <
http://gnu.org/licenses/gpl.html>

=C2=B7 This is free software: you are free to change and redistribute it.

=C2=B7 There is NO WARRANTY, to the extent permitted by law.


Steps to reproduce:

    1. Boot the system using qemu:

1. qemu-system-aarch64 -machine virt -cpu cortex-a57 -machine type=3Dvirt -=
m
1024 -smp 4 -kernel arch/arm64/boot/Image --append "noinitrd root=3D/dev/vd=
a
rw console=3DttyAMA0 loglevel=3D8" -nographic -drive
if=3Dnone,file=3Drootfs_ext4.img,id=3Dhd0 -device virtio-blk-device,drive=
=3Dhd0
--fsdev local,id=3Dkmod_dev,path=3D$PWD/kmodules,security_model=3Dnone -dev=
ice
virtio-9p-device,fsdev=3Dkmod_dev,mount_tag=3Dkmod_mount -S -s


Use gdb-multiarch to connect and debug:


gdb-multiarch vmlinux

(gdb) target remote localhost:1234

Remote debugging using localhost:1234

0x0000000040000000 in ?? ()

(gdb) b start_kernel

Breakpoint 1 at 0xffff2000126704ec: file init/main.c, line 538.

(gdb) c

Continuing.

--00000000000019a5bf0622ca50be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hi, I have a question for help<br>
</p>
<p>=C2=A0=C2=A0=C2=A0 I recently=C2=A0 Using ubuntu24.4 system qemu-system-=
aarch64=20
+gdb-multiarch to debug the kernel, setting breakpoints cannot be=20
stopped.</p>
<p>=C2=A0=C2=A0 system information:</p>
<p>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ubuntu version: 22.04</p>
<p>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Debug kernel version:=C2=A0 <=
span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10.5pt"><font face=
=3D"Calibri">5.0.0</font></span></p>
<p><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10.5pt"><font fa=
ce=3D"Calibri">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu version:=C2=
=A0 </font></span></p>
<p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5pt;margin-lef=
t:36pt"><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10pt">=C2=
=B7=C2=A0</span><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10.=
5pt"><font face=3D"Calibri">qemu-system-aarch64 --version</font></span><spa=
n style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10.5pt"></span></p>
<p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5pt;margin-lef=
t:36pt"><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10pt">=C2=
=B7=C2=A0</span><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10.=
5pt"><font face=3D"Calibri">QEMU emulator version 8.2.2 (Debian 1:8.2.2+ds-=
0ubuntu1.2)</font></span><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font=
-size:10.5pt"></span></p>
<p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5pt;margin-lef=
t:36pt"><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10pt">=C2=
=B7=C2=A0</span><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10.=
5pt"><font face=3D"Calibri">Copyright (c) 2003-2023 Fabrice Bellard and the=
 QEMU Project developers</font></span><span style=3D"font-family:=E5=AE=8B=
=E4=BD=93;font-size:10.5pt"><br>
  </span></p>
<p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5pt;margin-lef=
t:36pt"><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10.5pt"><br=
>
  </span></p>
<p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5pt;margin-lef=
t:36pt"><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10.5pt">gdb=
 version:</span></p>
<p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5pt;margin-lef=
t:36pt"><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10pt">=C2=
=B7=C2=A0</span><span class=3D"gmail-15" style=3D"font-family:=E5=AE=8B=E4=
=BD=93;font-size:10pt"><font face=3D"Courier New">gdb-multiarch --version</=
font></span><span class=3D"gmail-15" style=3D"font-family:=E5=AE=8B=E4=BD=
=93;font-size:10pt"></span></p>
<p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5pt;margin-lef=
t:36pt"><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10pt">=C2=
=B7=C2=A0</span><span class=3D"gmail-15" style=3D"font-family:=E5=AE=8B=E4=
=BD=93;font-size:10pt"><font face=3D"Courier New">GNU gdb (Ubuntu 15.0.50.2=
0240403-0ubuntu1) 15.0.50.20240403-git</font></span><span class=3D"gmail-15=
" style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10pt"></span></p>
<p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5pt;margin-lef=
t:36pt"><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10pt">=C2=
=B7=C2=A0</span><span class=3D"gmail-15" style=3D"font-family:=E5=AE=8B=E4=
=BD=93;font-size:10pt"><font face=3D"Courier New">Copyright (C) 2024 Free S=
oftware Foundation, Inc.</font></span><span class=3D"gmail-15" style=3D"fon=
t-family:=E5=AE=8B=E4=BD=93;font-size:10pt"></span></p>
<p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5pt;margin-lef=
t:36pt"><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10pt">=C2=
=B7=C2=A0</span><span class=3D"gmail-15" style=3D"font-family:=E5=AE=8B=E4=
=BD=93;font-size:10pt"><font face=3D"Courier New">License GPLv3+: GNU GPL v=
ersion 3 or later &lt;<a href=3D"http://gnu.org/licenses/gpl.html">http://g=
nu.org/licenses/gpl.html</a>&gt;</font></span><span class=3D"gmail-15" styl=
e=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10pt"></span></p>
<p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5pt;margin-lef=
t:36pt"><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10pt">=C2=
=B7=C2=A0</span><span class=3D"gmail-15" style=3D"font-family:=E5=AE=8B=E4=
=BD=93;font-size:10pt"><font face=3D"Courier New">This is free software: yo=
u are free to change and redistribute it.</font></span><span class=3D"gmail=
-15" style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10pt"></span></p>
<p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5pt;margin-lef=
t:36pt"><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10pt">=C2=
=B7=C2=A0</span><span class=3D"gmail-15" style=3D"font-family:=E5=AE=8B=E4=
=BD=93;font-size:10pt"><font face=3D"Courier New">There is NO WARRANTY, to =
the extent permitted by law.</font></span></p>
<p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5pt;margin-lef=
t:36pt"><span style=3D"font-family:&quot;Courier New&quot;;font-size:10pt">=
<br></span></p><p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom=
:5pt;margin-left:36pt"><span style=3D"font-family:&quot;Courier New&quot;;f=
ont-size:10pt">Steps to reproduce:</span><br></p>
<p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5pt;margin-lef=
t:36pt"><span class=3D"gmail-15" style=3D"font-family:=E5=AE=8B=E4=BD=93;fo=
nt-size:10pt"><font face=3D"Courier New">=C2=A0 =C2=A0 1. Boot the system u=
sing qemu:=C2=A0=C2=A0 </font></span></p>
<p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5pt;margin-lef=
t:72pt"><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:12pt">1.=C2=
=A0</span><span class=3D"gmail-15" style=3D"font-family:=E5=AE=8B=E4=BD=93;=
font-size:10pt"><font face=3D"Courier New">qemu-system-aarch64
 -machine virt -cpu cortex-a57 -machine type=3Dvirt -m 1024 -smp 4 -kernel
 arch/arm64/boot/Image --append &quot;noinitrd root=3D/dev/vda rw=20
console=3DttyAMA0 loglevel=3D8&quot; -nographic -drive=20
if=3Dnone,file=3Drootfs_ext4.img,id=3Dhd0 -device virtio-blk-device,drive=
=3Dhd0=20
--fsdev local,id=3Dkmod_dev,path=3D$PWD/kmodules,security_model=3Dnone -dev=
ice
 virtio-9p-device,fsdev=3Dkmod_dev,mount_tag=3Dkmod_mount -S -s</font></spa=
n><span class=3D"gmail-15" style=3D"font-family:=E5=AE=8B=E4=BD=93;font-siz=
e:10pt"><br>
  </span></p><p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5=
pt;margin-left:72pt"><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-siz=
e:13.3333px;text-align:-webkit-center"><br></span></p><p class=3D"MsoNormal=
" style=3D"margin-top:5pt;margin-bottom:5pt;margin-left:72pt"><span style=
=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:13.3333px;text-align:-webkit-c=
enter">Use gdb-multiarch to connect and debug:</span><br></p>
<p class=3D"MsoNormal" style=3D"text-align:center;margin-top:5pt;margin-bot=
tom:5pt;margin-left:72pt"><span class=3D"gmail-15" style=3D"font-family:=E5=
=AE=8B=E4=BD=93;font-size:10pt"><br>
  </span></p>
<p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5pt;margin-lef=
t:72pt"><span class=3D"gmail-15" style=3D"font-family:&quot;Courier New&quo=
t;;font-size:10pt">gdb-multiarch vmlinux</span><span style=3D"font-family:C=
alibri;font-size:10.5pt"></span></p>
<p class=3D"MsoNormal" align=3D"justify" style=3D"margin-top:5pt;margin-bot=
tom:5pt;margin-left:42pt;text-indent:21pt;text-align:justify"><span style=
=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10.5pt"><font face=3D"Calibri"=
>(gdb) target remote localhost:1234</font></span><span style=3D"font-family=
:=E5=AE=8B=E4=BD=93;font-size:10.5pt"></span></p>
<p class=3D"MsoNormal" align=3D"justify" style=3D"margin-top:5pt;margin-bot=
tom:5pt;margin-left:42pt;text-indent:21pt;text-align:justify"><span style=
=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10.5pt"><font face=3D"Calibri"=
>Remote debugging using localhost:1234</font></span><span style=3D"font-fam=
ily:=E5=AE=8B=E4=BD=93;font-size:10.5pt"></span></p>
<p class=3D"MsoNormal" align=3D"justify" style=3D"margin-top:5pt;margin-bot=
tom:5pt;margin-left:42pt;text-indent:21pt;text-align:justify"><span style=
=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10.5pt"><font face=3D"Calibri"=
>0x0000000040000000 in ?? ()</font></span><span style=3D"font-family:=E5=AE=
=8B=E4=BD=93;font-size:10.5pt"></span></p>
<p class=3D"MsoNormal" align=3D"justify" style=3D"margin-top:5pt;margin-bot=
tom:5pt;margin-left:42pt;text-indent:21pt;text-align:justify"><span style=
=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10.5pt"><font face=3D"Calibri"=
>(gdb) b start_kernel</font></span><span style=3D"font-family:=E5=AE=8B=E4=
=BD=93;font-size:10.5pt"></span></p>
<p class=3D"MsoNormal" align=3D"justify" style=3D"margin-top:5pt;margin-bot=
tom:5pt;margin-left:42pt;text-indent:21pt;text-align:justify"><span style=
=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10.5pt"><font face=3D"Calibri"=
>Breakpoint 1 at 0xffff2000126704ec: file init/main.c, line 538.</font></sp=
an><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10.5pt"></span><=
/p>
<p class=3D"MsoNormal" align=3D"justify" style=3D"margin-top:5pt;margin-bot=
tom:5pt;margin-left:42pt;text-indent:21pt;text-align:justify"><span style=
=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10.5pt"><font face=3D"Calibri"=
>(gdb) c</font></span><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-si=
ze:10.5pt"></span></p>
<p class=3D"MsoNormal" align=3D"justify" style=3D"margin-top:5pt;margin-bot=
tom:5pt;margin-left:42pt;text-indent:21pt;text-align:justify"><span style=
=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10.5pt"><font face=3D"Calibri"=
>Continuing.</font></span><span style=3D"font-family:=E5=AE=8B=E4=BD=93;fon=
t-size:10.5pt"></span></p>
<p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5pt;margin-lef=
t:72pt"></p>
<p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5pt;margin-lef=
t:36pt"><span class=3D"gmail-15" style=3D"font-family:=E5=AE=8B=E4=BD=93;fo=
nt-size:10pt"></span></p>
<p class=3D"MsoNormal" style=3D"margin-top:5pt;margin-bottom:5pt;margin-lef=
t:36pt"><span style=3D"font-family:=E5=AE=8B=E4=BD=93;font-size:10.5pt"><br=
>
</span></p>
<p></p>
<p></p>
<p>=C2=A0 =C2=A0=C2=A0</p></div>

--00000000000019a5bf0622ca50be--

