Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03814C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 18:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufMmO-0004Su-8v; Fri, 25 Jul 2025 14:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufMkv-0002Fq-Hn
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 14:02:55 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ufMkt-0003BY-KC
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 14:02:53 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7183dae670dso22325717b3.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 11:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753466570; x=1754071370; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WGURkdy3ekag9iAbnmoyAib7YTj69cFey5+rzv1TZMg=;
 b=PIn73vIIlXVnBXCC/HJZ9BjXq6shQATPueeVvWThbdIX9PrXYha7kBn9s48u4v+aaE
 NYz9PBLfme/xFwXBnX/yB9+B4bHu/JARZYiPO4Vpld6YC6HoAgpyf6tNBEa74C8nocG0
 PFDJ0zQKzqGbENpyzPIZAJQH/dWNvxair9SFol7wjIen2TDQ4kTr7frIdx5kqlJlaF5I
 ncz1myqUz/ORU99C6c2qqEOzfavUceSwR0Jku16xHnuPddZLf6KXGLBMjtxw6dDlc7w0
 ztWQWt2T8GRpYHqgelgO/uYq3xm4///C9uWHCVabt4362GHnPjFFeVVTQuaAJjUOdJkX
 AcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753466570; x=1754071370;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WGURkdy3ekag9iAbnmoyAib7YTj69cFey5+rzv1TZMg=;
 b=lmSfbZ1yBIgmUvzmrfAePyUv9nmniSsSiuCTjjygKrGLObq9JVASqEn9mInLppIebi
 zXLo65S/W7vuqkgw2PES5PbVyyoUB0kYw6/F1MRDMv1QvzlhaYGByqpd7ckBuImg+7sa
 xesgk+GoCP+7DdHq2FYP1rQf8oeTB17WTxkilBtEYU728xwpzNBPrvimYnZhhgCPPDX4
 8fScrtGiDAeINVw8rEFtls5fg0tw4r/tucHf9Zj3merMq8+A/oG0l2NbYsCNs3s+oEE+
 CMTaPcH3L5Z5xsnxgZEDvQBQ3v8Jeo8E6xx4l0DRDX8TjRfixpY8ZCv6kVaDTGEC14Fm
 v0gA==
X-Gm-Message-State: AOJu0YxysFKv6EswpVUcTrM18OzmGlczGQWyTh1+/ZO69zpInf+d3PSF
 ZcI2BLejTC7j92snKzOuEM/P1kWgN5uNEQSDfWnk3yu+ja3Q9jeKO1IQN2KGUEYDgC2SzDOVu50
 BfnWMQ/Vp2GkroPLx3e4sumb5VDPR80EsIO6Vxnp82g==
X-Gm-Gg: ASbGncuspT1bbg0Lwwzkz9kJhbkiDSK3mlQot8feMKTIOoCH0Q/XshZvC8M7b4fbiCN
 ss8ybAGqUPU2gLX95L0NkrxN/whCQQbFdWjDJwEycO7zwmgUeuewjeb9w+BXU4R/IBu/olxcw8+
 O5CcRYAWZRnwbffbmdCiVkHFeNRDGriW7273warHD/7xPOjpCcAaW9cjVCm1vveV59Mr89Az/eg
 kdAsozp
X-Google-Smtp-Source: AGHT+IGVKDX5JyUvN7wlnYeb8oTgLphQUMfCyg51z8eUQBH3V1ejioehV/+rzXxrnMjZh3ZBG3ElL8sZL0eTNCgYmsQ=
X-Received: by 2002:a05:690c:892:b0:705:750e:851 with SMTP id
 00721157ae682-719e349804dmr35653667b3.37.1753466569621; Fri, 25 Jul 2025
 11:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
 <20250721132718.2835729-3-peter.maydell@linaro.org> <87ms8uh7ln.fsf@suse.de>
