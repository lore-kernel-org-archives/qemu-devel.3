Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF25C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 03:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riR0G-0001rB-82; Thu, 07 Mar 2024 22:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1riR0E-0001ph-Et; Thu, 07 Mar 2024 22:34:34 -0500
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1riR07-0007bb-PR; Thu, 07 Mar 2024 22:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1709868855; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
 bh=L1wzoKIPOmPeyWnh0T12v4H/ozWOq4BrkXMk43vJpwA=;
 b=RHYhBRoZvE/BSRHar5du2FMdveajjdbPVjZTKcT5oxCab9HL6U8Kqwq6O2BG3m6Su5tErU8w7ZQBKf+n6URTzok6fdJik+cJzCGCbRAFqrzjl9pCByDQs5wbIeI3Z0robojo4T7DVqfn2Fg0nq3LYe6Cbg4Dld9twjD2BQqVF2E=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R501e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0W21B8At_1709868853; 
Received: from 30.198.1.199(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W21B8At_1709868853) by smtp.aliyun-inc.com;
 Fri, 08 Mar 2024 11:34:14 +0800
Content-Type: multipart/alternative;
 boundary="------------Qeo207xkaiVAdfUTqFL7ktyR"
Message-ID: <2b6f12f6-4a34-4ede-ad60-322d5ccf66ac@linux.alibaba.com>
Date: Fri, 8 Mar 2024 11:34:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/9] target/riscv: remove 'over' brconds from vector
 trans
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, palmer@rivosinc.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240306171932.549549-1-dbarboza@ventanamicro.com>
 <20240306171932.549549-4-dbarboza@ventanamicro.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240306171932.549549-4-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------Qeo207xkaiVAdfUTqFL7ktyR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel and Alistair,

Hope it is not too late. I think there are two bugs in this patch.

1) The first is for instruction vfmv.s.f.  vfmv.s.f doesn't use helper 
function. If we remove the over check, it will set the first element of 
destination vector register, which is against the specification. 
According to the riscv-v-specification, 16.2. Floating-Point Scalar Move 
Instructions,

"If vstart ≥ vl, no operation is performed and the destination register is not updated".

2) The second is for vector instruction with helper functions. we should 
not change any elements including the tail elements when vstart >=vl. 
But this patch break this behavior. According to the 
riscv-v-specification,  5.4. Prestart, Active, Inactive, Body, and Tail 
Element Denitions,

"When vstart ≥ vl, there are no body elements, and no elements are updated in any destination vector register group,
including that no tail elements are updated with agnostic values."

I will review this patch set in more details later.

Thanks,
Zhiwei

