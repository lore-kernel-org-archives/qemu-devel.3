Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0D0E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJ9Y-0003SU-TL; Thu, 05 Dec 2024 16:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJJ9X-0003SJ-LP
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:12:51 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJJ9V-0000r6-PE
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:12:51 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cedf5fe237so2072824a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 13:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733433167; x=1734037967; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mwkzcxco0XFnItNLn4rGF+Pv+73RPTuRVKAz0oChYn4=;
 b=MJiJP9SlvsESOq6NTrS615KoLkf7hYqbZch6UnuRAdbXDNII2Cl9E33uLhKJTQ1fLK
 BZ5ogKfEBClA0+05LXxsDNo7uMxL2htJTrGjYoAkWxXjPJkkxaLjDo6RVdz10krevD1C
 vLPIrKnE7/R/wwXayjF2upfdW1LDQPkhaSoKi5uoFdn8LjghocDwbB0Ccg7+iSVLchVw
 OEagRjixEcJW+knrCOC6zneK9GVNQe6PeiQPBdJ2I7WZLjlp3FjIFeYXoG1iePnPkzz1
 h7fboAADVVZfm9xpM8fg9v7bu12NFlmy7KOcoJg9zoMgrAVf+HdbPSx7p3dqC9unXyBc
 xqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733433167; x=1734037967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mwkzcxco0XFnItNLn4rGF+Pv+73RPTuRVKAz0oChYn4=;
 b=IHhXPu1Ch37KbUiYXHkP45LMiHiMN7sm+PxEnvLBHWJY/uskQ/yTQKjYpbY7NHYrer
 LbLT57Z7UHKf0OmTp1aiZs7ahbuYgbBLkOQYCcLjhyInT+F8Ou3D21wLYutG2Bl+dqmT
 VmprTuXT131C6I4PPkRdhYUCHmPrkUF7fkjthXw5dH9MPup5o8vbkt+c4z0uZ45BFzZx
 +9U9/iV8yU0ZZoxyRhjawS5tQHNYdSY3EHC29XOrUVJQLkX4b9JerhzAixmldAB/qDzm
 SWWpYYtj5jj0IyyyFye06VFbrTAHY3gL2+Sikb8Ccg5MN1bIOoddfVTIyG6LIeX8noQl
 NLjg==
X-Gm-Message-State: AOJu0Yx/bDitZut6OyrPb4DtmYgEQZRksdmbcy4yjof3IFTuQv8PW/Mz
 ng2PyeWd8YKDBy2sqh6K8fi88Wi3i4fM3KuISnzC7uOfUTTahxZPM9L8Wkb9e2s5rIYX26u23gT
 EOXYYLaG5sAVGppEfScKKce4ZZbt6TcgeMtyJGA==
X-Gm-Gg: ASbGnctm/GG14Wq01TnzvbWpworDyfeppAenpMJdJyQQm7jyvFgVmN1EAtUYBlSvzcE
 mM72LUbo1FBICTXy1Wf0J0vttfT/bMzzM
X-Google-Smtp-Source: AGHT+IEkvzYDx8kI/ZcPCU/p+WzWZgQY351VyXJpOramw/f4DMLVh2ff/eUwMQIHC8jSrQ2cO3XoSxo0NQcOAOWNReo=
X-Received: by 2002:a05:6402:540b:b0:5d0:e696:1bfc with SMTP id
 4fb4d7f45d1cf-5d3be6f5d85mr560945a12.15.1733433167408; Thu, 05 Dec 2024
 13:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-24-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 21:12:36 +0000
Message-ID: <CAFEAcA9ECxgGvsSuw+GGsj4h2reKs9bVRSG=TD0oHPh519m7yA@mail.gmail.com>
Subject: Re: [PATCH 23/67] target/arm: Convert FMOV, FABS,
 FNEG (scalar) to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, 1 Dec 2024 at 15:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 104 ++++++++++++++++++++++-----------
