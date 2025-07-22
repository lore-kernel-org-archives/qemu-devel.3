Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEEBC83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 16:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueGGO-0007nX-22; Tue, 22 Jul 2025 12:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ueFVi-00059t-Ha
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 12:06:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ueFVe-0000Vt-54
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 12:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753200388;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8PkPdoAtbd73SLURCB7Bp7l06Gqgo0BdBWA7rBDnXxA=;
 b=OpBLiKqrRcGPdxxoum4sNjEps+Lvu9moYDna+iHwRo5g2o2r3Sws/DQ2tdn4t8+Xj03Etd
 TgcQ9C/zzhisSjwup6WCt6b+if3GD0DUu+3+KrRSwJrtFtdzD19UwRdB2K2G3N0dkLToa4
 KOemURZ/S5DO9iFB6jrbic50kSc1C3o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-KCVoaJhjOX6BFuXpIu_c-A-1; Tue,
 22 Jul 2025 12:06:25 -0400
X-MC-Unique: KCVoaJhjOX6BFuXpIu_c-A-1
X-Mimecast-MFC-AGG-ID: KCVoaJhjOX6BFuXpIu_c-A_1753200383
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4B691800294; Tue, 22 Jul 2025 16:06:22 +0000 (UTC)
Received: from redhat.com (dhcp-16-135.lcy.redhat.com [10.42.16.135])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E307E18003FC; Tue, 22 Jul 2025 16:06:18 +0000 (UTC)
Date: Tue, 22 Jul 2025 17:06:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
Subject: Re: [PATCH v4 02/28] crypto/x509-utils: Add helper functions for
 certificate store
Message-ID: <aH-294Q-03CRPJHN@redhat.com>
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-3-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250711211105.439554-3-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 11, 2025 at 05:10:38PM -0400, Zhuoying Cai wrote:
> Introduce new helper functions for x509 certificate, which will be used
> by the certificate store:
> 
> qcrypto_x509_convert_cert_der() - converts a certificate from PEM to DER format
> qcrypto_x509_get_keyid_len() - returns the length of the key ID
> qcrypto_x509_get_signature_algorithm() - returns signature algorithm of the certificate
> 
> These functions provide support for certificate format conversion and
> metadata extraction.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  crypto/meson.build          |   5 +-
>  crypto/x509-utils.c         | 155 ++++++++++++++++++++++++++++++++++++
>  include/crypto/x509-utils.h |  71 +++++++++++++++++
>  3 files changed, 227 insertions(+), 4 deletions(-)
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

Lets make this change, plus....

>  if nettle.found()
>    crypto_ss.add(nettle, files('hash-nettle.c', 'hmac-nettle.c', 'pbkdf-nettle.c'))
>    if hogweed.found()
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 8bad00a51b..d2cf790d5b 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -11,6 +11,8 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "crypto/x509-utils.h"
> +
> +#ifdef CONFIG_GNUTLS

...this addition as a separate commit. They are refactoring the
way we build the code, without adding any features, so best
practice says they should be separated from feature additions.



>  #include <gnutls/gnutls.h>
>  #include <gnutls/crypto.h>
>  #include <gnutls/x509.h>
> @@ -25,6 +27,87 @@ static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
>      [QCRYPTO_HASH_ALGO_RIPEMD160] = GNUTLS_DIG_RMD160,
>  };
>  
> +static const int qcrypto_to_gnutls_keyid_flags_map[] = {
> +    [QCRYPTO_KEYID_FLAGS_SHA1] = GNUTLS_KEYID_USE_SHA1,
> +    [QCRYPTO_KEYID_FLAGS_SHA256] = GNUTLS_KEYID_USE_SHA256,
> +    [QCRYPTO_KEYID_FLAGS_SHA512] = GNUTLS_KEYID_USE_SHA512,
> +    [QCRYPTO_KEYID_FLAGS_BEST_KNOWN] = GNUTLS_KEYID_USE_BEST_KNOWN,
> +};
> +
> +static const int gnutls_to_qcrypto_sig_alg_map[] = {
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
> +int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
> +                                  uint8_t **result, size_t *resultlen,
> +                                  Error **errp)
> +{
> +    int ret = -1;
> +    int rc;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +
> +    rc = gnutls_x509_crt_init(&crt);
> +    if (rc < 0) {
> +        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
> +        return ret;
> +    }
> +
> +    rc = gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    *result = g_malloc0(*resultlen);
> +    rc = gnutls_x509_crt_export(crt, GNUTLS_X509_FMT_DER, *result, resultlen);
> +    if (rc != 0) {

We need to  do   "g_clear_pointer(result, g_free)"  in this error path

> +        error_setg(errp, "Failed to convert certificate to DER format: %s",
> +                   gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    ret = 0;
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return ret;
> +}
> +
> +int qcrypto_x509_get_keyid_len(QCryptoKeyidFlags flag, Error **errp)
> +{
> +    if (flag >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map)) {
> +        error_setg(errp, "Unknow key ID flag %d", flag);
> +        return -1;
> +    }
> +
> +    if ((flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_SHA512]) ||
> +        (flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_BEST_KNOWN])) {
> +        return QCRYPTO_HASH_DIGEST_LEN_SHA512;
> +    } else if (flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_SHA256]) {
> +        return QCRYPTO_HASH_DIGEST_LEN_SHA256;
> +    } else {
> +        return QCRYPTO_HASH_DIGEST_LEN_SHA1;
> +    }
> +}
> +

