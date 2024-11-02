Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F335AE677F5
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 12:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7CAC-0007fD-3J; Sat, 02 Nov 2024 07:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t7CAA-0007ei-Ny
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 07:19:26 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t7CA8-0008Hu-HN
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 07:19:26 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2fb51e00c05so42054571fa.0
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 04:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730546362; x=1731151162; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RqyIQ687bBJUsbA1mSLjyoLXauao+/umKEjUw7ch3W8=;
 b=HSyJP6z8LP62EINTlQUpraioepMjqxRD5WMwkHp5RN2iu8Lj/XkO9i5KlMkHvp7AAX
 Sa4sQzAi+x7RPX0ONRo4E6azxhclyfxNSbZT3ex7toTgYY0rapvoGME6BsUbXMIvijfP
 GTRdZcuLodHcFRidhIdp2aqNeAxGd1Y7kCRSOS0f9vM/avRUK5G8yw3JmVq8pDaIBaax
 vsVPpso+ouvw8lu4OFVRE60dtzqG+OYFwUl7yGp4v7Hg7xLOXOx4O82fpBPx6DTBiWzX
 kGpUfJecJvQOc/juRJ/y80SvFqtqdLrYTbUR9RPME9UvVkUra84ja/Y/x5DsU8XIM4Vm
 SLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730546362; x=1731151162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RqyIQ687bBJUsbA1mSLjyoLXauao+/umKEjUw7ch3W8=;
 b=KHTSqA/fq7jG0f1HmU21a/WBSwxrwoIL3DSI2FxwzAjWlmJh4jB5oXJy2qMNUSrGBV
 fDqunjMLjAp0G8UF0VIorqtCRjgAwNEyEqyYFtJnWaHQiW8/dmscfe85n+Ckuj2yNi1C
 ob+giKUDl/gajmmX/HgTQ5rKQlaa5XTxjuctnK8791/PAeBru8MO9UIYES6o33bABD3A
 grW+6L4DT5AOdyhDT2YaOKqpbUdhrEo2ttnTS4AiqvzqDvl4vicPYC08BdjwldiP3Xiu
 6dRLa3JnvV0PegrwsfyVpJ7T2i/Wv7ZRnOjsddpZ9kSBbmxwh8gX96CtXTXDYG6gpBt0
 tP+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAZw2idEV3cc20UDNJQMkuO86/H2GVXOzM8qhtrKXHg+Um23GG76AGci3gpr6KHTpH+qEDcvIhsmCW@nongnu.org
X-Gm-Message-State: AOJu0YwsisSchMAOdhpIYnoyt8Jc8uXl+juAyX3WCwegcaplKODWMJc/
 ZCRwT+/MKHywhlJvLYLSvAQWoZx0t3XKTKNtJ944Z3YXjJECLBk61S+RLYO5SAmmfsg2IJCJU6P
 MbSOYssaA58+hYAgvcD2/KuaeXY4=
X-Google-Smtp-Source: AGHT+IFeTuZGzdMswtBgrcI3mXtUTAesNQRi5NZr0GQlnVpYZU3yAsqYd1g3WB4xZPUXE6I9nKz8fP3OvBUGI6ETjl0=
X-Received: by 2002:a2e:a80e:0:b0:2fb:36df:3b4 with SMTP id
 38308e7fff4ca-2fedb813d24mr50743151fa.34.1730546362194; Sat, 02 Nov 2024
 04:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20241014152408.427700-1-r.peniaev@gmail.com>
 <20241014152408.427700-8-r.peniaev@gmail.com>
 <6c2ed8a5-685e-4efb-b8d6-beba7f4e4dce@eviden.com>
In-Reply-To: <6c2ed8a5-685e-4efb-b8d6-beba7f4e4dce@eviden.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Sat, 2 Nov 2024 12:19:10 +0100
Message-ID: <CACZ9PQUq9ycErJSg2qRB3ewGb9+yv3yyhX+DyETJKijO=G2UyA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] chardev/mux: implement detach of frontends from mux
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002fa2560625ec39ef"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000002fa2560625ec39ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 22, 2024, 07:21 CLEMENT MATHIEU--DRIF <
clement.mathieu--drif@eviden.com> wrote:

