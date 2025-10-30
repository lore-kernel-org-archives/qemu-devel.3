Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F34DCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 19:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEYZF-0000L9-V4; Thu, 30 Oct 2025 15:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYZ8-0000Jn-Tl
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:44:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYYv-0007bn-1X
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761853423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d/6FJ20xG/uLCLhvt6IlIkObWKuPEXqGYQPKsxzsK2E=;
 b=dyAXAQiA/Ip1xJJRi2Aj9nOpHNHLWLHiYDCLG8byBQVc2TEVpMhzhiS0KxbKGFcRq5iwTV
 7FIBPjALlr/zslD4+xMGLUQbFhTjptVa+W1dNUr4188DFebKObQptoDLFtzHdhSny2FOrS
 WmnMr7drD/TAnFm4uHkybzyxmgV1K9k=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600--DVvqmcWNHiLD6WvlVU3pA-1; Thu, 30 Oct 2025 15:43:42 -0400
X-MC-Unique: -DVvqmcWNHiLD6WvlVU3pA-1
X-Mimecast-MFC-AGG-ID: -DVvqmcWNHiLD6WvlVU3pA_1761853421
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-294880e7ca4so28838065ad.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 12:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761853421; x=1762458221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d/6FJ20xG/uLCLhvt6IlIkObWKuPEXqGYQPKsxzsK2E=;
 b=pTSLP5WHy/kBIGyPQdlZga6brfMmAY5lZ+cpw2MKQQoKU18UKoADlr/VhlwG95SU5y
 jLo01p+LSKrKfJvf/O/4CchluWtdPuTJIy4n6LyCR96X/F2TM5qlwDFOaQ5svjUXcIGn
 5807VMxumbFuuKXl5LzMWiptawD+E2kdVU59tGcDENNaLT/egzSzdmqtKiN5o5lCl0aY
 y7AS20qq3tJVrpAI4qPPlOMizvloFkDvtYkFiAlLG/hRwVw3oa5CyzqNPH2WM8bk5YWR
 q6dBOkjHEbofMYUZ6rDHZMN+wpyroeNl5y4l3K8AivCQ+2SZKfg39CLGU//kdb8jCrvN
 R0Pw==
X-Gm-Message-State: AOJu0YwQFeEo6DathXawAXvddW6oTJYH1QC5eh3BZqmsuGpzcUiOmlBd
 SszeAGjktdDOSgvKAFmRQq5JRWdGrHMTcg6Q8DRVLWZN6wiazsG9vpwCpoCeU4aEvC/ZMFkt05j
 i4GQagAsXL9yqPdSPILXDuSmpLA/4nf2W97iooXKwLfIb6ALelLo8DD5f2mOLBsNUhPlG96+eT6
 MoRcfWOgKicLTdbDIQiL660sIttM61e1Q=
X-Gm-Gg: ASbGncs0FQlKr2hh0etyIkmDK7tWFxE/301wiGVT0Ard4zcHMAawf1ez90pHarqhpyy
 G6p7V0FwaRs9H9nCs50Jo/JFpRvdROmZDHxjD6qxs+9fqnm0e7plGx+Ep/m/yC+8Y2CB4fX9dZi
 6IC4nr2zN/T47aLaHQlSeMKiKnMb4KKVSq/nlZCRbDNjhPcLQoMXVeGwmjwWI5YUQDnqzvVI8Kq
 eHDJY2HvImdTcc=
X-Received: by 2002:a17:903:2f8f:b0:294:f6e2:cea5 with SMTP id
 d9443c01a7336-2951a49726amr12934825ad.28.1761853420983; 
 Thu, 30 Oct 2025 12:43:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYHR462C+Mri4IB2CUY/Jy3ThyeAT5k5TLSG+LiLc6AheE50wQfbb0Hqo6aNsBpINVQFZUXSaTb1N93Wmd7HM=
X-Received: by 2002:a17:903:2f8f:b0:294:f6e2:cea5 with SMTP id
 d9443c01a7336-2951a49726amr12934655ad.28.1761853420662; Thu, 30 Oct 2025
 12:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-13-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-13-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Oct 2025 23:43:29 +0400
