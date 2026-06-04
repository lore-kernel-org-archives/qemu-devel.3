Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A22BCD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 02:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUy2J-00057P-EX; Wed, 03 Jun 2026 22:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wUy2F-000575-9k
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 22:42:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wUy2C-0002dR-8D
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 22:42:18 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxX+r95SBqDmQQAA--.44742S3;
 Thu, 04 Jun 2026 10:42:05 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxGOD55SBqRUybAA--.32397S3;
 Thu, 04 Jun 2026 10:42:03 +0800 (CST)
Subject: Re: [PATCH v2 13/13] target/loongarch: Add new structure CPUSysState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <20260602030029.1476299-1-maobibo@loongson.cn>
 <20260602030029.1476299-14-maobibo@loongson.cn>
 <52cc9b38-e1e8-46ef-aaaf-41b33200188f@mailo.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <3232b704-4215-0385-e1f9-d4ed0cdbc7af@loongson.cn>
Date: Thu, 4 Jun 2026 10:38:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <52cc9b38-e1e8-46ef-aaaf-41b33200188f@mailo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxGOD55SBqRUybAA--.32397S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF47AFykGF4UGw15tr4rXrc_yoWruw1Upr
 n7AryUGrWUGrykAa18Jwn8Wry3Wr1UG3W2qw1fta48GFWUJr1jqF10q39IgF15A3y8Xr10
 qF1UZrnrZF47X3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
 Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
 14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.97,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2026/6/3 下午2:43, Philippe Mathieu-Daudé wrote:
> On 2/6/26 05:00, Bibo Mao wrote:
>> New structure CPUSysState is added here, it contains CSR registers
>> now, in future TLB and timer can be moved to this structure also.
>>
>> It is only code movement, no function change.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   target/loongarch/cpu.c                        |   4 +-
>>   target/loongarch/cpu.h                        |  35 +++---
>>   target/loongarch/csr.c                        |   4 +-
>>   target/loongarch/csr.h                        |   2 +-
>>   target/loongarch/machine.c                    | 118 +++++++++---------
>>   .../tcg/insn_trans/trans_extra.c.inc          |   4 +-
>>   6 files changed, 86 insertions(+), 81 deletions(-)
> 
> 
>> diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
>> index ed7c603a0b..ef71cdf30f 100644
>> --- a/target/loongarch/csr.h
>> +++ b/target/loongarch/csr.h
>> @@ -29,6 +29,6 @@ CSRInfo *get_csr(unsigned int csr_num);
>>   bool set_csr_flag(unsigned int csr_num, int flag);
>>   static inline int get_csr_offset(const CSRInfo *csr, int vm_level)
>>   {
>> -    return csr->offset;
>> +    return csr->offset + offsetof(CPULoongArchState, 
>> sys_states[vm_level]);
>>   }
>>   #endif /* TARGET_LOONGARCH_CSR_H */
>> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
>> index 4db53fec26..931a5ca5ba 100644
>> --- a/target/loongarch/machine.c
>> +++ b/target/loongarch/machine.c
>> @@ -58,9 +58,9 @@ static const VMStateDescription vmstate_msgint = {
>>       .minimum_version_id = 1,
>>       .needed = msgint_needed,
>>       .fields = (const VMStateField[]) {
>> -        VMSTATE_UINT64_ARRAY(env.CSR_MSGIS, LoongArchCPU, N_MSGIS),
>> -        VMSTATE_UINT64(env.CSR_MSGIR, LoongArchCPU),
>> -        VMSTATE_UINT64(env.CSR_MSGIE, LoongArchCPU),
>> +        VMSTATE_UINT64_ARRAY(env.sys_states[0].CSR_MSGIS, 
>> LoongArchCPU, N_MSGIS),
>> +        VMSTATE_UINT64(env.sys_states[0].CSR_MSGIR, LoongArchCPU),
>> +        VMSTATE_UINT64(env.sys_states[0].CSR_MSGIE, LoongArchCPU),
> 
> No impact right now, but all the migration stream will be broken when
> you add more sys_states.
when LVZ TCG feature is supported, there is no code change here.
There will be new subsection such as vmstate_lvz for LVZ feature.

If new subsection is added, will the migration stream be broken? I do 
not see this point.
> 
> Will sys_states number be static or dynamic?
The number of sys_states is static, currently it is 1, will be 2 with 
LVZ supported. Index 0 for host mode and Index 1 for guest mode.
> 
>>           VMSTATE_END_OF_LIST()
>>       },
>>   };
> 
> 
>> diff --git a/target/loongarch/tcg/insn_trans/trans_extra.c.inc 
>> b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
>> index 298a80cff5..838ac7e6b4 100644
>> --- a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
>> +++ b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
>> @@ -46,13 +46,15 @@ static bool gen_rdtime(DisasContext *ctx, arg_rr *a,
>>   {
>>       TCGv dst1 = gpr_dst(ctx, a->rd, EXT_NONE);
>>       TCGv dst2 = gpr_dst(ctx, a->rj, EXT_NONE);
>> +    tcg_target_long offset;
>>       translator_io_start(&ctx->base);
>>       gen_helper_rdtime_d(dst1, tcg_env);
>>       if (word) {
>>           tcg_gen_sextract_tl(dst1, dst1, high ? 32 : 0, 32);
>>       }
>> -    tcg_gen_ld_i64(dst2, tcg_env, offsetof(CPULoongArchState, CSR_TID));
>> +    offset = offsetof(CPUSysState, CSR_TID) + 
>> offsetof(CPULoongArchState, sys_states[0]);
> 
> This seems fragile. Could you move as a preliminary patch change?
> Also write it reversed:
> 
>    offsetof(CPULoongArchState, sys_states[0]) + offsetof(CPUSysState, 
> CSR_TID)
instruction rdtime() can be used by user mode, function get_csr() cannot 
be called for user mode emulation only. Here macro offset is used 
directly :(

yeap, will split the patch into smaller ones, and use the reversed version.

Regards
Bibo Mao
> 
>> +    tcg_gen_ld_i64(dst2, tcg_env, offset);
>>       return true;
>>   }
> 
> 