On 2024/3/7 1:19, Daniel Henrique Barboza wrote:
> Most of the vector translations has this following pattern at the start:
>
>      TCGLabel *over = gen_new_label();
>      tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>
> And then right at the end:
>
>       gen_set_label(over);
>       return true;
>
> This means that if vstart >= vl we'll not set vstart = 0 at the end of
> the insns - this is done inside the helper that is being skipped.  The
> reason why this pattern hasn't been a bigger problem is because the
> conditional vstart >= vl is very rare.
>
> Checking all the helpers in vector_helper.c we see all of them with a
> pattern like this:
>
>      for (i = env->vstart; i < vl; i++) {
>          (...)
>      }
>      env->vstart = 0;
>
> Thus they can handle vstart >= vl case gracefully, with the benefit of
> setting env->vstart = 0 during the process.
>
> Remove all 'over' conditionals and let the helper set env->vstart = 0
> every time.
>
> While we're at it, remove the (vl == 0) brconds from trans_rvbf16.c.inc
> too since they're unneeded.
>
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> Reviewed-by: Richard Henderson<richard.henderson@linaro.org>
> Reviewed-by: Alistair Francis<alistair.francis@wdc.com>
> ---
>   target/riscv/insn_trans/trans_rvbf16.c.inc |  12 ---
>   target/riscv/insn_trans/trans_rvv.c.inc    | 117 ---------------------
>   target/riscv/insn_trans/trans_rvvk.c.inc   |  18 ----
>   3 files changed, 147 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
> index 8ee99df3f3..a842e76a6b 100644
> --- a/target/riscv/insn_trans/trans_rvbf16.c.inc
> +++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
> @@ -71,11 +71,8 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
>   
>       if (opfv_narrow_check(ctx, a) && (ctx->sew == MO_16)) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
>   
>           gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
>           data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
> @@ -87,7 +84,6 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
>                              ctx->cfg_ptr->vlenb, data,
>                              gen_helper_vfncvtbf16_f_f_w);
>           mark_vs_dirty(ctx);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -100,11 +96,8 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
>   
>       if (opfv_widen_check(ctx, a) && (ctx->sew == MO_16)) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
>   
>           gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
>           data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
> @@ -116,7 +109,6 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
>                              ctx->cfg_ptr->vlenb, data,
>                              gen_helper_vfwcvtbf16_f_f_v);
>           mark_vs_dirty(ctx);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -130,11 +122,8 @@ static bool trans_vfwmaccbf16_vv(DisasContext *ctx, arg_vfwmaccbf16_vv *a)
>       if (require_rvv(ctx) && vext_check_isa_ill(ctx) && (ctx->sew == MO_16) &&
>           vext_check_dss(ctx, a->rd, a->rs1, a->rs2, a->vm)) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
>   
>           gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
>           data = FIELD_DP32(data, VDATA, LMUL, ctx->lmul);
> @@ -147,7 +136,6 @@ static bool trans_vfwmaccbf16_vv(DisasContext *ctx, arg_vfwmaccbf16_vv *a)
>                              ctx->cfg_ptr->vlenb, data,
>                              gen_helper_vfwmaccbf16_vv);
>           mark_vs_dirty(ctx);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index e42728990e..0114a132b3 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -616,9 +616,6 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>       TCGv base;
>       TCGv_i32 desc;
>   
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>       dest = tcg_temp_new_ptr();
>       mask = tcg_temp_new_ptr();
>       base = get_gpr(s, rs1, EXT_NONE);
> @@ -660,7 +657,6 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>           tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
>       }
>   
> -    gen_set_label(over);
>       return true;
>   }
>   
> @@ -802,9 +798,6 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
>       TCGv base, stride;
>       TCGv_i32 desc;
>   
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>       dest = tcg_temp_new_ptr();
>       mask = tcg_temp_new_ptr();
>       base = get_gpr(s, rs1, EXT_NONE);
> @@ -819,7 +812,6 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
>   
>       fn(dest, mask, base, stride, tcg_env, desc);
>   
> -    gen_set_label(over);
>       return true;
>   }
>   
> @@ -906,9 +898,6 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
>       TCGv base;
>       TCGv_i32 desc;
>   
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>       dest = tcg_temp_new_ptr();
>       mask = tcg_temp_new_ptr();
>       index = tcg_temp_new_ptr();
> @@ -924,7 +913,6 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
>   
>       fn(dest, mask, base, index, tcg_env, desc);
>   
> -    gen_set_label(over);
>       return true;
>   }
>   
> @@ -1044,9 +1032,6 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>       TCGv base;
>       TCGv_i32 desc;
>   
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>       dest = tcg_temp_new_ptr();
>       mask = tcg_temp_new_ptr();
>       base = get_gpr(s, rs1, EXT_NONE);
> @@ -1059,7 +1044,6 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>       fn(dest, mask, base, tcg_env, desc);
>   
>       mark_vs_dirty(s);
> -    gen_set_label(over);
>       return true;
>   }
>   
> @@ -1100,10 +1084,6 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
>                                uint32_t width, gen_helper_ldst_whole *fn,
>                                DisasContext *s)
>   {
> -    uint32_t evl = s->cfg_ptr->vlenb * nf / width;
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, evl, over);
> -
>       TCGv_ptr dest;
>       TCGv base;
>       TCGv_i32 desc;
> @@ -1120,8 +1100,6 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
>   
>       fn(dest, base, tcg_env, desc);
>   
> -    gen_set_label(over);
> -
>       return true;
>   }
>   
> @@ -1195,10 +1173,6 @@ static inline bool
>   do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
>                 gen_helper_gvec_4_ptr *fn)
>   {
> -    TCGLabel *over = gen_new_label();
> -
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>       if (a->vm && s->vl_eq_vlmax && !(s->vta && s->lmul < 0)) {
>           gvec_fn(s->sew, vreg_ofs(s, a->rd),
>                   vreg_ofs(s, a->rs2), vreg_ofs(s, a->rs1),
> @@ -1216,7 +1190,6 @@ do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
>                              s->cfg_ptr->vlenb, data, fn);
>       }
>       mark_vs_dirty(s);
> -    gen_set_label(over);
>       return true;
>   }
>   
> @@ -1248,9 +1221,6 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
>       TCGv_i32 desc;
>       uint32_t data = 0;
>   
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>       dest = tcg_temp_new_ptr();
>       mask = tcg_temp_new_ptr();
>       src2 = tcg_temp_new_ptr();
> @@ -1271,7 +1241,6 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
>       fn(dest, mask, src1, src2, tcg_env, desc);
>   
>       mark_vs_dirty(s);
> -    gen_set_label(over);
>       return true;
>   }
>   
> @@ -1410,9 +1379,6 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
>       TCGv_i32 desc;
>       uint32_t data = 0;
>   
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>       dest = tcg_temp_new_ptr();
>       mask = tcg_temp_new_ptr();
>       src2 = tcg_temp_new_ptr();
> @@ -1433,7 +1399,6 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
>       fn(dest, mask, src1, src2, tcg_env, desc);
>   
>       mark_vs_dirty(s);
> -    gen_set_label(over);
>       return true;
>   }
>   
> @@ -1495,8 +1460,6 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
>   {
>       if (checkfn(s, a)) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
> @@ -1509,7 +1472,6 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
>                              s->cfg_ptr->vlenb,
>                              data, fn);
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -1571,8 +1533,6 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
>   {
>       if (opiwv_widen_check(s, a)) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
> @@ -1584,7 +1544,6 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
>                              tcg_env, s->cfg_ptr->vlenb,
>                              s->cfg_ptr->vlenb, data, fn);
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -1643,8 +1602,6 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
>                           gen_helper_gvec_4_ptr *fn, DisasContext *s)
>   {
>       uint32_t data = 0;
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>       data = FIELD_DP32(data, VDATA, VM, vm);
>       data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
> @@ -1655,7 +1612,6 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
>                          vreg_ofs(s, vs2), tcg_env, s->cfg_ptr->vlenb,
>                          s->cfg_ptr->vlenb, data, fn);
>       mark_vs_dirty(s);
> -    gen_set_label(over);
>       return true;
>   }
>   
> @@ -1834,8 +1790,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
>               gen_helper_##NAME##_h,                                 \
>               gen_helper_##NAME##_w,                                 \
>           };                                                         \
> -        TCGLabel *over = gen_new_label();                          \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                      \
>           data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -1848,7 +1802,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
>                              s->cfg_ptr->vlenb, data,                \
>                              fns[s->sew]);                           \
>           mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>           return true;                                               \
>       }                                                              \
>       return false;                                                  \
> @@ -2045,14 +1998,11 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
>                   gen_helper_vmv_v_v_b, gen_helper_vmv_v_v_h,
>                   gen_helper_vmv_v_v_w, gen_helper_vmv_v_v_d,
>               };
> -            TCGLabel *over = gen_new_label();
> -            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>               tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs1),
>                                  tcg_env, s->cfg_ptr->vlenb,
>                                  s->cfg_ptr->vlenb, data,
>                                  fns[s->sew]);
> -            gen_set_label(over);
>           }
>           mark_vs_dirty(s);
>           return true;
> @@ -2068,8 +2018,6 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
>           /* vmv.v.x has rs2 = 0 and vm = 1 */
>           vext_check_ss(s, a->rd, 0, 1)) {
>           TCGv s1;
> -        TCGLabel *over = gen_new_label();
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>           s1 = get_gpr(s, a->rs1, EXT_SIGN);
>   
> @@ -2102,7 +2050,6 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
>           }
>   
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -2129,8 +2076,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
>                   gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
>                   gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
>               };
> -            TCGLabel *over = gen_new_label();
> -            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>               s1 = tcg_constant_i64(simm);
>               dest = tcg_temp_new_ptr();
> @@ -2140,7 +2085,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
>               fns[s->sew](dest, s1, tcg_env, desc);
>   
>               mark_vs_dirty(s);
> -            gen_set_label(over);
>           }
>           return true;
>       }
> @@ -2275,9 +2219,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
>               gen_helper_##NAME##_w,                                 \
>               gen_helper_##NAME##_d,                                 \
>           };                                                         \
> -        TCGLabel *over = gen_new_label();                          \
>           gen_set_rm(s, RISCV_FRM_DYN);                              \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                      \
>           data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -2292,7 +2234,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
>                              s->cfg_ptr->vlenb, data,                \
>                              fns[s->sew - 1]);                       \
>           mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>           return true;                                               \
>       }                                                              \
>       return false;                                                  \
> @@ -2310,9 +2251,6 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
>       TCGv_i32 desc;
>       TCGv_i64 t1;
>   
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> -
>       dest = tcg_temp_new_ptr();
>       mask = tcg_temp_new_ptr();
>       src2 = tcg_temp_new_ptr();
> @@ -2330,7 +2268,6 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
>       fn(dest, mask, t1, src2, tcg_env, desc);
>   
>       mark_vs_dirty(s);
> -    gen_set_label(over);
>       return true;
>   }
>   
> @@ -2393,9 +2330,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
>           static gen_helper_gvec_4_ptr * const fns[2] = {          \
>               gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
>           };                                                       \
> -        TCGLabel *over = gen_new_label();                        \
>           gen_set_rm(s, RISCV_FRM_DYN);                            \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);\
>                                                                    \
>           data = FIELD_DP32(data, VDATA, VM, a->vm);               \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);           \
> @@ -2408,7 +2343,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
>                              s->cfg_ptr->vlenb, data,              \
>                              fns[s->sew - 1]);                     \
>           mark_vs_dirty(s);                                        \
> -        gen_set_label(over);                                     \
>           return true;                                             \
>       }                                                            \
>       return false;                                                \
> @@ -2467,9 +2401,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
>           static gen_helper_gvec_4_ptr * const fns[2] = {            \
>               gen_helper_##NAME##_h, gen_helper_##NAME##_w,          \
>           };                                                         \
> -        TCGLabel *over = gen_new_label();                          \
>           gen_set_rm(s, RISCV_FRM_DYN);                              \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                      \
>           data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -2482,7 +2414,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
>                              s->cfg_ptr->vlenb, data,                \
>                              fns[s->sew - 1]);                       \
>           mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>           return true;                                               \
>       }                                                              \
>       return false;                                                  \
> @@ -2584,9 +2515,7 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
>   {
>       if (checkfn(s, a)) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
>           gen_set_rm_chkfrm(s, rm);
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
> @@ -2597,7 +2526,6 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
>                              s->cfg_ptr->vlenb,
>                              s->cfg_ptr->vlenb, data, fn);
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -2696,8 +2624,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
>                   gen_helper_vmv_v_x_w,
>                   gen_helper_vmv_v_x_d,
>               };
> -            TCGLabel *over = gen_new_label();
> -            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>               t1 = tcg_temp_new_i64();
>               /* NaN-box f[rs1] */
> @@ -2711,7 +2637,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
>               fns[s->sew - 1](dest, t1, tcg_env, desc);
>   
>               mark_vs_dirty(s);
> -            gen_set_label(over);
>           }
>           return true;
>       }
> @@ -2773,9 +2698,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>               gen_helper_##HELPER##_h,                               \
>               gen_helper_##HELPER##_w,                               \
>           };                                                         \
> -        TCGLabel *over = gen_new_label();                          \
>           gen_set_rm_chkfrm(s, FRM);                                 \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                      \
>           data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -2787,7 +2710,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>                              s->cfg_ptr->vlenb, data,                \
>                              fns[s->sew - 1]);                       \
>           mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>           return true;                                               \
>       }                                                              \
>       return false;                                                  \
> @@ -2824,9 +2746,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>               gen_helper_##NAME##_h,                                 \
>               gen_helper_##NAME##_w,                                 \
>           };                                                         \
> -        TCGLabel *over = gen_new_label();                          \
>           gen_set_rm(s, RISCV_FRM_DYN);                              \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                      \
>           data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -2838,7 +2758,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>                              s->cfg_ptr->vlenb, data,                \
>                              fns[s->sew]);                           \
>           mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>           return true;                                               \
>       }                                                              \
>       return false;                                                  \
> @@ -2891,9 +2810,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>               gen_helper_##HELPER##_h,                               \
>               gen_helper_##HELPER##_w,                               \
>           };                                                         \
> -        TCGLabel *over = gen_new_label();                          \
>           gen_set_rm_chkfrm(s, FRM);                                 \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                      \
>           data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -2905,7 +2822,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>                              s->cfg_ptr->vlenb, data,                \
>                              fns[s->sew - 1]);                       \
>           mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>           return true;                                               \
>       }                                                              \
>       return false;                                                  \
> @@ -2940,9 +2856,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>               gen_helper_##HELPER##_h,                               \
>               gen_helper_##HELPER##_w,                               \
>           };                                                         \
> -        TCGLabel *over = gen_new_label();                          \
>           gen_set_rm_chkfrm(s, FRM);                                 \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                      \
>           data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -2954,7 +2868,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>                              s->cfg_ptr->vlenb, data,                \
>                              fns[s->sew]);                           \
>           mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>           return true;                                               \
>       }                                                              \
>       return false;                                                  \
> @@ -3031,8 +2944,6 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
>           vext_check_isa_ill(s)) {                                   \
>           uint32_t data = 0;                                         \
>           gen_helper_gvec_4_ptr *fn = gen_helper_##NAME;             \
> -        TCGLabel *over = gen_new_label();                          \
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
>                                                                      \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
>           data =                                                     \
> @@ -3043,7 +2954,6 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
>                              s->cfg_ptr->vlenb,                      \
>                              s->cfg_ptr->vlenb, data, fn);           \
>           mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>           return true;                                               \
>       }                                                              \
>       return false;                                                  \
> @@ -3131,8 +3041,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>           s->vstart_eq_zero) {                                       \
>           uint32_t data = 0;                                         \
>           gen_helper_gvec_3_ptr *fn = gen_helper_##NAME;             \
> -        TCGLabel *over = gen_new_label();                          \
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
>                                                                      \
>           data = FIELD_DP32(data, VDATA, VM, a->vm);                 \
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
> @@ -3145,7 +3053,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
>                              s->cfg_ptr->vlenb,                      \
>                              data, fn);                              \
>           mark_vs_dirty(s);                                          \
> -        gen_set_label(over);                                       \
>           return true;                                               \
>       }                                                              \
>       return false;                                                  \
> @@ -3171,8 +3078,6 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
>           require_align(a->rd, s->lmul) &&
>           s->vstart_eq_zero) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
> @@ -3187,7 +3092,6 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
>                              s->cfg_ptr->vlenb,
>                              s->cfg_ptr->vlenb, data, fns[s->sew]);
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -3201,8 +3105,6 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
>           require_align(a->rd, s->lmul) &&
>           require_vm(a->vm, a->rd)) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
> @@ -3217,7 +3119,6 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
>                              s->cfg_ptr->vlenb,
>                              data, fns[s->sew]);
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -3386,9 +3287,6 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
>           /* This instruction ignores LMUL and vector register groups */
>           TCGv_i64 t1;
>           TCGv s1;
> -        TCGLabel *over = gen_new_label();
> -
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>           t1 = tcg_temp_new_i64();
>   
> @@ -3400,7 +3298,6 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
>           tcg_gen_ext_tl_i64(t1, s1);
>           vec_element_storei(s, a->rd, 0, t1);
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -3442,10 +3339,6 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
>   
>           /* The instructions ignore LMUL and vector register group. */
>           TCGv_i64 t1;
> -        TCGLabel *over = gen_new_label();
> -
> -        /* if vstart >= vl, skip vector register write back */
> -        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>           /* NaN-box f[rs1] */
>           t1 = tcg_temp_new_i64();
> @@ -3453,7 +3346,6 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
>   
>           vec_element_storei(s, a->rd, 0, t1);
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -3624,8 +3516,6 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
>               gen_helper_vcompress_vm_b, gen_helper_vcompress_vm_h,
>               gen_helper_vcompress_vm_w, gen_helper_vcompress_vm_d,
>           };
> -        TCGLabel *over = gen_new_label();
> -        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
>   
>           data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
>           data = FIELD_DP32(data, VDATA, VTA, s->vta);
> @@ -3635,7 +3525,6 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
>                              s->cfg_ptr->vlenb, data,
>                              fns[s->sew]);
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -3658,12 +3547,9 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
>                                vreg_ofs(s, a->rs2), maxsz, maxsz);        \
>               mark_vs_dirty(s);                                           \
>           } else {                                                        \
> -            TCGLabel *over = gen_new_label();                           \
> -            tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, maxsz, over);  \
>               tcg_gen_gvec_2_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2), \
>                                  tcg_env, maxsz, maxsz, 0, gen_helper_vmvr_v); \
>               mark_vs_dirty(s);                                           \
> -            gen_set_label(over);                                        \
>           }                                                               \
>           return true;                                                    \
>       }                                                                   \
> @@ -3692,8 +3578,6 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
>   {
>       uint32_t data = 0;
>       gen_helper_gvec_3_ptr *fn;
> -    TCGLabel *over = gen_new_label();
> -    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>   
>       static gen_helper_gvec_3_ptr * const fns[6][4] = {
>           {
> @@ -3738,7 +3622,6 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
>                          s->cfg_ptr->vlenb, data, fn);
>   
>       mark_vs_dirty(s);
> -    gen_set_label(over);
>       return true;
>   }
>   
> diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
> index a5cdd1b67f..6d640e4596 100644
> --- a/target/riscv/insn_trans/trans_rvvk.c.inc
> +++ b/target/riscv/insn_trans/trans_rvvk.c.inc
> @@ -164,8 +164,6 @@ GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_check)
>                   gen_helper_##NAME##_w,                                     \
>                   gen_helper_##NAME##_d,                                     \
>               };                                                             \
> -            TCGLabel *over = gen_new_label();                              \
> -            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);     \
>                                                                              \
>               data = FIELD_DP32(data, VDATA, VM, a->vm);                     \
>               data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                 \
> @@ -177,7 +175,6 @@ GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_check)
>                                  s->cfg_ptr->vlenb, s->cfg_ptr->vlenb,       \
>                                  data, fns[s->sew]);                         \
>               mark_vs_dirty(s);                                              \
> -            gen_set_label(over);                                           \
>               return true;                                                   \
>           }                                                                  \
>           return false;                                                      \
> @@ -249,14 +246,12 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, vwsll_vx_check)
>               TCGv_ptr rd_v, rs2_v;                                             \
>               TCGv_i32 desc, egs;                                               \
>               uint32_t data = 0;                                                \
> -            TCGLabel *over = gen_new_label();                                 \
>                                                                                 \
>               if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                      \
>                   /* save opcode for unwinding in case we throw an exception */ \
>                   decode_save_opc(s);                                           \
>                   egs = tcg_constant_i32(EGS);                                  \
>                   gen_helper_egs_check(egs, tcg_env);                           \
> -                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);    \
>               }                                                                 \
>                                                                                 \
>               data = FIELD_DP32(data, VDATA, VM, a->vm);                        \
> @@ -272,7 +267,6 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, vwsll_vx_check)
>               tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));            \
>               gen_helper_##NAME(rd_v, rs2_v, tcg_env, desc);                    \
>               mark_vs_dirty(s);                                                 \
> -            gen_set_label(over);                                              \
>               return true;                                                      \
>           }                                                                     \
>           return false;                                                         \
> @@ -325,14 +319,12 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKNED_EGS)
>               TCGv_ptr rd_v, rs2_v;                                             \
>               TCGv_i32 uimm_v, desc, egs;                                       \
>               uint32_t data = 0;                                                \
> -            TCGLabel *over = gen_new_label();                                 \
>                                                                                 \
>               if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                      \
>                   /* save opcode for unwinding in case we throw an exception */ \
>                   decode_save_opc(s);                                           \
>                   egs = tcg_constant_i32(EGS);                                  \
>                   gen_helper_egs_check(egs, tcg_env);                           \
> -                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);    \
>               }                                                                 \
>                                                                                 \
>               data = FIELD_DP32(data, VDATA, VM, a->vm);                        \
> @@ -350,7 +342,6 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKNED_EGS)
>               tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a->rs2));            \
>               gen_helper_##NAME(rd_v, rs2_v, uimm_v, tcg_env, desc);            \
>               mark_vs_dirty(s);                                                 \
> -            gen_set_label(over);                                              \
>               return true;                                                      \
>           }                                                                     \
>           return false;                                                         \
> @@ -394,7 +385,6 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
>       {                                                                         \
>           if (CHECK(s, a)) {                                                    \
>               uint32_t data = 0;                                                \
> -            TCGLabel *over = gen_new_label();                                 \
>               TCGv_i32 egs;                                                     \
>                                                                                 \
>               if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {                      \
> @@ -402,7 +392,6 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
>                   decode_save_opc(s);                                           \
>                   egs = tcg_constant_i32(EGS);                                  \
>                   gen_helper_egs_check(egs, tcg_env);                           \
> -                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);    \
>               }                                                                 \
>                                                                                 \
>               data = FIELD_DP32(data, VDATA, VM, a->vm);                        \
> @@ -417,7 +406,6 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
>                                  data, gen_helper_##NAME);                      \
>                                                                                 \
>               mark_vs_dirty(s);                                                 \
> -            gen_set_label(over);                                              \
>               return true;                                                      \
>           }                                                                     \
>           return false;                                                         \
> @@ -448,7 +436,6 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
>   {
>       if (vsha_check(s, a)) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
>           TCGv_i32 egs;
>   
>           if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {
> @@ -456,7 +443,6 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
>               decode_save_opc(s);
>               egs = tcg_constant_i32(ZVKNH_EGS);
>               gen_helper_egs_check(egs, tcg_env);
> -            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>           }
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
> @@ -472,7 +458,6 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
>                   gen_helper_vsha2cl32_vv : gen_helper_vsha2cl64_vv);
>   
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
> @@ -482,7 +467,6 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
>   {
>       if (vsha_check(s, a)) {
>           uint32_t data = 0;
> -        TCGLabel *over = gen_new_label();
>           TCGv_i32 egs;
>   
>           if (!s->vstart_eq_zero || !s->vl_eq_vlmax) {
> @@ -490,7 +474,6 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
>               decode_save_opc(s);
>               egs = tcg_constant_i32(ZVKNH_EGS);
>               gen_helper_egs_check(egs, tcg_env);
> -            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
>           }
>   
>           data = FIELD_DP32(data, VDATA, VM, a->vm);
> @@ -506,7 +489,6 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
>                   gen_helper_vsha2ch32_vv : gen_helper_vsha2ch64_vv);
>   
>           mark_vs_dirty(s);
> -        gen_set_label(over);
>           return true;
>       }
>       return false;
--------------Qeo207xkaiVAdfUTqFL7ktyR
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Daniel and Alistair,</p>
    <p>Hope it is not too late. I think there are two bugs in this
      patch.<br>
    </p>
    <p>1) The first is for instruction vfmv.s.f.  vfmv.s.f doesn't use
      helper function. If we remove the over check, it will set the
      first element of destination vector register, which is against the
      specification. According to the riscv-v-specification, 16.2.
      Floating-Point Scalar Move Instructions, <br>
    </p>
    <pre>"If vstart ≥ vl, no operation is performed and the destination register is not updated".</pre>
    <p>2) The second is for vector instruction with helper functions. we
      should not change any elements including the tail elements when
      vstart &gt;=vl. But this patch break this behavior. According to
      the riscv-v-specification,  5.4. Prestart, Active, Inactive, Body,
      and Tail Element Denitions,</p>
    <pre>"When vstart ≥ vl, there are no body elements, and no elements are updated in any destination vector register group,
