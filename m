Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD04FCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 10:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0dsy-0007Ri-MC; Mon, 22 Sep 2025 06:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1v0dsi-0007Qf-OB
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1v0dsd-0003k7-Nq
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758537280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O5gg34K1YSP/OF6z+UNbWct6AFQgrVI1wkNppcUc1tY=;
 b=KxaFYVkGeMaj8E4Ha4YyuY23IN60NyJPYzx9g51jakOKT0V3v0nw4/9FRuUs0Jh3PD4GW5
 H2OlodcDIY6FDQ0TdRaS8Cq2QYV0++byjwpCsIIa5kkezDmpQnyeUQf3Iyatf8wRknQdZL
 mzBJufNYVL00TS9al/VpDqaTdtaxQJc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-DSVo1hf-OvudEF-29FS0ww-1; Mon, 22 Sep 2025 06:34:38 -0400
X-MC-Unique: DSVo1hf-OvudEF-29FS0ww-1
X-Mimecast-MFC-AGG-ID: DSVo1hf-OvudEF-29FS0ww_1758537277
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b54d0ffd16eso3317374a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 03:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758537277; x=1759142077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O5gg34K1YSP/OF6z+UNbWct6AFQgrVI1wkNppcUc1tY=;
 b=pQKAhE1aWlIdvkYtX4CGdUagZ7UObBQa/qxC3g6GB0uT1HiryCDrG5C3MpiECGe9y9
 IRsK/JIWkMaU/rQEKxSPjV0D0jz6x+//Lutmj1HmlVwen+CchHofgkZ4kt1RoqY5sXFq
 djBDZIV6lEmGUku5xwl4uI1fmMRq3cmwZZV7hTojAFvd8PS0JBo1SpvDwrr5m63Nr1tD
 FBkdSgfmaVS5HefUbCmpjXlF1R9vwcX95G4JpSmjkuVEDQD/dat1EZl6tH3onN6GAxNX
 3BdJ5QRuZaLKstn4JJvI64JAJrDnuccPR3Hev/8NxijVtu01BD5BSP9Qo8K0HSEw/r/C
 kfeg==
X-Gm-Message-State: AOJu0Yxvcun78ae0PAK3JJzgoFMQQ/qgCmH+AjcHyUsT64ryCV1EximV
 e3qYUqRLB1EnKbe3u0U36SyN+9OmSjr4BwF1DhFRLNBDshmvldVDyVZVZaQPWTGOZJDt8QTkuTO
 TXAt7mn18Z7yp/sh7YJZQhq6IkotLua+aOuHBZ42a5qUBPdS/g8uZMHBu6zPFyYCrA4uzMGUSvv
 VSkutbhreo2HvQWNwQAbdMRZbfM8JcRYw=
X-Gm-Gg: ASbGncvL9Mv3o39JOTWBjqQzyOyz+kesFN3iC7wHNczJwqp8Fx+xykdug/lpqueGpfm
 cPLuLmPajQusG/S+fH3WYhF+i6hZbPMllKTlE8H6KuBFjFatmf221K6tmUUpc2e9sNrRgbgBpXP
 uf0TMWSrzKfvHJPDGKNwfZNXo1Y+2E2Ld49g/jM82UujkKRqOby1snKg==
X-Received: by 2002:a05:6a20:3ca1:b0:261:f6d2:e727 with SMTP id
 adf61e73a8af0-29261fc4b81mr18495536637.25.1758537277052; 
 Mon, 22 Sep 2025 03:34:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYVFS7nsWkBtvaLLJfHv800IEKlDIyRqQMFpyMCz4M66W2hYLZwu51lezcRc+Bs4ugaTiQyjru7RDaCrh+IuI=
X-Received: by 2002:a05:6a20:3ca1:b0:261:f6d2:e727 with SMTP id
 adf61e73a8af0-29261fc4b81mr18495501637.25.1758537276724; Mon, 22 Sep 2025
 03:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-20-marcandre.lureau@redhat.com>
 <aM1rj-5Rja1CXqy0@redhat.com>
