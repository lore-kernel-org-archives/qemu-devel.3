Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1DFC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZVP-0005IM-Dx; Tue, 15 Jul 2025 02:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubZPN-00071K-0S
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:44:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubZPI-0007Cs-44
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752561890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g2GNShuYUsv/79m0VWED2XpRtfeIbdJGneDzm8z9mUs=;
 b=FYfhf8M33t91JmjVEaDAdJmEjsT4lgksCXC/+TNOwVdT5zBDEoT1yLSNLxwld4CqVv+RUc
 VsI7+dH9zWpgvesaPgnEt9CD7r75Ui3nQCHU7b+qL26FuokmUpWzy8iG1Oh243gNSiiuR7
 RocZ7+czfCSB/nn7HmY3aliBrSCX4mU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-0qK0twfXOMq7LJ_DSiQKKg-1; Tue, 15 Jul 2025 02:44:48 -0400
X-MC-Unique: 0qK0twfXOMq7LJ_DSiQKKg-1
X-Mimecast-MFC-AGG-ID: 0qK0twfXOMq7LJ_DSiQKKg_1752561887
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b20f50da27so2910240f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752561887; x=1753166687;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g2GNShuYUsv/79m0VWED2XpRtfeIbdJGneDzm8z9mUs=;
 b=jWE4nlQiWxjA4WNE6emFMCqtndyNmZSumeoaVTZZBiqHZnAhcZ4iOx0IrIIKACVbzw
 Tkz6sjt1P7w7aMMxW9erPbmNTA/1o/NqvfgUCjxpssN0HiJyz5lnQ/lAbAr1ignydhAm
 /wcyGczBYYk1MtW0rVaulgFnDjnQkL4+cD8WbZQHQ5NmhcW2hOlVy0AcELuTrJn6H4qm
 I7I/bpRWHoPNCm4uO/GwMZ3Bsp9+Ns7QYQ3Tr90SjYjbMhn08YQc4AcfRbntXSz4i4aC
 0GV3HxPGWMTCatib/qGA0fljv06r/YvV2GmcEU13BkEVtRuUJYTegZgxZzghouQqrCL5
 Neeg==
X-Gm-Message-State: AOJu0YzgGv/ph4z2uB5/UjUWbUyaabrMLoVPAZcdTVpt075jy2jPziHa
 Pm6Osb+QUHHcaqVVtJ2j9CKfHIN0x4jCTItzf05eDs1T7r11w2FV4odh371CeRnmtLeRzzwc5/X
 uPwDpg0dOqYc5EXFSEe/Lf9YK+ApyALQS74Z/ivOz0VCGbzJoyrFSKi7Py8fSTIRBrNWjpfrYfS
 QBGfS52Fd7hXIgxWJPI5sHfeLLFmVcl4QiuMTTH9Y=
X-Gm-Gg: ASbGnct9qh674do89Ud/1tOknt7A2WfCaS6+gvClnNDnRkGzIfHYF8gCrLq+9uc+aMW
 zT+mQyd9DA87qzMB/JVp7lU+CvRSIiZ++Tm31hMQnnoHKUaSFPEfjPUIoceZYa7bBYb0JSUnu92
 7/iSAd42xm/682OJ357TRJ
X-Received: by 2002:a05:6000:3110:b0:3a5:8991:64b7 with SMTP id
 ffacd0b85a97d-3b609544312mr1795090f8f.26.1752561885863; 
 Mon, 14 Jul 2025 23:44:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPhPAU4X0sG0qJswruXc3KZypwB/jrAiSfZ5Ssca/maHLnxPrpjARRTw8OVa1cpM5PTc030/cKMRAAKdeUhFc=
X-Received: by 2002:a05:6000:3110:b0:3a5:8991:64b7 with SMTP id
 ffacd0b85a97d-3b609544312mr1795070f8f.26.1752561885401; Mon, 14 Jul 2025
 23:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <e41344bd22248b0883752ef7a7c459090a3d9cfc.1752560127.git.mst@redhat.com>
In-Reply-To: <e41344bd22248b0883752ef7a7c459090a3d9cfc.1752560127.git.mst@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 15 Jul 2025 08:44:35 +0200
X-Gm-Features: Ac12FXzu2NbTTjK2Kn4T8A4WWAnztR5nmeHB8YOPJEHXzKtb9Xlb52OMm12BFYI
Message-ID: <CABgObfZE1bZkKqJgEHWLsnwcQ1Zfy2JLNKqudZEGQdA+Nc8TrA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: bindings: allow any number of params
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a06abd0639f21c08"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

--000000000000a06abd0639f21c08
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 15 lug 2025, 08:20 Michael S. Tsirkin <mst@redhat.com> ha scritto:

> We are going to be adding more parameters, and this makes
> rust unhappy:
>     Functions with lots of parameters are considered bad style and reduce
>     readability (=E2=80=9Cwhat does the 5th parameter mean?=E2=80=9D). Co=
nsider grouping
>     some parameters into a new type.
>
> Specifically:
>
> error: this function has too many arguments (8/7)
>     -->
> /builds/mstredhat/qemu/build/rust/qemu-api/rust-qemu-api-tests.p/structur=
ed/bindings.inc.rs:3840
> :5
>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


     |
