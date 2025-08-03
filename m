Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2913DC87FCB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 11:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiWVs-0006Ut-SO; Sun, 03 Aug 2025 07:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWVo-0006Oh-Uy
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 07:04:21 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWVn-000094-Kq
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 07:04:20 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-712be7e034cso29828737b3.0
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 04:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754219058; x=1754823858; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M/XT6qtnScAykeQAGpT66UNd1PFPa9Po98UAo+uNYnQ=;
 b=fjvroGdqVBi9QyY9LBpgUlo5SU/T8zMupV5PCBADcoxC8i00jGu0VjbdeZpEhSATTf
 rS+nFP8mE/Ss6+s3rJua1OsqhjghRAO61PsHhkSgEhe+rUOti6zqlg3T+9+mWHxR9A7b
 0njdkvcLrfXpQfMmHAy3D5h+dU30kqN8BvQGQWpDfH5XIrD0r6lvdI8f+GfdIFG32NmL
 RoAgRkltYuP0Iaa/odiAsEWLy+DHzq8zXpZ4DCqBXDYU+/KIDaTTxbCus5E7XVJqJtXP
 6BkhWUpWt1pFfpovV9jcxlMEK4dYV0Cfip8DZUC4v2MKErr0vqEJAZS2eEWi+Y9TWST7
 YlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754219058; x=1754823858;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M/XT6qtnScAykeQAGpT66UNd1PFPa9Po98UAo+uNYnQ=;
 b=oP33NHeN+09wU21SE3k69IrLOCpXZaPolxldHLLQEPxG4hvQeU3hf+k4JeJWbpwhIJ
 9GmNTC664rx2ME8wtSXSccv6ZallHAHlxn//KZ3LZEPL2EZFqmfNbMpdGjlsHRmCpU11
 mggGD/tAkM7oTDX+Ds22Yjcd00aUHwMSdWr+p0cL68QVouTpTEophcyZuE7EZR6w4fHG
 dOM6T5cX/qzZ/NMqa2T3e7TRMBQ2DgqRSMlSETui6jwZLgXeMrAvrWUlUqa4R3SQPJCr
 NRBIqr/YMn9ktXL2wbe45Ne8dAR84ez6RxVL15IInSMt8U0oV/ZfYo+EDVyykDaxQ6HL
 mRVw==
X-Gm-Message-State: AOJu0YwXKihqfg991UGfmURNmecveKn8Br0QuIMMD0MTyvOfhLZY3hvy
 G8H/wMDT4l2Yaw8BoYZAvPHKnCr7svWhcak5tORNaL97ggBiTvwrn7CtJ9YYKPEj5V2mn1o3QJL
 1HgVsCJd2g0jEw8RAmXot858wRlZx1DqXoPkTYfsodg==
X-Gm-Gg: ASbGncsypgCHAfJeohZGIYX872fHdc0LrOd63KOxFQQc2Vvvhbt+ImGPPMrscB3azt0
 BGCeQHVLPDroD3XyG87bzMvH68d4KQAbXFVIgHJF8bwOP3hv8IYoVDay4mDP+xIXWIfTL/PKO08
 AdfxpIT+RnJz7i7WIISjL8yv81bOJzAP1teQaQoTk6PxyeM/AjBcL1Ojr/FZIJV++5wvJmLTlJD
 GbHtsEo
X-Google-Smtp-Source: AGHT+IFVI8NUaGowfipa3EAx3x6QHDJVT/uBm+AYhf2Ea230wtqbAQOWkgPtVzsDA0HTFfqTtVvqnupGlZ2hQNF8qQA=
X-Received: by 2002:a05:690c:1b:b0:719:7123:ce3a with SMTP id
 00721157ae682-71b7f5e18a8mr90724107b3.2.1754219058497; Sun, 03 Aug 2025
 04:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250802230459.412251-1-richard.henderson@linaro.org>
 <20250802230459.412251-69-richard.henderson@linaro.org>
In-Reply-To: <20250802230459.412251-69-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 3 Aug 2025 12:04:06 +0100
X-Gm-Features: Ac12FXwU2KHRgQpuiC2QxXIKx5FjymPnokMJxPzUs-yZdcnYtsvuHYO-UpsG82s
Message-ID: <CAFEAcA-Vp+g4Ve2oXdkoVDiGznbT_Q1kasC_E7i5+=0PCzda0g@mail.gmail.com>
Subject: Re: [PATCH v2 68/95] linux-user: Remove redundant ELF_DATA definitons
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Sun, 3 Aug 2025 at 00:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We already provide ELF_DATA based on TARGET_BIG_ENDIAN.
> Remove the extra definitions from openrisc and s390x.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

