Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3275EF8FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxnkf-0006SK-I4; Wed, 04 Mar 2026 10:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnke-0006RI-D5
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:03:04 -0500
Received: from mail-dl1-x1244.google.com ([2607:f8b0:4864:20::1244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxnkc-0000PP-Eq
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 10:03:04 -0500
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-1273349c56bso8455765c88.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 07:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772636581; x=1773241381; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IfYtF7XDSUOUHxkwjeCKauVzyE9FKBB1TxM0M9CjcUI=;
 b=Z1ou29fpHBv/rr+woqHHxIYWXjVm1Bf0ypR1VhrCtfL+goJfRJfxU46KThEMudflOZ
 rnIjrvZmTR50DUp8n/mNIh/TD6uBzbV+MSXXdT8FDj8uasDOz8I7kvfVbKt1H3ynQbcq
 E3hSi6yZlA4U/gxs3iRl2f1UwnsTU3Yv8fJPeqgzmiyal31Ey/3amAGyVvMin4DB6kty
 kJ/SGYQ4zfogNsM5UhjJQUmfkz/tzlBytb4ekJDFGv2H+mSmS/ddxzbzrgkruH46s67a
 TRLFeZwvAjXLMQ/5yAGPgv+74dDxUIO22xmhQu1Hizag9m5ccy30oIG5/AkTKYZP9aGa
 IIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772636581; x=1773241381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IfYtF7XDSUOUHxkwjeCKauVzyE9FKBB1TxM0M9CjcUI=;
 b=w87173h/pga8+298VQacSnpXGYowoNjzOTl7c/cxj6JhJ9Qm3RMmADHLEnQ/r2B40I
 HCEoPEBr6BdYhzFSkfcOwCZw6n0xVlcP+gSmFz2aRl8IPdfQDK58jGPD/RfRihi66YZu
 FGO+R8yeunCZ3gWE/ok0xvCE2qPGSz+0a0tYXH67FaDHTnSHV0PSpgR55v9oBgW13e2a
 byV826794JuQzyoeqDtcrXAOJs2E5pSCgayLoO2KND1xRl/gxug0L9DDgZtIh90K2sdz
 T0+f/en3+cRU6oqrB58dwpAFZEBPFYaNFU+g7jWu0B0qpnTs9M0HNlHUuyv2XnYZYa0e
 8s5g==
X-Gm-Message-State: AOJu0YzJ9ttUTQbPKf93jY3E6DNmcJOzTeHWhMRQtFavj/Qx1zqAXCW2
 8fjZXNxox34CVk61MZFt+CDPvQMHh9IQJks3MBgy1lIqTGogK2EU0qzY
X-Gm-Gg: ATEYQzy8vXMjMMkap+oz25togjj8kSoGTeq0ukkFKuNlZDH2WTepAriDoo+oXpm3hGi
 VEymtvmDv9KSzDJnVTNR+ODogd+wGOLWZ23zF2ZrlQieUxDqc667XhCz46BNsZcQEDiIzZa59zG
 0eyZGPdq8IkMpAi4d/mLBZZ0Yhxc7WXNZ01piNLFO32awhZxZGhLYSTyBJHEYaVd/G/nnWA9cIp
 Y+XiYrwVdYziQPMzgBMS6viXMlc1nUTh4cC3VYSfvPLHhLselA6el68c84CK8N0WTfHYv6f0ImP
 CX3PC8aVG238adt83VzkCcKBk6cQL4ENH3Ap3g+xq39cCJTdf6olmvfyXukulW2Bpl1c/cq0JAY
 he9uQdBZeP9AQlF9pnBFX4ZJsYHvV9N69p/PjvnZxxoTmB2eKupi6YzXXrJeFHcAJHbPnsrg8Eh
 tJ4HwmVfzoMtSql+uunr8ugRHfMsOL7smj6igeJNjne1w2TauBtfl0n+cLJz4SVBFeqMMUDqY7A
 svObMelnUwJkm6k1Ntn3MIyin5Nl7I=
X-Received: by 2002:a05:7300:2382:b0:2be:6f6:a39c with SMTP id
 5a478bee46e88-2be30ff1260mr847960eec.13.1772636579961; 
 Wed, 04 Mar 2026 07:02:59 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be2ae7a2f5sm2282710eec.33.2026.03.04.07.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 07:02:59 -0800 (PST)
Date: Wed, 4 Mar 2026 23:02:34 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 04/14] target/riscv: rvv: Make vfwcvtbf16.f.f.v
 support OFP8 to BF16 conversion for Zvfofp8min extension
Message-ID: <aahJXqtDDE--HysR@ZEVORN-PC.localdomain>
References: <20260304134006.2908449-1-max.chou@sifive.com>
 <20260304134006.2908449-5-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304134006.2908449-5-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1244;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1244.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Mar 04, 2026 at 09:39:56PM +0800, Max Chou wrote:
> According to the Zvfofp8min extension, the vfwcvtbf16.f.f.v instruction
> supports OFP8 to BF16 conversion when SEW is 8.
> And the VTYPE.altfmt field is used to select the OFP8 format.
> * altfmt = 0: OFP8.e4m3 to BF16
> * altfmt = 1: OFP8.e5m2 to BF16
> 
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  target/riscv/helper.h                      | 12 +++
>  target/riscv/insn_trans/trans_rvbf16.c.inc | 16 +++-
>  target/riscv/vector_helper.c               | 99 +++++++++++++++++++++-
>  3 files changed, 122 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index eb0a488ba8..356c24d9fb 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1247,6 +1247,18 @@ DEF_HELPER_5(vfwcvtbf16_f_f_v, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vfwmaccbf16_vv, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vfwmaccbf16_vf, void, ptr, ptr, i64, ptr, env, i32)
>  
> +/* OFP8 functions */
> +DEF_HELPER_5(vfwcvtbf16_f_f_v_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvtbf16_f_f_v_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvtbf16_f_f_w_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvtbf16_f_f_w_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvtbf16_sat_f_f_w_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvtbf16_sat_f_f_w_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_f_f_q_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_f_f_q_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_sat_f_f_q_ofp8e4m3, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_sat_f_f_q_ofp8e5m2, void, ptr, ptr, ptr, env, i32)
> +
>  /* Vector crypto functions */
>  DEF_HELPER_6(vclmul_vv, void, ptr, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_6(vclmul_vx, void, ptr, ptr, tl, ptr, env, i32)
> diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
> index 6cfda03d2e..9aafd4d2ef 100644
> --- a/target/riscv/insn_trans/trans_rvbf16.c.inc
> +++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
> @@ -92,11 +92,20 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
>  static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
>  {
>      REQUIRE_FPU;
> -    REQUIRE_ZVFBFMIN(ctx);
>  
> -    if (opfv_widen_check(ctx, a) && (ctx->sew == MO_16)) {
> +    if (opfv_widen_check(ctx, a) &&
> +        ((ctx->sew == MO_16 && ctx->cfg_ptr->ext_zvfbfmin) ||
> +         (ctx->sew == MO_8 && ctx->cfg_ptr->ext_zvfofp8min))) {
> +        gen_helper_gvec_3_ptr *fn;
>          uint32_t data = 0;
>  
> +        if (ctx->sew == MO_16) {
> +            fn = gen_helper_vfwcvtbf16_f_f_v;
> +        } else {
> +            fn = ctx->altfmt ? gen_helper_vfwcvtbf16_f_f_v_ofp8e5m2 :
> +                               gen_helper_vfwcvtbf16_f_f_v_ofp8e4m3;
> +        }
> +
>          gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
>  
>          data = FIELD_DP32(data, VDATA, VM, a->vm);
> @@ -106,8 +115,7 @@ static bool trans_vfwcvtbf16_f_f_v(DisasContext *ctx, arg_vfwcvtbf16_f_f_v *a)
>          tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
>                             vreg_ofs(ctx, a->rs2), tcg_env,
>                             ctx->cfg_ptr->vlenb,
> -                           ctx->cfg_ptr->vlenb, data,
> -                           gen_helper_vfwcvtbf16_f_f_v);
> +                           ctx->cfg_ptr->vlenb, data, fn);
>          finalize_rvv_inst(ctx);
>          return true;
>      }
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 57221ab884..e7b187a57d 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -89,7 +89,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>  
>      switch (vsew) {
>      case MO_8:
> -        ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
> +        ill_altfmt &= !(cpu->cfg.ext_zvfbfa || cpu->cfg.ext_zvfofp8min);
>          break;
>      case MO_16:
>          ill_altfmt &= !(cpu->cfg.ext_zvfbfa);
> @@ -5034,6 +5034,103 @@ GEN_VEXT_V_ENV(vfncvt_f_f_w_w, 4)
>  RVVCALL(OPFVV1, vfncvtbf16_f_f_w, NOP_UU_H, H2, H4, float32_to_bfloat16)
>  GEN_VEXT_V_ENV(vfncvtbf16_f_f_w, 2)
>  
> +/*
> + * OCP FP8 Narrowing Conversions (BF16/F32 -> FP8)
> + * 1. Initialize a local float_status with RISC-V specific NaN handling
> + * 2. Call the softfloat conversion function with saturation parameter
> + * 3. Merge exception flags back to the original status
> + */
> +#define GEN_OCP_FP8_NARROW(NAME, CONVERT_FN, SATURATE, IN_TYPE)  \
> +static uint8_t NAME(IN_TYPE a, float_status *s)                  \
> +{                                                                \
> +    float_status local = *s;                                     \
> +    local.default_nan_pattern = 0x70;                            \
> +    local.default_nan_mode = true;                               \
> +    uint8_t result = CONVERT_FN(a, SATURATE, &local);            \
> +    s->float_exception_flags |= local.float_exception_flags;     \
> +    return result;                                               \
> +}
> +
> +/* BF16 -> E4M3/E5M2 conversions */
> +GEN_OCP_FP8_NARROW(vfncvt_bf16_to_e4m3, bfloat16_to_float8_e4m3, false,
> +                   uint16_t)
> +GEN_OCP_FP8_NARROW(vfncvt_bf16_to_e5m2, bfloat16_to_float8_e5m2, false,
> +                   uint16_t)
> +GEN_OCP_FP8_NARROW(vfncvt_bf16_to_e4m3_sat, bfloat16_to_float8_e4m3, true,
> +                   uint16_t)
> +GEN_OCP_FP8_NARROW(vfncvt_bf16_to_e5m2_sat, bfloat16_to_float8_e5m2, true,
> +                   uint16_t)
> +
> +/* F32 -> E4M3/E5M2 conversions */
> +GEN_OCP_FP8_NARROW(vfncvt_f32_to_e4m3, float32_to_float8_e4m3, false, uint32_t)
> +GEN_OCP_FP8_NARROW(vfncvt_f32_to_e5m2, float32_to_float8_e5m2, false, uint32_t)
> +GEN_OCP_FP8_NARROW(vfncvt_f32_to_e4m3_sat, float32_to_float8_e4m3, true,
> +                   uint32_t)
> +GEN_OCP_FP8_NARROW(vfncvt_f32_to_e5m2_sat, float32_to_float8_e5m2, true,
> +                   uint32_t)
> +
> +/*
> + * OCP FP8 Widening Conversions (FP8 -> BF16)
> + * According to Zvfofp8min isa specification: "No rounding occurs, and no
> + * floating-point exception flags are set."
> + * 1. Initialize a local float_status with no_signaling_nans=true
> + * 2. Call the softfloat conversion function
> + * 3. Intentionally DISCARD exception flags (not merged back)
> + */
> +#define GEN_OCP_FP8_WIDEN(NAME, CONVERT_FN)      \
> +static uint16_t NAME(uint8_t a, float_status *s) \
> +{                                                \
> +    float_status local = *s;                     \
> +    local.no_signaling_nans = true;              \
> +    return CONVERT_FN(a, &local);                \
> +}
The widening conversion correctly discards exception
flags per spec ("No rounding occurs, and no floating-
point exception flags are set."). Good.

Thanks,
Chao
> +
> +GEN_OCP_FP8_WIDEN(vfwcvt_e4m3_to_bf16, float8_e4m3_to_bfloat16)
> +GEN_OCP_FP8_WIDEN(vfwcvt_e5m2_to_bf16, float8_e5m2_to_bfloat16)
> +
> +/* vfwcvtbf16.f.f.w vd, vs2, vm # Convert OFP8 to BF16. */
> +RVVCALL(OPFVV1, vfwcvtbf16_f_f_v_ofp8e4m3, WOP_UU_B, H2, H1,
> +        vfwcvt_e4m3_to_bf16)
> +RVVCALL(OPFVV1, vfwcvtbf16_f_f_v_ofp8e5m2, WOP_UU_B, H2, H1,
> +        vfwcvt_e5m2_to_bf16)
> +GEN_VEXT_V_ENV(vfwcvtbf16_f_f_v_ofp8e4m3, 2)
> +GEN_VEXT_V_ENV(vfwcvtbf16_f_f_v_ofp8e5m2, 2)
> +
> +/* vfncvtbf16.f.f.w vd, vs2, vm # Convert BF16 to OFP8 without saturation. */
> +RVVCALL(OPFVV1, vfncvtbf16_f_f_w_ofp8e4m3, NOP_UU_B, H1, H2,
> +        vfncvt_bf16_to_e4m3)
> +RVVCALL(OPFVV1, vfncvtbf16_f_f_w_ofp8e5m2, NOP_UU_B, H1, H2,
> +        vfncvt_bf16_to_e5m2)
> +GEN_VEXT_V_ENV(vfncvtbf16_f_f_w_ofp8e4m3, 1)
> +GEN_VEXT_V_ENV(vfncvtbf16_f_f_w_ofp8e5m2, 1)
> +
> +/* vfncvtbf16.sat.f.f.w vd, vs2, vm # Convert BF16 to OFP8 with saturation. */
> +RVVCALL(OPFVV1, vfncvtbf16_sat_f_f_w_ofp8e4m3, NOP_UU_B, H1, H2,
> +        vfncvt_bf16_to_e4m3_sat)
> +RVVCALL(OPFVV1, vfncvtbf16_sat_f_f_w_ofp8e5m2, NOP_UU_B, H1, H2,
> +        vfncvt_bf16_to_e5m2_sat)
> +GEN_VEXT_V_ENV(vfncvtbf16_sat_f_f_w_ofp8e4m3, 1)
> +GEN_VEXT_V_ENV(vfncvtbf16_sat_f_f_w_ofp8e5m2, 1)
> +
> +/* Quad-width narrowing type for FP32 to OFP8 */
> +#define QOP_UU_B uint8_t, uint32_t, uint32_t
> +
> +/* vfncvt.f.f.q vd, vs2, vm # Convert FP32 to OFP8. */
> +RVVCALL(OPFVV1, vfncvt_f_f_q_ofp8e4m3, QOP_UU_B, H1, H4,
> +        vfncvt_f32_to_e4m3)
> +RVVCALL(OPFVV1, vfncvt_f_f_q_ofp8e5m2, QOP_UU_B, H1, H4,
> +        vfncvt_f32_to_e5m2)
> +GEN_VEXT_V_ENV(vfncvt_f_f_q_ofp8e4m3, 1)
> +GEN_VEXT_V_ENV(vfncvt_f_f_q_ofp8e5m2, 1)
> +
> +/* vfncvt.sat.f.f.q vd, vs2, vm # Convert FP32 to OFP8 with saturation. */
> +RVVCALL(OPFVV1, vfncvt_sat_f_f_q_ofp8e4m3, QOP_UU_B, H1, H4,
> +        vfncvt_f32_to_e4m3_sat)
> +RVVCALL(OPFVV1, vfncvt_sat_f_f_q_ofp8e5m2, QOP_UU_B, H1, H4,
> +        vfncvt_f32_to_e5m2_sat)
> +GEN_VEXT_V_ENV(vfncvt_sat_f_f_q_ofp8e4m3, 1)
> +GEN_VEXT_V_ENV(vfncvt_sat_f_f_q_ofp8e5m2, 1)
> +
>  /*
>   * Vector Reduction Operations
>   */
> -- 
> 2.52.0
> 

