Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6C2CF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 20:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stBkC-0004wv-Me; Tue, 24 Sep 2024 16:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1stBk7-0004vq-67; Tue, 24 Sep 2024 16:02:39 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1stBk4-00017Q-Ts; Tue, 24 Sep 2024 16:02:38 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a8d2b24b7a8so39465066b.1; 
 Tue, 24 Sep 2024 13:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727208154; x=1727812954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3NSD7gr2EOCFdatq9TGgjZ/qMFpXgKetLHJFff2Lzc=;
 b=Ts3UC6v36rlJefIhHsa1wX6DO0S0fBZN2G5JjPJ20RigLtrtkI69jai1yYeWR/GhZH
 DM0VyYt50W5ij8Jl9/TYDn1gFdZGTKtKTcfMI8w/SxYcUseEPLWOUOuDO7bObXZAmWJ5
 9ynmgq9+xoXYG+qSsT1hP7ijVrM67C64HsBrg7g+RMOoyxNoqfWf5TPkpoSbIIDliPcA
 rydEtVDDgPEc3TI8VR1wONgJaI+uSt1EoSfpHxX0OuCswruYwHA+8ORxDRMK/JVGtWQX
 Z0XfufSPWPinI28gMIqIBD27RQvTNUKkt2GU1OHvGkVjNNev/8hmbEl182BX0DmE8+xc
 i3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727208154; x=1727812954;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z3NSD7gr2EOCFdatq9TGgjZ/qMFpXgKetLHJFff2Lzc=;
 b=aOMERs31fHUp0rwnzUWTXt7C9l+5CowsmwqctI4Z7TlDqdfpxpXOm3shBj78Wi5eCW
 5Xe4TKa7xyDzPwin6a9lDIjSqz/A5iIURLiMGD/INfOzxQ5LJS27hUM5qDv/0RVfcQjs
 tCXNzqt/O1TnSO1T8fJ99ZrDcuVJy37kGe59MPgB6K5tRTvmXdV0/tE8p6ONZgmzzMG9
 OjGb3Z4XxDK/0bIlUE2XaTMQnKC430stLOx8fjRrolOJZgmBE80pWgdbwIHofASPeYK4
 DH0zhPhc8RWn46Axw38PFwSBlQuWhG7t46pY+DtBjLoVsr06RdXrsZcA87gXaavAce8H
 PT0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU22+fu6C4dbT7uzi/+LIR1pSm0oaiCXWHMky4ac9sxR4M7IeqUB/3POKstSqsPpgFpBvCrWhDoOw3q@nongnu.org,
 AJvYcCWQfhTPbo/068MA2iG5ZE/6J/Lwcv25Wwhydk7npxSsY4hxn2tPSt04/XNeFKcLjX8OT5XbzY2boPE=@nongnu.org
X-Gm-Message-State: AOJu0YwPaw6ZtCanPAhQYSj/x1mgPODqUpqgXPzuy4IRdnQY8c65XQiH
 Qd0n896vwjiji2rUJCljKAHf+oe7nmSSASgAgSENmNIXvp0dcc/L
X-Google-Smtp-Source: AGHT+IFSCfPEOseS0LqPnJ8JRgZrfsOpVa8N6pQSVcyvev03SWSre4VMdgZukKllPPhLaLLu+RgX3w==
X-Received: by 2002:a17:907:2da2:b0:a7d:c464:d5f3 with SMTP id
 a640c23a62f3a-a93a16cfb5dmr32600766b.11.1727208153654; 
 Tue, 24 Sep 2024 13:02:33 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-172-208.77.11.pool.telefonica.de.
 [77.11.172.208]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930c8a8bsm125824866b.131.2024.09.24.13.02.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2024 13:02:33 -0700 (PDT)
Date: Tue, 24 Sep 2024 20:02:31 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH 07/23] hw/ppc/e500: Extract ppce500_ccsr.c
In-Reply-To: <001e172d-4046-66cc-4758-a7a206fda931@eik.bme.hu>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-8-shentey@gmail.com>
 <001e172d-4046-66cc-4758-a7a206fda931@eik.bme.hu>
