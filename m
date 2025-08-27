Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DCDCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 17:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urK5P-0000uI-7i; Wed, 27 Aug 2025 13:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urK5C-0000qn-Nw
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 13:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urK58-0005RT-TN
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 13:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756316220;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5PPbvMOkxc2xqOT26qL8+SdWd3/2wr/TafPAZG3ZXbE=;
 b=Qy1iZajSnl8kk9ajwRt9Ha3Barwl0a0jmiu9/FXv1LlxqWqqaFFNWmrgBe0TEKYya7Uj5C
 LpMqB9kSQmRhtWfBC051GUCwsy0BC0PylIp7OldCaD2DJAK25UVkk6h58iNg35nmCWVYRR
 I7D1jJkW7Y+GSP4spDBf7AUn88VxJIo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-ou4pd3XuNVGj9mtliFzgIA-1; Wed,
 27 Aug 2025 13:36:56 -0400
X-MC-Unique: ou4pd3XuNVGj9mtliFzgIA-1
X-Mimecast-MFC-AGG-ID: ou4pd3XuNVGj9mtliFzgIA_1756316214
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13AFC1800370; Wed, 27 Aug 2025 17:36:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 956C71977686; Wed, 27 Aug 2025 17:36:48 +0000 (UTC)
Date: Wed, 27 Aug 2025 18:36:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
Subject: Re: [PATCH v5 08/29] crypto/x509-utils: Add helper functions for
 DIAG 320 subcode 2
Message-ID: <aK9CLbhICMPKFZgD@redhat.com>
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-9-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818214323.529501-9-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Aug 18, 2025 at 05:43:01PM -0400, Zhuoying Cai wrote:
> Introduce new helper functions to extract certificate metadata needed for
> DIAG 320 subcode 2:
> 
> qcrypto_x509_check_cert_times() - validates the certificate's validity period against the current time
> qcrypto_x509_get_pk_algorithm() - returns the public key algorithm used in the certificate
> qcrypto_x509_get_cert_key_id() - extracts the key ID from the certificate
> 
> These functions provide support for metadata extraction and validity checking
> for X.509 certificates.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  crypto/x509-utils.c         | 174 ++++++++++++++++++++++++++++++++++++
>  include/crypto/x509-utils.h |  58 ++++++++++++
>  2 files changed, 232 insertions(+)
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 29d5146bb2..67b42aad1f 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -27,6 +27,21 @@ static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
>      [QCRYPTO_HASH_ALGO_RIPEMD160] = GNUTLS_DIG_RMD160,
>  };
>  
> +static const int gnutls_to_qcrypto_pk_alg_map[] = {
> +    [GNUTLS_PK_RSA] = QCRYPTO_PK_ALGO_RSA,
> +    [GNUTLS_PK_DSA] = QCRYPTO_PK_ALGO_DSA,
> +    [GNUTLS_PK_ECDSA] = QCRYPTO_PK_ALGO_ECDSA,
> +    [GNUTLS_PK_RSA_OAEP] = QCRYPTO_PK_ALGO_RSA_OAEP,
> +    [GNUTLS_PK_EDDSA_ED25519] = QCRYPTO_PK_ALGO_ED25519,
> +    [GNUTLS_PK_EDDSA_ED448] = QCRYPTO_PK_ALGO_ED448,
> +};
> +
> +static const int qcrypto_to_gnutls_keyid_flags_map[] = {
> +    [QCRYPTO_HASH_ALGO_SHA1] = GNUTLS_KEYID_USE_SHA1,
> +    [QCRYPTO_HASH_ALGO_SHA256] = GNUTLS_KEYID_USE_SHA256,
> +    [QCRYPTO_HASH_ALGO_SHA512] = GNUTLS_KEYID_USE_SHA512,
> +};
> +
>  int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>                                        QCryptoHashAlgo alg,
>                                        uint8_t *result,
> @@ -123,6 +138,143 @@ cleanup:
>      return ret;
>  }
>  

> +
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
> +                                 QCryptoHashAlgo hash_alg,
> +                                 uint8_t **result,
> +                                 size_t *resultlen,
> +                                 Error **errp)
> +{
> +    int rc;
> +    int ret = -1;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +
> +    if (hash_alg >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map)) {

Must also check qcrypto_to_gnutls_hash_alg_map bounds.

> +        error_setg(errp, "Unknow hash algorithm %d", hash_alg);

's/Unknow/Unknown/'

> +        return ret;
> +     }
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
> +    *resultlen = gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[hash_alg]);
> +    if (*resultlen == 0) {
> +        error_setg(errp, "Failed to get hash algorithn length: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    *result = g_malloc0(*resultlen);
> +    if (gnutls_x509_crt_get_key_id(crt,
> +                                   qcrypto_to_gnutls_keyid_flags_map[hash_alg],
> +                                   *result, resultlen) != 0) {
> +        error_setg(errp, "Failed to get key ID from certificate");
> +        g_clear_pointer(result, g_free);
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

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


