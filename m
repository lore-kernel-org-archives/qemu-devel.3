Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B32C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 07:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRQrW-0000D6-VV; Tue, 17 Jun 2025 03:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uRQrI-0000B9-5e
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 03:35:59 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uRQrD-0001xu-Op
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 03:35:50 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxLGvFGlFomjsYAQ--.56136S3;
 Tue, 17 Jun 2025 15:35:33 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBx3xvCGlFoDg0eAQ--.37253S3;
 Tue, 17 Jun 2025 15:35:32 +0800 (CST)
Subject: Re: [PATCH 07/10] hw/loongarch: connect pch_msi controller to avec
 controller
To: gaosong <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250609104833.839811-1-gaosong@loongson.cn>
 <20250609104833.839811-8-gaosong@loongson.cn>
 <b0441034-9c99-0480-d0e1-2e30aac9a143@loongson.cn>
 <57f90747-1829-5e0e-fbb2-d4615ceeb72f@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <5551ef94-90fd-9388-d02d-5a32029e16aa@loongson.cn>
Date: Tue, 17 Jun 2025 15:34:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <57f90747-1829-5e0e-fbb2-d4615ceeb72f@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx3xvCGlFoDg0eAQ--.37253S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXF47JF18Jw4xXF1furykZwc_yoWrJw45pF
 WkJFW5CrWUJ348Jr1kWr1UWry5Ar4UK3W7Xr1xXFy8Jr1UXr1jgr18Xr1qgr1UJrW8Xr1U
 Zr1UWrZFvF1UAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.129,
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



On 2025/6/17 上午9:58, gaosong wrote:
> 在 2025/6/11 下午2:36, Bibo Mao 写道:
>>
>>
>> On 2025/6/9 下午6:48, Song Gao wrote:
>>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>>> ---
>>>   hw/loongarch/virt.c | 18 +++++++++++++-----
>>>   1 file changed, 13 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>>> index 718b5b4f92..6b670e7936 100644
>>> --- a/hw/loongarch/virt.c
>>> +++ b/hw/loongarch/virt.c
>>> @@ -503,11 +503,19 @@ static void 
>>> virt_irq_init(LoongArchVirtMachineState *lvms, MachineState *ms)
>>>       qdev_prop_set_uint32(pch_msi, "msi_irq_num", num);
>>>       d = SYS_BUS_DEVICE(pch_msi);
>>>       sysbus_realize_and_unref(d, &error_fatal);
>>> -    sysbus_mmio_map(d, 0, VIRT_PCH_MSI_ADDR_LOW);
>>> -    for (i = 0; i < num; i++) {
>>> -        /* Connect pch_msi irqs to extioi */
>>> -        qdev_connect_gpio_out(DEVICE(d), i,
>>> -                              qdev_get_gpio_in(extioi, i + start));
>>> +    if (virt_is_avecintc_enabled(lvms)) {
>>> +        for (i = 0; i < num; i++) {
>>> +            /* Connect pch_msi irqs to avec */
>>> +            qdev_connect_gpio_out(DEVICE(d), i,
>>> +                                 qdev_get_gpio_in(avec, i + start));
>> one parent irqline for avec is enough. Variable num is the number 
>> allocated for pch_msi when connecting to extioi. So variable num is 
>> meaningless with avec.
>>
> hi,
> here is  pch_msi  [start-256] gpio_out  connect to avec gpio_in [start, 
> 256], not the avec connect to cpu.
pch_msi is always connected to eiointc, and it is not connected to avec 
gpio_in. There is two MSI controllers coexisting together: pch_msi and 
avec, guest OS can choose use one of them or both.

Regards
Bibo Mao

> and  I think  the 'one parent lrqline for avec'  is avec connect cpu 
> gpio_in INT_AVEC at patch 6
> 'qdev_connect_gpio_out(avec, cpu, qdev_get_gpio_in(cpudev, INT_AVEC));'
> or all pch_msi gpio_out connect one avec gpio_in ?  I'm a little 
> confused here.
> 
>> Also there is no msi memory map region for avec such as 
>> sysbus_mmio_map() in the following.
>>
> emm, the region add at patch 6
>    memory_region_add_subregion(get_system_memory(), VIRT_PCH_MSI_ADDR_LOW,
> sysbus_mmio_get_region(SYS_BUS_DEVICE(avec), 0));
> 
> I will adjust the patch order and the code order.
> 
>>> +        }
>>> +    } else {In the first, I think irqchip avec and pch_msi can 
>>> coexist together.
>> MSI memory area for avec is
>>    [VIRT_PCH_MSI_ADDR_LOW - 0x100000, VIRT_PCH_MSI_ADDR_LOW)
> yes, you're right. memory area for avec should be 2fe0000000-2ff0000000;
>> for pch_msi is
>>    [VIRT_PCH_MSI_ADDR_LOW, VIRT_PCH_MSI_ADDR_LOW + 0x8)
>>
>> For parent line, AVEC is connected to CPU MSGINT BIT14 and pch_msi is
>> connected to extioi.
>>
>> So they can coexists together, it only depends on how guest kernel use 
>> MSI controller.
>>
> emm,  in case avec exists we should pick avec.
> 
> thanks.
> Song Gao.
>> Regards
>> Bibo Mao
>>> +        sysbus_mmio_map(d, 0, VIRT_PCH_MSI_ADDR_LOW);
>>> +        for (i = 0; i < num; i++) {
>>> +            /* Connect pch_msi irqs to extioi */
>>> +            qdev_connect_gpio_out(DEVICE(d), i,
>>> +                                  qdev_get_gpio_in(extioi, i + start));
>>> +        }
>>>       }
>>>         virt_devices_init(pch_pic, lvms);
>>>


