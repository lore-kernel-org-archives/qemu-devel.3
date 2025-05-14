Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C054CC3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 16:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFF8W-0006Lf-Jm; Wed, 14 May 2025 12:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFEoa-0002si-R8
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:18:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFEoX-0000Eh-0U
 for qemu-devel@nongnu.org; Wed, 14 May 2025 12:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747239515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iHYOakESQFu0Jsit1j/GNktZJhq71hTE5KGU79UngUA=;
 b=NeNxm13/gK+xGyZRNnev2wyorseDCitgjr+z4ow6eoZbZ670IsX9wPObALoQOk0QnLENFa
 iuhYmQrg08dcG7CrPtpRsgssT1GXDtKfh/g11vd9sBNUgn2kZOkIjEbFnhEQ4ZV9Q9hslN
 +1RQytQSGhHqSRi31GilWfSFPGMThfM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-_CWEcm_JPxSxZshqUYxijQ-1; Wed, 14 May 2025 12:18:34 -0400
X-MC-Unique: _CWEcm_JPxSxZshqUYxijQ-1
X-Mimecast-MFC-AGG-ID: _CWEcm_JPxSxZshqUYxijQ_1747239513
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5fc013fb4easo14821a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 09:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747239513; x=1747844313;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iHYOakESQFu0Jsit1j/GNktZJhq71hTE5KGU79UngUA=;
 b=UpYxKoHbMI0He15XKXWKsVs4/HP51hcSVlixaUlBkbnJrLHLkz9Jux0MrrpMIz3qKP
 wDrnOX5lxoxD7g4hSZjZEUmx/gcULzE+CZtEyuseBkhGO5BJI3xZ310PC9q7MbiSHNzd
 19v3h4QEHlYAsTHzTh1Zdx5CXQN8qahNvlFbdfwhFxOSqyears+3ps332PLImpgYZb8f
 T/LZJWkffnReW9ZhRSc0KflP1Id7wheNg9sk4b0FKSp5vFO3jxICCIgcgCPjIwG0mgwK
 QJUegsrz4IEVZEhE1CmwQf39h0fv71arymkql7c2nXG6DZaiDYTvWffrRogXeLI5L55n
 r2yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl6RHcnWe9jf1fYEvuWp4fFeOFEsdUVBgYV+br83NBHY97V+hQ/siZuvdcW16e50hXRnHy7CTmJHOn@nongnu.org
X-Gm-Message-State: AOJu0YwcGpb5lqABivN9tojATa1S8vrMe8Owi7pJnRJTPxFG/9TF7s2y
 Y7c54b5ebkigxF4T3kfUHkPE1Z8Dl+T5LROBeD9zmJnka5qN2mSIw+Rys+ErB2x96YHJ7vUvacT
 axibAlgWVz35YPrZIRv475YHreqMpfHsAZshiyUf3nRS5b4m2XYdi
X-Gm-Gg: ASbGncuFS1H6cHTae1gNBzlsiCjmXHQzoemd/b9XG7UNmflEhXfmNEIPQ0kxxYl5Oh0
 sMIzJYPEaPXRMfyvnQUUjST8tByM8i3yCxxiyzGtTveD7PA7nOxz3CluxfCph2rObtg+jqOQ1PQ
 UKtWY8z8Iizjohdent6QPJhcMTwEn+F7WYeEjeaXFM/7WOaWG0juPf68e8OYLyCfmdkLZQOIAOe
 avrFblrp78uY9t5IW3ruurWILEwE/LaFToJKk1zxirRquNibaamtkByBqDaIhXC4bJEgbO+IyKZ
 9CcRCgAeegeJowMh8OjydMckalLE4nMysAH/ND77jWg=
X-Received: by 2002:a17:907:7fa8:b0:ad2:3723:6bf5 with SMTP id
 a640c23a62f3a-ad4f7183950mr410478866b.22.1747239512520; 
 Wed, 14 May 2025 09:18:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3q+j0baICOHFrPTr3cX023oH4ObDPiznIUK32QXRV4a4F5W47XGjbiHfdeIH88D4fyUd+8w==
