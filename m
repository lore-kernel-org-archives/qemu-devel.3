Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7F0C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 01:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubU5l-0002Sk-Da; Mon, 14 Jul 2025 21:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ubU5h-0002SS-AB
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 21:04:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ubU5d-0006cj-Nt
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 21:04:17 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxLGsGqXVofMopAQ--.21905S3;
 Tue, 15 Jul 2025 09:04:07 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxH8IDqXVo4J8XAA--.9572S3;
 Tue, 15 Jul 2025 09:04:05 +0800 (CST)
Subject: Re: [PATCH v5 02/11] hw/loongarch: add virt feature avecintc support
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250711085915.3042395-1-gaosong@loongson.cn>
 <20250711085915.3042395-3-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <e7f42f9d-498a-e930-570a-c7173400b991@loongson.cn>
Date: Tue, 15 Jul 2025 09:02:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250711085915.3042395-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxH8IDqXVo4J8XAA--.9572S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCFy3Cw47JryxZr1ktrWkGrX_yoWruFW5pa
 y5AFZ5uF1UJr4Ig3sxK3Z8uF15Aws7Ka4agF43urW0kF1DWr18urn8CwsxtFWkA3ykZFW0
 v3WkGr47uFsrZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1YL9U
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.933,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2025/7/11 下午4:59, Song Gao wrote:
> Avecintc feature is added in LoongArchVirtMachinState, and it is used
> to check whether virt machine supports the advanced interrupt controller
> and by default set avecintc with ON_OFF_AUTO_ON.
> LoongArchVirtMachineState adds misc_feature and misc_status for misc
> features and status. and set the default avec feature bit.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c         | 30 ++++++++++++++++++++++++++++++
>   include/hw/loongarch/virt.h | 14 ++++++++++++++
>   2 files changed, 44 insertions(+)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index b15ada2078..112cf9a9db 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -47,6 +47,27 @@
>   #include "hw/virtio/virtio-iommu.h"
>   #include "qemu/error-report.h"
>   
> +static void virt_get_avecintc(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
> +    OnOffAuto avecintc = lvms->avecintc;
> +
> +    visit_type_OnOffAuto(v, name, &avecintc, errp);
> +
> +}
> +static void virt_set_avecintc(Object *obj, Visitor *v, const char *name,
> +                              void *opaque, Error **errp)
> +{
> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
> +
> +    visit_type_OnOffAuto(v, name, &lvms->avecintc, errp);
> +    if (lvms->avecintc == ON_OFF_AUTO_OFF) {
> +        lvms->misc_feature &= ~BIT(IOCSRF_AVEC);
> +        lvms->misc_status &= ~BIT(IOCSRM_AVEC_EN);
> +    }
> +}
> +
>   static void virt_get_veiointc(Object *obj, Visitor *v, const char *name,
>                                 void *opaque, Error **errp)
>   {
> @@ -846,6 +867,9 @@ static void virt_initfn(Object *obj)
>       if (tcg_enabled()) {
>           lvms->veiointc = ON_OFF_AUTO_OFF;
>       }
> +
> +    lvms->misc_feature = BIT(IOCSRF_AVEC);
> +    lvms->avecintc = ON_OFF_AUTO_ON;
>       lvms->acpi = ON_OFF_AUTO_AUTO;
>       lvms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
>       lvms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
> @@ -1238,6 +1262,12 @@ static void virt_class_init(ObjectClass *oc, const void *data)
>           NULL, NULL);
>       object_class_property_set_description(oc, "v-eiointc",
>                               "Enable Virt Extend I/O Interrupt Controller.");
> +#ifdef CONFIG_TCG
I think it will be better if tcg_enabled() is used here, since 
CONFIG_TCG and CONFIG_KVM is enabled by default. It should be supported 
in KVM mode now. It is suggested in V4 review process :)

Regards
Bibo Mao
> +    object_class_property_add(oc, "avecintc", "OnOffAuto",
> +        virt_get_avecintc, virt_set_avecintc, NULL, NULL);
> +    object_class_property_set_description(oc, "avecintc",
> +                            "Enable Advance Interrupt Controller.");
> +#endif
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
>   #ifdef CONFIG_TPM
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index 7120b46714..68b8e92e99 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -23,6 +23,7 @@
>   #define IOCSRF_DVFSV1           7
>   #define IOCSRF_GMOD             9
>   #define IOCSRF_VM               11
> +#define IOCSRF_AVEC             15
>   
>   #define VERSION_REG             0x0
>   #define FEATURE_REG             0x8
> @@ -31,6 +32,7 @@
>   #define MISC_FUNC_REG           0x420
>   #define IOCSRM_EXTIOI_EN        48
>   #define IOCSRM_EXTIOI_INT_ENCODE 49
> +#define IOCSRM_AVEC_EN          51
>   
>   #define LOONGARCH_MAX_CPUS      256
>   
> @@ -69,6 +71,7 @@ struct LoongArchVirtMachineState {
>       Notifier     powerdown_notifier;
>       OnOffAuto    acpi;
>       OnOffAuto    veiointc;
> +    OnOffAuto    avecintc;
>       char         *oem_id;
>       char         *oem_table_id;
>       DeviceState  *acpi_ged;
> @@ -84,6 +87,8 @@ struct LoongArchVirtMachineState {
>       DeviceState *extioi;
>       struct memmap_entry *memmap_table;
>       unsigned int memmap_entries;
> +    uint64_t misc_feature;
> +    uint64_t misc_status;
>   };
>   
>   #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
> @@ -91,6 +96,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
>   void virt_acpi_setup(LoongArchVirtMachineState *lvms);
>   void virt_fdt_setup(LoongArchVirtMachineState *lvms);
>   
> +static inline bool virt_has_avecintc(LoongArchVirtMachineState *lvms)
> +{
> +    if (!(lvms->misc_feature & BIT(IOCSRF_AVEC))) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>   static inline bool virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
>   {
>       if (lvms->veiointc == ON_OFF_AUTO_OFF) {
> 


