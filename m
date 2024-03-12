Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87477C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 10:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjzV8-00043A-6x; Tue, 12 Mar 2024 06:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjzV4-00042c-Ag; Tue, 12 Mar 2024 06:36:50 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjzV0-00076p-FG; Tue, 12 Mar 2024 06:36:50 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dd10a37d68so46095415ad.2; 
 Tue, 12 Mar 2024 03:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710239805; x=1710844605; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/feAvFsiQEEYbBfbw2VoGB58BoW/awLOfmKBRsXW+s=;
 b=gaQ6kYDlWbWPreK5pAbj1O+1visStydGI0uNUlU3SZVFAofSNBGXzZjmCSNdoJPm3N
 /WnypPLMBNWjNPkgrhNaS3ZqQt3rv7tpkhpRpbPGx5xuo7d0yKvqdhBOwF9D0FaqHNzP
 ll7+eqd7td4UEXTGxORkuNREkya9t2HKUmE6VKoNlgb/TFJA7u5B3mVJfCeXmtfSkUvP
 zQ7UBmcNjDCSDOWSnSeo56XGt+3nAgx221p/HkyK613FFC2Au1FtElXeslBozoGnsINv
 VZalSUKk5tdr4DWM47cEds/YhCa065KuapTOklAI72u+vTp/WloCoPSU2T2eAkQyRBIF
 eeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710239805; x=1710844605;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=N/feAvFsiQEEYbBfbw2VoGB58BoW/awLOfmKBRsXW+s=;
 b=TgEA5iWYZ4mhsWGxEPaZEY+6U5jhnL0N5oxSTRJRL+wI9aOZ2FUJWwcs8sNX5c/XyN
 fc1JPgN4uyhyA3KRiXbJQYXvPgFnGwbZVwysO4KPXZERnD+ZiSi9ff7D7iRGMPWcKO7D
 FEmQySqwHIxb1Si8L1OBb8cwMaHT7/6Gd5He5gPNoUO81zHh9ssAX5YvWbiQISBLFLFZ
 C1E4voRmEWNcKXC+RLHxCQt5g0ecdmqxdGGh+CUYgpP3Y6bkSC9qGlTFXWLmRRRi9sp5
 LSrXTcuzPR2BIG0Q1T2gVSY/7qeHp171B80WLW+rgKd734g/b8+wqPxLwWcWc3whGALc
 OF6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy+xswr+zsJCRunJQYRVrnSEzQGdG2BYJyC26wkOroD5Fu55M1pxTISFMdtEM/57BpusLi5DXWYZ0iKfIQhK3Ji3Nx94iQtrm7XpW2v5WoK/VwLll0mYozVq8=
X-Gm-Message-State: AOJu0YyZbQaut/y3smJ2TY1HDY/ojuZqAmrL/6qn7h8462K+CGIWo4HE
 +W7GokKaxhKSPq2+2NARJ4SYkyulGsTdp4Otcx6oDrd459Rho1NC
X-Google-Smtp-Source: AGHT+IFgNZ/pAfaLbH2iMa9g0DYLiSpmEfmVKJSlsON7EcO9+kkyouQaomQZKgDsWDj8oWldGHVmng==
X-Received: by 2002:a17:902:7c07:b0:1dd:6211:e26 with SMTP id
 x7-20020a1709027c0700b001dd62110e26mr6855371pll.15.1710239804513; 
 Tue, 12 Mar 2024 03:36:44 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 a15-20020a170902eccf00b001dcf91da5c8sm184186plh.95.2024.03.12.03.36.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 03:36:44 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 20:36:39 +1000