including that no tail elements are updated with agnostic values."

</pre>
    <p>I will review this patch set in more details later.</p>
    <p>Thanks,<br>
      Zhiwei<br>
    </p>
    <div class="moz-cite-prefix">On 2024/3/7 1:19, Daniel Henrique
      Barboza wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20240306171932.549549-4-dbarboza@ventanamicro.com">
      <pre class="moz-quote-pre" wrap="">Most of the vector translations has this following pattern at the start:

    TCGLabel *over = gen_new_label();
    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);

And then right at the end:

     gen_set_label(over);
     return true;

This means that if vstart &gt;= vl we'll not set vstart = 0 at the end of
the insns - this is done inside the helper that is being skipped.  The
reason why this pattern hasn't been a bigger problem is because the
conditional vstart &gt;= vl is very rare.

Checking all the helpers in vector_helper.c we see all of them with a
pattern like this:

    for (i = env-&gt;vstart; i &lt; vl; i++) {
        (...)
    }
    env-&gt;vstart = 0;

Thus they can handle vstart &gt;= vl case gracefully, with the benefit of
setting env-&gt;vstart = 0 during the process.

Remove all 'over' conditionals and let the helper set env-&gt;vstart = 0
every time.

While we're at it, remove the (vl == 0) brconds from trans_rvbf16.c.inc
too since they're unneeded.

