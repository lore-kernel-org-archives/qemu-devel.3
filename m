Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C827BE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 13:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJYkQ-0006uB-Vs; Fri, 06 Dec 2024 08:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJYkP-0006tg-C7
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:51:57 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJYkN-0000gm-Gi
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:51:56 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ffc86948dcso21969131fa.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 05:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733493114; x=1734097914; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MYAXp/LqnuXcI9snRuByYwYtzgOA+i9+vc1iiTasQiI=;
 b=b5VI3DVoicZowoboQadl23G001Hnb7HNYHNJqUD4F1Cy6zfzKa9sIWSqu6iDLAw/GQ
 RP2UriLD4fbX66bIxeFmdKOvpUsJ9Zlor5Rzs+PrOEdjSGsC4rZzAF0rqyisr9Ete64X
 gwzw4E5CWzFmR1H1xoooy3Bro18tGAuS1JpS0vCPPHG05W7B6udJYg/4qr4ZNlGaXY+Q
 x7vApNFbBpk0y1/79CTCE2rkOmh9j674V/JzdMO7ymVtCryi17TtpLCs9dSS6uLp/uMS
 YlOqjbiLlrUFyvFAmo0juTqjHmT8Piz7ezxXSZf3XQPJHnuyO6MR7TewOE34SLEf/q0a
 wZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733493114; x=1734097914;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MYAXp/LqnuXcI9snRuByYwYtzgOA+i9+vc1iiTasQiI=;
 b=cNDAN3UETx5aVZIs4zXF69qPwV0AbhD+YgLPomzBWC1aeq7BzSTH5Cj/UdA9GajyIz
 Q1Ev08S/zBYcdC6ISsPA1Vp+BidD65Yx5UzFO8RA8yWBNqrbt8VI9usQQupjYZTe9TdL
 +xD0BBVzNAh0AE0O2MOTTJiPKCcwcrBpEfWzyIJ+IaX2pYf7m9/RfOKUAbr3OuarhKyl
 56moKqhIFjP5m075E7a9w8CGeJikdImxi2vhV2bdTKcdFu6PuCaR/0oLddqABHNQp1PT
 oJrHqZAel870F963WIqiKESLjdR7Z46yGn1c1SUr1SfGpR+YD9zthxZmjGSOC09+jhNV
 ey+g==
X-Gm-Message-State: AOJu0Yz4ycQDuAloSu5H85pbCx6x459Y9i/vmjjThvDT1ZKrSf9rgw62
 gse9NmyoNgPppLZjMwothacpkgH2bPj9k1NGOekbUg1deWUf28zN98lWek+cSLo+wb+CDmKaOe+
 BS5srlVWAo39NINJzVRsqWWMEaJBTyGtD1P2Naw==
X-Gm-Gg: ASbGncvY5RVvD710IZsJl96+Q8AOVkdyBQucLZfZURLFiKP8l2AA0M20oPh10Fg+BIM
 b09D/6lla2+gGN2wThusfk4i4ynkTZvYy
X-Google-Smtp-Source: AGHT+IEwc4cmKyBZW1ITe1a0w2lHT/cMR98STJB/YkjeHyWFSZhObr07VExzGxD0HpVnnih8CwEmNbCzoXWl8Y+CD7I=
X-Received: by 2002:a2e:9e4f:0:b0:300:38ff:f8e2 with SMTP id
 38308e7fff4ca-30038fffb2dmr6340831fa.10.1733493113661; Fri, 06 Dec 2024
 05:51:53 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-33-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-33-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 13:51:42 +0000
Message-ID: <CAFEAcA_G21DzdwM2bpQuKwXH5W174UR2gA=zhRcSuOm3LqSYeg@mail.gmail.com>
Subject: Re: [PATCH 32/67] target/arm: Convert FJCVTZS to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

On Sun, 1 Dec 2024 at 15:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 41 +++++++++++++++++-----------------
>  target/arm/tcg/a64.decode      |  2 ++
>  2 files changed, 22 insertions(+), 21 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

