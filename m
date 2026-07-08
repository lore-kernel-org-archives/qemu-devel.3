Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEAAC43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 11:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whQUc-0005p1-Sq; Wed, 08 Jul 2026 07:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1whQUZ-0005oX-RK; Wed, 08 Jul 2026 07:31:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1whQUX-0007EA-Lb; Wed, 08 Jul 2026 07:31:03 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6688INHg2738367; Wed, 8 Jul 2026 11:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WaSoWS
 eKuUT/50TViWJrOeEvhTMOUe7k6rdpMgRQ0pw=; b=n4NBuWJrwu7nWMeZkzRb1a
 3xXF93VGY1MvXoVSKmvskGcLnEJXcKKcxvvaSpfo29Jp6UFoEKaRIINRWwmfNQM2
 ns79KHVmgovO1qpFutH5uEFQ20B0z3lLd2C8dsHxG7tQQTNxv9gLPc6GQyMxsDuM
 rfz+ENJrojhCFWqhawh8FMxZ3EZm4c2jt/SXGMVrYtDeZ/iPppEi9a6XkSXJ57Tk
 i6Zow5eHz6s2c+YfyfpL4Ls1pAx0uNh1NMJN5njoLogli2SP1DQX3wgKW8z5jMIN
 wU3X68sJ3fLNi2+PXczkSbz3kMMRX1IkzYSXi/VfCm5Xfr4n7/bK0ntw0qAZ3JXg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3v6df-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 11:30:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668BJhVL025821;
 Wed, 8 Jul 2026 11:30:57 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgk7suy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 11:30:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 668BUuUi33555048
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jul 2026 11:30:56 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEAD45805B;
 Wed,  8 Jul 2026 11:30:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 931BE5805D;
 Wed,  8 Jul 2026 11:30:54 +0000 (GMT)
Received: from [9.39.26.49] (unknown [9.39.26.49])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jul 2026 11:30:54 +0000 (GMT)
Message-ID: <eee0b411-c573-49f6-a292-a253d43f6a79@linux.ibm.com>
Date: Wed, 8 Jul 2026 17:00:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/28] target/ppc: Moving instructions to decodetree
 specification
From: Chinmay Rath <rathc@linux.ibm.com>
To: milesg@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 npiggin@gmail.com, harshpb@linux.ibm.com
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <285fdd30-f22d-4d4b-b8ee-5f04fccfca6d@linux.ibm.com>
 <4ef1791085a32802185b2c68686aab273f4dfcbd.camel@linux.ibm.com>
 <f96c5fde-b4d6-48ee-8778-7255ecb3236e@linux.ibm.com>
 <1c2a47848384c57ceb2d2ed929d3ccdf16d72ed3.camel@linux.ibm.com>
 <cdc5c7dd-ced8-4aaf-aac4-8c7be60795d6@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <cdc5c7dd-ced8-4aaf-aac4-8c7be60795d6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4e34f3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8
 a=odoOnQTRXRCoAWh8_8gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDExMCBTYWx0ZWRfX3uCQD9Fn7AKo
 VJwHUhr44f9yXTcH6aKSNFm+UwoSszhDbUMWxAZin0S85i2pWHqNAC3azcKVM8mubMlgdYO/IJG
 acbc/kPejrjcSlj8TOyTdykiM330PWA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDExMCBTYWx0ZWRfX+nXoE1x4Ery7
 bU1CmM4X8wkpt7RHhm5hMbOiONNk1KDS6r+UYE1C0qSucE/JOEfREJjkvKApsFhooetSi/cBG/d
 XJQm7j1rgRhv0dW0m8NiAzHbs/s/PRhd+/dXFqvhlETUHnHs2Rl4PM0WaH8jvyPUP3+I26HK3M5
 bq+yuQOwd4PqLlgpAyWBfl/djD0z/zOqhj/78V9wCbddFt6g9nXXtLP6XFf6LLrjhVqmrTNgozx
 rBGvDrQ+CQfbVd3aPqVvInilBRbsyv3zjzp4vGnggAcuH7Ozgsho37bM05kRA/ODrsfXt6DeDmC
 N/oH4XCzgxmmNIyRjVb3Np1Tt8+5fl7R/6nDcgSVc8UK0vnGHQrhvu0jGHOFKjSsXzT3N1hnN9w
 n0Ev1ADmAWDjk/ATnNfpmdon8djauHqGE8hr9dgA8Wg5lHGUZt3AiUUz8YoXl4IVuLOALyc2JFs
 VdeT3GOCad0afTWrPyw==
