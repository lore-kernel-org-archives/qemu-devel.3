Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF1CC27C53
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 22:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIycJ-0002pH-Td; Sun, 16 Jun 2024 18:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rrh.henry@gmail.com>)
 id 1sIycH-0002ou-TZ
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 18:44:54 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rrh.henry@gmail.com>)
 id 1sIycF-0001iL-Sg
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 18:44:53 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2eae70fb324so3171511fa.2
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 15:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718577889; x=1719182689; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xviu+UP8hwey+nKuQrae//O8kwthi9M/9z9v7YOLads=;
 b=eXhMNGP14mLdReL7dgEjy6WE7MtSa9VrsG77DIUTvC2cqalilFKC+s0q1Y6+aEx+wQ
 FMlq188pjwchrVNqECAIhZHBBbsl+UogPboxzed37gWG4UoFqdyUQrgKgWUJjgWKTJU7
 mLjx+Juyfj4AADX9fw0nfh1AJfAsBN7FRKPvx6Npzj3buOdN37lJCbgR4EEp+yQ7F13R
 DQJYcjz4m25noDXJuyOf9tKC5i4dJZqMwl82fP+DgDBGVJkY3tISiZvm/QbArbw09Xpj
 fe2fdJK7H3KdlTlin56gF+99RN7Fp/ywQEEm6hgPwFO0u5sSfejLBuoLpCoxYEk0urkG
 Ky2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718577889; x=1719182689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xviu+UP8hwey+nKuQrae//O8kwthi9M/9z9v7YOLads=;
 b=nDSDXvm81jw0Kl+Lig+z4rjQb5GwVGUNt6J1EFs6g0YcweN3Iv8MaujaONsXbHhWTF
 2ZXCkQKMkL4wwvikSXZ0rfCD29sdoMfUEKdl8O4R9SU5Znb8g1DzJL8pzHP87g2kN9Nt
 W66NbEZ4iTxJtU6bYs+n+jniAob6I7SSsTbIUVELrovz7eyH4lha4cEfALQOQQWhFr1r
 ryGFEpq9Vd1mb2lidcTEIOAtm9Lc6r6Zrd92qXuzKH5dVYRblBtEJGYKm/k5SGqRud5i
 VV3AzFVMUropXBETyUpdMBiPIloceQn+LO8J6R3kFhdzxkwEnr8oqWFqMCp077uZF9yj
 jxLA==
X-Gm-Message-State: AOJu0YxMSqVoButWYScX78O08VRt8DTDGwgiNiq9JwZ+h+IyEfHdieKg
 aFNUVOBHyayUNVS0Gx+NnSLXpRu5BEiEHXpcoVgEFjebKDKsf46aMyMo1x+jbdrjwtlV/mDHNU7
 Sirfhdmv2vO3D8G3QQQ4cqRF1U18=
X-Google-Smtp-Source: AGHT+IEAQUX3P2T6Ta6hjwrktHT8XATTK98WjvlJbFyGrkTzHxkli28kJK1k2A6Bi6SrvthIu+qtkH1sXk6sIg+D/rI=
X-Received: by 2002:a2e:979a:0:b0:2ec:daf:85d2 with SMTP id
 38308e7fff4ca-2ec0e5caf8fmr42057311fa.5.1718577888664; Sun, 16 Jun 2024
 15:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240611162021.269457-1-robhenry@microsoft.com>
 <20240611162021.269457-2-robhenry@microsoft.com>
 <71f86082-05df-48c8-9581-68f6417c525e@linaro.org>
