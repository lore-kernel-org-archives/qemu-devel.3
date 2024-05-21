Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3F6C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OXP-00064S-DJ; Tue, 21 May 2024 08:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9OXM-00063g-CD
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:24:12 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9OXK-00008i-RA
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:24:12 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-571ba432477so9687464a12.1
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716294247; x=1716899047; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qVthAK1jYx9b0bGk2p3SsPnONf5JXUCNteZeUAIDWNs=;
 b=k+W8+VcBj7x88Vnrr0h/FQNLCxS3BqhPela7B/dVEEs2W3CYlivZkDyH+tDhO41++e
 BDiH9AJp9ypJ/aWtcPSzoQe4/lUwEZbZ7YOBQ+qfqFy6PHz8277r3m7Xm8AEFQB7IBSb
 eqByrQZ4Q24+fXSnBKScrkqhMQxdyA0SmGmOB8qSyvH9CcjOHctKHTfmW/C9JPDuRF4g
 gScy4HETu8QIVcuVsp3kHTytm8xl6WWI86VurY33whSnquOsrjMW428+XOzyTgmQrO68
 QEdHRuGrJdi3AHvFkw5dDEYs30F4ovNnFxMwwM+cN94mA1m7s1UdkxrkVimwWOkQySJo
 ViLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716294247; x=1716899047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qVthAK1jYx9b0bGk2p3SsPnONf5JXUCNteZeUAIDWNs=;
 b=XMWA73QEcA2+ktEc86h3Ms4pI1f3tx8bZGdJ80iWzMC5JWbvznzZoha7JviDe1Ayng
 0NJj3FFzEwCZlpxNVx2NHZQ5IHMt2KJdOZde/iG1P1Lhc4UJsPl3YoMhWS1wseMiB+Lo
 VWlwDqLhaQ2DYXBkrr1fE8yfhpkzfdW36QBRmA8Y3yi7Tsa35M8Yc8/jKnbCJ8Il83f+
 QpgHMoQmfSkkXmgPKCLDg92aBu/zZopcw+L+YFrqAjWNvYvHGYJPbuX+OhhjUn8TPDqp
 EQBKyjKzFkJJVL1uauq1LFMnMFAzJZCYSaOAdhsIM9Q8BzZExbiAu6IdCiHZA5IH387n
 6tJQ==
X-Gm-Message-State: AOJu0YwqqdfN3UqCX/LecRBeH7ARlhxN/66cZhY7AxrvycsMkZHusDN9
 Zxcs73FXUzNy22/gjT66I3zCP4SL6O8tQhaRaQtJqYYJ0DRt23uJbD120iV1BOShNlyPcNgKwcy
 BkdoQzfTq9HhWANJaozY0A2z6dT5i2YKLfJ6BCoA4zQahJl45
X-Google-Smtp-Source: AGHT+IFB71RrUANsfo/qCLQOdb+g2ubxmIsIue/FH6ZLkihBNG6MAID3egcoEhnhgmsAwx609TdcR+qwRKXJYc4d37o=
X-Received: by 2002:a50:d795:0:b0:56a:ae8a:acc0 with SMTP id
 4fb4d7f45d1cf-5734d5cc9c8mr22311828a12.21.1716294246945; Tue, 21 May 2024
 05:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-9-richard.henderson@linaro.org>
In-Reply-To: <20240511115400.7587-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2024 13:23:56 +0100
Message-ID: <CAFEAcA9Tr2Jfv2uExrqcYzzNaSE-2Z5hSs55uqB9=17AC-Vp-Q@mail.gmail.com>
Subject: Re: [PATCH 08/17] ppc64: Simplify reginfo_is_eq
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Sat, 11 May 2024 at 12:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Since we now only copy into reginfo exactly what we want to compare,
> and since we zero all unused padding and reserved space, we need not
> enumerate each field for comparison, but defer to memcmp.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