X-Received: by 2002:a17:907:7fa8:b0:ad2:3723:6bf5 with SMTP id
 a640c23a62f3a-ad4f7183950mr410473966b.22.1747239511873; 
 Wed, 14 May 2025 09:18:31 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-129.web.vodafone.de.
 [109.42.48.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219349301sm954070666b.72.2025.05.14.09.18.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 09:18:31 -0700 (PDT)
Message-ID: <b986097d-d78b-4163-831b-2551336711ea@redhat.com>
Date: Wed, 14 May 2025 18:18:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/25] s390x/diag: Implement DIAG 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com,
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-8-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250508225042.313672-8-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 09/05/2025 00.50, Zhuoying Cai wrote:
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
>   crypto/x509-utils.c            | 204 ++++++++++++++++++++++++++++-
>   include/crypto/x509-utils.h    |  10 ++
>   include/hw/s390x/ipl/diag320.h |  47 +++++++
>   qapi/crypto.json               |  20 +++
>   target/s390x/diag.c            | 227 ++++++++++++++++++++++++++++++++-
>   5 files changed, 506 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 0b8cfc9022..51bd75d4eb 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -129,6 +129,7 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>       int hlen;
>       gnutls_x509_crt_t crt;
>       gnutls_datum_t datum = {.data = cert, .size = size};
> +    gnutls_x509_crt_fmt_t fmt;
>   
>       if (alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
>           error_setg(errp, "Unknown hash algorithm");
> @@ -140,9 +141,15 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>           return -1;
>       }
>   
> +    fmt = qcrypto_get_x509_cert_fmt(cert, size, errp);
> +    if (fmt == -1) {
> +        error_setg(errp, "Certificate is neither in DER or PEM format");

qcrypto_get_x509_cert_fmt() already has an errp parameter, so I'd expect 
that the qcrypto_get_x509_cert_fmt() function already sets up errp in case 
of errors, doesn't it? In that case you should not set errp here again, I think.

> +        return -1;
> +    }
> +
>       gnutls_x509_crt_init(&crt);
>   
> -    if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) != 0) {
> +    if (gnutls_x509_crt_import(crt, &datum, fmt) != 0) {
>           error_setg(errp, "Failed to import certificate");
>           goto cleanup;
>       }
> @@ -199,6 +206,173 @@ cleanup:
>       return rc;
>   }
>   
> +int qcrypto_get_x509_cert_version(uint8_t *cert, size_t size, Error **errp)
> +{
> +    int rc = -1;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +    gnutls_x509_crt_fmt_t fmt;
> +
> +    fmt = qcrypto_get_x509_cert_fmt(cert, size, errp);
> +    if (fmt == -1) {
> +        error_setg(errp, "Certificate is neither in DER or PEM format");

dito?

> +        return rc;
> +    }
> +
> +    if (gnutls_x509_crt_init(&crt) < 0) {
> +        error_setg(errp, "Failed to initialize certificate");
> +        return rc;
> +    }
> +
> +    if (gnutls_x509_crt_import(crt, &datum, fmt) != 0) {
> +        error_setg(errp, "Failed to import certificate");
> +        goto cleanup;
> +    }
> +
> +    rc = gnutls_x509_crt_get_version(crt);
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return rc;
> +}
> +
> +int qcrypto_check_x509_cert_times(uint8_t *cert, size_t size, Error **errp)
> +{
> +    int rc = -1;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +    time_t now = time(0);
> +    gnutls_x509_crt_fmt_t fmt;
> +
> +    if (now == ((time_t)-1)) {
> +        error_setg(errp, "Cannot get current time");

Maybe use error_setg_errno() here to get the information from errno, too?

> +        return rc;
> +    }
> +
> +    fmt = qcrypto_get_x509_cert_fmt(cert, size, errp);
> +    if (fmt == -1) {
> +        error_setg(errp, "Certificate is neither in DER or PEM format");

This is again ignoring the errp from qcrypto_get_x509_cert_fmt().

> +        return rc;
> +    }
> +
> +    if (gnutls_x509_crt_init(&crt) < 0) {
> +        error_setg(errp, "Failed to initialize certificate");
> +        return rc;
> +    }
> +
> +    if (gnutls_x509_crt_import(crt, &datum, fmt) != 0) {
> +        error_setg(errp, "Failed to import certificate");
> +        goto cleanup;
> +    }
> +
> +    if (gnutls_x509_crt_get_expiration_time(crt) < now) {
> +        error_setg(errp, "The certificate has expired");
> +        goto cleanup;
> +    }
> +
> +    if (gnutls_x509_crt_get_activation_time(crt) > now) {
> +        error_setg(errp, "The certificate is not yet active");
> +        goto cleanup;
> +    }

gnutls_x509_crt_get_expiration_time() and 
gnutls_x509_crt_get_activation_time() can both return -1 on errors. I think 
you should take that into account in the checks here, too.

> +    rc = 0;
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return rc;
> +}
> +
> +int qcrypto_get_x509_pk_algorithm(uint8_t *cert, size_t size, Error **errp)
> +{
> +    int rc = -1;
> +    unsigned int bits;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +    gnutls_x509_crt_fmt_t fmt;
> +
> +    fmt = qcrypto_get_x509_cert_fmt(cert, size, errp);
> +    if (fmt == -1) {
> +        error_setg(errp, "Certificate is neither in DER or PEM format");
> +        return rc;
> +    }
> +
> +    if (gnutls_x509_crt_init(&crt) < 0) {
> +        error_setg(errp, "Failed to initialize certificate");
> +        return rc;
> +    }
> +
> +    if (gnutls_x509_crt_import(crt, &datum, fmt) != 0) {
> +        error_setg(errp, "Failed to import certificate");
> +        goto cleanup;
> +    }
> +
> +    rc = gnutls_x509_crt_get_pk_algorithm(crt, &bits);
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return rc;
> +}
> +
> +int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
> +                                 QCryptoKeyidFlags flag,
> +                                 uint8_t *result,
> +                                 size_t *resultlen,
> +                                 Error **errp)
> +{
> +    int ret = -1;
> +    int keyid_len;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +    gnutls_x509_crt_fmt_t fmt;
> +
> +    if (flag >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map)) {
> +        error_setg(errp, "Unknown key id flag");
> +        return -1;
> +    }
> +
> +    if (result == NULL) {
> +        error_setg(errp, "No valid buffer given");
> +        return -1;
> +    }

