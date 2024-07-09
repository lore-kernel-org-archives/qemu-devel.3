Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF732C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBir-0008Oj-4C; Tue, 09 Jul 2024 10:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRBip-0008HF-Fg
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:21:35 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRBin-0001mh-SP
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:21:35 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5957040e32aso426048a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 07:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720534891; x=1721139691; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1fGY3akIwGrvyq9NDRbjhvoDxrybtYmpnbWhqEBK9oA=;
 b=tNHrNz2vR/Sr0C0/6Lkq9l6wmmAIix3lLNPgMSTzBqv2trO2X8as4jDdKshDjkTsL2
 OzUGcirjAZlc7/McbXgN7CK3Udb0TfsCrWTyyTQCzu0yUsycwqRf3GXzWeQ8bbA0VEWL
 B2hnN7LxFIVQYY3nsJBt48n2iR2/e6r5N9s9M4at+VRXWsQdZ+V+vG501jPmwW3DHknp
 zLzWHQsoMjL/NGyPezCzdEKJaWgXcFMTs19jZh5IyWleO9nbS9/sTcNhQffYMXrg1S2M
 E9l5sHkIw5PEKSjhPLeVbg6qaGUiLEVU9+KQONBBoVodB0efY5Oy/5xZfEVqcS+hXfZG
 qjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720534891; x=1721139691;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1fGY3akIwGrvyq9NDRbjhvoDxrybtYmpnbWhqEBK9oA=;
 b=Y2vXbADJFGUQHPMx8qU7ydoEER3UuOwx6nFTAYbyVSTEVovT7TstTRZh6PekW5qOUw
 xpomfnDAEuiNbrO8rriWz8f6XIAg9AP2xlo4YBs6LyjI6VEK67vnAIJhtwKaNGDXGcRh
 HZtB9XjXaKaafn/AHORZ8nupxstcrePbXch93UHKHm6L2JoqL8n+n9FeWephB2yx0qxW
 xhVPztHJ7R8s0+H6qdHDi7viy8iW3vrke9wfM0I9SFf7DMW4LrBYZXz9l2yD1vcGCj/B
 X8oOOLMQZKk6DPP7/76dbzq1WdZ4fSKNn4jBYJ14xMWOV5xdFQMYDIQe0JsqREONCi5U
 SCKQ==
X-Gm-Message-State: AOJu0YypVfMHiFP5fq4HW61VCJSLDhh+EQr9stKg6ig3aUhNUdJhfukP
 EuxeoDZwcaLCKgzEeS58YB4dowS198rUIN/1auFqk7cohLAZHcbUkA7+p15qore9gJ5jcIn655C
 0Bg9DBiRsjevw5JUV029/tHCwgr0EOFJFN7HhLg==
X-Google-Smtp-Source: AGHT+IH8C2UWuj2lNdlw1Ww5r6rDnuTrWPrcYLREy/2L4xokNyCoEOIXX95piXIAGL1j3QxUr4s4bpIjtpBYNC17qKw=
X-Received: by 2002:a50:d61d:0:b0:57c:6ade:d8f5 with SMTP id
 4fb4d7f45d1cf-594bb67f905mr2115949a12.21.1720534891072; Tue, 09 Jul 2024
 07:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240709000610.382391-1-richard.henderson@linaro.org>
 <20240709000610.382391-4-richard.henderson@linaro.org>
In-Reply-To: <20240709000610.382391-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jul 2024 15:21:20 +0100
Message-ID: <CAFEAcA94h70Spf8Y6eOuYpxYUtsTvkzga7vK0ZMg_YEC8X0Sgg@mail.gmail.com>
Subject: Re: [PATCH 3/6] target/arm: Convert SQDMULL, SQDMLAL,
 SQDMLSL to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 9 Jul 2024 at 01:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 604 ++++++---------------------------
>  target/arm/tcg/a64.decode      |  33 ++
>  2 files changed, 138 insertions(+), 499 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

