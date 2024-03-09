Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AE3C54791
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 18:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj1mY-0004XR-Uy; Sat, 09 Mar 2024 13:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rj1mW-0004XB-VC
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 13:50:53 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rj1mU-0006Q8-5i
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 13:50:52 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a4467d570cdso221623266b.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 10:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710010249; x=1710615049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3yXI9wsVluGva8NwXKqchP6nNhaej6qzY4J4xF7tFn4=;
 b=hADGXD0H2YQd1OCQyi6Qf1R5szLHOUR+GKPW55wr5tgD7imblPXxwU0xSATM+VG0Xc
 AcaYqez/EtDioT4TTu1W7iGKlVgeu5khzXMW218xIZmuJ48S+VVvTakJ7T85oG1A7Tig
 4O6BBiphuiGXdsb0kRuhhh5WoSBoqQijjoFwtW520cj9aPBC8fwDIe+iiFnZwRuU2VSV
 MYEYloxPg23p6b6L1RKgm+Cd2pNwe74lieqmdyq5+ISUbplnxDEEKvNaWl3VthWBrkgQ
 XR9HIAX9AkYQf2GVP2YFEJYJ+/k6fvdjXNGlhQ4I1V3H0N080YDASnfssaOkX2nonTvX
 oHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710010249; x=1710615049;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3yXI9wsVluGva8NwXKqchP6nNhaej6qzY4J4xF7tFn4=;
 b=av0B/yieLo7vOjGop68VuGRn5/zTlso/U+wGnlyN4VOJ9rZBoqZ3uwFLAMNNNN9mVL
 gxof/AIv/Fk05HWuaEBJ/EjiMX5QBPh219Ftn44iEulAnYr2u4e5pGrl1l8uPiPFVAhq
 JtOSUzhqqQYIrBlyV/CJ8yt8sCG9s4ADwLAw4bBYB/hVA091htXe1T/xeKMSsbEOTG/q
 U5LPiJpMF/bUo35kXjTn6FXAgiWYw8POohMCoGniMq1E8FeipVyVoPlKsxcS47Hmk1B4
 z8ZaPSCviCI2QZYVrdao/MIclCy4yIiHt05f5jMSGG2tPYxeUIBXv3p//QmnB3iSXHj3
 Xu+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsn92JWWRzX9A61cDzfDVBnhkkBNn8/0a4OCWbYo1hBuAJkXUSUMVd2a4Om+LzZ7AGVoB+3pyrQV5okeRTrtTGrsiVELE=
X-Gm-Message-State: AOJu0YwzBAGhg5tzy7eNNkT7M6vslEG+cwr/aKA+7vN/7CtHhGBRVS2i
 AuyY/eKHwCSaFbN3q8vR+fIrqyprV9sKRhLoGdoTiNJ0EPOR1Skn
X-Google-Smtp-Source: AGHT+IFaarp6JkVZKQhkj2E9AlUUj3NIws/Kcj3OqMIRgWs0sFqSWG1AETTRQHxm6fYDV8BM3xHa4w==
X-Received: by 2002:a17:907:7ea0:b0:a45:c66a:a062 with SMTP id
 qb32-20020a1709077ea000b00a45c66aa062mr1588871ejc.11.1710010248459; 
 Sat, 09 Mar 2024 10:50:48 -0800 (PST)
Received: from [127.0.0.1] (dynamic-078-054-250-034.78.54.pool.telefonica.de.
 [78.54.250.34]) by smtp.gmail.com with ESMTPSA id
 kl24-20020a170907995800b00a4452ed413asm1164018ejc.16.2024.03.09.10.50.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Mar 2024 10:50:48 -0800 (PST)
Date: Sat, 09 Mar 2024 18:50:37 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_hw/pci-host/pam=3A_Free_PAMMe?=
 =?US-ASCII?Q?moryRegion_from_Intel-specific_bit_handling?=
In-Reply-To: <16c61c00-30e9-41a3-b202-ec05d778e296@linaro.org>
References: <20240309134056.1605-1-shentey@gmail.com>
 <20240309134056.1605-2-shentey@gmail.com>
 <16c61c00-30e9-41a3-b202-ec05d778e296@linaro.org>
Message-ID: <E8FA1314-C5A1-4E60-A44F-DD27BC0BA5F0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
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



Am 9=2E M=C3=A4rz 2024 16:29:23 UTC schrieb "Philippe Mathieu-Daud=C3=A9" =
<philmd@linaro=2Eorg>:
>Hi Bernhard,
>
>On 9/3/24 14:40, Bernhard Beschow wrote:
>> The PAM bit extraction is currently spread across pam=2Ec and the north=
bridge
>> device models, making the extraction logic harder to comprehend=2E Also=
 note how
