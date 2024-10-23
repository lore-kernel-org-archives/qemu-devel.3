Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FF8D2E018
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 07:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3VVx-0003oJ-6Y; Wed, 23 Oct 2024 03:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3VVv-0003nv-6m
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:10:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3VVt-00054x-G4
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729667435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r0NgO6ANTLJGE9Z+TVkXaSWuuQVuRfOtgNLH581pRNM=;
 b=TX6KQrAY1iYnGaqEQtzzTbKEj9mXB9sQd2GJeSMxEUAGLGM+ZM9GvM4tbvU6LQwODDENp4
 pWyuPJ1FebiHMYPH3DtvlsuEyBWFer7UarwHfkbdTugqhreDA+Rep2IbVx694YxWJmU0io
 cslBohjS0Bv2IXfjMBejebWftX3n/7o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-4WWMj0rrN-20Vfm-S4yKhw-1; Wed, 23 Oct 2024 03:10:33 -0400
X-MC-Unique: 4WWMj0rrN-20Vfm-S4yKhw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d47fdbbd6so3753522f8f.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 00:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729667432; x=1730272232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r0NgO6ANTLJGE9Z+TVkXaSWuuQVuRfOtgNLH581pRNM=;
 b=mgjVHc6ZapmjvGAjnpE+XiC+/l+X8SuAKf0zedTAC3Tr8akCgTGyPDNIJZjxa+znlr
 V6qJDMK9wT04uMYIyX40FJz0BeVJr1iQn7HNh7uCLad73OS9qYbYnMabX/OWS0885qP5
 PLW6J6aM9mTadwFMS7YUb1HREwxPCC0kNgyFY7fDP3g9rCskDrTrhF6xBl78EZG5HyDg
 hy+/G6cVSqL/ooSE/Tv8ijRdHgOr0ZuceM4mdTY68jet+o9uadWWfeijLwWoYpGKyoEa
 nSi1lLUpZY5RXcpSvWoRqPHHeysRZtSdKdLA34uiEK317jKM88rsjHwdY06rdH7p8hR3
 0xzA==
X-Gm-Message-State: AOJu0YwHlbiG8+z33gzMT7rdWbo9+KtYSrZ3RykEnkmhDSUE98P4uGaI
 ZS7ttWBsdXpY2t2lTOwwMSNty6eJHoiauvOOnPWvToephqLUyXpmluqo3a1ivrJstMpI7VZOmLt
 nyGhXk8XzCZXlFz2apMlVy4Gwo2tvvmxnh4a3qQoDjPD4OyVyTfZ4L9nSNFzV3BQ9TXAqgOJTjV
 YU0xcOpN6GAV1GVnph+BqaVp0ySPw=
X-Received: by 2002:a5d:5590:0:b0:37c:d2f3:b3b0 with SMTP id
 ffacd0b85a97d-37efcf0d877mr1008936f8f.23.1729667432324; 
 Wed, 23 Oct 2024 00:10:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxFq1VChuEYmvA0y+U2Ee0hbWt5v7FV98Q+jmTvP8OnQOpBHYQ6Sb739yvlXOibFlCQpAp3lm6klPgFe5dd6g=
X-Received: by 2002:a5d:5590:0:b0:37c:d2f3:b3b0 with SMTP id
 ffacd0b85a97d-37efcf0d877mr1008919f8f.23.1729667431915; Wed, 23 Oct 2024
 00:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-10-pbonzini@redhat.com>
 <ZxgBDQ0fgwRr7D9P@redhat.com>
In-Reply-To: <ZxgBDQ0fgwRr7D9P@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 23 Oct 2024 09:10:18 +0200
Message-ID: <CABgObfb=Ty6zbWt1C8xNAgzow=V60cX0K-5rhdoS6WiQEXjP9A@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] rust: clean up define_property macro
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Content-Type: multipart/alternative; boundary="000000000000dc06b406251f94d1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--000000000000dc06b406251f94d1
Content-Type: text/plain; charset="UTF-8"

Il mar 22 ott 2024, 21:46 Kevin Wolf <kwolf@redhat.com> ha scritto:

> >              info: $prop,
> >              offset: ::core::mem::offset_of!($state, $field)
> >                  .try_into()
> >                  .expect("Could not fit offset value to type"),
> > -            bitnr: 0,
> > -            bitmask: 0,
> >              set_default: true,
> >              defval: $crate::bindings::Property__bindgen_ty_1 { u:
> $defval.into() },
> > -            arrayoffset: 0,
> > -            arrayinfo: ::core::ptr::null(),
> > -            arrayfieldsize: 0,
> > -            link_type: ::core::ptr::null(),
> > +            ..unsafe {
> ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init()
> }
>
> But is it really worth introducing unsafe code just for a more compact
> notation? If the compiler doesn't actually understand the pattern, it
> might even be less efficient than what we had (i.e. if it really creates
> the zeroed object and copies stuff over).
>

It goes away later in the series (patch 11 replaces it with a more
manageable "Zeroable::ZERO"), but I wanted to split the patches in "parts
that change existing code" and "parts that introduce new concepts".

I agree that it's not optimal either way, I went like this because at this
point this "unsafe { zeroed() }" idiom is present several times in the code
and one more doesn't really change much.

Paolo


> Kevin
>
>

--000000000000dc06b406251f94d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 22 ott 2024, 21:46 Kevin Wolf &lt;<a href=3D"ma=
ilto:kwolf@redhat.com">kwolf@redhat.com</a>&gt; ha scritto:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 info: $prop,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offset: ::core::mem::o=
ffset_of!($state, $field)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .try_int=
o()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .expect(=
&quot;Could not fit offset value to type&quot;),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bitnr: 0,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bitmask: 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_default: true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defval: $crate::bindin=
gs::Property__bindgen_ty_1 { u: $defval.into() },<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arrayoffset: 0,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arrayinfo: ::core::ptr::nul=
l(),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arrayfieldsize: 0,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 link_type: ::core::ptr::nul=
l(),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ..unsafe { ::core::mem::May=
beUninit::&lt;$crate::bindings::Property&gt;::zeroed().assume_init() }<br>
<br>
But is it really worth introducing unsafe code just for a more compact<br>
notation? If the compiler doesn&#39;t actually understand the pattern, it<b=
r>
might even be less efficient than what we had (i.e. if it really creates<br=
>
the zeroed object and copies stuff over).<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">It goes away later in the series (=
patch 11 replaces it with a more manageable &quot;Zeroable::ZERO&quot;), bu=
t I wanted to split the patches in &quot;parts that change existing code&qu=
ot; and &quot;parts that introduce new concepts&quot;.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">I agree that it&#39;s not optimal either way=
, I went like this because at this point this &quot;unsafe { zeroed() }&quo=
t; idiom is present several times in the code and one more doesn&#39;t real=
ly change much.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=
=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_=
quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Kevin<br>
<br>
</blockquote></div></div></div>

--000000000000dc06b406251f94d1--


