Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D790C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 09:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF824-0006cV-Fm; Wed, 14 May 2025 05:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uF81z-0006QT-H3
 for qemu-devel@nongnu.org; Wed, 14 May 2025 05:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uF81x-0002Ez-Dl
 for qemu-devel@nongnu.org; Wed, 14 May 2025 05:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747213438;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=RxBzzm6GzcB+OXIwYldTaoD4DTkh1FcpPahOXjM/WsM=;
 b=BLWnrJnGEh3Z5JT9GCxxhA9VYpPEEmMWWOlXza/HEHPmfxixz90drbk0iAWe7QBgwYiWfy
 nDV36sl0NaMzWISl89sJZRdZCYKU9UZV63HRruVDwh1PuwbNZE9bTTMtBCgVk47nuh1dvH
 k4YdMC6vfHPaDjDhbc+1AQaDul6M3uc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-tw1EpkU1NvyBy6IfX5Y6xw-1; Wed,
 14 May 2025 05:03:55 -0400
X-MC-Unique: tw1EpkU1NvyBy6IfX5Y6xw-1
X-Mimecast-MFC-AGG-ID: tw1EpkU1NvyBy6IfX5Y6xw_1747213433
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 628DE1800370; Wed, 14 May 2025 09:03:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.147])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED11119560A3; Wed, 14 May 2025 09:03:47 +0000 (UTC)
Date: Wed, 14 May 2025 10:03:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, walling@linux.ibm.com, jjherne@linux.ibm.com,
 jrossi@linux.ibm.com, fiuczy@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 02/25] hw/s390x/ipl: Create certificate store
Message-ID: <aCRccMVidyvEZZzp@redhat.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-3-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250508225042.313672-3-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, May 08, 2025 at 06:50:18PM -0400, Zhuoying Cai wrote:
> Create a certificate store for boot certificates used for secure IPL.
> 
> Load certificates from the -boot-certificate option into the cert store.
> 
> Currently, only x509 certificates in DER format and uses SHA-256 hashing
> algorithm are supported, as these are the types required for secure boot
> on s390.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  crypto/meson.build          |   5 +-
>  crypto/x509-utils.c         | 163 ++++++++++++++++++++++++
>  hw/s390x/cert-store.c       | 242 ++++++++++++++++++++++++++++++++++++
>  hw/s390x/cert-store.h       |  39 ++++++
>  hw/s390x/ipl.c              |   9 ++
>  hw/s390x/ipl.h              |   3 +
>  hw/s390x/meson.build        |   1 +
>  include/crypto/x509-utils.h |   6 +
>  include/hw/s390x/ipl/qipl.h |   3 +
>  qapi/crypto.json            |  80 ++++++++++++


Please split the crypto subsystem changes from the s390x subsystem
changes, as separate commits. Also be sure to CC myself (as crypto
maintainer) on patches that change the crypto subsystem.


> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 8bad00a51b..0b8cfc9022 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -11,6 +11,12 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "crypto/x509-utils.h"
> +
> +/*
> + * Surround with GNUTLS marco to ensure the interfaces are
> + * still available when GNUTLS is not enabled.

This comment is redundant - we don't need to explain
what an #ifdef does.

> + */
> +#ifdef CONFIG_GNUTLS
>  #include <gnutls/gnutls.h>
>  #include <gnutls/crypto.h>
>  #include <gnutls/x509.h>
> @@ -25,6 +31,94 @@ static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
>      [QCRYPTO_HASH_ALGO_RIPEMD160] = GNUTLS_DIG_RMD160,
>  };
>  
> +static const int qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS__MAX] = {
> +    [QCRYPTO_KEYID_FLAGS_SHA1] = GNUTLS_KEYID_USE_SHA1,
> +    [QCRYPTO_KEYID_FLAGS_SHA256] = GNUTLS_KEYID_USE_SHA256,
> +    [QCRYPTO_KEYID_FLAGS_SHA512] = GNUTLS_KEYID_USE_SHA512,
> +    [QCRYPTO_KEYID_FLAGS_BEST_KNOWN] = GNUTLS_KEYI_DUSE_BEST_KNOWN,
> +};
> +
> +static const int qcrypto_to_gnutls_cert_fmt_map[QCRYPTO_CERT_FMT__MAX] = {
> +    [QCRYPTO_CERT_FMT_DER] = GNUTLS_X509_FMT_DER,
> +    [QCRYPTO_CERT_FMT_PEM] = GNUTLS_X509_FMT_PEM,
> +};
> +
> +int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
> +                                 QCryptoCertFmt fmt, Error **errp)
> +{
> +    int rc;
> +    int ret = 0;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +
> +    if (fmt >= G_N_ELEMENTS(qcrypto_to_gnutls_cert_fmt_map)) {
> +        error_setg(errp, "Unknown certificate format");
> +        return ret;
> +    }
> +
> +    if (gnutls_x509_crt_init(&crt) < 0) {
> +        error_setg(errp, "Failed to initialize certificate");
> +        goto cleanup;
> +    }
> +
> +    rc = gnutls_x509_crt_import(crt, &datum, qcrypto_to_gnutls_cert_fmt_map[fmt]);
> +    if (rc == GNUTLS_E_ASN1_TAG_ERROR) {
> +        ret = 0;
> +        goto cleanup;
> +    }
> +
> +    ret = 1;
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return ret;
> +}
> +
> +static int qcrypto_get_x509_cert_fmt(uint8_t *cert, size_t size, Error **errp)
> +{
> +    int fmt;
> +
> +    if (qcrypto_check_x509_cert_fmt(cert, size, QCRYPTO_CERT_FMT_DER, errp)) {
> +        fmt = GNUTLS_X509_FMT_DER;
> +    } else if (qcrypto_check_x509_cert_fmt(cert, size, QCRYPTO_CERT_FMT_PEM, errp)) {
> +        fmt = GNUTLS_X509_FMT_PEM;
> +    } else {
> +        return -1;
> +    }
> +
> +    return fmt;
> +}
> +
> +int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg, Error **errp)
> +{
> +    if (alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
> +        error_setg(errp, "Unknown hash algorithm");
> +        return 0;
> +    }
> +
> +    return gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
> +}
> +
> +int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag, Error **errp)
> +{
> +    QCryptoHashAlgo alg;
> +
> +    if (flag >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map)) {
> +        error_setg(errp, "Unknown key id flag");
> +        return 0;
> +    }
> +
> +    alg = QCRYPTO_HASH_ALGO_SHA1;
> +    if ((flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_SHA512]) ||
> +        (flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_BEST_KNOWN])) {
> +        alg = QCRYPTO_HASH_ALGO_SHA512;
> +    } else if (flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_SHA256]) {
> +        alg = QCRYPTO_HASH_ALGO_SHA256;
> +    }
> +
> +    return qcrypto_get_x509_hash_len(alg, errp);
> +}

