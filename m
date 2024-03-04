Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A20C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh8GG-0002y2-0I; Mon, 04 Mar 2024 08:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rh8G9-0002wk-HI
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:21:41 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rh8G4-0005NI-1y
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:21:34 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-564372fb762so5877374a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 05:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709558490; x=1710163290; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NpXEnaMYtF6jKBwYo4yAsZHIAGy3RRfL09a4at74QvQ=;
 b=xsr/AdEcYIaGrVD60p+dG/2kMu9OObAiIhW1s9bCr4QND5m8igubvfZSW6yiM03mt7
 Y40Y2BO+vzVRYmGYTa30sttbHnmOjF46zjrMeB7GWbd3OXPtQfQIDhOeOxRBb45zJd66
 2gIKT2C++W42lnSOcOWgswcEE7taP9Cice61Tq6guou0sx/AZcQmRa+4RzyaiCwGnf2x
 wCeiUp9Ibz2vRCipxV8ZapZN2p0oAUg/TNMRaqdN7HEmK7nyxxul+8hqHbDL9nplqnVN
 2h9VumVGi0ILIgdMsIPqM2Fs2jG1ypNqiC6UQ6KQcG2udN++RgYof/7nCqrGN++xdUjJ
 Wnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709558490; x=1710163290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NpXEnaMYtF6jKBwYo4yAsZHIAGy3RRfL09a4at74QvQ=;
 b=f7JJlDoP8shzSCG4BL1hBYgVPAJTgr0XOcryd2MRzGlLMPkDDMW0FdMT3iZt6HHleP
 O9drC/NpPHqIqZbKmsKKo3PtqUfdeV2CVG/XHOzmO2c5FbiFA65VgPj4hQSlHSomWIkr
 4RIlAPNUfpRdT+dN4RpVpcQJzrxZRH5Zfu02t3o04fzigyhIELmTOfRbu3R0g1IPsOjK
 4GFBGa3JlQerfHzNl5iZdHAlSfwYgfskYU05hTqjFOOHNjcBOmTrLQg4oQGQLjQmzRnK
 VpzqOSNNoXq67eY6VT1+A2PrL9C/BtCSUIiCiPIaIewCINBW0YXP5lUZNtf6vToiD6yM
 9UVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo0CPPfrmXSMRjbHWUzhR0Exi8O3hfv/nOHMPgZd81N0tiVa+4zGODmHsMRYEJzTiNR8QFqhQSkUDI+1JY+NtEwB0h2t8=
X-Gm-Message-State: AOJu0YyivPb3Aqtb6FWmsyGZhSTmwBtyAY3gHrrCwfKnZ4bfYwtwiQcK
 CdSIX/lVJfrlkval6bybbzNWRZSUmg1BblnITrxvGoefOpvmUrEe97gAhGHBAxhz6g+kwYEOVdG
 hfvLlLGUpYgWFaFyjDMtlysKlbq34cBrB0ek9HA==
X-Google-Smtp-Source: AGHT+IG6AwZifNHzz4Kd9BCA2UhluL+OGSrrkExxwml3pzCQzTPKdYpQMNXiIklj1G92JH30iOcqd3ElG7lbCVRv6us=
X-Received: by 2002:a05:6402:5d85:b0:566:b3f3:d987 with SMTP id
 if5-20020a0564025d8500b00566b3f3d987mr5111075edb.42.1709558490123; Mon, 04
 Mar 2024 05:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
 <20240301183219.2424889-4-peter.maydell@linaro.org>
 <f0dd2308-6a94-46b5-821f-12ab907d29ea@linaro.org>
In-Reply-To: <f0dd2308-6a94-46b5-821f-12ab907d29ea@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 13:21:18 +0000
Message-ID: <CAFEAcA_JFq9hFoCJDD9BNx-SOumZBtLs64B=yj-jWRrg_WMzfA@mail.gmail.com>
Subject: Re: [PATCH 3/8] target/arm: use FIELD macro for CNTHCTL bit
 definitions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 1 Mar 2024 at 21:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/1/24 08:32, Peter Maydell wrote:
> > We prefer the FIELD macro over ad-hoc #defines for register bits;
> > switch CNTHCTL to that style before we add any more bits.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   target/arm/internals.h | 19 +++++++++++++++++--
> >   target/arm/helper.c    |  9 ++++-----
> >   2 files changed, 21 insertions(+), 7 deletions(-)
> >
> > diff --git a/target/arm/internals.h b/target/arm/internals.h
> > index c93acb270cc..6553e414934 100644
> > --- a/target/arm/internals.h
> > +++ b/target/arm/internals.h
> > @@ -224,8 +224,23 @@ FIELD(VTCR, SL2, 33, 1)
> >   #define HSTR_TTEE (1 << 16)
> >   #define HSTR_TJDBX (1 << 17)
> >
> > -#define CNTHCTL_CNTVMASK      (1 << 18)
> > -#define CNTHCTL_CNTPMASK      (1 << 19)
> > +FIELD(CNTHCTL, EL0PCTEN, 0, 1)
> > +FIELD(CNTHCTL, EL0VCTEN, 1, 1)
> > +FIELD(CNTHCTL, EVNTEN, 2, 1)
> > +FIELD(CNTHCTL, EVNTDIR, 3, 1)
> ...
> > +FIELD(CNTHCTL, EL0VTEN, 8, 1)
> > +FIELD(CNTHCTL, EL0PTEN, 9, 1)
> > +FIELD(CNTHCTL, EL1PCTEN, 10, 1)
> > +FIELD(CNTHCTL, EL1PTEN, 11, 1)
>
> These bits change definition based on HCR_E2H, which I remembered when I got to patch 5,
> which adds code nearby the existing tests of these bits.
>
> It might be confusing to only provide the E2H versions, without some extra suffix?

Yeah, bits 8..11 are RES0 if E2H is 0; bits 3 and 2 are the same;
bits 0 and 1 change (to EL1PCTEN and EL1PCEN, so bit 0 when E2H is 0
has the same name as bit 10 when E2H is 1).

I don't see the need to suffix the bits that are only relevant in
one context and RES0 in the other, only the ones where the bit has
the same name but a different location, or where the same bit
number has two names. So:

+/*
+ * Depending on the value of HCR_EL2.E2H, bits 0 and 1
+ * have different bit definitions, and EL1PCTEN might be
+ * bit 0 or bit 10. We use _E2H1 and _E2H0 suffixes to
+ * disambiguate if necessary.
+ */
+FIELD(CNTHCTL, EL0PCTEN_E2H1, 0, 1)
+FIELD(CNTHCTL, EL0VCTEN_E2H1, 1, 1)
+FIELD(CNTHCTL, EL1PCTEN_E2H0, 0, 1)
+FIELD(CNTHCTL, EL1PCEN_E2H0, 1, 1)
+FIELD(CNTHCTL, EVNTEN, 2, 1)
+FIELD(CNTHCTL, EVNTDIR, 3, 1)
+FIELD(CNTHCTL, EVNTI, 4, 4)
+FIELD(CNTHCTL, EL0VTEN, 8, 1)
+FIELD(CNTHCTL, EL0PTEN, 9, 1)
+FIELD(CNTHCTL, EL1PCTEN_E2H1, 10, 1)
+FIELD(CNTHCTL, EL1PTEN, 11, 1)
+FIELD(CNTHCTL, ECV, 12, 1)
+FIELD(CNTHCTL, EL1TVT, 13, 1)
+FIELD(CNTHCTL, EL1TVCT, 14, 1)
+FIELD(CNTHCTL, EL1NVPCT, 15, 1)
+FIELD(CNTHCTL, EL1NVVCT, 16, 1)
+FIELD(CNTHCTL, EVNTIS, 17, 1)
+FIELD(CNTHCTL, CNTVMASK, 18, 1)
+FIELD(CNTHCTL, CNTPMASK, 19, 1)

(and updating the uses in following patches as needed) ?

thanks
-- PMM

