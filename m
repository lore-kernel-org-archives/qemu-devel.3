Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49692C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 15:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLPY8-0001S8-OO; Sun, 23 Jun 2024 11:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sLPY6-0001Rh-4W
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 11:54:38 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sLPY4-0008Le-3m
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 11:54:37 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2c7c61f7ee3so2776269a91.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 08:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1719158074; x=1719762874;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/HpNZMdhTtHRVYCl+3FhtOeDv2R3CbG9pkvAbY/pBBY=;
 b=2pl9hEiD1P+yp6Hj5Rxy+tja8NK4rFtZ6jVjmjZt82F+ztfWe9lsyBsu3Tpn5Qhjej
 bqdBbEy6nqpruypI0IXMxCxRx2r5nIDAcDK+i6qzGv20s0+5+7qFk0LSHmqeIqs/AUcz
 86L8fW7Kl2SACtRmf51fmMqQ6ssPRCgh8jiIc0/lafFSBhspkh3xz5jpEAXB9xmG1Hsa
 cZmSv27I4zErJRas6L6M5P4p9Qe4PP/uP9GdF+mDVHGUKMzhlNPT9QQgu21RzpuX0sjl
 kkH0j/SjxEmpvFlThn/RTaKW7bXjYOAhuB1Cj2zaesBf+LBgKdP/inJN/ES87y2sSGQr
 6P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719158074; x=1719762874;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/HpNZMdhTtHRVYCl+3FhtOeDv2R3CbG9pkvAbY/pBBY=;
 b=Uh52F/BwhIVETDF9+WuFC+W/8AmBqRPiXdqFbvnQNnsVX8WemFUE/v+MTh1jRYm6O9
 RqDkef0bAIJSgZfWQu0W2WtDWKjB27bgiCp5dmSVeKoboWzYDg9QBRMRj69Yoxbg3dSA
 BWoPtChpq6Jqg2+j142FWD+Tr1RgA8wvRlFq5GVOSmS7+M0sgcHw9oM14hG3seZ3F3x/
 kQahL+jhIjFczAR3+EhrhAkZgYM+llfd6CC4j9wpwoDGaEkoHUqHPAAdoD2eK/PpNv4U
 uW6Ouz+I+/Ol1O2gGqUSVtLbNnqay+FpnmKlSqUcfxMXCyOow3VVlm9xTEfk71oR6GAB
 k3sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV80fHtIkAwErPTqnOGqyOR5fxHYB1gwVowQy/cBSFZMfogIXBNL3CjSV+0tComNlcik5PtG3bPyoHHcjJ2CqQU4wTmGy8=
X-Gm-Message-State: AOJu0Ywn9lXKEWv/CNjmxKypAQXzueuaROFoiRmS/a87b8w2osXkanKY
 5F7FS2DeKFt+Ef8K84OQjNITifs+JcoUbxEdm2HQT8r4e2aNqWvUvZMAFH3x5kU973qpWtdU+jp
 +CErlogS4y80scEgt6d7NWV4SLjEeqFCSHWMA2gGiU3cl6PKBmTnK4A==
X-Google-Smtp-Source: AGHT+IEyeXdVF3PKhUxNO2X66Bn/gT/kPCRY8L1pyJbAbYJ0qRtx62H9Q8n9krOM17CFXW8cVHiWWUrf30cwf7yQYFU=
X-Received: by 2002:a17:90a:f18d:b0:2c7:9fee:6ea0 with SMTP id
 98e67ed59e1d1-2c86146d120mr1441405a91.32.1719158074272; Sun, 23 Jun 2024
 08:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-23-itachis@FreeBSD.org>
 <8bf36c67-070e-4e04-987b-c64b502ed62d@linaro.org>
In-Reply-To: <8bf36c67-070e-4e04-987b-c64b502ed62d@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 23 Jun 2024 09:54:23 -0600
Message-ID: <CANCZdfpX1rFFznOohEenUv3kpEg91NR04QZPd3wJnBk1SmR8fg@mail.gmail.com>
Subject: Re: [PATCH 22/23] Add set_mcontext function for ARM AArch64 in
 bsd-user
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org, 
 Ajeet Singh <itachis@freebsd.org>, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000054886f061b90ae01"