X-Proofpoint-ORIG-GUID: n3u2dPyTmj7P-pEl_MFRfHqU0Iu-94yg
X-Proofpoint-GUID: uOEuYGtruwRBxUNOzVg8kehVOGLebltG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080110
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
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


On 6/30/26 11:12, Chinmay Rath wrote:
>
> On 6/12/26 00:48, Miles Glenn wrote:
>> On Thu, 2026-06-04 at 15:59 +0530, Chinmay Rath wrote:
>>> On 6/3/26 19:40, Miles Glenn wrote:
>>>> On Wed, 2026-06-03 at 17:09 +0530, Chinmay Rath wrote:
>>>>> On 5/20/26 21:37, Chinmay Rath wrote:
>>>>>> We recently had a QEMU decodetree hackathon at our org focusing 
>>>>>> on moving
>>>>>> instructions to decodetree specification. I have consolidated the 
>>>>>> patches
>>>>>> generated out of this effort in this series. Though I have done a 
>>>>>> round
>>>>>> of review on all of them, might share some more review comments 
>>>>>> later.
>>>>>>
>>>>>> The checkpatch.pl script emits false error for a couple of 
>>>>>> patches which
>>>>>> are of the following nature :
>>>>>>
>>>>>> TRANS(STWAT, do_st_atomic, DEF_MEMOP(MO_UL))
>>>>>>
>>>>>> static bool trans_LDAT(DisasContext *ctx, arg_LDAT *a)
>>>>>>                                                        ^
>>>>>> I see this happening in the last pointer argument in function
>>>>>> definitions after macros (like TRANS(..) in this case).
>>>>>>
>>>>>> Richard, Peter, Stefan,
>>>>>> Could you please advise if it would be okay to have the above false
>>>>>> positive in the patches ?
>>>>> Hi Chao,
>>>>> I was wondering if you would be able to advise a way forward for this
>>>>> checkpatch issue ? TIA.
>>>>>> Gitlab CI: https://gitlab.com/rathc/qemu/-/pipelines/2540725424
>>>>>> Please note that check-python-tox and migration-compat-aarch64 
>>>>>> from CI
>>>>>> fails in the upstream master branch as seen in the following:
>>>>>> https://gitlab.com/rathc/qemu/-/pipelines/2537246569
>>>>>>
>>>>>> Thanks,
>>>>>> Chinmay
>>>>> Hi Glenn,
>>>>> If possible, would you like to have a look at this series when you 
>>>>> get a
>>>>> chance ? TIA.
>>>> Hi Chinmay,
>>>>
>>>> First, I'd like to thank you and everyone that worked on this for 
>>>> their
>>>> efforts!  This seems like one of those tasks that everyone knows is
>>>> needed but everyone would rather work on other more interesting things
>>>> (myself included).  I would like to take a look at this series when I
>>>> get the chance.  I do have a lot on my plate right now, but 
>>>> hopefully I
>>>> can get to it in the next week or so.
>>>>
>>>> Thanks,
>>>>
>>>> Glenn
>>> Sure Glenn, thanks !
>> I had a little time to look over the changes today and I didn't see any
>> major issues.  I did notice that the change, "Refactor sleep and its
>> variants to use a common helper", didn't seem related to moving things
>> into decodetree, so maybe that should be reviewed separately? There
>> was also a lot of moving of implementation code out of translate.c into
>> more specific files, like fixedpoint-impl.c.inc.  This didn't seem
>> required in order to use decodetree either, so perhaps those changes
>> should be split out into another patch?
>>
>> Otherwise, I think it looks pretty good.
>>
>> Thanks,
>>
>> Glenn
> Thanks for going through this Glenn !
> I shall mention in the cover letter that some patches in the series 
> facilitate the movement instead of purely doing the movement (like the 
> "Refactor sleep and its variants to use a common helper" patch). Would 
> that be okay to you ?
>
> The movement of instructions from translate.c to specific files along 
> with their decodetree movement is something that has been 
> traditionally in all older decodetree movement patches, so that is 
> something that's expected IMO.
>
> Thanks,
> Chinmay
Hi Glenn,
Please do share if you have any further review comments. Please feel 
free to provide your R-by if you seem fit in any of the patches. Will 
help us expedite the review.

