Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C1AC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 11:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcOaZ-00031x-Ge; Tue, 20 Feb 2024 06:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rcOaV-00031K-VL; Tue, 20 Feb 2024 06:47:03 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rcOaR-0005oz-3C; Tue, 20 Feb 2024 06:47:03 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a3cc2f9621aso572882366b.1; 
 Tue, 20 Feb 2024 03:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708429616; x=1709034416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=piA06gM8ElnMTsROizaJ4zu+/hmtfqgqIbTNa0mq+Yc=;
 b=NQNIKO1emL3xxUjH8N9in1LuGLAGH8N66D3JQ4sn6Y/z8kBuE3ykHxkTFRn+yhXrDz
 ZAnCTpSBVaEK7nLc6QHkQmhE6d7lm88GiTrsLcfZ1kQJc/Gok+A3ffr2TnJhijBV7p8L
 KC60eecCdDNXqj5ELvQnjiNCSRPCCNrc/8H9PQoMiikUZLruMgaYwr2LpHryHaVbPbaV
 WCmbpJMYkHKkigDuoBVnNLZ9MkuLCnIqPw8RYFDQyWns87egIWQc98TPMlIHjHVNXsxs
 JAOy1wHEGNZc/9/rH66a7jiPC584y6q2kLbTZygxPsx8E5reaUcxg1iWQ+YYRtpGyOx0
 LC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708429616; x=1709034416;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=piA06gM8ElnMTsROizaJ4zu+/hmtfqgqIbTNa0mq+Yc=;
 b=oI/0L2+/s7//Pj3sOTJynd2y2iRpySv2aal4Rx+wAbJ4OFVabgVajmwSDE553sA2VJ
 jpfpO5eBlsHr8khqjen298fvQ6NuptcZT9R2iaL6c9O+b9N6eEfO7PKwzKeE41HtmLnx
 P3z/RHiKSEvtqWKs4QLUKPPKwhH4ONmbdVAklJIdscbf8ZBhAXAsXfhg/x07pgUy2zGb
 +Fhxet0G+F++zIXGCpIj8zbh/R3gYPvZzlOUqwA0LQfvB3Uw35h9dL6oTSKvWyjZBUcV
 DAu5XvnVIAmCNN/GvsTY4Vy547VKNxlYWsMh749Sux1sPHVk99Tm079IArHYENqndUy2
 Ijrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8u4xV8Cz/KtHsMZwlMlygSZ+V2xk9d2bfeQ6Nfu3kDJGTV2qiMWsF5AunoPYqfz53cLGmOvKPfteEJ8NeVpq+03LZHjSUjLZUQypxPlg9dbTDWz47ayPE+gs=
X-Gm-Message-State: AOJu0YxRDX+ajSMjyoANgGi+ET/prB0zK2ubl+Kmvh//dDL1OxjskSz/
 5LudhvsFBkZ1QizKgI5Gk1Buwx2YqBvbRBhlfv1T9cZd77h5s8Wc
X-Google-Smtp-Source: AGHT+IF8gE88OI/vsw/YwWzJMNY4mybgOrkDi+wYbfDieMf8oF4XZSiW6MPCZ5NsCOlIlc7A9zIJHg==
X-Received: by 2002:a17:906:5917:b0:a3e:c738:afa2 with SMTP id
 h23-20020a170906591700b00a3ec738afa2mr2909256ejq.76.1708429615937; 
 Tue, 20 Feb 2024 03:46:55 -0800 (PST)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 vg8-20020a170907d30800b00a3d2fe84ff9sm3887167ejc.36.2024.02.20.03.46.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 03:46:55 -0800 (PST)
Date: Tue, 20 Feb 2024 09:27:13 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
CC: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_docs/system/ppc=3A_Docum?=
 =?US-ASCII?Q?ent_running_Linux_on_AmigaNG_machines?=
In-Reply-To: <20240219203006.8AF8F4E6003@zero.eik.bme.hu>
References: <20240219203006.8AF8F4E6003@zero.eik.bme.hu>
Message-ID: <DCDFFE97-403A-4B18-81AF-1CBE77E4EBFA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
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