This check sounds like it could also be a simple g_assert() statement instead?

> +    fmt = qcrypto_get_x509_cert_fmt(cert, size, errp);
> +    if (fmt == -1) {
> +        error_setg(errp, "Certificate is neither in DER or PEM format");

overwriting errp again

> +        return -1;
> +    }
> +
> +    if (gnutls_x509_crt_init(&crt)) {
> +        error_setg(errp, "Failed to initialize certificate");
> +        return -1;
> +    }
> +
> +    if (gnutls_x509_crt_import(crt, &datum, fmt) != 0) {
> +        error_setg(errp, "Failed to import certificate");
> +        goto cleanup;
> +    }
> +
> +    keyid_len = qcrypto_get_x509_keyid_len(QCRYPTO_KEYID_FLAGS_SHA256, errp);
> +    if (*resultlen < keyid_len) {
> +        error_setg(errp,
> +                   "Result buffer size %zu is smaller than key id %d",
> +                   *resultlen, keyid_len);
> +        goto cleanup;
> +    }
> +
> +    if (gnutls_x509_crt_get_key_id(crt,
> +                                   qcrypto_to_gnutls_keyid_flags_map[flag],
> +                                   result, resultlen) != 0) {
> +        error_setg(errp, "Failed to get fingerprint from certificate");
> +        goto cleanup;
> +    }
> +
> +    ret = 0;
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    return ret;
> +}
> +
>   #else /* ! CONFIG_GNUTLS */
>   
>   int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
> @@ -236,4 +410,32 @@ int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **err
>       return -ENOTSUP;
>   }
>   
> +int qcrypto_get_x509_cert_version(uint8_t *cert, size_t size, Error **errp)
> +{
> +    error_setg(errp, "To get certificate version requires GNUTLS");

I'm not a native speaker, but that sentence sounds weird to me. Maybe:

GNUTLS is required to get certificate versions

?

> +    return -ENOTSUP;
> +}
> +
> +int qcrypto_check_x509_cert_times(uint8_t *cert, size_t size, Error **errp)
> +{
> +    error_setg(errp, "To get certificate times requires GNUTLS");

dito

> +    return -ENOTSUP;
> +}
> +
> +int qcrypto_get_x509_pk_algorithm(uint8_t *cert, size_t size, Error **errp)
> +{
> +    error_setg(errp, "To get public key algorithm requires GNUTLS");

dito

> +    return -ENOTSUP;
> +}
> +
> +int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
> +                                 QCryptoKeyidFlags flag,
> +                                 uint8_t *result,
> +                                 size_t *resultlen,
> +                                 Error **errp)
> +{
> +    error_setg(errp, "To get key ID requires GNUTLS");

dito

> +    return -ENOTSUP;
> +}
> +
>   #endif /* ! CONFIG_GNUTLS */
> diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
> index 8fb263b9e1..cf43de0b2c 100644
> --- a/include/crypto/x509-utils.h
> +++ b/include/crypto/x509-utils.h
> @@ -25,4 +25,14 @@ int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg, Error **errp);
>   int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag, Error **errp);
>   int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp);
>   
> +int qcrypto_get_x509_cert_version(uint8_t *cert, size_t size, Error **errp);
> +int qcrypto_check_x509_cert_times(uint8_t *cert, size_t size, Error **errp);
> +int qcrypto_get_x509_pk_algorithm(uint8_t *cert, size_t size, Error **errp);
> +
> +int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
> +                                 QCryptoKeyidFlags flag,
> +                                 uint8_t *result,
> +                                 size_t *resultlen,
> +                                 Error **errp);
> +
>   #endif
> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
> index e91eb7238c..dc1dae1d76 100644
> --- a/include/hw/s390x/ipl/diag320.h
> +++ b/include/hw/s390x/ipl/diag320.h
> @@ -12,15 +12,24 @@
>   
>   #define DIAG_320_SUBC_QUERY_ISM     0
>   #define DIAG_320_SUBC_QUERY_VCSI    1
> +#define DIAG_320_SUBC_STORE_VC      2
>   
>   #define DIAG_320_RC_OK              0x0001
>   #define DIAG_320_RC_INVAL_VCSSB_LEN 0x0202
> +#define DIAG_320_RC_INVAL_VCB_LEN   0x0204
> +#define DIAG_320_RC_BAD_RANGE       0x0302
>   
>   #define VCSSB_MAX_LEN   128
>   #define VCE_HEADER_LEN  128
>   #define VCB_HEADER_LEN  64
>   
>   #define DIAG_320_ISM_QUERY_VCSI     0x4000000000000000
> +#define DIAG_320_ISM_STORE_VC       0x2000000000000000
> +
> +#define DIAG_320_VCE_FLAGS_VALID                0x80
> +#define DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING    0
> +#define DIAG_320_VCE_FORMAT_X509_DER            1
> +#define DIAG_320_VCE_HASHTYPE_SHA2_256          1
>   
>   struct VCStorageSizeBlock {
>       uint32_t length;
> @@ -39,4 +48,42 @@ struct VCStorageSizeBlock {
>   typedef struct VCStorageSizeBlock \
>   VCStorageSizeBlock;
>   
> +struct VCBlock {
> +    uint32_t in_len;
> +    uint32_t reserved0;
> +    uint16_t first_vc_index;
> +    uint16_t last_vc_index;
> +    uint32_t reserved1[5];
> +    uint32_t out_len;
> +    uint8_t reserved2[3];
> +    uint8_t version;
> +    uint16_t stored_ct;
> +    uint16_t remain_ct;
> +    uint32_t reserved3[5];
> +    uint8_t vce_buf[];
> +} QEMU_PACKED;
> +typedef struct VCBlock VCBlock;

Looks like it could be done without QEMU_PACKED ?

> +
> +struct VCEntry {
> +    uint32_t len;
> +    uint8_t flags;
> +    uint8_t key_type;
> +    uint16_t cert_idx;
> +    uint32_t name[16];
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
> +} QEMU_PACKED;
> +typedef struct VCEntry VCEntry;

dito

>   #endif
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index 2bbf29affe..4757bcd3db 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -692,3 +692,23 @@
>              'rsa-sha256', 'rsa-sha384', 'rsa-sha512', 'rsa-sha224',
>              'dsa-sha224', 'dsa-sha256',
>              'ecdsa-sha1', 'ecdsa-sha224', 'ecdsa-sha256', 'ecdsa-sha384', 'ecdsa-sha512']}
> +
> +##
> +# @QCryptoPkAlgo:
> +#
> +# Algorithms for public-key
> +#
> +# @unknown: UNKNOWN
> +#
> +# @rsa: RSA
> +#
> +# @dsa: DSA
> +#
> +# @dh: DH
> +#
> +# @ecdsa: ECDSA
> +#
> +# Since: 9.2

