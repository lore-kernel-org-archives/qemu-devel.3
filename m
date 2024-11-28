Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2E7D6D251
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 01:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGTTd-0001iv-Lo; Wed, 27 Nov 2024 20:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tGTTV-0001dH-55; Wed, 27 Nov 2024 20:37:45 -0500
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tGTTS-00078S-S0; Wed, 27 Nov 2024 20:37:44 -0500
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-51532deb8a4so83097e0c.0; 
 Wed, 27 Nov 2024 17:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732757861; x=1733362661; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6vaRMqPS2LxmZO96IyUfKDwpd4ogUpeKQd6xajVtamE=;
 b=WvmvNwSmcRpmEdBVXmfLnhZPLlh5Ej6ABIq1VTpCam+ybGKXfJyUmSK+sEmMV62Ezx
 kPsJ1+GHXyvKhWjfOdh5xidqBGg+sHdHMxp1e6eLysSid3WYfMMyPevxS8vctee+kKmW
 S/H538mKoJK8XBIIOBEL61PuLIKZaY1BSpM5C4AGwnb7GEzpeSnfOIUvm7ymaDImzaMG
 z15pMYFbRzMesvuMuds9H4Nz8nrCSUjL43Z5b8XImt+gjkYYM4xbvH/Fmrg/tcgpadTI
 w5Yf0lMav04iIqEYuNG5rUr47EWf/SXLhOo2dXlpyDE7O6TBiUsumi+QinHXAvtwcvVY
 lxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732757861; x=1733362661;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6vaRMqPS2LxmZO96IyUfKDwpd4ogUpeKQd6xajVtamE=;
 b=IMoXSfpnH1NSUSoezb6usgZnG/WTfDrLqealHeDjbb0I9OIkIDYsILmZe7B+FinRf4
 5g9t1r5+mcacPPsMtp0/PnqucjpYtIMALr/Bl6rNCcT+vq6O1rJFyEaTr+yv4tsNSpgY
 IGPD/dBqikSdaMgqzyXf0YIkiKAXGMpIhl/mFJgvpsFWzghRiG8+Soo/1HboHZyFYlxy
 /HKHQhXgFzgPIefanpnBcHc/FQ9Y70MUTwugOoZLHy1LlFF/z6Y9hc7yabk2cTfd7YaF
 Lx3bohCBSscsSMw9UYlAgVNC8GfsIBCUMi+1R74ac2TqZnnpKsKBYL4UO+01udAmjxI+
 /+cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOoLnCnW3slcdWL5VbL2s9WwZYNRF596SPeuWNCzz02HmqYOXVRjUpa1KJ55JRz5OohuWTi/TVF8HY@nongnu.org
X-Gm-Message-State: AOJu0YyjDs95xnLOfucGXdM1htjy8RZW++5vRiWUuA3APwQ6xUWyJuOU
 i0dQN4CZI7CsErK920Ss3UWb1aUx8MoMNwBFvTZWO0Ixsox8m9aFh3K9KrbYablr50wAojuwYsx
 kdfA7O77Rb1vscyGlSwrpmOPexVI=
X-Gm-Gg: ASbGncteLqYfahs47Kb1DI3ltnqM4hSvP0YFOhJeUBx8jacEPoSnlOP+MoW/AXafKC7
 9Dl5RIq75BBgsy/COieqi2q9/Bf6UyzCko8PRKH0GdQdYFmsnq4J8LV9Tr9OxBQ==
X-Google-Smtp-Source: AGHT+IEYuE46ZvFkKwGO/MVe+NiPa8802CEXduLa21FgST0gwXiO2KVVqPwonqX+jv8/QnA8O9EYcklvLUlSKFy7Zr4=
X-Received: by 2002:a05:6102:dd0:b0:4af:3bbd:b047 with SMTP id
 ada2fe7eead31-4af44a4713amr7922684137.17.1732757860876; Wed, 27 Nov 2024
 17:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20241114091332.108811-1-cleger@rivosinc.com>
 <20241114091332.108811-2-cleger@rivosinc.com>
 <CAKmqyKO+v0AyvTER4a3JMzEN=b+NSa=BYdULt6=cGmmj46b_Jw@mail.gmail.com>
 <7c88eba0-c010-4aef-ad57-ede292129aff@rivosinc.com>
 <CAKmqyKMH_YAgomy325ZmpGCNkDMrb5pwJU9GBgNicFAsAc0J6A@mail.gmail.com>
 <1868e353-6c40-4cfb-a00f-4afdde68baea@rivosinc.com>
In-Reply-To: <1868e353-6c40-4cfb-a00f-4afdde68baea@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 28 Nov 2024 11:37:14 +1000
Message-ID: <CAKmqyKPomWUDWAtXSPtFMszRwYggG-sR+_erw4aOyxHRmHMW0A@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] target/riscv: fix henvcfg potentially containing
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