Suggested-by: Richard Henderson <a class="moz-txt-link-rfc2396E" href="mailto:richard.henderson@linaro.org">&lt;richard.henderson@linaro.org&gt;</a>
Signed-off-by: Daniel Henrique Barboza <a class="moz-txt-link-rfc2396E" href="mailto:dbarboza@ventanamicro.com">&lt;dbarboza@ventanamicro.com&gt;</a>
Reviewed-by: Richard Henderson <a class="moz-txt-link-rfc2396E" href="mailto:richard.henderson@linaro.org">&lt;richard.henderson@linaro.org&gt;</a>
Reviewed-by: Alistair Francis <a class="moz-txt-link-rfc2396E" href="mailto:alistair.francis@wdc.com">&lt;alistair.francis@wdc.com&gt;</a>
---
 target/riscv/insn_trans/trans_rvbf16.c.inc |  12 ---
 target/riscv/insn_trans/trans_rvv.c.inc    | 117 ---------------------
 target/riscv/insn_trans/trans_rvvk.c.inc   |  18 ----
 3 files changed, 147 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
index 8ee99df3f3..a842e76a6b 100644
--- a/target/riscv/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -71,11 +71,8 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
 
     if (opfv_narrow_check(ctx, a) &amp;&amp; (ctx-&gt;sew == MO_16)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
 
         gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);
         data = FIELD_DP32(data, VDATA, LMUL, ctx-&gt;lmul);
