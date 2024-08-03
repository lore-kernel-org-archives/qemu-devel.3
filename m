Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FC5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2024 00:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa2HC-0006kO-U4; Fri, 02 Aug 2024 20:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sa2H8-0006Rz-92
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 20:05:34 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sa2H5-0007tV-W3
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 20:05:34 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2cfdafdb914so2725559a91.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 17:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643530; x=1723248330;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rGL7gFaq9AjBCZ3FNbpSbx3DRAa14kb1+hBLcMNR70o=;
 b=teyhxfZ4tC5WnK9eWM7aPLUVhPvD3buDYkUfLQvk+2u5DjVYQDfIYesZuzP/UXchbP
 SPrcsf+GOOQEneyKZvmo7w8LCP1epsD2RB4k7j0mtDjax5KnQ5thxdalQEg4xIzk9sCx
 VOIVcJjqkUf63kCAmKNttaIgXXKngNbuThAEDMAzPnpBaHcycOHiCim0HcmSos5ARECK
 +N6jioAnFPbw8N6xxvqtofxvuQjtSdIA0cbOJz4a4tsjMCX04l+82n4NC9AyRLTTK2bk
 xhnO7RntFlXKA5hmtLkh+KccLnxyNYpTWp+HzxaKfNwYtDr3qCH868RmQ8xCRksgnX1V
 e7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643530; x=1723248330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rGL7gFaq9AjBCZ3FNbpSbx3DRAa14kb1+hBLcMNR70o=;
 b=QR5TbSxZT3ZoyFiioS8m8g/foOLNhughSSSw8DdK7V2dM0KYAks+9Oi+qO4y1LM1/m
 aYja6hKZyXEOoVl280bo52Yav0cyQZAQUDuUU/SJGjfl8c2puFiiGEuwikC/MfPb2R6g
 GB8ElGHSujFmeGaqj8MgLriEs06tYBAJFQDQ5jaANy2sb6yCCqlTzXYeWA03v0jeIetX
 wmkqF1CqGmsIFNEItLrwyOV1+kPsGlJunosjddVrUwLNhmvKYa3Q/QvbbXmYSbr3/qE+
 ZnMlXP0hiVDTJWOsXNY7IkYEw0JTLLcFHD58jiGIrZqt01p6w803wnSuHNcjaMjKXDZ2
 G+pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaulD94fHf+jjQ7rcdOOnQU6gkTDkgwAU8/hHcSD8aRHOZdqr9cf0t/3X4go8dyw+uA8lUBFf3PO7K63J8OrNLl/Bm//w=
X-Gm-Message-State: AOJu0YxueXLMHE1djmrX/UR4OJSSLOqSKm8OWIqidc7oFxjkdR0FqktZ
 M/7E9CwHMl4NnbbLEGgqHd6pVzVrH8DqFCoP+KRnNctjpio9SpobVlXUg6faXnYjW4JroKlQoHC
 xFACmAtC/dswg4E2FxiNsdc4Qghb0B2Z4ropdtA==
X-Google-Smtp-Source: AGHT+IFWSilvrgtMYiNLwI5VDayllompmJ9UL1ZiWEDX2ziU+vAnJRFea0hmWDly4NWqMYujKNusUB1d5THcztwG36c=
X-Received: by 2002:a17:90b:883:b0:2cb:4c06:8f11 with SMTP id
 98e67ed59e1d1-2d00e6a3b36mr1205149a91.22.1722643530218; Fri, 02 Aug 2024
 17:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-11-itachis@FreeBSD.org>
 <4cdcacde-a5f8-4365-bd6c-65e98a77eada@linaro.org>
In-Reply-To: <4cdcacde-a5f8-4365-bd6c-65e98a77eada@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 2 Aug 2024 18:05:19 -0600
Message-ID: <CANCZdfpRL7BN1LT-O0Fuw_HiPxujBw6oNqusstnOhGs6NGUh_A@mail.gmail.com>
Subject: Re: [PATCH 10/18] bsd-user: Add RISC-V thread setup and
 initialization support
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org, 
 Mark Corbin <mark.corbin@embecsom.com>, Ajeet Singh <itachis@freebsd.org>, 
 Jessica Clarke <jrtc27@jrtc27.com>, Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000b19a64061ebc335b"
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1033.google.com
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

