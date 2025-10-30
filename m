Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9206CCCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 19:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEYN9-0002Jf-PK; Thu, 30 Oct 2025 15:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYN7-0002J7-BT
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYN1-0005ft-St
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761852693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J5HnDGCz5DYnQ6xCgQZTZnNpXY5QFaU6P7FLoqnX438=;
 b=D0ndo59QnUqDCN1I8wQlHmjGV9FUo30L5pdlOPQNkcnhCRGbqL/VVdZesyoXgcyDvsBxmZ
 MFC21dP5Cfu5C9qhZkbp4KzJKlmfNnvIHURXUADEDd5JKeoelCMnpVEd6EZsYJ5aQv+xGG
 6k2s4Kd0pZhWZayFwhL3SIUKvaoGZjE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-OhjXH7z4OOyHFZxTH73QrQ-1; Thu, 30 Oct 2025 15:31:27 -0400
X-MC-Unique: OhjXH7z4OOyHFZxTH73QrQ-1
X-Mimecast-MFC-AGG-ID: OhjXH7z4OOyHFZxTH73QrQ_1761852686
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-272b7bdf41fso18888545ad.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 12:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761852686; x=1762457486;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J5HnDGCz5DYnQ6xCgQZTZnNpXY5QFaU6P7FLoqnX438=;
 b=ASMNgoCzOWdxDzklbU7McqHp4SRghf8WYOT+V/45pmP+9dF5GTNBsCsIGVKYCdNuEw
 pB0D/nLpdPPs3lfZsJO2Xpm+qY7n09FGRPxfKUSxGxesLgVoJs7PxxjzB/5xWveKgYKx
 VD57M7M1TJ5kFeqFO6fpPBMfSulGH1nJ0XIE0agVV8pZd0F44xJz8SdsTuVtGqIRW5LW
 fQKb4NTP2LsuW29CjNHEPMGU0ebdHE4qgRZee3PUTbD7KgoG9lxJgAfbf4mbMM2sct3j
 KYv36/234FYtRA+ObokPLZj5B5aZ7T7/u2wwQmKXnp6kyUh9nFtt5G6lFgKnTHWmHtyF
 8AhQ==
X-Gm-Message-State: AOJu0YzyhLVfdTT2Rl+S1tQ4pxWNlvviu4Sd38Mf3w1lNdZjcqvYrSvk
 f+gjKFTbUcodh2DAymQzI6Vbn22L2aozi5GzmcPJJa4L6kiAVDy/4nluIixr3MOH8XvehU59F2z
 5KBIW4Afi2CxqBWtTJGkp/tniTf1OwAnGBsWt1YtRoXaBvLEuixjJMePsxGT/AZkmUTwvjGLtEV
 FsgitU6PCvypwTkW0zJq3jA1XRApHkadI=
X-Gm-Gg: ASbGncvpcwTh4Pw25bGAEdGEoZMaxtBVvjsaGQoGteXe8Q+IEyCicZVJnxoHDyb2Anc
 BzNivZ0QFcFZST94CTcxZkmHbniH9qRI8nqr6k4QtxYbihAzdnxH4Jf1YnzA+6sy9Kfcu4hj9C0
 /mQIB8X8Hx3lvuP3HSg57ZvNmZE5CaWdI/gwKrU/rU2AZSnqBtiMKhKUUWEVVX0DVIFMXvgchGN
 X/dPx8eAE2vOdw=
X-Received: by 2002:a17:902:f64c:b0:295:1a5c:efff with SMTP id
 d9443c01a7336-2951a5cf611mr10549945ad.14.1761852685954; 
 Thu, 30 Oct 2025 12:31:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUUtuppKvY8S4yAFL6NMJABzokM5H71C1mMMgYwFlz+ilozz68tzLTSekwWLu3FD+wqGSezAbhuc3bwbydKDw=
X-Received: by 2002:a17:902:f64c:b0:295:1a5c:efff with SMTP id
 d9443c01a7336-2951a5cf611mr10549605ad.14.1761852685474; Thu, 30 Oct 2025
 12:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144805.2239954-1-berrange@redhat.com>
 <20251030144805.2239954-4-berrange@redhat.com>
In-Reply-To: <20251030144805.2239954-4-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Oct 2025 23:31:14 +0400
X-Gm-Features: AWmQ_bn386RmINEpl8rCSDD6dWsJVusKue7DF8iM2WvyZ65cg_tFhJ2K4WkHlmY
Message-ID: <CAMxuvaw-Vf5vHf7NPuqFjA80KQVFBOi=QPTkasFc6sEL8A-HcA@mail.gmail.com>
Subject: Re: [PATCH 03/21] crypto: replace stat() with access() for credential
 checks
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="00000000000076ee9c0642654b69"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000076ee9c0642654b69
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Oct 30, 2025 at 6:48=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> Readability of the credential files is what matters for our usage,
> so access() is more appropriate than stat().
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  crypto/tlscreds.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
> index 9e59594d67..208a7e6d8f 100644
> --- a/crypto/tlscreds.c
> +++ b/crypto/tlscreds.c
> @@ -100,7 +100,6 @@ qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,
>                             char **cred,
>                             Error **errp)
>  {
> -    struct stat sb;
>      int ret =3D -1;
>
>      if (!creds->dir) {
> @@ -114,7 +113,7 @@ qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,
>
>      *cred =3D g_strdup_printf("%s/%s", creds->dir, filename);
>
> -    if (stat(*cred, &sb) < 0) {
> +    if (access(*cred, R_OK) < 0) {
>          if (errno =3D=3D ENOENT && !required) {
>              ret =3D 0;
>          } else {
> --
> 2.51.1
>
>

--00000000000076ee9c0642654b69
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30, 2025 at 6:48=E2=80=
=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" ta=
rget=3D"_blank">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Readability of the credential files is w=
hat matters for our usage,<br>
so access() is more appropriate than stat().<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>=
&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
---<br>
=C2=A0crypto/tlscreds.c | 3 +--<br>
=C2=A01 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c<br>
index 9e59594d67..208a7e6d8f 100644<br>
--- a/crypto/tlscreds.c<br>
+++ b/crypto/tlscreds.c<br>
@@ -100,7 +100,6 @@ qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 char **cred,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 struct stat sb;<br>
=C2=A0 =C2=A0 =C2=A0int ret =3D -1;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!creds-&gt;dir) {<br>
@@ -114,7 +113,7 @@ qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,<br>
<br>
=C2=A0 =C2=A0 =C2=A0*cred =3D g_strdup_printf(&quot;%s/%s&quot;, creds-&gt;=
dir, filename);<br>
<br>
-=C2=A0 =C2=A0 if (stat(*cred, &amp;sb) &lt; 0) {<br>
+=C2=A0 =C2=A0 if (access(*cred, R_OK) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (errno =3D=3D ENOENT &amp;&amp; !requi=
red) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div>
</div>

--00000000000076ee9c0642654b69--


