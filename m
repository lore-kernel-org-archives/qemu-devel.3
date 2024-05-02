Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02917C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 12:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Vj1-0001OQ-PZ; Thu, 02 May 2024 08:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s2Viy-0001O7-1O
 for qemu-devel@nongnu.org; Thu, 02 May 2024 08:39:44 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s2Viv-00059Q-HN
 for qemu-devel@nongnu.org; Thu, 02 May 2024 08:39:43 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a51addddbd4so878657366b.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 05:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1714653579; x=1715258379; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XtYzsznNjgXFGwWxCNrrkFvPY6of5sv4Lpp6+h15FKA=;
 b=WKkDoWPuD7hyt5aEyo7P/myOyXvuhrMn0QFLXxdSBYbt13gy0K9hmJpZYQVprbVv4O
 +s4PLmqEjX+yiF5N0YSwUrdk0Ju9c/iiPPsS46qVilw8ua6UZqhRvyjdG3hfyEbqo9TW
 CpF5Q0p3uK8tz1yvYHA+rYe1XBXvTFR/Fs4y0Vthy8iDdMHMX5yuiUIKSLUc53oOun0H
 2krItQxm+4N6Lpgx8Tb9MOMGmlIWctXjA2JvWmitN2Nay1HJs9EsoxzmnkgqRzC1SuTD
 3c1xEGliKzS71/qb56z6Lcy1Q5ONV00pc9/IZSmMoWxHYjB5p1Vdgrf2VAfm5Wr6hNbd
 0ipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714653579; x=1715258379;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XtYzsznNjgXFGwWxCNrrkFvPY6of5sv4Lpp6+h15FKA=;
 b=mlPz6W/7V/tLIQ8LDBKtFvCEEIzNmia+WpoH77hEZNHvzqXrep8St8yX2v2Bi6VZl9
 A7aqY73s0tmTqjOwFBjbfOnC26mM5t91CrsxRQz3TZDe8kcBPkWL/WfkLcZchfEHAFHj
 bWyV8t0bSGC5iWA0MVj2seJws0XVGomdy06/eDWv4EtjitgkEjYrcqenFVME/dxjzS2Y
 R7FMn25VFOMAx8qupsr9rAym1SdbWaIaLpWbrCEw9Qm9GfhbT8EriL7i5aF4Gmo7QewS
 zMCU9TXi0bz3drZxUa/GIHw49AiluuFkHkaWcQK//kM7vhUxuz0Ex+ruJ6noWIno3iwv
 cNbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOPlv4XOnZ7ugq5de+1pAJ3gEdFJ5iEByxgLzaPAyMz/GJTGlgdP8I4Gd5Awr32Jc4LjikbyFA53WZAlsvarFaZt0T9Zg=
X-Gm-Message-State: AOJu0YzIJvbCsBs0rO13H6XYpMWq0j8dK+F/mIYWe8SZPnvTjBBMq9P3
 pgJZRtZaj2vaQ6x90QwwrtO5nLaWI/PGZVabpTeci7WvMSDLDfHXo3pvpmQucIU=
X-Google-Smtp-Source: AGHT+IEGkc+s89qdKLoT3eWuk6nkUxxNwpXKN10KrxjEQGkXdZLkg9/DT7Z74fFsHLOickC72NIQiA==
X-Received: by 2002:a17:906:c02:b0:a58:cd39:d154 with SMTP id
 s2-20020a1709060c0200b00a58cd39d154mr1232393ejf.11.1714653579313; 
 Thu, 02 May 2024 05:39:39 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 k25-20020a1709061c1900b00a58db23f174sm511734ejg.87.2024.05.02.05.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 05:39:38 -0700 (PDT)
Date: Thu, 2 May 2024 14:39:37 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Atish Patra <atishp@rivosinc.com>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, alistair.francis@wdc.com
Subject: Re: [PATCH 1/3] target/riscv: Save counter values during
 countinhibit update
Message-ID: <20240502-8a8ecc74a81a9fa33bf8c9b1@orel>
References: <20240429-countinhibit_fix-v1-0-802ec1e99133@rivosinc.com>
 <20240429-countinhibit_fix-v1-1-802ec1e99133@rivosinc.com>
 <d672ec9d-eaa0-48c1-9f99-d94cf06e7aac@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d672ec9d-eaa0-48c1-9f99-d94cf06e7aac@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62a.google.com
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

