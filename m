Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF93DEDEBF5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 21:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWt9-0000fR-4r; Tue, 03 Mar 2026 16:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vxWsx-0000e6-PV; Tue, 03 Mar 2026 16:02:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vxWst-0004as-Sp; Tue, 03 Mar 2026 16:02:31 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623EEsSv589479; Tue, 3 Mar 2026 21:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CALsqF
 kOOLmmSE2trMf2GFeX8uvwZBLh62Q23gbRDF8=; b=gw5tviz8VawiYcCKcbcj+c
 cIvSOES+Osln6Nl1T/c25Vr2ZptpRuzPa+T4Jo+iG8WU6SJHpBfn3JeCqMOtpMvF
 /QzhBDwSfayzcprEDFaoL59WYkEyU45sGURwigNaACD54Gh0wj/AqD6Hm3Zyk+Pk
 WXWlv4a8YNSg/dlLknL/8JdWbPsRSUckMj4N8q65D8/mKvundOwWThobfp93P5iE
 9idZW907PRWuGo6a2Uhy8OjGHWbMbRihxBb8X9yCbbRiXVOch8sHtwKxuDdWWjmv
 DirQt/6M2AlMJqmjg6MiI0FUjbZwkmVPlewlM1NLjQ3XbYLgzlnQcSHPqiwupbQw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmmkgm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2026 21:02:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623IQwpX010300;
 Tue, 3 Mar 2026 21:02:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6k3ypb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2026 21:02:18 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 623L2H9B19661336
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Mar 2026 21:02:17 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C48F5805A;
 Tue,  3 Mar 2026 21:02:17 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F6B358056;
 Tue,  3 Mar 2026 21:02:16 +0000 (GMT)
Received: from [9.61.108.121] (unknown [9.61.108.121])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Mar 2026 21:02:16 +0000 (GMT)
Message-ID: <35d6bae0-533e-43a0-85ae-45aacdb66542@linux.ibm.com>
Date: Tue, 3 Mar 2026 16:02:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/30] crypto/x509-utils: Add helper functions for DIAG
 320 subcode 2
To: Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 richard.henderson@linaro.org, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-9-zycai@linux.ibm.com>
 <a876fd40-c80a-4cbd-8969-b0c3cde6b7d9@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <a876fd40-c80a-4cbd-8969-b0c3cde6b7d9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE2OSBTYWx0ZWRfX71yrq5JHutM0
 v8ksAykyK60Cb4DIDTzXxfmoeQfOmedPY7aH0MC9mZ96jZ3KM9406SUB7lzqzs0zkkMuDMlAxNi
 2wlYthPN+wvYsM9ymjihvUblBwapdW5z4o0qmn8VNSe3qZzgzERiba3lOuKt+QS50L0DP0ovWGL
 3bZtgg528CtDFnCYF9PDcH9WEhoB0XNh6EtVGqU4Vd/Jp3idawoyqFPP2DuBObXMIqfpDDopLh6
 a06JwR+TozilogXBhA9lEg6JA68WcPMqB5ht/ZrgaiNW0dku2c1s10h8FmCKn7f1cnPnRSq5h99
 ErpGC7/3OW9xkI8iy45ksswICoF3GJv5RAfmU+W+dpDTdMBuCDiBL3kr6P+92X5+3a+WOvs6K74
 2GVWHRnZLpigQrenb1xmnunGl+yWGSVgfLTgWe0/em1qjAfgmK2Fa8UaetqejP3SXfnhRAL3cnG
 KuYTJ8pCkGwfsXJ2vnQ==
X-Proofpoint-ORIG-GUID: woe0Dg5_OkRmz4HDDChWHAqUmT-rFwGd
X-Proofpoint-GUID: woe0Dg5_OkRmz4HDDChWHAqUmT-rFwGd
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69a74c5b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=BxBFNj_ctIa25WKpb7QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030169
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

