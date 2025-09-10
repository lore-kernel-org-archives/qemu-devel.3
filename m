Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAD7CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 20:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwRfC-00019h-71; Wed, 10 Sep 2025 16:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uwRf5-00013n-KZ; Wed, 10 Sep 2025 16:43:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uwRes-0004oN-JN; Wed, 10 Sep 2025 16:43:24 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ADa73a025770;
 Wed, 10 Sep 2025 20:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=XQchfq
 8x7kQGtP8IefHEkKydeCU+YmRTE/8pJopyO+I=; b=TSxAvpTwXXbgSTbkVYjPZa
 FAOOM/8WFAjQ4eeZz427EG+wJpNRkNsCLuHlUpR3280NGp6nZdwYZh0NfFPgJX4z
 eEwTsKWGfUYELx2Gw+QGenf3iVausK8A+oX7LK3f6xvd8AYRFVJ2jeRY3RHazPWZ
 /LX67vI4RkTloDJqx64bjGRnR6QfbwSkqvHkiCjwH8eVTNEBGopfwO5n2GjcxerL
 zFYnZD6wqXU0LLLqx53yx5bqhBdACU2fBO0zFVPEFjtZf9J+UKkYCPxguGlTX1Cr
 kJKI7N1/MqVXW2b2QzPFPA75LBf0u6MF/3L0/VGtqLEW8AxqX+FCOjsGSU0JGF0A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx0p7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Sep 2025 20:43:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58AHYtok010666;
 Wed, 10 Sep 2025 20:43:07 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910sn2c49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Sep 2025 20:43:07 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58AKh5L732637568
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Sep 2025 20:43:05 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B209758055;
 Wed, 10 Sep 2025 20:43:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A73A458043;
 Wed, 10 Sep 2025 20:43:04 +0000 (GMT)
Received: from [9.61.89.180] (unknown [9.61.89.180])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 10 Sep 2025 20:43:04 +0000 (GMT)
Message-ID: <a3a2b7b9-5cf0-4c59-9ae4-eded6186f4ec@linux.ibm.com>
Date: Wed, 10 Sep 2025 16:43:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/29] hw/s390x/ipl: Create certificate store
To: Collin Walling <walling@linux.ibm.com>, thuth@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-5-zycai@linux.ibm.com>
 <4ef5904d-0bdc-44c5-8411-80ff9a1ff961@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <4ef5904d-0bdc-44c5-8411-80ff9a1ff961@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ErjhTcEtu0QRO35Gx6tKsUL0FF61dk-M
X-Proofpoint-ORIG-GUID: ErjhTcEtu0QRO35Gx6tKsUL0FF61dk-M
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c1e2dc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=MDNJ75JN1vTUiMufNEAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX2+o5/cTjpnx8
 A6KX69qQWPnzZ0t48sf59dMWXfs325Iu17V8Sy5IPujFShR6yZLjujErQ1LhhuA+aFFYEqpAPNj
 bwUyyRNu2R/mBrwaxAIDtRnOwiZxXSlQiHmj/CaAykOU8Z3/tDwArDm9xUWA5QopH1vopTGWGKW
 iz7oxh2NZbNvpnqZkc2VQhQOBbcBHQlOHsZv2pPFasN6cw5Xg1rybsN3yP9+0GcIDTy5e8C9+Lw
 cMNazVNCuNWeSIZFKcsP7vyNKrM24unpzsVvLps8QgHfbTTYJ6lStz+x3xRROjLAaVwScMMVbiL
 2GJ6cyHN5NE5eKihLWb/jansOVI9wFE4neMIJ+zZDCoC1yJpYuZZGAYRts0ooh+JUOAjt3ikD3n
 lUbMMN6t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/8/25 8:54 PM, Collin Walling wrote:
> On 8/18/25 17:42, Zhuoying Cai wrote:
>> Create a certificate store for boot certificates used for secure IPL.
>>
>> Load certificates from the `boot-certs` parameter of s390-ccw-virtio
>> machine type option into the cert store.
>>
>> Currently, only X.509 certificates in PEM format are supported, as the
>> QEMU command line accepts certificates in PEM format only.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>  hw/s390x/cert-store.c       | 201 ++++++++++++++++++++++++++++++++++++
>>  hw/s390x/cert-store.h       |  38 +++++++
>>  hw/s390x/ipl.c              |   9 ++
>>  hw/s390x/ipl.h              |   3 +
>>  hw/s390x/meson.build        |   1 +
>>  include/hw/s390x/ipl/qipl.h |   2 +
>>  6 files changed, 254 insertions(+)
>>  create mode 100644 hw/s390x/cert-store.c
>>  create mode 100644 hw/s390x/cert-store.h
>>
>> diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
>> new file mode 100644
>> index 0000000000..81e748a912
>> --- /dev/null
>> +++ b/hw/s390x/cert-store.c
>> @@ -0,0 +1,201 @@
>> +/*
>> + * S390 certificate store implementation
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "cert-store.h"
>> +#include "qapi/error.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/option.h"
>> +#include "qemu/config-file.h"
>> +#include "hw/s390x/ebcdic.h"
>> +#include "hw/s390x/s390-virtio-ccw.h"
>> +#include "qemu/cutils.h"
>> +#include "crypto/x509-utils.h"
>> +#include "qapi/qapi-types-machine-s390x.h"
>> +
>> +static BootCertPathList *s390_get_boot_certs(void)
>> +{
>> +    return S390_CCW_MACHINE(qdev_get_machine())->boot_certs;
>> +}
>> +
>> +static size_t cert2buf(char *path, char **cert_buf)
>> +{
>> +    size_t size;
>> +
>> +    if (!g_file_get_contents(path, cert_buf, &size, NULL) || size == 0) {
>> +        return 0;
>> +    }
>> +
>> +    return size;
>> +}
> 
> Seems redundant to check if size == 0 here.  If g_file_get_contents
> succeeds and size is set to 0, there's no difference between returning 0
> or returning size.
> 
>> +
>> +static S390IPLCertificate *init_cert_x509(size_t size, uint8_t *raw, Error **errp)
>> +{
>> +    S390IPLCertificate *q_cert = NULL;
> 
> I think the term "q_cert" is from an older implementation when we called
> this a "QEMUCertStore".  Since we're doing this for s390 right now, I
> think it makes sense to just to call it "cert".
> 
>> +    g_autofree uint8_t *cert_der = NULL;
>> +    size_t der_len = size;
>> +    int rc;
>> +
>> +    rc = qcrypto_x509_convert_cert_der(raw, size, &cert_der, &der_len, errp);
>> +    if (rc != 0) {
>> +        return NULL;
>> +    }
>> +
>> +    q_cert = g_new0(S390IPLCertificate, 1);
>> +    q_cert->size = size;
>> +    q_cert->der_size = der_len;
>> +    q_cert->key_id_size = QCRYPTO_HASH_DIGEST_LEN_SHA256;
>> +    q_cert->hash_size = QCRYPTO_HASH_DIGEST_LEN_SHA256;
> 
> Setting the sizes here doesn't seem right:
> 1. it's making an assumption about the cert's data, and
> 2. these fields are never accessed in any subsequent patch
> 
> Patch 9 will explicitly use this enum when retrieving the cert and
> fingerprint, but this data is neither checked nor extracted from the
> S390IPLCertificate var.
> 
> I think it makes sense to get rid of the above two lines and potentially
> the two S390IPLCertificate fields as well.
> 

Thanks for the feedback! I agree that these two fields can be removed
from S390IPLCertificate.

However, the values themselves are still needed. Since both the key ID
and fingerprint (hash value) of the certificate are SHA-256 outputs
(with the fingerprint specifically requiring it), their lengths should
always be 32 bytes.

These values are also used in this patch when calculating the
certificate data length (key ID, fingerprint, and certificate), and in
patch 9 when computing the VCE length.

Given that, it might be clearer to define them as constants rather than
storing them in the struct.

>> +    q_cert->raw = raw;
>> +
>> +    return q_cert;
>> +}
>> +
>> +static S390IPLCertificate *init_cert(char *path)
>> +{
>> +    char *buf;
>> +    size_t size;
>> +    char vc_name[VC_NAME_LEN_BYTES];
>> +    g_autofree gchar *filename = NULL;
>> +    S390IPLCertificate *qcert = NULL;
>> +    Error *local_err = NULL;
>> +
>> +    filename = g_path_get_basename(path);
>> +
>> +    size = cert2buf(path, &buf);
>> +    if (size == 0) {
>> +        error_report("Failed to load certificate: %s", path);
>> +        return NULL;
>> +    }
>> +
>> +    qcert = init_cert_x509(size, (uint8_t *)buf, &local_err);
>> +    if (qcert == NULL) {
>> +        error_reportf_err(local_err, "Failed to initialize certificate: %s:  ", path);
>> +        g_free(buf);
>> +        return NULL;
>> +    }
>> +
>> +    /*
>> +     * Left justified certificate name with padding on the right with blanks.
>> +     * Convert certificate name to EBCDIC.
>> +     */
>> +    strpadcpy(vc_name, VC_NAME_LEN_BYTES, filename, ' ');
>> +    ebcdic_put(qcert->vc_name, vc_name, VC_NAME_LEN_BYTES);
>> +
>> +    return qcert;
>> +}
>> +
>> +static void update_cert_store(S390IPLCertificateStore *cert_store,
>> +                              S390IPLCertificate *qcert)
>> +{
>> +    size_t data_buf_size;
>> +    size_t keyid_buf_size;
>> +    size_t hash_buf_size;
>> +    size_t cert_buf_size;
>> +
>> +    /* length field is word aligned for later DIAG use */
>> +    keyid_buf_size = ROUND_UP(qcert->key_id_size, 4);
>> +    hash_buf_size = ROUND_UP(qcert->hash_size, 4);
>> +    cert_buf_size = ROUND_UP(qcert->der_size, 4);
>> +    data_buf_size = keyid_buf_size + hash_buf_size + cert_buf_size;
>> +
>> +    if (cert_store->max_cert_size < data_buf_size) {
>> +        cert_store->max_cert_size = data_buf_size;
>> +    }
>> +
>> +    cert_store->certs[cert_store->count] = *qcert;
>> +    cert_store->total_bytes += data_buf_size;
>> +    cert_store->count++;
>> +}
>> +
>> +static GPtrArray *get_cert_paths(void)
>> +{
>> +    BootCertPathList *path_list = NULL;
>> +    BootCertPathList *list = NULL;
>> +    gchar *cert_path;
>> +    GDir *dir = NULL;
>> +    const gchar *filename;
>> +    g_autoptr(GError) err = NULL;
>> +    g_autoptr(GPtrArray) cert_path_builder = g_ptr_array_new_full(0, g_free);
>> +
>> +    path_list = s390_get_boot_certs();
>> +    if (path_list == NULL) {
>> +        return g_steal_pointer(&cert_path_builder);
>> +    }
>> +
>> +    for (list = path_list; list; list = list->next) {
>> +        cert_path = list->value->path;
>> +
>> +        if (g_strcmp0(cert_path, "") == 0) {
>> +            error_report("Empty path in certificate path list is not allowed");
>> +            exit(1);
>> +        }
>> +
>> +        struct stat st;
>> +        if (stat(cert_path, &st) != 0) {
>> +            error_report("Failed to stat path '%s': %s", cert_path, g_strerror(errno));
>> +            exit(1);
>> +        }
>> +
>> +        if (S_ISREG(st.st_mode)) {
>> +            if (g_str_has_suffix(cert_path, ".pem")) {
>> +                g_ptr_array_add(cert_path_builder, g_strdup(cert_path));
>> +            }
>> +        } else if (S_ISDIR(st.st_mode)) {
>> +            dir = g_dir_open(cert_path, 0, &err);
>> +            if (dir == NULL) {
>> +                error_report("Failed to open directory '%s': %s",
>> +                             cert_path, err->message);
>> +                exit(1);
>> +            }
>> +
>> +            while ((filename = g_dir_read_name(dir))) {
>> +                if (g_str_has_suffix(filename, ".pem")) {
>> +                    g_ptr_array_add(cert_path_builder,
>> +                                    g_build_filename(cert_path, filename, NULL));
>> +                }
>> +            }
>> +
>> +            g_dir_close(dir);
>> +        } else {
>> +            error_report("Path '%s' is neither a file nor a directory", cert_path);
>> +        }
>> +    }
>> +
>> +    qapi_free_BootCertPathList(path_list);
>> +    return g_steal_pointer(&cert_path_builder);
>> +}
>> +
>> +void s390_ipl_create_cert_store(S390IPLCertificateStore *cert_store)
>> +{
>> +    GPtrArray *cert_path_builder;
>> +
>> +    cert_path_builder = get_cert_paths();
>> +    if (cert_path_builder->len == 0) {
>> +        g_ptr_array_free(cert_path_builder, TRUE);
>> +        return;
>> +    }
>> +
>> +    cert_store->max_cert_size = 0;
>> +    cert_store->total_bytes = 0;
>> +
>> +    for (int i = 0; i < cert_path_builder->len; i++) {
>> +        if (i > MAX_CERTIFICATES - 1) {
>> +            error_report("Maximum %d certificates are allowed", MAX_CERTIFICATES);
> 
> nit: reword to "Cert store exceeds maximum of %d certificates"
> 
>> +            exit(1);
>> +        }
>> +
>> +        S390IPLCertificate *qcert = init_cert((char *) cert_path_builder->pdata[i]);
>> +        if (qcert) {
>> +            update_cert_store(cert_store, qcert);
>> +        }
>> +    }
>> +
>> +    g_ptr_array_free(cert_path_builder, TRUE);
>> +}
>> diff --git a/hw/s390x/cert-store.h b/hw/s390x/cert-store.h
>> new file mode 100644
>> index 0000000000..f030c8846c
>> --- /dev/null
>> +++ b/hw/s390x/cert-store.h
>> @@ -0,0 +1,38 @@
>> +/*
>> + * S390 certificate store
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_S390_CERT_STORE_H
>> +#define HW_S390_CERT_STORE_H
>> +
>> +#include "hw/s390x/ipl/qipl.h"
>> +#include "crypto/x509-utils.h"
>> +
>> +#define VC_NAME_LEN_BYTES  64
>> +
>> +struct S390IPLCertificate {
>> +    uint8_t vc_name[VC_NAME_LEN_BYTES];
>> +    size_t  size;
>> +    size_t  der_size;
>> +    size_t  key_id_size;
>> +    size_t  hash_size;
> 
> From above: I don't think these two fields are needed?
> 
>> +    uint8_t *raw;
>> +};
>> +typedef struct S390IPLCertificate S390IPLCertificate;
>> +
>> +struct S390IPLCertificateStore {
>> +    uint16_t count;
>> +    size_t   max_cert_size;
>> +    size_t   total_bytes;
>> +    S390IPLCertificate certs[MAX_CERTIFICATES];
>> +} QEMU_PACKED;
>> +typedef struct S390IPLCertificateStore S390IPLCertificateStore;
>> +
>> +void s390_ipl_create_cert_store(S390IPLCertificateStore *cert_store);
>> +
>> +#endif
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 2f082396c7..186be923d7 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -35,6 +35,7 @@
>>  #include "qemu/option.h"
>>  #include "qemu/ctype.h"
>>  #include "standard-headers/linux/virtio_ids.h"
>> +#include "cert-store.h"
>>  
>>  #define KERN_IMAGE_START                0x010000UL
>>  #define LINUX_MAGIC_ADDR                0x010008UL
>> @@ -422,6 +423,13 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
>>      }
>>  }
>>  
>> +S390IPLCertificateStore *s390_ipl_get_certificate_store(void)
>> +{
>> +    S390IPLState *ipl = get_ipl_device();
>> +
>> +    return &ipl->cert_store;
>> +}
>> +
>>  static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>>  {
>>      CcwDevice *ccw_dev = NULL;
>> @@ -717,6 +725,7 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>>  
>>      if (!ipl->kernel || ipl->iplb_valid) {
>>          cpu->env.psw.addr = ipl->bios_start_addr;
>> +        s390_ipl_create_cert_store(&ipl->cert_store);
>>          if (!ipl->iplb_valid) {
>>              ipl->iplb_valid = s390_init_all_iplbs(ipl);
>>          } else {
>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>> index 8f83c7da29..bee72dfbb3 100644
>> --- a/hw/s390x/ipl.h
>> +++ b/hw/s390x/ipl.h
>> @@ -13,6 +13,7 @@
>>  #ifndef HW_S390_IPL_H
>>  #define HW_S390_IPL_H
>>  
>> +#include "cert-store.h"
>>  #include "cpu.h"
>>  #include "exec/target_page.h"
>>  #include "system/address-spaces.h"
>> @@ -35,6 +36,7 @@ int s390_ipl_pv_unpack(struct S390PVResponse *pv_resp);
>>  void s390_ipl_prepare_cpu(S390CPU *cpu);
>>  IplParameterBlock *s390_ipl_get_iplb(void);
>>  IplParameterBlock *s390_ipl_get_iplb_pv(void);
>> +S390IPLCertificateStore *s390_ipl_get_certificate_store(void);
>>  
>>  enum s390_reset {
>>      /* default is a reset not triggered by a CPU e.g. issued by QMP */
>> @@ -64,6 +66,7 @@ struct S390IPLState {
>>      IplParameterBlock iplb;
>>      IplParameterBlock iplb_pv;
>>      QemuIplParameters qipl;
>> +    S390IPLCertificateStore cert_store;
>>      uint64_t start_addr;
>>      uint64_t compat_start_addr;
>>      uint64_t bios_start_addr;
>> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
>> index 8866012ddc..80d3d4a74d 100644
>> --- a/hw/s390x/meson.build
>> +++ b/hw/s390x/meson.build
>> @@ -17,6 +17,7 @@ s390x_ss.add(files(
>>    'sclpcpu.c',
>>    'sclpquiesce.c',
>>    'tod.c',
>> +  'cert-store.c',
>>  ))
>>  s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
>>    'tod-kvm.c',
>> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
>> index 6824391111..e505f44020 100644
>> --- a/include/hw/s390x/ipl/qipl.h
>> +++ b/include/hw/s390x/ipl/qipl.h
>> @@ -20,6 +20,8 @@
>>  #define LOADPARM_LEN    8
>>  #define NO_LOADPARM "\0\0\0\0\0\0\0\0"
>>  
>> +#define MAX_CERTIFICATES  64
>> +
>>  /*
>>   * The QEMU IPL Parameters will be stored at absolute address
>>   * 204 (0xcc) which means it is 32-bit word aligned but not
> 
> 