Am 19=2E Februar 2024 20:30:06 UTC schrieb BALATON Zoltan <balaton@eik=2Eb=
me=2Ehu>:
>Documentation on how to run Linux on the amigaone, pegasos2 and
>sam460ex machines is currently buried in the depths of the qemu-devel
>mailing list and in the source code=2E Let's collect the information in
>the QEMU handbook for a one stop solution=2E
>
>Co-authored-by: Bernhard Beschow <shentey@gmail=2Ecom>
>Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>---
>v2:
>Move top level title one level up so subsections will be below it in TOC
>
> MAINTAINERS                 |   1 +
> docs/system/ppc/amigang=2Erst | 161 ++++++++++++++++++++++++++++++++++++
> docs/system/target-ppc=2Erst  |   1 +
> 3 files changed, 163 insertions(+)
> create mode 100644 docs/system/ppc/amigang=2Erst
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 7d61fb9319=2E=2E0aef8cb2a6 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -1562,6 +1562,7 @@ F: hw/rtc/m41t80=2Ec
> F: pc-bios/canyonlands=2Edt[sb]
> F: pc-bios/u-boot-sam460ex-20100605=2Ebin
> F: roms/u-boot-sam460ex
>+F: docs/system/ppc/amigang=2Erst
>=20
> pegasos2
> M: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>diff --git a/docs/system/ppc/amigang=2Erst b/docs/system/ppc/amigang=2Ers=
t
>new file mode 100644
>index 0000000000=2E=2E738decd0c5
>--- /dev/null
>+++ b/docs/system/ppc/amigang=2Erst
>@@ -0,0 +1,161 @@
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>+AmigaNG boards (``amigaone``, ``pegasos2``, ``sam460ex``)
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+These PowerPC machines emulate boards that are primarily used for
>+running Amiga like OSes (AmigaOS 4, MorphOS and AROS) but these can
>+also run Linux which is what this section documents=2E
>+
>+Eyetech AmigaOne/Mai Logic Teron (``amigaone``)
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+The ``amigaone`` machine emulates an AmigaOne XE mainboard by Eyetech
>+which is a rebranded Mai Logic Teron board with modified U-Boot
>+firmware to support AmigaOS 4=2E
>+
>+Emulated devices
>+----------------
>+
>+ * PowerPC 7457 CPU (can also use``-cpu g3, 750cxe, 750fx`` or ``750gx``=
)
>+ * Articia S north bridge
>+ * VIA VT82C686B south bridge
>+ * PCI VGA compatible card (guests may need other card instead)
>+ * PS/2 keyboard and mouse
>+
>+Firmware
>+--------
>+
>+A firmware binary is necessary for the boot process=2E It is a modified
>+U-Boot under GPL but its source is lost so it cannot be included in
>+QEMU=2E A binary is available at
>+https://www=2Ehyperion-entertainment=2Ecom/index=2Ephp/downloads?view=3D=
files&parent=3D28=2E
>+The ROM image is in the last 512kB which can be extracted with the
>+following command:
>+
>+=2E=2E code-block:: bash
>+
>+  $ tail -c 524288 updater=2Eimage > u-boot-amigaone=2Ebin
>+
>+The BIOS emulator in the firmware is unable to run QEMU=E2=80=98s standa=
rd
>+vgabios so ``VGABIOS-lgpl-latest=2Ebin`` is needed instead which can be
>+downloaded from http://www=2Enongnu=2Eorg/vgabios=2E
>+
>+Running Linux
>+-------------
>+
>+There are some Linux images under the following link that work on the
>+``amigaone`` machine:
>+https://sourceforge=2Enet/projects/amigaone-linux/files/debian-installer=
/=2E
>+To boot the system run:
>+
>+=2E=2E code-block:: bash
>+
>+  $ qemu-system-ppc -machine amigaone -bios u-boot-amigaone=2Ebin \
>+                    -cdrom "A1 Linux Net Installer=2Eiso" \
>+                    -device ati-vga,model=3Drv100,romfile=3DVGABIOS-lgpl=
-latest=2Ebin
>+
>+From the firmware menu that appears select ``Boot sequence`` =E2=86=92
>+``Amiga Multiboot Options`` and set ``Boot device 1`` to
>+``Onboard VIA IDE CDROM``=2E Then hit escape until the main screen appea=
rs again,
>+hit escape once more and from the exit menu that appears select either
>+``Save settings and exit`` or ``Use settings for this session only``=2E =
It may
>+take a long time loading the kernel into memory but eventually it boots =
and the
>+installer becomes visible=2E The ``ati-vga`` RV100 emulation is not
>+complete yet so only frame buffer works, DRM and 3D is not available=2E
>+
>+Genesi/bPlan Pegasos II (``pegasos2``)
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>+
>+The ``pegasos2`` machine emulates the Pegasos II sold by Genesi and
>+designed by bPlan=2E Its schematics are available at
>+https://www=2Epowerdeveloper=2Eorg/platforms/pegasos/schematics

Period missing at end of sentence=2E

