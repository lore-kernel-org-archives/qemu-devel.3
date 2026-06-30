Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEC3C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 05:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weRGY-0000sU-8a; Tue, 30 Jun 2026 01:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1weRGT-0000rj-9J; Tue, 30 Jun 2026 01:44:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1weRGR-0008Pf-1s; Tue, 30 Jun 2026 01:44:09 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U1J6TB604849; Tue, 30 Jun 2026 05:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VIbXXr
 AV4Mx/uegbGyPP1sNug65VX/GQacgHTmN60Cw=; b=oeGPgLQUE/LDQVhQEBtIAI
 7JjgV+J/hDWTUr+Zz+HGaQxk8QNKVV3ZEhJZOQQRvfF7/8nQmuP/oDNa4koz9hHi
 btQbaYpNxkHJlxo2bO5wO1utPomo9hva9Fzrbod06BFkKkavzXWrBDRouD4E4XIf
 VVgkYOD/KD1t+WxSjLWrDxZdTWrJmw4upHdNdfTXa0WkqD3w85HFMb6XKLHaRKWn
 QYLIw7S7oP3XASzuq5tNy1kl7CP9maETpfpkiDN6hw/nmX+KThFm+HIo7WR5FYqv
 U+bUVOdGB7WlaFZG2k31eEdXdfr//yjZg0u8sXw3CikqfTO4t4ZE6XcveeuqN/Ag
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5n0cp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 05:44:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65U5PMae007914;
 Tue, 30 Jun 2026 05:44:00 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbh8m81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 05:44:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65U5hx1T24445550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 05:43:59 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2778C58054;
 Tue, 30 Jun 2026 05:43:59 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02C8C58062;
 Tue, 30 Jun 2026 05:43:51 +0000 (GMT)
Received: from [9.124.209.153] (unknown [9.124.209.153])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 30 Jun 2026 05:43:50 +0000 (GMT)
Message-ID: <cdc5c7dd-ced8-4aaf-aac4-8c7be60795d6@linux.ibm.com>
Date: Tue, 30 Jun 2026 11:12:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/28] target/ppc: Moving instructions to decodetree
 specification
To: milesg@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 npiggin@gmail.com, harshpb@linux.ibm.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, stefanha@redhat.com
Cc: vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 sv@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <285fdd30-f22d-4d4b-b8ee-5f04fccfca6d@linux.ibm.com>
 <4ef1791085a32802185b2c68686aab273f4dfcbd.camel@linux.ibm.com>
 <f96c5fde-b4d6-48ee-8778-7255ecb3236e@linux.ibm.com>
 <1c2a47848384c57ceb2d2ed929d3ccdf16d72ed3.camel@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <1c2a47848384c57ceb2d2ed929d3ccdf16d72ed3.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA0MiBTYWx0ZWRfXwjc3ouOkVPdM
 a983+talfzckTbVaBgHa6KgIi8M99rw83mY7sJwBot56snnxWhYD5/D4RamI6HyIZtRyhLRR/Tc
 rTtTl8wz8ZkiQhW9xnHTm9DzLLR5eeC4i3v+0GRwxI89TpO9LrIfoSGp9fZjk8uDzMf8sECUUex
 wxIy8U4LzPIoG6q0QFJ1cPh6K5o25bUQ2ivTIanUjwdUiSgDtvaii9gOaDwnlKzdPQLpstvsNqx
 D3F0li7cUqYznLO/zuqc4RJm8LiKyS3wMT2jyrwPJy0GKgfc03Xtg7r3OsvdJQLBtqyE+w29NpB
 46nEIGXRIvlU7ai+i281poPAZ9OU6/Qyzl2KTD2qbN8yYB+EThmIcgecP63mMrwG8WixKrFJDlI
 uKuZ0MbYgrec77SeQH8DbwF9r7GXfG4cILKWH517Bf72f1aMNLEL54xOyE8OBZ4ae3CniK7NoS1
 hJqIu7YyJldatplrZlg==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a4357a2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8
 a=TgFuzEOzGliqHDKaYHMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: L9A55C9FUqeqQ3fDbVBH6txRBLiFcn7F
