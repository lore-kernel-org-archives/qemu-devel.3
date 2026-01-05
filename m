Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7979DC2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 01:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcZAE-0002hU-8o; Sun, 04 Jan 2026 20:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vcZA7-0002hB-Le
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 20:13:36 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vcZA4-000514-Q2
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 20:13:35 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxLMM1EFtp0nUFAA--.16960S3;
 Mon, 05 Jan 2026 09:13:25 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAx38IyEFtpUYINAA--.30460S3;
 Mon, 05 Jan 2026 09:13:24 +0800 (CST)
Subject: Re: [PATCH v2 4/4] target/loongarch: Add some CPUCFG bits with host
 CPU model
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20260104022905.2120787-1-maobibo@loongson.cn>
 <20260104022905.2120787-5-maobibo@loongson.cn>
 <05847b10-91ee-4def-83e7-0e0cb50da585@linaro.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <be99fefd-be30-8a43-e814-3b3889a7e65f@loongson.cn>
Date: Mon, 5 Jan 2026 09:10:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <05847b10-91ee-4def-83e7-0e0cb50da585@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx38IyEFtpUYINAA--.30460S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw13JryrtF4rCr13XFW8uFX_yoW8CFW7pr
 WIyr13JFW8GFZ3Aw1ftw4UWF9xXr4xGw47Wa4fKFy8Cr43Xr12qr40qFZ29F1DJ397Cr12
 qFs0vrn8uFsrZ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xuctUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.628,
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



On 2026/1/4 下午11:11, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 4/1/26 03:29, Bibo Mao wrote:
>> Some CPUCFG capability bits depend on KVM host hypervsior and they
>> are detected on QEMU. However some CPUCFG bits are irrelative with
>> hypervsior, here these bits are checked from host machine and set
>> for VM with host CPU model.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   target/loongarch/cpu.c | 27 ++++++++++++++++++++++++++-
>>   target/loongarch/cpu.h |  8 ++++++++
>>   2 files changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index f9255c4f84..b87819c8e0 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -503,7 +503,7 @@ static uint32_t get_host_cpucfg(int number)
>>   static void loongarch_host_initfn(Object *obj)
>>   {
>> -    uint32_t data;
>> +    uint32_t data, cpucfg, field;
>>       uint64_t cpuid;
>>       LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>> @@ -513,6 +513,31 @@ static void loongarch_host_initfn(Object *obj)
>>           cpu->env.cpucfg[0] = data;
>>       }
>> +    /* Set cpucfg bits irrelative with KVM hypervisor */
> 
> What do you mean by "irrelative"?
Different from FPU/LSX feature, some features like 128-bit atomic 
instruction etc are only indication in cpucfg, there is no enabling or 
disabling control function in KVM hypervisor. And there is no exception 
in KVM hypervisor when 128-bit atomic instruction is executed if 
hardware supports, KVM hypervisor cannot control this.

How about changing the comments like this?
    /*
     * There is no exception in KVM hypervisor when these intructions are
     * executed if HW support, KVM hypervisor cannot control this.
     *
     * Set cpucfg bits which cannot be controlled by KVM hypervisor.
     */

Regards
Bibo Mao