10.1

> +##
> +{ 'enum': 'QCryptoPkAlgo',
> +  'data': ['unknown', 'rsa', 'dsa', 'dh', 'ecdsa']}
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 0743f5ec0e..6fd59ac863 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -17,12 +17,14 @@
>   #include "s390x-internal.h"
>   #include "hw/watchdog/wdt_diag288.h"
>   #include "system/cpus.h"
> +#include "hw/s390x/cert-store.h"
>   #include "hw/s390x/ipl.h"
>   #include "hw/s390x/s390-virtio-ccw.h"
>   #include "system/kvm.h"
>   #include "kvm/kvm_s390x.h"
>   #include "target/s390x/kvm/pv.h"
>   #include "qemu/error-report.h"
> +#include "crypto/x509-utils.h"
>   
>   
>   int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
> @@ -191,6 +193,87 @@ out:
>       }
>   }
>   
> +static int diag_320_is_cert_valid(S390IPLCertificate qcert, Error **errp)
> +{
> +    int version;
> +    int rc;
> +
> +    version = qcrypto_get_x509_cert_version((uint8_t *)qcert.raw, qcert.size, errp);
> +    if (version < 0) {
> +        return version == -ENOTSUP ? -ENOTSUP : 0;
> +    }
> +
> +    rc = qcrypto_check_x509_cert_times((uint8_t *)qcert.raw, qcert.size, errp);
> +    if (rc) {
> +        return 0;
> +    }
> +
> +    return 1;
> +}

