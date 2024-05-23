Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96887C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 13:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA8xg-0003XR-GM; Thu, 23 May 2024 09:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA8xS-0003UT-Ve
 for qemu-devel@nongnu.org; Thu, 23 May 2024 09:58:17 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA8xL-00008P-W3
 for qemu-devel@nongnu.org; Thu, 23 May 2024 09:58:14 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56e1f3462caso12250782a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716472686; x=1717077486; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yzFX2McasZ+8V0Tlczr4K6m0eCEQEVhgKPAdmns9vpU=;
 b=YvWF87eb9n+vQpLOBP2eIUF0EaTGjBSxxe6hMzFrmYr44xqXWVCGhFquV9N7KLWnnD
 tKGsvGbC/nIV+fJobQPcoCkI1vy6wUsDXYFsOC3jnUypB79Qt5DRcQmDUGasjjQMPOZr
 C22M6cbt+sW3fBSKs075fWmk1TDrvjXCkVX+nNkIb6oeX+QjpN2oUFqr3hSYjL2/t6P1
 txlytcLRPpJ0lUuF4QQPX4aDpFRmdZh3/1LW/kEKhHlLynaIys89DcbEXzMIBBtYmzjr
 CoreLLnL11pMX6jReuEE7JktGGFxUMHGQYXI2biR/alPVWV8joPycvtVe9VwK39CfJ0H
 SkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716472686; x=1717077486;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yzFX2McasZ+8V0Tlczr4K6m0eCEQEVhgKPAdmns9vpU=;
 b=iWkNJRKsT+HzP+27Z2MymN/zaR64Y5VTKbDWNhEB4+Y/2U1vigVLu/CQAZ9GvPnBwa
 P3GJFz4SKe+JFWs78BiAGd+GFrUxmdCKQOJ0lPNzUYQIOWawYvq7yODfb7FMqXiCY2Yu
 R+ex43HhIF7SrV5assBi8isJisEpmAWXjF8LTnEFpowSqLCFKbUhJP77Sxz3Jqt0Mgbh
 KmDPhOX/M5lyxMr11PXLlxUwIdUepbW/aD1wwVLC/jBYqsLnq1L1z0Y02md0NiPRvwFx
 6yCgRcJX1g60lp6F8J+Atk43tRGLSsaylz5He8FtYWOCFtN1FtaTdIPTihVHBQUEpxWu
 NnbA==
X-Gm-Message-State: AOJu0YxEjSsXyaqj1PbQdTTaD88vNFGcUI+NVL2bOwd2HcmxvVQ088R3
 b7x2LhNPTnl4WVc72gGNQm65KBs3jxXXO9RsyeB1nIj24IHLcE6fbfPW8ECSiNpga/Hf8axjlrH
 WSEwiQf3+lfIkSgWHnpG9fbpNle5wVOEmGGqHtpNAytGEe7+L
X-Google-Smtp-Source: AGHT+IEB8gw4HY9/Ii8K6qJa7crlYlQKeosDrgxNw0go2jyGt1ZcHKOFrT+XXA9TsP//A4tFKDACDQ4PEVO7nq9kIxs=
X-Received: by 2002:a50:8707:0:b0:578:4c5b:98a1 with SMTP id
 4fb4d7f45d1cf-5784c5b9988mr461115a12.31.1716472686264; Thu, 23 May 2024
 06:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-25-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 14:57:55 +0100
Message-ID: <CAFEAcA9Uzhr6Lf+Vr7fRFEatzz6_L8WYGyrV+YkasUKxBX2hpA@mail.gmail.com>
Subject: Re: [PATCH 24/57] target/arm: Convert ADDP to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 6 May 2024 at 02:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h            |   5 ++
>  target/arm/tcg/translate.h     |   3 +
>  target/arm/tcg/a64.decode      |   6 ++
>  target/arm/tcg/gengvec.c       |  12 ++++
>  target/arm/tcg/translate-a64.c | 128 ++++++---------------------------
>  target/arm/tcg/vec_helper.c    |  30 ++++++++
>  6 files changed, 77 insertions(+), 107 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

