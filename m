Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0DFD3C54C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 06:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1gpn-0003WN-SU; Fri, 18 Oct 2024 02:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1gpj-0003W2-M2
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 02:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1gpe-0007hl-HS
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 02:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729234286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nqhRtrW+ZdVP8Aa7mSqxhgF0ooHtMQMOU2vLkC/eJCc=;
 b=B9WK0dQfsZtdixJD7aJFiiU4p74/RoyCQbo1RqrkqpY+Y+lAHIUMPrIBDBSCZua6fwD2Ww
 JUZDQSIKpSmVQ+9dg+TnYqO4c2pcnMLAxmYIdixqJCCu+LIi3qjmxsLndLciBPj7Nnem4h
 wBtln0++zGUPMf/Ao4QQuZhcZkWN3Bg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-QqQqTjNRM4eWgwh8RyIEWg-1; Fri, 18 Oct 2024 02:51:24 -0400
X-MC-Unique: QqQqTjNRM4eWgwh8RyIEWg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d95264eb4so828978f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 23:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729234283; x=1729839083;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nqhRtrW+ZdVP8Aa7mSqxhgF0ooHtMQMOU2vLkC/eJCc=;
 b=OoloVCxhbZrA0qnTumUpo6Pg/YRjWZeq31+astGC+wHyvLz+TJY9C71/65bdMnSPSx
 2hWbyhUsvxTeSmfmRutaKYJNQxkBG6MjvTXXbGBlEZxQo9AkR+UIBti0aF5+s5wIaAkN
 dYoBsipOQvJhIdHwGp/zvXlb2MBHKiMWJ7AEg0WXiaKIaxAgH9Q8qAoOEKecRSN/J1p7
 7vPoA3JsUkadZbk5uyWUd9a4iqcTsQQPdGCQPFDoEn6+eVWiPxNH3c8kmdlP2RKw39dy
 yKMWKU71bKQUM6yxH4dVLOQfDV0QzaeBZR9/KltogsOwXA9B76R3D6nCpWpHyHojFMPU
 JjFA==
X-Gm-Message-State: AOJu0Yx9BtJFSd6L178NI75pSkBz6I6j6iUSiqgm23+/MIhbQ1LlVlxk
 k/cvkT2LsdXns5yMgTTcTndyRKWCdfMiym+WyECy5bFHYvRAMjjS+ZaUVd5vxaFEmEtmfp1Cpen
 GaTJe2XCIP86aa6UhkimF54ThJyQbqt7GIF1vcCfWo2dw0VPZwVHM2WzxG3Ynd7jMjJy2QVEoTC
 M8+ZnlUpPFUaVPaL1x4sjvq7SdREI=
X-Received: by 2002:a5d:404f:0:b0:37d:2d45:b3d4 with SMTP id
 ffacd0b85a97d-37eab71218dmr926508f8f.52.1729234282989; 
 Thu, 17 Oct 2024 23:51:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQy2ua3U6QXnIYTacUIV/fRzkfTAB1qfOllaRaFi5H/4DY3wHzqcpsOnWmHTG2Wc/IoSKxtnx8qCBgo2/zvvU=
X-Received: by 2002:a5d:404f:0:b0:37d:2d45:b3d4 with SMTP id
 ffacd0b85a97d-37eab71218dmr926498f8f.52.1729234282581; Thu, 17 Oct 2024
 23:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-11-pbonzini@redhat.com>
 <SY0P300MB10266B5144972CDF92AF065795472@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
 <CABgObfaX+KhYx3Wo8jGG_hLh_c6t=nYEPZt3FXKQMyOqivVDgA@mail.gmail.com>
 <SY0P300MB1026EAB6DCBDDCD602E7A67C95402@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB1026EAB6DCBDDCD602E7A67C95402@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 18 Oct 2024 08:51:11 +0200
Message-ID: <CABgObfYWd4aAaVk58TSBNTqB=VwgFS_=LnmmvGj3FWXg770uFg@mail.gmail.com>
Subject: Re: [PATCH 10/16] rust: introduce alternative implementation of
 offset_of!
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000025ae870624babbd7"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000025ae870624babbd7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 18 ott 2024, 05:16 Junjie Mao <junjie.mao@hotmail.com> ha scritto:

>
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > On Thu, Oct 17, 2024 at 7:35=E2=80=AFAM Junjie Mao <junjie.mao@hotmail.=
com>
> wrote:
> >> Paolo Bonzini <pbonzini@redhat.com> writes:
> >> > offset_of! was stabilized in Rust 1.77.0.  Use an alternative
> implemenation
> >> > that was found on the Rust forums, and whose author agreed to licens=
e
> as
> >> > MIT for use in QEMU.
> >> >
> >> > The alternative allows only one level of field access, but apart
> >> > from this can be used just by replacing core::mem::offset_of! with
> >> > qemu_api::offset_of!.
> >>
> >> How about a macro like this (which essentially comes from memoffset
> >> crate [1])? It has the same use as core::mem::offset_of! (except the
> >> same single-level limitation) and does not need wrapping structures wi=
th
> >> with_offsets!.
> >
> > Unfortunately offset_from is not available in const context, and
> > offset_of! is needed to fill in the Property and VMStateDescription
> > arrays.
> >
> > That said, I noticed now that declare_properties! does not declare the
> > resulting array as const, so that would be possible. But if
> > declare_properties could use a non-mut static, that would be better.
>
> Agree.
>
> Then how about converting with_offsets! to a derive attribute
> (e.g. #[derive(offsets)])? The current approach introduces one more
> level of indentation. When we later upgrade the minimal supported
> version of Rust and switch to std::mem::offset_of!, we'll need a large
> diff to adjust the indentation which may be annoying to rebase upon. An
> attribute seems easier to manage.
>

Ok, using quote! to generate the with_offsets! {} call should be easy.

Paolo


> I can help draft the macro early next week if you think that is valuable.
>
> Junjie Mao
>
> >
> > Paolo
> >
> >> macro_rules! offset_of {
> >>     ($parent:ty, $field:tt) =3D> {{
> >>         let uninit =3D std::mem::MaybeUninit::<$parent>::uninit();
> >>         let base =3D uninit.as_ptr();
> >>         // SAFETY:
> >>         //
> >>         // MaybeUninit<$parent> has the same size and alignment as
> $parent, so
> >>         // projection to $field is in bound.
> >>         //
> >>         // addr_of! does not create intermediate references to the
> uninitialized
> >>         // memory, thus no UB is involved.
> >>         let field =3D unsafe { std::ptr::addr_of!((*base).$field) };
> >>         // SAFETY:
> >>         //
> >>         // Both base and field point to the MaybeUninit<$parent> and
> are casted
> >>         // to u8 for calculating their distance.
> >>         unsafe { field.cast::<u8>().offset_from(base.cast::<u8>()) as
> usize }
> >>     }};
> >> }
> >>
> >> [1] https://docs.rs/memoffset/latest/memoffset/
>
>

--00000000000025ae870624babbd7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 18 ott 2024, 05:16 Junjie Mao &lt;<a href=3D"ma=
ilto:junjie.mao@hotmail.com">junjie.mao@hotmail.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" =
rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Thu, Oct 17, 2024 at 7:35=E2=80=AFAM Junjie Mao &lt;<a href=3D"mail=
to:junjie.mao@hotmail.com" target=3D"_blank" rel=3D"noreferrer">junjie.mao@=
hotmail.com</a>&gt; wrote:<br>
&gt;&gt; Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D=
"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; writes:<br>
&gt;&gt; &gt; offset_of! was stabilized in Rust 1.77.0.=C2=A0 Use an altern=
ative implemenation<br>
&gt;&gt; &gt; that was found on the Rust forums, and whose author agreed to=
 license as<br>
&gt;&gt; &gt; MIT for use in QEMU.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The alternative allows only one level of field access, but ap=
art<br>
&gt;&gt; &gt; from this can be used just by replacing core::mem::offset_of!=
 with<br>
&gt;&gt; &gt; qemu_api::offset_of!.<br>
&gt;&gt;<br>
&gt;&gt; How about a macro like this (which essentially comes from memoffse=
t<br>
&gt;&gt; crate [1])? It has the same use as core::mem::offset_of! (except t=
he<br>
&gt;&gt; same single-level limitation) and does not need wrapping structure=
s with<br>
&gt;&gt; with_offsets!.<br>
&gt;<br>
&gt; Unfortunately offset_from is not available in const context, and<br>
&gt; offset_of! is needed to fill in the Property and VMStateDescription<br=
>
&gt; arrays.<br>
&gt;<br>
&gt; That said, I noticed now that declare_properties! does not declare the=
<br>
&gt; resulting array as const, so that would be possible. But if<br>
&gt; declare_properties could use a non-mut static, that would be better.<b=
r>
<br>
Agree.<br>
<br>
Then how about converting with_offsets! to a derive attribute<br>
(e.g. #[derive(offsets)])? The current approach introduces one more<br>
level of indentation. When we later upgrade the minimal supported<br>
version of Rust and switch to std::mem::offset_of!, we&#39;ll need a large<=
br>
diff to adjust the indentation which may be annoying to rebase upon. An<br>
attribute seems easier to manage.<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Ok, using quote! to generate the with_offs=
ets! {} call should be easy.</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D=
"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I can help draft the macro early next week if you think that is valuable.<b=
r>
<br>
Junjie Mao<br>
<br>
&gt;<br>
&gt; Paolo<br>
&gt;<br>
&gt;&gt; macro_rules! offset_of {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0($parent:ty, $field:tt) =3D&gt; {{<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0let uninit =3D std::mem::MaybeUni=
nit::&lt;$parent&gt;::uninit();<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0let base =3D uninit.as_ptr();<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// SAFETY:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// MaybeUninit&lt;$parent&gt; has=
 the same size and alignment as $parent, so<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// projection to $field is in bou=
nd.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// addr_of! does not create inter=
mediate references to the uninitialized<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// memory, thus no UB is involved=
.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0let field =3D unsafe { std::ptr::=
addr_of!((*base).$field) };<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// SAFETY:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// Both base and field point to t=
he MaybeUninit&lt;$parent&gt; and are casted<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// to u8 for calculating their di=
stance.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsafe { field.cast::&lt;u8&gt;()=
.offset_from(base.cast::&lt;u8&gt;()) as usize }<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0}};<br>
&gt;&gt; }<br>
&gt;&gt;<br>
&gt;&gt; [1] <a href=3D"https://docs.rs/memoffset/latest/memoffset/" rel=3D=
"noreferrer noreferrer" target=3D"_blank">https://docs.rs/memoffset/latest/=
memoffset/</a><br>
<br>
</blockquote></div></div></div>

--00000000000025ae870624babbd7--


