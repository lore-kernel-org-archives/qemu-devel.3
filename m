Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382CDE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJFfg-0003Xu-Ck; Thu, 05 Dec 2024 12:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJFff-0003XK-3Z
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:29:47 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJFfd-0002ko-Ku
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:29:46 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434a766b475so12084665e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 09:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733419784; x=1734024584; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bFGgK1p+XckRKimAjQg/rIk3yfNBLaJvo7hC4EBr6oI=;
 b=GUd72Kfp5zhNfJ856ugVs1wTgktwOZp/YkoFDgt1uqrgzYlNV+5xNx02F6+pRjpokd
 2dVKo292wcH4wc1IT8eSr6DM4zeEaLK0yQQkQty50QufXDRoAGot7ksB3vob+t7rnUJ6
 /4nq+YId7tNJMPvdabZp5bKeRP+wwzI2De3GkuR7+VsUPH2dEgTf/a37FrFqAl3nnYb5
 GVeit7Qg9+hYQSzzhDVOrBFJ0thFBhvWpmGv1XpSKcMjfdG1TQfzk/wGJf2v0EOrGrkn
 A66gpG/lEP+zmzB87ikkxfsU70m9N+KbAA5MkJXmgeAZy4p81viBx23xy3eaU/5oRAig
 dG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733419784; x=1734024584;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bFGgK1p+XckRKimAjQg/rIk3yfNBLaJvo7hC4EBr6oI=;
 b=tRd1F4ui2kZyof8Y/bclZqlwjSq0moDt9tXO6sHOkGFHV7aDXYclpcwgWOxjxBlEiR
 jHidSyWUVluZzsndd49vgalpNpplk2xTbpW1QuXInGEsqoEA6iPz7kTZLyDrTL0IefWE
 Y/7LNQTAOkhOSnT2yuAMlMay8gvcr3t8gRbKKmHqFVLRhTAKKicsciVGQsHhBA9C8xPW
 4ysmo2N2K0F9oBcPPyGrUjO6hp9Y91EFL8eIXjRqm0+OrfdPmxksyfTzEN+OtIcwmurI
 aSAi2Kox9pw7jJmlx8f2kBNQmnHxho1bTig/gaDKYCZPqvP1SqfRhR/eBx3/NZ1BFR13
 2R6g==
X-Gm-Message-State: AOJu0YwL9gBVBr9Te84Af+7djLM1WpJ4Fg+jeQoDHqY5gECWaN2bEwpI
 HmXBZKA1EpVQL0XWkn8J19qykBr1nJ4B85SvGbBxydLv66jticHYyheeqVj07EKkPMJmSUXS5GE
 Jx5KB8uv21iCDBtV+UAwEUZSvnxGFDUH3crE3OV9iwK6ut78l
X-Gm-Gg: ASbGncu0C5cTWfArhLIOz36aaI9knrMqUrCvTbIybZt1+xCaYAY9RIlkBWq+EU5fJ+h
 ouj8Rs3phqucBBfcJrMiUqmzKR+VknGKb
X-Google-Smtp-Source: AGHT+IGs1Mslb5K/bqCKGRNc0b7W9wjb6kzdsTsinAQ7YVF3+n+eJusn4xP2TmCvL87sO+xvZ90PRld7A6+JKmmqkf0=
X-Received: by 2002:a05:6000:156f:b0:37c:d23f:e464 with SMTP id
 ffacd0b85a97d-385fd421500mr9515912f8f.38.1733419783672; Thu, 05 Dec 2024
 09:29:43 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-10-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 17:29:32 +0000
Message-ID: <CAFEAcA-BEXL7bGhv=F06ocq+fxeU_DqWhPRgTzdpAs8=qcFfew@mail.gmail.com>
Subject: Re: [PATCH 09/67] target/arm: Convert PAC[ID]*, AUT[ID]* to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

On Sun, 1 Dec 2024 at 15:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes PACIA, PACIZA, PACIB, PACIZB, PACDA, PACDZA, PACDB,
> PACDZB, AUTIA, AUTIZA, AUTIB, AUTIZB, AUTDA, AUTDZA, AUTDB, AUTDZB.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 173 +++++++++------------------------
>  target/arm/tcg/a64.decode      |  13 +++
>  2 files changed, 58 insertions(+), 128 deletions(-)

Well, that's certainly a more compact representation than we had before :-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

