Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA71606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KyNkmqsf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKunJ-0000sf-8D; Sun, 25 Oct 2026 05:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKun8-0000qg-3A
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 05:45:26 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKun6-0008VX-7H
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 05:45:25 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8ac9d666d4eso16011337b3.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 02:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792921522; cv=none;
 d=google.com; s=arc-20260327;
 b=S7tmLa+za/X06G43jQRJjf6ehWnHGf5OoFE9TeN+IxM04pPhTwU4Och1tIkBgpFo8B
 9jNLWusaQNwhS/yXRrY7CPB4+fscxbxvB4Z+Ck1OqGz+MtKHvI+RFIxOX9fxM8k95xvm
 m/eZPp9X8gUMwXdNawMR/HyinA3Q3TVxyS9VgjegkUQOX60aB26Dhp6Rh5xCQ5x3lTV1
 JyTa8bIj8kd21o1cYKB2WNRZcpJ+aPWxbAsqjO87hUMUR84p/GOLokHTPOjMVuxKRjs8
 jjoivWE8YvPkfgiDK6FR7MFmuu5DZTqVjNnFloVWEEl3X3gI+256qBG0EXqZcZnWIdnC
 R6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DzjKs/qrm8rgcb7Xg6xh6iKM2RJ6CCIhXW7uGjEg+NQ=;
 fh=+xvzzxqgPzkAWFhcZUCHdOlMVc2Sg2yypWZczwtedFA=;
 b=Uk23QSFNctGOJBt7HaKNuCZ+R0TPxmG1WDd9hBeehFBKu2CBzR0xBDdOlBiHIqERvA
 eL6XwZLhqxxyLElCI6OrrjS6QHj6wartWne96QJ0mjCqUY+WeymZ78i0nC2G7HIEJKN1
 WA09KPOJ512FAkhyAPm2VZg6ephB4jcoOu8zK+uHwE4prwj/fXnDzPH4JR0UgMt807gV
 CkNIJAnr+J2MADXLRUoKtZeqRGRQ6iZ2J7wZQzdq5qYOL/D7JdwVijFSyZRei0zMap7y
 T4kcg6HKVOg4fUyu8Nce9/VhQGUxqOenimETFxSLqx0WKeOpuVrAM9x+wneXp76Y5XT7
 +tHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792921522; x=1793526322; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DzjKs/qrm8rgcb7Xg6xh6iKM2RJ6CCIhXW7uGjEg+NQ=;
 b=KyNkmqsfFi0YPImZA7l5pfY2rOqAaw3lhZ1KRsYmKfYLOxJV/Duvzlh0HpJU8rxJEU
 zrkWzk5HKp6gvq+rrL+ts5VKD0waD6vAbID6zbmsghkspUFZxRvp4zMIMlsOVMAZfB/d
 TToaXz5HWx/EY0xFWKZa9AxRWn7XofH+sHuRZvVvepIJRmtzQujhQOe+fmCtOyZsx1nB
 JJ5vSVXWY/ZK0cnLCamEMAlFf4YHQk2EoZYQz5+GLGwg8NP/1LGOp2VjfLDlTqeoj4+T
 weZr8MJyfPCrdC5dwru2iSRS9GOrvQPQnoZOFt+BtymxkEHzs1pvJv/fQsK2nlQqV6pi
 EzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792921522; x=1793526322;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DzjKs/qrm8rgcb7Xg6xh6iKM2RJ6CCIhXW7uGjEg+NQ=;
 b=Xa/W3zPUFgjIz9mHh6oRgJdY1MapC2QtyaRlRoq5nTw6bmOwdY/XW07JCbBFRl+C8x
 RjUkUwpnS+vv/uzLP9OZxM1xPOBraT/XKqhWHiXMV/F1RGkqzi+PvI23Z0XSh4CsSh6+
 rufbCF2l/cvTMBY0ewVSRJ9BdkOHNxVc5yV9OLSR7vnbfdAU1+GG4nDqpGfSOUfk35TT
 zxgeb9D6iDPNiUCjwQ/SjCfZu2nrPdFrHYVZZxVtAvCm1kBSX/zXpAuVzvtcuQXZDeNE
 2Gcggr8mAAez1vgA4y3mFd9GTO9Fg8OMTJZ2doFlmUb9BW1eQ93zfDY9pNshKkxRaRJX
 xokw==
X-Forwarded-Encrypted: i=1;
 AKwUvByhhT1D4QsC2zjEJ6yzBhHDxt+YgJDG9RFiTdLE9y6zEwa01Lv/Iz5gUb5uk/MzxBM7VotCuX8PAUjr@nongnu.org
X-Gm-Message-State: AFq9FYKSxozusnTPtGhu0lEw75QRulIn2a9sgbcr5NgjuBlySvw4xe+C
 Oq5sh+cuypBjfqLdXeNUko9qJ1wMU1Ro1aygcQToahqpdHHe/o/OkUCaHFm8KW0RyirXRwG0Etb
 dOOkdZz+PP//BYvhZVyaIaH1Rzdb8rR4bFVKFwBxzxnRtzBotztUsZUA=
