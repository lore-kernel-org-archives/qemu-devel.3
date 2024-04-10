Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BC8CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 18:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruclo-0006au-Mq; Wed, 10 Apr 2024 14:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rucln-0006aT-Vw
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 14:34:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruclk-0001Dr-Or
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 14:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712774038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2t9crLMA4Nx2dI6at8jX2kUeuD4Ofo1fuTpmKpbtzC0=;
 b=KKKKDqfkkW7om5g//gdIyF9064/3hViIENrnXudXymOgFjFAwUPMxdVLjcxZDr0SHCj7JV
 NPOObHWg2wyJCUnVe2D5r8VtlWrbQyWiaUDZ9LEv06NbBK/hf+/JyqaCM1E+mNnoib3CDZ
 M0bz0W85BxQ1z+vLqjw4mEIPZ2frEcE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-u66Udc4pPTmT_rAXtIMZeA-1; Wed, 10 Apr 2024 14:33:57 -0400
X-MC-Unique: u66Udc4pPTmT_rAXtIMZeA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-343cfa7a9ebso3663092f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 11:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712774035; x=1713378835;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2t9crLMA4Nx2dI6at8jX2kUeuD4Ofo1fuTpmKpbtzC0=;
 b=oVpmjsQb0KY0dYq3H1w2bxN+13kh6jaSw+VDInncNiET+sWTDKUgZVaxnCvVd1ZT4M
 SYCjZZVFuhn+pf6/jGT64k+O6CP/8PgLwXEGhEA8cZH7m+sEbkQp9ud5QyJ1ePLhj+9w
 /TUzhoXuao6M07/kwLV8qI7WlCfLQ4OpJqHyvyJtXGhljinJ8YDT9O9LaAs6rruat4T6
 XUB3nGAKQNgvmdRcrFe5WYk18xZEWJ8/lWgAmLMpKhgF1HPsnDaMTlq3d7GG3EyZ2TvP
 KcqQV5GOIJjcoxsXTPW9nURdobpG6WkXSA1HyEjcOWi+CvWkuKHcKCV2GUxR301WaLAm
 c85A==
X-Gm-Message-State: AOJu0Yx1BEkHFtiw568zGs8FgY4YBAFsXJmMU0q8BQf01+5bLVCGIWln
 J2HeHz9m1Sw6suBS/3YJMkLnzXV9PWm6L+Q1fj8PibRVcJRtHEruw+5+F9MtNYriZIpjKXKhMDL
 S10t4OaUPnAxlRSleNsX8wTmXRvvijp++Uk8Mzm02OzAjUnhTT8oi7CBd90Js3Byu0dA6mJGWzP
 w3qZ0Rws2Lcl8TmcxR+hWLndmofoBRjmx/TGs=
X-Received: by 2002:adf:f24c:0:b0:343:a6fc:b2e8 with SMTP id
 b12-20020adff24c000000b00343a6fcb2e8mr2417515wrp.26.1712774035202; 
 Wed, 10 Apr 2024 11:33:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvfpNjHjmvkVv3v4nOZAoyLcC4G/Sy9MwbnpZbym+QKbuBfB1TAYvyWB3UuCM43/6ED2fxi44AS81YKnlleTc=
X-Received: by 2002:adf:f24c:0:b0:343:a6fc:b2e8 with SMTP id
 b12-20020adff24c000000b00343a6fcb2e8mr2417508wrp.26.1712774034802; Wed, 10
 Apr 2024 11:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-5-pbonzini@redhat.com>
 <ec63bef5-780e-44d0-8979-a31f7b54b07f@linaro.org>
In-Reply-To: <ec63bef5-780e-44d0-8979-a31f7b54b07f@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 10 Apr 2024 20:33:43 +0200
Message-ID: <CABgObfZugsZoVUJtujf8Sbor0DAi_C=F_EfHd2GwF6W3HuRvYg@mail.gmail.com>
Subject: Re: [PATCH for-9.1 04/19] target/i386: do not use s->tmp0 and s->tmp4
 to compute flags
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000ece3880615c247c1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000ece3880615c247c1
Content-Type: text/plain; charset="UTF-8"