Message-Id: <CZRPETJSO62V.5YV22F323JKC@wheely>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, <clg@kaod.org>
Subject: Re: [PATCH v3] docs/system/ppc: Document running Linux on AmigaNG
 machines
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Bernhard Beschow" <shentey@gmail.com>, "BALATON Zoltan"
 <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240220232200.042DA4E6005@zero.eik.bme.hu>
 <c9dc84be-c7bf-c676-491b-2c6b1164d502@eik.bme.hu>
 <a9814b1b-98d7-29d8-36f9-228f20206917@eik.bme.hu>
 <3E4E29CA-AE91-4C8D-BB51-B3759CF3110F@gmail.com>
In-Reply-To: <3E4E29CA-AE91-4C8D-BB51-B3759CF3110F@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Mar 12, 2024 at 7:28 PM AEST, Bernhard Beschow wrote:
>
>
> Am 9. M=C3=A4rz 2024 11:34:56 UTC schrieb BALATON Zoltan <balaton@eik.bme=
.hu>:
> >On Thu, 29 Feb 2024, BALATON Zoltan wrote:
> >> On Wed, 21 Feb 2024, BALATON Zoltan wrote:
> >>> Documentation on how to run Linux on the amigaone, pegasos2 and
> >>> sam460ex machines is currently buried in the depths of the qemu-devel
> >>> mailing list and in the source code. Let's collect the information in
> >>> the QEMU handbook for a one stop solution.
> >>=20
> >> Ping? (Just so it's not missed from next pull.)
> >
> >Ping for freeze.
>
> Has this patch been tagged yet? It would really be a pity if it didn't ma=
ke it into 9.0.

Will send out a PR today and I'll include it.

>
> FWIW:
>
> Reviewed-by: Bernhard Beschow <shentey@gmail.com>

Thanks, always helpful.

Thanks,
Nick

>
> >
> >> Regards,
> >> BALATON Zoltan
> >>=20
> >>> Co-authored-by: Bernhard Beschow <shentey@gmail.com>
> >>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> >>> Tested-by: Bernhard Beschow <shentey@gmail.com>
> >>> ---
> >>> v3: Apply changes and Tested-by tag from Bernhard
> >>> v2: Move top level title one level up so subsections will be below it=
 in TOC
> >>>=20
> >>> MAINTAINERS                 |   1 +
> >>> docs/system/ppc/amigang.rst | 161 +++++++++++++++++++++++++++++++++++=
+
> >>> docs/system/target-ppc.rst  |   1 +
> >>> 3 files changed, 163 insertions(+)
> >>> create mode 100644 docs/system/ppc/amigang.rst
> >>>=20
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index 7d61fb9319..0aef8cb2a6 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -1562,6 +1562,7 @@ F: hw/rtc/m41t80.c
> >>> F: pc-bios/canyonlands.dt[sb]
> >>> F: pc-bios/u-boot-sam460ex-20100605.bin
> >>> F: roms/u-boot-sam460ex
> >>> +F: docs/system/ppc/amigang.rst
> >>>=20
> >>> pegasos2
> >>> M: BALATON Zoltan <balaton@eik.bme.hu>
> >>> diff --git a/docs/system/ppc/amigang.rst b/docs/system/ppc/amigang.rs=
t
> >>> new file mode 100644
> >>> index 0000000000..ba1a3d80b9
> >>> --- /dev/null
> >>> +++ b/docs/system/ppc/amigang.rst
> >>> @@ -0,0 +1,161 @@
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +AmigaNG boards (``amigaone``, ``pegasos2``, ``sam460ex``)
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +These PowerPC machines emulate boards that are primarily used for
> >>> +running Amiga like OSes (AmigaOS 4, MorphOS and AROS) but these can
> >>> +also run Linux which is what this section documents.
> >>> +
> >>> +Eyetech AmigaOne/Mai Logic Teron (``amigaone``)
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +The ``amigaone`` machine emulates an AmigaOne XE mainboard by Eyetec=
h
> >>> +which is a rebranded Mai Logic Teron board with modified U-Boot
> >>> +firmware to support AmigaOS 4.
> >>> +
> >>> +Emulated devices
> >>> +----------------
> >>> +
> >>> + * PowerPC 7457 CPU (can also use``-cpu g3, 750cxe, 750fx`` or ``750=
gx``)
> >>> + * Articia S north bridge
> >>> + * VIA VT82C686B south bridge
> >>> + * PCI VGA compatible card (guests may need other card instead)
> >>> + * PS/2 keyboard and mouse
> >>> +
> >>> +Firmware
> >>> +--------
> >>> +
> >>> +A firmware binary is necessary for the boot process. It is a modifie=
d
> >>> +U-Boot under GPL but its source is lost so it cannot be included in
> >>> +QEMU. A binary is available at
> >>> +https://www.hyperion-entertainment.com/index.php/downloads?view=3Dfi=
les&parent=3D28.
> >>> +The ROM image is in the last 512kB which can be extracted with the
> >>> +following command:
> >>> +
> >>> +.. code-block:: bash
> >>> +
> >>> +  $ tail -c 524288 updater.image > u-boot-amigaone.bin
> >>> +
> >>> +The BIOS emulator in the firmware is unable to run QEMU=E2=80=98s st=
andard
> >>> +vgabios so ``VGABIOS-lgpl-latest.bin`` is needed instead which can b=
e
> >>> +downloaded from http://www.nongnu.org/vgabios.
> >>> +
> >>> +Running Linux
> >>> +-------------
> >>> +
> >>> +There are some Linux images under the following link that work on th=
e
> >>> +``amigaone`` machine:
> >>> +https://sourceforge.net/projects/amigaone-linux/files/debian-install=
er/.
> >>> +To boot the system run:
> >>> +
> >>> +.. code-block:: bash
> >>> +
> >>> +  $ qemu-system-ppc -machine amigaone -bios u-boot-amigaone.bin \
> >>> +                    -cdrom "A1 Linux Net Installer.iso" \
> >>> +                    -device ati-vga,model=3Drv100,romfile=3DVGABIOS-=
lgpl-latest.bin
> >>> +
> >>> +From the firmware menu that appears select ``Boot sequence`` =E2=86=
=92
> >>> +``Amiga Multiboot Options`` and set ``Boot device 1`` to
> >>> +``Onboard VIA IDE CDROM``. Then hit escape until the main screen app=
ears again,
> >>> +hit escape once more and from the exit menu that appears select eith=
er
> >>> +``Save settings and exit`` or ``Use settings for this session only``=
. It may
> >>> +take a long time loading the kernel into memory but eventually it bo=
ots and the
> >>> +installer becomes visible. The ``ati-vga`` RV100 emulation is not
> >>> +complete yet so only frame buffer works, DRM and 3D is not available=
.
> >>> +
> >>> +Genesi/bPlan Pegasos II (``pegasos2``)
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +The ``pegasos2`` machine emulates the Pegasos II sold by Genesi and
> >>> +designed by bPlan. Its schematics are available at
> >>> +https://www.powerdeveloper.org/platforms/pegasos/schematics.
> >>> +
> >>> +Emulated devices
> >>> +----------------
> >>> +
> >>> + * PowerPC 7457 CPU (can also use``-cpu g3`` or ``750cxe``)
> >>> + * Marvell MV64361 Discovery II north bridge
> >>> + * VIA VT8231 south bridge
> >>> + * PCI VGA compatible card (guests may need other card instead)
> >>> + * PS/2 keyboard and mouse
> >>> +
> >>> +Firmware
> >>> +--------
> >>> +
> >>> +The Pegasos II board has an Open Firmware compliant ROM based on
> >>> +SmartFirmware with some changes that are not open-sourced therefore
> >>> +the ROM binary cannot be included in QEMU. An updater was available
> >>> +from bPlan, it can be found in the `Internet Archive
> >>> +<http://web.archive.org/web/20071021223056/http://www.bplan-gmbh.de/=
up050404/up050404>`_.
> >>> +The ROM image can be extracted from it with the following command:
> >>> +
> >>> +.. code-block:: bash
> >>> +
> >>> +  $ tail -c +85581 up050404 | head -c 524288 > pegasos2.rom
> >>> +
> >>> +Running Linux
> >>> +-------------
> >>> +
> >>> +The PowerPC version of Debian 8.11 supported Pegasos II. The BIOS
> >>> +emulator in the firmware binary is unable to run QEMU=E2=80=98s stan=
dard
> >>> +vgabios so it needs to be disabled. To boot the system run:
> >>> +
> >>> +.. code-block:: bash
> >>> +
> >>> +  $ qemu-system-ppc -machine pegasos2 -bios pegasos2.rom \
> >>> +                    -cdrom debian-8.11.0-powerpc-netinst.iso \
> >>> +                    -device VGA,romfile=3D"" -serial stdio
> >>> +
> >>> +At the firmware ``ok`` prompt enter ``boot cd install/pegasos``.
> >>> +
> >>> +Alternatively, it is possible to boot the kernel directly without
> >>> +firmware ROM using the QEMU built-in minimal Virtual Open Firmware
> >>> +(VOF) emulation which is also supported on ``pegasos2``. For this,
> >>> +extract the kernel ``install/powerpc/vmlinuz-chrp.initrd`` from the =
CD
> >>> +image, then run:
> >>> +
> >>> +.. code-block:: bash
> >>> +
> >>> +  $ qemu-system-ppc -machine pegasos2 -serial stdio \
> >>> +                    -kernel vmlinuz-chrp.initrd -append "---" \
> >>> +                    -cdrom debian-8.11.0-powerpc-netinst.iso
> >>> +
> >>> +aCube Sam460ex (``sam460ex``)
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +The ``sam460ex`` machine emulates the Sam460ex board by aCube which =
is
> >>> +based on the AMCC PowerPC 460EX SoC (that despite its name has a
> >>> +PPC440 CPU core).
> >>> +
> >>> +Firmware
> >>> +--------
> >>> +
> >>> +The board has a firmware based on an older U-Boot version with
> >>> +modifications to support booting AmigaOS 4. The firmware ROM is
> >>> +included with QEMU.
> >>> +
> >>> +Emulated devices
> >>> +----------------
> >>> +
> >>> + * PowerPC 460EX SoC
> >>> + * M41T80 serial RTC chip
> >>> + * Silicon Motion SM501 display parts (identical to SM502 on real bo=
ard)
> >>> + * Silicon Image SiI3112 2 port SATA controller
> >>> + * USB keyboard and mouse
> >>> +
> >>> +Running Linux
> >>> +-------------
> >>> +
> >>> +The only Linux distro that supported Sam460ex out of box was CruxPPC
> >>> +2.x. It can be booted by running:
> >>> +
> >>> +.. code-block:: bash
> >>> +
> >>> +  $ qemu-system-ppc -machine sam460ex -serial stdio \
> >>> +                    -drive if=3Dnone,id=3Dcd,format=3Draw,file=3Dcru=
x-ppc-2.7a.iso \
> >>> +                    -device ide-cd,drive=3Dcd,bus=3Dide.1
> >>> +
> >>> +There are some other kernels and instructions for booting other
> >>> +distros on aCube's product page at
> >>> +https://www.acube-systems.biz/index.php?page=3Dhardware&pid=3D5
> >>> +but those are untested.
> >>> diff --git a/docs/system/target-ppc.rst b/docs/system/target-ppc.rst
> >>> index 4f6eb93b17..87bf412ce5 100644
> >>> --- a/docs/system/target-ppc.rst
> >>> +++ b/docs/system/target-ppc.rst
> >>> @@ -17,6 +17,7 @@ help``.
> >>> .. toctree::
> >>>    :maxdepth: 1
> >>>=20
> >>> +   ppc/amigang
> >>>    ppc/embedded
> >>>    ppc/powermac
> >>>    ppc/powernv
> >>


