Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD14C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 17:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueGM1-0006Ij-C3; Tue, 22 Jul 2025 13:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ueFdn-0002Ch-E0
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 12:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ueFdl-0002Q4-6J
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 12:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753200892;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=eFEhvzC3Syk9+XtdM7PZbtV5xUKMj3OCaW2rq9AnyXA=;
 b=U/PjSprKvbsZu1rlwQR6oMcVlusnnU5C6yJBQzd/AKzwaSCA9urk8fZwNhPfWjHRKy2qnE
 qNkN59CDshV7ZGWbQUfahRw/VlmmLEXnfpOb9eSi2tXyqK1McUYZ/LGPxOa0rPAQVA0Nvg
 ZyhSVcOzVTnyLeWmA/acVHyZnpu4Las=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-3BN_Q3wjOg6MKQ2ZK-7agg-1; Tue,
 22 Jul 2025 12:14:47 -0400
X-MC-Unique: 3BN_Q3wjOg6MKQ2ZK-7agg-1
X-Mimecast-MFC-AGG-ID: 3BN_Q3wjOg6MKQ2ZK-7agg_1753200885
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 179BC19560AA; Tue, 22 Jul 2025 16:14:45 +0000 (UTC)
Received: from redhat.com (dhcp-16-135.lcy.redhat.com [10.42.16.135])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 924EE19560A3; Tue, 22 Jul 2025 16:14:40 +0000 (UTC)
Date: Tue, 22 Jul 2025 17:14:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
Subject: Re: [PATCH v4 03/28] hw/s390x/ipl: Create certificate store
Message-ID: <aH-47dFEBZBp1Boi@redhat.com>
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-4-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250711211105.439554-4-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
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

On Fri, Jul 11, 2025 at 05:10:39PM -0400, Zhuoying Cai wrote:
> Create a certificate store for boot certificates used for secure IPL.
> 
> Load certificates from the boot-certificate parameter of s390-ccw-virtio
> machine type option into the cert store.
> 
> Currently, only X.509 certificates in PEM format are supported, as the
> QEMU command line accepts certificates in PEM format only. Additionally,
> only the SHA-256 hashing algorithm is supported, as it is required for
> secure boot on s390.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  hw/s390x/cert-store.c       | 223 ++++++++++++++++++++++++++++++++++++
>  hw/s390x/cert-store.h       |  39 +++++++
>  hw/s390x/ipl.c              |   9 ++
>  hw/s390x/ipl.h              |   3 +
>  hw/s390x/meson.build        |   1 +
>  include/hw/s390x/ipl/qipl.h |   2 +
>  6 files changed, 277 insertions(+)
>  create mode 100644 hw/s390x/cert-store.c
>  create mode 100644 hw/s390x/cert-store.h
> 
> diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
> new file mode 100644
> index 0000000000..3b4faa3738
> --- /dev/null
> +++ b/hw/s390x/cert-store.c
> @@ -0,0 +1,223 @@
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
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/option.h"
> +#include "qemu/config-file.h"
> +#include "hw/s390x/ebcdic.h"
> +#include "hw/s390x/s390-virtio-ccw.h"
> +#include "qemu/cutils.h"
> +#include "crypto/x509-utils.h"
> +
> +static const char *s390_get_boot_certificates(void)
> +{
> +    return S390_CCW_MACHINE(qdev_get_machine())->boot_certificates;
> +}
> +
> +static size_t cert2buf(char *path, char **cert_buf)
> +{
> +    size_t size;
> +
> +    if (!g_file_get_contents(path, cert_buf, &size, NULL) || size == 0) {
> +        return 0;
> +    }
> +
> +    return size;
> +}
> +
> +static S390IPLCertificate *init_cert_x509(size_t size, uint8_t *raw)

Add 'Error **errp' to this method, and don't use error_report


> +{
> +    S390IPLCertificate *q_cert = NULL;
> +    int key_id_size;
> +    int hash_size;
> +    int hash_type;
> +    Error *err = NULL;
> +
> +    g_autofree uint8_t *cert_der = NULL;
> +    size_t der_len = size;
> +    int rc;
> +
> +    hash_type = qcrypto_x509_get_signature_algorithm(raw, size, &err);

Pass in errp

> +    if (hash_type == -1) {

> +        error_report_err(err);

drop this

> +        return NULL;
> +    }
> +    if (hash_type != QCRYPTO_SIG_ALGO_RSA_SHA256) {
> +        error_report_err(err);

'err' is not set, in this branch, so you must use

  error_setg(errp, "Only SHA256 hash type is suppoorted, not %s",
             QCryptoHashAlgo_str(hash_type));
 
> +        return NULL;
> +    }
> +
> +    key_id_size = qcrypto_x509_get_keyid_len(QCRYPTO_KEYID_FLAGS_SHA256, &err);

Pass in errp

> +    if (key_id_size == -1) {
> +        error_report_err(err);

Drop this

> +        return NULL;
> +    }

this can just be  'key_id_size = QCRYPTO_HASH_DIGEST_LEN_SHA256'

> +
> +    hash_size = QCRYPTO_HASH_DIGEST_LEN_SHA256;
> +
> +    rc = qcrypto_x509_convert_cert_der(raw, size, &cert_der, &der_len, &err);
> +    if (rc != 0) {
> +        error_report_err(err);
> +        return NULL;
> +    }
> +
> +    q_cert = g_new0(S390IPLCertificate, 1);
> +    q_cert->size = size;
> +    q_cert->der_size = der_len;
> +    q_cert->key_id_size = key_id_size;
> +    q_cert->hash_size = hash_size;
> +    q_cert->raw = raw;
> +    q_cert->hash_type = QCRYPTO_SIG_ALGO_RSA_SHA256;
> +
> +    return q_cert;
> +}

