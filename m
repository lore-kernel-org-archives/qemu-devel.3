Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67731F3D60F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 08:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w77zX-0003oz-TX; Mon, 30 Mar 2026 04:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1w77zN-0003oX-Nd
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 04:28:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1w77zK-0000cd-AG
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 04:28:49 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Bx08A1NMpptuMfAA--.31741S3;
 Mon, 30 Mar 2026 16:28:37 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJCxfcIpNMpp5ZtgAA--.51661S3;
 Mon, 30 Mar 2026 16:28:28 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Add support for dbar hint variants
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, jiaxun.yang@flygoat.com, richard.henderson@linaro.org, 
 lixianglai@loongson.cn
References: <20260327003206.3749780-1-gaosong@loongson.cn>
 <c28274cf-5957-67d9-80d8-3cf94427e961@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <0f7941d8-3244-9965-8534-68bcc8b5ec90@loongson.cn>
Date: Mon, 30 Mar 2026 16:29:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c28274cf-5957-67d9-80d8-3cf94427e961@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxfcIpNMpp5ZtgAA--.51661S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3JryDWFy7ZF15KF1DWr4kuFX_yoWfWw1rpr
 1kAFWUKFWUJrn3Zw18J34UZFyUZr48G3W7Xw10qFy8ur47Gr1jgr10grZ0gF1UGw4kXF1U
 AF4UZwnrZFnxXFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU8j-e5UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.988,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

在 2026/3/30 下午3:57, Bibo Mao 写道:
>
>
> On 2026/3/27 上午8:32, Song Gao wrote:
>> LoongArch architecture (since LA664) introduces fine-grained dbar
>> hints that allow controlling which memory accesses are ordered by
>> the barrier. Previously, all dbar instructions were treated as a
>> full barrier (TCG_MO_ALL | TCG_BAR_SC).
>>
>> This patch adds support for decoding dbar hints and emitting the
>> appropriate TCG memory barrier flags. For CPUs that do not advertise
>> the DBAR_HINTS feature (cpucfg3.DBAR_HINTS = 0), all dbar hints
>> fall back to a full barrier, preserving compatibility.
>>
>> The hint encoding follows the LoongArch v1.10 specification:
>> - Bit4: 0 = completion barrier, 1 = ordering barrier
>>          (ignored by TCG as TCG only supports ordering barriers)
>> - Bit3: barrier for previous reads (0 = enforce, 1 = relax)
>> - Bit2: barrier for previous writes (0 = enforce, 1 = relax)
>> - Bit1: barrier for succeeding reads (0 = enforce, 1 = relax)
>> - Bit0: barrier for succeeding writes (0 = enforce, 1 = relax)
>>
>> The mapping to TCG memory order flags is as follows:
>> - TCG_MO_LD_LD is set if both previous and succeeding reads are ordered.
>> - TCG_MO_ST_LD is set if previous write and succeeding read are ordered.
>> - TCG_MO_LD_ST is set if previous read and succeeding write are ordered.
>> - TCG_MO_ST_ST is set if both previous and succeeding writes are 
>> ordered.
>>
>> If the resulting flags describe an acquire or release barrier,
>> TCG_BAR_LDAQ or TCG_BAR_STRL is used accordingly; otherwise a
>> full SC barrier (TCG_BAR_SC) is emitted.
>>
>> Special hint handling:
>> - hint 0x700: LL/SC loop barrier, treated as a full barrier as 
>> recommended.
>> - hint 0xf and 0x1f: reserved/no-op, treated as no operation
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/cpu.c                        |  4 +
>>   .../tcg/insn_trans/trans_memory.c.inc         | 82 ++++++++++++++++++-
>>   target/loongarch/tcg/translate.c              |  1 +
>>   target/loongarch/translate.h                  |  3 +
>>   4 files changed, 88 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index e22568c84a..d8d106b07e 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -455,6 +455,10 @@ static void loongarch_max_initfn(Object *obj)
>>           data = FIELD_DP32(data, CPUCFG2, LLACQ_SCREL, 1);
>>           data = FIELD_DP32(data, CPUCFG2, SCQ, 1);
>>           cpu->env.cpucfg[2] = data;
>> +
>> +        data = cpu->env.cpucfg[3];
>> +        data = FIELD_DP32(data, CPUCFG3, DBAR_HINTS, 1);
>> +        cpu->env.cpucfg[3] = data;
>>       }
>>   }
>>   diff --git a/target/loongarch/tcg/insn_trans/trans_memory.c.inc 
>> b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
>> index e287d46363..99bc486119 100644
>> --- a/target/loongarch/tcg/insn_trans/trans_memory.c.inc
>> +++ b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
>> @@ -137,11 +137,89 @@ static bool trans_preldx(DisasContext *ctx, 
>> arg_preldx * a)
>>       return true;
>>   }
>>   +/*
>> + * Decode dbar hint and emit appropriate TCG memory barrier.
>> + *
>> + * The hint is a 5-bit field (0-31) encoded in the instruction.
>> + * For hint 0x700 (special LL/SC loop barrier), treat as full barrier.
>> + *
>> + * See LoongArch Reference Manual v1.10, Section 4.2.2 for details.
>> + */
>>   static bool trans_dbar(DisasContext *ctx, arg_dbar * a)
>>   {
>>       tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
> I am not familiar with memory order. I only point out the possible 
> problem purely from code.
>
> Should tcg_gen_mb() be moved afterward, otherwise there may be two 
> times calling with tcg_gen_mb().
yes , you are right.   this tcg_gen_mb() should remove.

>
>> -    return true;
>> -}
>> +    int hint = a->imm;
>> +    TCGBar bar_flags = 0;
>> +
>> +    /* Reserved/no-op hints: 0xf and 0x1f */
>> +    if (hint == 0xf || hint == 0x1f) {
>> +        return true;
>> +    }
> Ditto, should it move afterward?
here ,  no-op hint we juet return true,