X-Proofpoint-GUID: O9dRDu0tcv-yODFzwdHjIk4ETjoIHDtu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA0MiBTYWx0ZWRfX+iISpYzWehUz
 1c6lysX7z6rUbN/2OqBCQ3p5Wa5AbhF44Lmh7D0/qA1kxHb4TUq/Iq9vnUhrrXz3sWQO1u2ukYu
 ENlNzPo7bvM/1KQIDXsNknSyKKIjHCc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300042
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


On 6/12/26 00:48, Miles Glenn wrote:
> On Thu, 2026-06-04 at 15:59 +0530, Chinmay Rath wrote:
>> On 6/3/26 19:40, Miles Glenn wrote:
>>> On Wed, 2026-06-03 at 17:09 +0530, Chinmay Rath wrote:
>>>> On 5/20/26 21:37, Chinmay Rath wrote:
>>>>> We recently had a QEMU decodetree hackathon at our org focusing on moving
>>>>> instructions to decodetree specification. I have consolidated the patches
>>>>> generated out of this effort in this series. Though I have done a round
>>>>> of review on all of them, might share some more review comments later.
>>>>>
>>>>> The checkpatch.pl script emits false error for a couple of patches which
>>>>> are of the following nature :
>>>>>
>>>>> TRANS(STWAT, do_st_atomic, DEF_MEMOP(MO_UL))
>>>>>
>>>>> static bool trans_LDAT(DisasContext *ctx, arg_LDAT *a)
>>>>>                                                        ^
>>>>> I see this happening in the last pointer argument in function
>>>>> definitions after macros (like TRANS(..) in this case).
>>>>>
>>>>> Richard, Peter, Stefan,
>>>>> Could you please advise if it would be okay to have the above false
>>>>> positive in the patches ?
>>>> Hi Chao,
>>>> I was wondering if you would be able to advise a way forward for this
>>>> checkpatch issue ? TIA.
>>>>> Gitlab CI: https://gitlab.com/rathc/qemu/-/pipelines/2540725424
>>>>> Please note that check-python-tox and migration-compat-aarch64 from CI
>>>>> fails in the upstream master branch as seen in the following:
>>>>> https://gitlab.com/rathc/qemu/-/pipelines/2537246569
>>>>>
>>>>> Thanks,
>>>>> Chinmay
>>>> Hi Glenn,
>>>> If possible, would you like to have a look at this series when you get a
>>>> chance ? TIA.
>>> Hi Chinmay,
>>>
>>> First, I'd like to thank you and everyone that worked on this for their
>>> efforts!  This seems like one of those tasks that everyone knows is
>>> needed but everyone would rather work on other more interesting things
>>> (myself included).  I would like to take a look at this series when I
>>> get the chance.  I do have a lot on my plate right now, but hopefully I
>>> can get to it in the next week or so.
>>>
>>> Thanks,
>>>
>>> Glenn
>> Sure Glenn, thanks !
> I had a little time to look over the changes today and I didn't see any
> major issues.  I did notice that the change, "Refactor sleep and its
> variants to use a common helper", didn't seem related to moving things
> into decodetree, so maybe that should be reviewed separately?  There
> was also a lot of moving of implementation code out of translate.c into
> more specific files, like fixedpoint-impl.c.inc.  This didn't seem
> required in order to use decodetree either, so perhaps those changes
> should be split out into another patch?
>
> Otherwise, I think it looks pretty good.
>
> Thanks,
>
> Glenn
Thanks for going through this Glenn !
I shall mention in the cover letter that some patches in the series 
facilitate the movement instead of purely doing the movement (like the 
"Refactor sleep and its variants to use a common helper" patch). Would 
that be okay to you ?

The movement of instructions from translate.c to specific files along 
with their decodetree movement is something that has been traditionally 
in all older decodetree movement patches, so that is something that's 
expected IMO.

