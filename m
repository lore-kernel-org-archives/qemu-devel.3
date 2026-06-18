Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDC2CD98F3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCA9-0001jm-47; Thu, 18 Jun 2026 08:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fcallies@linux.ibm.com>)
 id 1wa5xZ-0002bz-Q0; Thu, 18 Jun 2026 02:10:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fcallies@linux.ibm.com>)
 id 1wa5xY-0004qS-6k; Thu, 18 Jun 2026 02:10:41 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HHnSqx1252740; Thu, 18 Jun 2026 06:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=aT49/h
 MJ/p2b3FraIWCSy+o0QKz1ZeS+z+5NDmYGqR8=; b=IGTIBg4uBPmsFsfrgE8aXK
 0ooWzZIOovDj5fMkKVQt3nEOw9aC9q4EANSWSEBdSv2SnKHr9EXGLWPd/dOI10cA
 Y/uDWH9+/wk7tduCGhaZsw7w9i7AnBSKB6SVQQse5UNyG2jdvwbifjKawD8GcdbQ
 Rhpjy5U598HyV82ncRTL5KYx/EAkVnqtkHdAq1opvhQg4kvjmvWI/BCRdlQSxrlf
 I7EFjJtrn0QEcdZ6vEq3RnmBjtItQfEkZdtk+mJfmcQWqDjaCicXw5uL0TO430BN
 /stbE7lCb7/8/888dN8dVZ8BHvRxiuwpM0ExlMAxb49LSIcKE93QOLHP6ynZb0SQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequ6m49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 06:10:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I64a42019496;
 Thu, 18 Jun 2026 06:10:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1722a18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 06:10:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65I6AWYv40698172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jun 2026 06:10:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C17820043;
 Thu, 18 Jun 2026 06:10:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB4A820040;
 Thu, 18 Jun 2026 06:10:31 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jun 2026 06:10:31 +0000 (GMT)
Message-ID: <1cf46c18-6b80-415a-bcb8-cb68dea6b69e@linux.ibm.com>
Date: Thu, 18 Jun 2026 08:10:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/17] target/s390x: Support protected key AES CTR for
 cpacf kmctr instruction
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 iii@linux.ibm.com, david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-13-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-13-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1MSBTYWx0ZWRfX18omDHCqNMbY
 zHE5nnNd61A0kj0fX+oZkZmYXuZYpd/NL/YdoK3OTLstxh/AW46aCFN633SNFGiQw/DJOW+JeU8
 HsaOXYVi7mZf4vn/Qv2a053LEUhXFA4=
X-Proofpoint-ORIG-GUID: DM1-KtslAz70RAPZXXHfhhVARsHIeAuJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1MSBTYWx0ZWRfX0Dw7sPHk8aM3
 ycWkxHcMRmnRZUICjI8OyT1T6ej3IJaDXWTL59kIj85miFSXjB/xGNE0SoDHCGMfN944wSZqr2k
 PDM5XwSnzM7pHS27uA0o1swsvh3MnkSZQmwsIdm91+byUe6uM31gdfWdvnUp9ZUCgWU1Z7lWLru
 wcmTwg/w15E8yfHJuTNHTphdFxgtLsYozkPylPkmNk+PQ7aFqHIdVMosal710kQPOpSWNPgEQe0
 mPFZtUZJDejtw17sCivztSxUPHt592z4iQb1KCa0mb7yjQ1BTmpHtk8XwPs3iXhBlNqJw0cACLJ
 TKldMzVjotp34q1wAN3Ux3dnQ6hx2Q5STOQT/N1vGcInkVHq0ko3XMo3vEjPXum0pm0RkD0Atae
 vjaBXXqTetwqoVkDghr9HAToDfAh+drTk2YzY67yAcwNE2p6cgdyhUtrMMFnRNcq8ha/RXDQGjp
 UHI8mSLL9GcluHXZqlA==
X-Proofpoint-GUID: DM1-KtslAz70RAPZXXHfhhVARsHIeAuJ
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a338bdc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=UP5xVGQBSjxHt9vJOV8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180051
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=fcallies@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
> Support the subfunctions CPACF_KMCTR_PAES_128, CPACF_KMCTR_PAES_192
> and CPACF_KMCTR_PAES_256 for the cpacf kmctr instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |  3 ++
>   target/s390x/tcg/cpacf.h         |  5 ++
>   target/s390x/tcg/cpacf_aes.c     | 90 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  7 +++
>   4 files changed, 105 insertions(+)
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 074c53aecd..4a131dc191 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -938,6 +938,9 @@ static uint16_t qemu_MAX[] = {
>       S390_FEAT_KMCTR_AES_128,
>       S390_FEAT_KMCTR_AES_192,
>       S390_FEAT_KMCTR_AES_256,
> +    S390_FEAT_KMCTR_EAES_128,
> +    S390_FEAT_KMCTR_EAES_192,
> +    S390_FEAT_KMCTR_EAES_256,

EAES -> PAES or EAES -> ENCRYPTED_AES

>       S390_FEAT_PCC_XTS_AES_128,
>       S390_FEAT_PCC_XTS_AES_256,
>       S390_FEAT_PCKMO_AES_128,

[ snip ]

> diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
> index a6487261e1..ffa286d422 100644
> --- a/target/s390x/tcg/cpacf_aes.c
> +++ b/target/s390x/tcg/cpacf_aes.c
> @@ -729,3 +729,93 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>   
>       return !len ? 0 : 3;
>   }
> +
> +int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> +                   uint64_t param_addr, uint64_t *dst_ptr_reg,
> +                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
> +                   uint64_t *ctr_ptr_reg, uint32_t type,
> +                   uint8_t fc, uint8_t mod)
> +{

[ snip ]

> +    /* fetch protected key from param block */
> +    for (i = 0; i < keysize; i++) {
> +        addr = wrap_address(env, param_addr + i);
> +        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
> +    }
> +    /* 'decrypt' the protected key */
> +    for (i = 0; i < keysize; i++) {
> +        key[i] ^= protkey_xor_pattern[i];

Outsourcing if you see a benefit.

> +    }
> +
> +    /* expand key */
> +    AES_set_encrypt_key(key, keysize * 8, &exkey);

[ snip ]