@@ -87,7 +84,6 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
                            ctx-&gt;cfg_ptr-&gt;vlenb, data,
                            gen_helper_vfncvtbf16_f_f_w);
         mark_vs_dirty(ctx);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -100,11 +96,8 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
 
     if (opfv_widen_check(ctx, a) &amp;&amp; (ctx-&gt;sew == MO_16)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
 
         gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);
         data = FIELD_DP32(data, VDATA, LMUL, ctx-&gt;lmul);
@@ -116,7 +109,6 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
                            ctx-&gt;cfg_ptr-&gt;vlenb, data,
                            gen_helper_vfwcvtbf16_f_f_v);
         mark_vs_dirty(ctx);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -130,11 +122,8 @@ static bool trans_vfwmaccbf16_vv(DisasContext *ctx, arg_vfwmaccbf16_vv *a)
     if (require_rvv(ctx) &amp;&amp; vext_check_isa_ill(ctx) &amp;&amp; (ctx-&gt;sew == MO_16) &amp;&amp;
         vext_check_dss(ctx, a-&gt;rd, a-&gt;rs1, a-&gt;rs2, a-&gt;vm)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
 
         gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);
         data = FIELD_DP32(data, VDATA, LMUL, ctx-&gt;lmul);
@@ -147,7 +136,6 @@ static bool trans_vfwmaccbf16_vv(DisasContext *ctx, arg_vfwmaccbf16_vv *a)
                            ctx-&gt;cfg_ptr-&gt;vlenb, data,
                            gen_helper_vfwmaccbf16_vv);
         mark_vs_dirty(ctx);
-        gen_set_label(over);
         return true;
     }
     return false;
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index e42728990e..0114a132b3 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -616,9 +616,6 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     TCGv base;
     TCGv_i32 desc;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     base = get_gpr(s, rs1, EXT_NONE);
@@ -660,7 +657,6 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
     }
 
-    gen_set_label(over);
     return true;
 }
 
@@ -802,9 +798,6 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
     TCGv base, stride;
     TCGv_i32 desc;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     base = get_gpr(s, rs1, EXT_NONE);
@@ -819,7 +812,6 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
 
     fn(dest, mask, base, stride, tcg_env, desc);
 
-    gen_set_label(over);
     return true;
 }
 
@@ -906,9 +898,6 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     TCGv base;
     TCGv_i32 desc;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     index = tcg_temp_new_ptr();
@@ -924,7 +913,6 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
 
     fn(dest, mask, base, index, tcg_env, desc);
 
-    gen_set_label(over);
     return true;
 }
 
@@ -1044,9 +1032,6 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     TCGv base;
     TCGv_i32 desc;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     base = get_gpr(s, rs1, EXT_NONE);
@@ -1059,7 +1044,6 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     fn(dest, mask, base, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1100,10 +1084,6 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
                              uint32_t width, gen_helper_ldst_whole *fn,
                              DisasContext *s)
 {
-    uint32_t evl = s-&gt;cfg_ptr-&gt;vlenb * nf / width;
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, evl, over);
-
     TCGv_ptr dest;
     TCGv base;
     TCGv_i32 desc;
