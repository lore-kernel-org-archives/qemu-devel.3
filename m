Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02249C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 00:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW3dY-0005R6-Ep; Mon, 22 Jul 2024 20:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sW3dX-0005Qc-Hx
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 20:44:15 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sW3dV-0004Z4-UB
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 20:44:15 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-492a8333cb1so433130137.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 17:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721695452; x=1722300252; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4lZqODAkQ7oyXneTw8U/i+7Pb15caczZGI3elJ3vbG4=;
 b=IXQTiSevxDC8q9JnuoDSdpfIrN7jMA0OdlTs95AgGM9KfDQmBaTnt1c7u7ayeznSLK
 q1EiTLVNJIJlng0eIg+c0AryidLENHFul1qsIV+vlwaauLGdJ3oFHQrHlBkxDZPYsSFF
 M9cq2dFDBs0wnhUXQBojXFMtKxOMA9jkC5y4XdBS8nkcGHeXuEEISMfvU232FZhSGXu3
 pxyQqq6x/zev6s0VKoy6lnUBxt/ds0WzGgVZUWQntoj3TqcgIWSiVCHDFnuyaXFewP4F
 lU81WFPxD5N6ZFwQK/3++Z0pRDYyHQvHAGE43qKbY8ZWfr2CRSxzmL7g/UoAtOebaPWW
 pmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721695452; x=1722300252;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4lZqODAkQ7oyXneTw8U/i+7Pb15caczZGI3elJ3vbG4=;
 b=tt996Dnla4Z8iUOZAKQBXwLUEUDtUwKfajVMDiwVrIBKiEIx1W4U3udkILhWHn/pUy
 LLiGmQW0iPot40NRsfmJ0netcyx2cAhpkPCHiZeuMFHpnCUnqr/mL+4RLzlggyoXcfjk
 3mcf0LR7IBQWlycIml292DsO2J4vFsRlM8gwmsKsv3L36PhVW4JsBxY5og5xriqrCW8X
 JbczgwwQoLAW7hTZuJQtzenoiyJSDlrduLD1ZX7KvQtXrCHGX4/Qb+jT5GlsstXWcj+D
 1NuxlHnD7xsIeOQcu20D4QA6qIkdoRYI9Jdt5esFeSwNqakdX9BcYyxIU5mzylg7kM3R
 q+AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4u6EKHxmbM64Uv6rEOmOXJJ+s8NjBWzw5O6pFuVw31QNUXgPjVsrGSh8LPHEatGzyC/mQsVtYGA9MRyi02bgdSLSDcfY=
X-Gm-Message-State: AOJu0Yx4yZaLwAF9nt5g8Orv4EbQVFkhoWRbnSpfmrUGowHEecmajoJl
 6pr3oNHoH19Xk+rnm1vH31TKyCZJqMvUUsIbX8qKI/FFIwsLluncVi5VMntPJDd70PeiiFw+nyO
 22oQ0AMuNWayspxkMSsJQTtT5Aow=
X-Google-Smtp-Source: AGHT+IGPHLUgjQaKTthCNvgHtP8oPDASMWGXEUN1H/WFyGLebJOW9jKXEAaQRatGW4No4n7p5JX8hadIf7b+9NqcBdo=
X-Received: by 2002:a05:6102:5616:b0:48f:9897:8385 with SMTP id
 ada2fe7eead31-4928b95bcc7mr6980675137.9.1721695452488; Mon, 22 Jul 2024
 17:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
 <20240718021012.2057986-27-alistair.francis@wdc.com>
 <CAFEAcA-Lrnt30uvR5k+GVsM-goKuD7ZQzzxOpxocBf3C6BzvMg@mail.gmail.com>
 <CAHBxVyHZ1_zgg-V2aKMcYsZjWHwcfndt-rbTa0h8mp_Ufe7hjw@mail.gmail.com>
