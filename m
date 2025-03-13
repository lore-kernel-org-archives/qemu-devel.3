Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DBEC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 16:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsl7Q-0000WB-Ec; Thu, 13 Mar 2025 12:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tsl7M-0000M3-M0
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:09:08 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tsl7J-0000dl-Oj
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 12:09:08 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e5b56fc863so1589161a12.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741882143; x=1742486943;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PJ2aC4N6ZomaQSS+0rygutwmqjpnxjmrZbOK3m1BSSs=;
 b=JFh6Ix/SLNysw3FRrOhds13WAX3f9qT86gVvoMT0YaTNzowDf2QjBUspiXRVT81OsR
 jWyXwUw7lGXp2ALWjITixiw4hR6Gc7jKqsUrNDhWHvLufkQry/RNmzGOzVOxaCNHtMoh
 78H2LRlCS0BG9jUJKi/CuR9/m1jzvgAz+iWHlY2NcTuJ2NvoIQvD9yJqdWoaL8r+z7nN
 PWdBTyfuzfjRpEnymiF0SNBeTzQNHn+8z7IqI7LfSbDRPlNvBmqMzMIhYXUhTdO7qmYv
 lIn9t+EYsQIxMZUqkz+10uIqjGZF2tEU3UAdqGYBekXEz8xPOcTr0quY3NtQ55oOecPv
 uB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741882143; x=1742486943;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PJ2aC4N6ZomaQSS+0rygutwmqjpnxjmrZbOK3m1BSSs=;
 b=MsL7eXmS8gNXVPaPs+KXu+0esQPhFiKxI3ovgSa6EdLeXK+WOK2LQyseg/AiQ5U8zv
 KDYTXxkbYwDAgCDgC8tCAnmzsRM4mRwmT7uAFZ2rUz7aJULbO2EOZFtDSyQhNMNshOn9
 PNwmUpAMsfQK5YOwnlyx//qJHuUxq1XR92EcA9Jnk2CL2nOx9eney79mt914/SpvGUQy
 pWTwbWDY/xjVbTgQlvsV4Co3yQxoCLcAGxhfpX7HyDVEtrMcyi4W6RJbi/g7F8aYPdEw
 Mg3D33BW+SpCXqYNcWTZBPcXis3rmwJQP+H/2NzkPLFXxTKk3w1ew8CetgywdhoEbJ/m
 cH+w==
X-Gm-Message-State: AOJu0Yyb5XdGnLuoSzfvswGHdNcZBKKD7KUF26uFUDmNS2boXVh4nSL3
 4nLnYXv3IQ70pkO/6mjo7V5B0OSgFcHx4egaZmGsUm33E3I82W8nznpgxO4KqxTgOmOlZHtFCft
 TQSp0Sv5gCUL/90wZTQI0l6m/Gmr7uH+Xi7vUcA==
X-Gm-Gg: ASbGncvl7q7ot4lcQgg2HngmhqpoBfJcHf/AKTa8zM/aXTZhBb5n67gm4yTRZPDX71f
 1GO4+RyMJ6kwzvyEoY1JgjmXR4XfTuzKyNct4NcwjCgIc2VHwXlD/Wn+deew/A14DW+brauZgyZ
 rg9sdWaIVPVF8drnrl5VVU8Nnn
X-Google-Smtp-Source: AGHT+IFB7syDP2rSoE45YmbDoL4HUt0trQs4HSuP0Y6d1vVMB/LWqYS6DHaOZDDHWftXpQFRxJQRQAfvYzrmyr6kX2Q=
X-Received: by 2002:a05:6402:1e8c:b0:5e7:5b30:3c4f with SMTP id
 4fb4d7f45d1cf-5e75df5c36dmr15850593a12.14.1741882142948; Thu, 13 Mar 2025
 09:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250225160052.39564-1-loic@rivosinc.com>
 <20250225160052.39564-2-loic@rivosinc.com>
 <bb50a8a4-9d82-4f57-b1d6-b2e6b4b95212@ventanamicro.com>
