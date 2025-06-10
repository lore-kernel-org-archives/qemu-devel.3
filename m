Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CD1C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27e-0002Rw-S2; Tue, 10 Jun 2025 12:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uOyzt-000791-Iq
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 09:26:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uOyzn-0006gD-4M
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 09:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749561988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TZ8YbzTFpdhd6WiOhudM2Tuhugtqn6d4bA9UVq6kugI=;
 b=WqsJwhhiPBjFzLan/wTHeXXqUg60KOCa7U1y5mG4SKhuOjL1cWfiOkpjx1meniKT2zBd5w
 i7nsjJZFuxNtJNSJfgPFSskk0ENp+va8WdDf6IBaBQ7e0hOCnlQepkeRaElHKpR/aExHDg
 ZWmRbxfdAATxUkMtXuxvGWaRaMsOlis=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-7VqRrdStMkiDlApx8uIKdA-1; Tue, 10 Jun 2025 09:26:24 -0400
X-MC-Unique: 7VqRrdStMkiDlApx8uIKdA-1
X-Mimecast-MFC-AGG-ID: 7VqRrdStMkiDlApx8uIKdA_1749561984
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6faeebe9c5bso48192716d6.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 06:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749561984; x=1750166784;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TZ8YbzTFpdhd6WiOhudM2Tuhugtqn6d4bA9UVq6kugI=;
 b=rTRfMm6/RIy7P8n2er2Fk485eucaYQLPV/zWjgHZLEjd6sRmI0iQqQARlej0bJ4qWj
 9mwlPVZZiFu96ORbh1O4PJtTIvvfEDLZjiWyGN4h98ugp27gZEOShkz0tPfrkuWSpIqA
 nflgxfvoM8YNLCbtLdo23fijT55b3SPG+3/h965gOhyZj/oEMA4Zvcchqlh3oWVSzfMw
 lkoqT7/eQMOEYge15HpIluWEWfy3CsWojiDP2u7qFSfPbRP3Ex4RXww47RE46RyYA2j8
 Mq0NUxRzaUEV45tXOnlp5Y52oKIeVLbBRrsyxxLZdT875mmj5J+O3nZBFA+k35tKwZAA
 p3zw==
X-Gm-Message-State: AOJu0YxiQiYk4iT/0TgMdhpREMmLT9CkXjhaGsXVcq3NQfmYvoK+xFeL
 dz29l/snmrwzQILgvHUKWL+hTy1UyBZmg6J6QGI3dQTfgITo8/YsaFlC2Rk+n6wFVq7QRFN23Ub
 So5CWU9VhnTh81MAIibOe3ytQHkXFdU7I6PRbPPSpO3fvzEGK23GyIXcnzY2tkhQFtgiuRDtrKu
 mfG2oTvuSrVfyNcj1sbh1eXU/p+d0wFfo=
X-Gm-Gg: ASbGncsqBC9j9FtINAgAuLGDg/ZYZxs0YlElMrILTxEWDzO3pYxQspnlmlF592ay5NT
 YZbVktg7gKGNyUyLO0vtdRt7BGjC3LXmFWkjJYkjSj6GkxbfpxAbFkmungC/CN0dnoQoF0zw03f
 y2YBVkqb+foVBEQVwdIDhQk0R9TPWhkUI2sEjP
X-Received: by 2002:a05:6214:242e:b0:6fa:cb05:b44c with SMTP id
 6a1803df08f44-6fb08f4314fmr266826766d6.3.1749561984281; 
 Tue, 10 Jun 2025 06:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG33ocxkZEMglLzN5LY6ffp83zf1HHmc9QPJ1W61gb+CYFBfzhOluCj4vzs9SClPZByqDMfkiWzoQkPajiv1Q=
X-Received: by 2002:a05:6214:242e:b0:6fa:cb05:b44c with SMTP id
 6a1803df08f44-6fb08f4314fmr266826216d6.3.1749561983816; Tue, 10 Jun 2025
 06:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250605101124.367270-1-pbonzini@redhat.com>
 <20250605101124.367270-2-pbonzini@redhat.com>
In-Reply-To: <20250605101124.367270-2-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Jun 2025 17:26:12 +0400
X-Gm-Features: AX0GCFvE64xeikhVCZx9sJM6BU5Q1IMeiXm2InfyBL5Zwgr9Ien68vArHYlPu24
Message-ID: <CAMxuvayD+KvQTVWv+MyU8gmxLgwDF3p1ahiY+6WLvHJndJTXxg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: make TryFrom macro more resilient
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, armbru@redhat.com, 
 mkletzan@redhat.com
