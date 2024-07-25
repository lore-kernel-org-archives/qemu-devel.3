Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63E9C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 09:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWv7b-0008E3-Ql; Thu, 25 Jul 2024 05:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWv7X-0008DE-5V
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 05:50:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWv7U-0008HV-Op
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 05:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721901042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7uXUtBqAPRIBxu9JBMHrJScKxjzQwTvQjrJlBsUt13I=;
 b=ZOZszGT7HBjUWXRWYUKrj7/kMlq3nPLJjdHAg0KHrfuQrFra8lk6MpwnpGtxujWOJ5FMzT
 kBef2c2iQ2giNM0SIFOOT3iI+JmSf7PDqpKW3zAlVH/X209+9pzkrYXDxlaOB7eVtwX0NZ
 ltrU8+0qia8z0uP3U9+Eixl8RzZFr/A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-doxyWDBGOzaysc37Wo4MKQ-1; Thu, 25 Jul 2024 05:50:41 -0400
X-MC-Unique: doxyWDBGOzaysc37Wo4MKQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-426703ac975so3842735e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 02:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721901040; x=1722505840;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7uXUtBqAPRIBxu9JBMHrJScKxjzQwTvQjrJlBsUt13I=;
 b=fcqDvKRAW0yv/R8eL2/lN3rotD/mkQsT0A324n19VRJhi/sji4dSdK8VrWMm82H8l1
 cDK+2IjKOYc1xNj3+CLHDIFLlcCHl5MXhnV7JJwvF5Fk3DVPKILRmuLfaiB6TxJTu086
 cVDJRyWWWFZPwHYur27rhpTVz8JbAGQA1bH1NDuYAjBOd3UvwTkyHQHn8cGRULKeCW3I
 mloJpvaXTSZfrd55io3uhToiB9CMW6ctNtUEr44j4puoXr32p+Z0M5NiUOx8MAQKN5Ec
 QdsHKTip/7aMD92sMugaIlZaZGDKNA9eyKXKLyl/Eyi/uX5p9SI5Wj5UP5hZNfKVz/sN
 q1tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpeh37n/VOWzF07TsnWjQU5zV9qCOPujxDaVmfS14jR4jQGGZdFPHnJDjWQ/mPYGCj3HAil8hRLFyGkPaRQrvYiLW56r0=
X-Gm-Message-State: AOJu0Yzr4fLqvStI571JlZ1wI6EferWT/qFUpYCTzhzOYyZdt5Tthpn/
 NWREeNcxCPvuhcXbFu744SisZULnJ2kjPpYw2zI5QJnhPfZiHV/SZQV6e+P15R5bAvrJYNLVJ1l
 00mx0lk5zQmnUTSUoX+EWnpMP3eCXKJ4u4HmxLVJRGMtFHFI70lOZfFeNF9aL4qJXJv1ujWG3O9
 Ef3+85dm+oW2ZyR3apxpzQy5HcLlM=
X-Received: by 2002:a05:600c:138b:b0:426:5b19:d2b3 with SMTP id
 5b1f17b1804b1-427f9a20aecmr33974915e9.14.1721901039785; 
 Thu, 25 Jul 2024 02:50:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY5lQG+oW7K2oa14Y2IohmuLbcJ7VFmYx/NyHWP11cWA05XfskORoSGK13ka0SceIrry8ZXc6tMGKzpMXzVs8=
X-Received: by 2002:a05:600c:138b:b0:426:5b19:d2b3 with SMTP id
 5b1f17b1804b1-427f9a20aecmr33974565e9.14.1721901039120; Thu, 25 Jul 2024
 02:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <bc27a983-f0b7-4803-96f7-060a4a331348@redhat.com>
 <h4gxy.dr366knvycy@linaro.org>
 <CABgObfZOqBogWQtzfghjKMsW-J_sp-iL5dt7mmYnvE5eQb9G5w@mail.gmail.com>
 <h61ku.ipxyjqsxu75@linaro.org>
In-Reply-To: <h61ku.ipxyjqsxu75@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 Jul 2024 11:50:26 +0200
Message-ID: <CABgObfa-dxDD_oVGu8PrQffVhvP=MFifUUTinC-brzTnqdkK0A@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/8] Add Rust support, implement ARM PL011
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qeemu-devel@nongnu.org, qemu-devel <qemu-devel@nongnu.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c68a71061e0f539a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
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

