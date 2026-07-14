Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6116C4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 18:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjhxZ-0007W9-Ms; Tue, 14 Jul 2026 14:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjhxG-0007LC-Di; Tue, 14 Jul 2026 14:34:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjhxB-0002FF-Jw; Tue, 14 Jul 2026 14:34:04 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EGBcKF4103608; Tue, 14 Jul 2026 18:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=86qTFA
 K1/QdkfNqPUYdKEPTPi/W5jroQzWFJfYgCnnU=; b=N4xn3AUfTnUnQ6N2VovsgI
 LKjqB4PoBXs57PEaBCyHqedrZ4OX8VI80OJk6AR+B87RNbLIpTJvDihB9sMgRDMd
 13PTEbaniQEPX94zYvdwOnBfyf7ZcVJVyXo4bHJMFNaTWUcWbnNa5JwdqAJ2iR+R
 pPxgCDO8s74b8b9YQw8gUe2MizaQnsPWPC4SRi6qNkB8Bm3125ZzfI1JMJvodyXo
 LiQHUdX8JbFXY3r4RQ/em26M1KWH9yuNqbkDwXPETHlSkO+KFYWAx3HcdTXSu2wg
 /mcNpDS77OS8p+DIlJjd7tXM86gut5XOzjvWhlWz9cQsAi8DEoU5heu/UuSObxLw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv3389m9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 18:33:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EIJh4B007652;
 Tue, 14 Jul 2026 18:33:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhc3f3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 18:33:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EIXqGS47251926
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 18:33:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2AC320043;
 Tue, 14 Jul 2026 18:33:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A65C20040;
 Tue, 14 Jul 2026 18:33:52 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.27.233])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 18:33:52 +0000 (GMT)
Message-ID: <6006c93c-601b-48cc-ab8e-41b66b835fac@linux.ibm.com>
Date: Tue, 14 Jul 2026 20:33:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/51] cpu: Use interval-tree for CPUWatchpoint
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-19-richard.henderson@linaro.org>
 <9aed7950-405a-4414-a951-9d044a8c9d53@linux.ibm.com>
 <01b9590c-2243-46f8-8f5a-de3ba0709ad8@linaro.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <01b9590c-2243-46f8-8f5a-de3ba0709ad8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfX2QrKqIVCaCaC
 GbxJ+QMAflzsk6569+TE5l9S4ZsX2yR6rugH25WL2OfBwU2UI3v4hSe/AlP2eSKfH6Se5s+qfSv
 /YlOwIrJI1esSd2O0av9DXzR5v3UilM=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a568114 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=KKAkSRfTAAAA:8
 a=rPfxHH-IYxZcdQw-WsUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: NV6cL6hzN0ccdMUW4jG5FpzrfdFFr0_q
