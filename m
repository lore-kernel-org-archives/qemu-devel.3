Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6698FCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCA7-0001jM-50; Thu, 18 Jun 2026 08:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fcallies@linux.ibm.com>)
 id 1wa5vy-0002HO-Pw; Thu, 18 Jun 2026 02:09:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fcallies@linux.ibm.com>)
 id 1wa5vw-0004FY-Uc; Thu, 18 Jun 2026 02:09:02 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HHmQvO1016585; Thu, 18 Jun 2026 06:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hZPlTK
 l7Ug3lJ4AFx76UQ3qjGuHiXsBYeW8HCL//Ksw=; b=Jr5O9j6p+BtngCIzoDBkZS
 ww0Tqi/hNmrcSgpOt5nywlFIx9pOBMrdCsK1o0bBaOTLS2AArfxw1WJwfEFE32gB
 enze9S23M9pe5TFfuWtxBG2TdfuxIGjtYUb6V8z8GmdB0QSOgdoiZwAfeQ9ig9CQ
 ffKP5hjLcMDul7Nlxk6FiECxj7A3BCf1UxCPyRmWFiyS4Vk2o43fd5LQqfdBK8ao
 +CC4aofT2xd/zYQaeQ45sdhsgUmmNJGft6vsYy/gyshkyaKXCTzjKPKOA9xtUV10
 Xlf6yite9rlrWc9Be3tGDYOgl0FOnnJGJkslJbMcC/USdAQ/mzkAgeMmwfe8YpcQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxegjp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 06:08:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I64fCT031398;
 Thu, 18 Jun 2026 06:08:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172a9dw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 06:08:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65I68qt89961964
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jun 2026 06:08:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA15E2004B;
 Thu, 18 Jun 2026 06:08:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7775520043;
 Thu, 18 Jun 2026 06:08:52 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jun 2026 06:08:52 +0000 (GMT)
Message-ID: <cc246d3d-0436-4d23-b2ce-0fdd000c0490@linux.ibm.com>
Date: Thu, 18 Jun 2026 08:08:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/17] target/s390x: Support protected key AES CBC for
 cpacf kmc instruction
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 iii@linux.ibm.com, david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-12-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-12-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a338b79 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=E6Shn9zuVhdXiWxorOUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1MSBTYWx0ZWRfX0/S1jxyMWdmp
 PLLQCxWOaPrWhaNOHTqfk+qp9NDolfix/Ir7O+0dfGsO2pCggpRrJNeOIOMc0RBo4lqHoGEm3g1
 PTdoCIXBGSZQQxhxS71i2Kwdya7bthXpALCdKe6yng2J9TmWo6FZakVNwsQVwJX87eJXi4+5C9C
 MgTdqf3WKp/vhuE4H4oGWk2qpPJ4fgI1CW8o5j9pmYvmTbOqtjLMq7adQ4/VIoyqcOecYsyOjI9
 /QVdNd+Gw40hW/rOKKZOdSpEoxcbmKuC6kdwQKGHkrjOTVXLH2afunpYlwnEFY4DVlWIbMFBXR0
 dEZt9zu7JyIrhkaTa4VqQhO1Tf3u/ebszpV82Mk6BSlMYGv5+9KxW9y51Wk9vlhLRDDt7bdsTwL
 GTHbJW8sSjC4HySbS/n/lWbDdLIvUSR6pvrW5TfdjZTABvqxz1COE8n/3dlRkIPJuOpg5SnDOf4
 B9DfiUefgX1XSdjT+XQ==
X-Proofpoint-GUID: k2KgRmRlpZRBFmARJdd1V8gazSsYH7gJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1MSBTYWx0ZWRfX5XNPHUcLOS5M
 gykAhxeS3AXvi0soQzRHU85n64I9+Pa3zWY4zDvcSRDsuzIUSCEFk0DxLKBh5NxXWFwCsqy65BW
 AJATGGrAgEMTlBEVPVOQ0YLjp4yDDWA=
X-Proofpoint-ORIG-GUID: k2KgRmRlpZRBFmARJdd1V8gazSsYH7gJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
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
> Support the subfunctions CPACF_KMC_PAES_128, CPACF_KMC_PAES_192
> and CPACF_KMC_PAES_256 for the cpacf kmc instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>

With the suggested changes:

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

> ---
>   target/s390x/gen-features.c      |   3 +
>   target/s390x/tcg/cpacf.h         |   4 ++
>   target/s390x/tcg/cpacf_aes.c     | 109 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |   7 ++
>   4 files changed, 123 insertions(+)
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 71e0e41d6e..074c53aecd 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -932,6 +932,9 @@ static uint16_t qemu_MAX[] = {
>       S390_FEAT_KMC_AES_128,
>       S390_FEAT_KMC_AES_192,
>       S390_FEAT_KMC_AES_256,
> +    S390_FEAT_KMC_EAES_128,
> +    S390_FEAT_KMC_EAES_192,
> +    S390_FEAT_KMC_EAES_256,

Again, either EAES -> PAES or EAES -> ENCRYPTED_AES

>       S390_FEAT_KMCTR_AES_128,
>       S390_FEAT_KMCTR_AES_192,
>       S390_FEAT_KMCTR_AES_256,

[ snip ]

> diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
> index bcfcf3b660..a6487261e1 100644
> --- a/target/s390x/tcg/cpacf_aes.c
> +++ b/target/s390x/tcg/cpacf_aes.c
> @@ -620,3 +620,112 @@ int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>   
>       return !len ? 0 : 3;
>   }
> +
> +int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> +                   uint64_t param_addr, uint64_t *dst_ptr_reg,
> +                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
> +                   uint32_t type, uint8_t fc, uint8_t mod)
> +{

[ snip ]

> +    /* fetch protected key from param block */
> +    for (i = 0; i < keysize; i++) {
> +        addr = wrap_address(env, param_addr + AES_BLOCK_SIZE + i);
> +        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
> +    }
> +    /* 'decrypt' the protected key */
> +    for (i = 0; i < keysize; i++) {
> +        key[i] ^= protkey_xor_pattern[i];
> +    }

You would already benefit from the suggested outsourcing.

> +
> +    /* expand key */
> +    if (mod) {
> +        AES_set_decrypt_key(key, keysize * 8, &exkey);
> +    } else {
> +        AES_set_encrypt_key(key, keysize * 8, &exkey);
> +    }

[ snip ]