--000000000000b19a64061ebc335b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 7:30=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/2/24 18:34, Ajeet Singh wrote:
> > From: Mark Corbin <mark.corbin@embecsom.com>
> >
> > Implemented functions for setting up and initializing threads in the
> > RISC-V architecture.
> > The 'target_thread_set_upcall' function sets up the stack pointer,
> > program counter, and function argument for new threads.
> > The 'target_thread_init' function initializes thread registers based on
> > the provided image information.
> >
> > Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
> > Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> > Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
> > Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
> > ---
> >   bsd-user/riscv/target_arch_thread.h | 47 ++++++++++++++++++++++++++++=
+
> >   1 file changed, 47 insertions(+)
> >   create mode 100644 bsd-user/riscv/target_arch_thread.h
> >
> > diff --git a/bsd-user/riscv/target_arch_thread.h
> b/bsd-user/riscv/target_arch_thread.h
> > new file mode 100644
> > index 0000000000..faabb9fb45
> > --- /dev/null
> > +++ b/bsd-user/riscv/target_arch_thread.h
> > @@ -0,0 +1,47 @@
> > +/*
> > + *  RISC-V thread support
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
> > +
> > +#ifndef TARGET_ARCH_THREAD_H
> > +#define TARGET_ARCH_THREAD_H
> > +
> > +/* Compare with cpu_set_upcall() in riscv/riscv/vm_machdep.c */
> > +static inline void target_thread_set_upcall(CPURISCVState *regs,
> > +    abi_ulong entry, abi_ulong arg, abi_ulong stack_base,
> > +    abi_ulong stack_size)
> > +{
> > +    abi_ulong sp;
> > +
> > +    sp =3D (abi_ulong)(stack_base + stack_size) & ~(16 - 1);
> > +
> > +    regs->gpr[xSP] =3D sp;
> > +    regs->pc =3D entry;
> > +    regs->gpr[xA0] =3D arg;
> > +}
> > +
> > +/* Compare with exec_setregs() in riscv/riscv/machdep.c */
>
> exec_machdep.c.
>
> > +static inline void target_thread_init(struct target_pt_regs *regs,
> > +    struct image_info *infop)
> > +{
> > +    regs->sepc =3D infop->entry;
> > +    regs->regs[xRA] =3D infop->entry;
> > +    regs->regs[10] =3D infop->start_stack;               /* a0 */
>
> xA0
>
> > +    regs->regs[xSP] =3D infop->start_stack & ~(16 - 1);
>
> ROUND_DOWN.
>

Oh, I should do a pass through our tree for rounding like this to add this
macro.

Warner


>
> r~
>

--000000000000b19a64061ebc335b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 2, 2024 at 7:30=E2=80=AFA=
M Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ric=
hard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 8/2/24 18:34, Ajeet Singh wrote:<br>
&gt; From: Mark Corbin &lt;<a href=3D"mailto:mark.corbin@embecsom.com" targ=
et=3D"_blank">mark.corbin@embecsom.com</a>&gt;<br>
&gt; <br>
&gt; Implemented functions for setting up and initializing threads in the<b=
r>
&gt; RISC-V architecture.<br>
&gt; The &#39;target_thread_set_upcall&#39; function sets up the stack poin=
ter,<br>
&gt; program counter, and function argument for new threads.<br>
&gt; The &#39;target_thread_init&#39; function initializes thread registers=
 based on<br>
&gt; the provided image information.<br>
&gt; <br>
&gt; Signed-off-by: Mark Corbin &lt;<a href=3D"mailto:mark.corbin@embecsom.=
com" target=3D"_blank">mark.corbin@embecsom.com</a>&gt;<br>
&gt; Signed-off-by: Ajeet Singh &lt;itachis@FreeBSD.org&gt;<br>
&gt; Co-authored-by: Jessica Clarke &lt;<a href=3D"mailto:jrtc27@jrtc27.com=
" target=3D"_blank">jrtc27@jrtc27.com</a>&gt;<br>
&gt; Co-authored-by: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/riscv/target_arch_thread.h | 47 +++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 47 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 bsd-user/riscv/target_arch_thread.h<br>
&gt; <br>
&gt; diff --git a/bsd-user/riscv/target_arch_thread.h b/bsd-user/riscv/targ=
et_arch_thread.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..faabb9fb45<br>
&gt; --- /dev/null<br>
&gt; +++ b/bsd-user/riscv/target_arch_thread.h<br>
&gt; @@ -0,0 +1,47 @@<br>
&gt; +/*<br>
&gt; + *=C2=A0 RISC-V thread support<br>
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
&gt; +<br>
&gt; +#ifndef TARGET_ARCH_THREAD_H<br>
&gt; +#define TARGET_ARCH_THREAD_H<br>
&gt; +<br>
&gt; +/* Compare with cpu_set_upcall() in riscv/riscv/vm_machdep.c */<br>
&gt; +static inline void target_thread_set_upcall(CPURISCVState *regs,<br>
&gt; +=C2=A0 =C2=A0 abi_ulong entry, abi_ulong arg, abi_ulong stack_base,<b=
r>
&gt; +=C2=A0 =C2=A0 abi_ulong stack_size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 abi_ulong sp;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sp =3D (abi_ulong)(stack_base + stack_size) &amp; ~(16 =
- 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 regs-&gt;gpr[xSP] =3D sp;<br>
&gt; +=C2=A0 =C2=A0 regs-&gt;pc =3D entry;<br>
&gt; +=C2=A0 =C2=A0 regs-&gt;gpr[xA0] =3D arg;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Compare with exec_setregs() in riscv/riscv/machdep.c */<br>
<br>
exec_machdep.c.<br>
<br>
&gt; +static inline void target_thread_init(struct target_pt_regs *regs,<br=
>
&gt; +=C2=A0 =C2=A0 struct image_info *infop)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 regs-&gt;sepc =3D infop-&gt;entry;<br>
&gt; +=C2=A0 =C2=A0 regs-&gt;regs[xRA] =3D infop-&gt;entry;<br>
&gt; +=C2=A0 =C2=A0 regs-&gt;regs[10] =3D infop-&gt;start_stack;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* a0 */<br>
<br>
xA0<br>
<br>
&gt; +=C2=A0 =C2=A0 regs-&gt;regs[xSP] =3D infop-&gt;start_stack &amp; ~(16=
 - 1);<br>
<br>
ROUND_DOWN.<br></blockquote><div><br></div><div>Oh, I should do a pass thro=
ugh our tree for rounding like this to add this macro.</div><div><br></div>=
<div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
r~<br>
</blockquote></div></div>

--000000000000b19a64061ebc335b--

