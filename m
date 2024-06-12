Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B39C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 08:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHJIk-0006iw-Js; Wed, 12 Jun 2024 04:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sHJIi-0006hi-OG
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:25:48 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sHJIg-0000aT-S1
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:25:48 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-441187684e3so16219941cf.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 01:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718180745; x=1718785545; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hyu6ielKMarcsWUOwFStM4bXwbsTyWxuDlTiRdxVleY=;
 b=kQ4zZVycpxAcoApIPsJSt3mvoqYUCYC22Ks5zSA4Fbzrp4sGwVkS6Q4h511sUP/IiC
 x3kNhmK/pd21mFGK7XGmDBlqQTUCAfox2FERKG6u9gX3gE5rGi95Z9CNRsZLVxjGGWet
 mmFojEGFtRTpeTNmu8z3ACphvd3YY8V3MzTPBILPo5mb/QJ85aFbv+FgOlkFsiQ1v/G2
 4SX3aLSqp1+N7u6JkUMpKYr+mLRfGVP+fEcDcneoadMnEG/IDLTknPXXSwO1MzSRBR0q
 IqCBNc6toWtajEmlGOvT+Ac8Y+Y/MnpHXhcAgR0yoP4NDHnFj9B36rrLAd++LIAoDq3U
 OLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718180745; x=1718785545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hyu6ielKMarcsWUOwFStM4bXwbsTyWxuDlTiRdxVleY=;
 b=A1q8NEIF4hy86JgEYf+rZ06ln3IbSe/W/ISv3Fe8xtjTTgBOxAm7jp3PL+Kw4m3gAP
 Zt1Bn+m9TxcxSjES6K9Tdk7g7FrLbZlvKsE+nJxKUSkPDIUJzfJfKYh2QMr2h5wtaGfx
 QrUWxD2tuyfEprXWD9MryvUPC8VCePH6CSi17+V/MNULbgXqJxcHVuZy5c0h4f2Yxp6M
 fOqqh/GB0NHspahJdLD9GNep7bmu8OSWNmmJSlvxVzjs1NRUvyahZbL+c2k6WvurUrmy
 MJcqyCSwPNBWEP96H0kEvf07wtl+xz+yhOsC0T0nll87/5w9F2bO3F1X42Mmolqbkg+l
 G7dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXfnla23o9rrWyAlKn8IXCXOrSV8kYgSrrsYAaWIih2TeYeVJyKU2372w0ubVnXLM1MOiS+GsgQx3XDsHEoaucoDg6cb4=
X-Gm-Message-State: AOJu0YzBkS/P+tAx25BUey+ZXkHGgDgxybVLMjCWlc1jOK1w/PzUGEV+
 vCLdp7SUUXX5MsxwS7VcVahi521Hj6/1Qk8Bx+qkUs5zXan9ePzEQxnatzqlaN4RmR3je6UCVkG
 RuWTgu3tOUElPpkKJ9YG/ZPhZsAc=
X-Google-Smtp-Source: AGHT+IHD5lcDcj3mCnnOqmKILq8fTpBkKfE6o4rpnx+hEtH4T4KVK9gYa9T2sFoO5OIbJz8+VdGdwAurpvsV3d1IJJM=
X-Received: by 2002:a05:622a:181e:b0:441:592c:e77c with SMTP id
 d75a77b69052e-4415abd56dbmr8770111cf.24.1718180745438; Wed, 12 Jun 2024
 01:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <0933b669c8e47e1a78d21e56881e0933ef910461.1718040303.git.manos.pitsidianakis@linaro.org>
 <20240610192517.GA350256@fedora>
 <CAAjaMXZ9bBtNyrjhUy=ypFeVYuo7ctHbaro6VCKins7-3M9e=g@mail.gmail.com>
 <CAJSP0QVvU2Vta6gcdBbDiV8a5wQf64HbYrJj_UOduhQynLyzNg@mail.gmail.com>
 <ZmlWbsG9edD4GgSZ@redhat.com>
In-Reply-To: <ZmlWbsG9edD4GgSZ@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 12 Jun 2024 12:25:33 +0400
Message-ID: <CAJ+F1CL8RTVKLCcDwyeDpYc5joYkwmz98dNnpmoB2VxSyWv0UA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/6] build-sys: Add rust feature option
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fdf05c061aad20e9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

