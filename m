Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD36C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 11:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJAbq-00057e-5V; Mon, 17 Jun 2024 07:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJAbn-00056N-Ny
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:33:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJAbl-0004bW-JU
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 07:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718623988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dVVRcsGnxVmhFlmtJsoWu9DDwHPe9JvumNCut2clZFM=;
 b=Ol7DQBLoheszut4wkOb940IZuZjxqYldk13uhUAknMcD5qKf5Cbhl2e8Fx8q/eazcZWW/s
 OYCyNHnFTHcFRXb/60Lq/5XSJ3Nm+Cz3QRGLFIMd6ciqd08aQIvhq9RUVmMGM0LfcfDjb3
 U4h/ssmNeiaqy/YwyvFN8M8deMTqL1Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-9OtcJq5oNHexDBFFeLTz6Q-1; Mon, 17 Jun 2024 07:33:07 -0400
X-MC-Unique: 9OtcJq5oNHexDBFFeLTz6Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35f27bfa618so2084670f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 04:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718623986; x=1719228786;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dVVRcsGnxVmhFlmtJsoWu9DDwHPe9JvumNCut2clZFM=;
 b=jMeWcr6ivmfZcFad5BZHbF6bK/NP1+V0tgI7NBraCxi+Anjt1WDX4TzLZHI5J0nIph
 xsi8PABHV0rJzTcJza9Tu+gWUQgEiXZ+QuRWP/5EmexGRuws3tS4lnFxykOzcPLqVv98
 lkg9uboF8EJ4tqjH2rnIU0ZvmsXYhQ696ajgZjiyZsGVgsjtKYpQExK5KYr8Kg4RNcQk
 9c7Ypoc9+AKElAQYNmAQpT7UqG4Z3WFS3Ps7fCoMN60/P32bhNgUXCq0ko/xUZwp/48s
 eNb2sUxdE/IJCTYEUVF2bpF6EAcCKlKnWVKQ7IoIuRDJ+Se5gvO0J6kgl71M+x6LxW2L
 jcww==
X-Gm-Message-State: AOJu0Yy7QILoeWul3wFKjT0Gt4F9qTwz6P3RiOB9FEirHVzesbfGQXc+
 zGurgcY6HW+mXysY5TzMKhTvFpw+QuyWrcfBqzPbkZjaSiiLIv6ktGooKtxN7Fk3qtfmKz1grc5
 ZcwzxKjyTttB+bFtIL1ycc4V9I4hByBKsPq8OhxPfQByiAEmqdSbQDHlSQaYhE7ZyXbGOLlaVeO
 4/mwNeCS8DnzmKT5gRK5buo5BL2l4=
X-Received: by 2002:a05:6000:542:b0:360:9d4b:5b82 with SMTP id
 ffacd0b85a97d-3609d4b5ef9mr430986f8f.47.1718623986076; 
 Mon, 17 Jun 2024 04:33:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnMMRrDP2CTQcEeR2qhUF0l8iHzSCkciWZY1ygRobZ1ClyysI2nsdpwwMQBx+haF2zh8LayPV5e440bdvbThA=
X-Received: by 2002:a05:6000:542:b0:360:9d4b:5b82 with SMTP id
 ffacd0b85a97d-3609d4b5ef9mr430970f8f.47.1718623985591; Mon, 17 Jun 2024
 04:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
 <ez270.x96k6aeu0rpw@linaro.org> <ZmnHoajecti472mi@redhat.com>
 <ezjl0.qx0tmsp6d6t@linaro.org>
 <CABgObfbGwKc0RYBcDPzNkE8HOSouFj4D15Oh7TuiKOC+D7raaA@mail.gmail.com>
 <ZmqcFf0xB9m4WkA3@redhat.com>
 <CABgObfb4+FSsadFTVg6Dc1zehQV2Vei2_kSRd5CfxsGBLPN6Eg@mail.gmail.com>
 <Zmq47yQV-sQ0hGMy@redhat.com>
 <CABgObfYaxBxc8GS3=YU=EwNLEihEoD4ikZ595P4m_KTZCAAaBw@mail.gmail.com>
 <f26b0.f15017t08v16@linaro.org>
 <CABgObfaYUCU0Tj-jj66n8AaxOpqXFKcQA-E6G0W6q3MjjwQkiQ@mail.gmail.com>
 <f7vmg.s9przvzs9y9y@linaro.org>
In-Reply-To: <f7vmg.s9przvzs9y9y@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 17 Jun 2024 13:32:54 +0200
Message-ID: <CABgObfayPDfcrFJ5ckFFms_raD25ARFEvLNhP1qLmda_rjrLfg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000002a022a061b14548c"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000002a022a061b14548c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 17 giu 2024, 10:59 Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> ha scritto:

