Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8C5C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhWe-0007hh-Dv; Fri, 04 Jul 2025 10:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXhPr-0003wc-3D
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:30 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXhPp-0002Qu-60
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:26 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70e302191a3so8513297b3.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639364; x=1752244164; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dRfmkDbLrA59GuUWCAywJEKAaWpY98qWlZc6eOmxwAg=;
 b=ihenKZ+8Y3WU9PxcXYnI5n6ae1lNzq2c2NV/qJCbI44NnHXcDOLMu3+HNTgK1KToa9
 GaasWYATumpHpo0eOfH9m5bGcRhzo49QW/QSpzrtHUnpnQrCtOXvBqbhC4vEzquHqscF
 M9MZuICAsbdzDBxXtAIRW9r8Qw4H8xmXS7wXy2s+O1ZEN34Xe6OZZFEYRy4vtVx1hvUW
 EHZN2fVei69Q4gPO54p1RvLhp3z0/QUK/e47QMQFYhyBD12AZcCrsd/w+A7Bsh4+sB16
 LZRQUPzSzFv5Bzz1LNEsPldz8mJLvO4W1UhfE+P4jIvVMAhSkQHgRtZJgAk6MIXcMYFp
 h1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639364; x=1752244164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dRfmkDbLrA59GuUWCAywJEKAaWpY98qWlZc6eOmxwAg=;
 b=S1atkIB4BTkzrYuGj6HhnrtkRl88yqrmQ7SCrpQ9CRN9UeIeTdmYLqT84E1WJwGJfY
 aRZuf5ae47+5rvHXMfSy1wLNtd48qku8OTpx2mc3IT5UGHrT3u2fqlH6svEXwzbqTy8/
 1BItA8nRk0j+Lj51Ilnj1wK8YKuTax0ppvTZ/zpnGKNVwpfvqpFPTiasY28j0xq8F6Nf
 ZZ+VOZlo57GR/LxhfIHIjpJ6OHTP8ly5VNYSxqM50mPxIZnJW5xUZP0edGON2iSVPvbe
 r2MM7M23G1meRmQQW1oXM0ZVYsF7IfTslxGmMkgUwfaKpVI5HnMXicc3J87WcG3uIXpJ
 MT7g==
X-Gm-Message-State: AOJu0YzkD/fVz3Nw9ASLljqUb280CP8S6zDFdn66GOjRTybGx9wy7NYE
 dxLaNRIBN9xFYj2Ti7gNxrNlxEnUYXFM2/bm/zTngVrjtYCsPez68NXwPjen1920uCrUk/vGktR
 zQNTn2H/pkFVzMLuc2hFKXUmcwM4rOaAve0rjDEmM/i+pvH/SUxD9
X-Gm-Gg: ASbGnctJD15AIctv0FvBEN5QFTsHIGecs9ir7KPXY5xcV0HfKDL8BL1DLYSFSzZ9tMi
 7uFlpU69caKxeQ1bHw31GypNUpQf7csBHmnNSf0V25yw9bjAh9ClVP63pXaG1OAhpOVKWeWIhG1
 Q7Aum5E0GMvgYp4AJUc1OS9GhaUhMYVo4Di21JyA8Mv2vY
X-Google-Smtp-Source: AGHT+IFkhE2OOqcd9GBkT6E67/3hrQwTumGWOFAc5mWQ8y83vy8SIhaHoacnHxnwKRiui8lsoFg+KZZl0PRZ+W6iIE0=
X-Received: by 2002:a05:690c:4a09:b0:712:36f3:f6d7 with SMTP id
 00721157ae682-71668d50981mr38642547b3.32.1751639363920; Fri, 04 Jul 2025
 07:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
 <20250704142112.1018902-65-richard.henderson@linaro.org>
In-Reply-To: <20250704142112.1018902-65-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 15:29:12 +0100
X-Gm-Features: Ac12FXxvjUw5enBaaOU5ncZ2PSieAGRN1-VlL1Y3B8xK9vIzfvslxdsIbeqWOag
Message-ID: <CAFEAcA_zJZu9yutdeeDZmPcYLyrknxzgb61rYS+nb_=NbL=toQ@mail.gmail.com>
Subject: Re: [PATCH v4 064/108] target/arm: Implement SME2 SQRSHR, UQRSHR,
 SQRSHRN
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 4 Jul 2025 at 15:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme.h    |  20 ++++++
>  target/arm/tcg/sme_helper.c    | 120 +++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sme.c |  33 +++++++++
>  target/arm/tcg/sme.decode      |  37 ++++++++++
>  4 files changed, 210 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

