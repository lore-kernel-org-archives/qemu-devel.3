Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4EFCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 17:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urJxJ-00053i-Cj; Wed, 27 Aug 2025 13:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urJxD-00050l-2f
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 13:29:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urJx7-0003Ym-2m
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 13:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756315731;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4+FAD41aOIQaQoifucOrBOhX07NMrL7lbrpKM9pfkeU=;
 b=EyseiSYwsFdUeptueOnOvg8sBWoEqYJVgNgEG1EQ662Ga9k3JZLZ2b3wvIJt8kK/ktBcwm
 j/dym6odw+x+4w5FteIj7cldzCrzncDj3tjN86BrjZ1kS0wKs+lJvDLgvZYfyDe59JNtA7
 Z1byB6B1C3pk78tReS/aMJERZDonpLQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-QFBD-ZuVNSqfTzVlXrwxbw-1; Wed,
 27 Aug 2025 13:28:49 -0400
X-MC-Unique: QFBD-ZuVNSqfTzVlXrwxbw-1
X-Mimecast-MFC-AGG-ID: QFBD-ZuVNSqfTzVlXrwxbw_1756315727
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF80419560B5; Wed, 27 Aug 2025 17:28:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61E1519560AD; Wed, 27 Aug 2025 17:28:41 +0000 (UTC)
Date: Wed, 27 Aug 2025 18:28:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
Subject: Re: [PATCH v5 03/29] crypto/x509-utils: Add helper functions for
 certificate store
Message-ID: <aK9ARYO83XACYPYZ@redhat.com>
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-4-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818214323.529501-4-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Mon, Aug 18, 2025 at 05:42:56PM -0400, Zhuoying Cai wrote:
> Introduce new helper functions for x509 certificate, which will be used
> by the certificate store:
> 
> qcrypto_x509_convert_cert_der() - converts a certificate from PEM to DER format
> 
> These functions provide support for certificate format conversion.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  crypto/x509-utils.c         | 51 +++++++++++++++++++++++++++++++++++++
>  include/crypto/x509-utils.h | 20 +++++++++++++++
>  2 files changed, 71 insertions(+)
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 6176a88653..29d5146bb2 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -81,6 +81,48 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>      return ret;
>  }
>  
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
> +    if (*resultlen == 0) {
> +        error_setg(errp, "Invalid buffer size");
> +        goto cleanup;
> +    }

Requiring resultlen to be set as an input parameter is strange, when
this function is allocating the buffer. It would be better if we
ignore resultlen on input and....


> +
> +    *result = g_malloc0(*resultlen);
> +    rc = gnutls_x509_crt_export(crt, GNUTLS_X509_FMT_DER, *result, resultlen);

Use 'gnutls_x509_crt_export2' instead

     datum.data = NULL;
     datum.size = 0;
     rc = gnutls_x509_crt_export2(crt, GNUTLS_X509_FMT_DER, &datum);
     if (rc != 0) {
     ....
     }
     *result = g_new0(uint8_t, datum.size);
     *resultlen = datum.size;
     memcpy(result, datum.data, datum.size);
     gnutls_free(datum.data);

> +    if (rc != 0) {
> +        error_setg(errp, "Failed to convert certificate to DER format: %s",
> +                   gnutls_strerror(rc));
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
>  #else /* ! CONFIG_GNUTLS */
>  
>  int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
> @@ -93,4 +135,13 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>      return -1;
>  }
>  
> +int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
> +                                  uint8_t **result,
> +                                  size_t *resultlen,
> +                                  Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to export X.509 certificate");
> +    return -1;
> +}
> +
>  #endif /* ! CONFIG_GNUTLS */
> diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
> index 1e99661a71..4239e3e55a 100644
> --- a/include/crypto/x509-utils.h
> +++ b/include/crypto/x509-utils.h
> @@ -19,4 +19,24 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>                                        size_t *resultlen,
>                                        Error **errp);
>  
> +/**
> + * qcrypto_x509_convert_cert_der
> + * @cert: pointer to the raw certificate data in PEM format
> + * @size: size of the certificate
> + * @result: output location for the allocated buffer for the certificate in DER format
> +            (the function allocates memory which must be freed by the caller)
> + * @resultlen: pointer to the size of the buffer
> +               (will be updated with the actual size of the DER-encoded certificate)
> + * @errp: error pointer
> + *
> + * Convert the given @cert from PEM to DER format.
> + *
> + * Returns: 0 on success,
> + *         -1 on error.
> + */
> +int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
> +                                  uint8_t **result,
> +                                  size_t *resultlen,
> +                                  Error **errp);
> +
>  #endif
> -- 
> 2.50.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


