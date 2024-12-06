Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6B7E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJaZX-0007j3-I3; Fri, 06 Dec 2024 10:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJaZW-0007ic-38
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:48:50 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJaZU-0004YV-J2
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:48:49 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa1e6ecd353so344257066b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733500127; x=1734104927; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zPDeiSKvlp7ZsGCVwtVsVzirelDNE8iSGotP76xLW/A=;
 b=PODCtuBuoOT1P+8j5pckqeU7bx9ZpBubIcOFM3Fub6ZhcJB2aS+kbscaw6cmfK/Zfz
 2VUF+/71sYRwMuD9opHqdY3VJcydTVjIV71e/weSOiYah56DYhutnvow2AAuilDc7yQ3
 GXM7OmUdNvJjx9ZeOqwzyUxbTTX5y4GLeg6TAMGPVfQp+mnLfKIHhKSVKokCk+8Sx9s7
 JQfJU/+7MoDeN542kfzAVkQKkPGMMq9OSNTYeE6EqdQCws8LP9Dy6wSBQnPHyHBHwKaZ
 Gf8EohAO2foWzTplQgDySTskVG2jwXn3056zHkF/s+59KJ/0HhoUmFFv1n7FazOuxtZS
 6FfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733500127; x=1734104927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zPDeiSKvlp7ZsGCVwtVsVzirelDNE8iSGotP76xLW/A=;
 b=pxpFLBgL538zZIKTxk+WYpe6POAdEUKq53L7soIKXIF1PMx5q0u0BOEf/T7qI2BwxI
 PkEMc6I8oYU0nCXhGV4x8Mw8XgEcfSrZUZCVybyTic1//OhFYIUnBaIOi919lKr6yCna
 i4/FV/fi/aizko810Xms+4FEWmC+e3U3tKDjEQOV0jQ0CmSU+MzNpeL1I840oazSXTQ6
 pNRIScG8/ihryaPTpD/DAUbnTAA9NkuvXWZ98MNA93DbxSapjPI9ATOmz/8UKEvgOQk2
 3MmRTnfwH/Z+xt3C5krEbpEwDaZbkNOlNvqFOpZ9Aao1hU3RuHfJXZZ7M7xhdBwLDZnR
 BH5A==
X-Gm-Message-State: AOJu0Yw3I7z7uJEXZSGJfP+wXSPiUhyuMtmvY53alcFS9YuZ+OLwajjZ
 Jq/lxlyjWFDwXrhcN18kgW2FkRbYC/Lks2tdpCV3/XMQx/aF6+GhJKWpoTxU4TnQXXXhVjqcz/8
 JmmX6OgZM4F09e1fbYD5L1oHxrCvREnj/V2x7MtRwxmridi/J
X-Gm-Gg: ASbGncteHcwloBdt6h2JoBM84Zm8OMqhuP79HbwBclSHHWKA0LyfiPLPxgQq909xGr5
 o0OS6wvuOR37ZHZ63FaTCcCcxvLPs61hJ
X-Google-Smtp-Source: AGHT+IGXSlLY31nyG8wSAblK3Am3F6EbI4lJu41HOdvKC9CKmrrl5vgnVZrON5k9ld7kyb921vJN8j4OiAkh3mily7U=
X-Received: by 2002:a05:6402:915:b0:5cf:dfaf:d5f2 with SMTP id
 4fb4d7f45d1cf-5d3be67fe69mr8362816a12.9.1733500126961; Fri, 06 Dec 2024
 07:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-50-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-50-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 15:48:36 +0000
Message-ID: <CAFEAcA8n+48haqQW2-bbr-ALPvLQ6fWEyGYSwL2ui6kmYSETLg@mail.gmail.com>
Subject: Re: [PATCH 49/67] target/arm: Convert FCVTN, BFCVTN to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

On Sun, 1 Dec 2024 at 15:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 89 ++++++++++++++++++----------------
>  target/arm/tcg/a64.decode      |  5 ++
>  2 files changed, 52 insertions(+), 42 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