In-Reply-To: <aM1rj-5Rja1CXqy0@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 22 Sep 2025 14:34:25 +0400
X-Gm-Features: AS18NWC_6iyozrjmUeWil5lQYjN6DygoC9HIHiUtHnTmi6-g-jZW8WbMOULwSbg
Message-ID: <CAMxuvay3zOzcRZBDseDw4UwqTRC5k1Qk1cRomGvVRzR2jV8U3w@mail.gmail.com>
Subject: Re: [PATCH 19/24] configure: set the meson executable suffix/ext
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 Yonggang Luo <luoyonggang@gmail.com>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000b42fa1063f615d29"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000b42fa1063f615d29
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Sep 19, 2025 at 6:41=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Fri, Sep 19, 2025 at 05:33:13PM +0400, marcandre.lureau@redhat.com
> wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>
> Please actually the reason why the change is needed. The code
> change seems related to msys2 / Windows, but our CI is already
> covering this and so what's broken ?
>

It doesn't cover --enable-rust yet:

../rust/meson.build:41:2: ERROR: Program
'/c/Users/User/qemu/build/pyvenv/bin/meson' not found or not executable


>
>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  configure | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/configure b/configure
> > index 8d84e3c5c0..7b1795ab29 100755
> > --- a/configure
> > +++ b/configure
> > @@ -1000,7 +1000,19 @@ $mkvenv ensuregroup --dir
> "${source_path}/python/wheels" \
> >  # We ignore PATH completely here: we want to use the venv's Meson
> >  # *exclusively*.
> >
> > -meson=3D"$(cd pyvenv/bin; pwd)/meson"
> > +# for msys2
> > +get_pwd() {
> > +    if pwd -W >/dev/null 2>&1; then
> > +        pwd -W
> > +    else
> > +        pwd
> > +    fi
> > +}
> > +
> > +meson=3D"$(cd pyvenv/bin; get_pwd)/meson"
> > +if [ -f "$meson$EXESUF" ]; then
> > +  meson=3D"$meson$EXESUF"
> > +fi
> >
> >  # Conditionally ensure Sphinx is installed.
> >
> > --
> > 2.51.0
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000b42fa1063f615d29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 19, 2=
025 at 6:41=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berran=
ge@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Fri, Sep 19, 2025 at 05:33:13PM +0400,=
 <a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank">marcandre=
.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
<br>
<br>
Please actually the reason why the change is needed. The code<br>
change seems related to msys2 / Windows, but our CI is already<br>
covering this and so what&#39;s broken ?<br></blockquote><div><br></div><di=
v>It doesn&#39;t cover --enable-rust yet:</div><div><br></div><div>../rust/=
meson.build:41:2: ERROR: Program &#39;/c/Users/User/qemu/build/pyvenv/bin/m=
eson&#39; not found or not executable</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
<br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br=
>
&gt; ---<br>
&gt;=C2=A0 configure | 14 +++++++++++++-<br>
&gt;=C2=A0 1 file changed, 13 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/configure b/configure<br>
&gt; index 8d84e3c5c0..7b1795ab29 100755<br>
&gt; --- a/configure<br>
&gt; +++ b/configure<br>
&gt; @@ -1000,7 +1000,19 @@ $mkvenv ensuregroup --dir &quot;${source_path}/=
python/wheels&quot; \<br>
&gt;=C2=A0 # We ignore PATH completely here: we want to use the venv&#39;s =
Meson<br>
&gt;=C2=A0 # *exclusively*.<br>
&gt;=C2=A0 <br>
&gt; -meson=3D&quot;$(cd pyvenv/bin; pwd)/meson&quot;<br>
&gt; +# for msys2<br>
&gt; +get_pwd() {<br>
&gt; +=C2=A0 =C2=A0 if pwd -W &gt;/dev/null 2&gt;&amp;1; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd -W<br>
&gt; +=C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 pwd<br>
&gt; +=C2=A0 =C2=A0 fi<br>
&gt; +}<br>
&gt; +<br>
&gt; +meson=3D&quot;$(cd pyvenv/bin; get_pwd)/meson&quot;<br>
&gt; +if [ -f &quot;$meson$EXESUF&quot; ]; then<br>
&gt; +=C2=A0 meson=3D&quot;$meson$EXESUF&quot;<br>
&gt; +fi<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # Conditionally ensure Sphinx is installed.<br>
&gt;=C2=A0 <br>
&gt; -- <br>
&gt; 2.51.0<br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div>

--000000000000b42fa1063f615d29--


