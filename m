Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B8FC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 17:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDRcM-0005bc-EE; Fri, 09 May 2025 13:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uDRcI-0005ao-JY
 for qemu-devel@nongnu.org; Fri, 09 May 2025 13:34:34 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uDRcG-0007Ve-OS
 for qemu-devel@nongnu.org; Fri, 09 May 2025 13:34:34 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e740a09eb00so2395054276.0
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746812071; x=1747416871; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5POo5JTMEcXvcliahFXEcisESlZvcsj3wN5QlvfIxSg=;
 b=yym6UKsxxHEneJlH4oLJWXQGqo8EFcSZ31AvhQJ9cyiMc7YtmNBzilExzz+CtCayHg
 Uod6aBKv5gpfQ5ZHHb/H3MUP6prWwugI+j+eYreXzI4JVB3WFZOomK/zBIvdnLyIY9L3
 oAmXMHGezsvupbvN76Ss8gqa9a//AR1DtyiaXTQFmAMLDidruhbhQQBvG8CgR3bR2Fch
 NhOcUD9q5g69RdcaIOesf7xSrZ3uk61U8FtLvAQqtN5frkcpq9nHz126KbPpqaOHWLPY
 D69Xm7sCRpKpR2416f9Taw19nU1I2UaabLdOdsJYTe2b3Tzgz90quTP5kIA5eIemNecp
 57Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746812071; x=1747416871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5POo5JTMEcXvcliahFXEcisESlZvcsj3wN5QlvfIxSg=;
 b=ddWEhuIr6Fktz9swY9l/TF7gek1SRAgevUJ6tiaZCokXfU9uCnHu98+uOiY6leK1v3
 UhA2rDyZ/3YzUCJwJoeHUIHlxWGy6z8ThVWc71M5juMTpF5VyCTd7OtlVXqjMlmtFKqq
 PPjRsRL3VzA7UaJuue/nXCHcy/u2b1/coanJHf5MjB6gnY+DQrNAi773P3wkHhvbDd0m
 m6hrIbqw9Wflif8IeFew4UFYV6vtPK9JDdUw+ui5r2joAryB8mQvPEHviOfXZVLOy0+4
 D7tNkLCr9BI/RmIC2bvpyi4onxOYFHFhz/xnvO+1Ov8FJFMyYIT6cfctARaS7+cYT1tS
 Itbg==
X-Gm-Message-State: AOJu0YzM3ZsdZgDTmHmTmBB2netNe/PKSsFYEftn+tBG9HUsJalhDNjE
 u2gRfJGlXOhDNYhGIPvItRV8yuiCoN1PZslK8qi2CuCHWTOtjFwkf9wdeq0SGwaY8Y8Qxo1Dv7L
 iSKXJDGGOxvsKW4y49coLYxjF0cRN8RJJXlfVyw==
X-Gm-Gg: ASbGncuuz6yE6ychATe5FCMh3b+EfbxtG8/yU4Rm16//PtkP2dYhbraRyrRA7zz/+Mx
 JPlrJUNJR75EsBYMuPzXmgCOcJSNQKSggjVOmJAsMeRS9nd+lXcHLmBqV6m6k/baWKJtLY2V4kf
 bxJuofuVsQz9MpsCLUGwrKEsLQe4js6GBCMA==
X-Google-Smtp-Source: AGHT+IFfu59pl3Tv3E/3PvhEg+VSUrGaAoXIvbzZyoLLZijBYOGkNqFoHbWNc9/56kcSUDeyRscaihkyFWd2SqOOb4c=
X-Received: by 2002:a05:6902:228d:b0:e78:f3ea:200b with SMTP id
 3f1490d57ef6-e78fdc71abamr5857607276.22.1746812070986; Fri, 09 May 2025
 10:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250505131130.82206-1-santimonserr@gmail.com>
In-Reply-To: <20250505131130.82206-1-santimonserr@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 May 2025 18:34:19 +0100
X-Gm-Features: ATxdqUGY75Fo6psiRVX78ErX6GDtG6GXy41vQPQSl3qZFWHKXiWnZ0GYDGLJ10A
Message-ID: <CAFEAcA_754T6Aucak+MimuaP0gO8mtUoAmq5wNj1N9oDmpa5eQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm: Replace TABs for spaces
To: Santiago Monserrat Campanello <santimonserr@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, thuth@redhat.com, 
 sw@weilnetz.de
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

On Mon, 5 May 2025 at 14:11, Santiago Monserrat Campanello
<santimonserr@gmail.com> wrote:
>
> replaced all TABs for spaces for arm code
>
> Signed-off-by: Santiago Monserrat Campanello <santimonserr@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/373
>
> ---
> replaced all tabs with spaces using vim :retab
> used 4 spaces except in some defines and comments where I tried to
> put everything alinged in the same column for better readability
>
> fixed the alignment of the previous version
> ---
>  hw/arm/omap1.c           | 1016 +++++++++++++++++++-------------------
>  hw/arm/omap_sx1.c        |    2 +-
>  hw/dma/omap_dma.c        |  334 ++++++-------
>  hw/gpio/omap_gpio.c      |   28 +-
>  hw/i2c/omap_i2c.c        |  178 +++----
>  hw/intc/omap_intc.c      |  154 +++---
>  hw/misc/omap_clk.c       |  470 +++++++++---------
>  hw/timer/pxa2xx_timer.c  |   76 +--
>  include/hw/arm/omap.h    |  534 ++++++++++----------
>  include/hw/arm/sharpsl.h |    2 +-
>  include/hw/arm/soc_dma.h |    4 +-
>  11 files changed, 1399 insertions(+), 1399 deletions(-)

Hi; thanks for this patch. As a general note, this is a really
big patch, even though it's only doing tab-to-space conversion.

If it were touching more than one kind of Arm related code
I would ask to split it up into multiple patches, but since
all of these are basically related to the same OMAP board
and it happens to apply cleanly and I can confirm it's
only changing whitespace characters and not anything else,
I've applied it to target-arm.next.

thanks
-- PMM

