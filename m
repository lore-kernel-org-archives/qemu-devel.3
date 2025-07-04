Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34FCC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhPI-0002Tj-Rs; Fri, 04 Jul 2025 10:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXhLs-00042X-2U
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:22 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXhLo-0007x3-1e
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:18 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-716ee8947cdso1125347b3.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639113; x=1752243913; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pz2qbzXz3RBUZr1h2ZLsOJYtjSHVglXojMEtSCas/tc=;
 b=o3hCAVklDW4ZZnaXqazhTHrSstqgXXe9hQ70DtJhtEavP63Js8J2decLhsIV1DXhaW
 DFzqduO0mZOB6bwe4ZpeZckR8gv1YvqbaRbqXLbnNhoLFz0pY6acT9LkWmiJ98zUTnM0
 bwUqfigDLskpMSUIm4G8M4hUfS5ZmLC4wLu2+RVqJNLDCTqpwL6Mmg09bRP344gaRCxI
 /ZVAzRx9UZgRIkfHCSz6PPNkVTaWtYNbwQu3aDjc4PIT/bpcXbg9ouTnhceFbZvcGy1E
 bJt4up3Wj1AKrWW8e3mbhlK/f0RGqEOnWcwtU06P0bfvz1HZeVq7n7PYHZUtLJdRBH0M
 N+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639113; x=1752243913;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pz2qbzXz3RBUZr1h2ZLsOJYtjSHVglXojMEtSCas/tc=;
 b=KEYxlYheLn2EOh+2dcIXiheSNfm4fX5KWQtlNJdI/ebuQhvkgc6uqd3RqCfsNuCA75
 pVJeEVkOAAIiL6ZAk3itYKt9jRX20HE8li06aWRDrO1BfBuMtVRx5lmD0z16tzUQy4aL
 oCDyuWpFVG0WMgZFJM7PWSCXcNEy6y15LIjR3Tgy0GJ1yXi7L360SmIPPagLlmNncJ2D
 IlnWvSh4UlabdywHGOHrZzNF2pXi1mIDMWnl/dtHaS//cCyWR8Ne135aq9BZxBwR6JqM
 DpYuWIAryhHRLOY8XlxrrShlKbTmP0k1D3sVI3U9R9OuzyIThzGQIBA8TlggQ/5WOVoX
 5s6w==
X-Gm-Message-State: AOJu0Yy1Uu1FtrJLx+GApGhf0VtY0Uj8LcA3cJgHbSBNTHZFiwwelurU
 h42d9Oj6APbCxk9rjlV8Ngf8g3tX7tT8+pUDOymz1+9zbEnqoVo2AbDjURTSGbYhZTSertgwmGH
 Pfhk4I3Kd3eoGzOmuKC5B/EGpF2Tr/oyAXrSqMAitSQ==
X-Gm-Gg: ASbGnctCNnm4F0opVqBITg24VYD7lloaLGeVAa9HrCJ5WzODEyqaQzH+VxEByafGLZo
 Exz4dokVt7eWBP/c+BREY3txx0kRD9+Xv8ScAnrrAT278w+UYXA01gDlJUCKw0l4m8gbym1upUG
 3kHvU83nSFhOfKjDkpYrkJbjynqNTLbHhYrS5qOmHW+2VY
X-Google-Smtp-Source: AGHT+IEc0MyecKwbGgr5EYxrGfoz4UmhdXNodjEJr9rnM+td/iKSoKpRB0NSFU2pxLja6SY4Q2bMZRx1hf3+d7PCoJw=
X-Received: by 2002:a05:690c:b84:b0:70f:84c8:3105 with SMTP id
 00721157ae682-71668d73139mr37409777b3.37.1751639113268; Fri, 04 Jul 2025
 07:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
 <20250704142112.1018902-10-richard.henderson@linaro.org>
In-Reply-To: <20250704142112.1018902-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 15:24:59 +0100
X-Gm-Features: Ac12FXxf6R7UWgQa9JQBAJsxtTd--2vaJRu5LT6qyxXkRUiSZ3o571m3SwOWq-o
Message-ID: <CAFEAcA-J7whgL_Y1GW3uULdBAVZw0P1M144BYB7RC=mqAcX3bA@mail.gmail.com>
Subject: Re: [PATCH v4 009/108] target/arm: Fix bfdotadd_ebf vs nan selection
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Fri, 4 Jul 2025 at 15:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Implement FPProcessNaNs4 within bfdotadd_ebf, rather than
> simply letting NaNs propagate through the function.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 0e1850182a1 ("target/arm: Implement FPCR.EBF=1 semantics for bfdotadd()")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/vec_helper.c | 75 ++++++++++++++++++++++++++-----------
>  1 file changed, 53 insertions(+), 22 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

