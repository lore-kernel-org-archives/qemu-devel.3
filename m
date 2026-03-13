Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA536107BCE2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 19:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w18ev-00017g-JD; Fri, 13 Mar 2026 15:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1w18es-00016B-7X; Fri, 13 Mar 2026 15:58:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1w18ep-00087A-3U; Fri, 13 Mar 2026 15:58:53 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DIPMSW2581717; Fri, 13 Mar 2026 19:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EUYCMT
 5bRdmF0/szveR0lBBefxZIZ/Jo6dci1lM2g80=; b=FonRnblaxjuPd1Tkdv+ePA
 O9WP/lfccXtFIlKr6rxbFHCqjPUwdtgxEoBUEJClALfn+za6GBkCxRX4WGayh4hT
 ZcPvppVHje7+F53B7FMDjGaObYpAQb68nUR6ayBIWDzebbKvJv8+1b0wMyB5o8MS
 Aw72TV+1W01AGM/iu4Smxxsrr9xJyqq2d4mj5/oNYbYmI0RE2EznHeGCjHe/DkNq
 4D+OWlydp+hXVHVwRIqyGP8jbplq5f/Fx9WpCAIVgIxKejRA1nFsXXBCNIZd/SmH
 YUfO02+zYgaLvjFbc2AaKPJJJl+3iaCGcWzDDDG126fGw71WghRneK/fld5zMkPw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh951jrr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 19:58:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DJ6Vtq008844;
 Fri, 13 Mar 2026 19:58:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha7852j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 19:58:39 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62DJwc6a13173300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 19:58:38 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 240E858054;
 Fri, 13 Mar 2026 19:58:38 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 326E15805A;
 Fri, 13 Mar 2026 19:58:36 +0000 (GMT)
Received: from [9.67.17.67] (unknown [9.67.17.67])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 13 Mar 2026 19:58:36 +0000 (GMT)
Message-ID: <1b5fe3da-1026-4ae3-9349-15f9b7959ea0@linux.ibm.com>
Date: Fri, 13 Mar 2026 15:58:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/30] s390x/diag: Implement DIAG 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
References: <20260305224146.664053-1-zycai@linux.ibm.com>
 <20260305224146.664053-10-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20260305224146.664053-10-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=69b46c70 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=C7bh8Hn2Yi7jycEupm0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE1NSBTYWx0ZWRfX2p7MhbZgd/yz
 tKSS0Jnx4tk9YQALrIjyf5PUEwFfk/G2ZulqKgF9m88EuMqBcpXj96d+gFJNtH6GROiRWVpN4cv
 TnrmJOzdImnlHwcclO1ULRIv9O6NQEYYNkk+D6/K5XlB8Kr3r8OU7xRpXcyD7fEPnOd2ffRrTuI
 05QuEoIyiOezcD6Zyih20MM5Bi/7L5iYbpUBwhTi5aYoXcP2vblj3qiWDe1G5ph0/lfrmQMdR1p
 JKiqxsvnk+HUl/L8qZhFRN0xlsr7hkaXevodg482MI1Cs2aD/jSoPdWSTASrYaoRe+WQpVOAfwz
 1pPT8Qkyax3CzGBsHGF1NKgVXGhFrC7yU2UBjAv4Is5QV9mQ9jivJZxZ3Z781QBpfiXcsQB/4c0
 n0cqLHVkqH2IFo2l9cbpDdUTnvmUEr2opzbt6VFz0L5L1bpt28mMPeZX7Pls/mA+TiTbgV3X/fI
 94BOadgMovvkkgNF9Wg==
X-Proofpoint-ORIG-GUID: V7DlQ58fA88Gt_WMxNHmleL62koDwY4S
X-Proofpoint-GUID: V7DlQ58fA88Gt_WMxNHmleL62koDwY4S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/5/26 17:41, Zhuoying Cai wrote:
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
> Note: SHA2-256 VC hash type is required for retrieving the hash
> (fingerprint) of the certificate.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>

Functionally, this looks fine.  I've noted a few nits below, but I don't
think they're worth dragging things out.

The important thing to address:
 - documentation rewording
 - CERT_NAME_MAX_LEN change

The rest are inconsequential.

