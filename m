Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C397CCD5BA8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 10:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm9hr-0001xZ-Ic; Thu, 05 Sep 2024 06:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sm9hq-0001wk-A4
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 06:27:14 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sm9ho-0007I2-Dj
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 06:27:14 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2f4f24263acso11123841fa.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 03:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725532030; x=1726136830; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+B1EfBOMHYHAZB5h4exHvi88VPzs2y2vW7dtloYIbbo=;
 b=ZUGigbrg6NEfyf3P/qjI3cB/m8lnIZMkFWM2AnRLLRWXYSdTUjcobD8tz44sXN6VZE
 bhrPWVRY+qSL/+60N332AdldS9BKA0neA4QrIedvWiitfc/fMYITyEe2Nx/YqX5miQzX
 Hgrq0spUhvS3+Bb1q2jf0IflYbS7WRJnrNAUgqBhvVWTRAaMV9+VxhVD+p1KjTN8Ufp9
 gMrZ6Lpx4jElYk0O63XCIuZnUxYbbgkw8dce7i+XsscSezjjGegEijxwctVAXSljrQII
 LQrIz3fNcsC3btbrpW5E4TqwAiETaZntZBbiLwQ7t3UndPGx5v3deWMUQi3OK/R4ZLIg
 bLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725532030; x=1726136830;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+B1EfBOMHYHAZB5h4exHvi88VPzs2y2vW7dtloYIbbo=;
 b=QqkwOXNXHU0FoQTtepn4xdBSnikyx4fTxwuFDVDcIQQQMRhzJentA7c76RTA7xwQp1
 1hL1CgEabgX7RiH+u2Z1UO4daIy/24NlN9IEzlIuHvWgdYTbANYkL4+pya1jqXoCm1Xh
 Hs1DYv67QRV1HM7m+kW2WkPsJjB+x9DUA3iRcI81KDvN07WKZK8iwKxDErM88S1fN4tq
 nH8LqO8GeLLJdt1Olm5iEjNo/OHZW4h7RWyvQmZxhlP4SgTNANSlc2mo0BeHNGiYVc6S
 XJdHKZj2ZWwt3whgpnium4IewtyZe7VbgYBnIJwI3pC5BH44slrVp5pj8d5Ax5/OrVCn
 feIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ0u6z8Jt7QfLWdLyzSHRlAggxOWleVq/CxtE57aDN/PeHIWLm1PIATg0Up1ncR6WTkn3uqJ0K6ABm@nongnu.org
X-Gm-Message-State: AOJu0YwHyc+rb86eHTTtX65s2CO5+Qf+wHB5emqtc0F7IYUbK2sJ9U26
 V40MDtRp05terQxgHH8rFuoTvXl2NMIO5sA7LDVMLfnBOPWcaJBgZBi9FqU4RKiFM6S3r1IxhS6
 KNBFjjs/5+w2eKeqVaubWr8CZbSmpUGkjqkAQtA==
X-Google-Smtp-Source: AGHT+IGFNv5Pr9qXTFDQI3NWo0SORws1NQn8oojf2UHchdVf07R6HrdguAyncGOzAd0CeL2oK/iWYoHSoBghkfQmj5o=
X-Received: by 2002:a05:651c:220e:b0:2f3:e2fd:aae0 with SMTP id
 38308e7fff4ca-2f6105c4b9cmr227483211fa.6.1725532029849; Thu, 05 Sep 2024
 03:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240904101445.4127-1-deller@kernel.org>
In-Reply-To: <20240904101445.4127-1-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Sep 2024 11:26:59 +0100
Message-ID: <CAFEAcA_jdPn=8tT_oBDfyiBwKpMuwOWfj-if5xzJ1oQ2XH=gDA@mail.gmail.com>
Subject: Re: [PULL 0/2] Hppa v9.1 fixes patches
To: deller@kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 deller@gmx.de
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Wed, 4 Sept 2024 at 11:14, <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The following changes since commit fd1952d814da738ed107e05583b3e02ac11e88ff:
>
>   Update version for v9.1.0 release (2024-09-03 09:18:26 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/hdeller/qemu-hppa.git tags/hppa-v9.1-fixes-pull-request
>
> for you to fetch changes up to d33d3adb573794903380e03e767e06470514cefe:
>
>   target/hppa: Fix random 32-bit linux-user crashes (2024-09-03 22:08:22 +0200)
>
> ----------------------------------------------------------------
> hppa target fixes
>
> Two important patches for the hppa target which missed qemu-v9.1:
> - One fix for random linux-user crashes
> - One fix for random issues due to loosing the division V-bit
>   during delivery of hardware interrupts. This triggers all sorts
>   of random faults when running in system mode.
>
> Helge
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

