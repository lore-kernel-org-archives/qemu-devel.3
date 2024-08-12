Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57F0C52D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 09:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdRWt-00010y-Nv; Mon, 12 Aug 2024 05:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdRWq-0000rn-GG
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 05:39:52 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdRWo-0004j4-Ny
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 05:39:52 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5a1f9bc80e3so1818776a12.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 02:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723455588; x=1724060388; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pfK5sTi8yI/IkOfN0bSMTnvpTluWZj3mNnXrj8Wk8ps=;
 b=BE9binvresMmPHzZZ72x9wqbAA5m2pXJ7H4w03MkJ+17j5KgvzvnSJCyu+O48YKTVX
 MRuQnN446dPHqzPLJppV3gHESsD0WW+KF+P+EEgGhGfYcjYZBQ+4mTZiFrdNVMoHVBS7
 m2JW793lr90IMboNiAEauhvN5h2pX3d8lHTFKWWZmMqun4ijxeb+elTsImk/hsvQEvNL
 xtBHXhOKpQ5y335Dq2n756YD+I5VdkA81+X+mYMOEHn4Uy9gl5fqzSUOmJJJJq3Rn2r3
 EHYcowkjDJorhsfYOtgB3IJIEd7fGnc5W9NpEdYTHFiEg1lIwYfWsWmtDEGIO3IAY8Wr
 q6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723455588; x=1724060388;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pfK5sTi8yI/IkOfN0bSMTnvpTluWZj3mNnXrj8Wk8ps=;
 b=m6oH8mKp2SNZYDJczzxKzlOdpaINnTePFhNAH/Ss9d5sdOYOIfcJ3qB/3evEzQdw7B
 6l+SmgNxRR6elIIpQiWHuD+B+DJYQVAB1KcREtXvrPjXQqwfZji3KAdkB3p+UmlYFGRH
 VPwll65EpAxBDxamYCeLfQaKbvJZK/2LenbT9ASO5+e+tbTsXF796vVPGF5IwWuMqYlZ
 1TSfb8tCJPS3B6b8mY0trQjO5M1IWhdYa/StE+FCBvQ8Qk/L9cM4+GOB784gy+CBwGz8
 ZiIrTYpgNe6uKn6ChRd2ghJSAusZ5Bz7yuJYrwaD56POersrchSNMZWaTmjwVSfdpsKK
 8WOA==
X-Gm-Message-State: AOJu0YwkyYZZHLilKctxbtyaDTRYbeFaC0HEShh4G+DRL1sLqfJVJRdI
 WsCv+EoETFIqQAvSoq8ZnLjkjgL2YQ3wMWVCBcX3BDHlp5nmusL1hM7kTBhuIgSnQpgMo2lG0tf
 +wijh3o86kuE+Rhs5Wqml9dmVumd+dW/vgSrjTw==
X-Google-Smtp-Source: AGHT+IEzK8AO4DiIkeFtYggxTAFTc/X75XTyCF88mIvuj7YsKr5tsA1N/lZ5iR6ffu25zq3ojfiyA1pSmoOy34x2p4k=
X-Received: by 2002:a05:6402:d08:b0:5a1:5692:b5f9 with SMTP id
 4fb4d7f45d1cf-5bd0a681fefmr8012817a12.38.1723455588233; Mon, 12 Aug 2024
 02:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240809180835.1243269-1-peter.maydell@linaro.org>
 <20240809180835.1243269-10-peter.maydell@linaro.org>
 <945e5e14-9a15-4dfc-856f-f3a7d401a5bc@linaro.org>
In-Reply-To: <945e5e14-9a15-4dfc-856f-f3a7d401a5bc@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Aug 2024 10:39:36 +0100
Message-ID: <CAFEAcA9nnzwm-OSpiAWTOtf2On27B1Hi2Fr3h=5jSKRPdnnQDQ@mail.gmail.com>
Subject: Re: [PULL 09/11] target/arm: add support for PMUv3 64-bit PMCCNTR in
 AArch32 mode
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Sun, 11 Aug 2024 at 22:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/10/24 04:08, Peter Maydell wrote:
> > From: Alex Richardson <alexrichardson@google.com>
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 8fb4b474e83..94900667c33 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -5952,6 +5952,12 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
> >         .access = PL1_RW, .accessfn = access_trap_aa32s_el1,
> >         .writefn = sdcr_write,
> >         .fieldoffset = offsetoflow32(CPUARMState, cp15.mdcr_el3) },
> > +    { .name = "PMCCNTR", .state = ARM_CP_STATE_AA32,
> > +      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_64BIT,
> > +      .cp = 15, .crm = 9, .opc1 = 0,
> > +      .access = PL0_RW, .resetvalue = 0, .fgt = FGT_PMCCNTR_EL0,
> > +      .readfn = pmccntr_read, .writefn = pmccntr_write,
> > +      .accessfn = pmreg_access_ccntr },
> >   };
> >
> >   /* These are present only when EL1 supports AArch32 */
>
> This fails testing:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/7551982466
>
> FAIL: duplicate register {'name': 'PMCCNTR', 'regnum': 96} vs {'name': 'PMCCNTR',
> 'regnum': 79}
> FAIL: counted all 219 registers in XML
> FAIL: PMCCNTR 96 == 79 (xml)

Hmm, not sure why that didn't get caught by my local testing
or by my gitlab run -- does it only get run on an aarch64 host?

Anyway, the registers do architecturally have the same name
(they're the same register, just accessible via different
pathways). What is our practice for this? Do we just give
one of them a non-standard name?

-- PMM