If we eliminate the QCryptoKeyidFlags enum, then the need for this
method also goes away.

>  int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>                                        QCryptoHashAlgo alg,
>                                        uint8_t *result,
> @@ -74,3 +157,75 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>      gnutls_x509_crt_deinit(crt);
>      return ret;
>  }
> +
> +int qcrypto_x509_get_signature_algorithm(uint8_t *cert, size_t size, Error **errp)
> +{
> +    int rc;
> +    int ret = -1;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +
> +    rc = gnutls_x509_crt_init(&crt);
> +    if (rc < 0) {
> +        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
> +        return ret;
> +    }
> +
> +    rc = gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    /*
> +     * This function never returns a negative error code.
> +     * Error cases and unknown/unsupported signature algorithms
> +     * are mapped to GNUTLS_SIGN_UNKNOWN.
> +     */
> +    rc = gnutls_x509_crt_get_signature_algorithm(crt);
> +    if (rc >= G_N_ELEMENTS(gnutls_to_qcrypto_sig_alg_map)) {
> +        error_setg(errp, "Unknown signature algorithm %d", rc);
> +        goto cleanup;
> +    }
> +
> +    ret = gnutls_to_qcrypto_sig_alg_map[rc];
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return ret;
> +}
> +
> +#else /* ! CONFIG_GNUTLS */
> +
> +int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
> +                                  uint8_t **result,
> +                                  size_t *resultlen,
> +                                  Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to export X.509 certificate");
> +    return -1;
> +}
> +
> +int qcrypto_x509_get_keyid_len(QCryptoKeyidFlags flag, Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to get key ID length");
> +    return -1;
> +}
> +
> +int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
> +                                      QCryptoHashAlgo hash,
> +                                      uint8_t *result,
> +                                      size_t *resultlen,
> +                                      Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to get fingerprint");
> +    return -1;
> +}

If you separate out the  meson.build + #ifdef CONFIG_GNUTLS change, then
this specific stub should be done in that refactoring commit too.

> +
> +int qcrypto_x509_get_signature_algorithm(uint8_t *cert, size_t size, Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to get signature algorithm");
> +    return -1;
> +}
> +
> +#endif /* ! CONFIG_GNUTLS */
> diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
> index 1e99661a71..d916d248bb 100644
> --- a/include/crypto/x509-utils.h
> +++ b/include/crypto/x509-utils.h
> @@ -13,10 +13,81 @@
>  
>  #include "crypto/hash.h"
>  
> +typedef enum {
> +    QCRYPTO_KEYID_FLAGS_SHA1,
> +    QCRYPTO_KEYID_FLAGS_SHA256,
> +    QCRYPTO_KEYID_FLAGS_SHA512,
> +    QCRYPTO_KEYID_FLAGS_BEST_KNOWN,
> +} QCryptoKeyidFlags;

I don't think this enum serves any useful purpose.

The qcrypto_x509_get_cert_key_id method should just accept
the QCryptoHashAlgo enum directly and avoid the redirextion.

> +
> +typedef enum {
> +    QCRYPTO_SIG_ALGO_UNKNOWN,
> +    QCRYPTO_SIG_ALGO_RSA_SHA1,
> +    QCRYPTO_SIG_ALGO_DSA_SHA1,
> +    QCRYPTO_SIG_ALGO_RSA_MD5,
> +    QCRYPTO_SIG_ALGO_RSA_MD2,
> +    QCRYPTO_SIG_ALGO_RSA_RMD160,
> +    QCRYPTO_SIG_ALGO_RSA_SHA256,
> +    QCRYPTO_SIG_ALGO_RSA_SHA384,
> +    QCRYPTO_SIG_ALGO_RSA_SHA512,
> +    QCRYPTO_SIG_ALGO_RSA_SHA224,
> +    QCRYPTO_SIG_ALGO_DSA_SHA224,
> +    QCRYPTO_SIG_ALGO_DSA_SHA256,
> +    QCRYPTO_SIG_ALGO_ECDSA_SHA1,
> +    QCRYPTO_SIG_ALGO_ECDSA_SHA224,
> +    QCRYPTO_SIG_ALGO_ECDSA_SHA256,
> +    QCRYPTO_SIG_ALGO_ECDSA_SHA384,
> +    QCRYPTO_SIG_ALGO_ECDSA_SHA512,
> +} QCryptoSigAlgo;
> +
>  int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>                                        QCryptoHashAlgo hash,
>                                        uint8_t *result,
>                                        size_t *resultlen,
>                                        Error **errp);
>  

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


