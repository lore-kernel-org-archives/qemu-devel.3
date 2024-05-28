Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBA6C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzLS-0005nc-ST; Tue, 28 May 2024 12:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzLR-0005mm-Db
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:06:37 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzLM-0008JI-Gc
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:06:37 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2e9819a630fso16046231fa.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716912391; x=1717517191; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EPAsQxwtwqFj58fgphhVrxwUN2PU1i5kTv4zhVy6edU=;
 b=xLNBxqnifgcWMf989huoC868+IWnfwidiqtQ9otzWg54UG7CV8U+VsS6jXmd4zFVNj
 oCYaFWyTJI/cRbItDQ3SAk8Bqj200KF6fGTb9glpp+ufuKsnqO0h1c7vT1PzMAc16cjz
 0aH+SK6591wnBzEj3yTeEe6wS0tLfdvZDIZj82ZQDr1kR07cAI0Jk/8dhLxzOFOe6Yg6
 MkZtsH7XtkURRhSNZP7taTXxVHebdbzSBwdp2F59SmXPzuoH1yjIAercf1XWKlrBA/hz
 fu/72Nj+UhoKwnN6pUslaKEOgUC+aa1cnUqxYh3Qrvx/Z83EiuxQo9NYNuvoKB+L/H6Z
 M0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912391; x=1717517191;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EPAsQxwtwqFj58fgphhVrxwUN2PU1i5kTv4zhVy6edU=;
 b=f7RWCfgNWNLYL9xGfMKRzNcTrCjTMZb6CNPuUoMnh/zam5w83Ytt/4YaFWmRajtlsy
 wRObr+W12AyP9p2ikzLOaVpITV0yOBZwaBKwu8fBHvw0P1ntYYWbfbneC/UKz2Yby3CZ
 /ebMZkGAukPYEOXJNYCvTgeoEVtJfROzwKNI3zzoXGOmOJM+P8rTpmbw8qBK9LX+0Len
 ZiNeG0MUBXN3oORq8bkc+zRLfKPO1VDZeNOlvFu3xb1oqrv4dRDwp48yhCn0tYhZNDOj
 kFlw8Y97Vet5dvo6+fyGcO2CSMUQ3nFoK0j5Fy7YqIoR1dBc7rDQZN3RPW2kcz5CDAcH
 BoVg==
X-Gm-Message-State: AOJu0Yz8Rv36sjUHizPiJjIj2d5DL1FXvfLhicqXLO7XBiBOv7me+i4r
 bp5soBtimUBqwXzLtTWwiwp+vB0GT5AX8wfU6IqunUvI9VQksi9twdqEVjHvNgrAo3oTKE7dYVY
 CqMDL879smM8mvB9UgaAbEPCsu/D/v76LU+Omzw==
X-Google-Smtp-Source: AGHT+IEB+qXWSCxvnqnUevMg8IUn66JSbNL//x1uxZ3D+rUTJZiH10x+/tsoC3q45px6A0b1GFiIVu4lsXB4LJlN48U=
X-Received: by 2002:a2e:a261:0:b0:2d8:d972:67e3 with SMTP id
 38308e7fff4ca-2e95b0416c9mr94995351fa.5.1716912390700; Tue, 28 May 2024
 09:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-63-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-63-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 17:06:20 +0100
Message-ID: <CAFEAcA9LO1fdU4tMBPGxFeF=m=AoPZ5XJnYMWqs7YjRisY7w8w@mail.gmail.com>
Subject: Re: [PATCH v2 62/67] target/arm: Convert MUL, PMUL to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Sat, 25 May 2024 at 00:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  5 ++++
>  target/arm/tcg/translate-a64.c | 51 +++++++++++++---------------------
>  2 files changed, 25 insertions(+), 31 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

