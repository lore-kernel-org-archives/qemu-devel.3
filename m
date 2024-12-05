Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B6CE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJIbO-0002oI-8m; Thu, 05 Dec 2024 15:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJIbN-0002n5-44
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:37:33 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJIbL-00056t-GN
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:37:32 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cedf5fe237so2028527a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733431048; x=1734035848; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xEyAkDhxBFjaRSAuSFJ3Wp349Y8DsVcysYVs3R5DPes=;
 b=TZEfa8/WTyk4cHMtCpWlEyDvkaopHuMHgMBQ3DRFLGjEUivQQBKcZTvBCPVjumdNlo
 +CBRUuS6SSU5Mc7TsNzZRkBR7sfB3tkr2uBef5hGUbda1R/UWVj0TgdzzwmiAYNt1LiA
 vSa+drgCwPizhz6RvMEEjGrC7qo1YGPYmbalU7YDfpWJgg7oP5xyQUmnKTMNUicFkGoC
 mP36NlafOP4a4gZ9Dsjan/yMwvT+oCmsBObHCm+etvB0HPpcPn0HblvNm7CMMeEyGXIp
 Lv61yqrA4DoachpVKzm0ltfwHBA62INB09+90WRHSqkBzokc54nMisu6fNJmO3wos/B2
 Rrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733431048; x=1734035848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xEyAkDhxBFjaRSAuSFJ3Wp349Y8DsVcysYVs3R5DPes=;
 b=KFd1qCvcoJW1fNM5+Lnl80anqErlO/doCrvuihSnmlQmoTCTIUTBtZQRwNjyWnSlU7
 gpcVBEdIQ8p6ObqQPeoqZGFMwA6DlPmC5U6Pbzi0WtbtVIVmmaJRekVp7ZebB7bh7AgE
 uag8Zo17gb28PUnsSFLy37q3WehD0Pled+Xr5zozLt8oaDxQUGg+dVX+ZYj03Rke73aq
 eP5bTVvQJHLFJAInyqoqZn67qK1xeV/85hQ3ZXxZNWb8AO9Ioqb7CpHpF3cIfrcOzkSu
 384HK3RzwKqu+HO8CSqdlFUdrjyYDR1xwDQTLXxUEhaNLL4Wx3WLH1buWEcud91Ln1G/
 Jx7w==
X-Gm-Message-State: AOJu0YxpnLfz29RffXmQFRMwBTLMN3YjuGW0QeNvsKuWExPtxXIEl6UP
 EVogDbtn3vVSw2ryiGjTK+dMTyJE9yHswOakfqQgDVDCjyU3ihUG2TEQanUt2MJSfRr7xVBgJx2
 l3pDGghE5p6Yp0fwf8r0v/4Nwjc2mHYggLb4obviBJlu4zEqN
X-Gm-Gg: ASbGncvCFtt1OiJaKZC1hLg38HovllinDBn1Tk89h48UtvpPjWmtaQ8ha1tke5aC3Ql
 M5J9+r7+0UUo1D7vTojhM9b78vXnYEamD
X-Google-Smtp-Source: AGHT+IH+yXFAonhUumwtX1wPWBbGYN/V9Ez08hWwp84koA4SJ0aTRJ2i+MDjL0Fs/pp28czmW5IWUxzp7SsB0DnNm64=
X-Received: by 2002:a05:6402:2550:b0:5ce:d028:e11 with SMTP id
 4fb4d7f45d1cf-5d3be6fc30cmr487595a12.17.1733431048528; Thu, 05 Dec 2024
 12:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-22-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 20:37:17 +0000
Message-ID: <CAFEAcA9KvF1p_OHz8YiyqXDm8BzPUer1X2p3zYTaQv4afsLaMQ@mail.gmail.com>
Subject: Re: [PATCH 21/67] target/arm: Introduce fp_access_check_vector_hsd
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Sun, 1 Dec 2024 at 15:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Provide a simple way to check for float64, float32, and float16
> support vs vector width, as well as the fpu enabled.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

