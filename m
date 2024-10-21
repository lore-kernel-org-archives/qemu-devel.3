Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658B3D0E6F0
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 10:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2puV-0000SE-V1; Mon, 21 Oct 2024 06:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2puU-0000RW-0h
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2puR-0003Rj-Pv
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729507509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hwc0m6a8g1TMX3VbIm/9LRZOMvkOBPKkVJTMm2raJfs=;
 b=e4K6VXVQxayKbfcF0lbsm17ZjTa4xThqV2TNPpI/agiqulnubSO5aJMxuf6Ow4oEhtKOUV
 vLBzBpcT6exAYJWYRl0C20WMV6ib4NdCYxS5teGw/pplu2/ns16BdZcRUJNGR0OH8I4UH3
 sqNi6CY1sffWauvCsDcXuUovwdtPBS4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-hoIRZUfEO2ii5-63CjydQA-1; Mon, 21 Oct 2024 06:45:07 -0400
X-MC-Unique: hoIRZUfEO2ii5-63CjydQA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4316655b2f1so17639815e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 03:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729507506; x=1730112306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hwc0m6a8g1TMX3VbIm/9LRZOMvkOBPKkVJTMm2raJfs=;
 b=ULi1NTtshNPSploKSuNYG7Iqtg1K5Qk0hfvlkx2VslAF69e1sNh6+sCvvmSDzxT9Uq
 Pu/z2HaeExhyhQyY5IJ8iGMvLDHEcb8cYdQSh/mTh6qLv2xd/ZChNMvBe3Wbn+2ZIdo3
 f8gkCfd7B91tFi7ZnAQ1hJAA1+wu8QtyY4N5VtmXfnmkPqWK23RDtoPhPyxcgxqo/qOJ
 DuBpgF0KbZH5LpKrEl07Iujas96gcG1H25g5W8jtOBCfRHYR+wfjYFM/QdeZIIah/lTq
 +N8+WwUZJBSkEx0485KeA/p55Yl2UvlX4PbKxQxcliWn7P26PO5UIkQIZLxz/ofn2zIR
 AxlQ==
X-Gm-Message-State: AOJu0YyVJFLJvewjBe8U5mmVZlkuFd6C3KyVJC5ICIFSIXdpq1ybv5ar
 y0IjCOjbPYH1aExiu3uzWalX+u2mlKlIBHfz0uDHNEOSr0GZWsh2QQ5LYaVv/M45zTqKuY8DI3t
 G/6gtPz2NF5v5zmN9JRihj73sMWL0Qqpql5TUG902822K1aztfIzoSX/TTUIhBPFZLo30QCFjeR
 G2w0AsqusqrnM+V//b41WvzX3Odds=
X-Received: by 2002:adf:e988:0:b0:37c:cc67:8b1f with SMTP id
 ffacd0b85a97d-37eab710526mr7035767f8f.48.1729507506291; 
 Mon, 21 Oct 2024 03:45:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2D0/gL7jcZtdLF5hHlr1cfVvujFBSr4QRhocSn9oLgzn2vNuEhCkixazStIp7+fYLWx849+W1NKA8pKUAWIc=
X-Received: by 2002:adf:e988:0:b0:37c:cc67:8b1f with SMTP id
 ffacd0b85a97d-37eab710526mr7035748f8f.48.1729507505662; Mon, 21 Oct 2024
 03:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241018144306.954716-1-pbonzini@redhat.com>
 <20241018144306.954716-10-pbonzini@redhat.com>
 <SY0P300MB1026DF84A11DD5A72EC45EEB95432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB1026DF84A11DD5A72EC45EEB95432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Oct 2024 12:44:54 +0200
Message-ID: <CABgObfYox+Un798wFjxktDsa7XnjXmgM8ohTeotD2eFpqAweeg@mail.gmail.com>
Subject: Re: [PATCH 09/13] rust: clean up define_property macro
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008306fb0624fa58a9"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000008306fb0624fa58a9
Content-Type: text/plain; charset="UTF-8"

Il lun 21 ott 2024, 12:39 Junjie Mao <junjie.mao@hotmail.com> ha scritto:

