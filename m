Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A036CA600C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 16:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEr6r-0001aS-5b; Thu, 08 Oct 2026 12:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xEr6q-0001aC-2M
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 12:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xEr6n-0007a7-Vx
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 12:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791477400;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z/UUmooO/7bIYSg6OS8d5DYV7eO6vqCdLpJnZY418WI=;
 b=cvuogL3ATCkSLWIa+905v9diX6DAEa/gtPFzv/Wv960UDOVDG+cFK3SLpHMovEC1hZzHnH
 sddxx0F/ooFNbv8lRQUYFeop7AQEEmrMLSSM5/+D60jEFw+18nbIM/rx+kkEB/XTc5hBEu
 0CA7iYrQ/MnKJ4/S2rW3794NhZ4EzVE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-Lw31-g6rPBmQbOQozP8Y0g-1; Thu, 8 Oct 2026 16:36:39 +0000
X-MC-Unique: Lw31-g6rPBmQbOQozP8Y0g-1
X-Mimecast-MFC-AGG-ID: Lw31-g6rPBmQbOQozP8Y0g_1791477398
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e6b5c5f44so80927845e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 09:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791477398; x=1792082198;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z/UUmooO/7bIYSg6OS8d5DYV7eO6vqCdLpJnZY418WI=;
 b=DK6UTDyy8nY1Hq/Q/Nth8QpVCQ5YMsKKht3TSAGpcmG8rOGI3nQkok0MgGhe1/a7LL
 MVhHP0Z5MKBN/MM03TTvH4HmElCrhIu9crMjUKCsnoQDppbeFNTTLHTwni3ff0Vfqbox
 cWBitrZZRE+CdV1dqDfW8jl00DT+OtWHP7S0M/C9VB9cpcuoXxU2bXcg0J7/NmmLlcze
 Tqna2P669I090Q/tWp+1LgmPGhmEoQJo7pgOAtFxsUNsQmm3ReL0Zg8T5jTl2aSXrgF9
 OaIzTM3Ljftt2xGoKQT1KrdDx4ZerLEfvfyZ56GWqOEN5WTz+CUQ+wjaSISiXwR/VCmu
 57wg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDRtbvTtvztgQnMmsapQKanBFTjmxPWN0lgt3dgmHqusbrcRXTSyBm16KScj5KD+GaVK9HL405im2P@nongnu.org
X-Gm-Message-State: AFuF++lQjsFx23z6LUOlqQZOFmUMdCX5bz4FWM3K/O+N8wnWl++S7soT
 kYC7PYVVFlodch/02MZZ9IGfCRFiFNsDmMS2QWdFbOs0prpZm923ZX9TmFKcFRvbcZiUni4u92M
 AUjJ4Sgu1ekUrfyIt5uKsOfi+TIZQbYgA7T3tXzYL3O+U2lTUwQ3FwtlL
X-Gm-Gg: AYBFou2UQIOV1d4yBcAG9n7KZw1dTu9Pfmrme78Vx8rj/82rX7H9N+N02o3/LbvSdr6
 +9FqmI3LnQJKRMnIW7AMVQSHYa6cpOZ1+wfji7KLsdVguZvUSzOj1ap2RQBbPBsemDJNq0lqY0v
 Cnams0fMgg+xuRHIf/3E0UE0rN3JGq9LJmDCzfFfGOwr8AuvSsyKYf8fWb3z/t9OVAfl4X5Bgcw
 e7+b2/onE0CZV0Jhv+ZLNsIL0Zz544qsthsORMCXrwVx45CnlqospIiXmWH9iSUy84WShvimZhn
 qoeqwtCa9PJGVCOy9a5UECwTMX89ToqWVaGkt0IAPM5H3g3EJcytC7bXmwA+ZVtqwaA4xAURK1M
 iwxZIYG32l/vZVCe3tpdvcI6yqFj6rAfKtixIcLzZDKQi4CUM
X-Received: by 2002:a05:600c:34cd:b0:4a1:7c7d:8881 with SMTP id
 5b1f17b1804b1-4a180311361mr114214845e9.13.1791477397739; 
 Thu, 08 Oct 2026 09:36:37 -0700 (PDT)
X-Received: by 2002:a05:600c:34cd:b0:4a1:7c7d:8881 with SMTP id
 5b1f17b1804b1-4a180311361mr114214105e9.13.1791477397310; 
 Thu, 08 Oct 2026 09:36:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18acf3a39sm1279535e9.4.2026.10.08.09.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 09:36:36 -0700 (PDT)
