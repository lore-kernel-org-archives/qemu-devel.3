Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C3DC531CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 01:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn4Wv-0000rz-6M; Thu, 23 Jul 2026 21:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wn4Ws-0000rd-MJ; Thu, 23 Jul 2026 21:16:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1wn4Wp-0000Sg-BA; Thu, 23 Jul 2026 21:16:46 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxaevwvGJqWsQGAA--.25357S3;
 Fri, 24 Jul 2026 09:16:32 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxPsftvGJqpPIWAA--.58623S2;
 Fri, 24 Jul 2026 09:16:30 +0800 (CST)
Subject: Re: [PATCH for-11.2] hw: add compat machines for 11.2
To: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <17746591750@163.com>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <20260723163806.368127-1-cohuck@redhat.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <48fafd42-816a-337d-d5dd-96c382549a23@loongson.cn>
Date: Fri, 24 Jul 2026 09:16:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260723163806.368127-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxPsftvGJqpPIWAA--.58623S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ww1DWFyxGr1fKF17uw45Jwc_yoWftr13pF
 1DAFWktF43XF1xXrZIy3Wxu3W5Cw4kKayj9r4xZw4IyF4DKFnrG340y3WFyFWj9rs7JF4U
 XFn5uFW7G3WUX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
 kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
 twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
 k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
 4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
 42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2-VyUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.557,
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



On 2026/7/24 上午12:38, Cornelia Huck wrote:
> Add 11.2 machine types for arm/i440fx/loongarch/m68k/q35/s390x/spapr.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   hw/arm/virt.c              |  9 ++++++++-
>   hw/core/machine.c          |  3 +++
>   hw/i386/pc.c               |  3 +++
>   hw/i386/pc_piix.c          | 13 +++++++++++--
>   hw/i386/pc_q35.c           | 13 +++++++++++--
>   hw/loongarch/virt.c        | 11 +++++++++--
>   hw/m68k/virt.c             |  9 ++++++++-
>   hw/ppc/spapr.c             | 15 +++++++++++++--
>   hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>   include/hw/core/boards.h   |  3 +++
>   include/hw/i386/pc.h       |  3 +++
>   11 files changed, 85 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 219597cabd0b..e7a56e37f731 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -4441,10 +4441,17 @@ static void machvirt_machine_init(void)
>   }
>   type_init(machvirt_machine_init);
>   
> +static void virt_machine_11_2_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
> +
>   static void virt_machine_11_1_options(MachineClass *mc)
>   {
> +    virt_machine_11_2_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
>   }
> -DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
> +DEFINE_VIRT_MACHINE(11, 1)
>   
>   static void virt_machine_11_0_options(MachineClass *mc)
>   {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 805148678d57..354b93c62037 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -40,6 +40,9 @@
>   #include "qemu/audio.h"
>   #include "hw/arm/smmuv3.h"
>   
> +GlobalProperty hw_compat_11_1[] = {};
> +const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
> +
>   GlobalProperty hw_compat_11_0[] = {
>       { "chardev-vc", "encoding", "cp437" },
>       { "tpm-crb", "cap-chunk", "off" },
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f064aa2b3e32..e9e4fc262b83 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -74,6 +74,9 @@
>   #include "hw/xen/xen-bus.h"
>   #endif
>   
> +GlobalProperty pc_compat_11_1[] = {};
> +const size_t pc_compat_11_1_len = G_N_ELEMENTS(pc_compat_11_1);
> +
>   GlobalProperty pc_compat_11_0[] = {};
>   const size_t pc_compat_11_0_len = G_N_ELEMENTS(pc_compat_11_0);
>   
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 82457bdb167a..223a19cc4bbc 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -428,12 +428,21 @@ static void pc_i440fx_machine_options(MachineClass *m)
>                        pc_piix_compat_defaults, pc_piix_compat_defaults_len);
>   }
>   
> -static void pc_i440fx_machine_11_1_options(MachineClass *m)
> +static void pc_i440fx_machine_11_2_options(MachineClass *m)
>   {
>       pc_i440fx_machine_options(m);
>   }
>   
> -DEFINE_I440FX_MACHINE_AS_LATEST(11, 1);
> +DEFINE_I440FX_MACHINE_AS_LATEST(11, 2);
> +
> +static void pc_i440fx_machine_11_1_options(MachineClass *m)
> +{
> +    pc_i440fx_machine_11_2_options(m);
> +    compat_props_add(m->compat_props, hw_compat_11_1, hw_compat_11_1_len);
> +    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
> +}
> +
> +DEFINE_I440FX_MACHINE(11, 1);
>   
>   static void pc_i440fx_machine_11_0_options(MachineClass *m)
>   {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 6c1e4eff5f1d..94cd71124b18 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -383,12 +383,21 @@ static void pc_q35_machine_options(MachineClass *m)
>                        pc_q35_compat_defaults, pc_q35_compat_defaults_len);
>   }
>   
> -static void pc_q35_machine_11_1_options(MachineClass *m)
> +static void pc_q35_machine_11_2_options(MachineClass *m)
>   {
>       pc_q35_machine_options(m);
>   }
>   
> -DEFINE_Q35_MACHINE_AS_LATEST(11, 1);
> +DEFINE_Q35_MACHINE_AS_LATEST(11, 2);
> +
> +static void pc_q35_machine_11_1_options(MachineClass *m)
> +{
> +    pc_q35_machine_11_2_options(m);
> +    compat_props_add(m->compat_props, hw_compat_11_1, hw_compat_11_1_len);
> +    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
> +}
> +
> +DEFINE_Q35_MACHINE(11, 1);
>   
>   static void pc_q35_machine_11_0_options(MachineClass *m)
>   {
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 6693dea647be..9cc79929a8ab 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -1465,7 +1465,6 @@ static void virt_class_init(ObjectClass *oc, const void *data)
>       mc->default_ram_id = "loongarch.ram";
>       mc->desc = "QEMU LoongArch Virtual Machine";
>       mc->max_cpus = LOONGARCH_MAX_CPUS;
> -    mc->is_default = 1;
>       mc->default_kernel_irqchip_split = false;
>       mc->block_default_type = IF_VIRTIO;
>       mc->default_boot_order = "c";
> @@ -1546,6 +1545,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
>           MACHINE_VER_DEPRECATION(__VA_ARGS__); \
>           if (latest) { \
>               mc->alias = "virt"; \
> +            mc->is_default = true; \
>           } \
>       } \
>       static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
> @@ -1600,7 +1600,14 @@ static void machvirt_machine_init(void)
>   
>   type_init(machvirt_machine_init);
>   
> +static void virt_machine_11_2_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
> +
>   static void virt_machine_11_1_options(MachineClass *mc)
>   {
> +    virt_machine_11_2_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
>   }
> -DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
> +DEFINE_VIRT_MACHINE(11, 1)

