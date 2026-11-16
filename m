Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65DF606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 02:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSmPR-0007Xp-WB; Sun, 15 Nov 2026 21:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xSmP3-0007On-1u
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 21:25:07 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xSmP0-0004CH-9J
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 21:25:04 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxLNJyafpqC_sfAA--.26759S3;
 Mon, 16 Nov 2026 10:24:50 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJDxBc1vafpqwcw0AA--.13048S2;
 Mon, 16 Nov 2026 10:24:49 +0800 (CST)
Subject: Re: [PULL 05/10] target/loongarch: Remove TLB entry in vmstate
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
References: <20261023014931.4055823-1-maobibo@loongson.cn>
 <20261023014931.4055823-6-maobibo@loongson.cn>
 <CAFEAcA-bMyReAMg7LgLujtPQZ361fb3oNN3AAmiMeGQ9_Og1Bw@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <1c7a3abc-d570-1b8b-c65c-9db866e2e75f@loongson.cn>
Date: Mon, 16 Nov 2026 10:26:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-bMyReAMg7LgLujtPQZ361fb3oNN3AAmiMeGQ9_Og1Bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxBc1vafpqwcw0AA--.13048S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCry5uF43KFykAF4rJr43Jwc_yoW5Ar4Upa
 s3uF17KFWkJr97Wws7J345WFZ8urnrG3y7tF4UGwn5Gas7Crn5Krs2y3yI9FZIya45Kr1I
 vF1jy34UXF4DArgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.724,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-22.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/11/15 下午10:10, Peter Maydell wrote:
> On Fri, 23 Oct 2026 at 02:49, Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> The content of TLB entry may change if LVZ is added, TLB table can
>> re-establish from empty state after VM migration. There will be
>> compatible issue if TLB entry is removed in vmstate, however it is
>> only affect TCG mode.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>
>> ---
>>   target/loongarch/machine.c | 35 -----------------------------------
>>   1 file changed, 35 deletions(-)
> 
> Hi; as pointed out in https://gitlab.com/qemu-project/qemu/-/work_items/4879
> this change breaks migration of a loongarch "virt-11.1" machine from
> QEMU 11.1 to current head-of-git. Since loongarch supports versioned
> machine types that means you must preserve migration compatibility
> across QEMU versions.
> 
> In this case if the destination QEMU can reconstruct its TLB
> state without the incoming information, that means you need
> to accept and ignore these vmstate sections in the incoming
> migration data.
Hi Peter,

Thanks for pointing out the migration issue. Will revert this patch, and 
add another patch to accept and ignore these vmstate_tlb sections.

Regards
Bibo Mao
> 
>> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
>> index 931a5ca5ba..952c5497af 100644
>> --- a/target/loongarch/machine.c
>> +++ b/target/loongarch/machine.c
>> @@ -175,38 +175,6 @@ static const VMStateDescription vmstate_pmu = {
>>       },
>>   };
>>
>> -#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>> -static bool tlb_needed(void *opaque)
>> -{
>> -    return tcg_enabled();
>> -}
>> -
>> -/* TLB state */
>> -static const VMStateDescription vmstate_tlb_entry = {
>> -    .name = "cpu/tlb_entry",
>> -    .version_id = 0,
>> -    .minimum_version_id = 0,
>> -    .fields = (const VMStateField[]) {
>> -        VMSTATE_UINT64(tlb_misc, LoongArchTLB),
>> -        VMSTATE_UINT64(tlb_entry0, LoongArchTLB),
>> -        VMSTATE_UINT64(tlb_entry1, LoongArchTLB),
>> -        VMSTATE_END_OF_LIST()
>> -    }
>> -};
>> -
>> -static const VMStateDescription vmstate_tlb = {
>> -    .name = "cpu/tlb",
>> -    .version_id = 0,
>> -    .minimum_version_id = 0,
>> -    .needed = tlb_needed,
>> -    .fields = (const VMStateField[]) {
>> -        VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
>> -                             0, vmstate_tlb_entry, LoongArchTLB),
>> -        VMSTATE_END_OF_LIST()
>> -    }
>> -};
>> -#endif
>> -
>>   /* LoongArch CPU state */
>>   const VMStateDescription vmstate_loongarch_cpu = {
>>       .name = "cpu",
>> @@ -283,9 +251,6 @@ const VMStateDescription vmstate_loongarch_cpu = {
>>           &vmstate_fpu,
>>           &vmstate_lsx,
>>           &vmstate_lasx,
>> -#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>> -        &vmstate_tlb,
>> -#endif
>>           &vmstate_lbt,
>>           &vmstate_msgint,
>>           &vmstate_pmu,
> 
> thanks
> -- PMM
> 


