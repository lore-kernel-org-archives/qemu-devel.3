Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F49D3CC83
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 22:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg8zx-0007Ja-0r; Wed, 14 Jan 2026 17:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vg8zt-0007Ie-Us; Wed, 14 Jan 2026 17:05:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vg8zr-0005AQ-Tx; Wed, 14 Jan 2026 17:05:49 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60EIJNAd019671;
 Wed, 14 Jan 2026 22:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DLj2QB
 NFypRuqjjwUvVpMjpHyML/6D6/8X75cSk5Vrk=; b=jwEWg3QUqbhGF5lBchmdwD
 l0vnbj6KqCiBj96ezmLuJl9i5BpRxDDS9xcpf6opMW7xCRu2kvFwuMITfYUu0juy
 4GIOf7fajt1jlIkNpskTuQJVlc8iIlr3xunx9OjLkCzshFTleSoR0cc1e/CVCCoZ
 Q2i29rF3NbkVY/tki3deBl8XTdy4aGN/o/u8qsMUfLZ+Yn5rG/92Ip5exkk1XIKw
 szS3r7jZj35ajNQ9mflruE2Ym32htgNuZDSNeZlIFzPxbvM4mK4R0Fll70Z2wy5J
 wOFdr4C0hpiNBCGvZ9nZNnl3qTCN7dQwSxNPsWodi6s6tWRWO44O/nk2gMFIEdDA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6hbfuh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Jan 2026 22:05:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60EJC7Um002565;
 Wed, 14 Jan 2026 22:05:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm13svw9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Jan 2026 22:05:44 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60EM5hCq7209922
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Jan 2026 22:05:43 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FE8C58053;
 Wed, 14 Jan 2026 22:05:43 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DF9058043;
 Wed, 14 Jan 2026 22:05:41 +0000 (GMT)
Received: from [9.61.11.245] (unknown [9.61.11.245])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Jan 2026 22:05:41 +0000 (GMT)
Message-ID: <ab32a8f0-304a-4712-90c8-88045a1938a8@linux.ibm.com>
Date: Wed, 14 Jan 2026 17:05:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/29] s390x/diag: Implement DIAG 320 subcode 2
To: Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-10-zycai@linux.ibm.com>
 <75ea4764-6344-4584-b583-2e7316ddb81c@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <75ea4764-6344-4584-b583-2e7316ddb81c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fmb2cyIoIEFpHp2DeMbkMYivj-dDwYC4
X-Proofpoint-ORIG-GUID: Fmb2cyIoIEFpHp2DeMbkMYivj-dDwYC4
X-Authority-Analysis: v=2.4 cv=TaibdBQh c=1 sm=1 tr=0 ts=69681339 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=vqsGD-8LfUaFyCe3oDIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE3OSBTYWx0ZWRfX8KLdRMUCsMaD
 hlaodK8Vy9mHwzZZFoPr8z8aPYgPQVWbRX4TmSKZOeKNiHfTao3Le3m3A3RCBCWmygMKHCYed4p
 GvhSpBcuiAeq9I+Pop5cg+eOe+ZUg3hbzAsf+Vf2JKqH6tuxfyimzOyZptUe2W/UBMV/wuac631
 RcmHpkYxnBMNtRH/xHiCD+hlc3Q62Fc5uCTiSe/KRwBcjY3YlOcSy/0Dl9qXQfyyANzWrK/OT1L
 +nD0sqAC9dc91aetxQDrhkGxxCXPXd0HQJmvIsWAWJmfEDloedlwuC0dh8UEIZqvizI/D+lcP71
 KPCfn2IoEqHoILAZfhjtyqBaIpAz9hxFkjkmiFVsRc0O5vmjsB6ufQOtShyDOPVYnenQHziSZs0
 LbranLY5lswPWsjXDYOL49svvq+Q4c81o0qDhc7vacaI6BZgQSl6X3bYTBeWaTT09gRWDTbIePc
 /PRiuN6CEbF5/oAzF8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_06,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601140179
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Thanks for the feedback!

