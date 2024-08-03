Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A575CC3DA7F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2024 00:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa2GA-0002Gv-Cz; Fri, 02 Aug 2024 20:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sa2G9-0002CR-0Q
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 20:04:33 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sa2G5-0006tS-MP
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 20:04:32 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2cd48ad7f0dso6635577a91.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 17:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643467; x=1723248267;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z+j/0LIMc3gF7HcW0ApWioX1RRbqElvL0GT88qin+30=;
 b=jQo/Dmdn/VY11tTcT4cTeUvIUX1e/8rzoHrkjLc92xlrqN8bz+mS2n1NmzTsdmK1/d
 +kKTwjc7xe5MPMv5qD3FvWsi3igWxqvt+rShuXXgJrKuOEfwj8ecAFGeGj2aIkYo+8l3
 rhMDdwPZel7y0uoDQ542/zwOzLpBLNIzgM+9W1oFOZKFsqYFE0Tf23ylF12kZfE6Vlx7
 k/XeGWikew+DWVEEc8X0/3hb/PJK395+8pKtnLzt0xxYoZs/KQ7lM1ihdR3krggZKzDr
 shZ7Amr4cJC4pcKz5LmI5h1RtHaDTHmhP4GOBJa1o5jr9nEGFCkDW8yCjUVcwMtaUpaQ
 QjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643467; x=1723248267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z+j/0LIMc3gF7HcW0ApWioX1RRbqElvL0GT88qin+30=;
 b=lGW4AqKNddAP5d1sq+c8G35c2JCMb402yKHTVO/JvqIJTrriljSWIIvwT4sj8pzVub
 POjX+quiLYIGnjLhcO+6j3xxFPM7t0K2R4m26JuExzW0eKJsOU8GaRCGS0m0zEaAJJN2
 /vdwUMxiNdd94fuGXmNSIyNmMEhVk6lH3RqlWd5mSsCvXVoeTOm+pGbQUE+H++Db/iiM
 uPEe6gvQSom4VrGb6pUbYfbCG4uqX72iumkVvJOhRSc5pR+eeQpNdCBSp1PhtZZ1qhs3
 UXR/tub2LwIzkOhVTW60HHRXM2NlPym7TAWKZele3MPwuyqHVsvzKOLqDP3JwL63rH8J
 dHnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGfKIgdiMZfF4+jsW1BUz/hBHDThH6LFoAak073jR+OLe06/fBB11GnoExzOKBH2d7ppKHfrNVmjDqhKsIIOV9E7ifx9c=
X-Gm-Message-State: AOJu0YxMH5RWoS0698+kiaPmXHgc9udzMeCklERZRdTnQjsb5GOM4iCX
 dJk7SL3BQa8u1r0qmVMFNxLNYkVTH/XYjJxHlCVcgMMqRpSPR1PFMfjIna1d59ce4ap5N0B1uva
 HVQhegf/YXJBYU+zVXKdnbRQbNAZMCG9dZVc4nQ==
X-Google-Smtp-Source: AGHT+IHTD2qDWePDYdgYZMDzZTlVbyO1IfG47UowD3IAilzfexJDaTWTVciwGYbw3ULo/sLDg8ti2RIJSKskAFd2g60=
X-Received: by 2002:a17:90b:30d5:b0:2c9:9f2a:2b20 with SMTP id
 98e67ed59e1d1-2cff9488090mr6482691a91.22.1722643467033; Fri, 02 Aug 2024
 17:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-16-itachis@FreeBSD.org>
 <e336b442-cd6c-40ac-9a48-3f9356bd0c48@linaro.org>