--000000000000c68a71061e0f539a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 25 lug 2024, 08:19 Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> ha scritto:

> >(before the call to qemu_chr_fe_accept_input):
> >// TODO: this causes a callback that creates another "&mut self".
> >// This is forbidden by Rust aliasing rules and has to be fixed
> >// using interior mutability.
>
> You mean that we can have a call stack that looks something like...
>
> <qemu code>
> |_ pl011_read
>   |_ PL011State::read()
>      |_ qemu_chr_fe_accept_input()
>       |_ pl011_read
>         |_ PL011State::read()
>
> If I understand correctly, this does not create another "&mut self",
> because a mutable reference of self is passed to
> qemu_chr_fe_accept_input(), and only exists until it returns.
>

Unfortunately that's a *mut, not a &mut. A &mut must be unique, so the cast
in pl011_read() is undefined behavior.

In any case, I agree that these subtleties must be examined thoroughly
> in general. In this case though PL011State has only Copy fields and no
> side effects when dropped. This means that adding interior mutability
> e.g. with Cell would have exactly the same behavior.
>

If you add interior mutability you can operate on a &self; and then
creating the &mut (via either Cell or RefCell) from the callback is legal.

But your bringing it up makes me wonder whether we can detect any bad
> behaviors with miri... It does not play well with FFI boundaries but
> it's possible to mock them in some cases. I will look into the two TODOs
> you mention and also if it's possible to verify the correct behavior
> whenever possible!
>

The most robust way is to write proper bindings to QEMU APIs that enforce
use of shared references. That will take time; but we'll get there, for now
it's important just to point out the problem.


> >> >=E2=9D=8C a trait to generate all-zero structs without having to type=
 "unsafe {
> >> >MaybeUninit::zeroed().assume_init() }"
> >>
> >> Traits cannot have const fns at the moment (traits cannot have
> >> type-level effects like const or async but it's WIP to get them into
> >> rustc), so this cannot be used for statics and consts.
> >
> >Ah, I see. Anyhow, I've been looking at the Linux kernel's pinned-init
> >crate (https://rust-for-linux.com/pinned-init) and it provides a
> >Zeroable macro including #[derive] support. So that has gone lower in
> >my priority.
> >
> >> >=E2=9D=8C I'd like to use ctor instead of non-portable linker magic,
> >>
> >> The linker sections are pretty much standard and in fact ctor uses the
> >> same linker attributes. Would writing our own constructor macro be a
> >> solution for you? My reasoning is that 1) we support our own specific
> >> platforms and it's better for portability to reflect that in our sourc=
e
> >> tree and 2) it avoids the external dependency, linker sections do not
> >> change so any ctor update would be in the API or adding more platform
> >> support,  not fixes in what we target.
> >
> >I'd still like to give someone else the burden. :) Writing our own
> >constructor macro would be more work for little gain.
>
> Well, it's just that I personally don't view adding __attribute__
> manually in only two places is a burden but I've no strong preference
> over it.
>
> I'm looking at the ctor dependencies and they are a few:
>
> https://github.com/mmastrac/rust-ctor/blob/cc3ab9160ed9dc3bdf20d735352b51=
9abc2913e9/Cargo.lock
>
> Do you perhaps agree with adding a FIXME comment to replace the linker
> attributes with ctor when we get the cargo dependency story in meson
> sorted out?
>

Yes, that's fine.

Paolo

Manos
>
>

--000000000000c68a71061e0f539a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 25 lug 2024, 08:19 Manos Pitsidianakis &lt;<a h=
ref=3D"mailto:manos.pitsidianakis@linaro.org">manos.pitsidianakis@linaro.or=
g</a>&gt; ha scritto:</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
&gt;(before the call to qemu_chr_fe_accept_input):<br>
&gt;// TODO: this causes a callback that creates another &quot;&amp;mut sel=
f&quot;.<br>
&gt;// This is forbidden by Rust aliasing rules and has to be fixed<br>
&gt;// using interior mutability.<br>
<br>
You mean that we can have a call stack that looks something like...<br>
<br>
&lt;qemu code&gt;<br>
|_ pl011_read<br>
=C2=A0 |_ PL011State::read()<br>
=C2=A0 =C2=A0 =C2=A0|_ qemu_chr_fe_accept_input()<br>
=C2=A0 =C2=A0 =C2=A0 |_ pl011_read<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |_ PL011State::read()<br>
<br>
If I understand correctly, this does not create another &quot;&amp;mut self=
&quot;, <br>
because a mutable reference of self is passed to <br>
qemu_chr_fe_accept_input(), and only exists until it returns.<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Unfortunately =
that&#39;s a *mut, not a &amp;mut. A &amp;mut must be unique, so the cast i=
n pl011_read() is undefined behavior.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
In any case, I agree that these subtleties must be examined thoroughly <br>
in general. In this case though PL011State has only Copy fields and no <br>
side effects when dropped. This means that adding interior mutability <br>
e.g. with Cell would have exactly the same behavior.<br></blockquote></div>=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">If you add interior mut=
ability you can operate on a &amp;self; and then creating the &amp;mut (via=
 either Cell or RefCell) from the callback is legal.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
