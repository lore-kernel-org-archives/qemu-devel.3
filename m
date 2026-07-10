Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3544C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi6cE-0006Am-RK; Fri, 10 Jul 2026 04:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wi6cB-0006AE-Vj
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:29:44 -0400
Received: from out-182.mta1.migadu.com ([95.215.58.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wi6c9-00006s-6I
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:29:43 -0400
Message-ID: <f04f159f-7ade-4d2e-bf32-41cd6e6d71ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783672177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OeIcNjRADKE/HqFC66TZVcEHnK3cb4R3oYoaysH3IWU=;
 b=wGocQvBQzyJsx5XnxKtIupT1OHPh8Wae2H+uNrXS37eGXr77tWthzZbVO6vtfbH42l5yFN
 H+gG2ON04x39IWWBuQQ89aCJSqTb3MVHzuZoajqrpxlHnMCFjfcZnQDckhcj8jDyV801j5
 36+ESU8oLbnZkS3AdBHktZjNaezwHpg=
Date: Fri, 10 Jul 2026 16:28:56 +0800
MIME-Version: 1.0
Cc: cui.tao@linux.dev, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v2 3/3] target/loongarch: add no_pv_feature compat flag
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
References: <20260710005029.345378-1-cui.tao@linux.dev>
 <20260710005029.345378-4-cui.tao@linux.dev>
 <dba7047b-a2e5-ba52-c59c-683e02a5ea19@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <dba7047b-a2e5-ba52-c59c-683e02a5ea19@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=95.215.58.182; envelope-from=cui.tao@linux.dev;
 helo=out-182.mta1.migadu.com
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



在 2026/7/10 11:09, Bibo Mao 写道:
> 
> 
> On 2026/7/10 上午8:50, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> Advertising pv features to the guest affects the migration stream. Add a
>> no_pv_feature compat flag so the behavior can be gated per machine version:
>> LoongArchCPU gets a bool field, and the virt machine gains a
>> LoongArchVirtMachineClass field that defaults the CPU flag per version.
>>
>> kvm_cpu_check_pv_features() skips populating pv features when the flag is
>> set. The 11.1 machine type keeps pv advertisement off (no_pv_feature is
>> true, preserving the previous behavior); from the new 11.2 machine type it
>> is on by default.
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>   hw/loongarch/virt.c         | 14 +++++++++++++-
>>   include/hw/loongarch/virt.h |  9 ++++++++-
>>   target/loongarch/cpu.h      |  1 +
>>   target/loongarch/kvm/kvm.c  |  5 +++++
>>   4 files changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index 6693dea647..53c84c8def 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -955,6 +955,8 @@ static void virt_init(MachineState *machine)
>>                            machine->cpu_type);
>>               exit(EXIT_FAILURE);
>>           }
>> +        LOONGARCH_CPU(cpuobj)->no_pv_feature =
>> +            LOONGARCH_VIRT_MACHINE_GET_CLASS(lvms)->no_pv_feature;
> I think it will better to set in function virt_cpu_plug().
On virt_cpu_plug(): 
  agreed, that's cleaner — I'll move the propagation there.
>>           qdev_realize_and_unref(DEVICE(cpuobj), NULL, &error_fatal);
>>       }
>>       virt_check_dmsi(machine);
>> @@ -1584,6 +1586,7 @@ static const TypeInfo virt_machine_info = {
>>       .parent         = TYPE_MACHINE,
>>       .abstract       = true,
>>       .instance_size  = sizeof(LoongArchVirtMachineState),
>> +    .class_size     = sizeof(LoongArchVirtMachineClass),
>>       .class_init     = virt_class_init,
>>       .instance_init  = virt_initfn,
>>       .instance_finalize = virt_instance_finalize,
>> @@ -1601,6 +1604,15 @@ static void machvirt_machine_init(void)
>>   type_init(machvirt_machine_init);
>>     static void virt_machine_11_1_options(MachineClass *mc)
>> +{
>> +    LoongArchVirtMachineClass *vmc = LOONGARCH_VIRT_MACHINE_CLASS(mc);
>> +
>> +    /* pv feature advertisement is enabled from 11.2; keep 11.1 unchanged */
>> +    vmc->no_pv_feature = true;
>> +}
>> +DEFINE_VIRT_MACHINE(11, 1)
>> +
>> +static void virt_machine_11_2_options(MachineClass *mc)
>>   {
>>   }
>> -DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
>> +DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
>> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
>> index d39a9bbf5d..cf8d9e1fd2 100644
>> --- a/include/hw/loongarch/virt.h
>> +++ b/include/hw/loongarch/virt.h
>> @@ -130,8 +130,15 @@ struct LoongArchVirtMachineState {
>>       bool highmem_mmio;
>>   };
>>   +struct LoongArchVirtMachineClass {
>> +    MachineClass parent_obj;
>> +
>> +    bool no_pv_feature;   /* compat: 11.1 and older do not advertise pv features */
>> +};
>> +
>>   #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
>> -OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
>> +OBJECT_DECLARE_TYPE(LoongArchVirtMachineState, LoongArchVirtMachineClass,
>> +                    LOONGARCH_VIRT_MACHINE)
>>   void virt_acpi_setup(LoongArchVirtMachineState *lvms);
>>   void virt_fdt_setup(LoongArchVirtMachineState *lvms);
>>   diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>> index ad30c73167..11bbb5f36e 100644
>> --- a/target/loongarch/cpu.h
>> +++ b/target/loongarch/cpu.h
>> @@ -447,6 +447,7 @@ struct ArchCPU {
>>       OnOffAuto msgint;
>>       OnOffAuto kvm_pv_ipi;
>>       OnOffAuto kvm_steal_time;
>> +    bool no_pv_feature;   /* compat: do not advertise KVM pv features */
>>       int32_t socket_id;  /* socket-id of this CPU */
>>       int32_t core_id;    /* core-id of this CPU */
>>       int32_t thread_id;  /* thread-id of this CPU */
>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>> index c557ee3c3d..878914928b 100644
>> --- a/target/loongarch/kvm/kvm.c
>> +++ b/target/loongarch/kvm/kvm.c
>> @@ -1119,6 +1119,11 @@ static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
>>       CPULoongArchState *env = cpu_env(cs);
>>       bool kvm_supported;
>>   +    /* compat: older machine types do not advertise pv features to the guest */
>> +    if (cpu->no_pv_feature) {
>> +        return 0;
>> +    }
>> +
> This piece of code is unnecessary, with QEMU-11.1 machine type, kvm_cpu_check_pv_features checking is skipped when CPU is created, why?

On the check_pv_features guard: 
you're right, it's unnecessary. As you
pointed out in v1, check_pv_features() is host detection and should run
regardless of machine version. I'll remove the guard and check
no_pv_feature in kvm_set_pv_features() instead, so the push is skipped for
11.1 while detection still happens normally.

One timing concern: 
virt_cpu_plug() runs after qdev_realize(), but the
first FULL_STATE sync (post_init) fires during realize — so the push could
happen before no_pv_feature is set in plug. Should I keep setting the flag
before qdev_realize() (in virt_init) for now, or is there a better
mechanism?

> 
> Regards
> Bibo Mao
>>       kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_PV_IPI);
>>       if (cpu->kvm_pv_ipi == ON_OFF_AUTO_ON) {
>>           if (!kvm_supported) {
>>
> 


