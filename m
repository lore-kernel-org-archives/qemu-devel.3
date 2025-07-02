Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88F1C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 11:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWvSd-0006Ae-Dt; Wed, 02 Jul 2025 07:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWvSc-0006AR-DX; Wed, 02 Jul 2025 07:17:06 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWvSZ-0001HS-VW; Wed, 02 Jul 2025 07:17:06 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e7569ccf04cso3497641276.0; 
 Wed, 02 Jul 2025 04:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751455019; x=1752059819; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=esFG4mriCbLfyUGdNR7evvuJtPcFizqP8K87IbCb5+g=;
 b=drKtG9LiRSiFq6AvqaIy6nx8j/R0eDYJLY1QhsqCXliVe6MMmkP8SALyo/8UWA9ge5
 lht37fw7qWWJme2lkBCOfu6dl+MGUUex6y28d2CfF0dRL0uBO1eM3gQwQ1AsUXsLawd3
 6sfDGgTGmd/DcsNj7mjCrZoYdE6embvICb/DS4ZaJLR1B5vMQguYSWicNjvp/pCB7g7O
 cjfQt8oCNxvPKgFhXeVJMEhZiWZkVEmfFseZMGo9MqourE/8GQOqFYpzt4BiaXI+cVCs
 uc+Yg8/J0cZ/NrLyDbNkgJ/tPvwD31DEiDbbAIIQ8UhMoG84R3I9fLATeqW0m8A5vmHA
 fK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751455019; x=1752059819;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=esFG4mriCbLfyUGdNR7evvuJtPcFizqP8K87IbCb5+g=;
 b=k+71IP+Adq6YhDT29abU9tH2DP8qfHq3VYQF7Qmi7eRS9k2oPPdWcAwFoFtvRdFeId
 ORYWigmtDYjaMHSZ98gYHMNuxHNK6bbRl+bSu6oZia3jCqI4FkIRqpWstq1SLnQ77Zmd
 VByLqPgw874zIAR/fNwjCK2DhI8Xc6dK9ye+uhR3qjReD3jLdjWaWeKlBJFinEDgoxjE
 4OhVY40Tt0JIDl9ADqFhQg8IBSbrnuE1bGKQ288A3RcCiLGPO0nfg4v2ejMAhWksks8O
 64MABE1tl/NnNwExQTNtuWD9zDWlcbjR6pyGa+xCpwgX7DuzAO6hfV0UrGlcPcDPETBO
 +GDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs4L2/2x4pW5FkqZUOQkU3YmbVdvKgPz47oLOXJxfcY3Vp5QB6maLfSgSuMbtJUY39yHHz4eJQ7w==@nongnu.org
X-Gm-Message-State: AOJu0Yx/NHbfNuCxWk5DpzrfmxwJr5uJuoO1yhuFErfy8qZ9aA4A5X2U
 1lrBJH79BQPnJayxfjsUn54E5l0W+grFp4JWxx8Ri5sSf1xXyel9WeA9JLC+RS9xmPK1CsjPT/8
 o8cUF4Y7DVJEhZIsscEA49OpgfMM/UKg=
X-Gm-Gg: ASbGncvJYfdGjCUXUex2SSyopVIUQK2A1/rCnFkd/c1UouZ8ckI466k7crIP1VBwl/x
 +JshJIX9bJTrAhrircqQxs/igsl8SeNv121MLA9/Ohbmx8IeIPRyW4KWDYIYMI/R/NMB+PjQ1zv
 QWJIpBbjs/sNM4kTUphj/t3HkhP4Xa24helPVFioUehq/MqWEyZMXL3A==
X-Google-Smtp-Source: AGHT+IFpaF8A/vaVaOQH/7pHY5ja2hFic/EtSTKshLxVZBTmlDA3jmNJYZqFjIN20hD9zTqT+Pug/TUeK1WaNFss/pw=
X-Received: by 2002:a05:6902:18c2:b0:e82:249a:7b83 with SMTP id
 3f1490d57ef6-e897e14c9femr3071027276.20.1751455018594; Wed, 02 Jul 2025
 04:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
 <20250701103159.62661-5-kosasihwilliam4@gmail.com>
 <d0fe4c30-3dbd-4868-a277-c6777a83972d@linaro.org>
In-Reply-To: <d0fe4c30-3dbd-4868-a277-c6777a83972d@linaro.org>
From: William Kosasih <kosasihwilliam4@gmail.com>
Date: Wed, 2 Jul 2025 20:46:45 +0930
X-Gm-Features: Ac12FXz1qYkxvbTO6X-NFYDIdmYcrr6gPUW9wO1k8YELN5vL6GUbDGESji8f_34
Message-ID: <CAG66A_cXDwDgCZNEfpRcZQi8nrbP-kpnKMMbaQqaDfKNGNC2yg@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] target/arm: Fix VLDR helper load alignment checks
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003936850638f066ae"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-yb1-xb2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--0000000000003936850638f066ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard, really appreciate your comment, thank you very much.


