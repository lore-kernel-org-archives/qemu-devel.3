Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF59C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 08:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Lgw-0008Q4-0B; Fri, 10 May 2024 04:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s5Lgt-0008Pk-EE
 for qemu-devel@nongnu.org; Fri, 10 May 2024 04:33:19 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s5Lgr-0005Mw-8Z
 for qemu-devel@nongnu.org; Fri, 10 May 2024 04:33:18 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2e27277d2c1so22099761fa.2
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 01:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715329994; x=1715934794; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D4z5zh73hszhEhJ+HWke81T5S/M2o7KslWNub/qU0/c=;
 b=VbRnexHVDkNkiWku5h5uL67oNzv0Dygz/+kpYS7om6xF1Fh9gAIkaO49/XNWBWrX5N
 b+U4sMvyAUg10QM8mtVCM0gxDwQ9G96SUZ+EMvc58IXnVNuMrTgdld1JXFrdFAWj9z/w
 UWcFRhuARL7tUpCaRju455RFRDkPgMDHvY6kNUB7e0YadPV1uKOs4zhPxUM87QRleEyC
 4/iWxbAqwk3Zd9Pep3Zqn16rdHrYfIWRnLaCZlyRWmagtv1lWh5mDOd31BVb9opgEGn2
 vbN2++G49HLQvVRm0EwPRXI5TkG0T9faDtbOYIpbphEe97FBPDPd+0LlIsQ8EFhAKJhI
 r3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715329994; x=1715934794;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D4z5zh73hszhEhJ+HWke81T5S/M2o7KslWNub/qU0/c=;
 b=S81ELUf73ZfIqvGdnh7HpcY8ymKX39xibDIht2tzTGbLIiWcROxgGLrgovnJmhKICG
 ALwyJWnzy0Lz4S3RuGhx23HAlaBgfuA27xF362RUgmW2N3DQ5GywZNoDvU5gSnYD5Duf
 m0XfuX9uvuyZFeP0BDdVYpuQnRSXXQMgvGFCMyesV0H6RPqY7x0jNDHYtTmdZqvnxl/I
 H4QAXMq4FoL8Wox5LY2X6UXyRvmzCu6Da76/+ZLopoHwgRao/4X17w6W2tcYo6IGUNZ8
 kceVdZtTEp7M99qF2NZd8I/hXEkffkGJLO/Iw5mU81nIZE8wHODh8oes7tozKBy9qq/O
 syqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcgsDbQEVuEFwQJTuKwLfAsDl95QS3J3gmoUQR0s4rQuWcHZwtpQT1HR99Mlc9M0Hnmvx+ripePlnYXr5YCBN2wXFW6j4=
X-Gm-Message-State: AOJu0YwDVE828NCTGR7ie1X1LZBG8cr6wBKn+nPzpUeCHMBDB7EaGiX4
 nB7MWYja4LMk8OEpcKF5xQa5mJ4yw3GL4mXsdXH2U/nwVCF74cPaIF6YOCAK2fw=
X-Google-Smtp-Source: AGHT+IHH144+vJlHHAQf2EO01OuOl4bOBwOiUZgSs+HiBX2LfFvX2JmfJducULg+P//nvkVQblln/A==
X-Received: by 2002:a2e:3c18:0:b0:2e2:9416:a64a with SMTP id
 38308e7fff4ca-2e51ff52536mr10371921fa.20.1715329994353; 
 Fri, 10 May 2024 01:33:14 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b8a77f8sm3866555f8f.54.2024.05.10.01.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 01:33:13 -0700 (PDT)
Date: Fri, 10 May 2024 10:33:12 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, alistair.francis@wdc.com
Subject: Re: [PATCH 1/3] target/riscv: Save counter values during
 countinhibit update
Message-ID: <20240510-226f2f36707b191d29fc3adb@orel>
References: <20240429-countinhibit_fix-v1-0-802ec1e99133@rivosinc.com>
 <20240429-countinhibit_fix-v1-1-802ec1e99133@rivosinc.com>
 <d672ec9d-eaa0-48c1-9f99-d94cf06e7aac@ventanamicro.com>
 <20240502-8a8ecc74a81a9fa33bf8c9b1@orel>
 <CAHBxVyH4ooHy=GGkqPmYO4NaL7-Rt-Ds=-m=jmWw5kzq6_u=Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHBxVyH4ooHy=GGkqPmYO4NaL7-Rt-Ds=-m=jmWw5kzq6_u=Rg@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=ajones@ventanamicro.com; helo=mail-lj1-x22f.google.com
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

