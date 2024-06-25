Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F00DC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 12:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM5SF-0003tZ-9t; Tue, 25 Jun 2024 08:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5S2-0003hT-6u
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:39:12 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5S0-00026z-SA
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:39:09 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a6fbe639a76so871099666b.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 05:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719319144; x=1719923944; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dl2K5msxk4bm2KHv/0YRRmsgYy+HuefsmsPOsL7syjI=;
 b=KyYYzGoSc7dKRCk78MH8GvrWq7aiEbI91t4DJMdTQk9M6cyDpyT0u9ut1Lo+fEUm5W
 Oncn2Cta3p3mmgFe8wYdSxy9N9i6+ixqvmxKtQ3hPf7CXF1SZ6m9sTMEPf0yC+8GHiVX
 09YCLHtbog97ahe/vleiCs9DxMA5kvLjt3d4DZi3MXRmZAMToMAS0ytl5PzAIlKKMGRT
 M8ozt22lY6L80vSfVh9VOqxjs1dKe215tqsApZ79KPExrMyO85YnyDt1RFIJTXt87zkO
 nB7smrrRL9ShgBv065J+FcWrkEdNTZUUlmNEN7N+ct+xnlLoiwV1L25rSHhak/FiH6ID
 ZH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719319144; x=1719923944;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dl2K5msxk4bm2KHv/0YRRmsgYy+HuefsmsPOsL7syjI=;
 b=T81aW3y5SujKuYJ5CmSf0NhMp9+sPbrfaNaMCecjrDTyU3IdQR3KrYJnnZuWtOE+vC
 Ynpqk1ZPtVxso0bwy0nO/UPPIVeQiqLcFWPo5/zyxVRz34ew8uOh6S9YcjOLU7Z3yqNB
 0TcnGeLgENB21mrMl0e52x3NAJhBzaAMvSOZIcxPiG1Lvs+mRF7oxrkzMSn47OraTEc0
 j3YmfR/t+6InlfmyjsDxlboyxv6LTMlFso3h0knWA19UgH8zmiP/bMxmhNRCwxnRcLNn
 Z2Amml6P03nf9zGpzopyI6IU1xjoG/5a5D+mTqOhdot/IhuejNq/tx6hNg051X90RggQ
 e5TA==
X-Gm-Message-State: AOJu0YzQJiAT8B9OxLUZggH9Ng9hwh+pRl2Kx998JHZ8Mz+btznR4xB9
 JMRs9mOzZmVHntahD6R6tD0iBcFvgwbliDMqUVIgY0vrXu2cQrXf/kgwE2hOtjCeeZbxJRPmYrf
 pqGTzkHoxi+ko4C0guxZAuocEELf9IuS15zfKTymcrFXAjpxd
X-Google-Smtp-Source: AGHT+IF0WrHkxU6fmfwmDZJidw3OBcdY3kTklvR9Zlh7vnMJoEB8vEoY5R3KXfdmj7bdEGk2dgL4RkhDdOGQM8pBVLw=
X-Received: by 2002:a17:906:2b93:b0:a6f:e069:3b06 with SMTP id
 a640c23a62f3a-a6ffe3ceb11mr738604066b.21.1719319144156; Tue, 25 Jun 2024
 05:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
 <20240625050810.1475643-6-richard.henderson@linaro.org>
In-Reply-To: <20240625050810.1475643-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jun 2024 13:38:52 +0100
Message-ID: <CAFEAcA_Gp0ryBCV_yGHe9x7Jv8isbAePyNTJZ0+SD9Fkxpuz1Q@mail.gmail.com>
Subject: Re: [PATCH 05/13] target/arm: Convert SDOT, UDOT to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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

On Tue, 25 Jun 2024 at 06:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  7 +++++
>  target/arm/tcg/translate-a64.c | 54 ++++++++++++++++++----------------
>  2 files changed, 35 insertions(+), 26 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

