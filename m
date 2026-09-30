Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE979CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBvyC-0001r7-Ok; Wed, 30 Sep 2026 11:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xBvy4-0001pB-JE
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:11:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xBvy2-0000WT-E3
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790781092;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7wSWouChO3YJdVcdwVjl9u7Qj6YLaKikGf1NY1itGlY=;
 b=WpXn7qkRnDrlkLlD8HsuRR4U4eA8F3y4Jh+UCHs3AhbVznTi6Aohm7xIfyrdY+wsfj+LkG
 /aeebjEiVdbADjCbm7t1gZPOf9GS4kZpM83DyFsd+555o7b7DOlnZ9PTbpUcoX6LDKq+z8
 D0Sp+1nu99R61XTT4/is8SLhiv7pAvk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-avrlqCgMPC6-noR6WVSQXg-1; Wed, 30 Sep 2026 11:11:29 -0400
X-MC-Unique: avrlqCgMPC6-noR6WVSQXg-1
X-Mimecast-MFC-AGG-ID: avrlqCgMPC6-noR6WVSQXg_1790781088
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e6b5c5f44so83081055e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 08:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790781088; x=1791385888;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7wSWouChO3YJdVcdwVjl9u7Qj6YLaKikGf1NY1itGlY=;
 b=o4CH4CC7I8FoelFte7TDDGEdQXI0XSbjfvif2MrLOBEkmgUajXd5QRcgfB44nEWj2c
 u2f5YUVzAzhmi0iEoQbFmME4WYBwHnLBU2BdK1mdAXbrxzwXpVdZcAOoYDxXDneoPlgQ
 JPVBBOVDQqepFHyVyvE1FT36lYvZ6JyGdznWPS6K5HAwROwdmBchgK7uLvS6i6CU2wN0
 M2jSntRZgg8l2/yGBY8zkb+UzRXfbY+jmG/Ym1t8fXC/8a+YdicpbeR/aI+hULvhqDYS
 VvdJ/cVxy4uJHWO6AKp0dBvd7J2ZlwtA7h/i6m7lw3e7VUkcv0a+q5SHbPo5Opwx+Uqs
 NFAw==
X-Forwarded-Encrypted: i=1;
 AKwUvByQXOMScCLTP3EAqifpg746WljZrSY0kYy8VN/HHiqwFZpg4H7ey+x4vy5Ua8NRH8iYc64zyGNyb2/R@nongnu.org
X-Gm-Message-State: AFuF++mqsAYkjvj/bF8BVYwQmzDtf2mDqnLK+ZeYYtutemKjq0JlWRSe
 JMtxcjUTqTxS/JRUyjeZzSt0V5LzFuI41BN6HOMCJ2eJTk+5HbcusUYV+rhEgTIUFsdD1SIju/L
 lxQWULBzc8Hk5O506CQVv5CrsqnCq/dHyzIGrjTTkjWMh7Prsz7e3CDqH
X-Gm-Gg: AYBFou2qohyYsl7ybTgQRZeinz+10h5WYsr+jq5NEr+xU12UkIux24wbzeyDpvvW86J
 9wwoapINuMEETK+XjFb0EaBtZFGyHQKBjrE+m3EZ0AeP31FmNUipTuYm45v/g28VC8Soq4SreRL
 5F9aIjOsKh0888KjYp1UmPBZg3+8l7vYA75ZbKM2t7ZH2Q8RcpmL2fdqe+cjXliCyk76z7thz8i
 nrxZE9ahTABVxlpIWRWO8jdUFKrEYE3wx1ijFtzSM3La96JCihiefpNyKGZiort9+/+cQSllh5m
 Dthwg5OC+lSFl6Kz3JtIHT5HfXhMmt2qOTrP3U8LAzlouwiR6lgBFxMfMPwR/FALKg+Am+dd6gn
 lRcfniSutBKmDbz87ZbFmEweqF+WV5h/EU60lylAgcz+vjGQ8
X-Received: by 2002:a05:600c:3111:b0:49f:bc28:e8bc with SMTP id
 5b1f17b1804b1-4a01afe731dmr31701735e9.17.1790781088255; 
 Wed, 30 Sep 2026 08:11:28 -0700 (PDT)
X-Received: by 2002:a05:600c:3111:b0:49f:bc28:e8bc with SMTP id
 5b1f17b1804b1-4a01afe731dmr31701265e9.17.1790781087824; 
 Wed, 30 Sep 2026 08:11:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01e66b39csm4907525e9.15.2026.09.30.08.11.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 08:11:27 -0700 (PDT)
Message-ID: <f7e35493-02a4-4aa6-ac37-8d37369fa4e7@redhat.com>
Date: Wed, 30 Sep 2026 17:11:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 16/26] target/arm/kvm: Apply SYSREG props to the final
 vcpu
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
 <20260916144721.751810-17-eric.auger@redhat.com>
 <8F110441-6D38-4134-9196-76AFA021250F@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <8F110441-6D38-4134-9196-76AFA021250F@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 9/28/26 12:44 PM, Khushit Shah wrote:
>
>> On 16 Sep 2026, at 8:15 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> SYSREG prop settings were recorded in a hashtable but they
>> are not yet injected on guest. Iterate over all set fields and
>> apply the new value through KVM_SET_ONE_REG. The new field
>> value overrides the current observable vcpu register value.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> With this, I suppose, what named models will do is directly write to
> ID register state, As it also defines state which affects vCPU init flags also.
>
>> ---
>> target/arm/kvm.c        | 65 +++++++++++++++++++++++++++++++++++++++++
>> target/arm/trace-events |  1 +
>> 2 files changed, 66 insertions(+)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 3ec2618cc1..ddf320d0e6 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -343,6 +343,9 @@ static ARM64SysRegField *get_field(int i, ARM64SysReg *reg)
>> #define MAKE_IDREG_KEY(reg_idx, field_shift) \
>>     (((uint64_t)(reg_idx) << 8) | ((uint64_t)(field_shift) & 0xFF))
>>
>> +#define KEY_TO_REG_IDX(key)     ((uint32_t)(((uint64_t)(key)) >> 8))
>> +#define KEY_TO_SHIFT(key)       ((uint8_t)(((uint64_t)(key)) & 0xFF))
>> +
>> static void set_sysreg_prop(Object *obj, Visitor *v,
>>                             const char *name, void *opaque,
>>                             Error **errp)
>> @@ -2215,6 +2218,63 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
>>     return 0;
>> }
>>
>> +static int kvm_arm_apply_sysreg_props(ARMCPU *cpu, Error **errp)
>> +{
>> +    uint64_t *idregs = cpu->isar.idregs;
>> +    gpointer key_ptr, value_ptr;
>> +    CPUState *cs = CPU(cpu);
>> +    GHashTableIter iter;
>> +
>> +    g_hash_table_iter_init(&iter, cpu->sysreg_props);
>> +
>> +    while (g_hash_table_iter_next(&iter, &key_ptr, &value_ptr)) {
>> +        uint64_t key = (uint64_t)key_ptr;
>> +        uint64_t value = (uint64_t)value_ptr;
>> +        uint32_t reg_idx = KEY_TO_REG_IDX(key);
>> +        uint8_t lower    = KEY_TO_SHIFT(key);
>> +        ARM64SysReg *reg = &arm64_id_regs[reg_idx];
>> +        struct kvm_one_reg kvm_reg;
>> +        uint64_t current, old, mask;
>> +        uint64_t kvm_idx;
>> +        ARM64SysRegField *field = get_field(lower, reg);
>> +        int length = field->length;
>> +        uint64_t oldfv;
>> +        int ret;
>> +
>> +        mask = MAKE_64BIT_MASK(lower, length);
>> +        value = value << lower;
>> +
>> +        old = idregs[reg_idx];
>> +
>> +        kvm_idx = idregs_sysreg_to_kvm_reg(id_register_sysreg[reg_idx]);
>> +        ret = read_sys_reg64(cs->kvm_fd, &current, kvm_idx);
>> +        if (ret) {
>> +            error_setg(errp, "failed to read the current value of %s",
>> +                       reg->name);
>> +            return ret;
>> +        }
>> +        oldfv = (current & mask) >> lower;
>> +
>> +        idregs[reg_idx] = current & ~mask;
>> +        idregs[reg_idx] |= value;
>> +        kvm_reg.id = kvm_idx;
>> +        kvm_reg.addr = (uintptr_t)&idregs[reg_idx];
>> +
> We can ignore this if value == old value
>
>> +        ret = ioctl(cs->kvm_fd, KVM_SET_ONE_REG, &kvm_reg);
>> +        if (ret) {
>> +            error_setg(errp, "failed to apply new value 0x%"PRIx64" for field %s.%s "
>> +                       "(previous is 0x%"PRIx64"): %m", idregs[reg_idx],
>> +                       reg->name, field->name, oldfv);
>> +            return ret;
>> +        }
>> +
>> +        trace_apply_sysreg_prop(reg->name, field->name, old, current,
>> +                                mask, value, idregs[reg_idx]);
>> +    }
>> +    return 0;
>> +}
>> +
>> int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
>> {
>>     int ret;
>> @@ -2315,6 +2375,11 @@ int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
>>     }
>>     cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
>>
>> +    ret = kvm_arm_apply_sysreg_props(cpu, errp);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
> This should also happen on vCPU reset.
>
> Overall, I like this approach as if the user does not provide any property overrides, it should behave the same as older builds.
to me the risky part if the initialization of all cpu->isar.idregs[]
from host which can have side effects like the CLDIR_EL1 story.

Eric
>
> Warm Regards,
> Khushit
>>     return kvm_arm_init_cpreg_list(cpu);
>> }
>>
>> diff --git a/target/arm/trace-events b/target/arm/trace-events
>> index d72ad6b671..b4d2b45a7d 100644
>> --- a/target/arm/trace-events
>> +++ b/target/arm/trace-events
>> @@ -18,6 +18,7 @@ kvm_arm_writable_idregs_to_cpreg_list(const char *name, uint64_t previous, uint6
>> decode_idreg_writemap(const char* name, int lower, int upper, char *prop_name) "%s [%d:%d] is writable (prop %s)"
>> get_sysreg_prop(const char *name, uint64_t value) "%s 0x%"PRIx64
>> set_sysreg_prop(const char *name, uint64_t old, uint64_t mask, uint64_t field_value, uint64_t new) "%s old reg value=0x%"PRIx64" mask=0x%"PRIx64" new field value=0x%"PRIx64" new reg value=0x%"PRIx64
>> +apply_sysreg_prop(const char *reg_name, const char *field_name, uint64_t old, uint64_t current, uint64_t mask, uint64_t field_value, uint64_t new) "%s.%s old=0x%"PRIx64" current=0x%"PRIx64" mask=0x%"PRIx64" new field value=0x%"PRIx64" new=0x%"PRIx64
>> nb_sysreg_props(const char *name, int count) "%s: %d SYSREG properties"
>>
>> # cpu.c
>> -- 
>> 2.53.0
>>