But your bringing it up makes me wonder whether we can detect any bad <br>
behaviors with miri... It does not play well with FFI boundaries but <br>
it&#39;s possible to mock them in some cases. I will look into the two TODO=
s <br>
you mention and also if it&#39;s possible to verify the correct behavior <b=
r>
whenever possible!<br></blockquote></div></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">The most robust way is to write proper bindings to QEMU A=
PIs that enforce use of shared references. That will take time; but we&#39;=
ll get there, for now it&#39;s important just to point out the problem.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><br>
&gt;&gt; &gt;=E2=9D=8C a trait to generate all-zero structs without having =
to type &quot;unsafe {<br>
&gt;&gt; &gt;MaybeUninit::zeroed().assume_init() }&quot;<br>
&gt;&gt;<br>
&gt;&gt; Traits cannot have const fns at the moment (traits cannot have<br>
&gt;&gt; type-level effects like const or async but it&#39;s WIP to get the=
m into<br>
&gt;&gt; rustc), so this cannot be used for statics and consts.<br>
&gt;<br>
&gt;Ah, I see. Anyhow, I&#39;ve been looking at the Linux kernel&#39;s pinn=
ed-init<br>
&gt;crate (<a href=3D"https://rust-for-linux.com/pinned-init" rel=3D"norefe=
rrer noreferrer" target=3D"_blank">https://rust-for-linux.com/pinned-init</=
a>) and it provides a<br>
&gt;Zeroable macro including #[derive] support. So that has gone lower in<b=
r>
&gt;my priority.<br>
&gt;<br>
&gt;&gt; &gt;=E2=9D=8C I&#39;d like to use ctor instead of non-portable lin=
ker magic,<br>
&gt;&gt;<br>
&gt;&gt; The linker sections are pretty much standard and in fact ctor uses=
 the<br>
&gt;&gt; same linker attributes. Would writing our own constructor macro be=
 a<br>
&gt;&gt; solution for you? My reasoning is that 1) we support our own speci=
fic<br>
&gt;&gt; platforms and it&#39;s better for portability to reflect that in o=
ur source<br>
&gt;&gt; tree and 2) it avoids the external dependency, linker sections do =
not<br>
&gt;&gt; change so any ctor update would be in the API or adding more platf=
orm<br>
&gt;&gt; support,=C2=A0 not fixes in what we target.<br>
&gt;<br>
&gt;I&#39;d still like to give someone else the burden. :) Writing our own<=
br>
&gt;constructor macro would be more work for little gain.<br>
<br>
Well, it&#39;s just that I personally don&#39;t view adding __attribute__ <=
br>
manually in only two places is a burden but I&#39;ve no strong preference <=
br>
over it.<br>
<br>
I&#39;m looking at the ctor dependencies and they are a few:<br>
<a href=3D"https://github.com/mmastrac/rust-ctor/blob/cc3ab9160ed9dc3bdf20d=
735352b519abc2913e9/Cargo.lock" rel=3D"noreferrer noreferrer" target=3D"_bl=
ank">https://github.com/mmastrac/rust-ctor/blob/cc3ab9160ed9dc3bdf20d735352=
b519abc2913e9/Cargo.lock</a><br>
<br>
Do you perhaps agree with adding a FIXME comment to replace the linker <br>
attributes with ctor when we get the cargo dependency story in meson <br>
sorted out?<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Yes, that&#39;s fine.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Manos<br>
<br>
</blockquote></div></div></div>

--000000000000c68a71061e0f539a--


