Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4494E67A8A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 07:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxgdc-0008DN-Kx; Wed, 04 Mar 2026 02:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vxgdY-0008Ch-HT
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:27:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vxgdW-0004tW-KR
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772609232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1fc9ay7NzjXtfsscKXTAxpRwfiO5hSpLDvIN8UUix/Y=;
 b=ZxDWktXDjYlW0THlZIANSaEye+8C8GT89lU3+vFVDGmmzm38zJSUxfwsj5pj6siHwbxNqe
 iRnuGeVnsjC23lv5KlBlz7G9P1Nc1cnSdEZzCiqZ6ERAlR4BtTDMs9ClumZcaHjo23AaJf
 bbG6Kxmc3mXhShIf1p70V5EWZlY5X6Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-XtecwpchPiiyzF-3-2YqDw-1; Wed,
 04 Mar 2026 02:27:08 -0500
X-MC-Unique: XtecwpchPiiyzF-3-2YqDw-1
X-Mimecast-MFC-AGG-ID: XtecwpchPiiyzF-3-2YqDw_1772609226
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACDC018002CF; Wed,  4 Mar 2026 07:27:06 +0000 (UTC)
Received: from [10.45.224.194] (unknown [10.45.224.194])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B296519560AB; Wed,  4 Mar 2026 07:26:58 +0000 (UTC)
Message-ID: <1423d381-5e73-4f8c-b0f3-3b71b3f8ea19@redhat.com>
Date: Wed, 4 Mar 2026 08:26:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/30] crypto/x509-utils: Add helper functions for DIAG
 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-9-zycai@linux.ibm.com>
 <a876fd40-c80a-4cbd-8969-b0c3cde6b7d9@redhat.com>
 <35d6bae0-533e-43a0-85ae-45aacdb66542@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <35d6bae0-533e-43a0-85ae-45aacdb66542@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 03/03/2026 22.02, Zhuoying Cai wrote:
> On 2/28/26 8:43 AM, Thomas Huth wrote:
>> On 12/02/2026 21.43, Zhuoying Cai wrote:
>>> Introduce new helper functions to extract certificate metadata:
>>>
>>> qcrypto_x509_check_cert_times() - validates the certificate's validity period against the current time
>>> qcrypto_x509_get_pk_algorithm() - returns the public key algorithm used in the certificate
>>> qcrypto_x509_get_cert_key_id() - extracts the key ID from the certificate
>>> qcrypto_x509_check_ecc_curve_p521() - determines the ECC public key algorithm uses P-521 curve
>>>
>>> These functions provide support for metadata extraction and validity checking
>>> for X.509 certificates.
>>>
>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>>> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
>>> ---
>>>    crypto/x509-utils.c         | 236 ++++++++++++++++++++++++++++++++++++
>>>    include/crypto/x509-utils.h |  51 ++++++++
>>>    2 files changed, 287 insertions(+)
>>>
>>> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
>>> index 2696d48155..906d5e5e87 100644
>>> --- a/crypto/x509-utils.c
>>> +++ b/crypto/x509-utils.c
>>> @@ -27,6 +27,16 @@ static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
>>>        [QCRYPTO_HASH_ALGO_RIPEMD160] = GNUTLS_DIG_RMD160,
>>
>> So there is a mapping for RIPEMD160 - everything else will be mapped to 0,
>> which is GNUTLS_DIG_UNKNOWN if I got the gnutls.h header right ...
>>
>>>    };
>> ...
>>> +int qcrypto_x509_get_cert_key_id(uint8_t *cert, size_t size,
>>> +                                 QCryptoHashAlgo hash_alg,
>>> +                                 uint8_t **result,
>>> +                                 size_t *resultlen,
>>> +                                 Error **errp)
>>
>> ... and in patch 09/30, you call this function with:
>>
>> +    rc = qcrypto_x509_get_cert_key_id(cert->raw, cert->size,
>> +                                      QCRYPTO_HASH_ALGO_SHA256,
>> +                                      &key_id_data, &key_id_len, &err);
>>
>> i.e. hash_alg is QCRYPTO_HASH_ALGO_SHA256...
>>
>>> +{
>>> +    int rc;
>>> +    int ret = -1;
>>> +    gnutls_x509_crt_t crt;
>>> +    gnutls_datum_t datum = {.data = cert, .size = size};
>>> +
>>> +    if (hash_alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
>>> +        error_setg(errp, "Unknown hash algorithm %d", hash_alg);
>>> +        return ret;
>>> +    }
>>> +
>>> +    if (hash_alg >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map) ||
>>> +        qcrypto_to_gnutls_keyid_flags_map[hash_alg] == -1) {
>>> +        error_setg(errp, "Unsupported key id flag %d", hash_alg);
>>> +        return ret;
>>> +    }
>>> +
>>> +    rc = gnutls_x509_crt_init(&crt);
>>> +    if (rc < 0) {
>>> +        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
>>> +        return ret;
>>> +    }
>>> +
>>> +    rc = gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM);
>>> +    if (rc != 0) {
>>> +        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
>>> +        goto cleanup;
>>> +    }
>>> +
>>> +    *resultlen = gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[hash_alg]);
>>
>> ... so qcrypto_to_gnutls_hash_alg_map[hash_alg] should result in
>> GNUTLS_DIG_UNKNOWN as far as I can see. How is this supposed to work? Is
>> this code used at all? Or is the error simply ignored somewhere up in the
>> call chain? Or did I miss something?
>>
>>    Thomas
> 
> Thanks for the review!
> 
> To clarify: the diff context only showed the RIPEMD160 line, but the
> existing qcrypto_to_gnutls_hash_alg_map[] also includes SHA256 in
> x509-utils.c.
> 
> static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
>      [QCRYPTO_HASH_ALGO_MD5] = GNUTLS_DIG_MD5,
>      [QCRYPTO_HASH_ALGO_SHA1] = GNUTLS_DIG_SHA1,
>      [QCRYPTO_HASH_ALGO_SHA224] = GNUTLS_DIG_SHA224,
>      [QCRYPTO_HASH_ALGO_SHA256] = GNUTLS_DIG_SHA256,
>      [QCRYPTO_HASH_ALGO_SHA384] = GNUTLS_DIG_SHA384,
>      [QCRYPTO_HASH_ALGO_SHA512] = GNUTLS_DIG_SHA512,
>      [QCRYPTO_HASH_ALGO_RIPEMD160] = GNUTLS_DIG_RMD160,
> };
> 
> For the call in patch 09/30, hash_alg is QCRYPTO_HASH_ALGO_SHA256, so
> qcrypto_to_gnutls_hash_alg_map[hash_alg] resolves to GNUTLS_DIG_SHA256
> (value 6), and gnutls_hash_get_len(...) returns 32 as expected.

Ooops, sorry, I've been fooled by the line wrapping of my e-mail client.

It broke the lines like this:

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index 2696d48155..906d5e5e87 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -27,6 +27,16 @@ static const int
qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
      [QCRYPTO_HASH_ALGO_RIPEMD160] = GNUTLS_DIG_RMD160,
  };

So without having a real close look, it indeed looked like there is only one 
entry in the array here :-/

Sorry for the noise!

  Thomas


