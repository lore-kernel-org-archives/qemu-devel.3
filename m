Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A4DC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 11:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA6mS-0003gG-Ch; Thu, 23 May 2024 07:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA6mQ-0003fg-1B
 for qemu-devel@nongnu.org; Thu, 23 May 2024 07:38:42 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA6mO-0006DS-2Q
 for qemu-devel@nongnu.org; Thu, 23 May 2024 07:38:41 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a5a2c05006aso588096266b.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 04:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716464318; x=1717069118; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W1puet64s5158zwEXqnlgcBncY+3lTT8aH2pqomzJVs=;
 b=UF7v5eB7nhup9SmZSS4PX6mDxnFGTCb1X/ggLdfzFLnXAIihRX6/t1kE+P0MKYr0fc
 CRkNab/uBe0eI1WVI8x1g2vle8k8B2Mea18NRVHIkfxJO7SWvWTwyI+MhkGuVklm6hbi
 Di2gIQ3Zvoc2vyKY2gy9Ce3Gi+TlK65IfyrJJ1IAQytUVHJ1iQPZXLHB1m18YzHUIOl5
 1Ck7sO+o7LYivrI1Fdz49k4RQPJhmfgEKzKmIOVUaRWA8G/IaKCBin7IoBk4Hluquhdy
 bGr2hZ5p2E3F4Efz2hd59rKuE0jdKPBloxL+yOkVIhIcrj7mkbiA2f5eynw2whvZ01dh
 Ha9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716464318; x=1717069118;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W1puet64s5158zwEXqnlgcBncY+3lTT8aH2pqomzJVs=;
 b=eFTMqN//wiYPfROqU4HwQjYjuG+Rzr7pbogZ6JiW92EV1Myh6KgT66LxjezRvJIWEu
 uznOB+sx0ncZKr+nIL6yRf8qYLe5VSlvUsJD7qeYnTBch4kIipsD+avE9POOmFR2bXBV
 djxDRh3JKeg/7VQxRCBAuUeRXrGEOp342Z0+47JreRwF3QdFXowa0eeh+/ed2AqyTraC
 SFkDMF1k2fjHTnO/GI9PBePuUsqWG9yL3bjmDm2tvpr88apwXp/O4ynoa1R9TWYPUVNr
 TjaNqg4v77tF6FOg958cGGDNNWW1jIO6V0eiOvWNxH3Eq/jAP2Z2DAz9wYJ6vfHvTDY7
 A+PQ==
X-Gm-Message-State: AOJu0YwDv2l0PuBpd4endYbRgQPZSIZUJDCy9o7ydnZNh7q/Y9+BuZ3K
 T8JtElCsPecXONX4ooXPmYMPl9tSguh3Tqaz7UzpKKBwjBhQUVIV4Hy/4aKuM1s5J5r5QiUnUWm
 8dqZqXYndaH7LJzpP959qSqi2hQj34tXZvWz0kQ==
X-Google-Smtp-Source: AGHT+IHHTGroORM+yofUT6YrqaOXJufINYAORqskWhIPrrciEoHVs/yCyHRsSZY0RrA0iTbtbIPe3H/v1azDQaTH/bA=
X-Received: by 2002:a50:a6ce:0:b0:56e:10d3:85e3 with SMTP id
 4fb4d7f45d1cf-57832a4a1fcmr3759879a12.13.1716464318196; Thu, 23 May 2024
 04:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-15-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 12:38:27 +0100
Message-ID: <CAFEAcA9Y3MDSN_sUmcNe7U6W2rPyDKMyp97N+0cdX+skbLTHLw@mail.gmail.com>
Subject: Re: [PATCH 14/57] target/arm: Convert FMAX, FMIN, FMAXNM,
 FMINNM to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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

On Mon, 6 May 2024 at 02:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h            |   4 +
>  target/arm/tcg/a64.decode      |  17 ++++
>  target/arm/tcg/translate-a64.c | 168 +++++++++++++++++----------------
>  target/arm/tcg/vec_helper.c    |   4 +
>  4 files changed, 113 insertions(+), 80 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

