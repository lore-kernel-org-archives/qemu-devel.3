Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E9CC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 04:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcHgt-0004mE-H6; Mon, 19 Feb 2024 23:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcHgr-0004lm-IS; Mon, 19 Feb 2024 23:25:09 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcHgp-0007Kl-0e; Mon, 19 Feb 2024 23:25:09 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-295c8b795e2so2749589a91.0; 
 Mon, 19 Feb 2024 20:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708403105; x=1709007905; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nGGEiOfgwwsWJwQ5Ybjh0uzMa/9ot07KfPohoRv5J48=;
 b=OF0Maoi9E5FuDq9PGkyxOmSThvHqfZnQY2WNY0oFS0n0E4oM8dX4lBjXs7j4bEr+KV
 sbhnjRvus+3QAGcUpWhgj2OsSkNC/4Hi+CLkXdMWpK9zD0ltt5M5EIMYyTW2dBRpofHO
 ynLAEeqihNIju4i0xPqcX1dj/Rk30sCTY4R+tQhN5aALKGUeq1InXcjeXUPckCMpFh4L
 hqUCntPYm61QE6aHIGensZdROvk4SNv6dPhR50SELAX552hLfQD0H/E+kFW6zgOTW3ac
 Lt0Y2J2wWWc9sRK/NhcF14oMqfGEz56Zu/OcY4PvmXu0qNZTxaaQBmrKDOF8SCaf8sfR
 /jOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708403105; x=1709007905;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nGGEiOfgwwsWJwQ5Ybjh0uzMa/9ot07KfPohoRv5J48=;
 b=sLM+ThsknI7LFQ4EPnN24Gr06yiEN9ue8cFbh7r+b8mOTVXMKsWWowGKQydA63DeMF
 49pp2UjkqyHWbh/LDn4mlqEMbjy3+LCQ7O9oipDQlrRANO02U9KfRL93NZ9ya6qXTzSm
 SMRSBkt16jM53B4i4fRGZN/9JBzVDrt+n0P1Fw3qKQIl38yckuwpCaWFGfHqmd8/5ex7
 d65ayAg9tQ0hH3TJWclrB8mLeppZDnkZxs65ydwDUCoY0295JkDSRXu/3Ht1/tFr1AZd
 18EwK2mKA2KdzfuC9hE1UEpnCyE9q5WC3yXrCFtge8PH6aLHAVngloD6dBxxmQD5DKCS
 vZCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6XraOLXPo1/MbSyS4lrF8Js0PkI4cLT1H2PpZgNp6wO2qrrMrpTjlKRs775EQTj3Shz5V93xxq4V/7kY+/GUJHAR12KhrfcjsMMRBQj06SeOuRW1eVQqP2LE=
X-Gm-Message-State: AOJu0Yxo/r9jcjngTCQtKa7QlBkpZzt/Ql4YfiBrkqnXCOKWQZkTlm42
 QqYQlNz2F/zRIRg3ZhmR5lCrxE9HgE9WleIfG1j/Y1/qdZh4uAIY
X-Google-Smtp-Source: AGHT+IGdvf8Ch3gZlBbLuk11ZgVGqoDWJ+BJH86RcI+LfeDKAVbcZTGd7LUHsG76DQgRUQunGlh3yg==
X-Received: by 2002:a17:90a:f284:b0:299:5fe5:5ec2 with SMTP id
 fs4-20020a17090af28400b002995fe55ec2mr4425249pjb.17.1708403105100; 
 Mon, 19 Feb 2024 20:25:05 -0800 (PST)
Received: from localhost (123-243-155-241.static.tpgi.com.au.
 [123.243.155.241]) by smtp.gmail.com with ESMTPSA id
 n17-20020a17090ade9100b0029937256b91sm6183982pjv.7.2024.02.19.20.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 20:25:04 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Feb 2024 14:24:59 +1000
Message-Id: <CZ9MCTFAU5C0.2FPZF0G932N6O@wheely>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, "Bernhard Beschow"
 <shentey@gmail.com>, <clg@kaod.org>
Subject: Re: [PATCH v2] docs/system/ppc: Document running Linux on AmigaNG
 machines
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240219203006.8AF8F4E6003@zero.eik.bme.hu>
In-Reply-To: <20240219203006.8AF8F4E6003@zero.eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102b.google.com
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

