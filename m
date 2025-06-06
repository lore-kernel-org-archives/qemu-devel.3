Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4462EC5B559
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTvU-0006nF-Oq; Fri, 06 Jun 2025 06:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNTvN-0006kF-6U
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNTvF-0006oR-EK
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749204215;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kZ9L5EGOgNggAPnW4NLdvH93jxRhd3SyJXMcvelDHfw=;
 b=ADYmkFTCug4Tva6Wvia/M5yMyzS8W6F1EPKSVSxGCA9Vg5F0HXFS+ZEeO8UuFkV+wSHEYp
 o/k1ZckNERgSmEH9TlDWHVXQIiVnBulalgRrxPqiOrdylvSWElwKqBHwiQqYifiXRMSxZa
 FqH9QAc/vHgw1E69dMj2Bdt6eqvShF4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-XO_KVVytNAmpe8KJRITliQ-1; Fri,
 06 Jun 2025 06:03:31 -0400
X-MC-Unique: XO_KVVytNAmpe8KJRITliQ-1
X-Mimecast-MFC-AGG-ID: XO_KVVytNAmpe8KJRITliQ_1749204210
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C00D19560B2; Fri,  6 Jun 2025 10:03:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00A60180035E; Fri,  6 Jun 2025 10:03:24 +0000 (UTC)
Date: Fri, 6 Jun 2025 11:03:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, walling@linux.ibm.com, jjherne@linux.ibm.com,
 jrossi@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 02/28] crypto/x509-utils: Add helper functions for
 certificate store
