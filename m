Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1088ACCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnNe-0006xP-Ma; Fri, 31 Oct 2025 07:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEnNd-0006x8-Bq
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:33:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEnNX-0002Gk-NE
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761910387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sEb20HK7eSZm56T++WgMxDh1emREf5mlZ+KyxqhBJmI=;
 b=EOBlsLgvi4EzFvKWUaF30LZOrzh2ZTOLg+YnwWBtySBZTqm+uozX/MsPwQyLz2d6gvs7SZ
 mX1cvE6+Q/Nci1vXekyv/tOqU5YCb0WjfdpnWqMRE6ngGYqBLvK1WsTd4yeFaQP6HuybMS
 vHQjAY54AkBHVMcLz09mqpkX8ygRj/E=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-F1py5ZhfMFeg6JpwNGU0ug-1; Fri, 31 Oct 2025 07:33:05 -0400
X-MC-Unique: F1py5ZhfMFeg6JpwNGU0ug-1
X-Mimecast-MFC-AGG-ID: F1py5ZhfMFeg6JpwNGU0ug_1761910384
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-33d75897745so5431373a91.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761910384; x=1762515184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sEb20HK7eSZm56T++WgMxDh1emREf5mlZ+KyxqhBJmI=;
 b=ObxRm0n8xvX06Gc/z74JcPvQ4euoEe2BVVN7qBhPNa1ePYmLyO2eGVqCXTKzzdfXCX
 c7fTw4DQIaL7tLUsgVXxJQq3QKWuBQkmv0SYaJeZJd4s0Ts3FgXx10ZvbeuRQxRG2oUG
 4kVlWUdDOH1VhdB0rXsAFoj9ybemnYwRbvGEbNU45ZMxWpiWwR8bkoLsGO1OhtJHGByJ
 ygYzV3vyvcJ+OMkFRotsaJGLcSqw3Cl8Ooy95t9xIo81HmqIhqCWhUtMPd+A9L/rHfvd
 0FaFN3g7SDSKvqNOKmkaWpIRFKB0fDRnwOwx3MdliF+hDqyJE4rTRqJnQs9nsHbmURya
 +D/A==
X-Gm-Message-State: AOJu0YxVb2nmD5n0yFbdIENQrD1TBU6XKAQAqPftqKeGPZ4HbBqXhP6l
 7o6orByskznxHAHuF+M35k4XmFA1mn8Q10mwd56ppFpHJO93vWKD+WtRpYANzjZV63cPR1E1q+l
 ATAPA9YLauwZ8gCbvOu1hdcddFuSJuLZajk5asxcEs2Npgsge+6ZDPdHf053lhhrxQnQikTyi0J
 EOowWVPY3u1I2Cqz25MUC5M2Sydz98q4oztMprLbx7IA==
X-Gm-Gg: ASbGnctfPMMlcYnJsBBt49WLv18k5T4eGvh1/b+/DP/pd/q5qsKhCavhrOY92CuzrMa
 3QUxNJi9w9bqus5VW2sDHP+vBKVmwRG4TlIDRCPquy9tyxapj5B5RUXrdQitO/sIN5sTAAAhXdQ
 hf05Ae/4t8UBpSX/SnKynaLYPkxNxJPe+xnLGNUUgbXZ+HSb3dY7u+zixn3aeOmXYz9RCu7841q
 j4MMHzXi6bcmss=
X-Received: by 2002:a17:90b:5910:b0:33b:6650:57c3 with SMTP id
 98e67ed59e1d1-340830553e6mr4302510a91.21.1761910383676; 
 Fri, 31 Oct 2025 04:33:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOZI7q1j4A8Q137UN4aynnhFq5im5MM3m9a4OGIlA5dwkz0a8qJZqWv80om9YOpHRJH/i1lTGqeeHpUeY7oJg=
X-Received: by 2002:a17:90b:5910:b0:33b:6650:57c3 with SMTP id
 98e67ed59e1d1-340830553e6mr4302459a91.21.1761910383136; Fri, 31 Oct 2025
 04:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-17-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-17-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 31 Oct 2025 15:32:51 +0400
X-Gm-Features: AWmQ_blwecbO-p5U2A2z26xYJ7b7g8sGypoT1M8kdlAXI8urSCFcfhtTlyrd8TM
Message-ID: <CAMxuvawDsd+w_UFD7VJDq76BNzoEWL0tQvNt_ZC8soPVEdtTRg@mail.gmail.com>
Subject: Re: [PATCH 16/21] crypto: deprecate use of external dh-params.pem file
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="0000000000008367b6064272ba42"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000008367b6064272ba42
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Oct 30, 2025 at 6:50=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> GNUTLS has deprecated use of externally provided diffie-hellman
> parameters, since it will automatically negotiate DH params in
> accordance with RFC7919.
>