Thanks,
Chinmay
>
>
>> -Chinmay
>>>> Thanks,
>>>> Chinmay
>>>>> Aboorva Devarajan (3):
>>>>>      target/ppc: Move vector merge instructions to decodetree
>>>>>      target/ppc: Move vector pack instructions to decodetree
>>>>>      target/ppc: Move GPR atomic load/store instructions to decodetree
>>>>>
>>>>> Amit Machhiwal (2):
>>>>>      target/ppc: Move fixed-point Shift insns to decodetree
>>>>>      target/ppc: Move fixed-point byte-reversal store insns to decodetree
>>>>>
>>>>> Mukesh Kumar Chaurasiya (IBM) (2):
>>>>>      target/ppc: convert slw,srw instruction via decode spec
>>>>>      target/ppc: convert sraw[i] instruction via decode spec
>>>>>
>>>>> Nikhil Kumar Singh (3):
>>>>>      target/ppc: Migrate extswsli to decodetree
>>>>>      target/ppc: Migrate atomic loads to decodetree
>>>>>      target/ppc: Convert cache instructions to decodetree
>>>>>
>>>>> Ojaswin Mujoo (7):
>>>>>      target/ppc: Move isync instruction to decodetree.
>>>>>      target/ppc: Convert b{a, l, la} to decode tree
>>>>>      target/ppc: move various conditional branch insns to decodetree
>>>>>      target/ppc: Fix TRANS* macro variadic arguments handling
>>>>>      target/ppc: Move wait instruction to decodetree
>>>>>      target/ppc: Move sleep & friends to decodetree
>>>>>      target/ppc: Refactor sleep and its variants to use a common helper
>>>>>
>>>>> Shivang Upadhyay (4):
>>>>>      target/ppc: Move Condition Register access instructions to decodetree.
>>>>>      target/ppc: Move Condition Register logical instructions to
>>>>>        decodetree.
>>>>>      target/ppc: Move Fixed-Point Load/Store String instructions to
>>>>>        decodetree.
>>>>>      target/ppc: Move VMX integer arithmetic and BCD instructions to
>>>>>        decodetree.
>>>>>
>>>>> Shivani Nittor (1):
>>>>>      target/ppc : Convert mcrf to decode tree
>>>>>
>>>>> Tanushree Shah (2):
>>>>>      target/ppc: Move rlwimi, rlwinm instructions to decodetree
>>>>>      target/ppc: Move lmw, stmw instructions to decodetree
>>>>>
>>>>> Utkarsh Verma (1):
>>>>>      target/ppc: Move st{b, h, w, d, q}cx instructions to decodetree
>>>>>
>>>>> Vishal Chourasia (3):
>>>>>      target/ppc: Move mfmsr, mtmsr[d] instructions to decodetree
>>>>>      target/ppc: Move byte-reverse instructions to decodetree
>>>>>      target/ppc: Move system call and rfi instructions to decodetree
>>>>>
>>>>>     target/ppc/helper.h                           |  100 +-
>>>>>     target/ppc/insn32.decode                      |  244 ++
>>>>>     target/ppc/int_helper.c                       |   76 +-
>>>>>     target/ppc/internal.h                         |    7 -
>>>>>     target/ppc/mem_helper.c                       |   18 +-
>>>>>     target/ppc/tcg-excp_helper.c                  |   10 +-
>>>>>     target/ppc/translate.c                        | 2592 ++++-------------
>>>>>     target/ppc/translate/branch-impl.c.inc        |  181 ++
>>>>>     target/ppc/translate/fixedpoint-impl.c.inc    |  936 ++++++
>>>>>     target/ppc/translate/misc-impl.c.inc          |  175 ++
>>>>>     .../ppc/translate/processor-ctrl-impl.c.inc   |   30 +
>>>>>     target/ppc/translate/storage-ctrl-impl.c.inc  |  117 +
>>>>>     target/ppc/translate/vmx-impl.c.inc           |  360 +--
>>>>>     target/ppc/translate/vmx-ops.c.inc            |   41 -
>>>>>     14 files changed, 2529 insertions(+), 2358 deletions(-)
>>>>>
>

