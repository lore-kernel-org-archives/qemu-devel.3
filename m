Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9AEC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 09:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjyRX-0005Dg-6g; Tue, 12 Mar 2024 05:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rjyRU-0005C3-MQ; Tue, 12 Mar 2024 05:29:04 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rjyRS-0003eG-BK; Tue, 12 Mar 2024 05:29:04 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a4627a7233aso315813466b.1; 
 Tue, 12 Mar 2024 02:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710235740; x=1710840540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jfvr8Hgpt4XiM2qpUCgIfHLKDjogYiElmXwM+0PP/cw=;
 b=P8RFhewy6cOoB1vpx2rjFRDieKdtcUc9eWeJtvoGtzvWeolzBoYHBZOBnnxzJAEV6y
 ijb9UZVBbiQ13LFmEFf7oJzyQ0O8NyE29B/9dmQuQynm0UDEb/IU7HzLM6bER8Bu4HZU
 ET6SjxkWFt5WgIIjXdqQYilLrY+CARmki4LttmwSemYCTRHLJpbVQE95bkXwa2PzB89g
 TMeNDvgSm0LgwqAjjh0PTTMfI+O3OKOJ8MnFaADMeUqk/BwptREQQOHR7SxtrkrG1V5B
 OS9zZOHcUPeJc7TaUbOLsVEkB1byASg+22bKsSOw1vMxd2A9o4G3RRh7O2gq+hojL2n3
 P3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710235740; x=1710840540;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jfvr8Hgpt4XiM2qpUCgIfHLKDjogYiElmXwM+0PP/cw=;
 b=QQrwiKCFVi8SRy6IY1h3FI0AyfxCV/mvopQre+MOXhB6U/YZ9ZENAMPjrUOfoExCuf
 TKyXmcb6+qmXyZ5uGGGcbu2FTYGf3I2NkDSOD+A7xSHOkTMNTTXffy4be0Yuck18dQBH
 Me9Y1842qnCkLU497Z91TEd5xom1NARwhGm+gStdyRsu8SmDNdkBJF1es9YKLi3roIJG
 pBAugaDd5s71igMBse5BNLjk5SokkB+oaN4fHEUK9yu5Q6eixRUMj5/cu/vShVBWd+QV
 Ghmd81cHhlf2epGgiL4WrH3OnoClTZn9mrQdl6VslsfflokYNaJ7PBintKORsnSleSBN
 OI7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFEPfyonwr8VAz6od1yWfw81KFwHG3gO7aTzO/O7QubVfnhSPYm+PbZQ09ubgMNLbwTqeSxvKEybzy0tkzCdfov/MtFmnS0kGCejs3zwblSOzyaX3mLW/F290=
X-Gm-Message-State: AOJu0YzJgi7x2V4TbCvvgcxeCkpzFgySfN4iQXik9kG9pcCxJAOgY2XG
 fBi4a0DZMtlqS3E4f9PPED2syNWqpqENQiVUkCaOaLCuAZSBqbe7RN0msFIo
X-Google-Smtp-Source: AGHT+IFnkVKmJZJvokWCLL6DtnW43qULWb8Ezk9DzpAOH6Mpy0dYTel+2Dmcsserf1H9hpRS9oBC1g==
X-Received: by 2002:a17:906:cf85:b0:a46:1e21:3739 with SMTP id
 um5-20020a170906cf8500b00a461e213739mr6030395ejb.6.1710235739681; 
 Tue, 12 Mar 2024 02:28:59 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-078-054-052-200.78.54.pool.telefonica.de.
 [78.54.52.200]) by smtp.gmail.com with ESMTPSA id
 i26-20020a170906251a00b00a44cb0bf11bsm3665807ejb.79.2024.03.12.02.28.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 02:28:59 -0700 (PDT)
Date: Tue, 12 Mar 2024 09:28:57 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
CC: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_docs/system/ppc=3A_Docum?=
 =?US-ASCII?Q?ent_running_Linux_on_AmigaNG_machines?=
