Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0650CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCA6-0001ip-OJ; Thu, 18 Jun 2026 08:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fcallies@linux.ibm.com>)
 id 1wa5l5-0000ax-3d; Thu, 18 Jun 2026 01:57:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fcallies@linux.ibm.com>)
 id 1wa5l3-0000uc-HO; Thu, 18 Jun 2026 01:57:46 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HHmqj1978744; Thu, 18 Jun 2026 05:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LpAMwQ
 424Yf88Mac2/e8SVo734fynWYdiOSqwI+OUOM=; b=CcJueMz6sA6Q/dIN2ZQ3mW
 DNG6bcH+csYp1itKKNDX0uZy56nH0CTMXNQq62MXRDgmDh2eObs1Hqo1/LsvyX3b
 nr3U+tK94xoTDLvFk86uNooYnWuzqPAd0L+uJ5kXKOKRcWGjh2dCZ9Yh8Lk2yF5X
 YOq3GLXgRd+b/3FHh0mrlewRpOZ1ZDyjHdX4FCnRDMQvhzJegy/wxhSFctbZsr5S
 eJHsY794o4OaBjW6G1BnZ0o/O6J5oWCOqBgLeF2kcoqjUYO4ZegfOS9aSZL2fCtP
 uQK0RQ2G/RELxya4yMVj5yN6c8AWaXWNOSsZDp4UD2OmvlzkMdMVLfdT3AUlohqQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx6fgc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 05:57:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I5nmeL019408;
 Thu, 18 Jun 2026 05:57:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172a7wb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 05:57:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65I5vbZ540305128
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jun 2026 05:57:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3390C20043;
 Thu, 18 Jun 2026 05:57:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 010F120040;
 Thu, 18 Jun 2026 05:57:37 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jun 2026 05:57:36 +0000 (GMT)
Message-ID: <943edaf2-801b-4124-a7c7-67555ba2ac28@linux.ibm.com>
Date: Thu, 18 Jun 2026 07:57:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/17] target/s390x: Support protected key AES ECB for
 cpacf km instruction
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 iii@linux.ibm.com, david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-11-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-11-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pwvxO9hKDO7m-X_yLb392I05qxbumRBT
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a3388d6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VGiExruGORX4ntSzDeoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1MSBTYWx0ZWRfX5R/m0KiGnWre
 v9WbwAqsrvWpG1SkWE1zsppGPC2rAfwxGacyI7b3yQgE9ouhwQqpnoqZbGtJzZr/jixDxeo6X+Y
 tDbiSSsbTY/HwdUv1rUihSm9T1fojtM=
X-Proofpoint-ORIG-GUID: pwvxO9hKDO7m-X_yLb392I05qxbumRBT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1MSBTYWx0ZWRfX0FnT8L+Wxf59
 pSWKtdQ42fAAJJ1hwIlKRLvw+VCQhv8BLkMaMBue/5nC50jO46HvPImNxempl57hs+X3eU4XjC3
 T6SFS5BX7eJgdIg1nuDX7Smi0OQh3agbJN1GCSd7A4IF9GG4zmYHpevx+QzFskGJEF5LFxpGdqw
 i/f5Br1gpipboVP8L4ywa629nIjCOZ38Bji3Qvzg8xI9QkAJLesbx/OP7QEV6hhZzKFb98FJOWX
 yD5PmXhhbkWKgzVblBFsB1Ux8/zqps1lgaqNms3afRLL+Lw+PL1yHnM5DfKVuPMHcFnbp6vqv3S
 FjeV1azKlOfuPnw7g6UPUECVIWw9qihTLnOmP5nIHJ3JF8jpYkhot7OEwLC73/EERzm0k5jxn75
 B7AbboTBaBtstN0bkATnPyRvAUBcSQJVtKYccCpoZh7WU04PWWv0QbNrMu80DNDofocMMthNpfG
 ASAGS5qp1GdO30p3v7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180051
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=fcallies@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Jun 2026 08:48:01 -0400
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



On 17.06.26 11:48, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KM_PAES_128, CPACF_KM_PAES_192
> and CPACF_KM_PAES_256 for the cpacf km instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>

With the comments at least considered:

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

> ---
>   target/s390x/gen-features.c      |  3 ++
>   target/s390x/tcg/cpacf.h         |  4 ++
>   target/s390x/tcg/cpacf_aes.c     | 87 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  7 +++
>   4 files changed, 101 insertions(+)
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index d3e69aaca6..71e0e41d6e 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -924,6 +924,9 @@ static uint16_t qemu_MAX[] = {
>       S390_FEAT_KM_AES_128,
>       S390_FEAT_KM_AES_192,
>       S390_FEAT_KM_AES_256,
> +    S390_FEAT_KM_EAES_128,
> +    S390_FEAT_KM_EAES_192,
> +    S390_FEAT_KM_EAES_256,

I would strongly prefer PAES instead of EAES. I know the CPACF function 
is called KM...ENCRYPTED...AES... but since we use protected or PAES in 
any other context and never Encrypted AES I would highly suggest PAES 
here as well. Or as an alternative expand the E to 
S390_FEAT_KM_ENCRYPTED_AES_128 to match the CPACF naming.

>       S390_FEAT_KM_XTS_AES_128,
>       S390_FEAT_KM_XTS_AES_256,
>       S390_FEAT_KMC_AES_128,

[ snip ]

> diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
> index 5a0a3473d5..bcfcf3b660 100644
> --- a/target/s390x/tcg/cpacf_aes.c
> +++ b/target/s390x/tcg/cpacf_aes.c
> @@ -533,3 +533,90 @@ int cpacf_aes_pckmo(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>   
>       return 0;
>   }
> +
> +int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> +                   uint64_t param_addr, uint64_t *dst_ptr_reg,
> +                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
> +                   uint32_t type, uint8_t fc, uint8_t mod)
> +{

[ snip ]

> +
> +    /* fetch protected key from param block */
> +    for (i = 0; i < keysize; i++) {
> +        addr = wrap_address(env, param_addr + i);
> +        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
> +    }
> +    /* 'decrypt' the protected key */
> +    for (i = 0; i < keysize; i++) {
> +        key[i] ^= protkey_xor_pattern[i];
> +    }

Think about outsourcing this into a function as it would improve 
readability and reduce code dublication in future commits.

> +
> +    /* expand key */
> +    if (mod) {
> +        AES_set_decrypt_key(key, keysize * 8, &exkey);
> +    } else {
> +        AES_set_encrypt_key(key, keysize * 8, &exkey);
> +    }

[ snip ]


