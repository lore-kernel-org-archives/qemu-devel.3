Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB88C71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 01:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQyNn-0003K3-34; Sun, 15 Jun 2025 21:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uQyNk-0003JZ-8X
 for qemu-devel@nongnu.org; Sun, 15 Jun 2025 21:11:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uQyNh-0003cB-Fe
 for qemu-devel@nongnu.org; Sun, 15 Jun 2025 21:11:28 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxfeE0b09oUmYXAQ--.13818S3;
 Mon, 16 Jun 2025 09:11:16 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxXsUxb09oL1UcAQ--.21035S3;
 Mon, 16 Jun 2025 09:11:15 +0800 (CST)
Subject: Re: [PATCH 02/10] loongarch: add virt feature avecintc support
To: gaosong <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250609104833.839811-1-gaosong@loongson.cn>
 <20250609104833.839811-3-gaosong@loongson.cn>
 <b31a750b-0153-271f-d937-87b8b41c6d8f@loongson.cn>
 <d6d33e1c-d066-8de7-ec2c-717572333cf2@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <45a615a4-563e-36e4-a1b3-032ffec457cc@loongson.cn>
Date: Mon, 16 Jun 2025 09:09:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d6d33e1c-d066-8de7-ec2c-717572333cf2@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXsUxb09oL1UcAQ--.21035S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3ArW5Kr47Kr4rKr43KFy5WrX_yoWxGw4xpr
 WkJFWUJryUGrn7Xr17Kr1UWryUJr1xtw1UXr4UWF48JrsrXr1jgr1UXr1qgFyUAw48Jr10
 qr18JrsrZF13XrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-
 e5UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.554,
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



