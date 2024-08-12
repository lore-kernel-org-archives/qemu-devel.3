Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAD7C52D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 10:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdSKZ-0005QD-CG; Mon, 12 Aug 2024 06:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdSKY-0005NR-Ef
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 06:31:14 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdSKW-0003zL-ED
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 06:31:14 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a6117aso1682847a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 03:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723458670; x=1724063470; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=teV7+KWxsFPiD9hQ62Y2jSQq9jDjy66bEL59TDSMYf0=;
 b=IDjypJ+43OsHpxmE9JF2BHxZOdyuQ1KJ/JFsE4cB1RHHfUU9hZeao57pGZ1svoQczr
 8MimYPAfmFqYwfzXcFSOBrtRR2NANA/uPTGf3lpcTLQRSvsXVGzv3LpOyITKX4A9wJ7x
 fiOBcPCnAP4DfLmK8dQ9j2twXPYhrQCUM2p1bl8IqvbhkR90nuqTCgE61HNVCnbBTo8S
 TJXgSW7PfEhj0MG8WhKJT9d9s2HBxqBG0OgQHZLfrZSxa7TCfoUTym51rXB8VaT4oqHu
 gEv8vp8p2qxIJDQ/tVSZtS0jUI6FMF+BpoCTiwg3EfQslsawAcHGuFr3/sjiFGfaA+iI
 G8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723458670; x=1724063470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=teV7+KWxsFPiD9hQ62Y2jSQq9jDjy66bEL59TDSMYf0=;
 b=EJmIT8Yxv/mKi3VkvlWZ+l9y33+ppPhSOHsx9pupic2qeR2qSz4/PwBDkn4DwMMXL0
 oa0Rx8f2XZG/d89QIGcbC688rExbxbPVq5SKUdDl28FpSkrkOiiN0KEZOzqBhO1GlND5
 q1XKvcxdQH6GCFncrNbS9ruxQGFQt/dBPtDqKn2dWLtkDnp1Hxtdc4nDT6HasTlQqBfu
 0U1Xs4h9D83Cx6RE6DhFK/VtqFjIB5doexQlk5qS5I+4V4t+48Sg94H5OdoxalWZRtjy
 CuqbBv7gM/egfn/W68QwFn25BXJf2/Qh5ntUiTv43r00t0Sj7nCqeelMvp17FuRZdelC
 qOtA==
X-Gm-Message-State: AOJu0Yw9qB0ZG/p7CysBvHyxRG7CMOKoXWYe6Cz2M6G73BeXii1b97wm
 ljBjs/V5UFmJYda4w7ZB8BG2nszvJyS/+WYUs+Y9z0mfhhtf4aa5I4FBYQlpqnONpNFojrheUNt
 VS8kvoHQFlbai1NXNZSZqrJqT/vDaafcrgMpmRw==
X-Google-Smtp-Source: AGHT+IFDYIavyKit0gq40KCOpDx9qTRRsZAOOzpYpxXIg9B4SW1aD0clLPBxiaS+X7hcZLD0InVDFy83XxwpvHhUjtg=
X-Received: by 2002:a05:6402:42c7:b0:5a2:97d7:c728 with SMTP id
 4fb4d7f45d1cf-5bd0a3d3756mr8733081a12.0.1723458670072; Mon, 12 Aug 2024
 03:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240809180835.1243269-1-peter.maydell@linaro.org>
 <20240809180835.1243269-10-peter.maydell@linaro.org>
 <945e5e14-9a15-4dfc-856f-f3a7d401a5bc@linaro.org>
 <CAFEAcA9nnzwm-OSpiAWTOtf2On27B1Hi2Fr3h=5jSKRPdnnQDQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9nnzwm-OSpiAWTOtf2On27B1Hi2Fr3h=5jSKRPdnnQDQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Aug 2024 11:30:58 +0100
Message-ID: <CAFEAcA9f-kgWTYg7WS7gC05wBPzG9Af8+Gnp+aBKM9_t5ToSyg@mail.gmail.com>
Subject: Re: [PULL 09/11] target/arm: add support for PMUv3 64-bit PMCCNTR in
 AArch32 mode
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Mon, 12 Aug 2024 at 10:39, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sun, 11 Aug 2024 at 22:36, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 8/10/24 04:08, Peter Maydell wrote:
> > > From: Alex Richardson <alexrichardson@google.com>
> > > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > > index 8fb4b474e83..94900667c33 100644
> > > --- a/target/arm/helper.c
> > > +++ b/target/arm/helper.c
> > > @@ -5952,6 +5952,12 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
> > >         .access = PL1_RW, .accessfn = access_trap_aa32s_el1,
> > >         .writefn = sdcr_write,
> > >         .fieldoffset = offsetoflow32(CPUARMState, cp15.mdcr_el3) },
> > > +    { .name = "PMCCNTR", .state = ARM_CP_STATE_AA32,
> > > +      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_64BIT,
> > > +      .cp = 15, .crm = 9, .opc1 = 0,
> > > +      .access = PL0_RW, .resetvalue = 0, .fgt = FGT_PMCCNTR_EL0,
> > > +      .readfn = pmccntr_read, .writefn = pmccntr_write,
> > > +      .accessfn = pmreg_access_ccntr },
> > >   };
> > >
> > >   /* These are present only when EL1 supports AArch32 */
> >
> > This fails testing:
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/7551982466
> >
> > FAIL: duplicate register {'name': 'PMCCNTR', 'regnum': 96} vs {'name': 'PMCCNTR',
> > 'regnum': 79}
> > FAIL: counted all 219 registers in XML
> > FAIL: PMCCNTR 96 == 79 (xml)
>
> Hmm, not sure why that didn't get caught by my local testing
> or by my gitlab run -- does it only get run on an aarch64 host?
>
> Anyway, the registers do architecturally have the same name
> (they're the same register, just accessible via different
> pathways). What is our practice for this? Do we just give
> one of them a non-standard name?

Looking at how we handle "PAR", we have some clunky code
to add the ARM_CP_NO_GDB flag to the 32-bit version.
I guess that produces the best results but it's going
to be kind of awkward...

-- PMM

