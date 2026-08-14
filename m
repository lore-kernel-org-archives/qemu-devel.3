Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C75CC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wutvv-0001ia-MA; Fri, 14 Aug 2026 11:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wutvt-0001ho-HX
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 11:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wutvq-000771-PR
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 11:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786721693;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7okoVJBLZWESdwgLg7Z5BVxv/ezHszMZAamDbVRePaQ=;
 b=Xx0bjIwHtuoxGa0tiwRMMMUwFyMhz2DRNNorgO4Tj7+soZwFLKFey7t1ftU1elo7xMQtu2
 6e2nSogN7Lhuu7euc4fGSFlPIjNHHKMWEEF0na9NWJEJOeUSYDH8kWJT0aoPTMEZzXKSag
 k+8CLsanAOJXxM9xjcY5+hfEiv85tL8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-rNriyFfVM9u1GsiCgbrSyQ-1; Fri, 14 Aug 2026 11:34:52 -0400
X-MC-Unique: rNriyFfVM9u1GsiCgbrSyQ-1
X-Mimecast-MFC-AGG-ID: rNriyFfVM9u1GsiCgbrSyQ_1786721691
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4994aebe932so11921275e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 08:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786721691; x=1787326491;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7okoVJBLZWESdwgLg7Z5BVxv/ezHszMZAamDbVRePaQ=;
 b=ZSqwZHz/JOBPrMVE8QNDyXAf95HWVPk5IptbFSIRt8DG0YZW+cd1sEE/GqH/dsqERA
 wrUMhXs9xxQA4hpzhMRliIBbFneVzZalLESqjT7crOZVoxwuWNB7oIaV9qWDd5vie/IZ
 DfKQRG735/KVYVjlsaE4FXihCFl6am7Ocf5/VSkr9M5tck2kuo12VSuqenY3fI1Xj0+v
 jV3YOov9aHFQ+7tTrygh2vRigesFCNUDtoRy7a48exdIhDuq6nK5KX1Osc0NMO3nTFdH
 ZA5lWwFmZSl3a7TS2CEeRM+0CyNjJ4SrV3AF+7lbZr4H4Ho0w+fVI9HM1CO9qJ1w27nj
 tihQ==
X-Gm-Message-State: AOJu0YxeKoV1ZJp3bK4pjKGJ+1DgVpnh8VLVqTJe6X4u4NlL/nhPLwzn
 Qp+k2XvTHVBLdTwrLE+MqK1LbO5ud024v1X4YBqI5ZNQPTI3M0kYECopjDym9kk1GaDyVMp22gH
 wOGwQYlIzcG/BFd51SfyvYAjTOURd5bFBGJeN4nslf/UO5Ly/dVTEag1X
X-Gm-Gg: AR+sD12p4UT0S8TV/mG2w/fp8pK3PTH1SdHFtCkRICQ3rMfZpwhmtgL3YI/rnqS70Oi
 NYVWIGg08ycfSMsiBg/9FW+ptRSYHtnBTX45tFhPhHdDFxUqJs+PTzttCfq509lW4fZS0wHwhE7
 7OaVPWrWDO4ruQV2JcBeVSM+NH0HU5lnSVOc4QBFgHB1FEoqaiTx1uchxqVrOXcOmya34apnEKe
 Gp7s8X/shTnydDCY4vjiL9tPoudEvSOklQACKNkUGbE3ba0a8suw0eNIh/wcYtNR5tmWIjOlz1i
 S5tDXOCQo/FdojUDZOPV5FsGHmPXmdqK8yiO6F071ne9p+ChgpUpl8rAVlhmprJ92JGzgs3RV9I
 5HgBjDQWENpaLN2nUFMocjnKDig1+OeCcASrEoqIxPb+upoH+