Ok, here we have again that problem that the function name and the "normal" 
return values indicate a boolean return value (is valid = true or false), 
but the function can also return -ENOTSUP which could be misinterpreted as 
"true" if the caller is not careful. Could you please rework this?

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

Oh well, and here we also return with is_valid != 0 in case of errors ... 
that's super confusing :-(

> +        return -1;
> +    }
> +
> +    /* key-type */
> +    algo = qcrypto_get_x509_pk_algorithm((uint8_t *)qcert.raw, qcert.size, &err);
> +    if (algo == QCRYPTO_PK_ALGO_RSA) {
> +        vce->key_type = DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;
> +    }
> +
> +    /* VC format */
> +    if (qcert.format == QCRYPTO_CERT_FMT_DER) {
> +        vce->format = DIAG_320_VCE_FORMAT_X509_DER;
> +    }
> +
> +    /* key id and key id len */
> +    *key_id_data = g_malloc0(qcert.key_id_size);
> +    rc = qcrypto_get_x509_cert_key_id((uint8_t *)qcert.raw, qcert.size,
> +                                      QCRYPTO_KEYID_FLAGS_SHA256,
> +                                      *key_id_data, &qcert.key_id_size, &err);
> +    if (rc < 0) {
> +        error_report("Fail to retrieve certificate key ID");

Don't you want to report the "err" variable here?

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
> +        error_report("Fail to retrieve certificate hash");

dito

> +        goto out;
> +    }
> +    vce->hash_len = cpu_to_be16(qcert.hash_size);
> +
> +    return 0;
> +
> +out:
> +    g_free(*key_id_data);
> +    g_free(*hash_data);

