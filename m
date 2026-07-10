Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA410C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAdI-00005A-QW; Fri, 10 Jul 2026 08:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wiAd7-0008Vl-Lm
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 08:46:59 -0400
Received: from out-185.mta0.migadu.com ([91.218.175.185])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wiAd4-0003cm-N5
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 08:46:57 -0400
Message-ID: <81b1df12-815b-456a-acb5-1470748d828b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783687611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AzW2irXH6Qlh2VQ5TvDh/esrttATZjJE9K2l/IHdfIQ=;
 b=MrNruQATw8wIJEeqKSJJO4dVo4XIAtrf15Lq5YnLbwrjlTEV4jG/JcCvFbfzCDP5jYI0L/
 V/UiCVNsqP4zbr880tVT2UK5sshpYJcuZc2bcELCGAvdLkDeLR+7NRcgmZVRdwPkyVDOnB
 jynmvtcGuqindmq/Mr3sFGfrJcEAxhE=
Date: Fri, 10 Jul 2026 20:46:46 +0800
MIME-Version: 1.0
Cc: cui.tao@linux.dev, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v2 1/3] target/loongarch/kvm: advertise pv features per
 vCPU
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
References: <20260710005029.345378-1-cui.tao@linux.dev>
 <20260710005029.345378-2-cui.tao@linux.dev>
 <70dc23f1-f346-2d47-4a42-e2195ea9e622@loongson.cn>
 <4f914264-be8e-4b5b-a54a-14a911855529@linux.dev>
 <471614c4-7f4e-74e2-fbf6-eb6873c67d17@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <471614c4-7f4e-74e2-fbf6-eb6873c67d17@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.185; envelope-from=cui.tao@linux.dev;
 helo=out-185.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



