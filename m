Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9B2C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzK8-0002v3-9I; Tue, 28 May 2024 12:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzK5-0002kt-Gh
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:05:13 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzK3-0008Ao-ED
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:05:13 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5755fafa5a7so1325496a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716912310; x=1717517110; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TbmHJuvd9skI6hjG//tiPz/xdB7vTwogbjGsB3+L8Go=;
 b=AVoI0q7T4qOhv2oZZ3ArTFdqqc0ZAwGWgGbo8aiIQybwJtLjxbXSDK0b1Q9gjZmdii
 +4rj8dwVU789QvmaMLRfCM7fpBbsOYXbUJ5sQKpagPORmwSxeGaJD04ipnetaL2vDqSJ
 Z/91hFASdYuknNog0edRHVVZaPIO5QhR2kEqfbpzdL+0b7YXDytpZ4Vj9Dq4uLeGT+72
 s7p/7+Z+0ziz998UhpTIgdYqPEwtwlv+eRjNGdfpkNfeOAohhADvP8nsd4fcxJFrnXbC
 OlvlxRnBi7/D2vxoiFeGPH6IreLknDxYhQRbCHcSfRlWOczTCfqH4Zi0jlLFtqWVx1D+
 8UMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912310; x=1717517110;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TbmHJuvd9skI6hjG//tiPz/xdB7vTwogbjGsB3+L8Go=;
 b=FUXNxpT2LWUq1s0i+kmYnOpRUZylFnWs5ypopX6AHDjRsNdSZdEcDt5WKTensAjSkH
 hR/OALON4w4hE2j7zrdEiAdVUZCrT3w5Ts7sL2SckqfSJi2XO2TCCOGHtgmLHAMrfbfU
 XET78zj0q4vWf+cwzjhMt0uTbaT1Uga1vF/YEKPF0SRDwb/mg6XsOnTObtVfgyYwi79a
 lDzV32XhjKdHr39wpqRS4H6vcnknb5Ft77GbWZPmDkkbD8HXp4tJ7gk9S9wnqyOwscRh
 jd76vIGDOJEqanjOqDV57lDd+KSZkGWNtoX6gWGGrpazS7Zz4NRmKn15nyLCQLRD5TUS
 ckYw==
X-Gm-Message-State: AOJu0YwH71YkT+FljOGSdrot9012i1/LIr0JngIRPJbqh3JcGfCiqSKE
 BuHofnPQRcL6wAbjHyRatvejnMeas7wBXjqskETqTP6jdQpQpZFVRUVTwUoE00q+Ki1DhuNpvpS
 ETeZatkaHNdn4f8g66yqSdpv7ay4ST8Pug3XRHA==
X-Google-Smtp-Source: AGHT+IF61bt9o1gS7FD+I1nMAutWbKM9YVHaMZn5WdZ2k3RQ2ibQW7ZFYF6HeavJUPHe1++NXqfrpTuUPeuWhNRh0/s=
X-Received: by 2002:a50:d75c:0:b0:578:62e7:e5a4 with SMTP id
 4fb4d7f45d1cf-57862e7e682mr7012440a12.6.1716912309971; Tue, 28 May 2024
 09:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-61-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-61-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 17:04:58 +0100
Message-ID: <CAFEAcA_yDMmyHKzHRGd735O2=9n86p0Zm_wUBWgt15aKEOmmPw@mail.gmail.com>
Subject: Re: [PATCH v2 60/67] target/arm: Convert SMAX, SMIN, UMAX,
 UMIN to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 25 May 2024 at 00:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  4 ++++
>  target/arm/tcg/translate-a64.c | 22 ++++++----------------
>  2 files changed, 10 insertions(+), 16 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

