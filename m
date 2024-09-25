Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E13CCF9ED
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 19:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stXhT-0006QO-2d; Wed, 25 Sep 2024 15:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1stXh6-00065B-M9; Wed, 25 Sep 2024 15:29:03 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1stXh3-0001vv-5P; Wed, 25 Sep 2024 15:28:59 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c5cc65a8abso107179a12.3; 
 Wed, 25 Sep 2024 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727292535; x=1727897335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3+SlUNTbfPD0SQJHqh5QoPHZOskcO4CWEQCEnsUaPE=;
 b=NWu8SH2qiEf9WbSHrhxQpptM4UMzUZmm0sjyffdjNlAqzOO4DglYldT4GyvtKRHDBs
 cV/raZj6wLql0ASPjVVWBlgkjs4ph04PLSN37WaU1xAgE3y3GKNkX8rM+Kn6pEUzDTla
 tGwHgWGJbaimFitTOaD1fM5NuqMt8xHy/fp93rLjsjyYxdsJCCrcntJCs8k4Sc7T2o27
 B9V0xeSFFEMkSHqcWesSaiLm3yOZDMocXSPC3K+Dni1OzZkOEnGwBqhgDiWiPIOnCOr0
 kPjaJHf7qgP8sFWH6oVHD3IfCBh/G8Uaxhr0UxSXFAEq4+8O3fTxqAGlf1d0GtzhBFfE
 R9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727292535; x=1727897335;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3+SlUNTbfPD0SQJHqh5QoPHZOskcO4CWEQCEnsUaPE=;
 b=s8RknAaE7Y1KEfZdkBYnjl5rV0FJLsUE81stDwnwB4b/3gEVRAmE73qBDv+8PKm1mg
 WLqI0iFfpleYqk6pR8dPrY5AVXJOnFhWFToyc0D9iS5dkq4R3FLqEwH5A3/F9jDpIm0c
 jNSlhanaaK/dqikIZjIWLr1G/Xq1UMysJtHRIoGcq0QVExy/31UxCxAFwRX5eJSTdkc2
 jwVrtAaKg2khXNFLHrWwsfnEgArKdtDJp+IEPa6IlN9dYoauTHukx3BZ2BapmdnYX9IT
 KDycUtsleVW8sYxhqpKS3+0yDRliU1LPEClHj3jaP25LY0hfz5+CWHxS7nh4nOyPGTUk
 XwGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq8kj9YLuX8D9YNsaH8WNtpVcAwHyeGoIIAWhZxC10jaHYxtiYQnjfFO9A5++azetHXI5A6W51TsQYjw==@nongnu.org,
 AJvYcCVwzqW8voj+la3NsCYWkiK1Oqm0cWtsFfMz5aTTC3ZZ5k5Y5rM42KTEEuucDntgaEJ0SQYn9Tm461g=@nongnu.org,
 AJvYcCXsl6p8c+uQZ/3RcQrsXezSuO484BPn055WrXVIH1U4mlaSbdTy4rxdva54DbSnxrKynjNI3EuKbmbC@nongnu.org
X-Gm-Message-State: AOJu0Yz1oA4w+kMhuwtZR/JvdQawZC8yiZMiXVwJkY8qlW34B4tIKE/M
 KSDw9T9mRp0Gd8OHX6/ZBkMsfiIFEN+L/2irlrhzC2cQ7EwaZp2p
X-Google-Smtp-Source: AGHT+IEyDJYfCKDn3dUyslfQIHSywgK6UpGlOvornPmd+JaGDFGXZmP6wTFBhyHHg+f7NYpkiKZkQg==
X-Received: by 2002:a05:6402:2788:b0:5c7:2131:5d3 with SMTP id
 4fb4d7f45d1cf-5c721310723mr2526646a12.12.1727292534735; 
 Wed, 25 Sep 2024 12:28:54 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-049-158.77.11.pool.telefonica.de.
 [77.11.49.158]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4d7926sm2242229a12.93.2024.09.25.12.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 12:28:54 -0700 (PDT)
Date: Wed, 25 Sep 2024 19:03:20 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
CC: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 01/23] hw/ppc/e500: Do not leak struct boot_info
In-Reply-To: <72a2d6aa-07c2-403f-9db5-5a17d98de6ad@redhat.com>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-2-shentey@gmail.com>
 <72a2d6aa-07c2-403f-9db5-5a17d98de6ad@redhat.com>
