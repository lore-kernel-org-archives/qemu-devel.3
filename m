Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AD7C02190
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 16:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tduAB-0005uv-0m; Fri, 31 Jan 2025 11:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tduA6-0005sS-Te
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 11:46:34 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tduA5-0000Pl-BC
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 11:46:34 -0500
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e549dd7201cso2772055276.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 08:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738341991; x=1738946791; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JppQovlldchCafF0myyuaZnJyMgp5KkagX6RDlfYEd4=;
 b=FmhYS7O+NDdQFjtiYPSIsPeXOH1rDm1sJnHgJEYiGCmTVy9s7HRfMznCNRNDamyYeP
 Hk8JDs/t68tA2VY7r22vmjbsa2Fq3qHTTDxCQhdABmvbk7IdmeQNUBvCtSHHPPE6zTU1
 9v2vQrnPEeDxoIIRRIL05bMFc2ywfV+lLEJcF+BI7FO4FnfF1rvTUuJhLE7VjLBxDdaJ
 G1W55DQvMPwWCdmuWnfLJ2GAKVPhrUeXybIl5jaHaScWS1ipbYALt+e025pY6oO4mvmc
 J+Zho3qUfNNDNq9jRCJEa7e772L+Yn5XadqsUwOk6+C7QiDmAQLqqX04KAlc65G4Fgpg
 6wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738341991; x=1738946791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JppQovlldchCafF0myyuaZnJyMgp5KkagX6RDlfYEd4=;
 b=Z5WhsoqGxeaF7nHXZDKw9mV9h+HJZaZq0MbBOBhB0vLvb4Nu9CcxAIJyHUyn+DVa4S
 kILDoeMFmKSn4U7fTCYYYpVF8/2Uww1rfKtndhnf6c23BI3ab9+BjDdqj3sLijynTWLL
 xcTJVujwMuE4sfpJ0CfvBmv1GMEa9B1L3iOVzqpafBEAmupg+kLEHcn/avvSzIvAdldZ
 LmpjZ7w7cO9NGwF1BvT+X5ngtSWJGTWfeQGnYtOk/v1ZWTy8hV1HZiIA+/gaxwBp/JKV
 xgUV6L94eMRcAQP9MquIwHibJzZKYrnNLKAh6RaAE7+reWF1xXNRi4rnaDtnm15TMR4O
 Ycxw==
X-Gm-Message-State: AOJu0YzwjVsyeabkJsPmkmJq2v/q7tgBtcADQjuEKKsetymwSbpF7Rbr
 Ovca6g+JVlrqCpDpv6QROab+UwUZfGFFbHFTrOEY+AcdiGOBaQ73VeUPL6Ist2PrTeIjx6JuP6g
 QbzuwFSTpRXRsL8swGTOMrLkGS7vFfM/rjNy56A==
X-Gm-Gg: ASbGnctGVGWygkdLMgn9RLbIWZxkNS/riBa93ODFaudeQOUwTco25B2vzO5njzKyY/D
 +6GG84GBQuTFmcla/mZ5qJYj4CyeqQ3v3VyUzqkeNqdJdVrRPlYRwCON0wSnp3r0KrKk/GBGOKQ
 ==
X-Google-Smtp-Source: AGHT+IHl7+7n5n0RrZZTb3zVKAorYARghoJEnfxSyv4OFt7WXaFwttoJyl63gn39E92Mickw0i8REEI4P5kR1XZK1Jg=
X-Received: by 2002:a05:6902:982:b0:e57:3ddf:4e7b with SMTP id
 3f1490d57ef6-e58a4adbd87mr9882139276.16.1738341991544; Fri, 31 Jan 2025
 08:46:31 -0800 (PST)
MIME-Version: 1.0
References: <20250129013857.135256-1-richard.henderson@linaro.org>
 <20250129013857.135256-29-richard.henderson@linaro.org>
In-Reply-To: <20250129013857.135256-29-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jan 2025 16:46:20 +0000
X-Gm-Features: AWEUYZlnJzsQ6BEDHU0twLgJCF3LcxV38giUUmvOirlsNkzbuIazAT1z3HDRljA
Message-ID: <CAFEAcA8au1rLJdsB8iVKLN0N5eNP7twm=SCVb7zsLpHCqrDusg@mail.gmail.com>
Subject: Re: [PATCH v2 28/34] target/arm: Split gvec_fmla_idx_* for fmls and
 ah_fmls
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 29 Jan 2025 at 01:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Split negation cases out of gvec_fmla, creating 6 new helpers.
> We no longer pass 'neg' as a bit in simd_data.
>
> Handle FPCR.AH=0 via xor and FPCR.AH=1 via muladd flags.

>  static bool do_fmla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool neg)
>  {
> -    static gen_helper_gvec_4_ptr * const fns[3] = {
> -        gen_helper_gvec_fmla_idx_h,
> -        gen_helper_gvec_fmla_idx_s,
> -        gen_helper_gvec_fmla_idx_d,
> +    static gen_helper_gvec_4_ptr * const fns[3][3] = {
> +        { gen_helper_gvec_fmla_idx_h,
> +          gen_helper_gvec_fmla_idx_s,
> +          gen_helper_gvec_fmla_idx_d },
> +        { gen_helper_gvec_fmls_idx_h,
> +          gen_helper_gvec_fmls_idx_s,
> +          gen_helper_gvec_fmls_idx_d },
> +        { gen_helper_gvec_ah_fmls_idx_h,
> +          gen_helper_gvec_ah_fmls_idx_s,
> +          gen_helper_gvec_ah_fmls_idx_d },
>      };
>      MemOp esz = a->esz;
>      int check = fp_access_check_vector_hsd(s, a->q, esz);
> @@ -6756,8 +6762,7 @@ static bool do_fmla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool neg)
>
>      gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
>                        esz == MO_16 ? FPST_A64_F16 : FPST_A64,
> -                      (s->fpcr_ah << 5) | (a->idx << 1) | neg,
> -                      fns[esz - 1]);
> +                      a->idx, fns[esz - 1][neg ? 1 + s->fpcr_ah : 0]);

The indexes into fns[][] here are the wrong way around, so
if you try to do a FMLA on a double it hands you back
gen_helper_gvec_ah_fmls_idx_h ...

thanks
-- PMM

