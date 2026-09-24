Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05458C98304
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 04:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9awY-0002Aa-QR; Thu, 24 Sep 2026 00:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1x9awT-00029E-K1; Thu, 24 Sep 2026 00:20:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1x9awP-0004L4-SL; Thu, 24 Sep 2026 00:20:16 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O2aAMn976694; Thu, 24 Sep 2026 04:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YUdzT6
 4n65fr8vMqpMInufP4ueXVSv3Zb7b0W9/pXf8=; b=qFDQluc+250xDmFkyo4miN
 Yva7Odkioq8yzEtyM0uzr1kJifKapIaKwO9pc5CWRLTvKd0eRDcRc1737daD/Ux8
 I8xZvuqvSmCPYRXCWg6vkpAFJCJT7o5ooNk5uT69mIJ1vXLMYUkFTo4YNb7on9oC
 vY+CAyLGaiQ0i5q2LB1B3LKRT5hVpyHztGxj8Rg88lKXJvjDhlmDfaaTcqUf+wuk
 yvzGJU02wOxQrUR0yzNhLQFnHMRfJ2p6byRuvhHRtJyUsunMtvgT9cvEhkqgay4t
 nAULsjFjBmDuWkcnC2bVP6bOmfuI6gY6Jcqa3tth+BEgN/h12kryVGvFCLIQeLLg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdveapp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 04:19:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O2IVJs1317730; Thu, 24 Sep 2026 04:19:58 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1v1xj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 04:19:58 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68O4JunH15205114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 04:19:57 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3DC55805A;
 Thu, 24 Sep 2026 04:19:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 063045803F;
 Thu, 24 Sep 2026 04:19:54 +0000 (GMT)
Received: from [9.123.9.22] (unknown [9.123.9.22])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 04:19:53 +0000 (GMT)
Message-ID: <a5355ab8-bafe-4c1e-989b-dcb05ec1fca3@linux.ibm.com>
Date: Thu, 24 Sep 2026 09:49:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] ppc: Raise decrementer IRQ on zero write
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Kirill A. Korinsky" <kirill@korins.ky>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Amit Machhiwal <amachhiw@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>
References: <20260903115229.95811-1-kirill@korins.ky>
 <20260903115229.95811-3-kirill@korins.ky>
 <3cc35c1e-febf-4ea7-94d2-e9191bc4acb8@ilande.co.uk>
Content-Language: en-GB
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <3cc35c1e-febf-4ea7-94d2-e9191bc4acb8@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: z6OEzBHXycuvl-IfCwUVssm6wDx0Y2tS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAxOCBTYWx0ZWRfX/OQnL0Q/waZ/
 zbtEi1ft8zuolzt0Tt0G4DBLRZRDU/G9YGY6on4r79erK3TR1J1QC3rtkUOJNJiCVd/HhD1hrHE
 bp1hnNtJrBbHGL79/rrdzIn7WbYZlcU=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab4a4ef cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=ug1x1TSWlDlFpk69nW4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NMEYJ8DE7MgG3Y2rsOqfZJJtj3Xc-Dzs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAxOCBTYWx0ZWRfX8b5hyW4hWVPG
 Tvtm9Meo67yN4RIymXUL8CT9pAUeS9kO4w4vgzoMT1/GF0XUcEb+juCuMQ6pDmICW7YY+t759yX
 JZ2Y8u2COMcXVClVsJTuUqARpvgM6Y4SDl+5scNh3P0jlu6sz4VxFXLtw5/rJGFi4Fx1BTYGS8U
 dEBEDKXcboDNPIGSGFsuPOBZ95+J3RDdLx1XXAU8TKCWYENB3sTrd2JONfPVBBvIlAM2Q/Hv4la
 1Pd9xOgbQkmRoUSr/OMM4T4qhuiyQ4GTXEJVvaltguaJNc+sfZ2as++q0atQaJiFVWmcuNaghts
 GBQsoUNxSCPNzpaC62ksV4gXQa91VdEYWuBuQVW2aT0SvIP6RS89FmoyUOZQFOIGiXbqn4sfRbi
 nFHwT/yEOyd/qtL4mYlWR++eQeuLJIrQVeFFFmcWZtVBtCSYVovwYgqq/R+NhrBcNHSY1eZAkXI
 pRWIfGTG/iYqujt0+pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240018
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

Hi Mark,

On 18/09/26 6:49 pm, Mark Cave-Ayland wrote:
> On 03/09/2026 12:50, Kirill A. Korinsky wrote:
> 
>> OpenBSD writes zero to an edge triggered decrementer, then enters idle
>> expecting its interrupt. QEMU defers the already due edge to a timer at
>> the current virtual time, leaving the guest stalled.
>>
>> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
>> ---
>>   hw/ppc/ppc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
>> index b123b4cc1c..d99e47d532 100644
>> --- a/hw/ppc/ppc.c
>> +++ b/hw/ppc/ppc.c
>> @@ -885,6 +885,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, 
>> int64_t now, uint64_t *nextp,
>>        * an edge interrupt, so raise it here too.
>>        */
>>       if (((flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
>> +        ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && value == 0) ||
>>           ((flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
>>             && signed_decr >= 0)) {
>>           (*raise_excp)(cpu);
> 
> LGTM, however since this is core PPC code I'd like a R-B tag from the 
> main PPC maintainers above. Chinmay/Harsh?

Thanks for your review feedback on this series.
Chinmay is on vacation till next week and I had asked Amit and Anushree
offline to provide their review/test feedback on this (considering this
2/5 generic change). I see Kirill has posted v2 based on Amit's review
feedback now. Since it is going to land in 11.2, I think we can give it
a little more time for review feedback (if any), before pulling it in
along with other PPC patches. Let me know if any other concerns? Thanks!

regards,
Harsh
> 
> 
> ATB,
> 
> Mark.


