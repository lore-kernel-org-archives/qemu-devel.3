Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A56EC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 12:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUQ0z-0007gU-Tm; Thu, 18 Jul 2024 08:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUQ0x-0007YX-BV
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:13:39 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUQ0t-00011g-TQ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:13:38 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2eea8ea8c06so10925521fa.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 05:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721304814; x=1721909614; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3tpes5dxhfpKSLf56sc+8cBXu34tTXvDy19AAY0Wmsg=;
 b=eqBgNAaTSYgRvbyo2oG8BGcc5ExsqD5EoGGMqSnCRhw3XVv7dR1war4WohCPiCKmZB
 J4/vATKDMUG2m5UD6OIMnEgyHxFjUfpDEOWtFHPTMUkX7ExHaoCD86qy8vnq4+IXHCT6
 qi6AI+56R9e0tTvimOvTUej5V6BKZVdIZVPHyyGSxcVEWJBzEvHXTAgZn+cgnGR6M2X/
 Kwrbu9gWO+nU1tbpfrB305+EoYQbhNGNyMU3v0EOfTNtt2Sz644wGD12WHmr9mOvuG+y
 tScbZ3c+7KIDOlUMzzpCTv4rIGZ/jByACKH2x2Z3SYQUygtBTlsgGkD7DGw5SBAkF84o
 NQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721304814; x=1721909614;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3tpes5dxhfpKSLf56sc+8cBXu34tTXvDy19AAY0Wmsg=;
 b=mZkNP5TURE2TwUoiUFl+6GUgqHF8EvCnFCAAxHSJJ+AZaVJ7RXvEVGZbpddqrambHC
 cS8I2xpiMjUxFT0DOKIDT611RFCWIvA2sViVhMw9BftHqgCuOBCeThj7jsqUBVDdyosv
 H3mrQcORVVwEv7e6bMyXo0LOZ72fKJkps/VXyNjQgwFeCce6Z4So+MAqTe2yGdFDPWFU
 eKJJyx9SVmx/XKvhOw4VbEcgVnkhts4A0d8RL9VbBLgBsZvEPGarWzHvgDGPDM9IPM/6
 8pjkHp7O/8rDNEWWiDVpQ2WfogVW/OPSCnDwQUb5DaaTqQPPLTX9f10oIQO14iGFKYcI
 oaCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu1WNPb00gQruj/uyZeBWiGBq43rRzBiUIKpB07PD1Q2ngfu6low7hvzg4F+uNduPFb2HgoU0JjCqID5BWnK+CMePD8IE=
X-Gm-Message-State: AOJu0YxRj4IT9KezGbjmhpvqnHswCr8pJN+CC+q6E40t1dI5is9pA00z
 8FtvvzjlmkmbMyLPcEUfbyaIcmWwtSpSG8yXaR/LGkXMvNmhCwCJa6zrup2VI2aMwWosKtVchnW
 OkKIbaODp2HeqAO6+iSsXSdUKm3FZa/6G/OAQpA==
X-Google-Smtp-Source: AGHT+IF9vx+pXWBPHa6ZW6z8o7PcCyRfArPO8XEAvd7kegEcW/yb7YCad5w+mOD2cHPL+gl5oXfIn20OKXm3OV4uN5A=
X-Received: by 2002:a2e:be24:0:b0:2ee:7bed:2cf4 with SMTP id
 38308e7fff4ca-2ef05c91135mr19181041fa.23.1721304813628; Thu, 18 Jul 2024
 05:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
 <20240716-pmu-v3-5-8c7c1858a227@daynix.com>
In-Reply-To: <20240716-pmu-v3-5-8c7c1858a227@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jul 2024 13:13:11 +0100
Message-ID: <CAFEAcA-XMAhxO1Zz9vpBAL-Kf1RwrU17J21ZaaYbtbXSQNavSw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] hvf: arm: Properly disable PMU
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

On Tue, 16 Jul 2024 at 13:51, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Setting pmu property used to have no effect for hvf so fix it.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  target/arm/hvf/hvf.c | 317 ++++++++++++++++++++++++++-------------------------
>  1 file changed, 163 insertions(+), 154 deletions(-)

This patch is doing too much stuff at once. If you want to
change the API of hvf_sysreg_read(), please do that in its
own refactoring patch so it's easier to review.

thanks
-- PMM

