Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C51AEE01FA
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 01:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soBie-0000xH-1u; Tue, 10 Sep 2024 21:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1soBic-0000wA-0e
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 21:00:26 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1soBiY-0008VT-Br
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 21:00:25 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Cxjeqf6+Bm2zkEAA--.10619S3;
 Wed, 11 Sep 2024 09:00:15 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front2 (Coremail) with SMTP id qciowMAxa8ae6+BmXv4DAA--.18857S3;
 Wed, 11 Sep 2024 09:00:14 +0800 (CST)
Subject: Re: [PATCH 1/2] acpi: ged: Add macro for acpi ged sleep register
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Ani Sinha <anisinha@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, =?UTF-8?Q?Thomas_Wei=c3=9fschuh?=
 <thomas@t-8ch.de>, qemu-devel@nongnu.org
References: <20240906021943.150494-1-maobibo@loongson.cn>
 <20240906021943.150494-2-maobibo@loongson.cn>
 <20240910133154-mutt-send-email-mst@kernel.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <b927a0c2-7194-5706-3e08-0d872e0a37f4@loongson.cn>
Date: Wed, 11 Sep 2024 09:00:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240910133154-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowMAxa8ae6+BmXv4DAA--.18857S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr17JFWUKr1Uur4fAr4DJrc_yoW8KFWDpr
 yvvF9xKrZ7tF429r4Yv3WDCa48Kr4Y9rsrGF4vg34j93WUu34SgF10qr45Kry7Xa1fXF40
 q3sFq345Wr9I9rXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.597,
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



On 2024/9/11 上午1:32, Michael S. Tsirkin wrote:
> On Fri, Sep 06, 2024 at 10:19:42AM +0800, Bibo Mao wrote:
>> Macro definition is added for acpi ged sleep register, so that ged
>> emulation driver can use this, also it can be used in FDT table if
>> ged is exposed with FDT table.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/acpi/generic_event_device.c         | 6 +++---
>>   include/hw/acpi/generic_event_device.h | 3 +++
>>   2 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
>> index 15b4c3ebbf..10a338877c 100644
>> --- a/hw/acpi/generic_event_device.c
>> +++ b/hw/acpi/generic_event_device.c
>> @@ -201,9 +201,9 @@ static void ged_regs_write(void *opaque, hwaddr addr, uint64_t data,
>>   
>>       switch (addr) {
>>       case ACPI_GED_REG_SLEEP_CTL:
>> -        slp_typ = (data >> 2) & 0x07;
>> -        slp_en  = (data >> 5) & 0x01;
>> -        if (slp_en && slp_typ == 5) {
>> +        slp_typ = (data & ACPI_GED_SLP_TYP_MASK) >> ACPI_GED_SLP_TYP_SHIFT;
>> +        slp_en  = !!(data  & ACPI_GED_SLP_ENABLE);
>> +        if (slp_en && slp_typ == ACPI_GED_SLP_TYP_S5) {
>>               qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>>           }
>>           return;
>> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
>> index 40af3550b5..526fea6efe 100644
>> --- a/include/hw/acpi/generic_event_device.h
>> +++ b/include/hw/acpi/generic_event_device.h
>> @@ -82,7 +82,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>>   #define ACPI_GED_RESET_VALUE       0x42
>>   
>>   /* ACPI_GED_REG_SLEEP_CTL.SLP_TYP value for S5 (aka poweroff) */
>> +#define ACPI_GED_SLP_TYP_SHIFT     0x02
>>   #define ACPI_GED_SLP_TYP_S5        0x05
>> +#define ACPI_GED_SLP_TYP_MASK      0x1C
>> +#define ACPI_GED_SLP_ENABLE        0x20
> 
> The comment is wrong now, isn't it?
> Pls document each value, copying name from spec verbatim.
The name comes from linux header files with little modification.
#define ACPI_X_WAKE_STATUS          0x80
#define ACPI_X_SLEEP_TYPE_MASK      0x1C
#define ACPI_X_SLEEP_TYPE_POSITION  0x02
#define ACPI_X_SLEEP_ENABLE         0x20

yeap, it will better if comes from spec verbatim. I will investigate and 
refresh the patch in next version.

Regards
Bibo Mao
> 
>>   
>>   #define GED_DEVICE      "GED"
>>   #define AML_GED_EVT_REG "EREG"
>> -- 
>> 2.39.3


