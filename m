Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DE3CA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF7Qo-0005ky-G4; Fri, 09 Oct 2026 06:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xF7Qn-0005kk-1m
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 06:02:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xF7Qk-0005lm-Do
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 06:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791540141;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qVw/AOI5Byij/EuNDA1o5GevYH9T8u9aG5UefmtnLlk=;
 b=P9WxQ/T5z5ZDtJzSN4SJ4B8I2BEQRvv4gfFP8+rD7oUpd7e/S4Wi3qC3l6k2nZ1gAOUsxo
 9kC9K8Q2/xO5JcafDcWFB09uUOPS/jbBJALRgctqPgoD5mN51O9mm62P38SkYg/5Hvoira
 EhcEmY4lL0S+iYvdiLKawrZtLUmwXYQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-krBxvaVnOLKUWT9igf_erA-1; Fri, 9 Oct 2026 10:02:19 +0000
X-MC-Unique: krBxvaVnOLKUWT9igf_erA-1
X-Mimecast-MFC-AGG-ID: krBxvaVnOLKUWT9igf_erA_1791540138
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c2e49c5ff09so689367166b.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 03:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791540138; x=1792144938;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qVw/AOI5Byij/EuNDA1o5GevYH9T8u9aG5UefmtnLlk=;
 b=wUO/5vY8AJoHYh+myi4eyNfQRfrRXRAOS0QOrggf7HtCpoF/l6jhsfEy4Y3d9DeMZB
 REM4fcJsLgEjJL2ozEnVb9rL8ZaQhj57qc573yeSUq37N6iUjJmh+MB4R/G/HsQ4phvR
 BkQtvlzrM93az5gH03U+1wM3GCEvHecS3HFzM+uGt5jr6v5nwgsOLmg9o8xZrC0WisoZ
 OuxNaGc5nYaVJnZze1gW6L04H2zJ6/d0Sjc81YiXjIme9StSsDt6Fecv8tB2jplGZXFN
 nxHdWNTdPKMLJ8CIKHSX/lg8AB0PY2+449iig7hS5EzG+lWD3Gkp2gxpT261ggkZxP2d
 zlEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCL/PWsd9K05tCbDDJ++l9MpnllVij6n/F8eEXTL+xfnQBLxAMlwoC3wSrA4l1q5QIF//oP8HNFnfx@nongnu.org
X-Gm-Message-State: AFq9FYIeT8J4zxATr7pItpa5G4M0ER70bdbKE7pEhkxSgRhNkt9lrKlO
 4EpyX/pf1nhZGw9wLa4wTJ2aL5b4/lVohXQeG3JvXKRgY8U3wq0ookzrZPpuzBshGWWWQGyat+N
 jszzIjAq+ME2wwhajky1t3u8c7DL5iYPrYChy8RpsqezVl3FRBQboX4AC
X-Gm-Gg: AYBFou2aeeasDafLZUSY1xoKEKmQRqAGJMc1RiebeCKdMAhLfOZkTiIt45A06pACmOt
 L8XvHceViyN1GiQj0LFuPc5U9BQclZQnShMUoy+EavewU7mH8QUyXNz9d0MvLXPLhleLTao1Sed
 2Y+DjsZfCTiDVAKEg6TcpBDK4DfdmKtjYp6c/kKZ7gtvB7p3TRZoKdngMt4BL0x+YCtmrMXnGu7
 5avFKcwCyYGgBqeTF0GLBG1b5UfWoPkfXrk7AR8fPp3Ud3B0/s+VEqyr4mI3radzgFribmS/9tt
 OHhcezkTqByqc2Y37t5JzesOSAvltLu+thuMa3Nm38PGeDUtngfxX+oTaB+HBATrH7sAcwcGG4k
 bQ2R9p4sObdRnM09KZiSM2lc8taNCGAwHSWJ9Apu1sMvwspIQ
X-Received: by 2002:a17:906:f5aa:b0:c26:19de:9ac5 with SMTP id
 a640c23a62f3a-c31aa0960bamr129186466b.29.1791540138030; 
 Fri, 09 Oct 2026 03:02:18 -0700 (PDT)
X-Received: by 2002:a17:906:f5aa:b0:c26:19de:9ac5 with SMTP id
 a640c23a62f3a-c31aa0960bamr129181966b.29.1791540137592; 
 Fri, 09 Oct 2026 03:02:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aca657sm3041038f8f.43.2026.10.09.03.02.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 03:02:17 -0700 (PDT)
