Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C59CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 06:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vANLu-0005iq-Nh; Sun, 19 Oct 2025 02:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1vANLj-0005iR-OG
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 02:57:06 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1vANLh-0008AI-5U
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 02:57:03 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-430d04de73fso695965ab.0
 for <qemu-devel@nongnu.org>; Sat, 18 Oct 2025 23:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760857018; x=1761461818; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l8NCTsexsuE/QRcC22pAJHuheJFNXbRo5G9onhkwPRQ=;
 b=QWkQmrtbCgjR8UnQkfrEN7GX/qx8+Z0FeFGFg2Fc3ISx9to1E/Bl1Q2Ax8HIOaDCF/
 hl3edAnSiLc2prhIUn1UpfuEIKaTgd+mWM4e1JS4IqehGUBO2ludbQ9aumj+qyC6wAEN
 jdoI5P7IRE3W2mUQnmZXpjYwVQw5pV09Lg36fwVw4JcLvYSk+cwQmZOBXHWeTTr9qLtZ
 jz+P4UEaHSb2iMSBIUw8wOQnJsmWva8jgmOl4KLcUA/jKOxLRsq/RoaDl4TT+UMsER0E
 4wR5TvA0PYhMdd2tANt52KS6nUOMCj8A9EjHQPlBy6i65+nPcIqspec6HJd/NtehkhGB
 yYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760857018; x=1761461818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l8NCTsexsuE/QRcC22pAJHuheJFNXbRo5G9onhkwPRQ=;
 b=YYX0SWDakxnXYrgB6xODuFsD5oYQeEooDG1P0V4ZspHpoMegipM/dosuqYkse3/GfX
 ueagVsPZxHhzcicq7i6eNDTOk6hS+HQxQxTxUpXQYzvyXmv8mHgXJ9r0xGbXOgwbgXpa
 bVisfUNC3sRJvuBL7ATE6sG8GBikqIcUqKLyG6yn0JIZvZIxwrLRw+2++AbIgRkxFBUB
 AC3lRs6T0WciQKMDgpJpSQ7E44JbIH2YcX4Ufo8dm3vsQlwUYxGYaKsztn9LoqW94Nl4
 p3+YfWiAg1mn7oDv6PnmUKLLOpqthZ2NJwKNu+BmGXHz70HkLPBbtZ9jmi1FWxiF0A8y
 pahg==
X-Gm-Message-State: AOJu0Yy2BqLlekB13SnurLZ1wdS58FKYBdZT99Y6j5iR1zz1wNwvm6wI
 eVpYDWu4mOiucUKTk7d1r5sdKjuI8u6A10SymORB8546ffnp9RtbVBJrPlUNpqcGww3xOUcpuU1
 1oG+QqaAbg7Xb7Xq22Zu0Aj0mMKRwBUY=
X-Gm-Gg: ASbGnct8HlNe0rQMtIgKQ53pLLS6HaBEPmIR2/YHsuLxtVmGWRdTlXUS7AIglmljqgM
 JpHNw7/XY5L7GYSfwFhMwwssgDyiGm2x5shKCfwrRwybKBXZF1Ydq2xKR3t+h29w1zDVYfcZeVZ
 BfFvbPgUPmiym/3/VqsNU4Ha0Ron/61L9+gOFG3VwbdpeTHbTLRul6rt4N9q8JNLSunJymQDPwY
 3AjY2FsrUurjcnt5Cr/QRbfxFw+AuoOnTTN6p8s5i4M9WFFN8V90fbSnsbB0lxZuBFWTq6gcyNK
 A9m5K2UK/PAMmmlBpPp4oyr8pcU=
X-Google-Smtp-Source: AGHT+IGEgMHe2YciGXS/TuLknjszD0GcsSLGL/S+tsqqCqXlrqy9pNhojYwZ1IaNFfghC7OKB618ut+1++f/RHOGtj0=
X-Received: by 2002:a05:6e02:491a:b0:430:a8d0:725c with SMTP id
 e9e14a558f8ab-430c52bec72mr45790275ab.5.1760857017886; Sat, 18 Oct 2025
 23:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1760798392.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1760798392.git.balaton@eik.bme.hu>
From: Yogesh Vyas <yvyas1991@gmail.com>
Date: Sun, 19 Oct 2025 12:26:46 +0530
X-Gm-Features: AS18NWC_w57trqnZZ3ZqEpaS_MqqUFHFwtxFnSt35vdtYcZNeeHGVGseV14FjxY
Message-ID: <CAJOT6qN-n7LpVnLO-5CpOUF8z-j1Ogi=6cJBvvKZc-Eh5tHVzA@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] Pegasos2 clean up and pegasos1 emulation
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: multipart/alternative; boundary="0000000000000d29e306417d792b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=yvyas1991@gmail.com; helo=mail-il1-x130.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000000d29e306417d792b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi BALATON,

