Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201DBC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 08:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuoan-0008Ni-Hi; Wed, 19 Mar 2025 04:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tuoaZ-0008Ml-10
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:15:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tuoaS-0001Dc-UF
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 04:15:46 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bxjawlfdpn2NGcAA--.35661S3;
 Wed, 19 Mar 2025 16:15:34 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCxbsUhfdpnJk1TAA--.45760S3;
 Wed, 19 Mar 2025 16:15:31 +0800 (CST)
Subject: Re: [PATCH v4 2/4] hw/loongarch/virt: Remove unnecessary NULL pointer
To: Markus Armbruster <armbru@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250319020847.1511759-1-maobibo@loongson.cn>
 <20250319020847.1511759-3-maobibo@loongson.cn> <87v7s5345y.fsf@pond.sub.org>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <6b6b0792-04af-220d-8375-cef4b09b3ea9@loongson.cn>
Date: Wed, 19 Mar 2025 16:14:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87v7s5345y.fsf@pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxbsUhfdpnJk1TAA--.45760S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr15Cr13trWxGFyxZw13trc_yoW7ZFyDpr
 47J3Wq9ryDAF12v3yIvFyFgFy0yr1xta1xW393t3W3ZF1DGryDtF47Kw1F9rW3urWvga1S
 qa13CFn8uF1SqFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTmDUUU
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



On 2025/3/19 下午2:50, Markus Armbruster wrote:
> Bibo Mao <maobibo@loongson.cn> writes:
> 
>> There is NULL pointer checking function error_propagate() already,
>> it is not necessary to add checking for function parameter. Here remove
>> NULL pointer checking with function parameter.
> 
> I believe the title "Remove unnecessary NULL pointer" and this paragraph
> are remnants of your initial version, which transformed
> 
>      if (err) {
>          error_propagate(errp, err);
>      }
> 
> to just
> 
>      error_propagate(errp, err);
> 
> However, the patch doesn't do that anymore.
> 
> I think you should drop the paragraph, and replace the title.
yes, the title is misleading. Originally the problem is found with 
script scripts/coccinelle/remove_local_err.cocci, so here is the title.

How about "Remove local error object" or something else. Could you 
please provide some suggestions since English is your mother language?

> 
> I apologize for not noticing this earlier.
It is not necessary for the apologize. I appreciate your review 
comments. With effective communication, the quality of code is better.
> 
>> Since function will return directly when there is error report, this
>> patch removes combination about error_setg() and error_propagate(),
>> error_setg() with dest error object is used directly such as:
>>
>>    error_setg(err);                 -------->      error_setg(errp);
>>    error_propagate(errp, err);                     return;
>>    return;
> 
> Yes, much of the patch does this or equivalent transformations.
> However, there's more; see [*] below.
> 
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/loongarch/virt.c | 33 ++++++++++++---------------------
>>   1 file changed, 12 insertions(+), 21 deletions(-)
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index a5840ff968..a9fab39dd8 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -859,30 +859,29 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>       LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>>       CPUState *cs = CPU(dev);
>>       CPUArchId *cpu_slot;
>> -    Error *err = NULL;
>>       LoongArchCPUTopo topo;
>>       int arch_id;
>>   
>>       if (lvms->acpi_ged) {
>>           if ((cpu->thread_id < 0) || (cpu->thread_id >= ms->smp.threads)) {
>> -            error_setg(&err,
>> +            error_setg(errp,
>>                          "Invalid thread-id %u specified, must be in range 1:%u",
>>                          cpu->thread_id, ms->smp.threads - 1);
>> -            goto out;
>> +            return;
>>           }
>>   
>>           if ((cpu->core_id < 0) || (cpu->core_id >= ms->smp.cores)) {
>> -            error_setg(&err,
>> +            error_setg(errp,
>>                          "Invalid core-id %u specified, must be in range 1:%u",
>>                          cpu->core_id, ms->smp.cores - 1);
>> -            goto out;
>> +            return;
>>           }
>>   
>>           if ((cpu->socket_id < 0) || (cpu->socket_id >= ms->smp.sockets)) {
>> -            error_setg(&err,
>> +            error_setg(errp,
>>                          "Invalid socket-id %u specified, must be in range 1:%u",
>>                          cpu->socket_id, ms->smp.sockets - 1);
>> -            goto out;
>> +            return;
>>           }
>>   
>>           topo.socket_id = cpu->socket_id;
>> @@ -891,11 +890,11 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>           arch_id =  virt_get_arch_id_from_topo(ms, &topo);
>>           cpu_slot = virt_find_cpu_slot(ms, arch_id);
>>           if (CPU(cpu_slot->cpu)) {
>> -            error_setg(&err,
>> +            error_setg(errp,
>>                          "cpu(id%d=%d:%d:%d) with arch-id %" PRIu64 " exists",
>>                          cs->cpu_index, cpu->socket_id, cpu->core_id,
>>                          cpu->thread_id, cpu_slot->arch_id);
>> -            goto out;
>> +            return;
>>           }
>>       } else {
>>           /* For cold-add cpu, find empty cpu slot */
>> @@ -911,33 +910,24 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>       cpu->env.address_space_iocsr = &lvms->as_iocsr;
>>       cpu->phy_id = cpu_slot->arch_id;
>>       cs->cpu_index = cpu_slot - ms->possible_cpus->cpus;
>> -    numa_cpu_pre_plug(cpu_slot, dev, &err);
>> -out:
>> -    if (err) {
>> -        error_propagate(errp, err);
>> -    }
>> +    numa_cpu_pre_plug(cpu_slot, dev, errp);
>>   }
>>   
>>   static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
>>                                       DeviceState *dev, Error **errp)
>>   {
>>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
>> -    Error *err = NULL;
>>       LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>>       CPUState *cs = CPU(dev);
>>   
>>       if (cs->cpu_index == 0) {
>> -        error_setg(&err, "hot-unplug of boot cpu(id%d=%d:%d:%d) not supported",
>> +        error_setg(errp, "hot-unplug of boot cpu(id%d=%d:%d:%d) not supported",
>>                      cs->cpu_index, cpu->socket_id,
>>                      cpu->core_id, cpu->thread_id);
>> -        error_propagate(errp, err);
>>           return;
>>       }
>>   
>> -    hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
>> -    if (err) {
>> -        error_propagate(errp, err);
>> -    }
>> +    hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, errp);
>>   }
>>   
>>   static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
>> @@ -1003,6 +993,7 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>>           hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
>>           if (err) {
>>               error_propagate(errp, err);
>> +            return;
>>           }
>>       }
> 
>         cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
>         cpu_slot->cpu = NULL;
>         return;
>     }
> 
> [*] This is something else.  Before the patch, we clear cpu_slot->cpu
> evem when the last hotplug_handler() fails.  Afterwards, we don't.
> Looks like a bug fix to me.  Either mention the fix in the commit
> message, or split it off into a separate patch.  I'd do the latter.
> 
yes, will split it into two patches. The latter is bugfix, when cpu 
fails to unplug and it should return immediately, so that system can 
continue to run , and cpu_slot->cpu should not be cleared.

Regards
Bibo Mao


