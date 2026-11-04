Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61910606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Uw/qwzdU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOdHR-0004QF-Ma; Wed, 04 Nov 2026 10:52:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOdHQ-0004Pl-6b
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 10:52:04 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOdHO-0002ak-Ii
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 10:52:03 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8b308fca7c3so8562427b3.2
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 07:52:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793807521; cv=none;
 d=google.com; s=arc-20260327;
 b=Hs2F51OrN+tJAVkPBwbfi/08fl+AniW6oskSP2yGO6E3R+7qryJwHZkDm8bgMOtgir
 iPyzoxrbpY/sqgIj8EWuC6sjm0DdQaVG3W9a0Ho+bvE2FdHc0rkpROTGpw1YaoVRDgbu
 GX+mzYMwAXkdYjyVyAg0zYBYjeRQeV81Z/6Lul9MJPFSh2fqzgcjzLncgkowKfNnOj1/
 hn8EAZTlT4ZS9yfdCLo/vnUE8PyaRNqnwnEKt2VMA1T1MuOh5YNCOlZu0KfO0e+HWUcl
 uZ1pSNhijbbUDlYHY6jEAy3OgXE+QVCYh3cTunTNEwVw5bBG5l2g61sArz/G1AgRVmxu
 m6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vwNeySTU0zElIXJJtnjeMJC2Gk06YnJ6rgloBT0IKw8=;
 fh=gkDlO4P4SsofPFl83s2lm4+Lo9uZ+HKb0HG30jeort4=;
 b=oy3L+v6jf9IoB1eWziq8xjkj7FrRr/HJxUSJMiyJLufoaQulwveEOLWP6UKE864yLE
 3FPfAvtXQcS7L9FyFSCQTG68QTW9fdFzN1XNFrZ1yu3S11f4jpdhVV4y2bl3I+oUJG4r
 FEqtNmjSlc5tjYVqrqtShU3hP9mRh/WftQx+MzQyuIXzXuyJfqcO792LtHCTPXsOAYM7
 2Gv/EXWDNIMPPwicA5RFE+++Uxdeqj3Z6ArgHq3M1O0SZBMN2q9mcBtkSh5Wgkk+/17B
 eb0gV3oAOtPShKcWRS3jV1I5XR/n5+CW0y5Jzqj0CWxMc8tBpxefw/hxMsv+QxIRufc3
 45Xg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793807521; x=1794412321; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vwNeySTU0zElIXJJtnjeMJC2Gk06YnJ6rgloBT0IKw8=;
 b=Uw/qwzdUTmaQdMKLqWha7ISo6tik0c9pDAWAxgJWKvnBpP2mFWzrpZsjxyZwEN1ioK
 Nw22yN1sQkDs9YFwGdI49N5S7+h2lVZYAiCmMOYePf9pUFoKpHk59HWBMby0sg49cIWC
 nAy60o6B0r/loG05ldhxVLbdkmUAsNUSVJnxIrDUgBnv2KT65cmmCUaDlfdBiNYDPrak
 34C2DA/NIxRsvyKy+XAcbAnRc+hdwK6fPQBBtVXfJQBQ1KLdixT+gjKeW+N11P6GJ0Kc
 wVelNef8VUz1RwrMGhX25/M9LXGWusiHgFfwsKL4bolqokThnJ7rvMs8WXXrZqOp64dw
 UoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793807521; x=1794412321;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vwNeySTU0zElIXJJtnjeMJC2Gk06YnJ6rgloBT0IKw8=;
 b=LSb2XfOHqTjf3UELt/BDtlEnMfam6kT0EhcjhLW7w8DMXekyq8w93FPCHH9GpJB3tc
 ReZQjeML/yOrHIozwEfwzuob6WlCHBRHwmXHlEUZfQ65F5f8Unx1wtU5QV8gPm0iu/I1
 k+VV6PMib9l1bx2X2jHEyGH+kzxyIXT0UlvCcLHNpg4dKRP8BPFznqUMunhTSmLdGVaY
 ZOsLWDF2yALnqa2stmANiPDrzGgwSYCgqRqehbk+UpiB80J3NailJg9TaeExGLCSiYHV
 KgpIQoSIYlAurpoVVr7jrEBtx9hKhYmRmHR2KOConcR2FKPtZQxm9jcEX7u65wHxLDTv
 4gFg==