This method looks fairly pointless to me. Why doesn't the caller just
directly call qcrypto_get_x509_hash_len without this indirection of
QCRYPTO_KEYID_FLAGS, especially given that you've just hardcoded to
use of QCRYPTO_KEYID_FLAGS_SHA256 in the caller ?

> @@ -74,3 +168,72 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>      gnutls_x509_crt_deinit(crt);
>      return ret;
>  }
> +
> +int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp)
> +{
> +    int rc = -1;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +    gnutls_x509_crt_fmt_t fmt;
> +
> +    fmt = qcrypto_get_x509_cert_fmt(cert, size, errp);
> +    if (fmt == -1) {
> +        error_setg(errp, "Certificate is neither in DER or PEM format");
> +        return rc;
> +    }
> +
> +    if (gnutls_x509_crt_init(&crt) < 0) {
> +        error_setg(errp, "Failed to initialize certificate");
> +        return rc;
> +    }
> +
> +    if (gnutls_x509_crt_import(crt, &datum, fmt) != 0) {
> +        error_setg(errp, "Failed to import certificate");
> +        goto cleanup;
> +    }

This code pattern looks dubious to me.  The qcrypto_get_x509_cert_fmt
method will call qcrypto_check_x509_cert_fmt which will call
gnutls_x509_crt_import(), the result of which is then thrown
away, and this method calls gnutls_x509_crt_import again. Get
rid of qcrypto_check_x509_cert_fmt from this. 

> +
> +    rc = gnutls_x509_crt_get_signature_algorithm(crt);

This needs to be remapped to the QCryptoSigAlgo enum values.

> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return rc;
> +}
> +
> +#else /* ! CONFIG_GNUTLS */
> +
> +int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
> +                                 QCryptoCertFmt fmt, Error **errp)
> +{
> +    error_setg(errp, "To get certificate format requires GNUTLS");
> +    return -ENOTSUP;
> +}
> +
> +int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg, Error **errp)
> +{
> +    error_setg(errp, "To get hash length requires GNUTLS");
> +    return -ENOTSUP;
> +}
> +
> +int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag, Error **errp)
> +{
> +    error_setg(errp, "To get key ID length requires GNUTLS");
> +    return -ENOTSUP;
> +}
> +
> +int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
> +                                      QCryptoHashAlgo hash,
> +                                      uint8_t *result,
> +                                      size_t *resultlen,
> +                                      Error **errp)
> +{
> +    error_setg(errp, "To get fingerprint requires GNUTLS");
> +    return -ENOTSUP;
> +}
> +
> +int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp)
> +{
> +    error_setg(errp, "To get signature algorithm requires GNUTLS");
> +    return -ENOTSUP;
> +}
> +
> +#endif /* ! CONFIG_GNUTLS */
> diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
> index 1e99661a71..8fb263b9e1 100644
> --- a/include/crypto/x509-utils.h
> +++ b/include/crypto/x509-utils.h
> @@ -19,4 +19,10 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>                                        size_t *resultlen,
>                                        Error **errp);
>  
> +int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
> +                                 QCryptoCertFmt fmt, Error **errp);
> +int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg, Error **errp);
> +int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag, Error **errp);
> +int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp);

Please add API docs for each method.


> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index c9d967d782..2bbf29affe 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -612,3 +612,83 @@
>    'base': { 'alg': 'QCryptoAkCipherAlgo' },
>    'discriminator': 'alg',
>    'data': { 'rsa': 'QCryptoAkCipherOptionsRSA' }}
> +
> +##
> +# @QCryptoKeyidFlags:
> +#
> +# The supported flags for the key ID
> +#
> +# @sha1: SHA-1
> +#
> +# @sha256: SHA-256
> +#
> +# @sha512: SHA-512
> +#
> +# @best-known: BEST-KNOWN
> +#
> +# Since: 9.2
> +##
> +{ 'enum': 'QCryptoKeyidFlags',
> +  'data': ['sha1', 'sha256', 'sha512', 'best-known']}
> +
> +##
> +# @QCryptoCertFmt:
> +#
> +# The supported certificate encoding formats
> +#
> +# @der: DER
> +#
> +# @pem: PEM
> +#
> +# Since: 9.2

We're in the 10.1 dev cycle


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