In-Reply-To: <71f86082-05df-48c8-9581-68f6417c525e@linaro.org>
From: Robert Henry <rrh.henry@gmail.com>
Date: Sun, 16 Jun 2024 15:44:37 -0700
Message-ID: <CAEYr_8mY3cqnL1dsm-dA2k+T+M4YAQpHxeaYoZ805Ax-FSp8rA@mail.gmail.com>
Subject: Re: [PATCH 1/1] i386/tcg: Allow IRET from user mode to user mode for
 dotnet runtime
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 "Robert R. Henry" <robhenry@microsoft.com>
Content-Type: multipart/alternative; boundary="00000000000092a443061b0998b2"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=rrh.henry@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000092a443061b0998b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I do not think I will have the time or focus to work on improving this
patch this summer, as I will retire in 2 weeks and need to make a clean
break to focus on other things (health, for one) for a while.

If anyone wants to put into place Richard's ideas, I will not be offended!

I do not see any of this chatter in this email thread on the bug report
https://gitlab.com/qemu-project/qemu/-/issues/249

Robert Henry

On Sat, Jun 15, 2024 at 4:25=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 6/11/24 09:20, Robert R. Henry wrote:
> > This fixes a bug wherein i386/tcg assumed an interrupt return using
> > the IRET instruction was always returning from kernel mode to either
> > kernel mode or user mode. This assumption is violated when IRET is used
> > as a clever way to restore thread state, as for example in the dotnet
> > runtime. There, IRET returns from user mode to user mode.
> >
> > This bug manifested itself as a page fault in the guest Linux kernel.
> >
> > This bug appears to have been in QEMU since the beginning.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/249
> > Signed-off-by: Robert R. Henry <robhenry@microsoft.com>
> > ---
> >   target/i386/tcg/seg_helper.c | 78 ++++++++++++++++++++++-------------=
-
> >   1 file changed, 47 insertions(+), 31 deletions(-)
> >
> > diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.=
c
> > index 715db1f232..815d26e61d 100644
> > --- a/target/i386/tcg/seg_helper.c
> > +++ b/target/i386/tcg/seg_helper.c
> > @@ -843,20 +843,35 @@ static void do_interrupt_protected(CPUX86State
> *env, int intno, int is_int,
> >
> >   #ifdef TARGET_X86_64
> >
> > -#define PUSHQ_RA(sp, val, ra)                   \
> > -    {                                           \
> > -        sp -=3D 8;                                \
> > -        cpu_stq_kernel_ra(env, sp, (val), ra);  \
> > -    }
> > -
> > -#define POPQ_RA(sp, val, ra)                    \
> > -    {                                           \
> > -        val =3D cpu_ldq_kernel_ra(env, sp, ra);   \
> > -        sp +=3D 8;                                \
> > -    }
> > +#define PUSHQ_RA(sp, val, ra, cpl, dpl) \
> > +  FUNC_PUSHQ_RA(env, &sp, val, ra, cpl, dpl)
> > +
> > +static inline void FUNC_PUSHQ_RA(
> > +    CPUX86State *env, target_ulong *sp,
> > +    target_ulong val, target_ulong ra, int cpl, int dpl) {
> > +  *sp -=3D 8;
> > +  if (dpl =3D=3D 0) {
> > +    cpu_stq_kernel_ra(env, *sp, val, ra);
> > +  } else {
> > +    cpu_stq_data_ra(env, *sp, val, ra);
> > +  }
> > +}
>
> This doesn't seem quite right.
>
> I would be much happier if we were to resolve the proper mmu index
> earlier, once, rather
> than within each call to cpu_{ld,st}*_{kernel,data}_ra.  With the mmu
> index in hand, use
> cpu_{ld,st}*_mmuidx_ra instead.
>
> I believe you will want to factor out a subroutine of x86_cpu_mmu_index
> which passes in
> the pl, rather than reading cpl from env->hflags.  This will also allow
> cpu_mmu_index_kernel to be eliminated or simplified, which is written to
> assume pl=3D0.
>
>
> r~
>

--00000000000092a443061b0998b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I do not think I will have the time or focus to work on im=
proving this patch this summer, as I will retire in 2 weeks and need to mak=
e a clean break to focus on other things (health, for one) for a while.<div=
><br></div><div>If anyone wants to put into place Richard&#39;s ideas, I wi=
ll not be offended!<br><div><br></div><div>I do not see any of this chatter=
 in this email thread on the bug report <a href=3D"https://gitlab.com/qemu-=
project/qemu/-/issues/249">https://gitlab.com/qemu-project/qemu/-/issues/24=
9</a></div></div><div><br></div><div>Robert Henry</div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jun 15, 2024=
 at 4:25=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.henders=
on@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">On 6/11/24 09:20, Robert R. Henr=
y wrote:<br>
&gt; This fixes a bug wherein i386/tcg assumed an interrupt return using<br=
>
&gt; the IRET instruction was always returning from kernel mode to either<b=
r>
&gt; kernel mode or user mode. This assumption is violated when IRET is use=
d<br>
&gt; as a clever way to restore thread state, as for example in the dotnet<=
br>
&gt; runtime. There, IRET returns from user mode to user mode.<br>
&gt; <br>
&gt; This bug manifested itself as a page fault in the guest Linux kernel.<=
br>
&gt; <br>
&gt; This bug appears to have been in QEMU since the beginning.<br>
&gt; <br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/249=
" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu=
/-/issues/249</a><br>
&gt; Signed-off-by: Robert R. Henry &lt;<a href=3D"mailto:robhenry@microsof=
t.com" target=3D"_blank">robhenry@microsoft.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/i386/tcg/seg_helper.c | 78 ++++++++++++++++++++++--=
------------<br>
&gt;=C2=A0 =C2=A01 file changed, 47 insertions(+), 31 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper=
.c<br>
&gt; index 715db1f232..815d26e61d 100644<br>
&gt; --- a/target/i386/tcg/seg_helper.c<br>
&gt; +++ b/target/i386/tcg/seg_helper.c<br>
&gt; @@ -843,20 +843,35 @@ static void do_interrupt_protected(CPUX86State *=
env, int intno, int is_int,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#ifdef TARGET_X86_64<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -#define PUSHQ_RA(sp, val, ra)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sp -=3D 8;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stq_kernel_ra(env, sp, (val), ra);=C2=
=A0 \<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt; -#define POPQ_RA(sp, val, ra)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; -=C2=A0 =C2=A0 {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D cpu_ldq_kernel_ra(env, sp, ra);=
=C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sp +=3D 8;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; +#define PUSHQ_RA(sp, val, ra, cpl, dpl) \<br>
&gt; +=C2=A0 FUNC_PUSHQ_RA(env, &amp;sp, val, ra, cpl, dpl)<br>
&gt; +<br>
&gt; +static inline void FUNC_PUSHQ_RA(<br>
&gt; +=C2=A0 =C2=A0 CPUX86State *env, target_ulong *sp,<br>
&gt; +=C2=A0 =C2=A0 target_ulong val, target_ulong ra, int cpl, int dpl) {<=
br>
&gt; +=C2=A0 *sp -=3D 8;<br>
&gt; +=C2=A0 if (dpl =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 cpu_stq_kernel_ra(env, *sp, val, ra);<br>
&gt; +=C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 cpu_stq_data_ra(env, *sp, val, ra);<br>
&gt; +=C2=A0 }<br>
&gt; +}<br>
<br>
This doesn&#39;t seem quite right.<br>
<br>
I would be much happier if we were to resolve the proper mmu index earlier,=
 once, rather <br>
than within each call to cpu_{ld,st}*_{kernel,data}_ra.=C2=A0 With the mmu =
index in hand, use <br>
cpu_{ld,st}*_mmuidx_ra instead.<br>
<br>
I believe you will want to factor out a subroutine of x86_cpu_mmu_index whi=
ch passes in <br>
the pl, rather than reading cpl from env-&gt;hflags.=C2=A0 This will also a=
llow <br>
cpu_mmu_index_kernel to be eliminated or simplified, which is written to as=
sume pl=3D0.<br>
<br>
<br>
r~<br>
</blockquote></div>

--00000000000092a443061b0998b2--

