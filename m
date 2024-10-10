Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1881CF11D2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 11:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syrkn-0004yU-3M; Thu, 10 Oct 2024 07:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syrkk-0004xa-UY
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 07:54:46 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syrkf-0001j2-LU
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 07:54:46 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c721803a89so1020640a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 04:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728561279; x=1729166079; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8Sns7xsmeqPOQZ2N1m+ivw76fAsG/Ttx25YK//ondvE=;
 b=JEDybLoMSzhl63Pc+FOtdunQ07ozoPjHjnVE23/5maX321gKG53kT3PmyMS7YaIcdX
 paGlsC+o/jUfxS3aIyGSwoQT45HRanXyB9d5Lp0i21h7kYL5tww2TUXHNxuHv7jvFrzY
 YLcfjyPWhsilL6lPtroGP5tohId++ERmtqQc4nkPyf25blvJDgnLoBu7e89XXYEMldwh
 TUV4QWI2h8+gHi21tc8uothEasUOW0k5wNthzRweq7O+QYbODEeDxSbV5GfjCfHgfyjK
 zpO6mJQkM9GIC1Mxzp9HoEPuce8LL1soUfMaH/8p0j6GuZXvaGmAOGrDp6u+U1GXRajC
 fVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728561279; x=1729166079;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Sns7xsmeqPOQZ2N1m+ivw76fAsG/Ttx25YK//ondvE=;
 b=Q8VFq6i1+Of8Ykwejbz39Kh4O1W1stKYBv1nT4i5oGt2v8NCUquTJ+TMjwRjiQZrzW
 3QiTcSmQMDvTkFmoN0zitgX+5IiJ99C2iFEPteHVUZCNNzOfejDGH367j7Zal0gIdwMD
 t0gpdaXvLpzO1haQGWg0/EhAx1KLh/WdOavj1leJGhrT3xeCaJIg18nVtQlTD8o7qzNO
 ixdferdqJ07at4JLcLWrNb7dcW62OK2w7mGnArZJ6BMWoo4SAgpWy7ziDMqQT43SPKM8
 4QsoSJoeu9vNMWdhWAhO84X/Tf0Mgiwq9SzcYbgbdAGgIAmQSMhjAowqSoZ6oM9Esb58
 fJNg==
X-Gm-Message-State: AOJu0Yw61uSH/fzpPq8EQiKJzjJl+D7qm9OIgn76C++xGt8C1nvkyaxc
 /Z3FgjC7o4XVtVCwP06yGuDaALgEhGIMVrhdwwXEo0gV483E/Zfu5skD8XrFDdRIYiOXpD5whm2
 IiqIv3Khmjg4rO4s+SAzVrSTz7ZEf9S+VjYB5iw==
X-Google-Smtp-Source: AGHT+IHlzPdpIM+xZafDveyx5hFZBh1GFLt91YGTshVGwJuewegfJ0kE6/lX8niCegw6R1ub6TjBDm7VFgL5A3dgYr4=
X-Received: by 2002:a05:6402:3513:b0:5c8:79fa:2e3e with SMTP id
 4fb4d7f45d1cf-5c91d6fc258mr5034904a12.28.1728561278443; Thu, 10 Oct 2024
 04:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241009000453.315652-1-richard.henderson@linaro.org>
 <20241009000453.315652-20-richard.henderson@linaro.org>
In-Reply-To: <20241009000453.315652-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Oct 2024 12:54:27 +0100
Message-ID: <CAFEAcA-azLR3SdjR6_+aJ0EkWW97mQukacHABHxWj+b7mQ0OxQ@mail.gmail.com>
Subject: Re: [PATCH v3 19/20] target/arm: Implement TCGCPUOps.tlb_fill_align
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 9 Oct 2024 at 01:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Fill in the tlb_fill_align hook.  Handle alignment not due to
> memory type, since that's no longer handled by generic code.
> Pass memop to get_phys_addr.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h      |  6 ++---
>  target/arm/cpu.c            |  2 +-
>  target/arm/tcg/cpu-v7m.c    |  2 +-
>  target/arm/tcg/tlb_helper.c | 49 ++++++++++++++-----------------------
>  4 files changed, 24 insertions(+), 35 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

