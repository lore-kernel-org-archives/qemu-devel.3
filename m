Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1190CC369A9
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 13:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3E26-0006jf-Dy; Fri, 11 Apr 2025 09:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u3E1x-0006jB-FT
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:02:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u3E1u-00059i-KJ
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744376562;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=B9NdX6+ONySdnNXGQ+D9VGWYoohhcqGIVKniHuMiaZ4=;
 b=f8ap2jVdcXDF3kx+Jy8qaA/H25IYl+mxICwL3QsqIYKC8qatDcaOvQsT1q7AYmTSnmYDfl
 tpj+F+dPuy2Gl7QJR3u/WwJl0KqVM160Hl5vAu2jHqOD6ldMu7ZPcAuEwpWNqGrAktnBJA
 zANGEYMc2r+mflQ5qMV3nmxBUIJM87g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-kIvCscy9PzG9KfISUusmrQ-1; Fri,
 11 Apr 2025 09:02:38 -0400
X-MC-Unique: kIvCscy9PzG9KfISUusmrQ-1
X-Mimecast-MFC-AGG-ID: kIvCscy9PzG9KfISUusmrQ_1744376553
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 814471955BC1; Fri, 11 Apr 2025 13:02:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87662180B493; Fri, 11 Apr 2025 13:02:28 +0000 (UTC)
Date: Fri, 11 Apr 2025 14:02:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, walling@linux.ibm.com, jjherne@linux.ibm.com,
 jrossi@linux.ibm.com, fiuczy@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v1 02/24] hw/s390x/ipl: Create certificate store
Message-ID: <Z_kS4SCJlkwvhHPk@redhat.com>
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-3-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250408155527.123341-3-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 08, 2025 at 11:55:04AM -0400, Zhuoying Cai wrote:
> Create a certificate store for boot certificates used for secure IPL.
> 
> Load certificates from the -boot-certificate option into the cert store.
> 
> Currently, only x509 certificates in DER format and uses SHA-256 hashing
> algorithm are supported, as these are the types required for secure boot
> on s390.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  hw/s390x/cert-store.c       | 249 ++++++++++++++++++++++++++++++++++++
>  hw/s390x/cert-store.h       |  50 ++++++++
>  hw/s390x/ipl.c              |   9 ++
>  hw/s390x/ipl.h              |   3 +
>  hw/s390x/meson.build        |   1 +
>  include/hw/s390x/ipl/qipl.h |   3 +
>  6 files changed, 315 insertions(+)
>  create mode 100644 hw/s390x/cert-store.c
>  create mode 100644 hw/s390x/cert-store.h
> 
> diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
> new file mode 100644
> index 0000000000..1aa8aea040
> --- /dev/null
> +++ b/hw/s390x/cert-store.c
> @@ -0,0 +1,249 @@
> +/*
> + * S390 certificate store implementation
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cert-store.h"
> +#include "qemu/error-report.h"
> +#include "qemu/option.h"
> +#include "qemu/config-file.h"
> +#include "hw/s390x/ebcdic.h"
> +#include "qemu/cutils.h"
> +#include "cert-store.h"
> +
> +#ifdef CONFIG_GNUTLS
> +#include <gnutls/x509.h>
> +#include <gnutls/gnutls.h>
> +#endif /* #define CONFIG_GNUTLS */

It is bad practice to directly use GNUTLS in any QEMU code except
for under the 'crypto/' directory (and its test suites). We must
define internal APIs for accessing the info we need and then call
those instead of gnutls.


> +
> +static const char *s390_get_boot_certificates(void)
> +{
> +    QemuOpts *opts;
> +    const char *path;
> +
> +    opts = qemu_find_opts_singleton("boot-certificates");
> +    path = qemu_opt_get(opts, "boot-certificates");
> +
> +    return path;
> +}
> +
> +static size_t cert2buf(char *path, size_t max_size, char **cert_buf)
> +{
> +    size_t size;
> +    g_autofree char *buf;
> +    buf = g_malloc(max_size);
> +
> +    if (!g_file_get_contents(path, &buf, &size, NULL) ||
> +        size == 0 || size > max_size) {
> +        return 0;
> +    }
> +
> +    *cert_buf = g_steal_pointer(&buf);
> +
> +    return size;
> +}
> +
> +#ifdef CONFIG_GNUTLS
> +int g_init_cert(uint8_t *raw_cert, size_t cert_size, gnutls_x509_crt_t *g_cert)
> +{
> +    int rc;
> +
> +    if (gnutls_x509_crt_init(g_cert) < 0) {
> +        return -1;
> +    }
> +
> +    gnutls_datum_t datum_cert = {raw_cert, cert_size};
> +    rc = gnutls_x509_crt_import(*g_cert, &datum_cert, GNUTLS_X509_FMT_DER);
> +    if (rc) {
> +        gnutls_x509_crt_deinit(*g_cert);
> +        return rc;
> +    }
> +
> +    return 0;
> +}
> +#endif /* CONFIG_GNUTLS */
> +
> +static int init_cert_x509_der(size_t size, char *raw, S390IPLCertificate **qcert)
> +{
> +#ifdef CONFIG_GNUTLS
> +    gnutls_x509_crt_t g_cert = NULL;
> +    g_autofree S390IPLCertificate *q_cert;
> +    size_t key_id_size;
> +    size_t hash_size;
> +    int rc;
> +
> +    rc = g_init_cert((uint8_t *)raw, size, &g_cert);
> +    if (rc) {
> +        if (rc == GNUTLS_E_ASN1_TAG_ERROR) {
> +            error_report("The certificate is not in DER format");
> +        }
> +        return -1;
> +    }
> +
> +    rc = gnutls_x509_crt_get_key_id(g_cert, GNUTLS_KEYID_USE_SHA256, NULL, &key_id_size);
> +    if (rc != GNUTLS_E_SHORT_MEMORY_BUFFER) {
> +        error_report("Failed to get certificate key ID size");
> +        goto out;
> +    }
> +
> +    rc = gnutls_x509_crt_get_fingerprint(g_cert, GNUTLS_DIG_SHA256, NULL, &hash_size);
> +    if (rc != GNUTLS_E_SHORT_MEMORY_BUFFER) {
> +        error_report("Failed to get certificate hash size");
> +        goto out;
> +    }


We already have qcrypto_get_x509_cert_fingerprint() to avoid direct use
of gnutls. That API could be extended to optionally also report the
key id.

> +
> +    q_cert = g_malloc(sizeof(*q_cert));
> +    q_cert->size = size;
> +    q_cert->key_id_size = key_id_size;
> +    q_cert->hash_size = hash_size;
> +    q_cert->raw = raw;
> +    q_cert->format = GNUTLS_X509_FMT_DER;
> +    *qcert = g_steal_pointer(&q_cert);
> +
> +    gnutls_x509_crt_deinit(g_cert);
> +

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


