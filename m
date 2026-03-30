Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91108FF4959
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 08:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w77YD-0007un-EP; Mon, 30 Mar 2026 04:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1w77Y9-0007uJ-Kl
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 04:00:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1w77Y4-0004FT-8h
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 04:00:41 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxccCQLcppWuEfAA--.31529S3;
 Mon, 30 Mar 2026 16:00:16 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxpsCPLcppY5dgAA--.18819S3;
 Mon, 30 Mar 2026 16:00:15 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Add support for dbar hint variants
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, jiaxun.yang@flygoat.com, richard.henderson@linaro.org, 
 lixianglai@loongson.cn
References: <20260327003206.3749780-1-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <c28274cf-5957-67d9-80d8-3cf94427e961@loongson.cn>
Date: Mon, 30 Mar 2026 15:57:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260327003206.3749780-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpsCPLcppY5dgAA--.18819S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuw4rtry3ZF4fKF18Aw1fGrX_yoW3JrWUpF
 4xCF17KFW7tF9rZan7Xa1Y9rn8ur4fKFW2qa4xtryfursxGr18ZF1kK3yYgF48Cw4DZF10
 vFs5Aw13WFZIvFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70Pf
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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



On 2026/3/27 上午8:32, Song Gao wrote:
> LoongArch architecture (since LA664) introduces fine-grained dbar
> hints that allow controlling which memory accesses are ordered by
> the barrier. Previously, all dbar instructions were treated as a
> full barrier (TCG_MO_ALL | TCG_BAR_SC).
> 
> This patch adds support for decoding dbar hints and emitting the
> appropriate TCG memory barrier flags. For CPUs that do not advertise
> the DBAR_HINTS feature (cpucfg3.DBAR_HINTS = 0), all dbar hints
> fall back to a full barrier, preserving compatibility.
> 
> The hint encoding follows the LoongArch v1.10 specification:
> - Bit4: 0 = completion barrier, 1 = ordering barrier
>          (ignored by TCG as TCG only supports ordering barriers)
> - Bit3: barrier for previous reads (0 = enforce, 1 = relax)
> - Bit2: barrier for previous writes (0 = enforce, 1 = relax)
> - Bit1: barrier for succeeding reads (0 = enforce, 1 = relax)
> - Bit0: barrier for succeeding writes (0 = enforce, 1 = relax)
> 
> The mapping to TCG memory order flags is as follows:
> - TCG_MO_LD_LD is set if both previous and succeeding reads are ordered.
> - TCG_MO_ST_LD is set if previous write and succeeding read are ordered.
> - TCG_MO_LD_ST is set if previous read and succeeding write are ordered.
> - TCG_MO_ST_ST is set if both previous and succeeding writes are ordered.
> 
> If the resulting flags describe an acquire or release barrier,
> TCG_BAR_LDAQ or TCG_BAR_STRL is used accordingly; otherwise a
> full SC barrier (TCG_BAR_SC) is emitted.
> 
> Special hint handling:
> - hint 0x700: LL/SC loop barrier, treated as a full barrier as recommended.
> - hint 0xf and 0x1f: reserved/no-op, treated as no operation
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c                        |  4 +
>   .../tcg/insn_trans/trans_memory.c.inc         | 82 ++++++++++++++++++-
>   target/loongarch/tcg/translate.c              |  1 +
>   target/loongarch/translate.h                  |  3 +
>   4 files changed, 88 insertions(+), 2 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index e22568c84a..d8d106b07e 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -455,6 +455,10 @@ static void loongarch_max_initfn(Object *obj)
>           data = FIELD_DP32(data, CPUCFG2, LLACQ_SCREL, 1);
>           data = FIELD_DP32(data, CPUCFG2, SCQ, 1);
>           cpu->env.cpucfg[2] = data;
> +
> +        data = cpu->env.cpucfg[3];
> +        data = FIELD_DP32(data, CPUCFG3, DBAR_HINTS, 1);
> +        cpu->env.cpucfg[3] = data;
>       }
>   }
>   
> diff --git a/target/loongarch/tcg/insn_trans/trans_memory.c.inc b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
> index e287d46363..99bc486119 100644
> --- a/target/loongarch/tcg/insn_trans/trans_memory.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
> @@ -137,11 +137,89 @@ static bool trans_preldx(DisasContext *ctx, arg_preldx * a)
>       return true;
>   }
>   
> +/*
> + * Decode dbar hint and emit appropriate TCG memory barrier.
> + *
> + * The hint is a 5-bit field (0-31) encoded in the instruction.
> + * For hint 0x700 (special LL/SC loop barrier), treat as full barrier.
> + *
> + * See LoongArch Reference Manual v1.10, Section 4.2.2 for details.
> + */
>   static bool trans_dbar(DisasContext *ctx, arg_dbar * a)
>   {
>       tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
I am not familiar with memory order. I only point out the possible 
problem purely from code.

Should tcg_gen_mb() be moved afterward, otherwise there may be two times 
calling with tcg_gen_mb().
> -    return true;
> -}
> +    int hint = a->imm;
> +    TCGBar bar_flags = 0;
> +
> +    /* Reserved/no-op hints: 0xf and 0x1f */
> +    if (hint == 0xf || hint == 0x1f) {
> +        return true;
> +    }
Ditto, should it move afterward?