>
>
> On 14/10/2024 17:24, Roman Penyaev wrote:
> > Caution: External email. Do not open attachments or click links, unless
> this email comes from a known sender and you know the content is safe.
> >
> >
> > With bitset management now it becomes feasible to implement
> > the logic of detaching frontends from multiplexer.
> >
> > Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> > Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> > Cc: qemu-devel@nongnu.org
> > ---
> >   chardev/char-fe.c          |  2 +-
> >   chardev/char-mux.c         | 21 ++++++++++++++++++---
> >   chardev/chardev-internal.h |  1 +
> >   3 files changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> > index 3b8771ca2ac4..8ac6bebb6f74 100644
> > --- a/chardev/char-fe.c
> > +++ b/chardev/char-fe.c
> > @@ -225,7 +225,7 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
> >           }
> >           if (CHARDEV_IS_MUX(b->chr)) {
> >               MuxChardev *d =3D MUX_CHARDEV(b->chr);
> > -            d->backends[b->tag] =3D NULL;
> > +            mux_chr_detach_frontend(d, b->tag);
> >           }
> >           if (del) {
> >               Object *obj =3D OBJECT(b->chr);
> > diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> > index 4fc619b2da70..bda5c45e6058 100644
> > --- a/chardev/char-mux.c
> > +++ b/chardev/char-mux.c
> > @@ -290,10 +290,10 @@ static void char_mux_finalize(Object *obj)
> >       bit =3D -1;
> >       while ((bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, bit + 1)) =
<
> MAX_MUX) {
> >           CharBackend *be =3D d->backends[bit];
> > -        if (be) {
> > -            be->chr =3D NULL;
> > -        }
> > +        be->chr =3D NULL;
> > +        d->backends[bit] =3D NULL;
> >       }
> > +    d->mux_bitset =3D 0;
> >       qemu_chr_fe_deinit(&d->chr, false);
> >   }
> >
> > @@ -332,6 +332,21 @@ bool mux_chr_attach_frontend(MuxChardev *d,
> CharBackend *b,
> >       return true;
> >   }
> >
> > +bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)
> > +{
> > +    unsigned int bit;
> > +
> > +    bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, tag);
> > +    if (bit !=3D tag) {
> > +        return false;
> > +    }
> > +
> > +    d->mux_bitset &=3D ~(1 << bit);
>
> mux_bitset is unsigned long, I think we should use 1ul here even id
> MAX_MUX is a low value
>


Sent a patch on that. Thanks.

--
Roman

--0000000000002fa2560625ec39ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi,=C2=A0</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" class=3D=
"gmail_attr">On Tue, Oct 22, 2024, 07:21 CLEMENT MATHIEU--DRIF &lt;<a href=
=3D"mailto:clement.mathieu--drif@eviden.com">clement.mathieu--drif@eviden.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
On 14/10/2024 17:24, Roman Penyaev wrote:<br>
&gt; Caution: External email. Do not open attachments or click links, unles=
s this email comes from a known sender and you know the content is safe.<br=
>
&gt; <br>
&gt; <br>
&gt; With bitset management now it becomes feasible to implement<br>
&gt; the logic of detaching frontends from multiplexer.<br>
&gt; <br>
&gt; Signed-off-by: Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com=
" target=3D"_blank" rel=3D"noreferrer">r.peniaev@gmail.com</a>&gt;<br>
&gt; Cc: &quot;Marc-Andr=C3=A9 Lureau&quot; &lt;<a href=3D"mailto:marcandre=
.lureau@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@r=
edhat.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank" rel=3D"=
noreferrer">qemu-devel@nongnu.org</a><br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0chardev/char-fe.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 +-<br>
&gt;=C2=A0 =C2=A0chardev/char-mux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 21 +=
+++++++++++++++++---<br>
&gt;=C2=A0 =C2=A0chardev/chardev-internal.h |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A03 files changed, 20 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/chardev/char-fe.c b/chardev/char-fe.c<br>
&gt; index 3b8771ca2ac4..8ac6bebb6f74 100644<br>
&gt; --- a/chardev/char-fe.c<br>
&gt; +++ b/chardev/char-fe.c<br>
&gt; @@ -225,7 +225,7 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (CHARDEV_IS_MUX(b-&gt;chr))=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MuxChardev *d =
=3D MUX_CHARDEV(b-&gt;chr);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d-&gt;backends[b-&gt;tag] =
=3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_chr_detach_frontend(d, =
b-&gt;tag);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (del) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Object *obj =3D =
OBJECT(b-&gt;chr);<br>
&gt; diff --git a/chardev/char-mux.c b/chardev/char-mux.c<br>
&gt; index 4fc619b2da70..bda5c45e6058 100644<br>
&gt; --- a/chardev/char-mux.c<br>
&gt; +++ b/chardev/char-mux.c<br>
&gt; @@ -290,10 +290,10 @@ static void char_mux_finalize(Object *obj)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bit =3D -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0while ((bit =3D find_next_bit(&amp;d-&gt;mux=
_bitset, MAX_MUX, bit + 1)) &lt; MAX_MUX) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CharBackend *be =3D d-&gt;back=
ends[bit];<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (be) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 be-&gt;chr =3D NULL;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 be-&gt;chr =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 d-&gt;backends[bit] =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 d-&gt;mux_bitset =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_chr_fe_deinit(&amp;d-&gt;chr, false);<b=
r>
&gt;=C2=A0 =C2=A0}<br>
&gt; <br>
&gt; @@ -332,6 +332,21 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharB=
ackend *b,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; <br>
&gt; +bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 unsigned int bit;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 bit =3D find_next_bit(&amp;d-&gt;mux_bitset, MAX_MUX, t=
ag);<br>
&gt; +=C2=A0 =C2=A0 if (bit !=3D tag) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 d-&gt;mux_bitset &amp;=3D ~(1 &lt;&lt; bit);<br>
<br>
mux_bitset is unsigned long, I think we should use 1ul here even id <br>
MAX_MUX is a low value<br></blockquote></div></div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Sent a patch on that. Tha=
nks.</div><div dir=3D"auto"><br></div><div dir=3D"auto">--</div><div dir=3D=
"auto">Roman</div></div>

--0000000000002fa2560625ec39ef--

