Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08D7C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 17:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXkTo-0002bI-BF; Fri, 04 Jul 2025 13:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXkTk-0002aF-W8
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:45:41 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXkTh-0008TR-7J
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 13:45:39 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-70e302191a3so9960787b3.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751651134; x=1752255934; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AhwglpwRI2YWJX5jT7lGq65I82pvGfIo9yNasOTcwRg=;
 b=BeDNezd6vNlYmL/FkoTG5A31NG8vNIuGfn+gaRe02XP07ju7YBQEyeg+0IxS01M7SN
 cdFoXVGPRsr9CiOzRil7f96mlHwodbo5yaLBF0a5mXhlGxqe0T/NgS+Df7VS8h3m9BdO
 5WYUXPKRVk+A6IvnRCmCwfF/aC3mccIBGnvBJtFnuVlaArC7K8uu5a5pI1ZSpY2ZvHuC
 Z+nG8smXolEMmk64CZyHkvZXpQSWW6vCQQUsZbk9UXjmRy6bJu9cPrQd/PK6JMc+T8eU
 wW+SPiEVT27OfuZnXqRhxL0dPli9ORmBLeDBZcYuVB3fmgkL9SYTeMgHm9YT011ziiK8
 5ORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751651134; x=1752255934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AhwglpwRI2YWJX5jT7lGq65I82pvGfIo9yNasOTcwRg=;
 b=UdXH+0UQgRWbtA/wgBwH39J5rXHkKZ/mvuhP5S7jH/Q8SeLIPHHUlHATfKz9jICCde
 mH8WWCh16uK/YIa90Xo7sS886lrmjHlb+N3DktMUmQUcoEVOcoVnMRYwFbSMhkIo09bb
 XhfOKOqITeZ7pUqJrrEnzFwvJTIhKAl1QMLd4HoAW89pMtCbYT/UAmo741sfyIHuC0/e
 Uwbbj/ZhkZ6LugjA2crWcMYpSkMiOn1fLNeTIqCjB//VKmFmjjWkkOpM+okDLkdeqMLs
 BstcZ9THaLm6gADQetzBJGwKErF38J8EO/LLp0KskEfkJD6GMUJr86O1+Ba6eMe+f4Dp
 D+FQ==
X-Gm-Message-State: AOJu0Yy26yX75hbv1GJdASnf0VHIbx0FMX4ITpihFSnNPam/UBh6HqTI
 VdCMJm8rjCKEuH+MLrixBoTwfiE/30OHHehVyPedZu0fLmeiKDNwiXGOZZp05+1tG+pNYBQE0hX
 hXK/e8oYJHf1mAfezF+upo48a8rNZbtFAZn1fVKyAzA==
X-Gm-Gg: ASbGncvvExh0fJiI3Ibf1Rn4UfaoWLVA2gwT70C7OMCrHJv196PoSluWD15d7bZCSat
 zJK7kxtSwuWHwgZE6/0GtZGQbpMt7GQvx/cbM4OjHYSI0ih339UGTQor5Z3Qm716Z1cwiD7apz4
 Y/J7kAj34r1tNFpxisn1WonorndPXCMLVcBhYiz6r6Bt47
X-Google-Smtp-Source: AGHT+IHtJWICdiGrI9wSZ8obWrGuraGbYaJAbLO4V5AelCOvvXYGmZlbNTfGR5tCHxjvKMexmqpYTFla3SlifA4M/eA=
X-Received: by 2002:a05:690c:6c93:b0:70d:f237:6a6a with SMTP id
 00721157ae682-71668c08c14mr52453267b3.11.1751651134481; Fri, 04 Jul 2025
 10:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250704165729.208381-1-jcksn@duck.com>
 <20250704165729.208381-9-jcksn@duck.com>
In-Reply-To: <20250704165729.208381-9-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 18:45:22 +0100
X-Gm-Features: Ac12FXy3z8z50GIEnkq0mY5vBgjFyVP_yBc6vwbfMQOe7kpeoyjIRp78PgIvAGE
Message-ID: <CAFEAcA8wt-cc7N=4MYEbNqBooYysX3H2xK0AHHtTNyPZYC65aw@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] MAX78000: TRNG Implementation
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Fri, 4 Jul 2025 at 17:57, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This commit implements the True Random Number
> Generator for the MAX78000
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---

> +
> +static uint64_t max78000_trng_read(void *opaque, hwaddr addr,
> +                                    unsigned int size)
> +{
> +    uint32_t data;
> +
> +    Max78000TrngState *s = opaque;
> +    switch (addr) {
> +    case CTRL:
> +        return s->ctrl;
> +
> +    case STATUS:
> +        return 1;
> +
> +    case DATA:
> +        /*
> +         * When interrupts are enabled, reading random data should cause a
> +         * new interrupt to be generated; since there's always a random number
> +         * available, we could qemu_set_irq(s->irq, s->ctrl & RND_IE). Because
> +         * of how trng_write is set up, this is always a noop, so don't
> +         */
> +        qemu_guest_getrandom_nofail(&data, sizeof(data));
> +        return data;
> +

I guess this does work, but only because the M-profile
interrupt controller happens to be designed to not care
about the difference between edge triggered and level
triggered interrupts. With a different interrupt controller
you would need to model that reading from DATA causes
the interrupt line to briefly go low and then high again,
to give you the rising edge.

The hardware here seems weirdly designed -- the only
way to stop it from sitting there with the interrupt
asserted is to disable interrupts. But hardware designers
do weird things sometimes...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

