Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511DEC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 15:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuYhU-0001BA-5U; Tue, 18 Mar 2025 11:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuYhS-0001Ad-0K
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 11:17:50 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuYhQ-0000MP-8d
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 11:17:49 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e63c966fe37so3988586276.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 08:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742311066; x=1742915866; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R1SeOpDbVoflkzU0s+KaAenmYo2MGwybLQsGDksjjJM=;
 b=MsiL1iJxPCg+U7KsUyBzgRZjv8YEOk+xD2Iclk1/kz6WmYQMEAlM1TgdvAre+/fV2p
 8b5ad45t7xOueYUg22lbs99htynEK7TY5nhOz9x0MnsX7eTtrMsH54v7LeIlOhqoezl9
 o9tGl4eZtgbjdqu0e50UEWKOJQgHj3lT2MJC+qjv0QK1m/hTtHms31I8xCHQ3BEqDgX7
 yCB/84f2c/JZJZTlhHOxXc7fHicms4zyBiIM4Xs7LwRui220GueRpXnl2JuMu6e+AkTZ
 5yB0NT1M8z+0YftOQN7GFq0+yYO+2WKLoUkawXrQ0L0F4hdTXTmAel9VJN+7jn0ysnrX
 D7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742311066; x=1742915866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R1SeOpDbVoflkzU0s+KaAenmYo2MGwybLQsGDksjjJM=;
 b=KTjdGOHSVnNq7FAdRQI8n7pkc3chrxoTO4L4WFEPF3yAQYK2c2EMa0xxMuA/GZdxda
 xCaq3snnM74w1oW48pZH2Xr3slRMzhRcKaka1qLHDsMKVMHQDIyn8limxABrZRLtJzXZ
 KEHbD5DXg3gN+Qas71SDYlGzmkIPqQVRN6YfunJXz7oH/OzraHxjuV7bNkm0giEqb/vp
 GzZCoadnasr2m8tjomlVdSz1Cc+jmFJUksRIgeEzMgjEuVQPhJ2wHZnjMsjrT1I0wfV0
 ZgE0u4jE85eFTTCMZEHNHlvQ8V4uZSWZ0RM5c1EthdDiuRmI6iM/DT7DvuYi7roC9WMc
 Ct9A==
X-Gm-Message-State: AOJu0YxLbkl1b1SYHERoBHYB1kzUxkpZizDgiULUCH7EcxJbCvy8HLCc
 0C35N9xwq7p+/o1iVJyfWIVCKMY1IJuELWC6+Rgt4PiLKL9ODeoYIMtIbuQrScHUsV2CQEfdrb2
 Tncampf1J5RXKWGx/Yy6plSxTacEbgCo4pYFT8w==
X-Gm-Gg: ASbGncsuIMDfd+mdGBY4cCXSGnF9bSCZs3vmRiS756K9csBNFws9teB14epQ5oYr2E4
 Lf99AdEobNguy+B21A8662iuuWIJdURQW7aKIwss2ZNyeQAOgtEBS7xlFNh9abHnbnToYQuLL7s
 cxM4wp0GpKUrj8mUEEU7O06TXXE64tDE/XMvfk4g==
X-Google-Smtp-Source: AGHT+IHAHLxAFmAAlkXPDeNNBY/JhPSrWFDjROE0tLSnHg8e25cnjh3XuNruq9yhg28ZxECQOTJXpVeqMgnt36Q8vcA=
X-Received: by 2002:a05:6902:1690:b0:e63:cba9:4cb1 with SMTP id
 3f1490d57ef6-e64c0e3de0bmr5853823276.43.1742311066597; Tue, 18 Mar 2025
 08:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250314183224.21822-1-shentey@gmail.com>
 <20250314183224.21822-3-shentey@gmail.com>
In-Reply-To: <20250314183224.21822-3-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 15:17:34 +0000
X-Gm-Features: AQ5f1JrDc_c4PmCT954MtuWyzIvg3vsoaYMwu3dNehayyL6DNHIVHV-7zO7vAkE
Message-ID: <CAFEAcA_z8mpTgOyp+xn9pSy0p2kx_EydXBHZ4ahstg46YmArFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/arm/fsl-imx8mp: Remove unused define
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Fri, 14 Mar 2025 at 18:32, Bernhard Beschow <shentey@gmail.com> wrote:
>
> The SoC has three SPI controllers, not four. Remove the extra define of an SPI
> IRQ.
>
> Fixes: 06908a84f036 "hw/arm/fsl-imx8mp: Add SPI controllers"
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

