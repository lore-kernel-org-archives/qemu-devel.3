Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1CFC5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 10:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMkub-0005Vo-PO; Wed, 04 Jun 2025 05:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uMkua-0005VO-LS
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:59:56 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uMkuY-0002hk-PA
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:59:56 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a374f727dbso5765289f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749031193; x=1749635993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hubZyUgI/uMTIR9skbz0guVl/yj87bakpA4EgYSmMe8=;
 b=NM6ISVsKCdMQmhr8PI07Z9Ozjf9WgSPH6yqN+qOawnjmbYloHyQyFxWm6p/CKsoelb
 nhFB9qtVUKLDb62DOANHCckaPWPmPNQYoSeDvs7ViJXho+S5k9gxT6ZVUR+kKD6hd39I
 lH7qioGvGpyYHoNxfNuqAZNnX3m4q2luY38oX2zF8G279rrFgNBD0vNMjmID7aigls0Q
 m65QlEuRoGfC8QBCmF2HdTty23yWDDDTjL5jThhJFnvytoMRU6tKeOqzccADyvaSOjkg
 C6kYhLG7myAfxL3i7u81xK1lgFrOleyfFlWSm8NgZ15uJaQwcml92L19YzVnEXNqACTM
 QNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749031193; x=1749635993;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hubZyUgI/uMTIR9skbz0guVl/yj87bakpA4EgYSmMe8=;
 b=pCSSfR4CvIf39ET9qnY/xvkX4uBTjeypKkCDk0mATiQWNju4zpVdSwQJ7jC/NauMwB
 EEleAayOZZM+0T2lrc830bgZutPUoT34sIK5ihu+ltEexLJefzoTQDBDvujontma+S6X
 XN8J1y/p9ZVZOR6ZQK25osLTDpNQQaHEEVFNqy1wXzA7+Ap4avYcZ6GkQy9IAO2Qa0X6
 SGk1Val7JuEEud/Np1BjxyqBAXPbFdc30jNPbH8Mi3NfNll2j2B4MY4BPrss4jT0LTEv
 eW00tGBCCZupiq+BVmC3640qq+VfMILbLznGdP9nkOAuBc6utzL1Zbl/T+5WYjXKJvbU
 dCdQ==
X-Gm-Message-State: AOJu0Ywq+S2frjLQwynXYdB/a1x0+yFQz27b1558CwK1vBZYLY7OTZpF
 U4AIjgnourTVyqnx6BLvOpVD+vBPaVmI6QGnz6EXlMzKCOwt9h6SQxvX
X-Gm-Gg: ASbGncu/VuoHqfOCWYWicdSugKiZ8Uc76+M5eDKC1vkLc23Fp/ZQ2exq9m0lZ64dzIR
 P9DgRCXaQBuCixRLxcUp5APRdXE/gWqYnOMcbtGBIajvGL57mlnC5dIqdP7E8MguHYTZcdLE0dx
 0tktdooq+25IPtHlZk3DyYVG4BCfXW0dVVR/0RT/x2cZP2KCT/CoZP1xqm6H16NaVARrPNnkV/M
 yMFy51OPv5EC7Y9YFkjg6DFYA74EwTRY0W2Eig43ufn4IrbPd4UEcbJK5GLjx3K/xXuJNlF6/mz
 xDEo1mX6zx53ZefYDY7yDokL9atcbT3WG+ErxDSG9GL0mA==
X-Google-Smtp-Source: AGHT+IE8co9C/WDu8Egl+bx1J/j0BinXisreA1Wswp1WdICMIdxs6u/eyU08Hl0JmiKpM7w8LP6zCA==
X-Received: by 2002:a5d:5889:0:b0:3a4:de02:208 with SMTP id
 ffacd0b85a97d-3a51d92d54amr1621351f8f.25.1749031190642; 
 Wed, 04 Jun 2025 02:59:50 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c79dsm20775387f8f.25.2025.06.04.02.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 02:59:50 -0700 (PDT)
Date: Wed, 04 Jun 2025 09:59:44 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Thomas Huth <thuth@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org
Subject: Re: [PULL 36/58] pc-bios: Move device tree files in their own subdir
In-Reply-To: <6b0cddfb-4ebe-4775-becc-c4301235849d@redhat.com>
References: <20250425152843.69638-1-philmd@linaro.org>
 <20250425152843.69638-37-philmd@linaro.org>
 <621F23F2-05FC-4C8C-8AA8-F61DED04B306@gmail.com>
 <83dcb220-dd06-fb7f-1960-432fb2696b60@eik.bme.hu>
 <0648af18-2e50-4eaa-96fb-b0e64eb706d9@linaro.org>
 <05174912-B148-4ECB-9F8C-4C0641FFC2BB@gmail.com>
 <6b0cddfb-4ebe-4775-becc-c4301235849d@redhat.com>