Message-ID: <72A24E73-2163-44B8-B466-1108481DACD7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 25=2E September 2024 15:35:15 UTC schrieb "C=C3=A9dric Le Goater" <clg@=
redhat=2Ecom>:
>On 9/23/24 11:29, Bernhard Beschow wrote:
>> The struct is allocated once with g_new0() but never free()'d=2E Fix th=
e leakage
>> by adding an attribute to struct PPCE500MachineState which avoids the
>> allocation=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   hw/ppc/e500=2Eh |  8 ++++++++
>>   hw/ppc/e500=2Ec | 17 ++++-------------
>>   2 files changed, 12 insertions(+), 13 deletions(-)
>>=20
>> diff --git a/hw/ppc/e500=2Eh b/hw/ppc/e500=2Eh
>> index 8c09ef92e4=2E=2E557ce6ad93 100644
>> --- a/hw/ppc/e500=2Eh
>> +++ b/hw/ppc/e500=2Eh
>> @@ -5,10 +5,18 @@
>>   #include "hw/platform-bus=2Eh"
>>   #include "qom/object=2Eh"
>>   +typedef struct boot_info {
>> +    uint32_t dt_base;
>> +    uint32_t dt_size;
>> +    uint32_t entry;
>> +} boot_info;
>
>or simply move the fields under the machine state struct to avoif
>the struct boot_info which doesn't seem that necessary=2E Is it ?

Yes, this works=2E Good idea=2E

Best regards,
Bernhard

>
>
>Thanks,
>
>C=2E
>
>
>
>> +
>>   struct PPCE500MachineState {
>>       /*< private >*/
>>       MachineState parent_obj;
>>   +    boot_info boot_info;
>> +
>>       /* points to instance of TYPE_PLATFORM_BUS_DEVICE if
>>        * board supports dynamic sysbus devices
>>        */
>> diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>> index 3bd12b54ab=2E=2E75b051009f 100644
>> --- a/hw/ppc/e500=2Ec
>> +++ b/hw/ppc/e500=2Ec
>> @@ -80,13 +80,6 @@
>>     #define PLATFORM_CLK_FREQ_HZ       (400 * 1000 * 1000)
>>   -struct boot_info
>> -{
>> -    uint32_t dt_base;
>> -    uint32_t dt_size;
>> -    uint32_t entry;
>> -};
>> -
>>   static uint32_t *pci_map_create(void *fdt, uint32_t mpic, int first_s=
lot,
>>                                   int nr_slots, int *len)
>>   {
>> @@ -919,7 +912,6 @@ void ppce500_init(MachineState *machine)
>>       bool kernel_as_payload;
>>       hwaddr bios_entry =3D 0;
>>       target_long payload_size;
>> -    struct boot_info *boot_info =3D NULL;
>>       int dt_size;
>>       int i;
>>       unsigned int smp_cpus =3D machine->smp=2Ecpus;
>> @@ -974,9 +966,8 @@ void ppce500_init(MachineState *machine)
>>           /* Register reset handler */
>>           if (!i) {
>>               /* Primary CPU */
>> -            boot_info =3D g_new0(struct boot_info, 1);
>>               qemu_register_reset(ppce500_cpu_reset, cpu);
>> -            env->load_info =3D boot_info;
>> +            env->load_info =3D &pms->boot_info;
>>           } else {
>>               /* Secondary CPUs */
>>               qemu_register_reset(ppce500_cpu_reset_sec, cpu);
>> @@ -1274,9 +1265,9 @@ void ppce500_init(MachineState *machine)
>>       }
>>       assert(dt_size < DTB_MAX_SIZE);
>>   -    boot_info->entry =3D bios_entry;
>> -    boot_info->dt_base =3D dt_base;
>> -    boot_info->dt_size =3D dt_size;
>> +    pms->boot_info=2Eentry =3D bios_entry;
>> +    pms->boot_info=2Edt_base =3D dt_base;
>> +    pms->boot_info=2Edt_size =3D dt_size;
>>   }
>>     static void e500_ccsr_initfn(Object *obj)
>