Message-ID: <00d6c513-b5ae-45d1-a31b-9729e2ca6451@redhat.com>
Date: Fri, 9 Oct 2026 12:02:15 +0200
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
 <5AC3258F-1F6E-491E-8B38-633C52199904@nutanix.com>
 <df13670e-1502-4947-8a76-600dd045708b@redhat.com>
 <9E461CD6-E877-495A-BC4F-FB3AA32CB198@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <9E461CD6-E877-495A-BC4F-FB3AA32CB198@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/8/26 11:45 AM, Khushit Shah wrote:
>
>> On 8 Oct 2026, at 1:22 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>>
>>
>> On 9/30/26 9:54 AM, Khushit Shah wrote:
>>>> On 16 Sep 2026, at 8:15 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>>>
>>>> !-------------------------------------------------------------------|
>>>> CAUTION: External Email
>>>>
>>>> |-------------------------------------------------------------------!
>>>>
>>>> SYSREG prop settings were recorded in a hashtable but they
>>>> are not yet injected on guest. Iterate over all set fields and
>>>> apply the new value through KVM_SET_ONE_REG. The new field
>>>> value overrides the current observable vcpu register value.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> ---
>>>> target/arm/kvm.c        | 65 +++++++++++++++++++++++++++++++++++++++++
>>>> target/arm/trace-events |  1 +
>>>> 2 files changed, 66 insertions(+)
>>>>
>>>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>>>> index 3ec2618cc1..ddf320d0e6 100644
>>>> --- a/target/arm/kvm.c
>>>> +++ b/target/arm/kvm.c
>>>> @@ -343,6 +343,9 @@ static ARM64SysRegField *get_field(int i, ARM64SysReg *reg)
>>>> #define MAKE_IDREG_KEY(reg_idx, field_shift) \
>>>>    (((uint64_t)(reg_idx) << 8) | ((uint64_t)(field_shift) & 0xFF))
>>>>
>>>> +#define KEY_TO_REG_IDX(key)     ((uint32_t)(((uint64_t)(key)) >> 8))
>>>> +#define KEY_TO_SHIFT(key)       ((uint8_t)(((uint64_t)(key)) & 0xFF))
>>>> +
>>>> static void set_sysreg_prop(Object *obj, Visitor *v,
>>>>                            const char *name, void *opaque,
>>>>                            Error **errp)
>>>> @@ -2215,6 +2218,63 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
>>>>    return 0;
>>>> }
>>>>
>>>> +static int kvm_arm_apply_sysreg_props(ARMCPU *cpu, Error **errp)
>>>> +{
>>>> +    uint64_t *idregs = cpu->isar.idregs;
>>>> +    gpointer key_ptr, value_ptr;
>>>> +    CPUState *cs = CPU(cpu);
>>>> +    GHashTableIter iter;
>>>> +
>>>> +    g_hash_table_iter_init(&iter, cpu->sysreg_props);
>>>> +
>>>> +    while (g_hash_table_iter_next(&iter, &key_ptr, &value_ptr)) {
>>>> +        uint64_t key = (uint64_t)key_ptr;
>>>> +        uint64_t value = (uint64_t)value_ptr;
>>>> +        uint32_t reg_idx = KEY_TO_REG_IDX(key);
>>>> +        uint8_t lower    = KEY_TO_SHIFT(key);
>>>> +        ARM64SysReg *reg = &arm64_id_regs[reg_idx];
>>>> +        struct kvm_one_reg kvm_reg;
>>>> +        uint64_t current, old, mask;
>>>> +        uint64_t kvm_idx;
>>>> +        ARM64SysRegField *field = get_field(lower, reg);
>>>> +        int length = field->length;
>>>> +        uint64_t oldfv;
>>>> +        int ret;
>>>> +
>>>> +        mask = MAKE_64BIT_MASK(lower, length);
>>>> +        value = value << lower;
>>>> +
>>>> +        old = idregs[reg_idx];
>>>> +
>>>> +        kvm_idx = idregs_sysreg_to_kvm_reg(id_register_sysreg[reg_idx]);
>>>> +        ret = read_sys_reg64(cs->kvm_fd, &current, kvm_idx);
>>>> +        if (ret) {
>>>> +            error_setg(errp, "failed to read the current value of %s",
>>>> +                       reg->name);
>>>> +            return ret;
>>>> +        }
>>>> +        oldfv = (current & mask) >> lower;
>>>> +
>>>> +        idregs[reg_idx] = current & ~mask;
>>>> +        idregs[reg_idx] |= value;
>>>> +
>>>> +        kvm_reg.id = kvm_idx;
>>>> +        kvm_reg.addr = (uintptr_t)&idregs[reg_idx];
>>>> +
>>>> +        ret = ioctl(cs->kvm_fd, KVM_SET_ONE_REG, &kvm_reg);
>>>> +        if (ret) {
>>>> +            error_setg(errp, "failed to apply new value 0x%"PRIx64" for field %s.%s "
>>>> +                       "(previous is 0x%"PRIx64"): %m", idregs[reg_idx],
>>>> +                       reg->name, field->name, oldfv);
>>>> +            return ret;
>>>> +        }
>>> Hi Eric,
>>>
>>> The above is the only KVM-related code here. Can we split this into
>>>    1. Apply SYSREG_ props callback which resides in cpu64.c?
>>>    2. The previous writeback to cpregs function that writes back ID registers to KVM?
>> the problem is the previous method was copying all the idregs that
>> changed back to cpregs. But those idregs were populated from the "max"
>> vcpu which in some cases led to inconsistency with the final vcpu
>> setting. The setter now registers the new field value in a hash table.
>> Maybe we can just rely on an arch callback to apply them on the guest
>>
> Yes, this is what I am suggesting.
>
> What I was thinking is a KVM-specific code (kvm_arch_init_vcpu) will call callback to cpu64.c to set the property values after the vCPUs are init, and after the callback finishes, the values are written back to cpregs.
>
> With this the inconsistency problem does not arise as we will only call the callback after we properly setup the vCPU.

I have moved most of the code in cpu64, ie. hash table lookup and
cpu->isar.idregs[] update on success. The functional uses an
acceleration specific callback to apply the field value on guest vcpu.
However the arch agnostic function is still called in kvm so that the
kvmlist is synced to cpregs afterwards.

Let's see in v10 if it matches your expectations

Thanks

Eric
>
> FWIU, you are suggesting the same thing?
>
> Thanks,
> Khushit
>> Thanks
>>
>> Eric
>>> The reason being the SYSREG_ props otherwise do not work with any other accelerator.
>>> We are already trying to make the SYSREG_ getter/setter accel-agnostic.
>>>
>>> The above method still has the nicety that -cpu host without any SYSREG_ prop should
>>> behave the same as previous :)
>>>
>>> Side note:
>>> While we don’t target TCG support currently, I tried your v8 + named models on TCG
>>> (quick hack; ~20 LOC), and SYSREG_ props/named models works almost out of the box
>>> there (very minimal testing), which was cool.
>>>
>>> Thanks,
>>> Khushit
>>>
>>>> +
>>>> +        trace_apply_sysreg_prop(reg->name, field->name, old, current,
>>>> +                                mask, value, idregs[reg_idx]);
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>> int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
>>>> {
>>>>    int ret;
>>>> @@ -2315,6 +2375,11 @@ int kvm_arch_init_vcpu(CPUState *cs, Error **errp)
>>>>    }
>>>>    cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
>>>>
>>>> +    ret = kvm_arm_apply_sysreg_props(cpu, errp);
>>>> +    if (ret) {
>>>> +        return ret;
>>>> +    }
>>>> +
>>>>    return kvm_arm_init_cpreg_list(cpu);
>>>> }
>>>>
>>>> diff --git a/target/arm/trace-events b/target/arm/trace-events
>>>> index d72ad6b671..b4d2b45a7d 100644
>>>> --- a/target/arm/trace-events
>>>> +++ b/target/arm/trace-events
>>>> @@ -18,6 +18,7 @@ kvm_arm_writable_idregs_to_cpreg_list(const char *name, uint64_t previous, uint6
>>>> decode_idreg_writemap(const char* name, int lower, int upper, char *prop_name) "%s [%d:%d] is writable (prop %s)"
>>>> get_sysreg_prop(const char *name, uint64_t value) "%s 0x%"PRIx64
>>>> set_sysreg_prop(const char *name, uint64_t old, uint64_t mask, uint64_t field_value, uint64_t new) "%s old reg value=0x%"PRIx64" mask=0x%"PRIx64" new field value=0x%"PRIx64" new reg value=0x%"PRIx64
>>>> +apply_sysreg_prop(const char *reg_name, const char *field_name, uint64_t old, uint64_t current, uint64_t mask, uint64_t field_value, uint64_t new) "%s.%s old=0x%"PRIx64" current=0x%"PRIx64" mask=0x%"PRIx64" new field value=0x%"PRIx64" new=0x%"PRIx64
>>>> nb_sysreg_props(const char *name, int count) "%s: %d SYSREG properties"
>>>>
>>>> # cpu.c
>>>> -- 
>>>> 2.53.0
>


