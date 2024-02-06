Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40847C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 17:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXPWf-0001NX-03; Tue, 06 Feb 2024 12:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXPWW-0001MG-22
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 12:46:20 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXPWS-0002a8-OK
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 12:46:19 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33b1d7f7366so3132426f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 09:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707241575; x=1707846375; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tp+8vZ617JGjQNAydqXDnkXmQj2eSEDuQMcwtamx0mc=;
 b=IimpNZVmNnGx3+ouZO7I2ztYIYbCuT2gJr7/qYPLvSZYsRzUe/X0bQnPXGhf9hEeN+
 KMw0kL81XjSzZ5DJbhWnsrAGpujHy8tSYzU6fheM+iBu/la4IpLVWoH/FsHg57/BRG08
 OMCkIExZ4tANnRwl5wn0ifVoZ7mfYDaWvtlBsIygVxIMgTW8DXl9/EvKPifiIygv9zPq
 DnvKJ/PmCWoc8bOlMVtWr8Xdv5dDSq5wX5XmsEdEw4QdZDWykTnLnb2Iv/XJ9YEgqGDn
 7nu+LAzwVqydiecheOXhmQZPu3PwckoaprXX+EryXq8Y5VWwgbjdCQUY0DgvPEUrOaNH
 ZvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707241575; x=1707846375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tp+8vZ617JGjQNAydqXDnkXmQj2eSEDuQMcwtamx0mc=;
 b=rXOlQ/WHZpL5lpUkjJxQ1U09xZWXgsJBhMj8uqOQUZ4Y+TlDV9wbW3MPQV6tLREj8F
 5rJc1hbwCXdW0/5LyqKl5+Y3fQF5o0xRZXivEkSLmOn6z4kIe/vJC6rRq3u7/JecfHZl
 hCmhECaUB3PCLvEY4qBWDFnsDBDIIoU9q56ydu2q2ZJiX5b9NoDUmAsX2x1pNESyTz8E
 2WDMoCBnLIv2lFfuDzzfc1EGGgMSU6acw0d6ZbLQJbVkSkCzayrrJQPCmofdnQwWoNsQ
 +HRB+hb++6MR5SEWGeBIFMG4dfzYe7INPFGkdYLcCJ1+wQmZHO8Aczn2uj8ARglw8HMs
 XytA==
X-Gm-Message-State: AOJu0YwgGXEVZnVqgZS8EP9Rwea9w96u3UXpDt9w28I3ygoWh/2s8iG6
 X1XuTOx3wAK42psi3pQ5tx9SPt+2HzlIkYE6a6VLwx+/YyW/MKPMzetLtb6+ySUq/uv/JNXXQ8w
 5t6/VJ33lu3oOvlTOz4l/0y55YckaQbblnJ4wPg==
X-Google-Smtp-Source: AGHT+IFMytTx45naEg659TfRjQkOcHFSq7YTnK0S7gs1hbICXVC5NLy/lN7uf5LbzJvKRSyzbSVBNuqEllKeA7ns6e8=
X-Received: by 2002:adf:fc88:0:b0:33b:304d:36b7 with SMTP id
 g8-20020adffc88000000b0033b304d36b7mr1686640wrr.56.1707241575063; Tue, 06 Feb
 2024 09:46:15 -0800 (PST)
MIME-Version: 1.0
References: <20240206171231.396392-1-peter.maydell@linaro.org>
 <20240206171231.396392-3-peter.maydell@linaro.org>
 <bfbeda026f49803025e2a90e41c5e043c93d1a59.camel@infradead.org>
In-Reply-To: <bfbeda026f49803025e2a90e41c5e043c93d1a59.camel@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2024 17:46:03 +0000
Message-ID: <CAFEAcA_-opZFSEn4DLGzkpGkoAxJsCpD87SR2Hn3mGMtx-Hy7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/qtest/npcm7xx_emc-test: Connect all NICs to a
 backend
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Nabih Estefan <nabihestefan@google.com>, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

On Tue, 6 Feb 2024 at 17:36, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Tue, 2024-02-06 at 17:12 +0000, Peter Maydell wrote:
> > Currently QEMU will warn if there is a NIC on the board that
> > is not connected to a backend. By default the '-nic user' will
> > get used for all NICs, but if you manually connect a specific
> > NIC to a specific backend, then the other NICs on the board
> > have no backend and will be warned about:
> >
> > qemu-system-arm: warning: nic npcm7xx-emc.1 has no peer
> > qemu-system-arm: warning: nic npcm-gmac.0 has no peer
> > qemu-system-arm: warning: nic npcm-gmac.1 has no peer
> >
> > So suppress those warnings by manually connecting every NIC
> > on the board to some backend.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
>
>
> ... although do we want to expand this test to cover the GMACs?

It's very specific to details of how to program the particular
ethernet controller. The GMAC is supposed to be covered by
npcm_gmac-test.c (but that has issues of its own, see
https://lore.kernel.org/qemu-devel/CAFEAcA_gkQz7q+PhiqrVd+YrVJvLt1H=Ypp4av9qn+6mYC6jdA@mail.gmail.com/
and in any case doesn't yet try to actually exercise the device
beyond a rather minimal "check the register reset values"
test that doesn't need any particular backend connected).

thanks
-- PMM

