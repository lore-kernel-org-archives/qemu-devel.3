Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E691E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLQ1B-000394-GZ; Wed, 11 Dec 2024 11:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLQ19-00038K-Mu
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:56:55 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLQ18-000645-7v
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:56:55 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e3988fdb580so5625143276.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733936213; x=1734541013; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EUQuTpWm9UhAvSvm45A5MM3t7f+CKFSui1IV7sQT3z8=;
 b=iOQW3tCIbaPmDgXTp4kGHkhYgDc1AhXx5IHZ9OzhPUqskE1VQo6FQJLFrnFY4otjXt
 EJ5VMcCrgM0ZKp7LSbkzzbVHoOiaYlXhZeNJvYeSciD6IA9ZK73r6mElFZvXGHNc3YV5
 ARkUDXOyh6V7EP0MHj6WmCqD1tFqKCjqP1TWpuQkRVH23s7KmfTkxiJ7qq81g5x+UNEP
 A+jE+aHfjci8w2sdFK3hAZ1MqPiwBkvnmMXNUTZfKiZGde4Eb51GU6s6QxAUe6TS5Wfn
 MDz8bTyP7Qy52OPRfFbEEGZs0cxX2azx/wdYppFpYYHBrA2O9fCOBPBjvCjGwPi8bkpG
 9RRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733936213; x=1734541013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EUQuTpWm9UhAvSvm45A5MM3t7f+CKFSui1IV7sQT3z8=;
 b=LrxxusX7g7Dz81DPIWUo/IFLixAMeLvGE9YkPx+J+CcrA4t/MqXVx3vYSR525hsHyS
 UmxVUwUWKXgcMruSlQaQ56XwcA6rTh8rn/LcPvPw6O7+Bli8D0ScOJKWPPrhK+k1FKdB
 hKfYub9pCvxNah4jvWLT1GXqKzH9bNXRT5FQJ8WE0FqhGq6+wGBnczQB9m3xUqeIrHjg
 JdUj7Zv6H6ecwYVwv4QyNmyn36hujiMPNwhSyXd3h5163nhBwLJVvcRhPqNfUsdwwC7U
 XtIIyn8NIISdvoS7E4gXyLM6nNReH48OHvCp9WeHRLa7new0MeFR7NSHcSTaFNPwTGpd
 W+wA==
X-Gm-Message-State: AOJu0YxFN/VEkISFfWIUPzmEUi/ClvcFtQXkouGOTnH/uXXvlrJFMDTF
 F5uu6fLg3TyQBpFq5F5GKhTEGai5r1KDm9ApeGQU8dZSTzzjuVisRyZo9M0PsWObdoPfxG7Zm4A
 jFjOvN44uAe9mESr1MvB2kLh3mG9tYhjXbTVXpw==
X-Gm-Gg: ASbGnctEtMis8ZY5EvMaUCTSr3MMImUJKXKovfTFxLbc/OwXQk1/cuvByri22BHdeCW
 V83mEvjbyDMkCwHZPYXkxvr5fEXLrsMbrfDKv
X-Google-Smtp-Source: AGHT+IF3IK9ihnDfuBGs9U6CdHs/iL6MUk6IRaAdmooU3t902b/70Uc3m5ClHbVL75YeH1+dqqvTDfHokwHVz4l6oN8=
X-Received: by 2002:a05:6902:c0b:b0:e38:85ae:4667 with SMTP id
 3f1490d57ef6-e3d8f580680mr99603276.1.1733936212910; Wed, 11 Dec 2024 08:56:52
 -0800 (PST)
MIME-Version: 1.0
References: <20241206031224.78525-1-richard.henderson@linaro.org>
 <20241206031224.78525-8-richard.henderson@linaro.org>
In-Reply-To: <20241206031224.78525-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 16:56:40 +0000
Message-ID: <CAFEAcA8Td+0yeAD3BkEoik1Wpo39WW3sZ5AGQ1N4j8WGvUMFCg@mail.gmail.com>
Subject: Re: [PATCH 7/9] target/arm: Convert sme_helper.c to fpst alias
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Fri, 6 Dec 2024 at 03:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme.h | 4 ++--
>  target/arm/tcg/sme_helper.c | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

