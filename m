Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F333FC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwzN-00032Z-Fu; Tue, 11 Jun 2024 04:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sGwzL-00032D-II
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:36:19 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sGwzJ-0005bd-Vb
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:36:19 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-579fa270e53so1034534a12.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 01:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718094976; x=1718699776; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6RembHLwkOyv7tlgzOTSxzgHhL8szsKqgQ3ptT75Lc=;
 b=rnj4X5jprd1tu8V88KtH1mDccYmHUDNjkJulERy3tEgH2tR5P5fu+FNzxO+KDyhnmr
 2e9dRB2Cn60g8K8U1B9ibJ3ayvZP/3lNhxtR7sFRNSuSfoBRiMNkLwfCVoqRXOWT3kKr
 BgzzaATTFVukCZvcT2XRCBlLmnJhvaFJLwpT2zzjwfOXesOqrKh5nVLzz3c7I+QM/2QB
 9LO4W2iSPpcxSsQj+fwCgFyM0y+8xptHXRsR6w6mAqDEluU6SEZA5l9sAszhq2zwmHNY
 ITVAsTwDZynydo5WpY+Zzb4fLvcyVWeTViSJEJ3rN2w8RmHtRobH7BKcAuHDqeeERiSG
 hIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718094976; x=1718699776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k6RembHLwkOyv7tlgzOTSxzgHhL8szsKqgQ3ptT75Lc=;
 b=nrpEW4Twi6u1eNTI+ck7c7KeR32fJX/Umz+3NnRHBXp79eO346kOEok7nGSjOueNqB
 XW1+V/4qDZzW242MGSJokij0hGCHvP2mljxqhpHujfVTqt5Zrin1B2ykJ3L4IEN0rati
 yY2sGEyC2jJfIXtH2nbc7QVtrGVaIqb0v5AwiYWgsqSiqyMwPrYRbvYAbhwHRNYq9llW
 SplDf6BPgr5CqXYY4AeAhyBrWN6xLGQViwEKKhT3TcchLtwguu5CsFoeJ+qoI9D7HNE0
 22zT8jvKFtnHlBh6UAuLcFKXe+xGvTLylB0kWURNu5ZnFM3d4bTAhDziy98yFQjzOVpt
 9zVA==
X-Gm-Message-State: AOJu0Yyk5FrYGo73QmSoL600uRe7SMDPe+BB60EcJUkTdEsXHi5G0Uc7
 AF2FWGEkUt0sQnTW2/6KoQnf2jT13XQha5vdlrqfiK/9CfZm4EiI++f9k8GjiOxsOfuz0Qw7Mog
 qHPR3ITu3hMFXimWSWieeMhj+uUcxYPpRWVljrA==
X-Google-Smtp-Source: AGHT+IF5gHCdZresklNd7YCM+DWy1SrJMzdlWjXFs3AEbdfZz6trsPVEh30mEff45zSdIdTSyVcupISpvjS3/FuaVd0=
X-Received: by 2002:a50:9fa7:0:b0:57c:5fc9:16a3 with SMTP id
 4fb4d7f45d1cf-57c5fc916f4mr8015835a12.13.1718094975822; Tue, 11 Jun 2024
 01:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240603160933.1141717-1-peter.maydell@linaro.org>
 <20240603160933.1141717-4-peter.maydell@linaro.org>
 <5b10d49a-8da2-491f-8b8c-26556482957d@linaro.org>
In-Reply-To: <5b10d49a-8da2-491f-8b8c-26556482957d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jun 2024 09:36:02 +0100
Message-ID: <CAFEAcA_1JyzM9WiBsQ-3YxNmH3i1usnU3iAc7QR-G2m89f-GbQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] accel/tcg: Make TCGCPUOps::cpu_exec_halt mandatory
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 11 Jun 2024 at 09:25, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Peter,
>
> On 3/6/24 18:09, Peter Maydell wrote:
> > Now that all targets set TCGCPUOps::cpu_exec_halt, we can make it
> > mandatory and remove the fallback handling that calls cpu_has_work.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   include/hw/core/tcg-cpu-ops.h | 9 ++++++---
> >   accel/tcg/cpu-exec.c          | 7 +------
> >   2 files changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-op=
s.h
> > index 099de3375e3..34318cf0e60 100644
> > --- a/include/hw/core/tcg-cpu-ops.h
> > +++ b/include/hw/core/tcg-cpu-ops.h
> > @@ -122,10 +122,13 @@ struct TCGCPUOps {
> >        * to do when the CPU is in the halted state.
> >        *
> >        * Return true to indicate that the CPU should now leave halt, fa=
lse
> > -     * if it should remain in the halted state.
> > +     * if it should remain in the halted state. (This should generally
> > +     * be the same value that cpu_has_work() would return.)
> >        *
> > -     * If this method is not provided, the default is to do nothing, a=
nd
> > -     * to leave halt if cpu_has_work() returns true.
> > +     * This method must be provided. If the target does not need to
> > +     * do anything special for halt, the same function used for its
> > +     * CPUClass::has_work method can be used here, as they have the
> > +     * same function signature.
> >        */
> >       bool (*cpu_exec_halt)(CPUState *cpu);
> >       /**
> > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> > index 6711b58e0b2..8be4d2a1330 100644
> > --- a/accel/tcg/cpu-exec.c
> > +++ b/accel/tcg/cpu-exec.c
> > @@ -682,13 +682,8 @@ static inline bool cpu_handle_halt(CPUState *cpu)
> >   #ifndef CONFIG_USER_ONLY
> >       if (cpu->halted) {
> >           const TCGCPUOps *tcg_ops =3D cpu->cc->tcg_ops;
> > -        bool leave_halt;
> > +        bool leave_halt =3D tcg_ops->cpu_exec_halt(cpu);
> >
> > -        if (tcg_ops->cpu_exec_halt) {
> > -            leave_halt =3D tcg_ops->cpu_exec_halt(cpu);
> > -        } else {
> > -            leave_halt =3D cpu_has_work(cpu);
> > -        }
> >           if (!leave_halt) {
> >               return true;
> >           }
>
> Could we assert the handler is assigned in tcg_exec_realizefn()?

Yeah, we could. I thought about an assert that it was set up,
but couldn't identify a place to do that.

> If you agree I could squash these 3 lines:
>
> -- >8 --
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -1077,6 +1077,10 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **err=
p)
>       static bool tcg_target_initialized;
>
>       if (!tcg_target_initialized) {
> +        /* Check mandatory TCGCPUOps handlers */
> +        assert(cpu->cc->tcg_ops->initialize);
> +        assert(cpu->cc->tcg_ops->cpu_exec_halt);
> +
>           cpu->cc->tcg_ops->initialize();

I don't think we need to assert initialize if we're about to call
it anyway -- the call will crash if it's NULL in an easy to diagnose way.

>           tcg_target_initialized =3D true;
>       }
> ---
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

thanks
-- PMM