> Don't do this.  (1) Not all of these operations require sign extension,
> (2) it's clearer
> to simply cast to an appropriate MTYPE.

I'll fix that :-)

AFAICS, this isn't used.

I wasn't sure whether your preference is to delete the other macros as well
(MFLAG(), MSIZE(), and their underlying definition),
but I assume that you wanted them gone. I've deleted all of them in my next
patch series, opting to pass those
as the parameter of the VLDR, VSTR helper macro instead. I hope that
matches your intent -- but please let me know if you=E2=80=99d
prefer a different approach, I'm happy to fix them again. Sorry for the
back-and-forth, and thanks again for your guidance.

Best regards,
William



On Wed, Jul 2, 2025 at 11:59=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/1/25 04:31, William Kosasih wrote:
> > This patch adds alignment checks in the load operations in the VLDR
> > instruction.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
> > Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
> > ---
> >   target/arm/tcg/mve_helper.c | 41 ++++++++++++++++++++++++++++--------=
-
> >   1 file changed, 31 insertions(+), 10 deletions(-)
> >
> > diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
> > index 506d1c3475..922cd2371a 100644
> > --- a/target/arm/tcg/mve_helper.c
> > +++ b/target/arm/tcg/mve_helper.c
> > @@ -147,6 +147,22 @@ static void mve_advance_vpt(CPUARMState *env)
> >       env->v7m.vpr =3D vpr;
> >   }
> >
> > +/* Mapping of LDTYPE/STTYPE to the number of bytes accessed */
> > +#define MSIZE_b 1
> > +#define MSIZE_w 2
> > +#define MSIZE_l 4
> > +
> > +/* Mapping of LDTYPE/STTYPE to MemOp flag */
> > +#define MFLAG_b MO_UB
> > +#define MFLAG_w MO_TEUW
> > +#define MFLAG_l MO_TEUL
> > +
> > +#define MSIZE(t)  MSIZE_##t
>
> AFAICS, this isn't used.
>
> > +#define MFLAG(t)  MFLAG_##t
> > +
> > +#define SIGN_EXT(v, T, B) { \
> > +    ((T)(v) << (sizeof(T) * 8 - (B))) >> (sizeof(T) * 8 - (B)) }
>
> Don't do this.  (1) Not all of these operations require sign extension,
> (2) it's clearer
> to simply cast to an appropriate MTYPE.
>
> r~
>
> > +
> >   /* For loads, predicated lanes are zeroed instead of keeping their ol=
d
> values */
> >   #define DO_VLDR(OP, MSIZE, LDTYPE, ESIZE, TYPE)
>  \
> >       void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)
>   \
> > @@ -155,6 +171,8 @@ static void mve_advance_vpt(CPUARMState *env)
> >           uint16_t mask =3D mve_element_mask(env);
>   \
> >           uint16_t eci_mask =3D mve_eci_mask(env);
>   \
> >           unsigned b, e;
>   \
> > +        int mmu_idx =3D arm_to_core_mmu_idx(arm_mmu_idx(env));
> \
> > +        MemOpIdx oi =3D make_memop_idx(MFLAG(LDTYPE) | MO_ALIGN,
> mmu_idx);\
> >           /*
>   \
> >            * R_SXTM allows the dest reg to become UNKNOWN for abandoned
>  \
> >            * beats so we don't care if we update part of the dest and
>  \
> > @@ -163,7 +181,10 @@ static void mve_advance_vpt(CPUARMState *env)
> >           for (b =3D 0, e =3D 0; b < 16; b +=3D ESIZE, e++) {
>  \
> >               if (eci_mask & (1 << b)) {
>   \
> >                   d[H##ESIZE(e)] =3D (mask & (1 << b)) ?
>   \
> > -                    cpu_##LDTYPE##_data_ra(env, addr, GETPC()) : 0;
>  \
> > +                    SIGN_EXT(cpu_ld##LDTYPE##_mmu(env, addr, oi,
> GETPC()),\
> > +                             TYPE,
> \
> > +                             MSIZE * 8)
>  \
> > +                    : 0;
> \
> >               }
>  \
> >               addr +=3D MSIZE;
>   \
> >           }
>  \
> > @@ -185,20 +206,20 @@ static void mve_advance_vpt(CPUARMState *env)
> >           mve_advance_vpt(env);
>  \
> >       }
> >
> > -DO_VLDR(vldrb, 1, ldub, 1, uint8_t)
> > -DO_VLDR(vldrh, 2, lduw, 2, uint16_t)
> > -DO_VLDR(vldrw, 4, ldl, 4, uint32_t)
> > +DO_VLDR(vldrb, 1, b, 1, uint8_t)
> > +DO_VLDR(vldrh, 2, w, 2, uint16_t)
> > +DO_VLDR(vldrw, 4, l, 4, uint32_t)
> >
> >   DO_VSTR(vstrb, 1, stb, 1, uint8_t)
> >   DO_VSTR(vstrh, 2, stw, 2, uint16_t)
> >   DO_VSTR(vstrw, 4, stl, 4, uint32_t)
> >
> > -DO_VLDR(vldrb_sh, 1, ldsb, 2, int16_t)
> > -DO_VLDR(vldrb_sw, 1, ldsb, 4, int32_t)
> > -DO_VLDR(vldrb_uh, 1, ldub, 2, uint16_t)
> > -DO_VLDR(vldrb_uw, 1, ldub, 4, uint32_t)
> > -DO_VLDR(vldrh_sw, 2, ldsw, 4, int32_t)
> > -DO_VLDR(vldrh_uw, 2, lduw, 4, uint32_t)
> > +DO_VLDR(vldrb_sh, 1, b, 2, int16_t)
> > +DO_VLDR(vldrb_sw, 1, b, 4, int32_t)
> > +DO_VLDR(vldrb_uh, 1, b, 2, uint16_t)
> > +DO_VLDR(vldrb_uw, 1, b, 4, uint32_t)
> > +DO_VLDR(vldrh_sw, 2, w, 4, int32_t)
> > +DO_VLDR(vldrh_uw, 2, w, 4, uint32_t)
> >
> >   DO_VSTR(vstrb_h, 1, stb, 2, int16_t)
> >   DO_VSTR(vstrb_w, 1, stb, 4, int32_t)
>
>

--0000000000003936850638f066ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Richard, really appreciate your comment, thank you=
 very much.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Don&#39;t do this.=C2=A0 (1) Not all of these operations require=
 sign extension, (2) it&#39;s clearer<br>to simply cast to an appropriate M=
TYPE.</blockquote><div>I&#39;ll fix that :-)</div><div><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">AFAICS, this isn&#39;t used.</block=
quote><div>I wasn&#39;t sure whether your preference=C2=A0is to delete the =
other macros as well (MFLAG(), MSIZE(), and their underlying definition),=
=C2=A0</div><div>but I assume that you wanted them gone. I&#39;ve deleted a=
ll of them in my next patch series, opting to pass those=C2=A0</div><div>as=
 the parameter of the VLDR, VSTR helper macro instead. I hope that matches =
your intent -- but please let me know if you=E2=80=99d=C2=A0</div><div>pref=
er a different approach, I&#39;m happy to fix them again.=C2=A0Sorry for th=
e back-and-forth, and thanks again for your guidance.</div><div><br></div><=
div>Best regards,</div><div>William</div><div>=C2=A0=C2=A0</div><div><br></=
div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Wed, Jul 2, 2025 at 11:59=E2=80=AFAM Richard Henders=
on &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.henderson@li=
naro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">On 7/1/25 04:31, William Kosasih wrote:<br>
&gt; This patch adds alignment checks in the load operations in the VLDR<br=
>
&gt; instruction.<br>
&gt; <br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/115=
4" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/1154</a><br>
&gt; Signed-off-by: William Kosasih &lt;<a href=3D"mailto:kosasihwilliam4@g=
mail.com" target=3D"_blank">kosasihwilliam4@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/arm/tcg/mve_helper.c | 41 +++++++++++++++++++++++++=
+++---------<br>
&gt;=C2=A0 =C2=A01 file changed, 31 insertions(+), 10 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c=
<br>
&gt; index 506d1c3475..922cd2371a 100644<br>
&gt; --- a/target/arm/tcg/mve_helper.c<br>
&gt; +++ b/target/arm/tcg/mve_helper.c<br>
&gt; @@ -147,6 +147,22 @@ static void mve_advance_vpt(CPUARMState *env)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;v7m.vpr =3D vpr;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/* Mapping of LDTYPE/STTYPE to the number of bytes accessed */<br>
&gt; +#define MSIZE_b 1<br>
&gt; +#define MSIZE_w 2<br>
&gt; +#define MSIZE_l 4<br>
&gt; +<br>
&gt; +/* Mapping of LDTYPE/STTYPE to MemOp flag */<br>
&gt; +#define MFLAG_b MO_UB<br>
&gt; +#define MFLAG_w MO_TEUW<br>
&gt; +#define MFLAG_l MO_TEUL<br>
&gt; +<br>
&gt; +#define MSIZE(t)=C2=A0 MSIZE_##t<br>
<br>
AFAICS, this isn&#39;t used.<br>
<br>
&gt; +#define MFLAG(t)=C2=A0 MFLAG_##t<br>
&gt; +<br>
&gt; +#define SIGN_EXT(v, T, B) { \<br>
&gt; +=C2=A0 =C2=A0 ((T)(v) &lt;&lt; (sizeof(T) * 8 - (B))) &gt;&gt; (sizeo=
f(T) * 8 - (B)) }<br>
<br>
Don&#39;t do this.=C2=A0 (1) Not all of these operations require sign exten=
sion, (2) it&#39;s clearer <br>
to simply cast to an appropriate MTYPE.<br>
<br>
r~<br>
<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/* For loads, predicated lanes are zeroed instead of keepi=
ng their old values */<br>
&gt;=C2=A0 =C2=A0#define DO_VLDR(OP, MSIZE, LDTYPE, ESIZE, TYPE)=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0void HELPER(mve_##OP)(CPUARMState *env, void=
 *vd, uint32_t addr)=C2=A0 =C2=A0 \<br>