Message-ID: <5f053971-13a0-4130-ab57-eaf85bcef3a8@redhat.com>
Date: Thu, 8 Oct 2026 18:36:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 17/26] target/arm/kvm: Add consistency checking for
 SYSREG props
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260916144721.751810-1-eric.auger@redhat.com>
 <20260916144721.751810-18-eric.auger@redhat.com>
 <CECAE32E-9A75-4D8D-827D-9F25D026F364@nutanix.com>
 <dc5aecf7-db4f-4b16-92fd-432d663ff900@redhat.com>
 <A5B31865-5901-45F3-B782-274DA54E8615@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <A5B31865-5901-45F3-B782-274DA54E8615@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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



On 10/8/26 11:36 AM, Khushit Shah wrote:
>
>> On 8 Oct 2026, at 1:18 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> Hi Khushit,
>>
>> On 9/30/26 9:34 AM, Khushit Shah wrote:
>>>> On 16 Sep 2026, at 8:15 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>>>
>>>> !-------------------------------------------------------------------|
>>>> CAUTION: External Email
>>>>
>>>> |-------------------------------------------------------------------!
>>>>
>>>> Since legacy composite options (such as SVE, virtualization, ...)
>>>> and new SYSREG props coexist, add some basic consistency checks.
>>>>
>>>> Those checks are performed both in kvm_arch_init_vcpu() before
>>>> applying the SYSREG props at the end of the initialization chain.
>>>>
>>>> Some ID reg fields corresponding to legacy composite option scope
>>>> are not writable. In that case we just check that the field has
>>>> not become writable.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Hi Eric,
>>>
>>> Gave this another look. I suggest moving this to kvm_arm_expose_idreg_properties().
>>> What I suggest specifically is:
>>> - Have a list of ID register fields which conflicts with legacy props.
>> this depends on the definition of "conflict". For instance does 
>>
>> PMUVer conflicts with has_pmu?
>>
> Yes, PMUVer = 0 is inconsistent with has_pmu=true 
>
>> Nevertheless your suggested approach could work for props below which in case they show up would trigger
>>        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
>>                   propname);
> I was thinking of not exposing these props because we know it conflicts. So instead of checking the set props in kvm_arm_vcpu_validate_sysreg, we never expose conflicts in kvm_arm_expose_idreg_properties
>
> I am suggesting this way because for named CPU models, we will have to handle this conflicts differently.

I am afraid this a bit aggressive as a defensive approach. I like the
idea for fields that are not yet writable. We can easily switch to a
skiplist on property generation. For others for which some valid
combinations exist I would keep the existing check. But let's see how it
goes with named vcpu models. If it appears this extra complexity is not
needed we can simplify that if needed.

Thanks