Received-SPF: none client-ip=2607:f8b0:4864:20::1032;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--00000000000054886f061b90ae01
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 4:51=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 6/17/24 11:58, Ajeet Singh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > The function copies register values from the provided target_mcontext_t
> > structure to the CPUARMState registers
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> > ---
> >   bsd-user/aarch64/signal.c | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> >
> > diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
> > index 43c886e603..13faac8ce6 100644
> > --- a/bsd-user/aarch64/signal.c
> > +++ b/bsd-user/aarch64/signal.c
> > @@ -95,3 +95,25 @@ abi_long setup_sigframe_arch(CPUARMState *env,
> abi_ulong frame_addr,
> >       return 0;
> >   }
> >
> > +/*
> > + * Compare to set_mcontext() in arm64/arm64/machdep.c
> > + * Assumes that the memory is locked if frame points to user memory.
> > + */
> > +abi_long set_mcontext(CPUARMState *regs, target_mcontext_t *mcp, int
> srflag)
> > +{
> > +    int err =3D 0, i;
> > +    const uint64_t *gr =3D mcp->mc_gpregs.gp_x;
> > +
> > +    for (i =3D 0; i < 30; i++) {
> > +        regs->xregs[i] =3D tswap64(gr[i]);
> > +    }
> > +
> > +    regs->xregs[TARGET_REG_SP] =3D tswap64(mcp->mc_gpregs.gp_sp);
> > +    regs->xregs[TARGET_REG_LR] =3D tswap64(mcp->mc_gpregs.gp_lr);
> > +    regs->pc =3D mcp->mc_gpregs.gp_elr;
>
> tswap.
>

So "regs->pc =3D tswap64(mcp->mc_gpregs.gp_elr)"  then?


> > +    pstate_write(regs, mcp->mc_gpregs.gp_spsr);
> > +
> > +    /* XXX FP? */
>
> Similarly, see target_restore_fpsimd_record.
>

Since neither this, nor the get_mcontext is written for FP on upstream yet,
can we do those as a followup commit?

Warner


>
> r~
>

--00000000000054886f061b90ae01
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 18, 2024 at 4:51=E2=80=AF=
PM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 6/17/24 11:58, Ajeet Singh wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; The function copies register values from the provided target_mcontext_=
t<br>
&gt; structure to the CPUARMState registers<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Ajeet Singh &lt;itachis@FreeBSD.org&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/aarch64/signal.c | 22 ++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 22 insertions(+)<br>
&gt; <br>
&gt; diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c<br>
&gt; index 43c886e603..13faac8ce6 100644<br>
&gt; --- a/bsd-user/aarch64/signal.c<br>
&gt; +++ b/bsd-user/aarch64/signal.c<br>
&gt; @@ -95,3 +95,25 @@ abi_long setup_sigframe_arch(CPUARMState *env, abi_=
ulong frame_addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/*<br>
&gt; + * Compare to set_mcontext() in arm64/arm64/machdep.c<br>
&gt; + * Assumes that the memory is locked if frame points to user memory.<=
br>
&gt; + */<br>
&gt; +abi_long set_mcontext(CPUARMState *regs, target_mcontext_t *mcp, int =
srflag)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int err =3D 0, i;<br>
&gt; +=C2=A0 =C2=A0 const uint64_t *gr =3D mcp-&gt;mc_gpregs.gp_x;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; 30; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 regs-&gt;xregs[i] =3D tswap64(gr[i]);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 regs-&gt;xregs[TARGET_REG_SP] =3D tswap64(mcp-&gt;mc_gp=
regs.gp_sp);<br>
&gt; +=C2=A0 =C2=A0 regs-&gt;xregs[TARGET_REG_LR] =3D tswap64(mcp-&gt;mc_gp=
regs.gp_lr);<br>
&gt; +=C2=A0 =C2=A0 regs-&gt;pc =3D mcp-&gt;mc_gpregs.gp_elr;<br>
<br>
tswap.<br></blockquote><div><br></div><div>So &quot;regs-&gt;pc =3D tswap64=
(mcp-&gt;mc_gpregs.gp_elr)&quot;=C2=A0 then?</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 pstate_write(regs, mcp-&gt;mc_gpregs.gp_spsr);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* XXX FP? */<br>
<br>
Similarly, see target_restore_fpsimd_record.<br></blockquote><div><br></div=
><div>Since neither this, nor the get_mcontext is written for FP on upstrea=
m yet, can we do those as a followup commit?</div><div><br></div><div>Warne=
r<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
r~<br>
</blockquote></div></div>

--00000000000054886f061b90ae01--