Please set *key_id_data and *hash_data to NULL to make sure to not leave 
dangling pointers floating around.

> +    return -1;
> +}
> +
> +
>   void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>   {
>       S390CPU *cpu = env_archcpu(env);
> @@ -216,7 +299,7 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>   
>       switch (subcode) {
>       case DIAG_320_SUBC_QUERY_ISM:
> -        uint64_t ism = cpu_to_be64(DIAG_320_ISM_QUERY_VCSI);
> +        uint64_t ism = cpu_to_be64(DIAG_320_ISM_QUERY_VCSI | DIAG_320_ISM_STORE_VC);
>   
>           if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism, sizeof(ism))) {
>               s390_cpu_virt_mem_handle_exc(cpu, ra);
> @@ -260,6 +343,148 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>           }
>           rc = DIAG_320_RC_OK;
>           break;
> +    case DIAG_320_SUBC_STORE_VC:
> +        VCBlock *vcb;
> +        size_t vce_offset;
> +        size_t remaining_space;
> +        size_t keyid_buf_size;
> +        size_t hash_buf_size;
> +        size_t cert_buf_size;
> +        uint32_t vce_len;
> +        unsigned char *key_id_data = NULL;
> +        void *hash_data = NULL;
> +        int is_valid = 0;
> +        uint16_t first_vc_index;
> +        uint16_t last_vc_index;
> +        uint32_t in_len;
> +
> +        vcb = g_new0(VCBlock, 1);
> +        if (s390_cpu_virt_mem_read(cpu, addr, r1, vcb, sizeof(*vcb))) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            return;
> +        }
> +
> +        in_len = be32_to_cpu(vcb->in_len);
> +        first_vc_index = be16_to_cpu(vcb->first_vc_index);
> +        last_vc_index = be16_to_cpu(vcb->last_vc_index);
> +
> +        if (in_len % TARGET_PAGE_SIZE != 0) {
> +            rc = DIAG_320_RC_INVAL_VCB_LEN;
> +            g_free(vcb);
> +            break;
> +        }
> +
> +        if (first_vc_index > last_vc_index) {
> +            rc = DIAG_320_RC_BAD_RANGE;
> +            g_free(vcb);
> +            break;
> +        }
> +
> +        if (first_vc_index == 0) {
> +            /*
> +             * Zero is a valid index for the first and last VC index.
> +             * Zero index results in the VCB header and zero certificates returned.
> +             */
> +            if (last_vc_index == 0) {
> +                goto out;
> +            }
> +
> +            /* DIAG320 certificate store remains a one origin for cert entries */
> +            vcb->first_vc_index = 1;
> +        }
> +
> +        vce_offset = VCB_HEADER_LEN;
> +        vcb->out_len = VCB_HEADER_LEN;
> +        remaining_space = in_len - VCB_HEADER_LEN;
> +
> +        for (int i = first_vc_index - 1; i < last_vc_index && i < qcs->count; i++) {
> +            VCEntry *vce;
> +            S390IPLCertificate qcert = qcs->certs[i];
> +            /*
> +             * Each VCE is word aligned.
> +             * Each variable length field within the VCE is also word aligned.
> +             */
> +            keyid_buf_size = ROUND_UP(qcert.key_id_size, 4);
> +            hash_buf_size = ROUND_UP(qcert.hash_size, 4);
> +            cert_buf_size = ROUND_UP(qcert.size, 4);
> +            vce_len = VCE_HEADER_LEN + cert_buf_size + keyid_buf_size + hash_buf_size;
> +
> +            /*
> +             * If there is no more space to store the cert,
> +             * set the remaining verification cert count and
> +             * break early.
> +             */
> +            if (remaining_space < vce_len) {
> +                vcb->remain_ct = cpu_to_be16(last_vc_index - i);
> +                break;
> +            }
> +
> +            /*
> +             * Construct VCE
> +             * Unused area following the VCE field contains zeros.
> +             */
> +            vce = g_malloc0(vce_len);
> +            vce->len = cpu_to_be32(vce_len);
> +            vce->cert_idx = cpu_to_be16(i + 1);
> +            vce->cert_len = cpu_to_be32(qcert.size);
> +
> +            strncpy((char *)vce->name, (char *)qcert.vc_name, VC_NAME_LEN_BYTES);
> +
> +            rc = diag_320_get_cert_info(vce, qcert, &is_valid, &key_id_data, &hash_data);
> +            if (rc) {
> +                g_free(vce);
> +                continue;
> +            }
> +
> +            /* VCE field offset is also word aligned */
> +            vce->hash_offset = cpu_to_be16(VCE_HEADER_LEN + keyid_buf_size);
> +            vce->cert_offset = cpu_to_be16(VCE_HEADER_LEN + keyid_buf_size +
> +                                           hash_buf_size);
> +
> +            /* Write Key ID */
> +            memcpy(vce->cert_buf, key_id_data, qcert.key_id_size);
> +            /* Write Hash key */
> +            memcpy(vce->cert_buf + keyid_buf_size, hash_data, qcert.hash_size);
> +            /* Write VCE cert data */
> +            memcpy(vce->cert_buf + keyid_buf_size + hash_buf_size, qcert.raw, qcert.size);
> +
> +            /* The certificate is valid and VCE contains the certificate */
> +            if (is_valid) {
> +                vce->flags |= DIAG_320_VCE_FLAGS_VALID;
> +            }
> +
> +            /* Write VCE Header */
> +            if (s390_cpu_virt_mem_write(cpu, addr + vce_offset, r1, vce, vce_len)) {
> +                s390_cpu_virt_mem_handle_exc(cpu, ra);
> +                return;
> +            }
> +
> +            vce_offset += vce_len;
> +            vcb->out_len += vce_len;
> +            remaining_space -= vce_len;
> +            vcb->stored_ct++;
> +
> +            g_free(vce);
> +            g_free(key_id_data);
> +            g_free(hash_data);
> +        }
> +
> +        vcb->out_len = cpu_to_be32(vcb->out_len);
> +        vcb->stored_ct = cpu_to_be16(vcb->stored_ct);
> +
> +    out:
> +        /*
> +         * Write VCB header
> +         * All VCEs have been populated with the latest information
> +         * and write VCB header last.
> +         */
> +        if (s390_cpu_virt_mem_write(cpu, addr, r1, vcb, VCB_HEADER_LEN)) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            return;
> +        }
> +        rc = DIAG_320_RC_OK;
> +        g_free(vcb);
> +        break;

IMHO this "case" block is way too big for being specified directly here. 
Please move it to a separate function.

>       default:
>           s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>           return;

  Thanks,
   Thomas


