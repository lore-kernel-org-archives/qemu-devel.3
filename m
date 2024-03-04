Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBD7C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 18:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhCey-0000uR-JL; Mon, 04 Mar 2024 13:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhCex-0000ty-Dc
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 13:03:31 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhCev-0006PT-Sn
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 13:03:31 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5658082d2c4so6626760a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 10:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709575408; x=1710180208; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AEN6w40t0pspdlu2ngnJZO7POyMRUmSmC4FlT3zYSt8=;
 b=UJN6smd/IB16HZEjGTOfHXy8ELkPYpDN/MBZYRB8+z6kDFbRjOyGLyWacYwPxKchUl
 hze8gGgU8XUSQA+bHjZPphqlXzW+2+wMRNvMxxUvB7YiPCNV4dj66EDxWSlV9zvWjCFe
 5+hSDEkjzAcOZwXRTg/YxjAdusXUr2N/xmK6mIpLZ+547Ae75yIe259UQu9zhQ6iGBet
 3z5yqAm7FaRRQYFD8FlBhRoMF82YQTvvCtYr621Z3kvQggVtboQrsnfm8c3CaeOgPC/X
 8OVntNguH34aM19Ofcaf8T6fIcKcK3avkDPLDUfkvm/OYMZU7C+woW8/cknmpQqLy5c8
 XugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709575408; x=1710180208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AEN6w40t0pspdlu2ngnJZO7POyMRUmSmC4FlT3zYSt8=;
 b=gDaZv+yqGJQa+SbZcZnq7+smUkX8oH9+PlMiQaehtu75TuTMx3BH5p5AtA9brwJQg6
 FPdjcBZ7PBUyszlyEVNF7eBOhG5279kdq1900VEehEpgc5Z6vrM4yXpyIUmH3Sg97O5y
 Bk4VB0+tFoZfEgsoWUrqFxtda4jrp6zVBSle84Mw2TCprR+rvNQvpwsDl0Xk7IJ1XcUs
 GPEcbWhdGfxYuKhw5Pb98R2ZKFCJ8wHBS6V/o4cTINDngbh2+Yd5Se2htmqRxZrTTruN
 eSwiYTFTqxItVUsAsiWNZ84dNoUbNM0Gd7cwlLX43XPogcF7eap36P3nRPLZTp7zIDNX
 8hqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwIIpuuwV5HYwVuEMX5Rd02ELSxa5Gn0PK95tI0f5a/hI9ZvFifFKcArK8vBCk16OmfwH7i2D3m8+pbCGQ+rfudBVgXkg=
X-Gm-Message-State: AOJu0Yz6Z0mI/UeGhh8imAi4n9YrCvU29S2zb6xMc8AoKhLRFRL1N1Nw
 8YAaZ7nyyKMCYPRdCRb5FzMU6Wa61d3kRdeGXo49FzMIvMUpLX80N6Vb41KJC2USnOIKCL2KSqM
 Xy6j6EcMzgGqv08GFT+FwrOr7peu0mcYyFX7I+Q==
X-Google-Smtp-Source: AGHT+IGx0CF+o19HHQuuOwrtma1IrXh+TMhYU8VNPQL33hGkR9mNpQ3TVVN5UhBwlrnia5sL+vA5BxDyIIssKgJqTDg=
X-Received: by 2002:a05:6402:12ce:b0:567:14ff:771a with SMTP id
 k14-20020a05640212ce00b0056714ff771amr4462075edx.21.1709575408265; Mon, 04
 Mar 2024 10:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
In-Reply-To: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 18:03:17 +0000
Message-ID: <CAFEAcA93hQXMh7NXej2X=HUhgyrv-e+3UEjC-5X5Q14gwkdmgg@mail.gmail.com>
Subject: Re: [PATCH 0/7] contrib/elf2dmp: Improve robustness
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, 3 Mar 2024 at 10:51, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> elf2dmp sometimes fails to work with partially corrupted dumps, and also
> emits warnings when sanitizers are in use. This series are collections
> of changes to improve the situation.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Akihiko Odaki (7):
>       contrib/elf2dmp: Always check for PA resolution failure
>       contrib/elf2dmp: Always destroy PA space
>       contrib/elf2dmp: Ensure segment fits in file
>       contrib/elf2dmp: Use lduw_le_p() to read PDB
>       contrib/elf2dmp: Use rol64() to decode
>       contrib/elf2dmp: Continue even contexts are lacking
>       MAINTAINERS: Add Akihiko Odaki as a elf2dmp reviewer
>

I noticed somebody filed a bug report about elf2dmp
crashing recently:

https://gitlab.com/qemu-project/qemu/-/issues/2202

Does this patchset happen to fix that crash?

thanks
-- PMM

