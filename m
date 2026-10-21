Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8548606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IRumJaxs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXaY-00048U-Hv; Wed, 21 Oct 2026 10:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJXaA-0003wh-Ah
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:46:28 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJXa8-0004Qe-4n
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:46:21 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8acda240937so7049117b3.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792593977; cv=none;
 d=google.com; s=arc-20260327;
 b=cpBUPpeTb05cIkPUHpyjJOQxtODTH7wBf0cdrC2v7iDv1GAYwnpdtJh+4pZvM3Fz23
 WPRe4jlUBQ/s0Js9CgFJB9ybOsUB4PUHvIbbFWuGwhoAur1a+ftesu3xMhOpJ6EmJHdM
 IW/VDb8TA//KIMMkUlseDxcq/M0XgpKASYS34Vy5jrXadqqHC2gn4+emM+iWZqfGnYq/
 OTWVjnbGCKBj79exkh0npXPixiyoX30KlfpuJ/52hfA8a5D6C1pxe+iJaE7TD6WDdHt+
 urhdLDIhTj1Bgt3k36gdkIWo3TlFL7er7pr/FFxlrJtLAf27X/y2YKVlT8ljH7SvzfTg
 XBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sSLtenY6QRNVBOJIpklEsN2/mmmmH+YqHZH3OdYMJCI=;
 fh=vOm/qQVew/R0vFO9ftZTlvrCJSCKGHlm5MqwXXiPhk4=;
 b=k+7B8B1JnH99u2d2XSP8cG3T6r4DBIM5/yapJLOKerCGXEEA7AArBGTLHH7svdqwd6
 YQd41D/JmF7tmqrrf+iUU9LAabKjCgrsGwtUICiYmSt5WVkXL2o8QD5EVA7beqPRfQ1S
 +wEKD8SRa2UwRO5Uye9/ZlOAw+Cad4VULf/4fAvzW6VLdFg6nDTaJIQz8IEZualNbxhy
 6Izmmz01ys4WQ68fVqK/SaV12X0fF6G5cCfp3WdYKhQQ1lNxtf3OH3QqPvT3xSsTKDDh
 +APj7E8p8uEl2oLlSwNC8+ExSwmrXIxrF+JAWnY9/YMUi9ILzfAzuvlW/3l2TjFGDv7u
 YF6w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792593977; x=1793198777; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sSLtenY6QRNVBOJIpklEsN2/mmmmH+YqHZH3OdYMJCI=;
 b=IRumJaxs9FEHXZQezPHSZdhKRHhZnpXs8EVgrUz3U13mE6ntl5Hp7uudLkb2VNHrrt
 RF5aJUwIiHRDxrHAEgtcSz84Aypr92I8zWSZRJ+qZVGr4UUXHZT+cF9nVEhfIB/Iz7+c
 sRM8nuz2Ns4AJypmqU7wCeKHwZHE/b2vu5r2r/iABJ2U3eZ8BDiMIulHYsMkSXfO10T4
 OrKtUdbc/xwvlqcC8AAnZE03pYqq4Zxvfk82KX4EnEzB/qj/D/VIRG96sTBIxp0aUti/
 sq7GHfc5iVfSrDgrl2G8jFGTlmI/o9cAK2NAop+KBFpB3foN2zT/anHpR0NPdOsucoyr
 g0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792593977; x=1793198777;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sSLtenY6QRNVBOJIpklEsN2/mmmmH+YqHZH3OdYMJCI=;
 b=ENlaxQ37hROFCur9MJNj4A76hmCijqwVrHff604ubjmySwyTN/476nhD3iTdIAksGB
 EFn8BMLVmgnInsV4nQkvzEH/UXLO3A2BCj+d0x4QPnqW8R8C++XpCrbNPDG9ZBVxCFG/
 x0ssx/6Z9KCnka6BJXL/b9wPS5TYCOmrc8DTGamKsH6MnNQhBkNslwv+LtmBMeIRmL1S
 /u23erdsKq08mx4uQOsSwSHAX29GtbuDED/Zp4BboAIC1yJupFnidJqpNH2sXbrBpp/a
 6Vt8b6aTABBVsxNM6s1TZ5oght6Uw6kLfGHaBnQT2iLZSlkZuU3wulQPX/gqIhv266C3
 oKcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPnP1Fn/0iLtKRk0hsvfGbpMytNUJEWsvYkqhd6v/2WbUIdi8B5dLcpFG3QnVkUoL1GhAaN1RYkvE5@nongnu.org
