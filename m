Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F71CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 19:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEYNV-0002TD-8k; Thu, 30 Oct 2025 15:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYNR-0002Rp-9x
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYNH-0005iM-Lg
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761852711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FSafgSelmBYGbvh6Pa+XoSfU6VKvJfIXW27JNpwCGV8=;
 b=Rq+rWGAfNXu9jJbgQUp1nDJy1PyO7W2+HFzxdpmto6tn4miS+NqvLsh3IJG+tXMyWTws2O
 Ew7zwXuGT7L8+hyLbEbYAJ2Zpz+jLNG+cYPK2FLBvTxptPO7OK09x3vL+EK/sfDNxCakiq
 zMID8RMHiQhA0b0Hhl/oV5JgiIgnQEU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-shP0sp4sOv-fAn17TSx8Ew-1; Thu, 30 Oct 2025 15:31:49 -0400
X-MC-Unique: shP0sp4sOv-fAn17TSx8Ew-1
X-Mimecast-MFC-AGG-ID: shP0sp4sOv-fAn17TSx8Ew_1761852708
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2909daa65f2so25972665ad.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 12:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761852708; x=1762457508;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FSafgSelmBYGbvh6Pa+XoSfU6VKvJfIXW27JNpwCGV8=;
 b=NjxvnZo/q1WEPEBk8b7zzyE8hqRCVug2rsSI+p1xcscCWDdXgSXL2sULW7iXvvFo7F
 wDZcIqztN8S50gz5s6/mKkbRLCkW4CLQLAMVk6R3zWTiBcUqwukTS0AeddBE3fSg7eAm
 RaEEVDtl9EYdBdUv5itZvlmyDHpPUcASBalCwR5N5ueAifngZk78udrp1MTk3oXA9fKu
 tfTUqnK4detkZrh+N9k/1pVtqqKgTdrXytcf9P4tbM/386qEilgZ8lzSfnMFrAqa8Tzw
 WLAhFC2lSdX5wEXcz2J/3FSBNbX3n1VJAnzi8UnAxfQWuP2usJAUK6LXUKt1Ec62JNcJ
 Tj5Q==
X-Gm-Message-State: AOJu0Yzn2vznig7BHzjoudKIJSqmuU86Tk7syfE39FppLKxPsrxn0Dzn
 XmbkJ1qa2Q41jarQdIjFlPSwhsJJgavArW1ocFZF2t8fEcPQG1dJdXlZQ5LL+NwQUggqQaZCthK
 nqAbzRicggmlC2mrQpHM0Vfy0sxm4eNc8VWPlak5ozjp2RTN/eL0lJQMhq4QGiC2DaUUvONa+ij
 ly5PWiqliPqoNyL6sRXaTZAYLhk4oUqi8=
X-Gm-Gg: ASbGnct6aFfC3SoiKvta/oTX4pP/qmwks7xoYRgV8XXrJSKP9kcfhNFL2xtM/2qCd2C
 vejEJPtM5EW/pZ6Rzf2PZ4csJvykkrlZLh6ERFJWzrhzAQiJc2uXBRDguN2GBQp7MwXqncyfSPy
 zbNLf7zt53F9cqgbyKw96ReMPDPN6alp9QsZSOyY4uM2dYfp9uo4jeB42MLGGGUwB/W5742lVY8
 A9a+DaQQKyAOtY=
X-Received: by 2002:a17:90b:3b41:b0:32e:3592:581a with SMTP id
 98e67ed59e1d1-34081c76daemr1420842a91.17.1761852707908; 
 Thu, 30 Oct 2025 12:31:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdyd63ittq64tAE1cHw5WHY6x+FuWa1YjSyU/udThDZ5nNTUluJUgsEMsKtJk1FIKr+SKYZm9zQB72WnurFOk=
X-Received: by 2002:a17:90b:3b41:b0:32e:3592:581a with SMTP id
 98e67ed59e1d1-34081c76daemr1420813a91.17.1761852707524; Thu, 30 Oct 2025
 12:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-8-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-8-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Oct 2025 23:31:36 +0400
