Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB027D2E00A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 02:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3RTD-0000NF-46; Tue, 22 Oct 2024 22:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t3RTB-0000MU-BO; Tue, 22 Oct 2024 22:51:33 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t3RT9-00049z-99; Tue, 22 Oct 2024 22:51:32 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4a4864b8f98so1683447137.2; 
 Tue, 22 Oct 2024 19:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729651890; x=1730256690; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lf2R6m25ObmnmMMUCnMEjLhkcP/BuUdREgB1UdR7UV8=;
 b=cBq4ocXm4fkDrRQ4QQd1f4TVtouIp+5Qw2iZ2WBY5464wr5l/4dQjzA/hdcp0231Xt
 0PQjaVJrez4mz8Zy1U7VizLRgNQhPdR7NJ1pU7qlqIhFS267KeDSwn11sT3vzn//ABwL
 kSS5rFRJoIUsiB+C5iUE8eZBiQRXA3x1Yi0d+McvY0cVp0XifuUawinoCZg6qbhHRjto
 XIJtA1iBnCUZB/10eIa3NKsA7UF3OQtf32opzF0x1ZTFDVycORhZ6ALkAWefZtbMYkCi
 wJXoN7T+CQ7hJx0UkAQ15oiFIADcQT0RxFogIpJcKlytXioldKwPFzyEgS9RfdZPSGsM
 DLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729651890; x=1730256690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lf2R6m25ObmnmMMUCnMEjLhkcP/BuUdREgB1UdR7UV8=;
 b=UwVp9vMYO2yJQ3a9pRcvV3WInfC2CuutuH5kR+Ez0CisWPyo+ixcgQk0jUk9Ia7Et7
 sbk9eBW4+bQ/hy9+rX6QAWdpr08LtATs5KH+XCMRqnJJFDbEv77T3KTewAVYEX294VSI
 Fraw7oIgtay2sJ2G+G40BYYM1Rwx3cx6n7kdsYG2dJCNSbG0kKOOCtDe4mIfCmLS65nz
 dO3ZnRcMWQuyF2tarI5cxOjeZgeopc8oyqv3KyNgIZChqr3LDrFw5HGdQoQNk5Vz19gM
 qhMs5ihvD837cqIyamQPCuwLWKosnFKGABDkNnVhKTh6m7cYKIHKR1z2w4/9i3/qVFXK
 PXrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoFhyp62JVOfcb/U3HTGXLybajMhI0wLGKykV5QBb5TiwobGhRvTuZi73XrWyaOeo5p0hl0L6Jkx1N@nongnu.org
X-Gm-Message-State: AOJu0YxQ51o/cCd1+C70aphMpCc/F/dgzmkSK2x9kimJGZeF0jANKIt+
 d3QlzsFdzAIhY8cN3mFQSkZrjkGBl6sq0K/PqCjfqKBM3tqNtq4ai9U1dbaRLEUqbucczI64s3p
 9x3DeAUQFTvV3WHf0t0wvTWwVjic=
X-Google-Smtp-Source: AGHT+IF6TfGepWovNZHJanft7vVzfHJOmY8dD7KS7F0A+sDKFjqEEI8SE3I5E6K/v8c2qGQlzHoTHHj7fn+6gRCYSxI=
X-Received: by 2002:a05:6102:370a:b0:4a3:d8ab:8938 with SMTP id
 ada2fe7eead31-4a751bfecbcmr1526676137.12.1729651889623; Tue, 22 Oct 2024
 19:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241017145226.365825-1-cleger@rivosinc.com>
 <20241017145226.365825-2-cleger@rivosinc.com>
 <CAKmqyKMoDSFaJz7LhX4GMV9AhOQUDLOt79Fctw_k97SazpSjjQ@mail.gmail.com>
 <f99c19eb-2986-49a7-a334-b086e19ad4c4@rivosinc.com>
In-Reply-To: <f99c19eb-2986-49a7-a334-b086e19ad4c4@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 23 Oct 2024 12:51:03 +1000
Message-ID: <CAKmqyKM2dsjF4YaVbvemqA73=xmgVFsUd64v7k0qjBzT_n=JDw@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] target/riscv: fix henvcfg potentially containing
 stale bits
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
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