X-Gm-Message-State: AFq9FYK1iQjrZxZJCyMCMaVb1pbQoebAPiGU0Y2ouBxNAWo7/OQO6T4q
 MklmxLA5LQCDQg1CjPKJUaQfZJPupWm/pmWGMFuI2JT8vc4CO9VU0cel3TNAow7cfas/Np9SM/3
 IpFx8cxEcH38JKrTXpCLjthACEH/tePIn8a8YRxROyA==
X-Gm-Gg: AYBFou3qOkS9C0/0BVaUxt+SNnkJEouSpJY6Zujk+JPIDS/qCff2UL0QqnD3F6Xhh/s
 0eH21OPP/CBx+eEfCCLbODKKM0y6emXmKmFQTlD+aKCIckE67PynQmoQE8V/vEXWyDEzDMhGAzf
 J4DW7Jo++ujr1lymFTxdFdDEkpHLm3oJ3QgsiayvEWsPg9Fc6p7V2TgXylws+RsYw3pAmzewKO/
 mzuRcmEwcpOEUwcI3D9QBHEvYc79JjhRCXqeOS8XVzRoI2Zzfc1njApLAj6fDU9Cg7tAmugKOKd
 RgpYJHopIP7SIDqrTrUmIc2pOkDsxGYZFwP/dlhtE3ylxHUy/R2P1oL6I4Lp0+/F/MzVdqggLJS
 DaHSA3DqQBPnoNxOJsN280hyArMx4qd7+Ui5HGkMrZSyw6YEqDrzrPj2uyDuTzAvMG0J9t8Lw/s
 kGmMxdI5yFOKU5hTZblnz6556NCBFXyKVVZbp5JYSZ2w==
X-Received: by 2002:a05:690c:397:b0:8b1:42a1:ad0e with SMTP id
 00721157ae682-8b142a1b144mr1587767b3.50.1792593976471; Wed, 21 Oct 2026
 07:46:16 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019162217.3272337-1-peter.maydell@linaro.org>
 <20261019162217.3272337-5-peter.maydell@linaro.org>
 <aa95e88d-10f1-4882-a705-b75bbfd9ae8a@linaro.org>
In-Reply-To: <aa95e88d-10f1-4882-a705-b75bbfd9ae8a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Oct 2026 15:46:04 +0100
X-Gm-Features: AclHuK8E5plf-W5FGuN-LzyFUkYL_WvgIxHp6YZWzAk40r0qgSVhA8PIbxH9zIk
Message-ID: <CAFEAcA9R2M=4GjduBxNDsfncLjLCchLneO=EfCoB1iqDjYnV+w@mail.gmail.com>
Subject: Re: [PATCH 4/4] hw/intc/exynos4210_combiner: write default case is
 unreachable, not guest error
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 15:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/19/26 18:22, Peter Maydell wrote:
> > In exynos4210_combiner_write(), we rule out "reg_n > 1" before we
> > start doing anything as being an invalid guest access.  The default
> > case in the later "switch (reg_n)" is therefore unreachable, because
> > it has explicit cases for 0 and 1.  Use g_assert_not_reached()
> > instead of a LOG_GUEST_ERROR.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/intc/exynos4210_combiner.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
> > index 2bdb9a0152c..80295ae6402 100644
> > --- a/hw/intc/exynos4210_combiner.c
> > +++ b/hw/intc/exynos4210_combiner.c
> > @@ -242,9 +242,7 @@ static void exynos4210_combiner_write(void *opaque, hwaddr offset,
> >           exynos4210_combiner_update(s, grp_quad_base_n + 3);
> >           break;
> >       default:
> > -        qemu_log_mask(LOG_GUEST_ERROR,
> > -                      "exynos4210.combiner: unallowed write access at offset 0x"
> > -                      HWADDR_FMT_plx "\n", offset);
> > +        g_assert_not_reached();
> >           break;
> >       }
> >   }
>
> You could remove the break as well as unreachable.

Yes, good idea.

-- PMM