> >qdev_define_type!(c"test-device", TestDevice);
> >impl ObjectImpl for TestDevice {}
> >impl DeviceImpl for TestDevice {}
> >
> >fn main() {
> >    let d =3D TestDevice::new();
> >    d.cold_reset();
> >}
> >
> >Of course the code makes no sense but it's a start.
>
> Let's not rush into making interfaces without the need for them arising
> first. It's easy to wander off into bikeshedding territory; case in
> point, there has been little discussion on the code of this RFC and much
> more focus on hypotheticals.
>

I see your point but I think it's important to understand the road ahead of
us.

Knowing that we can build and maintain a usable (does not have to be
perfect) interface to QOM is important, and in fact it's already useful for
the pl011 device's chardev. It's also important to play with more advanced
usage of the language to ascertain what features of the language will be
useful; for example, my current implementation uses generic associated
types which are not available on Debian Bookworm=E2=80=94it should be easy =
to
remove them but if I am wrong that's also a data point, and an important
one.

Don't get me wrong: *for this first device* only, it makes a lot of sense
to have a very C-ish implementation. It lets us sort out the build system
integration, tackle idiomatic bindings one piece at a time, and is easier
to review than Marc-Andr=C3=A9's approach of building the whole QAPI bindin=
gs.
But at the same time, I don't consider a C-ish device better just because
it's written in Rust: as things stand your code has all the disadvantages
of C and all the disadvantages of Rust. What makes it (extremely) valuable
is that your code can lead us along the path towards reaping the advantages
of Rust.

I think we're actually in a great position. We have a PoC from Marc-Andr=C3=
=A9,
plus the experience of glib-rs (see below), that shows us that our goal of
idiomatic bindings is doable; and a complementary PoC from you that will
guide us and let us reach it in little steps. The first 90% of the work is
done, now we only have to do the second 90%... :) but then we can open the
floodgates for Rust code in QEMU.

For what it's worth, in my opinion looking at glib-rs for inspiration is
> a bad idea, because that project has to support an immutable public
> interface (glib) while we do not.
>

glib-rs includes support for GObject, which was itself an inspiration for
QOM (with differences, granted).

There are a lot of libraries that we can take inspiration from: in addition
to glib-rs, zbus has an interesting approach to
serialization/deserialization for example that could inform future work on
QAPI. It's not a coincidence that these libraries integrate with more
traditional C code, because we are doing the same. Rust-vmm crates will
also become an interesting topic sooner or later.

There's more to discuss about this topic which I am open to continuing
> on IRC instead!
>

Absolutely, I will try to post code soonish and also review the build
system integration.

Thanks,

Paolo


> -- Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd
>
> >
> >One thing that would be very useful is to have an Error
> >implementation. Looking at what Marc-Andr=C3=A9 did for Error*
> >(
> https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat=
.com/20210907121943.3498701-13-marcandre.lureau@redhat.com/
> ),
> >his precise implementation relies on his code to go back and forth
> >between Rust representation, borrowed C object with Rust bindings and
> >owned C object with Rust bindings. But I think we can at least have
> >something like this:
> >
> >// qemu::Error
> >pub struct Error {
> >    msg: String,
> >    /// Appends the print string of the error to the msg if not None
> >    cause: Option<Box<dyn std::error::Error>>,
> >    location: Option<(String, u32)>
> >}
> >
> >impl std::error::Error for Error { ... }
> >
> >impl Error {
> >  ...
> >  fn into_c_error(self) -> *const bindings::Error { ... }
> >}
> >
> >// qemu::Result<T>
> >type Result<T> =3D Result<T, Error>;
> >
> >which can be implemented without too much code. This way any "bool
> >f(..., Error *)" function (example: realize :)) could be implemented
> >as returning qemu::Result<()>.
>
>

--0000000000002a022a061b14548c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 17 giu 2024, 10:59 Manos Pitsidianakis &lt;<a h=
ref=3D"mailto:manos.pitsidianakis@linaro.org" target=3D"_blank" rel=3D"nore=
ferrer">manos.pitsidianakis@linaro.org</a>&gt; ha scritto:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">&gt;qdev_define_type!(c&quot;tes=
t-device&quot;, TestDevice);<br>
&gt;impl ObjectImpl for TestDevice {}<br>
&gt;impl DeviceImpl for TestDevice {}<br>
&gt;<br>
&gt;fn main() {<br>
&gt;=C2=A0 =C2=A0 let d =3D TestDevice::new();<br>
&gt;=C2=A0 =C2=A0 d.cold_reset();<br>
&gt;}<br>
&gt;<br>
&gt;Of course the code makes no sense but it&#39;s a start.<br>
<br>
Let&#39;s not rush into making interfaces without the need for them arising=
 <br>
