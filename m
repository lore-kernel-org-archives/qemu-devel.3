Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16006C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5h0-0007Yj-TN; Thu, 06 Feb 2025 12:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg5gy-0007Xp-EJ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:29:32 -0500
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg5gv-0001kL-VM
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:29:32 -0500
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e5b22d35268so1104809276.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 09:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738862967; x=1739467767; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LtBFBQ34iQ5GlvLvrgRafbPTcpDdZxt65lIrC0bLP4g=;
 b=OqK/pO9zMmolCvU4jvyb0Vaco+TMDDaYnuFW1WiHh5oU9jujFf8HScUlgWtSVrcZbv
 P4IfWBwWBjAbXRreTjpcOPW+7JNifazgMQXDhJO9xv1uMfWnoYM4ZOBCBsWVEKUs+rgr
 APs234BnSvyEJ0Ou0oZqBnRF3oILSyKR0YkRFDKvJV9uWpZTmdJFWwsxIvAsmq7USem8
 HbUSuPXFSJs3rZgGoxRM7uReS+rN+r4mlhzOS6vZwh/RQMBa5KQilROXEH0F18bkAYzB
 /uF1iSjdqGrShePbQ9LkNo/h2lFPEdHfCqamMuNzTa49Oacy/9aip/NvrNAtFDIelweF
 iYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738862967; x=1739467767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LtBFBQ34iQ5GlvLvrgRafbPTcpDdZxt65lIrC0bLP4g=;
 b=TdPJL2NjIEN35RC3qQmgLhp/c+mOTTPErlmeik+vI+IPCABe6bvQMJHIy+H7l85xX+
 xNMQko5ZLTc2aYDXCMcg9J7ngyKxdP3oZSck9ivia5GVQVML+g/fSc26lAKA5ltwxc/U
 UmIsg9Xe7eS1HFSmp7vbrw01s9dlvf+qfgn+IZbhnmTL1/5uxCEMlqsWIXu2ZrRc/No1
 mv6HyYmL3FxO6WxsHrbMVisYynmy7hoScjFF03TvlJXq43g7FmiWf8AY0WLRNHQQfY/u
 B3TCtQ3ywUBy6CbIVWtvCzU90rHVHNOOw6he5iL0PikmaICClggb4not43fT5gqZLibW
 eNTg==
X-Gm-Message-State: AOJu0YwCDPLtHkJkrnhYT26hC4Esd+NTBlfzo/wJj+xHuB2bwC5PEHSO
 7JxF9ll0RVbev8XaiCU+zXhG/zStbB6SjzNdsvQfNQ+wfUx3n+x2er5a6lGbYIzpNAiZ8jnmKwS
 2Y6pX/wbUUS9f3z27/Ev9UlAAza1t5GgoMp4Ilw==
X-Gm-Gg: ASbGncvnwYIqaB7YYrg5VeDt1wgdja8R02N8yQXPOjHVTh80DLjh63oUZ8iT+NDW6NB
 J6wzq4EOOrwPTFWV0rZLtAZyWuj+QlZi+yDQh71LzA+kx22H5irmBPVhU9IzMgtnknfjnMGKDpQ
 ==
X-Google-Smtp-Source: AGHT+IHCeXHdcv5n9MoThmAHh6b6OfDltmV7bQfj5uG9qBJJN3EqXjvK0dAfCY+ppV871mZBmmUgA/riEyPRGYEGX10=
X-Received: by 2002:a05:6902:2505:b0:e58:3741:2748 with SMTP id
 3f1490d57ef6-e5b259cf95amr6764564276.7.1738862967626; Thu, 06 Feb 2025
 09:29:27 -0800 (PST)
MIME-Version: 1.0
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-14-shentey@gmail.com>
In-Reply-To: <20250204092112.26957-14-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2025 17:29:16 +0000
X-Gm-Features: AWEUYZldbr2gTqQzb2phM5bIu8583UkV2mcRBeWC2rXbGqIIXY9m9HQvLcImmbA
Message-ID: <CAFEAcA93kevhjQHWjbZFMRaka2LSTr+jYcT7aA_AyrTDsKcubw@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] hw/arm/fsl-imx8mp: Implement gneral purpose
 timers
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  docs/system/arm/imx8mp-evk.rst |  1 +
>  include/hw/arm/fsl-imx8mp.h    | 11 +++++++
>  include/hw/timer/imx_gpt.h     |  1 +
>  hw/arm/fsl-imx8mp.c            | 53 ++++++++++++++++++++++++++++++++++
>  hw/timer/imx_gpt.c             | 25 ++++++++++++++++
>  hw/arm/Kconfig                 |  1 +
>  6 files changed, 92 insertions(+)

Typo in the subject: "general". Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

