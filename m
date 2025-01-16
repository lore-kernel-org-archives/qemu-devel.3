Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06FAC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 11:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYO7H-0001tl-6U; Thu, 16 Jan 2025 06:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYO74-0001kp-PS
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:32:40 -0500
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYO72-0005lX-9L
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:32:38 -0500
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e3a26de697fso1282237276.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 03:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737027155; x=1737631955; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XVXCmA4jNWdfTjbWvZeFtT4EP5A/IfJW6OBDMfSth3A=;
 b=eBcJmMvNJfI67wuhPs4lISqmWitBW8v+F3aWvsJWFXKC8QOEo4zluTlW8DYVnb+EaU
 OLqjR/cL0Jhlg+xij9XQVd2rSJz9odaYU8E0j8ugZZdnf1Qa9dJvRFGWFpzzG0JwSyIx
 Wh7QCGRVKb7wy0/3d+M0ftqQ9RLXG1dsio6E/IIDFLkXoGsPZLcWQPMVltn0l2aIXS+O
 5G0HhCWXMKyBbxdsZ+qv9dp3/1buEh0FzgZSQRfqPoWzzS+J2HyM9h+dTg9Jeev5ktH8
 fmsc+v2KdAi1thPbH7HQ4ArfQbt/lCkk8NZqqXG8v36+yCTC6SMvKjEVjHo36/AEQo0o
 tjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737027155; x=1737631955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XVXCmA4jNWdfTjbWvZeFtT4EP5A/IfJW6OBDMfSth3A=;
 b=K6ZJHj+S/eoPkKJv+jKFoN/eRcxdzBF2AQvMqWr/EAfXpo2qacXtreyzPnkUsL9Coz
 dTgjN2O2nomBtNYpYGV7yTR9VLxBGMwgSwfNtplx4iLrWCxiVpfOxaiG9/ENh0iqPJos
 x6CHsb5Eo/R6JO407yuIKYxAPZOjZuQBfN+xJLDssR+p0kyL0QTRLnzV1D1Kv+ZFW3j2
 VJZ3/HFYx0+YN74pNb41z9/OfSswxxCyJCx8MGSgvVsIO2EHriGjUE0ckoAox7cPOGaf
 rndUX/9GGjc3lrL3gNbsRkJDvXIE9k1MyW6DWrJ9cLNpD8ayBoeD73yITOuhfioePa+W
 GwIw==
X-Gm-Message-State: AOJu0YyYRC8uOQDEWlPwn58xqdDlKo/E/4yM+am3e+NjClTfzj1z+gKj
 vHH381DnAhrvD9m+TjrtE04G0NR5divRUqooP9pGZFlTk2RBItzi7KY+dzdISC0TqTA8yCvCJTB
 tPChK/eIF7CHVbPmC9HoKMBRcDvXx4Mysy4BKTw==
X-Gm-Gg: ASbGnctsXHQj0FluJ1cvRXyaQFivn4woEvjLTDjPHF1+GvMRMAjO2ZBboPrXFzwEOLk
 qRru2j6BFJN4righzDblVHKu8ORjN/w0mBV121BM=
X-Google-Smtp-Source: AGHT+IEh8K0LarobC+hTKs4kgVkYpehx6sFM4n6aW5pkN+xo0PGQQe36O/pGqK+BpnxH6WjVazJMbGfXHhF/k/dCKFE=
X-Received: by 2002:a81:fa07:0:b0:6f6:d428:39c7 with SMTP id
 00721157ae682-6f6d4283a04mr33328237b3.37.1737027155062; Thu, 16 Jan 2025
 03:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20250116111600.2570490-1-anasonov@astralinux.ru>
In-Reply-To: <20250116111600.2570490-1-anasonov@astralinux.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2025 11:32:23 +0000
X-Gm-Features: AbW1kvZZUEKseMHKWgku35XYwORZfx2EX4EwASM-gJNw3l3ke3lqrdrHF-U4src
Message-ID: <CAFEAcA_S1COmR=_t8Q7mXoEoAwYSbxUNRSvZmp35LiH9JSbtPg@mail.gmail.com>
Subject: Re: [PATCH] hw/ide: replace assert with proper error handling
To: Artem Nasonov <anasonov@astralinux.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, 
 sdl.qemu@linuxtesting.org
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

On Thu, 16 Jan 2025 at 11:17, Artem Nasonov <anasonov@astralinux.ru> wrote:
>
> This assert was found during fuzzing and can be triggered with some qtest commands.
> So instead of assert failure I suggest to handle this error and abort the command.
> This patch is required at least to improve fuzzing process and do not spam with this assert.
> RFC.
>
> Found by Linux Verification Center (linuxtesting.org) with libFuzzer.
>
> Fixes: ed78352a59 ("ide: Fix incorrect handling of some PRDTs in ide_dma_cb()")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2777
> Signed-off-by: Artem Nasonov <anasonov@astralinux.ru>
> ---
>  hw/ide/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index f9baba59e9..baca7121ec 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -931,7 +931,10 @@ static void ide_dma_cb(void *opaque, int ret)
>      s->io_buffer_size = n * 512;
>      prep_size = s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size);
>      /* prepare_buf() must succeed and respect the limit */
> -    assert(prep_size >= 0 && prep_size <= n * 512);
> +    if (prep_size < 0 || prep_size > n * 512) {
> +        ide_dma_error(s);
> +        return;
> +    }

Now the comment and the code disagree (the comment
says that the callback must never do the thing that we
now have code to handle).

What's the actual situation when the prepare_buf callback hits
this assertion? Is the problem in this code, or is it in the
callback implementation? Which IDEDMAOps is involved?

thanks
-- PMM

