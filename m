Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E6CC369D5
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Apr 2025 06:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8vvH-0001rC-Oz; Sun, 27 Apr 2025 02:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u8vvB-0001qK-FO
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 02:55:26 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u8vv8-00049T-3K
 for qemu-devel@nongnu.org; Sun, 27 Apr 2025 02:55:25 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxbeLK1A1o0hzHAA--.29906S3;
 Sun, 27 Apr 2025 14:55:07 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCxLcXH1A1ojUaYAA--.50309S3;
 Sun, 27 Apr 2025 14:55:05 +0800 (CST)
Subject: Re: [PATCH v2 04/16] hw/intc/loongarch_pch: Set version information
 at initial stage
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250324093730.3683378-1-maobibo@loongson.cn>
 <20250324093730.3683378-5-maobibo@loongson.cn>
 <b1ac7812-ac9b-4bcc-a04e-93dd43fbec51@linaro.org>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <2c55bf31-f3b7-b345-e6e7-864edbd7277b@loongson.cn>
Date: Sun, 27 Apr 2025 14:53:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b1ac7812-ac9b-4bcc-a04e-93dd43fbec51@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxLcXH1A1ojUaYAA--.50309S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF17CrW7Wr15tF45XFy3Jrc_yoW5JF4fpr
 1kArW3JrWUJrn7Jr1xAr1UXFy5JF4rJw1UWr1IgFyUJF45Jr10qr1UXr1j9F1UJr48Jr1j
 qr15Grn8uF1UXrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
 Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
 JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
 CYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
 6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
 AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
 0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
 v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
 xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8TqcUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.665,
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



On 2025/4/25 下午5:57, Philippe Mathieu-Daudé wrote:
> On 24/3/25 10:37, Bibo Mao wrote:
>> Register PCH_PIC_INT_ID constains version and supported irq number
>> information, and it is read only register. The detailed value can
>> be set at initial stage, rather than read callback.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/intc/loongarch_pch_pic.c            | 17 ++++++++++-------
>>   include/hw/intc/loongarch_pic_common.h | 17 +++++++++++++++--
>>   2 files changed, 25 insertions(+), 9 deletions(-)
> 
> 
>> diff --git a/include/hw/intc/loongarch_pic_common.h 
>> b/include/hw/intc/loongarch_pic_common.h
>> index ef6edc15bf..fb848da4b8 100644
>> --- a/include/hw/intc/loongarch_pic_common.h
>> +++ b/include/hw/intc/loongarch_pic_common.h
>> @@ -10,9 +10,9 @@
>>   #include "hw/pci-host/ls7a.h"
>>   #include "hw/sysbus.h"
>> -#define PCH_PIC_INT_ID_VAL              0x7000000UL
>> -#define PCH_PIC_INT_ID_VER              0x1UL
>>   #define PCH_PIC_INT_ID                  0x00
>> +#define  PCH_PIC_INT_ID_VAL             0x7
>> +#define  PCH_PIC_INT_ID_VER             0x1
>>   #define PCH_PIC_INT_MASK                0x20
>>   #define PCH_PIC_HTMSI_EN                0x40
>>   #define PCH_PIC_INT_EDGE                0x60
>> @@ -30,10 +30,23 @@
>>   OBJECT_DECLARE_TYPE(LoongArchPICCommonState,
>>                       LoongArchPICCommonClass, LOONGARCH_PIC_COMMON)
>> +union LoongArchPIC_ID {
>> +    struct {
>> +        uint64_t _reserved_0:24;
>> +        uint64_t id:8;
> 
> Why not use:
> 
>             uint8_t _reserved_0[3];
>             uint8_t id;
> 
> Otherwise see commit ecbf3567e21 ("docs/devel/style: add a section about
> bitfield, and disallow them for packed structures"), this might give
> troubles on Windows or big-endian hosts such s390x.
Good suggestion, will use this method rather than bit-field method.

Regards
Bibo Mao
> 
>> +        uint64_t version:8;
>> +        uint64_t _reserved_1:8;
>> +        uint64_t irq_num:8;
>> +        uint64_t _reserved_2:8;
>  > +    } QEMU_PACKED desc;> +    uint64_t data;
>> +};


