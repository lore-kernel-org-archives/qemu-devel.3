Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2ADC8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 07:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWrZk-0003Gn-5A; Wed, 02 Jul 2025 03:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uWrZh-0003GO-A3
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:08:10 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uWrZZ-0002ca-Ns
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:08:08 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxnmvL2mRoeg4hAQ--.31222S3;
 Wed, 02 Jul 2025 15:07:55 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJAxE+TH2mRowWUGAA--.36649S3;
 Wed, 02 Jul 2025 15:07:54 +0800 (CST)
Subject: Re: [PATCH v3 2/9] hw/loongarch: add virt feature avecintc support
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250627030138.2482055-1-gaosong@loongson.cn>
 <20250627030138.2482055-3-gaosong@loongson.cn>
 <ab746c92-492b-fb47-c5f4-df04da478a85@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <3bf9c6c4-60f4-a405-a779-bb297f03dcc7@loongson.cn>
Date: Wed, 2 Jul 2025 15:10:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ab746c92-492b-fb47-c5f4-df04da478a85@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJAxE+TH2mRowWUGAA--.36649S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtFy7Gr47XFykKrWDKrykZwc_yoW3Aw4rpr
 1kJFW8WryUGrn7Xr17Kr1UWFy5Jr18t3WDXr48XFyUJF4DGr1jqr1UXr1qgFyUAw4kAr18
 Jr18XrnrZF17XrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2nYFDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.077,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