Eric
>
>
> I hope this makes sense.
>
>
> Thanks,
> Khushit
>
>> Thanks
>>
>> Eric
>>
>>> - in kvm_arm_expose_idreg_properties() (the new field based approach) never expose fields
>>>  which are part of the above list.
>>>
>>> This way the same consistency logic you have will carry over to named models by just adding different
>>> setters for the above field.
>>>
>>> What are your thoughts on this?
>>>
>>> Thanks,
>>> Khushit
>>>> — 
>>>> target/arm/kvm.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++
>>>> 1 file changed, 105 insertions(+)
>>>>
>>>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>>>> index ddf320d0e6..f52c03745e 100644
>>>> --- a/target/arm/kvm.c
>>>> +++ b/target/arm/kvm.c
>>>> @@ -340,6 +340,107 @@ static ARM64SysRegField *get_field(int i, ARM64SysReg *reg)
>>>>    return NULL;
>>>> }
>>>>
>>>> +
>>>> +/**
>>>> + * kvm_arm_vcpu_validate_sysreg:
>>>> + *
>>>> + * Validate a SYSREG field value is consistent with legacy composite options
>>>> + * Some checks are not implemented because the corresponding sysreg field
>>>> + * is not currently writable. In that case we make sure the field has not
>>>> + * become writable, which would mean the user had the capability to set the
>>>> + * corresponding property.
>>>> + *
>>>> + * return true if consistent. false if it is not, along with an error handle
>>>> + */
>>>> +static bool kvm_arm_vcpu_validate_sysreg(ARMCPU *cpu, ARM64SysRegField *field,
>>>> +                                         uint64_t value, Error **errp)
>>>> +{
>>>> +    const char *fieldname = field->name;
>>>> +    ARM64SysReg *sysregdesc = &arm64_id_regs[field->index];
>>>> +    const char *regname = sysregdesc->name;
>>>> +    g_autofree char *propname = g_strdup_printf("SYSREG_%s_%s", regname, fieldname);
>>>> +
>>>> +    /* virtualization */
>>>> +    if (!strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL2")) {
>>>> +        /* consistency with machine virtualization property */
>>>> +        if (cpu->has_el2 && value == 0) {
>>>> +            error_setg(errp,
>>>> +                "Inconsistent -machine virtualization=on and "
>>>> +                "%s=0", propname);
>>>> +            return false;
>>>> +        } else if (!cpu->has_el2 && value > 0) {
>>>> +            error_setg(errp,
>>>> +                "Inconsistent -machine virtualization=off and "
>>>> +                "%s > 0", propname);
>>>> +            return false;
>>>> +        }
>>>> +    /* secure */
>>>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL3") && value > 0) {
>>>> +        /* consistency with machine secure property */
>>>> +        error_setg(errp, "%s is set but qemu is not ready to support it",
>>>> +                   propname);
>>>> +        return false;
>>>> +    /* MTE */
>>>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64PFR1_EL1_MTE")) {
>>>> +        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
>>>> +                   propname);
>>>> +        return false;
>>>> +    /* SVE */
>>>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_SVE")) {
>>>> +        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
>>>> +                   propname);
>>>> +        return false;
>>>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64ZFR0_EL1_SVEver")) {
>>>> +        if (cpu_isar_feature(aa64_sve, cpu) && value == 0) {
>>>> +            error_setg(errp, "sve is set but %s is set to 0", propname);
>>>> +            return false;
>>>> +        } else if (!cpu_isar_feature(aa64_sve, cpu) && value > 0) {
>>>> +            error_setg(errp, "sve is not set but %s is greater than 0",
>>>> +                       propname);
>>>> +            return false;
>>>> +        }
>>>> +    /* PAUTH */
>>>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64ISAR1_EL1_APA")) {
>>>> +        /* PAUTH QARMA5 address authentification */
>>>> +        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
>>>> +                   propname);
>>>> +        return false;
>>>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64ISAR1_EL1_API")) {
>>>> +        /* PAUTH Impl Defined address authentification */
>>>> +        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
>>>> +                   propname);
>>>> +        return false;
>>>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64ISAR1_EL1_GPA")) {
>>>> +        /* QARMA5 generic code authentification */
>>>> +        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
>>>> +                   propname);
>>>> +        return false;
>>>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64ISAR1_EL1_GPI")) {
>>>> +        /* QARMA5 generic code authentification */
>>>> +        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
>>>> +                   propname);
>>>> +        return false;
>>>> +    /* PMU */
>>>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64DFR0_EL1_PMUVer")) {
>>>> +        if (cpu->has_pmu && value == 0) {
>>>> +            error_setg(errp, "%s is 0 whereas pmu is set", propname);
>>>> +            return false;
>>>> +        } else if (!cpu->has_pmu && value) {
>>>> +            error_setg(errp, "%s is non null whereas pmu is unset", propname);
>>>> +            return false;
>>>> +        }
>>>> +    /* aarch64 false */
>>>> +    } else if (!arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>>>> +        if ((!strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL0") ||
>>>> +             !strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL1") ||
>>>> +             !strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL2")) && value < 2)
>>>> +            error_setg(errp, "%s is < 2 while aarch64 is set to off",
>>>> +                       propname);
>>>> +            return false;
>>>> +    }
>>>> +    return true;
>>>> +}
>>>> +
>>>> #define MAKE_IDREG_KEY(reg_idx, field_shift) \
>>>>    (((uint64_t)(reg_idx) << 8) | ((uint64_t)(field_shift) & 0xFF))
>>>>
>>>> @@ -2241,6 +2342,10 @@ static int kvm_arm_apply_sysreg_props(ARMCPU *cpu, Error **errp)
>>>>        uint64_t oldfv;
>>>>        int ret;
>>>>
>>>> +        if (!kvm_arm_vcpu_validate_sysreg(cpu, field, value, errp)) {
>>>> +            return -1;
>>>> +        }
>>>> +
>>>>        mask = MAKE_64BIT_MASK(lower, length);
>>>>        value = value << lower;
>>>>
>>>> -- 
>>>> 2.53.0
>


