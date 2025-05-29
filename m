Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F34C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 18:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKiKC-0004N1-9E; Thu, 29 May 2025 14:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uKiK8-0004JZ-CR; Thu, 29 May 2025 14:49:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uKiK4-0004m4-Vk; Thu, 29 May 2025 14:49:52 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TDXkeN003063;
 Thu, 29 May 2025 18:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nZHsDU
 BVM6ymkBvaE1a0Xn/0+6SJB1WRx4S+g0ag2Ko=; b=qJ8J+7E980T9vqJLYRpHfZ
 Uxn+S92ujlrxh6QC/IIeZemAzBP+u6zPZ4TsvUMXbWyRfsd8g8FoQ5B/Q/Ie/Ulv
 ZbIw3Jw+8kPbJfmKBGMGyZX3B6gAMQJBUDaK4lEJJeP3zKGvuXLwwV2t17nQZMf8
 gUbW/A3C05mLZmZ7owBmKIOj3uHKzT0/Ajo6wsvddjO8anmYI/wJ1mWTS9Fjb0Hm
 /MnjzmtqCyqVGcwRhIRPtHAQQEVjQ8OJ61N+YlsnUaoI+5D4Qutalr1nEsNhNZyB
 0E0IPulq/m5xrusP75yWpGJFuNRg1Xm8JHvOmx0qkb546Us9q4Tv8CdF22QkSK7w
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40gqchr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 May 2025 18:49:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54THYwqC027404;
 Thu, 29 May 2025 18:49:46 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46useq5t6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 May 2025 18:49:46 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54TIniAv21627602
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 18:49:44 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4420158068;
 Thu, 29 May 2025 18:49:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F69A58069;
 Thu, 29 May 2025 18:49:43 +0000 (GMT)
Received: from [9.61.85.78] (unknown [9.61.85.78])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 29 May 2025 18:49:43 +0000 (GMT)
Message-ID: <684a7cd3-7c37-4d15-b079-df9ca5b492cd@linux.ibm.com>
Date: Thu, 29 May 2025 14:49:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/25] hw/s390x/ipl: Create certificate store
To: Thomas Huth <thuth@redhat.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-3-zycai@linux.ibm.com>
 <29fac656-e644-4ceb-8e82-d82880e0092c@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <29fac656-e644-4ceb-8e82-d82880e0092c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=avmyCTZV c=1 sm=1 tr=0 ts=6838ac4a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=HR8c-AKbthllK5vWEq0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4MCBTYWx0ZWRfX0dg8cRgGliYg
 qFsCRXgcWaFr/h3wRqhOSy/Ye+7zLpSrxpWIa4kZqUH54zAaG3VaUlDxZCPmJUlc2TMxlxwTGnb
 ntVgjWtdArfxauTaNlh4dHZUN/4icY9M3q4XAJC8TIYYeLE3OqnJCJ6MVTB8lrPHEYPHIrioMHz
 3Zu9gPMcOzOjlgxJktEwO70gQE14O59TnEpTBkscBtxPjvVsLh6jKSkg6VNc9wjZoioXZS5/ewE
 Rw6kbb5UcEUFjC3hOHYScTBNEGJoavRVWrez7iMPSplMNqaeD4ZKzPXCLLpeAPfzh3GkEYSpoMV
 eBJxweCQmnx4E+oXugnK3lF7nGS/uh1qHmpPgGh/6kSjuTuLPH9iBbKdpAFL9eOImsxm4aNWzwN
 8Q3emjM3MrRCudu6pDvc0k851jYJQ4VOabMtXlmIoF2zQvgmvSXrAd+yW3tTQLO5siqA5uLf
X-Proofpoint-GUID: SNWaWXxeqmUDD4MQfxqiU4dTmP28pKqw
X-Proofpoint-ORIG-GUID: SNWaWXxeqmUDD4MQfxqiU4dTmP28pKqw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290180
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


