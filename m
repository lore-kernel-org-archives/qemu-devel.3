Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEACC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNU61-0001Z0-9b; Fri, 06 Jun 2025 06:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNU5x-0001Xt-KG
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:14:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNU5v-0000F8-0S
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749204876;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BCbIyiqEhxKCXJZHwh71NMDxqKoyGU9R+wWtHoALYqo=;
 b=JEida8XWdQG38ai/8gkFo9uDmlzVvuU253SKNOJi0cl66Pwb9kHoHbZA1TQwP4k2KvTJcq
 KivtMHDirJBdp9EXu6p3qFyDf12VIxg8xKovLI3aI/xmkjcHm76BnaZ1DqaHd89XDxFW9Q
 FT0DjG8P9vtZUISIlVS4z9MGigeZYl8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-AZZvhBU2MA-PzB3gBHZIKg-1; Fri,
 06 Jun 2025 06:14:33 -0400
X-MC-Unique: AZZvhBU2MA-PzB3gBHZIKg-1
X-Mimecast-MFC-AGG-ID: AZZvhBU2MA-PzB3gBHZIKg_1749204871
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D206218002BD; Fri,  6 Jun 2025 10:14:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79976195E74A; Fri,  6 Jun 2025 10:14:26 +0000 (UTC)
Date: Fri, 6 Jun 2025 11:14:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, walling@linux.ibm.com, jjherne@linux.ibm.com,
 jrossi@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 02/28] crypto/x509-utils: Add helper functions for
 certificate store
Message-ID: <aEK_f57-kymX4_Iu@redhat.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-3-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250604215657.528142-3-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Wed, Jun 04, 2025 at 05:56:30PM -0400, Zhuoying Cai wrote:
> Add helper functions for x509 certificate which will be used in the next
> patch for the certificate store.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  crypto/meson.build          |   5 +-
>  crypto/x509-utils.c         | 166 ++++++++++++++++++++++++++++++++++++
>  include/crypto/x509-utils.h |  54 ++++++++++++
>  qapi/crypto.json            |  80 +++++++++++++++++
>  4 files changed, 301 insertions(+), 4 deletions(-)


> +int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
> +                                QCryptoCertFmt fmt, Error **errp)
> +{
> +    int rc;
> +    int ret = -1;
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
> +        return ret;
> +    }
> +
> +    rc = gnutls_x509_crt_import(crt, &datum, qcrypto_to_gnutls_cert_fmt_map[fmt]);
> +    if (rc == GNUTLS_E_ASN1_TAG_ERROR) {
> +        goto cleanup;
> +    }
> +
> +    ret = 0;
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return ret;
> +}

On reflection I think this method should be removed entirely.
In terms of QEMU command line we should exclusively allow
certs in PEM format only. If we need DER format internally,
we can use gnutls to convert from PEM to DER.

> +
> +int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg)
> +{
> +    if (alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
> +        return 0;
> +    }
> +
> +    return gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
> +}
> +
> +int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag)
> +{
> +    QCryptoHashAlgo alg;
> +
> +    if (flag >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map)) {
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
> +    return qcrypto_get_x509_hash_len(alg);
> +}
> +
> +static int qcrypto_import_x509_cert(gnutls_x509_crt_t crt, gnutls_datum_t *datum)
> +{
> +    int rc;
> +
> +    rc = gnutls_x509_crt_import(crt, datum, GNUTLS_X509_FMT_PEM);
> +    if (rc) {
> +        rc = gnutls_x509_crt_import(crt, datum, GNUTLS_X509_FMT_DER);
> +    }
> +
> +    return rc;
> +}

This method can go away too if we declare the public interface
is exclusively PEM.


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
> +# Since: 10.1
> +##
> +{ 'enum': 'QCryptoCertFmt',
> +  'data': ['der', 'pem']}

This can go away too if we declare we only use PEM.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


