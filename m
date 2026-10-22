Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFBD606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 03:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H0JrQOXr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJjho-0006ba-Oc; Wed, 21 Oct 2026 23:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebasjosue84@gmail.com>)
 id 1xJjhm-0006aw-VU
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 23:43:02 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sebasjosue84@gmail.com>)
 id 1xJjhk-0001ZU-Bi
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 23:43:02 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6ac76a02368so1447164a12.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 20:42:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792640577; cv=none;
 d=google.com; s=arc-20260327;
 b=IvFcQWgIY/dpzIag8Cj6P9+3SXmEBNgP8jlIbypJuXdKMtqZWSUmJwOJUXqscAe+Nt
 ArKyQJoqXI+BTJIo4ZkMYC+7fBV0ahpqy+9E53tcgH+Xe2BGOM2kO2cFX8we01IdbWoV
 +hTEvrNnEGpUT3sUHM0Q+kQcUkQvBLkNs4QlD1W6tlF8zwRpM3f6u1lfZaVYKGZTNQHU
 au0hknlteGiFMTLmLac2FFBUlc6B7oK2mS05y0c4jvnSCop//Ppk8Ho8SeVUoOCMV9s4
 t+kDh9z6rHBDAcfZLyTAKdZo2uBaWwlK75S5mK1I/G1ZKY2vl9ZS2qH1Olyl576CL+Po
 USCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yBN3kEvILHy6sOduDf8CoEvsCmz2OgnbTxWsQrPqBfE=;
 fh=k+xGB3K8JDpK6GEjyzPf1ck3V0ZHh3uucRUL2Vvzlrc=;
 b=FAm5L3/XKn5Pm5UPK82X/0/bpBdUOWrK/vIwbAbaGW7lEYZ8qr9lR0m3Yft3rMGW/E
 bWaOKLQTFC1WF8zl+zCdYeTBSWCwtAX0j7RPXNYFAhXM7bh1+0xFs7gTb+PJXlgD7TzG
 EvkoT3yAtFOey00r0Qf1i4iPn1q6jimyqnAS+NePm6MLoQjs8AnwmgiPT7oYWx2HwxgJ
 IkL745tYVQLcrSuZL2mxpXB5RhYLXmDInpbuB9UtGCq3JQiD/9tq0/NCH6bYLKrzXfNR
 4Tx8P3zTubBjyHNOFKMbSXP9yHtLeJzmPBUdtwOwSaqlgYwQ4oG1htWVlEAbtFv8dCsA
 dztA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792640577; x=1793245377; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yBN3kEvILHy6sOduDf8CoEvsCmz2OgnbTxWsQrPqBfE=;
 b=H0JrQOXrTZWGvdlBEUwd6R+PEgEoFTwMP/9Y2zVDyNP7GWHp3kLZz2/PQygZDeQIJq
 JP5jihUpxDpwGgGI5IcrNu5QtvwRWsHdSagxN+e2wCphSizSsqbW2w3+1WlQ50ZdnnCZ
 Jz34MxbKdCqHfQyKjy4kvtEMR8tvAYcD0uuZ1QkpI7quBCja9JWy+yquS85H2zWixXKk
 w7BOgcfF0prFf2nGpwfxQGpd4+Yhkp3RPEIWlWBDP4ZXvQZ98qhN1kEkqd8ppNuhmQY5
 flv3JYpaq1kf+uio687EVfp3H+J+KhbLbCv8QkFTRTprUmMA4G5JZztCvgg91SyqMyNk
 8g4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792640577; x=1793245377;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yBN3kEvILHy6sOduDf8CoEvsCmz2OgnbTxWsQrPqBfE=;
 b=IYxkjk4sb70pDqL/Q8t+NAqVWPdOSIlGFY46wpKlVb/b4w7+J2ZHKMSQ5KIlaeq3DF
 0lTFhUTol3phqeICqS8oWI/DpZW8WNfPhfUSDFuCqiuj7b2n903eQal7kimYOLNBg+5O
 hFuchJUEwQi38L8bFrPzAXBUqlGBN4AfK+3rM21teMx/mNyxj8DODKPZ9RGjRZxccbTz
 t5/XisY6E3ccpiEsqBaeyN1t/CAPsxdCzN8gwQVbrhibuYbc25Xpopq1nxMLOxN/rlgp
 VAf4akN/Rl3UF6/1pfAg9BNWlLZy9grrn55YISb7XtJ7vclsCF0j5If4s/df2RlSmXZ1
 Q//A==