On Tue, Apr 30, 2024 at 03:00:45PM GMT, Daniel Henrique Barboza wrote:
> 
> 
> On 4/29/24 16:28, Atish Patra wrote:
> > Currently, if a counter monitoring cycle/instret is stopped via
> > mcountinhibit we just update the state while the value is saved
> > during the next read. This is not accurate as the read may happen
> > many cycles after the counter is stopped. Ideally, the read should
> > return the value saved when the counter is stopped.
> > 
> > Thus, save the value of the counter during the inhibit update
> > operation and return that value during the read if corresponding bit
> > in mcountihibit is set.
> > 
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >   target/riscv/cpu.h     |  1 -
> >   target/riscv/csr.c     | 32 ++++++++++++++++++++------------
> >   target/riscv/machine.c |  1 -
> >   3 files changed, 20 insertions(+), 14 deletions(-)
> > 
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 3b1a02b9449a..09bbf7ce9880 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -153,7 +153,6 @@ typedef struct PMUCTRState {
> >       target_ulong mhpmcounter_prev;
> >       /* Snapshort value of a counter in RV32 */
> >       target_ulong mhpmcounterh_prev;
> > -    bool started;
> >       /* Value beyond UINT32_MAX/UINT64_MAX before overflow interrupt trigger */
> >       target_ulong irq_overflow_left;
> >   } PMUCTRState;
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index 726096444fae..68ca31aff47d 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -929,17 +929,11 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
> >       if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
> >           /*
> > -         * Counter should not increment if inhibit bit is set. We can't really
> > -         * stop the icount counting. Just return the counter value written by
> > -         * the supervisor to indicate that counter was not incremented.
> > +         * Counter should not increment if inhibit bit is set. Just return the
> > +         * current counter value.
> >            */
> > -        if (!counter->started) {
> > -            *val = ctr_val;
> > -            return RISCV_EXCP_NONE;
> > -        } else {
> > -            /* Mark that the counter has been stopped */
> > -            counter->started = false;
> > -        }
> > +         *val = ctr_val;
> > +         return RISCV_EXCP_NONE;
> >       }
> >       /*
> > @@ -1973,9 +1967,23 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
> >       /* Check if any other counter is also monitoring cycles/instructions */
> >       for (cidx = 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
> > -        if (!get_field(env->mcountinhibit, BIT(cidx))) {
> >               counter = &env->pmu_ctrs[cidx];
> > -            counter->started = true;
> > +        if (get_field(env->mcountinhibit, BIT(cidx)) && (val & BIT(cidx))) {
> > +	    /*
> > +             * Update the counter value for cycle/instret as we can't stop the
> > +             * host ticks. But we should show the current value at this moment.
> > +             */
> > +            if (riscv_pmu_ctr_monitor_cycles(env, cidx) ||
> > +                riscv_pmu_ctr_monitor_instructions(env, cidx)) {
> > +                counter->mhpmcounter_val = get_ticks(false) -
> > +                                           counter->mhpmcounter_prev +
> > +                                           counter->mhpmcounter_val;
> > +                if (riscv_cpu_mxl(env) == MXL_RV32) {
> > +                    counter->mhpmcounterh_val = get_ticks(false) -
> > +                                                counter->mhpmcounterh_prev +
> > +                                                counter->mhpmcounterh_val;
> > +		}
> > +            }
> >           }
> >       }
> > diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> > index 76f2150f78b5..3e0f2dd2ce2a 100644
> > --- a/target/riscv/machine.c
> > +++ b/target/riscv/machine.c
> > @@ -328,7 +328,6 @@ static const VMStateDescription vmstate_pmu_ctr_state = {
> >           VMSTATE_UINTTL(mhpmcounterh_val, PMUCTRState),
> >           VMSTATE_UINTTL(mhpmcounter_prev, PMUCTRState),
> >           VMSTATE_UINTTL(mhpmcounterh_prev, PMUCTRState),
> > -        VMSTATE_BOOL(started, PMUCTRState),
> 
> Unfortunately we can't remove fields from the VMStateDescription without breaking
> migration backward compatibility. Older QEMUs will attempt to read a field that
> doesn't exist and migration will fail.
> 
> I'm assuming that we care about backward compat. If we're not up to this point yet
> then we can just bump the version_id of vmstate_pmu_ctr_state and be done with it.
> This is fine to do unless someone jumps in and complains that we broke a migration
> case for the 'virt' board. Granted, we don't have versioned boards yet so I'm unsure
> if someone would actually have a base to complain. Alistair, Drew, care to comment?

Without versioning boards, then we shouldn't expect migrations to work for
anything other than between QEMUs of the same version. We're delaying the
versioning until it's reasonable to expect users to prefer to migrate
their guests, rather than reboot them, when updating the QEMU the guests
are running on. I'm not sure how we'll know when that is, but I think we
can wait until somebody shouts or at least until we see that the tooling
which makes migration easy (libvirt, etc.) is present.

Regarding this patch, I'm curious what the current status is of migration.
If we can currently migrate from a QEMU with the latest released version
to a QEMU built from the current upstream, and then back again, then I
think this patch should be written in a way to preserve that. If we
already fail that ping-pong migration, then, as this patch doesn't make
things worse, we might as well save ourselves from the burden of the
compat code.

Thanks,
drew

