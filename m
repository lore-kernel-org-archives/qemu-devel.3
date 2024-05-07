Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5A5C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4I1w-0006NU-UJ; Tue, 07 May 2024 06:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4I1m-0006G1-80
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:26:31 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4I1k-0005od-8i
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:26:29 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-572af0b12b8so152305a12.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715077586; x=1715682386; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cQnw0Lr91mm91QCQbo0hvaxzztmipIFdNFt3BeGuD0g=;
 b=RsmbSjE5fZHVVTthPsGrqmqDrxqvzVnEKQBqYmS+CTBNri+cyH/cp4dCyto9PlNmcn
 OQMmQeIP68wO7MQ7M+j9/DMEk5p21S2S5OH+p1U6J5h3ALwS9SmaK22QvAT1ARbSre6a
 EE+1pIv1xNGvgw8qEp/E8yabtysqfaJ2CDZuLJI2/g11lAVQfa1FrzVO9Br9A7ZwTxVy
 JuiI5YqREIrr1YXfLsFDcMcaYNM04dXA67ecS/v3W5ZrGcGPcJQP0mQL2mdev/kvr2Wg
 xNbFDweoKZ7QIg8eyq4sz6xGAtWCIFV1fbD+VkFv+3umIHCxb932K+XukZisl5Olp86/
 XzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715077586; x=1715682386;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cQnw0Lr91mm91QCQbo0hvaxzztmipIFdNFt3BeGuD0g=;
 b=wj13s0H4E+aA/yTV0aif0rfHbS/8hp9+eDUqrIRkXw188bkChWru/AY1tbTiBsuYwe
 1Qq17IKCJeGvKSSSpllCefLLCFsy8FGc6rONK98UYLXac5SPWvRMTp/tvgLl6oJChFUD
 jVcuPrBwc358Hv9sLGWEGwW5WEfuUhjPcvxzEhAz2MoJhzjvNUsRqIodMiRTPxMEUMCY
 R9ZPlN4Dgc16DQLlM44NnlNc42ke2GMut45UnGm3+hjQDNB905v7qGg3vBoUsYEIunN7
 Q486/jI0pFWduhz1ahxfxfpakjjnOgH2gVadchQf8zmTtl8eO6mbM0+Km6KK7ctRwkbT
 bHAg==
X-Gm-Message-State: AOJu0YycbucqJCjRCNBYQ5sUf0IdjpJAKXPYo5lUkvIyeRm93C2gDEwm
 6/0aYjyLrXxD5LXuL7lR+R+xry9pVmhS4VkDuaGYlJD3nod9PyZyZkU4PLYhD9H3dSrt4x17ODG
 lgolqoEUvHqo38sgQlIAXzH4jM9JKBQEr6UrWiQ==
X-Google-Smtp-Source: AGHT+IEmwP8rQN8Cu1Ab/oYxVyuveoffE9Lxk7KLvjPLNi/cF/5XXyGWeUgVyKq5e3bd7Po1WkF0x0BsWNd+Jv1/ipc=
X-Received: by 2002:a50:ab5a:0:b0:572:5f8c:42 with SMTP id
 t26-20020a50ab5a000000b005725f8c0042mr8214873edc.0.1715077586524; 
 Tue, 07 May 2024 03:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHnsOnN6AkE3visU9jaycp61G87XRJFwDGx4D1=HJSJpA2tfXw@mail.gmail.com>
In-Reply-To: <CAHnsOnN6AkE3visU9jaycp61G87XRJFwDGx4D1=HJSJpA2tfXw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2024 11:26:15 +0100
Message-ID: <CAFEAcA8S1HJgcJdC5M=V1UHZHwNKhX_ii9PNNc88uC2Gi2E3sw@mail.gmail.com>
Subject: Re: [PATCH] Fixes: Indentation using TABs and improve formatting
To: Tanmay <tanmaynpatil105@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm@nongnu.org, 
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 6 May 2024 at 07:20, Tanmay <tanmaynpatil105@gmail.com> wrote:
>
> Hi,
>
> I have added a patch inline that fixes indentation and formatting for some files as listed in https://gitlab.com/qemu-project/qemu/-/issues/373.
>
> Thanks,
> Tanmay