X-Gm-Message-State: AFq9FYL3bXi292QoRt1Pi/QQllP+2auxrE0Zt7VTOugL/MDbGR60DMIl
 +SvgulTwe4Py1Pz/e83kwr1Gzx0lQ7McmDqMogSu0fomWKTvJqbkUHcrqY6BFV9oddI5ESK3act
 d/loLQyEGdfuiDKaeQQaQiP05ZfKlwTo=
X-Gm-Gg: AYBFou13gGo/aOLhGC8Uh7fVcsj5itpIzGn+2xP5GFsMDSBRLsW3L6pilmOu+RqtYF4
 k+Tk2Cr0H4syEVvUCpJCL8ADTOLYgkAqCA3b4jpkYCQCKAeW2P3b7zZA/CPCcBB03Bhe3JP1vpM
 0CbPrGsGk8cKoHRSkZZVRI/99WP+rY6L6Ooi3sZKjkR/+kXMYjvKfz3B3K8hOkffUCM08+6MtCM
 gOW1pLhvDOdcsbeDi9hHVne44PpPQmNWlM0YA4Reh8jhnNhq4pLRcV0uQ3z/mT8j1x80MS/z8Ki
 bmMv0OGdRU9h8WMIsL/IV3c2Pv4Nt8BqCNCHI2Pu+E8Wys5vEsLS0TiWZyQTnSooXW+w3A3XvYv
 0tMomwOqZFTdi5/kN7OTaTEsW/VvkYpnEgMxen49/1OFWVF06bGxRpcyxOBv90ON0yhQEww==
X-Received: by 2002:a05:6402:3217:b0:6ac:7737:e50d with SMTP id
 4fb4d7f45d1cf-6b408ed59f7mr3018554a12.29.1792640577087; Wed, 21 Oct 2026
 20:42:57 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260916034331.2390427-1-sebasjosue84@gmail.com>
 <20261011040617.807504-1-sebasjosue84@gmail.com>
 <b6a81310e44e6ac785c469772c9d6df2f1fce4a8.camel@wdc.com>
In-Reply-To: <b6a81310e44e6ac785c469772c9d6df2f1fce4a8.camel@wdc.com>
From: =?UTF-8?Q?Sebasti=C3=A1n_Alba?= <sebasjosue84@gmail.com>
Date: Wed, 21 Oct 2026 21:42:45 -0600
X-Gm-Features: AclHuK9Fohipwm0P9QfZu8-1kUs6S7rwld7DtBxjy_Oy7ZYM7L-VH5-ABZe2QCY
Message-ID: <CAJD=UNe2OsN3bnQeLX1vimFuZ8=o3Zy=tUbvsHCC_ckTt_0-bw@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: pmp: clear the entire PMP state on reset
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "palmer@dabbelt.com" <palmer@dabbelt.com>, 
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>, 
 "chao.liu@processmission.com" <chao.liu@processmission.com>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Content-Type: multipart/alternative; boundary="000000000000cead51065e65a82b"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=sebasjosue84@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000cead51065e65a82b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Fair enough on the A and L fields, I'll follow the spec there.

The reason v2 went further... v1 leaves pmp_state.addr[] and
num_rules stale. Those are QEMU's own derived state, recomputed
only on the pmpaddr/pmpcfg write paths and never at reset.
pmp_is_in_range() compares against addr[].sa and .ea without
looking at the A field, and the partially-inside check in
pmp_hart_has_privs() runs before A is tested. So a range left from
before the reset can still deny a straddling access with A=3DOFF.
That part isn't a spec question, it's bookkeeping the spec doesn't
know about.