X-Proofpoint-ORIG-GUID: Umx8IPlZnFnj4932mjkz97vqEwyxSm3i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfXwaoq5LaDLfn6
 AScrOjpgVH5eBrIjAF7La2XaJa49OIgMz57hrVrzX3itfL/Y1M3+4Mghf9I5eSC0WOIBjsbWrIz
 AFlpAO8RgP1MmBdXhB9L3biLsZ7zFeuhNA7tSM1vyP07+fakUdz+0C5emUKFQu5I6nU2pX1uYMt
 meaJWvs5GiuV1v5myNyjeXMoYhv5j1BVM5zF42/YlpLX60KIM2VYqrCFcycbhAw8cVeX6yqfUrB
 Jpb+ndyEQDtExdLM1kEgw/WGo2AmsVCNCom7E2SQqNpmh8mIa7XlkE3zek/PAyGAKmJ2Op5o8fx
 /VzI5G8KOWOHvzZJk1w/6qii/afrMmpShmSv/zzgCr/YBWs6zmsoS0cpHE/mdh+9CIs2+9s3Ax0
 d+ZMYC3SqdSrLNNQwZKMo/k7Vh2B/NOuGtL3BddVQi0ZBfX/x6oaZmtQQpSxkjKAApYuRWuReiZ
 ZojpLnDnnLy64WF6hJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140188
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 7/14/26 16:55, Richard Henderson wrote:
> On 7/14/26 06:02, Ilya Leoshkevich wrote:
>>
>>
>> On 7/10/26 22:53, Richard Henderson wrote:
>>> Use a balanced binary tree rather than a simple list for watchpoints.
>>> Using an interval tree makes it easy to probe for any overlapping 
>>> address.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   include/exec/breakpoint.h |   7 +-
>>>   include/hw/core/cpu.h     |   3 +-
>>>   accel/tcg/cpu-exec.c      |   8 +-
>>>   accel/tcg/watchpoint.c    | 155 +++++++++++++++++++++-----------------
>>>   hw/core/cpu-common.c      |   1 -
>>>   system/watchpoint.c       |  43 ++++++-----
>>>   target/arm/hyp_gdbstub.c  |   3 +-
>>>   7 files changed, 119 insertions(+), 101 deletions(-)
>>>
>>> diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
>>> index bb7cbc626d..e0826a1a2d 100644
>>> --- a/include/exec/breakpoint.h
>>> +++ b/include/exec/breakpoint.h
>>> @@ -9,7 +9,6 @@
>>>   #define EXEC_BREAKPOINT_H
>>>   #include "qemu/interval-tree.h"
>>> -#include "qemu/queue.h"
>>>   #include "exec/vaddr.h"
>>>   #include "exec/memattrs.h"
>>> @@ -36,13 +35,11 @@ struct CPUBreakpoint {
>>>   };
>>>   struct CPUWatchpoint {
>>> -    vaddr vaddr;
>>> -    vaddr len;
>>> +    IntervalTreeNode itree;
>>>       vaddr hitaddr;
>>>       MemTxAttrs hitattrs;
>>> -    int flags; /* BP_* */
>>> +    BreakpointFlags flags;
>>
>> Should this go into 1/51?
>>
>>>       unsigned id;
>>> -    QTAILQ_ENTRY(CPUWatchpoint) entry;
>>>   };
>>>   int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags 
>>> flags,
>>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>>> index b8a1419860..7e19ea418d 100644
>>> --- a/include/hw/core/cpu.h
>>> +++ b/include/hw/core/cpu.h
>>> @@ -525,8 +525,7 @@ struct CPUState {
>>>       /* ice debug support */
>>>       IntervalTreeRoot breakpoints;
>>> -
>>> -    QTAILQ_HEAD(, CPUWatchpoint) watchpoints;
>>> +    IntervalTreeRoot watchpoints;
>>>       CPUWatchpoint *watchpoint_hit;
>>>       void *opaque;
>>> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>>> index 2762cf6705..ab299387e3 100644
>>> --- a/accel/tcg/cpu-exec.c
>>> +++ b/accel/tcg/cpu-exec.c
>>> @@ -682,10 +682,12 @@ static inline bool cpu_handle_halt(CPUState *cpu)
>>>   static inline void cpu_handle_debug_exception(CPUState *cpu)
>>>   {
>>>       const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
>>> -    CPUWatchpoint *wp;
>>> +    IntervalTreeNode *n;
>>> -    if (!cpu->watchpoint_hit) {
>>
>> Isn't it reasonable to continue checking for this, or can it never be
>> NULL if we come here?
> 
> Intermediate steps.
> 
> Before this patch we walk the entire watchpoint list performing this 
> same clearing in cpu_check_watchpoint.  With this patch, we no longer 
> walk every element in cpu_check_watchpoint, but have not yet eliminated 
> some manual checks for BP_WATCHPOINT_HIT in the target code.  By the end 
> of the patch series, this loop is gone completely.
> 
> Helpful if I add a /* Will be cleaned up */ comment at this point in the 
> series?
> 
> 
> r~

I think it's fine as is, I just haven't read the series until the
end yet. Thanks for the explanation.

