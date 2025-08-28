Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94124CA0FFF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFk-0002I0-G3; Thu, 28 Aug 2025 13:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1urdfM-0005lI-II; Thu, 28 Aug 2025 10:31:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1urdfE-0007tv-M9; Thu, 28 Aug 2025 10:31:51 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SB1GbH008925;
 Thu, 28 Aug 2025 14:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DAh3LM
 2V4eEpp3D836dBP7ItgB/jzr0ka0DGjmyTJO0=; b=YOYhChYpHVyd72OZNnaoUf
 89zjmluu5g6cnSHYyIajvOt+qXVTtvBwqhDOXEzgA2gdVLPBclS3PCTqfekA1m4q
 /Yfn2OYa5wfHKLoDABJhHby53mUuhTev5O4Xz6heyyC+7kBD1GM9W/KvpcP8sz82
 4yzxIJZU+tsvzgQp+oqXFxXBVI4N+szaG1MX21uD4YJtZA6jBBlgjYEvdEg3GuhU
 icA6sFXDgplAB8PyS9pUOILNnjqSTHz3tO9kQp1Nuf4y6NrZmaAHmf6ww2grDR8V
 fdnaKFds9iK1XYxE7yXVB0LQZK1WcgsMUnhoD3xI0GoybaTHNnejYjfG5Z0ayrXQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48tnv11313-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 14:31:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57SDiY0Y002512;
 Thu, 28 Aug 2025 14:31:36 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qrypwcef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 14:31:36 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57SEVYLS33555132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Aug 2025 14:31:35 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB9B55805B;
 Thu, 28 Aug 2025 14:31:34 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EAD658055;
 Thu, 28 Aug 2025 14:31:33 +0000 (GMT)
Received: from [9.61.75.179] (unknown [9.61.75.179])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 28 Aug 2025 14:31:32 +0000 (GMT)
Message-ID: <41aa6001-efb4-4cb7-822c-0606ab7673e7@linux.ibm.com>
Date: Thu, 28 Aug 2025 10:31:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zhuoying Cai <zycai@linux.ibm.com>
Subject: Re: [PATCH v5 04/29] hw/s390x/ipl: Create certificate store
To: Jared Rossi <jrossi@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-5-zycai@linux.ibm.com>
 <9d246121-b9d4-488a-b084-c9dc59868383@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <9d246121-b9d4-488a-b084-c9dc59868383@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0eA7Cp9rTYy3vZqDm50df24MR_nwh6O8
X-Authority-Analysis: v=2.4 cv=KMhaDEFo c=1 sm=1 tr=0 ts=68b06849 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=pIu4bu8Wg9eLU8ZokA8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MCBTYWx0ZWRfX2uHFu8E2Zvtj
 cP22oU2+fvrVmp6CtTyFBTUk6vbq8iKHx7ADfCpnXAxDCJtU3G6tCnqH4PAqkH9s4fIs7MHoff1
 YtHAJGKvZr5OTIMoF6kiX4ytB8nPs/nCjwUepKR3nNgSfsk7w+V/Vf94hXWyCX58tiGkR2tKX4d
 oK3ZAf9iZmYuJrv9foVcpkBEF3D6flKs0sC3Kbt/SuwDlsJ2PuN4m3mLCTd/gIerpD/9dd0I7Kk
 SOaT2EKqNjl26qKbhZFBJlomQg2VKYnYGqXlENFOaMbEDsnA4PdsvtBFGUIjsnWiwPk+Iq2yvnP
 qeAlI8ID34iEagZUkkJiy1nlKT91sM6XWHFbu2rba/8yOGwg6V8ZfQNAwXlkYns8bWAUk5RTec8
 EE7AKdIh