Il mer 10 apr 2024, 08:35 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> On 4/9/24 06:43, Paolo Bonzini wrote:
> > Create a new temporary whenever flags have to use one, instead of using
> > s->tmp0 or s->tmp4.  NULL can now be passed as the scratch register
> > to gen_prepare_*.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   target/i386/tcg/translate.c | 54 +++++++++++++++++++++----------------
> >   1 file changed, 31 insertions(+), 23 deletions(-)
> >
> > diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> > index 197cccb6c96..debc1b27283 100644
> > --- a/target/i386/tcg/translate.c
> > +++ b/target/i386/tcg/translate.c
> > @@ -947,9 +947,9 @@ static CCPrepare gen_prepare_eflags_c(DisasContext
> *s, TCGv reg)
> >       case CC_OP_SUBB ... CC_OP_SUBQ:
> >           /* (DATA_TYPE)CC_SRCT < (DATA_TYPE)CC_SRC */
> >           size = s->cc_op - CC_OP_SUBB;
> > -        t1 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
> > -        /* If no temporary was used, be careful not to alias t1 and
> t0.  */
> > -        t0 = t1 == cpu_cc_src ? s->tmp0 : reg;
> > +        /* Be careful not to alias t1 and t0.  */
> > +        t1 = gen_ext_tl(NULL, cpu_cc_src, size, false);
> > +        t0 = (reg == t1 || !reg) ? tcg_temp_new() : reg;
> >           tcg_gen_mov_tl(t0, s->cc_srcT);
> >           gen_extu(size, t0);
>
> The tcg_temp_new, mov, and extu can be had with gen_ext_tl...
>

There's actually a lot more that can be done now that I looked more closely
at gen_ext_tl. It is fine (modulo bugs elsewhere) to just extend cc_* in
place. In fact this lets the optimizer work better, even allows (rare)
cross tb optimization because it effectively bumps CC_OP_ADD* to
target_long size, and is just as effective in removing tmp0/tmp4.

Paolo


> >           goto add_sub;
> > @@ -957,8 +957,9 @@ static CCPrepare gen_prepare_eflags_c(DisasContext
> *s, TCGv reg)
> >       case CC_OP_ADDB ... CC_OP_ADDQ:
> >           /* (DATA_TYPE)CC_DST < (DATA_TYPE)CC_SRC */
> >           size = s->cc_op - CC_OP_ADDB;
> > -        t1 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
> > -        t0 = gen_ext_tl(reg, cpu_cc_dst, size, false);
> > +        /* Be careful not to alias t1 and t0.  */
> > +        t1 = gen_ext_tl(NULL, cpu_cc_src, size, false);
> > +        t0 = gen_ext_tl(reg == t1 ? NULL : reg, cpu_cc_dst, size,
> false);
>
> ... like this.
>
> It would be helpful to update the function comments (nothing is 'compute
> ... to reg' in
> these functions).  Future cleanup, perhaps rename 'reg' to 'scratch', or
> remove the
> argument entirely where applicable.
>
> > @@ -1109,11 +1113,13 @@ static CCPrepare gen_prepare_cc(DisasContext *s,
> int b, TCGv reg)
> >           size = s->cc_op - CC_OP_SUBB;
> >           switch (jcc_op) {
> >           case JCC_BE:
> > -            tcg_gen_mov_tl(s->tmp4, s->cc_srcT);
> > -            gen_extu(size, s->tmp4);
> > -            t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
> > -            cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = s->tmp4,
> > -                               .reg2 = t0, .use_reg2 = true };
> > +            /* Be careful not to alias t1 and t0.  */
> > +            t1 = gen_ext_tl(NULL, cpu_cc_src, size, false);
> > +            t0 = (reg == t1 || !reg) ? tcg_temp_new() : reg;
> > +            tcg_gen_mov_tl(t0, s->cc_srcT);
> > +            gen_extu(size, t0);
>
> gen_ext_tl
>
> > +            cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = t0,
> > +                               .reg2 = t1, .use_reg2 = true };
> >               break;
> >
> >           case JCC_L:
> > @@ -1122,11 +1128,13 @@ static CCPrepare gen_prepare_cc(DisasContext *s,
> int b, TCGv reg)
> >           case JCC_LE:
> >               cond = TCG_COND_LE;
> >           fast_jcc_l:
> > -            tcg_gen_mov_tl(s->tmp4, s->cc_srcT);
> > -            gen_exts(size, s->tmp4);
> > -            t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, true);
> > -            cc = (CCPrepare) { .cond = cond, .reg = s->tmp4,
> > -                               .reg2 = t0, .use_reg2 = true };
> > +            /* Be careful not to alias t1 and t0.  */
> > +            t1 = gen_ext_tl(NULL, cpu_cc_src, size, true);
> > +            t0 = (reg == t1 || !reg) ? tcg_temp_new() : reg;
> > +            tcg_gen_mov_tl(t0, s->cc_srcT);
> > +            gen_exts(size, t0);
>
> gen_ext_tl
>
> With that,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~
>
>