@@ -1120,8 +1100,6 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
 
     fn(dest, base, tcg_env, desc);
 
-    gen_set_label(over);
-
     return true;
 }
 
@@ -1195,10 +1173,6 @@ static inline bool
 do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
               gen_helper_gvec_4_ptr *fn)
 {
-    TCGLabel *over = gen_new_label();
-
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     if (a-&gt;vm &amp;&amp; s-&gt;vl_eq_vlmax &amp;&amp; !(s-&gt;vta &amp;&amp; s-&gt;lmul &lt; 0)) {
         gvec_fn(s-&gt;sew, vreg_ofs(s, a-&gt;rd),
                 vreg_ofs(s, a-&gt;rs2), vreg_ofs(s, a-&gt;rs1),
@@ -1216,7 +1190,6 @@ do_opivv_gvec(DisasContext *s, arg_rmrr *a, GVecGen3Fn *gvec_fn,
                            s-&gt;cfg_ptr-&gt;vlenb, data, fn);
     }
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1248,9 +1221,6 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
     TCGv_i32 desc;
     uint32_t data = 0;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     src2 = tcg_temp_new_ptr();
@@ -1271,7 +1241,6 @@ static bool opivx_trans(uint32_t vd, uint32_t rs1, uint32_t vs2, uint32_t vm,
     fn(dest, mask, src1, src2, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1410,9 +1379,6 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
     TCGv_i32 desc;
     uint32_t data = 0;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     src2 = tcg_temp_new_ptr();
@@ -1433,7 +1399,6 @@ static bool opivi_trans(uint32_t vd, uint32_t imm, uint32_t vs2, uint32_t vm,
     fn(dest, mask, src1, src2, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1495,8 +1460,6 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
 {
     if (checkfn(s, a)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);
         data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);
@@ -1509,7 +1472,6 @@ static bool do_opivv_widen(DisasContext *s, arg_rmrr *a,
                            s-&gt;cfg_ptr-&gt;vlenb,
                            data, fn);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -1571,8 +1533,6 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
 {
     if (opiwv_widen_check(s, a)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);
         data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);
@@ -1584,7 +1544,6 @@ static bool do_opiwv_widen(DisasContext *s, arg_rmrr *a,
                            tcg_env, s-&gt;cfg_ptr-&gt;vlenb,
                            s-&gt;cfg_ptr-&gt;vlenb, data, fn);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -1643,8 +1602,6 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
                         gen_helper_gvec_4_ptr *fn, DisasContext *s)
 {
     uint32_t data = 0;
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
     data = FIELD_DP32(data, VDATA, VM, vm);
     data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);
@@ -1655,7 +1612,6 @@ static bool opivv_trans(uint32_t vd, uint32_t vs1, uint32_t vs2, uint32_t vm,
                        vreg_ofs(s, vs2), tcg_env, s-&gt;cfg_ptr-&gt;vlenb,
                        s-&gt;cfg_ptr-&gt;vlenb, data, fn);
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -1834,8 +1790,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
             gen_helper_##NAME##_h,                                 \
             gen_helper_##NAME##_w,                                 \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);             \
@@ -1848,7 +1802,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s-&gt;cfg_ptr-&gt;vlenb, data,                \
                            fns[s-&gt;sew]);                           \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2045,14 +1998,11 @@ static bool trans_vmv_v_v(DisasContext *s, arg_vmv_v_v *a)
                 gen_helper_vmv_v_v_b, gen_helper_vmv_v_v_h,
                 gen_helper_vmv_v_v_w, gen_helper_vmv_v_v_d,
             };
-            TCGLabel *over = gen_new_label();
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
             tcg_gen_gvec_2_ptr(vreg_ofs(s, a-&gt;rd), vreg_ofs(s, a-&gt;rs1),
                                tcg_env, s-&gt;cfg_ptr-&gt;vlenb,
                                s-&gt;cfg_ptr-&gt;vlenb, data,
                                fns[s-&gt;sew]);
-            gen_set_label(over);
         }
         mark_vs_dirty(s);
         return true;
@@ -2068,8 +2018,6 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
         /* vmv.v.x has rs2 = 0 and vm = 1 */
         vext_check_ss(s, a-&gt;rd, 0, 1)) {
         TCGv s1;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         s1 = get_gpr(s, a-&gt;rs1, EXT_SIGN);
 
@@ -2102,7 +2050,6 @@ static bool trans_vmv_v_x(DisasContext *s, arg_vmv_v_x *a)
         }
 
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -2129,8 +2076,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
                 gen_helper_vmv_v_x_b, gen_helper_vmv_v_x_h,
                 gen_helper_vmv_v_x_w, gen_helper_vmv_v_x_d,
             };
-            TCGLabel *over = gen_new_label();
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
             s1 = tcg_constant_i64(simm);
             dest = tcg_temp_new_ptr();
@@ -2140,7 +2085,6 @@ static bool trans_vmv_v_i(DisasContext *s, arg_vmv_v_i *a)
             fns[s-&gt;sew](dest, s1, tcg_env, desc);
 
             mark_vs_dirty(s);
-            gen_set_label(over);
         }
         return true;
     }
@@ -2275,9 +2219,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
             gen_helper_##NAME##_w,                                 \
             gen_helper_##NAME##_d,                                 \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm(s, RISCV_FRM_DYN);                              \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);             \
@@ -2292,7 +2234,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s-&gt;cfg_ptr-&gt;vlenb, data,                \
                            fns[s-&gt;sew - 1]);                       \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2310,9 +2251,6 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     TCGv_i32 desc;
     TCGv_i64 t1;
 
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
-
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     src2 = tcg_temp_new_ptr();
@@ -2330,7 +2268,6 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     fn(dest, mask, t1, src2, tcg_env, desc);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
@@ -2393,9 +2330,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
         static gen_helper_gvec_4_ptr * const fns[2] = {          \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,        \
         };                                                       \
-        TCGLabel *over = gen_new_label();                        \
         gen_set_rm(s, RISCV_FRM_DYN);                            \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);\
                                                                  \
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);               \
         data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);           \
@@ -2408,7 +2343,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)           \
                            s-&gt;cfg_ptr-&gt;vlenb, data,              \
                            fns[s-&gt;sew - 1]);                     \
         mark_vs_dirty(s);                                        \
-        gen_set_label(over);                                     \
         return true;                                             \
     }                                                            \
     return false;                                                \
@@ -2467,9 +2401,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
         static gen_helper_gvec_4_ptr * const fns[2] = {            \
             gen_helper_##NAME##_h, gen_helper_##NAME##_w,          \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm(s, RISCV_FRM_DYN);                              \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);             \
@@ -2482,7 +2414,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)             \
                            s-&gt;cfg_ptr-&gt;vlenb, data,                \
                            fns[s-&gt;sew - 1]);                       \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2584,9 +2515,7 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
 {
     if (checkfn(s, a)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
         gen_set_rm_chkfrm(s, rm);
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);
         data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);