first. It&#39;s easy to wander off into bikeshedding territory; case in <br=
>
point, there has been little discussion on the code of this RFC and much <b=
r>
more focus on hypotheticals.<br></blockquote></div></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">I see your point but I think it&#39;s important=
 to understand the road ahead of us.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">Knowing that we can build and maintain a usable (does not have=
 to be perfect) interface to QOM is important, and in fact it&#39;s already=
 useful for the pl011 device&#39;s chardev. It&#39;s also important to play=
 with more advanced usage of the language to ascertain what features of the=
 language will be useful; for example, my current implementation uses gener=
ic associated types which are not available on Debian Bookworm=E2=80=94it s=
hould be easy to remove them but if I am wrong that&#39;s also a data point=
, and an important one.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Don&#39;t get me wrong: *for this first device* only, it makes a lot of sen=
se to have a very C-ish implementation. It lets us sort out the build syste=
m integration, tackle idiomatic bindings one piece at a time, and is easier=
 to review than Marc-Andr=C3=A9&#39;s approach of building the whole QAPI b=
indings. But at the same time, I don&#39;t consider a C-ish device better j=
ust because it&#39;s written in Rust: as things stand your code has all the=
 disadvantages of C and all the disadvantages of Rust. What makes it (extre=
mely) valuable is that your code can lead us along the path towards reaping=
 the advantages of Rust.</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>I think we&#39;re actually in a great position. We have a PoC from Marc-An=
dr=C3=A9, plus the experience of glib-rs (see below), that shows us that ou=
r goal of idiomatic bindings is doable; and a complementary PoC from you th=
at will guide us and let us reach it in little steps. The first 90% of the =
work is done, now we only have to do the second 90%... :) but then we can o=
pen the floodgates for Rust code in QEMU.</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
For what it&#39;s worth, in my opinion looking at glib-rs for inspiration i=
s <br>
a bad idea, because that project has to support an immutable public <br>
interface (glib) while we do not.<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">glib-rs includes support for GObject, whic=
h was itself an inspiration for QOM (with differences, granted).</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">There are a lot of libraries that =
we can take inspiration from: in addition to glib-rs, zbus has an interesti=
ng approach to serialization/deserialization for example that could inform =
future work on QAPI. It&#39;s not a coincidence that these libraries integr=
ate with more traditional C code, because we are doing the same. Rust-vmm c=
rates will also become an interesting topic sooner or later.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">There&#39;s more to discuss about t=
his topic which I am open to continuing <br>
on IRC instead!<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">Absolutely, I will try to post code soonish and also review =
the build system integration.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Thanks,</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-- Manos Pitsidianakis<br>
Emulation and Virtualization Engineer at Linaro Ltd<br>
<br>
&gt;<br>
&gt;One thing that would be very useful is to have an Error<br>
&gt;implementation. Looking at what Marc-Andr=C3=A9 did for Error*<br>
&gt;(<a href=3D"https://patchew.org/QEMU/20210907121943.3498701-1-marcandre=
.lureau@redhat.com/20210907121943.3498701-13-marcandre.lureau@redhat.com/" =
rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://patchew.=
org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat.com/2021090712194=
3.3498701-13-marcandre.lureau@redhat.com/</a>),<br>
&gt;his precise implementation relies on his code to go back and forth<br>
&gt;between Rust representation, borrowed C object with Rust bindings and<b=
r>
&gt;owned C object with Rust bindings. But I think we can at least have<br>
&gt;something like this:<br>
&gt;<br>
&gt;// qemu::Error<br>
&gt;pub struct Error {<br>
&gt;=C2=A0 =C2=A0 msg: String,<br>
&gt;=C2=A0 =C2=A0 /// Appends the print string of the error to the msg if n=
ot None<br>
&gt;=C2=A0 =C2=A0 cause: Option&lt;Box&lt;dyn std::error::Error&gt;&gt;,<br=
>
&gt;=C2=A0 =C2=A0 location: Option&lt;(String, u32)&gt;<br>
&gt;}<br>
&gt;<br>
&gt;impl std::error::Error for Error { ... }<br>
&gt;<br>
&gt;impl Error {<br>
&gt;=C2=A0 ...<br>
&gt;=C2=A0 fn into_c_error(self) -&gt; *const bindings::Error { ... }<br>
&gt;}<br>
&gt;<br>
&gt;// qemu::Result&lt;T&gt;<br>
&gt;type Result&lt;T&gt; =3D Result&lt;T, Error&gt;;<br>
&gt;<br>
&gt;which can be implemented without too much code. This way any &quot;bool=
<br>
&gt;f(..., Error *)&quot; function (example: realize :)) could be implement=
ed<br>
&gt;as returning qemu::Result&lt;()&gt;.<br>
<br>
</blockquote></div></div></div>

--0000000000002a022a061b14548c--