In-Reply-To: <CAHBxVyHZ1_zgg-V2aKMcYsZjWHwcfndt-rbTa0h8mp_Ufe7hjw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 23 Jul 2024 10:43:46 +1000
Message-ID: <CAKmqyKM_gcuNvR=2Rff29C5EAFTNiyz3XNTH5H4wt9W5JbmO+w@mail.gmail.com>
Subject: Re: [PULL 26/30] target/riscv: Do not setup pmu timer if OF is
 disabled
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Jul 23, 2024 at 9:33=E2=80=AFAM Atish Kumar Patra <atishp@rivosinc.=
com> wrote:
>
> On Sat, Jul 20, 2024 at 8:19=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Thu, 18 Jul 2024 at 03:15, Alistair Francis <alistair23@gmail.com> w=
rote:
> > >
> > > From: Atish Patra <atishp@rivosinc.com>
> > >
> > > The timer is setup function is invoked in both hpmcounter
> > > write and mcountinhibit write path. If the OF bit set, the
> > > LCOFI interrupt is disabled. There is no benefitting in
> > > setting up the qemu timer until LCOFI is cleared to indicate
> > > that interrupts can be fired again.
> > > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > Message-ID: <20240711-smcntrpmf_v7-v8-12-b7c38ae7b263@rivosinc.com>
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >  target/riscv/pmu.c | 56 ++++++++++++++++++++++++++++++++++++--------=
--
> > >  1 file changed, 44 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> > > index a4729f6c53..3cc0b3648c 100644
> > > --- a/target/riscv/pmu.c
> > > +++ b/target/riscv/pmu.c
> > > @@ -416,14 +416,49 @@ int riscv_pmu_update_event_map(CPURISCVState *e=
nv, uint64_t value,
> > >      return 0;
> > >  }
> >
> > Hi; I was looking at an issue Coverity flagged up with this code (CID
> > 1558461, 1558463):
> >
> > > +static bool pmu_hpmevent_is_of_set(CPURISCVState *env, uint32_t ctr_=
idx)
> > > +{
> > > +    target_ulong mhpmevent_val;
> > > +    uint64_t of_bit_mask;
> > > +
> > > +    if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> > > +        mhpmevent_val =3D env->mhpmeventh_val[ctr_idx];
> > > +        of_bit_mask =3D MHPMEVENTH_BIT_OF;
> > > +     } else {
> > > +        mhpmevent_val =3D env->mhpmevent_val[ctr_idx];
> > > +        of_bit_mask =3D MHPMEVENT_BIT_OF;
> >
> > MHPMEVENT_BIT_OF is defined as BIT_ULL(63)...
> >
> > > +    }
> > > +
> > > +    return get_field(mhpmevent_val, of_bit_mask);
> >
> > ...but we pass it to get_field(), whose definition is:
> >
> > #define get_field(reg, mask) (((reg) & \
> >                  (uint64_t)(mask)) / ((mask) & ~((mask) << 1)))
> >
> > Notice that part of this expression is "(mask) << 1". So Coverity compl=
ains
> > that we took a constant value and shifted it right off the top.
> >
> > I think this is probably a false positive, but why is target/riscv
> > using its own ad-hoc macros for extracting bitfields? We have
> > a standard set of extract/deposit macros in bitops.h, and not
>
> Thanks for pointing those out. I checked the get_field usage from the
> beginning of riscv support 6 years back.
> There are tons of users of get_field in a bunch of riscv sources. I
> guess it was just added once and everybody kept using it
> without switching to generic functions.

I think you are right about that

>
> @Alistair Francis : Are there any other reasons ?

Not that I know of

>
> If not, I can take a stab at fixing those if nobody is looking at them al=
ready.

That would be great!

Alistair

>
> > using them makes the riscv code harder to read for people who
> > are used to the rest of the codebase (e.g. to figure out if this
> > Coverity issue is a false positive I would need to look at these
> > macros to figure out what exactly they're doing).
> >
> > thanks
> > -- PMM

