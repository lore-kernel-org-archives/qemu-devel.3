Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D60CF11CE
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 10:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syqf1-00005v-HY; Thu, 10 Oct 2024 06:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syqf0-00005f-TF
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:44:46 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syqez-0008D9-8Y
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:44:46 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c9428152c0so145099a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 03:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728557083; x=1729161883; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BX/60HY1SQilc1djhjB/a1kYJ5/dGdDi3/gVE9ZXjRA=;
 b=pydFnU4KmMUY+aKA313vPi/lfxxun5MntdZhHv0Lii8XeEsWUmeXILyaMCbaIyRxD4
 blZvNkljDTJd4Eq/JyOx3lLFO9/l5LrsjSbL0d22LTJUXKnZJ82BsnNb/6vmYoD9cp+1
 eRV58oQRwzSeow477qKd0YqaXppw/EgwhKrMVSQ1vCJhdTBW4g+J1Iys7cylZHRUM3sa
 77oCS1amolJmZTL/S1QiqDwhkYOVQFR0XEvpK5KyJUz+Jlm5kwkBDJ4T4sbCGiodOfeD
 qQ09UX/2Mif/ARfDTUbMt+adRIeLxuNzFL484lJ2R4DwXZYzWF1ILJFlcGhPaLoY47e0
 3u+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728557083; x=1729161883;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BX/60HY1SQilc1djhjB/a1kYJ5/dGdDi3/gVE9ZXjRA=;
 b=RLW7CuhTkLuJQOvy/WgFvxsqQMAd7jY1Q+6ga9Jy58mLflMUk6N9MZzUqsjZxvomj4
 QzqdDOcg3cNpRlsG7P9ABPGoBCvgisJFwZNGSzo7nSGEA40phcR+3PblohqwWGMJzl9l
 U0BIQK6J5o76i/qL6kM4J9ULjyT3xRb1Bof3iTeiRSb0bv72JFYq6Af3UoAe9mKshwx/
 x8CYBKihxl9Mdy7b82S3qqqwFWJMka7kdnDsTUoM4iHSbTh6jSwxSmiUpX2SVodyj1vX
 5GRMvhMW+kml0BKRawUJeB+VmtvyG8W5a4I/1o4JKm0iAzWt4FR0MBr5KS4EQDjEDVf2
 yTJQ==
X-Gm-Message-State: AOJu0Yyvz4jLEVwOTt092JjYPSkvUkwQrchpB9cyw7jQc3/Q0KhmHzni
 GovcJJ0ny6P4YIXfPzT7mViG1tHQt9buLFkMlYeFoSeShl4YEYqXD0ic7lch89UnWERi6w82H+L
 SjH79G2z9CLFVJP96DL2BQ0aHgLIiKgRihOOFrQ==
X-Google-Smtp-Source: AGHT+IHZMWiUZgylwth4eNH4y3+UYvrysEu+bCAnCgwYWQMyWAJs0RSCwqbbOpDohzoAn4H+jeuGr31Qt7J4TGKbEx4=
X-Received: by 2002:a05:6402:3512:b0:5c5:c5c0:74ec with SMTP id
 4fb4d7f45d1cf-5c91d675a01mr4875352a12.24.1728557083380; Thu, 10 Oct 2024
 03:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20241009000453.315652-1-richard.henderson@linaro.org>
 <20241009000453.315652-7-richard.henderson@linaro.org>
In-Reply-To: <20241009000453.315652-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Oct 2024 11:44:31 +0100
Message-ID: <CAFEAcA-mSsFgjoBWi13dXqZUbys2N81YVXLD_ZfuuGo+Xfy-gQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/20] accel/tcg: Use the alignment test in
 tlb_fill_align
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Wed, 9 Oct 2024 at 01:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> When we have a tlb miss, defer the alignment check to
> the new tlb_fill_align hook.  Move the existing alignment
> check so that we only perform it with a tlb hit.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> @@ -1754,8 +1767,8 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>           * Lookup both pages, recognizing exceptions from either.  If the
>           * second lookup potentially resized, refresh first CPUTLBEntryFull.
>           */
> -        mmu_lookup1(cpu, &l->page[0], l->mmu_idx, type, ra);
> -        if (mmu_lookup1(cpu, &l->page[1], l->mmu_idx, type, ra)) {
> +        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
> +        if (mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra)) {

Is 0 the right thing here ? Given that alignment-requirements can
differ per-page, what happens for the case of an unaligned access
that crosses a page boundary where the first page is "memory that
doesn't care about alignment" and the second page is "memory that
does enforce alignment" ?

For Arm this is moot, because an access that crosses a page
boundary into something with different memory attributes is
CONSTRAINED UNPREDICTABLE (per Arm ARM rev K.a B2.15.3), but
maybe other architectures are less flexible.

Also, the comment does say "recognizing exceptions from either",
and we aren't going to do that for alignment issues in page 2,
so if we're OK with ignoring this we should update the comment.

thanks
-- PMM