Message-ID: <aEK86dSVDBGxguM8@redhat.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-3-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250604215657.528142-3-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 04, 2025 at 05:56:30PM -0400, Zhuoying Cai wrote:
> Add helper functions for x509 certificate which will be used in the next
> patch for the certificate store.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  crypto/meson.build          |   5 +-
>  crypto/x509-utils.c         | 166 ++++++++++++++++++++++++++++++++++++
>  include/crypto/x509-utils.h |  54 ++++++++++++
>  qapi/crypto.json            |  80 +++++++++++++++++
>  4 files changed, 301 insertions(+), 4 deletions(-)
> 
> diff --git a/crypto/meson.build b/crypto/meson.build
> index 735635de1f..0614bfa914 100644
> --- a/crypto/meson.build
> +++ b/crypto/meson.build
> @@ -22,12 +22,9 @@ crypto_ss.add(files(
>    'tlscredsx509.c',
>    'tlssession.c',
>    'rsakey.c',
> +  'x509-utils.c',
>  ))
>  
> -if gnutls.found()
> -  crypto_ss.add(files('x509-utils.c'))
> -endif
> -
>  if nettle.found()
>    crypto_ss.add(nettle, files('hash-nettle.c', 'hmac-nettle.c', 'pbkdf-nettle.c'))
>    if hogweed.found()
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 8bad00a51b..7a7f12c111 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -11,6 +11,8 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "crypto/x509-utils.h"
> +
> +#ifdef CONFIG_GNUTLS
>  #include <gnutls/gnutls.h>
>  #include <gnutls/crypto.h>
>  #include <gnutls/x509.h>
> @@ -25,6 +27,109 @@ static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
>      [QCRYPTO_HASH_ALGO_RIPEMD160] = GNUTLS_DIG_RMD160,
>  };
>  
> +static const int qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS__MAX] = {
> +    [QCRYPTO_KEYID_FLAGS_SHA1] = GNUTLS_KEYID_USE_SHA1,
> +    [QCRYPTO_KEYID_FLAGS_SHA256] = GNUTLS_KEYID_USE_SHA256,
> +    [QCRYPTO_KEYID_FLAGS_SHA512] = GNUTLS_KEYID_USE_SHA512,
> +    [QCRYPTO_KEYID_FLAGS_BEST_KNOWN] = GNUTLS_KEYID_USE_BEST_KNOWN,
> +};
> +
> +static const int qcrypto_to_gnutls_cert_fmt_map[QCRYPTO_CERT_FMT__MAX] = {
> +    [QCRYPTO_CERT_FMT_DER] = GNUTLS_X509_FMT_DER,
> +    [QCRYPTO_CERT_FMT_PEM] = GNUTLS_X509_FMT_PEM,
> +};
> +
> +static const int gnutls_to_qcrypto_sig_alg_map[QCRYPTO_SIG_ALGO__MAX] = {
> +    [GNUTLS_SIGN_UNKNOWN] = QCRYPTO_SIG_ALGO_UNKNOWN,
> +    [GNUTLS_SIGN_RSA_SHA1] = QCRYPTO_SIG_ALGO_RSA_SHA1,
> +    [GNUTLS_SIGN_RSA_SHA] = QCRYPTO_SIG_ALGO_RSA_SHA1,
> +    [GNUTLS_SIGN_DSA_SHA1] = QCRYPTO_SIG_ALGO_DSA_SHA1,
> +    [GNUTLS_SIGN_RSA_MD5] = QCRYPTO_SIG_ALGO_RSA_MD5,
> +    [GNUTLS_SIGN_RSA_MD2] = QCRYPTO_SIG_ALGO_RSA_MD2,
> +    [GNUTLS_SIGN_RSA_RMD160] = QCRYPTO_SIG_ALGO_RSA_RMD160,
> +    [GNUTLS_SIGN_RSA_SHA256] = QCRYPTO_SIG_ALGO_RSA_SHA256,
> +    [GNUTLS_SIGN_RSA_SHA384] = QCRYPTO_SIG_ALGO_RSA_SHA384,
> +    [GNUTLS_SIGN_RSA_SHA512] = QCRYPTO_SIG_ALGO_RSA_SHA512,
> +    [GNUTLS_SIGN_RSA_SHA224] = QCRYPTO_SIG_ALGO_RSA_SHA224,
> +    [GNUTLS_SIGN_DSA_SHA224] = QCRYPTO_SIG_ALGO_DSA_SHA224,
> +    [GNUTLS_SIGN_DSA_SHA256] = QCRYPTO_SIG_ALGO_DSA_SHA256,
> +    [GNUTLS_SIGN_ECDSA_SHA1] = QCRYPTO_SIG_ALGO_ECDSA_SHA1,
> +    [GNUTLS_SIGN_ECDSA_SHA224] = QCRYPTO_SIG_ALGO_ECDSA_SHA224,
> +    [GNUTLS_SIGN_ECDSA_SHA256] = QCRYPTO_SIG_ALGO_ECDSA_SHA256,
> +    [GNUTLS_SIGN_ECDSA_SHA384] = QCRYPTO_SIG_ALGO_ECDSA_SHA384,
> +    [GNUTLS_SIGN_ECDSA_SHA512] = QCRYPTO_SIG_ALGO_ECDSA_SHA512,
> +};
> +
> +int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
> +                                QCryptoCertFmt fmt, Error **errp)
> +{
> +    int rc;
> +    int ret = -1;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +
> +    if (fmt >= G_N_ELEMENTS(qcrypto_to_gnutls_cert_fmt_map)) {
> +        error_setg(errp, "Unknown certificate format");

Always include the actual invalid value in messages like this

       error_setg(errp, "Unknown certificate format %d", fmt);

> +        return ret;
> +    }
> +
> +    if (gnutls_x509_crt_init(&crt) < 0) {
> +        error_setg(errp, "Failed to initialize certificate");

Include the real error message please

  rc = gnutls_x509_crt_init(&crt);
  if (rc < 0) {
     error_setg(errp, "Failed to initialize certificate: %s",
                gnutls_strerror(rc));
  }

> +        return ret;
> +    }
> +
> +    rc = gnutls_x509_crt_import(crt, &datum, qcrypto_to_gnutls_cert_fmt_map[fmt]);
> +    if (rc == GNUTLS_E_ASN1_TAG_ERROR) {
> +        goto cleanup;

This is jumping to the error cleanup path without filling 'errp'.

> +    }
> +
> +    ret = 0;
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return ret;
> +}
> +
> +int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg)
> +{
> +    if (alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
> +        return 0;
> +    }
> +
> +    return gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
> +}

