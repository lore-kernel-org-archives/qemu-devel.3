Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3671DC83F07
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 07:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYg8J-0008Qu-Vd; Mon, 07 Jul 2025 03:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uYg8H-0008PE-85
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 03:19:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uYg8E-0006HK-7h
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 03:19:20 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxG6zpdGtoOVwjAQ--.35614S3;
 Mon, 07 Jul 2025 15:19:06 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxQ+TmdGtoaIEMAA--.7470S3;
 Mon, 07 Jul 2025 15:19:04 +0800 (CST)
Subject: Re: [PATCH V1 1/2] hw/rtc: Fixed loongson rtc emulation errors
To: lixianglai <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <cover.1749777563.git.lixianglai@loongson.cn>
 <b83fa4c3319e372b2a7b3b7b994821441ff9ca7c.1749777563.git.lixianglai@loongson.cn>
 <8576e7f9-c7ed-63c7-0213-7b74fe0b6f06@loongson.cn>
 <2c796290-4500-0fbf-9f8b-c35d9f64f440@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <b998491a-aa1e-9312-d889-bd424bebf95e@loongson.cn>
Date: Mon, 7 Jul 2025 15:17:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2c796290-4500-0fbf-9f8b-c35d9f64f440@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxQ+TmdGtoaIEMAA--.7470S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jw17JrWDZFW8ZF48WrW8Zrc_yoWxtF18pF
 4kJFyDJFy5Jrn7Jr17WryUAFy5Jr1UJw1DXr18GF48Jr47Jr1jgr1UXr9Fgr1UAr48Jr15
 Xr15JrnxZF17JrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
 wI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
 AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
 IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
 CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
 WIevJa73UjIFyTuYvjxUzpBTUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.626,
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



On 2025/7/7 下午2:36, lixianglai wrote:
> Hi Bibo Mao:
>>
>>
>> On 2025/6/13 上午9:31, Xianglai Li wrote:
>>> The expire time is sent to the timer only
>>> when the expire Time is greater than 0 or
>>> greater than now. Otherwise, the timer
>>> will trigger interruption continuously.
>>>
>>> Timer interrupts are sent using pulse functions.
>>>
>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>>> ---
>>> Cc: Bibo Mao <maobibo@loongson.cn>
>>> Cc: Song Gao <gaosong@loongson.cn>
>>> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> Cc: Xianglai Li <lixianglai@loongson.cn>
>>>
>>>   hw/loongarch/virt-fdt-build.c | 11 +++++++++--
>>>   hw/rtc/ls7a_rtc.c             | 26 +++++++++++++++++---------
>>>   2 files changed, 26 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/hw/loongarch/virt-fdt-build.c 
>>> b/hw/loongarch/virt-fdt-build.c
>>> index 728ce46699..c613131a07 100644
>>> --- a/hw/loongarch/virt-fdt-build.c
>>> +++ b/hw/loongarch/virt-fdt-build.c
>>> @@ -17,6 +17,11 @@
>>>   #include "system/reset.h"
>>>   #include "target/loongarch/cpu.h"
>>>   +#define FDT_IRQ_FLAGS_EDGE_LO_HI 1
>>> +#define FDT_IRQ_FLAGS_EDGE_HI_LO 2
>>> +#define FDT_IRQ_FLAGS_LEVEL_HI 4
>>> +#define FDT_IRQ_FLAGS_LEVEL_LO 8
>>> +
>>>   static void create_fdt(LoongArchVirtMachineState *lvms)
>>>   {
>>>       MachineState *ms = MACHINE(lvms);
>>> @@ -416,7 +421,8 @@ static void 
>>> fdt_add_uart_node(LoongArchVirtMachineState *lvms,
>>>       if (chosen) {
>>>           qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", 
>>> nodename);
>>>       }
>>> -    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0x4);
>>> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq,
>>> +                           FDT_IRQ_FLAGS_LEVEL_HI);
>>>       qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
>>>                             *pch_pic_phandle);
>>>       g_free(nodename);
>>> @@ -436,7 +442,8 @@ static void 
>>> fdt_add_rtc_node(LoongArchVirtMachineState *lvms,
>>>                               "loongson,ls7a-rtc");
>>>       qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 
>>> 2, size);
>>>       qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
>>> -                           VIRT_RTC_IRQ - VIRT_GSI_BASE , 0x4);
>>> +                           VIRT_RTC_IRQ - VIRT_GSI_BASE ,
>>> +                           FDT_IRQ_FLAGS_EDGE_LO_HI);
>>>       qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
>>>                             *pch_pic_phandle);
>>>       g_free(nodename);
>>> diff --git a/hw/rtc/ls7a_rtc.c b/hw/rtc/ls7a_rtc.c
>>> index 10097b2db7..7eca75a42a 100644
>>> --- a/hw/rtc/ls7a_rtc.c
>>> +++ b/hw/rtc/ls7a_rtc.c
>>> @@ -145,20 +145,24 @@ static void toymatch_write(LS7ARtcState *s, 
>>> uint64_t val, int num)
>>>           now = qemu_clock_get_ms(rtc_clock);
>>>           toymatch_val_to_time(s, val, &tm);
>>>           expire_time = now + (qemu_timedate_diff(&tm) - 
>>> s->offset_toy) * 1000;
>>> -        timer_mod(s->toy_timer[num], expire_time);
>>> +        if (expire_time > now) {
>>> +            timer_mod(s->toy_timer[num], expire_time);
>>> +        }
>> Should rtc alarm interrupt be injected directly if (expire_time <= now)?
>>
> Through experiments on the hardware platform, sending an alarm less than
> the current time to loongson rtc alarm does not trigger an interrupt.
> 
> According to the behavior of the hardware, we do not need to trigger an
> interrupt immediately when expire_time <= now
Sounds good. yes, the behavior of qemu emulation should be the same with 
real HW.

