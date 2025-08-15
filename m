Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3511CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 14:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umv94-00083z-6u; Fri, 15 Aug 2025 10:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umv92-00083f-Lr
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 10:11:00 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umv90-0001vJ-G3
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 10:11:00 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e931c85710aso2076427276.0
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 07:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755267055; x=1755871855; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Enzf+mDG03UgDgZFabGbGRdu5P0wx58tmwLs2svVics=;
 b=romf31hw4bahxZM/F50NM1hHzkHybeiCK9ehK+X/492VkAbq/Zv0LR44DO0D8ktGe9
 /LAQZdh6Z8Nz93FNFdFYP0iU2fSsn6lBr7GBTOrTjRD9c3IkZIa8MfvhQEq7KWtZO3LU
 4uDcJVbWhwtjU1MEzgnbeMEeig17TJG52PoFt5xbAez+bFMqNMjfaNz+syl98HHQUVH9
 NnKW38MGxLht9eyTIqDb7MD9aKHcVW3FIbmhJQOvv1FRJfYHSPKofdj6kVvLI/ORea+d
 dUbjrg79RDB/EQeqd3qLW0tDfnUj7webm7GsAa1K/hB8PlHkxhNNnq8GdfdTq7t2At7X
 9AdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755267055; x=1755871855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Enzf+mDG03UgDgZFabGbGRdu5P0wx58tmwLs2svVics=;
 b=Pubh7ddy7Hrm/LVi1n26JUhUoTLS1Ry2IJZUi/575BXOA38E2mFN1TUcyCjjOsxd7I
 sH1u8cvD95lUnD4logzh2VR4sdgBcXakWmIX0fTvB3YOrvpgUTUCT+zdlLKL+FyKzt/U
 HdxPBpr2DFR4v9M6NY9D6kpZ2ULOFi1njVpm9l3rW9HtJvebPRAknvE7iRCl2T+2E+tK
 TWtpg8uNBl9klPTTPjGnLM/t+1rCYU8qH6t93ZFo8+Sz/a+40IEU3PSw0qJdDUckYpf0
 prkS9aEvLXaGfOHMrAY6ImHdHXBUTpcJmIzfNpy7yat5nXms1nkuSh1SnqErdKrJerwz
 P7yQ==
X-Gm-Message-State: AOJu0YwT5ezZ1ST/ukTcjDDkATX9ZZp38Yx8SsSDRGguOThdV3f+bifU
 btSpna55lPnYeD3hi2UxdBCxyzzc4rhRCuBmgsl6awpbllnCEGwwHwsy1ungI6jLKe/Oaj4BZxq
 Yy7PJscNTLRRM9ZejolLh8+YmqR/xSfzFHV9hWnIPqg==
X-Gm-Gg: ASbGncujwjyWMYNK3ZTZck4ygodhc4UCZWgLadNRDPNfx+sSMg9NK919o8w2Ezyvx/l
 CfQ/G2vkhwcDWAtdNXG1iSM1CtKZbRzhl4nbEVcD4TaSRRoBZoZEFAGOn3XII3j7I0P00XsLrHg
 xgN2qTLHaSzGwTt5JxueqTnSrJxvIHMAcx3ZnuumuHY1rPNg8pZdQv8PgjgMPvUG9q9jnh6nfho
 PibmNpw
X-Google-Smtp-Source: AGHT+IFd9NQtPYmh7qnGHgQuvYzQfNybJI0mDYDM8LB4FpEvFnxu9b1xhRMydeNNlCVJoTo4stN/tPKzI5BGlK6cyAU=
X-Received: by 2002:a05:6902:20ca:b0:e90:55f8:7161 with SMTP id
 3f1490d57ef6-e93324a9d04mr2735241276.30.1755267055179; Fri, 15 Aug 2025
 07:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250803014019.416797-1-richard.henderson@linaro.org>
In-Reply-To: <20250803014019.416797-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 15:10:43 +0100
X-Gm-Features: Ac12FXz5DgUIx0CmaDuWey5oWczOM-7ty7xBPY2wPVUnRZabZoe54XUK_69sGsA
Message-ID: <CAFEAcA8pFLgizAkVQKkJqUDYk+LS9LiN28hbaNDYBcJ29WM+XQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] target/arm: Implement FEAT_CSSC, FEAT_CMPBR
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Sun, 3 Aug 2025 at 02:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These two extensions are related due to sharing ID_AA64ISAR2.CSSC.
>
> I had intended to test by bootstrapping gcc under emulation with
> -march=native (that seemed the easiest way to test the short
> range branches), but that failed for unrelated reasons.
>
> I'll try again next week.
>
>
> r~
>
>
> Richard Henderson (11):
>   target/arm: Add feature predicate for FEAT_CSSC
>   target/arm: Implement MIN/MAX (immediate)
>   target/arm: Implement MIN/MAX (register)
>   target/arm: Split out gen_wrap2_i32 helper
>   target/arm: Implement CTZ, CNT, ABS
>   target/arm: Enable FEAT_CSSC for -cpu max

I've applied this bits (FEAT_CSSC) to target-arm.next for
10.2; thanks.

-- PMM