In-Reply-To: <bb50a8a4-9d82-4f57-b1d6-b2e6b4b95212@ventanamicro.com>
From: =?UTF-8?B?TG/Dr2MgTGVmb3J0?= <loic@rivosinc.com>
Date: Thu, 13 Mar 2025 17:08:49 +0100
X-Gm-Features: AQ5f1JpA3Id2FpqNhmZKF2nlhevM3FikP3u4qzqyPEll3rY1G8ZdW442HEkk0wQ
Message-ID: <CAGKm2NKCEjyKJS6oCG1=diU7RjC7PnQSLLxM0Kvam_De4VvXpA@mail.gmail.com>
Subject: Re: [PATCH 1/5] target/riscv: pmp: don't allow RLB to bypass rule
 privileges
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="0000000000005f1d1706303b8a0c"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=loic@rivosinc.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000005f1d1706303b8a0c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 12:40=E2=80=AFPM Daniel Henrique Barboza <
dbarboza@ventanamicro.com> wrote:

>
>
> On 2/25/25 1:00 PM, Lo=C3=AFc Lefort wrote:
> > When Smepmp is supported, RLB allows bypassing locks when writing CSRs
> but
> > should not affect interpretation of actual PMP rules.
> >
> > pmp_is_locked is changed to only check LOCK bit and a new pmp_is_readon=
ly
> > function is added that checks both LOCK bit and mseccfg.RLB.
> pmp_write_cfg and
> > pmpaddr_csr_write are changed to use pmp_is_readonly while
> pmp_hart_has_privs
> > keeps using pmp_is_locked.
>
>
> Note that this change (removing  MSECCFG_RLB_ISSET(env) check from
> pmp_is_locked())
> can impact the behavior of at least one caller in pmp_hart_has_privs():
>
>
>              if (!MSECCFG_MML_ISSET(env)) {
>                  /*
>                   * If mseccfg.MML Bit is not set, do pmp priv check
>                   * This will always apply to regular PMP.
>                   */
>                  *allowed_privs =3D PMP_READ | PMP_WRITE | PMP_EXEC;
>                  if ((mode !=3D PRV_M) || pmp_is_locked(env, i)) {
>                      *allowed_privs &=3D env->pmp_state.pmp[i].cfg_reg;
>                  }
>              }
>
> Setting allowed_privs requires !MSECCFG_RLB_ISSET(env), and after this
> patch allowed_privs
> will be set regardless of MSECCFG_RLB_ISSET(env), at least w.r.t how
> pmp_is_locked() works.
>
> This might not be an issue and there's not behavioral change. In this cas=
e
> it would be good
> to mention in the commit msg why this is the case.
>
> We can just add a !MSECCFG_RLB_ISSET(env) at this point to preserve
> behavior too.
>
> Not checking RLB in this code path is the main point of this commit:
allowed_privs should not depend on RLB.
I'll reword the commit message in v2 to make it more explicit.