X-Gm-Gg: AYBFou1fZMQAbiWvSCFdnZ+1yp2p85GcaJJ3En+T36CvgkX6/lYRoaJqwWSOElULZid
 OamuZfm2UdqnCwgDPYhDqn8kdbKd86bMWjiECC5SpZLHlZVImrJKuxdxIDDVIRAIEXquDnOLpBt
 EG3Cl3dY8GzpM4cEQ5HHkpgVBu7k6BsjypqQEViQKK3ZvzuI73uEw/IipAhCxBzfPvf5rcxHwK4
 RPz682RqXtN60cg47uCRHB0hyZF+96AxnRQeI2UGR2kM4JFHG8eCFA9r4ub+BqzR6Uzjv5e10da
 Gt7JXBOlA5XOgBfhRAaEPhbvYNtRu7OKRT7iZUO81Nvu2qldcnqpY1PEnbGQwTGsFqqaonzteZN
 tCIGQEGta8zr97w8Kqta/K/JIlkV12f2UfXcBs/DzXzH5UrmdIv+fBkMTYivdtOkjZE2EPqA8o8
 rMBYmzt0j5Gk8cj4lsNLyr
X-Received: by 2002:a05:690c:60c5:b0:8b0:fb9b:8d0 with SMTP id
 00721157ae682-8b166c01ca7mr22452467b3.50.1792921521977; Sun, 25 Oct 2026
 02:45:21 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019162217.3272337-1-peter.maydell@linaro.org>
 <20261019162217.3272337-2-peter.maydell@linaro.org>
 <25d0ce95-e964-496a-a3bf-2c5f9fa1b78a@tls.msk.ru>
In-Reply-To: <25d0ce95-e964-496a-a3bf-2c5f9fa1b78a@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Oct 2026 09:45:10 +0000
X-Gm-Features: AclHuK9KOxkkFAKlhiXd_9oDUsqydvHCIeUvBOzUQv7w3jxj5rqR3AbOMwCynoo
Message-ID: <CAFEAcA8MQw9bcAG+7ft=cxZpFrSCWvXpLerXrH=beBBdhvzM-g@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/intc/exynos4210_combiner: Fix group register range
 check
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 QEMU Stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 25 Oct 2026 at 05:43, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 10/19/26 19:22, Peter Maydell wrote:
> > The exynos4210 combiner has registers arranged in sets of 4:
> >   offset 0x0: IIESR0 (handles interrupt groups 0..3)
> >   offset 0x4: IIECR0
> >   offset 0x8: IISTR0
> >   offset 0xc: IIMSR0
> >   offset 0x10: IIESR1 (handles interrupt groups 4..7)
> >   offset 0x14: IIECR1
> >
> > and so on for a total of 16 sets of registers, which puts the final
> > IIMSR15 at offset 0xfc.  After that come two registers which aren't
> > grouped, ICIPSR0 at 0x100 and ICIPSR1 at 0x104.  The entire register
> > memory region is thus 0x108 bytes.
> >
> > The logic which separates out the "offset is in one of the sets of
> > registers" from "offset is one of the ICIPSRn registers" is
> > incorrect, and so a write to offset 0x10448100 (which should be
> > ICIPSR0) falls through into the code for handling accesses to a set
> > of registers, and indexes off the end of the s->group[] array.
> >
> > For an input offset of, say, 0x3C, req_quad_base_n is 0x3, because
> > this is in the 3rd set of registers.  grp_quad_base_n is then 0xC,
> > because this set of registers handles interrupt groups 12..15, and we
> > will index s->group[] with grp_quad_base_n through to grp_quad_base_n
> > + 3.  IIC_NGRP is the size of the group[] array, and so we need to
> > check grp_quad_base_n against it, not req_quad_base_n.
> >
> > Fix the bounds check, and add an assertion that the code path
> > where we are beyond the register-set range isn't going to
> > overrun its array, which we know to be true because of the
> > size used for the MemoryRegion.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 8e03cf1eeb1f9e0 ("ARM: exynos4210: IRQ subsystem support.")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4709
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/intc/exynos4210_combiner.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
>
> (This is now commit ab6579bf73b in the master branch).
>
> Hi Peter!
>
> This change has been Cc'ed qemu-stable.  For 10.0.x series,
> I'm also picking up a previous commit,
>
>   b6d36a1af79 hw/intc/exynos4210_combiner: Avoid hw_error for guest error
>
> instead of adjusting this change.  Please let me know if I shouldn't :)
>
> Overall, it feels like this a niche device, and it's unlikely anyone
> actually cares for the stable series -- actual users of this device
> in qemu most likely have their own local builds of qemu anyway.  But
> sure thing I might be wrong.

Yes; I cc'd stable on this mostly because it's an array overflow,
but as you say it's niche, and this device isn't covered by
our security-policy as it's TCG only.

Picking up that earlier commit is fine if that's how you'd
prefer to avoid the merge conflict.

thanks
-- PMM

