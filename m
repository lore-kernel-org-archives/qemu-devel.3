Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91E5C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBywa-00015Z-Eo; Tue, 28 May 2024 11:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBywY-00014r-IJ
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:40:54 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBywX-0004xF-24
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:40:54 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f462so1218333a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716910850; x=1717515650; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZzTPYtNfMgt9HPWeQJTgfsmYru0kbJvbA6DJB+4g/ok=;
 b=dAH8tFCW7khyCYwL5iRgrOTY6e2kYGbrSdZmCl0DbRBhaO9p3xXHz8u9OjXGU2EPmX
 Q+XNq06khf7MuYSEqupsQNKYjIBnYVNtxql1oRQZDNGPdZkW6XGRn+xMaIn7PGs26YrB
 LvZD77z1i/DeSitp9OjWUVk17eQTkL0wy44LAnHed21NmQhJskExA/UnrctBM4z279QZ
 77iPqQJHdEvhM53lJsBUBd3YVNmlnQB3mdJyAv0HyAcFVb+aupv516GNgomkIWLN/nwD
 RcXNS7vTf1xa9P++vlEAs5dfgb+kdDQLpIdhAjCdCI6d6xmYoEBisHAnuXTIe2oGWcvc
 NodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716910850; x=1717515650;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZzTPYtNfMgt9HPWeQJTgfsmYru0kbJvbA6DJB+4g/ok=;
 b=pj0XKU4iBucLcF7tYh1MBkgBocon8dAsnkw//BKsUsU9zXFPswLhgs8fjnTLQ8+OJb
 P1olG4goo4gTCTRZkSY3gLL6p3OOt86XEsHRxNsqL/ItBIiYIyniLgzmgRij2pHPnJGt
 vltY581UMm/wmAUs2vpFRFuy7FvWb8qCyTagMmlFD/L2sCnG1YV5yza8T5eZOPkUjyJj
 ZVbKvOamBr6CTncejoeVJ1F8gkLtNbEc1HUQxq1onotTPM7MMlk9ZZd1X5k1GwTiCaeT
 KInmcFOO7NP2wfg1DtbDWh2r2qAbi2UIfSaFC0HUwUq9PrTIAsoGGVj6btjWGZQvdz6U
 pYww==
X-Gm-Message-State: AOJu0YwFOfAS8wIsDiLd/oED4luJdzD+Ss3aEbWjvkedf1e4m9y9e33n
 15xCgU86zALrd+fpex4L1Vhm8Odpp5LOwrB8ONU3VSGxwUt4j6nBPLo6EMip5MAyUYeWCUKo2Ya
 6QCzxPZ4aU2fRioA72RrIYifiWKidA3EPdmonNA==
X-Google-Smtp-Source: AGHT+IEMgCsdhjIvfFwPf+M1UX0AMEznrHjI+L6lGt7DjWlzxE5DGDlbWCDqm6X8ZQLxy8PtlHwy/xOfBMzzYsra0X4=
X-Received: by 2002:a50:cdce:0:b0:579:f196:45ac with SMTP id
 4fb4d7f45d1cf-579f196473cmr1516180a12.7.1716910849666; Tue, 28 May 2024
 08:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-40-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-40-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 16:40:38 +0100
Message-ID: <CAFEAcA-rxn-Kkq9JKs6h4r6mHp3anAsohYcrfJw95ET6EFk5tw@mail.gmail.com>
Subject: Re: [PATCH v2 39/67] target/arm: Inline scalar SUQADD and USQADD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Sat, 25 May 2024 at 00:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This eliminates the last uses of these neon helpers.
> Incorporate the MO_64 expanders as an option to the vector expander.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h            |   8 --
>  target/arm/tcg/translate-a64.h |   8 ++
>  target/arm/tcg/gengvec64.c     |  71 ++++++++++++++
>  target/arm/tcg/neon_helper.c   | 165 ---------------------------------
>  target/arm/tcg/translate-a64.c |  73 +++++----------
>  5 files changed, 103 insertions(+), 222 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

