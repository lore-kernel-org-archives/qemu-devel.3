Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAF0C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 16:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueGKp-0005JY-PR; Tue, 22 Jul 2025 12:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ueFj8-00041W-Rc
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 12:20:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ueFj6-0004Hk-AM
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 12:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753201222;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=IvzUrpKrwhK1g5v5oAUeAaMdsRBf+YM265r61Jmqeao=;
 b=Jf7O0TpqJMWwMyo5WZoeaqGFaG0p2kWWoXPmxqov0STzcipDmRxgUXhKiAviOFYYOXtohS
 pQ+P8wfdc6CbgtDjtfP30usY4LDwlwA9yEZYzK7EnApzxEcLIwNURcgpBuKIYxgF2TRx/l
 cUQWMyn469hWnNy1hm+lrURu2G+TtbI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-6dhjpjksPiG12msIzfbNkw-1; Tue,
 22 Jul 2025 12:20:18 -0400
X-MC-Unique: 6dhjpjksPiG12msIzfbNkw-1
X-Mimecast-MFC-AGG-ID: 6dhjpjksPiG12msIzfbNkw_1753201216
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B73F01944D23; Tue, 22 Jul 2025 16:20:16 +0000 (UTC)
Received: from redhat.com (dhcp-16-135.lcy.redhat.com [10.42.16.135])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DF8D30001A4; Tue, 22 Jul 2025 16:20:12 +0000 (UTC)
Date: Tue, 22 Jul 2025 17:20:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
Subject: Re: [PATCH v4 08/28] crypto/x509-utils: Add helper functions for
 DIAG 320 subcode 2
Message-ID: <aH-6OV5_Q2YcYUgb@redhat.com>
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-9-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250711211105.439554-9-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jul 11, 2025 at 05:10:44PM -0400, Zhuoying Cai wrote:
> Introduce new helper functions to extract certificate metadata needed for
> DIAG 320 subcode 2:
> 
> qcrypto_x509_get_cert_version() - retrieves version of a certificate
> qcrypto_x509_check_cert_times() - validates the certificate's validity period against the current time
> qcrypto_x509_get_pk_algorithm() - returns the public key algorithm used in the certificate
> qcrypto_x509_get_cert_key_id() - extracts the key ID from the certificate
> 
> These functions provide support for metadata extraction and validity checking
> for X.509 certificates.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  crypto/x509-utils.c         | 199 ++++++++++++++++++++++++++++++++++++
>  include/crypto/x509-utils.h |  76 +++++++++++++-
>  2 files changed, 272 insertions(+), 3 deletions(-)
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index d2cf790d5b..135f83f55e 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -55,6 +55,14 @@ static const int gnutls_to_qcrypto_sig_alg_map[] = {
>      [GNUTLS_SIGN_ECDSA_SHA512] = QCRYPTO_SIG_ALGO_ECDSA_SHA512,
>  };
>  
> +static const int gnutls_to_qcrypto_pk_alg_map[] = {
> +    [GNUTLS_PK_UNKNOWN] = QCRYPTO_PK_ALGO_UNKNOWN,
> +    [GNUTLS_PK_RSA] = QCRYPTO_PK_ALGO_RSA,
> +    [GNUTLS_PK_DSA] = QCRYPTO_PK_ALGO_DSA,
> +    [GNUTLS_PK_DH] = QCRYPTO_PK_ALGO_DH,
> +    [GNUTLS_PK_ECDSA] = QCRYPTO_PK_ALGO_ECDSA,
> +};
> +
>  int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
>                                    uint8_t **result, size_t *resultlen,
>                                    Error **errp)
> @@ -195,6 +203,169 @@ cleanup:
>      return ret;
>  }
>  
> +int qcrypto_x509_get_cert_version(uint8_t *cert, size_t size, Error **errp)
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
> +    rc = gnutls_x509_crt_get_version(crt);
> +    if (rc < 0) {
> +        error_setg(errp, "Failed to get certificate version: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    ret = rc;
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return ret;
> +}

I'm not convinced this method needs to exist. QEMU doesn't care about the
cert version, and if something else consuming the data from guest OS/firmware
cares, then it can validate the version.

> +int qcrypto_x509_get_pk_algorithm(uint8_t *cert, size_t size, Error **errp)
> +{
> +    int rc;
> +    int ret = -1;
> +    unsigned int bits;
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
> +    rc = gnutls_x509_crt_get_pk_algorithm(crt, &bits);
> +    if (rc >= G_N_ELEMENTS(gnutls_to_qcrypto_pk_alg_map)) {
> +        error_setg(errp, "Unknown public key algorithm %d", rc);
> +        goto cleanup;
> +    }
> +
> +    ret = gnutls_to_qcrypto_pk_alg_map[rc];
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return ret;
> +}
> +
> +int qcrypto_x509_get_cert_key_id(uint8_t *cert, size_t size,
> +                                 QCryptoKeyidFlags flag,

IMHO this can just use  "QCryptoHashAlgo hash_alg"

> +                                 uint8_t **result,
> +                                 size_t *resultlen,
> +                                 Error **errp)
> +{
> +    int rc;
> +    int ret = -1;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +
> +    *resultlen = qcrypto_x509_get_keyid_len(qcrypto_to_gnutls_keyid_flags_map[flag],
> +                                            errp);
> +    if (*resultlen == -1) {
> +        return ret;
> +    }
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
> +    if (gnutls_x509_crt_get_key_id(crt,
> +                                   qcrypto_to_gnutls_keyid_flags_map[flag],
> +                                   *result, resultlen) != 0) {
> +        error_setg(errp, "Failed to get key ID from certificate");
> +        goto cleanup;
> +    }
> +
> +    ret = 0;
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return ret;
> +}


> @@ -53,10 +61,10 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>   * @result: output location for the allocated buffer for the certificate in DER format
>              (the function allocates memory which must be freed by the caller)
>   * @resultlen: pointer to the size of the buffer
> -               (will be replaced by the actual size of the DER-encoded certificate)
> +               (will be updated with the actual size of the DER-encoded certificate)
>   * @errp: error pointer
>   *
> - * Convert given @cert from PEM to DER format.
> + * Convert the given @cert from PEM to DER format.
>   *
>   * Returns: 0 on success,
>   *         -1 on error.
> @@ -70,7 +78,7 @@ int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
>   * qcrypto_x509_get_keyid_len
>   * @flag: the key ID flag
>   *
> - * Determine the length of the key ID of the given @flag.
> + * Determine the length of the key ID corresponding to the given @flag.
>   *
>   * Returns: the length on success,
>   *          -1 on error.


Squash these changes into the arlier patch that introduced the mistakes,


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


