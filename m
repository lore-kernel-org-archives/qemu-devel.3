Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A641BC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNUfp-0006Ix-FM; Fri, 06 Jun 2025 06:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNUfn-0006ID-Cf
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNUfk-0006XV-32
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749207098;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=KOXqP7xVWEytsXXfjthInU/Byy8Z6ef70pONMJr3IOI=;
 b=Sa4zpNDJf3Njo5xrqVA6OHuvBkNTApQSo2Nx5LMMjMpVEcRQ5/DMffx3H5c16f8g9X9/w3
 SRlpsPOfNwCsO6vvwfDrAougJePEXRMXtQ5xosJMsmaLNaWG44i9PBc3YG/Uz9uuAjdH9m
 JnomNBKFcDKnBjWhznIv8izBvLxGHhg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-U8O-iHBYNrK1hsBrjfjMEg-1; Fri,
 06 Jun 2025 06:51:35 -0400
X-MC-Unique: U8O-iHBYNrK1hsBrjfjMEg-1
X-Mimecast-MFC-AGG-ID: U8O-iHBYNrK1hsBrjfjMEg_1749207093
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA6F019560B1; Fri,  6 Jun 2025 10:51:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D810118002B9; Fri,  6 Jun 2025 10:51:28 +0000 (UTC)
Date: Fri, 6 Jun 2025 11:51:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, walling@linux.ibm.com, jjherne@linux.ibm.com,
 jrossi@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 09/28] s390x/diag: Implement DIAG 320 subcode 2
Message-ID: <aELILYtDSoJ--0AP@redhat.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-10-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250604215657.528142-10-zycai@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Wed, Jun 04, 2025 at 05:56:37PM -0400, Zhuoying Cai wrote:
> DIAG 320 subcode 2 provides verification-certificates (VCs) that are in the
> certificate store. Only X509 certificates in DER format and SHA-256 hash
> type are recognized.
> 
> The subcode value is denoted by setting the second-left-most bit
> of an 8-byte field.
> 
> The Verification Certificate Block (VCB) contains the output data
> when the operation completes successfully. It includes a common
> header followed by zero or more Verification Certificate Entries (VCEs),
> depending on the VCB input length and the VC range (from the first VC
> index to the last VC index) in the certificate store.
> 
> Each VCE contains information about a certificate retrieved from
> the S390IPLCertificateStore, such as the certificate name, key type,
> key ID length, hash length, and the raw certificate data.
> The key ID and hash are extracted from the raw certificate by the crypto API.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  include/hw/s390x/ipl/diag320.h |  47 ++++++
>  target/s390x/diag.c            | 262 ++++++++++++++++++++++++++++++++-
>  2 files changed, 308 insertions(+), 1 deletion(-)
> 

> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 1f7d0cb2f6..c8518dc5be 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -17,6 +17,7 @@
>  #include "s390x-internal.h"
>  #include "hw/watchdog/wdt_diag288.h"
>  #include "system/cpus.h"
> +#include "hw/s390x/cert-store.h"
>  #include "hw/s390x/ipl.h"
>  #include "hw/s390x/ipl/diag320.h"
>  #include "hw/s390x/s390-virtio-ccw.h"
> @@ -24,6 +25,7 @@
>  #include "kvm/kvm_s390x.h"
>  #include "target/s390x/kvm/pv.h"
>  #include "qemu/error-report.h"
> +#include "crypto/x509-utils.h"
>  
>  
>  int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
> @@ -191,8 +193,260 @@ out:
>      }
>  }
>  
> +static int diag_320_is_cert_valid(S390IPLCertificate qcert, Error **errp)
> +{
> +    int version;
> +    int rc;
> +
> +    version = qcrypto_get_x509_cert_version((uint8_t *)qcert.raw, qcert.size, errp);

Why not change 'qcert.raw' to be 'uint8_t *' to begin with if
all the APIs it is used with expect that ?

> +    if (version < 0) {
> +        return version == -ENOTSUP ? -ENOTSUP : -1;
> +    }

This method shouldn't be returning errnos, only '-1'

> +
> +    rc = qcrypto_check_x509_cert_times((uint8_t *)qcert.raw, qcert.size, errp);
> +    if (rc) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int diag_320_get_cert_info(VCEntry *vce, S390IPLCertificate qcert, int *is_valid,
> +                                  unsigned char **key_id_data, void **hash_data)
> +{
> +    int algo;
> +    int rc;
> +    Error *err = NULL;
> +
> +    /* VCE flag (validity) */
> +    *is_valid = diag_320_is_cert_valid(qcert, &err);
> +    /* return early if GNUTLS is not enabled */
> +    if (*is_valid == -ENOTSUP) {
> +        error_report("GNUTLS is not supported");
> +        return -1;
> +    }
> +    /* reset err for the next caller to avoid assert failure */
> +    err = NULL;

This leaks memory. There is also no reason why this should
treat missing GNUTLS as different from any other errors.
All fatal errors must be turned into failures of this
method.

> +
> +    /* key-type */
> +    algo = qcrypto_get_x509_pk_algorithm((uint8_t *)qcert.raw, qcert.size, &err);
> +    if (algo == QCRYPTO_PK_ALGO_RSA) {
> +        vce->key_type = DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;
> +    }
> +    err = NULL;

Again leaking memory and failing at error propagation.

> +
> +    /* VC format */
> +    if (qcert.format == QCRYPTO_CERT_FMT_DER) {
> +        vce->format = DIAG_320_VCE_FORMAT_X509_DER;
> +    }
> +
> +    /* key id and key id len */
> +    *key_id_data = g_malloc0(qcert.key_id_size);

This can be removed if qcrypto_get_x509_cert_key_id is changed
to allocate the correct size itself.

> +    rc = qcrypto_get_x509_cert_key_id((uint8_t *)qcert.raw, qcert.size,
> +                                      QCRYPTO_KEYID_FLAGS_SHA256,
> +                                      *key_id_data, &qcert.key_id_size, &err);
> +    if (rc < 0) {
> +        error_report_err(err);
> +        error_report("Fail to retrieve certificate key ID");

The second error_report() is redundant

> +        goto out;
> +    }
> +    vce->keyid_len = cpu_to_be16(qcert.key_id_size);
> +
> +    /* hash type */
> +    if (qcert.hash_type == QCRYPTO_SIG_ALGO_RSA_SHA256) {
> +        vce->hash_type = DIAG_320_VCE_HASHTYPE_SHA2_256;
> +    }
> +
> +    /* hash and hash len */
> +    *hash_data = g_malloc0(qcert.hash_size);
> +    rc = qcrypto_get_x509_cert_fingerprint((uint8_t *)qcert.raw, qcert.size,
> +                                           QCRYPTO_HASH_ALGO_SHA256,
> +                                           *hash_data, &qcert.hash_size, &err);
> +    if (rc < 0) {
> +        error_report_err(err);
> +        error_report("Fail to retrieve certificate hash");

Also redundant.

> +        goto out;
> +    }
> +    vce->hash_len = cpu_to_be16(qcert.hash_size);
> +
> +    return 0;
> +
> +out:
> +    g_free(*key_id_data);
> +    g_free(*hash_data);
> +
> +    *key_id_data = NULL;
> +    *hash_data = NULL;

g_clear_pointer(key_id_data, g_free) does free & clear in one operation

> +
> +    return -1;
> +}
> +
> +static VCEntry *build_vce(S390IPLCertificate qcert, uint32_t vce_len, int idx,
> +                          size_t keyid_buf_size, size_t hash_buf_size)
> +{
> +    VCEntry *vce = NULL;

g_autofree

> +    unsigned char *key_id_data = NULL;

g_autofree

> +    void *hash_data = NULL;

g_autofree

> +    int is_valid = -1;
> +    int rc;
> +
> +    /*
> +     * Construct VCE
> +     * Unused area following the VCE field contains zeros.
> +     */
> +    vce = g_malloc0(vce_len);
> +
> +    rc = diag_320_get_cert_info(vce, qcert, &is_valid, &key_id_data, &hash_data);
> +    if (rc) {
> +        g_free(vce);

Redundant if using g_autofree

> +        return NULL;
> +    }
> +
> +    vce->len = cpu_to_be32(vce_len);
> +    vce->cert_idx = cpu_to_be16(idx + 1);
> +    vce->cert_len = cpu_to_be32(qcert.size);
> +
> +    strncpy((char *)vce->name, (char *)qcert.vc_name, VC_NAME_LEN_BYTES);
> +
> +    /* VCE field offset is also word aligned */
> +    vce->hash_offset = cpu_to_be16(VCE_HEADER_LEN + keyid_buf_size);
> +    vce->cert_offset = cpu_to_be16(VCE_HEADER_LEN + keyid_buf_size + hash_buf_size);
> +
> +    /* Write Key ID */
> +    memcpy(vce->cert_buf, key_id_data, qcert.key_id_size);
> +    /* Write Hash key */
> +    memcpy(vce->cert_buf + keyid_buf_size, hash_data, qcert.hash_size);
> +    /* Write VCE cert data */
> +    memcpy(vce->cert_buf + keyid_buf_size + hash_buf_size, qcert.raw, qcert.size);
> +
> +    /* The certificate is valid and VCE contains the certificate */
> +    if (is_valid == 0) {
> +        vce->flags |= DIAG_320_VCE_FLAGS_VALID;
> +    }
> +
> +    g_free(key_id_data);
> +    g_free(hash_data);
> +
> +    key_id_data = NULL;
> +    hash_data = NULL;

Redundant with g_autofree

> +
> +    return vce;

Use  g_steal_pointer(&vce) with g_autofree.

> +}
> +
> +static int handle_diag320_store_vc(S390CPU *cpu, uint64_t addr, uint64_t r1, uintptr_t ra,
> +                                   S390IPLCertificateStore *qcs)
> +{
> +    VCBlock *vcb;

g_autofree VCBlock *vcb = NULL;

> +    size_t vce_offset;
> +    size_t remaining_space;
> +    size_t keyid_buf_size;
> +    size_t hash_buf_size;
> +    size_t cert_buf_size;
> +    uint32_t vce_len;
> +    uint16_t first_vc_index;
> +    uint16_t last_vc_index;
> +    uint32_t in_len;
> +
> +    vcb = g_new0(VCBlock, 1);
> +    if (s390_cpu_virt_mem_read(cpu, addr, r1, vcb, sizeof(*vcb))) {
> +        s390_cpu_virt_mem_handle_exc(cpu, ra);

Fails to free 'vcb', hence the best practice use of g_autofree

> +        return -1;
> +    }
> +
> +    in_len = be32_to_cpu(vcb->in_len);
> +    first_vc_index = be16_to_cpu(vcb->first_vc_index);
> +    last_vc_index = be16_to_cpu(vcb->last_vc_index);
> +
> +    if (in_len % TARGET_PAGE_SIZE != 0) {
> +        g_free(vcb);
> +        return DIAG_320_RC_INVAL_VCB_LEN;
> +    }
> +
> +    if (first_vc_index > last_vc_index) {
> +        g_free(vcb);
> +        return DIAG_320_RC_BAD_RANGE;
> +    }
> +
> +    if (first_vc_index == 0) {
> +        /*
> +         * Zero is a valid index for the first and last VC index.
> +         * Zero index results in the VCB header and zero certificates returned.
> +         */
> +        if (last_vc_index == 0) {
> +            goto out;
> +        }
> +
> +        /* DIAG320 certificate store remains a one origin for cert entries */
> +        vcb->first_vc_index = 1;
> +    }
> +
> +    vce_offset = VCB_HEADER_LEN;
> +    vcb->out_len = VCB_HEADER_LEN;
> +    remaining_space = in_len - VCB_HEADER_LEN;
> +
> +    for (int i = first_vc_index - 1; i < last_vc_index && i < qcs->count; i++) {
> +        VCEntry *vce;
> +        S390IPLCertificate qcert = qcs->certs[i];
> +        /*
> +         * Each VCE is word aligned.
> +         * Each variable length field within the VCE is also word aligned.
> +         */
> +        keyid_buf_size = ROUND_UP(qcert.key_id_size, 4);
> +        hash_buf_size = ROUND_UP(qcert.hash_size, 4);
> +        cert_buf_size = ROUND_UP(qcert.size, 4);
> +        vce_len = VCE_HEADER_LEN + cert_buf_size + keyid_buf_size + hash_buf_size;
> +
> +        /*
> +         * If there is no more space to store the cert,
> +         * set the remaining verification cert count and
> +         * break early.
> +         */
> +        if (remaining_space < vce_len) {
> +            vcb->remain_ct = cpu_to_be16(last_vc_index - i);
> +            break;
> +        }
> +
> +        vce = build_vce(qcert, vce_len, i, keyid_buf_size, hash_buf_size);
> +        if (vce == NULL) {
> +            continue;
> +        }
> +
> +        /* Write VCE */
> +        if (s390_cpu_virt_mem_write(cpu, addr + vce_offset, r1, vce, vce_len)) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            return -1;
> +        }
> +
> +        vce_offset += vce_len;
> +        vcb->out_len += vce_len;
> +        remaining_space -= vce_len;
> +        vcb->stored_ct++;
> +
> +        g_free(vce);
> +    }
> +
> +    vcb->out_len = cpu_to_be32(vcb->out_len);
> +    vcb->stored_ct = cpu_to_be16(vcb->stored_ct);
> +
> +out:
> +    /*
> +     * Write VCB header
> +     * All VCEs have been populated with the latest information
> +     * and write VCB header last.
> +     */
> +    if (s390_cpu_virt_mem_write(cpu, addr, r1, vcb, VCB_HEADER_LEN)) {
> +        s390_cpu_virt_mem_handle_exc(cpu, ra);

Fails to free  'vcb'

> +        return -1;
> +    }
> +
> +    g_free(vcb);
> +    return DIAG_320_RC_OK;
> +}
> +

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