X-Received: by 2002:a05:600c:4e13:b0:498:11b5:3ff7 with SMTP id
 5b1f17b1804b1-499879bd2e1mr94162235e9.18.1786721690590; 
 Fri, 14 Aug 2026 08:34:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4e13:b0:498:11b5:3ff7 with SMTP id
 5b1f17b1804b1-499879bd2e1mr94161455e9.18.1786721690078; 
 Fri, 14 Aug 2026 08:34:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988ae8af3sm52203945e9.4.2026.08.14.08.34.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 08:34:48 -0700 (PDT)
Message-ID: <0cb9dba3-c905-4e2d-a3e9-539dbf2ea787@redhat.com>
Date: Fri, 14 Aug 2026 17:34:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 14/19] target/arm/kvm: compute supported values for
 ID register fields
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Prerna Saxena <prerna.saxena@nutanix.com>
References: <20260716213858.609699-1-khushit.shah@nutanix.com>
 <20260716213858.609699-15-khushit.shah@nutanix.com>
 <fe76f638-81aa-43cf-aafb-c774ab1902f8@redhat.com>
 <82F566CD-CC65-4368-AE92-3A2E637CC27A@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <82F566CD-CC65-4368-AE92-3A2E637CC27A@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 8/5/26 11:58 AM, Khushit Shah wrote:
>
>> On 26 Jul 2026, at 7:52 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> Hi Khushit,
>>
>> On 7/16/26 11:38 PM, Khushit Shah wrote:
>>> Add arm_field_get_supported_values() which, for a given ID register
>>> field, builds the set of values KVM allows it to take on the live host.
>>>
>>> Non-writable fields are pinned to the host value. Writable fields follow
>>> their per field constraints. This function likely needs change when
>>> KVM starts exposing a new writable field that is not lower-safe, hence,
>>> the special handling of TGranX_2/SpecSEI/L1Ip/MIDR/REVIDR/AIDR.
>> so this looks quite risky. 
> I agree.
>
> What are your thoughts on having a authoritative list in QEMU of all
> writable fields? No matter what KVM exposes as writable, actual fields
> we allow to be writable will be intersection of KVM writable + QEMU
> writable. When The QEMU list is updated we make sure things like this
> function is updated.
>
> This get’s rid of cases where we silently support writing to a field.
> It is similar to x86, QEMU only supports writing to specific CPUID
> leafs (by the defined Properties) and not just any CPUID leafs.
>
>>> Cross-field constraints are not modelled; for example ID_AA64ZFR0_EL1
>>> is gated by SVE. Reproducing every inter-field dependency in QEMU
>>> would only duplicate KVM's logic and drift out of sync with it.
>> Isn't qmp_query_cpu_model_expansion sufficient? In general upper layers
>> will try to apply raw named models. If ajustements are needed between
>> source and destination, we know field candidate values (either the
>> source or dest one) and this latter can be directly tried using
>> qmp_query_cpu_model_expansion write. On top of that
>> qmp_query_cpu_model_expansion can be directly checked against a scratch
>> vcpu reusing the logic implemented at kernel level.
> I am not sure if it is acceptable for query_cpu_model_expansion should fail
> if model is not realisable. On at least x86 it does not. It just returns the
> state which QEMU would request KVM for the given configurations.
>
> Ref:
> https://github.com/qemu/qemu/blob/3e3ccab106f879b1512f8e0d51a827dd4de30e22/target/i386/cpu.c#L9689

I need to further study that. I will come back to you.