The doc says:
 Since 3.6.0, DH parameters are negotiated following RFC7919.

But QEMU doesn't require >=3D 3.6. Add a preliminary patch?


> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  crypto/tlscreds.c         | 24 ++++++++----------------
>  crypto/tlscredsanon.c     |  6 ++++--
>  crypto/tlscredspsk.c      |  6 ++++--
>  crypto/tlscredsx509.c     |  4 +++-
>  docs/about/deprecated.rst |  9 +++++++++
>  docs/system/tls.rst       | 12 +++++++-----
>  6 files changed, 35 insertions(+), 26 deletions(-)
>
> diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
> index 798c9712fb..85268f3b57 100644
> --- a/crypto/tlscreds.c
> +++ b/crypto/tlscreds.c
> @@ -22,6 +22,7 @@
>  #include "qapi/error.h"
>  #include "qapi-types-crypto.h"
>  #include "qemu/module.h"
> +#include "qemu/error-report.h"
>  #include "tlscredspriv.h"
>  #include "trace.h"
>
> @@ -38,22 +39,7 @@ qcrypto_tls_creds_get_dh_params_file(QCryptoTLSCreds
> *creds,
>
>      trace_qcrypto_tls_creds_load_dh(creds, filename ? filename :
> "<generated>");
>
> -    if (filename =3D=3D NULL) {
> -        ret =3D gnutls_dh_params_init(dh_params);
> -        if (ret < 0) {
> -            error_setg(errp, "Unable to initialize DH parameters: %s",
> -                       gnutls_strerror(ret));
> -            return -1;
> -        }
> -        ret =3D gnutls_dh_params_generate2(*dh_params, DH_BITS);
> -        if (ret < 0) {
> -            gnutls_dh_params_deinit(*dh_params);
> -            *dh_params =3D NULL;
> -            error_setg(errp, "Unable to generate DH parameters: %s",
> -                       gnutls_strerror(ret));
> -            return -1;
> -        }
> -    } else {
> +    if (filename !=3D NULL) {
>          GError *gerr =3D NULL;
>          gchar *contents;
>          gsize len;
> @@ -67,6 +53,10 @@ qcrypto_tls_creds_get_dh_params_file(QCryptoTLSCreds
> *creds,
>              g_error_free(gerr);
>              return -1;
>          }
> +        warn_report_once("Use of an external DH parameters file '%s' is =
"
> +                         "deprecated and will be removed in a future
> release",
> +                         filename);
> +
>          data.data =3D (unsigned char *)contents;
>          data.size =3D len;
>          ret =3D gnutls_dh_params_init(dh_params);
> @@ -87,6 +77,8 @@ qcrypto_tls_creds_get_dh_params_file(QCryptoTLSCreds
> *creds,
>                         filename, gnutls_strerror(ret));
>              return -1;
>          }
> +    } else {
> +        *dh_params =3D NULL;
>      }
>
>      return 0;
> diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
> index 69ed1d792a..777cc4f5bb 100644
> --- a/crypto/tlscredsanon.c
> +++ b/crypto/tlscredsanon.c
> @@ -68,8 +68,10 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds=
,
>              return -1;
>          }
>
> -        gnutls_anon_set_server_dh_params(box->data.anonserver,
> -                                         box->dh_params);
> +        if (box->dh_params) {
> +            gnutls_anon_set_server_dh_params(box->data.anonserver,
> +                                             box->dh_params);
> +        }
>      } else {
>          ret =3D
> gnutls_anon_allocate_client_credentials(&box->data.anonclient);
>          if (ret < 0) {
> diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
> index e437985260..801da50625 100644
> --- a/crypto/tlscredspsk.c
> +++ b/crypto/tlscredspsk.c
> @@ -129,8 +129,10 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds=
,
>                         gnutls_strerror(ret));
>              goto cleanup;
>          }
> -        gnutls_psk_set_server_dh_params(box->data.pskserver,
> -                                        box->dh_params);
> +        if (box->dh_params) {
> +            gnutls_psk_set_server_dh_params(box->data.pskserver,
> +                                            box->dh_params);
> +        }
>      } else {
>          box =3D qcrypto_tls_creds_box_new_client(GNUTLS_CRD_PSK);
>
> diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
> index 2fc0872627..7e79af4266 100644
> --- a/crypto/tlscredsx509.c
> +++ b/crypto/tlscredsx509.c
> @@ -684,7 +684,9 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,
>                                                   errp) < 0) {
>              return -1;
>          }
> -        gnutls_certificate_set_dh_params(box->data.cert, box->dh_params)=
;
> +        if (box->dh_params) {
> +            gnutls_certificate_set_dh_params(box->data.cert,
> box->dh_params);
> +        }
>      }
>      creds->parent_obj.box =3D g_steal_pointer(&box);
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index ca6b3769b5..694a69da64 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -365,6 +365,15 @@ Options are:
>      - move backing file to NVDIMM storage and keep ``pmem=3Don``
>        (to have NVDIMM with persistence guaranties).
>
> +Using an external DH (Diffie-Hellman) parameters file (since 10.2)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Loading of external Diffie-Hellman parameters from a 'dh-params.pem'
> +file is deprecated and will be removed with no replacement in a
> +future release. Where no 'dh-params.pem' file is provided, the DH
> +parameters will be automatically negotiated in accordance with
> +RFC7919.
> +
>  Device options
>  --------------
>
> diff --git a/docs/system/tls.rst b/docs/system/tls.rst
> index a4f6781d62..44c4bf04e9 100644
> --- a/docs/system/tls.rst
> +++ b/docs/system/tls.rst
> @@ -251,11 +251,13 @@ When specifying the object, the ``dir`` parameters
> specifies which
>  directory contains the credential files. This directory is expected to
>  contain files with the names mentioned previously, ``ca-cert.pem``,
>  ``server-key.pem``, ``server-cert.pem``, ``client-key.pem`` and
> -``client-cert.pem`` as appropriate. It is also possible to include a set
> -of pre-generated Diffie-Hellman (DH) parameters in a file
> -``dh-params.pem``, which can be created using the
> -``certtool --generate-dh-params`` command. If omitted, QEMU will
> -dynamically generate DH parameters when loading the credentials.
> +``client-cert.pem`` as appropriate.
> +
> +While it is possible to include a set of pre-generated Diffie-Hellman
> +(DH) parameters in a file ``dh-params.pem``, this facility is now
> +deprecated and will be removed in a future release. When omitted the
> +DH parameters will be automatically negotiated in accordance with
> +RFC7919.
>
>  The ``endpoint`` parameter indicates whether the credentials will be
>  used for a network client or server, and determines which PEM files are
> --
> 2.51.1
>
>

