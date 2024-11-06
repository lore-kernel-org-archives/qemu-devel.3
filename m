Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F3AD40D08
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 00:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Tj9-0001vi-CE; Tue, 05 Nov 2024 19:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8Tj6-0001vH-NZ; Tue, 05 Nov 2024 19:16:48 -0500
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t8Tj3-00061P-SA; Tue, 05 Nov 2024 19:16:48 -0500
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-84fe06fbdc6so2290130241.0; 
 Tue, 05 Nov 2024 16:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730852204; x=1731457004; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mdgJ7BjPFxmiUmWSfCC2UnNNNesu9PCvFvRFlD/S6IM=;
 b=UNmR/m6NT9JTepxqKgP+vp59GCG49ySGod1Sr16FK/GrlyrpZiB02AhbFPCfjiWZ8g
 yZZSZiqMtIUgJFkVk5OE60VH1vDejrbVOeJdYzz8BqxQofcoia85cqInjKX5sJ8toDk+
 gLasrbHZmUqUZ00vdfdGZ4AQRINmOjTZLYpDxIjBvd9VApSIBgOfmZg6vEkhNvc/7YXG
 LBCqbfySBLX3koivzfBJaH58GIzospt+UvFoO2bGTE5OYDtnHYU6U1V3KdJBf+pW8n9a
 1eUIGI8EIbYBv4lQ0MMIRlBnPYXJ9ifxDNk4nTkix+NIxb7bGn0XK9+PBOVKOb+asAc8
 m0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730852204; x=1731457004;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mdgJ7BjPFxmiUmWSfCC2UnNNNesu9PCvFvRFlD/S6IM=;
 b=Zg87/oWgZN/FWCAQw0pLsydP9S5KyK9exrUcy97Cvh9/HChCnViC5j64dAPTsF2rpB
 v5RzC+2TAT4FINzSohwGYyIhRZNzf8N4IKTBd0IPEy3XqYzPzrEx3AbLEMDiAZhxF8lq
 6BWmbiCjRmuhFHSguRm85+z/6/RGJwVG8ZwbEputjvKKbsTyzg8SLEeGWN6kaM9XfylB
 jOa8zgIIXknwFOe/NvLwAkyR25+E4sZjn6cetJYHV+zufTFbF1jPx31BBzYUBzdaQ0/F
 evbXv4PKGbXqYy67+5gpPMYkhyiiZEG7+6iEql03zEQb9GpIsv48FJ/6NHYS70+rA6rB
 sJ4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhezgrX8LrugMvTyB0MzxBRiuQat+TdGL/3nKJ3b4fD5DtUo6SMEOjdSU2gWmbzT9M394+18UEHuAg@nongnu.org
X-Gm-Message-State: AOJu0YzFo6T8QsdVTe8SYir94uaKk68562/+1bt5qCggstmuoWm7yGjs
 ducien6KmYSfLZ6Y8gJCWaXFOFrrSuZwwOhGJq3IhoiJVyZAEJ4gGvd2SrBaY29+8qpMdVw1MQ0
 Uk3lNNbHpeZtvIJuU8egW/O7RuHo=
X-Google-Smtp-Source: AGHT+IHhVQp8ovUMhgDb3E9LO5t/8ijCGR3q470VxP7z+kNEgRC3itgsW+QaeQfqcpc5NoRtXcRkoCYNy1Bzn6kntzc=
X-Received: by 2002:a05:6102:3f04:b0:4a5:afbc:48a9 with SMTP id
 ada2fe7eead31-4a9542c1887mr21450278137.8.1730852204208; Tue, 05 Nov 2024
 16:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20241017145226.365825-1-cleger@rivosinc.com>
 <20241017145226.365825-2-cleger@rivosinc.com>
 <CAKmqyKMoDSFaJz7LhX4GMV9AhOQUDLOt79Fctw_k97SazpSjjQ@mail.gmail.com>
 <f99c19eb-2986-49a7-a334-b086e19ad4c4@rivosinc.com>
 <CAKmqyKM2dsjF4YaVbvemqA73=xmgVFsUd64v7k0qjBzT_n=JDw@mail.gmail.com>
 <99d02504-92c4-4e8c-8f28-113dcdfb951b@rivosinc.com>
In-Reply-To: <99d02504-92c4-4e8c-8f28-113dcdfb951b@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Nov 2024 10:16:18 +1000
Message-ID: <CAKmqyKNX4RdndcSCRHbSWZbpZ0wx85iUMECvbmu7VCTBYw7TSA@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
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

