Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C315DFC618A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2024 01:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spI1p-0001rx-8x; Fri, 13 Sep 2024 21:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1spI1n-0001qg-Ct
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 21:56:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1spI1k-0003IY-65
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 21:56:47 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxPOpW7eRmvpkHAA--.17939S3;
 Sat, 14 Sep 2024 09:56:38 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxQNZR7eRmHmoGAA--.31255S3;
 Sat, 14 Sep 2024 09:56:36 +0800 (CST)
Subject: Re: [PATCH 3/5] include: Add loongarch_pic_common header file
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20240912023537.1004979-1-maobibo@loongson.cn>
 <20240912023537.1004979-4-maobibo@loongson.cn>
 <cdd1803b-6db6-42d0-b9a7-0803c5ea0f71@linaro.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <e0dc7fe3-c4b0-b898-bad4-73fd40769d22@loongson.cn>
Date: Sat, 14 Sep 2024 09:56:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cdd1803b-6db6-42d0-b9a7-0803c5ea0f71@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxQNZR7eRmHmoGAA--.31255S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF4Uuw4Uur45Ww47Jr1UArc_yoWrJFy7pr
 18AryayrWDJrWxGr1xXw1UAry7Jr4xJw1UWrnIgFyUJF15Jry0qr1jqr1qgF1UXr48Jry8
 Xr1DCws09r1UJrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.566,
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



On 2024/9/14 上午1:19, Philippe Mathieu-Daudé wrote:
> On 12/9/24 04:35, Bibo Mao wrote:
>> From: bibo mao <maobibo@loongson.cn>
>>
>> For header file hw/intc/loongarch_pch_pic.h, add common file
>> hw/intc/loongarch_pic_common.h and remove duplicated macro definition
>> in file loongarch_pch_pic.h
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   include/hw/intc/loongarch_pch_pic.h | 36 +++++------------------------
>>   1 file changed, 6 insertions(+), 30 deletions(-)
> 
> Maybe easier to review if moved as first patch, moving definitions
> to the new include/hw/intc/loongarch_pic_common.h
Good suggestion, will do in this way.
And thanks for you advice.

Regards
Bibo Mao
> 
>> diff --git a/include/hw/intc/loongarch_pch_pic.h 
>> b/include/hw/intc/loongarch_pch_pic.h
>> index d5437e88f2..c71ee59de2 100644
>> --- a/include/hw/intc/loongarch_pch_pic.h
>> +++ b/include/hw/intc/loongarch_pch_pic.h
>> @@ -5,42 +5,16 @@
>>    * Copyright (c) 2021 Loongson Technology Corporation Limited
>>    */
>> +#ifndef HW_LOONGARCH_PCH_PIC_H
>> +#define HW_LOONGARCH_PCH_PIC_H
>> +
>>   #include "hw/sysbus.h"
>> +#include "hw/intc/loongarch_pic_common.h"
>>   #define TYPE_LOONGARCH_PCH_PIC "loongarch_pch_pic"
>>   #define PCH_PIC_NAME(name) TYPE_LOONGARCH_PCH_PIC#name
>>   OBJECT_DECLARE_SIMPLE_TYPE(LoongArchPCHPIC, LOONGARCH_PCH_PIC)
>> -#define PCH_PIC_INT_ID_VAL              0x7000000UL
>> -#define PCH_PIC_INT_ID_VER              0x1UL
>> -
>> -#define PCH_PIC_INT_ID_LO               0x00
>> -#define PCH_PIC_INT_ID_HI               0x04
>> -#define PCH_PIC_INT_MASK_LO             0x20
>> -#define PCH_PIC_INT_MASK_HI             0x24
>> -#define PCH_PIC_HTMSI_EN_LO             0x40
>> -#define PCH_PIC_HTMSI_EN_HI             0x44
>> -#define PCH_PIC_INT_EDGE_LO             0x60
>> -#define PCH_PIC_INT_EDGE_HI             0x64
>> -#define PCH_PIC_INT_CLEAR_LO            0x80
>> -#define PCH_PIC_INT_CLEAR_HI            0x84
>> -#define PCH_PIC_AUTO_CTRL0_LO           0xc0
>> -#define PCH_PIC_AUTO_CTRL0_HI           0xc4
>> -#define PCH_PIC_AUTO_CTRL1_LO           0xe0
>> -#define PCH_PIC_AUTO_CTRL1_HI           0xe4
>> -#define PCH_PIC_ROUTE_ENTRY_OFFSET      0x100
>> -#define PCH_PIC_ROUTE_ENTRY_END         0x13f
>> -#define PCH_PIC_HTMSI_VEC_OFFSET        0x200
>> -#define PCH_PIC_HTMSI_VEC_END           0x23f
>> -#define PCH_PIC_INT_STATUS_LO           0x3a0
>> -#define PCH_PIC_INT_STATUS_HI           0x3a4
>> -#define PCH_PIC_INT_POL_LO              0x3e0
>> -#define PCH_PIC_INT_POL_HI              0x3e4
>> -
>> -#define STATUS_LO_START                 0
>> -#define STATUS_HI_START                 0x4
>> -#define POL_LO_START                    0x40
>> -#define POL_HI_START                    0x44
>>   struct LoongArchPCHPIC {
>>       SysBusDevice parent_obj;
>>       qemu_irq parent_irq[64];
>> @@ -67,3 +41,5 @@ struct LoongArchPCHPIC {
>>       MemoryRegion iomem8;
>>       unsigned int irq_num;
>>   };
>> +
>> +#endif /* HW_LOONGARCH_PCH_PIC_H */


