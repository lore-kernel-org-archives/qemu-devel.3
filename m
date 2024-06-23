Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394C6C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 20:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLTy4-00048R-Vy; Sun, 23 Jun 2024 16:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sLTy3-00047t-13
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 16:37:43 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sLTy0-0000sL-PY
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 16:37:42 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7178ba1c24bso1425046a12.3
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1719175058; x=1719779858;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ktMwDloomI99bDCj42NoHheoDO7HrCG9EISad08SDWg=;
 b=FXrTTbBNZH2FOlBhIcnhsWLP77Wr4j/MSqHXL0u5F9XSe6l/A0XDPMj8536oQ43kh9
 xPh6Sr0qcCORWvwz+ln770oSCAGZWrarxt6A8S2OJ/iVHnd2oo1cLpde/NuAOeew+7Z9
 zj2+rkfmw2SIssF/sgduSAAr1zEdDteeHcyKmXXH2EMT2eQCsZkVcSGYD670ffjCVMHD
 75HSTXZIkYNVgUdBS0I6TX5Fbzx/rabspLCZpDQ6PTh4J31c+aXykJZMWFYYKsqU/abp
 3UOxW3PWwA4o2KDtnesKlPQ2IGhyFsZoamTZ/lwKP0GI1J9KEZAQqPhhYS0CsacJOWLM
 DSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719175058; x=1719779858;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ktMwDloomI99bDCj42NoHheoDO7HrCG9EISad08SDWg=;
 b=fjmD78AYkWzZ/RGcYruAn5Nm7ojvHqCorm4R21gdZIdA8U1IJVyA2YWXuToWdH7Yfa
 GmVaunQzyXcTKLz8m83cAXfNrj98Wuyz5ZNFacEjRiEP3HuGStgaIh+8gayK4AoWBtJQ
 xp1N1BSowNVe8JJvAwG4TeONw3/tAKTLFBVWKQl/GxHkWy3TGhksRdwoZsgZjlDBUyxK
 E0fAvxQPCsZj/Wy5D+o+cWFzRGT6sb5BupVVCegDIEppNe8tJo5hPMQqyPhs8BkEsrxK
 YysnbUGgeGn1gCcB5cjRNViMNjW/TRwRiSZKjhFZbmWeOZKMyV95I7X4GUnad53N5iv6
 Q6Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCLuDKpqNZ8lkEdvh7ADwmHKHT/OUK04dbzJ9inx41pXoEwN60Wri3D+S5OHn//GUSJa13B8Svx0N2CUQCmATe1OnfdOM=
X-Gm-Message-State: AOJu0YzuSg5glwjlI1mMOF/nRF2kcgvxFGEdk5rrGqbI+35junqVkw3g
 hB7uPw7OVP+9XiEXduL0MSdw2oAEyDPlBJq9xxzsH7dqBAQe4RYgN6J58lf7l9fDsyNto8bwNTO
 gFtzjkiJ/NDgKVBn7rT2uWD0Op8aWlS0NCw0RPw==
X-Google-Smtp-Source: AGHT+IGVFCSsZT6BNYKLhjfxRwHMSqZMFkIImA+dLQulEEB9tTEA3a7GGI1kqmWGxJ7xJV1tv8YVyS/tu3jj7T2WNm4=
X-Received: by 2002:a17:903:41cd:b0:1f8:55dd:3c44 with SMTP id
 d9443c01a7336-1fa23f235b4mr40906755ad.61.1719175058534; Sun, 23 Jun 2024
 13:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-7-itachis@FreeBSD.org>
 <c6e6100e-6837-4f47-bb8c-5db5c7ba3aaa@linaro.org>
In-Reply-To: <c6e6100e-6837-4f47-bb8c-5db5c7ba3aaa@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 23 Jun 2024 14:37:27 -0600
Message-ID: <CANCZdfpG6dsnyt+J0TnSrzb+86LFj28Z48HUxdccgG90aBE4kg@mail.gmail.com>
Subject: Re: [PATCH 06/23] Add Aarch64 register handling
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org, 
 Ajeet Singh <itachis@freebsd.org>, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000abd0e5061b94a2d1"
Received-SPF: none client-ip=2607:f8b0:4864:20::52b;
 envelope-from=wlosh@bsdimp.com; helo=mail-pg1-x52b.google.com
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

