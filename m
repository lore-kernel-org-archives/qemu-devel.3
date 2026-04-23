Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01558FC0340
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvRs-0005Sw-Sh; Thu, 23 Apr 2026 10:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFvRT-0005OH-Ox; Thu, 23 Apr 2026 10:54:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wFvRR-0007ty-Dk; Thu, 23 Apr 2026 10:54:11 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63N8Sxp73944125; Thu, 23 Apr 2026 14:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1w8rPk
 N68Hllhmji8xPINkudHjYhpvkVaAp8UVIsi08=; b=CRFJZfMqWHESBpAI8pZAXk
 1D+3lGSvWxQh69MYlW4eHHYj1WKCmibA4EwdC+J0SJc/te8kdJJEoaMx6RTn355v
 3MIGT85YTUkmzlrur8j9Y3WIFvEL3RZwVWj9LSC2KlSPQ4NvSRIm1105DBwhqcLV
 PRds8CUHXlkbZeJv/tP4zt06uESevKat6zR+dRxrZZb8GoquSspTedh4jJ2IUx1A
 Bm8cEcW81mv+RdqTsUNtHAtvXmkvAVs7mhli7yqEPvGUS0QwlNqjDZSZnA1pU9XP
 TTQnngPQ1EUWFaGuoFNDyh5UsBUKjLbhunEKDCCxSjDapuIJ2e/FWNo5qwyWmeZA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3rmk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 14:54:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NEoQ9J032509;
 Thu, 23 Apr 2026 14:54:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxy1fn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Apr 2026 14:54:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63NEs1ft52756862
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2026 14:54:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B88F2004B;
 Thu, 23 Apr 2026 14:54:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 495D520040;
 Thu, 23 Apr 2026 14:54:00 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.71.73])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Apr 2026 14:54:00 +0000 (GMT)
Message-ID: <e720de3f-01ca-48f8-a06a-133865bafb0f@linux.ibm.com>
Date: Thu, 23 Apr 2026 16:54:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] tcg: Include missing 'tcg/tcg-op-common.h' header in
 'tcg-op-mem.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>, qemu-stable@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260423135035.50126-1-philmd@linaro.org>
 <20260423135035.50126-2-philmd@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260423135035.50126-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NJjCKvjbi-4HwQO70vqccRPVho-RGbNf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0OCBTYWx0ZWRfXy5fSp7ICTlW9
 2RV0zgqFTFgTRS8QAm+dRp7leb3/sf04VkmeA+VytWLjzMVXYLNWVcL1UDldu3N0Ng4doITJxYh
 2+a5K5E6pEFiH/PqOOSoFQdu5CHMFqQOuph5JUbknUZk6aLj5ivr00X+Xbn1i58kN2F08q0n+om
 z/Jdhgea/kJnLsHl7Vc2Pc+6QwpQrnRhBiaI496ac8z8xy8qXW+f7INs6TGVwWuINwmNiRXgcWt
 Qo9NB6jR/Sneudre7p+UU1SYhPIZWVM7dMpy9vHLHL0EQ7MuRWBABk3ZtV1gfJllw68jJZMnN4l
 +mtIDWW8957S4SNQM1pXftzQQ5tyDLpyI1cCIBp8gPeutfu0HCcHQUxHWWp0tT79Ze/w+mLTwW/
 If2+RdyG65VUUqAbi7ngxhIHaWtwsFCKWwJ46ii7Pfou6Czt7rfM1FPDn8VLs9BYXzMil/EErvd
 FrH012943QNd+Crh5YA==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69ea328d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=69wJf7TsAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=oxOZ8elYhvzyzEPtyTMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: NJjCKvjbi-4HwQO70vqccRPVho-RGbNf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230148
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 4/23/26 14:50, Philippe Mathieu-Daudé wrote:
> "tcg-op-mem.h" uses methods declared in "tcg/tcg-op-common.h".
> Include the latter to avoid when including the former:
>
>    include/tcg/tcg-op-mem.h:34:5: error: call to undeclared function 'tcg_gen_qemu_ld_i32_chk'
>     34 |     tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
>        |     ^
>
>    $ git grep -w tcg_gen_qemu_ld_i32_chk
>    include/tcg/tcg-op-common.h:328:void tcg_gen_qemu_ld_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
>    include/tcg/tcg-op-mem.h:35:    tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
>    tcg/tcg-op-ldst.c:286:void tcg_gen_qemu_ld_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,
>
> Cc: qemu-stable@nongnu.org
> Fixes: a8af0fb24da ("include/tcg/tcg-op: extract memory operations to tcg-op-mem.h")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/tcg/tcg-op-mem.h | 2 ++
>   1 file changed, 2 insertions(+)
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