On 1/9/26 7:41 AM, Thomas Huth wrote:
> On 08/12/2025 22.32, Zhuoying Cai wrote:
>> DIAG 320 subcode 2 provides verification-certificates (VCs) that are in the
>> certificate store. Only X509 certificates in DER format and SHA-256 hash
>> type are recognized.
>>
>> The subcode value is denoted by setting the second-left-most bit
>> of an 8-byte field.
>>
>> The Verification Certificate Block (VCB) contains the output data
>> when the operation completes successfully. It includes a common
>> header followed by zero or more Verification Certificate Entries (VCEs),
>> depending on the VCB input length and the VC range (from the first VC
>> index to the last VC index) in the certificate store.
>>
>> Each VCE contains information about a certificate retrieved from
>> the S390IPLCertificateStore, such as the certificate name, key type,
>> key ID length, hash length, and the raw certificate data.
>> The key ID and hash are extracted from the raw certificate by the crypto API.
>>
>> Note: SHA2-256 VC hash type is required for retrieving the hash
>> (fingerprint) of the certificate.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
> ...
>  > +struct VCEntry {
>  > +    uint32_t len;
>  > +    uint8_t flags;
>  > +    uint8_t key_type;
>  > +    uint16_t cert_idx;
>  > +    uint32_t name[16];
> 
> Why is this defined as an array of uint32_t when it is rather a string instead?
> 

This field contains the 64-byte name of the certificate in EBCDIC
format. I think it would be more appropriate to define it as uint8_t
name[64].

>  > +    uint8_t format;
>  > +    uint8_t reserved0;
>  > +    uint16_t keyid_len;
>  > +    uint8_t reserved1;
>  > +    uint8_t hash_type;
>  > +    uint16_t hash_len;
>  > +    uint32_t reserved2;
>  > +    uint32_t cert_len;
>  > +    uint32_t reserved3[2];
>  > +    uint16_t hash_offset;
>  > +    uint16_t cert_offset;
>  > +    uint32_t reserved4[7];
>  > +    uint8_t cert_buf[];
>  > +};
>  > +typedef struct VCEntry VCEntry;
> ...
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index 0e1897e03d..1498b29a0d 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -17,6 +17,7 @@
>>   #include "s390x-internal.h"
>>   #include "hw/watchdog/wdt_diag288.h"
>>   #include "system/cpus.h"
>> +#include "hw/s390x/cert-store.h"
>>   #include "hw/s390x/ipl.h"
>>   #include "hw/s390x/ipl/diag320.h"
>>   #include "hw/s390x/s390-virtio-ccw.h"
>> @@ -24,6 +25,7 @@
>>   #include "kvm/kvm_s390x.h"
>>   #include "target/s390x/kvm/pv.h"
>>   #include "qemu/error-report.h"
>> +#include "crypto/x509-utils.h"
>>   
>>   
>>   static inline bool diag_parm_addr_valid(uint64_t addr, size_t size, bool write)
>> @@ -231,8 +233,330 @@ static int handle_diag320_query_vcsi(S390CPU *cpu, uint64_t addr, uint64_t r1,
>>       return DIAG_320_RC_OK;
>>   }
>>   
>> +static bool is_cert_valid(S390IPLCertificate cert)
> 
> You're using call-by-value for all S390IPLCertificate parameters in this 
> patch ... that's quite cumbersome since the struct has a size of ~80 bytes.
> 
> Unless there is a very good reason for doing so, I'd suggest that you switch 
> the code to use (const) pointers instead of passing around that struct on 
> the stack.
> 
>> +{
>> +    int rc;
>> +    Error *err = NULL;
>> +
>> +    rc = qcrypto_x509_check_cert_times(cert.raw, cert.size, &err);
>> +    if (rc != 0) {
>> +        error_report_err(err);
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +static void handle_key_id(VCEntry *vce, S390IPLCertificate cert)
>> +{
>> +    int rc;
>> +    g_autofree unsigned char *key_id_data = NULL;
>> +    size_t key_id_len;
>> +    Error *err = NULL;
>> +
>> +    key_id_len = CERT_KEY_ID_LEN;
>> +    /* key id and key id len */
>> +    rc = qcrypto_x509_get_cert_key_id(cert.raw, cert.size,
>> +                                      QCRYPTO_HASH_ALGO_SHA256,
>> +                                      &key_id_data, &key_id_len, &err);
>> +    if (rc < 0) {
>> +        error_report_err(err);
>> +        return;
>> +    }
>> +
>> +    if (VCE_HEADER_LEN + key_id_len > be32_to_cpu(vce->len)) {
>> +        error_report("Unable to write key ID: exceeds buffer bounds");
>> +        return;
>> +    }
>> +
>> +    vce->keyid_len = cpu_to_be16(key_id_len);
>> +
>> +    memcpy(vce->cert_buf, key_id_data, key_id_len);
>> +}
>> +
>> +static int handle_hash(VCEntry *vce, S390IPLCertificate cert, uint16_t keyid_field_len)
>> +{
>> +    int rc;
>> +    uint16_t hash_offset;
>> +    g_autofree void *hash_data = NULL;
>> +    size_t hash_len;
>> +    Error *err = NULL;
>> +
>> +    hash_len = CERT_HASH_LEN;
>> +    /* hash and hash len */
>> +    hash_data = g_malloc0(hash_len);
>> +    rc = qcrypto_get_x509_cert_fingerprint(cert.raw, cert.size,
>> +                                           QCRYPTO_HASH_ALGO_SHA256,
>> +                                           hash_data, &hash_len, &err);
>> +    if (rc < 0) {
>> +        error_report_err(err);
>> +        return -1;
>> +    }
>> +
>> +    hash_offset = VCE_HEADER_LEN + keyid_field_len;
>> +    if (hash_offset + hash_len > be32_to_cpu(vce->len)) {
>> +        error_report("Unable to write hash: exceeds buffer bounds");
>> +        return -1;
>> +    }
>> +
>> +    vce->hash_len = cpu_to_be16(hash_len);
>> +    vce->hash_type = DIAG_320_VCE_HASHTYPE_SHA2_256;
>> +    vce->hash_offset = cpu_to_be16(hash_offset);
>> +
>> +    memcpy((uint8_t *)vce + hash_offset, hash_data, hash_len);
>> +
>> +    return 0;
>> +}
>> +
>> +static int handle_cert(VCEntry *vce, S390IPLCertificate cert, uint16_t hash_field_len)
>> +{
>> +    int rc;
>> +    uint16_t cert_offset;
>> +    g_autofree uint8_t *cert_der = NULL;
>> +    Error *err = NULL;
>> +
>> +    /* certificate in DER format */
>> +    rc = qcrypto_x509_convert_cert_der(cert.raw, cert.size,
>> +                                       &cert_der, &cert.der_size, &err);
>> +    if (rc < 0) {
>> +        error_report_err(err);
>> +        return -1;
>> +    }
>> +
>> +    cert_offset = be16_to_cpu(vce->hash_offset) + hash_field_len;
>> +    if (cert_offset + cert.der_size > be32_to_cpu(vce->len)) {
>> +        error_report("Unable to write certificate: exceeds buffer bounds");
>> +        return -1;
>> +    }
>> +
>> +    vce->format = DIAG_320_VCE_FORMAT_X509_DER;
>> +    vce->cert_len = cpu_to_be32(cert.der_size);
>> +    vce->cert_offset = cpu_to_be16(cert_offset);
>> +
>> +    memcpy((uint8_t *)vce + cert_offset, cert_der, cert.der_size);
>> +
>> +    return 0;
>> +}
>> +
>> +static int get_key_type(S390IPLCertificate cert)
>> +{
>> +    int algo;
>> +    int rc;
>> +    Error *err = NULL;
>> +
>> +    /* public key algorithm */
>> +    algo = qcrypto_x509_get_pk_algorithm(cert.raw, cert.size, &err);
>> +    if (algo < 0) {
>> +        error_report_err(err);
>> +        return -1;
>> +    }
>> +
>> +    if (algo == QCRYPTO_PK_ALGO_ECDSA) {
>> +        rc = qcrypto_x509_check_ecc_curve_p521(cert.raw, cert.size, &err);
>> +        if (rc == -1) {
>> +            error_report_err(err);
>> +            return -1;
>> +        }
>> +
>> +        return (rc == 1) ? DIAG_320_VCE_KEYTYPE_ECDSA_P521 :
>> +                           DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;
>> +    }
>> +
>> +    return DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;
>> +}
>> +
>> +static int build_vce_header(VCEntry *vce, S390IPLCertificate cert, int idx)
>> +{
>> +    int key_type;
>> +
>> +    vce->len = cpu_to_be32(VCE_HEADER_LEN);
>> +    vce->cert_idx = cpu_to_be16(idx + 1);
>> +    strncpy((char *)vce->name, (char *)cert.vc_name, VC_NAME_LEN_BYTES);
> 
> strncpy is often tripping up static analyzers when you use it like this.
> Please consider using memcpy(), pstrcpy() or strpadcpy() instead.
> (I guess memcpy is the right thing to use here since vc_name has already 
> been initialized with strpadcpy ?)
> 
>> +    key_type = get_key_type(cert);
>> +    if (key_type == -1) {
>> +        return -1;
>> +    }
>> +    vce->key_type = key_type;
>> +
>> +    return 0;
>> +}
> 
>   Thomas
> 


