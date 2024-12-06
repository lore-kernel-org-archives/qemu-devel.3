Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8001FE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZxW-0004sL-8E; Fri, 06 Dec 2024 10:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZxU-0004sA-Ui
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:09:32 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZxT-0002cR-8D
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:09:32 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-30037784fceso6253201fa.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733497769; x=1734102569; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eWBNnwwJIZ9zXOw86qobcAK4LqqYdzRS/2lMDjVOplA=;
 b=vbr1KQwPas4iH6GN2Jl0m6uAqh5wXTzThqCHawjAUZxWhucdaMciPh1GRz7YOO42BW
 a0Ax1lkB+OCenk9ZpLdMKOZqJ28vuyuTszv53ROP0bB7JtswrXiXx+hUUFmEnI7Hqrsf
 KSfWB5r/+v3mggKmL2I5BgGL/TRxziO8MYoNGFJEaS9H1xno45COCiCVjd49m5FZJ92c
 pO6dhZSk5NmTTwtdeRTbTc2q8+FeQ2P2FV++Z8YvOmp1LsWPsgyiGYeDOeXxhEplLlco
 1hSq7rBnYQFkf64fLQ4r/I0FHxsBFMDXdy8EhNQfywFhYcpHLiy0+fxfTcb7yRJe+34Q
 2bhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733497769; x=1734102569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eWBNnwwJIZ9zXOw86qobcAK4LqqYdzRS/2lMDjVOplA=;
 b=G7h0Pb+2u3PqF5o9MaaYbCV5x/8Z3eBlJVH9UZ0jRvl4tgjgSpnNnEfHZQFYvFatiV
 Fg7k1VjcJ87AOeOaX4jkPVgJDCIPqpGkAoEL9YTc8smnksgdiMgQpdvQFhCn79qlMEGq
 b6BLJD+9X82CU1wrPXyBZ3PWeFg3scgzu26vdx7S0Y6VbyQZ6yk62olt+l5U4HdEVDs9
 bA6MHoPAWeNZk5seDd9VflM3Ymj3GHsTOdtFOS6toMvOh08flVKQQWkBN+pHsna5Tfax
 8/fZyxhSd9g3+bGZAXWdyy7Zh4u06EYjLfO1UkYQAiSb47i6ju00z+0E+bDdWsXpRgxu
 FKIQ==
X-Gm-Message-State: AOJu0YyXr+ed5pWXOBjzuI45/cvryLGPWWfFZSwo4ytnMSu1eLMeT8ob
 5Lb0HI1c7bRRAkp3+aCSCw5pnVjrIcKyzZSuUjsp2ypKGYPGY7Wp//8IV0isNUvdJCRxStKJMLA
 jkCOohYwwLA2FNSkZ1qt+RMoxk+i+3l1SSkj94w==
X-Gm-Gg: ASbGncvQSejuSTT8K6PVDs/I2Qa20EJxQMjVzviLEkxJA8pbYe+EpOxZbQk+gUzQzH1
 hRMAemZNiA8L1PeB5laEKPIzEqlImyqz+
X-Google-Smtp-Source: AGHT+IFFvuvzVRv7NWSQmBuYIf/j891uSs0+tOA3wIGQ+rnTpHs+f5hGwLEslUQ3Mp6/lZitk8c3aTBvHfV+4AFWVZc=
X-Received: by 2002:a2e:a990:0:b0:2fb:8777:7359 with SMTP id
 38308e7fff4ca-3002fcf2245mr20007461fa.39.1733497769250; Fri, 06 Dec 2024
 07:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-42-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-42-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 15:09:18 +0000
Message-ID: <CAFEAcA9oiKzQyc-bBUeSYPAZ2Fh9dUaG+=cFJ56m=oqJ1dwzyg@mail.gmail.com>
Subject: Re: [PATCH 41/67] target/arm: Introduce gen_gvec_rev{16,32,64}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Sun, 1 Dec 2024 at 15:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate.h      |  6 +++
>  target/arm/tcg/gengvec.c        | 58 ++++++++++++++++++++++
>  target/arm/tcg/translate-neon.c | 88 +++++++--------------------------
>  3 files changed, 81 insertions(+), 71 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