--000000000000fdf05c061aad20e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jun 12, 2024 at 12:05=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Tue, Jun 11, 2024 at 02:25:39PM -0400, Stefan Hajnoczi wrote:
> > On Tue, 11 Jun 2024 at 13:54, Manos Pitsidianakis
> > <manos.pitsidianakis@linaro.org> wrote:
> > >
> > > On Tue, 11 Jun 2024 at 17:05, Stefan Hajnoczi <stefanha@redhat.com>
> wrote:
> > > >
> > > > On Mon, Jun 10, 2024 at 09:22:36PM +0300, Manos Pitsidianakis wrote=
:
> > > > > Add options for Rust in meson_options.txt, meson.build, configure
> to
> > > > > prepare for adding Rust code in the followup commits.
> > > > >
> > > > > `rust` is a reserved meson name, so we have to use an alternative=
.
> > > > > `with_rust` was chosen.
> > > > >
> > > > > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.or=
g
> >
> > > > > ---
> > > > > The cargo wrapper script hardcodes some rust target triples. This
> is
> > > > > just temporary.
> > > > > ---
> > > > >  .gitignore               |   2 +
> > > > >  configure                |  12 +++
> > > > >  meson.build              |  11 ++
> > > > >  meson_options.txt        |   4 +
> > > > >  scripts/cargo_wrapper.py | 211
> +++++++++++++++++++++++++++++++++++++++
> > > > >  5 files changed, 240 insertions(+)
> > > > >  create mode 100644 scripts/cargo_wrapper.py
>
> > > > > diff --git a/configure b/configure
> > > > > index 38ee257701..c195630771 100755
> > > > > --- a/configure
> > > > > +++ b/configure
>
> snip
>
> > > > > +  test "$with_rust_target_triple" !=3D "" && meson_option_add
> "-Dwith_rust_target_triple=3D$with_rust_target_triple"
>
> So the --rust-target-triple is only needed when cross compiling,
> but this is not the way we normally handle passing cross compiler
> info to meson. Instead we create a meson cross compiler options
> file containing the target info.
>
> eg for ./configure --cross-prefix=3Dx86_64-w64-mingw32-
>
> we end up creating:
>
> $ cat build/config-meson.cross
> # Automatically generated by configure - do not modify
> [properties]
> [built-in options]
> c_args =3D []
> cpp_args =3D []
> objc_args =3D []
> c_link_args =3D []
> cpp_link_args =3D []
> # environment defaults, can still be overridden on
> # the command line
> werror =3D true
> [project options]
>
> [binaries]
> c =3D ['x86_64-w64-mingw32-gcc','-m64']
> cpp =3D ['x86_64-w64-mingw32-g++','-m64']
> objc =3D ['x86_64-w64-mingw32-clang','-m64']
> ar =3D ['x86_64-w64-mingw32-ar']
> dlltool =3D ['x86_64-w64-mingw32-dlltool']
> nm =3D ['x86_64-w64-mingw32-nm']
> pkgconfig =3D ['x86_64-w64-mingw32-pkg-config']
> pkg-config =3D ['x86_64-w64-mingw32-pkg-config']
> ranlib =3D ['x86_64-w64-mingw32-ranlib']
> strip =3D ['x86_64-w64-mingw32-strip']
> widl =3D ['x86_64-w64-mingw32-widl']
> windres =3D ['x86_64-w64-mingw32-windres']
> windmc =3D ['x86_64-w64-mingw32-windmc']
> [host_machine]
> system =3D 'windows'
> cpu_family =3D 'x86_64'
> cpu =3D 'x86_64'
> endian =3D 'little'
>
>
> Should we not be passing the rust compiler target through
> this meson options file by setting something like this
>
>   rust =3D ['rustc', '--target', '$target_target_triple']
>

Agree


>
>
> Also I don't think we should be requiring --rust-target-triple
> to be passed by the user. For all the combinations we know &
> test, we should have configure "do the right thing" and set a
> suitable rust target triple based on the --cross-prefix argument
> that is given, so there is no extra burden on users cross
> compiling. Users should then only use --rust-target-triple
> if our default logic is wrong for some reason.
>
>
Then I think we would need to maintain some mapping between GNU
target-triplets and Rust. It would be convenient to allow users to
set/overwrite it though.


--=20
Marc-Andr=C3=A9 Lureau

--000000000000fdf05c061aad20e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 12, 2024 at 12:05=E2=80=
=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">be=
rrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Tue, Jun 11, 2024 at 02:25:39PM -0400, Stefan Hajnoczi =
wrote:<br>
&gt; On Tue, 11 Jun 2024 at 13:54, Manos Pitsidianakis<br>
&gt; &lt;<a href=3D"mailto:manos.pitsidianakis@linaro.org" target=3D"_blank=
">manos.pitsidianakis@linaro.org</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Tue, 11 Jun 2024 at 17:05, Stefan Hajnoczi &lt;<a href=3D"mail=
to:stefanha@redhat.com" target=3D"_blank">stefanha@redhat.com</a>&gt; wrote=
:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Mon, Jun 10, 2024 at 09:22:36PM +0300, Manos Pitsidianaki=
s wrote:<br>
&gt; &gt; &gt; &gt; Add options for Rust in meson_options.txt, meson.build,=
 configure to<br>
