Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE9AC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 09:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt1JW-0003XX-Tt; Fri, 14 Mar 2025 05:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tt1JT-0003X9-Kt
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 05:26:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tt1JQ-0004nW-B5
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 05:26:43 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxvOJC9tNnrEiWAA--.59937S3;
 Fri, 14 Mar 2025 17:26:27 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDxH+U+9tNn1JRKAA--.14533S3;
 Fri, 14 Mar 2025 17:26:26 +0800 (CST)
Subject: Re: [PATCH v2 2/3] hw/loongarch/virt: Remove unnecessary NULL pointer
 checking
To: Markus Armbruster <armbru@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250314084201.4182054-1-maobibo@loongson.cn>
 <20250314084201.4182054-3-maobibo@loongson.cn> <87plikrn81.fsf@pond.sub.org>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <63fc3b2b-140c-a4e4-c3ec-536cc31d9f11@loongson.cn>
Date: Fri, 14 Mar 2025 17:25:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87plikrn81.fsf@pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxH+U+9tNn1JRKAA--.14533S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr18AFWrWw1UJFW5tFWkGrX_yoW7GF48pr
 srt3WqvrykAF1vv34IyryagF10vr4xta1xZrZ8tw13XF1DWrnYyF42kw1a9FW3ArW09ayr
 Za13GFs8ZF1SqFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU8oGQDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.7,
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



On 2025/3/14 下午5:11, Markus Armbruster wrote:
> Bibo Mao <maobibo@loongson.cn> writes:
> 
>> There is NULL pointer checking function error_propagate() already,
>> it is not necessary to add checking for function parameter. Here remove
>> NULL pointer checking with function parameter.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/loongarch/virt.c | 25 +++++++++++--------------
>>   1 file changed, 11 insertions(+), 14 deletions(-)
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index a5840ff968..d82676d316 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -868,21 +868,24 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>               error_setg(&err,
>>                          "Invalid thread-id %u specified, must be in range 1:%u",
>>                          cpu->thread_id, ms->smp.threads - 1);
>> -            goto out;
>> +            error_propagate(errp, err);
>> +            return;
> 
> Make this

> 
>                 error_setg(&err, ...);
>                 return;
My bad. I remember replacing error_propagate with error_setg(errp, ...) 
already. Will do
> 
>>           }
>>   
>>           if ((cpu->core_id < 0) || (cpu->core_id >= ms->smp.cores)) {
>>               error_setg(&err,
>>                          "Invalid core-id %u specified, must be in range 1:%u",
>>                          cpu->core_id, ms->smp.cores - 1);
>> -            goto out;
>> +            error_propagate(errp, err);
>> +            return;
> 
> Likewise.
> 
>>           }
>>   
>>           if ((cpu->socket_id < 0) || (cpu->socket_id >= ms->smp.sockets)) {
>>               error_setg(&err,
>>                          "Invalid socket-id %u specified, must be in range 1:%u",
>>                          cpu->socket_id, ms->smp.sockets - 1);
>> -            goto out;
>> +            error_propagate(errp, err);
>> +            return;
> 
> Likewise.
> 
>>           }
>>   
>>           topo.socket_id = cpu->socket_id;
>> @@ -895,7 +898,8 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>                          "cpu(id%d=%d:%d:%d) with arch-id %" PRIu64 " exists",
>>                          cs->cpu_index, cpu->socket_id, cpu->core_id,
>>                          cpu->thread_id, cpu_slot->arch_id);
>> -            goto out;
>> +            error_propagate(errp, err);
>> +            return;
> 
> Likewise.
> 
>>           }
>>       } else {
>>           /* For cold-add cpu, find empty cpu slot */
>> @@ -912,10 +916,6 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>       cpu->phy_id = cpu_slot->arch_id;
>>       cs->cpu_index = cpu_slot - ms->possible_cpus->cpus;
>>       numa_cpu_pre_plug(cpu_slot, dev, &err);
> 
> You need to pass errp instead of &err now.
> 
>> -out:
>> -    if (err) {
>> -        error_propagate(errp, err);
>> -    }
>>   }
>>   
>>   static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
>> @@ -935,9 +935,7 @@ static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
>>       }
>>   
>>       hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
>> -    if (err) {
>> -        error_propagate(errp, err);
>> -    }
>> +    error_propagate(errp, err);
>>   }
> 
> Correct, but I'd recomment to go one step further:
> 
>   static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
>                                       DeviceState *dev, Error **errp)
>   {
>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
> -    Error *err = NULL;
>       LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>       CPUState *cs = CPU(dev);
>   
>       if (cs->cpu_index == 0) {
> -        error_setg(&err, "hot-unplug of boot cpu(id%d=%d:%d:%d) not supported",
> +        error_setg(errp, "hot-unplug of boot cpu(id%d=%d:%d:%d) not supported",
>                      cs->cpu_index, cpu->socket_id,
>                      cpu->core_id, cpu->thread_id);
> -        error_propagate(errp, err);
>           return;
>       }
>   
> -    hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -    }
> +    hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, errp);
>   }
> 
>>   
>>   static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
>> @@ -1001,9 +999,8 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>         cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
>         cpu_slot->cpu = CPU(dev);
>         if (lvms->ipi) {
>             hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev, &err);
>             if (err) {
>                 error_propagate(errp, err);
>                 return;
>             }
>         }
> 
>         if (lvms->extioi) {
>             hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), dev, &err);
>             if (err) {
>                 error_propagate(errp, err);
>                 return;
>             }
>         }
>>   
>>       if (lvms->acpi_ged) {
>>           hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
>> -        if (err) {
>> -            error_propagate(errp, err);
>> -        }
>> +        error_propagate(errp, err);
>> +        return;
>>       }
>>   
>>       return;
> 
> Better make this work exactly like the other checks above, and drop the
> final return, which serves no purpose:
> 
>             if (err) {
>                 error_propagate(errp, err);
>                 return;
>             }
>         }
Here is report from commandline, it say err NULL check is not necessary
spatch --sp-file scripts/coccinelle/error_propagate_null.cocci --dir 
hw/loongarch/

@@ -1001,9 +997,7 @@ static void virt_cpu_plug(HotplugHandler

      if (lvms->acpi_ged) {
          hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
-        if (err) {
-            error_propagate(errp, err);
-        }
+        error_propagate(errp, err);
      }

Regards
Bibo Mao
>     }
> 


