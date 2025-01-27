Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E320C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 13:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPZm-0000JB-Vf; Mon, 27 Jan 2025 08:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPZe-0000Hu-0h
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:54:46 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPZa-0007Mr-Th
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:54:44 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so6231875276.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 05:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737986081; x=1738590881; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8Lhj97v80kFVbDq00mXHkVOBuGzpVF6IYLPxp3Desvw=;
 b=GdwuM3E79uvItA9q6Vumz0Ghs7yb2tAyxtxfluCBPfD2JuyBNC25iz1q8vyFaTEXLV
 hV6c33Qgc5xEMiim9JRWROMXqN8IpkOlz5cR274L5MebjNRIgnVAnwgpDv4D5pM5UqmD
 pQ/Jrbcicp9//LC/YElWzNu2v4KsqFHH2DJSG7iBsoF0lTPx1PVazqiwDc4z3umqxCXD
 npdhVZt4pnlsW+gwsjjdVeseo8xaLHWYTH3QaU/H3BM9aDzY5OZUIy0OgkGYkt9MkyUJ
 HU2htlZwCLioFbxadW6SqfoDqu7Pc+z4PYWMcr/R5Kpu0g50VNxezTYjIxzy7YS13xmC
 7bRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737986081; x=1738590881;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Lhj97v80kFVbDq00mXHkVOBuGzpVF6IYLPxp3Desvw=;
 b=JJ46P788CRQtn04neguiW5kC02yS7N12eTVeYdAPpPz/X1H+x3dKvHsdeeEFBmw2Uo
 UaL2TvUBudoRmenaFyAzgJsUDt7Yul0C1CH3vC0zAj6AspcQJiS4lYloN2tyaik+KElB
 9AC9+d7K+qGJMcP122xQxp2OVYMSXkEVDXmdzgoXDJoER0WYlAtil4o9NI3toaud6r/l
 mgqFDt3+KFQHnkD2+NPde1cHZ0ZAGMH5laqmzq0DpHltmTu5JFabnDITrShbyQcF1h6u
 mTauKpcA0sBNvcdiERVhG5V/Dg9hrVbT+i/xO1autD/k1nK5TVhdvUO0i0rSs63zwsWP
 nj0Q==
X-Gm-Message-State: AOJu0Yx9MrebFCrh0bGhp3c69w4IqPdbkW2ldsjsDphvaBT2z7oeXzlb
 MM85zQ/Z4kPWKH+po3A72eYfaOtz7LIjp3AyNMkrKQpqTObZ3TMi9Ry7W2rsSiVR6JvfcsuXe6S
 XsxpAxxjXNP2qHONP0HaLWXqN35uLiDovb1eohQ==
X-Gm-Gg: ASbGncv3Sg4QfG4KG5G8iZnilPNtswyqxmgNfpBrSfC/NhbS03xVuyQ8J4Zl43DVSEF
 UoUr4YM4M7+JZhC48J5d8LgZsCRdUDjh1XieWlcKGjpA8PHl90Mj0aZ/C31AfqTY=
X-Google-Smtp-Source: AGHT+IEzu/9Pcgu8X9ONP+/ynXDql8tEjYTXPIA58uufS3UkrhjaUUVxvq7+OfcprbIBUtOTTzx2yQtth9ZD+eGVsCs=
X-Received: by 2002:a05:6902:160e:b0:e57:8b0d:27e0 with SMTP id
 3f1490d57ef6-e57b12f8ff1mr27078757276.31.1737986080079; Mon, 27 Jan 2025
 05:54:40 -0800 (PST)
MIME-Version: 1.0
References: <20250111183711.2338-1-shentey@gmail.com>
In-Reply-To: <20250111183711.2338-1-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 13:54:28 +0000
X-Gm-Features: AWEUYZnCyXqdjLQzDfyO8yWC1ecpZrV6QNbvzr6F7d8FYjdpI3JVwS2UnjosqSg
Message-ID: <CAFEAcA9pKrU4401VxHyFerK+VQT-dCHPYKFFdjOZPRZ3x0Ti_g@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] i.MX and SDHCI improvements
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Guenter Roeck <linux@roeck-us.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Sat, 11 Jan 2025 at 18:37, Bernhard Beschow <shentey@gmail.com> wrote:
>
> This series fixes some details in i.MX platform devices, improves SDHCI
> compatibility with U-Boot and modernizes some code.
>
> The first 5 patches are bugfixes 1/ resolving infinite loop in U-Boot esdhc
> driver, 2/ fixing a character echoing issue in imx-serial, 3/ fixing IRQ sharing
> issue in Designware PCIe emulation, and 4/ fixing GPIO level preservation across
> resets in imx-gpio.
>
> Patches 6 and 7 modernize SD card emulation by turning presence and
> write-protect GPIOs into qdev GPIOs and then further allowing the GPIOs to be
> inverted, just like device tree allows.
>
> The rest of the series is cosmetics including turning DPRINTF() into trace
> events which eases debugging.
>
> v2:
> * Drop redundant implementation of TYPE_OR_IRQ (David, Zoltan)
> * Use absolute QOM paths when tracing in imx_gpio and imx_i2c (Phil)
> * Trace hexadecimal values in imx_serial (Phil)
> * Do NOT move inversion of presence and write-protect GPIOs since that changes
> the internal logic of the device
>
> Bernhard Beschow (13):
>   hw/char/imx_serial: Fix reset value of UFCR register
>   hw/char/imx_serial: Update all state before restarting ageing timer
>   hw/pci-host/designware: Expose MSI IRQ

I've taken these three into target-arm.next; I see Philippe has
taken most of the rest; and the hw/sd patches I've left some
review comments on.

thanks
-- PMM

