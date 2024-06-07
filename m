Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A789CC41513
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 13:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFZZL-0003JI-TC; Fri, 07 Jun 2024 09:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFZZK-0003Ir-5s
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:23:46 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFZZH-0000w1-VR
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:23:45 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57a20c600a7so2347788a12.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 06:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717766622; x=1718371422; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3OQ/exeS6wnx2UNmvTkCz06ie/Po5AiUQ33NK+Y/kCA=;
 b=fyPWza3vHIeeO4d4NX++3AizskRoAp7nRyxbgl7aBZeKq6HP5o+IFa08b9d+RNekcI
 GLcI8PwYIBI1iPKXFnRr/ernfZUIBtBetP94hxMW42PHJ1IXoSLQ0hC4mff2DlKnliG+
 eileOK6tAjWCg6BTefrEs9vMbvi5aLNTDBVmjIalLufBW8wYEse5/uVAtBkgnKCHaHYb
 mgEJTFDa7gRuPHJdZUqJIoiygjr071g8lqku5m20DOVNQY9bcw8yHSWoLVNlrcu+lWgK
 0SyzKG+gb4T2PZmKcEP3BhhcDHWr4OSANSX1H7jWTQ9iGzd8h/FyRBIPEXKR9a6YvxIg
 +j8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717766622; x=1718371422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3OQ/exeS6wnx2UNmvTkCz06ie/Po5AiUQ33NK+Y/kCA=;
 b=jhkRpFW2dmCrM8J40YlsG9zHMCFHM9j+oWhMcNp5z1+CxIv44t7DJWh/+U8jBEbu9l
 0UdHzOJ4TYa3Uz/9xcPVAJ3WYYHTUQGMBi18G7aEV1YNpB5XY9zfMLb8mNTC4Pp4+bh5
 8OYGzAnOnhIAB3j1k26VQdCmQGKPtsOw0RVbth4hE1GABomFIBYaxkDnUGLKEaJ/oaxP
 udmLP6uhuW0eUV7ZmHXsjkqbyUe5yb5S5utW2YzdSqpnVOv+ZrreF4JlI15Ot9MtgZrE
 4QSdRW79Cc9aYmWa0boSn8f40wYYA1irHMtrWMebmKQGpHknABOntWf2qpX2+tht7ijT
 uvDQ==
X-Gm-Message-State: AOJu0YyEWgckcFTpPshNu2vTZhVqWYDcYTRWmBbkp4AASCKj6gsQW4Bl
 wP6UWVNnQ2mDPSCimY/FiLYq8qG4jB8oZIyeBdvZUC4TrN1OiZXHLiwByawU/1VIybiDaL0z8ua
 GqlsmVRfNSVokHV1Fs3IwejO5ic2K9bhhNzMgXA==
X-Google-Smtp-Source: AGHT+IFSQHMYK7SkpdMJTwVr2WGfNVqMGjwX+O5hihkfopBIURmQjpC6JwXupN2akUWmzUI+R2jUFFGN7Zq5nh0ZbIc=
X-Received: by 2002:a50:9f83:0:b0:57c:600d:5879 with SMTP id
 4fb4d7f45d1cf-57c600d5903mr653890a12.20.1717766622127; Fri, 07 Jun 2024
 06:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240531093729.220758-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20240531093729.220758-1-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2024 14:23:31 +0100
Message-ID: <CAFEAcA9iRmfMyx-mKGgyYRFVWE6F_bAGwCVcnKzcaw_2hcSLYg@mail.gmail.com>
Subject: Re: [PATCH 0/1] hw/arm/sbsa-ref: switch to 1GHz timer frequency
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 31 May 2024 at 10:37, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> Trusted Firmware 2.11 got released, EDK2 202405 got released as well.
> Both were built for QEMU CI and proper patch is now in arm.next queue.
>
> So all requirements to move from legacy 62.5MHz to armv8.6-ready 1GHz
> frequency are fulfiled.
>
> Marcin Juszkiewicz (1):
>   hw/arm/sbsa-ref: switch to 1GHz timer frequency
>
>  hw/arm/sbsa-ref.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