@@ -2597,7 +2526,6 @@ static bool do_opfv(DisasContext *s, arg_rmr *a,
                            s-&gt;cfg_ptr-&gt;vlenb,
                            s-&gt;cfg_ptr-&gt;vlenb, data, fn);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -2696,8 +2624,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
                 gen_helper_vmv_v_x_w,
                 gen_helper_vmv_v_x_d,
             };
-            TCGLabel *over = gen_new_label();
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
             t1 = tcg_temp_new_i64();
             /* NaN-box f[rs1] */
@@ -2711,7 +2637,6 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
             fns[s-&gt;sew - 1](dest, t1, tcg_env, desc);
 
             mark_vs_dirty(s);
-            gen_set_label(over);
         }
         return true;
     }
@@ -2773,9 +2698,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##HELPER##_h,                               \
             gen_helper_##HELPER##_w,                               \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm_chkfrm(s, FRM);                                 \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);             \
@@ -2787,7 +2710,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s-&gt;cfg_ptr-&gt;vlenb, data,                \
                            fns[s-&gt;sew - 1]);                       \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2824,9 +2746,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##NAME##_h,                                 \
             gen_helper_##NAME##_w,                                 \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm(s, RISCV_FRM_DYN);                              \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);             \
@@ -2838,7 +2758,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s-&gt;cfg_ptr-&gt;vlenb, data,                \
                            fns[s-&gt;sew]);                           \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2891,9 +2810,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##HELPER##_h,                               \
             gen_helper_##HELPER##_w,                               \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm_chkfrm(s, FRM);                                 \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);             \
@@ -2905,7 +2822,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s-&gt;cfg_ptr-&gt;vlenb, data,                \
                            fns[s-&gt;sew - 1]);                       \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -2940,9 +2856,7 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
             gen_helper_##HELPER##_h,                               \
             gen_helper_##HELPER##_w,                               \
         };                                                         \
-        TCGLabel *over = gen_new_label();                          \
         gen_set_rm_chkfrm(s, FRM);                                 \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);             \
@@ -2954,7 +2868,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s-&gt;cfg_ptr-&gt;vlenb, data,                \
                            fns[s-&gt;sew]);                           \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -3031,8 +2944,6 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
         vext_check_isa_ill(s)) {                                   \
         uint32_t data = 0;                                         \
         gen_helper_gvec_4_ptr *fn = gen_helper_##NAME;             \
-        TCGLabel *over = gen_new_label();                          \
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over); \
                                                                    \
         data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);             \
         data =                                                     \
@@ -3043,7 +2954,6 @@ static bool trans_##NAME(DisasContext *s, arg_r *a)                \
                            s-&gt;cfg_ptr-&gt;vlenb,                      \
                            s-&gt;cfg_ptr-&gt;vlenb, data, fn);           \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -3131,8 +3041,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
         s-&gt;vstart_eq_zero) {                                       \
         uint32_t data = 0;                                         \
         gen_helper_gvec_3_ptr *fn = gen_helper_##NAME;             \
-        TCGLabel *over = gen_new_label();                          \
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);          \
                                                                    \
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);                 \
         data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);             \
@@ -3145,7 +3053,6 @@ static bool trans_##NAME(DisasContext *s, arg_rmr *a)              \
                            s-&gt;cfg_ptr-&gt;vlenb,                      \
                            data, fn);                              \
         mark_vs_dirty(s);                                          \
-        gen_set_label(over);                                       \
         return true;                                               \
     }                                                              \
     return false;                                                  \
@@ -3171,8 +3078,6 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
         require_align(a-&gt;rd, s-&gt;lmul) &amp;&amp;
         s-&gt;vstart_eq_zero) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);
         data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);
@@ -3187,7 +3092,6 @@ static bool trans_viota_m(DisasContext *s, arg_viota_m *a)
                            s-&gt;cfg_ptr-&gt;vlenb,
                            s-&gt;cfg_ptr-&gt;vlenb, data, fns[s-&gt;sew]);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -3201,8 +3105,6 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
         require_align(a-&gt;rd, s-&gt;lmul) &amp;&amp;
         require_vm(a-&gt;vm, a-&gt;rd)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);
         data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);
@@ -3217,7 +3119,6 @@ static bool trans_vid_v(DisasContext *s, arg_vid_v *a)
                            s-&gt;cfg_ptr-&gt;vlenb,
                            data, fns[s-&gt;sew]);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -3386,9 +3287,6 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
         /* This instruction ignores LMUL and vector register groups */
         TCGv_i64 t1;
         TCGv s1;
-        TCGLabel *over = gen_new_label();
-
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         t1 = tcg_temp_new_i64();
 
@@ -3400,7 +3298,6 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
         tcg_gen_ext_tl_i64(t1, s1);
         vec_element_storei(s, a-&gt;rd, 0, t1);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -3442,10 +3339,6 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
 
         /* The instructions ignore LMUL and vector register group. */
         TCGv_i64 t1;
-        TCGLabel *over = gen_new_label();
-
-        /* if vstart &gt;= vl, skip vector register write back */
-        tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
         /* NaN-box f[rs1] */
         t1 = tcg_temp_new_i64();
@@ -3453,7 +3346,6 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
 
         vec_element_storei(s, a-&gt;rd, 0, t1);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -3624,8 +3516,6 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
             gen_helper_vcompress_vm_b, gen_helper_vcompress_vm_h,
             gen_helper_vcompress_vm_w, gen_helper_vcompress_vm_d,
         };
-        TCGLabel *over = gen_new_label();
-        tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_vl, 0, over);
 
         data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);
         data = FIELD_DP32(data, VDATA, VTA, s-&gt;vta);
@@ -3635,7 +3525,6 @@ static bool trans_vcompress_vm(DisasContext *s, arg_r *a)
                            s-&gt;cfg_ptr-&gt;vlenb, data,
                            fns[s-&gt;sew]);
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -3658,12 +3547,9 @@ static bool trans_##NAME(DisasContext *s, arg_##NAME * a)               \
                              vreg_ofs(s, a-&gt;rs2), maxsz, maxsz);        \
             mark_vs_dirty(s);                                           \
         } else {                                                        \
-            TCGLabel *over = gen_new_label();                           \
-            tcg_gen_brcondi_tl(TCG_COND_GEU, cpu_vstart, maxsz, over);  \
             tcg_gen_gvec_2_ptr(vreg_ofs(s, a-&gt;rd), vreg_ofs(s, a-&gt;rs2), \
                                tcg_env, maxsz, maxsz, 0, gen_helper_vmvr_v); \
             mark_vs_dirty(s);                                           \
-            gen_set_label(over);                                        \
         }                                                               \
         return true;                                                    \
     }                                                                   \
