Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E719C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGxl-0001wQ-17; Thu, 03 Jul 2025 06:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGxg-0001sz-W8
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:14:38 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGxe-0001G9-KV
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:14:36 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e733e25bfc7so4814111276.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751537672; x=1752142472; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DAdw1JU6QcqbemXcyoAYoUX7dbH9h6/ZiKNeCYV0wNM=;
 b=SGu/MyfCAqi+/ZWfcFVSfrBV/TA4UC6XY1VaWs3VoImdCbVOAGnpSs79DMGx2ygdR7
 Y5gRCgglLgam8vr5wZDLEgOhpOgfdlzReqkthq1hFre6CYb8913uLEZeO1W4vp9g7s6H
 cog0XF4rp4ZqfY4H0SgI52jSKLDzN0AhWtSRAWNZV633bSwYNQ4y3xJs+ScXTDxd9cPV
 t1IYm0FH1Bz2+cS28k7q7vHFSICYM8pRYPwzLrFZH3Bw19p53J4RfiVJendPv4T2s/2q
 /8+BF+L8zL9iffhLaUiVz10G12+QTkwGMwLnoYXEMHXGRcWDfNDAWJzs9/qX1wCh8OFV
 CPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751537672; x=1752142472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DAdw1JU6QcqbemXcyoAYoUX7dbH9h6/ZiKNeCYV0wNM=;
 b=ArZd2PjPRuezrWSbWw/BFROWDWohqZSSFeYipPVdZKmWjYp5GvZ22b9tujoRu2creA
 HedpI5SqevcNtimv5U1tts6rjwN144eWng9e0VoUjzRu4DsTMlYshhXNeCaqBN9GvVbS
 F0khdSVUgllM0lscnMdtFW5AsJdX9O5ZbfVP7Pvcb5RAfzyqd7IT3F1w8mZTrg0Z5f5l
 34tTH5xFY6iQ37iph+EuAgx94/VdNaOAjSezpKVuQuZyn3RhtCGkGwRnmnh2Ypt/alWt
 zuNGWC3GmfSkMqrW1UbJTp/mJF7SLv498C7q4jBZYav41DZXXmGJ8FEtSLzA9FyYslAv
 vl7Q==
X-Gm-Message-State: AOJu0Yz1nRr8C8gNzoV6x2sjDuXjvWPH9L0/riGmbEg4AJh0Swln3GV3
 iF6DJzktBSP0mx2vtH8VWw/3sb/lsyNSjgQy+UfPB2afG+m0StammDWMXzjDxas2RJkd1m+ZUXj
 vdmThAkoipMadUTG9NVdzTEnjovpiLwJl/VybaBOXZg==
X-Gm-Gg: ASbGncs9aTqpR9eDuEs6/7a6g0X1uyzYKWRmkwjc3zL+YFH2xAZcSs+v81mGodB2qcg
 UV7MvGQ/GYu0x7VlGoaaC50V0Ns+kwiahiokxVwR8VH2w+8RT3+daxLYCxeom045pfXHoMYlgaW
 F1lXYSVh3PKmxGwApoMXwzt3eWv5Cgygl4JQssuRu1T3si
X-Google-Smtp-Source: AGHT+IHklzEbQiRcdtw5IHxwGlyWplbhFJCU64Y7BW10Irm8ICI9FFh2dz4wt1b52F3KdP1zqN1krNdFoPWTFfUKkIQ=
X-Received: by 2002:a05:690c:6c08:b0:716:4ae0:7bf3 with SMTP id
 00721157ae682-71658fdaeb8mr35302627b3.5.1751537672233; Thu, 03 Jul 2025
 03:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-45-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-45-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:14:20 +0100
X-Gm-Features: Ac12FXzqdkLTqcus4fsyFzGRJ_-B5xJwjxHr9PWCq-IW4HQz_GRje5Hxdm4gz0U
Message-ID: <CAFEAcA9vjdu_V80QzmGgheYJRmYhvcjO6p1ouCHRuMokKdsKFw@mail.gmail.com>
Subject: Re: [PATCH v3 44/97] target/arm: Implement SME2 FCVTZS, FCVTZU
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 5 +++++
>  target/arm/tcg/sme.decode      | 9 +++++++++
>  2 files changed, 14 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

