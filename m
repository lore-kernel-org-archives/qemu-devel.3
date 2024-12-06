Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D50FE77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZzB-0005yC-K3; Fri, 06 Dec 2024 10:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZz1-0005qj-Dd
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:11:09 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZyy-0003FY-Mo
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:11:06 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-3002c324e7eso14993811fa.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733497863; x=1734102663; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=38NebLTFw6mLpi/S6wvRGKDFwCEXEsFpmO+vlDD+P3A=;
 b=dF5Vq1i6XsimzeXNII2LBhcfZJ3SPY9yYmY+tbLeujWyrf1r3DH8xfeg/VBSVnltsK
 iUhC3aWxpmvtI2v6HfJ1ppiuSB7oxz2UJb4oYv7vEKmkwji9IUgYxspyI1dluvKZ/316
 SHf01T6YYdKtnPeWJ10AJG+NKCrdV62z904PiJqiJwaJ8IyxgEJgMwhdjy8jAOj0z5YE
 ojpvXu7quOkBep/DKVG9SHq+Kq4PyxMUOwJF5MPXFUuXKn+3zP0J97AptUV0jqaHIqCA
 Qpt6FUb1memKaGa5n0clO1oReOfW1CJ1jNZsmEW/nnfyYHtaUAAvwiYiR4FwjAsTPGFi
 oJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733497863; x=1734102663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=38NebLTFw6mLpi/S6wvRGKDFwCEXEsFpmO+vlDD+P3A=;
 b=On3W659ZUP35Hk8WS5uUUyR7+xN1wfE88k/ph4aCM7uhrHxbCTykOqCNifW4w2c6Eh
 vfYGOMDMsUgNMHjaWsmN6lcGg0PdJNaHd0kQQHb85OdPp4RvE6vVYoGuJx+Atp7tL5OS
 GOSVg41DIUYUoKFw2oCvlLEZ6EMUivOYnW4/7jHarqHtxf2+vBPAd9mQNNP86BVLt4o7
 F73ynpBn0OHQfLvHK5sSYkPzSn/kKvekOtpkComYgtFmkA3Qr4Q7qy+gCPpJ8jg8s0rY
 PtCmf0fqHIeYwmwU8HE7Bn/5exA85Ois+9tM5TY/+TQWy5kPNz2cjGl6wuNJ5FKgk6Fd
 TWHg==
X-Gm-Message-State: AOJu0YwgAeDxP+ZTq2xsCI40jTZMYeABBtN911FZAqf6Gh/PYrK1+Nnw
 nu4wJqte9huy8s+aobm/rojRiR0ocgNA0jPb0oVzWbNSCnnYw8cpHvZpx2hpqCk38M68YmsIMDZ
 LLp6Co/IxqLpehh5Kw6ZT0NdCIT83UsDOfTxgYg==
X-Gm-Gg: ASbGncuwqp7vhzy3xL9Hm2A5388CRd4lXNGoXsF786b/uorQyyiFaRn/8+xlebxg8o/
 4Z9Y7l+6qUO4o2YraYiHocATws7K4RXHs
X-Google-Smtp-Source: AGHT+IH4dKf6fQ1JFnneEHk76cK+GGIHNJuPBiTYkWUVrAM7cNWDWY8qS67MJLq359eAvTljzLNE/AtyuW5CI+Asn5Y=
X-Received: by 2002:a05:651c:1544:b0:2ff:b6df:ce0a with SMTP id
 38308e7fff4ca-3002fd46712mr24158761fa.28.1733497862164; Fri, 06 Dec 2024
 07:11:02 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-44-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-44-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 15:10:51 +0000
Message-ID: <CAFEAcA_erXHv6nKT694pJurq-gh3otBAe8L9cfAkprOiEBg_4g@mail.gmail.com>
Subject: Re: [PATCH 43/67] target/arm: Move helper_neon_addlp_{s8,
 s16} to neon_helper.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
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

On Sun, 1 Dec 2024 at 15:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move from helper-a64.c to neon_helper.c so that these
> functions are available for arm32 code as well.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h          |  2 ++
>  target/arm/tcg/helper-a64.h  |  2 --
>  target/arm/tcg/helper-a64.c  | 43 ------------------------------------
>  target/arm/tcg/neon_helper.c | 43 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 45 insertions(+), 45 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

