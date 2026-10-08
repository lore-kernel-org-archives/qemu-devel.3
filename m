Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863A8CA600A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEirZ-0002TY-Uz; Thu, 08 Oct 2026 03:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xEirM-0002Sn-NA
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 03:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xEirK-0008PI-60
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 03:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791445688;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VhqT6V8g++wjj1+3kNOgPTPfwiIr9x2IrkCVTplXw/o=;
 b=XPBVnkMRE2pOS3VMYOQYqvaqhX3qHRkuF3XOxG8gZft3sxvncUlR+wYP6ViAc0Ezq6wji7
 7qv7hI5udZsKK/8IiWvglcgmkRa/Fige5lmaLbIlsKZWBqakQjhODCRsZ+mU4ccP6HMCsU
 3lWN0rvc5FQf4LqhDT6yyO+OpAgEKNo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-Tq7pSUySObC-t8bhlSjefA-1; Thu, 8 Oct 2026 07:48:07 +0000
X-MC-Unique: Tq7pSUySObC-t8bhlSjefA-1
X-Mimecast-MFC-AGG-ID: Tq7pSUySObC-t8bhlSjefA_1791445686
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48af4a0bd0fso2692159f8f.2
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 00:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791445686; x=1792050486;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VhqT6V8g++wjj1+3kNOgPTPfwiIr9x2IrkCVTplXw/o=;
 b=aQSMg6S1VGEJHhwoqoeQI+SIb56DEbLbGO+OjH0sAZG+GG0gfMy1IAxsETgNz01oY5
 q0yEdijyHK01JUdssDPVOCYrssakQQeuVK/QEMDEExpO3LpTAwGmy5PozDEVavnBawd3
 9uWgETc+W2rjRRA0GhvnHixPyJ2slcEFQBgpAqJb/paK0LzqwjV344uFGBr2P5N7AX9Q
 i2nhSvJY61aBsQcNIymrXDv20N3vN/54F3OIlQWULDG3+T2qWkLAU3hjKpM+XbCzmHpY
 6QUj68kC9s72nwEiM1ujfhXNJ80oXrMOOqO0/lJQkccDuIs1X+8qRGW1Vd3tnGHQ1WXG
 HC0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqUe9dQm1bWw8Ck1o2zohx46Bwq7qOnZTikPP7jhOqrjM0OQUpXHsxiuNKkdyyohmqnQEHhI8mWLZM@nongnu.org
X-Gm-Message-State: AFuF++l+cSAHCF1ba8k+3C2Ba/Wysq9+hLSK6FHhobEPPMUGTTiNZjU8
 3Sj4CR+sKlg51o0F9I/HZ1XtPw7arSt9oaZuc4HDPdar1rg87sVN1dnB2mobxoi7EzB5TzUvjcx
 gI/rX1w/e2B07t1g8Hado2OSpwHXEqf1vFJpjzcTIFeWBOcBE0o+6bWkq
X-Gm-Gg: AYBFou3epxo2g2oQMPv2CeYaaJwthnRahzfIPOHU1Plx5G+KEcLoG1cH+PmYvu8bd2u
 RJ2J+mJyRGFKgg4cHR47CI14h7gNgHieYiVvzATGF9ddlaXHJt+262BYht5LykJeQppCcVBf3is
 JoZ6Kzy4kjeZ0q55h6p+2p0Erx/q0y7ndmljQPy1smK2Hgw9/M5EApj9sEhqYaeJwQz7qZQMyfi
 n5uG6gxBQ98tJPDBOpiI8fsZsP4TLxM2P8+SJl0xXgHIgHKdfMla8EqBvMuIWulrwW+VGxcUDJC
 IoQA6IHKc4t0gfnBCLR8jPTgEYv7qVItJHyQlMtjerAUwlD07uSth0qzEzgb3XKLcHfZhDd5UZF
 uqSnVfKCEWnMuQvjeuHGssFZXqV1YmVltOEPvTpX8OZ26mrh1
X-Received: by 2002:a05:600c:83c4:b0:4a1:698d:3044 with SMTP id
 5b1f17b1804b1-4a180313c64mr78094445e9.11.1791445686238; 
 Thu, 08 Oct 2026 00:48:06 -0700 (PDT)
X-Received: by 2002:a05:600c:83c4:b0:4a1:698d:3044 with SMTP id
 5b1f17b1804b1-4a180313c64mr78094025e9.11.1791445685869; 
 Thu, 08 Oct 2026 00:48:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18360c5ebsm43425585e9.3.2026.10.08.00.48.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 00:48:05 -0700 (PDT)
Message-ID: <dc5aecf7-db4f-4b16-92fd-432d663ff900@redhat.com>
Date: Thu, 8 Oct 2026 09:48:03 +0200
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
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CECAE32E-9A75-4D8D-827D-9F25D026F364@nutanix.com>
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

Hi Khushit,

On 9/30/26 9:34 AM, Khushit Shah wrote:
>
>> On 16 Sep 2026, at 8:15 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> Since legacy composite options (such as SVE, virtualization, ...)
>> and new SYSREG props coexist, add some basic consistency checks.
>>
>> Those checks are performed both in kvm_arch_init_vcpu() before
>> applying the SYSREG props at the end of the initialization chain.
>>
>> Some ID reg fields corresponding to legacy composite option scope
>> are not writable. In that case we just check that the field has
>> not become writable.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Hi Eric,
>
> Gave this another look. I suggest moving this to kvm_arm_expose_idreg_properties().
> What I suggest specifically is:
> - Have a list of ID register fields which conflicts with legacy props.
this depends on the definition of "conflict". For instance does 

