Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CFEC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 10:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdSTK-0006F2-Am; Mon, 12 Aug 2024 06:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdSTI-0006E4-Af
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 06:40:16 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdSTG-0005IV-Ab
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 06:40:16 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5af6a1afa7bso4986533a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 03:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723459212; x=1724064012; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OhX3jzDzlDHF0LwghLhn9saUS05tYEBsrpisNDDLAHI=;
 b=A9+warWAryNHVVy9UOd3RW6b+aXLitbu40z8T3JXC6HLDr2nNWRiD+rIqqucOxInS/
 vV+gFKmWBiMZbPRdw77O2Jmcq9fIfGxgir9KMRRxuqF3KFx4kYxbw/N4FZdX0rZ0xjYy
 /9tZbjtgSN7jYPVC5tGQz1J9tCCcSKfy6TurbZaA2tUKGxnDwnqp25b9NjArJn1zTBHl
 fQafg4aWmihJLQwA/uyh5lJBWxxVvT+2+GWAQtoPJsoFwk7ViczuLI4VJ7CEeTrpNyGX
 1ktUPUDLZ6NeW3qg5azPB4sUj76QxLNh3vxR1N8Xh/quTLZxRtwicqS1GrU9fy+dIHli
 RC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723459212; x=1724064012;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OhX3jzDzlDHF0LwghLhn9saUS05tYEBsrpisNDDLAHI=;
 b=saGRCi0bXvCJfGownct33HpZBIW0fsm3ZiX0dsfUAxKTYd61AIn0b/YjAxxK6FIFE7
 0wdim7S84e4c96SCQwYfDp3nVZaDbiyf7vUTZG7hscQYphGTiFPuJKprd2QvM7yGjKjg
 OjyFG/Wvhp94s794+2y6vfaNtB87bW/CsMD16bhtippqfQU6No67Rs+NpqPkY37QHv9C
 7fWNIoxwPmHFJ+J+h9fWU9Gin8UQ/j6cnxjH8F7fpYp6lj/Ij7kjyWZAmAB6Bnhv3rns
 OLsfz4CnDYxRJwmFKPofafhqGQbvfQnt+nlFeOdbUZCQZXpu7i36TapluCaKlsHW5cGs
 jV1Q==
X-Gm-Message-State: AOJu0Yz7+0ZJwBMEhOBJQdvfCUhFcYdp0Q4zuJkT/2SFLruM9BVSGnn2
 VYeS3RGoQ2ttKOkITK7dLGTlzVqUR4MbpgQhvYfQF1IbDgc2IykmqnpuKN1Idn81+ITdQsNwmIg
 7EifmXpSn5fpxR6dL0l8LL4s4w+TMm4qLRJUWOrGsB+jM93qn
X-Google-Smtp-Source: AGHT+IE0TiS6WLIRXQvPxa/tf01qpMMLpRD/sspf4M126j2Wtx/XE6cPoOhw8zOQtlqa99ANpmolnBBMWw0IXgrhyB8=
X-Received: by 2002:a05:6402:40d1:b0:5a2:cc1c:4d07 with SMTP id
 4fb4d7f45d1cf-5bd0a62ac38mr5557762a12.27.1723459212383; Mon, 12 Aug 2024
 03:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240801220328.941866-1-alexrichardson@google.com>
 <CAFEAcA88Y=VXcTAGyZ396L2VDQp77E5KaStjpKrT5AS1aouC9w@mail.gmail.com>
In-Reply-To: <CAFEAcA88Y=VXcTAGyZ396L2VDQp77E5KaStjpKrT5AS1aouC9w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Aug 2024 11:40:01 +0100
Message-ID: <CAFEAcA_d1_sXXrLgUevi0RRHYVejFpwg68peU6bHU61MX3NrJg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: add support for 64-bit PMCCNTR in AArch32 mode
To: Alex Richardson <alexrichardson@google.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 8 Aug 2024 at 14:03, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 2 Aug 2024 at 02:00, Alex Richardson <alexrichardson@google.com> wrote:
> >
> > See https://developer.arm.com/documentation/ddi0601/2024-06/AArch32-Registers/PMCCNTR--Performance-Monitors-Cycle-Count-Register?lang=en
> >
> > Signed-off-by: Alex Richardson <alexrichardson@google.com>
> > ---
> >  target/arm/helper.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 8fb4b474e8..94900667c3 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -5952,6 +5952,12 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
> >        .access = PL1_RW, .accessfn = access_trap_aa32s_el1,
> >        .writefn = sdcr_write,
> >        .fieldoffset = offsetoflow32(CPUARMState, cp15.mdcr_el3) },
> > +    { .name = "PMCCNTR", .state = ARM_CP_STATE_AA32,
> > +      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_64BIT,
> > +      .cp = 15, .crm = 9, .opc1 = 0,
> > +      .access = PL0_RW, .resetvalue = 0, .fgt = FGT_PMCCNTR_EL0,
> > +      .readfn = pmccntr_read, .writefn = pmccntr_write,
> > +      .accessfn = pmreg_access_ccntr },
> >  };
> >
> >  /* These are present only when EL1 supports AArch32 */

> I've applied this to target-arm.next (with an expansion
> of the commit message to note some of the above).

It turns out that this breaks 'make check-tcg', because
when we generate the XML for the system registers for the
gdbstub we want to not have any duplicate register names.
(See thread at:
https://lore.kernel.org/qemu-devel/20240809180835.1243269-1-peter.maydell@linaro.org/T/#ma8051fd02da69ed0cac44e898ac0a61c131ff561
 )

So I'm dropping this for the moment.

thanks
-- PMM