On 2/28/26 8:43 AM, Thomas Huth wrote:
> On 12/02/2026 21.43, Zhuoying Cai wrote:
>> Introduce new helper functions to extract certificate metadata:
>>
>> qcrypto_x509_check_cert_times() - validates the certificate's validity period against the current time
>> qcrypto_x509_get_pk_algorithm() - returns the public key algorithm used in the certificate
>> qcrypto_x509_get_cert_key_id() - extracts the key ID from the certificate
>> qcrypto_x509_check_ecc_curve_p521() - determines the ECC public key algorithm uses P-521 curve
>>
>> These functions provide support for metadata extraction and validity checking
>> for X.509 certificates.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
>> ---
>>   crypto/x509-utils.c         | 236 ++++++++++++++++++++++++++++++++++++
>>   include/crypto/x509-utils.h |  51 ++++++++
>>   2 files changed, 287 insertions(+)
>>
>> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
>> index 2696d48155..906d5e5e87 100644
>> --- a/crypto/x509-utils.c
>> +++ b/crypto/x509-utils.c
>> @@ -27,6 +27,16 @@ static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
>>       [QCRYPTO_HASH_ALGO_RIPEMD160] = GNUTLS_DIG_RMD160,
> 
> So there is a mapping for RIPEMD160 - everything else will be mapped to 0, 
> which is GNUTLS_DIG_UNKNOWN if I got the gnutls.h header right ...
> 
>>   };
> ...
>> +int qcrypto_x509_get_cert_key_id(uint8_t *cert, size_t size,
>> +                                 QCryptoHashAlgo hash_alg,
>> +                                 uint8_t **result,
>> +                                 size_t *resultlen,
>> +                                 Error **errp)
> 
> ... and in patch 09/30, you call this function with:
> 
> +    rc = qcrypto_x509_get_cert_key_id(cert->raw, cert->size,
> +                                      QCRYPTO_HASH_ALGO_SHA256,
> +                                      &key_id_data, &key_id_len, &err);
> 
> i.e. hash_alg is QCRYPTO_HASH_ALGO_SHA256...
> 
>> +{
>> +    int rc;
>> +    int ret = -1;
>> +    gnutls_x509_crt_t crt;
>> +    gnutls_datum_t datum = {.data = cert, .size = size};
>> +
>> +    if (hash_alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
>> +        error_setg(errp, "Unknown hash algorithm %d", hash_alg);
>> +        return ret;
>> +    }
>> +
>> +    if (hash_alg >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map) ||
>> +        qcrypto_to_gnutls_keyid_flags_map[hash_alg] == -1) {
>> +        error_setg(errp, "Unsupported key id flag %d", hash_alg);
>> +        return ret;
>> +    }
>> +
>> +    rc = gnutls_x509_crt_init(&crt);
>> +    if (rc < 0) {
>> +        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
>> +        return ret;
>> +    }
>> +
>> +    rc = gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM);
>> +    if (rc != 0) {
>> +        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
>> +        goto cleanup;
>> +    }
>> +
>> +    *resultlen = gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[hash_alg]);
> 
> ... so qcrypto_to_gnutls_hash_alg_map[hash_alg] should result in 
> GNUTLS_DIG_UNKNOWN as far as I can see. How is this supposed to work? Is 
> this code used at all? Or is the error simply ignored somewhere up in the 
> call chain? Or did I miss something?
> 
>   Thomas
> 
> 

Thanks for the review!

To clarify: the diff context only showed the RIPEMD160 line, but the
existing qcrypto_to_gnutls_hash_alg_map[] also includes SHA256 in
x509-utils.c.

static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
    [QCRYPTO_HASH_ALGO_MD5] = GNUTLS_DIG_MD5,
    [QCRYPTO_HASH_ALGO_SHA1] = GNUTLS_DIG_SHA1,
    [QCRYPTO_HASH_ALGO_SHA224] = GNUTLS_DIG_SHA224,
    [QCRYPTO_HASH_ALGO_SHA256] = GNUTLS_DIG_SHA256,
    [QCRYPTO_HASH_ALGO_SHA384] = GNUTLS_DIG_SHA384,
    [QCRYPTO_HASH_ALGO_SHA512] = GNUTLS_DIG_SHA512,
    [QCRYPTO_HASH_ALGO_RIPEMD160] = GNUTLS_DIG_RMD160,
};

For the call in patch 09/30, hash_alg is QCRYPTO_HASH_ALGO_SHA256, so
qcrypto_to_gnutls_hash_alg_map[hash_alg] resolves to GNUTLS_DIG_SHA256
(value 6), and gnutls_hash_get_len(...) returns 32 as expected.

>> +    if (*resultlen == 0) {
>> +        error_setg(errp, "Failed to get hash algorithn length: %s", gnutls_strerror(rc));
>> +        goto cleanup;
>> +    }
>> +
>> +    *result = g_malloc0(*resultlen);
>> +    if (gnutls_x509_crt_get_key_id(crt,
>> +                                   qcrypto_to_gnutls_keyid_flags_map[hash_alg],
>> +                                   *result, resultlen) != 0) {
>> +        error_setg(errp, "Failed to get key ID from certificate");
>> +        g_clear_pointer(result, g_free);
>> +        goto cleanup;
>> +    }
>> +
>> +    ret = 0;
>> +
>> +cleanup:
>> +    gnutls_x509_crt_deinit(crt);
>> +    return ret;
>> +}
> 
>   Thomas
> 


