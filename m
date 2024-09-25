Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293ABCCF9EF
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 19:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stXhD-00069I-8f; Wed, 25 Sep 2024 15:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1stXh6-00065A-Le; Wed, 25 Sep 2024 15:29:03 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1stXh2-0001vJ-Qj; Wed, 25 Sep 2024 15:28:58 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a90349aa7e5so31925766b.0; 
 Wed, 25 Sep 2024 12:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727292534; x=1727897334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5T+uzerwROlkDdzZKXuzsYZsjWOi/nuFrXhXZ0ImgKk=;
 b=lRYaqT3SEjrqQZVaH7KyoMsnJs2RZRujiWJ39oULk1JOziOwC2vBKzVSjWL38616bT
 GiyPT3XaxvkSDqkF155ReXM4CGKHw0OAOz4zFhonY3eoRYJfsD5DXQWgDtbJRR+IDpcz
 6dhIOBoR6q2WnmMyk/v7fkm2rgBVEcLCTiAlEBneJ7+8kQD4PYT4vxSsbcc2kqs0lZeU
 9fSP1EQupIu1MBltFZUlJjrLTlm4nxBkkyQ+2w6rPq0Kukd9mMltpYiUfOroBOnZFk0D
 jfeU5ZIQ4/twPymdgw2QxjU9DKYTD91k8HTap099OimTZ1Ko7fMVJp9eiZE9t8OW8eCX
 0kEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727292534; x=1727897334;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5T+uzerwROlkDdzZKXuzsYZsjWOi/nuFrXhXZ0ImgKk=;
 b=HzYw9xm/rIRdGQKyVmkNkLcDpJ+rPriiMfQcA5wf891qUNpmN7D2o6L9JBi9dn9sw2
 sPHzF4+fSbN4TN7qEe1WVpEXhPNJvxgGh7pjG6q2wqCblAU8gdaZxkxRNOOI3ELmL2Fm
 hh08ZMDz5vvPWKMx76hCALs58RJxozW6/vBA4NWbW2dL5pGpHC03tgTS9Kvq4nErYNMs
 niwGjyNsb84VVKmsz/trysLKvoDeACvtYO7CHlEBWlErswi6jjn1VXS5t3B8v5RPBiL4
 jUT1w1WNkXW/b9mxMYWfhO4whkkwPdgzOuBtPB73TkXkTDLpmJmdv2dMl6LwMl7jfFxR
 iSwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWriNRg1J7i5pgWivvPd8pR5BBfSPsFz5ghi+WBxMhRxBpyGSmy5gsJhmhfK+YovvGhw/v736MJLcPM@nongnu.org,
 AJvYcCXVUzRcildxqr9AlSXwDflZa5XzqksQmAXBw+l38o/0ou7squ4pnfxUxZ3wlby97ZdiOtEtMh8bzpQ=@nongnu.org
X-Gm-Message-State: AOJu0Yz7CwjCkZhZS9ACOCHD7PRQ2xluqDmEiVigIeRbWjMg89VUK+AO
 dR/F4oKm2mxL02PGJ86PXmZLjnnpPCTvWEBMzHYKG+21e9ZhpgJo
X-Google-Smtp-Source: AGHT+IHTJdBVy1A0Rg4Id5dz/fEc9wATCGQU02dkxTt/rjuLh7AnSQMJeYOf0X0WxEJywcYKy8OL8Q==
X-Received: by 2002:a17:907:7288:b0:a86:a30f:4aef with SMTP id
 a640c23a62f3a-a93a0360629mr393024966b.22.1727292533319; 
 Wed, 25 Sep 2024 12:28:53 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-011-049-158.77.11.pool.telefonica.de.
 [77.11.49.158]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9392f4fa95sm247581266b.54.2024.09.25.12.28.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 12:28:52 -0700 (PDT)
Date: Wed, 25 Sep 2024 19:08:45 +0000
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
Subject: Re: [PATCH 01/23] hw/ppc/e500: Do not leak struct boot_info
In-Reply-To: <755fc52d-cb33-aaf0-cbed-825321b6889f@eik.bme.hu>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-2-shentey@gmail.com>
 <755fc52d-cb33-aaf0-cbed-825321b6889f@eik.bme.hu>