Regards,
Chinmay
>>
>>
>>> -Chinmay
>>>>> Thanks,
>>>>> Chinmay
>>>>>> Aboorva Devarajan (3):
>>>>>>      target/ppc: Move vector merge instructions to decodetree
>>>>>>      target/ppc: Move vector pack instructions to decodetree
>>>>>>      target/ppc: Move GPR atomic load/store instructions to 
>>>>>> decodetree
>>>>>>
>>>>>> Amit Machhiwal (2):
>>>>>>      target/ppc: Move fixed-point Shift insns to decodetree
>>>>>>      target/ppc: Move fixed-point byte-reversal store insns to 
>>>>>> decodetree
>>>>>>
>>>>>> Mukesh Kumar Chaurasiya (IBM) (2):
>>>>>>      target/ppc: convert slw,srw instruction via decode spec
>>>>>>      target/ppc: convert sraw[i] instruction via decode spec
>>>>>>
>>>>>> Nikhil Kumar Singh (3):
>>>>>>      target/ppc: Migrate extswsli to decodetree
>>>>>>      target/ppc: Migrate atomic loads to decodetree
>>>>>>      target/ppc: Convert cache instructions to decodetree
>>>>>>
>>>>>> Ojaswin Mujoo (7):
>>>>>>      target/ppc: Move isync instruction to decodetree.
>>>>>>      target/ppc: Convert b{a, l, la} to decode tree
>>>>>>      target/ppc: move various conditional branch insns to decodetree
>>>>>>      target/ppc: Fix TRANS* macro variadic arguments handling
>>>>>>      target/ppc: Move wait instruction to decodetree
>>>>>>      target/ppc: Move sleep & friends to decodetree
>>>>>>      target/ppc: Refactor sleep and its variants to use a common 
>>>>>> helper
>>>>>>
>>>>>> Shivang Upadhyay (4):
>>>>>>      target/ppc: Move Condition Register access instructions to 
>>>>>> decodetree.
>>>>>>      target/ppc: Move Condition Register logical instructions to
>>>>>>        decodetree.
>>>>>>      target/ppc: Move Fixed-Point Load/Store String instructions to
>>>>>>        decodetree.
>>>>>>      target/ppc: Move VMX integer arithmetic and BCD instructions to
>>>>>>        decodetree.
>>>>>>
>>>>>> Shivani Nittor (1):
>>>>>>      target/ppc : Convert mcrf to decode tree
>>>>>>
>>>>>> Tanushree Shah (2):
>>>>>>      target/ppc: Move rlwimi, rlwinm instructions to decodetree
>>>>>>      target/ppc: Move lmw, stmw instructions to decodetree
>>>>>>
>>>>>> Utkarsh Verma (1):
>>>>>>      target/ppc: Move st{b, h, w, d, q}cx instructions to decodetree
>>>>>>
>>>>>> Vishal Chourasia (3):
>>>>>>      target/ppc: Move mfmsr, mtmsr[d] instructions to decodetree
>>>>>>      target/ppc: Move byte-reverse instructions to decodetree
>>>>>>      target/ppc: Move system call and rfi instructions to decodetree
>>>>>>
>>>>>>     target/ppc/helper.h                           |  100 +-
>>>>>>     target/ppc/insn32.decode                      |  244 ++
>>>>>>     target/ppc/int_helper.c                       |   76 +-
>>>>>>     target/ppc/internal.h                         |    7 -
>>>>>>     target/ppc/mem_helper.c                       |   18 +-
>>>>>>     target/ppc/tcg-excp_helper.c                  |   10 +-
>>>>>>     target/ppc/translate.c                        | 2592 
>>>>>> ++++-------------
>>>>>>     target/ppc/translate/branch-impl.c.inc        |  181 ++
>>>>>>     target/ppc/translate/fixedpoint-impl.c.inc    |  936 ++++++
>>>>>>     target/ppc/translate/misc-impl.c.inc          |  175 ++
>>>>>>     .../ppc/translate/processor-ctrl-impl.c.inc   |   30 +
>>>>>>     target/ppc/translate/storage-ctrl-impl.c.inc  |  117 +
>>>>>>     target/ppc/translate/vmx-impl.c.inc           |  360 +--
>>>>>>     target/ppc/translate/vmx-ops.c.inc            |   41 -
>>>>>>     14 files changed, 2529 insertions(+), 2358 deletions(-)
>>>>>>
>>
>

