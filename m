Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB38CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 17:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSedY-0005jX-Fh; Thu, 28 May 2026 13:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSedT-0005j7-AS
 for qemu-devel@nongnu.org; Thu, 28 May 2026 13:35:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSedQ-0002Su-Pe
 for qemu-devel@nongnu.org; Thu, 28 May 2026 13:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779989707;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=svwqtWrqzM3kGhhJFVDvd8OT+guNLpygpqwmA559IC8=;
 b=bjqYrbKL+Y79Zio47lB+Q9KEoc7rBOhyL0ttYVYCmDP57kkwbSVoK9lGd7KqxxbwcxB40i
 kdtdMQcEArO29PTsJhNCLz+wQUEQ7+r0PPmO7uMYDa+uXXcaEeugs/CiLGHsk1EvOU8o+X
 fEFOox0U3Z+yah/afwinRmUx+zHLu3c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-jTJdDM4GNqyZAIxyyFEfcg-1; Thu, 28 May 2026 13:35:05 -0400
X-MC-Unique: jTJdDM4GNqyZAIxyyFEfcg-1
X-Mimecast-MFC-AGG-ID: jTJdDM4GNqyZAIxyyFEfcg_1779989704
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45e81291d62so11058628f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 10:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779989704; x=1780594504;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=svwqtWrqzM3kGhhJFVDvd8OT+guNLpygpqwmA559IC8=;
 b=BNu6AS6bSewOg1VV0RsktheSag1vnYNGnU7gOxcEfgX5AVooRs3H5FZLc7xC+4QiWP
 xkmdYYUfXwAOdTuFn2iikvZlju5J6eJMIm+5ZTcmWkx76DodhG+wWdtrxUX/E7Xq5hgB
 wdCM+f9ydSTs261M2xFUhXKm7c/jxMzkyhOK4S1UPw7SGyJbfzSc4aDeMqTH7Dytr4f5
 LxFxuNYWHb15J29vEhMudbTxvoR9L1XbBDZ4hO34OXtDiA0HxbvOItCCwucl636yV2jX
 7MtSzoexdCxkHDNzonmsuUOAIKjTEMqAKYZYYTtLjFPEYIqeC5zGpDYBCngMXLUBlN+a
 vHhQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bggjTHp/SV/mNlAWfsoSPqD9ev011iqld4muSe/QhfsNyEFXyRCjhpfAencuT27PQK1EE1mXxTl1b@nongnu.org
X-Gm-Message-State: AOJu0YxhWXdvKdTwQMwGXs0ezTNw/oF56ieaa4sIzSUteghTrB4wHL9b
 2odNsL3CtLxDbI6ALDWzLSBci0RMx7Rc/+BQXnQehOn3rQC8CleJS0owSmuUzyRPQT0koX9HVn3
 Ve0HylZbdTw9nsTHdV9342YFesmAZoJWmo2neK5swBzaGxCVcU0wQRSuu
X-Gm-Gg: Acq92OGe0jevLAsduWyvHJM628cEv3pDyxRxTDoAdw194kyxa8VTcPfIpRfNIX9pQqw
 tMAVkTUDCOlQgATVb5uZOJIOiKZF0M10Stdkij9Ag+jsVs4q/suWhedvYC4huiPEpFuA5CXs6Zp
 6tPV75FE+OgB60QEb/JptFn3iBkEnCKW5Uxd0OJmd2k+GaEmfkyMZqGfHuN8IsFHxdzXrfvd3br
 8oKxkqRzOQw6c6CdpJs2b0hal6EP8GnKT3wJ02WkvGFmIgoWGes099qZ1FcSRDNYHsKH24/NfTY
 SqZdv0Yz3AoiM0cw1n9lT+ycQw5nVfLlP+93ir4oXSnQOpSVnBlReSUx0tFt6/gBH8wqLIgcA66
 jW6TcXa8pT/JAzuxsvv4q7eRbalc5hEjBv5pcECBwrp6OtRGMn6cPAPLCJoouhqHGabsi9uGGgs
 /DuxZm
X-Received: by 2002:a05:6000:110a:b0:45e:ea65:d329 with SMTP id
 ffacd0b85a97d-45ef02900abmr246917f8f.7.1779989704180; 
 Thu, 28 May 2026 10:35:04 -0700 (PDT)
X-Received: by 2002:a05:6000:110a:b0:45e:ea65:d329 with SMTP id
 ffacd0b85a97d-45ef02900abmr246840f8f.7.1779989703639; 
 Thu, 28 May 2026 10:35:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eef267322sm948542f8f.12.2026.05.28.10.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 10:35:03 -0700 (PDT)
Message-ID: <f6c03ab6-7196-4160-acab-6a4a8dd35388@redhat.com>
Date: Thu, 28 May 2026 19:35:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/18] arm/kvm: write back modified ID regs to KVM
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
 "philmd@linaro.org" <philmd@linaro.org>, "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-13-eric.auger@redhat.com>
 <A29EDF01-278F-4975-9659-44359311204D@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <A29EDF01-278F-4975-9659-44359311204D@nutanix.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 5/27/26 4:42 PM, Khushit Shah wrote:
>
>> On 19 May 2026, at 6:57 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> In case some ID reg values were overriden after their
>> initialization in kvm_arm_get_host_cpu_features() we need to
>> copy the new value stored in isar.idregs array back to the
>> cpreg_list and then sync the cpreg_list to KVM.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>
>> ---
>>
>> v4 -> v5:
>> - only call kvm_arm_writable_idregs_to_cpreg_list and
>>  write_list_to_kvmstate if writable_map is allocated
>> - reinitialize the cpreg list after sync (Jinqian)
>> ---
>> target/arm/kvm.c        | 69 ++++++++++++++++++++++++++++++++++++++++-
>> target/arm/trace-events |  1 +
>> 2 files changed, 69 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 92219ee62e..30c5175c68 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -274,6 +274,21 @@ static uint32_t kvm_arm_sve_get_vls(int fd)
>>     return vls[0] & MAKE_64BIT_MASK(0, ARM_MAX_VQ);
>> }
>>
>> +static int kvm_feature_idx_to_idregs_idx(int kidx)
>> +{
>> +    int op1, crm, op2;
>> +    ARMSysRegs sysreg;
>> +
>> +    op1 = kidx / 64;
>> +    if (op1 == 2) {
>> +        op1 = 3;
>> +    }
>> +    crm = (kidx % 64) / 8;
>> +    op2 = kidx % 8;
>> +    sysreg = ENCODE_ID_REG(3, op1, 0, crm, op2);
>> +    return get_sysreg_idx(sysreg);
>> +}
>> +
>> static int idregs_idx_to_kvm_feature_idx(ARMIDRegisterIdx idx)
>> {
>>     ARMSysRegs sysreg = id_register_sysreg[idx];
>> @@ -1189,6 +1204,40 @@ bool kvm_arm_cpu_post_load(ARMCPU *cpu)
>>     return true;
>> }
>>
>> +/*
>> + * Copy writable ID regs from isar.idregs[] to cpreg_list
>> + * in case their value differs from the original init cpreg value
>> + */
>> +static void kvm_arm_writable_idregs_to_cpreg_list(ARMCPU *cpu)
>> +{
>> +    for (int i = 0; i < KVM_ARM_FEATURE_ID_RANGE_SIZE; i++) {
>> +        uint64_t writable_mask = cpu->writable_map[i];
>> +
>> +        if (writable_mask) {
>> +            int idx = kvm_feature_idx_to_idregs_idx(i);
>> +            ARM64SysReg *sysregdesc;
>> +            uint64_t previous, new;
>> +            uint64_t *cpreg;
>> +            uint32_t sysreg;
>> +
>> +            if (idx == -1) {
>> +                /* sysreg writable, but we don't know it */
>> +                continue;
>> +            }
>> +            sysregdesc = &arm64_id_regs[idx];
>> +            sysreg = id_register_sysreg[idx];
>> +            cpreg = kvm_arm_get_cpreg_ptr(cpu, idregs_sysreg_to_kvm_reg(sysreg));
>> +            previous = *cpreg;
>> +            new = cpu->isar.idregs[idx];
>> +            if (previous != new) {
>> +                *cpreg = new;
>> +                trace_kvm_arm_writable_idregs_to_cpreg_list(sysregdesc->name,
>> +                                                            previous, new);
>> +            }
>> +        }
>> +    }
>> +}
>> +
>> void kvm_arm_reset_vcpu(ARMCPU *cpu)
>> {
>>     int ret;
>> @@ -2140,7 +2189,25 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>     }
>>     cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
>>
>> -    return kvm_arm_init_cpreg_list(cpu);
>> +    ret = kvm_arm_init_cpreg_list(cpu);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +    /* overwrite writable ID regs with their updated property values */
>> +    if (cpu->writable_map) {
>> +        kvm_arm_writable_idregs_to_cpreg_list(cpu);
>> +        ret = write_list_to_kvmstate(cpu, KVM_PUT_FULL_STATE);
>> +        if (!ret) {
>> +            return -1;
>> +        }
>> +        /*
>> +         * modified values may have changed the visibility of some regs,
>> +         * reinitialize the cpreg_list accordingly
>> +         */
>> +         ret = kvm_arm_init_cpreg_list(cpu);
>> +    }
>> +
>> +    return ret;
>> }
>>
>> int kvm_arch_destroy_vcpu(CPUState *cs)
>> diff --git a/target/arm/trace-events b/target/arm/trace-events
>> index 8c7faf57c7..c25d2a1191 100644
>> --- a/target/arm/trace-events
>> +++ b/target/arm/trace-events
>> @@ -14,6 +14,7 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
>> # kvm.c
>> kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
>> get_host_cpu_idregs(const char *name, uint64_t value) "scratch vcpu host value for %s is 0x%"PRIx64
>> +kvm_arm_writable_idregs_to_cpreg_list(const char *name, uint64_t previous, uint64_t new) "%s overwrite default 0x%"PRIx64" with 0x%"PRIx64
>>
>> # cpu.c
>> arm_cpu_reset(uint64_t mp_aff) "cpu %" PRIu64
>> -- 
>> 2.53.0
>>
> Hi Eric, 
>
> We can not safely rely on ahcf on all configurations. This will not work for a host kernel that is booted with nested virtualisation support but qemu started without virtualisation  (i.e. -machine virt (no virtualisation=on)).
>  This happens because scratch vCPU always enables EL2 support if supported
> by the host kernel. Why limits alot of ID register fields (see limit_nv_id_reg() in
> kernel). Then the actual vCPU is initialised with ahcf->isar.idregs[] (with EL2 support). When trying to write back this will result in error.

OK I see. Thank you for reporting the issue

Eric
>
> Will attach how we solved this is separate mail/reply.
>
> Warm Regards,
> Khushit. 


