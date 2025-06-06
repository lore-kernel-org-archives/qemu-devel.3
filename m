Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA41C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNUUq-0001eE-96; Fri, 06 Jun 2025 06:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNUUm-0001dq-Q9
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:40:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNUUk-0004zj-0c
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749206416;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=dMf4mYBKKjendOz0E4TiSWv62iOHPap1cf9EfBTeDD4=;
 b=Bif+KxOPphAO863Mh/4Jfqf0hPSVoY7DG1HFvW/DHcjWIfP6nNsTbeDB0f7O9KkhI5p+Fj
 7a+LfAo79/9zHag9a0AJAj9DX/L1jTV+vsQmLSH34/IGnXtgjToX6V75MkW09klsUoDHmQ
 nvBUWqX7+nFvuttpMnm82jHijpOGebc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-SScMp0whMWSynspDs2eTAw-1; Fri,
 06 Jun 2025 06:40:14 -0400
X-MC-Unique: SScMp0whMWSynspDs2eTAw-1
X-Mimecast-MFC-AGG-ID: SScMp0whMWSynspDs2eTAw_1749206413
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D79331800772; Fri,  6 Jun 2025 10:40:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 010C318003FC; Fri,  6 Jun 2025 10:40:06 +0000 (UTC)
Date: Fri, 6 Jun 2025 11:40:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, walling@linux.ibm.com, jjherne@linux.ibm.com,
 jrossi@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 08/28] crypto/x509-utils: Add helper functions for
 DIAG 320 subcode 2
