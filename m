Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F66DC02191
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPit-0006NQ-1n; Mon, 27 Jan 2025 09:04:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPig-0006Bk-7w
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:04:07 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPie-00008n-Io
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:04:05 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e580d6211c8so7210406276.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 06:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737986643; x=1738591443; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1FTkJX742cJ5hI9w7nJZdyeHNqnv3M72LDBFIiWbAI=;
 b=BCLv2sq2/M6TFhhxD6AG2m7msOX8rJSqH6Ds5bKAP5eTV/YHU7rgAILmnNLYxX8IWs
 8w7Fg9JA5j5uz5k3qv11fAjziN79U4zVDCd0yD1LJawsq3zZ1b9r5SxNWUCKHg5JzoZY
 mVAO8EBL0f+pByzDMmb+Xq0jpr1bVVO56gBB115jxsm4SOrSSjnGw2LYrqQMkJCJ0TER
 uCb/q8E8Iv9GaPK83fVH61zyYNHRGm2p2qJGJfdmrJ02mweqKvT1UwrLOU6xfF6Q5XGA
 XBuESS1M/kt+0D0ttd06DyPCroFysSBJ2nBJKHw1wWmIcPXI3vRI4+lPAAodtO4raSgJ
 ccTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737986643; x=1738591443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M1FTkJX742cJ5hI9w7nJZdyeHNqnv3M72LDBFIiWbAI=;
 b=OdvGCqD6kHH2Eu7QYrXxaLr8GEAe2YV9xRb9TKQy9yeoLktSC6TNB+Ml710UMxA5ud
 wX4gEq5aIbPNUYBRyBd0Oj7b7iqs1x/JTyjREHYm/EMIInRpcRWRaO4Z1hz4hg+RuSSP
 0Yx9nsBytA7VhSS7Zkn3CJ/dg3wyJNgV8qmJVHPubNggwyHvpn6bta5oOqfF0B4h2A7O
 y3rAEu3mPkm1LhihK7S1mn+K6ao0/L6l08gCllm73xwjnsAkGYjufswbfsnjNw8KYZzH
 nEZRNxSG359GwbU4LLRTUkZd3ApPwlcW43MSj7sdDZfPz8zrxR0/9ocsAY8F4C1hk7DM
 ZQDA==
X-Gm-Message-State: AOJu0YyobyE3yk+Bu83bMfUhAzdwH17gxpHkxN+7NosQQQhNzG16eE1Q
 eIvmUFpx5Sl9cKKYFMnM9Iy3CbJpYcJJCoL5vZIpIQQ9p8qHnjd1PLSKXi929EEGLnyt6UCGQC8
 lTKf3tQR4s610R7N47mwo0EXprIJuNzbJP3k+ew==
X-Gm-Gg: ASbGncuD64l9o9oF3pY2TbBa5fHxY4Rprc6Eg1REPN4HQrmFXtDt24up2wu7f4nvEsk
 9IxLLE5qqPABHpxaOVZIoBsY1KCZ0zGfYUHBZJ69SvVWs6Vfu3NySHwPoukNCgPk=
X-Google-Smtp-Source: AGHT+IGF2sYuobLF97zVeqpPwAHZwswud+AkN7QhWW2AIqEVH79PjLVTDpyG0TCegLQNtpBIWOW+Xw5pdwP/XyYqzFc=
X-Received: by 2002:a05:6902:110d:b0:e57:99a0:eda6 with SMTP id
 3f1490d57ef6-e57b1096d49mr29509636276.25.1737986643328; Mon, 27 Jan 2025
 06:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20250110160204.74997-1-philmd@linaro.org>
 <20250110160204.74997-5-philmd@linaro.org>
In-Reply-To: <20250110160204.74997-5-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 14:03:52 +0000
X-Gm-Features: AWEUYZnsLylrvmb8yTwMS3XNj2gcBiEWwfbqmRjnlBWRGfbmV02-Y_p0ACZyjL4
Message-ID: <CAFEAcA_oK3Osfu+6vWDRPO3b2ufPn=04BO_zR=aw9-iJk38D7g@mail.gmail.com>
Subject: Re: [PATCH 4/9] hw/arm/stellaris: Replace magic numbers by definitions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Fri, 10 Jan 2025 at 16:02, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Add definitions for the number of controllers.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