X-Gm-Features: AWmQ_bkrhfjL4W7kRSr_L_CE_-5k2zBvjcWHlbH11iV817HewyDr10jWjODiuwc
Message-ID: <CAMxuvazgxTB2_kOW595OJypwLoJSHUskwr9QRVmxkP0Q5C6B8w@mail.gmail.com>
Subject: Re: [PATCH 07/21] crypto: remove needless indirection via parent_obj
 field
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="000000000000c75e5b0642654ccd"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000c75e5b0642654ccd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Oct 30, 2025 at 6:49=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The reload method already has a pointer to the parent object in
> the 'creds' parameter that is passed in, so indirect access via
> the subclass 'parent_obj' field is redundant.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  crypto/tlscredsx509.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
> index e5b869a35f..39f80b33ad 100644
> --- a/crypto/tlscredsx509.c
> +++ b/crypto/tlscredsx509.c
> @@ -773,15 +773,15 @@ qcrypto_tls_creds_x509_reload(QCryptoTLSCreds
> *creds, Error **errp)
>      QCryptoTLSCredsX509 *x509_creds =3D QCRYPTO_TLS_CREDS_X509(creds);
>      Error *local_err =3D NULL;
>      gnutls_certificate_credentials_t creds_data =3D x509_creds->data;
> -    gnutls_dh_params_t creds_dh_params =3D x509_creds->parent_obj.dh_par=
ams;
> +    gnutls_dh_params_t creds_dh_params =3D creds->dh_params;
>
>      x509_creds->data =3D NULL;
> -    x509_creds->parent_obj.dh_params =3D NULL;
> +    creds->dh_params =3D NULL;
>      qcrypto_tls_creds_x509_load(x509_creds, &local_err);
>      if (local_err) {
>          qcrypto_tls_creds_x509_unload(x509_creds);
>          x509_creds->data =3D creds_data;
> -        x509_creds->parent_obj.dh_params =3D creds_dh_params;
> +        creds->dh_params =3D creds_dh_params;
>          error_propagate(errp, local_err);
>          return false;
>      }
> --
> 2.51.1
>
>

--000000000000c75e5b0642654ccd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30, 2025 at 6:49=E2=80=
=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" ta=
rget=3D"_blank">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">The reload method already has a pointer =
to the parent object in<br>
the &#39;creds&#39; parameter that is passed in, so indirect access via<br>
the subclass &#39;parent_obj&#39; field is redundant.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>=
&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
---<br>
=C2=A0crypto/tlscredsx509.c | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c<br>
index e5b869a35f..39f80b33ad 100644<br>
--- a/crypto/tlscredsx509.c<br>
+++ b/crypto/tlscredsx509.c<br>
@@ -773,15 +773,15 @@ qcrypto_tls_creds_x509_reload(QCryptoTLSCreds *creds,=
 Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0QCryptoTLSCredsX509 *x509_creds =3D QCRYPTO_TLS_CREDS_X=
509(creds);<br>
=C2=A0 =C2=A0 =C2=A0Error *local_err =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0gnutls_certificate_credentials_t creds_data =3D x509_cr=
eds-&gt;data;<br>
-=C2=A0 =C2=A0 gnutls_dh_params_t creds_dh_params =3D x509_creds-&gt;parent=
_obj.dh_params;<br>
+=C2=A0 =C2=A0 gnutls_dh_params_t creds_dh_params =3D creds-&gt;dh_params;<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0x509_creds-&gt;data =3D NULL;<br>
-=C2=A0 =C2=A0 x509_creds-&gt;parent_obj.dh_params =3D NULL;<br>
+=C2=A0 =C2=A0 creds-&gt;dh_params =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0qcrypto_tls_creds_x509_load(x509_creds, &amp;local_err)=
;<br>
=C2=A0 =C2=A0 =C2=A0if (local_err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qcrypto_tls_creds_x509_unload(x509_creds)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0x509_creds-&gt;data =3D creds_data;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 x509_creds-&gt;parent_obj.dh_params =3D creds_=
dh_params;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 creds-&gt;dh_params =3D creds_dh_params;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_propagate(errp, local_err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div>
</div>

--000000000000c75e5b0642654ccd--


