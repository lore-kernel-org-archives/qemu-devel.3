Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E3DC77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTjpI-00088F-4K; Mon, 23 Jun 2025 12:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTjpF-00086K-Hr
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:15:17 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTjpC-00026n-V7
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:15:17 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-70f94fe1e40so43373107b3.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 09:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750695313; x=1751300113; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1EwVq7H4nIvlJdgHTBPUOhnsZB0/hJ7ARBlef90T1qA=;
 b=MlkAE16NiCqonH4Bc+TJ25abrr0R159L9YDqAf+8U9w1mnD4ZP+DKTazBchNFa33tl
 1Kv5ji71D1254JUAooIQ6ldTMNk8tsda5hvJlgJ2tvmNcTSSx3lB8gP5CAIyhFC7MGo9
 EskUD4gGfdp5wKze/anIO/7bn9b3bFIB5L+7KjfgDeRENdJD2I6cmklqKD58K3+lJN7e
 tfkhGeaQ586VXsuO3Pln4fqo2bd2wAqAFdarPvflkjrXxsSMYwnx9lM0W5q32kzh18YF
 eF9oMXCqZCMWfU0Q7/dgZ9MZOJbEcWP+dcoEaB2uRbQ3LP84KJWFPZzQWc5Fm7Qp1dbP
 0sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750695313; x=1751300113;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1EwVq7H4nIvlJdgHTBPUOhnsZB0/hJ7ARBlef90T1qA=;
 b=mLvFz4gk/HgK2/DVs5I/J3IkkjyV6fQp0Gp398tZlaBjCAASeKTEIKwJlmcgwaxapI
 jhnNjxOzbaeEpri663UEhVOhS7HH4aBMFbCdeCzcEN2ZlHgHQ6krVAJqUeOuM88YiUVs
 tGsrYhS4yLF5pDzqQ2xs6OWuhOoE80HXLS1bGJHE98FnAaOunMuufS8bJDPZXc78rjIY
 2twlSLL1AxWWW5lCxX2axN+uKwQ7ruekn3qkZWVxNcVhEwTXEdVufAIcS/35ggzzLfkH
 jQ+2zF0KYh0Usfpm0JhijMOqS9/mgCGPG259gRTYs9Yyv+TWb3Upp8foUMUiYcVuZ8wM
 zElw==
X-Gm-Message-State: AOJu0YxwYxphBd4P9S1WO+lWbNq01wKyuMMA+u6NSumWJsXG05b9HPfL
 Cy4+GZupOmn5fucODzKe2Qt3ln2iZEdyJJiMcwVmW/TS/seu4lFA0NoIVQYWERhwgDw5E+JEbqv
 JcD6gsCgkddecD9ROnrfjxWrshZ7VYFqZmk4BUCkSHA==
X-Gm-Gg: ASbGncv7FyW+9cI0DTC1aIt8Yaa24yJu/14I4ag3ffPLTnayQ4DhSyrHCjBuA5jHiFt
 60oCpXIMvmCunnzZsmxTYwmnnUlXbzMBptdUts8G6nZdDowrOrOOrb+/+aTBST+HH4LPrP+vKm8
 +AMuV14Mky56E1Bd+gLcBA98dEkWV1TwRYzyf1oNV+Tbjh
X-Google-Smtp-Source: AGHT+IEjn+s7g60f49/hGE+E8eEJEIr+AfJ2sfD29FtpAiITF8pkmm/tAbwAteCcvYi+WjDYtJ2tzZDEK/iNASCTKcc=
X-Received: by 2002:a05:690c:fd5:b0:6f9:4c00:53ae with SMTP id
 00721157ae682-713f679eeadmr1686847b3.8.1750695312994; Mon, 23 Jun 2025
 09:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-32-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 17:15:01 +0100
X-Gm-Features: AX0GCFsBkTUTI1kDhvYKx_-mNJ1GrsqCUhoatIN69dMb_47ElWl1iCUq15glL70
Message-ID: <CAFEAcA_t-tL-P+uLrkfX19VMY1oL3A6qnUFO0Z9Nh3jzXPGi7A@mail.gmail.com>
Subject: Re: [PATCH v2 031/101] target/arm: Implement SME2 ADD/SUB (array
 results, multiple and single vector)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Sun, 22 Jun 2025 at 00:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate.h     |  2 ++
>  target/arm/tcg/translate-sme.c | 29 +++++++++++++++++++++++++++++
>  target/arm/tcg/sme.decode      | 15 +++++++++++++++
>  3 files changed, 46 insertions(+)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

