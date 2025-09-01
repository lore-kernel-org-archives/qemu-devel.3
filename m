Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3061ACA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 16:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut7Js-00036m-2H; Mon, 01 Sep 2025 12:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut7Jo-00036O-8O
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 12:23:44 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut7Jk-0006sb-NU
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 12:23:43 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-723960ded6bso6438477b3.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 09:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756743819; x=1757348619; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RNyMi1J9ComDo9kbsxnoSfvoNlKLpUo5dVx/FtaQbbk=;
 b=d25RdqKf4rHmW9WM2E+mflatTZICLXDE1cMfyLJiaAlSKhtALwvIF29cb/nwDqzvCO
 aFrU/AvMlgo0PdoxdlJIhOSqkgn+gBgolqKv9P610MCnU7WJJ+cMqKNe4g9gyl0c900u
 XJKGq7EZwthAAtaq9bGbkkQxsi+z2AqKMkYg/UHjBA2/Bs2uDP7qY2ctMJ0unGQ2AqG5
 yBkGooba0MyEaWsY4CVaUgRGGKOOrI/ml0427CLJAPyb8KqwiS13cuSCsBnroCheCIxg
 6Nv/SJbM7Dyf4Xts0AdOvFixKYgTV38fuAwB/YV9e1pv9NSJhTQTe9T3fPX3bxlYNgDY
 5htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756743819; x=1757348619;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RNyMi1J9ComDo9kbsxnoSfvoNlKLpUo5dVx/FtaQbbk=;
 b=a5e1tkWjuQbQ7+qGgwMab00yU27KNoR2EOXjnFGIUvXNG3VEUkDbshqMhnnU7QVuPb
 ckFyKvugd1PGNIuwLtIKNUEy59tlu6MrCvSVU+mdkufU1/hBVTHOjleCdlBQv+0Xp3tP
 tbD5arMvXt7qR+GNY8iNqtwzYPCQDeB/tTgoz/4Li2eTfrbc9h7rHGmJioy80WQOHJbk
 NA1f9kY8WciLfEbkMFZJChj1C8Lxxr+OOrAv0y9P9e/Sbbmhge4YfIk7G39XD07XaddH
 GxvSO8rz723foH2Mgl+mbEJwlEQIvkPEOCJEXin1LxZgFGRQ6ahMOHUOZXC/UZAzbxWV
 bHCQ==
X-Gm-Message-State: AOJu0YwfnfTNF4QguohYjUSH3ESgcgsgQTxnAcAfRzcFHQJ2T2EH/Nsr
 5y+0pzKfvRPzdB3/FRVp0LmDhlp9IuCoMHlBKrBK+qMwyY6O36DxI2PBU1Oam7Vj4eiyxmHsPWS
 hByJrs2IhanMM1/MmzptGpGMLeCbWvsCr+clfZ8uf4OjW6zhPN2J+
X-Gm-Gg: ASbGncvCzgn0MoLzlI0GJZg/F5bLzcsxbNtNY31aAu4vY/HgaA8t+QGlAhsUZczMWos
 Ed740zL8sPXtK7zE+Ty3mQR3y0OhznoFWMoeLZkZySnH+8S7y/+SAVOLU4Q+U+9wCb4jRu3NiT9
 lBju8DnhQcEHQsbNGZCBdrzqcPANIM9066eEI2IfwyIvWTBH+tt+b1K+GRtkYp6Sd9xx+nfXQt9
 Ma13eG0oWXQzSeWmlc=
X-Google-Smtp-Source: AGHT+IFvLECNQksNxghAcwHL1zamWpO+A2RZPzzzPm5JacMBFgDzRH7Bco3UbD3VpHd8AXCzDJMc7le5dC0k05M93Pg=
X-Received: by 2002:a05:690c:a04f:b0:722:875f:2cb0 with SMTP id
 00721157ae682-722875f2e81mr54814237b3.49.1756743818941; Mon, 01 Sep 2025
 09:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250801174006.2466508-1-pierrick.bouvier@linaro.org>
 <3ca7be1f-267e-45c9-9894-67e920ad5ee9@linaro.org>
In-Reply-To: <3ca7be1f-267e-45c9-9894-67e920ad5ee9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Sep 2025 17:23:27 +0100
X-Gm-Features: Ac12FXwVzDsCE9Vu0qXTpOqpX7ZsS-dfR9s2jxtZSCwM_JomYkB68eSz7bOBIh4
Message-ID: <CAFEAcA991uW624qVvQe9Q+6JY7Qu7w+ksWJH6AExYghD8UtSFw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] single-binary: compile hw/intc/arm* files once
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Fri, 22 Aug 2025 at 15:31, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 2025-08-01 10:40, Pierrick Bouvier wrote:
> > We simply compile them as target common code, without moving them to hw/arm.
> >
> > Pierrick Bouvier (2):
> >    hw/meson: enter target hw first
> >    hw/intc: compile some arm related source once
> >
> >   hw/intc/meson.build |  6 +++---
> >   hw/meson.build      | 45 +++++++++++++++++++++++----------------------
> >   2 files changed, 26 insertions(+), 25 deletions(-)
> >
>
>
> Ping on this series.
> I'll be out next week, but it should be ready to be pulled once the
> trunk reopens.

Philippe -- I'm assuming you'll pick this up as part of
the single-binary work. Let me know if you'd rather it
goes via target-arm.

-- PMM

