Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693FEC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTe0j-0006qD-LL; Mon, 23 Jun 2025 06:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTe0h-0006pl-3v
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:02:43 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTe0f-0005FT-Iv
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:02:42 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-70e3e0415a7so32749577b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 03:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750672960; x=1751277760; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=78fy4h/5DONFEq1PaGzYHU37nQCxK6zQT32QBSfMpNk=;
 b=Z+V7eMIf6/BJCqGtowdjo5R9uUGYGykBBED8AnfsYv/q/tTSlCa2jdMBBbMiRei14p
 n8zqGtlWY193ZlC/2PoRvh9gTBU7kH74xSK1VnpYjOSz/7npyLSzqbvcDdOkEFx05GG8
 kChotELMM9CHbcTfMmo7r4EDkJ5EDnKRhP0fGcG9kAhRZJ5UO/7+2fp+uGJnF/kjqVwr
 iuiLHuhWwnF235ucYFLT1z70FNOUdOFT1nurcntiA24zC5lMpCTkkd4OnKQ1AOSl3/GJ
 ZSWoYw8nmTai+mM64K86nDpd3qgh7str9rCpAa6zkCBAodx2qzfvaYs4KMvUIJ37fI8W
 NQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750672960; x=1751277760;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=78fy4h/5DONFEq1PaGzYHU37nQCxK6zQT32QBSfMpNk=;
 b=s1STsXTQ+tDtrrrPlf7goR7hcJV8Ijl581FXdfG6c5PkJjXRT7aN70CFI19s+aO0TB
 vlWvNoJtJYbVhAGCXb5rBI74vHtgeHEFQG/PUijGPsyOc5O3/L8tyhFOTbF+e4IyFj2W
 oJogkjAbdr0N/bpancGs6E/emNRwC1jPpbJb/keQYq0wS6uss8+6PtmqZCf4SmEB7l7W
 9MJiPELBYUmKcQsGWJ9NJy0OEcHmTFRZCrKZN1XTt9+EewvNXlNpPobNRb1/OAlOD2vG
 3TJo758Igsw9RpBBfVedmNrXWtWIgqGTUkwMsrZuxe1i4yiB6/82fmCXN6hG2p+r+umf
 3lmw==
X-Gm-Message-State: AOJu0YxDR8pOfmxoaZpsbManFYFR+7X/77FXKj9zkCmuSNp9Px6HDPRt
 k3P2X6Gznq9nDocNfPJHBE6wJRfnGnsh33s/qVzCDDAPvZc0BvR4lYaKuzJ3lbXJ8LPIHt6m0mY
 GouWzO9V6Jq9bcsrePTiXd2DnTXxg8N0BOeV5VEZno+rteIAlg7pT
X-Gm-Gg: ASbGncvcRaJ0fx0NimCukqsEixEG8pbGWsj9mG65r8/XFPB2ZGiymlwudBIKnZY6xA9
 KSccsZ6gKJ8hjkai387cn1N//hLwsWWDiCgLHwQiPBK6rHTLozAr2yh3ryxHx8i1U+4T3yipayx
 bq9qUa3THABx6AVJVlK6ewUUHg39SN9Xva5U1oo5STvi3R/6bI5rQJrJo=
X-Google-Smtp-Source: AGHT+IFYkVOgLgYpiQBShHD/FAj7zSQazM4MZqASJkBypFGXLOrqeFwix9Urg58Gj19/i0IlN+B7+80Win/PntxcZ4g=
X-Received: by 2002:a05:690c:6910:b0:70e:2daa:65b7 with SMTP id
 00721157ae682-712ca3d9b80mr173876427b3.12.1750672959824; Mon, 23 Jun 2025
 03:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-4-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 11:02:27 +0100
X-Gm-Features: AX0GCFvnltQBVauDowHiof-If3x0AKCN-Q0W7SXvDqQQpCnAzTFcuxwL8uJLpDI
Message-ID: <CAFEAcA8FswfdKnPjkjguY-HiHHUhTV4qMGzf-i54thJnnNT5+g@mail.gmail.com>
Subject: Re: [PATCH v2 003/101] tcg: Add dbase argument to expand_clr
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Sun, 22 Jun 2025 at 00:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op-gvec.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