&gt; @@ -155,6 +171,8 @@ static void mve_advance_vpt(CPUARMState *env)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t mask =3D mve_element_=
mask(env);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t eci_mask =3D mve_eci_=
mask(env);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned b, e;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int mmu_idx =3D arm_to_core_mmu_idx(arm_m=
mu_idx(env));=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MemOpIdx oi =3D make_memop_idx(MFLAG(LDTY=
PE) | MO_ALIGN, mmu_idx);\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * R_SXTM allows the dest reg =
to become UNKNOWN for abandoned=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * beats so we don&#39;t care =
if we update part of the dest and=C2=A0 =C2=A0 =C2=A0\<br>
&gt; @@ -163,7 +181,10 @@ static void mve_advance_vpt(CPUARMState *env)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (b =3D 0, e =3D 0; b &lt; =
16; b +=3D ESIZE, e++) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (eci_mask &am=
p; (1 &lt;&lt; b)) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d[=
H##ESIZE(e)] =3D (mask &amp; (1 &lt;&lt; b)) ?=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 cpu_##LDTYPE##_data_ra(env, addr, GETPC()) : 0;=C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 SIGN_EXT(cpu_ld##LDTYPE##_mmu(env, addr, oi, GETPC()),\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MSIZE * 8)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 : 0;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0addr +=3D MSIZE;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; @@ -185,20 +206,20 @@ static void mve_advance_vpt(CPUARMState *env)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mve_advance_vpt(env);=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -DO_VLDR(vldrb, 1, ldub, 1, uint8_t)<br>
&gt; -DO_VLDR(vldrh, 2, lduw, 2, uint16_t)<br>
&gt; -DO_VLDR(vldrw, 4, ldl, 4, uint32_t)<br>
&gt; +DO_VLDR(vldrb, 1, b, 1, uint8_t)<br>
&gt; +DO_VLDR(vldrh, 2, w, 2, uint16_t)<br>
&gt; +DO_VLDR(vldrw, 4, l, 4, uint32_t)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0DO_VSTR(vstrb, 1, stb, 1, uint8_t)<br>
&gt;=C2=A0 =C2=A0DO_VSTR(vstrh, 2, stw, 2, uint16_t)<br>
&gt;=C2=A0 =C2=A0DO_VSTR(vstrw, 4, stl, 4, uint32_t)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -DO_VLDR(vldrb_sh, 1, ldsb, 2, int16_t)<br>
&gt; -DO_VLDR(vldrb_sw, 1, ldsb, 4, int32_t)<br>
&gt; -DO_VLDR(vldrb_uh, 1, ldub, 2, uint16_t)<br>
&gt; -DO_VLDR(vldrb_uw, 1, ldub, 4, uint32_t)<br>
&gt; -DO_VLDR(vldrh_sw, 2, ldsw, 4, int32_t)<br>
&gt; -DO_VLDR(vldrh_uw, 2, lduw, 4, uint32_t)<br>
&gt; +DO_VLDR(vldrb_sh, 1, b, 2, int16_t)<br>
&gt; +DO_VLDR(vldrb_sw, 1, b, 4, int32_t)<br>
&gt; +DO_VLDR(vldrb_uh, 1, b, 2, uint16_t)<br>
&gt; +DO_VLDR(vldrb_uw, 1, b, 4, uint32_t)<br>
&gt; +DO_VLDR(vldrh_sw, 2, w, 4, int32_t)<br>
&gt; +DO_VLDR(vldrh_uw, 2, w, 4, uint32_t)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0DO_VSTR(vstrb_h, 1, stb, 2, int16_t)<br>
&gt;=C2=A0 =C2=A0DO_VSTR(vstrb_w, 1, stb, 4, int32_t)<br>
<br>
</blockquote></div></div>

--0000000000003936850638f066ae--