>+
>+Emulated devices
>+----------------
>+
>+ * PowerPC 7457 CPU (can also use``-cpu g3`` or ``750cxe``)
>+ * Marvell MV64361 Discovery II north bridge
>+ * VIA VT8231 south bridge
>+ * PCI VGA compatible card (guests may need other card instead)
>+ * PS/2 keyboard and mouse
>+
>+Firmware
>+--------
>+
>+The Pegasos II board has an Open Firmware compliant ROM based on
>+SmartFirmware but it has some changes that are not open sourced

s/but it has/with/ ?

s/open sourced/open-sourced/

I'd add a comma after "open-sourced"=2E

>+therefore the ROM binary cannot be included in QEMU=2E An updater was
>+available from bPlan, it can be found here:
>+http://web=2Earchive=2Eorg/web/20071021223056/http://www=2Ebplan-gmbh=2E=
de/up050404/up050404

Period missing at end of sentence=2E

>+The ROM image can be extracted from it with the following command:
>+
>+=2E=2E code-block:: bash
>+
>+  $ tail -c +85581 up050404 | head -c 524288 > pegasos2=2Erom
>+
>+Running Linux
>+-------------
>+
>+The PowerPC version of Debian 8=2E11 supported Pegasos II=2E The BIOS
>+emulator in the firmware binary is unable to run QEMU=E2=80=98s standard
>+vgabios so it needs to be disabled=2E To boot the system run:
>+
>+=2E=2E code-block:: bash
>+
>+  $ qemu-system-ppc -machine pegasos2 -bios pegasos2=2Erom \
>+                    -cdrom debian-8=2E11=2E0-powerpc-netinst=2Eiso \
>+                    -device VGA,romfile=3D"" -serial stdio
>+
>+At the firmware ``ok`` prompt enter ``boot cd install/pegasos``=2E
>+
>+Alternatively it is possible to boot the kernel directly without

I'd add a comma after "Alternatively"=2E

>+firmware ROM using the QEMU built in minimal Virtual Open Firmware

s/built in/built-in/

>+(VOF) emulation which is also supported on ``pegasos2``=2E For this,
>+extract the kernel ``install/powerpc/vmlinuz-chrp=2Einitrd`` from the CD
>+image then run:

I'd put a comma before "then run"=2E

>+
>+=2E=2E code-block:: bash
>+
>+  $ qemu-system-ppc -machine pegasos2 -serial stdio \
>+                    -kernel vmlinuz-chrp=2Einitrd -append "---" \
>+                    -cdrom debian-8=2E11=2E0-powerpc-netinst=2Eiso
>+
>+aCube Sam460ex (``sam460ex``)
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>+
>+The ``sam460ex`` machine emulates the Sam460ex board by aCube which is
>+based on the AMCC PowerPC 460EX SoC (that despite its name has a
>+PPC440 CPU core)=2E
>+
>+Firmware
>+--------
>+
>+The board has a firmware based on an older U-Boot version with
>+modifications to support booting AmigaOS 4=2E The firmware ROM is
>+included with QEMU=2E
>+
>+Emulated devices
>+----------------
>+
>+ * PowerPC 460EX SoC
>+ * M41T80 serial RTC chip
>+ * Silicon Motion SM501 display parts (identical to SM502 on real board)
>+ * Silicon Image SiI3112 2 port SATA controller
>+ * USB keyboard and mouse
>+
>+Running Linux
>+-------------
>+
>+The only Linux distro that supported Sam460ex out of box was CruxPPC
>+2=2Ex=2E It can be booted by running:
>+
>+=2E=2E code-block:: bash
>+
>+  $ qemu-system-ppc -machine sam460ex -serial stdio \
>+                    -drive if=3Dnone,id=3Dcd,format=3Draw,file=3Dcrux-pp=
c-2=2E7a=2Eiso \
>+                    -device ide-cd,drive=3Dcd,bus=3Dide=2E1
>+
>+There are some other kernels and instructions for booting other
>+distros on aCube's product page at
>+https://www=2Eacube-systems=2Ebiz/index=2Ephp?page=3Dhardware&pid=3D5
>+but those are untested=2E
>diff --git a/docs/system/target-ppc=2Erst b/docs/system/target-ppc=2Erst
>index 4f6eb93b17=2E=2E87bf412ce5 100644
>--- a/docs/system/target-ppc=2Erst
>+++ b/docs/system/target-ppc=2Erst
>@@ -17,6 +17,7 @@ help``=2E
> =2E=2E toctree::
>    :maxdepth: 1
>=20
>+   ppc/amigang
>    ppc/embedded
>    ppc/powermac
>    ppc/powernv

For amigaone + pegasos2:
Tested-by: Bernhard Beschow <shentey@gmail=2Ecom>


