Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFEDE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 11:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUl8f-0004qG-Db; Mon, 06 Jan 2025 06:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tUl8c-0004pp-TU
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 06:19:15 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tUl8b-0000ti-A2
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 06:19:14 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e3a1cfeb711so16017437276.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 03:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736162350; x=1736767150; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FBt3/8W0f5vPTRZ0+vM1pqi94WCbZKfkeG5EpUvzIP0=;
 b=lMLFlqhZxtgbv4qrQ85aTNFKZUkb7Qmw0VrHLfqF4MCPuqPGSedJJVm0NjXDDxAYG5
 UnzPmpCgHwTD/7fVAmcfr9P4txKcqCdSRHRoH+Ida7wlEIFtq1TK/g+I5dEq1vGh2isa
 NPgG2l0w4eFJQ5kTnmBR9Z9JejQMvQKrGbqqOEKrLmJrtub5PpWchivBzhizMoDf66tl
 OAblNmfg43hZy3jUGCUVQs/qnBsNDCAHwBxfYU8rdrEEExInDU/HOQN8BNQeMeUYYtSr
 5avTkdV62thW4LNcUm/NcEgmOSXHn19X8pik8cRK4vjQSRRLxDjiSTH/NIJf7mGdM/Sm
 6l5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736162350; x=1736767150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FBt3/8W0f5vPTRZ0+vM1pqi94WCbZKfkeG5EpUvzIP0=;
 b=RSfpivCae/4CyfMRJMcHzIltkUU2HXR0YBWCC75Nd+3tYJwV557pEM4D0keeF7TJaz
 +kzjWlKmSTlVYwsg3Pi6pCjxXItUY1W/qy+JwxFwSFUhA48whiIoqEoKwXS3uRVw+EHP
 XSvkyar+Yr7eaV8HK8/RBTHYTh7uC2cnkf84qnLDi4grZvT23R/6BwS4+bySHLwFK/up
 jXAgg0ezARcwZppAGxKabd0bVDDeSe/bAVgH3Ju6vFgiOVZK+w5iq7lmVCdqM5w0XAIX
 22gSM2+yCeaLtHPrtqAJ4x4ucWlZhmFJo51OMuRkoaPGH7E1FrLG9TB1wG1WUGjZij67
 yDvA==
X-Gm-Message-State: AOJu0YxBsGRN+bFpn+VAzRvGCs5SJiSQ9R8qpR9OlTzcRoZQ3u5g9R5f
 /4zi1Y44dizH7ognq/7kAuiyDJRoh0NKxlWkoqnUmI7cJkL1b7nA91gHpfVoHwXJCgAKF2Oi7Cg
 QP7Tr4xOQdBr4uj4VQLcRjK6ZsFIXZxp9nkpp2g==
X-Gm-Gg: ASbGncvwjIoWnaprJzuXTqoxRzNzG4i3yEXl2DzUrB7WbDWP9MUNd5ycMoFCL76xafk
 ZdiH8rgU2UrUHvbOy00M3G8caUlLCibiU6Zfb4BI=
X-Google-Smtp-Source: AGHT+IHtIkvKHbR/gpno4T/96yNmmPUK815DS9MWkL2F08a3zReJLiTzDUy4VdGbDgnYUVVAIesn2DV+00ZF1FdnoTs=
X-Received: by 2002:a05:6902:15c9:b0:e28:ee2b:34fa with SMTP id
 3f1490d57ef6-e538c000d6emr40033185276.0.1736162350082; Mon, 06 Jan 2025
 03:19:10 -0800 (PST)
MIME-Version: 1.0
References: <20241223040945.82871-1-j@getutm.app>
In-Reply-To: <20241223040945.82871-1-j@getutm.app>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2025 11:18:58 +0000
Message-ID: <CAFEAcA9kzT2qwThGFvNmZ4VQgVEA189dmGYwHu-FZftfJFAU-g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Disable unavailable features on older macOS
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Mon, 23 Dec 2024 at 04:10, Joelle van Dyne <j@getutm.app> wrote:
> Some features require APIs introduced in a recent version of macOS. Currently,
> this is not checked anywhere and so either the build will fail (if building with
> an older version of Xcode) or will throw a warning and then crash if run on an
> older machine. The correct way to handle this is with availabilty checks. The
> checks are a clang extension that only works on Apple platforms but these files
> are only built for Apple platforms already and link with Apple frameworks.

We deliberately only support macos 12 or later and don't want
to carry code workarounds to build on earlier versions
(see eg commit 3bf445fbb1 which removes old ifdeffery needed by 11).
This is part of our "supported build platforms" policy
documented in docs/about/build-platforms.rst.

thanks
-- PMM

