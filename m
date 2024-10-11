Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843E6D0EE12
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ4U-0001AT-O4; Fri, 11 Oct 2024 13:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szJ4P-0000wP-Ik
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:53 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szHgs-0007g9-Mb
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 11:36:32 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c948c41edeso1085644a12.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 08:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728660989; x=1729265789; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ooVvsEyGOT7aTjiUJiE2ewcH9FMS1o9c1z/caxuq/gc=;
 b=LSs/dv8K1IhpSkn5tlNWhcbF5GpMmQ+jDgGuNSRQNadWhRCl7yy6akLOeDk4My8WIC
 iKe+Jv/fcE8gOR/3xJPLoyZKP6nCPhNnv1uB84EF23UjV28nO0RIFPyL2W4nmdfPfSaQ
 VLJ6tV6KXXG1Kz4QIcHs3h6OtfBdskymBcht1sn7CtzNjAYZWAbRycavIJDKlYo3m6Ni
 rZ720LAJgt5WmR61f+SeU/W/8qeazUNn9Sl7ZIpu+RWicInT883MMhLmy2BrRnl7MoI7
 ymazcLmPy/fXRSE+3CbRJ3zmlwwjNxCr8yaKdaY6KesJdAjQjlpEPkiwTCgp2mzT4Amp
 iE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728660989; x=1729265789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ooVvsEyGOT7aTjiUJiE2ewcH9FMS1o9c1z/caxuq/gc=;
 b=MCWQGBK7opNqVWr9yQj1KgeTCqK1XWKyKBwC80d6FfW3X8u5YWhfU8o8fRxpnRd0jJ
 DVKb6rsGZUdLPztrzbNdSVlZgbgBmY5WfN6DfYvLaMYoCjQGfpyweMvKAoI2eBsY0wWx
 kLIgmz0sCFY7kMZ7tCbX3BcEgvh4QHQl7vGXNbW60pacLApgmWtfKlSDQK9yRvYS2jfN
 86OjSkQCCmq2coupVYN7PS3gb/qzfWlwKWQZ/tNzp4IolHgWhFU34xm0HN9t6+1F5LAk
 JqER2U2dFFRpC1DeGJ8/DKb5ulIeYt+9jwuPyPV0BMvQKNDnBQiJlz8cA5iZyCTJQEWI
 sJWQ==
X-Gm-Message-State: AOJu0Yy5Y3rpcP+nSCFFO2t/JfsGusDR9aPqv4CSkn+04t821Hem1qnV
 y9cT2/cHQIsEER3o9XGqeFQ/nUShPEZqLvkI7WxbasPI2Nu7lTcKP2I4m73WlaWFTntuKdtg+rB
 s8wOnVPf6Az8mObL5yR5ytRITvwdKkt7984YGtg==
X-Google-Smtp-Source: AGHT+IEjAHVyDzsxyfA+hUYjmXreiKyNYIRlBTXDRhSDjaO8yGQi8i2TD7NUA9+tfGUqyCOuYQb/F3LOjlf9b49Eimc=
X-Received: by 2002:a05:6402:2786:b0:5be:ee30:9948 with SMTP id
 4fb4d7f45d1cf-5c948ca2342mr2251965a12.8.1728660988058; Fri, 11 Oct 2024
 08:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241009000453.315652-1-richard.henderson@linaro.org>
 <20241009000453.315652-7-richard.henderson@linaro.org>
 <CAFEAcA-mSsFgjoBWi13dXqZUbys2N81YVXLD_ZfuuGo+Xfy-gQ@mail.gmail.com>
 <b5bf5d17-2451-4d6e-9a4e-6fb4e94ad308@linaro.org>
In-Reply-To: <b5bf5d17-2451-4d6e-9a4e-6fb4e94ad308@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Oct 2024 16:36:16 +0100
Message-ID: <CAFEAcA9brYu2trekf3=ztRkHOc2Lw24_L+eSpTJzaf=orVFv8g@mail.gmail.com>
Subject: Re: [PATCH v3 06/20] accel/tcg: Use the alignment test in
 tlb_fill_align
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Fri, 11 Oct 2024 at 16:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/10/24 03:44, Peter Maydell wrote:
> > On Wed, 9 Oct 2024 at 01:05, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> When we have a tlb miss, defer the alignment check to
> >> the new tlb_fill_align hook.  Move the existing alignment
> >> check so that we only perform it with a tlb hit.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >
> >
> >> @@ -1754,8 +1767,8 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
> >>            * Lookup both pages, recognizing exceptions from either.  If the
> >>            * second lookup potentially resized, refresh first CPUTLBEntryFull.
> >>            */
> >> -        mmu_lookup1(cpu, &l->page[0], l->mmu_idx, type, ra);
> >> -        if (mmu_lookup1(cpu, &l->page[1], l->mmu_idx, type, ra)) {
> >> +        mmu_lookup1(cpu, &l->page[0], l->memop, l->mmu_idx, type, ra);
> >> +        if (mmu_lookup1(cpu, &l->page[1], 0, l->mmu_idx, type, ra)) {
> >
> > Is 0 the right thing here ? Given that alignment-requirements can
> > differ per-page, what happens for the case of an unaligned access
> > that crosses a page boundary where the first page is "memory that
> > doesn't care about alignment" and the second page is "memory that
> > does enforce alignment" ?
>
> I can't think of anything else that makes sense.  The access to the second page is
> "aligned" in the sense that it begins at offset 0.

Ah, yes, you don't get to see how unaligned the access
is in the second mmu lookup.

> Anyway, alignment as a page property is unique to Arm and...
>
>
> > For Arm this is moot, because an access that crosses a page
> > boundary into something with different memory attributes is
> > CONSTRAINED UNPREDICTABLE (per Arm ARM rev K.a B2.15.3), but
> > maybe other architectures are less flexible.
>
> ... as you say.
>
> > Also, the comment does say "recognizing exceptions from either",
> > and we aren't going to do that for alignment issues in page 2,
> > so if we're OK with ignoring this we should update the comment.
>
> The second page can still raise page faults.  How would you re-word this?

Mmm, so there's also the case of an unaligned access across the
page boundary where page 1 is present and page 2 is not -- do
we prioritize the alignment fault or the page fault? This
patch will always prioritize the alignment fault. For Arm
that's fine, as we architecturally should do the checks in
that order.

-- PMM

