Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21CEC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGKS-0000L5-7P; Thu, 03 Jul 2025 05:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGKP-0000DJ-P9
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:34:01 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGKK-0001Jz-5j
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:34:01 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-708d90aa8f9so79395827b3.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751535234; x=1752140034; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uCRs6uZK3K2CRC7pw7CSXwwqRxaN3LfA9hJNT1msqok=;
 b=NNhbNLzJSiLWYKpk+syeuY7LQh8N2sWsTgE4GlW/TWHmNfa7LkMWf2UiZyXwSuMJhX
 /PMj9ckNzE6ZGtgraHrq3pAYCTDaaGBl93wRUS0AIj4T8PyaVHRGzJxoIZhbi/iV0Y4m
 VscD66Sa1REJCf9Iic9ru09vFUXONRMsk7veoEuXLG5VOfM6BRYu5lxb0xJG7ua5EsS5
 uiiJCO5+7YaTGOdjKHDH5lEZ6NF/K+nPeg3F/3XrBzZBywDDCwnRkK8x5OViGWRazBQz
 qIXnndf1OEIeZ/hf9BcvrnBuywT5ZOllRe2aFL3ITExRZ8G4hFhG/8jzmC1q7uZg41O+
 hAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751535234; x=1752140034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uCRs6uZK3K2CRC7pw7CSXwwqRxaN3LfA9hJNT1msqok=;
 b=kKnEUj6/dtZtpcJB+k3tM1pojLPc50MGWNAMnobYBm8qwNEWp+QzPxBMIkWOfuItyK
 n3ThnxqGF81vYscng9UJ41MMhCtWokSYsfcrNpnKCB0hckHQJkos0uwWmb8ZKdEojtO+
 ZCxJVZYabwZSSS3IG3MSSqt6cc+jMrsexgVJ0EOHQldguRHnLbGfu0paKVFF0Kr7Ruyp
 8nUV7dNmJPJaEhYgATG/8g5RVCFsMrzpebNiiNReMT8E6L9vLoIZPFD7FDyv9iFwSFXb
 pBddX/WJ3tOcc2zylCxYY8oAC1448gFX9Aam/s4sh1Sl6GCsKO0QAuZcpvIcOoN4OKaS
 rCcA==
X-Gm-Message-State: AOJu0YxVb79Q7PWrHlDawxspo80doFLsHHjUdi2ip9DMuDvT02Fe/IAZ
 4KzL0plDWpPpygXJB47IzyMvOzndLbnMNyZUY1+JMaXD8Ypqh52k0g0rbUp26+P1GWYoehBBvU8
 Z7U/W1qh1YHWVpWWNSAZ3gg0Y2TNs/z4ZnVwgSaOj8xWFJqPVXgCj
X-Gm-Gg: ASbGnct+0J3WFwv5AKm6PpAloMBiqz7+G2XLoBCAv3jyy/kOkeA4sZTPLYqAqdYhS+b
 i+g7r7+ASf4XbkIuaFltjYJnu0yQv0QafZIFL9BQWvq64dYwqecNQqLz5KYm5Py0CBWHJAUztXL
 drzOWl6/mULAvgi2RA04wZAJREJlUfwq8b0ad0BAgYm4EJ
X-Google-Smtp-Source: AGHT+IEQ8p8+v5OuDqJuTwi0wOYRV92Lwzk5hbES3GLtCdr0fImpP7dI0X2URy9wKZRJf3bZQ1z0pcIP83gruKF7A+8=
X-Received: by 2002:a05:690c:6603:b0:70f:87c5:5270 with SMTP id
 00721157ae682-7164d4ce2b0mr87500977b3.19.1751535234613; Thu, 03 Jul 2025
 02:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-16-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:33:43 +0100
X-Gm-Features: Ac12FXyAgBh8h9oXTbnUxfRt78S8acyFxDaL6OTnHm_TRpmRs1G0Xv3AVsxzSeo
Message-ID: <CAFEAcA9cmLuPfXZ3Oi8_YNsmVxi4eZwyFvmmVNDeCkV0SMgzgg@mail.gmail.com>
Subject: Re: [PATCH v3 15/97] target/arm: Implement SME2 MOVA to/from tile,
 multiple registers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Wed, 2 Jul 2025 at 13:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme.h    |  9 +++++
>  target/arm/tcg/translate.h     |  1 +
>  target/arm/tcg/sme_helper.c    | 64 ++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-a64.c |  1 +
>  target/arm/tcg/translate-sme.c | 71 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/sme.decode      | 37 ++++++++++++++++++
>  6 files changed, 183 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

