Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BC9C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKidc-0001tm-3d; Thu, 29 May 2025 15:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uKidZ-0001tY-4c; Thu, 29 May 2025 15:09:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uKidW-0006pk-EY; Thu, 29 May 2025 15:09:56 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TDkiEG018298;
 Thu, 29 May 2025 19:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Yaa7bF
 FIMILUDn26RUZgXu3RkfnkzM/HlxE0k9E91u8=; b=NOpGbsxascFi6ZaM9Qm/iE
 hUG8J39UOMqmu9a3zTCON/jeYUmOq4mlGx2fjSB7JJYB4LROfs7HgN7bIBVI2+i3
 yUbDevi6hH3XA6LbfDtXyoH5JFXcXB8sfaSS99hEKIq0mM6+zKQ7kgZMdKEUbXAm
 ElgZXJe2TZZV3CRciZNA/RdG2hCcCq00sNwRa+DHJQUbiLg2nw/yk/gGenhxhAvV
 WbWmOvl8lfg67FD6W0JDUGg+KCkrI8L97WRinwDjV2mNXMZQ7FHU/1sSFBpdPxQk
 VxoUXpG679BxXZNDdRyOYyQ0Lredi0FBYdjRzZM/trfDPQ3WEIWI41QKjLA4fdMw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40gqf09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 May 2025 19:09:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54THYptf029188;
 Thu, 29 May 2025 19:09:51 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46ureup4pv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 May 2025 19:09:51 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54TJ9jJZ61604296
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:09:45 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B8B35805D;
 Thu, 29 May 2025 19:09:49 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 798F058052;
 Thu, 29 May 2025 19:09:48 +0000 (GMT)
Received: from [9.61.85.78] (unknown [9.61.85.78])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 29 May 2025 19:09:48 +0000 (GMT)
Message-ID: <3d790dad-d4be-443a-ac9b-7c2a5bc53e17@linux.ibm.com>
Date: Thu, 29 May 2025 15:09:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/25] s390x/diag: Implement DIAG 320 subcode 2
To: Thomas Huth <thuth@redhat.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-8-zycai@linux.ibm.com>
 <b986097d-d78b-4163-831b-2551336711ea@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <b986097d-d78b-4163-831b-2551336711ea@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fqNk4BFsbWFIxIqMn9WY2OWWYO0gbGnX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4NSBTYWx0ZWRfX2Fa+4qXb7bN0
 tQ9eo6zmv2tKAkOrqZve9K/pA+My/4XLszXfxgUQWwSMmO9HqifayK3JMYUlCeeVs+jec18wR+1
 ccZVlLt2vniphlAeWthrnJUNndZlVLl4RTGPsPLmJYK+7jwX/BrTeEiuqK9fOi87BsdKjUMpcw+
 Si0gBfd+HsCdejDiar4x/xnMTuTmhP9NWJg+D9PmTRqmMj4ZqyKBKHdvykE46E5uOYKddbmtxks
 zICW7ooEOkFMvnUZsAljEoo54ljNHPQnMML9U+oCT99T7S/58QcYQr2k/KxJTsgDEG1K15uncue
 DuTCjSBdlpf+uFLiZ7RhcTqawYXlpeVImfKyj7YPZVUz2DCj6Dzt8a73Be5TXMP5sp6Db+roy5I
 iir/kLpM15V0nEi7nX9/SjOx/z7FGx2/8UUBF93UCKfNgQPm1+PR6iusyDuGtmcXiX8V4Qre
