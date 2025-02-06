Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C3CC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5hi-0008OG-HL; Thu, 06 Feb 2025 12:30:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg5he-0008Nd-Lm
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:30:14 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg5hc-00023Z-Tm
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:30:14 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e5b3dbd6732so594157276.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 09:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738863011; x=1739467811; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q6m7e5WkjKXqAzgBYgPTfbRSg36ajEe8STBwhv4A5YI=;
 b=niZum1DhaZz7vGQrXVmJLao1LQHcAvvKuvbLNuD2C+L7QDo22DslEwwrfGdLKTUM/7
 F4aUrb86U9OxX627ygaIqdONgv/R9EEJ01fnlisNlCMFpUyBoYmfuJA5sjIT5sx3XmUN
 vbimZ3nx5lsQlFOGwFhzJWTdg6RqoG8DOdugK63YA9k4vSF5rpREhfhfPd6gAmROynA3
 t4S5Bjkh/vFcCip1HLpuyXwa0hVdibvGm9jQMTsacIP8FdzyrZmze6wFIPQOKP++SgIX
 RC3AI3Cuu7DJjUEQtq2HJt8en72Tpu84jxUpXxIGtCMu3FcNX6ePXkQxjWpDoSkbLohD
 gWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738863011; x=1739467811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q6m7e5WkjKXqAzgBYgPTfbRSg36ajEe8STBwhv4A5YI=;
 b=b/9ep8qNDAlBbC9W9NakZZguVW/ViT2iLvoV+j3WduXGcA7ZCD16PRj2+Ps4SIi7Gq
 5sx+VVUOdhtYH3PclAbno8WN0fmD7hBIlwTI/085iCQP7VT2o9PJc3obNkzh40axaTbo
 j6D4jts1hCi9kjCpipyC++2qnxrzEs6BO5Q02zqaFpPnV6M30ePS+yen9oFZCdWs7ZUb
 3XuHHZ7EUiq2733K1hBcBZ0yH62jW5Wajmz7RYtHFChWVX3f0Vt1X56tpBvDh6ICwG1S
 9LkCijcKbAXHIT/Xh0BUgQ9TURClWsOB6vWT1t9YxlIuidRxWVdhwNyd3plNGlnp5qiX
 ddWQ==
X-Gm-Message-State: AOJu0YzPnEMZC6aUUNasfZIQO4AkJuc+2Ic8vsIg+OBhFR5QBGeS8gYJ
 nnQiW0ZlHa0hH3JquvL5aFBIoDwoic1p+CgvUDlj1zIL187Ls2j265NFdmpVMZsVlNM+uzpS92W
 n2flXIVuK0OGDC5/pY7a+VIPRRQ4g6Szqi9QCVQ==
X-Gm-Gg: ASbGncvlh1J50EeWXZv31L1BwpfMJdJWT8bfS/7BHakHiQfI9nvvVDTAvZbwvFKzJ7Y
 85DEamL53WA8H5/uURE/hG1gikaOhKYZ7N0D7eXWbiNyZFzeMOxsJUFfoVBu0TUzu6fIO5vppcA
 ==
X-Google-Smtp-Source: AGHT+IF51I4z8jFZfGbEsC2bz27EQD9dpMpF0yLsAD+8LDkt0RUvUENMd7qlwckXUkp6FHXFX0LBDB/52sZDYgqFNQU=
X-Received: by 2002:a05:6902:15c2:b0:e5a:b05e:4da5 with SMTP id
 3f1490d57ef6-e5b25c1431emr6154603276.43.1738863011519; Thu, 06 Feb 2025
 09:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-15-shentey@gmail.com>
In-Reply-To: <20250204092112.26957-15-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2025 17:30:00 +0000
X-Gm-Features: AWEUYZm42NKXchJXoEJvQl-vwwIzttiaru7ReU2Q-WiY6NoWEfSNZ8Bxvp52CbY
Message-ID: <CAFEAcA--TOmLJaJR98uhk+tSuZPr1eZKqsEwf2wPRAW1ypSncQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] hw/arm/fsl-imx8mp: Add Ethernet controller
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail.com> wrote:
>
> The i.MX 8M Plus SoC actually has two ethernet controllers, the usual ENET one
> and a Designware one. There is no device model for the latter, so only add the
> ENET one.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  docs/system/arm/imx8mp-evk.rst |  1 +
>  include/hw/arm/fsl-imx8mp.h    |  8 ++++++++
>  hw/arm/fsl-imx8mp.c            | 24 ++++++++++++++++++++++++
>  hw/arm/imx8mp-evk.c            |  1 +
>  hw/arm/Kconfig                 |  1 +
>  5 files changed, 35 insertions(+)
>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

