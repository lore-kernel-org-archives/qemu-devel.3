Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF45CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 15:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEqku-0006JT-0l; Fri, 31 Oct 2025 11:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEqks-0006JD-PO
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vEqkg-0006DE-GV
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761923352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2mE5+KVwYdy2r066hzaCXcEXrOLLvHfG7qVD00VB9Vs=;
 b=MWOYC7goQwnLF48c0bAeolD7X1uUukBuN82raA9v5RO9+WQ/w8z/qmwoWVhO0EaGV03RwD
 cXobRrkPMK+ims/5mWHAOMH5fCds0GK9T90avrdOomgEwx/++Am6R3OQQHjydw7TDrVeWe
 oyqa92kdD2OeLk44MTlbvejsTquDs2U=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-3yr-UfaXPWSnnXUy1ZlcRA-1; Fri, 31 Oct 2025 11:09:09 -0400
X-MC-Unique: 3yr-UfaXPWSnnXUy1ZlcRA-1
X-Mimecast-MFC-AGG-ID: 3yr-UfaXPWSnnXUy1ZlcRA_1761923348
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-340bb1bf12aso1953a91.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 08:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761923348; x=1762528148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2mE5+KVwYdy2r066hzaCXcEXrOLLvHfG7qVD00VB9Vs=;
 b=dv345a29YeSFogsx4gjt9MI2Dhz2Pc0mbEGrVQlVI3f+kwjtGqz6dlDh/iCxxJmBkR
 xUsg3venq607thZC3R4cqAxK9hzlBuWcvEc3aQB3RnQ3LZQX2EOLkz3Ccj1az9DnFuE8
 QRjKY9XAjt4T7dTNA/5pZPOYTo7mXdWO/flFxRCCuTd1gGqvssPiNDyAgC6CU1+kNegJ
 iiSK/IqcdeP8FvCD5zrcRXeTJXdL+UNE+jeamOkTsNkW/0cFCjYJ2PUkm7Fo/8AiYiRd
 aeDmj814BnvgN+wNtoMLD3A2tTHlWp/XUIq4BfT14zYwbYDLMt3BKMp5byogMumnRpCH
 XTBw==
X-Gm-Message-State: AOJu0YyiVHyqkOp2OYf/usLRkTlGXr2qwAhu1N4wbBdURSw4zRJhKUtB
 77y3aK7pXv98CmUd7YpXBc2tmFTgQ5xm66taXJxpK0b/k9UXahDTF+IGFnkfUwjRt6cdhsdRSh5
 94UnYcztJwzyyBwTii9GqgMe0hAMVgpW/72IjkSs3LcaeYmok0IUm/oCm+LPCXcH8qtaQTcEgGf
 NSpat6hx/GkDBGkOdHK2dR2I7BwIeqRuw=
X-Gm-Gg: ASbGncua0t9YfoJCjHs2RzwSwVYI09Z/U26zlkWoU6CONHGvJeeI6o/B4k/j2iSSwMP
 zBQQhWS6DhwkeOERfo1f1k8cMcC4PAC0bSoCF9FEa+/FwRPEcTJufkJe4AEZZefXj2N0MNP6IaI
 cVJ9FW6auPHN1wp+dYlQ45QUGJDmbPeeTyYeVEu8JmcOaZXO3emtmmYdGmRP3M3A==
X-Received: by 2002:a17:90b:134e:b0:33b:cfac:d5c6 with SMTP id
 98e67ed59e1d1-3408308d0bfmr4621561a91.29.1761923347968; 
 Fri, 31 Oct 2025 08:09:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHmEj6Ik5w6gsroJyt/zgiX2lOu1ozYueMXOMbq1vO0HkPd13mgkRxAOIkdSvsxabiosLHGYo6WK+nX6dJNEE=
X-Received: by 2002:a17:90b:134e:b0:33b:cfac:d5c6 with SMTP id
 98e67ed59e1d1-3408308d0bfmr4621514a91.29.1761923347356; Fri, 31 Oct 2025
 08:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-18-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-18-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 31 Oct 2025 19:08:55 +0400
X-Gm-Features: AWmQ_bmB3pMVJ-6jxrGp0ElzTPnS-gl0wv2LQsCbILDc1P55xedxg6453nFYLkc
Message-ID: <CAMxuvazJbLQAJmBXMYTwOxUR6EVYFV7uJyicV_rgEpRJ49UqnQ@mail.gmail.com>
Subject: Re: [PATCH 17/21] crypto: avoid loading the CA certs twice
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="0000000000003dacbd064275bffe"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
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

