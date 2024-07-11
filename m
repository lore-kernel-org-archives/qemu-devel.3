Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CB7C3DA47
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 10:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRqhJ-000088-Rv; Thu, 11 Jul 2024 06:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRqh8-0008Qd-1m
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:06:36 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRqh5-00031C-Jp
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:06:33 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-58c947a6692so953315a12.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 03:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720692389; x=1721297189; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bSlZiBkF41thqlaeJ7gQmqe90FaqKX7hDK44FbZ8aDI=;
 b=PGshCwxN1UncB98gW0w0qDsZYBNnF2cqrdc0t6ILcD3iRjNm4dsRMWqKyEtSXjgxQH
 qEN2m4ivoBKzzvP0qU4EO4SA7W70Mwdpnsiwbuw5f7Lu1rMtavPvWgG3o9Ymfny/ucPP
 tqnLe8aX2lVJnhIouto7xUXFBDp9Yb8wDi1OJGE1b04W+jQjg4l0KC3NbMxKqlK0WHmA
 0/iMtiU0lVePmCiuFkl44WkmYkpy8Xd402eHPEoGKcQ9DFsFeZf/+BNRD5W8nuZdZZTj
 +G1pheLIfV0i/WGR1CYR6/XE7ht4BSqyXM04VnfE2+kok6o0gCVdg6K0tkDWAuIuzvNg
 6tUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720692389; x=1721297189;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bSlZiBkF41thqlaeJ7gQmqe90FaqKX7hDK44FbZ8aDI=;
 b=v0mxlpJ319iI5v/n0PbXZbXWDPZ7CZrYrNjqa7lIjGHv17UKAp/FeAl74Xu+QTLUqo
 40TLE05lEJuPsVa/flM1CMx9WYNBonNmZx/2IRdyqnNfxgFX/l5cGFp1GFLbwAtIsNOz
 u0U1my2VMesYn+6uFfjdAWSEZluBcpKiYbTCKwlg9Eytbkz6KiwuD1sR5vMiF0xJCvQa
 iy1YlvF2cI1U2MeTNdLrVTmIjkOcegF650G0djkwRqEmZ52C9AwzqGmmAGdud5JWqrXj
 sW4/E/UJx3pqw/hWF7VUuQbZGe5HytQNNCScUrOOqxor/zRiQHsSg8sGkSlIt72RtctF
 kojg==
X-Gm-Message-State: AOJu0Yxo3oiO7QxWT3srsnmEck+D+oc+qJKeBgTwSbfwm7vzlmDhJGlu
 9TFij4pqNKssnKuRTK5LbQW7x7U5LNWTyH3CcVFkkHBCJehQQyWrsodTY3tSzo4/Nh8f12B/Cz1
 J9hayYRAEqG2djLBA9a8jCvrsePBbQ6QO+sA8TZevyLxhpniJ
X-Google-Smtp-Source: AGHT+IEyD7JKsfELi49JfwQeIdziuKNxcIvXmTcG0wdXNiZ+YqDDaAh56vRqyfoyP5xyzY5c8ZmjNH8Gt9PD0bvhNAo=
X-Received: by 2002:aa7:cd52:0:b0:58d:77e0:5c17 with SMTP id
 4fb4d7f45d1cf-594ba5a033bmr4630024a12.21.1720692389484; Thu, 11 Jul 2024
 03:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240709000610.382391-1-richard.henderson@linaro.org>
In-Reply-To: <20240709000610.382391-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2024 11:06:18 +0100
Message-ID: <CAFEAcA9_3512Fs36=dCFZ2RwsDLwa-gT3U_+pUxbpZA_s0O4JQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/6] target/arm: AdvSIMD decodetree conversion,
 part 3
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 9 Jul 2024 at 01:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> [Sorry about the @qemu.prg typo; resend for anyone replying.]
>
> A small set, but better than waiting for a larger set.
> It's a good stopping point, finishing the convertion of
>
>   disas_simd_three_reg_diff
>   disas_simd_scalar_three_reg_diff
>   disas_simd_indexed
>
>
> r~
>
>
> Richard Henderson (6):
>   target/arm: Convert SMULL, UMULL, SMLAL, UMLAL, SMLSL, UMLSL to
>     decodetree
>   target/arm: Convert SADDL, SSUBL, SABDL, SABAL, and unsigned to
>     decodetree
>   target/arm: Convert SQDMULL, SQDMLAL, SQDMLSL to decodetree
>   target/arm: Convert SADDW, SSUBW, UADDW, USUBW to decodetree
>   target/arm: Convert ADDHN, SUBHN, RADDHN, RSUBHN to decodetree
>   target/arm: Convert PMULL to decodetree

Applied to target-arm.next, thanks.

-- PMM