This is just reinventing the qcrypto_hash_digest_len method,
drop it please.

> +int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag)
> +{
> +    QCryptoHashAlgo alg;
> +
> +    if (flag >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map)) {
> +        return 0;
> +    }
> +
> +    alg = QCRYPTO_HASH_ALGO_SHA1;
> +    if ((flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_SHA512]) ||
> +        (flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_BEST_KNOWN])) {

What is this comparison wanting to do ?

'flag' is declared as being a member of the QCryptoKeyidFlags enum

The code is checking 'flag' is in range for the bounds
of the qcrypto_to_gnutls_keyid_flags_map array, but then
'flag' is never used as an index for that array.

then the code takes the result of "qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_SHA512]"
which is a GNUTLS keyid constant, and compares it to 'flag' which is
a QCryptoKeyidFlags value.

This makes no sense at all.

> +        alg = QCRYPTO_HASH_ALGO_SHA512;
> +    } else if (flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_SHA256]) {
> +        alg = QCRYPTO_HASH_ALGO_SHA256;
> +    }
> +
> +    return qcrypto_get_x509_hash_len(alg);
> +}

This indirection via 'alg' is pointless when we have constants
for hash sizes already

     if ((flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_SHA512]) ||
         (flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_BEST_KNOWN])) {
         return QCRYPTO_HASH_DIGEST_LEN_SHA512;
     } else if (flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_SHA256]) {
         return QCRYPTO_HASH_DIGEST_LEN_SHA256;
     } else {
         return QCRYPTO_HASH_DIGEST_LEN_SHA1;
     }


> +
> +static int qcrypto_import_x509_cert(gnutls_x509_crt_t crt, gnutls_datum_t *datum)
> +{
> +    int rc;
> +
> +    rc = gnutls_x509_crt_import(crt, datum, GNUTLS_X509_FMT_PEM);
> +    if (rc) {
> +        rc = gnutls_x509_crt_import(crt, datum, GNUTLS_X509_FMT_DER);
> +    }

Must report the gnutls_strerror into an "errp" parameter.

> +
> +    return rc;
> +}
> +
>  int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>                                        QCryptoHashAlgo alg,
>                                        uint8_t *result,
> @@ -74,3 +179,64 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>      gnutls_x509_crt_deinit(crt);
>      return ret;
>  }
> +
> +int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp)
> +{
> +    int rc = -1;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +
> +    if (gnutls_x509_crt_init(&crt) < 0) {
> +        error_setg(errp, "Failed to initialize certificate");

This must include the gnutls_sterrror result

> +        return rc;
> +    }
> +
> +    if (qcrypto_import_x509_cert(crt, &datum) != 0) {

'errp' must be passed into this so it can report an accurate message...

> +        error_setg(errp, "Failed to import certificate");

..as this is useless.


> +        goto cleanup;
> +    }
> +
> +    rc = gnutls_x509_crt_get_signature_algorithm(crt);

This is not handling errors.

> +    rc = gnutls_to_qcrypto_sig_alg_map[rc];

This is not bounds checking the value.

Also it is bad practice to re-use the same variable for
two different purposes. Use 'ret' for tracking the overall
return status of this functino, and use 'rc' for things
this function calls.

> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return rc;
> +}
> +
> +#else /* ! CONFIG_GNUTLS */
> +
> +int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
> +                                QCryptoCertFmt fmt, Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to get certificate format");
> +    return -ENOTSUP;

No returning of errnos in crypto APIs please, only
the 'errp' parameter and 'return -1'.

> +}
> +
> +int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg)
> +{
> +    return -ENOTSUP;
> +}
> +
> +int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag)
> +{
> +    return -ENOTSUP;
> +}
> +
> +int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
> +                                      QCryptoHashAlgo hash,
> +                                      uint8_t *result,
> +                                      size_t *resultlen,
> +                                      Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to get fingerprint");
> +    return -ENOTSUP;
> +}
> +
> +int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to get signature algorithm");
> +    return -ENOTSUP;
> +}
> +
> +#endif /* ! CONFIG_GNUTLS */

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


