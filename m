Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FA9C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 10:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiV1b-0002JQ-K9; Sat, 11 Jul 2026 06:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wiV1Z-0002DT-Kr; Sat, 11 Jul 2026 06:33:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wiV1Y-0001LY-1m; Sat, 11 Jul 2026 06:33:33 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66B7BrsG364697; Sat, 11 Jul 2026 10:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RrDYf/
 qNCiPK+CrJPPw8yeiPATUnlsOUmW3TqGKgbfg=; b=i/Ejf9pcKrSsHOX4V8sVKn
 rvgTRi9EHOxqvmrE10sblnaO5up1T433bYQ0eQqJVMEC7AaN+Bb3CR1M25A8kQXg
 iDGiuP+Pbi/GlaqNZlByhRv6L1ORfye58SogkRSMmBpcpyl1d+FjpBowPAxuQnmD
 bg6iRb2tcxDuyXQYXFGCuPz4Sdg+CH5AAvlhe7wZQpV3zxEMFTrlSB3DEYBlC720
 YWIFvOoomW6dtnKd9Ubad8x7OFZUu2OvIZ/EsPdVtsHC5jE8O4au5ubNXWb0n8eg
 kB4EpWlZVClgDzbZtXAYAyv/MfMsKoKsleyg79tflBSpX7+GyoUMu2XXBWdH2uNw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegb8vfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 11 Jul 2026 10:33:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66BAJl1J018100;
 Sat, 11 Jul 2026 10:33:25 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6ynrrx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 11 Jul 2026 10:33:25 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66BAXNgU2491338
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 11 Jul 2026 10:33:24 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D964058054;
 Sat, 11 Jul 2026 10:33:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA6D158052;
 Sat, 11 Jul 2026 10:33:19 +0000 (GMT)
Received: from [9.124.217.8] (unknown [9.124.217.8])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 11 Jul 2026 10:33:19 +0000 (GMT)
Message-ID: <13b853cb-7943-46ff-8a38-2f8624d04641@linux.ibm.com>
Date: Sat, 11 Jul 2026 16:03:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 07/35] target/ppc: Implement watchpoint debug facility for
 v2.07S
Content-Language: en-GB
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <Harsh.Prateek.Bora@ibm.com>
References: <20230904090630.725952-1-clg@kaod.org>
 <20230904090630.725952-8-clg@kaod.org>
 <905b6448-d313-4808-b76b-d42f9ecfae55@oss.qualcomm.com>
 <0e1cc6c4-c403-42c8-9bb9-d6d5a658965f@kaod.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <0e1cc6c4-c403-42c8-9bb9-d6d5a658965f@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a521bf6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=pGLkceISAAAA:8 a=aow-egSQAAAA:8 a=BZWqBp3Lla1tp9cZoBsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDA5OCBTYWx0ZWRfXw5k7ecSmEUCs
 Kb0HiPhWhWPveAuXk49O6omM4E9xjzx4NuoetZest2Vj2z9LOf2ynNJrCwmUdH9H674Y6on2fv2
 NkkflmL5ULwAZstHDWnmcFBTGBKROEjyZ0hUtOqR2tPlGvYhfG59VvbffWTgvxjLrHF2aSXpFn5
 x9KKB3v7c2FjWChs35yU7LdVpKO+uwgxy3W9oWHx/6QmEN1H9WXb4Y5s0UNpAnb5Kpf7JBj+iTj
 p6/XmferS5SbJuQbTnVuCEWQpZ8AF5uDpR0LcTz/KX3ndJpQNMklN65ho0svjfmYesTkqEnFSDo
 u487GTW0OFXvpI2YfZi90dDQriarl61iIhAVsmNGPOZWGPoHOD+zoxOhc7VpUI1B4elsQ1sYKR7
 4Fg38teGFJAtChxlGxh5dGE+CRQ4CRViyfgbIibLHvxSDPrv07ZAcN3nvuyKIJcbjczu00wagWK
 CjrYtST9j1WXPndsxBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDA5OCBTYWx0ZWRfX1kuesSX1oF+d
 BWHpIgneQpODPME7lEX8dbOW5Rs4uGQF0V/nIEgSrL+FtQ/0ObUglA1PkNytj2duS67ObR4IPXV
 kwJl4gkFUBiv6dtzdQyUbbIrd8n2Hc4=
