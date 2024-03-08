Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA19DC54798
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 00:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riNnV-0000Re-0m; Thu, 07 Mar 2024 19:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbagley@ventanamicro.com>)
 id 1riNnS-0000R0-EO
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 19:09:10 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbagley@ventanamicro.com>)
 id 1riNnP-0000QF-Vf
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 19:09:10 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a2f22bfb4e6so237992766b.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 16:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709856545; x=1710461345; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pe3TR0NwUpdg1B/TXCHJ6oHW6ND3GseWYhsREVxqMVs=;
 b=VMCrwIEjWY0fc7FwZvfD+gKZ1oPgRSIIAPpnW1PCKlVwA0b8YtFjyfqg4zwK8UKbNN
 AGMPvCB/rtOdkAoSKh/w0L1Usy/Wv3OAkuRjjiLlJ+dBFgB+qZBYKhqaEB/CfeGPs1cY
 3JDH+m+y3Dm0AiKVw8FvLGiexBpFCYJHAbwXtImyuDTacqwv5H01Ido4JhvykUQ7vHFG
 iCg7dFHY2VixSPRPAI8SzTdyLukXYUWWn3hYKyN1vq0ekZEPXlXNqirVWroL4NvOoECq
 7ypEAHPl9xuAsnRL8FhEEXUoJSS5uQs+YD+asOabDyxtUimN5JkZS503MHgwUMCro+pR
 qsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709856545; x=1710461345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pe3TR0NwUpdg1B/TXCHJ6oHW6ND3GseWYhsREVxqMVs=;
 b=Pg+CjXZJPRMs/LvkfAjzpkvwWtlr6AghasmgFNAcY91H/p1ZYM/0rXc9FIs6cvs7NE
 vHZVBvuEtUwudHq70MLkAaDiye3KOqsRVRA6hbaZwQQxFQ12xgh9If0qN3Cez2Rlxv+v
 uhDpdrs+LwbpzvMcc8an4mD/PwmRgfYOhMRurWwWcItszaChAWU7Tr8h+0v4naYowafc
 7R0xSlXm05jiDxaGsTCkpaUAb/tTl1HWpeZRuShdM4AalsW6Rl4TynngDD5KwMYDLXD9
 O2J2S6xqya5/Xy0uEHdpKar5xxDTApq7m6hcEKOYygslgV69KMZaVUxm6HvedyJstHlG
 4GCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrFrDWsukkISExeZIpCU1gWmE1ewsZzfo3R8u/uwbP4P5VG5ghlcLbFPXGVufrpZlNdayIMpXqbTJPtpU5flWWQ/LjztU=
X-Gm-Message-State: AOJu0YzdjP5Oo9BDNgFIsnUrf8Ocfg1TEXX6t0J0mT1X6/JIN2FtPHnD
 vsTnL0UaeEgFYqcTRBdYVyXVp8AgnkQiuMKFbEdQsT0cLd2fdx62FqPG7yhcqAgxTMw6CKsktjg
 WZiIoQlOh3ZUfh2PyDZYUXRrEucGv+U8dliI8Ww==
X-Google-Smtp-Source: AGHT+IHTlKbSylt3BOX+EMy7sUosgo2yeibWWdktuGUzi5ceo9yXR9oXlhe30D1pYKyGcbGOLaB6I6JwGNCdd15sqeM=
X-Received: by 2002:a17:906:c00d:b0:a45:b75d:2e6d with SMTP id
 e13-20020a170906c00d00b00a45b75d2e6dmr4878573ejz.14.1709856545019; Thu, 07
 Mar 2024 16:09:05 -0800 (PST)
MIME-Version: 1.0
References: <20230810-c9e1f2783168b48bc07a1aa2@orel>
 <mhng-a6344a0c-8820-41b5-a015-b82b261b463d@palmer-ri-x1c9>
 <20230810-e160f9edae60ded9d2606b8b@orel>
 <20230811-bc15b48d336b79d9ec1f0936@orel>
 <20230811-52e2c90dc3b91e108eb5e4e8@orel>