With LoongArch part
Reviewed-by: Bibo Mao <maobibo@loongson.cn>

Regards
Bibo Mao
> diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
> index 51158ce1c08c..274970978ffb 100644
> --- a/hw/m68k/virt.c
> +++ b/hw/m68k/virt.c
> @@ -367,10 +367,17 @@ type_init(virt_machine_register_types)
>   #define DEFINE_VIRT_MACHINE(major, minor) \
>       DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
>   
> +static void virt_machine_11_2_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
> +
>   static void virt_machine_11_1_options(MachineClass *mc)
>   {
> +    virt_machine_11_2_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
>   }
> -DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
> +DEFINE_VIRT_MACHINE(11, 1)
>   
>   static void virt_machine_11_0_options(MachineClass *mc)
>   {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b79828b4e90c..7e284edd7d0b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4763,15 +4763,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
>   #define DEFINE_SPAPR_MACHINE(major, minor) \
>       DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)
>   
> +/*
> + * pseries-11.2
> + */
> +static void spapr_machine_11_2_class_options(MachineClass *mc)
> +{
> +    /* Defaults for the latest behaviour inherited from the base class */
> +}
> +
> +DEFINE_SPAPR_MACHINE_AS_LATEST(11, 2);
> +
>   /*
>    * pseries-11.1
>    */
>   static void spapr_machine_11_1_class_options(MachineClass *mc)
>   {
> -    /* Defaults for the latest behaviour inherited from the base class */
> +    spapr_machine_11_2_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
>   }
>   
> -DEFINE_SPAPR_MACHINE_AS_LATEST(11, 1);
> +DEFINE_SPAPR_MACHINE(11, 1);
>   
>   /*
>    * pseries-11.0
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 25a9fa495540..55131c1a4445 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -925,14 +925,26 @@ static const TypeInfo ccw_machine_info = {
>       DEFINE_CCW_MACHINE_IMPL(false, major, minor)
>   
>   
> +static void ccw_machine_11_2_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void ccw_machine_11_2_class_options(MachineClass *mc)
> +{
> +}
> +DEFINE_CCW_MACHINE_AS_LATEST(11, 2);
> +
>   static void ccw_machine_11_1_instance_options(MachineState *machine)
>   {
> +    ccw_machine_11_2_instance_options(machine);
>   }
>   
>   static void ccw_machine_11_1_class_options(MachineClass *mc)
>   {
> +    ccw_machine_11_2_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_11_1, hw_compat_11_1_len);
>   }
> -DEFINE_CCW_MACHINE_AS_LATEST(11, 1);
> +DEFINE_CCW_MACHINE(11, 1);
>   
>   static void ccw_machine_11_0_instance_options(MachineState *machine)
>   {
> diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
> index 29c68931d8a7..a436d48c8e52 100644
> --- a/include/hw/core/boards.h
> +++ b/include/hw/core/boards.h
> @@ -815,6 +815,9 @@ compat_props_add(GPtrArray *arr,
>       }
>   }
>   
> +extern GlobalProperty hw_compat_11_1[];
> +extern const size_t hw_compat_11_1_len;
> +
>   extern GlobalProperty hw_compat_11_0[];
>   extern const size_t hw_compat_11_0_len;
>   
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index d4b6d3ed57fa..ac03da97b645 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -209,6 +209,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
>   /* sgx.c */
>   void pc_machine_init_sgx_epc(PCMachineState *pcms);
>   
> +extern GlobalProperty pc_compat_11_1[];
> +extern const size_t pc_compat_11_1_len;
> +
>   extern GlobalProperty pc_compat_11_0[];
>   extern const size_t pc_compat_11_0_len;
>   
> 