> >
> > Signed-off-by: Lo=C3=AFc Lefort <loic@rivosinc.com>
> > ---
> >   target/riscv/pmp.c | 43 ++++++++++++++++++++++++-------------------
> >   1 file changed, 24 insertions(+), 19 deletions(-)
> >
> > diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> > index 85ab270dad..ddb7e0d23c 100644
> > --- a/target/riscv/pmp.c
> > +++ b/target/riscv/pmp.c
> > @@ -45,11 +45,6 @@ static inline uint8_t pmp_get_a_field(uint8_t cfg)
> >    */
> >   static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_inde=
x)
> >   {
> > -    /* mseccfg.RLB is set */
> > -    if (MSECCFG_RLB_ISSET(env)) {
> > -        return 0;
> > -    }
> > -
> >       if (env->pmp_state.pmp[pmp_index].cfg_reg & PMP_LOCK) {
> >           return 1;
> >       }
> > @@ -62,6 +57,15 @@ static inline int pmp_is_locked(CPURISCVState *env,
> uint32_t pmp_index)
> >       return 0;
> >   }
> >
> > +/*
> > + * Check whether a PMP is locked for writing or not.
> > + * (i.e. has LOCK flag and mseccfg.RLB is unset)
> > + */
> > +static int pmp_is_readonly(CPURISCVState *env, uint32_t pmp_index)
> > +{
> > +    return pmp_is_locked(env, pmp_index) && !MSECCFG_RLB_ISSET(env);
> > +}
> > +
> >   /*
> >    * Count the number of active rules.
> >    */
> > @@ -90,39 +94,40 @@ static inline uint8_t pmp_read_cfg(CPURISCVState
> *env, uint32_t pmp_index)
> >   static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index,
> uint8_t val)
> >   {
> >       if (pmp_index < MAX_RISCV_PMPS) {
> > -        bool locked =3D true;
> > +        bool readonly =3D true;
> >
> >           if (riscv_cpu_cfg(env)->ext_smepmp) {
> >               /* mseccfg.RLB is set */
> >               if (MSECCFG_RLB_ISSET(env)) {
> > -                locked =3D false;
> > +                readonly =3D false;
> >               }
> >
> >               /* mseccfg.MML is not set */
> > -            if (!MSECCFG_MML_ISSET(env) && !pmp_is_locked(env,
> pmp_index)) {
> > -                locked =3D false;
> > +            if (!MSECCFG_MML_ISSET(env) && !pmp_is_readonly(env,
> pmp_index)) {
> > +                readonly =3D false;
> >               }
> >
> >               /* mseccfg.MML is set */
> >               if (MSECCFG_MML_ISSET(env)) {
> >                   /* not adding execute bit */
> >                   if ((val & PMP_LOCK) !=3D 0 && (val & PMP_EXEC) !=3D
> PMP_EXEC) {
> > -                    locked =3D false;
> > +                    readonly =3D false;
> >                   }
> >                   /* shared region and not adding X bit */
> >                   if ((val & PMP_LOCK) !=3D PMP_LOCK &&
> >                       (val & 0x7) !=3D (PMP_WRITE | PMP_EXEC)) {
> > -                    locked =3D false;
> > +                    readonly =3D false;
> >                   }
> >               }
> >           } else {
> > -            if (!pmp_is_locked(env, pmp_index)) {
> > -                locked =3D false;
> > +            if (!pmp_is_readonly(env, pmp_index)) {
> > +                readonly =3D false;
>
> Here we can do:
>
>                    readonly =3D pmp_is_readonly(env, pmp_index);
>
> And spare an extra if.
>
> Sure, I will change this in v2.


>
> Thanks,
>
> Daniel
>
> >               }
> >           }
> >
> > -        if (locked) {
> > -            qemu_log_mask(LOG_GUEST_ERROR, "ignoring pmpcfg write -
> locked\n");
> > +        if (readonly) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "ignoring pmpcfg write - read only\n");
> >           } else if (env->pmp_state.pmp[pmp_index].cfg_reg !=3D val) {
> >               /* If !mseccfg.MML then ignore writes with encoding RW=3D=
01
> */
> >               if ((val & PMP_WRITE) && !(val & PMP_READ) &&
> > @@ -524,14 +529,14 @@ void pmpaddr_csr_write(CPURISCVState *env,
> uint32_t addr_index,
> >               uint8_t pmp_cfg =3D env->pmp_state.pmp[addr_index +
> 1].cfg_reg;
> >               is_next_cfg_tor =3D PMP_AMATCH_TOR =3D=3D
> pmp_get_a_field(pmp_cfg);
> >
> > -            if (pmp_is_locked(env, addr_index + 1) && is_next_cfg_tor)=
 {
> > +            if (pmp_is_readonly(env, addr_index + 1) &&
> is_next_cfg_tor) {
> >                   qemu_log_mask(LOG_GUEST_ERROR,
> > -                              "ignoring pmpaddr write - pmpcfg + 1
> locked\n");
> > +                              "ignoring pmpaddr write - pmpcfg+1 read
> only\n");
> >                   return;
> >               }
> >           }
> >
> > -        if (!pmp_is_locked(env, addr_index)) {
> > +        if (!pmp_is_readonly(env, addr_index)) {
> >               if (env->pmp_state.pmp[addr_index].addr_reg !=3D val) {
> >                   env->pmp_state.pmp[addr_index].addr_reg =3D val;
> >                   pmp_update_rule_addr(env, addr_index);
> > @@ -542,7 +547,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t
> addr_index,
> >               }
> >           } else {
> >               qemu_log_mask(LOG_GUEST_ERROR,
> > -                          "ignoring pmpaddr write - locked\n");
> > +                          "ignoring pmpaddr write - read only\n");
> >           }
> >       } else {
> >           qemu_log_mask(LOG_GUEST_ERROR,
>
>

--0000000000005f1d1706303b8a0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Mar 13, 2025 at 12:40=E2=80=AFPM =
Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ventanamicro.com">db=
arboza@ventanamicro.com</a>&gt; wrote:</div><div class=3D"gmail_quote gmail=
_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 2/25/25 1:00 PM, Lo=C3=AFc Lefort wrote:<br>
&gt; When Smepmp is supported, RLB allows bypassing locks when writing CSRs=
 but<br>
&gt; should not affect interpretation of actual PMP rules.<br>
&gt; <br>
&gt; pmp_is_locked is changed to only check LOCK bit and a new pmp_is_reado=
nly<br>
&gt; function is added that checks both LOCK bit and mseccfg.RLB. pmp_write=
_cfg and<br>
&gt; pmpaddr_csr_write are changed to use pmp_is_readonly while pmp_hart_ha=
s_privs<br>
&gt; keeps using pmp_is_locked.<br>
<br>
<br>
Note that this change (removing=C2=A0 MSECCFG_RLB_ISSET(env) check from pmp=
_is_locked())<br>
can impact the behavior of at least one caller in pmp_hart_has_privs():<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!MSECCFG_MML_ISSET(env)=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * If mseccfg=
.MML Bit is not set, do pmp priv check<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * This will =
always apply to regular PMP.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*allowed_priv=
s =3D PMP_READ | PMP_WRITE | PMP_EXEC;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((mode !=
=3D PRV_M) || pmp_is_locked(env, i)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*allowed_privs &amp;=3D env-&gt;pmp_state.pmp[i].cfg_reg;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
Setting allowed_privs requires !MSECCFG_RLB_ISSET(env), and after this patc=
h allowed_privs<br>
will be set regardless of MSECCFG_RLB_ISSET(env), at least w.r.t how pmp_is=
_locked() works.<br>
<br>
This might not be an issue and there&#39;s not behavioral change. In this c=
ase it would be good<br>
to mention in the commit msg why this is the case.<br>
<br>
We can just add a !MSECCFG_RLB_ISSET(env) at this point to preserve behavio=
r too.<br>
<br></blockquote><div>Not checking RLB in this code path is the main point =
of this commit: allowed_privs should not depend on RLB.</div><div>I&#39;ll =
reword the commit message in v2 to make it more explicit.</div><div><br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; Signed-off-by: Lo=C3=AFc Lefort &lt;<a href=3D"mailto:loic@rivosinc.co=
m" target=3D"_blank">loic@rivosinc.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/riscv/pmp.c | 43 ++++++++++++++++++++++++----------=
---------<br>
&gt;=C2=A0 =C2=A01 file changed, 24 insertions(+), 19 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c<br>
&gt; index 85ab270dad..ddb7e0d23c 100644<br>
&gt; --- a/target/riscv/pmp.c<br>
&gt; +++ b/target/riscv/pmp.c<br>
&gt; @@ -45,11 +45,6 @@ static inline uint8_t pmp_get_a_field(uint8_t cfg)<=
br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0static inline int pmp_is_locked(CPURISCVState *env, uint32=
_t pmp_index)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 /* mseccfg.RLB is set */<br>
&gt; -=C2=A0 =C2=A0 if (MSECCFG_RLB_ISSET(env)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (env-&gt;pmp_state.pmp[pmp_index].cfg_reg=
 &amp; PMP_LOCK) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; @@ -62,6 +57,15 @@ static inline int pmp_is_locked(CPURISCVState *env,=
 uint32_t pmp_index)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/*<br>
&gt; + * Check whether a PMP is locked for writing or not.<br>
&gt; + * (i.e. has LOCK flag and mseccfg.RLB is unset)<br>
&gt; + */<br>
&gt; +static int pmp_is_readonly(CPURISCVState *env, uint32_t pmp_index)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return pmp_is_locked(env, pmp_index) &amp;&amp; !MSECCF=
G_RLB_ISSET(env);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 * Count the number of active rules.<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt; @@ -90,39 +94,40 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *=
env, uint32_t pmp_index)<br>
&gt;=C2=A0 =C2=A0static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp=
_index, uint8_t val)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pmp_index &lt; MAX_RISCV_PMPS) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool locked =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool readonly =3D true;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (riscv_cpu_cfg(env)-&gt;ext=
_smepmp) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* mseccfg.RLB i=
s set */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (MSECCFG_RLB_=
ISSET(env)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 locked =3D fa=
lse;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 readonly =3D =
false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* mseccfg.MML i=
s not set */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!MSECCFG_MML_ISSET(env)=
 &amp;&amp; !pmp_is_locked(env, pmp_index)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 locked =3D fa=
lse;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!MSECCFG_MML_ISSET(env)=
 &amp;&amp; !pmp_is_readonly(env, pmp_index)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 readonly =3D =
false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* mseccfg.MML i=
s set */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (MSECCFG_MML_=
ISSET(env)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 not adding execute bit */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 ((val &amp; PMP_LOCK) !=3D 0 &amp;&amp; (val &amp; PMP_EXEC) !=3D PMP_EXEC=
) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 locked =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 readonly =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 shared region and not adding X bit */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 ((val &amp; PMP_LOCK) !=3D PMP_LOCK &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(val &amp; 0x7) !=3D (PMP_WRITE | PMP_EXEC)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 locked =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 readonly =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pmp_is_locked(env, pmp=
_index)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 locked =3D fa=
lse;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pmp_is_readonly(env, p=
mp_index)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 readonly =3D =
false;<br>
<br>
Here we can do:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0readon=
ly =3D pmp_is_readonly(env, pmp_index);<br>
<br>
And spare an extra if.<br>
<br></blockquote><div>Sure, I will change this in v2.</div><div>=C2=A0<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
<br>
Daniel<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (locked) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERR=
OR, &quot;ignoring pmpcfg write - locked\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (readonly) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERR=
OR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;ignoring pmpcfg write - read only\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (env-&gt;pmp_state.p=
mp[pmp_index].cfg_reg !=3D val) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* If !mseccfg.M=
ML then ignore writes with encoding RW=3D01 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((val &amp; P=
MP_WRITE) &amp;&amp; !(val &amp; PMP_READ) &amp;&amp;<br>
&gt; @@ -524,14 +529,14 @@ void pmpaddr_csr_write(CPURISCVState *env, uint3=
2_t addr_index,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t pmp_cfg =
=3D env-&gt;pmp_state.pmp[addr_index + 1].cfg_reg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is_next_cfg_tor =
=3D PMP_AMATCH_TOR =3D=3D pmp_get_a_field(pmp_cfg);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pmp_is_locked(env, addr=
_index + 1) &amp;&amp; is_next_cfg_tor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pmp_is_readonly(env, ad=
dr_index + 1) &amp;&amp; is_next_cfg_tor) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qe=
mu_log_mask(LOG_GUEST_ERROR,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ignoring pmpaddr write - pmpcfg +=
 1 locked\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ignoring pmpaddr write - pmpcfg+1=
 read only\n&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pmp_is_locked(env, addr_index)) {<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!pmp_is_readonly(env, addr_index)) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (env-&gt;pmp_=
state.pmp[addr_index].addr_reg !=3D val) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0en=
v-&gt;pmp_state.pmp[addr_index].addr_reg =3D val;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm=
p_update_rule_addr(env, addr_index);<br>
&gt; @@ -542,7 +547,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_=
t addr_index,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LO=
G_GUEST_ERROR,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;ignoring pmpaddr write - locked\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 &quot;ignoring pmpaddr write - read only\n&quot;);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_GUEST_ERROR,=
<br>
<br>
</blockquote></div></div>

--0000000000005f1d1706303b8a0c--