Message-ID: <7BA1D025-2B5B-4090-B9DF-A73F43BA6BB9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 23=2E September 2024 10:38:46 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>On Mon, 23 Sep 2024, Bernhard Beschow wrote:
>> The device model already has a header file=2E Also extract its implemen=
tation into
>> an accompanying source file like other e500 devices=2E
>>=20
>> This commit is also a preparation for the next commit=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> MAINTAINERS           |  2 +-
>> hw/ppc/e500-ccsr=2Eh    |  2 ++
>> hw/ppc/e500=2Ec         | 17 -----------------
>> hw/ppc/ppce500_ccsr=2Ec | 38 ++++++++++++++++++++++++++++++++++++++
>
>Maybe you could call it e500_ccsr=2Ec and also rename the header to e500_=
ccsr=2Eh (underscore instead of dash) to match them=2E Or if you want to ma=
tch ppce500_spin=2Ec then maybe move contents of e500-ccsr=2Eh to e500=2Eh?

Yeah, naming is hard=2E I'd actually prefer something like fsl_immr=2E* (t=
aking inspiration from device tree here) to not confuse the whole SoC with =
the CPU=2E With the ppce500 prefix I was sticking to the convention of the =
PCIE device=2E Though there is also mpc-i2c and fsl_etsec=2E=2E=2E

