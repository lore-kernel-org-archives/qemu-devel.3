Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DE9C25B76
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4FIW-0007HZ-UG; Tue, 07 May 2024 03:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s4FIU-0007HO-RL
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:31:34 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s4FIR-0001gb-Uc
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:31:34 -0400
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8AxTevM2DlmErUIAA--.16969S3;
 Tue, 07 May 2024 15:31:24 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxX1XJ2DlmDLYTAA--.22246S3; 
 Tue, 07 May 2024 15:31:23 +0800 (CST)
Subject: Re: [PATCH v3 1/5] hw/loongarch: Rename LOONGARCH_MACHINE with
 VIRT_MACHINE
To: Thomas Huth <thuth@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240506030206.2119832-1-maobibo@loongson.cn>
 <20240506030206.2119832-2-maobibo@loongson.cn>
 <b1a4b08c-e288-4319-ac4a-7d6ca1256755@redhat.com>
 <1a05cc73-3fda-2b17-e9be-541113a751fb@loongson.cn>
 <d5845d4e-c50d-87e6-c8d6-b21bd354c148@loongson.cn>
 <ea6ca025-8c2a-49ab-a5b5-9e77d1d4114a@redhat.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <fd244788-9452-8c25-eb2f-cbfe8484ad27@loongson.cn>
Date: Tue, 7 May 2024 15:31:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ea6ca025-8c2a-49ab-a5b5-9e77d1d4114a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxX1XJ2DlmDLYTAA--.22246S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZFy8tFyrKr43CF48XrWDGFX_yoW5uFWUpF
 Z7AF1kArWrXr48Cr4Iqwn8WFyjyr9rG34UWFn3JFW8t3909ryjgr40vrWq9F1DAw48tF18
 Zwn5C34fZFn8JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 F4_UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.593,
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



On 2024/5/7 下午2:10, Thomas Huth wrote:
> On 07/05/2024 03.18, maobibo wrote:
>>
>>
>> On 2024/5/6 下午2:09, maobibo wrote:
>>>
>>>
>>> On 2024/5/6 下午12:24, Thomas Huth wrote:
>>>> On 06/05/2024 05.02, Bibo Mao wrote:
>>>>> On LoongArch system, there is only virt machine type now, name
>>>>> LOONGARCH_MACHINE is confused, rename it with VIRT_MACHINE. Machine 
>>>>> name
>>>>> about Other real hw boards can be added in future.
>>>>>
>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>>> ---
>>>> ...
>>>>> @@ -1245,7 +1244,7 @@ static void loongarch_class_init(ObjectClass 
>>>>> *oc, void *data)
>>>>>   static const TypeInfo loongarch_machine_types[] = {
>>>>>       {
>>>>> -        .name           = TYPE_LOONGARCH_MACHINE,
>>>>> +        .name           = TYPE_VIRT_MACHINE,
>>>>>           .parent         = TYPE_MACHINE,
>>>>>           .instance_size  = sizeof(LoongArchMachineState),
>>>>>           .class_init     = loongarch_class_init,
>>>>> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
>>>>> index 4e14bf6060..5ea2f0370d 100644
>>>>> --- a/include/hw/loongarch/virt.h
>>>>> +++ b/include/hw/loongarch/virt.h
>>>>> @@ -73,8 +73,8 @@ struct LoongArchMachineState {
>>>>>       struct loongarch_boot_info bootinfo;
>>>>>   };
>>>>> -#define TYPE_LOONGARCH_MACHINE  MACHINE_TYPE_NAME("virt")
>>>>> -OBJECT_DECLARE_SIMPLE_TYPE(LoongArchMachineState, LOONGARCH_MACHINE)
>>>>> +#define TYPE_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
>>>>> +OBJECT_DECLARE_SIMPLE_TYPE(LoongArchMachineState, VIRT_MACHINE)
>>>>>   bool loongarch_is_acpi_enabled(LoongArchMachineState *lams);
>>>>>   void loongarch_acpi_setup(LoongArchMachineState *lams);
>>>>>   #endif
>>>>
>>>>   Hi,
>>>>
>>>> there are currently some efforts going on to create the possibility 
>>>> to link a QEMU binary that contains all targets in one binary. Since 
>>>> we already have a TYPE_VIRT_MACHINE for other targets, I wonder 
>>>> whether it might be better to use LOONGARCH_VIRT_MACHINE than just 
>>>> VIRT_MACHINE here? Philippe, could you comment on this?
>>>
>>> It is great if there is one QEMU binary which supports different 
>>> targets. And LOONGARCH_VIRT_MACHINE is ok for me.
>> Hi Thomas, Philippe,
>>
>> Does machine name "virt" need be changed if LOONGARCH_VIRT_MACHINE is 
>> used? There will be compatible issues if "virt" machine type is not 
>> suggested to use.
>>
>> However CPU type "max" is not widely used now, can we get different 
>> architectures from CPU type rather than machine type for one QEMU 
>> binary which supports different targets?
> 
> I assume it should be fine to keep the "virt" machine name and "max" CPU 
> type for each target, we've got a bunch of those already. I assume we'll 
> keep the binary names as symlinks to the generic binary around and then 
> decide via argv[0] about the main target...? Philippe, do you have 
> already concrete plans for this?
The method using symlinks to generic binary is great. It is transparent 
to detailed architectures. I will refresh the patch and use 
LOONGARCH_VIRT_MACHINE macro.

Regards
Bibo Mao
> 
>   Thomas
> 
> 