In-Reply-To: <20230811-52e2c90dc3b91e108eb5e4e8@orel>
From: Richard Bagley <rbagley@ventanamicro.com>
Date: Thu, 7 Mar 2024 16:08:53 -0800
Message-ID: <CAARkPA-P1U7xyLpdx+XD1M3Ji2NUfTb+88+GKUk8R2aFsOCMRw@mail.gmail.com>
Subject: Re: [PATCH] disas/riscv: Further correction to LUI disassembly
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, 
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com
Content-Type: multipart/alternative; boundary="000000000000fbaf1d06131afffe"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=rbagley@ventanamicro.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000fbaf1d06131afffe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

NACK

We have established that the change is a workaround for a bug in
the assembler.
I withdraw the merge request.

Thank you for this careful review.

On Fri, Aug 11, 2023 at 4:55=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om>
wrote:

> On Fri, Aug 11, 2023 at 10:25:52AM +0200, Andrew Jones wrote:
> > On Thu, Aug 10, 2023 at 06:27:50PM +0200, Andrew Jones wrote:
> > > On Thu, Aug 10, 2023 at 09:12:42AM -0700, Palmer Dabbelt wrote:
> > > > On Thu, 10 Aug 2023 08:31:46 PDT (-0700), ajones@ventanamicro.com
> wrote:
> > > > > On Mon, Jul 31, 2023 at 11:33:20AM -0700, Richard Bagley wrote:
> > > > > > The recent commit 36df75a0a9 corrected one aspect of LUI
> disassembly
> > > > > > by recovering the immediate argument from the result of LUI wit=
h
> a
> > > > > > shift right by 12. However, the shift right will left-fill with
> the
> > > > > > sign. By applying a mask we recover an unsigned representation
> of the
> > > > > > 20-bit field (which includes a sign bit).
> > > > > >
> > > > > > Example:
> > > > > > 0xfffff000 >> 12 =3D 0xffffffff
> > > > > > 0xfffff000 >> 12 & 0xfffff =3D 0x000fffff
> > > > > >
> > > > > > Fixes: 36df75a0a9 ("riscv/disas: Fix disas output of upper
> immediates")
> > > > > > Signed-off-by: Richard Bagley <rbagley@ventanamicro.com>
> > > > > > ---
> > > > > >  disas/riscv.c | 9 ++++++---
> > > > > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/disas/riscv.c b/disas/riscv.c
> > > > > > index 4023e3fc65..690eb4a1ac 100644
> > > > > > --- a/disas/riscv.c
> > > > > > +++ b/disas/riscv.c
> > > > > > @@ -4723,9 +4723,12 @@ static void format_inst(char *buf, size_=
t
> buflen, size_t tab, rv_decode *dec)
> > > > > >              break;
> > > > > >          case 'U':
> > > > > >              fmt++;
> > > > > > -            snprintf(tmp, sizeof(tmp), "%d", dec->imm >> 12);
> > > > > > -            append(buf, tmp, buflen);
> > > > > > -            if (*fmt =3D=3D 'o') {
> > > > > > +            if (*fmt =3D=3D 'i') {
> > > > > > +                snprintf(tmp, sizeof(tmp), "%d", dec->imm >> 1=
2
> & 0xfffff);
> > > > >
> > > > > Why are we correcting LUI's output, but still outputting
> sign-extended
> > > > > values for AUIPC?
> > > > >
> > > > > We can't assemble 'auipc a1, 0xffffffff' or 'auipc a1, -1' withou=
t
> getting
> > > > >
> > > > >  Error: lui expression not in range 0..1048575
> > > > >
> > > > > (and additionally for 0xffffffff)
> > > > >
> > > > >  Error: value of 00000ffffffff000 too large for field of 4 bytes
> at 0000000000000000
> > > > >
> > > > > either.
> > > > >
> > > > > (I see that the assembler's error messages state 'lui', but I was
> trying
> > > > > 'auipc'.)
> > > > >
> > > > > I'm using as from gnu binutils 2.40.0.20230214.
> > > > >
> > > > > (And, FWIW, I agree with Richard Henderson that these instruction=
s
> should
> > > > > accept negative values.)
> > > >
> > > > I'm kind of lost here, and you saying binutils rejects this syntax?
> If
> > > > that's the case it's probably just an oversight, can you file a bug
> in
> > > > binutils land so folks can see?
> > >
> > > Will do.
> > >
> >
> > https://sourceware.org/bugzilla/show_bug.cgi?id=3D30746
> >
>
> But, to try to bring this thread back to the patch under review. While th=
e
> binutils BZ may address our preferred way of providing immediates to the
> assembler, this patch is trying to make QEMU's output consistent with
> objdump. Since objdump always outputs long immediate values as hex, then
> it doesn't need to care about negative signs. QEMU seems to prefer
> decimal, though, and so does llvm-objdump, which outputs values for these
> instructions in the range 0..1048575. So, I guess this patch is making
> QEMU consistent with llvm-objdump.
>
> Back to making suggestions for this patch...
>
> 1. The commit message should probably say something along the lines of
>    what I just wrote in the preceding paragraph to better explain the
>    motivation.
>
> 2. Unless I'm missing something, then this patch should also address
>    AUIPC.
>
> Thanks,
> drew
>

--000000000000fbaf1d06131afffe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">NACK<br><br>We have established that the change is a worka=
round for a=C2=A0bug in the=C2=A0assembler.<br>I withdraw the=C2=A0merge re=
quest.<br><br>Thank=C2=A0you for this careful review.</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 11, 2023=
 at 4:55=E2=80=AFAM Andrew Jones &lt;<a href=3D"mailto:ajones@ventanamicro.=
com">ajones@ventanamicro.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On Fri, Aug 11, 2023 at 10:25:52AM +0200, Andre=
w Jones wrote:<br>
&gt; On Thu, Aug 10, 2023 at 06:27:50PM +0200, Andrew Jones wrote:<br>
&gt; &gt; On Thu, Aug 10, 2023 at 09:12:42AM -0700, Palmer Dabbelt wrote:<b=
r>
&gt; &gt; &gt; On Thu, 10 Aug 2023 08:31:46 PDT (-0700), <a href=3D"mailto:=
ajones@ventanamicro.com" target=3D"_blank">ajones@ventanamicro.com</a> wrot=
e:<br>
&gt; &gt; &gt; &gt; On Mon, Jul 31, 2023 at 11:33:20AM -0700, Richard Bagle=
y wrote:<br>
&gt; &gt; &gt; &gt; &gt; The recent commit 36df75a0a9 corrected one aspect =
of LUI disassembly<br>
&gt; &gt; &gt; &gt; &gt; by recovering the immediate argument from the resu=
lt of LUI with a<br>
&gt; &gt; &gt; &gt; &gt; shift right by 12. However, the shift right will l=
eft-fill with the<br>
&gt; &gt; &gt; &gt; &gt; sign. By applying a mask we recover an unsigned re=
presentation of the<br>
&gt; &gt; &gt; &gt; &gt; 20-bit field (which includes a sign bit).<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; Example:<br>
&gt; &gt; &gt; &gt; &gt; 0xfffff000 &gt;&gt; 12 =3D 0xffffffff<br>
&gt; &gt; &gt; &gt; &gt; 0xfffff000 &gt;&gt; 12 &amp; 0xfffff =3D 0x000ffff=
f<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; Fixes: 36df75a0a9 (&quot;riscv/disas: Fix disas ou=
tput of upper immediates&quot;)<br>
&gt; &gt; &gt; &gt; &gt; Signed-off-by: Richard Bagley &lt;<a href=3D"mailt=
o:rbagley@ventanamicro.com" target=3D"_blank">rbagley@ventanamicro.com</a>&=
gt;<br>
&gt; &gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 disas/riscv.c | 9 ++++++---<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 1 file changed, 6 insertions(+), 3 deletions=
(-)<br>
&gt; &gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; &gt; diff --git a/disas/riscv.c b/disas/riscv.c<br>
&gt; &gt; &gt; &gt; &gt; index 4023e3fc65..690eb4a1ac 100644<br>
&gt; &gt; &gt; &gt; &gt; --- a/disas/riscv.c<br>
&gt; &gt; &gt; &gt; &gt; +++ b/disas/riscv.c<br>
&gt; &gt; &gt; &gt; &gt; @@ -4723,9 +4723,12 @@ static void format_inst(cha=
r *buf, size_t buflen, size_t tab, rv_decode *dec)<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 br=
eak;<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;U&#39;=
:<br>
&gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fm=
t++;<br>
&gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snprint=
f(tmp, sizeof(tmp), &quot;%d&quot;, dec-&gt;imm &gt;&gt; 12);<br>
&gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 append(=
buf, tmp, buflen);<br>
&gt; &gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*fm=
t =3D=3D &#39;o&#39;) {<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*fm=
t =3D=3D &#39;i&#39;) {<br>
&gt; &gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 snprintf(tmp, sizeof(tmp), &quot;%d&quot;, dec-&gt;imm &gt;&gt; 12 &=
amp; 0xfffff);<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; Why are we correcting LUI&#39;s output, but still outpu=
tting sign-extended<br>
&gt; &gt; &gt; &gt; values for AUIPC?<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; We can&#39;t assemble &#39;auipc a1, 0xffffffff&#39; or=
 &#39;auipc a1, -1&#39; without getting<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt;=C2=A0 Error: lui expression not in range 0..1048575<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; (and additionally for 0xffffffff)<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt;=C2=A0 Error: value of 00000ffffffff000 too large for fi=
eld of 4 bytes at 0000000000000000<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; either.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; (I see that the assembler&#39;s error messages state &#=
39;lui&#39;, but I was trying<br>
&gt; &gt; &gt; &gt; &#39;auipc&#39;.)<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; I&#39;m using as from gnu binutils 2.40.0.20230214.<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; (And, FWIW, I agree with Richard Henderson that these i=
nstructions should<br>
&gt; &gt; &gt; &gt; accept negative values.)<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; I&#39;m kind of lost here, and you saying binutils rejects t=
his syntax?=C2=A0 If<br>
&gt; &gt; &gt; that&#39;s the case it&#39;s probably just an oversight, can=
 you file a bug in<br>
&gt; &gt; &gt; binutils land so folks can see?<br>
&gt; &gt; <br>
&gt; &gt; Will do.<br>
&gt; &gt;<br>
&gt; <br>
&gt; <a href=3D"https://sourceware.org/bugzilla/show_bug.cgi?id=3D30746" re=
l=3D"noreferrer" target=3D"_blank">https://sourceware.org/bugzilla/show_bug=
.cgi?id=3D30746</a><br>
&gt;<br>
<br>
But, to try to bring this thread back to the patch under review. While the<=
br>
binutils BZ may address our preferred way of providing immediates to the<br=
>
assembler, this patch is trying to make QEMU&#39;s output consistent with<b=
r>
objdump. Since objdump always outputs long immediate values as hex, then<br=
>
it doesn&#39;t need to care about negative signs. QEMU seems to prefer<br>
decimal, though, and so does llvm-objdump, which outputs values for these<b=
r>
instructions in the range 0..1048575. So, I guess this patch is making<br>
QEMU consistent with llvm-objdump.<br>
<br>
Back to making suggestions for this patch...<br>
<br>
1. The commit message should probably say something along the lines of<br>
=C2=A0 =C2=A0what I just wrote in the preceding paragraph to better explain=
 the<br>
=C2=A0 =C2=A0motivation.<br>
<br>
2. Unless I&#39;m missing something, then this patch should also address<br=
>
=C2=A0 =C2=A0AUIPC.<br>
<br>
Thanks,<br>
drew<br>
</blockquote></div>

--000000000000fbaf1d06131afffe--