I tested this series with the provided patches and observed the following:

When I run QEMU with the ROM option, the machine boots successfully with
the below command:

qemu-system-ppc64 -machine pegasos2 -bios pegasos2.rom \
                  -cdrom debian-8.11.0-powerpc-netinst.iso \
                  -device VGA,romfile=3D"" -serial stdio

However, when I try to boot the machine without the ROM using VOF, the
machine does not come up and no logs appear on stdout:

qemu-system-ppc64 -machine pegasos2 -serial stdio \
                  -kernel vmlinuz-chrp.initrd -append "---" \
                  -cdrom debian-8.11.0-powerpc-netinst.iso

Please let me know if I am missing any parameters or setup required for
booting via VOF on Pegasos2.

Documentation referred: qemu/docs/system/ppc/amigang.rst

Regards,
Yogesh Vyas

On Sat, Oct 18, 2025 at 8:44=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:

> This series changes how the fdt for VOF is generated in pegasos2 by
> moving the static parts to a dtb and only generate the changing parts
> such as memory size and PCI devices programmatically. This simplifies
> the code and allows simply adding emulation of Pegasos I which has a
> different north bridge and slightly different memory map but otherwise
> very similar and can be emulated by reusing parts from the amigaone
> machine. The machine was tested with a Pegasos I ROM image and MorphOS.
>
> The first VOF patch (submitted separetely before, the reviewed v3 is
> included here) fixes handling the name property in VOF that cannot be
> represented in a dts as that always takes the path as the name and
> cannot accept an explicit name property but we need the name property
> to appear when guest queries properties which previously was worked
> around by adding it to every node.
>
> The series also adds an extended DEFINE_MACHINE macro that is later
> used for more easily define the abstract machine type and hide most of
> the QOM boiler plate.
>
> Regards,
> BALATON Zoltan
>
> Link to previous version:
> https://patchew.org/QEMU/cover.1751494995.git.balaton@eik.bme.hu/
>
> v3:
> - rebase on master
>
> v2:
> - rebase on master
> - added some R-b tags from Philippe
> - move first patch later (was first to allow merging separately)
> - clarify blurb above
>
> BALATON Zoltan (13):
>   ppc/vof: Make nextprop behave more like Open Firmware
>   hw/ppc/pegasos2: Remove explicit name properties from device tree
>   hw/ppc/pegasos2: Change device tree generation
>   hw/ppc/pegasos2: Remove fdt pointer from machine state
>   hw/ppc/pegasos2: Rename mv field in machine state
>   hw/ppc/pegasos2: Add south bridge pointer in the machine state
>   hw/ppc/pegasos2: Move PCI IRQ routing setup to a function
>   hw/ppc/pegasos2: Move hardware specific parts out of machine reset
>   hw/ppc/pegasos2: Introduce abstract superclass
>   hw/ppc/pegasos2: Add bus frequency to machine state
>   hw/boards: Extend DEFINE_MACHINE macro to cover more use cases
>   hw/ppc/pegasos2: Add Pegasos I emulation
>   hw/ppc/pegasos2: Add VOF support for pegasos1
>
>  MAINTAINERS              |   1 +
>  hw/ppc/pegasos2.c        | 770 +++++++++++++++++++--------------------
>  hw/ppc/vof.c             |  50 ++-
>  include/hw/boards.h      |  16 +-
>  pc-bios/dtb/meson.build  |   2 +
>  pc-bios/dtb/pegasos1.dtb | Bin 0 -> 857 bytes
>  pc-bios/dtb/pegasos1.dts | 125 +++++++
>  pc-bios/dtb/pegasos2.dtb | Bin 0 -> 1701 bytes
>  pc-bios/dtb/pegasos2.dts | 167 +++++++++
>  9 files changed, 718 insertions(+), 413 deletions(-)
>  create mode 100644 pc-bios/dtb/pegasos1.dtb
>  create mode 100644 pc-bios/dtb/pegasos1.dts
>  create mode 100644 pc-bios/dtb/pegasos2.dtb
>  create mode 100644 pc-bios/dtb/pegasos2.dts
>
> --
> 2.41.3
>
>
>

--0000000000000d29e306417d792b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0BALATON,<div><br></div><div>I tes=
ted this series with the provided patches and observed the following:<br><b=
r>When I run QEMU with the ROM option, the machine boots successfully with =
the below command:<br><br>qemu-system-ppc64 -machine pegasos2 -bios pegasos=
2.rom \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -=
cdrom debian-8.11.0-powerpc-netinst.iso \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -device VGA,romfile=3D&quot;&quot; -seri=
al stdio<br><br>However, when I try to boot the machine without the ROM usi=
ng VOF, the machine does not come up and no logs appear on stdout:<br><br>q=
emu-system-ppc64 -machine pegasos2 -serial stdio \<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -kernel vmlinuz-chrp.initrd -appe=
nd &quot;---&quot; \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 -cdrom debian-8.11.0-powerpc-netinst.iso<br><br>Please let me=
 know if I am missing any parameters or setup required for booting via VOF =
