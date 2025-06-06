Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7739EC5B559
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNUMY-0006qp-RB; Fri, 06 Jun 2025 06:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNUMW-0006qM-Sa
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNUMR-0003bh-D6
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749205900;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=re6D9Mnn4uUD2o5P2eOsLIeZuhC38pkAIhr2AMi3YOU=;
 b=SZZp2oVGRXd/4sOU2lU4SuYqBnmr7UQf74F71vlJBiWigSXoYjKhadPEwJTPkuWi7o+5Xm
 DRAvx+lc6GK7epTYl01va8CBvxAG59gVDO9RM9+6pG6+9Tkv20JvetO0xkhwI44pzTkpaA
 j75B+IFm11a6HcxQqNSQOO6s5kQQpi8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-NIM_OcvzPf-y_muddnuKHA-1; Fri,
 06 Jun 2025 06:31:37 -0400
X-MC-Unique: NIM_OcvzPf-y_muddnuKHA-1
X-Mimecast-MFC-AGG-ID: NIM_OcvzPf-y_muddnuKHA_1749205895
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8A471956051; Fri,  6 Jun 2025 10:31:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4715180035E; Fri,  6 Jun 2025 10:31:30 +0000 (UTC)
Date: Fri, 6 Jun 2025 11:31:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, walling@linux.ibm.com, jjherne@linux.ibm.com,
 jrossi@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 03/28] hw/s390x/ipl: Create certificate store
