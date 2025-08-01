Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF14C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 15:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhrM9-000717-4H; Fri, 01 Aug 2025 11:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhr3E-0001HH-4H
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:48:06 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhr3C-0006Tk-7j
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:48:03 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-71a3935fa8dso12822617b3.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754059680; x=1754664480; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j/uQhooOXD4Y6Tb5exvB8s3XRU/baBFBYONUyWD8jUU=;
 b=f63AE5rBNfPl5nSQ5EuB0T405vafAU0Gr0awHf9H/s/PB/clBqfEJgHxFVybe9YKNL
 qRRJcoTrb7FVZorw/ztB6wsKDO4zD5jjrd/VS5IHY8WGvaKdP9EbFTaWRoR8E+NZiuOZ
 K/ampIxPZY5qjCQNilVqkiHkskYaaMjcC7/kEg/phgtCrhCW2L9fvmRYSlacpGauBdoq
 GkGgPYVBUS/YR7QPmldDMiSlvOZ6QfGbKBaedVfmLM3ljmnsh4bigu/ED5T/tLubsTC1
 ruAw7Q3VAydphQtUhuwfwCMAVol0QPDfNfs+swAaqfC7Rs3M6CMyzddkayDOs9giMq34
 filg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754059680; x=1754664480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j/uQhooOXD4Y6Tb5exvB8s3XRU/baBFBYONUyWD8jUU=;
 b=BOcZOhyyocUe/cLSo7FOfxN+0SMKGWTlZ54YHZH/zccS2AavdzwGgE9ybikfrHsCNJ
 04uWQTpuLxea5V9J7wcMaOkH8zgbf7M/bo38Ra8+1g50xO8PnJ5BAVB2Sk0DFWxtbp1b
 b2YydPkPwmTsiqkiYSgrIsIRN/zOlHBrVXQ3kZ+f8xNyLcn/vVeECzt18GysyYO6BSc6
 RkmiNI8S5sBXe92Wm282PxUuVnDsCiB0fncF2M4t+xC7ie9iRNPhhI1nnjFs4zSt3ZvE
 BPRySbt/ML+A/Pz9Way1lnHa00uKEGLsMlerLDWHPDBpYFZA73vvEGXIyoA3BbWHYvRO
 y71w==
X-Gm-Message-State: AOJu0YzRfpJvje310Un+pcZnck3NSIJQDZmm2DVUp1jUhAoXXHCiGMfX
 EG+JgsUGiXjWLkwDUKE6UYpBa7uhiZG3hXCHY/7UR9o2rORSV5Had57w2fyQ+p9vo3hsK4BWhZ0
 jxR93IbUNtETSz8/zLFGeuSQAWIic0qp2iAHLdbUFl8hHliGyh+SP
X-Gm-Gg: ASbGncv/gsBW5TUfYBu7WVxNOlzdTcqqTvWzRNx9HP0iNPsaX6mSsGFfgnFq6rDaBWe
 W7ZzslBEQVI666rjlMPFbeesmWR5cHns8RlHrros3M2iUixGBvGqyQNqaDJ4zIuUwr866C3Clre
 yJ4Dte8lF2R59o9dBj5XNSn9I68IwylXKxXKMbjj2wX3+3LGE/nezf5AKRBPn0SW7i1ZK8wg0gy
 kCDmatV
X-Google-Smtp-Source: AGHT+IHeLv0+pKMc+9Su0VI6d3SEWHfaBKMODCICas8/99OJ/Kx5t0nz9xcEcj3JeqkaiptQPp4YNjbuwN3TwHyTUSY=
X-Received: by 2002:a05:690c:6282:b0:71a:1e8e:62e9 with SMTP id
 00721157ae682-71a466ddeb0mr159063817b3.37.1754059680540; Fri, 01 Aug 2025
 07:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-2-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 15:47:49 +0100
X-Gm-Features: Ac12FXwgouAJUIn3NWJarNs4Czi9fOfOQVQ5vqNkBQgDmXzvpPUmaActIngCSYQ
Message-ID: <CAFEAcA-y+mFr-FwWrxWT7SBGAY3r8NjiZd3UQTPcefMHwCECYw@mail.gmail.com>
Subject: Re: [PATCH 01/89] linux-user: Create target/elfload.c files
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Wed, 30 Jul 2025 at 01:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Prepare to split the main linux-user/elfload.c.
> Create empty files for each target, and add the
> common build rule.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
> new file mode 100644
> index 0000000000..73fa78ef14
> --- /dev/null
> +++ b/linux-user/aarch64/elfload.c
> @@ -0,0 +1 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

No license info in the existing elfload.c so I guess
we can take LICENSE at its word that source files with
no licensing info are GPL2-or-later...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