Message-ID: <aELFg1kUzxqWUlIr@redhat.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-9-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250604215657.528142-9-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jun 04, 2025 at 05:56:36PM -0400, Zhuoying Cai wrote:
> Add helper functions for x509 certificate which will be used in the next
> patch for DIAG 320 subcode 2.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  crypto/x509-utils.c         | 190 +++++++++++++++++++++++++++++++++++-
>  include/crypto/x509-utils.h |  63 ++++++++++++
>  qapi/crypto.json            |  20 ++++
>  3 files changed, 272 insertions(+), 1 deletion(-)
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 7a7f12c111..dd8137210c 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -60,6 +60,14 @@ static const int gnutls_to_qcrypto_sig_alg_map[QCRYPTO_SIG_ALGO__MAX] = {
>      [GNUTLS_SIGN_ECDSA_SHA512] = QCRYPTO_SIG_ALGO_ECDSA_SHA512,
>  };
>  
> +static const int gnutls_to_qcrypto_pk_alg_map[QCRYPTO_PK_ALGO__MAX] = {
> +    [GNUTLS_PK_UNKNOWN] = QCRYPTO_PK_ALGO_UNKNOWN,
> +    [GNUTLS_PK_RSA] = QCRYPTO_PK_ALGO_RSA,
> +    [GNUTLS_PK_DSA] = QCRYPTO_PK_ALGO_DSA,
> +    [GNUTLS_PK_DH] = QCRYPTO_PK_ALGO_DH,
> +    [GNUTLS_PK_ECDSA] = QCRYPTO_PK_ALGO_ECDSA,
> +};
> +
>  int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
>                                  QCryptoCertFmt fmt, Error **errp)
>  {
> @@ -153,7 +161,7 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>  
>      gnutls_x509_crt_init(&crt);
>  
> -    if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) != 0) {
> +    if (qcrypto_import_x509_cert(crt, &datum) != 0) {

Don't change this - we want PEM format exclusively as our input.

>          error_setg(errp, "Failed to import certificate");
>          goto cleanup;
>      }
> @@ -204,6 +212,158 @@ cleanup:
>      return rc;
>  }
>  
> +int qcrypto_get_x509_cert_version(uint8_t *cert, size_t size, Error **errp)
> +{
> +    int rc = -1;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +
> +    if (gnutls_x509_crt_init(&crt) < 0) {
> +        error_setg(errp, "Failed to initialize certificate");
> +        return rc;
> +    }
> +
> +    if (qcrypto_import_x509_cert(crt, &datum) != 0) {
> +        error_setg(errp, "Failed to import certificate");
> +        goto cleanup;
> +    }
> +
> +    rc = gnutls_x509_crt_get_version(crt);
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return rc;
> +}
> +
> +int qcrypto_check_x509_cert_times(uint8_t *cert, size_t size, Error **errp)
> +{
> +    int rc = -1;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +    time_t now = time(0);
> +    time_t exp_time;
> +    time_t act_time;
> +
> +    if (now == ((time_t)-1)) {
> +        error_setg_errno(errp, errno, "Cannot get current time");
> +        return rc;
> +    }
> +
> +    if (gnutls_x509_crt_init(&crt) < 0) {
> +        error_setg(errp, "Failed to initialize certificate");

Missing gnutls_strerror info

> +        return rc;
> +    }
> +
> +    if (qcrypto_import_x509_cert(crt, &datum) != 0) {
> +        error_setg(errp, "Failed to import certificate");
> +        goto cleanup;
> +    }
> +
> +    exp_time = gnutls_x509_crt_get_expiration_time(crt);
> +    if (exp_time == ((time_t)-1)) {
> +        error_setg(errp, "Failed to get certificate expiration time");
> +        goto cleanup;
> +    }
> +    if (exp_time < now) {
> +        error_setg(errp, "The certificate has expired");
> +        goto cleanup;
> +    }
> +
> +    act_time = gnutls_x509_crt_get_activation_time(crt);
> +    if (act_time == ((time_t)-1)) {
> +        error_setg(errp, "Failed to get certificate activation time");
> +        goto cleanup;
> +    }
> +    if (act_time > now) {
> +        error_setg(errp, "The certificate is not yet active");
> +        goto cleanup;
> +    }
> +
> +    rc = 0;
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return rc;
> +}
> +
> +int qcrypto_get_x509_pk_algorithm(uint8_t *cert, size_t size, Error **errp)
> +{
> +    int rc = -1;
> +    unsigned int bits;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +
> +    if (gnutls_x509_crt_init(&crt) < 0) {
> +        error_setg(errp, "Failed to initialize certificate");

Missing gnutls_strerror info

> +        return rc;
> +    }
> +
> +    if (qcrypto_import_x509_cert(crt, &datum) != 0) {
> +        error_setg(errp, "Failed to import certificate");
> +        goto cleanup;
> +    }
> +
> +    rc = gnutls_x509_crt_get_pk_algorithm(crt, &bits);

Missing error reporting

> +    rc = gnutls_to_qcrypto_pk_alg_map[rc];

Missing bounds checking

Also use separate 'ret' vs 'rc' variables for the overall
function return status vs intermediate calls

> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return rc;
> +}
> +
> +int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
> +                                 QCryptoKeyidFlags flag,
> +                                 uint8_t *result,
> +                                 size_t *resultlen,
> +                                 Error **errp)
> +{
> +    int ret = -1;
> +    int keyid_len;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +
> +    if (flag >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map)) {
> +        error_setg(errp, "Unknown key id flag");
> +        return -1;
> +    }
> +
> +    if (result == NULL) {
> +        error_setg(errp, "No valid buffer given");
> +        return -1;
> +    }
> +
> +    if (gnutls_x509_crt_init(&crt)) {
> +        error_setg(errp, "Failed to initialize certificate");
> +        return -1;
> +    }
> +
> +    if (qcrypto_import_x509_cert(crt, &datum) != 0) {
> +        error_setg(errp, "Failed to import certificate");
> +        goto cleanup;
> +    }
> +
> +    keyid_len = qcrypto_get_x509_keyid_len(qcrypto_to_gnutls_keyid_flags_map[flag]);
> +    if (*resultlen < keyid_len) {
> +        error_setg(errp,
> +                   "Result buffer size %zu is smaller than key id %d",
> +                   *resultlen, keyid_len);
> +        goto cleanup;
> +    }

This is avoided if this function is responsible for allocating
'result' to be the right size to begin with.