>  target/arm/tcg/a64.decode      |   7 +++
>  2 files changed, 78 insertions(+), 33 deletions(-)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 2d3566e45c..87731e0be4 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -8287,6 +8287,67 @@ static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
>      return true;
>  }
>
> +typedef struct FPScalar1Int {
> +    void (*gen_h)(TCGv_i32, TCGv_i32);
> +    void (*gen_s)(TCGv_i32, TCGv_i32);
> +    void (*gen_d)(TCGv_i64, TCGv_i64);
> +} FPScalar1Int;
> +
> +static bool do_fp1_scalar_int(DisasContext *s, arg_rr_e *a,
> +                              const FPScalar1Int *f)
> +{
> +    switch (a->esz) {
> +    case MO_64:
> +        if (fp_access_check(s)) {
> +            TCGv_i64 t = read_fp_dreg(s, a->rn);
> +            f->gen_d(t, t);
> +            write_fp_dreg(s, a->rd, t);
> +        }
> +        break;
> +    case MO_32:
> +        if (fp_access_check(s)) {
> +            TCGv_i32 t = read_fp_sreg(s, a->rn);
> +            f->gen_s(t, t);
> +            write_fp_sreg(s, a->rd, t);
> +        }
> +        break;
> +    case MO_16:
> +        if (!dc_isar_feature(aa64_fp16, s)) {
> +            return false;
> +        }
> +        if (fp_access_check(s)) {
> +            TCGv_i32 t = read_fp_hreg(s, a->rn);
> +            f->gen_h(t, t);
> +            write_fp_sreg(s, a->rd, t);
> +        }
> +        break;
> +    default:
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static const FPScalar1Int f_scalar_fmov = {
> +    tcg_gen_mov_i32,
> +    tcg_gen_mov_i32,
> +    tcg_gen_mov_i64,
> +};
> +TRANS(FMOV_s, do_fp1_scalar_int, a, &f_scalar_fmov)
> +
> +static const FPScalar1Int f_scalar_fabs = {
> +    gen_vfp_absh,
> +    gen_vfp_abss,
> +    gen_vfp_absd,
> +};
> +TRANS(FABS_s, do_fp1_scalar_int, a, &f_scalar_fabs)
> +
> +static const FPScalar1Int f_scalar_fneg = {
> +    gen_vfp_negh,
> +    gen_vfp_negs,
> +    gen_vfp_negd,
> +};
> +TRANS(FNEG_s, do_fp1_scalar_int, a, &f_scalar_fneg)
> +
>  /* Floating-point data-processing (1 source) - half precision */
>  static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
>  {
> @@ -8295,15 +8356,6 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
>      TCGv_i32 tcg_res = tcg_temp_new_i32();
>
>      switch (opcode) {
> -    case 0x0: /* FMOV */
> -        tcg_gen_mov_i32(tcg_res, tcg_op);
> -        break;
> -    case 0x1: /* FABS */
> -        gen_vfp_absh(tcg_res, tcg_op);
> -        break;
> -    case 0x2: /* FNEG */
> -        gen_vfp_negh(tcg_res, tcg_op);
> -        break;
>      case 0x3: /* FSQRT */
>          fpst = fpstatus_ptr(FPST_FPCR_F16);
>          gen_helper_sqrt_f16(tcg_res, tcg_op, fpst);
> @@ -8331,6 +8383,9 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
>          gen_helper_advsimd_rinth(tcg_res, tcg_op, fpst);
>          break;
>      default:
> +    case 0x0: /* FMOV */
> +    case 0x1: /* FABS */
> +    case 0x2: /* FNEG */
>          g_assert_not_reached();
>      }
>

In these changes to the "handle this op" functions we make the
function assert if it's passed an op we've converted. But shouldn't
there also be a change which makes the calling function disas_fp_1src()
call unallocated_encoding() for the ops ?

> @@ -8349,15 +8404,6 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
>      tcg_res = tcg_temp_new_i32();
>
>      switch (opcode) {
> -    case 0x0: /* FMOV */
> -        tcg_gen_mov_i32(tcg_res, tcg_op);
> -        goto done;
> -    case 0x1: /* FABS */
> -        gen_vfp_abss(tcg_res, tcg_op);
> -        goto done;
> -    case 0x2: /* FNEG */
> -        gen_vfp_negs(tcg_res, tcg_op);
> -        goto done;
>      case 0x3: /* FSQRT */
>          gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_env);
>          goto done;
> @@ -8393,6 +8439,9 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
>          gen_fpst = gen_helper_frint64_s;
>          break;
>      default:
> +    case 0x0: /* FMOV */
> +    case 0x1: /* FABS */
> +    case 0x2: /* FNEG */
>          g_assert_not_reached();
>      }
>
> @@ -8417,22 +8466,10 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
>      TCGv_ptr fpst;
>      int rmode = -1;
>
> -    switch (opcode) {
> -    case 0x0: /* FMOV */
> -        gen_gvec_fn2(s, false, rd, rn, tcg_gen_gvec_mov, 0);
> -        return;
> -    }
> -
>      tcg_op = read_fp_dreg(s, rn);
>      tcg_res = tcg_temp_new_i64();
>
>      switch (opcode) {
> -    case 0x1: /* FABS */
> -        gen_vfp_absd(tcg_res, tcg_op);
> -        goto done;
> -    case 0x2: /* FNEG */
> -        gen_vfp_negd(tcg_res, tcg_op);
> -        goto done;
>      case 0x3: /* FSQRT */
>          gen_helper_vfp_sqrtd(tcg_res, tcg_op, tcg_env);
>          goto done;
> @@ -8465,6 +8502,9 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
>          gen_fpst = gen_helper_frint64_d;
>          break;
>      default:
> +    case 0x0: /* FMOV */
> +    case 0x1: /* FABS */
> +    case 0x2: /* FNEG */
>          g_assert_not_reached();
>      }
>
> @@ -10881,13 +10921,11 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
>          case 0x7b: /* FCVTZU */
>              gen_helper_advsimd_f16touinth(tcg_res, tcg_op, tcg_fpstatus);
>              break;
> -        case 0x6f: /* FNEG */
> -            tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
> -            break;
>          case 0x7d: /* FRSQRTE */
>              gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
>              break;
>          default:
> +        case 0x6f: /* FNEG */
>              g_assert_not_reached();
>          }

What's this change about? This bit of decode is not in the area that
corresponds to the new patterns you add to a64.decode.

Is this a bug in our existing decode where we decode something that
should be undef? I think that 0x6f here corresponds to the decode
table in section C4.1.96.6 ("Advanced SIMD scalar two-register
miscellaneous FP16"), where it is U:a:opcode == 1 1 01111. But
in that table that encoding is marked unallocated. A similar
thing is true for case 0x2f FABS and case 07f FSQRT. All three
of these should have set only_in_vector to true and not had the
code handling in the is_scalar branch of the function.

We should fix that bug in a separate patch before we do the
decodetree conversion, I think.

> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
> index 928e69da69..fca64c63c3 100644
> --- a/target/arm/tcg/a64.decode
> +++ b/target/arm/tcg/a64.decode
> @@ -47,6 +47,7 @@
>  @rr_h           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=1
>  @rr_d           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=3
>  @rr_sd          ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_sd
> +@rr_hsd         ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_hsd
>
>  @rrr_b          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=0
>  @rrr_h          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=1
> @@ -1321,6 +1322,12 @@ FMAXV_s         0110 1110 00 11000 01111 10 ..... .....     @rr_q1e2
>  FMINV_h         0.00 1110 10 11000 01111 10 ..... .....     @qrr_h
>  FMINV_s         0110 1110 10 11000 01111 10 ..... .....     @rr_q1e2
>
> +# Floating-point data processing (1 source)
> +
> +FMOV_s          00011110 .. 1 000000 10000 ..... .....      @rr_hsd
> +FABS_s          00011110 .. 1 000001 10000 ..... .....      @rr_hsd
> +FNEG_s          00011110 .. 1 000010 10000 ..... .....      @rr_hsd
> +
>  # Floating-point Immediate
>
>  FMOVI_s         0001 1110 .. 1 imm:8 100 00000 rd:5         esz=%esz_hsd
> --
> 2.43.0

thanks
-- PMM