In-Reply-To: <87ms8uh7ln.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Jul 2025 19:02:38 +0100
X-Gm-Features: Ac12FXwPpwsvdky-6wARVBRwNdplvx55EY1ox_dV5IlrfrCP6a_tKRXvdK-EX9o
Message-ID: <CAFEAcA9kxDdkEyLguTsEV_nDX9L5mAT+Rw_4Rmk68YQq50ee-A@mail.gmail.com>
Subject: Re: [PULL 02/20] target/arm: Correct encoding of Debug Communications
 Channel registers
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-arm <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Wed, 23 Jul 2025 at 23:20, Fabiano Rosas <farosas@suse.de> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > We don't implement the Debug Communications Channel (DCC), but
> > we do attempt to provide dummy versions of its system registers
> > so that software that tries to access them doesn't fall over.
> >
> > However, we got the tx/rx register definitions wrong. These
> > should be:
> >
> > AArch32:
> >   DBGDTRTX   p14 0 c0 c5 0  (on writes)
> >   DBGDTRRX   p14 0 c0 c5 0  (on reads)
> >
> > AArch64:
> >   DBGDTRTX_EL0  2 3 0 5 0 (on writes)
> >   DBGDTRRX_EL0  2 3 0 5 0 (on reads)
> >   DBGDTR_EL0    2 3 0 4 0 (reads and writes)
> >
> > where DBGDTRTX and DBGDTRRX are effectively different names for the
> > same 32-bit register, which has tx behaviour on writes and rx
> > behaviour on reads.  The AArch64-only DBGDTR_EL0 is a 64-bit wide
> > register whose top and bottom halves map to the DBGDTRRX and DBGDTRTX
> > registers.
> >
> > Currently we have just one cpreg struct, which:
> >  * calls itself DBGDTR_EL0
> >  * uses the DBGDTRTX_EL0/DBGDTRRX_EL0 encoding
> >  * is marked as ARM_CP_STATE_BOTH but has the wrong opc1
> >    value for AArch32
> >  * is implemented as RAZ/WI
> >
> > Correct the encoding so:
> >  * we name the DBGDTRTX/DBGDTRRX register correctly
> >  * we split it into AA64 and AA32 versions so we can get the
> >    AA32 encoding right
> >  * we implement DBGDTR_EL0 at its correct encoding
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2986
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Message-id: 20250708141049.778361-1-peter.maydell@linaro.org
> > ---
> >  target/arm/debug_helper.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
> > index 69fb1d0d9ff..aee06d4d426 100644
> > --- a/target/arm/debug_helper.c
> > +++ b/target/arm/debug_helper.c
> > @@ -988,11 +988,20 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
> >        .opc0 = 2, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 2,
> >        .access = PL1_RW, .accessfn = access_tdcc,
> >        .type = ARM_CP_CONST, .resetvalue = 0 },
> > -    /* DBGDTRTX_EL0/DBGDTRRX_EL0 depend on direction */
> > -    { .name = "DBGDTR_EL0", .state = ARM_CP_STATE_BOTH, .cp = 14,
> > +    /* Architecturally DBGDTRTX is named DBGDTRRX when used for reads */
> > +    { .name = "DBGDTRTX_EL0", .state = ARM_CP_STATE_AA64,
> >        .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 5, .opc2 = 0,
> >        .access = PL0_RW, .accessfn = access_tdcc,
> >        .type = ARM_CP_CONST, .resetvalue = 0 },
> > +    { .name = "DBGDTRTX", .state = ARM_CP_STATE_AA32, .cp = 14,
> > +      .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
> > +      .access = PL0_RW, .accessfn = access_tdcc,
> > +      .type = ARM_CP_CONST, .resetvalue = 0 },
> > +    /* This is AArch64-only and is a combination of DBGDTRTX and DBGDTRRX */
> > +    { .name = "DBGDTR_EL0", .state = ARM_CP_STATE_AA64,
> > +      .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 4, .opc2 = 0,
> > +      .access = PL0_RW, .accessfn = access_tdcc,
> > +      .type = ARM_CP_CONST, .resetvalue = 0 },
> >      /*
> >       * OSECCR_EL1 provides a mechanism for an operating system
> >       * to access the contents of EDECCR. EDECCR is not implemented though,
>
> Hi, this patch breaks migration. I'm leaving for the day and will take a
> closer look in the morning. But since we have timezones, here it is:

Thanks for the report; I can repro this. It happens because
the loop in cpu_post_load hits the "register in their list but
not ours" check, because the source VM has the AArch32
{.cp = 14, .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 5, .opc2 = 0}
register which should never have existed.

I'm not sure how to handle this, as we have no mechanism for
"ignore this incoming register value, it is bogus". I'm surprised
we've never run into this before...

I won't be able to look at this further til the tail end of
next week.

As an aside, it is a shame that post_load hooks do not
take an Error** -- if they did we would be able to report
this more usefully to the user by saying why the migration
failed instead of just returning -1. Perhaps it would be
worth adding _err versions of the hook fields in
VMStateDescription so that devices can optionally
implement them instead if they have interesting or
complicated errors to report ?

thanks
-- PMM