> +
> +    if (gnutls_x509_crt_get_key_id(crt,
> +                                   qcrypto_to_gnutls_keyid_flags_map[flag],
> +                                   result, resultlen) != 0) {
> +        error_setg(errp, "Failed to get fingerprint from certificate");
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
>  #else /* ! CONFIG_GNUTLS */
>  
>  int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
> @@ -239,4 +399,32 @@ int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **err
>      return -ENOTSUP;
>  }
>  
> +int qcrypto_get_x509_cert_version(uint8_t *cert, size_t size, Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to get certificate version");
> +    return -ENOTSUP;

No returning errnors please.

> +}
> +
> +int qcrypto_check_x509_cert_times(uint8_t *cert, size_t size, Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to get certificate times")
> +    return -ENOTSUP;
> +}
> +
> +int qcrypto_get_x509_pk_algorithm(uint8_t *cert, size_t size, Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to get public key algorithm");
> +    return -ENOTSUP;
> +}
> +
> +int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
> +                                 QCryptoKeyidFlags flag,
> +                                 uint8_t *result,
> +                                 size_t *resultlen,
> +                                 Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to get key ID");
> +    return -ENOTSUP;
> +}
> +
>  #endif /* ! CONFIG_GNUTLS */
> diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
> index d7be57c8ce..4a9941b33d 100644
> --- a/include/crypto/x509-utils.h
> +++ b/include/crypto/x509-utils.h
> @@ -73,4 +73,67 @@ int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag);
>   */
>  int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp);
>  
> +/**
> + * qcrypto_get_x509_cert_version
> + * @cert: pointer to the raw certiricate data

                                  ^^^^^^ typo..again below

> + * @size: size of the certificate
> + * @errp: error pointer
> + *
> + * Determine the version of the @cert.
> + *
> + * Returns: version of certificate on success,
> + *          negative error code on error,
> + *          -ENOTSUP if GNUTLS is not enabled.

Nope, only return '-1' on error - all details belong in 'errp

> + */
> +int qcrypto_get_x509_cert_version(uint8_t *cert, size_t size, Error **errp);
> +
> +/**
> + * qcrypto_check_x509_cert_times
> + * @cert: pointer to the raw certiricate data
> + * @size: size of the certificate
> + * @errp: error pointer
> + *
> + * Check whether the @cert activation and expiration times are valid at the current time.
> + *
> + * Returns: 0 if the certificate times are valid,
> + *         -1 on error,
> + *         -ENOTSUP if GNUTLS is not enabled.
> + */
> +int qcrypto_check_x509_cert_times(uint8_t *cert, size_t size, Error **errp);
> +
> +/**
> + * qcrypto_get_x509_pk_algorithm
> + * @cert: pointer to the raw certiricate data
> + * @size: size of the certificate
> + * @errp: error pointer
> + *
> + * Determine the public key algorithm of the @cert.
> + *
> + * Returns: a value from the QCryptoPkAlgo enum on success,
> + *          -1 on error,
> + *          -ENOTSUP if GNUTLS is not enabled.
> + */
> +int qcrypto_get_x509_pk_algorithm(uint8_t *cert, size_t size, Error **errp);
> +
> +/**
> + * qcrypto_get_x509_cert_key_id
> + * @cert: pointer to the raw certiricate data
> + * @size: size of the certificate
> + * @flag: the key ID flag
> + * @result: pointer to a buffer to store output key ID (may not be null)
> + * @resultlen: pointer to the size of the buffer
> + * @errp: error pointer
> + *
> + * Retrieve the key ID from the @cert based on the specified @flag.
> + *
> + * Returns: 0 if key ID was successfully stored in @result,
> + *         -1 on error,
> + *         -ENOTSUP if GNUTLS is not enabled.
> + */
> +int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
> +                                 QCryptoKeyidFlags flag,
> +                                 uint8_t *result,
> +                                 size_t *resultlen,

Better calling convention is to use 'uint8_t **result' and have
this method allocate a correct size buffer & return its size
in 'resultlen'.

> +                                 Error **errp);
> +
>  #endif

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


