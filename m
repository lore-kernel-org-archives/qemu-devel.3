Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BB7CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 13:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo08Y-0003jZ-Fl; Mon, 18 Aug 2025 09:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uo08W-0003jF-FY
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 09:42:56 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uo08U-0007oa-V3
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 09:42:56 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e94cfaa274fso829249276.0
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 06:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755524573; x=1756129373; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7ZlF0xsqdfx4X0ii2cNYvb/8fAkYkWaG6q7RECZUaPw=;
 b=ZxTeDMeT3zCKAWeCsrgTthxHlgnKCtx/Ljw5UE0rSnQlsu4V9xdZuHR2k0guI5FajT
 XgmpUyVJdh6tHeYwHbrA7zp+GSydtbbRoO1ukxjCidGnuMmbqXpoKi2vejxr0Va0R8MS
 WL3YCtSO7euLb3l3Vj7IMojbmTSiXuManDfngW1kS/RAPx7Ogc7UMd6soUmbvOkXs9eb
 WLPFQktPUAJw0NFsmFAJSbZat8v/ldFihBIs6TJXvIrNJU61UW641G8KhBP9+n2SU9Wp
 5vfKkkAWthCGHqiohlTvSphNfL6qixi4C6JlU1ok5tvIVrlqy3fBOunZ9DBQzlLi546j
 grqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755524573; x=1756129373;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ZlF0xsqdfx4X0ii2cNYvb/8fAkYkWaG6q7RECZUaPw=;
 b=bwQz88bxgiCnl+gHrnvZazsf02R8WChTUxWxwV55rNSMXmTNxRHq28jC2t83gggBW/
 nmh70T9s8ra5e+7g1wQbPNygLgTvu1ogm47qsDNTxYDPxVP1WZIZE7t1Ch5Q7whWNbnA
 MuB1EEMRfO+Sl85bN7E946CPFvB+B2QDQzlWXeE7abRsaniOZdYrR4rcI7LQh14O3Yd5
 9kN4F0ygjC8VWtnKvJtwakWvTv/eVp8hOlsB3Pb+j9Zq6CSffhFFaxbbLneeBZUd+J0w
 QdP3jZEpXnUeXTn9El4dnyD0MSBo9tKBgGh+yMhimblSH44kpSE7sljQ7+uQoPwhy4P5
 hWGQ==
X-Gm-Message-State: AOJu0YwDcz+fvSrHpL1KnwXd9tGwyN76OqfVHYCsozHkPD/zdzSsecdj
 /EM3ekvMw8FEO96sVBKzSzwcoRB4lc841hhQDLZ5heEprifd+LR36mUBuoASVX93108dV8Dy9kD
 +e7kcYtaRAaNBdFexSuvUWcucNOmCqNXVpZvrLU4G2g==
X-Gm-Gg: ASbGnctfvHa7h+SLMBMVFNX/g4+TjPo8Tl/ewjSZnxFUEpb+DUGVc0Yjvcgxej4d8Xi
 hLsRb5Djh8QZN/RYR2j/w8xGye5XQtvCXwANxsddfffqQFUcTUxePPvT6n2K0iWHtG0yrMW9+ll
 4zmX2Wd/dCXWL+v8gcYCcourRDhwm4DBWkwnlwVmbTdqNjK9iuiYS8/+k6kTHMSMosI0QLGBl2w
 HKKFp+d
X-Google-Smtp-Source: AGHT+IGCJ77a4W/vfTe70AxEMz+oLEskgJypga3v9uUdcmRd9evb1iYqA6w6tSOdPJvM5t+sD51B+AsBSypNPE5wsg0=
X-Received: by 2002:a05:6902:f84:b0:e93:3be4:9723 with SMTP id
 3f1490d57ef6-e933be4985cmr12967038276.9.1755524573228; Mon, 18 Aug 2025
 06:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250727074202.83141-1-richard.henderson@linaro.org>
 <20250727074202.83141-7-richard.henderson@linaro.org>
In-Reply-To: <20250727074202.83141-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Aug 2025 14:42:41 +0100
X-Gm-Features: Ac12FXycgRhsdqgE59z8zuWn8OfIqGM2QsUOJ7cmvHeIC__K7sq_BJxOA8JHzV8
Message-ID: <CAFEAcA8ez8XW9xn+Q=XwCFf+LObEZN9yQSEmEcy3hXTwYe2tCw@mail.gmail.com>
Subject: Re: [PATCH v9 6/6] target/arm: Enable FEAT_MEC in -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Gustavo Romero <gustavo.romero@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Sun, 27 Jul 2025 at 08:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Gustavo Romero <gustavo.romero@linaro.org>
>
> Advertise FEAT_MEC in AA64MMFR3 ID register for the Arm64 cpu max as a
> first step to fully support FEAT_MEC.
>
> The FEAT_MEC is an extension to FEAT_RME that implements multiple
> Memory Encryption Contexts (MEC) so the memory in a realm can be
> encrypted and accessing it from the wrong encryption context is not
> possible. An encryption context allow the selection of a memory
> encryption engine.
>
> At this point, no real memory encryption is supported, but software
> stacks that rely on FEAT_MEC should work properly.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250711140828.1714666-7-gustavo.romero@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/cpu64.c        | 1 +
>  docs/system/arm/emulation.rst | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 4eb51420ef..c54aa528c6 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1250,6 +1250,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>      t = GET_IDREG(isar, ID_AA64MMFR3);
>      t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
>      t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
> +    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);        /* FEAT_MEC */
>      t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
>      SET_IDREG(isar, ID_AA64MMFR3, t);

Looking at this again, I don't think we should set
ID_AA64MMFR3_EL1.MEC if RME is not enabled.

I guess the way to do this that fits in with how we
already handle "user-facing property disabled feature X
and that means we should also disable feature Y" is
to put a check in arm_cpu_realizefn() for "if RME
disabled then squash ID_AA64MMFR3.MEC to 0" ?

thanks
-- PMM

