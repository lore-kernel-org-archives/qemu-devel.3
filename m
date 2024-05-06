Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1BBC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 06:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3rYA-0004oE-3l; Mon, 06 May 2024 02:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s3rY7-0004o6-DZ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 02:10:07 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s3rY0-0002so-8I
 for qemu-devel@nongnu.org; Mon, 06 May 2024 02:10:06 -0400
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8CxCuoxdDhm6vgHAA--.10042S3;
 Mon, 06 May 2024 14:09:54 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxFlcudDhmTC4SAA--.20446S3; 
 Mon, 06 May 2024 14:09:52 +0800 (CST)
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
From: maobibo <maobibo@loongson.cn>
Message-ID: <1a05cc73-3fda-2b17-e9be-541113a751fb@loongson.cn>
Date: Mon, 6 May 2024 14:09:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b1a4b08c-e288-4319-ac4a-7d6ca1256755@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxFlcudDhmTC4SAA--.20446S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr18CFW7ur1rGrWfWw13Jrc_yoW8tr1UpF
 WxAF1kArW8Wr48Crn7W3s8WFyUArn7C347WFnxtFW0yrWqkryjgr48Z34q9F1UAw48tr40
 qw1ku34xZFn8JrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
 xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
 6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
 1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
 rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14
 v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
 c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYg4hUUU
 UU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.47,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 2024/5/6 下午12:24, Thomas Huth wrote:
> On 06/05/2024 05.02, Bibo Mao wrote:
>> On LoongArch system, there is only virt machine type now, name
>> LOONGARCH_MACHINE is confused, rename it with VIRT_MACHINE. Machine name
>> about Other real hw boards can be added in future.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
> ...
>> @@ -1245,7 +1244,7 @@ static void loongarch_class_init(ObjectClass 
>> *oc, void *data)
>>   static const TypeInfo loongarch_machine_types[] = {
>>       {
>> -        .name           = TYPE_LOONGARCH_MACHINE,
>> +        .name           = TYPE_VIRT_MACHINE,
>>           .parent         = TYPE_MACHINE,
>>           .instance_size  = sizeof(LoongArchMachineState),
>>           .class_init     = loongarch_class_init,
>> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
>> index 4e14bf6060..5ea2f0370d 100644
>> --- a/include/hw/loongarch/virt.h
>> +++ b/include/hw/loongarch/virt.h
>> @@ -73,8 +73,8 @@ struct LoongArchMachineState {
>>       struct loongarch_boot_info bootinfo;
>>   };
>> -#define TYPE_LOONGARCH_MACHINE  MACHINE_TYPE_NAME("virt")
>> -OBJECT_DECLARE_SIMPLE_TYPE(LoongArchMachineState, LOONGARCH_MACHINE)
>> +#define TYPE_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
>> +OBJECT_DECLARE_SIMPLE_TYPE(LoongArchMachineState, VIRT_MACHINE)
>>   bool loongarch_is_acpi_enabled(LoongArchMachineState *lams);
>>   void loongarch_acpi_setup(LoongArchMachineState *lams);
>>   #endif
> 
>   Hi,
> 
> there are currently some efforts going on to create the possibility to 
> link a QEMU binary that contains all targets in one binary. Since we 
> already have a TYPE_VIRT_MACHINE for other targets, I wonder whether it 
> might be better to use LOONGARCH_VIRT_MACHINE than just VIRT_MACHINE 
> here? Philippe, could you comment on this?

It is great if there is one QEMU binary which supports different 
targets. And LOONGARCH_VIRT_MACHINE is ok for me.

Regards
Bibo Mao
> 
>   Thomas