on Pegasos2.<br><br>Documentation referred: qemu/docs/system/ppc/amigang.rs=
t</div><div><br></div><div>Regards,</div><div>Yogesh Vyas</div></div><br><d=
iv class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Sat, Oct 18, 2025 at 8:44=E2=80=AFPM BALATON Zoltan &lt;<a hre=
f=3D"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">This series changes how t=
he fdt for VOF is generated in pegasos2 by<br>
moving the static parts to a dtb and only generate the changing parts<br>
such as memory size and PCI devices programmatically. This simplifies<br>
the code and allows simply adding emulation of Pegasos I which has a<br>
different north bridge and slightly different memory map but otherwise<br>
very similar and can be emulated by reusing parts from the amigaone<br>
machine. The machine was tested with a Pegasos I ROM image and MorphOS.<br>
<br>
The first VOF patch (submitted separetely before, the reviewed v3 is<br>
included here) fixes handling the name property in VOF that cannot be<br>
represented in a dts as that always takes the path as the name and<br>
cannot accept an explicit name property but we need the name property<br>
to appear when guest queries properties which previously was worked<br>
around by adding it to every node.<br>
<br>
The series also adds an extended DEFINE_MACHINE macro that is later<br>
used for more easily define the abstract machine type and hide most of<br>
the QOM boiler plate.<br>
<br>
Regards,<br>
BALATON Zoltan<br>
<br>
Link to previous version:<br>
<a href=3D"https://patchew.org/QEMU/cover.1751494995.git.balaton@eik.bme.hu=
/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU/cover.1751=
494995.git.balaton@eik.bme.hu/</a><br>
<br>
v3:<br>
- rebase on master<br>
<br>
v2:<br>
- rebase on master<br>
- added some R-b tags from Philippe<br>
- move first patch later (was first to allow merging separately)<br>
- clarify blurb above<br>
<br>
BALATON Zoltan (13):<br>
=C2=A0 ppc/vof: Make nextprop behave more like Open Firmware<br>
=C2=A0 hw/ppc/pegasos2: Remove explicit name properties from device tree<br=
>
=C2=A0 hw/ppc/pegasos2: Change device tree generation<br>
=C2=A0 hw/ppc/pegasos2: Remove fdt pointer from machine state<br>
=C2=A0 hw/ppc/pegasos2: Rename mv field in machine state<br>
=C2=A0 hw/ppc/pegasos2: Add south bridge pointer in the machine state<br>
=C2=A0 hw/ppc/pegasos2: Move PCI IRQ routing setup to a function<br>
=C2=A0 hw/ppc/pegasos2: Move hardware specific parts out of machine reset<b=
r>
=C2=A0 hw/ppc/pegasos2: Introduce abstract superclass<br>
=C2=A0 hw/ppc/pegasos2: Add bus frequency to machine state<br>
=C2=A0 hw/boards: Extend DEFINE_MACHINE macro to cover more use cases<br>
=C2=A0 hw/ppc/pegasos2: Add Pegasos I emulation<br>
=C2=A0 hw/ppc/pegasos2: Add VOF support for pegasos1<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A01 +<br>
=C2=A0hw/ppc/pegasos2.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 770 ++++++++++++++++++=
+--------------------<br>
=C2=A0hw/ppc/vof.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5=
0 ++-<br>
=C2=A0include/hw/boards.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 16 +-<br>
=C2=A0pc-bios/dtb/meson.build=C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0pc-bios/dtb/pegasos1.dtb | Bin 0 -&gt; 857 bytes<br>
=C2=A0pc-bios/dtb/pegasos1.dts | 125 +++++++<br>
=C2=A0pc-bios/dtb/pegasos2.dtb | Bin 0 -&gt; 1701 bytes<br>
=C2=A0pc-bios/dtb/pegasos2.dts | 167 +++++++++<br>
=C2=A09 files changed, 718 insertions(+), 413 deletions(-)<br>
=C2=A0create mode 100644 pc-bios/dtb/pegasos1.dtb<br>
=C2=A0create mode 100644 pc-bios/dtb/pegasos1.dts<br>
=C2=A0create mode 100644 pc-bios/dtb/pegasos2.dtb<br>
=C2=A0create mode 100644 pc-bios/dtb/pegasos2.dts<br>
<br>
-- <br>
2.41.3<br>
<br>
<br>
</blockquote></div></div>

--0000000000000d29e306417d792b--

