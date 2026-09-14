Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A01C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 01:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5vJS-0007vV-W7; Sun, 13 Sep 2026 21:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x5vJP-0007vN-Uj
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 21:16:48 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x5vJM-0006q8-6Y
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 21:16:47 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bx79LzSqdq8aILAA--.34089S3;
 Mon, 14 Sep 2026 09:16:35 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxRs3ySqdq92MgAA--.57378S2;
 Mon, 14 Sep 2026 09:16:34 +0800 (CST)
Subject: Re: [PATCH v5 23/62] loongarch/virt: convert OnOffAuto properties to
 QAPI-aware registration
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@oss.qualcomm.com>,
 Song Gao <17746591750@163.com>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
 <20260911-qom-qapi-v5-23-7732a55b7760@redhat.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <80f064d9-8ff4-12e3-f672-0b3b990896fa@loongson.cn>
Date: Mon, 14 Sep 2026 09:16:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260911-qom-qapi-v5-23-7732a55b7760@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxRs3ySqdq92MgAA--.57378S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Wr43uFW7AF1xWF15tFW5Jwc_yoW7trW8pF
 nxZanxZ3WUJF4I9aykK3WDu3WUKwsxCa4YgF4fuw18CF1qgr1jqryfCw12gFyUA3yDX3WF
 qa1ku39xZF1fJagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.489,
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



