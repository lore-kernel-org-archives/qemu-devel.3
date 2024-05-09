Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE892C25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 20:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5AMY-0002lD-Ba; Thu, 09 May 2024 16:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1s5AMC-0002IN-W4
 for qemu-devel@nongnu.org; Thu, 09 May 2024 16:27:15 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1s5AMA-0001PC-29
 for qemu-devel@nongnu.org; Thu, 09 May 2024 16:27:12 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-51fcb7dc722so1216522e87.1
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 13:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715286427; x=1715891227;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2nFoPXez/lVC8jSJFrENEqZGtmO/5tWYFQFWfazisc8=;
 b=PLlWnLRINMHZ0pq+G/5WTsqtdT8QWV9Q/UnrT0uRYevq8PAanR568szGozkhWxWkUw
 DahYDjCAJ/Zg7UyBjPfMO58Ri1UVzFj+cbp/e1YLUFSypTt0CyZTVmc6yLFA2vRfRYv0
 HlngNkfdRmdVBNJirewXSBZC/Zccg33b0MFKNnm5SgY9RAHqaV94JyHzWnTt9PymbqF2
 SH1hb/gxlDn3zrQPJf+B/AJqTqVSl8WrfTaWWlOHqMuBdmE6U+uaAmqZJQK3qCLndbqF
 9gtEqShKXwsTxa+RdD2RanwnGck/3HSGZsSF1fw0z5+LTgbx2V5+y/zBVYgTdLPcMeed
 poEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715286427; x=1715891227;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2nFoPXez/lVC8jSJFrENEqZGtmO/5tWYFQFWfazisc8=;
 b=U2ppXZU9s9OI8+AFjGsj1EU6sns9ye0FA5SkfQz6dxVlX6GlvLmVDOVngjx/2dcUWK
 YA3mx+O2t9W3MQ8peD/iuW/fq9KXIVZHxwNEoEV+PstwEL+7RgSeTIUUBRoSGJzRxBRn
 +UTwX58Bo7338p7IN/740hWU7cYLFjk3q0LWhl/ZNnBeA+RiXIlySWencnxIwE0iiPi/
 1yGU2Js9Gr8n0CsFeNsWvWeyafyNFTByWt7lQhNvVY8A3NsYonRVu/9l4PzT3a9H/2qn
 js1TezdMimExrzB7eq6qnOnbkVlXlY0LmdiOWC+9m9gSueQR2rWgNW5ukb9gq2KyCBdL
 gjfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXxg3VUVJtZ7i7KvG06LVs25Ll0l5EmHeIEzCSZEmNYN6fdBCEm4P0eonHvs1nYegMWGgwzQ8sSU7JWsZn6kNrYBGfeY4=
X-Gm-Message-State: AOJu0YxmgSjWSSe570jScVt7jAzRy904Pm6TZxcC0jTaTlwiSmO/Kn1p
 f2McRZF4E7L5nT7ZUNTbOjoOoSMLZDsQY+MOJ/S2QlqDVlOXDsfLIIG6FO70oKBh7O2gpRKLJOl
 g74za3p/gHtAWksRZTzKDYfuhqA7vz0hBtUUVAQ==
X-Google-Smtp-Source: AGHT+IEHcjbvGX4lbrCi5aQY8alYVTbprTL6TpIybjuXJal6giigCsGWPmYAphVrxh2O95LOyVxsa9+f97CiMplolgc=
X-Received: by 2002:a19:8c16:0:b0:51e:5867:6438 with SMTP id
 2adb3069b0e04-521e095fbebmr1065690e87.7.1715286427508; Thu, 09 May 2024
 13:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240429-countinhibit_fix-v1-0-802ec1e99133@rivosinc.com>
 <20240429-countinhibit_fix-v1-1-802ec1e99133@rivosinc.com>
 <d672ec9d-eaa0-48c1-9f99-d94cf06e7aac@ventanamicro.com>
 <20240502-8a8ecc74a81a9fa33bf8c9b1@orel>
