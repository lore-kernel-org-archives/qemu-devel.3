Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FB8C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFzg-0002Dt-Kr; Thu, 03 Jul 2025 05:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXFzU-0002At-5M
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:12:27 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXFzS-0001sS-FK
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:12:23 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-714067ecea3so42618927b3.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751533940; x=1752138740; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5KZmfKLAghyQ9OAoHmOFIfvZzaLpAgJw9UT2s2c7Npg=;
 b=FrN9lNfNymJLza4NWu/VAfPeWrYlzTwI9wfjCb1BrWCcd4Cagww8UdcxO0b/SOS5cv
 uyGup7aDnG1agYmXNr7T/kLJGVu8hJdgLqrB1BTQe1ICCFLf6zyyEPtXMwwzkGnLiyPV
 sd9NhWRs0xNxRLVQluZu95Iz3/H37PyMC3rS75bvoRVn6xiXymWPT0FyS1dLz2bUysxP
 hYtohIV+zqIqeeYjw9hiebv+TdV6L+6VzdwWVoQCsBdEMFyss2Piofqxuv/3rkRaA7/T
 sMuWvWQmr5MRSFldXTZhFEl+8G8KTq1vHldEFQOmWWu6+BOfzx7K5mUKhUUuY2qqvUIU
 H16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751533940; x=1752138740;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5KZmfKLAghyQ9OAoHmOFIfvZzaLpAgJw9UT2s2c7Npg=;
 b=AYigm7W2aW2N7TBJV9sNW/X5I7ib2XSSq8sI2O8y5A8Y2ZMJpezyixqC2Wxb7Yo7tC
 ItIVhgrmkOP3L6fHw7B1nHd79HZBpqVAGt5MR8WF+FGx441wF6QwseBDOO7XJG8j21L+
 dF6/LT2oOqoRLvyzr91xgdBmL5rM5Wa+d68EJE6hlSXeu8LXqkfwKTEiR46yl5KjK+eB
 l5KOlHJ6PAyTdeCd29QcNNo1QpbjD3SvmMfCP+yjTt+oaxkvrFXXLfmZC0UIdz0PLMgz
 yPee/aCTEz/GlfcmIp8fZNPQNbHR4gBsmePVoXIQUA3MyYWfSILGfMhXT6iXl63avDAI
 koDA==
X-Gm-Message-State: AOJu0YznLSNVJorwhY4BI4wGGF0wfH1HF3ZZCyCIShQr+/z2TwdI2rVh
 FJX3g7gSCvbhTm4OglTTFphbgpwmwJ6L9vuy+JNEqd8YGO7sNQvw8Xy14dokVXDVQ1wgVqBwBk1
 7G+e7gfh1DhWAAMZD4oHx0uGDlse6lL6deMqFVRzjjg==
X-Gm-Gg: ASbGncv+933YUFY7S6rdim8JjVyR2ocu68Z6L2YzBUqmjrajWWQfnVSazrfrbtJSYcp
 BacMdQvO1MD6urp0C3kp0zGCy1cbknpjqN8tqsVtKQ8HWG+LKnEjKhz6PRTrzIO2pU+BsmjpyhX
 fj9RJqPAzZzLtARP4eGfa+dsLkOf0h945DMjZTkcGERpzR
X-Google-Smtp-Source: AGHT+IGPQH/k6oZ3G/huziFt23FKyw0KFSZzwX/uy5fwJq1TNpyPjdW9HF94+ofLYEQtPTXTs1813MyVO6MZqC8rlgA=
X-Received: by 2002:a05:690c:6710:b0:714:586:86fc with SMTP id
 00721157ae682-7164d2ca1eemr91668167b3.16.1751533939863; Thu, 03 Jul 2025
 02:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250702122213.758588-1-richard.henderson@linaro.org>
 <20250702122213.758588-9-richard.henderson@linaro.org>
In-Reply-To: <20250702122213.758588-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:12:08 +0100
X-Gm-Features: Ac12FXy8Te81mhgz1hJmN_W5ZPnJk3-Gh_HF9ZXA-1TQXsu70ZP73PyGbH2tJcI
Message-ID: <CAFEAcA_xThNK=V1_bVS7nAmqSsQUrtk9TY7mxmFwM58wTnyf_Q@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] target/arm: Fix f16_dotadd vs nan selection
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Wed, 2 Jul 2025 at 13:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Implement FPProcessNaNs4 within f16_dotadd, rather than
> simply letting NaNs propagate through the function.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 3916841ac75 ("target/arm: Implement FMOPA, FMOPS (widening)")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/sme_helper.c | 62 +++++++++++++++++++++++++++----------
>  1 file changed, 46 insertions(+), 16 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

