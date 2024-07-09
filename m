Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A12C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBk0-0007C5-To; Tue, 09 Jul 2024 10:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRBjx-0006wE-Ne
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:22:46 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRBjv-0001zH-UC
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:22:45 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa69dso5629540a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720534962; x=1721139762; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XvZkY9NN1zlzy7afgSOGV7uANiG1b06UW33WFeFf128=;
 b=MsRAC9uA3KiF/hH28BjV9gBEpVYHU5YOmE9L1dBsby6pLYd/W8m+JxiW3uHMv+PzZu
 M4Fd3cDG6e/ur4AXfeZIp17Z1BpfQ7bNCWixtaTk7tXNK3+XyI7DvR/rK7Jj94Lu6vuG
 XQYoA7zOp6Mwb+QE3eiBaGjrw3YlnLEvEYyb3KgAWbFtg2co48wT3FxWhlwjGx+jsyf8
 6udZGl93z7NrAjPTiAhpSGGZ79FiHN7K3Krgqi3QN9OFvMEPBKo6vwRfIATlU1tRocjU
 YONFUku/Igdlvw/3SOJKR38UDexITNjvfwqXoKO1pwfEvrr+zkMResISwnztJruQvDkv
 +u8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720534962; x=1721139762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XvZkY9NN1zlzy7afgSOGV7uANiG1b06UW33WFeFf128=;
 b=tWwTzkiHXc5sOP/VdB27l9jtktYMaFHi2aJOKlDoK9I1zkT4bZNqmtj3+MRtuWExmx
 s/CaPGCcs0PwLxjzacfzWpLh+Oqo7BSvGYrEXpLARXifgPAMiGnQYHa30RX9y2YcnAI1
 /ya++DONnOxMoJIHTHy2m3Jnn8DBMJyq57zo78qPiGmrvSKnl/9+nBVnh3GNmwYc91IM
 mF8+/GtzVcD8bl1VaSnAElXD/m2iH9u6Aax7QpYFuu9qQPfYre4F4+alsZCf4P+hpXA0
 yEsoAi8RfnytdgnVY2roSkDaUw0BLgvoh8EAlPLCD4I8KY8j1cqiiqRF9jT70lW9bJkI
 y46Q==
X-Gm-Message-State: AOJu0YwXh4W3vbLVthod+1faQBpNBebczqccR3uHf0+OY+l++DQhPQs6
 /C4qX8eSYzf2x9L+zFljHgrY+56AxMZHS5spnl/XIOG+FpflqimYzfO65Ar+nCbvG+XlUsx8C9O
 by19xZ9IYzYSp6YOtB8IOtvfKjJxatBuU6YAJuwq4ZDkJImnL
X-Google-Smtp-Source: AGHT+IE6gZgS/Y8PzIQ7l8sfpNzsBWkLetIGQSkq37EKYMRQlhlHlFlDG1oMM/adpyoYf+XN3QVON9nAtBtdgWdD9Uc=
X-Received: by 2002:a05:6402:b19:b0:58d:842:6272 with SMTP id
 4fb4d7f45d1cf-594bb67e9demr1491419a12.25.1720534962490; Tue, 09 Jul 2024
 07:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240709000610.382391-1-richard.henderson@linaro.org>
 <20240709000610.382391-7-richard.henderson@linaro.org>
In-Reply-To: <20240709000610.382391-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jul 2024 15:22:31 +0100
Message-ID: <CAFEAcA_0K6awDE1KS_0=3R_PiXrxP7xjLD=bHtdSjFkDuPmXnQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] target/arm: Convert PMULL to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

