Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4BDCCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 19:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEYNj-0002Zn-DK; Thu, 30 Oct 2025 15:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYNh-0002ZJ-H4
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:32:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYNY-0005ka-SX
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761852727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1LPFtosjhY9o+m5lCmIf+ytgKdFi7vCAxxVanEmWzW4=;
 b=G8wpWsg1oDLU6IwCiUdtFUSLQagVtQOs0gjOdotlC2nnmvUiDVN88x+IEqjVhRopeGLEWz
 nsrc2Hzxog61uGobIhbMNyjRrA4k+Df6e4JkE2/AM6kkuYY/KM1DwF0NFoX+BK6skG6qbq
 n8fx7KXG/XwLXcj5NXtuWtO1Qdr7TQU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-qEW0ewrENwSjVTdskBwPxw-1; Thu, 30 Oct 2025 15:32:05 -0400
X-MC-Unique: qEW0ewrENwSjVTdskBwPxw-1
X-Mimecast-MFC-AGG-ID: qEW0ewrENwSjVTdskBwPxw_1761852724
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3407734d9a2so488562a91.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 12:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761852724; x=1762457524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1LPFtosjhY9o+m5lCmIf+ytgKdFi7vCAxxVanEmWzW4=;
 b=G1OoIcIr9pTSBDhXs3/Qo8VtohaaDWIzpsX7g1qV//Smo2q8dr6o0ZuDJPWWq5g4Fs
 IYcXMW1BrLPBJewAD3tjP14pRuCSi56XNI/b7dMt/iuTN6oMowBwhHuhnpoPhEmHFe7F
 orr5BbqDjDYBr6TNHJmwO6lvYCT8p+YWbKX7q0JkF3HpHecFFxSUQ6S5PmHfmzymlpep
 d/S62oVM3jA0DBG2DUxEtkOKjDgregIa/p7QM3xJJnRHWrTNSN/rGQjUOZjz9aHdx0x+
 TEwVwC0IRGqSFWcUNax/7Fi3ZicXv2RfmbolkrhlPQ//Hkhc1j+PmlhR4tMHSkhKnn6O
 1ZXg==
X-Gm-Message-State: AOJu0Yxx9LuSOfaPV9z2DiA8XTRZK7rUweahMhmbw21b+KF704lDnj7J
 JdNjhNf7Ih5QY/P6euufffA8C7mzyLNNkA8wdPdSHryMdmOLhiK/Vd9XFKzy5C5zGOvrlyUnW5F
 F5GW/5kDe93ZW5kzJbfABfIMiMORxux4iNIy5mWSIUXEz2hA4Cn73bftRnQWYAIEGp9JcfzB4aS
 IzjUh34jYJeUOOUswdqftsVcT+nEP5kzDUzQCVOl8=
X-Gm-Gg: ASbGncsTiic5M4F7lnAKz/rhffXeFWr3erlD5lwpK/O/4wq66NP/lzmo6y/pdmz1fgU
 GKxpaJrl6aRFxbw5m1w0sbdVBm1blVhOdhMXoVEPhOiUuC2qFphN/xtPa0NW7sFhMKD1me6iOwV
 2VcBrXRwA/N9fE7FVW+dNsBNvaAMns5QfnxlBi9/qSW52Pqdws4+zsZW8oRmCYA4ehXvdKzgH4r
 R3YKLM/bJBU1ak=
X-Received: by 2002:a17:90b:2791:b0:33b:6ef4:c904 with SMTP id
 98e67ed59e1d1-3408307ecc4mr1160427a91.20.1761852723953; 
 Thu, 30 Oct 2025 12:32:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHBisTL6jOG3JqIbj3+r23JNQ14hztBZ1LU1uVlldDBy7kG/qQcm5BhjcY++JpThvJwOY/tNAjprmnDQWncog=
X-Received: by 2002:a17:90b:2791:b0:33b:6ef4:c904 with SMTP id
 98e67ed59e1d1-3408307ecc4mr1160403a91.20.1761852723574; Thu, 30 Oct 2025
 12:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-11-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-11-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Oct 2025 23:31:52 +0400
