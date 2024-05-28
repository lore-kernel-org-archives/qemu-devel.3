Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C412CC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzDI-00017N-35; Tue, 28 May 2024 11:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzDG-00016z-T4
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:58:10 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzDF-0007E3-1J
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:58:10 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57864327f6eso1710225a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716911887; x=1717516687; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AxkRlXyboYQiQ3E/mkfizR+uQU7sfvCB/zKya05Q66s=;
 b=lW5ArVJINV8XOHIczcfdgWGhxH/Y1jpZQYMEfegPojjM3HhOTCB3KW2v52Tr330p3R
 gDEQcUlKUsajZfJI2WtOFQxEA23SBN0LEFYtZemQibc6ANiCIeKdUr4lv1r0oJf2zsqc
 EtKZLL4mNvUGbmPAKFdnQpd6E7a3V7WqoTDYTY5f0jyH3nNAXhPpssbf9IF+PHJwmJr9
 5//MJvR2WA62IkPnimdxU4y2quWleP6uLghQz9Me88v0IODy96dvv5mhloQu3+gwT//T
 nYjHTBRkP8OMBZfTDPbO/iQkEQc+a+I0M4KrEXCmjycLkY7vf+gGcEg9nGFJ2IYgxtlv
 4wtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911887; x=1717516687;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AxkRlXyboYQiQ3E/mkfizR+uQU7sfvCB/zKya05Q66s=;
 b=HmLAWeaclsJ6kDyC/UnfnDZiitDxQk/sdt1lwIdz9sIpJ533RUswFEZJRjmMSrPRRN
 dzstDSKE7QHbLo6AUcS5NmVpKQ2zo+h0xGxFFmvTVKucdB799n+1LU8qi8gw55Zh113x
 5FAI2AopHXkB1AG97mrycrlzVkbC6ebTUH+sfc6j9ATnAf48M/A/S8HujVI91AYGR4fK
 jut88w6QsiUVY1iTbGZfmRaML842BEIY9y3bSgT2xzI8HCQlsq6UeJYE0y7nLpP5sLPk
 2OAHKET6fWbQiQOazJM5JLRRVVXETSItFhi8c+BU/vFXDgIr/wakxMeurtrx3ZcsxwYc
 adaA==
X-Gm-Message-State: AOJu0YxpPzDDfZYa/SH0YYdFWBWKX1jS4AnE1wTtvgXQqfxFZc03PlNq
 nSQMdKTd8eecpKghUnLoKWvVrumn3k5eqNsIg4+GXMflDgE1UOtJknL5332UOmTgKy+kVPh4YdL
 gOgf4DqjMgvF8e2mGdr1ZRTWoQAifQKUekIx20A==
X-Google-Smtp-Source: AGHT+IF+8asxMgp0YPtRxSYUP11J/MlZsTsE4LfmkJBXDenERdib/4LWT0oq3/90mohf2Ba6D5KQCcYBKBa/imwn91s=
X-Received: by 2002:a50:9fef:0:b0:579:cd1c:8d69 with SMTP id
 4fb4d7f45d1cf-579cd1c8dc9mr6414835a12.2.1716911887488; Tue, 28 May 2024
 08:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-52-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-52-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 16:57:56 +0100
Message-ID: <CAFEAcA9zF0ch_0onhH+O=K9mf8e6MjzzNUZFrJX4x5jLmK1Y1Q@mail.gmail.com>
Subject: Re: [PATCH v2 51/67] target/arm: Convert CMGT, CMHI, CMGE, CMHS,
 CMTST, CMEQ to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Sat, 25 May 2024 at 00:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  12 +++
>  target/arm/tcg/translate-a64.c | 132 ++++++++++++---------------------
>  2 files changed, 60 insertions(+), 84 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

