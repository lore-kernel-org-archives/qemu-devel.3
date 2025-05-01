Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03265C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 19:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAZBm-00009W-Lq; Thu, 01 May 2025 15:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uAZBk-00007u-MW; Thu, 01 May 2025 15:03:16 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uAZBi-0004Pi-Ov; Thu, 01 May 2025 15:03:16 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso193857766b.3; 
 Thu, 01 May 2025 12:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746126192; x=1746730992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ocgFBXFmeG3qwIircFlJjaGx4dSo/HcAInTAgmoH2Q=;
 b=NDDbOA4pdU2r2TKmXoV1ImPYuEb1AoAinVu6772i/xxbuCIwDy901a2koXiTALSZnT
 qwxwkkRJvVn1M9770JKif8eOKwboNvua4bwHVKssMKBPXZGPZWM0hsEqKlnz1Kj3K+bI
 gCyYk76KffkVfM3XoSsxfEbjhmP5pa7jH5o0mrEXHbmJ/3Yj/lH+c1xNDJLftJOHwi+x
 KLE5tCddaDdyQB1zLxqWiqSWyG1ipLTgDwtCf9bEP+TtYm2l8x+LuPeWxyAx3U0ipy7U
 KyuyV75RHVxeFIShIWlnc6g5Nyg4Si+0Da1rzGltNOkgvAF9Tr8oDnWiRth/ETR+UuEk
 ocrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746126192; x=1746730992;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ocgFBXFmeG3qwIircFlJjaGx4dSo/HcAInTAgmoH2Q=;
 b=aocwGe1KMtG1qi6QDPHV80VDq9LPbkKls2WZZR8hXFvY7F0eTVhwe3UqW/EcOaMWvf
 7l6tfMr92henUX4OMgYZTQL25HlYNrAtNO2tS0F2T8umVZFje5Q56ou83nDwvjNogR0v
 IlVacubNtNHev/m1MNDAW6eJT3HnwhqFAJPvfmYHPYISVvU2UMzFgPgPPnq6d9E8JZdW
 Alr9rQ2b3/upLt1BV39p6cZvo08dSLOYFa/1dne1tVYpquEc0hZ/AEuxvdY5/i2Yn0+J
 hHBfeU7wgDvPejflH5MWXq3LkSrIwkhZLCK0XyXGGPEpvjPfWd1HgJOe6N5+y+Ze1knm
 9fdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLDr7nJIkK2h7r6UpG939f9iV2F4JG2iB0Mn+lfNUhem5LSCPmqUQyjlaeAeesyo5Gu6g+7CbR9z2O@nongnu.org
X-Gm-Message-State: AOJu0YwSqy6ECzpLDmY5UofR0OroRSF+9B3xWo/QsbKhyo+ZqPebbzFB
 rHCZS5IrDtHx22YU6Kda2p3+UoUBSh5Ah2tCL64entE5zwkDF+sWK5sYfg==
X-Gm-Gg: ASbGncujdrIroCbCqpgIVWGsXm3Gb3ekebSJY+pf451fWxYLAIK5Fagon6k0r/dtVhA
 mzk2Q6uGgkXWI20TpG7EH1rOquyJ6sfgV4aNVwkTCL1pRO4JntxtUd3LXT5Kvm5AsoTP8RZ1OQE
 1o0g0DpiZNTbz5fI71nKhZmAeAp0eOD6c0Ee1oxFLC4P2luc3LUNROlNr0FNF5Wj01qqUZxP/oI
 /njGGGjbC3Z+YGWc3qbYr1I1FXXznuxdcrNvWLOQLPFmgZb4D/QJ+uGzLIS/6ksCvUYV+GcKdRv
 YbgeTnT8hp2Pjn0vEaQIv5hU83yqFAwa16UzvopTyu2vsdagin1iKxBS+rhUTsoufbPuZNzfY85
 yRYkdurceLZikf63fxrrKbVydInkvpscx1E3nbKJ7q7Knb5ox
X-Google-Smtp-Source: AGHT+IFhmFScg0kXAfJXhaKyFlP4CEXYOs38Nwz4eVNNa/7/n+dw6zQ1SREd5UvaK53hQzCiMkF9Uw==
X-Received: by 2002:a17:907:97c7:b0:ace:5207:e2ec with SMTP id
 a640c23a62f3a-ad17ad3a328mr36478366b.4.1746126192054; 
 Thu, 01 May 2025 12:03:12 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-2980-eb00-a8d7-7173-cc26-fcbf.310.pool.telefonica.de.
 [2a02:3100:2980:eb00:a8d7:7173:cc26:fcbf])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad0da55af93sm79836666b.146.2025.05.01.12.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 12:03:11 -0700 (PDT)
Date: Thu, 01 May 2025 18:52:42 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
CC: qemu-arm@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH-for-10=2E0=3F_v2=5D_tests/functional=3A_Add?=
 =?US-ASCII?Q?_test_for_imx8mp-evk_board_with_USDHC_coverage?=