X-Proofpoint-GUID: m1VSR_UuaiqvgS5U1dNLruB2vhb_YBf1
X-Proofpoint-ORIG-GUID: fZcFuSy_afQw6578S9fJEEkmq1y12ZCY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607110098
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

+ Richard, Shiva

Hi Philippe, Cedric,

On 11/07/26 4:19 am, Cédric Le Goater wrote:
> + Harsh
> 
> On 7/11/26 00:07, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> (committed as d5ee641cfc5c3cbd51282d0c6e996f990b9d62a3)
>>
>> On 4/9/23 11:06, Cédric Le Goater wrote:
>>> From: Nicholas Piggin <npiggin@gmail.com>
>>>
>>> ISA v2.07S introduced the watchpoint facility based on the DAWR0
>>> and DAWRX0 SPRs. Implement this in TCG.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> ---
>>>   target/ppc/cpu.h         |  4 +++
>>>   target/ppc/helper.h      |  2 ++
>>>   target/ppc/internal.h    |  1 +
>>>   target/ppc/spr_common.h  |  2 ++
>>>   target/ppc/cpu.c         | 59 ++++++++++++++++++++++++++++++++++++++++
>>>   target/ppc/cpu_init.c    |  6 ++--
>>>   target/ppc/excp_helper.c | 52 ++++++++++++++++++++++++++++++++++-
>>>   target/ppc/machine.c     |  1 +
>>>   target/ppc/misc_helper.c | 10 +++++++
>>>   target/ppc/translate.c   | 13 +++++++++
>>>   10 files changed, 147 insertions(+), 3 deletions(-)
>>
>>
>>> diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
>>> index d9c665ce1819..62e1c15e3d33 100644
>>> --- a/target/ppc/cpu.c
>>> +++ b/target/ppc/cpu.c
>>> @@ -128,6 +128,65 @@ void ppc_store_ciabr(CPUPPCState *env, 
>>> target_ulong val)
>>>       env->spr[SPR_CIABR] = val;
>>>       ppc_update_ciabr(env);
>>>   }
>>> +
>>> +void ppc_update_daw0(CPUPPCState *env)
> 
> dawr0

I guess it was kept as daw0 since it considers both dawr0 and dawrx0.

> 
>>> +{
>>> +    CPUState *cs = env_cpu(env);
>>> +    target_ulong deaw = env->spr[SPR_DAWR0] & PPC_BITMASK(0, 60);
>>> +    uint32_t dawrx = env->spr[SPR_DAWRX0];
>>> +    int mrd = extract32(dawrx, PPC_BIT_NR(48), 54 - 48);
>>> +    bool dw = extract32(dawrx, PPC_BIT_NR(57), 1);
>>> +    bool dr = extract32(dawrx, PPC_BIT_NR(58), 1);
>>> +    bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
>>> +    bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
>>> +    bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
>>
>> Is it deliberate @sv and @pr are the same?
> 
> I think it's a typo. Should be 63. Harsh could you confirm please ?

Yes, It (pr) should have been 63. As per ISA 3.1:

61:63 PRIVM Privilege Mask
61 HYP Hypervisor non-ultravisor state
62 PNH Privileged Non-Hypervisor state
63 PRO Problem state

Shiva, Hope SV (supervisor) == PNH above ?

I see another patch in-flight modifying code in this routine from 
Richard for which I have comment, will post there.

Thanks for catching this.

regards,
Harsh>
> Thanks,
> 
> C.
> 


