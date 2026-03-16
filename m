Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A88F53D7E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2CIz-00065Z-Gg; Mon, 16 Mar 2026 14:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w2CIy-00065E-8B; Mon, 16 Mar 2026 14:04:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w2CIw-0008Ij-9M; Mon, 16 Mar 2026 14:04:40 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GFPl6i717620; Mon, 16 Mar 2026 18:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wu+aKv
 nEEMv/K4VFYUynRgHY33JIp2/3itGtbNs7nnU=; b=RyvN4ypDaZRBinhohj7gaP
 3LdHv7/uCfc0fZ+sLXlRBnoMik70U9SrgMTknISZDNmJjUdh2BM5imW7064cUcrr
 R4aQGj1xHn4kNohMUlOjZUM1ytkkrDoaIrt/o1VsMxL3uU0M3HsoVFA4uQ7bpqAB
 CRzfrOg+HTq12sQe7Kkq8QFExiGvEGsHQpPIMWvFvZThlzJHTmVJ2opSbbalw7Pb
 uJk6Gj1ej+1iafb/K9QB/e9VtSyjOcqTrYo++nk+2G5bF/rE6MXEDh92Y7p4bl+w
 OZbP0YTDwXklcsVJX+dRrDx4WZLkOppYYwsGmOh9Ca9xduFWK8uY7vO0T0E+sEMw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cru5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 18:04:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GEP3iW005380;
 Mon, 16 Mar 2026 18:04:31 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s5xxg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 18:04:31 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62GI4Tu627328832
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Mar 2026 18:04:29 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8588A58056;
 Mon, 16 Mar 2026 18:04:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ABD575804E;
 Mon, 16 Mar 2026 18:04:27 +0000 (GMT)
Received: from [9.61.130.103] (unknown [9.61.130.103])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Mar 2026 18:04:27 +0000 (GMT)
Message-ID: <521bf180-f73f-4645-9bd9-3d4b36193eca@linux.ibm.com>
Date: Mon, 16 Mar 2026 14:04:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/30] s390x/diag: Implement DIAG 320 subcode 2
To: Collin Walling <walling@linux.ibm.com>, thuth@redhat.com,
 berrange@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
References: <20260305224146.664053-1-zycai@linux.ibm.com>
 <20260305224146.664053-10-zycai@linux.ibm.com>
 <1b5fe3da-1026-4ae3-9349-15f9b7959ea0@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <1b5fe3da-1026-4ae3-9349-15f9b7959ea0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b84630 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Yr8cbUZHRAZd1DvtY8IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzOSBTYWx0ZWRfX0Ln5lNZ5Ui++
 zWuAhcO3X2pv6jRTlfxvWFmOvtmHmKLHFMXjXOqDTLzQCTjIO+Jezq+udwjCyewVJSOamYkS484
 gWBrZIQy13wMIJejGhpv9wmbZ2t5X2Cb5CjNV5+xEoFJ2YnjmaFUq9dxQhDvLtJXeQk27fbUn+x
 ppzRsGadk5cO2ELWtBcm4aFehnzV2kzZgOQvCJjYhjZz3ryvesuG7rD6OyUDbjG+fqv+8rlGWkN
 Dt0cj4ClNxArp7oAp2AHo+D8vlGbVTRdjdqgdX3nshOxclugxzDpcox5UXGNeAwWqkLJoQ2Z38b
 MRa1KqOgBfES9SlTkuCPcNwMdpmK1Y3ti2BUwUndMtKQqiDJA9eomsvRSTeRkp65m+HCVeBcGdj
 vfaQI5sCFmJ4AxH/FMJ97/Ys7lPmW4GO1Kukp8b/pAu1uwFCnxEey17Tkgc/Xi5z8UE0YrRmEYa
 Dxa10xt+JphgHO38eqA==