Thanks.
Song Gao
>
> Regards
> Bibo Mao
>> +
>> +    /* If the CPU does not support fine-grained hints,or for the 
>> special LL/SC
>> +     * loop barrier (0x700), emit a full barrier.
>> +     */
>> +    if (!avail_DBAR_HINT(ctx) || hint == 0x700) {
>> +        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
>> +        return true;
>> +    }
>> +
>> +    /*
>> +     * Fine-grained hint decoding:
>> +     * Bits 3-0 control which accesses must be ordered.
>> +     *   bit3: barrier previous reads?   (0 = enforce, 1 = relax)
>> +     *   bit2: barrier previous writes?  (0 = enforce, 1 = relax)
>> +     *   bit1: barrier succeeding reads? (0 = enforce, 1 = relax)
>> +     *   bit0: barrier succeeding writes?(0 = enforce, 1 = relax)
>> +     *
>> +     * For each combination, we set the corresponding TCG_MO_* flag 
>> if both
>> +     * sides of the barrier require ordering.
>> +     */
>> +    bool prev_rd = !(hint & 0x08);   /* need barrier for previous 
>> reads */
>> +    bool prev_wr = !(hint & 0x04);   /* need barrier for previous 
>> writes */
>> +    bool succ_rd = !(hint & 0x02);   /* need barrier for succeeding 
>> reads */
>> +    bool succ_wr = !(hint & 0x01);   /* need barrier for succeeding 
>> writes */
>> +
>> +    if (prev_rd && succ_rd) {
>> +        bar_flags |= TCG_MO_LD_LD;
>> +    }
>> +    if (prev_wr && succ_rd) {
>> +        bar_flags |= TCG_MO_ST_LD;
>> +    }
>> +    if (prev_rd && succ_wr) {
>> +        bar_flags |= TCG_MO_LD_ST;
>> +    }
>> +    if (prev_wr && succ_wr) {
>> +        bar_flags |= TCG_MO_ST_ST;
>> +    }
>> +
>> +    /* If no flags were set, this is a no-op barrier */
>> +    if (bar_flags == 0) {
>> +        return true;
>> +    }
>> +
>> +    /*
>> +     * Use acquire/release semantics when possible to generate more 
>> efficient
>> +     * code. Otherwise, fall back to a sequential consistency barrier.
>> +     *
>> +     * Acquire: order loads before loads/stores (LD_LD | LD_ST)
>> +     * Release: order stores before stores/loads (ST_ST | ST_LD)
>> +     */
>> +    if ((bar_flags & (TCG_MO_LD_LD | TCG_MO_LD_ST)) &&
>> +        !(bar_flags & (TCG_MO_ST_ST | TCG_MO_ST_LD))) {
>> +        /* Only acquire flags present */
>> +        tcg_gen_mb(bar_flags | TCG_BAR_LDAQ);
>> +    } else if ((bar_flags & (TCG_MO_ST_ST | TCG_MO_ST_LD)) &&
>> +               !(bar_flags & (TCG_MO_LD_LD | TCG_MO_LD_ST))) {
>> +        /* Only release flags present */
>> +        tcg_gen_mb(bar_flags | TCG_BAR_STRL);
>> +    } else {
>> +        /* Mixed or full barrier */
>> +        tcg_gen_mb(bar_flags | TCG_BAR_SC);
>> +    }
>> +
>> +     return true;
>> + }
>>     static bool trans_ibar(DisasContext *ctx, arg_ibar *a)
>>   {
>> diff --git a/target/loongarch/tcg/translate.c 
>> b/target/loongarch/tcg/translate.c
>> index b9ed13d19c..49280b1dd3 100644
>> --- a/target/loongarch/tcg/translate.c
>> +++ b/target/loongarch/tcg/translate.c
>> @@ -149,6 +149,7 @@ static void 
>> loongarch_tr_init_disas_context(DisasContextBase *dcbase,
>>         ctx->cpucfg1 = env->cpucfg[1];
>>       ctx->cpucfg2 = env->cpucfg[2];
>> +    ctx->cpucfg3 = env->cpucfg[3];
>>   }
>>     static void loongarch_tr_tb_start(DisasContextBase *dcbase, 
>> CPUState *cs)
>> diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
>> index ba1c89e57b..8aa8325dc6 100644
>> --- a/target/loongarch/translate.h
>> +++ b/target/loongarch/translate.h
>> @@ -43,6 +43,8 @@
>>   #define avail_LLACQ_SCREL(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, 
>> LLACQ_SCREL))
>>   #define avail_LLACQ_SCREL_64(C) (avail_64(C) && avail_LLACQ_SCREL(C))
>>   +#define avail_DBAR_HINT(C) (FIELD_EX32((C)->cpucfg3, CPUCFG3, 
>> DBAR_HINTS))
>> +
>>   /*
>>    * If an operation is being performed on less than TARGET_LONG_BITS,
>>    * it may require the inputs to be sign- or zero-extended; which will
>> @@ -66,6 +68,7 @@ typedef struct DisasContext {
>>       bool va32; /* 32-bit virtual address */
>>       uint32_t cpucfg1;
>>       uint32_t cpucfg2;
>> +    uint32_t cpucfg3;
>>   } DisasContext;
>>     void generate_exception(DisasContext *ctx, int excp);
>>


