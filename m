Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F46E9A03B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSdU-000744-3Y; Tue, 17 Feb 2026 16:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vsSdR-00073V-H6; Tue, 17 Feb 2026 16:29:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vsSdP-0003Z4-Te; Tue, 17 Feb 2026 16:29:33 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61HDtRb41674735; Tue, 17 Feb 2026 21:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zlERz4
 tz5P0MqzJTxiUqZST7aR8VgsHWo/vCwVYAL20=; b=L+6syphHEDzlnW/SZBdTkq
 erBhDpS7DgQ5h6xrpHUSlRggJlx795Fh8CJTedgWuxXh9laFPvX3lGR+D4I0fN0l
 rxEJHF8yycNy5GXLb65kWQ7joUFpZq93hQQQpK8IqipKElimVSJBKJ6/hssqESGH
 qLydpShsLgUYXv1Fn7sWUFgxtnED0puI6tTOyU86cbZU/FpIgbKY9WNXohIXzcRn
 IzIrflLvZbBp6rU6VVeqNM5gUdnYkUYmNK3XyW0x8Zl2hPZYR3PFMq2jr8FcG2OV
 RRAo9X7k5TIK6o/8mw1e5bb28gP0TRkAllpqDV8Jd99MxylEjIQ9M2zJQu+qLs0Q
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6rxms7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 21:29:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HJ2Qhv001419;
 Tue, 17 Feb 2026 21:29:26 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2bd8r7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Feb 2026 21:29:26 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61HLTPkd64880954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Feb 2026 21:29:25 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1803E58059;
 Tue, 17 Feb 2026 21:29:25 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C20958058;
 Tue, 17 Feb 2026 21:29:23 +0000 (GMT)
Received: from [9.61.75.187] (unknown [9.61.75.187])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Feb 2026 21:29:23 +0000 (GMT)
Message-ID: <410c1907-abd4-450b-b734-543b0bae00b5@linux.ibm.com>
Date: Tue, 17 Feb 2026 16:29:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/30] s390x/diag: Implement DIAG 320 subcode 2
To: Markus Armbruster <armbru@redhat.com>
Cc: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-10-zycai@linux.ibm.com> <874infpyu7.fsf@pond.sub.org>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <874infpyu7.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=6994ddb7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=KvBcEoFedPnX7cPRlogA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZFz3ENMd6ZzZ3udk0DbG3hsnbBbgMZcx
X-Proofpoint-ORIG-GUID: ZFz3ENMd6ZzZ3udk0DbG3hsnbBbgMZcx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE3NCBTYWx0ZWRfX+1tJv35YpzEN
 kHnkR+kUjcUWyti349Jte+z0yqUdEj8ieclSug/gOysgkTsiZi5ebqJkVbBM5Oj0VsnshIGVBWC
 Z19xaVXLQsbOYtqv7UV/bENmoRM6MHnC8/EzoSIzE3dXIV6bk9J0+WVeoNAp2ypJkeCsdR+ICXJ
 6jl/SrA4O+wsgjwr45Ar/7iVtohIe366UAfVqeuMl6gNjKGuCCQU0+3rh10h0jH55wtxqOKenXP
 rbRmMJJyiu18VDfgyJr51sWyAumhSnOKBCkE2Wc3Y0JeCmYMFoAxbdyhxjnUvX+Ergjj5L7FNti
 nulNeYUEI0BUmSXGkvih8WWyoJVuu2gxIxA969jV2Mcc43vvPc5hj12MWEGLIzJQdSotd4z3X0f
 KP2BBM6Fkyf2Ns1o0XL2Jx5C2Uq9FYPWlkLbVvnC7PUEYqzu580Ri8v5FNSskIZRe1kiksWvm9l
 HbmZwhfFsCS8DGeKjqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170174
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=1.999,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/17/26 3:18 AM, Markus Armbruster wrote:
> Zhuoying Cai <zycai@linux.ibm.com> writes:
> 
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
> 
> [...]
> 
>> @@ -235,8 +237,324 @@ static int handle_diag320_query_vcsi(S390CPU *cpu, uint64_t addr, uint64_t r1,
>>      return DIAG_320_RC_OK;
>>  }
>>  
>> +static bool is_cert_valid(const S390IPLCertificate *cert)
>> +{
>> +    int rc;
>> +    Error *err = NULL;
>> +
>> +    rc = qcrypto_x509_check_cert_times(cert->raw, cert->size, &err);
>> +    if (rc != 0) {
>> +        error_report_err(err);
> 
> Does not build for me:
> 
>     ../target/s390x/diag.c: In function ‘is_cert_valid’:
>     ../target/s390x/diag.c:249:9: error: implicit declaration of function ‘error_report_err’; did you mean ‘error_report’? [-Wimplicit-function-declaration]
>       249 |         error_report_err(err);
>           |         ^~~~~~~~~~~~~~~~
>           |         error_report
> 

Thanks for pointing this out. The build error is resolved by adding
#include "qapi/error.h" to the file. I’ll update this in the next version.

>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
> 
> [...]
> 


