Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42685C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGac-00088Y-07; Thu, 03 Jul 2025 05:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGZs-0007Nv-Hp
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:50:04 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGZr-0000V7-1y
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:50:00 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-70b4e497d96so56108237b3.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751536196; x=1752140996; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BJoVjilzB6RDEDJ9vIifAy8Oz9jiJnzPiIAOzFxI3Hc=;
 b=tlRIa2K2a6rLwxrXErN+xkNthl4me4tAkHKK+qhEJ88yuaIEcHBSaLnbF3S/CdxUq1
 Kk8ZiV0+LxeZfukEbTOT2Ikuykmod8zlW390xz6aF3ryxweG9PvhSqROW/GTY7pjZbLI
 bF6BAuqxFgN+DCNBic3XVBwCPqkxtQKA/zXhGZpoWpgI3pix3rSApiUHQS5cE+jUtUV7
 FZ+eI5iK9efixP0OVYDX6DmG4i55yaMEcf/J3cxUA6yYprBmzLHd4wgPX7An6GIhNNsX
 cF78ru9LH2gJ3UgZzPXYAuozXVAnpVjmP3SapIcblHY5GvSD3Bg1PWf7CLRJleyBIDBu
 RIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751536197; x=1752140997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BJoVjilzB6RDEDJ9vIifAy8Oz9jiJnzPiIAOzFxI3Hc=;
 b=aTUhhTAxZAt6BTf1DBSJcvugWyJwdJtem5dF1QwuRsDe8mVZI5wPQfIXdq35mck5zx
 NgUTQ+Fh1KQ0uehMbvO5AC4fmTLs1BMJ5HhqmfLFmmnqEcmrWycXCtNsVkxOkXoY5jut
 arr/wL+x0+GIsq9WiGAb6wiK1MHRAsTjKLb0DwRe1pSkwa8JD1hmR0dUQlgpB7EPrIEO
 HQXkK8MfT2F9f0xzijp6ulIqY7KzONcTxOdPf5cwG6oohcx6q5eVcNEjr6TB8m28MFvh
 Sk1mJQkKOOVCsp6WsJ+JQ/1LF9E57vYvHN7sNPWrNIzxHAMqq+WOwqd+0sX4KtsKKB7M
 oSfw==
X-Gm-Message-State: AOJu0YxVw74eh06PztTCPIHWhzz0QxViOZGd0Ah71NCg/d3H2LHzhwTt
 hLrhPTWXh/KK2f+zuTzXk++fWkJRQTW54/DlQo1x84lLBNKa672ZmNp89oCssAocEmc2WIwWRex
 E3JVGwGQ+9MkDm7a/WuR4D/HWSeattHih7YFQTmsdtg==
X-Gm-Gg: ASbGncs0Q7WSUslhcneL8yMcLRT4bhmMjySSkIqpc9rNBFcY4OtD1upVFK/EMpgtYUW
 gh0mhzih8vVblzyOfCZIt2qnahgHwQHmDchwXP8tzL+gjOgu38PMfpG5FFMkg4T8WHPhjfbs+0F
 DRp3SeUGSKF7oQYKbInpz64tYuoKvtFu0c9oM9ZMzGEt67
X-Google-Smtp-Source: AGHT+IHg4uYoh4QYsU50lPGbMZXdAiYp65FQ3yFFRhnQ6zjh0uhoYWmWksvgO1300uUq2S+9gbBX3PCThemEzObKWs0=
X-Received: by 2002:a05:690c:39c:b0:70e:29d2:fb96 with SMTP id
 00721157ae682-7164d4d235emr81444997b3.36.1751536196721; Thu, 03 Jul 2025
 02:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-35-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-35-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:49:45 +0100
X-Gm-Features: Ac12FXxG9xC4wpk-tr_kpRZXRDXu99AVOry-PtXFoShv8dYom1LOJlUdJtkNFKE
Message-ID: <CAFEAcA91g2j53UaSO241GQnt=3qM1Rcufg_84Q5uYvgdxT1OJA@mail.gmail.com>
Subject: Re: [PATCH v3 34/97] target/arm: Implement SDOT,
 UDOT (2-way) for SME2/SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Wed, 2 Jul 2025 at 13:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 10 ++++++++++
>  target/arm/tcg/sve.decode      |  8 +++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

