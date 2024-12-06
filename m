Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D32E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 13:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJYgy-0004sC-T5; Fri, 06 Dec 2024 08:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJYgv-0004rT-RI
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:48:22 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJYgt-0007LT-Vy
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:48:21 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ffc86948dcso21919351fa.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 05:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733492898; x=1734097698; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7UnAfWypkRoUqeDxuWGp0mGDyWXSI3lGURHYAE0TYmw=;
 b=clbrn7Y2m2LtirBCShZOMbF5i5D/TrWqOGqQitC+DplysMhF7cCRFNkjoKxB8c27MH
 ZDlT24XwFimWTQLw/1Yt2wR91nuMbWQgR3CJVrL76lEp7b3l07nHRoaO2kpDKFomxpsr
 xbUz5WBG5+RMznLYTbzfFcDUB1JDf3fTR0Y1BVe4fMbrc7boSPnQcDjjLESeiih6J2Xw
 49iy7zuOfVKAfpfeawR81cvei9MfXY+Hg25lWI2LC9ASYPMNhv+gEQdoq75G5DHYbMCd
 7psZoFyAdAz2+n3nj8nYSL06qEzZApLtGOiDPyUtJS+tcMtdpnpOObG6WcBAkRJ4YWqU
 fBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733492898; x=1734097698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7UnAfWypkRoUqeDxuWGp0mGDyWXSI3lGURHYAE0TYmw=;
 b=EJ7VT+3th9PoanEIjD6Zv4EsZmqQyUZY9R3LaQID2XrGv1McKGRaepxMMHt2oD4qfJ
 /zDyh6wGAyKlQxccKixujL7gMKmbAkpFYSsgig32uRmikDl/9Z3nds2rmVGzHyuUsorU
 XeKSy1Szf5BYpZ2YhPLewuHJRew3Q5QNWiJWqSiPyF5H3WWsdsJM0CPyA1WFS3uHx1HR
 kM0+ij+VXQgfp9aqHzX2RGEk1R64vXBZ18tp2mD8lAu+HJ2dFcipy3Z66jhd/E63KuPA
 4Ojp0+c889zZn+kTD2uDQ3V1WxLhN0+aW2TH1Mu3Ax7endtZI6Pr5t9wvFdPDCnprfx5
 ANYg==
X-Gm-Message-State: AOJu0YzCH2yhJXP4YMMbzjW91u8e+UNi2u0Vm7pH+9HFF8FzbZ6eL9cl
 hMbw6qcY1yyyBO67D120sfvWjJA1RkRp/OZc6ekokDYGDGij4YT8SxpwECwvFMwE6piDOA5AIrd
 pts6E+d85Os7Us03HCuU2Kky35UVKNqKel0dlAObbPSGr0TgD
X-Gm-Gg: ASbGncs83r8uCy0hWHPNh5YJwMWfmFLYEPyPq4pcfLm869tYKaNgbwymAEixthm+KGb
 P9HpEq23OVdLkrO0QmH2LQqW5vDwoIIjQ
X-Google-Smtp-Source: AGHT+IF8fEKEp70jnWxCNuZSCuk795u7e2rdikQhvPkagRdTQbutYjnxnhpDeJiUlDp1ibFYFg6RIc7/YgX0wPKs8s8=
X-Received: by 2002:a2e:bea5:0:b0:300:1f2d:97a with SMTP id
 38308e7fff4ca-3002f913f79mr13192551fa.16.1733492897624; Fri, 06 Dec 2024
 05:48:17 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-32-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 13:48:06 +0000
Message-ID: <CAFEAcA-11+JX0N4vjU_3WDNVt8nis-+ufANLG2L1TNGZhLcubQ@mail.gmail.com>
Subject: Re: [PATCH 31/67] target/arm: Convert handle_fpfpcvt to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