On 5/14/25 1:43 AM, Thomas Huth wrote:
> On 09/05/2025 00.50, Zhuoying Cai wrote:
>> Create a certificate store for boot certificates used for secure IPL.
>>
>> Load certificates from the -boot-certificate option into the cert store.
> 
> Nit: Remove the "-" before the "boot-certificate" here now, too.
> 
>>
>> Currently, only x509 certificates in DER format and uses SHA-256 hashing
>> algorithm are supported, as these are the types required for secure boot
>> on s390.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   crypto/meson.build          |   5 +-
>>   crypto/x509-utils.c         | 163 ++++++++++++++++++++++++
>>   hw/s390x/cert-store.c       | 242 ++++++++++++++++++++++++++++++++++++
>>   hw/s390x/cert-store.h       |  39 ++++++
>>   hw/s390x/ipl.c              |   9 ++
>>   hw/s390x/ipl.h              |   3 +
>>   hw/s390x/meson.build        |   1 +
>>   include/crypto/x509-utils.h |   6 +
>>   include/hw/s390x/ipl/qipl.h |   3 +
>>   qapi/crypto.json            |  80 ++++++++++++
>>   10 files changed, 547 insertions(+), 4 deletions(-)
>>   create mode 100644 hw/s390x/cert-store.c
>>   create mode 100644 hw/s390x/cert-store.h
>>
>> diff --git a/crypto/meson.build b/crypto/meson.build
>> index 735635de1f..0614bfa914 100644
>> --- a/crypto/meson.build
>> +++ b/crypto/meson.build
>> @@ -22,12 +22,9 @@ crypto_ss.add(files(
>>     'tlscredsx509.c',
>>     'tlssession.c',
>>     'rsakey.c',
>> +  'x509-utils.c',
>>   ))
>>   
>> -if gnutls.found()
>> -  crypto_ss.add(files('x509-utils.c'))
>> -endif
> 
> Alternatively, you could put the "return -ENOTSUP;" functions into a 
> x509-utils-stub.c file instead. Just as an idea. Not sure what is nicer 
> here, though.
> 
>>   if nettle.found()
>>     crypto_ss.add(nettle, files('hash-nettle.c', 'hmac-nettle.c', 'pbkdf-nettle.c'))
>>     if hogweed.found()
>> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
>> index 8bad00a51b..0b8cfc9022 100644
>> --- a/crypto/x509-utils.c
>> +++ b/crypto/x509-utils.c
>> @@ -11,6 +11,12 @@
>>   #include "qemu/osdep.h"
>>   #include "qapi/error.h"
>>   #include "crypto/x509-utils.h"
>> +
>> +/*
>> + * Surround with GNUTLS marco to ensure the interfaces are
>> + * still available when GNUTLS is not enabled.
>> + */
>> +#ifdef CONFIG_GNUTLS
>>   #include <gnutls/gnutls.h>
>>   #include <gnutls/crypto.h>
>>   #include <gnutls/x509.h>
>> @@ -25,6 +31,94 @@ static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
>>       [QCRYPTO_HASH_ALGO_RIPEMD160] = GNUTLS_DIG_RMD160,
>>   };
>>   
>> +static const int qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS__MAX] = {
>> +    [QCRYPTO_KEYID_FLAGS_SHA1] = GNUTLS_KEYID_USE_SHA1,
>> +    [QCRYPTO_KEYID_FLAGS_SHA256] = GNUTLS_KEYID_USE_SHA256,
>> +    [QCRYPTO_KEYID_FLAGS_SHA512] = GNUTLS_KEYID_USE_SHA512,
>> +    [QCRYPTO_KEYID_FLAGS_BEST_KNOWN] = GNUTLS_KEYID_USE_BEST_KNOWN,
>> +};
>> +
>> +static const int qcrypto_to_gnutls_cert_fmt_map[QCRYPTO_CERT_FMT__MAX] = {
>> +    [QCRYPTO_CERT_FMT_DER] = GNUTLS_X509_FMT_DER,
>> +    [QCRYPTO_CERT_FMT_PEM] = GNUTLS_X509_FMT_PEM,
>> +};
>> +
>> +int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
>> +                                 QCryptoCertFmt fmt, Error **errp)
> 
> Indentation seems to be off by one?
> 
>> +{
>> +    int rc;
>> +    int ret = 0;
>> +    gnutls_x509_crt_t crt;
>> +    gnutls_datum_t datum = {.data = cert, .size = size};
>> +
>> +    if (fmt >= G_N_ELEMENTS(qcrypto_to_gnutls_cert_fmt_map)) {
>> +        error_setg(errp, "Unknown certificate format");
>> +        return ret;
>  > +    }> +
>> +    if (gnutls_x509_crt_init(&crt) < 0) {
>> +        error_setg(errp, "Failed to initialize certificate");
>> +        goto cleanup;
> 
> So this will do a gnutls_x509_crt_deinit() in case the init() failed ... is 
> that OK or should deinit() only be called after init() succeeded?
> 
>> +    }
>> +
>> +    rc = gnutls_x509_crt_import(crt, &datum, qcrypto_to_gnutls_cert_fmt_map[fmt]);
>> +    if (rc == GNUTLS_E_ASN1_TAG_ERROR) {
>> +        ret = 0;
>> +        goto cleanup;
>> +    }
>> +
>> +    ret = 1;
>> +
>> +cleanup:
>> +    gnutls_x509_crt_deinit(crt);
>> +    return ret;
>> +}
> 
> The return code handling of this function is somewhat confusing. It looks 
> like it is meant to return a boolean value (1 for success, 0 for failure), 
> and that's also the way you use it in the function below, but the return 
> type is "int". Even worse the stub function at the end of the file does a " 
>    return -ENOTSUP;". Although this does not seem to be a problem right now, 
> this might be very fragile for future changes (future code that's expecting 
> a 0 for failures and non-zero for succcess will fail with -ENOTSUP).
> 
> I'd suggest to rework this function so that it 0 for success and a negative 
> error code in case of errors to avoid the possibility of confusion.
> 
>> +static int qcrypto_get_x509_cert_fmt(uint8_t *cert, size_t size, Error **errp)
>> +{
>> +    int fmt;
> 
> If you initialize fmt with -1 here ...
> 
>> +    if (qcrypto_check_x509_cert_fmt(cert, size, QCRYPTO_CERT_FMT_DER, errp)) {
>> +        fmt = GNUTLS_X509_FMT_DER;
>> +    } else if (qcrypto_check_x509_cert_fmt(cert, size, QCRYPTO_CERT_FMT_PEM, errp)) {
>> +        fmt = GNUTLS_X509_FMT_PEM;
>> +    } else {
>> +        return -1;
> 
> ... you can drop the final else branch here.
> 
>> +    }
>> +
>> +    return fmt;
>> +}
>> +
>> +int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg, Error **errp)
>> +{
>> +    if (alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
>> +        error_setg(errp, "Unknown hash algorithm");
>> +        return 0;
> 
> Should that maybe be an assert statement instead?
> 
> Anyway, in this case you set errp and return 0 ...
> 
>> +    }
>> +
>> +    return gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
> 
> ... but this also might return 0 and does not set errp. That means that the 
> caller cannot rely on errp being set (and I think you also never use it?).
> ==> Remove the error_setg() from this function?
> 
>> +}
>> +
>> +int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag, Error **errp)
>> +{
>> +    QCryptoHashAlgo alg;
>> +
>> +    if (flag >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map)) {
>> +        error_setg(errp, "Unknown key id flag");
>> +        return 0;
>> +    }
> 
> dito?
> 
>> +    alg = QCRYPTO_HASH_ALGO_SHA1;
>> +    if ((flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_SHA512]) ||
>> +        (flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_BEST_KNOWN])) {
>> +        alg = QCRYPTO_HASH_ALGO_SHA512;
>> +    } else if (flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_SHA256]) {
>> +        alg = QCRYPTO_HASH_ALGO_SHA256;
>> +    }
>> +
>> +    return qcrypto_get_x509_hash_len(alg, errp);
>> +}
>> +
>>   int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>>                                         QCryptoHashAlgo alg,
>>                                         uint8_t *result,
>> @@ -74,3 +168,72 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>>       gnutls_x509_crt_deinit(crt);
>>       return ret;
>>   }
>> +
>> +int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp)
>> +{
>> +    int rc = -1;
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
>> +    rc = gnutls_x509_crt_get_signature_algorithm(crt);
>> +
>> +cleanup:
>> +    gnutls_x509_crt_deinit(crt);
>> +    return rc;
>> +}
>> +
>> +#else /* ! CONFIG_GNUTLS */
>> +
>> +int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
>> +                                 QCryptoCertFmt fmt, Error **errp)
>> +{
>> +    error_setg(errp, "To get certificate format requires GNUTLS");
>> +    return -ENOTSUP;
>> +}
>> +
>> +int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg, Error **errp)
>> +{
>> +    error_setg(errp, "To get hash length requires GNUTLS");
>> +    return -ENOTSUP;
>> +}
>> +
>> +int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag, Error **errp)
>> +{
>> +    error_setg(errp, "To get key ID length requires GNUTLS");
>> +    return -ENOTSUP;
>> +}
>> +
>> +int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>> +                                      QCryptoHashAlgo hash,
>> +                                      uint8_t *result,
>> +                                      size_t *resultlen,
>> +                                      Error **errp)
>> +{
>> +    error_setg(errp, "To get fingerprint requires GNUTLS");
>> +    return -ENOTSUP;
>> +}
>> +
>> +int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp)
>> +{
>> +    error_setg(errp, "To get signature algorithm requires GNUTLS");
>> +    return -ENOTSUP;
>> +}
>> +
>> +#endif /* ! CONFIG_GNUTLS */
>> diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
>> new file mode 100644
>> index 0000000000..87bf9e381d
>> --- /dev/null
>> +++ b/hw/s390x/cert-store.c
>> @@ -0,0 +1,242 @@
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
>> +#include "qemu/error-report.h"
>> +#include "qemu/option.h"
>> +#include "qemu/config-file.h"
>> +#include "hw/s390x/ebcdic.h"
>> +#include "hw/s390x/s390-virtio-ccw.h"
>> +#include "qemu/cutils.h"
>> +#include "crypto/x509-utils.h"
>> +
>> +static const char *s390_get_boot_certificates(void)
>> +{
>> +    return S390_CCW_MACHINE(qdev_get_machine())->boot_certificates;
>> +}
>> +
>> +static size_t cert2buf(char *path, size_t max_size, char **cert_buf)
>> +{
>> +    size_t size;
>> +    g_autofree char *buf;
> 
> Maybe set *cert_buf = NULL here, just in case the get_contents() fails below?
> 
>> +    /*
>> +     * maximum allowed size of the certificate file to avoid consuming excessive memory
>> +     * (malformed or maliciously large files)
>> +     */
>> +    if (!g_file_get_contents(path, &buf, &size, NULL) ||
>> +        size == 0 || size > max_size) {
>> +        return 0;
>> +    }
>> +
>> +    *cert_buf = g_steal_pointer(&buf);
> 
> I wonder whether you need the detour via buf here at all? I expect that glib 
> does not return a valid buffer pointer in case the get_contents() function 
> fails, so you could rather pass cert_buf to it directly?
> 
>> +    return size;
>> +}
>> +
>> +static S390IPLCertificate *init_cert_x509_der(size_t size, char *raw)
>> +{
>> +    S390IPLCertificate *q_cert = NULL;
>> +    int key_id_size;
>> +    int hash_size;
>> +    int is_der;
>> +    int hash_type;
>> +    Error *err = NULL;
>> +
>> +    is_der = qcrypto_check_x509_cert_fmt((uint8_t *)raw, size,
>> +                                         QCRYPTO_CERT_FMT_DER, &err);
>> +    /* return early if GNUTLS is not enabled */
>> +    if (is_der == -ENOTSUP) {
>> +        error_report("GNUTLS is not enabled");
>> +        return q_cert;
> 
> I'd maybe use "return NULL" here instead to make it more obvious. (same for 
> the other early returns below)
> 
>> +    }
>> +    if (!is_der) {
>> +        error_report("The certificate is not in DER format");
>> +        return q_cert;
>> +    }
>> +
>> +    hash_type = qcrypto_get_x509_signature_algorithm((uint8_t *)raw, size, &err);
>> +    if (hash_type != QCRYPTO_SIG_ALGO_RSA_SHA256) {
>> +        error_report("The certificate does not use SHA-256 hashing");
>> +        return q_cert;
>> +    }
>> +
>> +    key_id_size = qcrypto_get_x509_keyid_len(QCRYPTO_KEYID_FLAGS_SHA256, &err);
>> +    if (key_id_size == 0) {
>> +        error_report("Failed to get certificate key ID size");
>> +        return q_cert;
>> +    }
>> +
>> +    hash_size = qcrypto_get_x509_hash_len(QCRYPTO_HASH_ALGO_SHA256, &err);
>> +    if (hash_size == 0) {
>> +        error_report("Failed to get certificate hash size");
>> +        return q_cert;
>> +    }
>> +
>> +    q_cert = g_new(S390IPLCertificate, 1);
>> +    q_cert->size = size;
>> +    q_cert->key_id_size = key_id_size;
>> +    q_cert->hash_size = hash_size;
>> +    q_cert->raw = raw;
>> +    q_cert->format = QCRYPTO_CERT_FMT_DER;
>> +    q_cert->hash_type = QCRYPTO_SIG_ALGO_RSA_SHA256;
>> +
>> +    return q_cert;
>> +}
>> +
>> +static int check_path_type(const char *path)
>> +{
>> +    struct stat path_stat;
>> +
>> +    if (stat(path, &path_stat) != 0) {
>> +        perror("stat");
>> +        return -1;
>> +    }
>> +
>> +    if (S_ISDIR(path_stat.st_mode)) {
>> +        return S_IFDIR;
>> +    } else if (S_ISREG(path_stat.st_mode)) {
>> +        return S_IFREG;
>> +    } else {
>> +        return -1;
>> +    }
>> +}
>> +
>> +static S390IPLCertificate *init_cert(char *paths)
>> +{
>> +    char *buf;
>> +    char vc_name[VC_NAME_LEN_BYTES];
>> +    g_autofree gchar *filename;
>> +    size_t size;
>> +    S390IPLCertificate *qcert = NULL;
>> +
>> +    filename = g_path_get_basename(paths);
>> +
>> +    size = cert2buf(paths, CERT_MAX_SIZE, &buf);
>> +    if (size == 0) {
>> +        error_report("Failed to load certificate: %s", paths);
>> +        return qcert;
> 
> dito
> 
>> +    }
>> +
>> +    qcert = init_cert_x509_der(size, buf);
>> +    if (qcert == NULL) {
>> +        error_report("Failed to initialize certificate: %s", paths);
>> +        g_free(buf);
>> +        return qcert;
>> +    }
>> +
>> +    /*
>> +     * Left justified certificate name with padding on the right with blanks.
>> +     * Convert certificate name to EBCDIC.
>> +     */
>> +    strpadcpy(vc_name, VC_NAME_LEN_BYTES, filename, ' ');
>> +    ebcdic_put(qcert->vc_name, vc_name, VC_NAME_LEN_BYTES);
> 
> No g_free(buf) here? Should it be marked with g_autofree ?
> 
>   Thomas
> 
> 

I believe g_free can be omitted here, as ownership of the buf pointer is
transferred to qcert after init_cert_x509_der() completes successfully.

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
>> +    cert_buf_size = ROUND_UP(qcert->size, 4);
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
>> +    const char *path;
>> +    gchar **paths;
>> +    gchar **paths_copy;
>> +    int path_type;
>> +    GDir *dir = NULL;
>> +    gchar *cert_path;
>> +    const gchar *filename;
>> +    GPtrArray *cert_path_builder;
>> +
>> +    cert_path_builder = g_ptr_array_new();
>> +
>> +    path = s390_get_boot_certificates();
>> +    if (path == NULL) {
>> +        return cert_path_builder;
>> +    }
>> +
>> +    paths = g_strsplit(path, ":", -1);
>> +    /* save the original pointer for freeing later */
>> +    paths_copy = paths;
>> +    while (*paths) {
>> +        /* skip empty certificate path */
>> +        if (!strcmp(*paths, "")) {
>> +            paths += 1;
>> +            continue;
>> +        }
>> +
>> +        cert_path = NULL;
>> +        path_type = check_path_type(*paths);
>> +        if (path_type == S_IFREG) {
>> +            cert_path = g_strdup(*paths);
>> +            g_ptr_array_add(cert_path_builder, cert_path);
>> +        } else if (path_type == S_IFDIR) {
>> +            dir = g_dir_open(*paths, 0, NULL);
>> +
>> +            if (dir) {
>> +                while ((filename = g_dir_read_name(dir))) {
>> +                    cert_path = g_build_filename(*paths, filename, NULL);
>> +                    g_ptr_array_add(cert_path_builder, (gpointer) cert_path);
>> +                }
>> +
>> +                g_dir_close(dir);
>> +            }
>> +        }
>> +
>> +        paths += 1;
>> +    }
>> +
>> +    g_strfreev(paths_copy);
>> +    return cert_path_builder;
>> +}
>> +
>> +void s390_ipl_create_cert_store(S390IPLCertificateStore *cert_store)
>> +{
>> +    GPtrArray *cert_path_builder;
>> +
>> +    cert_path_builder = get_cert_paths();
>> +    if (cert_path_builder->len == 0) {
>> +        g_ptr_array_free(cert_path_builder, true);
>> +        return;
>> +    }
>> +
>> +    cert_store->max_cert_size = 0;
>> +    cert_store->total_bytes = 0;
>> +
>> +    for (int i = 0; i < cert_path_builder->len; i++) {
>> +        S390IPLCertificate *qcert = init_cert((char *) cert_path_builder->pdata[i]);
>> +        if (qcert) {
>> +            update_cert_store(cert_store, qcert);
>> +        }
>> +    }
>> +
>> +    g_ptr_array_free(cert_path_builder, true);
>> +}
>> diff --git a/hw/s390x/cert-store.h b/hw/s390x/cert-store.h
>> new file mode 100644
>> index 0000000000..04acc6c2e0
>> --- /dev/null
>> +++ b/hw/s390x/cert-store.h
>> @@ -0,0 +1,39 @@
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
>> +    size_t size;
>> +    size_t key_id_size;
>> +    size_t hash_size;
>> +    char *raw;
>> +    QCryptoCertFmt format;
>> +    QCryptoSigAlgo hash_type;
>> +};
>> +typedef struct S390IPLCertificate S390IPLCertificate;
>> +
>> +struct S390IPLCertificateStore {
>> +    uint16_t count;
>> +    size_t max_cert_size;
>> +    size_t total_bytes;
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
>> index 505cded490..ac1f7517ea 100644
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
>> @@ -63,6 +65,7 @@ struct S390IPLState {
>>       IplParameterBlock iplb;
>>       IplParameterBlock iplb_pv;
>>       QemuIplParameters qipl;
>> +    S390IPLCertificateStore cert_store;
>>       uint64_t start_addr;
>>       uint64_t compat_start_addr;
>>       uint64_t bios_start_addr;
>> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
>> index 11e4e78b85..5b02f47155 100644
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
>> diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
>> index 1e99661a71..8fb263b9e1 100644
>> --- a/include/crypto/x509-utils.h
>> +++ b/include/crypto/x509-utils.h
>> @@ -19,4 +19,10 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>>                                         size_t *resultlen,
>>                                         Error **errp);
>>   
>> +int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
>> +                                 QCryptoCertFmt fmt, Error **errp);
>> +int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg, Error **errp);
>> +int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag, Error **errp);
>> +int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp);
>> +
>>   #endif
>> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
>> index 6824391111..b8e7d1da71 100644
>> --- a/include/hw/s390x/ipl/qipl.h
>> +++ b/include/hw/s390x/ipl/qipl.h
>> @@ -20,6 +20,9 @@
>>   #define LOADPARM_LEN    8
>>   #define NO_LOADPARM "\0\0\0\0\0\0\0\0"
>>   
>> +#define MAX_CERTIFICATES 64
>> +#define CERT_MAX_SIZE     (1024 * 8)
>> +
>>   /*
>>    * The QEMU IPL Parameters will be stored at absolute address
>>    * 204 (0xcc) which means it is 32-bit word aligned but not
>> diff --git a/qapi/crypto.json b/qapi/crypto.json
>> index c9d967d782..2bbf29affe 100644
>> --- a/qapi/crypto.json
>> +++ b/qapi/crypto.json
>> @@ -612,3 +612,83 @@
>>     'base': { 'alg': 'QCryptoAkCipherAlgo' },
>>     'discriminator': 'alg',
>>     'data': { 'rsa': 'QCryptoAkCipherOptionsRSA' }}
>> +
>> +##
>> +# @QCryptoKeyidFlags:
>> +#
>> +# The supported flags for the key ID
>> +#
>> +# @sha1: SHA-1
>> +#
>> +# @sha256: SHA-256
>> +#
>> +# @sha512: SHA-512
>> +#
>> +# @best-known: BEST-KNOWN
>> +#
>> +# Since: 9.2
>> +##
>> +{ 'enum': 'QCryptoKeyidFlags',
>> +  'data': ['sha1', 'sha256', 'sha512', 'best-known']}
>> +
>> +##
>> +# @QCryptoCertFmt:
>> +#
>> +# The supported certificate encoding formats
>> +#
>> +# @der: DER
>> +#
>> +# @pem: PEM
>> +#
>> +# Since: 9.2
>> +##
>> +{ 'enum': 'QCryptoCertFmt',
>> +  'data': ['der', 'pem']}
>> +
>> +##
>> +# @QCryptoSigAlgo:
>> +#
>> +# Algorithms for digital signature
>> +#
>> +# @unknown: UNKNOWN
>> +#
>> +# @rsa-sha1: RSA-SHA1 or RSA-SHA
>> +#
>> +# @dsa-sha1: DSA-SHA1 or DSA-SHA
>> +#
>> +# @rsa-md5: RSA-MD5
>> +#
>> +# @rsa-md2: RSA-MD2
>> +#
>> +# @rsa-rmd160: RSA-RMD160
>> +#
>> +# @rsa-sha256: RSA-SHA256
>> +#
>> +# @rsa-sha384: RSA-SHA384
>> +#
>> +# @rsa-sha512: RSA-SHA512
>> +#
>> +# @rsa-sha224: RSA-SHA224
>> +#
>> +# @dsa-sha224: DSA-SHA224
>> +#
>> +# @dsa-sha256: DSA-SHA256
>> +#
>> +# @ecdsa-sha1: ECDSA-SHA1
>> +#
>> +# @ecdsa-sha224: ECDSA-SHA224
>> +#
>> +# @ecdsa-sha256: ECDSA-SHA256
>> +#
>> +# @ecdsa-sha384: ECDSA-SHA384
>> +#
>> +# @ecdsa-sha512: ECDSA-SHA512
>> +#
>> +# Since: 9.2
>> +##
>> +{ 'enum': 'QCryptoSigAlgo',
>> +  'data': ['unknown', 'rsa-sha1', 'dsa-sha1',
>> +           'rsa-md5', 'rsa-md2', 'rsa-rmd160',
>> +           'rsa-sha256', 'rsa-sha384', 'rsa-sha512', 'rsa-sha224',
>> +           'dsa-sha224', 'dsa-sha256',
>> +           'ecdsa-sha1', 'ecdsa-sha224', 'ecdsa-sha256', 'ecdsa-sha384', 'ecdsa-sha512']}
> 


