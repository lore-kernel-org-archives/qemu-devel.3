Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE88C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJ04-0006vW-Kg; Thu, 03 Jul 2025 08:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJ01-0006rv-Ro
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:25:09 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXIzz-0004ZR-Hx
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:25:09 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e81cf6103a6so5519070276.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751545503; x=1752150303; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9y4NiBnyY+L3VyKqidewsL1aw100XTtHWrS2Ux/0R6s=;
 b=hoKbclEse41I4C4pq4/NEjzoFM9LAh5FJ1YxiXWZlFoflQG916mEVerD/iDyJq4eqb
 jhFYEUTFRFeS9jc4xxvIcK6tE6PHQPMEa3KZOpTFrl6K3wOmOoeeP64dYSlmm1zArnZW
 k/777ekp2abD4UGl+a46EnHkcrgRCa1xcV1SBdXTnZjmswdnMPDJQXKhOl1sQUb0Tndp
 8LcZaWWsfjcfBrJFhkEHAYYT4UyBW+8vVpVpss18YGTY83We9waC4RNx5Fm2KrX5rqGY
 ntRquKki7Kx34YRfv3XD6Gnb+zDLn5MADYz7dsA6/Im6g9Obx2t1+COAe9DpnIIUCbyE
 UKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751545503; x=1752150303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9y4NiBnyY+L3VyKqidewsL1aw100XTtHWrS2Ux/0R6s=;
 b=SAQGwCG9Ou8Hf/+NQZAVVY45L9MN+Yarsq9A+vLk5vMbJI6py0P99fGzG3Jj7FwIWl
 8pUhAtkl+pcsO8OIj1BGhifJdO6vLrztG52i3gLmF/Op0A/gxtI+Z8ti0pAFIXrglbBl
 7HFIW0fAIln4xRGYXBOtA2u2/JHDwHts1WDk05ENgff/LrDzvvg757O1bhnxqcvsv0Vd
 o2I7d90xOZoJZ/8n2GTHmoFypS4e0rlCWVpsngnzUBwBGELkwOXMgUiG0BmXBKgDEGKR
 CWU08V3yJvHnj63iSwMSgMMyrzq7q4AXDLB/J0TyaallEEPMd38IEBG7kW1cxIxTI6/g
 Z3GQ==
X-Gm-Message-State: AOJu0YwKAAoVWOdS6PUOO2LbU770NMX48B0K2t/dLYEyHbJz/cDIgfgu
 t0mmsav1VMArAdLUfVnzY4KeDx3sZdk8+XvocAUDCu9GAuOg1leNK5F+r7lXqdjM4HByy/T9RG5
 Y4YKEVGr+33AuqImOfB2Y7w+LoCJG2xv57UF3BIBJoA==
X-Gm-Gg: ASbGncuUBhp7cARC3U5kVdW0FaRqg1dkWhOfArzPouvtTLyD/3aHTC09uadxV0NN/vZ
 edzvMxKR5yywknHKMLl8xlDy+Btz24At66OaGbGLyTP4F2btXBfzWCFSWxnTreaGCh1ivqvrbDY
 o6vAFfpA6n8SNHu9L5e7aN67afCgmPJ+8XUschSx9pweKP
X-Google-Smtp-Source: AGHT+IEbk7HA8frNJJ5ZGS9/4KLUar8BearNvJz/7aJaMV1Cw9Z0tt2gC/0qYoVY6OdWImUL6ndloRVYkX8/oDG1BcA=
X-Received: by 2002:a05:690c:6ac6:b0:6fb:1e5a:fcdd with SMTP id
 00721157ae682-716590c00f3mr42292507b3.17.1751545503272; Thu, 03 Jul 2025
 05:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-76-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-76-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:24:51 +0100
X-Gm-Features: Ac12FXzv8DzG79qI5VHevu1JcQhvIVaeNXDNhZLwOrrgZEsQHR8tWFT0TL0lG48
Message-ID: <CAFEAcA9hQZKvuu1So4PO1djg9ECn+s3nzwh3BdytkKX7uXWk+g@mail.gmail.com>
Subject: Re: [PATCH v3 75/97] target/arm: Implement BFMLSLB{L,
 T} for SME2/SVE2p1
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 30 ++++++++++++++++++++++++++++++
>  target/arm/tcg/sve.decode      |  6 ++++++
>  2 files changed, 36 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

