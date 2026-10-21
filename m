Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD682606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 01:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJLLd-0007ft-FX; Tue, 20 Oct 2026 21:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xJLLZ-0007fV-Sd
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 21:42:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xJLLX-0003cT-Cr
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 21:42:29 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Ax29F5GNhqsOAXAA--.4443S3;
 Wed, 21 Oct 2026 09:42:18 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJCxPs93GNhquacuAA--.31902S2;
 Wed, 21 Oct 2026 09:42:17 +0800 (CST)
Subject: Re: [PULL 5/5] hw/intc/loongarch_extioi: Add extioi interrupt status
 display
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
References: <20260908073548.3249551-1-maobibo@loongson.cn>
 <20260908073548.3249551-6-maobibo@loongson.cn>
 <CAFEAcA9QmRG_ffAqrcXV0pxc8vFKhBqK=ORfLK1FC3w+-SOjgg@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <5869df31-9e27-411f-4d90-01121288103e@loongson.cn>
Date: Wed, 21 Oct 2026 09:43:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9QmRG_ffAqrcXV0pxc8vFKhBqK=ORfLK1FC3w+-SOjgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxPs93GNhquacuAA--.31902S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFy8Kw4xWryrKr4rur13Jrc_yoWrJF43pa
 43AF13Gr48Xr17J3say3WkXF98Aw4rCF17Jan3tw10kFn5Xr15uryrJ3429F17Gw1fJF1j
 v3WFvF1Y9a4DA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.387,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/10/20 下午10:38, Peter Maydell wrote:
> On Tue, 8 Sept 2026 at 08:35, Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> When irqchip in kernel is enabled, the register status of extioi irqchip
>> is in KVM kernel. Here add interrupt status display in user side in order
>> to debug extioi irqchip driver.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> Reviewed-by: Xianglai Li <lixianglai@loongson.cn>
>> ---
>>   hw/intc/loongarch_extioi.c | 58 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
> 
> Hi; this code introduces undefined behaviour, which you can see
> if you build QEMU with the clang sanitizer (i.e. configure with
> "--enable-ubsan --cc=clang --cxx=clang++") and run 'make check'.
> The test-hmp test falls over with this backtrace:
> 
>      ../../hw/intc/loongarch_extioi.c:439:33: runtime error: load of
> misaligned address 0x5b0a281448b4 for type 'uint64_t' (aka 'unsigned
> long'), which requires 8 byte alignment
>      0x5b0a281448b4: note: pointer points here
>        00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00
> 00 00 00  00 00 00 00 00 00 00 00
>                    ^
>          #0 0x5b0a0000d823 in loongarch_extioi_print_info
> /home/pm215/qemu/build/loongarch-san-dbg/../../hw/intc/loongarch_extioi.c:439:33
>          #1 0x5b09ff200b34 in qmp_x_query_intc_foreach
> /home/pm215/qemu/build/loongarch-san-dbg/../../hw/core/machine-qmp-cmds.c:437:13
>          #2 0x5b0a00042339 in do_object_child_foreach
> /home/pm215/qemu/build/loongarch-san-dbg/../../qom/object.c:1254:19
>          #3 0x5b0a0004239d in do_object_child_foreach
> /home/pm215/qemu/build/loongarch-san-dbg/../../qom/object.c:1259:23
>          #4 0x5b0a0004239d in do_object_child_foreach
> /home/pm215/qemu/build/loongarch-san-dbg/../../qom/object.c:1259:23
>          #5 0x5b0a00042429 in object_child_foreach_recursive
> /home/pm215/qemu/build/loongarch-san-dbg/../../qom/object.c:1279:12
>          #6 0x5b09ff200978 in qmp_x_query_interrupt_controllers
> /home/pm215/qemu/build/loongarch-san-dbg/../../hw/core/machine-qmp-cmds.c:451:5
> 
> 
>> +static void loongarch_extioi_print_info(InterruptStatsProvider *obj,
>> +                                        GString *buf)
>> +{
>> +    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(obj);
>> +    uint64_t *val;
>> +    unsigned long irq;
>> +    ExtIOICore *core;
>> +    int i;
>> +
>> +    vmstate_extioi_pre_save(s);
>> +    g_string_append_printf(buf, "%s:\n", object_get_typename(OBJECT(obj)));
>> +
>> +    val = (uint64_t *)s->isr;
> 
> This is because s->isr is an array of uint32_t values, not uint64_t.
> You can't take a pointer to one and cast it to the other like this:
>   (1) it may not be aligned enough
>   (2) on a big endian system, it will not give you the same value
> 
>> +    g_string_append_printf(buf, "  ISR     0x%016"PRIx64" 0x%016"PRIx64
>> +                                " 0x%016"PRIx64" 0x%016"PRIx64"\n",
>> +                                *val, *(val + 1), *(val + 2), *(val + 3));
> 
> I don't know this device and so I don't know what the natural way
> to show these register values to the user is. So I'm not sure whether
> it would be better to simply print the values as uint32_t, since that's
> what we have, or to manually assemble the two uint32_t halves into a uint64_t.
> Printing uint32_t seems like it would be simpler and would match the
> representation the device is actually using.
> 
> Similar problems apply to all the other places where we cast a uint32_t*
> to uint64_t* in this function.
> 
> Could you write a patch to fix this, please?
yes, I can reproduce this issue with provided configure info.
Will provide a fix patch soon, and thanks for your hint information and 
good suggestion.

Regards
Bibo Mao
> 
> thanks
> -- PMM
> 


