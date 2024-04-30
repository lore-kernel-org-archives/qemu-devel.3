Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C414C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 18:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1sTO-0003o0-Ai; Tue, 30 Apr 2024 14:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1sTN-0003nJ-Fp
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 14:45:01 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1sTD-00050N-Vp
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 14:45:01 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-572250b7704so6385284a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714502690; x=1715107490; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gBgASPmO3umVtWBxwX2dWIChGUiJly3iRrpORmwNCA=;
 b=gjDV9RccW+neDm2ZaHUJL1v7rBUcnEeJmKqZ0q4+CsGILmFO2FNQehSpvSkxPtqPLM
 +HvI+2aW7Hi0F+95xykoYpyswUwwc9+nzholtdBZYDFtJeJcVerqOjrnvRiYO1h5ITCH
 0JEouTyFBU97TRlTanMM1iUWwqInBoMW+4BiFW5eGDbmZSpyor6XTVdjyYlUTJhKm6rS
 7y11JiHcJ/mH1llJ38yP/fVapu9KefTIhRjYWV4Lqs+j9bGA5j9pUNF0oVojQlYtj22L
 JHk9SVVWs1Qx9hBWmoOYIukNKLav0etu7qvJHE3Zh8PmEiRhwRa+26Wjq+mM7UAWNtQh
 xy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714502690; x=1715107490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3gBgASPmO3umVtWBxwX2dWIChGUiJly3iRrpORmwNCA=;
 b=Cz/hp6WNLlW/ClIbgcWOhgW5uR1IgAii2DYazS1e4MqzDj4V1hI4BAaJ8bHsu5moPu
 IA07h4E4n0DWQGDP712vUctP43j2dCGIN45YexfTxZY4g7FcefBh/z8dUDIjfoeFHq9x
 Xb6VPtaQHt1BBLzZ5M0TEXLMGUEs8cN0ZycXkgZXjUYApuEiVnrWN/peaIevIdepi7zl
 ZdV4yC44JlMic34PW/LTnNdEkCCif0T4mYIK9yv/P2RnggSLQSKOkVk5G98cZX9E2bfl
 cVVp2c/W75eqQrwCssw0sfKhrNtJbqA9n7x6FI0uYMnMFEKq9+RrXyatfuopA3oTJeME
 DaHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwLOWcENSgULs2GWTZv80DoF4iYdIw46OmVl8gVn9c1EY8TEsn88dPW4oHIr2a6qeGNAmZMgLfchLV1Zc2K7Ee6Iwpupw=
X-Gm-Message-State: AOJu0YzW5Nal2rxRy55yfg+NmkQLYZrn7vAoa2zr7xjccMM9VU5+U+v+
 ZxTQ4R8tC+i2ueg7YZPu65ChL6WJPW5XYo7ezJJ87hcDZFoxakIM4zm1kMk5DGeiGdsEVme7LR0
 K8cOGoGJIGpf2S79Z9vrvUKjbeK0WcWehvg/eHw==
X-Google-Smtp-Source: AGHT+IFuMFg0PiJtqAlOUKGqjf2n9rAlcZePYebauohCzwk4FET2C8il2R8vdrWLPxH/BY67FY6E7Gwmcqno3AoQvXE=
X-Received: by 2002:a50:aad3:0:b0:565:dfac:a686 with SMTP id
 r19-20020a50aad3000000b00565dfaca686mr411314edc.38.1714502690495; Tue, 30 Apr
 2024 11:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240430140035.3889879-1-peter.maydell@linaro.org>
 <20240430140035.3889879-2-peter.maydell@linaro.org>
 <87ttji3h69.fsf@draig.linaro.org>
In-Reply-To: <87ttji3h69.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2024 19:44:39 +0100
Message-ID: <CAFEAcA-UL6cd7Obbx8sHpJ-Vdb-vpU8NJwdcLM2P+8ZpFnj2kg@mail.gmail.com>
Subject: Re: [PATCH 1/2] accel/tcg: Make TCGCPUOps::cpu_exec_halt return bool
 for whether to halt
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 30 Apr 2024 at 18:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > The TCGCPUOps::cpu_exec_halt method is called from cpu_handle_halt()
> > when the CPU is halted, so that a target CPU emulation can do
> > anything target-specific it needs to do.  (At the moment we only use
> > this on i386.)
> >
> > The current specification of the method doesn't allow the target
> > specific code to do something different if the CPU is about to come
> > out of the halt state, because cpu_handle_halt() only determines this
> > after the method has returned.  (If the method called cpu_has_work()
> > itself this would introduce a potential race if an interrupt arrived
> > between the target's method implementation checking and
> > cpu_handle_halt() repeating the check.)
> >
> > Change the definition of the method so that it returns a bool to
> > tell cpu_handle_halt() whether to stay in halt or not.
> >
> > We will want this for the Arm target, where FEAT_WFxT wants to do
> > some work only for the case where the CPU is in halt but about to
> > leave it.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  include/hw/core/tcg-cpu-ops.h       | 11 +++++++++--
> >  target/i386/tcg/helper-tcg.h        |  2 +-
> >  accel/tcg/cpu-exec.c                |  7 +++++--
> >  target/i386/tcg/sysemu/seg_helper.c |  3 ++-
> >  4 files changed, 17 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-op=
s.h
> > index dc1f16a9777..f3ac76e6f6d 100644
> > --- a/include/hw/core/tcg-cpu-ops.h
> > +++ b/include/hw/core/tcg-cpu-ops.h
> > @@ -111,8 +111,15 @@ struct TCGCPUOps {
> >      void (*do_interrupt)(CPUState *cpu);
> >      /** @cpu_exec_interrupt: Callback for processing interrupts in cpu=
_exec */
> >      bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
> > -    /** @cpu_exec_halt: Callback for handling halt in cpu_exec */
> > -    void (*cpu_exec_halt)(CPUState *cpu);
> > +    /**
> > +     * @cpu_exec_halt: Callback for handling halt in cpu_exec.
> > +     *
> > +     * Return true to indicate that the CPU should now leave halt, fal=
se
> > +     * if it should remain in the halted state.
> > +     * If this method is not provided, the default is to leave halt
> > +     * if cpu_has_work() returns true.
> > +     */
> > +    bool (*cpu_exec_halt)(CPUState *cpu);
>
> Would it be too much to rename the method to cpu_exec_leave_halt() to
> make it clearer on use the sense of the return value?

We could, but that makes it sound like it's a method to say
"should we leave halt?", which ...

> > -void x86_cpu_exec_halt(CPUState *cpu)
> > +bool x86_cpu_exec_halt(CPUState *cpu)
> >  {
> >      if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
> >          X86CPU *x86_cpu =3D X86_CPU(cpu);
> > @@ -138,6 +138,7 @@ void x86_cpu_exec_halt(CPUState *cpu)
> >          cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
> >          bql_unlock();
> >      }
> > +    return cpu_has_work(cpu);
>
> The x86 version is essentially being called for side effects. Do we want
> to document this usage in the method?

...is not how the x86 target is using it, as you note.

thanks
-- PMM

