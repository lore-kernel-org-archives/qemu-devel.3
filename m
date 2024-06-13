Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5F5C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 07:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHfKR-0003Gg-HF; Thu, 13 Jun 2024 03:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHfKO-0003GE-GL
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 03:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHfKM-0006Yl-Mc
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 03:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718265417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EHwD3GJFa0J/OAsapLCctRAIBbT4EIATDoElVVRrD9c=;
 b=F5rhWsZPz4EAe/l9ITEz/p24gUk7QOq8qPHA7fk79gNV9KqVw7/3NdT3kyecwtmXv3cOoO
 WzatucXjHNaubPsRXsXDlew3XgYR+JgkO61AkpBFrSlMSL4ITlk6jmx13ObM25w3zkhiL8
 99Z/9eXVzAGXGKrONDo2eIbYVWh6NyA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-zDBhtd4NMKirA-z5s_9CBw-1; Thu, 13 Jun 2024 03:56:54 -0400
X-MC-Unique: zDBhtd4NMKirA-z5s_9CBw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42183fdb37cso7339195e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 00:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718265413; x=1718870213;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EHwD3GJFa0J/OAsapLCctRAIBbT4EIATDoElVVRrD9c=;
 b=nIDqBeQwBIsgZ1VxSyP72v/5sQznDjEIQefzwzM2+O+kZQ65snXEBwazKEkP8HvPCT
 xm7I5BMuJJTM9a+Z1wOeMtJd3VCp+W3AQBmaKMFz0B86pUBYHeDxaY53sbH+rU1FIfkA
 bz5t0l40NbZcRAKYbtGhQ8T4xAxqHLL+ho940ZCn71NOoQiaBJzmsr62WBh+vSf6Jn7R
 ziU/PdAwttvjFgBWybwRuZOuh6rtE5v++mffPea/WkUnK5kT2SZyLNHJMnls96LW6MnM
 eio+h/kuO0vFJegupbQGF+6jukio0sVv5VCmPA2pxsdjy4KjR6igfx1C0vyhGT4cim2c
 Oyjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG7BPPICgO6IU9Rn79ONhv/Ut8D+cSd5PognK3rCSWc1QV3xUjavuSWg8GzUuXW2iIEuLqPLr+fvN0YpKg12OG1q1Wpr8=
X-Gm-Message-State: AOJu0YzakRW9O3j5J09aeeSJEENR+Wxzl9IzNA7r4Yl/WwC/kJ+1a1YI
 NtsOGIpeqBT9Jw33of7BaRgTLYqX8S3Nd3wKgGe1HxKds7pPcjee60RVuVju6jOSgJtmtAgDLRq
 ajDsnvpUGrMZsj5h4JdCKrFJ5okzYT7TjHtj9sQ3Fz6i2SLASdAQpqeahdgEffEbO/SVcEmWjx8
 BhvbSkatkGyutvGBrXOaDFx0neSuE=
X-Received: by 2002:a05:6000:18e:b0:35f:d70:6193 with SMTP id
 ffacd0b85a97d-35fdf7adcc7mr2838802f8f.41.1718265413149; 
 Thu, 13 Jun 2024 00:56:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEfKpwTxMM632hime6+/CCHlf1EMZ8z++ZumSlURwf0gJs5lCFGyP+m5TzyovwGz/gnUz7zWCdq2IjzxeNDSo=
X-Received: by 2002:a05:6000:18e:b0:35f:d70:6193 with SMTP id
 ffacd0b85a97d-35fdf7adcc7mr2838788f8f.41.1718265412815; Thu, 13 Jun 2024
 00:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
 <ez270.x96k6aeu0rpw@linaro.org> <ZmnHoajecti472mi@redhat.com>
 <ezjl0.qx0tmsp6d6t@linaro.org>
 <CABgObfbGwKc0RYBcDPzNkE8HOSouFj4D15Oh7TuiKOC+D7raaA@mail.gmail.com>
 <ZmqcFf0xB9m4WkA3@redhat.com>
In-Reply-To: <ZmqcFf0xB9m4WkA3@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jun 2024 09:56:39 +0200
Message-ID: <CABgObfb4+FSsadFTVg6Dc1zehQV2Vei2_kSRd5CfxsGBLPN6Eg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008fa5d8061ac0d7b7"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

--0000000000008fa5d8061ac0d7b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 13 giu 2024, 09:13 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> On Wed, Jun 12, 2024 at 11:27:04PM +0200, Paolo Bonzini wrote:
> > Il mer 12 giu 2024, 22:58 Manos Pitsidianakis <
> > manos.pitsidianakis@linaro.org> ha scritto:
> >
> > > In any case, it is out of scope for this RFC. Introducing wrappers
> would
> > > be a gradual process.
> > >
> >
> > Sure, how would you feel about such bindings being developed on list, a=
nd
> > maintained in a (somewhat) long-lived experimental branch?
>
> IMHO any higher level binding APIs for Rust should be acceptable in the
> main QEMU tree as soon as we accept Rust functionality. They can evolve
> in-tree based on the needs of whomever is creating and/or consuming them.
>

My question is the opposite, should we accept Rust functionality without
proper high level bindings? I am afraid that, if more Rust devices are
contributed, it becomes technical debt to have a mix of idiomatic and C-ish
code. If the answer is no, then this PL011 device has to be developed out
of tree.

Paolo


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

--0000000000008fa5d8061ac0d7b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 13 giu 2024, 09:13 Daniel P. Berrang=C3=A9 &lt;=
<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Jun =
12, 2024 at 11:27:04PM +0200, Paolo Bonzini wrote:<br>
&gt; Il mer 12 giu 2024, 22:58 Manos Pitsidianakis &lt;<br>
&gt; <a href=3D"mailto:manos.pitsidianakis@linaro.org" target=3D"_blank" re=
l=3D"noreferrer">manos.pitsidianakis@linaro.org</a>&gt; ha scritto:<br>
&gt; <br>
&gt; &gt; In any case, it is out of scope for this RFC. Introducing wrapper=
s would<br>
&gt; &gt; be a gradual process.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Sure, how would you feel about such bindings being developed on list, =
and<br>
&gt; maintained in a (somewhat) long-lived experimental branch?<br>
<br>
IMHO any higher level binding APIs for Rust should be acceptable in the<br>
main QEMU tree as soon as we accept Rust functionality. They can evolve<br>
in-tree based on the needs of whomever is creating and/or consuming them.<b=
r></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">My=
 question is the opposite, should we accept Rust functionality without prop=
er high level bindings? I am afraid that, if more Rust devices are contribu=
ted, it becomes technical debt to have a mix of idiomatic and C-ish code. I=
f the answer is no, then this PL011 device has to be developed out of tree.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"=
auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div></div>

--0000000000008fa5d8061ac0d7b7--


