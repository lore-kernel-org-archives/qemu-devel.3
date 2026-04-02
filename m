Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57F71112274
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 02:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w87g4-0000oU-Lw; Wed, 01 Apr 2026 22:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1w87g1-0000lV-22
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 22:20:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1w87fx-0007NB-LT
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 22:20:56 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxNMFx0s1phg4hAA--.46021S3;
 Thu, 02 Apr 2026 10:20:33 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxpsBt0s1ppB9jAA--.23757S3;
 Thu, 02 Apr 2026 10:20:30 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Add support for dbar hint variants
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, jiaxun.yang@flygoat.com, richard.henderson@linaro.org, 
 lixianglai@loongson.cn
References: <20260327003206.3749780-1-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <70916e5a-ec69-fb8f-259e-2ef07e97bc5a@loongson.cn>
Date: Thu, 2 Apr 2026 10:17:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260327003206.3749780-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpsBt0s1ppB9jAA--.23757S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuw4rtry3ZF4fKF18Aw1fGrX_yoW3GF1fpF
 4xCF17KFW7tF9rZan7Xa1j9rn8uF4fKFy2qa47tryfursxGr1kZF1kK3yYgF48Cw4qvF10
 vFs5Aw17WFZIvFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1YL9U
 UUUU=
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
> -    return true;
> -}
> +    int hint = a->imm;
> +    TCGBar bar_flags = 0;
> +
> +    /* Reserved/no-op hints: 0xf and 0x1f */
> +    if (hint == 0xf || hint == 0x1f) {
> +        return true;
> +    }
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
I do not know the memory order, however it seems that it is different 
with other architectures with following usage when it is translated to 
QEMU TCG code. I do now which is right.

__smp_rmb() ---> tcg_gen_mb(TCG_BAR_SC | TCG_MO_LD_LD | TCG_MO_LD_ST)
__smp_wmb() ---> tcg_gen_mb(TCG_BAR_SC | TCG_MO_ST_ST)
__smp_mb()  ---> tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL)

Regards
Bibo Mao
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