In-Reply-To: <20240502-8a8ecc74a81a9fa33bf8c9b1@orel>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Thu, 9 May 2024 13:26:56 -0700
Message-ID: <CAHBxVyH4ooHy=GGkqPmYO4NaL7-Rt-Ds=-m=jmWw5kzq6_u=Rg@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/riscv: Save counter values during countinhibit
 update
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=atishp@rivosinc.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, May 2, 2024 at 5:39=E2=80=AFAM Andrew Jones <ajones@ventanamicro.co=
m> wrote:
>
> On Tue, Apr 30, 2024 at 03:00:45PM GMT, Daniel Henrique Barboza wrote:
> >
> >
> > On 4/29/24 16:28, Atish Patra wrote:
> > > Currently, if a counter monitoring cycle/instret is stopped via
> > > mcountinhibit we just update the state while the value is saved
> > > during the next read. This is not accurate as the read may happen
> > > many cycles after the counter is stopped. Ideally, the read should
> > > return the value saved when the counter is stopped.
> > >
> > > Thus, save the value of the counter during the inhibit update
> > > operation and return that value during the read if corresponding bit
> > > in mcountihibit is set.
> > >
> > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > ---
> > >   target/riscv/cpu.h     |  1 -
> > >   target/riscv/csr.c     | 32 ++++++++++++++++++++------------
> > >   target/riscv/machine.c |  1 -
> > >   3 files changed, 20 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > > index 3b1a02b9449a..09bbf7ce9880 100644
> > > --- a/target/riscv/cpu.h
> > > +++ b/target/riscv/cpu.h
> > > @@ -153,7 +153,6 @@ typedef struct PMUCTRState {
> > >       target_ulong mhpmcounter_prev;
> > >       /* Snapshort value of a counter in RV32 */
> > >       target_ulong mhpmcounterh_prev;
> > > -    bool started;
> > >       /* Value beyond UINT32_MAX/UINT64_MAX before overflow interrupt=
 trigger */
> > >       target_ulong irq_overflow_left;
> > >   } PMUCTRState;
> > > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > > index 726096444fae..68ca31aff47d 100644
> > > --- a/target/riscv/csr.c
> > > +++ b/target/riscv/csr.c
> > > @@ -929,17 +929,11 @@ static RISCVException riscv_pmu_read_ctr(CPURIS=
CVState *env, target_ulong *val,
> > >       if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
> > >           /*
> > > -         * Counter should not increment if inhibit bit is set. We ca=
n't really
> > > -         * stop the icount counting. Just return the counter value w=
ritten by
> > > -         * the supervisor to indicate that counter was not increment=
ed.
> > > +         * Counter should not increment if inhibit bit is set. Just =
return the
> > > +         * current counter value.
> > >            */
> > > -        if (!counter->started) {
> > > -            *val =3D ctr_val;
> > > -            return RISCV_EXCP_NONE;
> > > -        } else {
> > > -            /* Mark that the counter has been stopped */
> > > -            counter->started =3D false;
> > > -        }
> > > +         *val =3D ctr_val;
> > > +         return RISCV_EXCP_NONE;
> > >       }
> > >       /*
> > > @@ -1973,9 +1967,23 @@ static RISCVException write_mcountinhibit(CPUR=
ISCVState *env, int csrno,
> > >       /* Check if any other counter is also monitoring cycles/instruc=
tions */
> > >       for (cidx =3D 0; cidx < RV_MAX_MHPMCOUNTERS; cidx++) {
> > > -        if (!get_field(env->mcountinhibit, BIT(cidx))) {
> > >               counter =3D &env->pmu_ctrs[cidx];
> > > -            counter->started =3D true;
> > > +        if (get_field(env->mcountinhibit, BIT(cidx)) && (val & BIT(c=
idx))) {
> > > +       /*
> > > +             * Update the counter value for cycle/instret as we can'=
t stop the
> > > +             * host ticks. But we should show the current value at t=
his moment.
> > > +             */
> > > +            if (riscv_pmu_ctr_monitor_cycles(env, cidx) ||
> > > +                riscv_pmu_ctr_monitor_instructions(env, cidx)) {
> > > +                counter->mhpmcounter_val =3D get_ticks(false) -
> > > +                                           counter->mhpmcounter_prev=
 +
> > > +                                           counter->mhpmcounter_val;
> > > +                if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> > > +                    counter->mhpmcounterh_val =3D get_ticks(false) -
> > > +                                                counter->mhpmcounter=
h_prev +
> > > +                                                counter->mhpmcounter=
h_val;
> > > +           }
> > > +            }
> > >           }
> > >       }
> > > diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> > > index 76f2150f78b5..3e0f2dd2ce2a 100644
> > > --- a/target/riscv/machine.c
> > > +++ b/target/riscv/machine.c
> > > @@ -328,7 +328,6 @@ static const VMStateDescription vmstate_pmu_ctr_s=
tate =3D {
> > >           VMSTATE_UINTTL(mhpmcounterh_val, PMUCTRState),
> > >           VMSTATE_UINTTL(mhpmcounter_prev, PMUCTRState),
> > >           VMSTATE_UINTTL(mhpmcounterh_prev, PMUCTRState),
> > > -        VMSTATE_BOOL(started, PMUCTRState),
> >
> > Unfortunately we can't remove fields from the VMStateDescription withou=
t breaking
> > migration backward compatibility. Older QEMUs will attempt to read a fi=
eld that
> > doesn't exist and migration will fail.
> >
> > I'm assuming that we care about backward compat. If we're not up to thi=
s point yet
> > then we can just bump the version_id of vmstate_pmu_ctr_state and be do=
ne with it.
> > This is fine to do unless someone jumps in and complains that we broke =
a migration
> > case for the 'virt' board. Granted, we don't have versioned boards yet =
so I'm unsure
> > if someone would actually have a base to complain. Alistair, Drew, care=
 to comment?
>
> Without versioning boards, then we shouldn't expect migrations to work fo=
r
> anything other than between QEMUs of the same version. We're delaying the
> versioning until it's reasonable to expect users to prefer to migrate
> their guests, rather than reboot them, when updating the QEMU the guests
> are running on. I'm not sure how we'll know when that is, but I think we
> can wait until somebody shouts or at least until we see that the tooling
> which makes migration easy (libvirt, etc.) is present.
>
> Regarding this patch, I'm curious what the current status is of migration=
.
> If we can currently migrate from a QEMU with the latest released version
> to a QEMU built from the current upstream, and then back again, then I

I haven't heard of anyone who actually uses migration in Qemu.
There is only one way to know about it when somebody complains.

I think we should just keep it simple and bump up the version  of
vmstate_pmu_ctr_state.
If somebody complains about backward compatibility, we can implement
compat code.
Otherwise, I don't see the point.

> think this patch should be written in a way to preserve that. If we
> already fail that ping-pong migration, then, as this patch doesn't make
> things worse, we might as well save ourselves from the burden of the
> compat code.
>
> Thanks,
> drew

