Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5482AC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 17:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueGNM-0000ws-F7; Tue, 22 Jul 2025 13:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ueFpK-00086J-Jv
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 12:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ueFpI-00058h-62
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 12:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753201606;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4U4hk3SbyF4fzDFM/xcPqn3l/4wxLGbTv2QtODqxoQI=;
 b=bVuAuyp0YKuQM4Ms1EZqkwGEtdGw4UZhMr2LrAtDwSrFtEcjWEEtlXXY9yb8Gb7eCtPNIo
 nQDn8l1JO45YFO/lkzokmDZC5bbhCJlwh5qyk9zCSays5SLIpZuG3He/62kV96nhYcXu4J
 w8s7jTNO7ojp0pwCW/sRbZaaCCluzo0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-pi3MmGdwPUClHFie0_Ta8Q-1; Tue,
 22 Jul 2025 12:26:43 -0400
X-MC-Unique: pi3MmGdwPUClHFie0_Ta8Q-1
X-Mimecast-MFC-AGG-ID: pi3MmGdwPUClHFie0_Ta8Q_1753201601
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D91AF1800C31; Tue, 22 Jul 2025 16:26:40 +0000 (UTC)
Received: from redhat.com (dhcp-16-135.lcy.redhat.com [10.42.16.135])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A5FB195608D; Tue, 22 Jul 2025 16:26:36 +0000 (UTC)
Date: Tue, 22 Jul 2025 17:26:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
Subject: Re: [PATCH v4 11/28] crypto/x509-utils: Add helper functions for
 DIAG 508 subcode 1
Message-ID: <aH-7uhXDuT6HoJ52@redhat.com>
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-12-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711211105.439554-12-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On Fri, Jul 11, 2025 at 05:10:47PM -0400, Zhuoying Cai wrote:
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
>  crypto/x509-utils.c         | 110 ++++++++++++++++++++++++++++++++++++
>  include/crypto/x509-utils.h |  39 +++++++++++++
>  2 files changed, 149 insertions(+)
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 135f83f55e..2b1ed5ee26 100644
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
> @@ -366,6 +367,98 @@ cleanup:
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
> +    *resultlen = sig_datum_pem.size;
> +
> +    ret = 0;
> +
> +cleanup:
> +    gnutls_pkcs7_deinit(signature);
> +    return ret;
> +}
> +
> +int qcrypto_x509_verify_sig(uint8_t *cert, size_t cert_size,
> +                            uint8_t *comp, size_t comp_size,
> +                            uint8_t *sig, size_t sig_size, Error **errp)
> +{
> +    int rc;
> +    int ret = -1;
> +    gnutls_x509_crt_t crt;

 = NULL;

> +    gnutls_pkcs7_t signature;

 = NULL;

> +    gnutls_datum_t cert_datum = {.data = cert, .size = cert_size};
> +    gnutls_datum_t data_datum = {.data = comp, .size = comp_size};
> +    gnutls_datum_t sig_datum = {.data = sig, .size = sig_size};
> +
> +    rc = gnutls_x509_crt_init(&crt);
> +    if (rc < 0) {
> +        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
> +        return ret;

goto cleanup;

> +    }
> +
> +    rc = gnutls_x509_crt_import(crt, &cert_datum, GNUTLS_X509_FMT_PEM);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
> +        gnutls_x509_crt_deinit(crt);

Drop this

> +        return ret;

goto cleanup;

> +    }
> +
> +    rc = gnutls_pkcs7_init(&signature);
> +    if (rc < 0) {
> +        error_setg(errp, "Failed to initalize pkcs7 data: %s", gnutls_strerror(rc));
> +        gnutls_x509_crt_deinit(crt);
> +        return ret;

Likewise

> +     }
> +
> +    rc = gnutls_pkcs7_import(signature, &sig_datum , GNUTLS_X509_FMT_PEM);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to import signature: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    rc = gnutls_pkcs7_verify_direct(signature, crt, 0, &data_datum, 0);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to verify signature: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    ret = 0;
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    gnutls_pkcs7_deinit(signature);

Both of these are safe to call with NULL, hence we can add the
"goto cleanup" mentioned above.

> +    return ret;
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


