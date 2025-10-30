Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2703BCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 19:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEYNK-0002OD-6C; Thu, 30 Oct 2025 15:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYNF-0002MV-Ju
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEYNB-0005hL-E7
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 15:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761852705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5cG48Y0bY2n6sp8hcRMtxt5q6Afhdu2+xzl0JEYxuO8=;
 b=HDQGGil/sMK88Ovntju4YR9PvK7szlDG2ebrydxAfCd3jj1cMWeymKItJvj1zvUTTCDZIl
 2ywIUg0INgseszhNEufdhXj7Y+aO8K+Crpx99Fe7lp4U9FR0M+EdEKsHQcHg36XWPBq+1n
 4bLeUnXf+7974QVYjiqfH/v3mOaTYA8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-dT8TFWbjN96pbxm3R0SI3A-1; Thu, 30 Oct 2025 15:31:43 -0400
X-MC-Unique: dT8TFWbjN96pbxm3R0SI3A-1
X-Mimecast-MFC-AGG-ID: dT8TFWbjN96pbxm3R0SI3A_1761852702
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-290992f9693so19952845ad.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 12:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761852702; x=1762457502;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5cG48Y0bY2n6sp8hcRMtxt5q6Afhdu2+xzl0JEYxuO8=;
 b=luYUcYoSmeVz+b/9/FdbivdpuIGlMtXZqLzWXVBKCsKoTZy9V24M/7rbaXNgQr8FEM
 cB1nf7KgtGD5WAmGCMM2NQFDxlOlYiOopf4tFjoCoJn7uyKNCemQz7hk3MgCkYNv4n1o
 jWietOVrV4Wgs2ePAYWJD6+Tdq5ezW/p1wc4TrwhaK7jKd8bvfZZszvPXjXmIHonBvLV
 wDaI46fLICTPrbRU1MTjx+jgD1DUWIVn4/1w2LuJhx6cDN/CGhScG9LqQPhe2b6haoBO
 Bnwm2RVbNOGz0w4AGq/1T4AYaWhWlpPCUXL244Yn54FKGf8ReJXr2cC+9KfCI+FGimSQ
 Q1Ww==
X-Gm-Message-State: AOJu0YxbMMNKjcf881PXsJXkE2ov/TsJSB9g6iAAsf8XC8HgP5dppF0V
 HjyG7QufrZb7L5TBI+EV9Kbp897hB+zPHz7oGFAtRrAthqg+F45XA0O8wJW/X2OO80C2S2wd/k0
 HrbbelJZ0n7dqwOm2I7W99E0u4lypblbdaZPxZFshzGE2WcUq3dRmqdUzhvP2cgLGsXhgL9rAiB
 F2hcjiMvTJd0jSVnsBRxYdXgUsESOCvI+aE9ABSnw=
X-Gm-Gg: ASbGncurboG5Js2rFqhSS+Bt0XGcKGxctYnVlbtM1VuODusmw5wezWGMxmTP3nKqoKE
 sbqKhr1WX3svBCXqmatikbTMgMsrisx9/ZixH0whuc1faBqko3iowMK6RJYjJ4fXqgFhhcobYcP
 lASTAtWM7oEN6AVH3ugVqI13MfHtGio0H41xASlWPpJ5K3m2ZOoasHpFuZWoMs37v4NH2KxjaFY
 q1xSVD4tIZvOA0=
X-Received: by 2002:a17:90b:3b50:b0:33d:a6a6:2e26 with SMTP id
 98e67ed59e1d1-3404ac9225fmr5752395a91.13.1761852702126; 
 Thu, 30 Oct 2025 12:31:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9tIAKxgHe8uLEDcugnFoLZZ062yZDGOsHXy5tjcnDQoiqIN/XT8akKTyV/Y6HinfcsUUwlmbYFivd/tCsysM=
X-Received: by 2002:a17:90b:3b50:b0:33d:a6a6:2e26 with SMTP id
 98e67ed59e1d1-3404ac9225fmr5752371a91.13.1761852701701; Thu, 30 Oct 2025
 12:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144805.2239954-1-berrange@redhat.com>
 <20251030144805.2239954-6-berrange@redhat.com>
