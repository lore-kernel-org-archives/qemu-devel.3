Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2933C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHAD-00049W-BN; Thu, 03 Jul 2025 06:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXHAC-00048m-3W
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:27:32 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXHA6-0006Xr-3B
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:27:31 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-713fba639f3so77294467b3.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751538445; x=1752143245; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OqVqdTNIkCziZsTxLyldsmzmSo/H9noC4yrICjC0j5Y=;
 b=l6ezhlHnfC+wOXNF9fWdk8Pp90W3K8at34TWW+QCYTNvixVXhxVQRLSxsBmI77FyH9
 ggLC4BkmuoW/4OB4CUTDLhV7SdXWp3o4XiSQSiWzuhwFIV5rSqItioMFlnzRwUrG4Dxc
 napHdnN2gkD/p+Fu9CJ9rpAy3wvzhkEZLmRzCxmD/t4hiXCd3DPutvKUY5+U5G8A2XyL
 tknXJM/W0ST3eVJNApkbZFNWbEObF0IA5XfvQFT7J8JKjxZQNiUWyRcmFiXshl1uuHZR
 2/NP+dfzYzZMq46WPmWNUf4bdQeMgfMXTlVdi0shx3BOtGreJQwuisTwNCgy34HXaOqL
 eeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751538445; x=1752143245;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OqVqdTNIkCziZsTxLyldsmzmSo/H9noC4yrICjC0j5Y=;
 b=WmptXCytv4n1U1eULpvbcHu9FdP/XbuPuf7RYBD7t2xsm/5sTVD6i6+/SDFHMxOpt/
 OGfqmnVhCEhrIhyU3fygj5wi4toYJBwBkCKpoXFILYs/n7zfU24C5/ThTH37ZS43XZOy
 aZuc17bWKj/uhf4UD/cw+7BgCO27wYS0RJjb/kVe5RbAlNvXiCiTvLGWDKUsGoCyM9u0
 s46DjvGjHBXOk8JtN0xHLV9dlonTLM6Maof7S6Mt/6LlnlRdqTXhsTE5BI+4bltH9Poj
 hXcWsBrDSNogBNjYnGhSiqHX/xlGxP5icc1+z3Ihi9zRXSD4VkV0sIBFvmPhPtQBAFXu
 j7dw==
X-Gm-Message-State: AOJu0Yyd/aUUmq+kawWg0GIOoWA3Qe9GyLrYWF77CGvZS4xq4YrssPaY
 cVXNSyOin/a+VftEuFkRIuFCyuRiwru4FKCa4Dq6wH6Ak/j/D+h/zfQFaMA/JQGmV5KWCFOXhCJ
 w8zdaJiqbZtRqpnVFGBrDa1qYhpGNgS4aT7Sj5nnWlw==
X-Gm-Gg: ASbGncu8SSJMDNsV1Mcc30ejLMmOuRkXtRuQapy9aOl4ybHuQzgKXAsk/L+HfKysVmP
 /0RDkmyE6q4s0lZ9sIF0unMXTWuC2guqWmiRXvaotACxmY7zpu+QFXN0fl2h6jBRr9AVgeHnNAb
 L3Fop7qAOTUXZM0ZouxGlbd3FFIuaODTmlGoX9D4tEvpvW
X-Google-Smtp-Source: AGHT+IEx5baTjg9BXbacquCA8I3nXcaJMFeUxFL3qusoDGF1GCPPJRmi8cORFjVDR7lfZsO36jWCgRg8IrGdFHrWanE=
X-Received: by 2002:a05:690c:6ac2:b0:6fb:b37f:2072 with SMTP id
 00721157ae682-7164d4db0b0mr90002047b3.22.1751538444780; Thu, 03 Jul 2025
 03:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-56-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-56-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:27:12 +0100
X-Gm-Features: Ac12FXyMZq8MQ1lcu4GV28UFbYIIHVfWjJcD7CGKCvxutd28q3DJKjnNxgk7A-U
Message-ID: <CAFEAcA9_WX6do8+O=zTLvDoKg=7BCtVpTX_hLmKisB96JtnV1A@mail.gmail.com>
Subject: Re: [PATCH v3 55/97] target/arm: Implement SME2 ZIP,
 UZP (two registers)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme.h    | 12 +++++++
>  target/arm/tcg/sme_helper.c    | 62 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sme.c | 40 ++++++++++++++++++++++
>  target/arm/tcg/sme.decode      | 12 +++++++
>  4 files changed, 126 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

