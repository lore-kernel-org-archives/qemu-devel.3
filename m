Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F29760A6F43
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=y4q7Oo/I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP39C-00022k-MT; Thu, 05 Nov 2026 14:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xP39B-00022U-H2
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:29:17 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xP398-0006gW-9x
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:29:17 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b308fca7c3so22472017b3.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:29:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793906953; cv=none;
 d=google.com; s=arc-20260327;
 b=k5gjp1212K1sRTTXP4li1zYCerXSnPuUOxL5+zj6gLLyrKac3oIwFR0GwK1fKhSq8W
 8vnUVKGcpazS34ssi1A6++msnCszpGblx9X9mZLbqhZKMukTN6skRhcSP2NwrMZETW35
 usIuQ9zXkOSC1VsUFx+89oGf9YlS9ySgIYFiInzl+zCCjqwZSrSUJ4TSNWYKRTaosPTs
 4NnVcJEnc5GSaq2bKc8I8W2p9Ke7HTh+XFhVZmAdQQbvkdQEsRGlcIIiLkXykkMwCdLM
 f9uTnw+AyAJBLmmjty1mSkLpBomESKFJCheZpq1Rj+57I91jIKDAAIkUbbz9xczFRXvE
 e12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3x2DkoeDm1fHztN8n9o/K1tBlQJ03Ml6fEfXaUe2dwQ=;
 fh=VRcZPmT6Amq8CJg6YQ9jtV39fafV0LyayVlqP5p8az0=;
 b=sK53P0BZrstOzQKgY/0ZcV0SRUVXGgymwTRvU9u7frlip+BDxNNBMO2mdTBliUUdlN
 TXS4W4Wq4MByXxGPyKXxSgf++byKxyVpxyglTi0X4XDVywDQ50ByXKabh2kugr33/Pmj
 LyxqZpMVsR7A4K6NUFvqcjcJHtWoFJngfLhMqNEHaa9rjeUhagMvl3YE3YG95+AJnAe+
 ocP12br8Vxu3F5lW50GfOW/mVq/9MAo/WAW4FXN1v6PfyZPOkL9RILDaK6HICzaifQbF
 N9IcGLmQwRa3Oq7aBTGPgjN1ffGcZy+YNpiwoJl4swbKR91oT9Q/ONr3j2Pms+JLkrH/
 Hjnw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793906953; x=1794511753; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3x2DkoeDm1fHztN8n9o/K1tBlQJ03Ml6fEfXaUe2dwQ=;
 b=y4q7Oo/IltEf1oJpwCBtyafAepOLDjSeMq8pVHPBF0Sc7XSni014xAkTaYOVcxO6qR
 AlNhGcyVaEaXy+7luUkFNqhOP/7HbhyouPdQItPUZHgXfbqXbKQXabg9ZRlgTS567wYd
 FiKYpvrzoWJcFAVT/dzLOJ/0z8S6H2U3BJye+f3drtuCkMng/np26sB0sJ/ANOrsIl5J
 dfzUaQs3hZzMWn4WwUOADj1EaWHxbZaCVxgB2gLnZlbw2QYHymDMsY2szJeqL/fWJbA/
 /HBRkksAQnuRsGy4NaJ/H6Qz4kQyMuaVA8dKrogGPrSRwggpPsU769x8n1WvLa6rJdZ/
 cKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793906953; x=1794511753;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3x2DkoeDm1fHztN8n9o/K1tBlQJ03Ml6fEfXaUe2dwQ=;
 b=V5rQoF20B6EmV3TIreHup3C/ylsjUi3/KiO057ahX3vn8FiWWjsLt2Pt84ugtrDWF/
 B6xQiGUF9lpqq5BkUlMumhO4ia6dtgIIcPVFIBxGz0nxckG7cewwj7AFNswTT8RW1JK8
 K1GMjGR/7OYjbIURD86wEpeMd/YJxtLO7yn3RSsBwObvUc+/nUhzOHpwqReX0d67m39A
 mRsjzOonSx/RVNrnc3RWhFgM5bXOKjnk1Rp/q5zmmbXP7t5A0DCEYBN8oSpAGG0Zh4uW
 HWRqvrEz8sCmfQwdti5cIH2G3jW6Qrge9EVRpFihTwj68zR6sHJ9z6QJzuMnTnjBmUPQ
 21SQ==
X-Gm-Message-State: APuU4Z8955yTy1DCIh1WD1/m/NNDjybtvDhAfX5tkPCO+H5H4GSy+y2U
 0DvB2m3BP7WEZuyBOKLrk1bTL3O4bX8Tr4/mbyaYH4RcZutbFiR35uamkOrl3g/pZJdxhqwtoQd
 0SjEXmEPMtnWmGdYguBMBAt+TG3Ks+7Q5/h++xUCBkw==
