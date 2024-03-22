Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C950C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 10:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rncIp-0003SX-Fc; Fri, 22 Mar 2024 06:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rncIn-0003Ro-AS
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:39:09 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rncIl-0002hL-NX
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:39:09 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56bdc2a2c96so1035819a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 03:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711103945; x=1711708745; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eYeuDM4ep5y5DOBD9mJRXkz+JcDNW7jIh5JA/WzlHVM=;
 b=MntHM5NBIpOvnYRbgqEuRVFKg73zAhOerwSnDpGpYxPtMyN3bnrttOut9WU2I3VNoe
 Uz5KbePk0o6y7kp3gfQ6/fo5zcYvT9KK751MjWDwlpef3FWZj22SBfsP22Lk/sjLON3E
 ObahUygaV0D+hJU2arLjibrd6XkHaV2rfE+FZ7FQK5ntq0ZOviwgaDWdIxOHoj6yAPhO
 0xXcpHB4PPDIuV7lHx2I86GWrz9XLBJgpQh3G2wNWGINMTwlDALMd1dcDa9+x9Ve22Me
 oP+coIA7FCNHg/yhq9fsbrru+tGgnFJM4wX7trXLnVKKLcRiYZyXEVPE7GvOnl/qMqtu
 Q+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711103945; x=1711708745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eYeuDM4ep5y5DOBD9mJRXkz+JcDNW7jIh5JA/WzlHVM=;
 b=TNMBlDsiC8B8mojlpdJux6sSP+Yh8P+qeSE2YkLxu39+iloyJGNKFPkGSgjQvqSjH4
 vTUe7EJIjoUAHFnpKEbUlpXnmSWrvZy7GS9JjlrFht6eWLkCKisXSpjFkeCO2jijyK/C
 ANQXLDdNb4x8ZZhk2w7DSUM+rkcHNi8khgCi/wpf+OzXdYd4TsZw6cIbo4r8kFZWoLUt
 cIdyca7D6de1MXkVKG4QffG2TlR5TBGxLrlfyD7kOk1MhJTmMjdSlQPioHPxbT6nobFw
 Sl8tL4SrkTLhDLFmPozlbDCZij/19thxgg11BbrkzURrQcKMdsCjrcs6f2Koy3IonOYD
 Qkbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWywLbr2caea7uPTt2+k9O2tPUvvCraFSwD932/pJ+IXDejSPjSO/i4dv+I4HVzd4vaOe9G1QA+2/PMpp6d2KdyCz5Uogs=
X-Gm-Message-State: AOJu0YwCOlXk9kQbXWBAN+LbFrR5QDRNxpSI4ihVizbQpzos1vlf1EIA
 9DcXIB2vS2nVwLA/H+gozHoQV3emDWzNyedp6gZVNLsinmWxzWDo0IlvoaPlVpGLUZs+wF+s7yU
 JzX6H5tmBoqowDagJoiFNWR/KkqLCEFOBhFz+8Q==
X-Google-Smtp-Source: AGHT+IF1HZ7YaD1F87H0C53WulQOw9YMR/Q+pTQGWBccf93B0KYBfUeGXxLpge7lN2jEe07X8lGbO3BlXQ0NEDuryKg=
X-Received: by 2002:a50:d54b:0:b0:568:d757:f7d2 with SMTP id
 f11-20020a50d54b000000b00568d757f7d2mr1274852edj.10.1711103944963; Fri, 22
 Mar 2024 03:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240321130812.2983113-1-ruanjinjie@huawei.com>
 <20240321130812.2983113-7-ruanjinjie@huawei.com>
 <CAFEAcA-SO3akirm+jgKGRvKH1bcsf1bLJE2uOCOoXi1h78WwFA@mail.gmail.com>
 <CAFEAcA8+9Xd-GDNzBqGfDxoc7Bg-+wK59vcsyyNmrXrvAitAuQ@mail.gmail.com>
 <53e82726-6b92-4176-a59d-c720e2c37ef4@huawei.com>
In-Reply-To: <53e82726-6b92-4176-a59d-c720e2c37ef4@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 10:38:53 +0000
Message-ID: <CAFEAcA_HMOUJMPDW3QgNDkAMNzBXxGi1Oo5SxryBSh5vZt5kiQ@mail.gmail.com>
Subject: Re: [RFC PATCH v9 06/23] target/arm: Add support for Non-maskable
 Interrupt
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Fri, 22 Mar 2024 at 05:05, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
>
>
> On 2024/3/22 2:28, Peter Maydell wrote:
> > On Thu, 21 Mar 2024 at 15:46, Peter Maydell <peter.maydell@linaro.org> wrote:
> >> Something somewhere needs to implement "if SCTLR_ELx.NMI is 0 then
> >> we don't take EXCP_VINMI etc but instead (maybe) EXCP_VIRQ etc".
> >> At the moment nothing does that:
> >>  * arm_cpu_update_vinmi() doesn't look at the NMI bit before
> >>    deciding whether to set CPU_INTERRUPT_VINMI
> >>  * in arm_excp_unmasked() if NMI is 0 then allIntMask takes its
> >>    default value of false and so arm_excp_unmasked() returns true,
> >>    so VINMI is not masked
> >>  * arm_cpu_exec_interrupt() doesn't look at the NMI bit before
> >>    deciding whether to check the CPU_INTERRUPT_VINMI bit in interrupt_request
> >>
> >> So even if SCTLR_ELx.NMI is 0 we'll still try to take a VINMI
> >> if it's set up in the HCR_EL2 bits.
> >>
> >> However we do this the required behaviour is that if NMI is 0
> >> then it is as if the interrupt doesn't have superpriority and
> >> it falls back to being handled as an ordinary IRQ, VIRQ, VFIQ etc.
> >> I think the best place to do this is probably here in
> >> arm_cpu_exec_interrupt() -- if SCTLR_ELx.NMI isn't set then
> >> treat the VFNMI bit like VFIQ, the VINMI bit like VIRQ, and
> >> the NMI bit like IRQ.
> >
> > Folding in something like this I think will work:
> >
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 91c2896de0f..797ae3eb805 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -837,7 +837,8 @@ static bool arm_cpu_exec_interrupt(CPUState *cs,
> > int interrupt_request)
> >
> >      /* The prioritization of interrupts is IMPLEMENTATION DEFINED. */
> >
> > -    if (cpu_isar_feature(aa64_nmi, env_archcpu(env))) {
> > +    if (cpu_isar_feature(aa64_nmi, env_archcpu(env)) &&
> > +        (arm_sctlr(env, cur_el) & SCTLR_NMI)) {
> >          if (interrupt_request & CPU_INTERRUPT_NMI) {
> >              excp_idx = EXCP_NMI;
> >              target_el = arm_phys_excp_target_el(cs, excp_idx, cur_el, secure);
> > @@ -862,7 +863,22 @@ static bool arm_cpu_exec_interrupt(CPUState *cs,
> > int interrupt_request)
> >                  goto found;
> >              }
> >          }
> > +    } else {
> > +        /*
> > +         * NMI disabled: interrupts with superpriority are handled
> > +         * as if they didn't have it
> > +         */
> > +        if (interrupt_request & CPU_INTERRUPT_NMI) {
> > +            interrupt_request |= CPU_INTERRUPT_HARD;
>
> The CPU_INTERRUPT_NMI and CPU_INTERRUPT_HARD are set simultaneously,
> should the CPU_INTERRUPT_NMI be cleared?

interrupt_request here is a local variable, and we will never
check the NMI bit in it beyond this point in the function,
so there's no need to explicitly clear the NMI bit.

thanks
-- PMM