On Mon, Oct 21, 2024 at 7:30=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
>
>
> On 21/10/2024 02:46, Alistair Francis wrote:
> > On Fri, Oct 18, 2024 at 12:55=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <clege=
r@rivosinc.com> wrote:
> >>
> >> With the current implementation, if we had the current scenario:
> >> - set bit x in menvcfg
> >> - set bit x in henvcfg
> >> - clear bit x in menvcfg
> >> then, the internal variable env->henvcfg would still contain bit x due
> >> to both a wrong menvcfg mask used in write_henvcfg() as well as a
> >> missing update of henvcfg upon menvcfg update.
> >> This can lead to some wrong interpretation of the context. In order to
> >> update henvcfg upon menvcfg writing, call write_henvcfg() after writin=
g
> >> menvcfg and fix the mask computation used in write_henvcfg() that is
> >> used to mesk env->menvcfg value (which could still lead to some stale
> >> bits). The same mechanism is also applied for henvcfgh writing.
> >>
> >> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> >> ---
> >>  target/riscv/csr.c | 17 +++++++++++++----
> >>  1 file changed, 13 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> >> index b84b436151..9e832e0b39 100644
> >> --- a/target/riscv/csr.c
> >> +++ b/target/riscv/csr.c
> >> @@ -2345,6 +2345,8 @@ static RISCVException read_menvcfg(CPURISCVState=
 *env, int csrno,
> >>      return RISCV_EXCP_NONE;
> >>  }
> >>
> >> +static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
> >> +                                    target_ulong val);
> >>  static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
> >>                                      target_ulong val)
> >>  {
> >> @@ -2357,6 +2359,7 @@ static RISCVException write_menvcfg(CPURISCVStat=
e *env, int csrno,
> >>                  (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> >>      }
> >>      env->menvcfg =3D (env->menvcfg & ~mask) | (val & mask);
> >> +    write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
> >>
> >>      return RISCV_EXCP_NONE;
> >>  }
> >> @@ -2368,6 +2371,8 @@ static RISCVException read_menvcfgh(CPURISCVStat=
e *env, int csrno,
> >>      return RISCV_EXCP_NONE;
> >>  }
> >>
> >> +static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
> >> +                                    target_ulong val);
> >>  static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
> >>                                       target_ulong val)
> >>  {
> >> @@ -2378,6 +2383,7 @@ static RISCVException write_menvcfgh(CPURISCVSta=
te *env, int csrno,
> >>      uint64_t valh =3D (uint64_t)val << 32;
> >>
> >>      env->menvcfg =3D (env->menvcfg & ~mask) | (valh & mask);
> >> +    write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
> >>
> >>      return RISCV_EXCP_NONE;
> >>  }
> >> @@ -2435,6 +2441,7 @@ static RISCVException write_henvcfg(CPURISCVStat=
e *env, int csrno,
> >>                                      target_ulong val)
> >>  {
> >>      uint64_t mask =3D HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | H=
ENVCFG_CBZE;
> >> +    uint64_t menvcfg_mask =3D 0;
> >>      RISCVException ret;
> >>
> >>      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
> >> @@ -2443,10 +2450,11 @@ static RISCVException write_henvcfg(CPURISCVSt=
ate *env, int csrno,
> >>      }
> >>
> >>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> >> -        mask |=3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENV=
CFG_ADUE);
> >> +        menvcfg_mask =3D HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE;
> >> +        mask |=3D env->menvcfg & menvcfg_mask;
> >
> > This doesn't seem right.
> >
> > Should it be something like
>
> That is what I did before but that didn't work, henvcfg still contained
> some stale bits.
>
> >
> >     if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> >         mask |=3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCF=
G_ADUE);
> >     }
> >
> >     mask =3D env->menvcfg & mask;
> >
> >>      }
> >>
> >> -    env->henvcfg =3D (env->henvcfg & ~mask) | (val & mask);
> >> +    env->henvcfg =3D (env->henvcfg & ~menvcfg_mask) | (val & mask);
> >
> > Using both menvcfg_mask and mask seems wrong here
>
> The problem is that if you use:
>
> mask |=3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE)
>
> Then, if a bit was cleared in menvcfg before writing henvcfg (let's say
> HENVCFG_ADUE), then env->henvcfg will be masked with mask =3D
> HENVCFG_PBMTE | HENVCFG_STCE, leaving the HENVCFG_ADUE stale bit in
> env->henvcfg which is wrong for the internal state.
>
> The idea here is to actually clear any menvcfg related bit (the 1:1
> bits) using the raw mask (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE)
> to clear everything and then OR it with the value to be written (which
> is masked with raw bits + menvcfg content) to avoid any stale bits.

When calling write_henvcfg() can't you just do:

write_henvcfg(env, CSR_HENVCFG, env->henvcfg & env->menvcfg)

I feel like that's clearer then the current approach

Alistair

>
> Thanks,
>
> Cl=C3=A9ment
>
> >
> > Alistair
>