> ---
>  docs/specs/s390x-secure-ipl.rst |  22 ++
>  hw/s390x/cert-store.h           |   3 +-
>  include/hw/s390x/ipl/diag320.h  |  55 +++++
>  target/s390x/diag.c             | 343 +++++++++++++++++++++++++++++++-
>  4 files changed, 420 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
> index 52661fab00..708253ac91 100644
> --- a/docs/specs/s390x-secure-ipl.rst
> +++ b/docs/specs/s390x-secure-ipl.rst
> @@ -38,3 +38,25 @@ Subcode 1 - query verification certificate storage information
>      The output is returned in the verification-certificate-storage-size block
>      (VCSSB). A VCSSB length of 4 indicates that no certificates are available
>      in the CS.
> +
> +Subcode 2 - store verification certificates
> +    Provides VCs that are in the certificate store.
> +
> +    The output is provided in a VCB, which includes a common header followed by
> +    zero or more verification-certificate entries (VCEs).
> +
> +    The instruction expects the cert store to
> +    maintain an origin of 1 for the index (i.e. a retrieval of the first
> +    certificate in the store should be denoted by setting first-VC to 1).

Nit: early newline after "...cert store to".  There is space for a few
more characters on that line.

> +
> +    The first-VC index and last-VC index fields of VCB specify the range of VCs
> +    to be stored by subcode 2. Stored count and remained count fields specify
> +    the number of VCs stored and could not be stored in the VCB due to
> +    insufficient storage specified in the VCB input length field.
> +

This might read better.  It makes it more clear how they're used.

"""
The first-VC and last-VC fields of the VCB specify the index range of
VCs to be stored in the VCB. Certs are stored sequentially, starting
with first-VC index. As each cert is stored, a "stored count" is
incremented. If there is not enough space to store all certs requested
by the index range, a "remaining count" will be recorded and no more
certificates will be stored.
"""

> +    Each VCE contains a header followed by information extracted from a
> +    certificate within the certificate store. The information includes:
> +    key-id, hash, and certificate data. This information is stored
> +    contiguously in a VCE (with zero-padding). Following the header, the
> +    key-id is immediately stored. The hash and certificate data follow and
> +    may be accessed via the respective offset fields stored in the VCE.
> diff --git a/hw/s390x/cert-store.h b/hw/s390x/cert-store.h
> index 7fc9503cb9..6f5ee63177 100644
> --- a/hw/s390x/cert-store.h
> +++ b/hw/s390x/cert-store.h
> @@ -11,10 +11,9 @@
>  #define HW_S390_CERT_STORE_H
>  
>  #include "hw/s390x/ipl/qipl.h"
> +#include "hw/s390x/ipl/diag320.h"
>  #include "crypto/x509-utils.h"
>  
> -#define CERT_NAME_MAX_LEN  64
> -

Is there a reason why this was moved to diag320.h?

(comments below this point are inconsequential, only consider if a v10
is required).

