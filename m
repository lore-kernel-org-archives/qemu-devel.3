Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EB6CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 14:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMoT8-0005T2-RO; Tue, 12 May 2026 10:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wMoT3-0005SW-Ms
 for qemu-devel@nongnu.org; Tue, 12 May 2026 10:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wMoT0-0002lA-Ci
 for qemu-devel@nongnu.org; Tue, 12 May 2026 10:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778597532;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9sxtl+GdLK5NvMOI7xxInAx13XkVbqDs2a0iwKfW4fk=;
 b=HDbgbHC0EYjtnFrGTCb+tqiQwxZqxjWCQiqbn/sLgGOlA+CHxs+plzgmHyMQTEtxH4fnM/
 n68XkQUbphSR3U3TGc9QIjDEOAb4gZ1hsFs9sFBO2Qug1bM8gMNFsIimSDh1afhjXebPEN
 Isvbf2kOMVg9zdJBxVGo4sQMhTU1Qy0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-FB7kqrnlNVmzsUWlbKqrUg-1; Tue, 12 May 2026 10:52:09 -0400
X-MC-Unique: FB7kqrnlNVmzsUWlbKqrUg-1
X-Mimecast-MFC-AGG-ID: FB7kqrnlNVmzsUWlbKqrUg_1778597528
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-bcdbb46dce2so316391766b.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 07:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778597528; x=1779202328;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9sxtl+GdLK5NvMOI7xxInAx13XkVbqDs2a0iwKfW4fk=;
 b=n5d72h87EKp6Rtwlr0t+5L3/Xlc7bOliIwfrWPhoQ2xsMa8QGMqNowPdj7YrEUr2t0
 KnCj/58hRcCFdCINRnI2RhcoaBzFjQdfPMRPvlHmFovqhuRGOl0JtpVE6Ie1T4bcP4ly
 W4AywdLprvcm99s+yxB4+udPkGBqKAN9OjiQPyWUPQQHsz0qZZjYUfn9AYG/ehmzH2rG
 D/5QaqEOyD6mKcmIYouernXTP1cM5DV/V42qyVIOzMoXo2+LwjNdagIKueqfRAL5A0qW
 eGsDE3qJ0ySWyZ23iOEb3tkIU6YSOhbBnfRCUwgbsXFGvgjMK5b54tmxPsp2aodBtdSU
 8aMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zw61lSMVX/W5lJiC9LrOYchjhRsI+nPcKt1T5NNLsOpSTP6dcxoKZsOZuz/jFnL4ba3lf5iw8YGiS@nongnu.org
X-Gm-Message-State: AOJu0YxnQ8sksTLHDmacW0l/DYUyZFaunx/LH5Eq7+T0YuxJZpznji8m
 7FPO/ep8XLVtOCNIBys5AxIxdNR8aTPSF9UB2VnpSSN2UKYBUEgKXU3LqMK62xHS4lqBjplbf7B
 W/KDWMJNWIHghA9x9ZihDfINmUzFTGA/8qLuZW7Knkkr+IhV24cT5uw9+
X-Gm-Gg: Acq92OH99u1FPF/RQHqv+lxCmOwWFmZ8IixMZmP+nUYMiywktj04eJbNLTUB7FCM2/q
 Mm3nOZKIV7FZInVCvMgeIjhSDwyJ/lSwiGbuLddM1lXY9P6Xink1q9OCuOopBopDcX4rI4spCQq
 b2BYZJnihqitLRj1kx3H5HJ/iYZa/fJ8AOgrCZBlkhZqjOwIErH3LPGJlbHiKWPGCVFnC9lm/69
 +KF9mECSieSOZ3TAefnRS2pjwcCjkEAAKzPGlK9XoFxOXbOiD0lXuoMJV6ETuEiRxP2/clvr7xr
 Uq2cWgN/J12nZtAYR3gobuyNnIaAh4pt0g9BA3CMfVg9jGs+9ZSUNCzrQmmbxEICoxrorTz0yfp
 S2CRUoXypDE9Mt28nKit2HS0xeLAo9XumvRWVewXbrKG4xUxopOgMMNhCEszWBbYNPlZUMw==
X-Received: by 2002:a17:907:d388:b0:bd3:8192:c8ed with SMTP id
 a640c23a62f3a-bd38192d0camr8428466b.34.1778597528127; 
 Tue, 12 May 2026 07:52:08 -0700 (PDT)