PMUVer conflicts with has_pmu?

Nevertheless your suggested approach could work for props below which in case they show up would trigger
        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
                   propname);

Thanks

Eric

> - in kvm_arm_expose_idreg_properties() (the new field based approach) never expose fields
>   which are part of the above list.
>
> This way the same consistency logic you have will carry over to named models by just adding different
> setters for the above field.
>
> What are your thoughts on this?
>
> Thanks,
> Khushit
>> — 
>> target/arm/kvm.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 105 insertions(+)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index ddf320d0e6..f52c03745e 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -340,6 +340,107 @@ static ARM64SysRegField *get_field(int i, ARM64SysReg *reg)
>>     return NULL;
>> }
>>
>> +
>> +/**
>> + * kvm_arm_vcpu_validate_sysreg:
>> + *
>> + * Validate a SYSREG field value is consistent with legacy composite options
>> + * Some checks are not implemented because the corresponding sysreg field
>> + * is not currently writable. In that case we make sure the field has not
>> + * become writable, which would mean the user had the capability to set the
>> + * corresponding property.
>> + *
>> + * return true if consistent. false if it is not, along with an error handle
>> + */
>> +static bool kvm_arm_vcpu_validate_sysreg(ARMCPU *cpu, ARM64SysRegField *field,
>> +                                         uint64_t value, Error **errp)
>> +{
>> +    const char *fieldname = field->name;
>> +    ARM64SysReg *sysregdesc = &arm64_id_regs[field->index];
>> +    const char *regname = sysregdesc->name;
>> +    g_autofree char *propname = g_strdup_printf("SYSREG_%s_%s", regname, fieldname);
>> +
>> +    /* virtualization */
>> +    if (!strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL2")) {
>> +        /* consistency with machine virtualization property */
>> +        if (cpu->has_el2 && value == 0) {
>> +            error_setg(errp,
>> +                "Inconsistent -machine virtualization=on and "
>> +                "%s=0", propname);
>> +            return false;
>> +        } else if (!cpu->has_el2 && value > 0) {
>> +            error_setg(errp,
>> +                "Inconsistent -machine virtualization=off and "
>> +                "%s > 0", propname);
>> +            return false;
>> +        }
>> +    /* secure */
>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL3") && value > 0) {
>> +        /* consistency with machine secure property */
>> +        error_setg(errp, "%s is set but qemu is not ready to support it",
>> +                   propname);
>> +        return false;
>> +    /* MTE */
>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64PFR1_EL1_MTE")) {
>> +        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
>> +                   propname);
>> +        return false;
>> +    /* SVE */
>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_SVE")) {
>> +        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
>> +                   propname);
>> +        return false;
>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64ZFR0_EL1_SVEver")) {
>> +        if (cpu_isar_feature(aa64_sve, cpu) && value == 0) {
>> +            error_setg(errp, "sve is set but %s is set to 0", propname);
>> +            return false;
>> +        } else if (!cpu_isar_feature(aa64_sve, cpu) && value > 0) {
>> +            error_setg(errp, "sve is not set but %s is greater than 0",
>> +                       propname);
>> +            return false;
>> +        }
>> +    /* PAUTH */
>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64ISAR1_EL1_APA")) {
>> +        /* PAUTH QARMA5 address authentification */
>> +        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
>> +                   propname);
>> +        return false;
>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64ISAR1_EL1_API")) {
>> +        /* PAUTH Impl Defined address authentification */
>> +        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
>> +                   propname);
>> +        return false;
>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64ISAR1_EL1_GPA")) {
>> +        /* QARMA5 generic code authentification */
>> +        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
>> +                   propname);
>> +        return false;
>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64ISAR1_EL1_GPI")) {
>> +        /* QARMA5 generic code authentification */
>> +        error_setg(errp, "%s is now exposed but qemu is not ready to support it",
>> +                   propname);
>> +        return false;
>> +    /* PMU */
>> +    } else if (!strcmp(propname, "SYSREG_ID_AA64DFR0_EL1_PMUVer")) {
>> +        if (cpu->has_pmu && value == 0) {
>> +            error_setg(errp, "%s is 0 whereas pmu is set", propname);
>> +            return false;
>> +        } else if (!cpu->has_pmu && value) {
>> +            error_setg(errp, "%s is non null whereas pmu is unset", propname);
>> +            return false;
>> +        }
>> +    /* aarch64 false */
>> +    } else if (!arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>> +        if ((!strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL0") ||
>> +             !strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL1") ||
>> +             !strcmp(propname, "SYSREG_ID_AA64PFR0_EL1_EL2")) && value < 2)
>> +            error_setg(errp, "%s is < 2 while aarch64 is set to off",
>> +                       propname);
>> +            return false;
>> +    }
>> +    return true;
>> +}
>> +
>> #define MAKE_IDREG_KEY(reg_idx, field_shift) \
>>     (((uint64_t)(reg_idx) << 8) | ((uint64_t)(field_shift) & 0xFF))
>>
>> @@ -2241,6 +2342,10 @@ static int kvm_arm_apply_sysreg_props(ARMCPU *cpu, Error **errp)
>>         uint64_t oldfv;
>>         int ret;
>>
>> +        if (!kvm_arm_vcpu_validate_sysreg(cpu, field, value, errp)) {
>> +            return -1;
>> +        }
>> +
>>         mask = MAKE_64BIT_MASK(lower, length);
>>         value = value << lower;
>>
>> -- 
>> 2.53.0
>>