>  #define CERT_KEY_ID_LEN    QCRYPTO_HASH_DIGEST_LEN_SHA256
>  #define CERT_HASH_LEN      QCRYPTO_HASH_DIGEST_LEN_SHA256
>  
> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
> index 6e4779c699..bfd6385b40 100644
> --- a/include/hw/s390x/ipl/diag320.h
> +++ b/include/hw/s390x/ipl/diag320.h
> @@ -12,19 +12,37 @@
>  
>  #define DIAG_320_SUBC_QUERY_ISM     0
>  #define DIAG_320_SUBC_QUERY_VCSI    1
> +#define DIAG_320_SUBC_STORE_VC      2
>  
>  #define DIAG_320_RC_OK              0x0001
>  #define DIAG_320_RC_NOT_SUPPORTED   0x0102
>  #define DIAG_320_RC_INVAL_VCSSB_LEN 0x0202
> +#define DIAG_320_RC_INVAL_VCB_LEN   0x0204
> +#define DIAG_320_RC_BAD_RANGE       0x0302
>  
>  #define DIAG_320_ISM_QUERY_SUBCODES 0x80000000
>  #define DIAG_320_ISM_QUERY_VCSI     0x40000000
> +#define DIAG_320_ISM_STORE_VC       0x20000000
>  
>  #define VCSSB_NO_VC     4
>  #define VCSSB_MIN_LEN   128
>  #define VCE_HEADER_LEN  128
> +/*
> + * If the VCE flags indicate an invalid certificate,
> + * the VCE length is set to 72, containing only the
> + * first five fields of VCEntry.
> + */	
> +#define VCE_INVALID_LEN 72
>  #define VCB_HEADER_LEN  64
>  
> +#define CERT_NAME_MAX_LEN  64
> +
> +#define DIAG_320_VCE_FLAGS_VALID                0x80
> +#define DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING    0
> +#define DIAG_320_VCE_KEYTYPE_ECDSA_P521         1
> +#define DIAG_320_VCE_FORMAT_X509_DER            1
> +#define DIAG_320_VCE_HASHTYPE_SHA2_256          1
> +
>  struct VCStorageSizeBlock {
>      uint32_t length;
>      uint8_t reserved0[3];
> @@ -39,4 +57,41 @@ struct VCStorageSizeBlock {
>  };
>  typedef struct VCStorageSizeBlock VCStorageSizeBlock;
>  
> +struct VCBlock {
> +    uint32_t in_len;
> +    uint32_t reserved0;
> +    uint16_t first_vc_index;
> +    uint16_t last_vc_index;
> +    uint32_t reserved1[5];
> +    uint32_t out_len;
> +    uint8_t reserved2[4];
> +    uint16_t stored_ct;
> +    uint16_t remain_ct;
> +    uint32_t reserved3[5];
> +    uint8_t vce_buf[];
> +};
> +typedef struct VCBlock VCBlock;
> +
> +struct VCEntry {
> +    uint32_t len;
> +    uint8_t flags;
> +    uint8_t key_type;
> +    uint16_t cert_idx;
> +    uint8_t name[CERT_NAME_MAX_LEN];
> +    uint8_t format;
> +    uint8_t reserved0;
> +    uint16_t keyid_len;
> +    uint8_t reserved1;
> +    uint8_t hash_type;
> +    uint16_t hash_len;
> +    uint32_t reserved2;
> +    uint32_t cert_len;
> +    uint32_t reserved3[2];
> +    uint16_t hash_offset;
> +    uint16_t cert_offset;
> +    uint32_t reserved4[7];
> +    uint8_t cert_buf[];
> +};
> +typedef struct VCEntry VCEntry;
> +
>  #endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index c44624e1e6..5326522fda 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -17,13 +17,16 @@
>  #include "s390x-internal.h"
>  #include "hw/watchdog/wdt_diag288.h"
>  #include "system/cpus.h"
> +#include "hw/s390x/cert-store.h"
>  #include "hw/s390x/ipl.h"
>  #include "hw/s390x/ipl/diag320.h"
>  #include "hw/s390x/s390-virtio-ccw.h"
>  #include "system/kvm.h"
>  #include "kvm/kvm_s390x.h"
>  #include "target/s390x/kvm/pv.h"
> +#include "qapi/error.h"
>  #include "qemu/error-report.h"
> +#include "crypto/x509-utils.h"
>  
>  
>  static inline bool diag_parm_addr_valid(uint64_t addr, size_t size, bool write)
> @@ -236,8 +239,333 @@ static int handle_diag320_query_vcsi(S390CPU *cpu, uint64_t addr, uint64_t r1,
>      return DIAG_320_RC_OK;
>  }
>  
> +static bool is_cert_valid(const S390IPLCertificate *cert)
> +{
> +    int rc;
> +    Error *err = NULL;
> +
> +    rc = qcrypto_x509_check_cert_times(cert->raw, cert->size, &err);
> +    if (rc != 0) {
> +        error_report_err(err);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static int handle_key_id(VCEntry *vce, const S390IPLCertificate *cert)
> +{
> +    int rc;
> +    g_autofree unsigned char *key_id_data = NULL;
> +    size_t key_id_len;
> +    Error *err = NULL;
> +
> +    rc = qcrypto_x509_get_cert_key_id(cert->raw, cert->size,
> +                                      QCRYPTO_HASH_ALGO_SHA256,
> +                                      &key_id_data, &key_id_len, &err);
> +    if (rc < 0) {
> +        error_report_err(err);
> +        return -1;
> +    }
> +
> +    if (VCE_HEADER_LEN + key_id_len > be32_to_cpu(vce->len)) {
> +        error_report("Unable to write key ID: exceeds buffer bounds");
> +        return -1;
> +    }
> +
> +    vce->keyid_len = cpu_to_be16(key_id_len);
> +
> +    memcpy(vce->cert_buf, key_id_data, key_id_len);
> +
> +    return 0;
> +}
> +
> +static int handle_hash(VCEntry *vce, const S390IPLCertificate *cert,
> +                       uint16_t keyid_field_len)
> +{
> +    int rc;
> +    uint16_t hash_offset;
> +    g_autofree void *hash_data = NULL;
> +    size_t hash_len;
> +    Error *err = NULL;
> +
> +    hash_len = CERT_HASH_LEN;
> +    hash_data = g_malloc0(hash_len);
> +    rc = qcrypto_get_x509_cert_fingerprint(cert->raw, cert->size,
> +                                           QCRYPTO_HASH_ALGO_SHA256,
> +                                           hash_data, &hash_len, &err);
> +    if (rc < 0) {
> +        error_report_err(err);
> +        return -1;
> +    }
> +
> +    hash_offset = VCE_HEADER_LEN + keyid_field_len;
> +    if (hash_offset + hash_len > be32_to_cpu(vce->len)) {
> +        error_report("Unable to write hash: exceeds buffer bounds");
> +        return -1;
> +    }
> +
> +    vce->hash_len = cpu_to_be16(hash_len);
> +    vce->hash_type = DIAG_320_VCE_HASHTYPE_SHA2_256;
> +    vce->hash_offset = cpu_to_be16(hash_offset);
> +
> +    memcpy((uint8_t *)vce + hash_offset, hash_data, hash_len);
> +
> +    return 0;
> +}
> +
> +static int handle_cert(VCEntry *vce, const S390IPLCertificate *cert,
> +                       uint16_t hash_field_len)
> +{
> +    int rc;
> +    uint16_t cert_offset;
> +    g_autofree uint8_t *cert_der = NULL;
> +    size_t der_size;
> +    Error *err = NULL;
> +
> +    rc = qcrypto_x509_convert_cert_der(cert->raw, cert->size,
> +                                       &cert_der, &der_size, &err);
> +    if (rc < 0) {
> +        error_report_err(err);
> +        return -1;
> +    }
> +
> +    cert_offset = be16_to_cpu(vce->hash_offset) + hash_field_len;
> +    if (cert_offset + der_size > be32_to_cpu(vce->len)) {
> +        error_report("Unable to write certificate: exceeds buffer bounds");
> +        return -1;
> +    }
> +
> +    vce->format = DIAG_320_VCE_FORMAT_X509_DER;
> +    vce->cert_len = cpu_to_be32(der_size);
> +    vce->cert_offset = cpu_to_be16(cert_offset);
> +
> +    memcpy((uint8_t *)vce + cert_offset, cert_der, der_size);
> +
> +    return 0;
> +}
> +
> +static int get_key_type(const S390IPLCertificate *cert)
> +{
> +    int rc;
> +    Error *err = NULL;
> +
> +    rc = qcrypto_x509_check_ecc_curve_p521(cert->raw, cert->size, &err);
> +    if (rc == -1) {
> +        error_report_err(err);
> +        return -1;
> +    }
> +
> +    return (rc == 1) ? DIAG_320_VCE_KEYTYPE_ECDSA_P521 :
> +                        DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;
> +}
> +
> +static int build_vce_header(VCEntry *vce, const S390IPLCertificate *cert, int idx)
> +{
> +    int key_type;
> +
> +    vce->len = cpu_to_be32(VCE_HEADER_LEN);
> +    vce->cert_idx = cpu_to_be16(idx + 1);
> +    memcpy(vce->name, cert->name, CERT_NAME_MAX_LEN);
> +
> +    key_type = get_key_type(cert);
> +    if (key_type == -1) {
> +        return -1;
> +    }
> +    vce->key_type = key_type;
> +
> +    return 0;
> +}
> +
> +static int build_vce_data(VCEntry *vce, const S390IPLCertificate *cert)
> +{
> +    uint16_t keyid_field_len;
> +    uint16_t hash_field_len;
> +    uint32_t cert_field_len;
> +    uint32_t vce_len;
> +    int rc;
> +
> +    rc = handle_key_id(vce, cert);
> +    if (rc) {
> +        return -1;
> +    }
> +    keyid_field_len = ROUND_UP(be16_to_cpu(vce->keyid_len), 4);
> +
> +    rc = handle_hash(vce, cert, keyid_field_len);
> +    if (rc) {
> +        return -1;
> +    }
> +    hash_field_len = ROUND_UP(be16_to_cpu(vce->hash_len), 4);
> +
> +    rc = handle_cert(vce, cert, hash_field_len);
> +    if (rc || !is_cert_valid(cert)) {
> +        return -1;
> +    }
> +    cert_field_len = ROUND_UP(be32_to_cpu(vce->cert_len), 4);
> +
> +    vce_len = VCE_HEADER_LEN + keyid_field_len + hash_field_len + cert_field_len;
> +    if (vce_len > be32_to_cpu(vce->len)) {
> +        return -1;
> +    }
> +
> +    vce->flags |= DIAG_320_VCE_FLAGS_VALID;
> +
> +    /* Update vce length to reflect the actual size used by vce */
> +    vce->len = cpu_to_be32(vce_len);
> +
> +    return 0;
> +}
> +
> +static VCEntry *diag_320_build_vce(const S390IPLCertificate *cert, int idx)
> +{
> +    g_autofree VCEntry *vce = NULL;
> +    uint32_t vce_max_size;
> +    int rc;
> +
> +    /*
> +     * Each field of the VCE is word-aligned.
> +     * Allocate enough space for the largest possible size for this VCE.
> +     * As the certificate fields (key-id, hash, data) are parsed, the
> +     * VCE's length field will be updated accordingly.
> +     */
> +    vce_max_size = VCE_HEADER_LEN +
> +                   ROUND_UP(CERT_KEY_ID_LEN, 4) +
> +                   ROUND_UP(CERT_HASH_LEN, 4) +
> +                   ROUND_UP(cert->der_size, 4);
> +
> +    vce = g_malloc0(vce_max_size);
> +    rc = build_vce_header(vce, cert, idx);
> +    if (rc) {
> +        /*
> +         * Error occurs - VCE does not contain a valid certificate.
> +         * Bit 0 of the VCE flags is 0 and the VCE length is set.
> +         */
> +        vce->len = cpu_to_be32(VCE_INVALID_LEN);
> +        goto out;
> +    }
> +
> +    vce->len = cpu_to_be32(vce_max_size);
> +    rc = build_vce_data(vce, cert);
> +    if (rc) {
> +        vce->len = cpu_to_be32(VCE_INVALID_LEN);
> +    }
> +
> +out:
> +    return g_steal_pointer(&vce);
> +}
> +
> +static int handle_diag320_store_vc(S390CPU *cpu, uint64_t addr, uint64_t r1, uintptr_t ra,
> +                                   S390IPLCertificateStore *cs)
> +{
> +    g_autofree VCBlock *vcb = NULL;
> +    size_t entry_offset;
> +    size_t remaining_space;
> +    uint32_t vce_len;
> +    uint16_t first_vc_index;
> +    uint16_t last_vc_index;
> +    int cs_start_index;
> +    int cs_end_index;
> +    uint32_t in_len;
> +
> +    vcb = g_new0(VCBlock, 1);
> +    if (s390_cpu_virt_mem_read(cpu, addr, r1, vcb, sizeof(*vcb))) {
> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
> +        return -1;
> +    }
> +
> +    in_len = be32_to_cpu(vcb->in_len);
> +    first_vc_index = be16_to_cpu(vcb->first_vc_index);
> +    last_vc_index = be16_to_cpu(vcb->last_vc_index);
> +
> +    if (in_len % TARGET_PAGE_SIZE != 0) {
> +        return DIAG_320_RC_INVAL_VCB_LEN;
> +    }
> +
> +    if (first_vc_index > last_vc_index) {
> +        return DIAG_320_RC_BAD_RANGE;
> +    }
> +
> +    vcb->out_len = VCB_HEADER_LEN;
> +
> +    /*
> +     * DIAG 320 subcode 2 expects to query a certificate store that
> +     * maintains an index origin of 1. However, the S390IPLCertificateStore
> +     * maintains an index origin of 0. Thus, the indices must be adjusted
> +     * for correct access into the cert store. A couple of special cases
> +     * must also be accounted for.
> +     */
> +
> +    /* Both indices are 0; return header with no certs */
> +    if (first_vc_index == 0 && last_vc_index == 0) {
> +        goto out;
> +    }
> +
> +    /* Normalize indices */
> +    cs_start_index = (first_vc_index == 0) ? 0 : first_vc_index - 1;
> +    cs_end_index = last_vc_index - 1;
> +
> +    /* Requested range is outside the cert store; return header with no certs */
> +    if (cs_start_index >= cs->count || cs_end_index >= cs->count) {
> +        goto out;
> +    }
> +
> +    entry_offset = VCB_HEADER_LEN;
> +    remaining_space = in_len - VCB_HEADER_LEN;
> +
> +    for (int i = cs_start_index; i <= cs_end_index; i++) {
> +        VCEntry *vce;
> +        const S390IPLCertificate *cert = &cs->certs[i];
> +
> +        /*
> +         * Bit 0 of the VCE flags indicates whether the certificate is valid.
> +         * The caller of DIAG320 subcode 2 is responsible for verifying that
> +         * the VCE contains a valid certificate.
> +         */
> +        vce = diag_320_build_vce(cert, i);
> +        vce_len = be32_to_cpu(vce->len);

Why not just use vce->len?  It would seem that diag_320_build_vce will
set the len to one of:
	- max len
	- actual len
	- invalid len (72)

In all cases, endianness is accounted for.

> +
> +        /*
> +         * If there is no more space to store the cert,
> +         * set the remaining verification cert count and
> +         * break early.
> +         */
> +        if (remaining_space < vce_len) {
> +            vcb->remain_ct = cpu_to_be16(last_vc_index - i);
> +            g_free(vce);
> +            break;
> +        }
> +
> +        /* Write VCE */
> +        if (s390_cpu_virt_mem_write(cpu, addr + entry_offset, r1, vce, vce_len)) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            g_free(vce);
> +            return -1;
> +        }
> +
> +        entry_offset += vce_len;

entry_offset seems to be serving the same purpose as vcb->out_len.  I
think it makes sense to drop the entry_offset variable and use
vcb->out_len in its place. Then there is one less thing to keep track of.

> +        vcb->out_len += vce_len;
> +        remaining_space -= vce_len;
> +        vcb->stored_ct++;
> +
> +        g_free(vce);
> +    }
> +    vcb->stored_ct = cpu_to_be16(vcb->stored_ct);
> +
> +out:
> +    vcb->out_len = cpu_to_be32(vcb->out_len);
> +
> +    if (s390_cpu_virt_mem_write(cpu, addr, r1, vcb, VCB_HEADER_LEN)) {
> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
> +        return -1;
> +    }
> +
> +    return DIAG_320_RC_OK;
> +}
> +
>  QEMU_BUILD_BUG_MSG(sizeof(VCStorageSizeBlock) != VCSSB_MIN_LEN,
>                     "size of VCStorageSizeBlock is wrong");
> +QEMU_BUILD_BUG_MSG(sizeof(VCBlock) != VCB_HEADER_LEN, "size of VCBlock is wrong");
> +QEMU_BUILD_BUG_MSG(sizeof(VCEntry) != VCE_HEADER_LEN, "size of VCEntry is wrong");
>  
>  void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>  {
> @@ -268,7 +596,8 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>           * for now.
>           */
>          uint32_t ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES |
> -                                         DIAG_320_ISM_QUERY_VCSI);
> +                                         DIAG_320_ISM_QUERY_VCSI |
> +                                         DIAG_320_ISM_STORE_VC);
>  
>          if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism_word0, sizeof(ism_word0))) {
>              s390_cpu_virt_mem_handle_exc(cpu, ra);
> @@ -294,6 +623,18 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>          }
>          env->regs[r1 + 1] = rc;
>          break;
> +    case DIAG_320_SUBC_STORE_VC:
> +        if (addr & ~TARGET_PAGE_MASK) {
> +            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +            return;
> +        }
> +
> +        rc = handle_diag320_store_vc(cpu, addr, r1, ra, cs);
> +        if (rc == -1) {
> +            return;
> +        }
> +        env->regs[r1 + 1] = rc;
> +        break;
>      default:
>          env->regs[r1 + 1] = DIAG_320_RC_NOT_SUPPORTED;
>          break;


-- 
Regards,
  Collin