Content-Type: multipart/alternative; boundary="0000000000008ee651063737a4da"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

--0000000000008ee651063737a4da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 2:11=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:

> If the enum includes values such as "Ok", "Err", or "Error", the TryInto
> macro can cause errors.  Be careful and qualify identifiers with the full
> path, or in the case of TryFrom<>::Error do not use the associated type
> at all.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  rust/qemu-api-macros/src/lib.rs | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/
> lib.rs
> index 103470785e3..c18bb4e036f 100644
> --- a/rust/qemu-api-macros/src/lib.rs
> +++ b/rust/qemu-api-macros/src/lib.rs
> @@ -203,8 +203,8 @@ fn derive_tryinto_body(
>      Ok(quote! {
>          #(const #discriminants: #repr =3D #name::#discriminants as #repr=
;)*;
>          match value {
> -            #(#discriminants =3D> Ok(#name::#discriminants),)*
> -            _ =3D> Err(value),
> +            #(#discriminants =3D>
> core::result::Result::Ok(#name::#discriminants),)*
> +            _ =3D> core::result::Result::Err(value),
>          }
>      })
>  }
> @@ -236,7 +236,8 @@ pub const fn from_bits(value: #repr) -> Self {
>          impl core::convert::TryFrom<#repr> for #name {
>              type Error =3D #repr;
>
> -            fn try_from(value: #repr) -> Result<Self, Self::Error> {
> +            #[allow(ambiguous_associated_items)]
> +            fn try_from(value: #repr) -> Result<Self, #repr> {
>                  #body
>              }
>          }
> --
> 2.49.0
>
>

--0000000000008ee651063737a4da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 5, =
2025 at 2:11=E2=80=AFPM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat=
.com">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">If the enum includes values such as &quot;Ok&quot;=
, &quot;Err&quot;, or &quot;Error&quot;, the TryInto<br>
macro can cause errors.=C2=A0 Be careful and qualify identifiers with the f=
ull<br>
path, or in the case of TryFrom&lt;&gt;::Error do not use the associated ty=
pe<br>
at all.<br>
<br>
Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank">pbonzini@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lur=
eau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0rust/qemu-api-macros/src/<a href=3D"http://lib.rs" rel=3D"noreferrer"=
 target=3D"_blank">lib.rs</a> | 7 ++++---<br>
=C2=A01 file changed, 4 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/rust/qemu-api-macros/src/<a href=3D"http://lib.rs" rel=3D"nore=
ferrer" target=3D"_blank">lib.rs</a> b/rust/qemu-api-macros/src/<a href=3D"=
http://lib.rs" rel=3D"noreferrer" target=3D"_blank">lib.rs</a><br>
index 103470785e3..c18bb4e036f 100644<br>
--- a/rust/qemu-api-macros/src/<a href=3D"http://lib.rs" rel=3D"noreferrer"=
 target=3D"_blank">lib.rs</a><br>
+++ b/rust/qemu-api-macros/src/<a href=3D"http://lib.rs" rel=3D"noreferrer"=
 target=3D"_blank">lib.rs</a><br>
@@ -203,8 +203,8 @@ fn derive_tryinto_body(<br>
=C2=A0 =C2=A0 =C2=A0Ok(quote! {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#(const #discriminants: #repr =3D #name::=
#discriminants as #repr;)*;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0match value {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #(#discriminants =3D&gt; Ok(#nam=
e::#discriminants),)*<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _ =3D&gt; Err(value),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #(#discriminants =3D&gt; core::r=
esult::Result::Ok(#name::#discriminants),)*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _ =3D&gt; core::result::Result::=
Err(value),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0})<br>
=C2=A0}<br>
@@ -236,7 +236,8 @@ pub const fn from_bits(value: #repr) -&gt; Self {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0impl core::convert::TryFrom&lt;#repr&gt; =
for #name {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type Error =3D #repr;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fn try_from(value: #repr) -&gt; =
Result&lt;Self, Self::Error&gt; {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #[allow(ambiguous_associated_ite=
ms)]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fn try_from(value: #repr) -&gt; =
Result&lt;Self, #repr&gt; {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#body<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>

--0000000000008ee651063737a4da--