>
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > Use the "struct update" syntax to initialize most of the fields to zero,
> > and simplify the handmade type-checking of $name.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  rust/qemu-api/src/device_class.rs | 29 ++++++-----------------------
> >  1 file changed, 6 insertions(+), 23 deletions(-)
> >
> > diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/
> device_class.rs
> > index 2219b9f73d0..5aba426d243 100644
> > --- a/rust/qemu-api/src/device_class.rs
> > +++ b/rust/qemu-api/src/device_class.rs
> > @@ -29,44 +29,27 @@ macro_rules! device_class_init {
> >  macro_rules! define_property {
> >      ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr,
> default = $defval:expr$(,)*) => {
> >          $crate::bindings::Property {
> > -            name: {
> > -                #[used]
> > -                static _TEMP: &::core::ffi::CStr = $name;
> > -                _TEMP.as_ptr()
> > -            },
> > +            // use associated function syntax for type checking
> > +            name: ::core::ffi::CStr::as_ptr($name),
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
> zeroed() is const only since 1.75.0 [1]. Is there any alternative for
> older Rust versions?
>

Yes: manual implementation of a Zeroable trait, as in the series I sent
before one. For now I am not worrying about the MSRV, since the
hacks/workarounds from those patches do not become any worse.

Paolo

>
> [1] https://doc.rust-lang.org/std/mem/union.MaybeUninit.html#method.zeroed
>
> --
> Best Regards
> Junjie Mao
>
>

--0000000000008306fb0624fa58a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 21 ott 2024, 12:39 Junjie Mao &lt;<a href=3D"ma=
ilto:junjie.mao@hotmail.com">junjie.mao@hotmail.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" =
rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; writes:<br>
<br>
&gt; Use the &quot;struct update&quot; syntax to initialize most of the fie=
lds to zero,<br>
&gt; and simplify the handmade type-checking of $name.<br>
&gt;<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://device_class.rs" rel=3D"nore=
ferrer noreferrer" target=3D"_blank">device_class.rs</a> | 29 ++++++-------=
----------------<br>
&gt;=C2=A0 1 file changed, 6 insertions(+), 23 deletions(-)<br>
&gt;<br>
&gt; diff --git a/rust/qemu-api/src/<a href=3D"http://device_class.rs" rel=
=3D"noreferrer noreferrer" target=3D"_blank">device_class.rs</a> b/rust/qem=
u-api/src/<a href=3D"http://device_class.rs" rel=3D"noreferrer noreferrer" =
target=3D"_blank">device_class.rs</a><br>
&gt; index 2219b9f73d0..5aba426d243 100644<br>
&gt; --- a/rust/qemu-api/src/<a href=3D"http://device_class.rs" rel=3D"nore=
ferrer noreferrer" target=3D"_blank">device_class.rs</a><br>
&gt; +++ b/rust/qemu-api/src/<a href=3D"http://device_class.rs" rel=3D"nore=
ferrer noreferrer" target=3D"_blank">device_class.rs</a><br>
&gt; @@ -29,44 +29,27 @@ macro_rules! device_class_init {<br>
&gt;=C2=A0 macro_rules! define_property {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ($name:expr, $state:ty, $field:expr, $prop:expr, $=
type:expr, default =3D $defval:expr$(,)*) =3D&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $crate::bindings::Property {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #[used]<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 static _TEMP:=
 &amp;::core::ffi::CStr =3D $name;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _TEMP.as_ptr(=
)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // use associated function =
syntax for type checking<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: ::core::ffi::CStr::as=
_ptr($name),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info: $prop,<br>
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
zeroed() is const only since 1.75.0 [1]. Is there any alternative for<br>
older Rust versions?<br></blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Yes: manual implementation of a Zeroable trait, as in t=
he series I sent before one. For now I am not worrying about the MSRV, sinc=
e the hacks/workarounds from those patches do not become any worse.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
[1] <a href=3D"https://doc.rust-lang.org/std/mem/union.MaybeUninit.html#met=
hod.zeroed" rel=3D"noreferrer noreferrer" target=3D"_blank">https://doc.rus=
t-lang.org/std/mem/union.MaybeUninit.html#method.zeroed</a><br>
<br>
--<br>
Best Regards<br>
Junjie Mao<br>
<br>
</blockquote></div></div></div>

--0000000000008306fb0624fa58a9--


