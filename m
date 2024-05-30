Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7D4C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfQf-0002Ng-Tu; Thu, 30 May 2024 09:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfQd-0002NJ-93
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:02:49 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfQb-0004h1-Lv
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:02:47 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a5cec2c2981so37139366b.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 06:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717074164; x=1717678964; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PS1VjW2JWzKAjt7ONn29Hyj9vLsp/2xtWp2G/vSvhZ0=;
 b=n5dlayiFMzNQpeXq2NrQ/q5mnviu1GPC4NrCvc03UESybdoxuRV5vq1WuNe4SYZpGO
 l8pvKHw04K0lRVld3zPngpU0Pyhhtu7REBzDhkaxyWNCCGlnO5tBBSgCTLm1P0EX6gW3
 S4qN09mwAwNPRlguXdLCCE5kf29IMVpnn6V/RMU3n2h1DBSKHT09yWTVwRUMqqZEhHtP
 PfmxZt3z2ZcPI2/RvpDVOFZIEcYNj+GCYzbBX3RihvKdk6mfdMbs+rYCxRnUoK6QOwxS
 39rF2uXNmmINaIycGz3UdZt75zTFvkNmbKRbL5w9jSDMvPfiTMhPuE6Xu6YjupNVNaCb
 3ftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717074164; x=1717678964;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PS1VjW2JWzKAjt7ONn29Hyj9vLsp/2xtWp2G/vSvhZ0=;
 b=izOwjUXexxcMc2FvoWjQGE6HIZVDnsNO8TEHK4DPOnjrhQZEl0K++c+yaosA6Y9tXz
 vfS5NmCwlpquD2xG85LUtuK9W8EsyU/NSE7HWiBLHzB0oiLrJB40xqUDSwWJx0X/fY1s
 5Rgv8qQs09gllHeE/kn2cVUedRPosGnSqhY1URu4xOb4jBjGyoE99PCxvgJo8WKMOtRt
 uOOEy7MUgtAiLriSY1BG0s7dLtWF9EcKH92A37WYzi9tIHi7o9tspLzhdTqihMdH3KMM
 E2ebuRJvoXIWF/qjAmbyZ+48T8cNYcZgMS6oZZG4x/axLs+TW4Cpsj9JqowRL13q0+OY
 wV2w==
X-Gm-Message-State: AOJu0Yzpm/ItOeuEY9Gl9wZk4o1AmF/CFzlp16SiALlNFcCpO4ZGn1M7
 Z+i/E9h5M5dfqnMdJlhqwe6IxpnzPNPZFKROBrBHCAgtRsPEQeICSRYUZWiLj3BHU6dk8UcxHdi
 sNGsyCHowpf8arRSsOp9kr8y6s2UupzHHjpocYg==
X-Google-Smtp-Source: AGHT+IFOg29wS0z5M4uZiQXilU0o2tGEGIXS+wu9yGN/JHB+MMEC4le6MZH6H+uc+dfQMT7VaZgc5PuqJeFZ2WYnZ9o=
X-Received: by 2002:a50:d498:0:b0:578:5dc5:a4fb with SMTP id
 4fb4d7f45d1cf-57a1793c0cdmr1359202a12.32.1717074163667; Thu, 30 May 2024
 06:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240526193637.459064-1-richard.henderson@linaro.org>
 <20240526193637.459064-5-richard.henderson@linaro.org>
In-Reply-To: <20240526193637.459064-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 14:02:32 +0100
Message-ID: <CAFEAcA9_ANQ2SHsVZ4MPp4Sw6pFBmvPGZF7VmyguUgGdpFh1Jg@mail.gmail.com>
Subject: Re: [PATCH RISU v2 04/13] risu: Add initial sparc64 support
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Sun, 26 May 2024 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Best effort for both Linux and Solaris as a host, since the
> gcc compile farm has more working Sparc Solaris hosts than
> Sparc Linux hosts.
>
> What's missing is a value for %gsr from Solaris.
> This could complicate comparison of VIS instructions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