X-Proofpoint-GUID: Ho5zEYBhy5BSs0Nudh-DtJrm3jBntj-4
X-Proofpoint-ORIG-GUID: Ho5zEYBhy5BSs0Nudh-DtJrm3jBntj-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160139
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Thanks for the review!

On 3/13/26 3:58 PM, Collin Walling wrote:
> On 3/5/26 17:41, Zhuoying Cai wrote:
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
> Functionally, this looks fine.  I've noted a few nits below, but I don't
> think they're worth dragging things out.
> 
> The important thing to address:
>  - documentation rewording
>  - CERT_NAME_MAX_LEN change
> 
> The rest are inconsequential.
> 
>> ---
>>  docs/specs/s390x-secure-ipl.rst |  22 ++
>>  hw/s390x/cert-store.h           |   3 +-
>>  include/hw/s390x/ipl/diag320.h  |  55 +++++
>>  target/s390x/diag.c             | 343 +++++++++++++++++++++++++++++++-
>>  4 files changed, 420 insertions(+), 3 deletions(-)
>>
>> diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
>> index 52661fab00..708253ac91 100644
>> --- a/docs/specs/s390x-secure-ipl.rst
>> +++ b/docs/specs/s390x-secure-ipl.rst
>> @@ -38,3 +38,25 @@ Subcode 1 - query verification certificate storage information
>>      The output is returned in the verification-certificate-storage-size block
>>      (VCSSB). A VCSSB length of 4 indicates that no certificates are available
>>      in the CS.
>> +
>> +Subcode 2 - store verification certificates
>> +    Provides VCs that are in the certificate store.
>> +
>> +    The output is provided in a VCB, which includes a common header followed by
>> +    zero or more verification-certificate entries (VCEs).
>> +
>> +    The instruction expects the cert store to
>> +    maintain an origin of 1 for the index (i.e. a retrieval of the first
>> +    certificate in the store should be denoted by setting first-VC to 1).
> 
> Nit: early newline after "...cert store to".  There is space for a few
> more characters on that line.
> 
>> +
>> +    The first-VC index and last-VC index fields of VCB specify the range of VCs
>> +    to be stored by subcode 2. Stored count and remained count fields specify
>> +    the number of VCs stored and could not be stored in the VCB due to
>> +    insufficient storage specified in the VCB input length field.
>> +
> 
> This might read better.  It makes it more clear how they're used.
> 
> """
> The first-VC and last-VC fields of the VCB specify the index range of
> VCs to be stored in the VCB. Certs are stored sequentially, starting
> with first-VC index. As each cert is stored, a "stored count" is
> incremented. If there is not enough space to store all certs requested
> by the index range, a "remaining count" will be recorded and no more
> certificates will be stored.
> """
> 
>> +    Each VCE contains a header followed by information extracted from a
>> +    certificate within the certificate store. The information includes:
>> +    key-id, hash, and certificate data. This information is stored
>> +    contiguously in a VCE (with zero-padding). Following the header, the
>> +    key-id is immediately stored. The hash and certificate data follow and
>> +    may be accessed via the respective offset fields stored in the VCE.
>> diff --git a/hw/s390x/cert-store.h b/hw/s390x/cert-store.h
>> index 7fc9503cb9..6f5ee63177 100644
>> --- a/hw/s390x/cert-store.h
>> +++ b/hw/s390x/cert-store.h
>> @@ -11,10 +11,9 @@
>>  #define HW_S390_CERT_STORE_H
>>  
>>  #include "hw/s390x/ipl/qipl.h"
>> +#include "hw/s390x/ipl/diag320.h"
>>  #include "crypto/x509-utils.h"
>>  
>> -#define CERT_NAME_MAX_LEN  64
>> -
> 
> Is there a reason why this was moved to diag320.h?
> 

It was moved to diag320.h because the same value is used by both
S390IPLCertificate and VCEntry from DIAG320. Since diag320.h is shared
by both QEMU and the BIOS, defining it there keeps the definition in a
single header and avoids duplication across multiple headers.

[...]