> +
> +static S390IPLCertificate *init_cert(char *path)
> +{
> +    char *buf;
> +    size_t size;
> +    char vc_name[VC_NAME_LEN_BYTES];
> +    g_autofree gchar *filename = NULL;
> +    S390IPLCertificate *qcert = NULL;

 Error *local_err = NULL;

> +
> +    filename = g_path_get_basename(path);
> +
> +    size = cert2buf(path, &buf);
> +    if (size == 0) {
> +        error_report("Failed to load certificate: %s", path);
> +        g_free(buf);
> +        return NULL;
> +    }
> +
> +    qcert = init_cert_x509(size, (uint8_t *)buf);

Pass in &local_err

> +    if (qcert == NULL) {
> +        error_report("Failed to initialize certificate: %s", path);

Use:

   error_reportf_err(local_err, "Failed to initialize certificate: %s", path);

> +        g_free(buf);
> +        return NULL;
> +    }
> +
> +    /*
> +     * Left justified certificate name with padding on the right with blanks.
> +     * Convert certificate name to EBCDIC.
> +     */
> +    strpadcpy(vc_name, VC_NAME_LEN_BYTES, filename, ' ');
> +    ebcdic_put(qcert->vc_name, vc_name, VC_NAME_LEN_BYTES);
> +
> +    return qcert;
> +}


> +
> +static void update_cert_store(S390IPLCertificateStore *cert_store,
> +                              S390IPLCertificate *qcert)
> +{
> +    size_t data_buf_size;
> +    size_t keyid_buf_size;
> +    size_t hash_buf_size;
> +    size_t cert_buf_size;
> +
> +    /* length field is word aligned for later DIAG use */
> +    keyid_buf_size = ROUND_UP(qcert->key_id_size, 4);
> +    hash_buf_size = ROUND_UP(qcert->hash_size, 4);
> +    cert_buf_size = ROUND_UP(qcert->der_size, 4);
> +    data_buf_size = keyid_buf_size + hash_buf_size + cert_buf_size;
> +
> +    if (cert_store->max_cert_size < data_buf_size) {
> +        cert_store->max_cert_size = data_buf_size;
> +    }
> +
> +    cert_store->certs[cert_store->count] = *qcert;
> +    cert_store->total_bytes += data_buf_size;
> +    cert_store->count++;
> +}
> +
> +static GPtrArray *get_cert_paths(void)
> +{
> +    const char *paths_list;
> +    g_auto(GStrv) paths = NULL;
> +    gchar **paths_copy;
> +    GDir *dir = NULL;
> +    const gchar *filename;
> +    g_autoptr(GError) err = NULL;
> +    g_autoptr(GPtrArray) cert_path_builder = g_ptr_array_new_full(0, g_free);
> +
> +    paths_list = s390_get_boot_certificates();
> +    if (paths_list == NULL) {
> +        return g_steal_pointer(&cert_path_builder);
> +    }
> +
> +    paths = g_strsplit(paths_list, ":", -1);
> +
> +    paths_copy = paths;
> +    while (*paths_copy) {
> +        if (!strcmp(*paths_copy, "")) {
> +            error_report("Empty path in certificate path list is not allowed");
> +            exit(1);
> +        }
> +
> +        struct stat st;
> +        if (stat(*paths_copy, &st) != 0) {
> +            error_report("Failed to stat path '%s': %s", *paths_copy, g_strerror(errno));
> +            exit(1);
> +        }
> +
> +        if (S_ISREG(st.st_mode)) {
> +            g_ptr_array_add(cert_path_builder, g_strdup(*paths_copy));
> +        } else if (S_ISDIR(st.st_mode)) {
> +            dir = g_dir_open(*paths_copy, 0, &err);
> +            if (dir == NULL) {
> +                error_report("Failed to open directory '%s': %s",
> +                             *paths_copy, err->message);
> +                exit(1);
> +            }
> +
> +            while ((filename = g_dir_read_name(dir))) {
> +                g_ptr_array_add(cert_path_builder,
> +                                g_build_filename(*paths_copy, filename, NULL));
> +            }

IMHO it should only append files with an extension of ".pem" to avoid picking
up any extraneous files in that location.

> +
> +            g_dir_close(dir);
> +        } else {
> +            error_report("Path '%s' is neither a file nor a directory", *paths_copy);
> +        }
> +
> +        paths_copy += 1;
> +    }
> +
> +    return g_steal_pointer(&cert_path_builder);
> +}



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