--000000000000ece3880615c247c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 10 apr 2024, 08:35 Richard Henderson &lt;<a hre=
f=3D"mailto:richard.henderson@linaro.org" target=3D"_blank" rel=3D"noreferr=
er">richard.henderson@linaro.org</a>&gt; ha scritto:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">On 4/9/24 06:43, Paolo Bonzini wrote:<br>
&gt; Create a new temporary whenever flags have to use one, instead of usin=
g<br>
&gt; s-&gt;tmp0 or s-&gt;tmp4.=C2=A0 NULL can now be passed as the scratch =
register<br>
&gt; to gen_prepare_*.<br>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">pbonzini@redhat.com</a>&g=
t;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/i386/tcg/translate.c | 54 +++++++++++++++++++++----=
------------<br>
&gt;=C2=A0 =C2=A01 file changed, 31 insertions(+), 23 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c=
<br>
&gt; index 197cccb6c96..debc1b27283 100644<br>
&gt; --- a/target/i386/tcg/translate.c<br>
&gt; +++ b/target/i386/tcg/translate.c<br>
&gt; @@ -947,9 +947,9 @@ static CCPrepare gen_prepare_eflags_c(DisasContext=
 *s, TCGv reg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case CC_OP_SUBB ... CC_OP_SUBQ:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* (DATA_TYPE)CC_SRCT &lt; (DA=
TA_TYPE)CC_SRC */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D s-&gt;cc_op - CC_OP_S=
UBB;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 t1 =3D gen_ext_tl(s-&gt;tmp0, cpu_cc_src,=
 size, false);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If no temporary was used, be careful n=
ot to alias t1 and t0.=C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 t0 =3D t1 =3D=3D cpu_cc_src ? s-&gt;tmp0 =
: reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Be careful not to alias t1 and t0.=C2=
=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t1 =3D gen_ext_tl(NULL, cpu_cc_src, size,=
 false);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t0 =3D (reg =3D=3D t1 || !reg) ? tcg_temp=
_new() : reg;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_mov_tl(t0, s-&gt;cc_sr=
cT);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_extu(size, t0);<br>
<br>
The tcg_temp_new, mov, and extu can be had with gen_ext_tl...<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">There&#39;s ac=
tually a lot more that can be done now that I looked more closely at gen_ex=
t_tl. It is fine (modulo bugs elsewhere) to just extend cc_* in place. In f=
act this lets the optimizer work better, even allows (rare) cross tb optimi=
zation because it effectively bumps CC_OP_ADD* to target_long size, and is =
just as effective in removing tmp0/tmp4.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto add_sub;<br>
&gt; @@ -957,8 +957,9 @@ static CCPrepare gen_prepare_eflags_c(DisasContext=
 *s, TCGv reg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case CC_OP_ADDB ... CC_OP_ADDQ:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* (DATA_TYPE)CC_DST &lt; (DAT=
A_TYPE)CC_SRC */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D s-&gt;cc_op - CC_OP_A=
DDB;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 t1 =3D gen_ext_tl(s-&gt;tmp0, cpu_cc_src,=
 size, false);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 t0 =3D gen_ext_tl(reg, cpu_cc_dst, size, =
false);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Be careful not to alias t1 and t0.=C2=
=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t1 =3D gen_ext_tl(NULL, cpu_cc_src, size,=
 false);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 t0 =3D gen_ext_tl(reg =3D=3D t1 ? NULL : =
reg, cpu_cc_dst, size, false);<br>
<br>
... like this.<br>
<br>
It would be helpful to update the function comments (nothing is &#39;comput=
e ... to reg&#39; in <br>
these functions).=C2=A0 Future cleanup, perhaps rename &#39;reg&#39; to &#3=
9;scratch&#39;, or remove the <br>
argument entirely where applicable.<br>
<br>
&gt; @@ -1109,11 +1113,13 @@ static CCPrepare gen_prepare_cc(DisasContext *=
s, int b, TCGv reg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D s-&gt;cc_op - CC_OP_S=
UBB;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (jcc_op) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case JCC_BE:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(s-&gt;tmp4, =
s-&gt;cc_srcT);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_extu(size, s-&gt;tmp4);=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t0 =3D gen_ext_tl(s-&gt;tmp=
0, cpu_cc_src, size, false);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cc =3D (CCPrepare) { .cond =
=3D TCG_COND_LEU, .reg =3D s-&gt;tmp4,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.reg2 =3D t0, .use_reg2 =3D true =
};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Be careful not to alias =
t1 and t0.=C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t1 =3D gen_ext_tl(NULL, cpu=
_cc_src, size, false);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t0 =3D (reg =3D=3D t1 || !r=
eg) ? tcg_temp_new() : reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(t0, s-&gt;cc=
_srcT);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_extu(size, t0);<br>
<br>
gen_ext_tl<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cc =3D (CCPrepare) { .cond =
=3D TCG_COND_LEU, .reg =3D t0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.reg2 =3D t1, .use_reg2 =3D true =
};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case JCC_L:<br>
&gt; @@ -1122,11 +1128,13 @@ static CCPrepare gen_prepare_cc(DisasContext *=
s, int b, TCGv reg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case JCC_LE:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cond =3D TCG_CON=
D_LE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fast_jcc_l:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(s-&gt;tmp4, =
s-&gt;cc_srcT);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_exts(size, s-&gt;tmp4);=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t0 =3D gen_ext_tl(s-&gt;tmp=
0, cpu_cc_src, size, true);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cc =3D (CCPrepare) { .cond =
=3D cond, .reg =3D s-&gt;tmp4,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.reg2 =3D t0, .use_reg2 =3D true =
};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Be careful not to alias =
t1 and t0.=C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t1 =3D gen_ext_tl(NULL, cpu=
_cc_src, size, true);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t0 =3D (reg =3D=3D t1 || !r=
eg) ? tcg_temp_new() : reg;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_mov_tl(t0, s-&gt;cc=
_srcT);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_exts(size, t0);<br>
<br>
gen_ext_tl<br>
<br>
With that,<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" rel=3D"noreferrer noreferrer" target=3D"_blank">richard.henderson@l=
inaro.org</a>&gt;<br>
<br>
<br>
r~<br>
<br>
</blockquote></div></div></div>

--000000000000ece3880615c247c1--


