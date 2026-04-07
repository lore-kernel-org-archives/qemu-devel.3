Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502ABFF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABSH-0003Yq-0S; Tue, 07 Apr 2026 14:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wABRe-0002am-4P
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wA9Qv-000479-4c
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 12:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775579863;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yflob0hoXvPb/eeHXEt12mlIK+9sdbIHt8xFJjJk0LA=;
 b=AHbGM0zpRD81eqeQGfk0U8ZbcMDC1PrGyf5Gd1pdw2pNf6NqarQsRT1Itfafbm9qldCv0H
 6WjWrsGX2snnlCB1sxBuMEgNrmApCnmMYcIhViDnKs+QTRlWrX5FuOjePGaCKuKCyFTDfy
 /cQH+pbEfpa5JYVm0ARqh7lQSUzBgyg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-tUbBc6XIMcqubORdkm009A-1; Tue,
 07 Apr 2026 12:37:39 -0400
X-MC-Unique: tUbBc6XIMcqubORdkm009A-1
X-Mimecast-MFC-AGG-ID: tUbBc6XIMcqubORdkm009A_1775579857
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 054C019560B3; Tue,  7 Apr 2026 16:37:37 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81003300019F; Tue,  7 Apr 2026 16:37:32 +0000 (UTC)
Date: Tue, 7 Apr 2026 17:37:29 +0100
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
Subject: Re: [PATCH v10 11/30] crypto/x509-utils: Add helper functions for
 DIAG 508 subcode 1
Message-ID: <adUyydJBYs8u5j7K@redhat.com>
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
 <20260402221453.1602899-12-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402221453.1602899-12-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

On Thu, Apr 02, 2026 at 06:14:33PM -0400, Zhuoying Cai wrote:
> Introduce helper functions to support signature verification required by
> DIAG 508 subcode 1:
> 
> qcrypto_pkcs7_convert_sig_pem() – converts a signature from DER to PEM format
> qcrypto_x509_verify_sig() – verifies the provided data against the given signature
> 
> These functions enable basic signature verification support.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  crypto/x509-utils.c         | 108 ++++++++++++++++++++++++++++++++++++
>  include/crypto/x509-utils.h |  41 ++++++++++++++
>  2 files changed, 149 insertions(+)
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 906d5e5e87..2b991ff9ac 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c

> +int qcrypto_pkcs7_convert_sig_pem(uint8_t *sig, size_t sig_size,
> +                                  uint8_t **result, size_t *resultlen,
> +                                  Error **errp)
> +{
> +    int ret = -1;
> +    int rc;
> +    gnutls_pkcs7_t signature;
> +    gnutls_datum_t sig_datum_der = {.data = sig, .size = sig_size};
> +    gnutls_datum_t sig_datum_pem = {.data = NULL, .size = 0};
> +
> +    rc = gnutls_pkcs7_init(&signature);
> +    if (rc < 0) {
> +        error_setg(errp, "Failed to initialize pkcs7 data: %s", gnutls_strerror(rc));
> +        return ret;
> +    }
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
> +        goto cleanup;
> +    }
> +
> +    *resultlen = sig_datum_pem.size;
> +    *result = g_memdup2(sig_datum_pem.data, sig_datum_pem.size);
> +
> +    ret = 0;
> +
> +cleanup:
> +    gnutls_pkcs7_deinit(signature);
> +    gnutls_free(sig_datum_pem.data);

Change to g_free plesae

> +    return ret;
> +}

With that fixed

 Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
 Acked-by: Daniel P. Berrangé <berrange@redhat.com>
 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