X-Gm-Message-State: APuU4Z8gwzIkSgi4dYTd0aqP8Y8ra3j4yhDi82xD8iTvW2dqNX4do2jI
 yXuEg/HVsjscTOOQbJ8z7ZiF2BHLV+rZg7piy+BPznfDUII+n6EJRLagytYSsU1M9ssVeKaUrYr
 Si/v67kSGef38dExtV6EfMJe+KRHdgV2mqbeEPDbvig==
X-Gm-Gg: AYBFou0yj0fYpQptGkJUOCZyPIaSFC60wNlSVg4BRgf6s0+/gP4jJ4Ss9w1FEBoaLsk
 UDf5nsSl6qz8XUt0lNHNKSOUJ9tXNNJptXIsqjwj+DzWZuZ/US5D9iVnv5xFoEZg6fdmuiF8Mgj
 euOA9sZGWKbGPrUxaSBmmmnXRxTuCW7Q2qdu6vpxh14jGmScytjLnzQHzynMGQ9pw+t3uUgqsYi
 Bmcc7TwoT/UwP/aFzwz4IoRjw3aSS4XU4KYLlzN2yETG8B7ZhCSXY0RCw315k580N9zdYirdgVx
 Nl8hueZ4BBoDge/4jn+oaudy+ca3yezTP0plHQchvZyr4I0FUYjTM9V6YzMHY+10xg9VJnLVBws
 YpzZyf3qdmLvKPwN/f8qTZf/s3lX2dDYpxhJaqNivow9NrcHPiRD7gVTfat2vMZJR4KIN8QxaX0
 5A0ROcWkObuK7AcfToTHXJ
X-Received: by 2002:a05:690c:dd5:b0:8b3:150b:43c3 with SMTP id
 00721157ae682-8b3150b5f37mr10814587b3.18.1793807516567; Wed, 04 Nov 2026
 07:51:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104145316.18841-1-philmd@oss.qualcomm.com>
 <20261104145316.18841-3-philmd@oss.qualcomm.com>
In-Reply-To: <20261104145316.18841-3-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Nov 2026 15:51:45 +0000
X-Gm-Features: AclHuK-HXQ7gxlOi-H697hxVJy7AE-cCpHCt-2vDRAMdL1gi2US7Awxgn5HSH7I
Message-ID: <CAFEAcA-KO6QUAm3Z3a2nzo0dA-ohftNUBnvhwE0yTANgS7mkNg@mail.gmail.com>
Subject: Re: [PATCH 2/5] tests/qtest/npcm7xx: Replace deprecated sprintf()
 with snprintf()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 14:54, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Replace sprintf() by safer snprintf() to fill the QOM path and
> property names. This silences when using Apple clang 17.0.0:
>
>   ../tests/qtest/npcm7xx_adc-test.c:140:5: warning: 'sprintf' is deprecat=
ed [-Wdeprecated-declarations]
>   ../tests/qtest/npcm7xx_adc-test.c:322:9: warning: 'sprintf' is deprecat=
ed [-Wdeprecated-declarations]
>   ../tests/qtest/npcm7xx_pwm-test.c:244:5: warning: 'sprintf' is deprecat=
ed [-Wdeprecated-declarations]
>   ../tests/qtest/npcm7xx_pwm-test.c:245:5: warning: 'sprintf' is deprecat=
ed [-Wdeprecated-declarations]
>   ../tests/qtest/npcm7xx_pwm-test.c:255:5: warning: 'sprintf' is deprecat=
ed [-Wdeprecated-declarations]
>   ../tests/qtest/npcm7xx_pwm-test.c:256:5: warning: 'sprintf' is deprecat=
ed [-Wdeprecated-declarations]
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  tests/qtest/npcm7xx_adc-test.c | 5 +++--
>  tests/qtest/npcm7xx_pwm-test.c | 8 ++++----
>  2 files changed, 7 insertions(+), 6 deletions(-)

g_strdup_printf() would be the preferred upgrade here for
all of these, I think. That gets rid of the fixed-sized
buffers entirely.

thanks
-- PMM

