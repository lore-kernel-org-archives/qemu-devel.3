Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B9DC83F17
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Jul 2025 14:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufg1p-00039J-RZ; Sat, 26 Jul 2025 10:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <muhammadievsamandar2@gmail.com>)
 id 1ufebU-00027o-FM
 for qemu-devel@nongnu.org; Sat, 26 Jul 2025 09:06:21 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <muhammadievsamandar2@gmail.com>)
 id 1ufebS-0007XV-FN
 for qemu-devel@nongnu.org; Sat, 26 Jul 2025 09:06:20 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-73e586fcc28so1998862a34.0
 for <qemu-devel@nongnu.org>; Sat, 26 Jul 2025 06:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753535175; x=1754139975; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zhR1Uexy719pKeaIHTRmdY8v/5/DE15ebRJKKzQ6G5Y=;
 b=GeVqqEgyW/pOPsVp/g+NXNOa9r8NQO98lQxOQoLVYpBVBGTZA7vzcjm3H3uGx3Db/s
 OKpLWYkA0R29vdd++Up6avRMZZWDzqTEis5pFH6KoJm5hURJGVjGORxUc3Px5tRRx4bh
 kIO/xHPHNehhYR9gaJkdWVigwfPhj1E8QbR4y0VCvZ7slK2ncLbdaNK3zeEup0QnhDo7
 g/du/HSkmxQ3DH0uwEJsNnV+K2NhYQzhwnhUltE++e0eV29RGhFmZJ4fGxtv5QPNU5WA
 CzU419KB9uAcm4l1QXOYxs4pEYmWhU46piEREPvC1A2tPeferFfvRSsxV6WL8kfj9sGS
 sr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753535175; x=1754139975;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zhR1Uexy719pKeaIHTRmdY8v/5/DE15ebRJKKzQ6G5Y=;
 b=W0+XOLcJP+AFTGEoBlJE1kHGSlAuMx+EnP7ztIfyCdcTdbOWKtdK5i0jSiDtK3ca8o
 nhv6KEYET+hPSfVyKIAG62sRY/yd/kLhubCZ2pbIxIDq0Gw152sGLOSlRfaFul0oSSja
 VK3G+HQ3dD0V6s0GtTK5ZTz326yCxq/63GlItQxpJgzJEU0w0iwuunVdCmrBAhKqHGh3
 3HCkY9viRLHPDAXZLlOeGkXUuxYEuJ20ciYiA0mmDplg8yOOCObmH/Md9fb+Bi4uAFie
 6DIIFgycNa/A6xeDtdYNswOdHZ85ZRDZL2GCEkh+uFuTsU+sj/jHxg+WTkfnCkF3pY/v
 RsEw==
X-Gm-Message-State: AOJu0YxHaT0FeBrc1i2Am1FJ4Zem4R0ecEX7gzlDvSM3IvzlXaQMcZPm
 I+L6hmJNZ00m2oa7cUuyKL/SiemI1OqZaS2Ca1APiWl5y0q6LDS+zUHfvw54ZQAHC+fWwm6wyH2
 7Vs34EPATvc0kFE7Noe+YeYmr5zs0vbZ505p8XNZXxQ==
X-Gm-Gg: ASbGncsHkG6hhlZ71BbuxFOQaXm1QrYfsfQiMX7xSqPyotKVH1BY3YyOGO7QMHU+VCg
 zqg1cieTgEVuiw0VLFfsHw0ib5ED5cEveSvEzq2SeiE/X58RJxsriPmhvIjRRUKTKwbIjFyj0BY
 eonQkt9SY7cq9Iu/foOgkEh0tO8dVsWNOOIEPinavtp+orNoQaCuDXqLcFmI5sN07/Xi9FjUBQx
 8Ee07+/
X-Google-Smtp-Source: AGHT+IGDraJifQ5QxtMGBs7kR6IOKHTFVpc0o7xw7siV7v0sxcBoMktA81jlIsmrSnzY/4T9nMm7ljdnLE0jzjYztVA=
X-Received: by 2002:a05:6808:4f22:b0:40b:9527:8e9b with SMTP id
 5614622812f47-42a5643bad5mr4475821b6e.7.1753535174568; Sat, 26 Jul 2025
 06:06:14 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?0KHQsNC80LDQvQ==?= <muhammadievsamandar2@gmail.com>
Date: Sat, 26 Jul 2025 18:06:03 +0500
X-Gm-Features: Ac12FXziVzS3xbBkEg2BWAwJEAFGUhlx-8jYeav0Ai_RUyn1wmFUrGD2_pnMm2I
Message-ID: <CAHqnKtft5rsBcc5A7ARVHL+YE_YQixoY2V3TTRKK1bbOoij8Vg@mail.gmail.com>
Subject: =?UTF-8?Q?How_to_fully_hide_QEMU_VM_from_detection_=28BIOSVersio?=
 =?UTF-8?Q?n_still_exposes_=E2=80=9CBOCHS=E2=80=9D_and_=E2=80=9CEDK_II=E2=80=9D=29?=
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002e6d81063ad4b9a7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=muhammadievsamandar2@gmail.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 26 Jul 2025 10:37:35 -0400
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

