Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2284CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 18:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzJJo-0005SI-Hr; Thu, 18 Sep 2025 14:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uzJJX-0005Ir-Bd; Thu, 18 Sep 2025 14:25:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uzJJS-0005PW-SP; Thu, 18 Sep 2025 14:25:01 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IBufHv023732;
 Thu, 18 Sep 2025 18:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qgVVIK
 dEHav0b4e35Cdg5rETpaA/bjyKLPbTRo4HfE0=; b=Am5RUGuS4YXZE7OrdejBZI
 ZJvAAHo5vXq9OIb9PMDV7YGIJU3rK7UO8tB5h9Y+92AZiUCVL4+r0pP5s9ngRCnJ
 jdNFpXwZTokcoSH5hdIbTrvpQ3TtXa5M0Ps+J81ayMxITlf27Yz54skE3VvWUaJ8
 uMledh/RQDIKZes9RX4mkR61xmPR0uxHXJCh4guSvrQFhQmQeV0RQQfTybTbQIU+
 UTHCXFRt6kO/RN8tHGGEwymmblP7t9wmfmAUJFP9M1EwycvPb2cKgHP7cOCPmXzq
 KG7S1pVoiZ5LEnBWja99GTl/hU7VJLt/VJfTLsNdxWHDbWfKfKUY4RGHeF+lZudg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qum0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 18:24:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IFwTH5029508;
 Thu, 18 Sep 2025 18:24:51 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kb18c91-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 18:24:51 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58IIOo7716122382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 18:24:50 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 521235805D;
 Thu, 18 Sep 2025 18:24:50 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97FBA58059;
 Thu, 18 Sep 2025 18:24:48 +0000 (GMT)
Received: from [9.61.248.192] (unknown [9.61.248.192])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Sep 2025 18:24:48 +0000 (GMT)
Message-ID: <c257ad0c-fa5f-4716-a257-60c0b905c0f3@linux.ibm.com>
Date: Thu, 18 Sep 2025 11:24:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/28] crypto/x509-utils: Add helper functions for
 certificate store
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-4-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250917232131.495848-4-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XfmVj8EwTeV-fDSe3fbskjkvGv7nYKFc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXwG9Zf2c/Hb7z
 NHhaV50mfkU5dSYeQB404C0tgkc9vMfOXYBDsa/YsGXAk2SKgFRpUVLsVoSKVK9OMPGePPBv1IB
 Irocem4Dgv+WaauRBBYHwy0a4CZQS+bRo90lcgoQdqlxPdkaG806YjC3RNP4KnHswZKk5uInyX4
 8OmPw7Kq6rEa2u/irkOAP9JAjxJyxr9uIGbBRo5/qyHdc+rUxSyZfHDDnYM2Z4swczgyCo4HecE
 nYB92SdmWUajrlg5/yJd4LjJn/4jTKyZXMynrtwcER1iOzfEcXhAWZNKhPXLbtsWkKR3t8c8HHL
 UoldnPikYV+sHa3S7+d4JnyVPPCdVToOIVI16BcmTDqjQ+LYP48DoBHiPDSP9OnyiJNnqaT0xja
 Lty0hdJi
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68cc4e74 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=Y-Y_FT6aZ3COII3uLl8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XfmVj8EwTeV-fDSe3fbskjkvGv7nYKFc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

On 9/17/2025 4:21 PM, Zhuoying Cai wrote:
> Introduce new helper functions for x509 certificate, which will be used
> by the certificate store:
>
> qcrypto_x509_convert_cert_der() - converts a certificate from PEM to DER format
>
> These functions provide support for certificate format conversion.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   crypto/x509-utils.c         | 50 +++++++++++++++++++++++++++++++++++++
>   include/crypto/x509-utils.h | 20 +++++++++++++++
>   2 files changed, 70 insertions(+)
>
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 6176a88653..5d43b0ec96 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -81,6 +81,47 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>       return ret;
>   }
>   
> +int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
> +                                  uint8_t **result, size_t *resultlen,
> +                                  Error **errp)
> +{
> +    int ret = -1;
> +    int rc;
> +    gnutls_x509_crt_t crt;
> +    gnutls_datum_t datum = {.data = cert, .size = size};
> +    gnutls_datum_t datum_der = {.data = NULL, .size = 0};
> +
> +    rc = gnutls_x509_crt_init(&crt);
> +    if (rc < 0) {
> +        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
> +        return ret;
> +    }
> +
> +    rc = gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    rc = gnutls_x509_crt_export2(crt, GNUTLS_X509_FMT_DER, &datum_der);
> +    if (rc != 0) {
> +        error_setg(errp, "Failed to convert certificate to DER format: %s",
> +                   gnutls_strerror(rc));
> +        goto cleanup;
> +    }
> +
> +    *result = g_new0(uint8_t, datum_der.size);
> +    *resultlen = datum_der.size;
> +    memcpy(*result, datum_der.data, datum_der.size);
> +
> +    ret = 0;
> +
> +cleanup:
> +    gnutls_x509_crt_deinit(crt);
> +    gnutls_free(datum_der.data);
> +    return ret;
> +}
> +
>   #else /* ! CONFIG_GNUTLS */
>   
>   int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
> @@ -93,4 +134,13 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>       return -1;
>   }
>   
> +int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
> +                                  uint8_t **result,
> +                                  size_t *resultlen,
> +                                  Error **errp)
> +{
> +    error_setg(errp, "GNUTLS is required to export X.509 certificate");
> +    return -1;
> +}
> +
>   #endif /* ! CONFIG_GNUTLS */
> diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
> index 1e99661a71..4239e3e55a 100644
> --- a/include/crypto/x509-utils.h
> +++ b/include/crypto/x509-utils.h
> @@ -19,4 +19,24 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
>                                         size_t *resultlen,
>                                         Error **errp);
>   
> +/**
> + * qcrypto_x509_convert_cert_der
> + * @cert: pointer to the raw certificate data in PEM format
> + * @size: size of the certificate
> + * @result: output location for the allocated buffer for the certificate in DER format
> +            (the function allocates memory which must be freed by the caller)
> + * @resultlen: pointer to the size of the buffer
> +               (will be updated with the actual size of the DER-encoded certificate)
> + * @errp: error pointer
> + *
> + * Convert the given @cert from PEM to DER format.
> + *
> + * Returns: 0 on success,
> + *         -1 on error.
> + */
> +int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
> +                                  uint8_t **result,
> +                                  size_t *resultlen,
> +                                  Error **errp);
> +
>   #endif