X-Proofpoint-ORIG-GUID: fqNk4BFsbWFIxIqMn9WY2OWWYO0gbGnX
X-Authority-Analysis: v=2.4 cv=UflRSLSN c=1 sm=1 tr=0 ts=6838b100 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=Uwlj6jU_IwjFMcv1EqQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290185
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 5/14/25 12:18 PM, Thomas Huth wrote:
> On 09/05/2025 00.50, Zhuoying Cai wrote:
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
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   crypto/x509-utils.c            | 204 ++++++++++++++++++++++++++++-
>>   include/crypto/x509-utils.h    |  10 ++
>>   include/hw/s390x/ipl/diag320.h |  47 +++++++
>>   qapi/crypto.json               |  20 +++
>>   target/s390x/diag.c            | 227 ++++++++++++++++++++++++++++++++-
>>   5 files changed, 506 insertions(+), 2 deletions(-)
>>
>> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
>> index 0b8cfc9022..51bd75d4eb 100644
>> --- a/crypto/x509-utils.c
>> +++ b/crypto/x509-utils.c
>> @@ -129,6 +129,7 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>>       int hlen;
>>       gnutls_x509_crt_t crt;
>>       gnutls_datum_t datum = {.data = cert, .size = size};
>> +    gnutls_x509_crt_fmt_t fmt;
>>   
>>       if (alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
>>           error_setg(errp, "Unknown hash algorithm");
>> @@ -140,9 +141,15 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>>           return -1;
>>       }
>>   
>> +    fmt = qcrypto_get_x509_cert_fmt(cert, size, errp);
>> +    if (fmt == -1) {
>> +        error_setg(errp, "Certificate is neither in DER or PEM format");
> 
> qcrypto_get_x509_cert_fmt() already has an errp parameter, so I'd expect 
> that the qcrypto_get_x509_cert_fmt() function already sets up errp in case 
> of errors, doesn't it? In that case you should not set errp here again, I think.
> 
>> +        return -1;
>> +    }
>> +
>>       gnutls_x509_crt_init(&crt);
>>   
>> -    if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) != 0) {
>> +    if (gnutls_x509_crt_import(crt, &datum, fmt) != 0) {
>>           error_setg(errp, "Failed to import certificate");
>>           goto cleanup;
>>       }
>> @@ -199,6 +206,173 @@ cleanup:
>>       return rc;
>>   }
>>   
>> +int qcrypto_get_x509_cert_version(uint8_t *cert, size_t size, Error **errp)
>> +{
>> +    int rc = -1;
>> +    gnutls_x509_crt_t crt;
>> +    gnutls_datum_t datum = {.data = cert, .size = size};
>> +    gnutls_x509_crt_fmt_t fmt;
>> +
>> +    fmt = qcrypto_get_x509_cert_fmt(cert, size, errp);
>> +    if (fmt == -1) {
>> +        error_setg(errp, "Certificate is neither in DER or PEM format");
> 
> dito?
> 
>> +        return rc;
>> +    }
>> +
>> +    if (gnutls_x509_crt_init(&crt) < 0) {
>> +        error_setg(errp, "Failed to initialize certificate");
>> +        return rc;
>> +    }
>> +
>> +    if (gnutls_x509_crt_import(crt, &datum, fmt) != 0) {
>> +        error_setg(errp, "Failed to import certificate");
>> +        goto cleanup;
>> +    }
>> +
>> +    rc = gnutls_x509_crt_get_version(crt);
>> +
>> +cleanup:
>> +    gnutls_x509_crt_deinit(crt);
>> +    return rc;
>> +}
>> +
>> +int qcrypto_check_x509_cert_times(uint8_t *cert, size_t size, Error **errp)
>> +{
>> +    int rc = -1;
>> +    gnutls_x509_crt_t crt;
>> +    gnutls_datum_t datum = {.data = cert, .size = size};
>> +    time_t now = time(0);
>> +    gnutls_x509_crt_fmt_t fmt;
>> +
>> +    if (now == ((time_t)-1)) {
>> +        error_setg(errp, "Cannot get current time");
> 
> Maybe use error_setg_errno() here to get the information from errno, too?
> 
>> +        return rc;
>> +    }
>> +
>> +    fmt = qcrypto_get_x509_cert_fmt(cert, size, errp);
>> +    if (fmt == -1) {
>> +        error_setg(errp, "Certificate is neither in DER or PEM format");
> 
> This is again ignoring the errp from qcrypto_get_x509_cert_fmt().
> 
>> +        return rc;
>> +    }
>> +
>> +    if (gnutls_x509_crt_init(&crt) < 0) {
>> +        error_setg(errp, "Failed to initialize certificate");
>> +        return rc;
>> +    }
>> +
>> +    if (gnutls_x509_crt_import(crt, &datum, fmt) != 0) {
>> +        error_setg(errp, "Failed to import certificate");
>> +        goto cleanup;
>> +    }
>> +
>> +    if (gnutls_x509_crt_get_expiration_time(crt) < now) {
>> +        error_setg(errp, "The certificate has expired");
>> +        goto cleanup;
>> +    }
>> +
>> +    if (gnutls_x509_crt_get_activation_time(crt) > now) {
>> +        error_setg(errp, "The certificate is not yet active");
>> +        goto cleanup;
>> +    }
> 
> gnutls_x509_crt_get_expiration_time() and 
> gnutls_x509_crt_get_activation_time() can both return -1 on errors. I think 
> you should take that into account in the checks here, too.
> 
>> +    rc = 0;
>> +
>> +cleanup:
>> +    gnutls_x509_crt_deinit(crt);
>> +    return rc;
>> +}
>> +
>> +int qcrypto_get_x509_pk_algorithm(uint8_t *cert, size_t size, Error **errp)
>> +{
>> +    int rc = -1;
>> +    unsigned int bits;
>> +    gnutls_x509_crt_t crt;
>> +    gnutls_datum_t datum = {.data = cert, .size = size};
>> +    gnutls_x509_crt_fmt_t fmt;
>> +
>> +    fmt = qcrypto_get_x509_cert_fmt(cert, size, errp);
>> +    if (fmt == -1) {
>> +        error_setg(errp, "Certificate is neither in DER or PEM format");
>> +        return rc;
>> +    }
>> +
>> +    if (gnutls_x509_crt_init(&crt) < 0) {
>> +        error_setg(errp, "Failed to initialize certificate");
>> +        return rc;
>> +    }
>> +
>> +    if (gnutls_x509_crt_import(crt, &datum, fmt) != 0) {
>> +        error_setg(errp, "Failed to import certificate");
>> +        goto cleanup;
>> +    }
>> +
>> +    rc = gnutls_x509_crt_get_pk_algorithm(crt, &bits);
>> +
>> +cleanup:
>> +    gnutls_x509_crt_deinit(crt);
>> +    return rc;
>> +}
>> +
>> +int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
>> +                                 QCryptoKeyidFlags flag,
>> +                                 uint8_t *result,
>> +                                 size_t *resultlen,
>> +                                 Error **errp)
>> +{
>> +    int ret = -1;
>> +    int keyid_len;
>> +    gnutls_x509_crt_t crt;
>> +    gnutls_datum_t datum = {.data = cert, .size = size};
>> +    gnutls_x509_crt_fmt_t fmt;
>> +
>> +    if (flag >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map)) {
>> +        error_setg(errp, "Unknown key id flag");
>> +        return -1;
>> +    }
>> +
>> +    if (result == NULL) {
>> +        error_setg(errp, "No valid buffer given");
>> +        return -1;
>> +    }
> 
> This check sounds like it could also be a simple g_assert() statement instead?
> 

g_assert() may not be ideal here, as it will terminate the guest if the
assertion fails, which is not the intended behavior.

[...]

