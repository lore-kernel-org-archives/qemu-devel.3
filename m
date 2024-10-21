Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA271D15D89
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 13:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2s3f-0001Tk-AZ; Mon, 21 Oct 2024 09:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2s3d-0001TN-Cb
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 09:02:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2s3W-0005ky-7Y
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 09:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729515760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4+jsO6Nyw+3+gKBxXjWOeGyC94AIwL87WbGkoODVgRg=;
 b=Ng7vrLd08Cl2mrDVgfsStJVUjqqfJUuYjwpPPL7jPqsYe62NQBUPO7DBSmsbqlO7VP1F+a
 ZlwsVl16AksevKmc/Oy1DdMqkCskhCGMgdOikFTq8dC3jywAs1w6KhjDJCZPmoiB5lz0SM
 2xVM9SFdP6Zve/iw+VHaFcCLmxpfeKQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-539UvIE6Nae0n6gRcxZaSA-1; Mon, 21 Oct 2024 09:02:39 -0400
X-MC-Unique: 539UvIE6Nae0n6gRcxZaSA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4317391101aso6797245e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 06:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729515757; x=1730120557;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4+jsO6Nyw+3+gKBxXjWOeGyC94AIwL87WbGkoODVgRg=;
 b=wrl+lcXPJJT7LPbo+54WcCqBqrSHuupygRLrh8gGvDTlUmSiBqS1SAhwuwliwy3R04
 QBJGLfb8xVg0HkIPUOYy7ryjMx/r7J364de1KFz5pqdeS/TizACAns24Z16xoYOXI/HW
 LSt5Y2rhmaOUMvF8c2ocgeaQ97mZ5fMIOqtnFNj0wlMfWleAIG0IAvzS6cZ8//Q0Aplq
 TLY7D8Imx1PIcgwgnquEKTUEctS/ZuVrMt0XVBDKxUr1njy0PPcvjGoOc132d/KnYaM/
 IWGhCFm/PgZiM9Trx0xNpt7UFxkaYxCE82PTPlfGS7opo0cNSDCnVHtZbnBzZ7xMNsfU
 dizw==
X-Gm-Message-State: AOJu0YxlhSEZl64I0eUO4GkzbEzRaRXd4iSACPCY4M9cK6De/AMnBsWg
 fnceZG8VP91/7NvswinVi4E2S1Yj0jgMNk9rVyp7qfVLF5BS6F/b+XCDTaBVgKz3TFUr/kdEfqp
 UiOivx2ID7/HTWcPLOsPpYFy4MdZ+fk2NC5Ukn4NwInKdhWsJrUWq3oUguz8EsV4Q3Wv96VoNXq
 lirR7fiGaX8PWJxlrEFsoNS8570rk=
X-Received: by 2002:a05:600c:5120:b0:431:5533:8f0b with SMTP id
 5b1f17b1804b1-431616a3a96mr90695825e9.32.1729515756777; 
 Mon, 21 Oct 2024 06:02:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfzZaIdnKkNViZgnV2oiRiZZEbWpBlJ24Vn89dH7H3x5+AlbMwNt8GCNA3lJs+G7j4m7Ww6F735ltDtAZ/tn8=
X-Received: by 2002:a05:600c:5120:b0:431:5533:8f0b with SMTP id
 5b1f17b1804b1-431616a3a96mr90695265e9.32.1729515756301; Mon, 21 Oct 2024
 06:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20241018144306.954716-1-pbonzini@redhat.com>
 <20241018144306.954716-9-pbonzini@redhat.com>
 <SY0P300MB10265D6A0FEDF3DE07F2220395432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfbUWFf_Mr+PR5_TZ0A6n29sZwdJ3umJFdTHgPHiVZrU4Q@mail.gmail.com>
 <SY0P300MB10265C8AF6439FEACFBDD17295432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB10265C8AF6439FEACFBDD17295432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Oct 2024 15:02:22 +0200
Message-ID: <CABgObfZBf2oQajgSBU=YhBJv9C67Ddq1J7yjSRj9UERqJhFaiw@mail.gmail.com>
Subject: Re: [PATCH 08/13] rust: build integration test for the qemu_api crate
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000049c7830624fc44ec"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000049c7830624fc44ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 21 ott 2024, 13:55 Junjie Mao <junjie.mao@hotmail.com> ha scritto:

>
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > On Mon, Oct 21, 2024 at 1:35=E2=80=AFPM Junjie Mao <junjie.mao@hotmail.=
com>
> wrote:
> >>
> >>
> >> Paolo Bonzini <pbonzini@redhat.com> writes:
> >>
> >> > Adjust the integration test to compile with a subset of QEMU object
> >> > files, and make it actually create an object of the class it defines=
.
> >> >
> >> > Follow the Rust filesystem conventions, where tests go in tests/ if
> >> > they use the library in the same way any other code would.
> >> >
> >> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> > ---
> >> >  meson.build                  | 10 ++++-
> >> >  rust/qemu-api/meson.build    | 20 +++++++--
> >> >  rust/qemu-api/src/tests.rs   | 49 ----------------------
> >> >  rust/qemu-api/tests/tests.rs | 78
> ++++++++++++++++++++++++++++++++++++
> >> >  4 files changed, 104 insertions(+), 53 deletions(-)
> >> >  delete mode 100644 rust/qemu-api/src/tests.rs
> >> >  create mode 100644 rust/qemu-api/tests/tests.rs
> >> <snip>
> >> > diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
> >> > index 42ea815fa5a..d24e0c0725e 100644
> >> > --- a/rust/qemu-api/meson.build
> >> > +++ b/rust/qemu-api/meson.build
> >> > @@ -14,11 +14,25 @@ _qemu_api_rs =3D static_library(
> >> >      '--cfg', 'MESON',
> >> >      # '--cfg', 'feature=3D"allocator"',
> >> >    ],
> >> > -  dependencies: [
> >> > -    qemu_api_macros,
> >> > -  ],
> >> >  )
> >> >
> >> >  qemu_api =3D declare_dependency(
> >> >    link_with: _qemu_api_rs,
> >> > +  dependencies: qemu_api_macros,
> >> >  )
> >> > +
> >> > +# Rust executable do not support objects, so add an intermediate
> step.
> >> > +rust_qemu_api_objs =3D static_library(
> >> > +    'rust_qemu_api_objs',
> >> > +    objects: [libqom.extract_all_objects(recursive: false),
> >> > +              libhwcore.extract_all_objects(recursive: false)])
> >> > +
> >> > +rust.test('rust-qemu-api-integration',
> >> > +     static_library(
> >> > +         'rust_qemu_api_integration',
> >> > +         'tests/tests.rs',
> >> > +         override_options: ['rust_std=3D2021', 'build.rust_std=3D20=
21'],
> >> > +         link_whole: [rust_qemu_api_objs, libqemuutil]),
> >> > +
> >> > +     dependencies: [qemu_api, qemu_api_macros],
> >> > +     suite: ['unit', 'rust'])
> >>
> >> I met the following error when trying to build the test:
> >
> > It works for me, but I'll switch to your meson.build code just to be
> safe.
>
> That's odd. What's the version of Rust and meson you have used in your
> test? On my side they're 1.82.0 and 1.5.1.
>

Nightly and 1.5.1, but I also tested with 1.63.0.

Anyhow the extra static_library() is not too nice either; so using test()
and executable() is fine by me.

Paolo

Rust.test() is still preferrable to me for its brevity, as long as it
> works.
>
> --
> Best Regards
> Junjie Mao
>
>

--00000000000049c7830624fc44ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 21 ott 2024, 13:55 Junjie Mao &lt;<a href=3D"ma=
ilto:junjie.mao@hotmail.com">junjie.mao@hotmail.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" =
rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Mon, Oct 21, 2024 at 1:35=E2=80=AFPM Junjie Mao &lt;<a href=3D"mail=
to:junjie.mao@hotmail.com" target=3D"_blank" rel=3D"noreferrer">junjie.mao@=
hotmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D=
"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; Adjust the integration test to compile with a subset of QEMU =
object<br>
&gt;&gt; &gt; files, and make it actually create an object of the class it =
defines.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Follow the Rust filesystem conventions, where tests go in tes=
ts/ if<br>
&gt;&gt; &gt; they use the library in the same way any other code would.<br=
>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@r=
edhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;=
<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 10 ++++-<br>
&gt;&gt; &gt;=C2=A0 rust/qemu-api/meson.build=C2=A0 =C2=A0 | 20 +++++++--<b=
r>
&gt;&gt; &gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://tests.rs" rel=3D"no=
referrer noreferrer" target=3D"_blank">tests.rs</a>=C2=A0 =C2=A0| 49 ------=
----------------<br>
&gt;&gt; &gt;=C2=A0 rust/qemu-api/tests/<a href=3D"http://tests.rs" rel=3D"=
noreferrer noreferrer" target=3D"_blank">tests.rs</a> | 78 ++++++++++++++++=
++++++++++++++++++++<br>
&gt;&gt; &gt;=C2=A0 4 files changed, 104 insertions(+), 53 deletions(-)<br>
&gt;&gt; &gt;=C2=A0 delete mode 100644 rust/qemu-api/src/<a href=3D"http://=
tests.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">tests.rs</a><br>
&gt;&gt; &gt;=C2=A0 create mode 100644 rust/qemu-api/tests/<a href=3D"http:=
//tests.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">tests.rs</a><br=
>
&gt;&gt; &lt;snip&gt;<br>
&gt;&gt; &gt; diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.=
build<br>
&gt;&gt; &gt; index 42ea815fa5a..d24e0c0725e 100644<br>
&gt;&gt; &gt; --- a/rust/qemu-api/meson.build<br>
&gt;&gt; &gt; +++ b/rust/qemu-api/meson.build<br>
&gt;&gt; &gt; @@ -14,11 +14,25 @@ _qemu_api_rs =3D static_library(<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &#39;--cfg&#39;, &#39;MESON&#39;,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 # &#39;--cfg&#39;, &#39;feature=3D&quot;a=
llocator&quot;&#39;,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 ],<br>
&gt;&gt; &gt; -=C2=A0 dependencies: [<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 qemu_api_macros,<br>
&gt;&gt; &gt; -=C2=A0 ],<br>
&gt;&gt; &gt;=C2=A0 )<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 qemu_api =3D declare_dependency(<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 link_with: _qemu_api_rs,<br>
&gt;&gt; &gt; +=C2=A0 dependencies: qemu_api_macros,<br>
&gt;&gt; &gt;=C2=A0 )<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +# Rust executable do not support objects, so add an intermed=
iate step.<br>
&gt;&gt; &gt; +rust_qemu_api_objs =3D static_library(<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 &#39;rust_qemu_api_objs&#39;,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 objects: [libqom.extract_all_objects(recursive=
: false),<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libhwcore.e=
xtract_all_objects(recursive: false)])<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +rust.test(&#39;rust-qemu-api-integration&#39;,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0static_library(<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;rust_qemu_api_integra=
tion&#39;,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;tests/<a href=3D"http=
://tests.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">tests.rs</a>&#=
39;,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0override_options: [&#39;ru=
st_std=3D2021&#39;, &#39;build.rust_std=3D2021&#39;],<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0link_whole: [rust_qemu_api=
_objs, libqemuutil]),<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0dependencies: [qemu_api, qemu_api_macros=
],<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0suite: [&#39;unit&#39;, &#39;rust&#39;])=
<br>
&gt;&gt;<br>
&gt;&gt; I met the following error when trying to build the test:<br>
&gt;<br>
&gt; It works for me, but I&#39;ll switch to your meson.build code just to =
be safe.<br>
<br>
That&#39;s odd. What&#39;s the version of Rust and meson you have used in y=
our<br>
test? On my side they&#39;re 1.82.0 and 1.5.1.<br></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Nightly and 1.5.1, but I also=
 tested with 1.63.0.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Any=
how the extra static_library() is not too nice either; so using test() and =
executable() is fine by me.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"=
gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Rust.test() is still preferrable to me for its brevity, as long as it<br>
works.<br>
<br>
--<br>
Best Regards<br>
Junjie Mao<br>
<br>
</blockquote></div></div></div>

--00000000000049c7830624fc44ec--