>> pam_update() deals with PAM_REGIONS_COUNT, even though it handles exact=
ly one
>> region=2E Fix this (at the cost of minor code duplication) by moving th=
e bit
>> extraction into the northbridge device models=2E As a side effect, pam_=
update()
>> becomes less Intel-specific which would allow it to be reused e=2Eg=2E =
in VIA
>> northbridges=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   include/hw/pci-host/pam=2Eh |  7 +++----
>>   hw/pci-host/i440fx=2Ec      |  7 +++++--
>>   hw/pci-host/pam=2Ec         | 14 +++++++-------
>>   hw/pci-host/q35=2Ec         |  5 +++--
>>   4 files changed, 18 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/include/hw/pci-host/pam=2Eh b/include/hw/pci-host/pam=2Eh
>> index 005916f826=2E=2Eb9b33aecc8 100644
>> --- a/include/hw/pci-host/pam=2Eh
>> +++ b/include/hw/pci-host/pam=2Eh
>> @@ -70,7 +70,6 @@
>>   /* PAM registers: log nibble and high nibble*/
>>   #define PAM_ATTR_WE     ((uint8_t)2)
>>   #define PAM_ATTR_RE     ((uint8_t)1)
>> -#define PAM_ATTR_MASK   ((uint8_t)3)
>
>Why not use PAM_ATTR_foo instead of MCH_HOST_BRIDGE_PAM_foo?

Could be used indeed=2E See also below=2E

>
>>   /* SMRAM register */
>>   #define SMRAM_D_OPEN           ((uint8_t)(1 << 6))
>> @@ -83,13 +82,13 @@
>>   #define PAM_REGIONS_COUNT       13
>>     typedef struct PAMMemoryRegion {
>> -    MemoryRegion alias[4];  /* index =3D PAM value */
>> -    unsigned current;
>> +    MemoryRegion alias[4];  /* index =3D mode value */
>> +    uint8_t mode;
>>   } PAMMemoryRegion;
>>     void init_pam(PAMMemoryRegion *mem, Object *owner, MemoryRegion *ra=
m,
>>                 MemoryRegion *system, MemoryRegion *pci,
>>                 uint32_t start, uint32_t size);
>> -void pam_update(PAMMemoryRegion *mem, int idx, uint8_t val);
>> +void pam_update(PAMMemoryRegion *mem, uint8_t mode);
>>     #endif /* QEMU_PAM_H */
>> diff --git a/hw/pci-host/i440fx=2Ec b/hw/pci-host/i440fx=2Ec
>> index 4f0a0438d7=2E=2Ecddd506ab0 100644
>> --- a/hw/pci-host/i440fx=2Ec
>> +++ b/hw/pci-host/i440fx=2Ec
>> @@ -64,6 +64,8 @@ struct I440FXState {
>>   #define I440FX_PAM_SIZE 7
>>   #define I440FX_SMRAM    0x72
>>   +#define I440FX_PAM_ATTR_MASK ((uint8_t)3)
>
>or (PAM_ATTR_RE|PAM_ATTR_WE)?
>
>It is odd to have I440FX_PAM_ATTR_MASK disconnected
>from the values it masks=2E

PAM_ATTR_RE and PAM_ATTR_WE are swapped in case of VIA=2E I didn't bother =
about these constants since both are currently not used at all=2E Shall I r=
emove them in case of a respin?

>
>> -void pam_update(PAMMemoryRegion *pam, int idx, uint8_t val)
>> +void pam_update(PAMMemoryRegion *pam, uint8_t mode)
>>   {
>> -    assert(0 <=3D idx && idx < PAM_REGIONS_COUNT);
>> +    g_assert(mode < ARRAY_SIZE(pam->alias));
>>   -    memory_region_set_enabled(&pam->alias[pam->current], false);
>> -    pam->current =3D (val >> ((!(idx & 1)) * 4)) & PAM_ATTR_MASK;
>
>Can we pass the mask by argument instead?

For VIA, each PAM region is defined by just two bits (rather than four as =
for Intel)=2E So a byte contains attributes for four regions instead of two=
=2E Therefore, passing a mask alone doesn't help, one needed to pass a shif=
t value as well=2E Furthermore, since PAM_ATTR_RE and PAM_ATTR_WE are swapp=
ed, it seems cleaner to just pass the final mode value=2E

Do we consider avoiding the redundancies more worthwhile than having the b=
it extraction logic together? If so, I'm fine with dropping the series unti=
l a VIA northbridge gets accepted=2E Perhaps what's missing is a bit extrac=
tion API which spans multiple bytes=2E Please let me know=2E

>
>> -    memory_region_set_enabled(&pam->alias[pam->current], true);
>> +    memory_region_set_enabled(&pam->alias[pam->mode], false);
>> +    pam->mode =3D mode;
>> +    memory_region_set_enabled(&pam->alias[pam->mode], true);
>>   }
>
>Are the VIA values different of the PAM_ATTR_foo ones?

They are different except for PAM_ATTR_MASK=2E

>
>I'm not sure this is an helpful change, I'd rather
>remove the MCH_HOST_BRIDGE_PAM_foo definitions and
>use the PAM generic ones=2E

PAM_ATTR_MASK could indeed be reused for VIA=2E I'd respin if this series =
made sense in its own right=2E

Best regsrds,
Bernhard

>
>Regards,
>
>Phil=2E

