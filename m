Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09805C27C50
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 12:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBw1J-00088G-7W; Tue, 28 May 2024 08:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBw1G-00086n-CE
 for qemu-devel@nongnu.org; Tue, 28 May 2024 08:33:35 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBw1C-0004Fa-UX
 for qemu-devel@nongnu.org; Tue, 28 May 2024 08:33:33 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-354fb2d9026so660034f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 05:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716899607; x=1717504407; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q7YMTLqkHC4fWohjIg2vd7qVXGW0DOiWQb9NkyMeib4=;
 b=Ji/aGyJD3EufE00gyP9GVzYLha1h3DYikP+hOAF/DXg2CNQ3C1PzQTbbiIK7FgLZZQ
 S1a7L7WpV8ybXKGSdo34Y8x0PeEW8pv1UzQSN04XSuie8PoANKq3UxHvy24wvj4Lvqmt
 geArJsIBdQfaXPxxa522KdShp/W6DM/VKLusxqEec/pig8pXtf1/4ZOKzkr242p7YW40
 6OvN2N6ypnm2ZjqN/uCSOUXzVpuozA55qzMv2MV6X3FTvnJs1CH/FuYT4A3+Drn7TBpB
 xstRQ0DbhkSaI4V8WdcWo+A3hZl7MMhoFtHHYhkcLu3KRNmLzb3w0cU68RC0I8Jmhvmu
 sNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716899607; x=1717504407;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q7YMTLqkHC4fWohjIg2vd7qVXGW0DOiWQb9NkyMeib4=;
 b=c7iQoF8EN+TzYACpDMdvWj8zfXqjIhPTG+CRyxLtp7fxGI7Rw16XXkE9Q3LCn/2jrx
 q3hTPZEEV+U7sIauH6ir06XnqkOQ3G+A7Q+jqEP5ssao2BuIerYf52xENlbtmnj3eSwL
 gaFeY8NNWPAhgcoKUrUi9PHSLxaRhx6gn0L2FO7pG0ld3epmyLUPTq5VVUTHBA4LAH8v
 9Euf+7yUm/rd5Bu4DotVbcuj7poP4u0meGlLFEp5p2wp0yUHuCPxFLtPHQEDmdOQXKyf
 mwrmxeaWDOxQAV6E149Dz9OHaHXpESISkJjCqHvxUHL343Z7W3Gl+oR65ePChH8WM1Du
 mfQg==
X-Gm-Message-State: AOJu0YyLWrKZU3ng/p0q/p61ahoCNRPj+wAWXJYC9M2v94xKcLCsYkYi
 GbJlspCj/TTSInHvQOzryVaLo17JLIASG1+WH7u//7bpR7AfCaCpCGp9Y4/x/bYcuz7ylSoEekX
 HgtFRcIVXWrqBoEnIGidqFLd0kKrHq7uT2dvQcUo6sF86PrjR
X-Google-Smtp-Source: AGHT+IFRSHnm8dwTvsTLkurJXAE0wjAu3t/UxytcICbY84m5G7nM1qRqMjmm60CPbDXRrAjLtzp+puWelIF5G7iYffI=
X-Received: by 2002:a05:6512:1309:b0:522:297f:cb06 with SMTP id
 2adb3069b0e04-529651988b4mr8081085e87.32.1716899123668; Tue, 28 May 2024
 05:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-7-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 13:25:12 +0100
Message-ID: <CAFEAcA_5RMV-OU+U+0LAEEQJsag1MF-La64JtqzTcN7EZ6u3_A@mail.gmail.com>
Subject: Re: [PATCH v2 06/67] target/arm: Verify sz=0 for Advanced SIMD scalar
 pairwise (fp16)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sat, 25 May 2024 at 00:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> All of these insns have "if sz == '1' then UNDEFINED" in their pseudocode.
> Fixes a RISU miscompare for invalid insn 0x5ef0c87a.
>
> Fixes: 5c36d89567c ("arm/translate-a64: add all FP16 ops in simd_scalar_pairwise")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

