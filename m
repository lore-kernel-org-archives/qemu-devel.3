Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3D6E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLOsx-0002JJ-PT; Wed, 11 Dec 2024 10:44:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLOsw-0002Ix-5C
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:44:22 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLOss-0002QW-Uf
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:44:21 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6efe5c1dea4so44540357b3.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 07:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733931857; x=1734536657; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kSSU5UmHSpMqGjoE4FcpjfWJI1yTnjZRfVfcQJTzv8E=;
 b=X6tB0OUCEZ+FEHVO7To3cUDTWH9D962j+K8Q+oxxdt7D9FTn6SB5DSXEIzCQMnUZvT
 RlVfIM+L6zXRstBcOwoX+xyn6XXJNXe1ck+MemDsw+phTSHEXI60qS9sbJDVUGGxYsZR
 ednHck0VrP3vvzUePYpXtzgUvPM57DYJhdmTe6fhNNdRitD0MsgQaE64jbojNi4HyUqn
 xeblgzRLZQUK4Rs7S0tfP4II+Ra0FnXGwJRr4w4NlgLdLvLpvC9lydBKiPSpjT1gNyyS
 L60r1cUNNq9OqQUOBeGGq3grihFPNXenr7NCuZLcIS3r8OZuAYSMOiKedofOReg66QpD
 Aa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733931857; x=1734536657;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kSSU5UmHSpMqGjoE4FcpjfWJI1yTnjZRfVfcQJTzv8E=;
 b=OXd14mb7TXRuzmnXZNRI+3S1nggNnRdxzBVEqZnGcT3RE7Pn1G7S0k3h9QHHVXmipA
 62No4bezaClmRVGX1j3hnI5mX7fz6qZu8FdWpX0KIATYm+aZ2AsJIFftmbbcSKLNzuIl
 i6TIJFweuP/K4SwWiplXWh8jiC9WAjTY5le4ibAKZ0bRE8qbY8gKJNSk1+8Vuh6mK40M
 VMEGQ0hOo1wiyldVj2mFhZlH2CLVzDL8ikuM6Hcy5nFTf0DxxlZJbjmpVxGTZXKNYEjn
 uOiGI9FevigIff8Yd7xP7kF8WT8+MezIOQ3wtrZoK1bUcwFTcbHXgTOqFy/oDVAxVHNm
 cVPQ==
X-Gm-Message-State: AOJu0Yx1HPD/8wQ9j91RhJ5T9+dNHsOAVDyKtGq3Btjz5+14Um2/20rB
 FzUmbBIh5dQJP5Lf3quJ7lPOEDgVPi8g5gW7abk6BN/mQH9JBe6SLYh2/+ArZFwBnUUkUEU9raX
 n0cUw1U682Ru0bNhw7l7JJ+uJt1fHdrcqMgoWFg==
X-Gm-Gg: ASbGncvCzNnHbtKHB0AxpJNRTb8rb2B3RERRZW3eGa7YaSYUNJpD+15MkghZ46XJVoD
 8W0DWIMcmnCAnaBL1W0whvXAujrFQ1AoSWmrl
X-Google-Smtp-Source: AGHT+IHsaniRF92k1q9q4t9P9Z2Iul63SvaSd4cIn6cg97xk27eYG8yEY8p7G97vl1f+rpuFpuIPFUqIK/SeRTnxH0Q=
X-Received: by 2002:a05:690c:3342:b0:6ef:5ca3:d0f1 with SMTP id
 00721157ae682-6f148084c57mr37346877b3.40.1733931857090; Wed, 11 Dec 2024
 07:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
 <20241210161733.1830573-24-richard.henderson@linaro.org>
In-Reply-To: <20241210161733.1830573-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 15:44:05 +0000
Message-ID: <CAFEAcA-9nUy0g0f0t7ais-Ygy1=2cDz2==-St8fU_tZ1GF8xtg@mail.gmail.com>
Subject: Re: [PATCH v2 23/69] target/arm: Fix decode of fp16 vector fabs, fneg
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Tue, 10 Dec 2024 at 16:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These opcodes are only supported as vector operations,
> not as advsimd scalar.  Set only_in_vector, and remove
> the unreachable implementation of scalar fneg.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index a99f3d0d13..f67360c4c5 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -10816,6 +10816,7 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
>          break;
>      case 0x2f: /* FABS */
>      case 0x6f: /* FNEG */
> +        only_in_vector = true;
>          need_fpst = false;
>          break;
>      case 0x7d: /* FRSQRTE */

Also case 0x7f FRSQRT I think, which will currently fall into
a g_assert_not_reached() for the scalar case.

thanks
-- PMM

