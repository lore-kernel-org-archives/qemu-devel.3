Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD23C3DA47
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 10:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRqu9-0001kl-4p; Thu, 11 Jul 2024 06:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRqu7-0001jh-FR
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:19:59 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRqu5-0006rw-Lc
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:19:59 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-595856e2336so1176109a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 03:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720693196; x=1721297996; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nq4823TG2sDpzsypw4Y2OeiLpK0wI9qQaXrKDfZOUPM=;
 b=xVxh6JFaPXOodNaNbOqDcv3AKasyUhlArHxlsT1JoWCvB/79SXELLiqli7T/4M2pIM
 jn+99RyZ4J/8KTpxTLVrhtnDTxOZogCBMCLj6jGOMqvHLuU5t+zXcLkLSm1TuSQugEr3
 /VJD4iGVHth1m+Kq89JoDG9/5lX9Z8itFX/v0o9pjtnre5UJsF0dA9+rMIJq5JABCD16
 WKQ8o96HLCkMRNd+pj3x15juc9k8M2FRYZlXsUvR/XSdUCRv8Vk2Fdz1BLwY4wDoEQ4a
 4ODv45g/3+3+8B6HAWrz/BAZQdxWlHValWbYFluxZy1XniOJHwjxcNGMFURjLTK7ys5T
 NclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720693196; x=1721297996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nq4823TG2sDpzsypw4Y2OeiLpK0wI9qQaXrKDfZOUPM=;
 b=bZ7YOR3a9/sIqqvIed5oOLuOIzcRsnz4792gbiasZCtPSWDUJ1SbiNvkoRTVhBuKkj
 O4JvE8WsysUD37jwgN7f0lHCvQL6sUz35fzfNUM2an9kUa69AMgYsHA7rXWh5uSr1/pb
 RfoSTdf4omBKfF+lvNgQphMajtBiKeSMMX4Vp2/1VsniLTkoVsryDFW7/wHAGAhsfRMs
 CNdPQwoaRitSu5M0VEfbsFW4bQw4juj/Y8zk0S9cCKzjWLSUwuz7dt2wBBhWoUU/Al9a
 sTvDtPXrUan+Uo+GUcjkuGgU6Z2f23OLd45qEwv0zRdvtopsqEk+9ec8z690WN4K3vNx
 hPwA==
X-Gm-Message-State: AOJu0YyzkmFxkAqN2MQGrL1Q9pphlKuCpcoviVpiSydXB0sngbHgquKp
 7M4nfnr1xNgPwQT52f9OH298hVX+Omkl5zMsqZgt5a6FPhvXIcJB0xsYRGV3elKFhuYUEyg4M9o
 EUDhIEZlVLklR9Dx0e4bGkZqR8nOuxE2dGhDEMieymRS5yjrT
X-Google-Smtp-Source: AGHT+IEIF2cmMIAx0nrRXbEWjxGAVrO/0LWclqIXc3Uhx90tlkRqN8wgf1KxYdtg8v8vyrNvfEoeKHAhP6PihuUUeN8=
X-Received: by 2002:aa7:d814:0:b0:57d:4409:4f48 with SMTP id
 4fb4d7f45d1cf-5980e530e85mr1750111a12.15.1720693196051; Thu, 11 Jul 2024
 03:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240710173512.424547-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20240710173512.424547-1-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2024 11:19:44 +0100
Message-ID: <CAFEAcA-q8uUzHaF1KazB7uuhgpbtrTKdL153Btzwnz6pvuOPWA@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/arm: calculate cache sizes properly
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Wed, 10 Jul 2024 at 18:35, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> Neoverse-V1 TRM says that NumSets are [27:13] not :32 like in code.

NumSets in fields [27:13] is the 32-bit CCSIDR_EL1 format
(i.e. what you have when FEAT_CCIDX is not implemented).
The make_ccsidr64() function provides the 64-bit CCSIDR_EL1
format (i.e. the one when FEAT_CCIDX is implemented).

I would suspect this is an accidental error in the Neoverse-V1
TRM -- if you have access to the real hardware and can dump
the CCSIDR_EL1 value I would expect you'll see it matches
what QEMU is implementing here (and that ID_AA64MMFR2_EL1.CCIDX
also says that FEAT_CCIDX is implemented). See also the comment
"The Neoverse-V1 r1p2 TRM lists 32-bit format CCSIDR_EL1 values"
in aarch64_neoverse_v1_initfn() where we document that we
don't trust what the TRM is saying here.

How did you run into this? Is there some guest software
which is assuming the old 32-bit format and not checking
ID_AA64MMFR2_EL1.CCIDX to see if it needs to use the new one?

thanks
-- PMM