--0000000000008367b6064272ba42
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30, 2025 at 6:50=
=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.c=
om">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">GNUTLS has deprecated use of externally provided dif=
fie-hellman<br>
parameters, since it will automatically negotiate DH params in<br>
accordance with RFC7919.<br></blockquote><div><br></div><div>The doc says:<=
/div><div>=C2=A0Since 3.6.0, DH parameters are negotiated
following RFC7919.</div><div><br></div><div>But QEMU doesn&#39;t require &g=
t;=3D 3.6. Add a preliminary patch?</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
</blockquote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a=
 href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a=
>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">---<br>
=C2=A0crypto/tlscreds.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 24 ++++++++-----=
-----------<br>
=C2=A0crypto/tlscredsanon.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++++--<br>
=C2=A0crypto/tlscredspsk.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 ++++--<br>
=C2=A0crypto/tlscredsx509.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 +++-<br>
=C2=A0docs/about/deprecated.rst |=C2=A0 9 +++++++++<br>
=C2=A0docs/system/tls.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 +++++++-----<br>
=C2=A06 files changed, 35 insertions(+), 26 deletions(-)<br>
<br>
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c<br>
index 798c9712fb..85268f3b57 100644<br>
--- a/crypto/tlscreds.c<br>
+++ b/crypto/tlscreds.c<br>
@@ -22,6 +22,7 @@<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qapi-types-crypto.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
+#include &quot;qemu/error-report.h&quot;<br>
=C2=A0#include &quot;tlscredspriv.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
<br>
@@ -38,22 +39,7 @@ qcrypto_tls_creds_get_dh_params_file(QCryptoTLSCreds *cr=
eds,<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_qcrypto_tls_creds_load_dh(creds, filename ? filen=
ame : &quot;&lt;generated&gt;&quot;);<br>
<br>
-=C2=A0 =C2=A0 if (filename =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_dh_params_init(dh_params);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Unable to=
 initialize DH parameters: %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0gnutls_strerror(ret));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gnutls_dh_params_generate2(*dh_params,=
 DH_BITS);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_dh_params_deinit(*dh_para=
ms);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *dh_params =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Unable to=
 generate DH parameters: %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0gnutls_strerror(ret));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 if (filename !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GError *gerr =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gchar *contents;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gsize len;<br>
@@ -67,6 +53,10 @@ qcrypto_tls_creds_get_dh_params_file(QCryptoTLSCreds *cr=
eds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_error_free(gerr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report_once(&quot;Use of an external DH p=
arameters file &#39;%s&#39; is &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;deprecated and will be removed in a future release&q=
uot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0filename);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data.data =3D (unsigned char *)contents;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data.size =3D len;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D gnutls_dh_params_init(dh_params);=
<br>
@@ -87,6 +77,8 @@ qcrypto_tls_creds_get_dh_params_file(QCryptoTLSCreds *cre=
ds,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 filename, gnutls_strerror(ret));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *dh_params =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c<br>
index 69ed1d792a..777cc4f5bb 100644<br>
--- a/crypto/tlscredsanon.c<br>
+++ b/crypto/tlscredsanon.c<br>
@@ -68,8 +68,10 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_anon_set_server_dh_params(box-&gt;data.=
anonserver,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bo=
x-&gt;dh_params);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (box-&gt;dh_params) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_anon_set_server_dh_params=
(box-&gt;data.anonserver,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0box-&gt;dh_params);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D gnutls_anon_allocate_client_crede=
ntials(&amp;box-&gt;data.anonclient);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c<br>
index e437985260..801da50625 100644<br>
--- a/crypto/tlscredspsk.c<br>
+++ b/crypto/tlscredspsk.c<br>
@@ -129,8 +129,10 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 gnutls_strerror(ret));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto cleanup;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_psk_set_server_dh_params(box-&gt;data.p=
skserver,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 box-&gt;=
dh_params);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (box-&gt;dh_params) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_psk_set_server_dh_params(=
box-&gt;data.pskserver,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 box-&gt;dh_params);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0box =3D qcrypto_tls_creds_box_new_client(=
GNUTLS_CRD_PSK);<br>
<br>
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c<br>
index 2fc0872627..7e79af4266 100644<br>
--- a/crypto/tlscredsx509.c<br>
+++ b/crypto/tlscredsx509.c<br>
@@ -684,7 +684,9 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 errp) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_certificate_set_dh_params(box-&gt;data.=
cert, box-&gt;dh_params);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (box-&gt;dh_params) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gnutls_certificate_set_dh_params=
(box-&gt;data.cert, box-&gt;dh_params);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0creds-&gt;parent_obj.box =3D g_steal_pointer(&amp;box);=
<br>
<br>
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst<br>
index ca6b3769b5..694a69da64 100644<br>
--- a/docs/about/deprecated.rst<br>
+++ b/docs/about/deprecated.rst<br>
@@ -365,6 +365,15 @@ Options are:<br>
=C2=A0 =C2=A0 =C2=A0- move backing file to NVDIMM storage and keep ``pmem=
=3Don``<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0(to have NVDIMM with persistence guaranties).<br=
>
<br>
+Using an external DH (Diffie-Hellman) parameters file (since 10.2)<br>
+&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39=
;&#39;&#39;&#39;&#39;&#39;&#39;<br>
+<br>
+Loading of external Diffie-Hellman parameters from a &#39;dh-params.pem&#3=
9;<br>
+file is deprecated and will be removed with no replacement in a<br>
+future release. Where no &#39;dh-params.pem&#39; file is provided, the DH<=
br>
+parameters will be automatically negotiated in accordance with<br>
+RFC7919.<br>
+<br>
=C2=A0Device options<br>
=C2=A0--------------<br>
<br>
diff --git a/docs/system/tls.rst b/docs/system/tls.rst<br>
index a4f6781d62..44c4bf04e9 100644<br>
--- a/docs/system/tls.rst<br>
+++ b/docs/system/tls.rst<br>
@@ -251,11 +251,13 @@ When specifying the object, the ``dir`` parameters sp=
ecifies which<br>
=C2=A0directory contains the credential files. This directory is expected t=
o<br>
=C2=A0contain files with the names mentioned previously, ``ca-cert.pem``,<b=
r>
=C2=A0``server-key.pem``, ``server-cert.pem``, ``client-key.pem`` and<br>
-``client-cert.pem`` as appropriate. It is also possible to include a set<b=
r>
-of pre-generated Diffie-Hellman (DH) parameters in a file<br>
-``dh-params.pem``, which can be created using the<br>
-``certtool --generate-dh-params`` command. If omitted, QEMU will<br>
-dynamically generate DH parameters when loading the credentials.<br>
+``client-cert.pem`` as appropriate.<br>
+<br>
+While it is possible to include a set of pre-generated Diffie-Hellman<br>
+(DH) parameters in a file ``dh-params.pem``, this facility is now<br>
+deprecated and will be removed in a future release. When omitted the<br>
+DH parameters will be automatically negotiated in accordance with<br>
+RFC7919.<br>
<br>
=C2=A0The ``endpoint`` parameter indicates whether the credentials will be<=
br>
=C2=A0used for a network client or server, and determines which PEM files a=
re<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div>

--0000000000008367b6064272ba42--


