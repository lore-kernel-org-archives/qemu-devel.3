Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2702C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByzn-0004Wv-Ia; Tue, 28 May 2024 11:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sByzm-0004WV-FX
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:44:14 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sByzk-0005F5-VN
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:44:14 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-578517c7ae9so1277266a12.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716911051; x=1717515851; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V2q2i7zwo4mEfT0+WBGQxi8ttG4P3870svhH27NYzWg=;
 b=ErsJncMVELFJRfeotPgHSe06cjVeVG1o1Xx/9uT1h58oRuZ3cuqMAzMJsPQksjvjKA
 scx8qSz/eLRQjFoR40FScmKdlouZpVNj/PmcyyiBw1/MRE9tQq2dL72+Akt+gFgdoMQY
 EZ5goWUspb0vdyhX3N1He29pHcLzj4EixVr12CCoYFWo2V5cSLdNs5NMLgVzSZYy5BMp
 4IqOgUAPS7SpnNkhYXJ9QiSQHzUKBUYBKTNCj1IDLxQybQyqJlgZku10u3dhJrjFTvsu
 gv8iB3ZcDcGfb9Kk7tJJ8Qno8GlVVLV/3+jJ/iNvCVeFEqmd1Hz1L4jkpuyXJGx7XrwW
 F9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911051; x=1717515851;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V2q2i7zwo4mEfT0+WBGQxi8ttG4P3870svhH27NYzWg=;
 b=HzLi76Bhib9XJn/YthppGYv3nWzzO2QuEaqaFf6IFrXonylLr4gnRObstGLd/GJjbN
 wfbMb6HRioNY3RT4yLH0itMC5IwouRMtZbflj10TeTk29MfL/0YI7LP20FjKG+7pXdig
 WZB2KAU89WYu4AbnhMzB/t8l4XYwyvjbH0I2TvJ4Mo4Uj3OaczHBhSPx8R5DvESF0h3d
 nbAcbL5+2aiywJq7zpuS9MQBZWul18kVBxahhGvUy1hl6W+d01eenD/9XlhS/1H3WNOE
 GgMaZpm4spA1Bpi0Oe/6/4wvmgXg7LDu4cjORDHYMcKjjLcT9Jo4cPEy/SiFA8sYnvxW
 QSvg==
X-Gm-Message-State: AOJu0YwipoYcB0i1ceylAlRMIagUA2+A4AbR3ggyMsq2aX+u/8egkcbv
 ft3BOG/EP/5tzPRF68oQTuEjAD0ksApzHkSO7IVZc53y12ybPRtV6qgoApJZ4YZ71LzkK5XT62y
 KuNHHlBThna5tNUHTkFXzIR6/ue6atAm2KSDhaA==
X-Google-Smtp-Source: AGHT+IFFG+mA7NRm0zPLrINTn9CpLTlkQ+ZK9efZhknAZyOZVV7u5QNIxACi9Dl6Gpu6vS3bQGPcazJVPxakhP7Ab4I=
X-Received: by 2002:a50:d78b:0:b0:575:c1a:494b with SMTP id
 4fb4d7f45d1cf-578518e9aa6mr8257086a12.9.1716911051545; Tue, 28 May 2024
 08:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-42-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-42-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 16:44:00 +0100
Message-ID: <CAFEAcA80d43uX4bEq+RFQ2gHhQrcRx5WLhx3hZhZeafjhW1zWA@mail.gmail.com>
Subject: Re: [PATCH v2 41/67] target/arm: Convert SQADD, SQSUB, UQADD, UQSUB
 to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Sat, 25 May 2024 at 00:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  11 ++++
>  target/arm/tcg/translate-a64.c | 100 +++++++++++++++++++--------------
>  2 files changed, 68 insertions(+), 43 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