> 3840 | /     pub fn new_bitfield_1(
> 3841 | |         secure: std::os::raw::c_uint,
> 3842 | |         space: std::os::raw::c_uint,
> 3843 | |         user: std::os::raw::c_uint,
> ...    |
> 3848 | |         address_type: std::os::raw::c_uint,
> 3849 | |     ) -> __BindgenBitfieldUnit<[u8; 4usize]> {
>      | |____________________________________________^
>      |
>      =3D help: for further information visit
> https://rust-lang.github.io/rust-clippy/master/index.html#too_many_argume=
nts
>      =3D note: `-D clippy::too-many-arguments` implied by `-D warnings`
>      =3D help: to override `-D warnings` add
> `#[allow(clippy::too_many_arguments)]`
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  rust/qemu-api/src/bindings.rs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.r=
s
> index 057de4b646..c4f1f755ce 100644
> --- a/rust/qemu-api/src/bindings.rs
> +++ b/rust/qemu-api/src/bindings.rs
> @@ -13,7 +13,8 @@
>      clippy::missing_const_for_fn,
>      clippy::ptr_offset_with_cast,
>      clippy::useless_transmute,
> -    clippy::missing_safety_doc
> +    clippy::missing_safety_doc,
> +    clippy::too_many_arguments
>  )]
>
>  //! `bindgen`-generated declarations.
> --
> MST
>
>
>

--000000000000a06abd0639f21c08
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 15 lug 2025, 08:20 Michae=
l S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; h=
a scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">We ar=
e going to be adding more parameters, and this makes<br>
rust unhappy:<br>
=C2=A0 =C2=A0 Functions with lots of parameters are considered bad style an=
d reduce<br>
=C2=A0 =C2=A0 readability (=E2=80=9Cwhat does the 5th parameter mean?=E2=80=
=9D). Consider grouping<br>
=C2=A0 =C2=A0 some parameters into a new type.<br>
<br>
Specifically:<br>
<br>
error: this function has too many arguments (8/7)<br>
=C2=A0 =C2=A0 --&gt; /builds/mstredhat/qemu/build/rust/qemu-api/rust-qemu-a=
pi-tests.p/structured/bindings.inc.rs:3840:5<br></blockquote></div></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Acked-by: Paolo Bonzini &lt;<a =
href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt;</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
=C2=A0 =C2=A0 =C2=A0|<br>
3840 | /=C2=A0 =C2=A0 =C2=A0pub fn new_bitfield_1(<br>
3841 | |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0secure: std::os::raw::c_uint,<br>
3842 | |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0space: std::os::raw::c_uint,<br>
3843 | |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user: std::os::raw::c_uint,<br>
...=C2=A0 =C2=A0 |<br>
3848 | |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0address_type: std::os::raw::c_uin=
t,<br>
3849 | |=C2=A0 =C2=A0 =C2=A0) -&gt; __BindgenBitfieldUnit&lt;[u8; 4usize]&g=
t; {<br>
=C2=A0 =C2=A0 =C2=A0| |____________________________________________^<br>
=C2=A0 =C2=A0 =C2=A0|<br>
=C2=A0 =C2=A0 =C2=A0=3D help: for further information visit <a href=3D"http=
s://rust-lang.github.io/rust-clippy/master/index.html#too_many_arguments" r=
el=3D"noreferrer noreferrer" target=3D"_blank">https://rust-lang.github.io/=
rust-clippy/master/index.html#too_many_arguments</a><br>
=C2=A0 =C2=A0 =C2=A0=3D note: `-D clippy::too-many-arguments` implied by `-=
D warnings`<br>
=C2=A0 =C2=A0 =C2=A0=3D help: to override `-D warnings` add `#[allow(clippy=
::too_many_arguments)]`<br>
<br>
Signed-off-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">mst@redhat.com</a>&gt;<br>
---<br>
=C2=A0rust/qemu-api/src/<a href=3D"http://bindings.rs" rel=3D"noreferrer no=
referrer" target=3D"_blank">bindings.rs</a> | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/rust/qemu-api/src/<a href=3D"http://bindings.rs" rel=3D"norefe=
rrer noreferrer" target=3D"_blank">bindings.rs</a> b/rust/qemu-api/src/<a h=
ref=3D"http://bindings.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">=
bindings.rs</a><br>
index 057de4b646..c4f1f755ce 100644<br>
--- a/rust/qemu-api/src/<a href=3D"http://bindings.rs" rel=3D"noreferrer no=
referrer" target=3D"_blank">bindings.rs</a><br>
+++ b/rust/qemu-api/src/<a href=3D"http://bindings.rs" rel=3D"noreferrer no=
referrer" target=3D"_blank">bindings.rs</a><br>
@@ -13,7 +13,8 @@<br>
=C2=A0 =C2=A0 =C2=A0clippy::missing_const_for_fn,<br>
=C2=A0 =C2=A0 =C2=A0clippy::ptr_offset_with_cast,<br>
=C2=A0 =C2=A0 =C2=A0clippy::useless_transmute,<br>
-=C2=A0 =C2=A0 clippy::missing_safety_doc<br>
+=C2=A0 =C2=A0 clippy::missing_safety_doc,<br>
+=C2=A0 =C2=A0 clippy::too_many_arguments<br>
=C2=A0)]<br>
<br>
=C2=A0//! `bindgen`-generated declarations.<br>
-- <br>
MST<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000a06abd0639f21c08--