&gt; &gt; &gt; &gt; prepare for adding Rust code in the followup commits.<b=
r>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; `rust` is a reserved meson name, so we have to use an a=
lternative.<br>
&gt; &gt; &gt; &gt; `with_rust` was chosen.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: Manos Pitsidianakis &lt;<a href=3D"mailt=
o:manos.pitsidianakis@linaro.org" target=3D"_blank">manos.pitsidianakis@lin=
aro.org</a>&gt;<br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt; The cargo wrapper script hardcodes some rust target tri=
ples. This is<br>
&gt; &gt; &gt; &gt; just temporary.<br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt;=C2=A0 .gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +<br>
&gt; &gt; &gt; &gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 12 +++<br>
&gt; &gt; &gt; &gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 11 ++<br>
&gt; &gt; &gt; &gt;=C2=A0 meson_options.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A04 +<br>
&gt; &gt; &gt; &gt;=C2=A0 scripts/cargo_wrapper.py | 211 ++++++++++++++++++=
+++++++++++++++++++++<br>
&gt; &gt; &gt; &gt;=C2=A0 5 files changed, 240 insertions(+)<br>
&gt; &gt; &gt; &gt;=C2=A0 create mode 100644 scripts/cargo_wrapper.py<br>
<br>
&gt; &gt; &gt; &gt; diff --git a/configure b/configure<br>
&gt; &gt; &gt; &gt; index 38ee257701..c195630771 100755<br>
&gt; &gt; &gt; &gt; --- a/configure<br>
&gt; &gt; &gt; &gt; +++ b/configure<br>
<br>
snip<br>
<br>
&gt; &gt; &gt; &gt; +=C2=A0 test &quot;$with_rust_target_triple&quot; !=3D =
&quot;&quot; &amp;&amp; meson_option_add &quot;-Dwith_rust_target_triple=3D=
$with_rust_target_triple&quot;<br>
<br>
So the --rust-target-triple is only needed when cross compiling,<br>
but this is not the way we normally handle passing cross compiler<br>
info to meson. Instead we create a meson cross compiler options<br>
file containing the target info.<br>
<br>
eg for ./configure --cross-prefix=3Dx86_64-w64-mingw32-<br>
<br>
we end up creating:<br>
<br>
$ cat build/config-meson.cross <br>
# Automatically generated by configure - do not modify<br>
[properties]<br>
[built-in options]<br>
c_args =3D []<br>
cpp_args =3D []<br>
objc_args =3D []<br>
c_link_args =3D []<br>
cpp_link_args =3D []<br>
# environment defaults, can still be overridden on <br>
# the command line<br>
werror =3D true<br>
[project options]<br>
<br>
[binaries]<br>
c =3D [&#39;x86_64-w64-mingw32-gcc&#39;,&#39;-m64&#39;]<br>
cpp =3D [&#39;x86_64-w64-mingw32-g++&#39;,&#39;-m64&#39;]<br>
objc =3D [&#39;x86_64-w64-mingw32-clang&#39;,&#39;-m64&#39;]<br>
ar =3D [&#39;x86_64-w64-mingw32-ar&#39;]<br>
dlltool =3D [&#39;x86_64-w64-mingw32-dlltool&#39;]<br>
nm =3D [&#39;x86_64-w64-mingw32-nm&#39;]<br>
pkgconfig =3D [&#39;x86_64-w64-mingw32-pkg-config&#39;]<br>
pkg-config =3D [&#39;x86_64-w64-mingw32-pkg-config&#39;]<br>
ranlib =3D [&#39;x86_64-w64-mingw32-ranlib&#39;]<br>
strip =3D [&#39;x86_64-w64-mingw32-strip&#39;]<br>
widl =3D [&#39;x86_64-w64-mingw32-widl&#39;]<br>
windres =3D [&#39;x86_64-w64-mingw32-windres&#39;]<br>
windmc =3D [&#39;x86_64-w64-mingw32-windmc&#39;]<br>
[host_machine]<br>
system =3D &#39;windows&#39;<br>
cpu_family =3D &#39;x86_64&#39;<br>
cpu =3D &#39;x86_64&#39;<br>
endian =3D &#39;little&#39;<br>
<br>
<br>
Should we not be passing the rust compiler target through<br>
this meson options file by setting something like this<br>
<br>
=C2=A0 rust =3D [&#39;rustc&#39;, &#39;--target&#39;, &#39;$target_target_t=
riple&#39;]<br></blockquote><div><br></div><div>Agree</div><div>=C2=A0<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
Also I don&#39;t think we should be requiring --rust-target-triple<br>
to be passed by the user. For all the combinations we know &amp;<br>
test, we should have configure &quot;do the right thing&quot; and set a<br>
suitable rust target triple based on the --cross-prefix argument<br>
that is given, so there is no extra burden on users cross<br>
compiling. Users should then only use --rust-target-triple<br>
if our default logic is wrong for some reason.<br>
<br>
</blockquote><div><br></div><div>Then I think we would need to maintain som=
e mapping between GNU target-triplets and Rust. It would be convenient to a=
llow users to set/overwrite it though.<br></div></div><br clear=3D"all"><br=
><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" clas=
s=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000fdf05c061aad20e9--