>(More below=2E=2E=2E)
>
>> hw/ppc/meson=2Ebuild    |  1 +
>> 5 files changed, 42 insertions(+), 18 deletions(-)
>> create mode 100644 hw/ppc/ppce500_ccsr=2Ec
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ffacd60f40=2E=2Eb7c8b7ae72 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1433,7 +1433,7 @@ e500
>> L: qemu-ppc@nongnu=2Eorg
>> S: Orphan
>> F: hw/ppc/e500*
>> -F: hw/ppc/ppce500_spin=2Ec
>> +F: hw/ppc/ppce500_*=2Ec
>> F: hw/gpio/mpc8xxx=2Ec
>> F: hw/i2c/mpc_i2c=2Ec
>> F: hw/net/fsl_etsec/
>> diff --git a/hw/ppc/e500-ccsr=2Eh b/hw/ppc/e500-ccsr=2Eh
>> index 249c17be3b=2E=2E3ab7e72568 100644
>> --- a/hw/ppc/e500-ccsr=2Eh
>> +++ b/hw/ppc/e500-ccsr=2Eh
>> @@ -4,6 +4,8 @@
>> #include "hw/sysbus=2Eh"
>> #include "qom/object=2Eh"
>>=20
>> +#define MPC8544_CCSRBAR_SIZE       0x00100000ULL
>> +
>> struct PPCE500CCSRState {
>>     /*< private >*/
>>     SysBusDevice parent;
>> diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>> index 2225533e33=2E=2E4ee4304a8a 100644
>> --- a/hw/ppc/e500=2Ec
>> +++ b/hw/ppc/e500=2Ec
>> @@ -61,7 +61,6 @@
>> #define RAM_SIZES_ALIGN            (64 * MiB)
>>=20
>> /* TODO: parameterize */
>> -#define MPC8544_CCSRBAR_SIZE       0x00100000ULL
>> #define MPC8544_MPIC_REGS_OFFSET   0x40000ULL
>> #define MPC8544_MSI_REGS_OFFSET   0x41600ULL
>> #define MPC8544_SERIAL0_REGS_OFFSET 0x4500ULL
>> @@ -1264,21 +1263,6 @@ void ppce500_init(MachineState *machine)
>>     pms->boot_info=2Edt_size =3D dt_size;
>> }
>>=20
>> -static void e500_ccsr_initfn(Object *obj)
>> -{
>> -    PPCE500CCSRState *ccsr =3D CCSR(obj);
>> -    memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
>> -                       MPC8544_CCSRBAR_SIZE);
>> -    sysbus_init_mmio(SYS_BUS_DEVICE(ccsr), &ccsr->ccsr_space);
>> -}
>> -
>> -static const TypeInfo e500_ccsr_info =3D {
>> -    =2Ename          =3D TYPE_CCSR,
>> -    =2Eparent        =3D TYPE_SYS_BUS_DEVICE,
>> -    =2Einstance_size =3D sizeof(PPCE500CCSRState),
>> -    =2Einstance_init =3D e500_ccsr_initfn,
>> -};
>> -
>> static const TypeInfo ppce500_info =3D {
>>     =2Ename          =3D TYPE_PPCE500_MACHINE,
>>     =2Eparent        =3D TYPE_MACHINE,
>> @@ -1289,7 +1273,6 @@ static const TypeInfo ppce500_info =3D {
>>=20
>> static void e500_register_types(void)
>> {
>> -    type_register_static(&e500_ccsr_info);
>>     type_register_static(&ppce500_info);
>> }
>>=20
>> diff --git a/hw/ppc/ppce500_ccsr=2Ec b/hw/ppc/ppce500_ccsr=2Ec
>> new file mode 100644
>> index 0000000000=2E=2E191a9ceec3
>> --- /dev/null
>> +++ b/hw/ppc/ppce500_ccsr=2Ec
>> @@ -0,0 +1,38 @@
>> +/*
>> + * QEMU PowerPC E500 embedded processors CCSR space emulation
>> + *
>> + * Copyright (C) 2009 Freescale Semiconductor, Inc=2E All rights reser=
ved=2E
>> + *
>> + * Author: Yu Liu,     <yu=2Eliu@freescale=2Ecom>
>> + *
>> + * This file is derived from hw/ppc440_bamboo=2Ec,
>> + * the copyright for that material belongs to the original owners=2E
>
>I think CCSR is a Freescale thing so likely this has nothing to do with p=
pc440_bamboo so this sentence was for other parts of e500=2Ec not applicabl=
e to this part=2E

Good point=2E IANAL so erred on the safe side and copied the whole license=
 text=2E I'm happy to omit this and would also prefer SPDX license identifi=
ers as long as I get the confirmation that this is legal=2E

Best regards,
Bernhard

>
>> + *
>> + * This is free software; you can redistribute it and/or modify
>> + * it under the terms of  the GNU General  Public License as published=
 by
>> + * the Free Software Foundation;  either version 2 of the  License, or
>> + * (at your option) any later version=2E
>> + */
>
>SPDX-License-Identifier seems to be preferred by some nowadays, I don't h=
ave an opinion on that so just mentioning it for consideration but I'm OK w=
ith this one too although it seems a bit long=2E
>
>Regards,
>BALATON Zoltan
>
>> +
>> +#include "qemu/osdep=2Eh"
>> +#include "e500-ccsr=2Eh"
>> +
>> +static void e500_ccsr_init(Object *obj)
>> +{
>> +    PPCE500CCSRState *ccsr =3D CCSR(obj);
>> +
>> +    memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
>> +                       MPC8544_CCSRBAR_SIZE);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(ccsr), &ccsr->ccsr_space);
>> +}
>> +
>> +static const TypeInfo types[] =3D {
>> +    {
>> +        =2Ename          =3D TYPE_CCSR,
>> +        =2Eparent        =3D TYPE_SYS_BUS_DEVICE,
>> +        =2Einstance_size =3D sizeof(PPCE500CCSRState),
>> +        =2Einstance_init =3D e500_ccsr_init,
>> +    },
>> +};
>> +
>> +DEFINE_TYPES(types)
>> diff --git a/hw/ppc/meson=2Ebuild b/hw/ppc/meson=2Ebuild
>> index 7cd9189869=2E=2E43c746795a 100644
>> --- a/hw/ppc/meson=2Ebuild
>> +++ b/hw/ppc/meson=2Ebuild
>> @@ -81,6 +81,7 @@ ppc_ss=2Eadd(when: 'CONFIG_MPC8544DS', if_true: files=
('mpc8544ds=2Ec'))
>> ppc_ss=2Eadd(when: 'CONFIG_E500', if_true: files(
>>   'e500=2Ec',
>>   'mpc8544_guts=2Ec',
>> +  'ppce500_ccsr=2Ec',
>>   'ppce500_spin=2Ec'
>> ))
>> # PowerPC 440 Xilinx ML507 reference board=2E
>>=20

