Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9EA606A33F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 06:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOr9Z-0003BS-Jt; Thu, 05 Nov 2026 01:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1xOr9X-0003BJ-Lp
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:40:51 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1xOr9V-0007o7-EI
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:40:51 -0500
Received: from loongson.cn (unknown [10.20.42.166])
 by gateway (Coremail) with SMTP id _____8Cx+9HtJOxql44cAA--.17236S3;
 Thu, 05 Nov 2026 14:40:45 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJDxTs_tJOxqi4EyAA--.38274S2;
 Thu, 05 Nov 2026 14:40:45 +0800 (CST)
Subject: Re: [PATCH 1/2] target/loongarch: Add asrtle_du()/asrtgt_du() helpers
To: Bibo Mao <maobibo@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@mailo.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20261029130109.185509-1-maobibo@loongson.cn>
 <20261029130109.185509-2-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <98c0aa06-0e78-4aaa-de74-70037ce0b0df@loongson.cn>
Date: Thu, 5 Nov 2026 14:39:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029130109.185509-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDxTs_tJOxqi4EyAA--.38274S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFy7uF1Duw17AF4DAFy8Xrc_yoW7tw4fpF
 s7Ar48Kay8JFZ7A397GayYgF1UZrZ5Ca12g3Z2y3ySkF4fXrykZr17K34akF4Uu3s5Xr4j
 vFsYvw1jvay5X3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwmhF
 DUUUU
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
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
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>
> According to the LoongArch manual, ldle/ldgt/stle/stgt and
> fldle/fldgt/fstle/fstgt perform unsigned address comparison, whereas
> asrtle/asrtgt perform signed address comparison.
>
> Add the asrtle_du() and asrtgt_du() helpers, and use them for the
> instructions that perform unsigned address comparison.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/helper.h                 |  2 ++
>   .../tcg/insn_trans/trans_fmemory.c.inc        |  8 ++++----
>   .../tcg/insn_trans/trans_memory.c.inc         |  8 ++++----
>   target/loongarch/tcg/op_helper.c              | 20 +++++++++++++++++++
>   4 files changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
> index e76c73c775..7ee655b027 100644
> --- a/target/loongarch/tcg/helper.h
> +++ b/target/loongarch/tcg/helper.h
> @@ -7,6 +7,8 @@ DEF_HELPER_2(raise_exception, noreturn, env, i32)
>   
>   DEF_HELPER_FLAGS_3(asrtle_d, TCG_CALL_NO_WG, void, env, tl, tl)
>   DEF_HELPER_FLAGS_3(asrtgt_d, TCG_CALL_NO_WG, void, env, tl, tl)
> +DEF_HELPER_FLAGS_3(asrtle_du, TCG_CALL_NO_WG, void, env, tl, tl)
> +DEF_HELPER_FLAGS_3(asrtgt_du, TCG_CALL_NO_WG, void, env, tl, tl)
>   
>   DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
>   DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
> diff --git a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
> index b863ba1dc2..b050436a77 100644
> --- a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
> @@ -81,7 +81,7 @@ static bool gen_fload_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
>   
>       CHECK_FPE;
>   
> -    gen_helper_asrtgt_d(tcg_env, src1, src2);
> +    gen_helper_asrtgt_du(tcg_env, src1, src2);
>       addr = make_address_x(ctx, src1, src2);
>       tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
>       maybe_nanbox_load(dest, mop);
> @@ -99,7 +99,7 @@ static bool gen_fstore_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
>   
>       CHECK_FPE;
>   
> -    gen_helper_asrtgt_d(tcg_env, src1, src2);
> +    gen_helper_asrtgt_du(tcg_env, src1, src2);
>       addr = make_address_x(ctx, src1, src2);
>       tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
>   
> @@ -115,7 +115,7 @@ static bool gen_fload_le(DisasContext *ctx, arg_frr *a, MemOp mop)
>   
>       CHECK_FPE;
>   
> -    gen_helper_asrtle_d(tcg_env, src1, src2);
> +    gen_helper_asrtle_du(tcg_env, src1, src2);
>       addr = make_address_x(ctx, src1, src2);
>       tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
>       maybe_nanbox_load(dest, mop);
> @@ -133,7 +133,7 @@ static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
>   
>       CHECK_FPE;
>   
> -    gen_helper_asrtle_d(tcg_env, src1, src2);
> +    gen_helper_asrtle_du(tcg_env, src1, src2);
>       addr = make_address_x(ctx, src1, src2);
>       tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
>   
> diff --git a/target/loongarch/tcg/insn_trans/trans_memory.c.inc b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
> index dcecf02e54..ae2a0dbf30 100644
> --- a/target/loongarch/tcg/insn_trans/trans_memory.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
> @@ -79,7 +79,7 @@ static bool gen_load_gt(DisasContext *ctx, arg_rrr *a, MemOp mop)
>       TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
>       TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
>   
> -    gen_helper_asrtgt_d(tcg_env, src1, src2);
> +    gen_helper_asrtgt_du(tcg_env, src1, src2);
>       src1 = make_address_i(ctx, src1, 0);
>       tcg_gen_qemu_ld_tl(dest, src1, ctx->mem_idx, mop);
>       gen_set_gpr(a->rd, dest, EXT_NONE);
> @@ -93,7 +93,7 @@ static bool gen_load_le(DisasContext *ctx, arg_rrr *a, MemOp mop)
>       TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
>       TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
>   
> -    gen_helper_asrtle_d(tcg_env, src1, src2);
> +    gen_helper_asrtle_du(tcg_env, src1, src2);
>       src1 = make_address_i(ctx, src1, 0);
>       tcg_gen_qemu_ld_tl(dest, src1, ctx->mem_idx, mop);
>       gen_set_gpr(a->rd, dest, EXT_NONE);
> @@ -107,7 +107,7 @@ static bool gen_store_gt(DisasContext *ctx, arg_rrr *a, MemOp mop)
>       TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
>       TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
>   
> -    gen_helper_asrtgt_d(tcg_env, src1, src2);
> +    gen_helper_asrtgt_du(tcg_env, src1, src2);
>       src1 = make_address_i(ctx, src1, 0);
>       tcg_gen_qemu_st_tl(data, src1, ctx->mem_idx, mop);
>   
> @@ -120,7 +120,7 @@ static bool gen_store_le(DisasContext *ctx, arg_rrr *a, MemOp mop)
>       TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
>       TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
>   
> -    gen_helper_asrtle_d(tcg_env, src1, src2);
> +    gen_helper_asrtle_du(tcg_env, src1, src2);
>       src1 = make_address_i(ctx, src1, 0);
>       tcg_gen_qemu_st_tl(data, src1, ctx->mem_idx, mop);
>   
> diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
> index 44772d03a4..25ed328753 100644
> --- a/target/loongarch/tcg/op_helper.c
> +++ b/target/loongarch/tcg/op_helper.c
> @@ -43,6 +43,26 @@ void HELPER(asrtgt_d)(CPULoongArchState *env, target_ulong rj, target_ulong rk)
>       }
>   }
>   
> +void HELPER(asrtle_du)(CPULoongArchState *env, target_ulong rj, target_ulong rk)
> +{
> +    CPUSysState *sys = env_sys(env);
> +
> +    if (rj > rk) {
> +        sys->CSR_BADV = rj;
> +        do_raise_exception(env, EXCCODE_BCE, GETPC());
> +    }
> +}
> +
> +void HELPER(asrtgt_du)(CPULoongArchState *env, target_ulong rj, target_ulong rk)
> +{
> +    CPUSysState *sys = env_sys(env);
> +
> +    if (rj <= rk) {
> +        sys->CSR_BADV = rj;
> +        do_raise_exception(env, EXCCODE_BCE, GETPC());
> +    }
> +}
> +
>   target_ulong HELPER(crc32)(target_ulong val, target_ulong m, uint64_t sz)
>   {
>       uint8_t buf[8];


