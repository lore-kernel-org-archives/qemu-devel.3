Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C17C35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 13:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutix-0002MB-2z; Wed, 19 Mar 2025 09:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tutis-0002Ld-0h
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:44:42 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tutiq-0002u6-03
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:44:41 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e637669ef11so5470975276.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742391877; x=1742996677; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eOQfMwq9eZCI7+fp7IPvh7To5zK8nbunI7gu1PMB/mQ=;
 b=saR7rXKo5SlqmeEAZlQlIEsMUEvNgnIaCklCfJPP7guBoU/gTQUu92jNvdbeqN+0iJ
 hITgb8hdwfDx2kScTYOCaompDR04JN3IPEK85HXFEj+y4yppKGBgFDhhkpfrLXVWQf4h
 9OLUkX8heETUaK27+6SZ8esPlPV2hI00VKonZB2NG6fH87Sv4AhospIzqmMcXK+GguUP
 R61VXDQZOhhL/oKBUmW5mP+3g2EJ0mwSIcsP4Dyl7XUpp86xBW9gRqUGRA+s1S0++AfD
 ZbQF6A2DF+qTZ/B8OQb8gObI7S3MQvaXKSsITTaFBZfo73Fw4MjG5P7ET5EDaeZyJhU5
 qrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742391877; x=1742996677;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eOQfMwq9eZCI7+fp7IPvh7To5zK8nbunI7gu1PMB/mQ=;
 b=HhIqiDaASoWLc+EiTQW/IzlWAHcJAmEfPv2vUaRPCrXNUwsABz/JWtqe90SpJ3Xzp7
 nxyi2Xo+y4qdUYUAAINOiiYHB1NDRfEKChhwr+QhVxksD2ZudULNw1Q+pBa+JAzyVX6C
 Ty0WbpuZvzyPJEgXdi6FDBmES2KVuocvTOXnvEeoSvHWjZiC24nSPrB61OqIsNSFFQmF
 IetFq6auDSLO2qGRxBII5KuxVzBoSDwTz3n/uxkjdgBuwFR/w6tJsVZSOzaAZSKs6Fed
 yzRZzQk9hDNvLMLO7W2xo/N6WuhdptnRMYWZ8WNHl4cM44zj8YJVy4HGdxsOaxXFEf3O
 rKhg==
X-Gm-Message-State: AOJu0YzVGaXVQfnkZ2K9wdRgH3GWyenR0W9TgImQICLESn7qA5kRGjpU
 CmF6e2FWzPxaQhx3Lwd3s04WQex1BiNcVEA3swxlFjwI4E3WAJyXI1TXBbm/ucKdmV651FPRMyU
 Zg0Bjp15awKBMOH3YD10+N2+vhcD89nFp8X0ZOw==
X-Gm-Gg: ASbGncvtHvsk6D5XtQ1MmNRouX9UILy+yvcUm1p9BKeYsbgX2HFX/ga6e/2U3rSnCNJ
 fPFBXv5Q/3n+oC1SQn9kaeF4dTQXQJPDbZxzrHRKphEtlH47cavj6rjZudJWokDIPvWldSMllHZ
 xlwr7obtntrWHkOSmQNWPo1j/Bmp0=
X-Google-Smtp-Source: AGHT+IGxYDq9e8EFZMAd+Kc6lfIBnnmeKrw0XrPTbML65Zw7b7aPQJB1SV18jMVWqfZrmSzU4xtJQNdDSa1CFLpEuSk=
X-Received: by 2002:a05:6902:240c:b0:e63:69d7:4e05 with SMTP id
 3f1490d57ef6-e667b3f9186mr3214008276.25.1742391876162; Wed, 19 Mar 2025
 06:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250319023036.71493-1-tanishdesai37@gmail.com>
In-Reply-To: <20250319023036.71493-1-tanishdesai37@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Mar 2025 13:44:24 +0000
X-Gm-Features: AQ5f1JqsLyVsniH8XhvGb5mF6-p2nvi61RtEQaVUgV4W8m6YfC0zxyi3kbXktFk
Message-ID: <CAFEAcA80b54NZUxPv_QoXQXakTwEuRvK-hxy==c=-PEB2dB3sg@mail.gmail.com>
Subject: Re: [PATCH] Fix duplicate symbol error on MacOS build
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Wed, 19 Mar 2025 at 12:53, Tanish Desai <tanishdesai37@gmail.com> wrote:
>
> The issue started after commit https://github.com/qemu/qemu/commit/59f4d65584bd3372070e2484876436c8d02505e4
>
> Reproduction:
>   1. In the build directory on MacOS (haven't tried on other OS), run:
>        ../configure --enable-rust --target-list=aarch64-softmmu
>   2. Then run either:
>        ninja -C .
>        OR
>        make
>   3. At the end, you will encounter the error:
>        duplicate symbol '_pl011_create' in:
>            /Users/tanishdesai37/Downloads/qemu-master/build/libcommon.a.p/hw_char_pl011.c.o
>            librust_aarch64_softmmu.a[5](pl011.pl011.390d424367e209af-cgu.1.rcgu.o)
>        ld: 1 duplicate symbols
>
> Root cause:
>   Both CONFIG_PL011 and X_PL011_RUST are selected, causing C++ and Rust to produce the same object.
>   This is due to the commit above where 'select PL011' forces a true condition instead of checking if HAVE_RUST is true.
>   If HAVE_RUST is true, X_PL011_RUST should be selected instead of CONFIG_PL011.
>
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> ---
>  hw/vmapple/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> index 2382b297672..01bcbf40e00 100644
> --- a/hw/vmapple/Kconfig
> +++ b/hw/vmapple/Kconfig
> @@ -22,7 +22,8 @@ config VMAPPLE
>      select PLATFORM_BUS
>      select PCI_EXPRESS
>      select PCI_EXPRESS_GENERIC_BRIDGE
> -    select PL011 # UART
> +    select PL011 if !HAVE_RUST # UART
> +    select X_PL011_RUST if HAVE_RUST # UART
>      select PL031 # RTC
>      select PL061 # GPIO
>      select GPIO_PWR

Paolo: we seem to have quite a lot of this

    select PL011 if !HAVE_RUST # UART
    select X_PL011_RUST if HAVE_RUST # UART

duplicated for every PL011-using machine. Can we factor this out
in Kconfig? e.g.

config PL011
    select X_PL011_RUST if HAVE_RUST
    select PL011_C if !HAVE_RUST

(and update hw/char/meson.build to use CONFIG_PL011_C for pl011.c).
Then all the machines can go back to plain "select PL011" and
don't need to care whether it's the Rust or C version.

Or does that not work?

thanks
-- PMM