--000000000000abd0e5061b94a2d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 10:35=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 6/17/24 11:57, Ajeet Singh wrote:
> > From: Stacey Son <sson@FreeBSD.org>
> >
> > Header file for managing CPU register states in
> > FreeBSD user mode
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> > ---
> >   bsd-user/aarch64/target_arch_reg.h | 56 +++++++++++++++++++++++++++++=
+
> >   1 file changed, 56 insertions(+)
> >   create mode 100644 bsd-user/aarch64/target_arch_reg.h
> >
> > diff --git a/bsd-user/aarch64/target_arch_reg.h
> b/bsd-user/aarch64/target_arch_reg.h
> > new file mode 100644
> > index 0000000000..5c7154f0c1
> > --- /dev/null
> > +++ b/bsd-user/aarch64/target_arch_reg.h
> > @@ -0,0 +1,56 @@
> > +/*
> > + *  FreeBSD arm64 register structures
> > + *
> > + *  Copyright (c) 2015 Stacey Son
> > + *  All rights reserved.
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
> > +#ifndef TARGET_ARCH_REG_H
> > +#define TARGET_ARCH_REG_H
> > +
> > +/* See sys/arm64/include/reg.h */
> > +typedef struct target_reg {
> > +    uint64_t        x[30];
> > +    uint64_t        lr;
> > +    uint64_t        sp;
> > +    uint64_t        elr;
> > +    uint64_t        spsr;
> > +} target_reg_t;
> > +
> > +typedef struct target_fpreg {
> > +    __uint128_t     fp_q[32];
>
> I'm not keen on this, though possibly it doesn't matter for hosts that
> bsd-user is
> intended to support.  Better as either Int128 or uint64_t fp_q[32][2].
>

OK. We don't use In128 anywhere today, but it's an easy change.


> What is this structure used for within qemu?
>

Yes. target_fpreg_t is used by the generic core dump code. This reserves
the proper amount of space for it. IIRC, gdb gets cranky if you don't, but
that memory is "dim" in my head, so maybe that problem was corrected ages
ago.


> Does freebsd support SVE yet?
>

Yes. But as later patches show bsd-user does not. I need to add that
support. None of our target applications seem to care, but that might just
be because the wrong answers are produced w/o a crash and there's enough
other crashes that it hasn't percolated up to the top of anybody's queue...


> It's certainly not used with this patch, so it's hard to tell, but can we
> omit it entirely
> for now?
>

It will be necessary for the core dump stuff, though I suppose it's all 0's
right now.  And core dumps are a low-priority item, but it just has to be
SOMETHING, so I propose we just change it here (and in
target_arch_signal.h) to be Int128 and then the future set of changes that
will add FP support for signals, etc will make whatever tweaks / fixes are
needed then.

Warner

--000000000000abd0e5061b94a2d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 17, 2024 at 10:35=E2=80=
=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org"=
>richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On 6/17/24 11:57, Ajeet Singh wrote:<br>
&gt; From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; <br>
&gt; Header file for managing CPU register states in<br>
&gt; FreeBSD user mode<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Ajeet Singh &lt;itachis@FreeBSD.org&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0bsd-user/aarch64/target_arch_reg.h | 56 ++++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 56 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 bsd-user/aarch64/target_arch_reg.h<br>
&gt; <br>
&gt; diff --git a/bsd-user/aarch64/target_arch_reg.h b/bsd-user/aarch64/tar=
get_arch_reg.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..5c7154f0c1<br>
&gt; --- /dev/null<br>
&gt; +++ b/bsd-user/aarch64/target_arch_reg.h<br>
&gt; @@ -0,0 +1,56 @@<br>
&gt; +/*<br>
&gt; + *=C2=A0 FreeBSD arm64 register structures<br>
&gt; + *<br>
&gt; + *=C2=A0 Copyright (c) 2015 Stacey Son<br>
&gt; + *=C2=A0 All rights reserved.<br>
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
&gt; +#ifndef TARGET_ARCH_REG_H<br>
&gt; +#define TARGET_ARCH_REG_H<br>
&gt; +<br>
&gt; +/* See sys/arm64/include/reg.h */<br>
&gt; +typedef struct target_reg {<br>
&gt; +=C2=A0 =C2=A0 uint64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 x[30];<br>
&gt; +=C2=A0 =C2=A0 uint64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 lr;<br>
&gt; +=C2=A0 =C2=A0 uint64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 sp;<br>
&gt; +=C2=A0 =C2=A0 uint64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 elr;<br>
&gt; +=C2=A0 =C2=A0 uint64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 spsr;<br>
&gt; +} target_reg_t;<br>
&gt; +<br>
&gt; +typedef struct target_fpreg {<br>
&gt; +=C2=A0 =C2=A0 __uint128_t=C2=A0 =C2=A0 =C2=A0fp_q[32];<br>
<br>
I&#39;m not keen on this, though possibly it doesn&#39;t matter for hosts t=
hat bsd-user is <br>
intended to support.=C2=A0 Better as either Int128 or uint64_t fp_q[32][2].=
<br></blockquote><div><br></div><div>OK. We don&#39;t use In128 anywhere to=
day, but it&#39;s an easy change.</div><div>=C2=A0<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
What is this structure used for within qemu?<br></blockquote><div><br></div=
><div>Yes.=C2=A0target_fpreg_t is used by the generic core dump=C2=A0code. =
This reserves the proper amount of space for it. IIRC, gdb gets cranky if y=
ou don&#39;t, but that memory is &quot;dim&quot; in my head, so maybe that =
problem was corrected ages ago.</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
Does freebsd support SVE yet?<br></blockquote><div><br></div><div>Yes. But =
as later patches show bsd-user does not. I need to add that support. None o=
f our target applications seem to care, but that might just be because the =
wrong answers are produced w/o a crash and there&#39;s enough other crashes=
 that it hasn&#39;t percolated up to the top of anybody&#39;s queue...</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
It&#39;s certainly not used with this patch, so it&#39;s hard to tell, but =
can we omit it entirely <br>
for now?<br></blockquote><div><br></div><div>It will be necessary for the c=
ore dump stuff, though I suppose it&#39;s all 0&#39;s right now.=C2=A0 And =
core dumps are a low-priority item, but it just has to be SOMETHING, so I p=
ropose we just change it here (and in target_arch_signal.h) to be Int128 an=
d then the future set of changes that will add FP support for signals, etc =
will make whatever tweaks / fixes are needed then.</div><div><br></div><div=
>Warner</div></div></div>

--000000000000abd0e5061b94a2d1--

