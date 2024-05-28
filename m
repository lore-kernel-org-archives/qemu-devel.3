Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490DAC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzE0-0002DY-LJ; Tue, 28 May 2024 11:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzDx-0002Bu-5f
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:58:53 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzDv-0007Gr-Q6
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:58:52 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a6268034cf8so49740366b.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716911930; x=1717516730; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XZHdHibYnpZlZr9G3I7C1t2Kad9PTikqW6rAXY6Migo=;
 b=LrPgwyVEC+zzWlmpVLcWc4OaVHJXPMOkjgiYGhojGpu15yAn9AY6ghL1FN+pWp52Kr
 iB3vYfbkH9rPT8VchcWLFE+j5wFAe7ECdHYMwheAQiIVutl1q9QEeq5QVf+BoU3AfDXd
 8fuj2U96gLRh09+yBCzpyWjNtLhjdwktjEkB53qHYr3B+WrJmB6H2q4ksH/KhfLFHCdB
 t4pBZSU5M3E9npT5lgFUl62o6+ceUlphqCoFbbBnd5tfxBhn660uXd9IHo2OQ/UWVeKt
 9CUq79PQLzc13Yr4s7LoKNuz6BGSyrnMfG2haW640ojaAPUCpZxB4d7r+qqv38GYc3Qu
 Coiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911930; x=1717516730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XZHdHibYnpZlZr9G3I7C1t2Kad9PTikqW6rAXY6Migo=;
 b=lxx+ugYRjSkVrPLOEPbRkFWLIsyY/MzKi2+MrlarLLO37kwwJ04lcHHRX//ccsPTGd
 Apk+bNl3+9YCjkhxmT12xDEyo7VlJ4eCiU1UE6k1uOfHNi4hSdClg42Mt8eUyCdHbH5C
 RchA4tUxC11uniPt046z7t1OsdmOSK9D9xqdKwywf9JGjcbZECdF79+QTMFxBTIlZwEE
 E5Pgq8thqGXHZ0fTyGEJnaECsXclUXfbI/go3AFnDv7z5msIR9lETaCdiAqtCwjQLF7d
 6p3VayY8q/cKg0TKLYK6w9t4Vy6+KbA1RgavHZ4+pXdyixCcsjve0Bv2MeZ9hDX51fVD
 rcag==
X-Gm-Message-State: AOJu0Yyp67mJjx664IKGEmpBFt/+vzPJH3NVmO4icvOO7dHSEGLd9CaF
 heEN1Pct6ljlQy1IHrZWEpOR8Q3sTYJzCIUWBg5NFZ5nmpY+XXUqKFTX0XdxiXdmfGWxeR2NcwZ
 Pu80MXkfo0uRA7BUNECuzkSk9zFz7oZuZ5qtA1ngre2JjHq5u
X-Google-Smtp-Source: AGHT+IEgWEVSatv4yZM+ONksBb7Fria/Aivmepb/attK2PSoFBLN3ywAB+YRW8i49tnRFFCylFtq3aeIIXIwHREcNrY=
X-Received: by 2002:a50:c946:0:b0:56e:10d3:85e3 with SMTP id
 4fb4d7f45d1cf-5785194fa92mr10974426a12.13.1716911930314; Tue, 28 May 2024
 08:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-53-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-53-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 16:58:39 +0100
Message-ID: <CAFEAcA8UKcxazjsjVXmcQw+4ihjc32SouLWMSXB=Fyez3MomJA@mail.gmail.com>
Subject: Re: [PATCH v2 52/67] target/arm: Use TCG_COND_TSTNE in
 gen_cmtst_{i32, i64}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 25 May 2024 at 00:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/gengvec.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