In-Reply-To: <20251030144805.2239954-6-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Oct 2025 23:31:29 +0400
X-Gm-Features: AWmQ_bkYf7hVuR2VC9JDUGm3h9q6uX4ofU7wxa0vHSgx4PVbDrT3Srhsx4KY_Po
Message-ID: <CAMxuvay=4bvkm1Rz2mJqkdGD20bJ8kSO0MFXcXd3gip6usO6RQ@mail.gmail.com>
Subject: Re: [PATCH 05/21] crypto: move check for TLS creds 'dir' property
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="0000000000006e88950642654ca3"
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

--0000000000006e88950642654ca3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Oct 30, 2025 at 6:48=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The check for the 'dir' property is being repeated for every
> credential file to be loaded, but this results in incorrect
> logic for optional credentials. The 'dir' property is mandatory
> for PSK and x509 creds, even if some individual files are
> optional. Address this by separating the check for the 'dir'
> property.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  crypto/tlscreds.c     | 9 ---------
>  crypto/tlscredsanon.c | 3 ++-
>  crypto/tlscredspsk.c  | 5 +++++
>  crypto/tlscredsx509.c | 8 ++++++--
>  4 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
> index 208a7e6d8f..65e97ddd11 100644
> --- a/crypto/tlscreds.c
> +++ b/crypto/tlscreds.c
> @@ -102,15 +102,6 @@ qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,
>  {
>      int ret =3D -1;
>
> -    if (!creds->dir) {
> -        if (required) {
> -            error_setg(errp, "Missing 'dir' property value");
> -            return -1;
> -        } else {
> -            return 0;
> -        }
> -    }
> -
>      *cred =3D g_strdup_printf("%s/%s", creds->dir, filename);
>
>      if (access(*cred, R_OK) < 0) {
> diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
> index 44af9e6c9a..bc3351b5d6 100644
> --- a/crypto/tlscredsanon.c
> +++ b/crypto/tlscredsanon.c
> @@ -43,7 +43,8 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
>              creds->parent_obj.dir ? creds->parent_obj.dir : "<nodir>");
>
>      if (creds->parent_obj.endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SER=
VER) {
> -        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
> +        if (creds->parent_obj.dir &&
> +            qcrypto_tls_creds_get_path(&creds->parent_obj,
>                                         QCRYPTO_TLS_CREDS_DH_PARAMS,
>                                         false, &dhparams, errp) < 0) {
>              return -1;
> diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
> index 5b68a6b7ba..545d3e45db 100644
> --- a/crypto/tlscredspsk.c
> +++ b/crypto/tlscredspsk.c
> @@ -81,6 +81,11 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
>      trace_qcrypto_tls_creds_psk_load(creds,
>              creds->parent_obj.dir ? creds->parent_obj.dir : "<nodir>");
>
> +    if (!creds->parent_obj.dir) {
> +        error_setg(errp, "Missing 'dir' property value");
> +        goto cleanup;
> +    }
> +
>      if (creds->parent_obj.endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SER=
VER) {
>          if (creds->username) {
>              error_setg(errp, "username should not be set when
> endpoint=3Dserver");
> diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
> index 0acb17b6ec..8fe6cc8e93 100644
> --- a/crypto/tlscredsx509.c
> +++ b/crypto/tlscredsx509.c
> @@ -567,8 +567,12 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509
> *creds,
>      int ret;
>      int rv =3D -1;
>
> -    trace_qcrypto_tls_creds_x509_load(creds,
> -            creds->parent_obj.dir ? creds->parent_obj.dir : "<nodir>");
> +    if (!creds->parent_obj.dir) {
> +        error_setg(errp, "Missing 'dir' property value");
> +        return -1;
> +    }
> +
> +    trace_qcrypto_tls_creds_x509_load(creds, creds->parent_obj.dir);
>
>      if (creds->parent_obj.endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SER=
VER) {
>          if (qcrypto_tls_creds_get_path(&creds->parent_obj,
> --
> 2.51.1
>
>

--0000000000006e88950642654ca3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30, 2025=
 at 6:48=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@=
redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">The check for the &#39;dir=
&#39; property is being repeated for every<br>
credential file to be loaded, but this results in incorrect<br>
logic for optional credentials. The &#39;dir&#39; property is mandatory<br>
for PSK and x509 creds, even if some individual files are<br>
optional. Address this by separating the check for the &#39;dir&#39;<br>
property.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>=
&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
---<br>
=C2=A0crypto/tlscreds.c=C2=A0 =C2=A0 =C2=A0| 9 ---------<br>
=C2=A0crypto/tlscredsanon.c | 3 ++-<br>
=C2=A0crypto/tlscredspsk.c=C2=A0 | 5 +++++<br>
=C2=A0crypto/tlscredsx509.c | 8 ++++++--<br>
=C2=A04 files changed, 13 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c<br>
index 208a7e6d8f..65e97ddd11 100644<br>
--- a/crypto/tlscreds.c<br>
+++ b/crypto/tlscreds.c<br>
@@ -102,15 +102,6 @@ qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int ret =3D -1;<br>
<br>
-=C2=A0 =C2=A0 if (!creds-&gt;dir) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (required) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Missing &=
#39;dir&#39; property value&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0*cred =3D g_strdup_printf(&quot;%s/%s&quot;, creds-&gt;=
dir, filename);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (access(*cred, R_OK) &lt; 0) {<br>
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c<br>
index 44af9e6c9a..bc3351b5d6 100644<br>
--- a/crypto/tlscredsanon.c<br>
+++ b/crypto/tlscredsanon.c<br>
@@ -43,7 +43,8 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0creds-&gt;parent_obj.dir ? =
creds-&gt;parent_obj.dir : &quot;&lt;nodir&gt;&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (creds-&gt;parent_obj.endpoint =3D=3D QCRYPTO_TLS_CR=
EDS_ENDPOINT_SERVER) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qcrypto_tls_creds_get_path(&amp;creds-&gt;=
parent_obj,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (creds-&gt;parent_obj.dir &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qcrypto_tls_creds_get_path(&amp;=
creds-&gt;parent_obj,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QCRYPTO_=
TLS_CREDS_DH_PARAMS,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 false, &=
amp;dhparams, errp) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c<br>
index 5b68a6b7ba..545d3e45db 100644<br>
--- a/crypto/tlscredspsk.c<br>
+++ b/crypto/tlscredspsk.c<br>
@@ -81,6 +81,11 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,<br=
>
=C2=A0 =C2=A0 =C2=A0trace_qcrypto_tls_creds_psk_load(creds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0creds-&gt;parent_obj.dir ? =
creds-&gt;parent_obj.dir : &quot;&lt;nodir&gt;&quot;);<br>
<br>
+=C2=A0 =C2=A0 if (!creds-&gt;parent_obj.dir) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Missing &#39;dir&#39; p=
roperty value&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (creds-&gt;parent_obj.endpoint =3D=3D QCRYPTO_TLS_CR=
EDS_ENDPOINT_SERVER) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (creds-&gt;username) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;user=
name should not be set when endpoint=3Dserver&quot;);<br>
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c<br>
index 0acb17b6ec..8fe6cc8e93 100644<br>
--- a/crypto/tlscredsx509.c<br>
+++ b/crypto/tlscredsx509.c<br>
@@ -567,8 +567,12 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds=
,<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
=C2=A0 =C2=A0 =C2=A0int rv =3D -1;<br>
<br>
-=C2=A0 =C2=A0 trace_qcrypto_tls_creds_x509_load(creds,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 creds-&gt;parent_obj.dir ? creds=
-&gt;parent_obj.dir : &quot;&lt;nodir&gt;&quot;);<br>
+=C2=A0 =C2=A0 if (!creds-&gt;parent_obj.dir) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Missing &#39;dir&#39; p=
roperty value&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 trace_qcrypto_tls_creds_x509_load(creds, creds-&gt;parent_ob=
j.dir);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (creds-&gt;parent_obj.endpoint =3D=3D QCRYPTO_TLS_CR=
EDS_ENDPOINT_SERVER) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (qcrypto_tls_creds_get_path(&amp;creds=
-&gt;parent_obj,<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div>
</div>

--0000000000006e88950642654ca3--