In-Reply-To: <e3ea2723-126f-45af-8bdd-602ee512b51f@linaro.org>
References: <20250409202630.19667-1-shentey@gmail.com>
 <aa47d49a-b81a-46cf-811a-2045e453f4bf@redhat.com>
 <6621A6A6-83F8-476C-973C-FE3D1918E061@gmail.com>
 <2c725cbc-6ba0-4e07-8863-acacbb45e121@redhat.com>
 <e3ea2723-126f-45af-8bdd-602ee512b51f@linaro.org>
Message-ID: <6F691694-5625-4ECF-8734-C0A546453607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 23=2E April 2025 11:31:31 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <ph=
ilmd@linaro=2Eorg>:
>Hi Thomas,
>
>On 23/4/25 11:40, Thomas Huth wrote:
>> On 23/04/2025 11=2E31, Bernhard Beschow wrote:
>>>=20
>>>=20
>>> Am 10=2E April 2025 06:05:35 UTC schrieb Thomas Huth <thuth@redhat=2Ec=
om>:
>>>> On 09/04/2025 22=2E26, Bernhard Beschow wrote:
>>>>> Introduce a functional test which boots Debian 12 on the imx8mp-evk =
board=2E Since
>>>>> the root filesystem resides on an SD card, the test also verifies th=
e basic
>>>>> operation of the USDHC=2E
>>>>>=20
>>>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>>>=20
>>>>> --=20
>>>>> v2:
>>>>> * Make test file executable (Thomas)
>>>>> * Omit fetch() (Thomas)
>>>>> * Omit "-accel tcg" (Thomas)
>>>>> * Add "snapshot=3Don" to make potential future tests independent
>>>>>=20
>>>>> Supersedes: 20250405214900=2E7114-1-shentey@gmail=2Ecom
>>>>> ---
>>>>> =C2=A0=C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 1 +
>>>>> =C2=A0=C2=A0 tests/functional/meson=2Ebuild=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
1 +
>>>>> =C2=A0=C2=A0 tests/functional/test_aarch64_imx8mp_evk=2Epy | 66 ++++=
++++++++++++ +++++
>>>>> =C2=A0=C2=A0 3 files changed, 68 insertions(+)
>>>>> =C2=A0=C2=A0 create mode 100755 tests/functional/test_aarch64_imx8mp=
_evk=2Epy
>>>>>=20
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index d54b5578f8=2E=2E4ceffa89dc 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -833,6 +833,7 @@ F: include/hw/arm/fsl-imx8mp=2Eh
>>>>> =C2=A0=C2=A0 F: include/hw/misc/imx8mp_*=2Eh
>>>>> =C2=A0=C2=A0 F: include/hw/pci-host/fsl_imx8m_phy=2Eh
>>>>> =C2=A0=C2=A0 F: docs/system/arm/imx8mp-evk=2Erst
>>>>> +F: tests/functional/test_aarch64_imx8mp_evk=2Epy
>>>>> =C2=A0=C2=A0 F: tests/qtest/rs5c372-test=2Ec
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 MPS2 / MPS3
>>>>> diff --git a/tests/functional/meson=2Ebuild b/tests/functional/ meso=
n=2Ebuild
>>>>> index 0f8be30fe2=2E=2Eaaaf3472f1 100644
>>>>> --- a/tests/functional/meson=2Ebuild
>>>>> +++ b/tests/functional/meson=2Ebuild
>>>>> @@ -75,6 +75,7 @@ tests_aarch64_system_quick =3D [
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 tests_aarch64_system_thorough =3D [
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 'aarch64_aspeed',
>>>>> +=C2=A0 'aarch64_imx8mp_evk',
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 'aarch64_raspi3',
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 'aarch64_raspi4',
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 'aarch64_replay',
>>>>> diff --git a/tests/functional/test_aarch64_imx8mp_evk=2Epy b/tests/ =
functional/test_aarch64_imx8mp_evk=2Epy
>>>>> new file mode 100755
>>>>> index 0000000000=2E=2E62fee74044
>>>>> --- /dev/null
>>>>> +++ b/tests/functional/test_aarch64_imx8mp_evk=2Epy
>>>>> @@ -0,0 +1,66 @@
>>>>> +#!/usr/bin/env python3
>>>>> +#
>>>>> +# Functional test that boots a Linux kernel and checks the console
>>>>> +#
>>>>> +# SPDX-License-Identifier: GPL-2=2E0-or-later
>>>>> +
>>>>> +from qemu_test import LinuxKernelTest, Asset
>>>>> +
>>>>=20
>>>> In case you respin (due to other reasons), please add a second empty =
line before the "class" statement (that's the style that we use in the othe=
r tests, too)=2E
>>>>=20
>>>> Anyway:
>>>> Reviewed-by: Thomas Huth <thuth@redhat=2Ecom>
>>>=20
>>> Ping (not for 10=2E0)
>>=20
>> Peter, should this go through your arm tree, or shall I pick it up with=
 other functional test patches for my next PR?
>
>My preference would be like with previous Avocado tests: when a
>(functional) test concerns mostly a dedicated subsystem, I'd rather see
>the dedicated subsystem maintainers to take it, so they get familiar
>with the test=2E Except if the maintainers are busy or unresponsive of
>course=2E

Ping