X-Proofpoint-GUID: 0eA7Cp9rTYy3vZqDm50df24MR_nwh6O8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508280090
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 8/26/25 9:40 AM, Jared Rossi wrote:
> 
> 
> On 8/18/25 5:42 PM, Zhuoying Cai wrote:
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
>>   hw/s390x/cert-store.c       | 201 ++++++++++++++++++++++++++++++++++++
>>   hw/s390x/cert-store.h       |  38 +++++++
>>   hw/s390x/ipl.c              |   9 ++
>>   hw/s390x/ipl.h              |   3 +
>>   hw/s390x/meson.build        |   1 +
>>   include/hw/s390x/ipl/qipl.h |   2 +
>>   6 files changed, 254 insertions(+)
>>   create mode 100644 hw/s390x/cert-store.c
>>   create mode 100644 hw/s390x/cert-store.h
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
>> +
>> +static S390IPLCertificate *init_cert_x509(size_t size, uint8_t *raw, Error **errp)
>> +{
>> +    S390IPLCertificate *q_cert = NULL;
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
> Missing free?
> 

Since the ownership of the buf pointer is transferred to qcert after
init_cert_x509() completes successfully, free() is not necessary here.

I'll add comments here to make things clearer.

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
> This looks like it should return an error?
> 
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
>> +            exit(1);
>> +        }
> Why not do this check before the loop, using cert_path_builder->len 
> directly?
> 
> Also, I think there is a missing free in this error case?
> 

Thanks for the feedback. I'll address them in the next version.

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
>>   #include "qemu/option.h"
>>   #include "qemu/ctype.h"
>>   #include "standard-headers/linux/virtio_ids.h"
>> +#include "cert-store.h"
>>   
>>   #define KERN_IMAGE_START                0x010000UL
>>   #define LINUX_MAGIC_ADDR                0x010008UL
>> @@ -422,6 +423,13 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
>>       }
>>   }
>>   
>> +S390IPLCertificateStore *s390_ipl_get_certificate_store(void)
>> +{
>> +    S390IPLState *ipl = get_ipl_device();
>> +
>> +    return &ipl->cert_store;
>> +}
>> +
>>   static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>>   {
>>       CcwDevice *ccw_dev = NULL;
>> @@ -717,6 +725,7 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>>   
>>       if (!ipl->kernel || ipl->iplb_valid) {
>>           cpu->env.psw.addr = ipl->bios_start_addr;
>> +        s390_ipl_create_cert_store(&ipl->cert_store);
>>           if (!ipl->iplb_valid) {
>>               ipl->iplb_valid = s390_init_all_iplbs(ipl);
>>           } else {
>> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
>> index 8f83c7da29..bee72dfbb3 100644
>> --- a/hw/s390x/ipl.h
>> +++ b/hw/s390x/ipl.h
>> @@ -13,6 +13,7 @@
>>   #ifndef HW_S390_IPL_H
>>   #define HW_S390_IPL_H
>>   
>> +#include "cert-store.h"
>>   #include "cpu.h"
>>   #include "exec/target_page.h"
>>   #include "system/address-spaces.h"
>> @@ -35,6 +36,7 @@ int s390_ipl_pv_unpack(struct S390PVResponse *pv_resp);
>>   void s390_ipl_prepare_cpu(S390CPU *cpu);
>>   IplParameterBlock *s390_ipl_get_iplb(void);
>>   IplParameterBlock *s390_ipl_get_iplb_pv(void);
>> +S390IPLCertificateStore *s390_ipl_get_certificate_store(void);
>>   
>>   enum s390_reset {
>>       /* default is a reset not triggered by a CPU e.g. issued by QMP */
>> @@ -64,6 +66,7 @@ struct S390IPLState {
>>       IplParameterBlock iplb;
>>       IplParameterBlock iplb_pv;
>>       QemuIplParameters qipl;
>> +    S390IPLCertificateStore cert_store;
>>       uint64_t start_addr;
>>       uint64_t compat_start_addr;
>>       uint64_t bios_start_addr;
>> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
>> index 8866012ddc..80d3d4a74d 100644
>> --- a/hw/s390x/meson.build
>> +++ b/hw/s390x/meson.build
>> @@ -17,6 +17,7 @@ s390x_ss.add(files(
>>     'sclpcpu.c',
>>     'sclpquiesce.c',
>>     'tod.c',
>> +  'cert-store.c',
>>   ))
>>   s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
>>     'tod-kvm.c',
>> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
>> index 6824391111..e505f44020 100644
>> --- a/include/hw/s390x/ipl/qipl.h
>> +++ b/include/hw/s390x/ipl/qipl.h
>> @@ -20,6 +20,8 @@
>>   #define LOADPARM_LEN    8
>>   #define NO_LOADPARM "\0\0\0\0\0\0\0\0"
>>   
>> +#define MAX_CERTIFICATES  64
>> +
>>   /*
>>    * The QEMU IPL Parameters will be stored at absolute address
>>    * 204 (0xcc) which means it is 32-bit word aligned but not
> Regards,
> Jared Rossi


