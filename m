Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746CFCEACCC
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svds7-0000bd-3S; Tue, 01 Oct 2024 10:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1svdpj-000825-BJ; Tue, 01 Oct 2024 10:26:37 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1svdpg-00077j-GU; Tue, 01 Oct 2024 10:26:33 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a8b155b5e9eso27906866b.1; 
 Tue, 01 Oct 2024 07:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727792787; x=1728397587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NN2B7VErLWPNZAtEBLafKn89g/c1M4zkYThceVJkgyE=;
 b=YgoOPOyO1LJxJsKLNJ9JJ7gWxV5fzlprZr/TBFfyaedupPvUKiXcLiP/D85QE4vSgA
 AH5cxctf53ngIU7miWEBvwbiA50Rt39GvSl9nJWlgevXiVj/WI28dmPz9UxlkzseKQIy
 ZQtWla+KMKS/Zpq6WATzE77mdlAm+bmWrmCMiB0wxrYGWNE8QsuGmDPWhDpGpUXMO0ZC
 ujXlw1Jl5269/lIbb8kUVNPXQAU8eaU7e8njff1heKpcTpzbot978MM+JUavw1DiRMkC
 5oYXTaYWqPkBrbay4Kb24F8jfSdcEaYlA31cbEMS4bPLqQCFTMgM30NI5ig2TwTq/Dc+
 1idA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727792787; x=1728397587;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NN2B7VErLWPNZAtEBLafKn89g/c1M4zkYThceVJkgyE=;
 b=QqCkez09RZqQe3qL8nJ/liMHkFfAHfMJdmY5LVJmbO/iyy6/VBDDE2FKMc8dknH+lA
 m5gcbuqMszKH9cvJ3HKLtarFxD5lzza2YocYdYuTQyohYsnWS/d9sSObUHGTp1bDY4wo
 A95XKJsPl+kezpMAJSDtoAnTzGMGe+yu1PuEl3xCvO7Yyy7ywlOsW/my8zXwyRDdyt9j
 rqdvVIwYdxCrMIDwU/i0/zAOzpUSMyEvF6iJEJK226PbAyvlkBJzkvkIDHUKWOXyqGRd
 kjD5TNWbPIo/7r6Oxr97f5/nyQrq7boG49OcqlgdZ1NTgEW8MuQk2dHrIzYrIOFOZ4hI
 uC+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRvDwiWI18p0Eh7uzUak0trJ4x6MujCtacLcQ4RSWPUQmeqgCd5149E0ObKpa6VFFnS54vA5XxOT0=@nongnu.org,
 AJvYcCXYW0KqMQ4tYMpWCJeDNLqfuNJPCZD8QptbcfZ9YEbBQ1X7UBCPtcg6CSWhcnMVHi9OTh+csKwoTSsf@nongnu.org
X-Gm-Message-State: AOJu0YwnthdMkSE8hHBm7bIIo5HPPxQvV37VZVMLYgNwC6v/DhnyKzfi
 F9lTZrlWLgvCOoFVJofOqBRfgLTjvD3Co1kk7GCgbXdnS44MED+p
X-Google-Smtp-Source: AGHT+IErvdaE2ki+7gKMX3Hiw+/3p59I4VmvYLzSDEz4uFtc741R4p5k4vC2PGTZeTZjR+Zxj0QptQ==
X-Received: by 2002:a17:906:4fd4:b0:a8a:4e39:a462 with SMTP id
 a640c23a62f3a-a93c48f90c2mr1820928166b.7.1727792786347; 
 Tue, 01 Oct 2024 07:26:26 -0700 (PDT)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c2998634sm712671466b.206.2024.10.01.07.26.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 07:26:26 -0700 (PDT)
Date: Tue, 01 Oct 2024 14:26:26 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
CC: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 01/23] hw/ppc/e500: Do not leak struct boot_info
In-Reply-To: <c823aedf-767f-6ddf-31f1-16ba667abeff@eik.bme.hu>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-2-shentey@gmail.com>
 <72a2d6aa-07c2-403f-9db5-5a17d98de6ad@redhat.com>
 <c823aedf-767f-6ddf-31f1-16ba667abeff@eik.bme.hu>
Message-ID: <2F9AA8B2-BF07-4F9C-BA0E-6403BFADF75D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
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