Hi; thanks for this patch. Unfortunately there seem to be some
problems with the formatting, which mean it doesn't apply correctly.

In particular you've sent it as a plain/text + HTML email, and
something (probably your mail client) is wrapping long lines.
I can usually fix something like this up on my end for a first
time submitter, but in this case the patch is just way too big
for that to be practical.

I generally don't recommend trying to send patch emails directly
through the gmail web UI -- it unfortunately mangles them too
much. Personally I use git-send-email; it is a bit awkward to
set up, but https://git-send-email.io/ has a nice step-by-step
guide including specific details on how to configure it to send
via Gmail.

> From 46026574821c46804111eea6607a1b39314b7abe Mon Sep 17 00:00:00 2001
> From: Tanmay Patil <tanmaynpatil105@gmail.com>
> Date: Sat, 25 Nov 2023 00:53:54 +0530
> Subject: [PATCH] Fixes: Indentation using TABs and improve formatting
>  Resolves: https://gitlab.com/qemu-project/qemu/-/issues/373
>
>    Files changed:
>         - hw/arm/boot.c
>         - hw/char/omap_uart.c
>         - hw/dma/pxa2xx_dma.c
>         - hw/gpio/omap_gpio.c
>         - hw/gpio/zaurus.c
>         - hw/input/tsc2005.c
>         - hw/input/tsc210x.c
>         - hw/intc/omap_intc.c
>         - hw/misc/cbus.c
>         - hw/misc/omap_clk.c
>         - hw/misc/omap_l4.c
>         - hw/misc/omap_sdrc.c
>         - hw/misc/omap_tap.c
>         - hw/sd/omap_mmc.c
>         - hw/sd/pxa2xx_mmci.c
>         - hw/timer/omap_gptimer.c
>         - hw/timer/omap_synctimer.c
>         - hw/timer/pxa2xx_timer.c
>         - include/hw/arm/pxa.h
>         - include/hw/arm/sharpsl.h
>         - include/hw/arm/soc_dma.h
>         - tcg/arm/tcg-target.h
>
> Signed-off-by: Tanmay Patil <tanmaynpatil105@gmail.com>
> ---
>  hw/arm/boot.c             |   8 +-
>  hw/char/omap_uart.c       |  49 +-
>  hw/dma/pxa2xx_dma.c       | 198 ++++----
>  hw/gpio/omap_gpio.c       | 243 +++++-----
>  hw/gpio/zaurus.c          |  61 +--
>  hw/input/tsc2005.c        | 130 ++---
>  hw/input/tsc210x.c        | 442 +++++++++--------
>  hw/intc/omap_intc.c       | 261 +++++-----
>  hw/misc/cbus.c            | 202 ++++----
>  hw/misc/omap_clk.c        | 999 +++++++++++++++++++-------------------
>  hw/misc/omap_l4.c         |  21 +-
>  hw/misc/omap_sdrc.c       | 135 +++---
>  hw/misc/omap_tap.c        |  28 +-
>  hw/sd/omap_mmc.c          | 208 ++++----
>  hw/sd/pxa2xx_mmci.c       | 149 +++---
>  hw/timer/omap_gptimer.c   | 126 ++---
>  hw/timer/omap_synctimer.c |   7 +-
>  hw/timer/pxa2xx_timer.c   | 279 ++++++-----
>  include/hw/arm/pxa.h      | 100 ++--
>  include/hw/arm/sharpsl.h  |   2 +-
>  include/hw/arm/soc_dma.h  |   4 +-
>  tcg/arm/tcg-target.h      |   4 +-
>  22 files changed, 1903 insertions(+), 1753 deletions(-)

This is a lot of changes to do all in one commit, even though they're
all just whitespace fixes. Could you split them up, please, into
multiple patches that tackle fewer files at a time?

thanks
-- PMM

