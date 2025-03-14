Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66526C282DE
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 02:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsumE-000788-7p; Thu, 13 Mar 2025 22:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tsumB-00077m-Tu
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 22:27:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tsum9-0006w4-7o
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 22:27:55 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bx32silNNnxs6VAA--.58624S3;
 Fri, 14 Mar 2025 10:27:46 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCxPscelNNnEfpJAA--.13626S3;
 Fri, 14 Mar 2025 10:27:45 +0800 (CST)
Subject: Re: [PATCH 2/3] hw/loongarch/virt: Remove unnecessary NULL pointer
 checking
To: Markus Armbruster <armbru@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250313091350.3770394-1-maobibo@loongson.cn>
 <20250313091350.3770394-3-maobibo@loongson.cn> <875xkdb4q5.fsf@pond.sub.org>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <10c55e3e-22f5-285d-7e38-3a6a08089302@loongson.cn>
Date: Fri, 14 Mar 2025 10:27:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <875xkdb4q5.fsf@pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPscelNNnEfpJAA--.13626S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr18Kr1DJFWrury3CF18tFc_yoW7Zr4Dpr
 4Dt3Wqvr1kAF1qv3yIvrySgFy0vr1xtay7urZ5tw13ZF1DXrn0yF1akw1Y9FW3Cayvva1r
 Xa13CFs8ZF1SqFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
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



On 2025/3/13 下午6:32, Markus Armbruster wrote:
> Bibo Mao <maobibo@loongson.cn> writes:
> 
>> There is NULL pointer checking function error_propagate() already,
>> it is not necessary to add checking for function parameter. Here remove
>> NULL pointer checking with function parameter.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/loongarch/virt.c | 12 +++---------
>>   1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index a5840ff968..ab951fc642 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -913,9 +913,7 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>>       cs->cpu_index = cpu_slot - ms->possible_cpus->cpus;
>>       numa_cpu_pre_plug(cpu_slot, dev, &err);
>>   out:
>> -    if (err) {
>> -        error_propagate(errp, err);
>> -    }
>> +    error_propagate(errp, err);
>>   }
>>   
>>   static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
>> @@ -935,9 +933,7 @@ static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
>>       }
>>   
>>       hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
>> -    if (err) {
>> -        error_propagate(errp, err);
>> -    }
>> +    error_propagate(errp, err);
>>   }
> 
> This looks correct.  But I believe we can eliminate error propagation
> here.  Untested patch appended.
> 
>>   
>>   static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
>> @@ -1001,9 +997,7 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>>   
>>       if (lvms->acpi_ged) {
>>           hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
>> -        if (err) {
>> -            error_propagate(errp, err);
>> -        }
>> +        error_propagate(errp, err);
>>       }
>>   
>>       return;
> 
> Here, I'd recommend
> 
>         if (lvms->acpi_ged) {
>             hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
>             if (err) {
>                 error_propagate(errp, err);
>    +            return;
>             }
> 
> because it makes future screwups harder.
> 
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index a5840ff968..4674bd9163 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -859,30 +859,29 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>       LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>       CPUState *cs = CPU(dev);
>       CPUArchId *cpu_slot;
> -    Error *err = NULL;
>       LoongArchCPUTopo topo;
>       int arch_id;
>   
>       if (lvms->acpi_ged) {
>           if ((cpu->thread_id < 0) || (cpu->thread_id >= ms->smp.threads)) {
> -            error_setg(&err,
> +            error_setg(errp,
>                          "Invalid thread-id %u specified, must be in range 1:%u",
>                          cpu->thread_id, ms->smp.threads - 1);
> -            goto out;
> +            return;
Hi Markus,

 From APIs, it seems that function error_propagate() do much more than 
error appending, such as comparing dest_err with error_abort etc. Though 
caller function is local variable rather than error_abort/fatal/warn, 
error_propagate() seems useful. How about do propagate error and return 
directly as following:

@@ -868,7 +868,8 @@ static void virt_cpu_pre_plug(HotplugHandler 
*hotplug_dev,
              error_setg(&err,
                         "Invalid thread-id %u specified, must be in 
range 1:%u",
                         cpu->thread_id, ms->smp.threads - 1);
-            goto out;
+            error_propagate(errp, err);
+            return;
          }

Regards
Bibo Mao
>           }
>   
>           if ((cpu->core_id < 0) || (cpu->core_id >= ms->smp.cores)) {
> -            error_setg(&err,
> +            error_setg(errp,
>                          "Invalid core-id %u specified, must be in range 1:%u",
>                          cpu->core_id, ms->smp.cores - 1);
> -            goto out;
> +            return;
>           }
>   
>           if ((cpu->socket_id < 0) || (cpu->socket_id >= ms->smp.sockets)) {
> -            error_setg(&err,
> +            error_setg(errp,
>                          "Invalid socket-id %u specified, must be in range 1:%u",
>                          cpu->socket_id, ms->smp.sockets - 1);
> -            goto out;
> +            return;
>           }
>   
>           topo.socket_id = cpu->socket_id;
> @@ -891,11 +890,11 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>           arch_id =  virt_get_arch_id_from_topo(ms, &topo);
>           cpu_slot = virt_find_cpu_slot(ms, arch_id);
>           if (CPU(cpu_slot->cpu)) {
> -            error_setg(&err,
> +            error_setg(errp,
>                          "cpu(id%d=%d:%d:%d) with arch-id %" PRIu64 " exists",
>                          cs->cpu_index, cpu->socket_id, cpu->core_id,
>                          cpu->thread_id, cpu_slot->arch_id);
> -            goto out;
> +            return;
>           }
>       } else {
>           /* For cold-add cpu, find empty cpu slot */
> @@ -911,33 +910,24 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
>       cpu->env.address_space_iocsr = &lvms->as_iocsr;
>       cpu->phy_id = cpu_slot->arch_id;
>       cs->cpu_index = cpu_slot - ms->possible_cpus->cpus;
> -    numa_cpu_pre_plug(cpu_slot, dev, &err);
> -out:
> -    if (err) {
> -        error_propagate(errp, err);
> -    }
> +    numa_cpu_pre_plug(cpu_slot, dev, errp);
>   }
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
>   static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
> 


