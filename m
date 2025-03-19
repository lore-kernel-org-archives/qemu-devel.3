Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713E4C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 08:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuoKx-0006iO-9A; Wed, 19 Mar 2025 03:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tuoKq-0006hq-JE
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 03:59:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tuoKl-0003oV-Nr
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 03:59:32 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxaeBXedpng86cAA--.4429S3;
 Wed, 19 Mar 2025 15:59:19 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxHcVUedpn90dTAA--.42143S3;
 Wed, 19 Mar 2025 15:59:18 +0800 (CST)
Subject: Re: [PATCH v4 4/4] target/loongarch: Set dest error with error_abort
 in virt_cpu_irq_init
To: Markus Armbruster <armbru@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250319020847.1511759-1-maobibo@loongson.cn>
 <20250319020847.1511759-5-maobibo@loongson.cn> <877c4l4km1.fsf@pond.sub.org>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <3d9c1bff-c1a5-5e87-e912-7246c2c8f512@loongson.cn>
Date: Wed, 19 Mar 2025 15:58:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <877c4l4km1.fsf@pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxHcVUedpn90dTAA--.42143S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KryrXw1kGw1xCw45Gw4rJFc_yoW5JFyrpr
 Waya1v9F1DAa4Duws2gryUXF1jyrs3Kry7Xa9Ykr4Ykwn8Xr1FqFW7Cwn09FW8Cw4rXa95
 Xrs5GFs3WFn8AagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.526,
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



On 2025/3/19 下午2:09, Markus Armbruster wrote:
> Bibo Mao <maobibo@loongson.cn> writes:
> 
>> In function virt_cpu_irq_init(), there is notification with ipi and extioi
>> interrupt controller for cpu creation. Local variable with error type is
>> used, however there is no check with its return value.
> 
> Good catch.
> 
> When the first call fails, we pass non-null @err to the second call,
> which is wrong.  If that one also fails, it'll likely trip
> error_setv()'s assertion.
> 
>> Here set dest error object with error_abort, rather than local variable, so
>> application will abort to run if there is error.
> 
> Why is failure impossible there?
In plug hanlder of extioi/ipi, there is only warn_report() if object is 
not TYPE_LOONGARCH_CPU, parameter errp is not changed.

With caller funciton virt_cpu_irq_init(), DEVICE(cs) is object with type 
TYPE_LOONGARCH_CPU always, so failure is impossible here.

> 
> If failure is impossible, the code before the patch is harmlessly wrong.
yes, it is harmlessly wrong.

Regards
Bibo Mao
> 
> If failure is possible, the code before the patch has a crash bug, and
> the patch makes it crash harder, i.e. when either call fails instead of
> when both fail.
> 
>> Fixes: 50ebc3fc47fe (hw/intc/loongarch_ipi: Notify ipi object when cpu is plugged)
>> Fixes: 087a23a87c57 (hw/intc/loongarch_extioi: Use cpu plug notification)
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/loongarch/virt.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index a9fab39dd8..f10a4704ab 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -327,7 +327,6 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
>>       MachineClass *mc = MACHINE_GET_CLASS(ms);
>>       const CPUArchIdList *possible_cpus;
>>       CPUState *cs;
>> -    Error *err = NULL;
>>   
>>       /* cpu nodes */
>>       possible_cpus = mc->possible_cpu_arch_ids(ms);
>> @@ -337,8 +336,10 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
>>               continue;
>>           }
>>   
>> -        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), DEVICE(cs), &err);
>> -        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), DEVICE(cs), &err);
>> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), DEVICE(cs),
>> +                             &error_abort);
>> +        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), DEVICE(cs),
>> +                             &error_abort);
>>       }
>>   }
> 


