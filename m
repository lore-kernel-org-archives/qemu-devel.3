Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A146BE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 18:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVEY6-0004Kt-CS; Tue, 07 Jan 2025 13:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tVEY3-0004Kd-Vo
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 13:43:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tVEY2-0002sc-EN
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 13:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736275405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YrRtO/BWxpaVLhq119weCOxcxsGl9Lz6DEEmcvxD9Kc=;
 b=SN9bZwUcM6aa1g0BT+TdqPnUa94b/sImNBDWh/7cEzrySEHPJlq67pQoMpTfTkvSFatVRT
 VBcgI5YKLfaTf9SUyb9X1nESlm19LW0ZY7klU4nWgME2mqYjo5rwGjldrbWqbG1/xBWYyt
 dKM0+4UfquKhlNa/q5LwOsgtSYO8o4U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-BIDPGM2LMxa_W-baAjGBkg-1; Tue, 07 Jan 2025 13:43:23 -0500
X-MC-Unique: BIDPGM2LMxa_W-baAjGBkg-1
X-Mimecast-MFC-AGG-ID: BIDPGM2LMxa_W-baAjGBkg
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385e2579507so6998605f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 10:43:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736275401; x=1736880201;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YrRtO/BWxpaVLhq119weCOxcxsGl9Lz6DEEmcvxD9Kc=;
 b=Qe6VwSG5Jroa/PPQAFCORc4SYJHjE2/9nY2jOHtnSHTP2F7XITIoyNjLM0utfTp4O9
 RxtSNKHaDXgx+DGd3JPWRrLLeqr9ByNVSqDu27zKtd6mWbq22W+mEMrx9v4FcHBBr+/M
 lU/GffGAKkn3NTDyJpmI99+mRv3s2bPhhgNW1ik+X5j9bqt6yowsDPrEfe5CK4UfwBs1
 fIJJP510PY6QlYjI1ik18K0ney0aRKBimvpo5zsJnAphwDPwJ2v5LegtxLik1g2GOSF8
 53P5JlBB1O3EVSarrzFdlIEch5lZRQTo/mioRfjsBToknSR1i6o256ppdKCGHGcnxPnT
 oUtA==
X-Gm-Message-State: AOJu0Yzix+unwjZfZrEJyMj4mrqt+p+dkOxOnLGCIwms0FInUBwWjfda
 hEpvpymytqim/gD0fWSl1phA7tqZ1Ddo0YRlF9N5iUvqDdIJ0jf2HQ1PuZQm+gNsgCN4HpLn8gF
 CkT60nUevow5tyaDcwBFFIS4sDSznMEwyid07ZDURdpF8QdXJ5Q59cBJeETuMSc05OPEWWaMXZ4
 Ygr4l8WZNxNIXom9+L7YajBM2KRyqP9j/6VuCGAQ==
X-Gm-Gg: ASbGncva4O3Svw4fGk3Qa2BkhQounF1NrBabbBJwwT221ENB1dmVVyTCoZVXF9WppnK
 B/ckripYFVNkOqv/MeOHLxNEl5nSJ6S6iViNG/w==
X-Received: by 2002:a5d:5e09:0:b0:385:e328:890a with SMTP id
 ffacd0b85a97d-38a223fd7e1mr53231454f8f.49.1736275401450; 
 Tue, 07 Jan 2025 10:43:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5c7Hqx4K6vtCvg/R5IYkBcGFg3GytvN7Z9QVumhxbpgJP+CZgwrhpaHYGy+a4KixA8U99RI+hOKdtil2nTTk=
X-Received: by 2002:a5d:5e09:0:b0:385:e328:890a with SMTP id
 ffacd0b85a97d-38a223fd7e1mr53231438f8f.49.1736275401076; Tue, 07 Jan 2025
 10:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20250107155406.53161-1-pbonzini@redhat.com>
In-Reply-To: <20250107155406.53161-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 7 Jan 2025 19:43:09 +0100
X-Gm-Features: AbW1kvbkxS6gspeOMpfjIF4lj0CdaLWAJrtzJ56xv4pSFyKFm8VROuEsnSnHHbA
Message-ID: <CABgObfYE=61AZHLYZHnRaZs06F3EOru-eGw7QHVxcmgbKWgNtg@mail.gmail.com>
Subject: Re: [PATCH] rust: add --check-cfg test to rustc arguments
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000839523062b221e36"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

--000000000000839523062b221e36
Content-Type: text/plain; charset="UTF-8"

Il mar 7 gen 2025, 16:54 Paolo Bonzini <pbonzini@redhat.com> ha scritto:

> rustc will check that every reachable #[cfg] matches a list of
> the expected config names and values.  Recent versions of rustc are
> also complaining about #[cfg(test)], even if it is basically a standard
> part of the language.  So, always allow it.
>

This is https://github.com/rust-lang/compiler-team/issues/785; I will add
it to the commit message.

Paolo


> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/rust/rustc_args.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
> index 5525b3886fa..d79dc6d81f1 100644
> --- a/scripts/rust/rustc_args.py
> +++ b/scripts/rust/rustc_args.py
> @@ -215,6 +215,8 @@ def main() -> None:
>
>      if rustc_version >= (1, 80):
>          if args.lints:
> +            print("--check-cfg")
> +            print("test")
>              for cfg in sorted(cargo_toml.check_cfg):
>                  print("--check-cfg")
>                  print(cfg)
> --
> 2.47.1
>

--000000000000839523062b221e36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 7 gen 2025, 16:54 Paolo B=
onzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&g=
t; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">r=
ustc will check that every reachable #[cfg] matches a list of<br>
the expected config names and values.=C2=A0 Recent versions of rustc are<br=
>
also complaining about #[cfg(test)], even if it is basically a standard<br>
part of the language.=C2=A0 So, always allow it.<br></blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">This is <a href=3D"https://=
github.com/rust-lang/compiler-team/issues/785">https://github.com/rust-lang=
/compiler-team/issues/785</a>; I will add it to the commit message.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
---<br>
=C2=A0scripts/rust/rustc_args.py | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py<br>
index 5525b3886fa..d79dc6d81f1 100644<br>
--- a/scripts/rust/rustc_args.py<br>
+++ b/scripts/rust/rustc_args.py<br>
@@ -215,6 +215,8 @@ def main() -&gt; None:<br>
<br>
=C2=A0 =C2=A0 =C2=A0if rustc_version &gt;=3D (1, 80):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if args.lints:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;--check-cfg&quot;)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;test&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for cfg in sorted(cargo_tom=
l.check_cfg):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&quot;-=
-check-cfg&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(cfg)<br=
>
-- <br>
2.47.1<br>
</blockquote></div></div></div>

--000000000000839523062b221e36--