Regards
Bibo Mao
> 
> Thanks,
> Xianglai Li.
> 
>> Regards
>> Bibo Mao
>>>       }
>>>   }
>>>     static void rtcmatch_write(LS7ARtcState *s, uint64_t val, int num)
>>>   {
>>> -    uint64_t expire_ns;
>>> +    int64_t expire_ns;
>>>         /* it do not support write when toy disabled */
>>>       if (rtc_enabled(s)) {
>>>           s->rtcmatch[num] = val;
>>>           /* calculate expire time */
>>>           expire_ns = ticks_to_ns(val) - ticks_to_ns(s->offset_rtc);
>>> -        timer_mod_ns(s->rtc_timer[num], expire_ns);
>>> +        if (expire_ns > 0) {
>>> +            timer_mod_ns(s->rtc_timer[num], expire_ns);
>>> +        }
>>>       }
>>>   }
>>>   @@ -185,7 +189,7 @@ static void ls7a_rtc_stop(LS7ARtcState *s)
>>>   static void ls7a_toy_start(LS7ARtcState *s)
>>>   {
>>>       int i;
>>> -    uint64_t expire_time, now;
>>> +    int64_t expire_time, now;
>>>       struct tm tm = {};
>>>         now = qemu_clock_get_ms(rtc_clock);
>>> @@ -194,19 +198,23 @@ static void ls7a_toy_start(LS7ARtcState *s)
>>>       for (i = 0; i < TIMER_NUMS; i++) {
>>>           toymatch_val_to_time(s, s->toymatch[i], &tm);
>>>           expire_time = now + (qemu_timedate_diff(&tm) - 
>>> s->offset_toy) * 1000;
>>> -        timer_mod(s->toy_timer[i], expire_time);
>>> +        if (expire_time > now) {
>>> +            timer_mod(s->toy_timer[i], expire_time);
>>> +        }
>>>       }
>>>   }
>>>     static void ls7a_rtc_start(LS7ARtcState *s)
>>>   {
>>>       int i;
>>> -    uint64_t expire_time;
>>> +    int64_t expire_time;
>>>         /* recalculate expire time and enable timer */
>>>       for (i = 0; i < TIMER_NUMS; i++) {
>>>           expire_time = ticks_to_ns(s->rtcmatch[i]) - 
>>> ticks_to_ns(s->offset_rtc);
>>> -        timer_mod_ns(s->rtc_timer[i], expire_time);
>>> +        if (expire_time > 0) {
>>> +            timer_mod_ns(s->rtc_timer[i], expire_time);
>>> +        }
>>>       }
>>>   }
>>>   @@ -370,7 +378,7 @@ static void toy_timer_cb(void *opaque)
>>>       LS7ARtcState *s = opaque;
>>>         if (toy_enabled(s)) {
>>> -        qemu_irq_raise(s->irq);
>>> +        qemu_irq_pulse(s->irq);
>>>       }
>>>   }
>>>   @@ -379,7 +387,7 @@ static void rtc_timer_cb(void *opaque)
>>>       LS7ARtcState *s = opaque;
>>>         if (rtc_enabled(s)) {
>>> -        qemu_irq_raise(s->irq);
>>> +        qemu_irq_pulse(s->irq);
>>>       }
>>>   }
>>>