@@ -3692,8 +3578,6 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
 {
     uint32_t data = 0;
     gen_helper_gvec_3_ptr *fn;
-    TCGLabel *over = gen_new_label();
-    tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
 
     static gen_helper_gvec_3_ptr * const fns[6][4] = {
         {
@@ -3738,7 +3622,6 @@ static bool int_ext_op(DisasContext *s, arg_rmr *a, uint8_t seq)
                        s-&gt;cfg_ptr-&gt;vlenb, data, fn);
 
     mark_vs_dirty(s);
-    gen_set_label(over);
     return true;
 }
 
diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
index a5cdd1b67f..6d640e4596 100644
--- a/target/riscv/insn_trans/trans_rvvk.c.inc
+++ b/target/riscv/insn_trans/trans_rvvk.c.inc
@@ -164,8 +164,6 @@ GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_check)
                 gen_helper_##NAME##_w,                                     \
                 gen_helper_##NAME##_d,                                     \
             };                                                             \
-            TCGLabel *over = gen_new_label();                              \
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);     \
                                                                            \
             data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);                     \
             data = FIELD_DP32(data, VDATA, LMUL, s-&gt;lmul);                 \
@@ -177,7 +175,6 @@ GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_check)
                                s-&gt;cfg_ptr-&gt;vlenb, s-&gt;cfg_ptr-&gt;vlenb,       \
                                data, fns[s-&gt;sew]);                         \
             mark_vs_dirty(s);                                              \
-            gen_set_label(over);                                           \
             return true;                                                   \
         }                                                                  \
         return false;                                                      \
@@ -249,14 +246,12 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, vwsll_vx_check)
             TCGv_ptr rd_v, rs2_v;                                             \
             TCGv_i32 desc, egs;                                               \
             uint32_t data = 0;                                                \
-            TCGLabel *over = gen_new_label();                                 \
                                                                               \
             if (!s-&gt;vstart_eq_zero || !s-&gt;vl_eq_vlmax) {                      \
                 /* save opcode for unwinding in case we throw an exception */ \
                 decode_save_opc(s);                                           \
                 egs = tcg_constant_i32(EGS);                                  \
                 gen_helper_egs_check(egs, tcg_env);                           \
-                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);    \
             }                                                                 \
                                                                               \
             data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);                        \
@@ -272,7 +267,6 @@ GEN_OPIVI_WIDEN_TRANS(vwsll_vi, IMM_ZX, vwsll_vx, vwsll_vx_check)
             tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a-&gt;rs2));            \
             gen_helper_##NAME(rd_v, rs2_v, tcg_env, desc);                    \
             mark_vs_dirty(s);                                                 \
-            gen_set_label(over);                                              \
             return true;                                                      \
         }                                                                     \
         return false;                                                         \
@@ -325,14 +319,12 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKNED_EGS)
             TCGv_ptr rd_v, rs2_v;                                             \
             TCGv_i32 uimm_v, desc, egs;                                       \
             uint32_t data = 0;                                                \
-            TCGLabel *over = gen_new_label();                                 \
                                                                               \
             if (!s-&gt;vstart_eq_zero || !s-&gt;vl_eq_vlmax) {                      \
                 /* save opcode for unwinding in case we throw an exception */ \
                 decode_save_opc(s);                                           \
                 egs = tcg_constant_i32(EGS);                                  \
                 gen_helper_egs_check(egs, tcg_env);                           \
-                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);    \
             }                                                                 \
                                                                               \
             data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);                        \
@@ -350,7 +342,6 @@ GEN_V_UNMASKED_TRANS(vaesem_vs, vaes_check_vs, ZVKNED_EGS)
             tcg_gen_addi_ptr(rs2_v, tcg_env, vreg_ofs(s, a-&gt;rs2));            \
             gen_helper_##NAME(rd_v, rs2_v, uimm_v, tcg_env, desc);            \
             mark_vs_dirty(s);                                                 \
-            gen_set_label(over);                                              \
             return true;                                                      \
         }                                                                     \
         return false;                                                         \
@@ -394,7 +385,6 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
     {                                                                         \
         if (CHECK(s, a)) {                                                    \
             uint32_t data = 0;                                                \
-            TCGLabel *over = gen_new_label();                                 \
             TCGv_i32 egs;                                                     \
                                                                               \
             if (!s-&gt;vstart_eq_zero || !s-&gt;vl_eq_vlmax) {                      \
@@ -402,7 +392,6 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
                 decode_save_opc(s);                                           \
                 egs = tcg_constant_i32(EGS);                                  \
                 gen_helper_egs_check(egs, tcg_env);                           \
-                tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);    \
             }                                                                 \
                                                                               \
             data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);                        \
@@ -417,7 +406,6 @@ GEN_VI_UNMASKED_TRANS(vaeskf2_vi, vaeskf2_check, ZVKNED_EGS)
                                data, gen_helper_##NAME);                      \
                                                                               \
             mark_vs_dirty(s);                                                 \
-            gen_set_label(over);                                              \
             return true;                                                      \
         }                                                                     \
         return false;                                                         \
@@ -448,7 +436,6 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
 {
     if (vsha_check(s, a)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
         TCGv_i32 egs;
 
         if (!s-&gt;vstart_eq_zero || !s-&gt;vl_eq_vlmax) {
@@ -456,7 +443,6 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
             decode_save_opc(s);
             egs = tcg_constant_i32(ZVKNH_EGS);
             gen_helper_egs_check(egs, tcg_env);
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
         }
 
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);
@@ -472,7 +458,6 @@ static bool trans_vsha2cl_vv(DisasContext *s, arg_rmrr *a)
                 gen_helper_vsha2cl32_vv : gen_helper_vsha2cl64_vv);
 
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
@@ -482,7 +467,6 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
 {
     if (vsha_check(s, a)) {
         uint32_t data = 0;
-        TCGLabel *over = gen_new_label();
         TCGv_i32 egs;
 
         if (!s-&gt;vstart_eq_zero || !s-&gt;vl_eq_vlmax) {
@@ -490,7 +474,6 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
             decode_save_opc(s);
             egs = tcg_constant_i32(ZVKNH_EGS);
             gen_helper_egs_check(egs, tcg_env);
-            tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
         }
 
         data = FIELD_DP32(data, VDATA, VM, a-&gt;vm);
@@ -506,7 +489,6 @@ static bool trans_vsha2ch_vv(DisasContext *s, arg_rmrr *a)
                 gen_helper_vsha2ch32_vv : gen_helper_vsha2ch64_vv);
 
         mark_vs_dirty(s);
-        gen_set_label(over);
         return true;
     }
     return false;
</pre>
    </blockquote>
  </body>
</html>

--------------Qeo207xkaiVAdfUTqFL7ktyR--