On 2026/9/12 上午12:34, Marc-André Lureau wrote:
> Convert the acpi, v-eiointc, and dmsi OnOffAuto properties from
> manual visitor-based callbacks to property_add_qapi_enum().
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/loongarch/virt.c | 85 +++++++++++++++++++++++++----------------------------
>   1 file changed, 40 insertions(+), 45 deletions(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 9cc79929a8ab..750ce2dbe5fc 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -36,7 +36,8 @@
>   #include "target/loongarch/cpu.h"
>   #include "target/loongarch/cpu-mmu.h"
>   #include "hw/firmware/smbios.h"
> -#include "qapi/qapi-visit-common.h"
> +#include "qapi/qapi-type-infos-common.h"
> +#include "qapi/visitor.h"
>   #include "hw/acpi/generic_event_device.h"
>   #include "hw/mem/nvdimm.h"
>   #include "hw/core/platform-bus.h"
> @@ -51,26 +52,21 @@
>   #include "qemu/log.h"
>   #include "kvm/kvm_loongarch.h"
>   
> -static void virt_get_dmsi(Object *obj, Visitor *v, const char *name,
> -                             void *opaque, Error **errp)
> +static int virt_get_dmsi(Object *obj, Error **errp)
>   {
>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
> -    OnOffAuto dmsi = lvms->dmsi;
> -
> -    visit_type_OnOffAuto(v, name, &dmsi, errp);
> -
> +    return lvms->dmsi;
>   }
> -static void virt_set_dmsi(Object *obj, Visitor *v, const char *name,
> -                              void *opaque, Error **errp)
> +
> +static void virt_set_dmsi(Object *obj, int value, Error **errp)
>   {
>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
> +    lvms->dmsi = value;
>   
> -    visit_type_OnOffAuto(v, name, &lvms->dmsi, errp);
> -
> -    if (lvms->dmsi == ON_OFF_AUTO_OFF) {
> +    if (value == ON_OFF_AUTO_OFF) {
>           lvms->misc_feature &= ~BIT(IOCSRF_DMSI);
>           lvms->misc_status &= ~BIT_ULL(IOCSRM_DMSI_EN);
> -    } else if (lvms->dmsi == ON_OFF_AUTO_ON) {
> +    } else if (value == ON_OFF_AUTO_ON) {
>           lvms->misc_feature = BIT(IOCSRF_DMSI);
>       }
>   }
> @@ -78,21 +74,16 @@ static void virt_set_dmsi(Object *obj, Visitor *v, const char *name,
>   #define DEFAULT_HIGH_PCIE_MMIO_SIZE_GB 64
>   #define DEFAULT_HIGH_PCIE_MMIO_SIZE (DEFAULT_HIGH_PCIE_MMIO_SIZE_GB * GiB)
>   
> -static void virt_get_veiointc(Object *obj, Visitor *v, const char *name,
> -                              void *opaque, Error **errp)
> +static int virt_get_veiointc(Object *obj, Error **errp)
>   {
>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
> -    OnOffAuto veiointc = lvms->veiointc;
> -
> -    visit_type_OnOffAuto(v, name, &veiointc, errp);
> +    return lvms->veiointc;
>   }
>   
> -static void virt_set_veiointc(Object *obj, Visitor *v, const char *name,
> -                              void *opaque, Error **errp)
> +static void virt_set_veiointc(Object *obj, int value, Error **errp)
>   {
>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
> -
> -    visit_type_OnOffAuto(v, name, &lvms->veiointc, errp);
> +    lvms->veiointc = value;
>   }
>   
>   static bool virt_get_highmem_mmio(Object *obj, Error **errp)
> @@ -1025,21 +1016,16 @@ static void virt_init(MachineState *machine)
>       loongarch_load_kernel(machine, &lvms->bootinfo, phys_addr_mask);
>   }
>   
> -static void virt_get_acpi(Object *obj, Visitor *v, const char *name,
> -                          void *opaque, Error **errp)
> +static int virt_get_acpi(Object *obj, Error **errp)
>   {
>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
> -    OnOffAuto acpi = lvms->acpi;
> -
> -    visit_type_OnOffAuto(v, name, &acpi, errp);
> +    return lvms->acpi;
>   }
>   
> -static void virt_set_acpi(Object *obj, Visitor *v, const char *name,
> -                               void *opaque, Error **errp)
> +static void virt_set_acpi(Object *obj, int value, Error **errp)
>   {
>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
> -
> -    visit_type_OnOffAuto(v, name, &lvms->acpi, errp);
> +    lvms->acpi = value;
>   }
>   
>   static char *virt_get_oem_id(Object *obj, Error **errp)
> @@ -1483,20 +1469,29 @@ static void virt_class_init(ObjectClass *oc, const void *data)
>       hc->unplug_request = virt_device_unplug_request;
>       hc->unplug = virt_device_unplug;
>   
> -    object_class_property_add(oc, "acpi", "OnOffAuto",
> -        virt_get_acpi, virt_set_acpi,
> -        NULL, NULL);
> -    object_class_property_set_description(oc, "acpi",
> -        "Enable ACPI");
> -    object_class_property_add(oc, "v-eiointc", "OnOffAuto",
> -        virt_get_veiointc, virt_set_veiointc,
> -        NULL, NULL);
> -    object_class_property_set_description(oc, "v-eiointc",
> -                            "Enable Virt Extend I/O Interrupt Controller.");
> -    object_class_property_add(oc, "dmsi", "OnOffAuto",
> -        virt_get_dmsi, virt_set_dmsi, NULL, NULL);
> -    object_class_property_set_description(oc, "dmsi",
> -                            "Enable direct Message-interrupts Controller.");
> +    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
> +        .name = "acpi",
> +        .description = "Enable ACPI",
> +        .qapi_type = &OnOffAuto_type_info,
> +        .get = virt_get_acpi,
> +        .set = virt_set_acpi,
> +    ));
> +
> +    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
> +        .name = "v-eiointc",
> +        .description = "Enable Virt Extend I/O Interrupt Controller.",
> +        .qapi_type = &OnOffAuto_type_info,
> +        .get = virt_get_veiointc,
> +        .set = virt_set_veiointc,
> +    ));
> +
> +    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
> +        .name = "dmsi",
> +        .description = "Enable direct Message-interrupts Controller.",
> +        .qapi_type = &OnOffAuto_type_info,
> +        .get = virt_get_dmsi,
> +        .set = virt_set_dmsi,
> +    ));
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
>   #ifdef CONFIG_TPM
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