Message-ID: <aELDf8--oCzcfhFI@redhat.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-4-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250604215657.528142-4-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jun 04, 2025 at 05:56:31PM -0400, Zhuoying Cai wrote:
> Create a certificate store for boot certificates used for secure IPL.
> 
> Load certificates from the boot-certificate parameter of s390-ccw-virtio
> machine type option into the cert store.
> 
> Currently, only x509 certificates in DER format and uses SHA-256 hashing
> algorithm are supported, as these are the types required for secure boot
> on s390.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  hw/s390x/cert-store.c       | 247 ++++++++++++++++++++++++++++++++++++
>  hw/s390x/cert-store.h       |  39 ++++++
>  hw/s390x/ipl.c              |   9 ++
>  hw/s390x/ipl.h              |   3 +
>  hw/s390x/meson.build        |   1 +
>  include/hw/s390x/ipl/qipl.h |   3 +
>  6 files changed, 302 insertions(+)
>  create mode 100644 hw/s390x/cert-store.c
>  create mode 100644 hw/s390x/cert-store.h
> 
> diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
> new file mode 100644
> index 0000000000..562fa22241
> --- /dev/null
> +++ b/hw/s390x/cert-store.c
> @@ -0,0 +1,247 @@
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
> +#include "hw/s390x/s390-virtio-ccw.h"
> +#include "qemu/cutils.h"
> +#include "crypto/x509-utils.h"
> +
> +static const char *s390_get_boot_certificates(void)
> +{
> +    return S390_CCW_MACHINE(qdev_get_machine())->boot_certificates;
> +}
> +
> +static size_t cert2buf(char *path, size_t max_size, char **cert_buf)
> +{
> +    size_t size;
> +
> +    /*
> +     * maximum allowed size of the certificate file to avoid consuming excessive memory
> +     * (malformed or maliciously large files)
> +     */
> +    if (!g_file_get_contents(path, cert_buf, &size, NULL) ||
> +        size == 0 || size > max_size) {

By the time this 'size > max_size' check is performed, the file
is already loaded into memory, which is fairly pointless. In
existing code loading certs we don't enforce any max size. This
data comes from the host admin who QEMU has to assume is trusted,
so the size check is not required.

> +        return 0;
> +    }
> +
> +    return size;
> +}
> +
> +static S390IPLCertificate *init_cert_x509_der(size_t size, char *raw)
> +{
> +    S390IPLCertificate *q_cert = NULL;
> +    int key_id_size;
> +    int hash_size;
> +    int is_der;
> +    int hash_type;
> +    Error *err = NULL;
> +
> +    is_der = qcrypto_check_x509_cert_fmt((uint8_t *)raw, size,
> +                                         QCRYPTO_CERT_FMT_DER, &err);
> +    /* return early if GNUTLS is not enabled */
> +    if (is_der == -ENOTSUP) {
> +        error_report("GNUTLS is not enabled");
> +        return NULL;
> +    }
> +    if (is_der != 0) {
> +        error_report("The certificate is not in DER format");
> +        return NULL;
> +    }

As mentioned in the other patch, we should exclusively accept PEM
format as the public interface. If we need DER format internllay,
gnutls_x509_cert_export can convert it into DER for us.

> +
> +    hash_type = qcrypto_get_x509_signature_algorithm((uint8_t *)raw, size, &err);
> +    if (hash_type != QCRYPTO_SIG_ALGO_RSA_SHA256) {
> +        error_report("The certificate does not use SHA-256 hashing");
> +        return NULL;
> +    }
> +
> +    key_id_size = qcrypto_get_x509_keyid_len(QCRYPTO_KEYID_FLAGS_SHA256);
> +    if (key_id_size == 0) {
> +        error_report("Failed to get certificate key ID size");
> +        return NULL;
> +    }
> +
> +    hash_size = qcrypto_get_x509_hash_len(QCRYPTO_HASH_ALGO_SHA256);
> +    if (hash_size == 0) {
> +        error_report("Failed to get certificate hash size");
> +        return NULL;
> +    }

Pointless method call when we have a QCRYPTO_HASH_DIGEST_LEN_SHA256
constant.

> +
> +    q_cert = g_new(S390IPLCertificate, 1);

g_new0 to guarantee zero initialization of all fields.

> +    q_cert->size = size;
> +    q_cert->key_id_size = key_id_size;
> +    q_cert->hash_size = hash_size;
> +    q_cert->raw = raw;
> +    q_cert->format = QCRYPTO_CERT_FMT_DER;
> +    q_cert->hash_type = QCRYPTO_SIG_ALGO_RSA_SHA256;
> +
> +    return q_cert;
> +}
> +
> +static int check_path_type(const char *path)
> +{
> +    struct stat path_stat;
> +
> +    if (stat(path, &path_stat) != 0) {
> +        perror("stat");
> +        return -1;
> +    }
> +
> +    if (S_ISDIR(path_stat.st_mode)) {
> +        return S_IFDIR;
> +    } else if (S_ISREG(path_stat.st_mode)) {
> +        return S_IFREG;
> +    } else {
> +        return -1;
> +    }
> +}

This helper isn't making the code any simpler - use the
stat() & S_ISXXX checks inline where needed.

> +static S390IPLCertificate *init_cert(char *paths)

s/paths/path/ as this is a single file being used.

