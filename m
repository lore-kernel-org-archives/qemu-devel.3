Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E65ECDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcOZz-0000b0-6W; Wed, 24 Jun 2026 10:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wcOZx-0000YX-VC; Wed, 24 Jun 2026 10:27:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wcOZw-0000dk-88; Wed, 24 Jun 2026 10:27:49 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OAmDmA866138; Wed, 24 Jun 2026 14:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hJt4dK
 njCWJ6d2W3W4/ZOpj8lSA9JGZY64FyiyDsSwY=; b=ilZekPwoAz04q4y58cQJjr
 Ebn+Pr+Ndfy2HtAgzflyindXFiVcfeG6jm4fraX0yolq8N4Vflh3ie5hiH+vnnr8
 uSyme/rjHeFb4gG2HKQcdXqtMI0+wnEhUmBGt3kg9ntmwjsbq/xWAVMjE2xU5gZn
 RiADmgtHpSVJ7iepTgGxMu8mBGydQd51QrmygBAUvwNvIDavOum6fBafQbPxYVLd
 2uO6OnCA6N5pUQNha9bLp0pKFtN4IZz1g8rR65SkF8qBjb5Vo19c0GAdH3Cpj4dA
 Jla32hcfwO4LjI5wc2jiUWgRHQV56wAa0/6eaz2qhKmI6E426rYDyq9ZQ1ZFylrg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqvkc7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 14:27:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OEJgNE025213;
 Wed, 24 Jun 2026 14:27:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k92c4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 14:27:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65OERbfs49349078
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 14:27:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 548F620043;
 Wed, 24 Jun 2026 14:27:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB85E20040;
 Wed, 24 Jun 2026 14:27:36 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.35.104])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jun 2026 14:27:36 +0000 (GMT)
Message-ID: <435a9a05-3779-44b6-8aae-3bbce5a2a7b6@linux.ibm.com>
Date: Wed, 24 Jun 2026 16:27:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/18] target/s390x: Rework s390 cpacf implementations
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-3-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260624081029.23815-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3be95f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=B6hoElRAeX7WwpK8Q9wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDExOSBTYWx0ZWRfX4dx62i+SlVAL
 TS/eOP/VBowuQtH3NMCcsvUxACPlorTkZehEauTkLbQ+flBTzzOslcRqT/9nyCqSTs0c4U7E6lR
 dOmh8jconfp8YhxAiiIrNFHHv2xuH3yansMGdLb5wnaW2tTUohQjSG6FDf4D3z1QsukKZBzNtgY
 qZQHYQ0Yc+12t3iUoGO3BRBmxgRSzPGCbZzLpld+XVraSc19R8apkgFtRbXql9Tb6l+MIyMakLt
 J+6XT7TynKYbysdfKxxdhjtrFONcTM2GE7q67GJhfn90KknDXmY/fyJIxbCcI2Vl8djOMZwPdtd
 JKaaF6gW74iapS0hfAiP8OXoW6sBpK6Xl4XSDVykmBaewaJzs/YdXs1zy6Z35qRarKOkmis2wm0
 LUPNcvAj5/RinBCebJLM5ZYuxhDJHw==
X-Proofpoint-GUID: pGXIhcMUK4hFTRXtLYrVo9WcXDdTCNVm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDExOSBTYWx0ZWRfX0k00TMhzr1XS
 mGibupaDZkbsgFNEsWM9qcGFKzDcxY+ZAhLkAE+7R69Ghc+Y5oTz2lj5QOetzR0BbL4W+W4RD/B
 3oaF+0auMFQlBnJYfiTFa43osGe/SrA=
X-Proofpoint-ORIG-GUID: pGXIhcMUK4hFTRXtLYrVo9WcXDdTCNVm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240119
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/24/26 10:09, Harald Freudenberger wrote:
> Fix missing parts for MSA 9 kdsa and rework the cpacf
> handling code so that further extensions can be made in
> a clean and structured way.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>   target/s390x/tcg/crypto_helper.c | 89 +++++++++++++++++++++++++++-----
>   target/s390x/tcg/insn-data.h.inc |  1 +
>   target/s390x/tcg/translate.c     |  2 +
>   3 files changed, 79 insertions(+), 13 deletions(-)
> 
> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
> index 29ad2aff43..f5189ce1c5 100644
> --- a/target/s390x/tcg/crypto_helper.c
> +++ b/target/s390x/tcg/crypto_helper.c
> @@ -272,6 +272,57 @@ static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>       }
>   }
>   
> +static int cpacf_kimd(CPUS390XState *env, const int mmu_idx, const uintptr_t ra,
> +                      uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
> +{
> +    int rc = 0;
> +
> +    switch (fc) {
> +    case 0x03: /* CPACF_KIMD_SHA_512 */
> +        rc = cpacf_sha512(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
> +                          &env->regs[r2 + 1], S390_FEAT_TYPE_KIMD);
> +        break;
> +    default:
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +    }
> +
> +    return rc;
> +}
> +
> +static int cpacf_klmd(CPUS390XState *env, const int mmu_idx, const uintptr_t ra,
> +                      uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
> +{
> +    int rc = 0;
> +
> +    switch (fc) {
> +    case 0x03: /* CPACF_KLMD_SHA_512 */
> +        rc = cpacf_sha512(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
> +                          &env->regs[r2 + 1], S390_FEAT_TYPE_KLMD);
> +        break;
> +    default:
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +    }
> +
> +    return rc;
> +}
> +
> +static int cpacf_ppno(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> +                      uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
> +{
> +    int rc = 0;
> +
> +    switch (fc) {
> +    case 0x72: /* CPACF_PRNO_TRNG */
> +        fill_buf_random(env, mmu_idx, ra, &env->regs[r1], &env->regs[r1 + 1]);
> +        fill_buf_random(env, mmu_idx, ra, &env->regs[r2], &env->regs[r2 + 1]);
> +        break;
> +    default:
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +    }
> +
> +    return rc;
> +}

I wonder if it would make sense to create separate op_kimd(), etc,
opcode handlers and make these new functions separate helpers.
Multiplexing in op_msa() and then de-multiplexing here looks like
busy work to me. That's of course out of scope of this series, so:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

[...]

