Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59D2C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJCQ-0007pQ-EA; Thu, 03 Jul 2025 08:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJCN-0007l9-Jm
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:37:55 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJCJ-0008S4-Lr
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:37:55 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-70e302191a3so79121447b3.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751546267; x=1752151067; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MbwHfSYOzTD/+GpLtxGAQljhFOKUTGJFolh8GMFFVXQ=;
 b=PB4uGzyyuMM9iPGf9ns0pLm8SLe3yEkjsTe0nI2P3FmAAlXx9GFYWf0BJMAu4Lv0CG
 rYjbnWZh1AO6A3Hz5Ibqpoz4awfdbGPHmbHMjPaatGiQTAJLGDhLPIIrJpFraypVu/ad
 yc9HBHUn8XGDHrVYLWblw4L3DfHWU5FNXQW/Vg9wpwCm/yjLic7Kn/MMC0+60bmtlEwm
 DoHzEDtw0yLxMvONVwfKJ4fs/QP5WbvJy/N+MH4768jxozKFmcPsZYQKUbgkvbA+bpHC
 H0cYG0uYNPaGnSAqdXsQ5HrP6hw21PW4iS5kp210anZlpKKIVuB32arqS1AVLDCqLOo0
 PDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751546267; x=1752151067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MbwHfSYOzTD/+GpLtxGAQljhFOKUTGJFolh8GMFFVXQ=;
 b=oL0cN8NJaHdqqmrtwyu6GP32rw6NQIcYcrMYnaxibKm4txyjLjLRZK78UXaMGZF4cN
 h1tf6cohHSz/Fjjna9blrkHCldub6DRFn+Q6y/D8GmK/JO8ma0TuA0B+vzxvH+O/DrQY
 bSAGFvCfkt8A2ImQ2v35tUPolX1b3p0oNPBq86EiGnNHlzb2wFcdHziCSuRQkG60ZwoM
 K1Q1gBncktJ2Hzc4aBGjlFGBg4b9/Y2Pg/wGVIf2lCPlqaueS57dRWTPKaAVFVX9Dzxt
 6GYc5ddJ3Z33BsfkJF8oPZixUsNgZAIy8y8zJWFZecS2BzNV1FkK6JrjzCWlVTxQX0sb
 qpIg==
X-Gm-Message-State: AOJu0YwAgTH+IvkeZ7IgRShgR72YbNV/7iGWH3osnqTcd1gdeGViyGTg
 ffGmnt43b6oCWfEqBBvY8Szfqb+riRw5zPhw2gm18o1clM+HlD613QpSqevdZ7ru9ZkINJZ4vT/
 AHg66hMpuOpXFJ7D1fOUvMgbETa2O15acYcNkGmKXUQ==
X-Gm-Gg: ASbGncungi/ZZZaeUjZVmAj+XCKS5tL2Zj5etC+f9RYUWgenTM/Z5UDNEILGXR33V+0
 9uELuYwjdMYTmk5mpxsMLyjgy1wJpkMmpfxOVy4tC0yznfte/8JCZe5MT1kPlks/avch9h29/go
 4F+ZDX4lR3AJF2YQKz/dNWelBAtu0A6KFswievwP63+SqOIRUOqUoobsA=
X-Google-Smtp-Source: AGHT+IG6+QtQc1Tcqg4YSUTIHK1f8aly6345v6KEAuIBdWNfJn/OfuYCydT7HMYUykdx8i2FcrPqxRkGAzI7SNEf7/s=
X-Received: by 2002:a05:690c:dd4:b0:6fe:d759:b187 with SMTP id
 00721157ae682-7165a3b7be5mr36635047b3.24.1751546267496; Thu, 03 Jul 2025
 05:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-88-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-88-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:37:35 +0100
X-Gm-Features: Ac12FXymvlBwTPubxjUJt9ncJ3qhLC_oGYQhX_dgItnm5W3OG1RI4OcGiYyKCHs
Message-ID: <CAFEAcA8_bedSNBLx1ww=3YeZ_EZUcv4arNs_LejeyzsbSnb8vA@mail.gmail.com>
Subject: Re: [PATCH v3 87/97] target/arm: Implement LD1Q, ST1Q for SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Wed, 2 Jul 2025 at 13:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sve.h    | 16 ++++++++++++++++
>  target/arm/tcg/sve_helper.c    |  6 ++++++
>  target/arm/tcg/translate-sve.c | 34 ++++++++++++++++++++++++++++++++--
>  target/arm/tcg/sve.decode      |  8 ++++++++
>  4 files changed, 62 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