In-Reply-To: <a9814b1b-98d7-29d8-36f9-228f20206917@eik.bme.hu>
References: <20240220232200.042DA4E6005@zero.eik.bme.hu>
 <c9dc84be-c7bf-c676-491b-2c6b1164d502@eik.bme.hu>
 <a9814b1b-98d7-29d8-36f9-228f20206917@eik.bme.hu>
Message-ID: <3E4E29CA-AE91-4C8D-BB51-B3759CF3110F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
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



Am 9=2E M=C3=A4rz 2024 11:34:56 UTC schrieb BALATON Zoltan <balaton@eik=2E=
bme=2Ehu>:
>On Thu, 29 Feb 2024, BALATON Zoltan wrote:
>> On Wed, 21 Feb 2024, BALATON Zoltan wrote:
>>> Documentation on how to run Linux on the amigaone, pegasos2 and
>>> sam460ex machines is currently buried in the depths of the qemu-devel
>>> mailing list and in the source code=2E Let's collect the information i=
n
>>> the QEMU handbook for a one stop solution=2E
>>=20
>> Ping? (Just so it's not missed from next pull=2E)
>
>Ping for freeze=2E

Has this patch been tagged yet? It would really be a pity if it didn't mak=
e it into 9=2E0=2E

FWIW:

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>
>> Regards,
>> BALATON Zoltan
>>=20
>>> Co-authored-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>> Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>> Reviewed-by: Nicholas Piggin <npiggin@gmail=2Ecom>
>>> Tested-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>> ---
>>> v3: Apply changes and Tested-by tag from Bernhard
>>> v2: Move top level title one level up so subsections will be below it =
in TOC
>>>=20
>>> MAINTAINERS                 |   1 +
>>> docs/system/ppc/amigang=2Erst | 161 ++++++++++++++++++++++++++++++++++=
++
>>> docs/system/target-ppc=2Erst  |   1 +
>>> 3 files changed, 163 insertions(+)
>>> create mode 100644 docs/system/ppc/amigang=2Erst
>>>=20
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 7d61fb9319=2E=2E0aef8cb2a6 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1562,6 +1562,7 @@ F: hw/rtc/m41t80=2Ec
>>> F: pc-bios/canyonlands=2Edt[sb]
>>> F: pc-bios/u-boot-sam460ex-20100605=2Ebin
>>> F: roms/u-boot-sam460ex
>>> +F: docs/system/ppc/amigang=2Erst
>>>=20
>>> pegasos2
>>> M: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>> diff --git a/docs/system/ppc/amigang=2Erst b/docs/system/ppc/amigang=
=2Erst
>>> new file mode 100644
>>> index 0000000000=2E=2Eba1a3d80b9
>>> --- /dev/null
>>> +++ b/docs/system/ppc/amigang=2Erst
>>> @@ -0,0 +1,161 @@
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> +AmigaNG boards (``amigaone``, ``pegasos2``, ``sam460ex``)
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> +
>>> +These PowerPC machines emulate boards that are primarily used for
>>> +running Amiga like OSes (AmigaOS 4, MorphOS and AROS) but these can
>>> +also run Linux which is what this section documents=2E
>>> +
>>> +Eyetech AmigaOne/Mai Logic Teron (``amigaone``)
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> +
>>> +The ``amigaone`` machine emulates an AmigaOne XE mainboard by Eyetech
>>> +which is a rebranded Mai Logic Teron board with modified U-Boot
>>> +firmware to support AmigaOS 4=2E
>>> +
>>> +Emulated devices
>>> +----------------
>>> +
>>> + * PowerPC 7457 CPU (can also use``-cpu g3, 750cxe, 750fx`` or ``750g=
x``)
>>> + * Articia S north bridge
>>> + * VIA VT82C686B south bridge
>>> + * PCI VGA compatible card (guests may need other card instead)
>>> + * PS/2 keyboard and mouse
>>> +
>>> +Firmware
>>> +--------
>>> +
>>> +A firmware binary is necessary for the boot process=2E It is a modifi=
ed
>>> +U-Boot under GPL but its source is lost so it cannot be included in
>>> +QEMU=2E A binary is available at
>>> +https://www=2Ehyperion-entertainment=2Ecom/index=2Ephp/downloads?view=
=3Dfiles&parent=3D28=2E
>>> +The ROM image is in the last 512kB which can be extracted with the
>>> +following command:
>>> +
>>> +=2E=2E code-block:: bash
>>> +
>>> +  $ tail -c 524288 updater=2Eimage > u-boot-amigaone=2Ebin
>>> +
>>> +The BIOS emulator in the firmware is unable to run QEMU=E2=80=98s sta=
ndard
>>> +vgabios so ``VGABIOS-lgpl-latest=2Ebin`` is needed instead which can =
be
>>> +downloaded from http://www=2Enongnu=2Eorg/vgabios=2E
>>> +
>>> +Running Linux
>>> +-------------
>>> +
>>> +There are some Linux images under the following link that work on the
>>> +``amigaone`` machine:
>>> +https://sourceforge=2Enet/projects/amigaone-linux/files/debian-instal=
ler/=2E
>>> +To boot the system run:
>>> +
>>> +=2E=2E code-block:: bash
>>> +
>>> +  $ qemu-system-ppc -machine amigaone -bios u-boot-amigaone=2Ebin \
>>> +                    -cdrom "A1 Linux Net Installer=2Eiso" \
>>> +                    -device ati-vga,model=3Drv100,romfile=3DVGABIOS-l=
gpl-latest=2Ebin
>>> +
>>> +From the firmware menu that appears select ``Boot sequence`` =E2=86=
=92
>>> +``Amiga Multiboot Options`` and set ``Boot device 1`` to
>>> +``Onboard VIA IDE CDROM``=2E Then hit escape until the main screen ap=
pears again,
>>> +hit escape once more and from the exit menu that appears select eithe=
r
>>> +``Save settings and exit`` or ``Use settings for this session only``=
=2E It may
>>> +take a long time loading the kernel into memory but eventually it boo=
ts and the
>>> +installer becomes visible=2E The ``ati-vga`` RV100 emulation is not
>>> +complete yet so only frame buffer works, DRM and 3D is not available=
=2E
>>> +
>>> +Genesi/bPlan Pegasos II (``pegasos2``)
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> +
>>> +The ``pegasos2`` machine emulates the Pegasos II sold by Genesi and
>>> +designed by bPlan=2E Its schematics are available at
>>> +https://www=2Epowerdeveloper=2Eorg/platforms/pegasos/schematics=2E
>>> +
>>> +Emulated devices
>>> +----------------
>>> +
>>> + * PowerPC 7457 CPU (can also use``-cpu g3`` or ``750cxe``)
>>> + * Marvell MV64361 Discovery II north bridge
>>> + * VIA VT8231 south bridge
>>> + * PCI VGA compatible card (guests may need other card instead)
>>> + * PS/2 keyboard and mouse
>>> +
>>> +Firmware
>>> +--------
>>> +
>>> +The Pegasos II board has an Open Firmware compliant ROM based on
>>> +SmartFirmware with some changes that are not open-sourced therefore
>>> +the ROM binary cannot be included in QEMU=2E An updater was available
>>> +from bPlan, it can be found in the `Internet Archive
>>> +<http://web=2Earchive=2Eorg/web/20071021223056/http://www=2Ebplan-gmb=
h=2Ede/up050404/up050404>`_=2E
>>> +The ROM image can be extracted from it with the following command:
>>> +
>>> +=2E=2E code-block:: bash
>>> +
>>> +  $ tail -c +85581 up050404 | head -c 524288 > pegasos2=2Erom
>>> +
>>> +Running Linux
>>> +-------------
>>> +
>>> +The PowerPC version of Debian 8=2E11 supported Pegasos II=2E The BIOS
>>> +emulator in the firmware binary is unable to run QEMU=E2=80=98s stand=
ard
>>> +vgabios so it needs to be disabled=2E To boot the system run:
>>> +
>>> +=2E=2E code-block:: bash
>>> +
>>> +  $ qemu-system-ppc -machine pegasos2 -bios pegasos2=2Erom \
>>> +                    -cdrom debian-8=2E11=2E0-powerpc-netinst=2Eiso \
>>> +                    -device VGA,romfile=3D"" -serial stdio
>>> +
>>> +At the firmware ``ok`` prompt enter ``boot cd install/pegasos``=2E
>>> +
>>> +Alternatively, it is possible to boot the kernel directly without
>>> +firmware ROM using the QEMU built-in minimal Virtual Open Firmware
>>> +(VOF) emulation which is also supported on ``pegasos2``=2E For this,
>>> +extract the kernel ``install/powerpc/vmlinuz-chrp=2Einitrd`` from the=
 CD
>>> +image, then run:
>>> +
>>> +=2E=2E code-block:: bash
>>> +
>>> +  $ qemu-system-ppc -machine pegasos2 -serial stdio \
>>> +                    -kernel vmlinuz-chrp=2Einitrd -append "---" \
>>> +                    -cdrom debian-8=2E11=2E0-powerpc-netinst=2Eiso
>>> +
>>> +aCube Sam460ex (``sam460ex``)
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>> +
>>> +The ``sam460ex`` machine emulates the Sam460ex board by aCube which i=
s
>>> +based on the AMCC PowerPC 460EX SoC (that despite its name has a
>>> +PPC440 CPU core)=2E
>>> +
>>> +Firmware
>>> +--------
>>> +
>>> +The board has a firmware based on an older U-Boot version with
>>> +modifications to support booting AmigaOS 4=2E The firmware ROM is
>>> +included with QEMU=2E
>>> +
>>> +Emulated devices
>>> +----------------
>>> +
>>> + * PowerPC 460EX SoC
>>> + * M41T80 serial RTC chip
>>> + * Silicon Motion SM501 display parts (identical to SM502 on real boa=
rd)
>>> + * Silicon Image SiI3112 2 port SATA controller
>>> + * USB keyboard and mouse
>>> +
>>> +Running Linux
>>> +-------------
>>> +
>>> +The only Linux distro that supported Sam460ex out of box was CruxPPC
>>> +2=2Ex=2E It can be booted by running:
>>> +
>>> +=2E=2E code-block:: bash
>>> +
>>> +  $ qemu-system-ppc -machine sam460ex -serial stdio \
>>> +                    -drive if=3Dnone,id=3Dcd,format=3Draw,file=3Dcrux=
-ppc-2=2E7a=2Eiso \
>>> +                    -device ide-cd,drive=3Dcd,bus=3Dide=2E1
>>> +
>>> +There are some other kernels and instructions for booting other
>>> +distros on aCube's product page at
>>> +https://www=2Eacube-systems=2Ebiz/index=2Ephp?page=3Dhardware&pid=3D5
>>> +but those are untested=2E
>>> diff --git a/docs/system/target-ppc=2Erst b/docs/system/target-ppc=2Er=
st
>>> index 4f6eb93b17=2E=2E87bf412ce5 100644
>>> --- a/docs/system/target-ppc=2Erst
>>> +++ b/docs/system/target-ppc=2Erst
>>> @@ -17,6 +17,7 @@ help``=2E
>>> =2E=2E toctree::
>>>    :maxdepth: 1
>>>=20
>>> +   ppc/amigang
>>>    ppc/embedded
>>>    ppc/powermac
>>>    ppc/powernv
>> 