--0000000000002e6d81063ad4b9a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear QEMU developers,

I hope this message finds you well.

My goal is to run a Windows virtual machine in such a way that software
like Safe Exam Browser (SEB) cannot detect that it=E2=80=99s running inside=
 a
virtual machine.

Currently, I=E2=80=99m using QEMU with virt-manager on Arch Linux to run a =
Windows
10 guest. I want to hide **all** virtualization traces =E2=80=94 including =
BIOS
strings and firmware signatures.

The only remaining field that still exposes the VM is the BIOS version
string. When running the following command inside the Windows guest:

    wmic bios get BIOSVersion

I get the output:

    BIOSVersion
    {"BOCHS  - 1", "unknown", "EDK II" - 10000"}

The presence of =E2=80=9CBOCHS=E2=80=9D and =E2=80=9CEDK II=E2=80=9D are st=
rong indicators of
virtualization and are easily detected.

Here is what I=E2=80=99ve already done:

1. Modified the libvirt XML configuration.
2. Built my own `OVMF_CODE.fd` and `OVMF_VARS.fd` using the
[tianocore/edk2](https://github.com/tianocore/edk2) repository. I removed
all references to BOCHS and EDK inside the firmware.
3. Installed a clean Windows 11 system via ISO in this customized
environment.

I switched to QEMU because VMware and VirtualBox don=E2=80=99t offer deep e=
nough
control over SMBIOS or firmware =E2=80=94 e.g., `SMBIOS.reflectHost =3D "TR=
UE"`
doesn=E2=80=99t help.

This is my first time working this deeply with VMs, and despite days of
effort, I still haven=E2=80=99t succeeded. I=E2=80=99m reaching out to the =
experts here in
hopes that you might point me in the right direction or offer a better
method for achieving full VM concealment.

For your convenience, I=E2=80=99ve uploaded all the relevant files and deta=
ils
[here](https://t.me/qemuvmwin10) for further inspection.

Thank you so much for your time and for maintaining such a powerful project=
.

Best regards,
Mukhammadiev Samandar

--0000000000002e6d81063ad4b9a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear QEMU developers,<br><br>I hope this message finds you=
 well.<br><br>My goal is to run a Windows virtual machine in such a way tha=
t software like Safe Exam Browser (SEB) cannot detect that it=E2=80=99s run=
ning inside a virtual machine.<br><br>Currently, I=E2=80=99m using QEMU wit=
h virt-manager on Arch Linux to run a Windows 10 guest. I want to hide **al=
l** virtualization traces =E2=80=94 including BIOS strings and firmware sig=
natures.<br><br>The only remaining field that still exposes the VM is the B=
IOS version string. When running the following command inside the Windows g=
uest:<br><br>=C2=A0 =C2=A0 wmic bios get BIOSVersion<br><br>I get the outpu=
t:<br><br>=C2=A0 =C2=A0 BIOSVersion<br>=C2=A0 =C2=A0 {&quot;BOCHS =C2=A0- 1=
&quot;, &quot;unknown&quot;, &quot;EDK II&quot; - 10000&quot;}<br><br>The p=
resence of =E2=80=9CBOCHS=E2=80=9D and =E2=80=9CEDK II=E2=80=9D are strong =
indicators of virtualization and are easily detected.<br><br>Here is what I=
=E2=80=99ve already done:<br><br>1. Modified the libvirt XML configuration.=
<br>2. Built my own `OVMF_CODE.fd` and `OVMF_VARS.fd` using the [tianocore/=
edk2](<a href=3D"https://github.com/tianocore/edk2">https://github.com/tian=
ocore/edk2</a>) repository. I removed all references to BOCHS and EDK insid=
e the firmware.<br>3. Installed a clean Windows 11 system via ISO in this c=
ustomized environment.<br><br>I switched to QEMU because VMware and Virtual=
Box don=E2=80=99t offer deep enough control over SMBIOS or firmware =E2=80=
=94 e.g., `SMBIOS.reflectHost =3D &quot;TRUE&quot;` doesn=E2=80=99t help.<b=
r><br>This is my first time working this deeply with VMs, and despite days =
of effort, I still haven=E2=80=99t succeeded. I=E2=80=99m reaching out to t=
he experts here in hopes that you might point me in the right direction or =
offer a better method for achieving full VM concealment.<br><br>For your co=
nvenience, I=E2=80=99ve uploaded all the relevant files and details [here](=
<a href=3D"https://t.me/qemuvmwin10">https://t.me/qemuvmwin10</a>) for furt=
her inspection.<br><br>Thank you so much for your time and for maintaining =
such a powerful project.<br><br>Best regards, =C2=A0<br>Mukhammadiev Samand=
ar<br></div>

--0000000000002e6d81063ad4b9a7--

