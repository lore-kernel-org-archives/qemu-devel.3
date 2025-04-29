Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CC8C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9k6s-0000Yw-B5; Tue, 29 Apr 2025 08:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9k6f-0000Qu-2W
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:30:38 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1u9k6c-0002I8-Pp
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:30:36 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-70565ccf3bcso62573197b3.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745929831; x=1746534631; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BAoci+tEcvKSPJsvbDNdvTaojpcFbLCSV+TJjTCof04=;
 b=P0zvnG+91WUcIvF7xsxutjre/IjJeaMu/4su4AnFXrd74q6+iZysmBYUtKjLdjjWmc
 xgzCQTxOfaS9pRev28ZB6j1se/Ktud1tPSR0lCtGmnIICKIoUE7FitbcmExepYtnklyE
 cv9IgliwX9FUWnthgT+Y1jgvRkT5xOWKK8J8DJrSMJtklc7n1djP75ONbcO2gnLu5x8n
 EMTv9gIA94Z9rpe+o9c7BLLz3UrAHiVTgaezsHSxivv20TCsYJsMVVBcHejMIw9goG5I
 FIW3vBtgRXC+ed/xPPw4TBScJv5jki+pRZ1odGX06DyAO6Zala+/PJb40FJ4ZSt5QcGV
 dD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745929831; x=1746534631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BAoci+tEcvKSPJsvbDNdvTaojpcFbLCSV+TJjTCof04=;
 b=CM9BHOTK+vtl9SBUXEOWlvXJMTtGCcz9a3lOo26Iv0ZzaCTtjIl3Txzc+uwwdNAu3c
 69U85Qv+vdTGjEZHrNfvJwsFrrcC7RQELUr7WhU0wF2pMxrD9kOnpK8wvmzJ+oQSQeT8
 LQoddNCY7rhkURDqI7jmmCuJNzBLxG8fug3PcauSMutRLgqwoxk7SBvBBZKmMx30cf81
 1hJFmG3U4GMmfAk2wMQJaTtqCqq6lAuorwITron+xOPyeGmLoRrWnSxZJleYW2pgXP1B
 WpcuaySxKvJ3WlSr34mREbyr8iaoiRMgsxN8gJaGEtHBccUpkpawHIis/MTsmq3tMcaG
 xP/Q==
X-Gm-Message-State: AOJu0YyXFX7BTamu9KG4wUbV5ixB8olmwmx6KkrIHgTfL3cxSud5w2N3
 TVzPpmrJlux5M8MaqoMoeqNC6+sPeRkAnIjD60MG6JHtobtYGYbPldPIxFRx+6pJmixQiJLSrW+
 lBpAiH0CenRAcHv8s0IfZmZTepkzEP0JuRIPKNBYUFQ+Dl+cb
X-Gm-Gg: ASbGncsBo7zwonnevt+tx7mn0ERvswJjf1clkAo2tftYnL9coo7EQrhH5pdanoWQj7w
 wgVcQP00frNGGAbxu7jz9Rt02NQ+m9xmhT0ORTBDG6UUN/9XrmA3X+QRtCDB53iBS1ASrNkHxSI
 yfp8jkBUZUQaoruGy/eikGuXY=
X-Google-Smtp-Source: AGHT+IEbpEUcx5AZO2lH4sduL6PbBgknqegiof875xjPqvBYOV1RRo72spOaoadeKqUkQuIILw2xexX9j0sGnZ/FPYQ=
X-Received: by 2002:a05:690c:3813:b0:706:cc6b:8547 with SMTP id
 00721157ae682-708997558f7mr48677057b3.25.1745929831671; Tue, 29 Apr 2025
 05:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250213142613.151308-1-peter.maydell@linaro.org>
 <CAFEAcA86t=uc_XZd0s1yOFsop68XN2HK7c5MUJNfn7kcDoMsxQ@mail.gmail.com>
 <CAFEAcA8CWFsxK6u0gg_pwCokGmzHe0=TRyf=9560APLX1DezMA@mail.gmail.com>
 <CAFEAcA8Z7KcMkELkO42SfLQMi=ctdVWhp7C150_RkM9b-LF=bA@mail.gmail.com>
In-Reply-To: <CAFEAcA8Z7KcMkELkO42SfLQMi=ctdVWhp7C150_RkM9b-LF=bA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Apr 2025 13:30:20 +0100
X-Gm-Features: ATxdqUEwsd2pFE-MY2qmEO9sOzYGnkaz2HEAoNBXabE0JeXqc0ExLbYqAW5FNPM
Message-ID: <CAFEAcA8wMbZGzo8nAYUr-Ze1eAR4A_27JycAV7j2XH+5oExJ-A@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/i386: Emulate ftz and denormal flag bits
 correctly
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

Ping^4, now that 10.0 is out; these are all reviewed patches.

Patchew link:
https://patchew.org/QEMU/20250213142613.151308-1-peter.maydell@linaro.org/


thanks
-- PMM

On Wed, 12 Mar 2025 at 13:22, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Ping^3 ? Anybody home?
>
> thanks
> -- PMM
>
> On Fri, 7 Mar 2025 at 10:38, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > Ping^2 for pickup of reviewed patches.
> >
> > thanks
> > -- PMM
> >
> > On Mon, 24 Feb 2025 at 14:47, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > Ping? Would an i386 maintainer like to pick these up?
> > >
> > > thanks
> > > -- PMM
> > >
> > > On Thu, 13 Feb 2025 at 14:26, Peter Maydell <peter.maydell@linaro.org> wrote:
> > > >
> > > > This is a set of four patches to target/i386 which use the core
> > > > fpu functionality we just landed for Arm FEAT_AFP to correct
> > > > the emulation of some corner cases of x86 floating point:
> > > >  * when we are flushing denormal outputs to zero, this should
> > > >    be done after rounding, not before
> > > >  * the MXCSR.DE and FPUS.DE bits indicate when a denormal input
> > > >    was not flushed and was used in an fp operation; we previously
> > > >    weren't implementing these semantics
> > > >
> > > > All four patches have been reviewed by RTH. Testing is a bit
> > > > light (make check-tcg and make check-functional), because AFAIK
> > > > there is no freely available comprehensive FP testsuite for x86,
> > > > and risu doesn't support x86 currently so I can't do the same kind
> > > > of random-instruction-testing I could for Arm.
> > > >
> > > > thanks
> > > > -- PMM
> > > >
> > > > Peter Maydell (4):
> > > >   target/i386: Detect flush-to-zero after rounding
> > > >   target/i386: Use correct type for get_float_exception_flags() values
> > > >   target/i386: Wire up MXCSR.DE and FPUS.DE correctly
> > > >   tests/tcg/x86_64/fma: add test for exact-denormal output
> > > >
> > > >  target/i386/ops_sse.h        |  16 +++---
> > > >  target/i386/tcg/fpu_helper.c | 101 +++++++++++++++++------------------
> > > >  tests/tcg/x86_64/fma.c       |  17 ++++--
> > > >  3 files changed, 68 insertions(+), 66 deletions(-)
> > > >
> > > > --
> > > > 2.43.0