X-Gm-Gg: AYBFou228MoO4ZYKMJXiHbwl3Q43V4348eHVzZvBNfSr/4KM6nEz/S5IUvA6CDybTmc
 X2w9FNk5S81rw26Sn3xLliK1/B4AmLHdQR4Adinw55yNMp/AfGPCmm6dQzVcew+5v8gIswdkKcV
 7kNtAFODhneHy3lfMKZc264CFFa/C5msVfKuSTqQtXtwisUykJjGUgLGZZ4Vix/T4ZBFisPzNz+
 /ydIFCwa+N94DEAYVSvhth0pEG3jk5nwqKoAlMeQXxsKs4NQACGw3MVEXW2RXDAhPsCf91omfES
 ipMIGnF18+QjnjVAvQQ9q9StbuU6LZ7fYkt8hMbfDZPMOkPcJ5X6rwPM+z4MUbi0UJd0sRQZe1R
 w7BrQWHYpcOASa5fyOsK90NXmDyxZIBSsnTzLPyb0OEZJTiZLvHByuaAU0UsdV39nLPiCh06RnR
 XYNo+oaPTnpFhtHWodUmuMvKbUYomnFnMLdzxAkMMKOQ==
X-Received: by 2002:a05:690c:f05:b0:897:73ed:dd25 with SMTP id
 00721157ae682-8b2b67095afmr144960127b3.27.1793906952818; Thu, 05 Nov 2026
 11:29:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-gic_read_bpr_from_property-v1-1-7e7392bfd321@linaro.org>
In-Reply-To: <20261105-gic_read_bpr_from_property-v1-1-7e7392bfd321@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2026 19:29:00 +0000
X-Gm-Features: AclHuK_PK7G7KMa7lDpqI9PBh5PQ4PMC9pauKWX-xUVpBr6SO0ZVGFWHAnio14s
Message-ID: <CAFEAcA-eFmvQZ8hoeGJb0hZagBejYWR0_-9-C6iA75m7k1VvXQ@mail.gmail.com>
Subject: Re: [PATCH] gicv2: do not hardcode minimum binary point
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Thu, 5 Nov 2026 at 12:26, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> The number of priority bits is implementation defined, and indeed
> machines such as a9mpcore and arm11mpcore define it in the
> num-priority-bits property. However we still hardcoded GIC_MIN_BPR.
>
> This commit replaces the GIC_MIN_BPR and GIC_MIN_ABPR defs with macros
> that read the property.
>
> The calculation is based on "Table 4-47 Active Priorities register
> implementation" in the GICv2 spec (page 4-150 of ARM IHI 0048B.b
> ID072613):
>
> +---------------+---------------+---------------+
> |               |               |    Maximum    |
> | Minimum value | Minimum value |    number of  |
> |   of Secure   | of Non-secure |     group     |
> |   GICC_BPR    |   GICC_BPR    | priority bits |
> +===============+===============+===============+
> |             3 |             4 |             4 |
> |             2 |             3 |             5 |
> |             1 |             2 |             6 |
> |             0 |             1 |             7 |
> +---------------+---------------+---------------+
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4375
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---

> diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
> index be923f7ed8861620d17fbf3d8569c42ae7c95487..e090bd0b283297d0863e13ef07e5738a549ea59d 100644
> --- a/include/hw/intc/arm_gic.h
> +++ b/include/hw/intc/arm_gic.h
> @@ -70,11 +70,6 @@
>  #include "arm_gic_common.h"
>  #include "qom/object.h"
>
> -/* Number of SGI target-list bits */
> -#define GIC_TARGETLIST_BITS 8
> -#define GIC_MAX_PRIORITY_BITS 8
> -#define GIC_MIN_PRIORITY_BITS 4

You don't need to move GIC_TARGETLIST_BITS (or its comment), as it's
unrelated to the priority bit config.

> +static inline uint32_t gic_min_bpr(GICState *s)
> +{
> +    uint32_t num_preemption_bits = s->n_prio_bits == 8 ? 7 : s->n_prio_bits;
> +    assert(!(s->n_prio_bits > GIC_MAX_PRIORITY_BITS
> +             || s->n_prio_bits < GIC_MIN_PRIORITY_BITS));

It's possible to hit this assertion, because I put the "check that
num-priority-bits is set sensibly" code in the wrong place. We
check that in arm_gic_realize(), but the property is defined on
the "common" superclass, so it is present also for TYPE_KVM_ARM_GIC.
Most of the uses of gic_min_bpr() are in the emulated-GIC code,
but the calls from arm_gic_common_reset_irq_state() will be
used also if you have a KVM GICv2. So if the user sets a silly
num-priority-bits value with KVM GICv2 they'll run into the assert.

We should move the checks on n_prio_bits from arm_gic_realize()
to arm_gic_common_realize().

For GICv3 I pre-calculate the number of preemption bits into
cs->prebits, but that's partly because there are other places
in the code where things are written in terms of looking at
the number of preemption bits; for GICv2 it looks like we
mostly look at the min BPR instead so not precalculating is fine.

I do notice one other place where we need to adjust for the
number of priority bits not being 8, which is that the number
of GICC_APRn registers depends on the number of implemented
preemption levels (table 4-47 in the gicv2 spec). However we
check against GIC_NR_APRS in the read/write code for these.
I think that the only consequence here is "we let the guest
read and write some values that if it isn't buggy it will never
do", so we can fix that as a separate bug. (If it does write
to the nonexistent registers, we are still looking at them in
e.g. gic_get_prio_from_apr_bits() so we will generate a bogus
running priority value and odd things might happen.)

thanks
-- PMM

