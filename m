Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA299CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 18:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT2IB-0006Mh-8f; Fri, 29 May 2026 14:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT2I3-0006MD-OB
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:50:40 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT2I0-0004sk-I9
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:50:39 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45ef6565cfdso244072f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 11:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780080635; x=1780685435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JXMhvEAYwVRlDEFfz0OuKhaYVQQQz+XTG6U4wXgza14=;
 b=BNud36BYFSBacDVxzEdkbwTPyh9p6endWZelHN6rNoLEIIg51+FWdQhr1M7WYE7fTm
 TfyzS9BE+YFtsjFXIkztiG2eSEpJWbIlEqEVkFElblLKuzgoYLuYLtnL8mmemO3rS/ck
 D6I14YA4slOWpUSOFzi70EsQggE+8cd3O2DJnlzPGFPvRD1LnPDvF3GBZ5AGXbbagvUF
 j7iOSIguAeN41u2+dhT07F0cjzMhYBMYu2TFphnH5JA/FUAa2KZf/yYj+09Zh8+5dFDL
 n5EM9wcjdZDnLLiEdMAewCJJfCmnIXCRMpF4M7iDVr0/3rKHjk/6UCH08EiUnNv9u+Pl
 gAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780080635; x=1780685435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JXMhvEAYwVRlDEFfz0OuKhaYVQQQz+XTG6U4wXgza14=;
 b=J6qmlG+AbKrl0eQcWd0gp6NyIIkMHm+SBSfyv0oaJIpSIIeTzZRVcts15ZmY9P/9oS
 JXNJtadzXlH3oSmISHadIxkWlJUtM5AmdoKcaF8zi7h74sHY2CQq6zOoH9Rz8pa94Yyz
 dBW3iPFy7WfVdCc03HEaxdm9kVCIX2JrCeQM+mgUlaXaQygikVQFgbfnnGKcvJpTAz+5
 4tRXsj9QDwXC9991894jgPmcjOwDMO4CzezegMktK6fceIiMkgXpcKTpeF3B4GuagSTZ
 a/6MkuXZkJAfpfIGzSkRc90mP/tzgWPZHL+LuP4QE9mlX2tUy46tU0rxxd3GcJFGwIBR
 eG2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8FEYSPWRveHr3YBpf3IdHBJVDil6TuRuNpqjrO+5iEGSspzWOD+yGnFiEVq38HdCN9CPQWre18RDgE@nongnu.org
X-Gm-Message-State: AOJu0YwJwR2Y4iW3Zke2PYuvYi3fBdX85iptqVT9VgrYORS5MsIrAZOp
 aJATOM/On1zKGeenAhiiTAEiSEA6WabD4AfHMc5VrD3zA6IO+dhOASNnCemPri2ZB2E=
X-Gm-Gg: Acq92OE1pT69F6S9yfvbQaDKhWYVqVJqCixeZXhphT0VNYA0LxYvb7k+fcoQh0Ch1Kp
 e4IYZ5G6OTTwKFIhbhy+Y0PjIIzGVeJUX0lpkGAgc0DK/xHOS+9LOfxSKXVuuZkomevaF8T0mnR
 v1gAhNnC2dp76a4MSokoM/PRBgevr6UNiECWR2tgjcyddfvzGXHt/1sbXv0kHnZzO8wuhEtABwF
 Fa167xkIoz0olNdBImU/cfeheUZOhNomXkEabEx7P2Rube31R2XlyB0BFwCfHvC0Bml11h9lsr8
 g2h1S5hmLMXfanyIEd6lVkEl76/lr7xGQ6JkDVA6RLbvm/JlfQFCb4mm/VcShN8WQQTNQMt0ruB
 XZjGJ1hWji6zinj0KbU6fXWW1mKXu6hu9z1pEa6qPkL81ACWLRlwtn2FUIq5izWKDJpXJ3L3Rik
 kQuvfZYAB6iQ1ReNbfc5FHpezDMbSPGmosnDP6bqiG1mRlVRDlSNgSeh/f2dH7zTp8lqrMMET6+
 BgK
X-Received: by 2002:a5d:598d:0:b0:45e:a19f:22c1 with SMTP id
 ffacd0b85a97d-45ef6b19af3mr1988327f8f.15.1780080634677; 
 Fri, 29 May 2026 11:50:34 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34a065esm5750714f8f.5.2026.05.29.11.50.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 11:50:33 -0700 (PDT)
Message-ID: <415ce99a-4f43-4ad4-b5f4-9839e74a62ea@linaro.org>
Date: Fri, 29 May 2026 20:50:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] accel/kvm: Remove need for
 AccelCPUClass::cpu_target_realize
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260529142434.87880-1-philmd@linaro.org>
 <20260529142434.87880-6-philmd@linaro.org>
 <179357ae-8d50-49e5-abc5-8abf670be847@oss.qualcomm.com>
 <d85a57cd-0f90-4930-9bd7-1f29c2526a25@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d85a57cd-0f90-4930-9bd7-1f29c2526a25@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 29/5/26 20:35, Pierrick Bouvier wrote:
> On 5/29/2026 11:32 AM, Pierrick Bouvier wrote:
>> On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
>>> accel_cpu_common_realize() first calls accel_cpu->cpu_target_realize
>>> then ops->cpu_realize.
>>>
>>> Rather than having one handler for each host architecture, use a
>>> single host-specific method (prefixed with kvm_arch_* like other
>>> similar KVM methods). Register it once as AccelOpsClass
>>> cpu_target_realize handler.
>>>
>>> PPC's ACCEL_CPU_NAME("kvm") TypeInfo is  now empty, remove it.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   include/system/kvm.h       |  2 ++
>>>   accel/kvm/kvm-accel-ops.c  |  1 +
>>>   target/i386/kvm/kvm-cpu.c  |  3 +--
>>>   target/ppc/kvm.c           | 23 +----------------------
>>>   target/riscv/kvm/kvm-cpu.c | 10 +---------
>>>   5 files changed, 6 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/include/system/kvm.h b/include/system/kvm.h
>>> index 5fa33eddda3..fd7175ea9f5 100644
>>> --- a/include/system/kvm.h
>>> +++ b/include/system/kvm.h
>>> @@ -364,6 +364,8 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
>>>   int kvm_arch_init_vcpu(CPUState *cpu);
>>>   int kvm_arch_destroy_vcpu(CPUState *cpu);
>>>   
>>> +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp);
>>> +
>>>   #ifdef TARGET_KVM_HAVE_RESET_PARKED_VCPU
>>>   void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd);
>>>   #else
>>> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
>>> index 6d9140e549f..4294c7a9514 100644
>>> --- a/accel/kvm/kvm-accel-ops.c
>>> +++ b/accel/kvm/kvm-accel-ops.c
>>> @@ -97,6 +97,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
>>>       AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
>>>   
>>>       ops->create_vcpu_thread = kvm_start_vcpu_thread;
>>> +    ops->cpu_target_realize = kvm_arch_cpu_realize;
>>
>> cpu_realize
> 
> Ignore, I was wrong, confused that with AccelCPUClass.

No, you are right.

> 
>>
>>>       ops->cpu_thread_is_idle = kvm_vcpu_thread_is_idle;
>>>       ops->cpus_are_resettable = kvm_cpus_are_resettable;
>>>       ops->synchronize_post_reset = kvm_cpu_synchronize_post_reset;
>>> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
>>> index c34d9f15c7e..36634ec8929 100644
>>> --- a/target/i386/kvm/kvm-cpu.c
>>> +++ b/target/i386/kvm/kvm-cpu.c
>>> @@ -39,7 +39,7 @@ static void kvm_set_guest_phys_bits(CPUState *cs)
>>>       }
>>>   }
>>>   
>>> -static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>>> +bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
>>>   {
>>>       X86CPU *cpu = X86_CPU(cs);
>>>       X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
>>> @@ -237,7 +237,6 @@ static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
>>>   {
>>>       AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
>>>   
>>> -    acc->cpu_target_realize = kvm_cpu_realizefn;
>>>       acc->cpu_instance_init = kvm_cpu_instance_init;
>>>   }
>>>   static const TypeInfo kvm_cpu_accel_type_info = {
>>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>>> index b94c2997a07..013f5e852e1 100644
>>> --- a/target/ppc/kvm.c
>>> +++ b/target/ppc/kvm.c
>>> @@ -49,7 +49,6 @@
>>>   #include "elf.h"
>>>   #include "system/kvm_int.h"
>>>   #include "system/kvm.h"
>>> -#include "accel/accel-cpu-target.h"
>>>   
>>>   #include CONFIG_DEVICES
>>>   
>>> @@ -2353,7 +2352,7 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
>>>       }
>>>   }
>>>   
>>> -static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
>>> +bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
>>>   {
>>>       int ret;
>>>       const char *vcpu_str = (cs->parent_obj.hotplugged == true) ?
>>> @@ -2995,23 +2994,3 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
>>>   void kvm_arch_accel_class_init(ObjectClass *oc)
>>>   {
>>>   }
>>> -
>>> -static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
>>> -{
>>> -    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
>>> -
>>> -    acc->cpu_target_realize = kvmppc_cpu_realize;
>>> -}
>>> -
>>> -static const TypeInfo kvm_cpu_accel_type_info = {
>>> -    .name = ACCEL_CPU_NAME("kvm"),
>>> -
>>> -    .parent = TYPE_ACCEL_CPU,
>>> -    .class_init = kvm_cpu_accel_class_init,
>>> -    .abstract = true,
>>> -};
>>> -static void kvm_cpu_accel_register_types(void)
>>> -{
>>> -    type_register_static(&kvm_cpu_accel_type_info);
>>> -}
>>> -type_init(kvm_cpu_accel_register_types);
>>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>>> index 17ba38403a3..7c4440d0025 100644
>>> --- a/target/riscv/kvm/kvm-cpu.c
>>> +++ b/target/riscv/kvm/kvm-cpu.c
>>> @@ -1990,14 +1990,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
>>>       kvm_riscv_add_cpu_user_properties(obj);
>>>   }
>>>   
>>> -/*
>>> - * We'll get here via the following path:
>>> - *
>>> - * riscv_cpu_realize()
>>> - *   -> cpu_exec_realizefn()
>>> - *      -> kvm_cpu_realize() (via accel_cpu_common_realize())
>>> - */
>>> -static bool kvm_cpu_realize(CPUState *cs, Error **errp)
>>> +bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
>>>   {
>>>       RISCVCPU *cpu = RISCV_CPU(cs);
>>>       int ret;
>>> @@ -2120,7 +2113,6 @@ static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
>>>       AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
>>>   
>>>       acc->cpu_instance_init = kvm_cpu_instance_init;
>>> -    acc->cpu_target_realize = kvm_cpu_realize;
>>>   }
>>>   
>>>   static const TypeInfo kvm_cpu_accel_type_info = {
>>
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>
>> Regards,
>> Pierrick
> 


