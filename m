Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3000CC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 13:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCI0m-0000Mp-MH; Tue, 06 May 2025 09:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCI0f-0000Fl-2w
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:06:57 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCI0a-00051n-PY
 for qemu-devel@nongnu.org; Tue, 06 May 2025 09:06:56 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e6a8aa771e8so4834874276.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 06:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746536811; x=1747141611; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MFL8h9OK56pPCur2whn/ND/7yU5L9Xfqr7/GYOhvy/c=;
 b=c8b56l0ICBrNnk7f/40/spD4iT8+VKAaVdawBh7hdxkSu7zGXFRpyt++DOKlShHGwD
 x1AyRnFxS4/Fg8aUXqapx99bHNvX8uw822vwx4s1nujG+iFdk45FluOg4JwoG5MidT3U
 fE1zvP0JTSuaXKDAtglta4DElJdrqLiVfJ5G/lGasiXVkBKC3JjnWku6eiJBBdANYFef
 l5VnT3QoMr+XMtV8EPXkCMDYMLHuURP6drADVbrzGbvoEhMttTzoyEOZTcj32IPrktgS
 Qd8GXUHynJthgyKRb+wbbgKdbP8NGYNhClBqiiwN2Dr9i0qRmTHi9PcBJbteVb5vF3bD
 fIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536811; x=1747141611;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MFL8h9OK56pPCur2whn/ND/7yU5L9Xfqr7/GYOhvy/c=;
 b=MFAcNek/sU1RV8pEKKYrPTXqxQf4AKwf/JJjMRtvardsWK6aUTBRQ+ZHkAtFO+bRXf
 tHkUa1dO1baxsu+v2chIq2zsRiA3WsqgenfxMglfDmB59VaTTSspYaeX+LgP1IKJrNHl
 aDMxyJaH/iHIOeMbz3PNYrdu9hLDYysorcpOYYddR8EGZ7d+0mTpDxy/pSyXZ4B+8nmo
 WvePuRY24hWaDWj1a3hvfAU6jbt9+egrDdp0jOqqUIlC18TTe/XhPe2rjaatTMicbd74
 OV5HxuwjMh8OwbPexMzkjhC0EhlqOUdcMphEUGaKLpRDhHZtd5ywJRjFSyCbT8YmCwD1
 UMew==
X-Gm-Message-State: AOJu0YxCHpgSZOYSqOQY0ON0ERm1Ar6Nd6gAWA0KUi+JPOyd2JxI3uQ5
 FUlZiYjRllGhhskWzRC5E9OboHfjHbfPqoAAoG19rRCQDzq9uJbf4aGAxkKbZrGsKevgzsyuOPL
 JNC96KcCIF/ERdBaH+DGtrGa5E5JQo8yUOqKmUA==
X-Gm-Gg: ASbGncsPSSu4TqB0zV/ktpIJyTUoE7VtYL9m0ZQK4si/Ahv635pn5sO5YJ5/pyCEC+V
 dqMx4GhKmj7j9DceRztWIE5Y9TgbJwFj46YBTT2UvAGczIBKN/MY4nIYltEK/zFeJjAEyqvd6gM
 pe221Epd75Szs05L77Bq51iRo=
X-Google-Smtp-Source: AGHT+IG/hDQRb2sL4bylOchtdUxU+kuA2WyMO0y/lggQNY/NSyNZ9CLDfp2M9C6tRImVenRz/mewCl0L3218aF3InXA=
X-Received: by 2002:a05:6902:1407:b0:e73:59f:fdf7 with SMTP id
 3f1490d57ef6-e7565537649mr21599200276.2.1746536810832; Tue, 06 May 2025
 06:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250501183445.2389-1-shentey@gmail.com>
In-Reply-To: <20250501183445.2389-1-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 May 2025 14:06:39 +0100
X-Gm-Features: ATxdqUGrZ26QVIjn1QuUSbg2IG90rnN_ZpK2eGmSzLoL8MnBjZFKWTKp21fySAU
Message-ID: <CAFEAcA98Rvcj8j7e68gfpKLnr-hDu+15Ky0mtqsrHktv2T83Ow@mail.gmail.com>
Subject: Re: [PATCH 0/3] i.MX fixes
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Thu, 1 May 2025 at 19:34, Bernhard Beschow <shentey@gmail.com> wrote:
>
> This series contains two bug fixes related to i.MX SoCs, plus one cosmetic
> change. The first fix adresses a bug in the Designware PCIe bridge that just
> got introduced in the 10.1 development cycle, the other one fixes a bug in the
> i.MX GPIO controller which existed since its introduction.
>
> Bernhard Beschow (3):
>   hw/pci-host/designware: Remove unused include
>   hw/pci-host/designware: Fix viewport configuration
>   hw/gpio/imx_gpio: Fix interpretation of GDIR polarity



Applied to target-arm.next, thanks.

-- PMM

