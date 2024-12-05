Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6DBE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJITJ-0004A8-9u; Thu, 05 Dec 2024 15:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJITH-00049b-3s
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:29:11 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJITF-00024q-0L
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:29:10 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d122cf8dd1so2172729a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733430547; x=1734035347; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mABNHMP6FvIXyD7suroKODjoEVvkfBT1QGbq7qeDMRY=;
 b=vq5RiAhesZMrYdIxSRnVV/FWVFKg21UXw0DJWATk0Tgwe+W9/oyD6nIuXKb7EYQFZv
 yzFo04iJGpljDx7MbX1mjikkC3QbSnGCtxely87N6c3wzur2g5tbNyIQt9dBtA532Hbx
 1a00xUcGulZK68yiCbnB011T8thKcBGhwnzFe4zPuR0gTUesfzayhFhEOe50V6DDopMB
 Ei9ttbfFrTfc0RL6+wisDi3CSnfYqjzbDrRKzHKrS/ynR6u4s0y9QUApyKVvfR3Sx+sY
 pm9fX6Lza6rzXPaNupHGh+igCzQr69sH4IO5fadDkFs57g4X6aI584xgWdyVCuY2GsKP
 luAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733430547; x=1734035347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mABNHMP6FvIXyD7suroKODjoEVvkfBT1QGbq7qeDMRY=;
 b=ho+mUGPP9wO0VLA15Q2mZMaG+KqVRMuErsUem6+Jjm5mZG+BKuafPOtB6oV9/+ioK2
 b74Sab/zaNKLLfm6Ir6EVEoXoFEi7ZK/DgoCmECGtPwmX1me1CJOmmKVUvgEzqUJEP9q
 TAvtsH1+FExk5AFayrDpsOGy6nowzwBhwfyon48PRAAynQ4T/57iJp/r3HaygKJ1zTzg
 QB49LaJgk59nSZvXJHUFkEXxEVy/uqyD9p07e3Khg0GMN0unCAcsNFUqSeiRdYQXHxck
 LB803Eocjqat7E4CJylUW5M/Ux6lWZcaJU2ghlrfw3/oDECC1KehN2bbZEPDLU6dNM8l
 swOg==
X-Gm-Message-State: AOJu0Ywf+jiHIBey89EsDj4wvfhh9YbiTSSk1n5TE6KRlwKB5nlt2hdB
 co/tdPI9Y+b3UTDdVFgu7M9ge2Hg/AOggCmSd0d8nHKPfT3OW/775Dzqn1rc1t2d6/yKgUmky2P
 MOrazr5BOiyLunuvvMOOt1MpGKTc0rK/kXYK/LA==
X-Gm-Gg: ASbGncvWFqOsynbhG+PEVMx2ddHx5IpdQ2qtxqnoAPM6asMu2iYbkD10qsfziW23LJC
 YABpwB+orPTs5brLofnOa1jSPbXf5wFA7
X-Google-Smtp-Source: AGHT+IGstFao1aZoiYqh/kfRyFmgpN+5o+vV92Q0OtgmJHhZ0+btX6aJoUBeCcZGWre9wAJyvpyeeqT2JnemGEkET7A=
X-Received: by 2002:a17:906:1baa:b0:aa6:32c0:5d03 with SMTP id
 a640c23a62f3a-aa639fec9femr22279666b.17.1733430547088; Thu, 05 Dec 2024
 12:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-18-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-18-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 20:28:56 +0000
Message-ID: <CAFEAcA8Bs8NozBx1hb2SYnmU6g-zq8dL85HgpLK2D=gy+qh5aw@mail.gmail.com>
Subject: Re: [PATCH 17/67] target/arm: Convert SETF8, SETF16 to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Sun, 1 Dec 2024 at 15:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 48 +++++-----------------------------
>  target/arm/tcg/a64.decode      |  4 +++
>  2 files changed, 11 insertions(+), 41 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