--0000000000003dacbd064275bffe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:50=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The x509 TLS credentials code will load the CA certs once to perform
> sanity chcking on the certs, then discard the certificate objects
> and let gnutls load them a second time.
>
> This introduces a new QCryptoTLSCredsX509Files struct which will
> hold the CA certificates loaded for sanity checking and pass them on
> to gnutls, avoiding the duplicated loading.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  crypto/tlscredsx509.c | 141 ++++++++++++++++++++++++++----------------
>  1 file changed, 87 insertions(+), 54 deletions(-)
>
> diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
> index 7e79af4266..6a830af50d 100644
> --- a/crypto/tlscredsx509.c
> +++ b/crypto/tlscredsx509.c
> @@ -40,6 +40,35 @@ struct QCryptoTLSCredsX509 {
>  };
>
>
> +typedef struct QCryptoTLSCredsX509Files QCryptoTLSCredsX509Files;
> +struct QCryptoTLSCredsX509Files {
> +    char *cacertpath;
> +    gnutls_x509_crt_t *cacerts;
> +    unsigned int ncacerts;
> +};
> +
> +static QCryptoTLSCredsX509Files *
> +qcrypto_tls_creds_x509_files_new(void)
> +{
> +    return g_new0(QCryptoTLSCredsX509Files, 1);
> +}
> +
> +
> +static void
> +qcrypto_tls_creds_x509_files_free(QCryptoTLSCredsX509Files *files)
> +{
> +    size_t i;
> +    for (i =3D 0; i < files->ncacerts; i++) {
> +        gnutls_x509_crt_deinit(files->cacerts[i]);
> +    }
> +    g_free(files->cacerts);
> +    g_free(files->cacertpath);
> +    g_free(files);
> +}
> +
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoTLSCredsX509Files,
> +                              qcrypto_tls_creds_x509_files_free);
> +
>  static int
>  qcrypto_tls_creds_check_cert_times(gnutls_x509_crt_t cert,
>                                     const char *certFile,
> @@ -315,11 +344,9 @@ qcrypto_tls_creds_check_cert(QCryptoTLSCredsX509
> *creds,
>
>  static int
>  qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
> +                                        QCryptoTLSCredsX509Files *files,
>                                          gnutls_x509_crt_t *certs,
>                                          unsigned int ncerts,
> -                                        gnutls_x509_crt_t *cacerts,
> -                                        unsigned int ncacerts,
> -                                        const char *cacertFile,
>                                          bool isServer,
>                                          Error **errp)
>  {
> @@ -360,13 +387,13 @@
> qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
>               * reached the root of trust.
>               */
>              return qcrypto_tls_creds_check_cert(
> -                creds, cert_to_check, cacertFile,
> +                creds, cert_to_check, files->cacertpath,
>                  isServer, true, errp);
>          }
> -        for (int i =3D 0; i < ncacerts; i++) {
> +        for (int i =3D 0; i < files->ncacerts; i++) {
>              if (gnutls_x509_crt_check_issuer(cert_to_check,
> -                                             cacerts[i])) {
> -                cert_issuer =3D cacerts[i];
> +                                             files->cacerts[i])) {
> +                cert_issuer =3D files->cacerts[i];
>                  break;
>              }
>          }
> @@ -374,7 +401,7 @@
> qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
>              break;
>          }
>
> -        if (qcrypto_tls_creds_check_cert(creds, cert_issuer, cacertFile,
> +        if (qcrypto_tls_creds_check_cert(creds, cert_issuer,
> files->cacertpath,
>                                           isServer, true, errp) < 0) {
>              return -1;
>          }
> @@ -394,19 +421,17 @@
> qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
>  }
>
>  static int
> -qcrypto_tls_creds_check_cert_pair(gnutls_x509_crt_t *certs,
> +qcrypto_tls_creds_check_cert_pair(QCryptoTLSCredsX509Files *files,
> +                                  gnutls_x509_crt_t *certs,
>                                    size_t ncerts,
>                                    const char *certFile,
> -                                  gnutls_x509_crt_t *cacerts,
> -                                  size_t ncacerts,
> -                                  const char *cacertFile,
>                                    bool isServer,
>                                    Error **errp)
>  {
>      unsigned int status;
>
>      if (gnutls_x509_crt_list_verify(certs, ncerts,
> -                                    cacerts, ncacerts,
> +                                    files->cacerts, files->ncacerts,
>                                      NULL, 0,
>                                      0, &status) < 0) {
>          error_setg(errp, isServer ?
> @@ -414,7 +439,7 @@ qcrypto_tls_creds_check_cert_pair(gnutls_x509_crt_t
> *certs,
>                     "CA certificate %s" :
>                     "Unable to verify client certificate %s against "
>                     "CA certificate %s",
> -                   certFile, cacertFile);
> +                   certFile, files->cacertpath);
>          return -1;
>      }
>
> @@ -439,7 +464,7 @@ qcrypto_tls_creds_check_cert_pair(gnutls_x509_crt_t
> *certs,
>
>          error_setg(errp,
>                     "Our own certificate %s failed validation against %s:
> %s",
> -                   certFile, cacertFile, reason);
> +                   certFile, files->cacertpath, reason);
>          return -1;
>      }
>
> @@ -490,15 +515,13 @@ qcrypto_tls_creds_load_cert_list(QCryptoTLSCredsX50=
9
> *creds,
>
>  static int
>  qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
> +                                    QCryptoTLSCredsX509Files *files,
>                                      bool isServer,
> -                                    const char *cacertFile,
>                                      const char *certFile,
>                                      Error **errp)
>  {
>      gnutls_x509_crt_t *certs =3D NULL;
>      unsigned int ncerts =3D 0;
> -    gnutls_x509_crt_t *cacerts =3D NULL;
> -    unsigned int ncacerts =3D 0;
>      size_t i;
>      int ret =3D -1;
>
> @@ -514,16 +537,6 @@
> qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
>          }
>      }
>
> -    if (qcrypto_tls_creds_load_cert_list(creds,
> -                                         cacertFile,
> -                                         &cacerts,
> -                                         &ncacerts,
> -                                         isServer,
> -                                         true,
> -                                         errp) < 0) {
> -        goto cleanup;
> -    }
> -
>      for (i =3D 0; i < ncerts; i++) {
>          if (qcrypto_tls_creds_check_cert(creds,
>                                           certs[i], certFile,
> @@ -533,17 +546,14 @@
> qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
>      }
>
>      if (ncerts &&
> -        qcrypto_tls_creds_check_authority_chain(creds,
> +        qcrypto_tls_creds_check_authority_chain(creds, files,
>                                                  certs, ncerts,
> -                                                cacerts, ncacerts,
> -                                                cacertFile, isServer,
> -                                                errp) < 0) {
> +                                                isServer, errp) < 0) {
>          goto cleanup;
>      }
>
> -    if (ncerts && ncacerts &&
> -        qcrypto_tls_creds_check_cert_pair(certs, ncerts, certFile,
> -                                          cacerts, ncacerts, cacertFile,
> +    if (ncerts &&
> +        qcrypto_tls_creds_check_cert_pair(files, certs, ncerts, certFile=
,
>                                            isServer, errp) < 0) {
>          goto cleanup;
>      }
> @@ -555,21 +565,53 @@
> qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
>          gnutls_x509_crt_deinit(certs[i]);
>      }
>      g_free(certs);
> -    for (i =3D 0; i < ncacerts; i++) {
> -        gnutls_x509_crt_deinit(cacerts[i]);
> -    }
> -    g_free(cacerts);
>
>      return ret;
>  }
>
>
> +static int
> +qcrypto_tls_creds_x509_load_ca(QCryptoTLSCredsX509 *creds,
> +                               QCryptoTLSCredsBox *box,
> +                               QCryptoTLSCredsX509Files *files,
> +                               bool isServer,
> +                               Error **errp)
> +{
> +    int ret;
> +
> +    if (qcrypto_tls_creds_get_path(&creds->parent_obj,
> +                                   QCRYPTO_TLS_CREDS_X509_CA_CERT,
> +                                   true, &files->cacertpath, errp) < 0) =
{
> +        return -1;
> +    }
> +
> +    if (qcrypto_tls_creds_load_cert_list(creds,
> +                                         files->cacertpath,
> +                                         &files->cacerts,
> +                                         &files->ncacerts,
> +                                         isServer,
> +                                         true,
> +                                         errp) < 0) {
> +        return -1;
> +    }
> +
> +    ret =3D gnutls_certificate_set_x509_trust(box->data.cert,
> +                                            files->cacerts,
> files->ncacerts);
> +    if (ret < 0) {
> +        error_setg(errp, "Cannot set CA certificate '%s': %s",
> +                   files->cacertpath, gnutls_strerror(ret));
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  static int
>  qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
>                              Error **errp)
>  {
>      g_autoptr(QCryptoTLSCredsBox) box =3D NULL;
> -    g_autofree char *cacert =3D NULL;
> +    g_autoptr(QCryptoTLSCredsX509Files) files =3D NULL;
>      g_autofree char *cacrl =3D NULL;
>      g_autofree char *cert =3D NULL;
>      g_autofree char *key =3D NULL;
> @@ -598,9 +640,9 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *cred=
s,
>          return -1;
>      }
>
> -    if (qcrypto_tls_creds_get_path(&creds->parent_obj,
> -                                   QCRYPTO_TLS_CREDS_X509_CA_CERT,
> -                                   true, &cacert, errp) < 0) {
> +    files =3D qcrypto_tls_creds_x509_files_new();
> +
> +    if (qcrypto_tls_creds_x509_load_ca(creds, box, files, isServer, errp=
)
> < 0) {
>          return -1;
>      }
>
> @@ -631,17 +673,8 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509
> *creds,
>      }
>
>      if (creds->sanityCheck &&
> -        qcrypto_tls_creds_x509_sanity_check(creds, isServer,
> -                                            cacert, cert, errp) < 0) {
> -        return -1;
> -    }
> -
> -    ret =3D gnutls_certificate_set_x509_trust_file(box->data.cert,
> -                                                 cacert,
> -                                                 GNUTLS_X509_FMT_PEM);
> -    if (ret < 0) {
> -        error_setg(errp, "Cannot load CA certificate '%s': %s",
> -                   cacert, gnutls_strerror(ret));
> +        qcrypto_tls_creds_x509_sanity_check(creds, files, isServer,
> +                                            cert, errp) < 0) {
>          return -1;
>      }
>
> --
> 2.51.1
>
>

--0000000000003dacbd064275bffe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSBnbWFpbF9xdW90ZV9jb250YWluZXIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJn
bWFpbF9hdHRyIj5PbiBUaHUsIE9jdCAzMCwgMjAyNSBhdCA2OjUw4oCvUE0gRGFuaWVsIFAuIEJl
cnJhbmfDqSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmJlcnJhbmdlQHJlZGhhdC5jb20iPmJlcnJhbmdl
QHJlZGhhdC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9Imdt
YWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFw
eCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPlRoZSB4NTA5IFRMUyBj
cmVkZW50aWFscyBjb2RlIHdpbGwgbG9hZCB0aGUgQ0EgY2VydHMgb25jZSB0byBwZXJmb3JtPGJy
Pg0Kc2FuaXR5IGNoY2tpbmcgb24gdGhlIGNlcnRzLCB0aGVuIGRpc2NhcmQgdGhlIGNlcnRpZmlj
YXRlIG9iamVjdHM8YnI+DQphbmQgbGV0IGdudXRscyBsb2FkIHRoZW0gYSBzZWNvbmQgdGltZS48
YnI+DQo8YnI+DQpUaGlzIGludHJvZHVjZXMgYSBuZXcgUUNyeXB0b1RMU0NyZWRzWDUwOUZpbGVz
IHN0cnVjdCB3aGljaCB3aWxsPGJyPg0KaG9sZCB0aGUgQ0EgY2VydGlmaWNhdGVzIGxvYWRlZCBm
b3Igc2FuaXR5IGNoZWNraW5nIGFuZCBwYXNzIHRoZW0gb248YnI+DQp0byBnbnV0bHMsIGF2b2lk
aW5nIHRoZSBkdXBsaWNhdGVkIGxvYWRpbmcuPGJyPg0KPGJyPg0KU2lnbmVkLW9mZi1ieTogRGFu
aWVsIFAuIEJlcnJhbmfDqSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmJlcnJhbmdlQHJlZGhhdC5jb20i
IHRhcmdldD0iX2JsYW5rIj5iZXJyYW5nZUByZWRoYXQuY29tPC9hPiZndDs8YnI+PC9ibG9ja3F1
b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+UmV2aWV3ZWQtYnk6IE1hcmMtQW5kcsOpIEx1cmVhdSAm
bHQ7PGEgaHJlZj0ibWFpbHRvOm1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbSI+bWFyY2FuZHJl
Lmx1cmVhdUByZWRoYXQuY29tPC9hPiZndDs8L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUg
Y2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRl
ci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPg0KLS0t
PGJyPg0KwqBjcnlwdG8vdGxzY3JlZHN4NTA5LmMgfCAxNDEgKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0tPGJyPg0KwqAxIGZpbGUgY2hhbmdlZCwgODcgaW5zZXJ0aW9u
cygrKSwgNTQgZGVsZXRpb25zKC0pPGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL2NyeXB0by90bHNj
cmVkc3g1MDkuYyBiL2NyeXB0by90bHNjcmVkc3g1MDkuYzxicj4NCmluZGV4IDdlNzlhZjQyNjYu
LjZhODMwYWY1MGQgMTAwNjQ0PGJyPg0KLS0tIGEvY3J5cHRvL3Rsc2NyZWRzeDUwOS5jPGJyPg0K
KysrIGIvY3J5cHRvL3Rsc2NyZWRzeDUwOS5jPGJyPg0KQEAgLTQwLDYgKzQwLDM1IEBAIHN0cnVj
dCBRQ3J5cHRvVExTQ3JlZHNYNTA5IHs8YnI+DQrCoH07PGJyPg0KPGJyPg0KPGJyPg0KK3R5cGVk
ZWYgc3RydWN0IFFDcnlwdG9UTFNDcmVkc1g1MDlGaWxlcyBRQ3J5cHRvVExTQ3JlZHNYNTA5Rmls
ZXM7PGJyPg0KK3N0cnVjdCBRQ3J5cHRvVExTQ3JlZHNYNTA5RmlsZXMgezxicj4NCivCoCDCoCBj
aGFyICpjYWNlcnRwYXRoOzxicj4NCivCoCDCoCBnbnV0bHNfeDUwOV9jcnRfdCAqY2FjZXJ0czs8
YnI+DQorwqAgwqAgdW5zaWduZWQgaW50IG5jYWNlcnRzOzxicj4NCit9Ozxicj4NCis8YnI+DQor
c3RhdGljIFFDcnlwdG9UTFNDcmVkc1g1MDlGaWxlcyAqPGJyPg0KK3FjcnlwdG9fdGxzX2NyZWRz
X3g1MDlfZmlsZXNfbmV3KHZvaWQpPGJyPg0KK3s8YnI+DQorwqAgwqAgcmV0dXJuIGdfbmV3MChR
Q3J5cHRvVExTQ3JlZHNYNTA5RmlsZXMsIDEpOzxicj4NCit9PGJyPg0KKzxicj4NCis8YnI+DQor
c3RhdGljIHZvaWQ8YnI+DQorcWNyeXB0b190bHNfY3JlZHNfeDUwOV9maWxlc19mcmVlKFFDcnlw
dG9UTFNDcmVkc1g1MDlGaWxlcyAqZmlsZXMpPGJyPg0KK3s8YnI+DQorwqAgwqAgc2l6ZV90IGk7
PGJyPg0KK8KgIMKgIGZvciAoaSA9IDA7IGkgJmx0OyBmaWxlcy0mZ3Q7bmNhY2VydHM7IGkrKykg
ezxicj4NCivCoCDCoCDCoCDCoCBnbnV0bHNfeDUwOV9jcnRfZGVpbml0KGZpbGVzLSZndDtjYWNl
cnRzW2ldKTs8YnI+DQorwqAgwqAgfTxicj4NCivCoCDCoCBnX2ZyZWUoZmlsZXMtJmd0O2NhY2Vy
dHMpOzxicj4NCivCoCDCoCBnX2ZyZWUoZmlsZXMtJmd0O2NhY2VydHBhdGgpOzxicj4NCivCoCDC
oCBnX2ZyZWUoZmlsZXMpOzxicj4NCit9PGJyPg0KKzxicj4NCitHX0RFRklORV9BVVRPUFRSX0NM
RUFOVVBfRlVOQyhRQ3J5cHRvVExTQ3JlZHNYNTA5RmlsZXMsPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHFjcnlwdG9fdGxzX2NyZWRzX3g1MDlfZmls
ZXNfZnJlZSk7PGJyPg0KKzxicj4NCsKgc3RhdGljIGludDxicj4NCsKgcWNyeXB0b190bHNfY3Jl
ZHNfY2hlY2tfY2VydF90aW1lcyhnbnV0bHNfeDUwOV9jcnRfdCBjZXJ0LDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNvbnN0IGNoYXIg
KmNlcnRGaWxlLDxicj4NCkBAIC0zMTUsMTEgKzM0NCw5IEBAIHFjcnlwdG9fdGxzX2NyZWRzX2No
ZWNrX2NlcnQoUUNyeXB0b1RMU0NyZWRzWDUwOSAqY3JlZHMsPGJyPg0KPGJyPg0KwqBzdGF0aWMg
aW50PGJyPg0KwqBxY3J5cHRvX3Rsc19jcmVkc19jaGVja19hdXRob3JpdHlfY2hhaW4oUUNyeXB0
b1RMU0NyZWRzWDUwOSAqY3JlZHMsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFFDcnlwdG9UTFNDcmVkc1g1MDlGaWxlcyAq
ZmlsZXMsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBnbnV0bHNfeDUwOV9jcnRfdCAqY2VydHMsPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1bnNp
Z25lZCBpbnQgbmNlcnRzLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnbnV0bHNfeDUwOV9jcnRfdCAqY2FjZXJ0cyw8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgdW5zaWduZWQgaW50IG5jYWNlcnRzLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb25zdCBjaGFyICpjYWNlcnRG
aWxlLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgYm9vbCBpc1NlcnZlciw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEVycm9yICoqZXJycCk8YnI+
DQrCoHs8YnI+DQpAQCAtMzYwLDEzICszODcsMTMgQEAgcWNyeXB0b190bHNfY3JlZHNfY2hlY2tf
YXV0aG9yaXR5X2NoYWluKFFDcnlwdG9UTFNDcmVkc1g1MDkgKmNyZWRzLDxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgICogcmVhY2hlZCB0aGUgcm9vdCBvZiB0cnVzdC48YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCAqLzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHFjcnlwdG9fdGxz
X2NyZWRzX2NoZWNrX2NlcnQoPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNyZWRzLCBj
ZXJ0X3RvX2NoZWNrLCBjYWNlcnRGaWxlLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBj
cmVkcywgY2VydF90b19jaGVjaywgZmlsZXMtJmd0O2NhY2VydHBhdGgsPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBpc1NlcnZlciwgdHJ1ZSwgZXJycCk7PGJyPg0KwqAgwqAgwqAgwqAg
wqB9PGJyPg0KLcKgIMKgIMKgIMKgIGZvciAoaW50IGkgPSAwOyBpICZsdDsgbmNhY2VydHM7IGkr
Kykgezxicj4NCivCoCDCoCDCoCDCoCBmb3IgKGludCBpID0gMDsgaSAmbHQ7IGZpbGVzLSZndDtu
Y2FjZXJ0czsgaSsrKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZ251dGxzX3g1MDlf
Y3J0X2NoZWNrX2lzc3VlcihjZXJ0X3RvX2NoZWNrLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhY2VydHNb
aV0pKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNlcnRfaXNzdWVyID0gY2FjZXJ0
c1tpXTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmaWxlcy0mZ3Q7Y2FjZXJ0c1tpXSkpIHs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgY2VydF9pc3N1ZXIgPSBmaWxlcy0mZ3Q7Y2FjZXJ0c1tpXTs8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgfTxicj4NCsKgIMKgIMKgIMKgIMKgfTxicj4NCkBAIC0zNzQsNyArNDAxLDcgQEAgcWNy
eXB0b190bHNfY3JlZHNfY2hlY2tfYXV0aG9yaXR5X2NoYWluKFFDcnlwdG9UTFNDcmVkc1g1MDkg
KmNyZWRzLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KwqAgwqAgwqAgwqAg
wqB9PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgIGlmIChxY3J5cHRvX3Rsc19jcmVkc19jaGVja19j
ZXJ0KGNyZWRzLCBjZXJ0X2lzc3VlciwgY2FjZXJ0RmlsZSw8YnI+DQorwqAgwqAgwqAgwqAgaWYg
KHFjcnlwdG9fdGxzX2NyZWRzX2NoZWNrX2NlcnQoY3JlZHMsIGNlcnRfaXNzdWVyLCBmaWxlcy0m
Z3Q7Y2FjZXJ0cGF0aCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpc1NlcnZlciwgdHJ1ZSwgZXJycCkgJmx0OyAwKSB7
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KwqAgwqAgwqAgwqAgwqB9
PGJyPg0KQEAgLTM5NCwxOSArNDIxLDE3IEBAIHFjcnlwdG9fdGxzX2NyZWRzX2NoZWNrX2F1dGhv
cml0eV9jaGFpbihRQ3J5cHRvVExTQ3JlZHNYNTA5ICpjcmVkcyw8YnI+DQrCoH08YnI+DQo8YnI+
DQrCoHN0YXRpYyBpbnQ8YnI+DQotcWNyeXB0b190bHNfY3JlZHNfY2hlY2tfY2VydF9wYWlyKGdu
dXRsc194NTA5X2NydF90ICpjZXJ0cyw8YnI+DQorcWNyeXB0b190bHNfY3JlZHNfY2hlY2tfY2Vy
dF9wYWlyKFFDcnlwdG9UTFNDcmVkc1g1MDlGaWxlcyAqZmlsZXMsPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGdudXRsc194NTA5X2NydF90
ICpjZXJ0cyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHNpemVfdCBuY2VydHMsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb25zdCBjaGFyICpjZXJ0RmlsZSw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ251dGxzX3g1
MDlfY3J0X3QgKmNhY2VydHMsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHNpemVfdCBuY2FjZXJ0cyw8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29uc3QgY2hhciAqY2FjZXJ0Rmls
ZSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGJvb2wgaXNTZXJ2ZXIsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBFcnJvciAqKmVycnApPGJyPg0KwqB7PGJyPg0KwqAgwqAgwqB1
bnNpZ25lZCBpbnQgc3RhdHVzOzxicj4NCjxicj4NCsKgIMKgIMKgaWYgKGdudXRsc194NTA5X2Ny
dF9saXN0X3ZlcmlmeShjZXJ0cywgbmNlcnRzLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjYWNlcnRzLCBuY2FjZXJ0cyw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZmls
ZXMtJmd0O2NhY2VydHMsIGZpbGVzLSZndDtuY2FjZXJ0cyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5VTEwsIDAsPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAwLCAm
YW1wO3N0YXR1cykgJmx0OyAwKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqBlcnJvcl9zZXRnKGVycnAs
IGlzU2VydmVyID88YnI+DQpAQCAtNDE0LDcgKzQzOSw3IEBAIHFjcnlwdG9fdGxzX2NyZWRzX2No
ZWNrX2NlcnRfcGFpcihnbnV0bHNfeDUwOV9jcnRfdCAqY2VydHMsPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7Q0EgY2VydGlmaWNhdGUgJXMmcXVvdDsgOjxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O1VuYWJsZSB0byB2ZXJpZnkgY2xpZW50
IGNlcnRpZmljYXRlICVzIGFnYWluc3QgJnF1b3Q7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgJnF1b3Q7Q0EgY2VydGlmaWNhdGUgJXMmcXVvdDssPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgY2VydEZpbGUsIGNhY2VydEZpbGUpOzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGNlcnRGaWxlLCBmaWxlcy0mZ3Q7Y2FjZXJ0cGF0aCk7PGJyPg0K
wqAgwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KwqAgwqAgwqB9PGJyPg0KPGJyPg0KQEAgLTQz
OSw3ICs0NjQsNyBAQCBxY3J5cHRvX3Rsc19jcmVkc19jaGVja19jZXJ0X3BhaXIoZ251dGxzX3g1
MDlfY3J0X3QgKmNlcnRzLDxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgZXJyb3Jfc2V0ZyhlcnJw
LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O091ciBvd24gY2VydGlm
aWNhdGUgJXMgZmFpbGVkIHZhbGlkYXRpb24gYWdhaW5zdCAlczogJXMmcXVvdDssPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2VydEZpbGUsIGNhY2VydEZpbGUsIHJlYXNvbik7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2VydEZpbGUsIGZpbGVzLSZndDtj
YWNlcnRwYXRoLCByZWFzb24pOzxicj4NCsKgIMKgIMKgIMKgIMKgcmV0dXJuIC0xOzxicj4NCsKg
IMKgIMKgfTxicj4NCjxicj4NCkBAIC00OTAsMTUgKzUxNSwxMyBAQCBxY3J5cHRvX3Rsc19jcmVk
c19sb2FkX2NlcnRfbGlzdChRQ3J5cHRvVExTQ3JlZHNYNTA5ICpjcmVkcyw8YnI+DQo8YnI+DQrC
oHN0YXRpYyBpbnQ8YnI+DQrCoHFjcnlwdG9fdGxzX2NyZWRzX3g1MDlfc2FuaXR5X2NoZWNrKFFD
cnlwdG9UTFNDcmVkc1g1MDkgKmNyZWRzLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBRQ3J5cHRvVExTQ3JlZHNYNTA5RmlsZXMgKmZp
bGVzLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgYm9vbCBpc1NlcnZlciw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29uc3QgY2hhciAqY2FjZXJ0RmlsZSw8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNv
bnN0IGNoYXIgKmNlcnRGaWxlLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgRXJyb3IgKiplcnJwKTxicj4NCsKgezxicj4NCsKgIMKg
IMKgZ251dGxzX3g1MDlfY3J0X3QgKmNlcnRzID0gTlVMTDs8YnI+DQrCoCDCoCDCoHVuc2lnbmVk
IGludCBuY2VydHMgPSAwOzxicj4NCi3CoCDCoCBnbnV0bHNfeDUwOV9jcnRfdCAqY2FjZXJ0cyA9
IE5VTEw7PGJyPg0KLcKgIMKgIHVuc2lnbmVkIGludCBuY2FjZXJ0cyA9IDA7PGJyPg0KwqAgwqAg
wqBzaXplX3QgaTs8YnI+DQrCoCDCoCDCoGludCByZXQgPSAtMTs8YnI+DQo8YnI+DQpAQCAtNTE0
LDE2ICs1MzcsNiBAQCBxY3J5cHRvX3Rsc19jcmVkc194NTA5X3Nhbml0eV9jaGVjayhRQ3J5cHRv
VExTQ3JlZHNYNTA5ICpjcmVkcyw8YnI+DQrCoCDCoCDCoCDCoCDCoH08YnI+DQrCoCDCoCDCoH08
YnI+DQo8YnI+DQotwqAgwqAgaWYgKHFjcnlwdG9fdGxzX2NyZWRzX2xvYWRfY2VydF9saXN0KGNy
ZWRzLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGNhY2VydEZpbGUsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtjYWNlcnRzLDxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCZhbXA7bmNhY2VydHMsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaXNTZXJ2ZXIsPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdHJ1
ZSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBlcnJwKSAmbHQ7IDApIHs8YnI+DQotwqAgwqAgwqAgwqAgZ290byBjbGVh
bnVwOzxicj4NCi3CoCDCoCB9PGJyPg0KLTxicj4NCsKgIMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7
IG5jZXJ0czsgaSsrKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqBpZiAocWNyeXB0b190bHNfY3JlZHNf
Y2hlY2tfY2VydChjcmVkcyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjZXJ0c1tpXSwgY2VydEZpbGUsPGJyPg0KQEAg
LTUzMywxNyArNTQ2LDE0IEBAIHFjcnlwdG9fdGxzX2NyZWRzX3g1MDlfc2FuaXR5X2NoZWNrKFFD
cnlwdG9UTFNDcmVkc1g1MDkgKmNyZWRzLDxicj4NCsKgIMKgIMKgfTxicj4NCjxicj4NCsKgIMKg
IMKgaWYgKG5jZXJ0cyAmYW1wOyZhbXA7PGJyPg0KLcKgIMKgIMKgIMKgIHFjcnlwdG9fdGxzX2Ny
ZWRzX2NoZWNrX2F1dGhvcml0eV9jaGFpbihjcmVkcyw8YnI+DQorwqAgwqAgwqAgwqAgcWNyeXB0
b190bHNfY3JlZHNfY2hlY2tfYXV0aG9yaXR5X2NoYWluKGNyZWRzLCBmaWxlcyw8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGNlcnRzLCBuY2VydHMsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNhY2VydHMs
IG5jYWNlcnRzLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjYWNlcnRGaWxlLCBpc1NlcnZlciw8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgZXJycCkgJmx0OyAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlz
U2VydmVyLCBlcnJwKSAmbHQ7IDApIHs8YnI+DQrCoCDCoCDCoCDCoCDCoGdvdG8gY2xlYW51cDs8
YnI+DQrCoCDCoCDCoH08YnI+DQo8YnI+DQotwqAgwqAgaWYgKG5jZXJ0cyAmYW1wOyZhbXA7IG5j
YWNlcnRzICZhbXA7JmFtcDs8YnI+DQotwqAgwqAgwqAgwqAgcWNyeXB0b190bHNfY3JlZHNfY2hl
Y2tfY2VydF9wYWlyKGNlcnRzLCBuY2VydHMsIGNlcnRGaWxlLDxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjYWNlcnRz
LCBuY2FjZXJ0cywgY2FjZXJ0RmlsZSw8YnI+DQorwqAgwqAgaWYgKG5jZXJ0cyAmYW1wOyZhbXA7
PGJyPg0KK8KgIMKgIMKgIMKgIHFjcnlwdG9fdGxzX2NyZWRzX2NoZWNrX2NlcnRfcGFpcihmaWxl
cywgY2VydHMsIG5jZXJ0cywgY2VydEZpbGUsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpc1NlcnZlciwgZXJycCkg
Jmx0OyAwKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqBnb3RvIGNsZWFudXA7PGJyPg0KwqAgwqAgwqB9
PGJyPg0KQEAgLTU1NSwyMSArNTY1LDUzIEBAIHFjcnlwdG9fdGxzX2NyZWRzX3g1MDlfc2FuaXR5
X2NoZWNrKFFDcnlwdG9UTFNDcmVkc1g1MDkgKmNyZWRzLDxicj4NCsKgIMKgIMKgIMKgIMKgZ251
dGxzX3g1MDlfY3J0X2RlaW5pdChjZXJ0c1tpXSk7PGJyPg0KwqAgwqAgwqB9PGJyPg0KwqAgwqAg
wqBnX2ZyZWUoY2VydHMpOzxicj4NCi3CoCDCoCBmb3IgKGkgPSAwOyBpICZsdDsgbmNhY2VydHM7
IGkrKykgezxicj4NCi3CoCDCoCDCoCDCoCBnbnV0bHNfeDUwOV9jcnRfZGVpbml0KGNhY2VydHNb
aV0pOzxicj4NCi3CoCDCoCB9PGJyPg0KLcKgIMKgIGdfZnJlZShjYWNlcnRzKTs8YnI+DQo8YnI+
DQrCoCDCoCDCoHJldHVybiByZXQ7PGJyPg0KwqB9PGJyPg0KPGJyPg0KPGJyPg0KK3N0YXRpYyBp
bnQ8YnI+DQorcWNyeXB0b190bHNfY3JlZHNfeDUwOV9sb2FkX2NhKFFDcnlwdG9UTFNDcmVkc1g1
MDkgKmNyZWRzLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoFFDcnlwdG9UTFNDcmVkc0JveCAqYm94LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFFDcnlwdG9UTFNDcmVkc1g1MDlGaWxlcyAqZmls
ZXMsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Ym9vbCBpc1NlcnZlciw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBFcnJvciAqKmVycnApPGJyPg0KK3s8YnI+DQorwqAgwqAgaW50IHJldDs8YnI+
DQorPGJyPg0KK8KgIMKgIGlmIChxY3J5cHRvX3Rsc19jcmVkc19nZXRfcGF0aCgmYW1wO2NyZWRz
LSZndDtwYXJlbnRfb2JqLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoFFDUllQVE9fVExTX0NSRURTX1g1MDlfQ0FfQ0VSVCw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0cnVl
LCAmYW1wO2ZpbGVzLSZndDtjYWNlcnRwYXRoLCBlcnJwKSAmbHQ7IDApIHs8YnI+DQorwqAgwqAg
wqAgwqAgcmV0dXJuIC0xOzxicj4NCivCoCDCoCB9PGJyPg0KKzxicj4NCivCoCDCoCBpZiAocWNy
eXB0b190bHNfY3JlZHNfbG9hZF9jZXJ0X2xpc3QoY3JlZHMsPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZmlsZXMtJmd0
O2NhY2VydHBhdGgsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDtmaWxlcy0mZ3Q7Y2FjZXJ0cyw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAmYW1wO2ZpbGVzLSZndDtuY2FjZXJ0cyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpc1NlcnZlciw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB0cnVlLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGVycnApICZsdDsgMCkgezxicj4NCivCoCDCoCDCoCDCoCByZXR1
cm4gLTE7PGJyPg0KK8KgIMKgIH08YnI+DQorPGJyPg0KK8KgIMKgIHJldCA9IGdudXRsc19jZXJ0
aWZpY2F0ZV9zZXRfeDUwOV90cnVzdChib3gtJmd0O2RhdGEuY2VydCw8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
ZmlsZXMtJmd0O2NhY2VydHMsIGZpbGVzLSZndDtuY2FjZXJ0cyk7PGJyPg0KK8KgIMKgIGlmIChy
ZXQgJmx0OyAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIGVycm9yX3NldGcoZXJycCwgJnF1b3Q7Q2Fu
bm90IHNldCBDQSBjZXJ0aWZpY2F0ZSAmIzM5OyVzJiMzOTs6ICVzJnF1b3Q7LDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZpbGVzLSZndDtjYWNlcnRwYXRoLCBnbnV0bHNfc3Ry
ZXJyb3IocmV0KSk7PGJyPg0KK8KgIMKgIMKgIMKgIHJldHVybiAtMTs8YnI+DQorwqAgwqAgfTxi
cj4NCis8YnI+DQorwqAgwqAgcmV0dXJuIDA7PGJyPg0KK308YnI+DQorPGJyPg0KwqBzdGF0aWMg
aW50PGJyPg0KwqBxY3J5cHRvX3Rsc19jcmVkc194NTA5X2xvYWQoUUNyeXB0b1RMU0NyZWRzWDUw
OSAqY3JlZHMsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBFcnJvciAqKmVycnApPGJyPg0KwqB7PGJyPg0KwqAgwqAgwqBnX2F1dG9wdHIoUUNyeXB0b1RM
U0NyZWRzQm94KSBib3ggPSBOVUxMOzxicj4NCi3CoCDCoCBnX2F1dG9mcmVlIGNoYXIgKmNhY2Vy
dCA9IE5VTEw7PGJyPg0KK8KgIMKgIGdfYXV0b3B0cihRQ3J5cHRvVExTQ3JlZHNYNTA5RmlsZXMp
IGZpbGVzID0gTlVMTDs8YnI+DQrCoCDCoCDCoGdfYXV0b2ZyZWUgY2hhciAqY2FjcmwgPSBOVUxM
Ozxicj4NCsKgIMKgIMKgZ19hdXRvZnJlZSBjaGFyICpjZXJ0ID0gTlVMTDs8YnI+DQrCoCDCoCDC
oGdfYXV0b2ZyZWUgY2hhciAqa2V5ID0gTlVMTDs8YnI+DQpAQCAtNTk4LDkgKzY0MCw5IEBAIHFj
cnlwdG9fdGxzX2NyZWRzX3g1MDlfbG9hZChRQ3J5cHRvVExTQ3JlZHNYNTA5ICpjcmVkcyw8YnI+
DQrCoCDCoCDCoCDCoCDCoHJldHVybiAtMTs8YnI+DQrCoCDCoCDCoH08YnI+DQo8YnI+DQotwqAg
wqAgaWYgKHFjcnlwdG9fdGxzX2NyZWRzX2dldF9wYXRoKCZhbXA7Y3JlZHMtJmd0O3BhcmVudF9v
YmosPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgUUNSWVBUT19UTFNfQ1JFRFNfWDUwOV9DQV9DRVJULDxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRydWUsICZhbXA7Y2FjZXJ0
LCBlcnJwKSAmbHQ7IDApIHs8YnI+DQorwqAgwqAgZmlsZXMgPSBxY3J5cHRvX3Rsc19jcmVkc194
NTA5X2ZpbGVzX25ldygpOzxicj4NCis8YnI+DQorwqAgwqAgaWYgKHFjcnlwdG9fdGxzX2NyZWRz
X3g1MDlfbG9hZF9jYShjcmVkcywgYm94LCBmaWxlcywgaXNTZXJ2ZXIsIGVycnApICZsdDsgMCkg
ezxicj4NCsKgIMKgIMKgIMKgIMKgcmV0dXJuIC0xOzxicj4NCsKgIMKgIMKgfTxicj4NCjxicj4N
CkBAIC02MzEsMTcgKzY3Myw4IEBAIHFjcnlwdG9fdGxzX2NyZWRzX3g1MDlfbG9hZChRQ3J5cHRv
VExTQ3JlZHNYNTA5ICpjcmVkcyw8YnI+DQrCoCDCoCDCoH08YnI+DQo8YnI+DQrCoCDCoCDCoGlm
IChjcmVkcy0mZ3Q7c2FuaXR5Q2hlY2sgJmFtcDsmYW1wOzxicj4NCi3CoCDCoCDCoCDCoCBxY3J5
cHRvX3Rsc19jcmVkc194NTA5X3Nhbml0eV9jaGVjayhjcmVkcywgaXNTZXJ2ZXIsPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGNhY2VydCwgY2VydCwgZXJycCkgJmx0OyAwKSB7PGJyPg0KLcKgIMKgIMKgIMKgIHJl
dHVybiAtMTs8YnI+DQotwqAgwqAgfTxicj4NCi08YnI+DQotwqAgwqAgcmV0ID0gZ251dGxzX2Nl
cnRpZmljYXRlX3NldF94NTA5X3RydXN0X2ZpbGUoYm94LSZndDtkYXRhLmNlcnQsPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgY2FjZXJ0LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEdOVVRMU19YNTA5
X0ZNVF9QRU0pOzxicj4NCi3CoCDCoCBpZiAocmV0ICZsdDsgMCkgezxicj4NCi3CoCDCoCDCoCDC
oCBlcnJvcl9zZXRnKGVycnAsICZxdW90O0Nhbm5vdCBsb2FkIENBIGNlcnRpZmljYXRlICYjMzk7
JXMmIzM5OzogJXMmcXVvdDssPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2Fj
ZXJ0LCBnbnV0bHNfc3RyZXJyb3IocmV0KSk7PGJyPg0KK8KgIMKgIMKgIMKgIHFjcnlwdG9fdGxz
X2NyZWRzX3g1MDlfc2FuaXR5X2NoZWNrKGNyZWRzLCBmaWxlcywgaXNTZXJ2ZXIsPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGNlcnQsIGVycnApICZsdDsgMCkgezxicj4NCsKgIMKgIMKgIMKgIMKgcmV0dXJuIC0x
Ozxicj4NCsKgIMKgIMKgfTxicj4NCjxicj4NCi0tIDxicj4NCjIuNTEuMTxicj4NCjxicj4NCjwv
YmxvY2txdW90ZT48L2Rpdj48L2Rpdj4NCg==
--0000000000003dacbd064275bffe--