Message-ID: <D40F7961-C681-4945-9E92-E0ED4B60C1B3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 3=2E Juni 2025 11:38:59 UTC schrieb Thomas Huth <thuth@redhat=2Ecom>:
>On 03/06/2025 08=2E39, Bernhard Beschow wrote:
>>=20
>>=20
>> Am 2=2E Juni 2025 08:12:39 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>>> On 30/5/25 02:54, BALATON Zoltan wrote:
>>>> On Thu, 29 May 2025, Bernhard Beschow wrote:
>>>>> Am 25=2E April 2025 15:28:20 UTC schrieb "Philippe Mathieu-Daud=C3=
=A9" <philmd@linaro=2Eorg>:
>>>>>> From: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>>>>>=20
>>>>>> We have several device tree files already and may have more in the
>>>>>> future so add a new dtb subdirectory and move device tree files the=
re
>>>>>> so they are not mixed with ROM binaries=2E
>>>>>>=20
>>>>>> Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>>>>> Message-ID: <57f179bd3904c1f2ca062ca4d4ff9592bb4f4daa=2E1745402140=
=2Egit=2Ebalaton@eik=2Ebme=2Ehu>
>>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>>>>> ---
>>>>>> MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +=
-
>>>>>> system/datadir=2Ec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +++-
>>>>>> pc-bios/{ =3D> dtb}/bamboo=2Edtb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Bin
>>>>>> pc-bios/{ =3D> dtb}/bamboo=2Edts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 0
>>>>>> pc-bios/{ =3D> dtb}/canyonlands=2Edtb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | Bin
>>>>>> pc-bios/{ =3D> dtb}/canyonlands=2Edts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 0
>>>>>> pc-bios/dtb/meson=2Ebuild=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 23 +++++++++++++++++++++
>>>>>> pc-bios/{ =3D> dtb}/petalogix-ml605=2Edtb=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | Bin
>>>>>> pc-bios/{ =3D> dtb}/petalogix-ml605=2Edts=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 0
>>>>>> pc-bios/{ =3D> dtb}/petalogix-s3adsp1800=2Edtb | Bin
>>>>>> pc-bios/{ =3D> dtb}/petalogix-s3adsp1800=2Edts |=C2=A0=C2=A0 0
>>>>>> pc-bios/meson=2Ebuild=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 23 +--------------------
>>>>>> qemu=2Ensi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 2 +-
>>>>>> 13 files changed, 29 insertions(+), 25 deletions(-)
>>>>>> rename pc-bios/{ =3D> dtb}/bamboo=2Edtb (100%)
>>>>>> rename pc-bios/{ =3D> dtb}/bamboo=2Edts (100%)
>>>>>> rename pc-bios/{ =3D> dtb}/canyonlands=2Edtb (100%)
>>>>>> rename pc-bios/{ =3D> dtb}/canyonlands=2Edts (100%)
>>>>>> create mode 100644 pc-bios/dtb/meson=2Ebuild
>>>>>> rename pc-bios/{ =3D> dtb}/petalogix-ml605=2Edtb (100%)
>>>>>> rename pc-bios/{ =3D> dtb}/petalogix-ml605=2Edts (100%)
>>>>>> rename pc-bios/{ =3D> dtb}/petalogix-s3adsp1800=2Edtb (100%)
>>>>>> rename pc-bios/{ =3D> dtb}/petalogix-s3adsp1800=2Edts (100%)
>>>>>>=20
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index 661a47db5ac=2E=2Ed82d962f1a4 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -1581,7 +1581,7 @@ F: hw/pci-host/ppc440_pcix=2Ec
>>>>>> F: hw/display/sm501*
>>>>>> F: hw/ide/sii3112=2Ec
>>>>>> F: hw/rtc/m41t80=2Ec
>>>>>> -F: pc-bios/canyonlands=2Edt[sb]
>>>>>> +F: pc-bios/dtb/canyonlands=2Edt[sb]
>>>>>> F: pc-bios/u-boot-sam460ex-20100605=2Ebin
>>>>>> F: roms/u-boot-sam460ex
>>>>>> F: docs/system/ppc/amigang=2Erst
>>>>>> diff --git a/system/datadir=2Ec b/system/datadir=2Ec
>>>>>> index e450b84ce91=2E=2Ef96f8fc2646 100644
>>>>>> --- a/system/datadir=2Ec
>>>>>> +++ b/system/datadir=2Ec
>>>>>> @@ -44,9 +44,11 @@ char *qemu_find_file(QemuFileType type, const ch=
ar *name)
>>>>>>=20
>>>>>>  =C2=A0=C2=A0=C2=A0 switch (type) {
>>>>>>  =C2=A0=C2=A0=C2=A0 case QEMU_FILE_TYPE_BIOS:
>>>>>> -=C2=A0=C2=A0=C2=A0 case QEMU_FILE_TYPE_DTB:
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subdir =3D "";
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>> +=C2=A0=C2=A0=C2=A0 case QEMU_FILE_TYPE_DTB:
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subdir =3D "dtb/";
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>  =C2=A0=C2=A0=C2=A0 case QEMU_FILE_TYPE_KEYMAP:
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subdir =3D "keymaps/";
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>> diff --git a/pc-bios/bamboo=2Edtb b/pc-bios/dtb/bamboo=2Edtb
>>>>>> similarity index 100%
>>>>>> rename from pc-bios/bamboo=2Edtb
>>>>>> rename to pc-bios/dtb/bamboo=2Edtb
>>>>>> diff --git a/pc-bios/bamboo=2Edts b/pc-bios/dtb/bamboo=2Edts
>>>>>> similarity index 100%
>>>>>> rename from pc-bios/bamboo=2Edts
>>>>>> rename to pc-bios/dtb/bamboo=2Edts
>>>>>> diff --git a/pc-bios/canyonlands=2Edtb b/pc-bios/dtb/canyonlands=2E=
dtb
>>>>>> similarity index 100%
>>>>>> rename from pc-bios/canyonlands=2Edtb
>>>>>> rename to pc-bios/dtb/canyonlands=2Edtb
>>>>>> diff --git a/pc-bios/canyonlands=2Edts b/pc-bios/dtb/canyonlands=2E=
dts
>>>>>> similarity index 100%
>>>>>> rename from pc-bios/canyonlands=2Edts
>>>>>> rename to pc-bios/dtb/canyonlands=2Edts
>>>>>> diff --git a/pc-bios/dtb/meson=2Ebuild b/pc-bios/dtb/meson=2Ebuild
>>>>>> new file mode 100644
>>>>>> index 00000000000=2E=2E7a71835bca7
>>>>>> --- /dev/null
>>>>>> +++ b/pc-bios/dtb/meson=2Ebuild
>>>>>> @@ -0,0 +1,23 @@
>>>>>> +dtbs =3D [
>>>>>> +=C2=A0 'bamboo=2Edtb',
>>>>>> +=C2=A0 'canyonlands=2Edtb',
>>>>>> +=C2=A0 'petalogix-ml605=2Edtb',
>>>>>> +=C2=A0 'petalogix-s3adsp1800=2Edtb',
>>>>>=20
>>>>> Was it intended that the suffix changed from =2Edts to =2Edtb? This =
change isn't motivated in the commit message and usually source files rathe=
r than generated artifacts are listed in build files=2E
>>>>=20
>>>> I think I either found similar python code somewhere and followed tha=
t because meson and python is not something I understand well=2E Or changed=
 it because we always need the list of dtbs to install but only need the dt=
s when compiling so this way we don't need another list or replacing suffix=
 twice=2E
>>>=20
>>> Should we revert?
>>=20
>> What's the idea behind having dtbs in the repository instead of making =
dtc mandatory? If there is any perspective that we could remove the dtbs in=
 the future I vote for restoring the original logic=2E I could send a patch=
 since I have further dtb fixes for the e500 and arm=2E
>
>IMHO since we require libfdt for many boards already anyway, we could als=
o require dtc for these boards that need a dtb (and disable them if dtc is =
not available) =2E=2E=2E we just might need some additional Kconfig symbol =
for that case since dtc and libfdt are sometimes shipped in different packa=
ges on the various distros and thus could be installed independently from e=
ach other=2E

I'd try that, and I have some ideas on how to make this work similar to ho=
w we deal with =2Ec files=2E I could then use this mechanism in my e500-fdt=
 branch=2E Let's see=2E=2E=2E

Best regards,
Bernhard
>
> Thomas
>