X-Received: by 2002:a17:907:d388:b0:bd3:8192:c8ed with SMTP id
 a640c23a62f3a-bd38192d0camr8424866b.34.1778597527658; 
 Tue, 12 May 2026 07:52:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67ef0dfd367sm5202207a12.17.2026.05.12.07.52.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 07:52:06 -0700 (PDT)
Message-ID: <9e1ef1c6-3ae1-4952-a295-147c1dfe82de@redhat.com>
Date: Tue, 12 May 2026 16:52:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/17] arm/cpu: Add infra to handle generated ID
 register definitions
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260503073541.790215-1-eric.auger@redhat.com>
 <20260503073541.790215-5-eric.auger@redhat.com>
 <CH3PR12MB7548456E92BB5137C5B5846FAB3C2@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548456E92BB5137C5B5846FAB3C2@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/7/26 10:58 AM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 03 May 2026 08:33
>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
>> devel@nongnu.org; qemu-arm@nongnu.org; kvmarm@lists.linux.dev;
>> peter.maydell@linaro.org; richard.henderson@linaro.org;
>> cohuck@redhat.com; sebott@redhat.com; Shameer Kolothum Thodi
>> <skolothumtho@nvidia.com>; philmd@linaro.org
>> Cc: maz@kernel.org; oliver.upton@linux.dev; pbonzini@redhat.com;
>> armbru@redhat.com; berrange@redhat.com; abologna@redhat.com;
>> jdenemar@redhat.com
>> Subject: [PATCH v4 04/17] arm/cpu: Add infra to handle generated ID register
>> definitions
>>
>> External email: Use caution opening links or attachments
>>
>>
>> The known ID regs are populated in a new initialization function
>> named initialize_cpu_sysreg_properties(). That code will be
>> automatically generated from AARCHMRS Registers.json. For the
>> time being let's just describe a single id reg, CTR_EL0. In this
>> description we only care about non RES/RAZ fields, ie. named fields.
>>
>> The registers are populated in an array indexed by ARMIDRegisterIdx
>> and their fields are added in a sorted list.
>>
>> [CH: adapted to reworked register storage]
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  target/arm/cpu-idregs.h            | 59 ++++++++++++++++++++++++++++++
>>  target/arm/cpu-sysreg-properties.c | 30 +++++++++++++++
>>  target/arm/cpu64.c                 |  3 ++
>>  target/arm/meson.build             |  3 +-
>>  4 files changed, 94 insertions(+), 1 deletion(-)
>>  create mode 100644 target/arm/cpu-idregs.h
>>  create mode 100644 target/arm/cpu-sysreg-properties.c
>>
>> diff --git a/target/arm/cpu-idregs.h b/target/arm/cpu-idregs.h
>> new file mode 100644
>> index 0000000000..4a9034594d
>> --- /dev/null
>> +++ b/target/arm/cpu-idregs.h
>> @@ -0,0 +1,59 @@
>> +/*
>> + * handle ID registers and their fields
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#ifndef ARM_CPU_CUSTOM_H
>> +#define ARM_CPU_CUSTOM_H
> ARM_CPU_IDREGS_H ?
indeed: TARGET_ARM_CPU_IDREGS__H
>
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> +#include "cpu.h"
>> +#include "cpu-sysregs.h"
>> +
>> +typedef struct ARM64SysRegField {
>> +    const char *name; /* name of the field, for instance CTR_EL0_IDC */
>> +    ARMIDRegisterIdx index; /* parent register, e.g. CTR_EL0_IDX */
>> +    int lower; /* lowest bit number of the field in the register */
>> +    int upper; /* highest bit number */
>> +} ARM64SysRegField;
>> +
>> +typedef struct ARM64SysReg {
>> +    const char *name;   /* name of the sysreg, for instance CTR_EL0 */
>> +    ARMSysRegs sysreg;
>> +    ARMIDRegisterIdx index; /* register index, e.g. CTR_EL0_IDX */
>> +    GList *fields; /* list of named fields, excluding RES* */
>> +} ARM64SysReg;
>> +
>> +void initialize_cpu_sysreg_properties(void);
>> +
>> +/*
>> + * List of exposed ID regs (automatically populated from AARCHMRS
>> Registers.json)
>> + */
>> +extern ARM64SysReg arm64_id_regs[NUM_ID_IDX];
>> +
>> +/* Allocate a new field and insert it at the head of the @reg list */
> It says insert at the head...
>
>> +static inline GList *arm64_sysreg_add_field(ARM64SysReg *reg, const char
>> *name,
>> +                                     uint8_t min, uint8_t max) {
>> +
>> +     ARM64SysRegField *field = g_new0(ARM64SysRegField, 1);
>> +
>> +     field->name = name;
>> +     field->lower = min;
>> +     field->upper = max;
>> +     field->index = reg->index;
>> +
>> +     reg->fields = g_list_append(reg->fields, field);
> But this is adding to the tail, right?
indeed use prepend instead
>
>> +     return reg->fields;
> Don't think the return is used anywhere.
now becoming static inline void 

arm64_sysreg_add_field()

Thanks

Eric

>
> Thanks,
> Shameer
>
>> +}
>> +
>> +static inline ARM64SysReg *arm64_sysreg_get(ARMIDRegisterIdx index)
>> +{
>> +        ARM64SysReg *reg = &arm64_id_regs[index];
>> +
>> +        reg->index = index;
>> +        reg->sysreg = id_register_sysreg[index];
>> +        return reg;
>> +}
>> +
>> +#endif
>> diff --git a/target/arm/cpu-sysreg-properties.c b/target/arm/cpu-sysreg-
>> properties.c
>> new file mode 100644
>> index 0000000000..5cc06c8f24
>> --- /dev/null
>> +++ b/target/arm/cpu-sysreg-properties.c
>> @@ -0,0 +1,30 @@
>> +/*
>> + * QEMU ARM CPU SYSREG PROPERTIES
>> + * will be automatically generated
>> + *
>> + * Copyright (c) Red Hat, Inc. 2026
>> + *
>> + */
>> +
>> + /* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#include "cpu-idregs.h"
>> +
>> +ARM64SysReg arm64_id_regs[NUM_ID_IDX];
>> +
>> +void initialize_cpu_sysreg_properties(void)
>> +{
>> +    memset(arm64_id_regs, 0, sizeof(ARM64SysReg) * NUM_ID_IDX);
>> +    /* CTR_EL0 */
>> +    ARM64SysReg *CTR_EL0 = arm64_sysreg_get(CTR_EL0_IDX);
>> +    CTR_EL0->name = "CTR_EL0";
>> +    arm64_sysreg_add_field(CTR_EL0, "TminLine", 32, 37);
>> +    arm64_sysreg_add_field(CTR_EL0, "DIC", 29, 29);
>> +    arm64_sysreg_add_field(CTR_EL0, "IDC", 28, 28);
>> +    arm64_sysreg_add_field(CTR_EL0, "CWG", 24, 27);
>> +    arm64_sysreg_add_field(CTR_EL0, "ERG", 20, 23);
>> +    arm64_sysreg_add_field(CTR_EL0, "DminLine", 16, 19);
>> +    arm64_sysreg_add_field(CTR_EL0, "L1Ip", 14, 15);
>> +    arm64_sysreg_add_field(CTR_EL0, "IminLine", 0, 3);
>> +}
>> +
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index a93ad2da5a..b940842d9e 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -37,6 +37,7 @@
>>  #include "hw/core/qdev-properties.h"
>>  #include "internals.h"
>>  #include "cpu-features.h"
>> +#include "cpu-idregs.h"
>>
>>  /* convert between <register>_IDX and SYS_<register> */
>>  #define DEF(NAME, OP0, OP1, CRN, CRM, OP2)      \
>> @@ -906,6 +907,8 @@ static void aarch64_cpu_register_types(void)
>>  {
>>      size_t i;
>>
>> +    initialize_cpu_sysreg_properties();
>> +
>>      for (i = 0; i < ARRAY_SIZE(aarch64_cpus); ++i) {
>>          arm_cpu_register(&aarch64_cpus[i]);
>>      }
>> diff --git a/target/arm/meson.build b/target/arm/meson.build
>> index 192ac7c31e..e2f740e48f 100644
>> --- a/target/arm/meson.build
>> +++ b/target/arm/meson.build
>> @@ -9,7 +9,8 @@ arm_user_ss.add(files('gdbstub.c'))
>>
>>  arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
>>    'cpu64.c',
>> -  'gdbstub64.c'
>> +  'gdbstub64.c',
>> +  'cpu-sysreg-properties.c',
>>  ))
>>
>>  arm_common_ss.add(files(
>> --
>> 2.53.0