I'll respin as two patches:

  1/2  bound the loop by the implemented entry count instead of
       pmp_get_num_rules(), clearing A and L. This is v1.
  2/2  reset addr[] and num_rules alongside it.

Happy for you to take just 1/2 and leave 2/2 to stand on its own.

Sebasti=C3=A1n

El mi=C3=A9, 21 oct 2026 a las 21:39, Alistair Francis (<Alistair.Francis@w=
dc.com>)
escribi=C3=B3:

> On Sat, 2026-10-10 at 22:06 -0600, Sebastian Alba Vives wrote:
> > pmp_unlock_entries() bounded its loop with pmp_get_num_rules(), which
> > returns the number of entries whose A field is not OFF rather than
> > the
> > number of implemented entries. With a sparse configuration the loop
> > stops early: with entries 0 and 1 OFF and entries 2 and 3 locked,
> > num_rules is 2, the loop covers i =3D 0 and i =3D 1, and entries 2 and =
3
> > keep their lock and address-match bits across reset.
> >
> > riscv_cpu_reset_hold() clears mseccfg, and with it RLB, before
> > calling
> > this, so pmp_is_readonly() then silently discards every subsequent
> > pmpcfg write to those entries. The stale rules survive for the
> > lifetime of the machine.
> >
> > Clearing only PMP_LOCK and PMP_AMATCH is not enough either. The priv
> > spec only mandates that the A and L fields be reset, but QEMU keeps
> > derived state next to the architectural registers: pmp_state.addr[]
> > and pmp_state.num_rules are recomputed from the pmpaddr and pmpcfg
> > write paths only, never at reset. pmp_is_in_range() compares against
> > addr[].sa and addr[].ea without consulting the A field, and the
> > partially-inside check in pmp_hart_has_privs() runs before the A
> > field is tested, so a range left over from before the reset can still
> > deny an access that straddles its boundary once the guest configures
> > any entry again.
> >
> > Zero the whole structure instead. Zero is the correct reset value for
> > every field: a cfg_reg of 0 is A=3DOFF with no permissions, and a
> > num_rules of 0 restores the no-rules short cut. Rename the function
> > since it no longer only unlocks entries.
> >
> > Fixes: 4bf501dc0118 ("target/riscv: pmp: Clear pmp/smepmp bits on
> > reset")
> > Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> > ---
> > Changes in v2:
> > - Zero the whole env->pmp_state instead of masking PMP_LOCK and
> >   PMP_AMATCH over a bounded set of entries, as suggested by Richard.
> >   v1 also left pmp_state.addr[] and pmp_state.num_rules stale across
> >   reset, which the memset covers as well.
>
> I think your v1 is actually better.
>
> Richard asked why you don't just zero `pmp_state`, but the answer is
> because the RISC-V spec states that on reset "Writable PMP
> registers=E2=80=99 A and L fields are set to 0". So we should follow that
>
> Alistair
>
> >
> > v1:
> >
> https://lore.kernel.org/qemu-devel/20260916034331.2390427-1-sebasjosue84@=
gmail.com/
> >
> >  target/riscv/cpu.c     | 4 ++--
> >  target/riscv/tcg/pmp.c | 9 ++-------
> >  target/riscv/tcg/pmp.h | 2 +-
> >  3 files changed, 5 insertions(+), 10 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index da4c1a090b..0b71196507 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -1048,7 +1048,7 @@ static void riscv_cpu_reset_hold(Object *obj,
> > ResetType type)
> >      }
> >
> >      /*
> > -     * Clear mseccfg and unlock all the PMP entries upon reset.
> > +     * Clear mseccfg and the PMP state upon reset.
> >       * This is required as per the priv, smepmp, and other security
> >       * extension specifications that share this CSR, and is needed
> >       * to clear stale entries across reboots.
> > @@ -1060,7 +1060,7 @@ static void riscv_cpu_reset_hold(Object *obj,
> > ResetType type)
> >          env->mseccfg =3D 0;
> >      }
> >
> > -    pmp_unlock_entries(env);
> > +    pmp_reset(env);
> >  #endif /* ifdef CONFIG_TCG */
> >  #else
> >      env->priv =3D PRV_U;
> > diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
> > index 41b55519a8..437e0ff2af 100644
> > --- a/target/riscv/tcg/pmp.c
> > +++ b/target/riscv/tcg/pmp.c
> > @@ -199,14 +199,9 @@ static bool pmp_write_cfg(CPURISCVState *env,
> > uint32_t pmp_index, uint8_t val)
> >      return false;
> >  }
> >
> > -void pmp_unlock_entries(CPURISCVState *env)
> > +void pmp_reset(CPURISCVState *env)
> >  {
> > -    uint32_t pmp_num =3D pmp_get_num_rules(env);
> > -    int i;
> > -
> > -    for (i =3D 0; i < pmp_num; i++) {
> > -        env->pmp_state.pmp[i].cfg_reg &=3D ~(PMP_LOCK | PMP_AMATCH);
> > -    }
> > +    memset(&env->pmp_state, 0, sizeof(env->pmp_state));
> >  }
> >
> >  static void pmp_decode_napot(hwaddr a, hwaddr *sa, hwaddr *ea)
> > diff --git a/target/riscv/tcg/pmp.h b/target/riscv/tcg/pmp.h
> > index 4c95c2767a..99546934fc 100644
> > --- a/target/riscv/tcg/pmp.h
> > +++ b/target/riscv/tcg/pmp.h
> > @@ -79,7 +79,7 @@ void pmp_update_rule_addr(CPURISCVState *env,
> > uint32_t pmp_index);
> >  void pmp_update_rule_nums(CPURISCVState *env);
> >  uint32_t pmp_get_num_rules(CPURISCVState *env);
> >  int pmp_priv_to_page_prot(pmp_priv_t pmp_priv);
> > -void pmp_unlock_entries(CPURISCVState *env);
> > +void pmp_reset(CPURISCVState *env);
> >
> >  #define MSECCFG_MML_ISSET(env) get_field(env->mseccfg, MSECCFG_MML)
> >  #define MSECCFG_MMWP_ISSET(env) get_field(env->mseccfg,
> > MSECCFG_MMWP)
>