Message-ID: <B263FDBA-E984-4351-81CB-1CCC09C2550E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
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



Am 23=2E September 2024 10:02:10 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>On Mon, 23 Sep 2024, Bernhard Beschow wrote:
>> The struct is allocated once with g_new0() but never free()'d=2E Fix th=
e leakage
>> by adding an attribute to struct PPCE500MachineState which avoids the
>> allocation=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> hw/ppc/e500=2Eh |  8 ++++++++
>> hw/ppc/e500=2Ec | 17 ++++-------------
>> 2 files changed, 12 insertions(+), 13 deletions(-)
>>=20
>> diff --git a/hw/ppc/e500=2Eh b/hw/ppc/e500=2Eh
>> index 8c09ef92e4=2E=2E557ce6ad93 100644
>> --- a/hw/ppc/e500=2Eh
>> +++ b/hw/ppc/e500=2Eh
>> @@ -5,10 +5,18 @@
>> #include "hw/platform-bus=2Eh"
>> #include "qom/object=2Eh"
>>=20
>> +typedef struct boot_info {
>> +    uint32_t dt_base;
>> +    uint32_t dt_size;
>> +    uint32_t entry;
>> +} boot_info;
>> +
>> struct PPCE500MachineState {
>>     /*< private >*/
>
>While at it you could remove these private markers=2E=2E=2E

Will do=2E

>
>>     MachineState parent_obj;
>>=20
>> +    boot_info boot_info;
>> +
>
>=2E=2E=2Eand drop the new line here so only the parent_obj is followed by=
 a new line as was suggested as reccomended style=2E

I'll merge struct boot_info below as C=C3=A9dric suggested=2E

Best regards,
Bernhard

>
>Regatds,
>BALATON Zoltan
>
>>     /* points to instance of TYPE_PLATFORM_BUS_DEVICE if
>>      * board supports dynamic sysbus devices
>>      */
>> diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>> index 3bd12b54ab=2E=2E75b051009f 100644
>> --- a/hw/ppc/e500=2Ec
>> +++ b/hw/ppc/e500=2Ec
>> @@ -80,13 +80,6 @@
>>=20
>> #define PLATFORM_CLK_FREQ_HZ       (400 * 1000 * 1000)
>>=20
>> -struct boot_info
>> -{
>> -    uint32_t dt_base;
>> -    uint32_t dt_size;
>> -    uint32_t entry;
>> -};
>> -
>> static uint32_t *pci_map_create(void *fdt, uint32_t mpic, int first_slo=
t,
>>                                 int nr_slots, int *len)
>> {
>> @@ -919,7 +912,6 @@ void ppce500_init(MachineState *machine)
>>     bool kernel_as_payload;
>>     hwaddr bios_entry =3D 0;
>>     target_long payload_size;
>> -    struct boot_info *boot_info =3D NULL;
>>     int dt_size;
>>     int i;
>>     unsigned int smp_cpus =3D machine->smp=2Ecpus;
>> @@ -974,9 +966,8 @@ void ppce500_init(MachineState *machine)
>>         /* Register reset handler */
>>         if (!i) {
>>             /* Primary CPU */
>> -            boot_info =3D g_new0(struct boot_info, 1);
>>             qemu_register_reset(ppce500_cpu_reset, cpu);
>> -            env->load_info =3D boot_info;
>> +            env->load_info =3D &pms->boot_info;
>>         } else {
>>             /* Secondary CPUs */
>>             qemu_register_reset(ppce500_cpu_reset_sec, cpu);
>> @@ -1274,9 +1265,9 @@ void ppce500_init(MachineState *machine)
>>     }
>>     assert(dt_size < DTB_MAX_SIZE);
>>=20
>> -    boot_info->entry =3D bios_entry;
>> -    boot_info->dt_base =3D dt_base;
>> -    boot_info->dt_size =3D dt_size;
>> +    pms->boot_info=2Eentry =3D bios_entry;
>> +    pms->boot_info=2Edt_base =3D dt_base;
>> +    pms->boot_info=2Edt_size =3D dt_size;
>> }
>>=20
>> static void e500_ccsr_initfn(Object *obj)
>>=20

