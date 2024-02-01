Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F395C48291
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 14:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVXv5-0005uC-Gv; Thu, 01 Feb 2024 09:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVXv0-0005t0-T5
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 09:19:54 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVXuz-0000d9-E6
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 09:19:54 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55ef4a66008so1028588a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 06:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706797191; x=1707401991; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RgAyJhoJGNs6a1y3AJdOMnoQBlZetfOAd7uE86D3ig4=;
 b=XObDb4y4CMMTE+7glKXcVcGauc2CAm/jxVuWIeRhtKl2LN1e3qaVwo2Ptr/rIw64uw
 xdPTww+EBUfKf7bj8Xac2wGPZDm0c6UXQUltm/4pacczPbM/GLAmDZYXa45IE5yAXd2I
 J6Ewb/+eEWPP1X9dPxwu76XkeAWbgcL7iichY6vBaKt45ekga1JN2ZunsBMxbRDs5wxu
 oQyWw3815wVg1MRDyKP/G2SkdfEMuK10wbHsEZBiH6N5FJuy+p9vB0cmPrDpXPIsmB79
 mZRMvbsFYYPvOLoXZolee0eI2JZz24N4NIfoxrt+3L4cr0YGhHFso4KsfKQlTq6mkS/W
 w7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706797191; x=1707401991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RgAyJhoJGNs6a1y3AJdOMnoQBlZetfOAd7uE86D3ig4=;
 b=YInqsJbp/r7EIqZ/mruz4gp8mDgrSMiHr4o4/FJJDPDpEtmemmwL0YDEe682U7xar+
 FqZbTjvZ1V0iT4hwEy8QQAgN3gQnMpPHdGt3PuLl94zcSNAFzI6wDJHBAwevgb1HJMzy
 G+xr9tRCpLJPRZMB54Q3I0jfuS0wuW1jFUHjq/npVXS+0vPwqh+22MxTcD+ljKhxIkLZ
 3Oc3tDi6OyUlVqDijYeN02o/AyDLZttWpZo3F4HWujp7X5qC3R/TO9yFij0Q24fydcsV
 aRXkGCrTuOHdeABFRyEHUYEJx1To6W+REul8Gts201UVTbf2Gk49S29nXfndAzYpurjz
 TpFg==
X-Gm-Message-State: AOJu0Yy9ArfgJ8DzGGUihlCJWoFgELCSMCQmvdDAe7Ik5O57UUI3U98Q
 co8uWI/ubtfNZEs6XfEMwXNEu0CrFq1IKzfRSOqTSMfPHUDkGGJm6/WnnwfSxg7OPeJZ5HBjM5G
 xertF7i2ECpys0pgJnM4Sz5gUuZLcw698DNCCUA==
X-Google-Smtp-Source: AGHT+IHBSIiuT3C/JCPmW20kDEF8tniqyAdp3gSi1s1e5DxDNR3uzzDsg/igXBtC+RiaYCI5L3F/R8hBbLj02jGqdHc=
X-Received: by 2002:aa7:d391:0:b0:55f:217d:9651 with SMTP id
 x17-20020aa7d391000000b0055f217d9651mr4107485edq.22.1706797191483; Thu, 01
 Feb 2024 06:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20240129081835.137726-1-thuth@redhat.com>
 <20240129081835.137726-3-thuth@redhat.com>
In-Reply-To: <20240129081835.137726-3-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 14:19:40 +0000
Message-ID: <CAFEAcA-yL8BAdtkF2xaWJOeFPUWRoBbuvPSEeorwjyei3oFjDQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] target/arm/tcg/m_helper.c: Include the full
 helpers only with CONFIG_ARM_V7M
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 29 Jan 2024 at 08:18, Thomas Huth <thuth@redhat.com> wrote:
>
> If CONFIG_ARM_V7M is not set, we don't want to include the full-fledged
> helper functions that require additional functions for linking. The
> reduced set of the linux-user functions works fine as stubs in this
> case, so change the #ifdef statement accordingly.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/arm/tcg/m_helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
> index d1f1e02acc..a5a6e96fc3 100644
> --- a/target/arm/tcg/m_helper.c
> +++ b/target/arm/tcg/m_helper.c
> @@ -22,6 +22,7 @@
>  #endif
>  #if !defined(CONFIG_USER_ONLY)
>  #include "hw/intc/armv7m_nvic.h"
> +#include CONFIG_DEVICES
>  #endif
>
>  static void v7m_msr_xpsr(CPUARMState *env, uint32_t mask,
> @@ -69,7 +70,7 @@ uint32_t arm_v7m_mrs_control(CPUARMState *env, uint32_t secure)
>      return value;
>  }
>
> -#ifdef CONFIG_USER_ONLY
> +#if defined(CONFIG_USER_ONLY) || !defined(CONFIG_ARM_V7M)

This looks a bit odd. If we don't have CONFIG_ARM_V7M
why are we compiling this file at all?

>
>  void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
>  {

thanks
-- PMM