--=20
Sebasti=C3=A1n Alba

--000000000000cead51065e65a82b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Fair enough on the A and L fields, I&#39;ll follow the spe=
c there.<br><br>The reason v2 went further... v1 leaves pmp_state.addr[] an=
d<br>num_rules stale. Those are QEMU&#39;s own derived state, recomputed<br=
>only on the pmpaddr/pmpcfg write paths and never at reset.<br>pmp_is_in_ra=
nge() compares against addr[].sa and .ea without<br>looking at the A field,=
 and the partially-inside check in<br>pmp_hart_has_privs() runs before A is=
 tested. So a range left from<br>before the reset can still deny a straddli=
ng access with A=3DOFF.<br>That part isn&#39;t a spec question, it&#39;s bo=
okkeeping the spec doesn&#39;t<br>know about.<br><br>I&#39;ll respin as two=
 patches:<br><br>=C2=A0 1/2 =C2=A0bound the loop by the implemented entry c=
ount instead of<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0pmp_get_num_rules(), clearing=
 A and L. This is v1.<br>=C2=A0 2/2 =C2=A0reset addr[] and num_rules alongs=
ide it.<br><br>Happy for you to take just 1/2 and leave 2/2 to stand on its=
 own.<br><br>Sebasti=C3=A1n<br></div><br><div class=3D"gmail_quote gmail_qu=
