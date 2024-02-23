Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3CEC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 09:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdSGK-0007WG-HL; Fri, 23 Feb 2024 04:54:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdSGH-0007Vh-1V
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 04:54:33 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdSGA-0003Wa-JW
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 04:54:32 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-563c0f13cabso200748a12.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 01:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708682053; x=1709286853; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UfSa1JIPQDgOPcjSwttNa4K0v5842px0GxwssmihDe0=;
 b=MH3MMRpPGwqcco/7TDFd3x3XD8wGgv0hxE7hXJxxkQn7OSv73Kfl16SV0Jm/dYb9gc
 FKW0KnrYtN0+hEpb19ejJVxAnCy09Bk3BYneB3MJK+KwYbL5kVDY6cwZB5tbl6J475o0
 cSoft3Xwqw37U//ceXuw5Uhgf/AIVbWrEuj9PJv786VkFFPOL0xpmnW/wss9g08nh3RP
 OlPvQN4lM37CTbvmdLSWo9HJZciGPnEqJyBrlwwH2Ana3UCRYnkdoSrV91IDbG1tsCvy
 sE76q+gkAmspJ4q2FuzgU8LySdUBLUtLHXXzIGsoFw+XTJzrztQrzbh8B/tSrtpzfarn
 jeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708682053; x=1709286853;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UfSa1JIPQDgOPcjSwttNa4K0v5842px0GxwssmihDe0=;
 b=dUdxnxLUXO1cNYAE5jwTpXhha5Z/Nix02YN2icWI01GxlUgY6yee/iUz6ZntxA8HoQ
 mToTPBYDj7PcGy+QvBjYciptKZwoXgjp+Z7fBKjwHzqJdwaKfxqHfQSgeI/hcFCoSpgA
 hqR0V+bGkgIiDavs5UZUARHMyc6C9CGPswQZiL8+aacZ36/Z3QIEx/RONh1eoh8xW3W6
 /5G6/TwNB2fgP6gcyGUWpjDEmzCNl19hDw/Left6UiL5ivPwcH5SyRVDAltTgffSD7zK
 BKovZJLxrPuRTH/YGrDEoJO1iR0k7h5YVWh5SnUdNMSgqT+C7ci7NslZtRE5duKXGjKL
 1L6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw22PEe8fc/D4VcVd5waqGYve9bRIfqlAMXUDhE8/tat96AvjSRGWpijD7baJ/bfbAEV1/bFXckB3Jsef2f6IIOgfS0Uc=
X-Gm-Message-State: AOJu0YygmNU22nQ31BFzAF6SlbaKrLm447CBvYRnfoeNBoWaPBb/MAvO
 b73jSGvakh9ezkd6kYrVd+NiiMMu9Nu5kGIK5eAYN2cHjW/8HHSeIfu1DnuP8cAQubDr/5ELlyQ
 YGZuxoVWYYhTercfNhdikjfmh5kNeSxr6gYeI/g==
X-Google-Smtp-Source: AGHT+IF7QYTkWyqRIiI4B+0jAi6zkX1YhQw1460ZTaWnJ/Pkxqf8UaBnYTgccjNcR33lfpDqCwcOV5cQ3kiir2v9CrA=
X-Received: by 2002:aa7:c990:0:b0:564:e278:60d2 with SMTP id
 c16-20020aa7c990000000b00564e27860d2mr856753edt.2.1708682053226; Fri, 23 Feb
 2024 01:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
 <CAFEAcA-Wir3M7dVV5247uMPxCtrYs8j4Z3S7nucCx3Ha8pA1dg@mail.gmail.com>
 <caf1110f9e9445cab3aa00ebab24d263@auriga.com>
In-Reply-To: <caf1110f9e9445cab3aa00ebab24d263@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 09:54:02 +0000
Message-ID: <CAFEAcA8uDn6v+6jTDY_wbSmcFq=5Rao8LB=ce_RU8GCtuHzq+g@mail.gmail.com>
Subject: Re: [PATCH v5 00/41] Raspberry Pi 4B machine
To: "Kambalin, Sergey" <sergey.kambalin@auriga.com>
Cc: Sergey Kambalin <serg.oker@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Thu, 22 Feb 2024 at 18:15, Kambalin, Sergey
<sergey.kambalin@auriga.com> wrote:
>
> Hi Peter!
>
> Sorry, it wasn't intentional.
>
> How can I keep the tags from v4?

If I reply with a 'Reviewed-by:' tag on a patch, and you
don't make major changes for the next version, copy that
tag into the commit message so it appears there under
your 'Signed-off-by:' tag when you post a subsequent
version of the patchset.

thanks
-- PMM