在 2025/7/2 上午10:03, Bibo Mao 写道:
>
>
> On 2025/6/27 上午11:01, Song Gao wrote:
>> LoongArchVirtMachinState adds avecintc features, and
>> it use to check whether virt machine support advance interrupt 
>> controller
>> and default set avecintc = ON_OFF_AUTO_ON.
>> LoongArchVirtMachineState adds misc_feature and misc_status for
>> misc fetures and status. and set default avec feture bit.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   hw/loongarch/virt.c         | 43 +++++++++++++++++++++++++++++++++----
>>   include/hw/loongarch/virt.h | 15 +++++++++++++
>>   2 files changed, 54 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index 6a169d4824..426eaaef84 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -47,6 +47,28 @@
>>   #include "hw/virtio/virtio-iommu.h"
>>   #include "qemu/error-report.h"
>>   +static void virt_get_avecintc(Object *obj, Visitor *v, const char 
>> *name,
>> +                             void *opaque, Error **errp)
>> +{
>> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
>> +    OnOffAuto avecintc = lvms->avecintc;
>> +
>> +    visit_type_OnOffAuto(v, name, &avecintc, errp);
>> +
>> +}
>> +static void virt_set_avecintc(Object *obj, Visitor *v, const char 
>> *name,
>> +                              void *opaque, Error **errp)
>> +{
>> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
>> +
>> +    if (lvms->avecintc == ON_OFF_AUTO_OFF) {
>> +        lvms->misc_feature &= ~BIT(IOCSRF_AVEC);
>> +        lvms->misc_status &= ~BIT(IOCSRM_AVEC_EN);
>> +    }
>> +
>> +    visit_type_OnOffAuto(v, name, &lvms->avecintc, errp);
> It is a little strange that firstly check variable and then set it, I 
> think that visit_type_OnOffAuto() should be before
>  +    if (lvms->avecintc == ON_OFF_AUTO_OFF) {
>  +        lvms->misc_feature &= ~BIT(IOCSRF_AVEC);
>  +        lvms->misc_status &= ~BIT(IOCSRM_AVEC_EN);
>  +    }
>
>> +}
>> +
>>   static void virt_get_veiointc(Object *obj, Visitor *v, const char 
>> *name,
>>                                 void *opaque, Error **errp)
>>   {
>> @@ -539,6 +561,10 @@ static MemTxResult virt_iocsr_misc_write(void 
>> *opaque, hwaddr addr,
>>               return MEMTX_OK;
>>           }
>>   +        if (val & BIT(IOCSRM_AVEC_EN)) {
>> +            lvms->misc_status |= BIT(IOCSRM_AVEC_EN);
>> +        }
>> +
>>           features = address_space_ldl(&lvms->as_iocsr,
>>                                        EXTIOI_VIRT_BASE + 
>> EXTIOI_VIRT_CONFIG,
>>                                        attrs, NULL);
>> @@ -574,8 +600,9 @@ static MemTxResult virt_iocsr_misc_read(void 
>> *opaque, hwaddr addr,
>>           break;
>>       case FEATURE_REG:
>>           ret = BIT(IOCSRF_MSI) | BIT(IOCSRF_EXTIOI) | 
>> BIT(IOCSRF_CSRIPI);
>> -        /*TODO: check bit IOCSRF_AVEC with virt_is_avec_enabled */
>> -        ret |= BIT(IOCSRF_AVEC);
>> +        if (virt_is_avecintc_enabled(lvms)) {
>> +            ret |= BIT(IOCSRF_AVEC);
>> +        }
>>           if (kvm_enabled()) {
>>               ret |= BIT(IOCSRF_VM);
>>           }
>> @@ -605,8 +632,10 @@ static MemTxResult virt_iocsr_misc_read(void 
>> *opaque, hwaddr addr,
>>           if (features & BIT(EXTIOI_ENABLE_INT_ENCODE)) {
>>               ret |= BIT_ULL(IOCSRM_EXTIOI_INT_ENCODE);
>>           }
>> -        /* enable avec default */
>> -        ret |= BIT_ULL(IOCSRM_AVEC_EN);
>> +        if (virt_is_avecintc_enabled(lvms) &&
>> +            (lvms->misc_status & BIT(IOCSRM_AVEC_EN))) {
>> +            ret |= BIT_ULL(IOCSRM_AVEC_EN);
>> +        }
>>           break;
>>       default:
>>           g_assert_not_reached();
>> @@ -850,6 +879,8 @@ static void virt_initfn(Object *obj)
>>       if (tcg_enabled()) {
>>           lvms->veiointc = ON_OFF_AUTO_OFF;
>>       }
>> +    lvms->misc_feature = BIT(IOCSRF_AVEC);
>> +    lvms->avecintc = ON_OFF_AUTO_ON;
>>       lvms->acpi = ON_OFF_AUTO_AUTO;
>>       lvms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
>>       lvms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
>> @@ -1242,6 +1273,10 @@ static void virt_class_init(ObjectClass *oc, 
>> const void *data)
>>           NULL, NULL);
>>       object_class_property_set_description(oc, "v-eiointc",
>>                               "Enable Virt Extend I/O Interrupt 
>> Controller.");
>> +    object_class_property_add(oc, "avecintc", "OnOffAuto",
>> +        virt_get_avecintc, virt_set_avecintc, NULL, NULL);
>> +    object_class_property_set_description(oc, "avecintc",
>> +                            "Enable Advance Interrupt Controller.");
> It is only can be added in TCG mode, in kvm mode avec should not be 
> supported now.
>> machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
>>   #ifdef CONFIG_TPM
>> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
>> index cc6656619d..44504e5501 100644
>> --- a/include/hw/loongarch/virt.h
>> +++ b/include/hw/loongarch/virt.h
>> @@ -70,6 +70,7 @@ struct LoongArchVirtMachineState {
>>       Notifier     powerdown_notifier;
>>       OnOffAuto    acpi;
>>       OnOffAuto    veiointc;
>> +    OnOffAuto    avecintc;
>>       char         *oem_id;
>>       char         *oem_table_id;
>>       DeviceState  *acpi_ged;
>> @@ -85,6 +86,8 @@ struct LoongArchVirtMachineState {
>>       DeviceState *extioi;
>>       struct memmap_entry *memmap_table;
>>       unsigned int memmap_entries;
>> +    uint64_t misc_feature;
>> +    uint64_t misc_status;
>>   };
>>     #define TYPE_LOONGARCH_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
>> @@ -92,6 +95,18 @@ 
>> OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, 
>> LOONGARCH_VIRT_MACHINE)
>>   void virt_acpi_setup(LoongArchVirtMachineState *lvms);
>>   void virt_fdt_setup(LoongArchVirtMachineState *lvms);
>>   +static inline bool 
>> virt_is_avecintc_enabled(LoongArchVirtMachineState *lvms)
>> +{
>> +    if (!(lvms->misc_feature & BIT(IOCSRF_AVEC))) {
>> +        return false;
>> +    }
>> +
>> +    if (lvms->avecintc == ON_OFF_AUTO_OFF) {
>> +        return false;
>> +    }
> Is it enough to only check variable misc_feature? checking avecintc 
> seems unnecessary duplicated.
>
  Someone may  disable avecintc with command  'avecintc = off'.

Thanks.
Song Gao.
> Regards
> Bibo Mao
>> +    return true;
>> +}
>> +
>>   static inline bool 
>> virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
>>   {
>>       if (lvms->veiointc == ON_OFF_AUTO_OFF) {
>>


