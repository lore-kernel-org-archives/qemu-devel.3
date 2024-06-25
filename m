Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9BAC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 12:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM5Vh-0008A7-I5; Tue, 25 Jun 2024 08:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5Vf-00088Q-6l
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:42:55 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5Vc-0002kg-7X
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:42:54 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57d1679ee83so5862663a12.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 05:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719319371; x=1719924171; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O3cpO3qXhbMQm7k/PhVcN62CjCTZxGPYGZ1giKfA2vQ=;
 b=NvpCT7O579q96Jri3zYsNhriFUfvb0g1LMr6MSD2Ln6dxJz+t+lyX9FTtEGRFksaR7
 G4EC0TTldo5lGzMHZiQNQRF2iWrTZWfevV7YRNIgOgwHAwHiBHkUKcdaDphdyZewNvCb
 s0dzkyix1u4kQXaoLGaiQPNakTZWUcdz8TRj1x1fy+ZARdQbQh5PzZeHJH0P7WoRCD3C
 H/Ajt+yPW5jZ9FiZmtzMXkXSCyltshR2ooMmeXASpbtljJBZiE/HrNk1YadHIihTKJ6F
 yompIA3O/Gux0WRT5iTdvCIOK6QDFbUjojTahRSw0WOIJYLOVYtGQNLmfOPYCna4es1W
 7O5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719319371; x=1719924171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O3cpO3qXhbMQm7k/PhVcN62CjCTZxGPYGZ1giKfA2vQ=;
 b=B2bymzW5ME9HBy/Uc3FlLpxwxcemflruZDLGMifYPOW19iUguF1gJlEpqK/2Z326Du
 slopnZydwuq42qm//9kbd8fslBWQJSD9fyD2ocJ05uwVbBLygNj/urMH2TTHsoxwm+Eq
 5t5J9DIFHea1NG0i5Uf7YlPzbhp9pEAhuIJ2LAhgqiQ2nyHZ6uVBhs5nlyiGVxoF0xOj
 WeRaFbN9vSKBpeJcuhP766cYSBrx4f1QcbhkUEgSmt3ngeBjBNv/ieZO8A6XCp/YvcdP
 f8XVCL2evLsJFHcmm4tvj/iF2VvbS4IYIHGdc1bj4p9o4psFAHGuNt03Vkcvb1YN8D6+
 GqKw==
X-Gm-Message-State: AOJu0Yy7T1d3BK7hC/BCqXIaQF9U9wWUhbGKLUN4e9pmSHE6O1XxuspV
 SfxJbD24Ijg8ojLbRJzx3wVoS5mtc14PLAsLomRrDXF8xiOvW42lR6WuniyzfRANVUbYM2bsGBM
 ygA9BEh1sn+6XJyhR9ZyTNemonVba8yg5q9cEjQ==
X-Google-Smtp-Source: AGHT+IG3iVBRsqlpI7pbtfi+fiAyV9BWtGs4qXAIje/vy74QagF3DOvn1Tw+JoIE+MTIKRktXUIvvKyYy1QylybJlG8=
X-Received: by 2002:a50:d7d4:0:b0:57c:7599:2c67 with SMTP id
 4fb4d7f45d1cf-57d4580ac7dmr5703583a12.37.1719319370780; Tue, 25 Jun 2024
 05:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
 <20240625050810.1475643-10-richard.henderson@linaro.org>
In-Reply-To: <20240625050810.1475643-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jun 2024 13:42:39 +0100
Message-ID: <CAFEAcA_ZRTK4fbG82qyDHBZizAqrW1-uWO1QMpqftoC5vTfjhg@mail.gmail.com>
Subject: Re: [PATCH 09/13] target/arm: Convert BFMMLA, SMMLA, UMMLA,
 USMMLA to decodetree
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

On Tue, 25 Jun 2024 at 06:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  4 ++++
>  target/arm/tcg/translate-a64.c | 36 ++++++++--------------------------
>  2 files changed, 12 insertions(+), 28 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