On Wed, Oct 30, 2024 at 6:57=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
>
>
> On 23/10/2024 04:51, Alistair Francis wrote:
> > On Mon, Oct 21, 2024 at 7:30=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger=
@rivosinc.com> wrote:
> >>
> >>
> >>
> >> On 21/10/2024 02:46, Alistair Francis wrote:
> >>> On Fri, Oct 18, 2024 at 12:55=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cle=
ger@rivosinc.com> wrote:
> >>>>
> >>>> With the current implementation, if we had the current scenario:
> >>>> - set bit x in menvcfg
> >>>> - set bit x in henvcfg
> >>>> - clear bit x in menvcfg
> >>>> then, the internal variable env->henvcfg would still contain bit x d=
ue
> >>>> to both a wrong menvcfg mask used in write_henvcfg() as well as a
> >>>> missing update of henvcfg upon menvcfg update.
> >>>> This can lead to some wrong interpretation of the context. In order =
to
> >>>> update henvcfg upon menvcfg writing, call write_henvcfg() after writ=
ing
> >>>> menvcfg and fix the mask computation used in write_henvcfg() that is
> >>>> used to mesk env->menvcfg value (which could still lead to some stal=
e
> >>>> bits). The same mechanism is also applied for henvcfgh writing.
> >>>>
> >>>> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> >>>> ---
> >>>>  target/riscv/csr.c | 17 +++++++++++++----
> >>>>  1 file changed, 13 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> >>>> index b84b436151..9e832e0b39 100644
> >>>> --- a/target/riscv/csr.c
> >>>> +++ b/target/riscv/csr.c
> >>>> @@ -2345,6 +2345,8 @@ static RISCVException read_menvcfg(CPURISCVSta=
te *env, int csrno,
> >>>>      return RISCV_EXCP_NONE;
> >>>>  }
> >>>>
> >>>> +static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
> >>>> +                                    target_ulong val);
> >>>>  static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
> >>>>                                      target_ulong val)
> >>>>  {
> >>>> @@ -2357,6 +2359,7 @@ static RISCVException write_menvcfg(CPURISCVSt=
ate *env, int csrno,
> >>>>                  (cfg->ext_svadu ? MENVCFG_ADUE : 0);
> >>>>      }
> >>>>      env->menvcfg =3D (env->menvcfg & ~mask) | (val & mask);
> >>>> +    write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
> >>>>
> >>>>      return RISCV_EXCP_NONE;
> >>>>  }
> >>>> @@ -2368,6 +2371,8 @@ static RISCVException read_menvcfgh(CPURISCVSt=
ate *env, int csrno,
> >>>>      return RISCV_EXCP_NONE;
> >>>>  }
> >>>>
> >>>> +static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
> >>>> +                                    target_ulong val);
> >>>>  static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
> >>>>                                       target_ulong val)
> >>>>  {
> >>>> @@ -2378,6 +2383,7 @@ static RISCVException write_menvcfgh(CPURISCVS=
tate *env, int csrno,
> >>>>      uint64_t valh =3D (uint64_t)val << 32;
> >>>>
> >>>>      env->menvcfg =3D (env->menvcfg & ~mask) | (valh & mask);
> >>>> +    write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
> >>>>
> >>>>      return RISCV_EXCP_NONE;
> >>>>  }
> >>>> @@ -2435,6 +2441,7 @@ static RISCVException write_henvcfg(CPURISCVSt=
ate *env, int csrno,
> >>>>                                      target_ulong val)
> >>>>  {
> >>>>      uint64_t mask =3D HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE |=
 HENVCFG_CBZE;
> >>>> +    uint64_t menvcfg_mask =3D 0;
> >>>>      RISCVException ret;
> >>>>
> >>>>      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
> >>>> @@ -2443,10 +2450,11 @@ static RISCVException write_henvcfg(CPURISCV=
State *env, int csrno,
> >>>>      }
> >>>>
> >>>>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> >>>> -        mask |=3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HE=
NVCFG_ADUE);
> >>>> +        menvcfg_mask =3D HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADU=
E;
> >>>> +        mask |=3D env->menvcfg & menvcfg_mask;
> >>>
> >>> This doesn't seem right.
> >>>
> >>> Should it be something like
> >>
> >> That is what I did before but that didn't work, henvcfg still containe=
d
> >> some stale bits.
> >>
> >>>
> >>>     if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> >>>         mask |=3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENV=
CFG_ADUE);
> >>>     }
> >>>
> >>>     mask =3D env->menvcfg & mask;
> >>>
> >>>>      }
> >>>>
> >>>> -    env->henvcfg =3D (env->henvcfg & ~mask) | (val & mask);
> >>>> +    env->henvcfg =3D (env->henvcfg & ~menvcfg_mask) | (val & mask);
> >>>
> >>> Using both menvcfg_mask and mask seems wrong here
> >>
> >> The problem is that if you use:
> >>
> >> mask |=3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE)
> >>
> >> Then, if a bit was cleared in menvcfg before writing henvcfg (let's sa=
y
> >> HENVCFG_ADUE), then env->henvcfg will be masked with mask =3D
> >> HENVCFG_PBMTE | HENVCFG_STCE, leaving the HENVCFG_ADUE stale bit in
> >> env->henvcfg which is wrong for the internal state.
> >>
> >> The idea here is to actually clear any menvcfg related bit (the 1:1
> >> bits) using the raw mask (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE)
> >> to clear everything and then OR it with the value to be written (which
> >> is masked with raw bits + menvcfg content) to avoid any stale bits.
> >
> > When calling write_henvcfg() can't you just do:
> >
> > write_henvcfg(env, CSR_HENVCFG, env->henvcfg & env->menvcfg)
>
> Yeah it's clearer and I thought of that but you'll end up with the same
> result since the problem does not come from the value you supply but
> rather by the old masked henvcfg value used at the end of
> write_henvcg()(and the mask is computed independently of the new value),
> ie this line:
>
> env->henvcfg =3D (env->henvcfg & ~mask) | (val & mask);

Yeah ok.

Maybe a comment or two to describe what is going on would be enough
then, or even splitting the single line ops into multiple lines would
be clearer

Alistair

