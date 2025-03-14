Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D46C28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 07:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsz18-0006i6-65; Fri, 14 Mar 2025 02:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tsz15-0006gO-KZ
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:59:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tsz12-00025L-Eo
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:59:35 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxqmrM09NnHB6WAA--.59233S3;
 Fri, 14 Mar 2025 14:59:25 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBx3MTE09NnU2VKAA--.11189S3;
 Fri, 14 Mar 2025 14:59:19 +0800 (CST)
Subject: Re: [PATCH 2/3] hw/loongarch/virt: Remove unnecessary NULL pointer
 checking
From: bibo mao <maobibo@loongson.cn>
To: Markus Armbruster <armbru@redhat.com>
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250313091350.3770394-1-maobibo@loongson.cn>
 <20250313091350.3770394-3-maobibo@loongson.cn> <875xkdb4q5.fsf@pond.sub.org>
 <10c55e3e-22f5-285d-7e38-3a6a08089302@loongson.cn>
 <87v7scw4se.fsf@pond.sub.org>
 <fc8a893c-9ff5-ad44-812a-66dd0f163269@loongson.cn>
Message-ID: <7081e48e-89cb-fbad-fa24-56770dc0afec@loongson.cn>
Date: Fri, 14 Mar 2025 14:58:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fc8a893c-9ff5-ad44-812a-66dd0f163269@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx3MTE09NnU2VKAA--.11189S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw4kGF4fAr18uF4UCrykJFc_yoWrKry5pr
 s7J3WDtrZ5Ar1kJr4Utry8XFy8tryUJ3WDGrn5JFy7Gr4UJr1jqF4UXF1qgF4UCr48J3WU
 Zr45XF9rZFnxtFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
 KfnxnUUI43ZEXa7IU8r9N3UUUUU==
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



On 2025/3/14 下午2:28, bibo mao wrote:
> 
> 
> On 2025/3/14 下午1:38, Markus Armbruster wrote:
>> bibo mao <maobibo@loongson.cn> writes:
>>
>> On 2025/3/13 下午6:32, Markus Armbruster wrote:
>>
>> [...]
>>
>>>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>>>> index a5840ff968..4674bd9163 100644
>>>> --- a/hw/loongarch/virt.c
>>>> +++ b/hw/loongarch/virt.c
>>>> @@ -859,30 +859,29 @@ static void virt_cpu_pre_plug(HotplugHandler 
>>>> *hotplug_dev,
>>>>       LoongArchCPU *cpu = LOONGARCH_CPU(dev);
>>>>       CPUState *cs = CPU(dev);
>>>>       CPUArchId *cpu_slot;
>>>> -    Error *err = NULL;
>>>>       LoongArchCPUTopo topo;
>>>>       int arch_id;
>>>>       if (lvms->acpi_ged) {
>>>>           if ((cpu->thread_id < 0) || (cpu->thread_id >= 
>>>> ms->smp.threads)) {
>>>> -            error_setg(&err,
>>>> +            error_setg(errp,
>>>>                          "Invalid thread-id %u specified, must be in 
>>>> range 1:%u",
>>>>                          cpu->thread_id, ms->smp.threads - 1);
>>>> -            goto out;
>>>> +            return;
>>>
>>> Hi Markus,
>>>
>>>   From APIs, it seems that function error_propagate() do much more than
>>> error appending, such as comparing dest_err with error_abort etc. Though
>>> caller function is local variable rather than error_abort/fatal/warn,
>>> error_propagate() seems useful. How about do propagate error and return
>>> directly as following:
>>>
>>> @@ -868,7 +868,8 @@ static void virt_cpu_pre_plug(HotplugHandler
>>> *hotplug_dev,
>>>               error_setg(&err,
>>>                          "Invalid thread-id %u specified, must be in
>>> range 1:%u",
>>>                          cpu->thread_id, ms->smp.threads - 1);
>>> -            goto out;
>>> +            error_propagate(errp, err);
>>> +            return;
>>>           }
>>
>> This is strictly worse.  One, it's more verbose.  Two, the stack
>> backtrace on failure is less useful, which matters when @errp is
>> &error_abort, and when you set a breakpoint on error_handle(), abort(),
>> or exit().  Three, it doesn't actually add useful functionality.
>>
>> To help you see the latter, let's compare the two versions, i.e.
>>
>>     direct: error_setg(errp, ...)
>>
>> and
>>
>>     propagate: two steps, first error_setg(&err, ...), and then
>>     error_propagate(errp, err);
>>
>> Cases: @errp can be NULL, &error_abort, &error_fatal, &error_warn, or a
>> non-null pointer to variable containing NULL.
>>
>> 1. @errp is NULL
>>
>>     Direct does nothing.
>>
>>     Propagate step 1 creates an error object, and stores it in @err.
>>     Step 2 frees the error object.  Roundabout way to do nothing.
>>
>> 2. @errp is &error_abort
>>
>>     Direct creates an error object, reports it to stderr, and abort()s.
>>     Note that the stack backtrace shows where the error is created.
>>
>>     Propagate step 1 creates an error object, and stores it in @err.
>>     Step 2 reports it to stderr, and abort()s.  No difference, except the
>>     stack backtrace shows where the error is propagated, which is less
>>     useful.
>>
>> 3. @errp is &error_fatal
>>
>>     Direct creates an error object, reports it to stderr, frees it, and
>>     exit(1)s.
>>
>>     Propagate step 1 creates an error object, and stores it in @err.
>>     Step 2 reports it to stderr, frees it, and exit(1)s.  No difference.
>>
>> 4. @errp is &error_warn
>>
>>     Direct creates an error object, reports it to stderr, and frees it.
>>
>>     Propagate step 1 creates an error object, and stores it in @err.
>>     Step 2 reports it to stderr, and frees it.  No difference.
>>
>> 5. @errp points to variable containing NULL
>>
>>     Direct creates an error object, and stores it in the variable.
>>
>>     Propagate step 1 creates an error object, and stores it in @err.
>>     Step 2 copies it to the variable.  No difference.
>>
>> Questions?
> The question how to use error_propagate() comparing with error_setg() 
> since there is such API. :)
I know nothing about error module, almost 80% code is copied from others.

 From header file include/qapi/error.h, It seems that error_setg() is 
used in error report leaf function, error_propagate() is used by caller 
node function. Is that right?

Regards
Bibo Mao
> 
> Regards
> Bibo Mao
>>
>> [...]
>>
> 