X-Gm-Features: AWmQ_bmn9l_NJb5EIVzxb89nAjeh10svwL8BWVleTFvnsFBQuLfNa0Fawqk_wNY
Message-ID: <CAMxuvayxhJS2jDpkJNAtST1uLomrvmYX1upNkDTxKF26450rmg@mail.gmail.com>
Subject: Re: [PATCH 12/21] crypto: introduce method for reloading TLS creds
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="0000000000004903e306426577e4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--0000000000004903e306426577e4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:49=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> This prevents direct access of the class members by the VNC
> display code.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  crypto/tlscreds.c         | 15 +++++++++++++++
>  include/crypto/tlscreds.h | 13 +++++++++++++
>  ui/vnc.c                  |  9 +--------
>  3 files changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
> index 49c7eb46a5..9433b4c363 100644
> --- a/crypto/tlscreds.c
> +++ b/crypto/tlscreds.c
> @@ -281,6 +281,21 @@ char *qcrypto_tls_creds_get_priority(QCryptoTLSCreds
> *creds)
>  }
>
>
> +bool qcrypto_tls_creds_reload(QCryptoTLSCreds *creds,
> +                              Error **errp)
> +{
> +    QCryptoTLSCredsClass *credscls =3D
> QCRYPTO_TLS_CREDS_GET_CLASS(OBJECT(creds));
> +
>

OBJECT() unnecessary here


> +    if (credscls->reload) {
> +        return credscls->reload(creds, errp);
> +    }
> +
> +    error_setg(errp, "%s does not support reloading credentials",
> +               object_get_typename(OBJECT(creds)));
> +    return false;
> +}
> +
> +
>  static const TypeInfo qcrypto_tls_creds_info =3D {
>      .parent =3D TYPE_OBJECT,
>      .name =3D TYPE_QCRYPTO_TLS_CREDS,
> diff --git a/include/crypto/tlscreds.h b/include/crypto/tlscreds.h
> index afd1016088..bb9280ed1a 100644
> --- a/include/crypto/tlscreds.h
> +++ b/include/crypto/tlscreds.h
> @@ -77,4 +77,17 @@ bool qcrypto_tls_creds_check_endpoint(QCryptoTLSCreds
> *creds,
>   */
>  char *qcrypto_tls_creds_get_priority(QCryptoTLSCreds *creds);
>
> +
> +/**
> + * qcrypto_tls_creds_reload:
> + * @creds: pointer to a TLS credentials object
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Request a reload of the TLS credentials, if supported
> + *
> + * Returns: true on success, false on error or if not supported
> + */
> +bool qcrypto_tls_creds_reload(QCryptoTLSCreds *creds,
> +                              Error **errp);
> +
>  #endif /* QCRYPTO_TLSCREDS_H */
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 77c823bf2e..6b32dd0fe9 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -578,7 +578,6 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
>  bool vnc_display_reload_certs(const char *id, Error **errp)
>  {
>      VncDisplay *vd =3D vnc_display_find(id);
> -    QCryptoTLSCredsClass *creds =3D NULL;
>
>      if (!vd) {
>          error_setg(errp, "Can not find vnc display");
> @@ -590,13 +589,7 @@ bool vnc_display_reload_certs(const char *id, Error
> **errp)
>          return false;
>      }
>
> -    creds =3D QCRYPTO_TLS_CREDS_GET_CLASS(OBJECT(vd->tlscreds));
> -    if (creds->reload =3D=3D NULL) {
> -        error_setg(errp, "%s doesn't support to reload TLS credential",
> -                   object_get_typename(OBJECT(vd->tlscreds)));
> -        return false;
> -    }
> -    if (!creds->reload(vd->tlscreds, errp)) {
> +    if (!qcrypto_tls_creds_reload(vd->tlscreds, errp)) {
>          return false;
>      }
>
> --
> 2.51.1
>
>

--0000000000004903e306426577e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30,=
 2025 at 6:49=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berr=
ange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">This prevents direct access of the clas=
s members by the VNC<br>
display code.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0crypto/tlscreds.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 15 +++++++++++++=
++<br>
=C2=A0include/crypto/tlscreds.h | 13 +++++++++++++<br>
=C2=A0ui/vnc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 9 +--------<br>
=C2=A03 files changed, 29 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c<br>
index 49c7eb46a5..9433b4c363 100644<br>
--- a/crypto/tlscreds.c<br>
+++ b/crypto/tlscreds.c<br>
@@ -281,6 +281,21 @@ char *qcrypto_tls_creds_get_priority(QCryptoTLSCreds *=
creds)<br>
=C2=A0}<br>
<br>
<br>
+bool qcrypto_tls_creds_reload(QCryptoTLSCreds *creds,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 QCryptoTLSCredsClass *credscls =3D QCRYPTO_TLS_CREDS_GET_CLA=
SS(OBJECT(creds));<br>
+<br></blockquote><div><br></div><div>OBJECT() unnecessary here</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 if (credscls-&gt;reload) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return credscls-&gt;reload(creds, errp);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 error_setg(errp, &quot;%s does not support reloading credent=
ials&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_get_typename=
(OBJECT(creds)));<br>
+=C2=A0 =C2=A0 return false;<br>
+}<br>
+<br>
+<br>
=C2=A0static const TypeInfo qcrypto_tls_creds_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.parent =3D TYPE_OBJECT,<br>
=C2=A0 =C2=A0 =C2=A0.name =3D TYPE_QCRYPTO_TLS_CREDS,<br>
diff --git a/include/crypto/tlscreds.h b/include/crypto/tlscreds.h<br>
index afd1016088..bb9280ed1a 100644<br>
--- a/include/crypto/tlscreds.h<br>
+++ b/include/crypto/tlscreds.h<br>
@@ -77,4 +77,17 @@ bool qcrypto_tls_creds_check_endpoint(QCryptoTLSCreds *c=
reds,<br>
=C2=A0 */<br>
=C2=A0char *qcrypto_tls_creds_get_priority(QCryptoTLSCreds *creds);<br>
<br>
+<br>
+/**<br>
+ * qcrypto_tls_creds_reload:<br>
+ * @creds: pointer to a TLS credentials object<br>
+ * @errp: pointer to a NULL-initialized error object<br>
+ *<br>
+ * Request a reload of the TLS credentials, if supported<br>
+ *<br>
+ * Returns: true on success, false on error or if not supported<br>
+ */<br>
+bool qcrypto_tls_creds_reload(QCryptoTLSCreds *creds,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp);<br>
+<br>
=C2=A0#endif /* QCRYPTO_TLSCREDS_H */<br>
diff --git a/ui/vnc.c b/ui/vnc.c<br>
index 77c823bf2e..6b32dd0fe9 100644<br>
--- a/ui/vnc.c<br>
+++ b/ui/vnc.c<br>
@@ -578,7 +578,6 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)<br>
=C2=A0bool vnc_display_reload_certs(const char *id, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VncDisplay *vd =3D vnc_display_find(id);<br>
-=C2=A0 =C2=A0 QCryptoTLSCredsClass *creds =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!vd) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Can not find vnc d=
isplay&quot;);<br>
@@ -590,13 +589,7 @@ bool vnc_display_reload_certs(const char *id, Error **=
errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 creds =3D QCRYPTO_TLS_CREDS_GET_CLASS(OBJECT(vd-&gt;tlscreds=
));<br>
-=C2=A0 =C2=A0 if (creds-&gt;reload =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;%s doesn&#39;t support =
to reload TLS credential&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0objec=
t_get_typename(OBJECT(vd-&gt;tlscreds)));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 if (!creds-&gt;reload(vd-&gt;tlscreds, errp)) {<br>
+=C2=A0 =C2=A0 if (!qcrypto_tls_creds_reload(vd-&gt;tlscreds, errp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div>

--0000000000004903e306426577e4--