On Tue Feb 20, 2024 at 6:30 AM AEST, BALATON Zoltan wrote:
> Documentation on how to run Linux on the amigaone, pegasos2 and
> sam460ex machines is currently buried in the depths of the qemu-devel
> mailing list and in the source code. Let's collect the information in
> the QEMU handbook for a one stop solution.
>
> Co-authored-by: Bernhard Beschow <shentey@gmail.com>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
> v2:
> Move top level title one level up so subsections will be below it in TOC
>
>  MAINTAINERS                 |   1 +
>  docs/system/ppc/amigang.rst | 161 ++++++++++++++++++++++++++++++++++++
>  docs/system/target-ppc.rst  |   1 +
>  3 files changed, 163 insertions(+)
>  create mode 100644 docs/system/ppc/amigang.rst
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7d61fb9319..0aef8cb2a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1562,6 +1562,7 @@ F: hw/rtc/m41t80.c
>  F: pc-bios/canyonlands.dt[sb]
>  F: pc-bios/u-boot-sam460ex-20100605.bin
>  F: roms/u-boot-sam460ex
> +F: docs/system/ppc/amigang.rst
> =20
>  pegasos2
>  M: BALATON Zoltan <balaton@eik.bme.hu>
> diff --git a/docs/system/ppc/amigang.rst b/docs/system/ppc/amigang.rst
> new file mode 100644
> index 0000000000..738decd0c5
> --- /dev/null
> +++ b/docs/system/ppc/amigang.rst
> @@ -0,0 +1,161 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +AmigaNG boards (``amigaone``, ``pegasos2``, ``sam460ex``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +These PowerPC machines emulate boards that are primarily used for
> +running Amiga like OSes (AmigaOS 4, MorphOS and AROS) but these can
> +also run Linux which is what this section documents.
> +
> +Eyetech AmigaOne/Mai Logic Teron (``amigaone``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The ``amigaone`` machine emulates an AmigaOne XE mainboard by Eyetech
> +which is a rebranded Mai Logic Teron board with modified U-Boot
> +firmware to support AmigaOS 4.
> +
> +Emulated devices
> +----------------
> +
> + * PowerPC 7457 CPU (can also use``-cpu g3, 750cxe, 750fx`` or ``750gx``=
)
> + * Articia S north bridge
> + * VIA VT82C686B south bridge
> + * PCI VGA compatible card (guests may need other card instead)
> + * PS/2 keyboard and mouse
> +
> +Firmware
> +--------
> +
> +A firmware binary is necessary for the boot process. It is a modified
> +U-Boot under GPL but its source is lost so it cannot be included in
> +QEMU. A binary is available at
> +https://www.hyperion-entertainment.com/index.php/downloads?view=3Dfiles&=
parent=3D28.
> +The ROM image is in the last 512kB which can be extracted with the
> +following command:
> +
> +.. code-block:: bash
> +
> +  $ tail -c 524288 updater.image > u-boot-amigaone.bin
> +
> +The BIOS emulator in the firmware is unable to run QEMU=E2=80=98s standa=
rd
> +vgabios so ``VGABIOS-lgpl-latest.bin`` is needed instead which can be
> +downloaded from http://www.nongnu.org/vgabios.
> +
> +Running Linux
> +-------------
> +
> +There are some Linux images under the following link that work on the
> +``amigaone`` machine:
> +https://sourceforge.net/projects/amigaone-linux/files/debian-installer/.
> +To boot the system run:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-ppc -machine amigaone -bios u-boot-amigaone.bin \
> +                    -cdrom "A1 Linux Net Installer.iso" \
> +                    -device ati-vga,model=3Drv100,romfile=3DVGABIOS-lgpl=
-latest.bin
> +
> +From the firmware menu that appears select ``Boot sequence`` =E2=86=92
> +``Amiga Multiboot Options`` and set ``Boot device 1`` to
> +``Onboard VIA IDE CDROM``. Then hit escape until the main screen appears=
 again,
> +hit escape once more and from the exit menu that appears select either
> +``Save settings and exit`` or ``Use settings for this session only``. It=
 may
> +take a long time loading the kernel into memory but eventually it boots =
and the
> +installer becomes visible. The ``ati-vga`` RV100 emulation is not
> +complete yet so only frame buffer works, DRM and 3D is not available.
> +
> +Genesi/bPlan Pegasos II (``pegasos2``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The ``pegasos2`` machine emulates the Pegasos II sold by Genesi and
> +designed by bPlan. Its schematics are available at
> +https://www.powerdeveloper.org/platforms/pegasos/schematics
> +
> +Emulated devices
> +----------------
> +
> + * PowerPC 7457 CPU (can also use``-cpu g3`` or ``750cxe``)
> + * Marvell MV64361 Discovery II north bridge
> + * VIA VT8231 south bridge
> + * PCI VGA compatible card (guests may need other card instead)
> + * PS/2 keyboard and mouse
> +
> +Firmware
> +--------
> +
> +The Pegasos II board has an Open Firmware compliant ROM based on
> +SmartFirmware but it has some changes that are not open sourced
> +therefore the ROM binary cannot be included in QEMU. An updater was
> +available from bPlan, it can be found here:
> +http://web.archive.org/web/20071021223056/http://www.bplan-gmbh.de/up050=
404/up050404
> +The ROM image can be extracted from it with the following command:
> +
> +.. code-block:: bash
> +
> +  $ tail -c +85581 up050404 | head -c 524288 > pegasos2.rom
> +
> +Running Linux
> +-------------
> +
> +The PowerPC version of Debian 8.11 supported Pegasos II. The BIOS
> +emulator in the firmware binary is unable to run QEMU=E2=80=98s standard
> +vgabios so it needs to be disabled. To boot the system run:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-ppc -machine pegasos2 -bios pegasos2.rom \
> +                    -cdrom debian-8.11.0-powerpc-netinst.iso \
> +                    -device VGA,romfile=3D"" -serial stdio
> +
> +At the firmware ``ok`` prompt enter ``boot cd install/pegasos``.
> +
> +Alternatively it is possible to boot the kernel directly without
> +firmware ROM using the QEMU built in minimal Virtual Open Firmware
> +(VOF) emulation which is also supported on ``pegasos2``. For this,
> +extract the kernel ``install/powerpc/vmlinuz-chrp.initrd`` from the CD
> +image then run:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-ppc -machine pegasos2 -serial stdio \
> +                    -kernel vmlinuz-chrp.initrd -append "---" \
> +                    -cdrom debian-8.11.0-powerpc-netinst.iso
> +
> +aCube Sam460ex (``sam460ex``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +The ``sam460ex`` machine emulates the Sam460ex board by aCube which is
> +based on the AMCC PowerPC 460EX SoC (that despite its name has a
> +PPC440 CPU core).
> +
> +Firmware
> +--------
> +
> +The board has a firmware based on an older U-Boot version with
> +modifications to support booting AmigaOS 4. The firmware ROM is
> +included with QEMU.
> +
> +Emulated devices
> +----------------
> +
> + * PowerPC 460EX SoC
> + * M41T80 serial RTC chip
> + * Silicon Motion SM501 display parts (identical to SM502 on real board)
> + * Silicon Image SiI3112 2 port SATA controller
> + * USB keyboard and mouse
> +
> +Running Linux
> +-------------
> +
> +The only Linux distro that supported Sam460ex out of box was CruxPPC
> +2.x. It can be booted by running:
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-ppc -machine sam460ex -serial stdio \
> +                    -drive if=3Dnone,id=3Dcd,format=3Draw,file=3Dcrux-pp=
c-2.7a.iso \
> +                    -device ide-cd,drive=3Dcd,bus=3Dide.1
> +
> +There are some other kernels and instructions for booting other
> +distros on aCube's product page at
> +https://www.acube-systems.biz/index.php?page=3Dhardware&pid=3D5
> +but those are untested.
> diff --git a/docs/system/target-ppc.rst b/docs/system/target-ppc.rst
> index 4f6eb93b17..87bf412ce5 100644
> --- a/docs/system/target-ppc.rst
> +++ b/docs/system/target-ppc.rst
> @@ -17,6 +17,7 @@ help``.
>  .. toctree::
>     :maxdepth: 1
> =20
> +   ppc/amigang
>     ppc/embedded
>     ppc/powermac
>     ppc/powernv