On Thu, Nov 21, 2024 at 6:28=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
>
>
> On 20/11/2024 06:02, Alistair Francis wrote:
> > On Tue, Nov 19, 2024 at 9:27=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger=
@rivosinc.com> wrote:
> >>
> >>
> >>
> >> On 19/11/2024 05:16, Alistair Francis wrote:
> >>> On Thu, Nov 14, 2024 at 7:14=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleg=
er@rivosinc.com> wrote:
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
> >>>>  target/riscv/csr.c | 40 +++++++++++++++++++++++++++++++++++-----
> >>>>  1 file changed, 35 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> >>>> index b84b436151..73ac4d5449 100644
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
> >>>> +    uint64_t henvcfg_mask =3D mask, menvcfg_mask;
> >>>>      RISCVException ret;
> >>>>
> >>>>      ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
> >>>> @@ -2443,10 +2450,24 @@ static RISCVException write_henvcfg(CPURISCV=
State *env, int csrno,
> >>>>      }
> >>>>
> >>>>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV64) {
> >>>> -        mask |=3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HE=
NVCFG_ADUE);
> >>>> +        /*
> >>>> +         * Since henvcfg depends on a menvcfg subset, we want to cl=
ear all the
> >>>> +         * menvcfg supported feature (whatever their state is) befo=
re enabling
> >>>> +         * some new one using the provided value. Not doing so woul=
d result in
> >>>> +         * keeping stale menvcfg bits in henvcfg value if a bit was=
 enabled in
> >>>> +         * menvcfg and then disabled before updating henvcfg for in=
stance.
> >>>> +         */
> >>>> +        menvcfg_mask =3D HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADU=
E;
> >>>> +        mask |=3D env->menvcfg & menvcfg_mask;
> >>>> +        henvcfg_mask |=3D menvcfg_mask;
> >>>>      }
> >>>>
> >>>> -    env->henvcfg =3D (env->henvcfg & ~mask) | (val & mask);
> >>>> +    /*
> >>>> +     * 'henvcfg_mask' contains all supported bits (both in henvcfg =
and menvcfg
> >>>> +     * common bits) and 'mask' contains henvcfg exclusive bits as w=
ell as
> >>>> +     * menvcfg enabled bits only.
> >>>> +     */
> >>>> +    env->henvcfg =3D (env->henvcfg & ~henvcfg_mask) | (val & mask);
> >>>
> >>> Won't `env->henvcfg & ~henvcfg_mask` still contain the stale data?
> >>> `henvcfg_mask` isn't based on the current value of `env->menvcfg`
> >>
> >> Hey Alistair,
> >>
> >> That's the point, env->henvcfg is cleared with henvcfg_mask which
> >> contains the set of HENVCFG_* and MENVCFG_* "raw" bits so that the new
> >> value that is written does not contain any menvcfg stale bits. "mask"
> >> however is actually masked with menvcfg value to ensure the new bits
> >> that are going to be written won't contain any incoherent bits.
> >
> > I'm not sure I follow...
> >
> > The commit message says:
> >
> > """
> > - set bit x in menvcfg
> > - set bit x in henvcfg
> > - clear bit x in menvcfg
> > """
> >
> > Which to me means henvcfg should be cleared when a bit in menvcfg is
> > cleared. But env->henvcfg is instead cleared based on `henvcfg_mask`
> > which isn't affected by menvcfg.
>
> Hey Alistair,
>
> Let's take some real example (MENVCFG_PBMTE for instance.) Let's assume
> menvcfg/henvcfg are 0 and the following sequence:
>
> - Set MENVCFG_PBMTE in menvcfg (menvcfg =3D MENVCFG_PBMTE)
> - Set HENVCFG_PBMTE in henvcfg (henvcfg =3D HENVCFG_PBMTE)
> - Clear MENVCFG_PBMTE in menvcfg (menvcfg =3D 0)
>
> On such sequence, we should clear HENVCFG_PBMTE in henvcfg. When using
> the existing code, henvcfg_write() does so:
>
> mask =3D HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
> mask |=3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
>
> So our mask =3D (HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE |
> HENVCFG_CBZE) and does not contains HENVCFG_PBMTE.
>
> Finally:
>
> env->henvcfg =3D (env->henvcfg & ~mask) | (val & mask);
>
> Then env->henvcfg & ~(HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE |
> HENVCFG_CBZE | HENVCFG_STCE | HENVCFG_ADUE) will yield henvcfg =3D
> HENVCFG_PBMTE (which is obviously not what we want) | val & mask.
>
> >
> > So clearing a bit in menvcfg will only not allow a bit to be set, but
> > not clear any existing bits
>
> Let's take again the current patch and what it does with the same sequenc=
e:
>
> - Set MENVCFG_PBMTE in menvcfg (menvcfg =3D MENVCFG_PBMTE)
> - Set HENVCFG_PBMTE in henvcfg (henvcfg =3D HENVCFG_PBMTE)
> - Clear MENVCFG_PBMTE in menvcfg (menvcfg =3D 0)
>
> henvcfg_mask =3D HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CB=
ZE;
> mask =3D HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
>
> henvcfg_mask |=3D (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
> /* Only keep the enabled bits from menvcfg */
> mask |=3D env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
>
> So mask =3D (HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE)
> which rightfully does not contain HENVCFG_PBMTE so the value to be
> written will be  correctly cleared from that bit.
>
> Finally, when it comes to write the final value we'll have the following:
>
> env->henvcfg =3D (env->henvcfg & ~henvcfg_mask) | (val & mask);
>
> Which yield
>
> henvcfg & ~(HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE |
> HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE) | val & (HENVCFG_FIOM |
> HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE | HENVCFG_STCE | HENVCFG_ADUE=
)
>
> So henvcfg HENVCFG_PBMTE bit is correctly cleared and not allowed to be
> set by the written value. But I might be missing something.

Ah ok!

That makes sense, sorry I took so long to wrap my head around this one.

Although now that we are basically clearing henvcfg on each write, do
we ever need the ` (env->henvcfg & ~henvcfg_mask) | ` can't we just
overwrite it each time?

Also, this will need a rebase on:
https://github.com/alistair23/qemu/tree/riscv-to-apply.next as there
are now more operations in write_henvcfg()

Alistair

>
> Thanks,
>
> Cl=C3=A9ment
>
> >
> > Alistair
> >
> >>
> >> I guess this still needs a few more explanations if that is not clear
> >> enough, sorry for that.
> >>
> >> Thanks,
> >>
> >> Cl=C3=A9ment
> >>>
> >>> Alistair
>