> +{
> +    char *buf;
> +    char vc_name[VC_NAME_LEN_BYTES];
> +    g_autofree gchar *filename;

All g_autofree variables *must* be initialized at time
of declaration. 

> +    size_t size;
> +    S390IPLCertificate *qcert = NULL;
> +
> +    filename = g_path_get_basename(paths);
> +
> +    size = cert2buf(paths, CERT_MAX_SIZE, &buf);
> +    if (size == 0) {
> +        error_report("Failed to load certificate: %s", paths);
> +        g_free(buf);
> +        return NULL;
> +    }
> +
> +    qcert = init_cert_x509_der(size, buf);
> +    if (qcert == NULL) {
> +        error_report("Failed to initialize certificate: %s", paths);
> +        g_free(buf);
> +        return NULL;
> +    }
> +
> +    /*
> +     * Left justified certificate name with padding on the right with blanks.
> +     * Convert certificate name to EBCDIC.
> +     */
> +    strpadcpy(vc_name, VC_NAME_LEN_BYTES, filename, ' ');

What purpose does the 'vc_name' serve ? Are there expectations
on the user for naming of the cert fiels ?

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
> +    cert_buf_size = ROUND_UP(qcert->size, 4);
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
> +    const char *path;
> +    gchar **paths;

g_auto(GStrv) paths = NULL;

to automatically free this

> +    gchar **paths_copy;

and use this as the working variable

> +    int path_type;
> +    GDir *dir = NULL;
> +    gchar *cert_path;
> +    const gchar *filename;
> +    GPtrArray *cert_path_builder;
> +
> +    cert_path_builder = g_ptr_array_new();

g_autoptr(GPtrArray) cert_path_builder = g_ptr_array_new_fill(0, g_free)

so that this get freed automatically in error paths, along
with any paths stored within it.

> +
> +    path = s390_get_boot_certificates();
> +    if (path == NULL) {
> +        return cert_path_builder;
> +    }

Calling this variable 'path' is misleading given it is
a list of paths.

> +
> +    paths = g_strsplit(path, ":", -1);
> +    /* save the original pointer for freeing later */
> +    paths_copy = paths;
> +    while (*paths) {
> +        /* skip empty certificate path */
> +        if (!strcmp(*paths, "")) {

IMHO this should be reported as a fatal user configuration
error.

> +            paths += 1;
> +            continue;
> +        }
> +
> +        cert_path = NULL;
> +        path_type = check_path_type(*paths);

Just call stat() directly here, and report a fatal error
if returns non-zero instead of ignoring the error

> +        if (path_type == S_IFREG) {
> +            cert_path = g_strdup(*paths);
> +            g_ptr_array_add(cert_path_builder, cert_path);

Drop the intermediate cert_path variable as it
serves no purpose

> +        } else if (path_type == S_IFDIR) {
> +            dir = g_dir_open(*paths, 0, NULL);

Pass an "GError" object not NULL and treat failure as
fatal.

> +
> +            if (dir) {
> +                while ((filename = g_dir_read_name(dir))) {
> +                    cert_path = g_build_filename(*paths, filename, NULL);
> +                    g_ptr_array_add(cert_path_builder, (gpointer) cert_path);
> +                }

The (gpointer) cast serves no purpose.

> +
> +                g_dir_close(dir);
> +            }
> +        }


> +
> +        paths += 1;
> +    }
> +
> +    g_strfreev(paths_copy);

Redundant when using g_auto

> +    return cert_path_builder;

return g_steal_pointer(&cert_path_builder)


> +}
> +
> +void s390_ipl_create_cert_store(S390IPLCertificateStore *cert_store)
> +{
> +    GPtrArray *cert_path_builder;
> +
> +    cert_path_builder = get_cert_paths();
> +    if (cert_path_builder->len == 0) {
> +        g_ptr_array_free(cert_path_builder, true);

s/true/TRUE/ - GLib does not accept stdbool constants

> +        return;
> +    }
> +
> +    cert_store->max_cert_size = 0;
> +    cert_store->total_bytes = 0;
> +
> +    for (int i = 0; i < cert_path_builder->len; i++) {
> +        if (i > MAX_CERTIFICATES - 1) {
> +            printf("Warning: Maximum %d certificates are allowed,"
> +                            " ignoring certificate #%d and beyond\n",
> +                            MAX_CERTIFICATES, i + 1);

Is this limit mandated by some s390x hardware design spec ?

If so, this should be a fatal error, not a warning.

If not, then it would be better to accept all the user
provided certs, no matter how many.

> +            break;
> +        }



> +
> +        S390IPLCertificate *qcert = init_cert((char *) cert_path_builder->pdata[i]);
> +        if (qcert) {
> +            update_cert_store(cert_store, qcert);
> +        }
> +    }
> +
> +    g_ptr_array_free(cert_path_builder, true);
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