On Thu, May 09, 2024 at 01:26:56PM GMT, Atish Kumar Patra wrote:
> On Thu, May 2, 2024 at 5:39 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Tue, Apr 30, 2024 at 03:00:45PM GMT, Daniel Henrique Barboza wrote:
> > >
> > >
> > > On 4/29/24 16:28, Atish Patra wrote:
> > > > Currently, if a counter monitoring cycle/instret is stopped via
> > > > mcountinhibit we just update the state while the value is saved
> > > > during the next read. This is not accurate as the read may happen
> > > > many cycles after the counter is stopped. Ideally, the read should
> > > > return the value saved when the counter is stopped.
> > > >
> > > > Thus, save the value of the counter during the inhibit update
> > > > operation and return that value during the read if corresponding bit
> > > > in mcountihibit is set.
> > > >
> > > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > > ---
> > > >   target/riscv/cpu.h     |  1 -
> > > >   target/riscv/csr.c     | 32 ++++++++++++++++++++------------
> > > >   target/riscv/machine.c |  1 -
> > > >   3 files changed, 20 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > > > index 3b1a02b9449a..09bbf7ce9880 100644
> > > > --- a/target/riscv/cpu.h
> > > > +++ b/target/riscv/cpu.h
> > > > @@ -153,7 +153,6 @@ typedef struct PMUCTRState {
> > > >       target_ulong mhpmcounter_prev;
> > > >       /* Snapshort value of a counter in RV32 */
> > > >       target_ulong mhpmcounterh_prev;
> > > > -    bool started;
> > > >       /* Value beyond UINT32_MAX/UINT64_MAX before overflow interrupt trigger */
> > > >       target_ulong irq_overflow_left;
> > > >   } PMUCTRState;
> > > > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > > > index 726096444fae..68ca31aff47d 100644
> > > > --- a/target/riscv/csr.c
> > > > +++ b/target/riscv/csr.c
> > > > @@ -929,17 +929,11 @@ static RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
> > > >       if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
> > > >           /*
> > > > -         * Counter should not increment if inhibit bit is set. We can't really
> > > > -         * stop the icount counting. Just return the counter value written by
> > > > -         * the supervisor to indicate that counter was not incremented.
> > > > +         * Counter should not increment if inhibit bit is set. Just return the
> > > > +         * current counter value.
> > > >            */
> > > > -        if (!counter->started) {
> > > > -            *val = ctr_val;
> > > > -            return RISCV_EXCP_NONE;
> > > > -        } else {
> > > > -            /* Mark that the counter has been stopped */
> > > > -            counter->started = false;
> > > > -        }
> > > > +         *val = ctr_val;
> > > > +         return RISCV_EXCP_NONE;
> > > >       }
> > > >       /*
> > > > @@ -1973,9 +1967,23 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
> > > >       /* Check if any other counter is also monitoring cycles/instructions */
> > > >       for (cidx = 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
> > > > -        if (!get_field(env->mcountinhibit, BIT(cidx))) {
> > > >               counter = &env->pmu_ctrs[cidx];
> > > > -            counter->started = true;
> > > > +        if (get_field(env->mcountinhibit, BIT(cidx)) && (val & BIT(cidx))) {
> > > > +       /*
> > > > +             * Update the counter value for cycle/instret as we can't stop the
> > > > +             * host ticks. But we should show the current value at this moment.
> > > > +             */
> > > > +            if (riscv_pmu_ctr_monitor_cycles(env, cidx) ||
> > > > +                riscv_pmu_ctr_monitor_instructions(env, cidx)) {
> > > > +                counter->mhpmcounter_val = get_ticks(false) -
> > > > +                                           counter->mhpmcounter_prev +
> > > > +                                           counter->mhpmcounter_val;
> > > > +                if (riscv_cpu_mxl(env) == MXL_RV32) {
> > > > +                    counter->mhpmcounterh_val = get_ticks(false) -
> > > > +                                                counter->mhpmcounterh_prev +
> > > > +                                                counter->mhpmcounterh_val;
> > > > +           }
> > > > +            }
> > > >           }
> > > >       }
> > > > diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> > > > index 76f2150f78b5..3e0f2dd2ce2a 100644
> > > > --- a/target/riscv/machine.c
> > > > +++ b/target/riscv/machine.c
> > > > @@ -328,7 +328,6 @@ static const VMStateDescription vmstate_pmu_ctr_state = {
> > > >           VMSTATE_UINTTL(mhpmcounterh_val, PMUCTRState),
> > > >           VMSTATE_UINTTL(mhpmcounter_prev, PMUCTRState),
> > > >           VMSTATE_UINTTL(mhpmcounterh_prev, PMUCTRState),
> > > > -        VMSTATE_BOOL(started, PMUCTRState),
> > >
> > > Unfortunately we can't remove fields from the VMStateDescription without breaking
> > > migration backward compatibility. Older QEMUs will attempt to read a field that
> > > doesn't exist and migration will fail.
> > >
> > > I'm assuming that we care about backward compat. If we're not up to this point yet
> > > then we can just bump the version_id of vmstate_pmu_ctr_state and be done with it.
> > > This is fine to do unless someone jumps in and complains that we broke a migration
> > > case for the 'virt' board. Granted, we don't have versioned boards yet so I'm unsure
> > > if someone would actually have a base to complain. Alistair, Drew, care to comment?
> >
> > Without versioning boards, then we shouldn't expect migrations to work for
> > anything other than between QEMUs of the same version. We're delaying the
> > versioning until it's reasonable to expect users to prefer to migrate
> > their guests, rather than reboot them, when updating the QEMU the guests
> > are running on. I'm not sure how we'll know when that is, but I think we
> > can wait until somebody shouts or at least until we see that the tooling
> > which makes migration easy (libvirt, etc.) is present.
> >
> > Regarding this patch, I'm curious what the current status is of migration.
> > If we can currently migrate from a QEMU with the latest released version
> > to a QEMU built from the current upstream, and then back again, then I
> 
> I haven't heard of anyone who actually uses migration in Qemu.
> There is only one way to know about it when somebody complains.
> 
> I think we should just keep it simple and bump up the version  of
> vmstate_pmu_ctr_state.
> If somebody complains about backward compatibility, we can implement
> compat code.
> Otherwise, I don't see the point.

Agreed.

Thanks,
drew

> 
> > think this patch should be written in a way to preserve that. If we
> > already fail that ping-pong migration, then, as this patch doesn't make
> > things worse, we might as well save ourselves from the burden of the
> > compat code.
> >
> > Thanks,
> > drew