On 2025/6/13 下午3:54, gaosong wrote:
> 在 2025/6/11 下午2:46, Bibo Mao 写道:
>>
>>
>> On 2025/6/9 下午6:48, Song Gao wrote:
>>> LoongArchVirtMachinState add  avecintc features, and
>>> it use to check whether virt machine support advance interrupt 
>>> controller
>>> and default is on.
>>>
>>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>>> ---
>>>   hw/loongarch/virt.c         | 31 +++++++++++++++++++++++++++----
>>>   include/hw/loongarch/virt.h |  9 +++++++++
>>>   2 files changed, 36 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>>> index 90d4643721..35643a4e0b 100644
>>> --- a/hw/loongarch/virt.c
>>> +++ b/hw/loongarch/virt.c
>>> @@ -47,6 +47,23 @@
>>>   #include "hw/virtio/virtio-iommu.h"
>>>   #include "qemu/error-report.h"
>>>   +static void virt_get_avecintc(Object *obj, Visitor *v, const char 
>>> *name,
>>> +                             void *opaque, Error **errp)
>>> +{
>>> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
>>> +    OnOffAuto avecintc = lvms->avecintc;
>>> +
>>> +    visit_type_OnOffAuto(v, name, &avecintc, errp);
>>> +
>>> +}
>>> +static void virt_set_avecintc(Object *obj, Visitor *v, const char 
>>> *name,
>>> +                              void *opaque, Error **errp)
>>> +{
>>> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
>>> +
>>> +    visit_type_OnOffAuto(v, name, &lvms->avecintc, errp);
>>> +}
>>> +
>>>   static void virt_get_veiointc(Object *obj, Visitor *v, const char 
>>> *name,
>>>                                 void *opaque, Error **errp)
>>>   {
>>> @@ -548,8 +565,9 @@ static MemTxResult virt_iocsr_misc_read(void 
>>> *opaque, hwaddr addr,
>>>           break;
>>>       case FEATURE_REG:
>>>           ret = BIT(IOCSRF_MSI) | BIT(IOCSRF_EXTIOI) | 
>>> BIT(IOCSRF_CSRIPI);
>>> -        /*TODO: check bit IOCSRF_AVEC with virt_is_avec_enabled */
>>> -        ret |= BIT(IOCSRF_AVEC);
>>> +        if (virt_is_avecintc_enabled(lvms)) {
>>> +            ret |= BIT(IOCSRF_AVEC);
>>> +        }
>>>           if (kvm_enabled()) {
>>>               ret |= BIT(IOCSRF_VM);
>>>           }
>>> @@ -575,8 +593,9 @@ static MemTxResult virt_iocsr_misc_read(void 
>>> *opaque, hwaddr addr,
>>>           if (features & BIT(EXTIOI_ENABLE_INT_ENCODE)) {
>>>               ret |= BIT_ULL(IOCSRM_EXTIOI_INT_ENCODE);
>>>           }
>>> -        /* enable avec default */
>>> -        ret |= BIT_ULL(IOCSRM_AVEC_EN);
>>> +        if (virt_is_avecintc_enabled(lvms)) {
>>> +            ret |= BIT_ULL(IOCSRM_AVEC_EN);
>>> +        }
>> Is it really that reading of MISC_FUNC_REG will return 
>> BIT_ULL(IOCSRM_AVEC_EN) if there is avec?
>>
> no, it is IOCSRM_AVEC_EN after drivier  enable avecintc.
> static inline void avecintc_enable(void)
> {
>          u64 value;
> 
>          value = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
>          value |= IOCSR_MISC_FUNC_AVEC_EN;
>          iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
> }
> 
> my thought  is that qemu has enabled avec by default,
> so I just add a  variable  OnOffAuto avecintc   on 
> LoongArchVirtMachineState,
>> Where is the write operation with register MISC_FUNC_REG?
>>
> no,  I will add it on v2?
> 
> how about add features and status on  LoongArchVirtMachineState for the 
> macine misc fetureas and status?
> like LoongArchExtIOICommonState
That sounds good to me.

Regards
Bibo Mao
> 
> Thanks.
> Song Gao
>> Regard
>> Bibo Mao
>>>           break;
>>>       default:
>>>           g_assert_not_reached();
>>> @@ -1212,6 +1231,10 @@ static void virt_class_init(ObjectClass *oc, 
>>> const void *data)
>>>           NULL, NULL);
>>>       object_class_property_set_description(oc, "v-eiointc",
>>>                               "Enable Virt Extend I/O Interrupt 
>>> Controller.");
>>> +    object_class_property_add(oc, "avecintc", "OnOffAuto",
>>> +        virt_get_avecintc, virt_set_avecintc, NULL, NULL);
>>> +    object_class_property_set_description(oc, "avecintc",
>>> +                            "Enable Advance Interrupt Controller.");
>>>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>>>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
>>>   #ifdef CONFIG_TPM
>>> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
>>> index 2b7d19953f..3a81f048e8 100644
>>> --- a/include/hw/loongarch/virt.h
>>> +++ b/include/hw/loongarch/virt.h
>>> @@ -50,6 +50,7 @@ struct LoongArchVirtMachineState {
>>>       Notifier     powerdown_notifier;
>>>       OnOffAuto    acpi;
>>>       OnOffAuto    veiointc;
>>> +    OnOffAuto    avecintc;
>>>       char         *oem_id;
>>>       char         *oem_table_id;
>>>       DeviceState  *acpi_ged;
>>> @@ -70,6 +71,14 @@ 
>>> OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, 
>>> LOONGARCH_VIRT_MACHINE)
>>>   void virt_acpi_setup(LoongArchVirtMachineState *lvms);
>>>   void virt_fdt_setup(LoongArchVirtMachineState *lvms);
>>>   +static inline bool 
>>> virt_is_avecintc_enabled(LoongArchVirtMachineState *lvms)
>>> +{
>>> +    if (lvms->avecintc == ON_OFF_AUTO_OFF) {
>>> +        return false;
>>> +    }
>>> +    return true;
>>> +}
>>> +
>>>   static inline bool 
>>> virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
>>>   {
>>>       if (lvms->veiointc == ON_OFF_AUTO_OFF) {
>>>


