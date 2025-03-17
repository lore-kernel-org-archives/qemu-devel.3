Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACDCC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 06:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu4Hr-0005UB-J9; Mon, 17 Mar 2025 02:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tu4Hp-0005Ts-Ne
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 02:49:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tu4Hm-0000dR-Gg
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 02:49:21 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxNHDnxddnq5aZAA--.63304S3;
 Mon, 17 Mar 2025 14:49:11 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCxPsfexddnVwJPAA--.30586S3;
 Mon, 17 Mar 2025 14:49:10 +0800 (CST)
Subject: Re: [PATCH v3 2/3] hw/loongarch/virt: Remove unnecessary NULL pointer
To: Markus Armbruster <armbru@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250317022922.802988-1-maobibo@loongson.cn>
 <20250317022922.802988-3-maobibo@loongson.cn> <8734fcgpek.fsf@pond.sub.org>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <7dcb68bc-b3ee-c509-15bc-33019f9922ac@loongson.cn>
Date: Mon, 17 Mar 2025 14:48:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8734fcgpek.fsf@pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPsfexddnVwJPAA--.30586S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr4kJw1UWr1xuw4kZFWrWFX_yoWrWF18pr
 s7J3WqvrWUAF10v3yFvFyagFy0vr1xtan7u39xt3W7Z3WDKrn8tF12kw1F9FW3CFW0gayf
 Xa13CFs8uF1SqFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
 14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
 CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
 MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
 4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
 WIevJa73UjIFyTuYvjxU24SoDUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.664,
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



On 2025/3/17 下午2:08, Markus Armbruster wrote:
> Bibo Mao <maobibo@loongson.cn> writes:
> 
>> There is NULL pointer checking function error_propagate() already,
>> it is not necessary to add checking for function parameter. Here remove
>> NULL pointer checking with function parameter.
>>
>> Since function will return directly when there is error report, this
>> patch removes combination about error_setg() and error_propagate(),
>> error_setg() with dest error object is used directly such as:
>>
>>    error_setg(err);                 -------->      error_setg(errp);
>>    error_propagate(errp, err);                     return;
>>    return;
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/loongarch/virt.c | 28 +++++++++++-----------------
>>   1 file changed, 11 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index a5840ff968..1fd91f94b5 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -865,24 +865,24 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
>> @@ -891,11 +891,11 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
>> @@ -912,10 +912,6 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>       cpu->phy_id = cpu_slot->arch_id;
>>       cs->cpu_index = cpu_slot - ms->possible_cpus->cpus;
>>       numa_cpu_pre_plug(cpu_slot, dev, &err);
> 
> You need to pass errp instead of &err now.
yes, should pass errp and remove local variable Error err.

> 
>> -out:
>> -    if (err) {
>> -        error_propagate(errp, err);
>> -    }
>>   }
>>   
>>   static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
>> @@ -927,17 +923,14 @@ static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
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
>>       hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
>> -    if (err) {
>> -        error_propagate(errp, err);
>> -    }
>> +    error_propagate(errp, err);
> 
> Missed this cleanup:
> 
>         hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, errp);
>   }
will do. With that, almost all local variable Error *err is removed. And 
that is cleaner.

Regards
Bibo Mao
> 
>>   }
>>   
>>   static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
>> @@ -1003,6 +996,7 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>>           hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
>>           if (err) {
>>               error_propagate(errp, err);
>> +            return;
>>           }
>>       }
> 