Currently with v7 you get:
(QEMU) query-cpu-model-expansion type=full
model={"name":"host","props":{"SYSREG_ID_AA64MMFR1_EL1_AFP":0x1}}
{"error": {"class": "GenericError", "desc": "failed to apply new value
0x1 for field AFP (previous is 0x0): Invalid argument"}}

This can be implemented elsewhere though

Eric
>
> cpu-definitions is maybe a better candidate for algo you are describing, but
> it will not take the user overrides into considerations and only say if a
> base model is usable or not
>
>
>>> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
>>> ---
>>> target/arm/kvm.c     | 99 ++++++++++++++++++++++++++++++++++++++++++++
>>> target/arm/kvm_arm.h | 26 ++++++++++++
>>> 2 files changed, 125 insertions(+)
>>>
>>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>>> index c38b99cfce..8f452f9570 100644
>>> --- a/target/arm/kvm.c
>>> +++ b/target/arm/kvm.c
>>> @@ -1262,6 +1262,105 @@ bool kvm_arm_cpu_post_load(ARMCPU *cpu)
>>>     return true;
>>> }
>>>
>>> +static bool arm_field_is_signed(const ARM64SysRegField *field)
>>> +{
>>> +    return field_matches(field, ID_AA64MMFR0_EL1_IDX, "TGran4")    ||
>>> +           field_matches(field, ID_AA64MMFR0_EL1_IDX, "TGran64")   ||
>>> +           field_matches(field, ID_MMFR0_EL1_IDX, "InnerShr")      ||
>>> +           field_matches(field, ID_MMFR0_EL1_IDX, "OuterShr")      ||
>>> +           field_matches(field, ID_AA64DFR0_EL1_IDX, "DoubleLock") ||
>>> +           field_matches(field, ID_AA64DFR0_EL1_IDX, "PMUVer")     ||
>>> +           field_matches(field, ID_DFR0_EL1_IDX, "PerfMon")        ||
>>> +           field_matches(field, ID_AA64PFR1_EL1_IDX, "MTE_frac")   ||
>>> +           field_matches(field, ID_AA64MMFR4_EL1_IDX, "E2H0")      ||
>>> +           field_matches(field, ID_DFR1_EL1_IDX, "MTPMU")          ||
>>> +           field_matches(field, ID_AA64PFR0_EL1_IDX, "FP")         ||
>>> +           field_matches(field, ID_AA64PFR0_EL1_IDX, "AdvSIMD");
>> Can't we extract this from Register.json instead?
> AFAIK, There is not signedness data in Register.json
>
>>> +}
>>> +
>>> +static void ranges_add(GArray *ranges, uint64_t min, uint64_t max)
>>> +{
>>> +    ArmFieldRange r = { .min = min, .max = max };
>>> +    g_array_append_val(ranges, r);
>>> +}
>>> +
>>> +void arm_field_get_supported_values(const ARM64SysRegField *field,
>>> +                                    const ARMISARegisters *host_isar,
>>> +                                    ArmFieldValueSet **value_set)
>>> +{
>>> +    bool is_signed = arm_field_is_signed(field);
>>> +    uint64_t host = extract64(host_isar->idregs[field->index],
>>> +                              field->shift, field->length);
>>> +    GArray *ranges = g_array_new(false, false, sizeof(ArmFieldRange));
>>> +
>>> +    /* A non-writable field can only ever hold the host value. */
>>> +    if (!arm_field_is_writable(field)) {
>>> +        ranges_add(ranges, host, host);
>>> +        goto done;
>> you already get this info from qmp_query_cpu_model_expansion
> Can you please elaborate how? I thought the current qmp_query_cpu_model_expansion
> (Your v6) only returns the writable field.
> (I have not yet looked at v7)
>
>>> +    }
>>> +
>>> +    if (field_matches(field, ID_AA64MMFR0_EL1_IDX, "TGran4_2")  ||
>>> +        field_matches(field, ID_AA64MMFR0_EL1_IDX, "TGran16_2") ||
>>> +        field_matches(field, ID_AA64MMFR0_EL1_IDX, "TGran64_2")) {
>>> +        /* Either support the host value or the "off" value */
>>> +        ranges_add(ranges, host, host);
>>> +        if (host != 1) { /* 1 = "off" */
>>> +            ranges_add(ranges, 1, 1);
>>> +        }
>>> +    } else if (field_matches(field, CTR_EL0_IDX, "L1Ip")) {
>>> +        /* Only safe to downgrade to VIPT, other values are reserved. */
>>> +        ranges_add(ranges, host, host);
>>> +        if (host != 2) { /* 2 = "VIPT" */
>>> +            ranges_add(ranges, 2, 2);
>>> +        }
>>> +    } else if (field_matches(field, ID_AA64MMFR1_EL1_IDX, "SpecSEI") ||
>>> +               field_matches(field, ID_MMFR4_EL1_IDX, "SpecSEI")) {
>>> +        /* It is safe to upgrade SpecSEI to 1, other values are reserved. */
>>> +        ranges_add(ranges, host, host);
>>> +        if (host != 1) {
>>> +            ranges_add(ranges, 1, 1);
>>> +        }
>>> +    } else if (field->index == MIDR_EL1_IDX ||
>>> +               field->index == REVIDR_EL1_IDX ||
>>> +               field->index == AIDR_EL1_IDX) {
>>> +        /*
>>> +         * No restriction on value that can be set for implementation ID
>>> +         * registers fields.
>>> +         */
>>> +        uint64_t max = 0;
>>> +        if (field->length == 64) {
>>> +            max = ~0ULL;
>>> +        } else {
>>> +            max = (1ULL << field->length) - 1;
>>> +        }
>>> +        ranges_add(ranges, 0, max);
>>> +    } else {
>>> +        /*
>>> +         * After handling the special cases, other writable fields are
>>> +         * either lower-safe or signed lower-safe.
>>> +         */
>>> +        if (field->arch_vals_count) {
>>> +            for (uint32_t i = 0; i < field->arch_vals_count; i++) {
>>> +                uint64_t av = field->arch_vals[i].value;
>>> +                int64_t v = is_signed ?
>>> +                    sextract64(av, 0, field->length) : (int64_t)av;
>>> +                int64_t hv = is_signed ?
>>> +                    sextract64(host, 0, field->length) : (int64_t)host;
>>> +                if (v <= hv) {
>>> +                    ranges_add(ranges, av, av);
>>> +                }
>>> +            }
>>> +        } else {
>>> +            g_assert(!is_signed); /* No signed field with no arch vals */
>>> +            ranges_add(ranges, 0, host);
>>> +        }
>>> +    }
>>> +done:
>>> +    *value_set = g_new0(ArmFieldValueSet, 1);
>>> +    (*value_set)->n_ranges = ranges->len;
>>> +    (*value_set)->ranges = (ArmFieldRange *)g_array_free(ranges, false);
>>> +}
>>> +
>>> static bool arm_field_skip_writeback_always(const ARM64SysRegField *field)
>>> {
>>>     /*
>>> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
>>> index 133a026036..9f15c91c4e 100644
>>> --- a/target/arm/kvm_arm.h
>>> +++ b/target/arm/kvm_arm.h
>>> @@ -143,6 +143,32 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
>>> void kvm_arm_add_vcpu_properties(ARMCPU *cpu);
>>>
>>> typedef struct ARM64SysReg ARM64SysReg;
>>> +typedef struct ARM64SysRegField ARM64SysRegField;
>>> +typedef struct ARMISARegisters ARMISARegisters;
>>> +
>>> +typedef struct ArmFieldRange {
>>> +    uint64_t min;
>>> +    uint64_t max;
>>> +} ArmFieldRange;
>>> +
>>> +typedef struct ArmFieldValueSet {
>>> +    ArmFieldRange *ranges;
>>> +    size_t n_ranges;
>>> +} ArmFieldValueSet;
>>> +
>>> +/**
>>> + * arm_field_get_supported_values:
>>> + * @field: The field to get the supported values for
>>> + * @host_isar: The host ISAR registers
>>> + * @value_set: The set of supported values for the @field
>>> + *
>>> + * Will be allocated and filled in with the supported values for the @field
>>> + * based on the host_isar and whether the field is writable or not.
>>> + * The caller must free the value_set.
>>> + */
>>> +void arm_field_get_supported_values(const ARM64SysRegField *field,
>>> +                                    const ARMISARegisters *host_isar,
>>> +                                    ArmFieldValueSet **value_set);
>>>
>>> /**
>>>  * kvm_arm_steal_time_finalize:
>> Thanks
>>
>> Eric
>