X-Gm-Features: AWmQ_bk1OhafHzkxrW-OxonYPsTCgwYqS42qNg7i05Cle-t7won30O4iqWtYQRE
Message-ID: <CAMxuvazVRsYq9Zzqje7JciH8QqPxYB2tX0x0vAGRvKGZAoRYLA@mail.gmail.com>
Subject: Re: [PATCH 10/21] crypto: remove duplication loading x509 CA cert
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="000000000000bc4b940642654d75"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000bc4b940642654d75
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Oct 30, 2025 at 6:49=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The CA cert is mandatory in both client and server scenarios.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  crypto/tlscredsx509.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
> index 08223781d7..f2f1aa2815 100644
> --- a/crypto/tlscredsx509.c
> +++ b/crypto/tlscredsx509.c
> @@ -578,11 +578,14 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509
> *creds,
>
>      trace_qcrypto_tls_creds_x509_load(creds, creds->parent_obj.dir);
>
> +    if (qcrypto_tls_creds_get_path(&creds->parent_obj,
> +                                   QCRYPTO_TLS_CREDS_X509_CA_CERT,
> +                                   true, &cacert, errp) < 0) {
> +        return -1;
> +    }
> +
>      if (isServer) {
>          if (qcrypto_tls_creds_get_path(&creds->parent_obj,
> -                                       QCRYPTO_TLS_CREDS_X509_CA_CERT,
> -                                       true, &cacert, errp) < 0 ||
> -            qcrypto_tls_creds_get_path(&creds->parent_obj,
>                                         QCRYPTO_TLS_CREDS_X509_CA_CRL,
>                                         false, &cacrl, errp) < 0 ||
>              qcrypto_tls_creds_get_path(&creds->parent_obj,
> @@ -598,9 +601,6 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,
>          }
>      } else {
>          if (qcrypto_tls_creds_get_path(&creds->parent_obj,
> -                                       QCRYPTO_TLS_CREDS_X509_CA_CERT,
> -                                       true, &cacert, errp) < 0 ||
> -            qcrypto_tls_creds_get_path(&creds->parent_obj,
>                                         QCRYPTO_TLS_CREDS_X509_CLIENT_CER=
T,
>                                         false, &cert, errp) < 0 ||
>              qcrypto_tls_creds_get_path(&creds->parent_obj,
> --
> 2.51.1
>
>

--000000000000bc4b940642654d75
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30, 2025 at 6:49=E2=80=
=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" ta=
rget=3D"_blank">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">The CA cert is mandatory in both client =
and server scenarios.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>=
&gt;=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
---<br>
=C2=A0crypto/tlscredsx509.c | 12 ++++++------<br>
=C2=A01 file changed, 6 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c<br>
index 08223781d7..f2f1aa2815 100644<br>
--- a/crypto/tlscredsx509.c<br>
+++ b/crypto/tlscredsx509.c<br>
@@ -578,11 +578,14 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_qcrypto_tls_creds_x509_load(creds, creds-&gt;pare=
nt_obj.dir);<br>
<br>
+=C2=A0 =C2=A0 if (qcrypto_tls_creds_get_path(&amp;creds-&gt;parent_obj,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QCRYPTO_TLS_CREDS_X509_=
CA_CERT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0true, &amp;cacert, errp=
) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (isServer) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qcrypto_tls_creds_get_path(&amp;creds=
-&gt;parent_obj,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QCRYPTO_T=
LS_CREDS_X509_CA_CERT,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0true, &am=
p;cacert, errp) &lt; 0 ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qcrypto_tls_creds_get_path(&amp;=
creds-&gt;parent_obj,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QCRYPTO_=
TLS_CREDS_X509_CA_CRL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 false, &=
amp;cacrl, errp) &lt; 0 ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qcrypto_tls_creds_get_path(=
&amp;creds-&gt;parent_obj,<br>
@@ -598,9 +601,6 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qcrypto_tls_creds_get_path(&amp;creds=
-&gt;parent_obj,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QCRYPTO_T=
LS_CREDS_X509_CA_CERT,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0true, &am=
p;cacert, errp) &lt; 0 ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qcrypto_tls_creds_get_path(&amp;=
creds-&gt;parent_obj,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QCRYPTO_=
TLS_CREDS_X509_CLIENT_CERT,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 false, &=
amp;cert, errp) &lt; 0 ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qcrypto_tls_creds_get_path(=
&amp;creds-&gt;parent_obj,<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div>
</div>

--000000000000bc4b940642654d75--


