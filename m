Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F06C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGaf-0008K1-3f; Thu, 03 Jul 2025 05:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGaC-0007dH-Ai
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:50:23 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGa8-0000ja-8k
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:50:19 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-714078015edso58318507b3.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751536215; x=1752141015; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x52QpShekcOPzfngz7lq5sNO18hifZ/zWZiGRzzuBMI=;
 b=ZjhA9rf62haTc5lhkzsBXyvaN9GDLZILiGhQS2sXxFBSGqbJ2n8d0tymxqq/GVWzDv
 WKFBMWymgSu6u11bCOTjiPDQns6W1Q8K9W4+Dta1UYKzRd+GHh5gVT+MvW7y1SVe9fIh
 SsJjWRN1F1nTRsbzvD8i5f4qEKih8WyH8m3gI0BDSF+jUd5iBU9IA51qsSBLXAocsl2Z
 +Gkj760SikG+6C0MYDyTi53NZM9zc9RONa+phr3Ms8CyWmP1GQ6KkP+nZqyM7zqnyf3W
 VmxgpOUjNiByPcaHQBNKAnYJOOVHVs1hEQzLbSB+82/onrGRN+9tlEdYkAsB+kTLOdQM
 qZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751536215; x=1752141015;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x52QpShekcOPzfngz7lq5sNO18hifZ/zWZiGRzzuBMI=;
 b=c9d8vg5wtXH4ajr91niedd+//5igNjdTQgCSTzfnwkbilRxyRb7HVCd8lzzclnzvUk
 X97mRH/brujGbFpI8reCD4ceL8DE+aN/Cke9Q83ikD043DlFGLB3RGlxEdg9IWgEtUt+
 VS/Y1o6thxbCCbPKZTJaTjJjkLSRYmvDs/PZdWkeDIqyl4R2rZleig8JxR0o+FefKG9p
 6SgY8r55eowIBHm8/g47LFYkeXnnpDKjOHXjION5JJTVjp5JbLVThuqDPMsjHaaDHrL2
 zq2nje9rGVOt+BcXS6wNnSH38+soizzNGg8HYpMjixTwcY5GnpXcCK33unf8Q3YPTVbG
 zJzA==
X-Gm-Message-State: AOJu0YwX6iOIY8z0NLN3iZ/Pqs5cAB/Ox4nZ9rcNy9ekAWtboLtGbmrj
 l/AqnUhiCZMe8ySvrMY1gvSsLHRY7vVqe1YOcCFpDeWHFwBa/nDA2f9wrAk14+OTDMSYoV+Va7x
 Kxx81K1UA4NLPMSxVqKYlpnQNDBNIgo3Hx4xY4uOQHA==
X-Gm-Gg: ASbGncur2UWc9WiiRBmBGjqkY6G1VFw//4vBN8SRyMA1B4cXmgnjvc/GWtGOqQY74YT
 8HEgGxj9/2ZE35xZmAFS6hB09bJCY4VMH3j7ls2mcPUhnZOG56D7ZZPWOckZvhHquwtpn/0BdFp
 kyzk4WvFcdCIcQpeCmCDHc7uCIvlR/ju42gd+Rn095P/XR
X-Google-Smtp-Source: AGHT+IE+ov5eeXy59VYBL0BB2OGeId12ErijMIre/CRbm+Yn4+FptaF8t9BluLXXWtrcnOdk7Yp87y1R8e+opPrwR8c=
X-Received: by 2002:a05:690c:c93:b0:70d:f3bb:a731 with SMTP id
 00721157ae682-7164d2c327fmr80237017b3.9.1751536215025; Thu, 03 Jul 2025
 02:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-37-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-37-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:50:03 +0100
X-Gm-Features: Ac12FXxYEk7ARAzMdYnSm7mjq9_rH2LzWbjrHSSuWSPUnaa98YTLsBdpRdkUYCY
Message-ID: <CAFEAcA9MSxRA5fkZgdgzf9GFAiKSAJmQ3sQN1O0-p4hODOZodQ@mail.gmail.com>
Subject: Re: [PATCH v3 36/97] target/arm: Implement SME2 SMLAL, SMLSL, UMLAL,
 UMLSL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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
>  target/arm/tcg/helper-sme.h    |  21 +++++
>  target/arm/tcg/sme_helper.c    |  59 ++++++++++++
>  target/arm/tcg/translate-sme.c |  84 +++++++++++++++++
>  target/arm/tcg/sme.decode      | 168 +++++++++++++++++++++++++++++++++
>  4 files changed, 332 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