Regards
Bibo Mao
> +
> +    /* If the CPU does not support fine-grained hints,or for the special LL/SC
> +     * loop barrier (0x700), emit a full barrier.
> +     */
> +    if (!avail_DBAR_HINT(ctx) || hint == 0x700) {
> +        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> +        return true;
> +    }
> +
> +    /*
> +     * Fine-grained hint decoding:
> +     * Bits 3-0 control which accesses must be ordered.
> +     *   bit3: barrier previous reads?   (0 = enforce, 1 = relax)
> +     *   bit2: barrier previous writes?  (0 = enforce, 1 = relax)
> +     *   bit1: barrier succeeding reads? (0 = enforce, 1 = relax)
> +     *   bit0: barrier succeeding writes?(0 = enforce, 1 = relax)
> +     *
> +     * For each combination, we set the corresponding TCG_MO_* flag if both
> +     * sides of the barrier require ordering.
> +     */
> +    bool prev_rd = !(hint & 0x08);   /* need barrier for previous reads */
> +    bool prev_wr = !(hint & 0x04);   /* need barrier for previous writes */
> +    bool succ_rd = !(hint & 0x02);   /* need barrier for succeeding reads */
> +    bool succ_wr = !(hint & 0x01);   /* need barrier for succeeding writes */
> +
> +    if (prev_rd && succ_rd) {
> +        bar_flags |= TCG_MO_LD_LD;
> +    }
> +    if (prev_wr && succ_rd) {
> +        bar_flags |= TCG_MO_ST_LD;
> +    }
> +    if (prev_rd && succ_wr) {
> +        bar_flags |= TCG_MO_LD_ST;
> +    }
> +    if (prev_wr && succ_wr) {
> +        bar_flags |= TCG_MO_ST_ST;
> +    }
> +
> +    /* If no flags were set, this is a no-op barrier */
> +    if (bar_flags == 0) {
> +        return true;
> +    }
> +
> +    /*
> +     * Use acquire/release semantics when possible to generate more efficient
> +     * code. Otherwise, fall back to a sequential consistency barrier.
> +     *
> +     * Acquire: order loads before loads/stores (LD_LD | LD_ST)
> +     * Release: order stores before stores/loads (ST_ST | ST_LD)
> +     */
> +    if ((bar_flags & (TCG_MO_LD_LD | TCG_MO_LD_ST)) &&
> +        !(bar_flags & (TCG_MO_ST_ST | TCG_MO_ST_LD))) {
> +        /* Only acquire flags present */
> +        tcg_gen_mb(bar_flags | TCG_BAR_LDAQ);
> +    } else if ((bar_flags & (TCG_MO_ST_ST | TCG_MO_ST_LD)) &&
> +               !(bar_flags & (TCG_MO_LD_LD | TCG_MO_LD_ST))) {
> +        /* Only release flags present */
> +        tcg_gen_mb(bar_flags | TCG_BAR_STRL);
> +    } else {
> +        /* Mixed or full barrier */
> +        tcg_gen_mb(bar_flags | TCG_BAR_SC);
> +    }
> +
> +     return true;
> + }
>   
>   static bool trans_ibar(DisasContext *ctx, arg_ibar *a)
>   {
> diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
> index b9ed13d19c..49280b1dd3 100644
> --- a/target/loongarch/tcg/translate.c
> +++ b/target/loongarch/tcg/translate.c
> @@ -149,6 +149,7 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
>   
>       ctx->cpucfg1 = env->cpucfg[1];
>       ctx->cpucfg2 = env->cpucfg[2];
> +    ctx->cpucfg3 = env->cpucfg[3];
>   }
>   
>   static void loongarch_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
> diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
> index ba1c89e57b..8aa8325dc6 100644
> --- a/target/loongarch/translate.h
> +++ b/target/loongarch/translate.h
> @@ -43,6 +43,8 @@
>   #define avail_LLACQ_SCREL(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LLACQ_SCREL))
>   #define avail_LLACQ_SCREL_64(C) (avail_64(C) && avail_LLACQ_SCREL(C))
>   
> +#define avail_DBAR_HINT(C) (FIELD_EX32((C)->cpucfg3, CPUCFG3, DBAR_HINTS))
> +
>   /*
>    * If an operation is being performed on less than TARGET_LONG_BITS,
>    * it may require the inputs to be sign- or zero-extended; which will
> @@ -66,6 +68,7 @@ typedef struct DisasContext {
>       bool va32; /* 32-bit virtual address */
>       uint32_t cpucfg1;
>       uint32_t cpucfg2;
> +    uint32_t cpucfg3;
>   } DisasContext;
>   
>   void generate_exception(DisasContext *ctx, int excp);
> 


