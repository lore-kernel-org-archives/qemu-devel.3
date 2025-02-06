Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEE0C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5e0-0003kC-8p; Thu, 06 Feb 2025 12:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg5dw-0003et-JW
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:26:25 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg5dt-0000Ne-BO
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:26:24 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6f768e9be1aso19646377b3.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 09:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738862779; x=1739467579; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B8HFdeEuQRCJWf6pwtsuzHBb7GMosUbfkQ6wqkwk/Pk=;
 b=ZL3oVmeQNzWdDhT84VNVOu68CFuQlD9XjlJ6Wxm5G6p65VzS1QKy4TOnse3BR0kxFQ
 ni1xv/TNtUG5AihGQ3VRWvgIaYYEBEb7JLhbqaLUYPZ4+fryHfXUhyVClJpiJdUJO3q8
 VN1LRRvWb8g+LtdcLn63lvcXm/tmTuiDtUq+MNGd2LruYmOiO8weJ3P0k/QfRgnvDuLP
 xIbT2KU0NR5KXbOFUZ4vwXpXUkHiMOKuw/vlt9RJmwnZlemHOIWT3sPFO7F0SFZmN0L7
 B0WjevZMsI4/TKOlYGzlKBy6GeULrAes36PInRt9j6WX+GYn192WCn2yP6XNT4KJVVrU
 Z+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738862779; x=1739467579;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B8HFdeEuQRCJWf6pwtsuzHBb7GMosUbfkQ6wqkwk/Pk=;
 b=netr+tpx6/qDm3G9IwSQafWeA/M9ht1eSdJQfQnB3L9OTQaX1mfNq72/BuUrolT7jW
 SoTEpC5AK5wXM2IKIocA9EPYhOkKmmsPAdJoTgv+ydQboI+xCZnYobYhYGB4cafuVfV4
 TV4hvdiz5h34hMH7VsZ9oKJfsBPjZV4z3RsTQO4AS8pazMeCvGSN34n0RltXh59PraIA
 2um+lkq2CgTcwPOIhGeSP4geKZSHGaXTUBp7sN6Z898QreG3Hxo3rVMybaiaD7wxOW2M
 GZA9tLtS572cRdL88/K7kEh3niWYZqemMIkQ095KYC5K1VAJrTriyNb7TRng6EfUfXS8
 ufXg==
X-Gm-Message-State: AOJu0YwOtP8IMT1MYYg3MDbtXiLmJwoopHmuiAeuxFKgk67lZFvretTX
 9aGNQnRRKrYYYwSKhaZQwwJLfXKCG1Jy7vjcsrseS43YSguYeEiURkSU6oVy4RvOh2Ep90Z+rAh
 XT92WLv7tTH/MBjfQXIhv/xPgMdymw0IooAP/Xn4jWiJzMEi7
X-Gm-Gg: ASbGncsNmuFk1OyNcinqIQipp2tXyfLt8HoNEeKyz45i/nKOHtXwfufhm8SB9ovowa6
 /Y9hhuZalgVO11nFJiZTr4S4vt2XI5u5E5d+qSDfAidgqu8ACwXYonc6BcXEjxdr0xevWoPe+sQ
 ==
X-Google-Smtp-Source: AGHT+IF0m3kIB0HQ93AU9j/a5Q14SAJkQVugDw8sXhRDWbXFYbi2DszfJ++SMYrBxy7k2pZarCKQfqmme7tKfAKzdBY=
X-Received: by 2002:a05:6902:1791:b0:e57:87db:22b5 with SMTP id
 3f1490d57ef6-e5b353554f2mr3891389276.6.1738862779240; Thu, 06 Feb 2025
 09:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-10-shentey@gmail.com>
In-Reply-To: <20250204092112.26957-10-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2025 17:26:07 +0000
X-Gm-Features: AWEUYZnGRDFhmJWMjCmrxXqYZEB9VNvT0zSCG-xtw070TUF9N1zDw-Suszm_dL8
Message-ID: <CAFEAcA9KihqeayB4VsS_ogEKhEk_PD2OdV13i6LP=hXUnsw_Lg@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] hw/arm/fsl-imx8mp: Add GPIO controllers
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

