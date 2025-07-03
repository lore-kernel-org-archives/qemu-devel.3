Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F62C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJLO-0005Hx-GG; Thu, 03 Jul 2025 08:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJKq-0004wN-Iq
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:46:42 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJKl-0006Iy-Mi
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:46:40 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e819ebc3144so7054824276.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751546794; x=1752151594; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JOrJCOIUmEfP2olDRNnMPHIJRSmlp6Zlg1mW5NE6H3U=;
 b=g/5+PhCm1TzSR0MJ1VTQe4x14GBQ0x3Ba5Y8PK/Oi4pGk2rEky+YiHnF9HHWyo1n9m
 yo5wlTk627UAvDzKNqZkbVYKSJtVxq4sBdBNaVYY2jbfyMFT68QuKuGr0BiG5L9nB6iJ
 Sg+uI4FLUE1FR90AenALnJtjqN/WO2XUDIdmxifMnDiGR/+ya3PqlBqszdTUaVrVzc8e
 UJfsOTgH7WS/IzQISNaNfpb6YisjUsQh2NHrrco+whP49ElJ1xYXjrqLqiMINdbX+h/f
 umnCDdhYjg54o7HjiBaEJ1Bz+Krfxe8FIJUc2ybhNTzq2+Zte3RvKwC2HRbGA8mlcsZe
 61QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751546794; x=1752151594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JOrJCOIUmEfP2olDRNnMPHIJRSmlp6Zlg1mW5NE6H3U=;
 b=oIwu/t128pXvVupI75xBTOOlXhSf8JoiAdkN0xrSnkHnPCX78xevFxuc9lKK4Ei5+B
 RnxMf3Hak0lxEK3RVXVGRBDDXU0uTyjxy/EPyAlG6NWBM794geb097xzWd7jbrmWIk+i
 pmqH94zA2sEGWKX2ZOtRaYp3GdfHPlfiItk9Y501DwcKxV1SRA8oGTFjJ+RaNeZA12V1
 kpgQDEDfjPsYdBOtqqLVmlInYmQMWX7OSOgQJc+vZ5uPk986ow4BDQ8thWbma8AFyKKa
 sEp1F91KWGJuYWbDqdkb96F02XzktU6RhGSrH4PPqltiBDtDRTDsccFRDmHD07Btd0vp
 cVHw==
X-Gm-Message-State: AOJu0YzQplE4HUlk8fjI86AZAxDwrppeiB9qejwALpIcvM70sW1zwupU
 8QWEeniCpk81egYhwLSKNRrl8EuGOI5ntDw7yuw6p60z/e5pC3P819TFssdj2IQnnu+f+p5lTbt
 9XLx2cmJfsEXQ0xLuOaa+dIxpW5EXGsh5BKCXX3NAOrFa6ROn+Es3
X-Gm-Gg: ASbGncuOq9EAhY9Pg7tC9MRs9iM/DLOKiOTNV+EFqE4YSf+IvsUITMljwBM8vcyg2hg
 nf9NlEFuf6NWcQjvP20kECLhefShBdWSb2vonPte4Tanz+7zoHP26x9UMaEdqrdDthtZEErr8Q8
 nKL5He2/zQzS+wmbPDt9Gcy3Bfd5s24vQsMRobXFmZmv4AwV4qKRj+eH4=
X-Google-Smtp-Source: AGHT+IG/qg1ZJnlea9Hw1WczgU3GcAX69Jtcl8c1cBg2Gbj8Vybx0eZtGyIQKXSFcg5w9Org4iMxNDH7203eefuZqFY=
X-Received: by 2002:a05:690c:692:b0:712:d70b:45e2 with SMTP id
 00721157ae682-7165a32017bmr43067677b3.6.1751546794246; Thu, 03 Jul 2025
 05:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-96-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-96-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:46:22 +0100
X-Gm-Features: Ac12FXw4WirIZaBkfODPplx9uKHRpMjDzmXVdom_D86T3DVnye7DIPBNkXik0Ig
Message-ID: <CAFEAcA8CjHXd8D8V4vWyvprBG+xGDOgRmMkWJ0eR4jDHqD-3pQ@mail.gmail.com>
Subject: Re: [PATCH v3 95/97] target/arm: Enable FEAT_SME2p1 on -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Wed, 2 Jul 2025 at 13:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/cpu64.c        | 10 ++++++++--
>  docs/system/arm/emulation.rst |  6 ++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

