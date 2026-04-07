Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0948FF5137
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABUD-0005h1-5v; Tue, 07 Apr 2026 14:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wABS8-0002em-OL
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wA8mt-0001ui-5V
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 11:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775577382;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YJ5wLc4u342CPd2ImDhK3k7T8EZx/R4UfOZ9BeVXG2A=;
 b=KmlccMCOow8SawVQPDTtAhRsoUPAyOKg8IbQm5sjKT2lZ/IjOTKxwpzub+AtsX/G3X3e4s
 /Yxi8Rj0qEwG1NDsofv+0sBVVFZG5imkcCQdjOxUU7qa1UHmx7O4Gd5B8Su0L4c5Rszpom
 Wy2Rj8dpaoMCBkooNJUd11zonMxF6xg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-qYBCrvGkPWGLUcDKpu9qyA-1; Tue,
 07 Apr 2026 11:56:20 -0400
X-MC-Unique: qYBCrvGkPWGLUcDKpu9qyA-1
X-Mimecast-MFC-AGG-ID: qYBCrvGkPWGLUcDKpu9qyA_1775577378
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03200195605E; Tue,  7 Apr 2026 15:56:18 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6530419560A6; Tue,  7 Apr 2026 15:56:13 +0000 (UTC)
Date: Tue, 7 Apr 2026 16:56:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, jrossi@linux.ibm.com,
 cohuck@redhat.com, richard.henderson@linaro.org,
 pierrick.bouvier@linaro.org, david@kernel.org,
 walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
Subject: Re: [PATCH v10 03/30] crypto/x509-utils: Add helper functions for
 certificate store
Message-ID: <adUpGiQHAi2yoLmt@redhat.com>
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-4-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402221453.1602899-4-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Thu, Apr 02, 2026 at 06:14:25PM -0400, Zhuoying Cai wrote:
> Introduce new helper functions for x509 certificate, which will be used
> by the certificate store:
> 
> qcrypto_x509_convert_cert_der() - converts a certificate from PEM to DER format
> 
> These functions provide support for certificate format conversion.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Acked-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  crypto/x509-utils.c         | 49 +++++++++++++++++++++++++++++++++++++
>  include/crypto/x509-utils.h | 21 ++++++++++++++++
>  2 files changed, 70 insertions(+)
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 6176a88653..2696d48155 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -81,6 +81,46 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
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
> +    gnutls_datum_t datum_der = {.data = NULL, .size = 0};
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
> +    rc = gnutls_x509_crt_export2(crt, GNUTLS_X509_FMT_DER, &datum_der);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to convert certificate to DER format: %s",
> +                   gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    *resultlen = datum_der.size;
> +    *result = g_memdup2(datum_der.data, datum_der.size);
> +
> +    ret = 0;
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    gnutls_free(datum_der.data);

Please use "g_free" here.

gnutls_free does nothing since gnutls deprecated gnutls_global_set_mem_functions
and turned its impl into a no-op, but the use of gnutls_free will break builds
with CFI enabled.

Same comment for the later patches to x509-utils.c that use gnutls_free.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