Am 26=2E September 2024 00:14:04 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>On Wed, 25 Sep 2024, C=C3=A9dric Le Goater wrote:
>> On 9/23/24 11:29, Bernhard Beschow wrote:
>>> The struct is allocated once with g_new0() but never free()'d=2E Fix t=
he leakage
>>> by adding an attribute to struct PPCE500MachineState which avoids the
>>> allocation=2E
>>>=20
>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>> ---
>>>   hw/ppc/e500=2Eh |  8 ++++++++
>>>   hw/ppc/e500=2Ec | 17 ++++-------------
>>>   2 files changed, 12 insertions(+), 13 deletions(-)
>>>=20
>>> diff --git a/hw/ppc/e500=2Eh b/hw/ppc/e500=2Eh
>>> index 8c09ef92e4=2E=2E557ce6ad93 100644
>>> --- a/hw/ppc/e500=2Eh
>>> +++ b/hw/ppc/e500=2Eh
>>> @@ -5,10 +5,18 @@
>>>   #include "hw/platform-bus=2Eh"
>>>   #include "qom/object=2Eh"
>>>   +typedef struct boot_info {
>>> +    uint32_t dt_base;
>>> +    uint32_t dt_size;
>>> +    uint32_t entry;
>>> +} boot_info;
>>=20
>> or simply move the fields under the machine state struct to avoif
>> the struct boot_info which doesn't seem that necessary=2E Is it ?
>
>It's passed to CPU reset function via env->load_info=2E It could be possi=
ble to pass the whole machine state but it seems that's unneeded so this st=
ruct just contains what's needed for this=2E Other machines also have simil=
ar boot_info structs although they seem to be different and not common to a=
ll machines=2E Thus I don't think merging with machine state would be bette=
r than keeping is separate as this is more CPU related=2E

I agree that having a consistent style across machines is prefereable, so =
I'll keep struct boot_info=2E It also avoids conflicts with your TLB cleanu=
p series=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>>=20
>> Thanks,
>>=20
>> C=2E
>>=20
>>=20
>>=20
>>> +
>>>   struct PPCE500MachineState {
>>>       /*< private >*/
>>>       MachineState parent_obj;
>>>   +    boot_info boot_info;
>>> +
>>>       /* points to instance of TYPE_PLATFORM_BUS_DEVICE if
>>>        * board supports dynamic sysbus devices
>>>        */
>>> diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>>> index 3bd12b54ab=2E=2E75b051009f 100644
>>> --- a/hw/ppc/e500=2Ec
>>> +++ b/hw/ppc/e500=2Ec
>>> @@ -80,13 +80,6 @@
>>>     #define PLATFORM_CLK_FREQ_HZ       (400 * 1000 * 1000)
>>>   -struct boot_info
>>> -{
>>> -    uint32_t dt_base;
>>> -    uint32_t dt_size;
>>> -    uint32_t entry;
>>> -};
>>> -
>>>   static uint32_t *pci_map_create(void *fdt, uint32_t mpic, int first_=
slot,
>>>                                   int nr_slots, int *len)
>>>   {
>>> @@ -919,7 +912,6 @@ void ppce500_init(MachineState *machine)
>>>       bool kernel_as_payload;
>>>       hwaddr bios_entry =3D 0;
>>>       target_long payload_size;
>>> -    struct boot_info *boot_info =3D NULL;
>>>       int dt_size;
>>>       int i;
>>>       unsigned int smp_cpus =3D machine->smp=2Ecpus;
>>> @@ -974,9 +966,8 @@ void ppce500_init(MachineState *machine)
>>>           /* Register reset handler */
>>>           if (!i) {
>>>               /* Primary CPU */
>>> -            boot_info =3D g_new0(struct boot_info, 1);
>>>               qemu_register_reset(ppce500_cpu_reset, cpu);
>>> -            env->load_info =3D boot_info;
>>> +            env->load_info =3D &pms->boot_info;
>>>           } else {
>>>               /* Secondary CPUs */
>>>               qemu_register_reset(ppce500_cpu_reset_sec, cpu);
>>> @@ -1274,9 +1265,9 @@ void ppce500_init(MachineState *machine)
>>>       }
>>>       assert(dt_size < DTB_MAX_SIZE);
>>>   -    boot_info->entry =3D bios_entry;
>>> -    boot_info->dt_base =3D dt_base;
>>> -    boot_info->dt_size =3D dt_size;
>>> +    pms->boot_info=2Eentry =3D bios_entry;
>>> +    pms->boot_info=2Edt_base =3D dt_base;
>>> +    pms->boot_info=2Edt_size =3D dt_size;
>>>   }
>>>     static void e500_ccsr_initfn(Object *obj)
>>=20
>>=20
>>

