Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3116FC5B559
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNUkf-00085z-C1; Fri, 06 Jun 2025 06:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNUkb-00085S-5a
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNUkX-00075k-2Y
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749207388;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DgycZ2aWP+00v1EhwW4Iwc87xOJWQDeUkpUdjV17KS0=;
 b=KKs+W2I/jcgSM0OswLA/ljuw94ffDkLTnRbauRIcU2cDXQWX+HXKkNbp/mdPdP+OTNocwX
 ZeHpl6/IfoR4coEmZab+kWXXq1MAdSYPrjWpBFh9GhLf+s7iyYywU3WqAUeCk6s8DqX/We
 hTl06pOcIdf2AlZW4T/j/AL4EewBvhI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-_UUxDeqtOJO8MBcEXf4hHg-1; Fri,
 06 Jun 2025 06:56:25 -0400
X-MC-Unique: _UUxDeqtOJO8MBcEXf4hHg-1
X-Mimecast-MFC-AGG-ID: _UUxDeqtOJO8MBcEXf4hHg_1749207383
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FB9118002B5; Fri,  6 Jun 2025 10:56:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D20671956087; Fri,  6 Jun 2025 10:56:17 +0000 (UTC)
Date: Fri, 6 Jun 2025 11:56:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, walling@linux.ibm.com, jjherne@linux.ibm.com,
 jrossi@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 11/28] crypto: Add helper functions for DIAG 508
 subcode 1
Message-ID: <aELJTt8aVbAaINo0@redhat.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-12-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250604215657.528142-12-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jun 04, 2025 at 05:56:39PM -0400, Zhuoying Cai wrote:
> Add helper functions for x509 certificate which will be used in the next
> patch for DIAG 508 subcode 1.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  crypto/x509-utils.c         | 61 +++++++++++++++++++++++++++++++++++++
>  include/crypto/x509-utils.h | 20 ++++++++++++
>  2 files changed, 81 insertions(+)
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index dd8137210c..4c997cf5d4 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -16,6 +16,7 @@
>  #include <gnutls/gnutls.h>
>  #include <gnutls/crypto.h>
>  #include <gnutls/x509.h>
> +#include <gnutls/pkcs7.h>
>  
>  static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
>      [QCRYPTO_HASH_ALGO_MD5] = GNUTLS_DIG_MD5,
> @@ -364,6 +365,58 @@ cleanup:
>      return ret;
>  }
>  
> +static int qcrypto_import_pkcs7(gnutls_pkcs7_t pkcs7, gnutls_datum_t *datum)
> +{
> +    int rc;
> +
> +    rc = gnutls_pkcs7_import(pkcs7, datum , GNUTLS_X509_FMT_PEM);
> +    if (rc) {
> +        rc = gnutls_pkcs7_import(pkcs7, datum , GNUTLS_X509_FMT_DER);
> +    }
> +
> +    return rc;
> +}

Again use PEM exclusively which avoids this helper.

> +
> +int qcrypto_verify_x509_cert(uint8_t *cert, size_t cert_size,
> +                             uint8_t *comp, size_t comp_size,
> +                             uint8_t *sig, size_t sig_size, Error **errp)

This is a sub-optimal name as it is not verifying the cert,
it is using the cert to verify a signature.

Incidentally I've just remembered that crypto all methods introduced
by this patch series should use 'qcrypto_x509_' as the prefix.

IOW, call this qcrypto_x509_verify_signature, and similar pattern
in earlier patches.

> +{
> +    int rc = -1;
> +    gnutls_x509_crt_t crt;
> +    gnutls_pkcs7_t signature;
> +    gnutls_datum_t cert_datum = {.data = cert, .size = cert_size};
> +    gnutls_datum_t data_datum = {.data = comp, .size = comp_size};
> +    gnutls_datum_t sig_datum = {.data = sig, .size = sig_size};
> +
> +    if (gnutls_x509_crt_init(&crt) < 0) {
> +        error_setg(errp, "Failed to initialize certificate");
> +        return rc;
> +    }
> +
> +    if (qcrypto_import_x509_cert(crt, &cert_datum) != 0) {
> +        error_setg(errp, "Failed to import certificate");
> +        gnutls_x509_crt_deinit(crt);
> +        return rc;
> +    }
> +
> +    if (gnutls_pkcs7_init(&signature) < 0) {
> +        error_setg(errp, "Failed to initalize pkcs7 data.");

gnutls_strerror details please, and no full stop required.

> +        return rc;
> +    }
> +
> +    if (qcrypto_import_pkcs7(signature, &sig_datum) != 0) {
> +        error_setg(errp, "Failed to import signature");
> +        goto cleanup;
> +    }
> +
> +    rc = gnutls_pkcs7_verify_direct(signature, crt, 0, &data_datum, 0);

This is failing to set 'errp',  and also should not be returning
the raw gnutls value, only '-1' on failure, '0' on success

> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    gnutls_pkcs7_deinit(signature);
> +    return rc;
> +}
> +
>  #else /* ! CONFIG_GNUTLS */
>  

> +/**
> + * qcrypto_verify_x509_cert
> + * @cert: pointer to the raw certiricate data
> + * @cert_size: size of the certificate
> + * @comp: pointer to the component to be verified
> + * @comp_size: size of the component
> + * @sig: pointer to the signature
> + * @sig_size: size of the signature
> + * @errp: error pointer
> + *
> + * Verify the provided @comp against the @sig and @cert.
> + *
> + * Returns: 0 on success,
> + *          negative error code on error,
> + *          -ENOTSUP if GNUTLS is not enabled.

Only -1 on error, no gnutls error codes nor errnos

> + */
> +int qcrypto_verify_x509_cert(uint8_t *cert, size_t cert_size,
> +                             uint8_t *comp, size_t comp_size,
> +                             uint8_t *sig, size_t sig_size, Error **errp);
> +
>  #endif
> -- 
> 2.49.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


