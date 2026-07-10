Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97673C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 03:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1d6-0006dM-3f; Thu, 09 Jul 2026 23:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wi1d1-0006d9-Sk
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 23:10:15 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wi1cy-0001kf-EA
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 23:10:15 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bx1+qMYlBqQCECAA--.8946S3;
 Fri, 10 Jul 2026 11:10:04 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxDceKYlBq1OQHAA--.22983S2;
 Fri, 10 Jul 2026 11:10:02 +0800 (CST)
Subject: Re: [PATCH v2 3/3] target/loongarch: add no_pv_feature compat flag
To: Tao Cui <cui.tao@linux.dev>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@mailo.com>,
 Tao Cui <cuitao@kylinos.cn>
References: <20260710005029.345378-1-cui.tao@linux.dev>
 <20260710005029.345378-4-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <dba7047b-a2e5-ba52-c59c-683e02a5ea19@loongson.cn>
Date: Fri, 10 Jul 2026 11:09:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260710005029.345378-4-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxDceKYlBq1OQHAA--.22983S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWry5Cr4UZF1fuF1kCr45urX_yoWruFyDpF
 ZrCF4kCw18WrZ7Zas7J3Z8Wrs8Jr4xGay2va1IyryFkanxGry8ur10y3yqkF4DJ3yvqF48
 XF1vkry7Za1UZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
 kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
 XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
 k0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
 Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
 AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
 cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
 8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4AhLUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.97,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026/7/10 上午8:50, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Advertising pv features to the guest affects the migration stream. Add a
> no_pv_feature compat flag so the behavior can be gated per machine version:
> LoongArchCPU gets a bool field, and the virt machine gains a
> LoongArchVirtMachineClass field that defaults the CPU flag per version.
> 
> kvm_cpu_check_pv_features() skips populating pv features when the flag is
> set. The 11.1 machine type keeps pv advertisement off (no_pv_feature is
> true, preserving the previous behavior); from the new 11.2 machine type it
> is on by default.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   hw/loongarch/virt.c         | 14 +++++++++++++-
>   include/hw/loongarch/virt.h |  9 ++++++++-
>   target/loongarch/cpu.h      |  1 +
>   target/loongarch/kvm/kvm.c  |  5 +++++
>   4 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 6693dea647..53c84c8def 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -955,6 +955,8 @@ static void virt_init(MachineState *machine)
>                            machine->cpu_type);
>               exit(EXIT_FAILURE);
>           }
> +        LOONGARCH_CPU(cpuobj)->no_pv_feature =
> +            LOONGARCH_VIRT_MACHINE_GET_CLASS(lvms)->no_pv_feature;
I think it will better to set in function virt_cpu_plug().
>           qdev_realize_and_unref(DEVICE(cpuobj), NULL, &error_fatal);
>       }
>       virt_check_dmsi(machine);
> @@ -1584,6 +1586,7 @@ static const TypeInfo virt_machine_info = {
>       .parent         = TYPE_MACHINE,
>       .abstract       = true,
>       .instance_size  = sizeof(LoongArchVirtMachineState),
> +    .class_size     = sizeof(LoongArchVirtMachineClass),
>       .class_init     = virt_class_init,
>       .instance_init  = virt_initfn,
>       .instance_finalize = virt_instance_finalize,
> @@ -1601,6 +1604,15 @@ static void machvirt_machine_init(void)
>   type_init(machvirt_machine_init);
>   
>   static void virt_machine_11_1_options(MachineClass *mc)
> +{
> +    LoongArchVirtMachineClass *vmc = LOONGARCH_VIRT_MACHINE_CLASS(mc);
> +
> +    /* pv feature advertisement is enabled from 11.2; keep 11.1 unchanged */
> +    vmc->no_pv_feature = true;
> +}
> +DEFINE_VIRT_MACHINE(11, 1)
> +
> +static void virt_machine_11_2_options(MachineClass *mc)
>   {
>   }
> -DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
> +DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index d39a9bbf5d..cf8d9e1fd2 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -130,8 +130,15 @@ struct LoongArchVirtMachineState {
>       bool highmem_mmio;
>   };
>   
> +struct LoongArchVirtMachineClass {
> +    MachineClass parent_obj;
> +
> +    bool no_pv_feature;   /* compat: 11.1 and older do not advertise pv features */
> +};
> +
>   #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
> -OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
> +OBJECT_DECLARE_TYPE(LoongArchVirtMachineState, LoongArchVirtMachineClass,
> +                    LOONGARCH_VIRT_MACHINE)
>   void virt_acpi_setup(LoongArchVirtMachineState *lvms);
>   void virt_fdt_setup(LoongArchVirtMachineState *lvms);
>   
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index ad30c73167..11bbb5f36e 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -447,6 +447,7 @@ struct ArchCPU {
>       OnOffAuto msgint;
>       OnOffAuto kvm_pv_ipi;
>       OnOffAuto kvm_steal_time;
> +    bool no_pv_feature;   /* compat: do not advertise KVM pv features */
>       int32_t socket_id;  /* socket-id of this CPU */
>       int32_t core_id;    /* core-id of this CPU */
>       int32_t thread_id;  /* thread-id of this CPU */
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index c557ee3c3d..878914928b 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -1119,6 +1119,11 @@ static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
>       CPULoongArchState *env = cpu_env(cs);
>       bool kvm_supported;
>   
> +    /* compat: older machine types do not advertise pv features to the guest */
> +    if (cpu->no_pv_feature) {
> +        return 0;
> +    }
> +
This piece of code is unnecessary, with QEMU-11.1 machine type, 
kvm_cpu_check_pv_features checking is skipped when CPU is created, why?

Regards
Bibo Mao
>       kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_PV_IPI);
>       if (cpu->kvm_pv_ipi == ON_OFF_AUTO_ON) {
>           if (!kvm_supported) {
> 