On Sun, 1 Dec 2024 at 15:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes SCVTF, UCVTF, FCVT{N,P,M,Z,A}{S,U}.
> Remove disas_fp_fixed_conv as those were the last insns
> decoded by that function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> +static void do_fcvt_scalar(DisasContext *s, MemOp out, MemOp esz,
> +                           TCGv_i64 tcg_out, int shift, int rn,
> +                           ARMFPRounding rmode)
> +{
> +    TCGv_ptr tcg_fpstatus;
> +    TCGv_i32 tcg_shift, tcg_rmode, tcg_single;
> +
> +    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
> +    tcg_shift = tcg_constant_i32(shift);
> +    tcg_rmode = gen_set_rmode(rmode, tcg_fpstatus);
> +
> +    switch (esz) {
> +    case MO_64:
> +        read_vec_element(s, tcg_out, rn, 0, MO_64);
> +        switch (out) {
> +        case MO_64 | MO_SIGN:
> +            gen_helper_vfp_tosqd(tcg_out, tcg_out, tcg_shift, tcg_fpstatus);
> +            break;
> +        case MO_64:
> +            gen_helper_vfp_touqd(tcg_out, tcg_out, tcg_shift, tcg_fpstatus);
> +            break;
> +        case MO_32 | MO_SIGN:
> +            gen_helper_vfp_tosld(tcg_out, tcg_out, tcg_shift, tcg_fpstatus);
> +            break;
> +        case MO_32:
> +            gen_helper_vfp_tould(tcg_out, tcg_out, tcg_shift, tcg_fpstatus);
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +        break;
> +
> +    case MO_32:
> +        tcg_single = read_fp_sreg(s, rn);
> +        switch (out) {
> +        case MO_64 | MO_SIGN:
> +            gen_helper_vfp_tosqs(tcg_out, tcg_single, tcg_shift, tcg_fpstatus);
> +            break;
> +        case MO_64:
> +            gen_helper_vfp_touqs(tcg_out, tcg_single, tcg_shift, tcg_fpstatus);
> +            break;
> +        case MO_32 | MO_SIGN:
> +            gen_helper_vfp_tosls(tcg_single, tcg_single,
> +                                 tcg_shift, tcg_fpstatus);
> +            tcg_gen_extu_i32_i64(tcg_out, tcg_single);
> +            break;
> +        case MO_32:
> +            gen_helper_vfp_touls(tcg_single, tcg_single,
> +                                 tcg_shift, tcg_fpstatus);
> +            tcg_gen_extu_i32_i64(tcg_out, tcg_single);
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +        break;
> +
> +    case MO_16:
> +        tcg_single = read_fp_hreg(s, rn);
> +        switch (out) {
> +        case MO_64 | MO_SIGN:
> +            gen_helper_vfp_tosqh(tcg_out, tcg_single, tcg_shift, tcg_fpstatus);
> +            break;
> +        case MO_64:
> +            gen_helper_vfp_touqh(tcg_out, tcg_single, tcg_shift, tcg_fpstatus);
> +            break;
> +        case MO_32 | MO_SIGN:
> +            gen_helper_vfp_toslh(tcg_single, tcg_single,
> +                                 tcg_shift, tcg_fpstatus);
> +            tcg_gen_extu_i32_i64(tcg_out, tcg_single);
> +            break;
> +        case MO_32:
> +            gen_helper_vfp_toulh(tcg_single, tcg_single,
> +                                 tcg_shift, tcg_fpstatus);
> +            tcg_gen_extu_i32_i64(tcg_out, tcg_single);
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    gen_restore_rmode(tcg_rmode, tcg_fpstatus);
> +}
> +
> +static bool do_fcvt_g(DisasContext *s, arg_fcvt *a,
> +                      ARMFPRounding rmode, bool is_signed)
> +{
> +    TCGv_i64 tcg_int;
> +    int check = fp_access_check_scalar_hsd(s, a->esz);
> +
> +    if (check <= 0) {
> +        return check == 0;
> +    }
> +
> +    tcg_int = cpu_reg(s, a->rd);
> +    do_fcvt_scalar(s, (a->sf ? MO_64 : MO_32) | (is_signed ? MO_SIGN : 0),
> +                   a->esz, tcg_int, a->shift, a->rn, rmode);
> +
> +    if (!a->sf) {
> +        tcg_gen_ext32u_i64(tcg_int, tcg_int);

For the MO_16 and MO_32 input cases we already did a
zero-extend-to-64-bits inside do_fcvt_scalar().
Maybe we should put the tcg_gen_ext32u_i64() also
inside do_fcvt_scalar() in the cases of MO_64 input
MO_32 output which are the only ones that actually need it?


Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

