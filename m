Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C56C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 09:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt1mK-0002vl-8M; Fri, 14 Mar 2025 05:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tt1mG-0002vP-L9
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 05:56:28 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tt1mD-0008VF-Fu
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 05:56:28 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxDGtE_dNnSFGWAA--.58863S3;
 Fri, 14 Mar 2025 17:56:20 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxzMRB_dNn159KAA--.13004S3;
 Fri, 14 Mar 2025 17:56:20 +0800 (CST)
Subject: Re: [PATCH v2 2/3] hw/loongarch/virt: Remove unnecessary NULL pointer
 checking
To: Markus Armbruster <armbru@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250314084201.4182054-1-maobibo@loongson.cn>
 <20250314084201.4182054-3-maobibo@loongson.cn> <87plikrn81.fsf@pond.sub.org>
 <63fc3b2b-140c-a4e4-c3ec-536cc31d9f11@loongson.cn>
 <87ldt8q7dp.fsf@pond.sub.org>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <4298d4fb-5b50-9742-242a-503d24829541@loongson.cn>
Date: Fri, 14 Mar 2025 17:55:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87ldt8q7dp.fsf@pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzMRB_dNn159KAA--.13004S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF13Zr4fuF1DCF4DJr47Awc_yoW8KFy3pr
 1xta1qvFykJr1jvw1IyryrtF1Fyrs7tr4kXr4Dt3W5Xrn0qrnYyFW3Kw129rW8CrWj9ayU
 Xa13GFsxu3Z5tFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
 xVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
 AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
 IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
 xhVjvjDU0xZFpf9x07jOF4_UUUUU=
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



On 2025/3/14 下午5:38, Markus Armbruster wrote:
> bibo mao <maobibo@loongson.cn> writes:
> 
> On 2025/3/14 下午5:11, Markus Armbruster wrote:
>>> Bibo Mao <maobibo@loongson.cn> writes:
>>>
>>>> There is NULL pointer checking function error_propagate() already,
>>>> it is not necessary to add checking for function parameter. Here remove
>>>> NULL pointer checking with function parameter.
>>>>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> 
> [...]
> 
>>>> @@ -1001,9 +999,8 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>>>          cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
>>>          cpu_slot->cpu = CPU(dev);
>>>          if (lvms->ipi) {
>>>              hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev, &err);
>>>              if (err) {
>>>                  error_propagate(errp, err);
>>>                  return;
>>>              }
>>>          }
>>>
>>>          if (lvms->extioi) {
>>>              hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), dev, &err);
>>>              if (err) {
>>>                  error_propagate(errp, err);
>>>                  return;
>>>              }
>>>          }
>>>>    
>>>>        if (lvms->acpi_ged) {
>>>>            hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
>>>> -        if (err) {
>>>> -            error_propagate(errp, err);
>>>> -        }
>>>> +        error_propagate(errp, err);
>>>> +        return;
>>>>        }
>>>>    
>>>>        return;
>>>
>>> Better make this work exactly like the other checks above, and drop the
>>> final return, which serves no purpose:
>>>
>>>              if (err) {
>>>                  error_propagate(errp, err);
>>>                  return;
>>>              }
>>>          }
>> Here is report from commandline, it say err NULL check is not necessary
>> spatch --sp-file scripts/coccinelle/error_propagate_null.cocci --dir
>> hw/loongarch/
>>
>> @@ -1001,9 +997,7 @@ static void virt_cpu_plug(HotplugHandler
>>
>>        if (lvms->acpi_ged) {
>>            hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &err);
>> -        if (err) {
>> -            error_propagate(errp, err);
>> -        }
>> +        error_propagate(errp, err);
>>        }
> 
> This change is correct.  The change I suggests is also correct.  I
> prefer mine because it's less easy to screw up.  If you add another
> check at the end, my version keeps working, while yours needs an update,
> which is easy to miss.
> 
I see until checking file scripts/coccinelle/error_propagate_null.cocci
-if (L) {
      error_propagate(E, L);
-}

you are error log expert, of source do with your suggestion -:)
And thanks for your earnest explanation.

Regards
Bibo Mao


