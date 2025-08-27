Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D33CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 17:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKDa-0006vB-Sb; Wed, 27 Aug 2025 13:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urKDB-0006YG-Rv
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 13:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urKCk-0006TA-9w
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 13:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756316698;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ktOsCl5p/x1RSW4EXh/CJ4GF06t1xYR+nKlVzN5lRdE=;
 b=ZJY3HrfzEnK4NRBroYST2MoFGYqYPQ+TnoQFeNImoDxfsp4I9bYWafzCDuc9C+BY7HRFPq
 uyYNjyhiDH9EI3R5ydZNgGAAiwMENstcgztNPdE+l8+wBsEnBCfUr+wFa8yiLrGBDow9nQ
 Hi46Upzc05O5BZa5izWo+n1e24206ts=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-mS1iNbXQONmSbYYKev8fOg-1; Wed,
 27 Aug 2025 13:44:53 -0400
X-MC-Unique: mS1iNbXQONmSbYYKev8fOg-1
X-Mimecast-MFC-AGG-ID: mS1iNbXQONmSbYYKev8fOg_1756316691
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3960619560B2; Wed, 27 Aug 2025 17:44:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2244180044F; Wed, 27 Aug 2025 17:44:45 +0000 (UTC)
Date: Wed, 27 Aug 2025 18:44:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
Subject: Re: [PATCH v5 11/29] crypto/x509-utils: Add helper functions for
 DIAG 508 subcode 1
Message-ID: <aK9ECfS7Y_dgBYSj@redhat.com>
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-12-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250818214323.529501-12-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Mon, Aug 18, 2025 at 05:43:04PM -0400, Zhuoying Cai wrote:
> Introduce helper functions to support signature verification required by
> DIAG 508 subcode 1:
> 
> qcrypto_pkcs7_convert_sig_pem() – converts a signature from DER to PEM format
> qcrypto_x509_verify_sig() – verifies the provided data against the given signature
> 
> These functions enable basic signature verification support.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  crypto/x509-utils.c         | 108 ++++++++++++++++++++++++++++++++++++
>  include/crypto/x509-utils.h |  39 +++++++++++++
>  2 files changed, 147 insertions(+)
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 67b42aad1f..f582e2ee48 100644
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
> @@ -275,6 +276,96 @@ cleanup:
>      return ret;
>  }
>  
> +int qcrypto_pkcs7_convert_sig_pem(uint8_t *sig, size_t sig_size,
> +                                  uint8_t **result, size_t *resultlen,
> +                                  Error **errp)
> +{
> +    int ret = -1;
> +    int rc;
> +    gnutls_pkcs7_t signature;
> +    gnutls_datum_t sig_datum_der = {.data = sig, .size = sig_size};
> +    gnutls_datum_t sig_datum_pem = { 0, };
> +
> +    rc = gnutls_pkcs7_init(&signature);
> +    if (rc < 0) {
> +        error_setg(errp, "Failed to initalize pkcs7 data: %s", gnutls_strerror(rc));
> +        return ret;
> +     }
> +
> +    rc = gnutls_pkcs7_import(signature, &sig_datum_der, GNUTLS_X509_FMT_DER);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to import signature: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    rc = gnutls_pkcs7_export2(signature, GNUTLS_X509_FMT_PEM, &sig_datum_pem);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to convert signature to PEM format: %s",
> +                   gnutls_strerror(rc));
> +        gnutls_free(sig_datum_pem.data);
> +        goto cleanup;
> +    }
> +
> +    *result = g_steal_pointer(&sig_datum_pem.data);

I just realized we should actually allocate a buffer with g_new and
copy over from sig_datum_pem, because we can't safely assume that
gnutls buffers can be freed with the system free(), only gnutls_free()

> +    *resultlen = sig_datum_pem.size;
> +
> +    ret = 0;
> +
> +cleanup:
> +    gnutls_pkcs7_deinit(signature);
> +    return ret;
> +}
With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