In-Reply-To: <e336b442-cd6c-40ac-9a48-3f9356bd0c48@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 2 Aug 2024 18:04:15 -0600
Message-ID: <CANCZdfqKRVR+1p_zADs8f_3Bi4F4y2Pa4fXCNLhi2_JBkMeZrQ@mail.gmail.com>
Subject: Re: [PATCH 15/18] bsd-user: Implement RISC-V signal trampoline setup
 functions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org, 
 Mark Corbin <mark.corbin@embecsom.com>, Ajeet Singh <itachis@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000ed7e1a061ebc2fee"
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102b.google.com
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

--000000000000ed7e1a061ebc2fee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 7:46=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/2/24 18:34, Ajeet Singh wrote:
> > From: Mark Corbin <mark.corbin@embecsom.com>
> >
> > Added functions for setting up the RISC-V signal trampoline and signal
> > frame:
> >
> > 'set_sigtramp_args()': Configures the RISC-V CPU state with arguments
> > for the signal handler. It sets up the registers with the signal
> > number,pointers to the signal info and user context, the signal handler
> > address, and the signal frame pointer.
> >
> > 'setup_sigframe_arch()': Initializes the signal frame with the current
> > machine context.This function copies the context from the CPU state to
> > the signal frame, preparing it for the signal handler.
> >
> > Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
> > Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > Co-authored-by: Warner Losh <imp@bsdimp.com>
> > ---
> >   bsd-user/riscv/signal.c | 63 ++++++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 63 insertions(+)
> >   create mode 100644 bsd-user/riscv/signal.c
> >
> > diff --git a/bsd-user/riscv/signal.c b/bsd-user/riscv/signal.c
> > new file mode 100644
> > index 0000000000..005eb53cab
> > --- /dev/null
> > +++ b/bsd-user/riscv/signal.c
> > @@ -0,0 +1,63 @@
> > +/*
> > + *  RISC-V signal definitions
> > + *
> > + *  Copyright (c) 2019 Mark Corbin
> > + *
> > + *  This program is free software; you can redistribute it and/or modi=
fy
> > + *  it under the terms of the GNU General Public License as published =
by
> > + *  the Free Software Foundation; either version 2 of the License, or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public License
> > + *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + */
> > +#include "qemu/osdep.h"
> > +
> > +#include "qemu.h"
> > +
> > +/*
> > + * Compare with sendsig() in riscv/riscv/exec_machdep.c
> > + * Assumes that target stack frame memory is locked.
> > + */
> > +abi_long
> > +set_sigtramp_args(CPURISCVState *regs, int sig, struct target_sigframe
> *frame,
> > +    abi_ulong frame_addr, struct target_sigaction *ka)
> > +{
> > +    /*
> > +     * Arguments to signal handler:
> > +     *  a0 (10) =3D signal number
> > +     *  a1 (11) =3D siginfo pointer
> > +     *  a2 (12) =3D ucontext pointer
> > +     *  pc      =3D signal pointer handler
> > +     *  sp (2)  =3D sigframe pointer
> > +     *  ra (1)  =3D sigtramp at base of user stack
> > +     */
> > +
> > +     regs->gpr[10] =3D sig;
> > +     regs->gpr[11] =3D frame_addr +
> > +         offsetof(struct target_sigframe, sf_si);
> > +     regs->gpr[12] =3D frame_addr +
> > +         offsetof(struct target_sigframe, sf_uc);
>
> xA0 .. xA2
>
> > +     regs->pc =3D ka->_sa_handler;
> > +     regs->gpr[2] =3D frame_addr;
> > +     regs->gpr[1] =3D TARGET_PS_STRINGS - TARGET_SZSIGCODE;
>
> xRA, xSP.
>

So to be clear, this is 'use these constants rather than the raw numbers
for the array subscripts' right?

Warner

Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> r~
>

--000000000000ed7e1a061ebc2fee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 2, 2024 at 7:46=E2=80=AFA=
M Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ric=
hard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 8/2/24 18:34, Ajeet Singh wrote:<br>
&gt; From: Mark Corbin &lt;<a href=3D"mailto:mark.corbin@embecsom.com" targ=
et=3D"_blank">mark.corbin@embecsom.com</a>&gt;<br>
&gt; <br>
&gt; Added functions for setting up the RISC-V signal trampoline and signal=
<br>
&gt; frame:<br>
&gt; <br>
&gt; &#39;set_sigtramp_args()&#39;: Configures the RISC-V CPU state with ar=
guments<br>
&gt; for the signal handler. It sets up the registers with the signal<br>
&gt; number,pointers to the signal info and user context, the signal handle=
r<br>
&gt; address, and the signal frame pointer.<br>
&gt; <br>
&gt; &#39;setup_sigframe_arch()&#39;: Initializes the signal frame with the=
 current<br>
&gt; machine context.This function copies the context from the CPU state to=
<br>
&gt; the signal frame, preparing it for the signal handler.<br>
&gt; <br>
&gt; Signed-off-by: Mark Corbin &lt;<a href=3D"mailto:mark.corbin@embecsom.=
com" target=3D"_blank">mark.corbin@embecsom.com</a>&gt;<br>
&gt; Signed-off-by: Ajeet Singh &lt;itachis@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; Co-authored-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targ=
et=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/riscv/signal.c | 63 +++++++++++++++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 63 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 bsd-user/riscv/signal.c<br>
&gt; <br>
&gt; diff --git a/bsd-user/riscv/signal.c b/bsd-user/riscv/signal.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..005eb53cab<br>
&gt; --- /dev/null<br>
&gt; +++ b/bsd-user/riscv/signal.c<br>
&gt; @@ -0,0 +1,63 @@<br>
&gt; +/*<br>
&gt; + *=C2=A0 RISC-V signal definitions<br>
&gt; + *<br>
&gt; + *=C2=A0 Copyright (c) 2019 Mark Corbin<br>
&gt; + *<br>
&gt; + *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; + *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; + *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; + *=C2=A0 (at your option) any later version.<br>
&gt; + *<br>
&gt; + *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; + *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; + *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; + *=C2=A0 GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; + *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + */<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;qemu.h&quot;<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Compare with sendsig() in riscv/riscv/exec_machdep.c<br>
&gt; + * Assumes that target stack frame memory is locked.<br>
&gt; + */<br>
&gt; +abi_long<br>
&gt; +set_sigtramp_args(CPURISCVState *regs, int sig, struct target_sigfram=
e *frame,<br>
&gt; +=C2=A0 =C2=A0 abi_ulong frame_addr, struct target_sigaction *ka)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Arguments to signal handler:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*=C2=A0 a0 (10) =3D signal number<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*=C2=A0 a1 (11) =3D siginfo pointer<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*=C2=A0 a2 (12) =3D ucontext pointer<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*=C2=A0 pc=C2=A0 =C2=A0 =C2=A0 =3D signal pointer=
 handler<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*=C2=A0 sp (2)=C2=A0 =3D sigframe pointer<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*=C2=A0 ra (1)=C2=A0 =3D sigtramp at base of user=
 stack<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0regs-&gt;gpr[10] =3D sig;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0regs-&gt;gpr[11] =3D frame_addr +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offsetof(struct target_sigframe, sf=
_si);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0regs-&gt;gpr[12] =3D frame_addr +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offsetof(struct target_sigframe, sf=
_uc);<br>
<br>
xA0 .. xA2<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0regs-&gt;pc =3D ka-&gt;_sa_handler;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0regs-&gt;gpr[2] =3D frame_addr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0regs-&gt;gpr[1] =3D TARGET_PS_STRINGS - TARGET_SZ=
SIGCODE;<br>
<br>
xRA, xSP.<br></blockquote><div><br></div><div>So to be clear, this is &#39;=
use these constants rather than the raw numbers for the array subscripts&#3=
9; right?</div><div><br></div><div>Warner</div><div><br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Otherwise,<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
r~<br>
</blockquote></div></div>

--000000000000ed7e1a061ebc2fee--