在 2026/7/10 16:44, Bibo Mao 写道:
> 
> 
> On 2026/7/10 下午4:09, Tao Cui wrote:
>>
>>
>> 在 2026/7/10 10:58, Bibo Mao 写道:
>>>
>>>
>>> On 2026/7/10 上午8:50, Tao Cui wrote:
>>>> From: Tao Cui <cuitao@kylinos.cn>
>>>>
>>>> kvm_set_pv_features() programs the KVM_FEATURE cpucfg attribute, which is a
>>>> per-vCPU setting. It was called from kvm_arch_put_registers() under a
>>>> function-local static guard, so it ran only once for the whole VM: only the
>>>> first vCPU got its pv features pushed to KVM, and on SMP guests the others
>>>> never saw KVM_FEATURE_IPI / KVM_FEATURE_STEAL_TIME.
>>>>
>>>> Drop the static guard and push pv features per vCPU under
>>>> KVM_PUT_FULL_STATE, the same gate kvm_set_stealtime() already uses. Host
>>>> feature detection stays in kvm_arch_init_vcpu(); the per-vCPU state write
>>>> belongs in kvm_arch_put_registers().
>>>>
>>>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>>>> ---
>>>>    target/loongarch/kvm/kvm.c | 15 ++++++---------
>>>>    1 file changed, 6 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>>>> index d6539c12ac..c557ee3c3d 100644
>>>> --- a/target/loongarch/kvm/kvm.c
>>>> +++ b/target/loongarch/kvm/kvm.c
>>>> @@ -816,7 +816,6 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>>>>    int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>>>>    {
>>>>        int ret;
>>>> -    static int once;
>>>>          ret = kvm_loongarch_put_regs_core(cs);
>>>>        if (ret) {
>>>> @@ -843,19 +842,17 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>>>>            return ret;
>>>>        }
>>>>    -    if (!once) {
>>>> +    if (level >= KVM_PUT_FULL_STATE) {
>>>> +        /*
>>>> +         * pv_features and steal time are per-vCPU state. Push them on
>>>> +         * full-state sync so every vCPU gets its own settings; the kernel
>>>> +         * clears the steal-time guest_addr on KVM_PUT_RESET_STATE.
>>>> +         */
>>>>            ret = kvm_set_pv_features(cs);
>>> pv feature is a little different from steal-time. steal-time guest_addr is created from guest OS, pv feature is created from VMM at beginning. steal-time guest_addr can be set for many times, and there is bit KVM_STEAL_PHYS_VALID checking with steal-time guest_addr, however pv feature can be set only once with existing method.
>>>
>>
>> Hi Bibo,
>>
>> Thanks for catching this — I hadn't fully considered the double-call path.
>>
>> KVM_PUT_FULL_STATE fires both at realize (cpu_synchronize_post_init) and
>> on incoming migration load (cpu_synchronize_all_post_init), so
>> kvm_set_pv_features() runs twice on the destination.
>>
>>> Although I do not understand flow of VM migration, with KVM_PUT_FULL_STATE state changing, there are at least two places where this state is set, one is from cpu_common_realizefn() which calls cpu_synchronize_post_init(), the other is qemu_loadvm_state()/qemu_loadvm_state_main() which calls cpu_synchronize_all_post_init().
>>>
>>> It seems that VM will fail to migrate since kvm_set_pv_features is called twice at least here. Do you test VM migration with this patch?
>>
>> I did test migration (virt-11.2 -> virt-11.2, virt-11.1 -> virt-11.1) and
>> it passed, but that was on a single host — source and destination computed
>> the same pv_features. The kernel (kvm_loongarch_cpucfg_set_attr) only
>> rejects a re-set when the value differs:
>>
>>      if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED) &&
>>          ((kvm->arch.pv_features & valid) != val))
>>          return -EINVAL;
>>
>> So a cross-host migration where the two sides compute different pv_features
>> would indeed fail on the second set.
>>
>> I'll add a per-vCPU guard so the push happens exactly once (at the first
>> FULL_STATE sync); subsequent syncs are skipped and the destination keeps
>> advertising the features its own host supports. Does that sound like the
>> right direction?
> I do not consider pv feature migration supports before. There are two points from my side when VM migrates from hostA to hostB, maybe there are other requirements out of my knowledge :(
>   1. the pv feature value got from running vCPUs on hostA should be supported on hostB.
>   2. if VM is rebooted or one vCPU is hot added, the pv feature value got from new added vCPU on hostB should be the same with boot CPU0, which is got from hostA.
> 

Thanks, those are good points — my set-once guard doesn't handle them
correctly.

For Point 2, the root issue is that kvm->arch.pv_features is VM-level:
the first vCPU locks the value, and all others (including hot-added) must
match. So after migrating hostA -> hostB, a hot-added vCPU on hostB must
still use hostA's value, not re-compute from hostB.

I've been thinking about how to handle the push. The challenge is that
there's no single QEMU hook that fires exactly once with the final
pv_features value for both fresh boot and migration:
  - post_load only fires on migration load, not on fresh boot;
  - KVM_PUT_FULL_STATE fires at both realize and load (the double-call).

One option that seems to work: push from the first KVM_PUT_RUNTIME_STATE
sync (when the guest first runs), gated by a per-vCPU flag. By that point
env->pv_features holds the correct value for both cases — host-detected on
fresh boot, or the migrated value after post_load. The flag ensures the
push happens only once per vCPU.

This still doesn't solve hot-add after cross-host migration: a newly
created vCPU would re-compute from hostB via check_pv_features, getting a
different value from CPU0. For that I think pv_features needs to be stored
at the VM level (matching kvm->arch.pv_features), so hot-added vCPUs
inherit it rather than re-detecting.

I've also checked a few other migration paths: savevm/snapshot restore
goes through the same post_load, and multi-hop migration keeps the
original host's value — the runtime-state push should cover both.
During testing I observed that cross-machine-type migration (virt-11.1 <->
virt-11.2) fails at QEMU's configuration check; I haven't investigated
whether pv_features adds further constraints there.

I also looked at how other architectures handle this. On x86, CPUID
(including KVM feature leaves) is set via KVM_SET_CPUID2 in
kvm_arch_init_vcpu(), not in put_registers(); the kernel allows
re-setting CPUID and validates the features against the host on each SET.
On arm, KVM_ARM_VCPU_INIT and device attributes (PMU, PVTIME IPA, etc.)
are set in init_vcpu / machine init; the kernel likewise permits
re-setting device attributes. Neither architecture pushes feature
configuration through put_registers.

On LoongArch, the kernel currently locks pv_features after the first SET
and rejects any different value. This is what makes the migration case
hard — the destination cannot override the host-detected value with the
migrated one. If the kernel could relax this (allow overriding while
validating that the new value is a subset of what the host supports,
similar to x86's KVM_SET_CPUID2), the QEMU side would be simpler: push
once in init_vcpu (host-detected), then override from post_load on
migration. I think adjusting both QEMU and KVM together would be simpler
than working around it entirely in QEMU — would that work?

I'm still going through the overall flow to check if there are other
edge cases I've missed.

Tao

> Regards
> Bibo Mao
>>
>> Thanks,
>> Tao
>>
>>>
>>> Regards
>>> Bibo Mao
>>>>            if (ret) {
>>>>                return ret;
>>>>            }
>>>> -        once = 1;
>>>> -    }
>>>>    -    if (level >= KVM_PUT_FULL_STATE) {
>>>> -        /*
>>>> -         * only KVM_PUT_FULL_STATE is required, kvm kernel will clear
>>>> -         * guest_addr for KVM_PUT_RESET_STATE
>>>> -         */
>>>>            ret = kvm_set_stealtime(cs);
>>>>            if (ret) {
>>>>                return ret;
>>>>
>>>
> 