ote_container"><div dir=3D"ltr" class=3D"gmail_attr">El mi=C3=A9, 21 oct 20=
26 a las 21:39, Alistair Francis (&lt;<a href=3D"mailto:Alistair.Francis@wd=
c.com">Alistair.Francis@wdc.com</a>&gt;) escribi=C3=B3:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width=
:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-lef=
t:1ex">On Sat, 2026-10-10 at 22:06 -0600, Sebastian Alba Vives wrote:<br>
&gt; pmp_unlock_entries() bounded its loop with pmp_get_num_rules(), which<=
br>
&gt; returns the number of entries whose A field is not OFF rather than<br>
&gt; the<br>
&gt; number of implemented entries. With a sparse configuration the loop<br=
>
&gt; stops early: with entries 0 and 1 OFF and entries 2 and 3 locked,<br>
&gt; num_rules is 2, the loop covers i =3D 0 and i =3D 1, and entries 2 and=
 3<br>
&gt; keep their lock and address-match bits across reset.<br>
&gt; <br>
&gt; riscv_cpu_reset_hold() clears mseccfg, and with it RLB, before<br>
&gt; calling<br>
&gt; this, so pmp_is_readonly() then silently discards every subsequent<br>
&gt; pmpcfg write to those entries. The stale rules survive for the<br>
&gt; lifetime of the machine.<br>
&gt; <br>
&gt; Clearing only PMP_LOCK and PMP_AMATCH is not enough either. The priv<b=
r>
&gt; spec only mandates that the A and L fields be reset, but QEMU keeps<br=
>
&gt; derived state next to the architectural registers: pmp_state.addr[]<br=
>
&gt; and pmp_state.num_rules are recomputed from the pmpaddr and pmpcfg<br>
&gt; write paths only, never at reset. pmp_is_in_range() compares against<b=
r>
&gt; addr[].sa and addr[].ea without consulting the A field, and the<br>
&gt; partially-inside check in pmp_hart_has_privs() runs before the A<br>
&gt; field is tested, so a range left over from before the reset can still<=
br>
&gt; deny an access that straddles its boundary once the guest configures<b=
r>
&gt; any entry again.<br>
&gt; <br>
&gt; Zero the whole structure instead. Zero is the correct reset value for<=
br>
&gt; every field: a cfg_reg of 0 is A=3DOFF with no permissions, and a<br>
&gt; num_rules of 0 restores the no-rules short cut. Rename the function<br=
>
&gt; since it no longer only unlocks entries.<br>
&gt; <br>
&gt; Fixes: 4bf501dc0118 (&quot;target/riscv: pmp: Clear pmp/smepmp bits on=
<br>
&gt; reset&quot;)<br>
&gt; Suggested-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderso=
n@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
&gt; Signed-off-by: Sebastian Alba Vives &lt;<a href=3D"mailto:sebasjosue84=
@gmail.com" target=3D"_blank">sebasjosue84@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; Changes in v2:<br>
&gt; - Zero the whole env-&gt;pmp_state instead of masking PMP_LOCK and<br>
&gt; =C2=A0 PMP_AMATCH over a bounded set of entries, as suggested by Richa=
rd.<br>
&gt; =C2=A0 v1 also left pmp_state.addr[] and pmp_state.num_rules stale acr=
oss<br>
&gt; =C2=A0 reset, which the memset covers as well.<br>
<br>
I think your v1 is actually better.<br>
<br>
Richard asked why you don&#39;t just zero `pmp_state`, but the answer is<br=
>
because the RISC-V spec states that on reset &quot;Writable PMP<br>
registers=E2=80=99 A and L fields are set to 0&quot;. So we should follow t=
hat<br>
<br>
Alistair<br>
<br>
&gt; <br>
&gt; v1:<br>
&gt; <a href=3D"https://lore.kernel.org/qemu-devel/20260916034331.2390427-1=
-sebasjosue84@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https://lore=
.kernel.org/qemu-devel/20260916034331.2390427-1-sebasjosue84@gmail.com/</a>=
<br>
&gt; <br>
&gt; =C2=A0target/riscv/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--<br>
&gt; =C2=A0target/riscv/tcg/pmp.c | 9 ++-------<br>
&gt; =C2=A0target/riscv/tcg/pmp.h | 2 +-<br>
&gt; =C2=A03 files changed, 5 insertions(+), 10 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
&gt; index da4c1a090b..0b71196507 100644<br>
&gt; --- a/target/riscv/cpu.c<br>
&gt; +++ b/target/riscv/cpu.c<br>
&gt; @@ -1048,7 +1048,7 @@ static void riscv_cpu_reset_hold(Object *obj,<br=
>
&gt; ResetType type)<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 /*<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0 * Clear mseccfg and unlock all the PMP entri=
es upon reset.<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * Clear mseccfg and the PMP state upon reset=
.<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This is required as per the priv, sme=
pmp, and other security<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * extension specifications that share t=
his CSR, and is needed<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to clear stale entries across reboots=
.<br>
&gt; @@ -1060,7 +1060,7 @@ static void riscv_cpu_reset_hold(Object *obj,<br=
>
&gt; ResetType type)<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env-&gt;mseccfg =3D 0=
;<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt; =C2=A0<br>
&gt; -=C2=A0=C2=A0=C2=A0 pmp_unlock_entries(env);<br>
&gt; +=C2=A0=C2=A0=C2=A0 pmp_reset(env);<br>
&gt; =C2=A0#endif /* ifdef CONFIG_TCG */<br>
&gt; =C2=A0#else<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 env-&gt;priv =3D PRV_U;<br>
&gt; diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c<br>
&gt; index 41b55519a8..437e0ff2af 100644<br>
&gt; --- a/target/riscv/tcg/pmp.c<br>
&gt; +++ b/target/riscv/tcg/pmp.c<br>
&gt; @@ -199,14 +199,9 @@ static bool pmp_write_cfg(CPURISCVState *env,<br>
&gt; uint32_t pmp_index, uint8_t val)<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 return false;<br>
&gt; =C2=A0}<br>
&gt; =C2=A0<br>
&gt; -void pmp_unlock_entries(CPURISCVState *env)<br>
&gt; +void pmp_reset(CPURISCVState *env)<br>
&gt; =C2=A0{<br>
&gt; -=C2=A0=C2=A0=C2=A0 uint32_t pmp_num =3D pmp_get_num_rules(env);<br>
&gt; -=C2=A0=C2=A0=C2=A0 int i;<br>
&gt; -<br>
&gt; -=C2=A0=C2=A0=C2=A0 for (i =3D 0; i &lt; pmp_num; i++) {<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env-&gt;pmp_state.pmp[i].c=
fg_reg &amp;=3D ~(PMP_LOCK | PMP_AMATCH);<br>
&gt; -=C2=A0=C2=A0=C2=A0 }<br>
&gt; +=C2=A0=C2=A0=C2=A0 memset(&amp;env-&gt;pmp_state, 0, sizeof(env-&gt;p=
mp_state));<br>
&gt; =C2=A0}<br>
&gt; =C2=A0<br>
&gt; =C2=A0static void pmp_decode_napot(hwaddr a, hwaddr *sa, hwaddr *ea)<b=
r>
&gt; diff --git a/target/riscv/tcg/pmp.h b/target/riscv/tcg/pmp.h<br>
&gt; index 4c95c2767a..99546934fc 100644<br>
&gt; --- a/target/riscv/tcg/pmp.h<br>
&gt; +++ b/target/riscv/tcg/pmp.h<br>
&gt; @@ -79,7 +79,7 @@ void pmp_update_rule_addr(CPURISCVState *env,<br>
&gt; uint32_t pmp_index);<br>
&gt; =C2=A0void pmp_update_rule_nums(CPURISCVState *env);<br>
&gt; =C2=A0uint32_t pmp_get_num_rules(CPURISCVState *env);<br>
&gt; =C2=A0int pmp_priv_to_page_prot(pmp_priv_t pmp_priv);<br>
&gt; -void pmp_unlock_entries(CPURISCVState *env);<br>
&gt; +void pmp_reset(CPURISCVState *env);<br>
&gt; =C2=A0<br>
&gt; =C2=A0#define MSECCFG_MML_ISSET(env) get_field(env-&gt;mseccfg, MSECCF=
G_MML)<br>
&gt; =C2=A0#define MSECCFG_MMWP_ISSET(env) get_field(env-&gt;mseccfg,<br>
&gt; MSECCFG_MMWP)<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"=
text-align:left">Sebasti=C3=A1n Alba</div><div style=3D"text-align:center">=
</div></div></div></div></div>

--000000000000cead51065e65a82b--

