Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781F6E99053
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB74I-0001Ea-9t; Fri, 10 Apr 2026 04:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wB74H-0001Dq-0N; Fri, 10 Apr 2026 04:18:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wB74E-0000s1-V1; Fri, 10 Apr 2026 04:18:20 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639KHlYA2162309; Fri, 10 Apr 2026 08:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hdO8+n
 4suFybdBAwaxNVR3b5hvXVaCTpXvsUvrrA0h0=; b=Yv5pJBCJx/dD509sESChvM
 GXo8TRESlxPPLXvRQoIHX6u5GsmJYUdx3xHCk20642YKwmJztHEcOv+OMN8yFFb1
 TvgZYD21xhbZrFPDvClkEUv0OSfG1WFQvucdSVSIUxd01BMhA0paxe+njdFheC1s
 s07ppIhgElPfK8fKejQIZqa/TMjTMYaweyKa740VmOi9E1rypsYVISjeu5tkHsvc
 3P/F+jRWtvq2LRYgFKUp11Bq8sFS91w2eMpfYgwa3ckOiM/GvlihurWiyJyLxpcv
 R8aNVoDmcH/LD2e4ct02J8udUJi7CvIVNKu9cUnkcxtL6k55FPYY9+3pHoYyBrDw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2g9067-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 08:18:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A30wnc030102;
 Fri, 10 Apr 2026 08:18:14 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7q5kw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 08:18:14 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63A8IDH122151812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Apr 2026 08:18:13 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1AF858060;
 Fri, 10 Apr 2026 08:18:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DDD758056;
 Fri, 10 Apr 2026 08:18:10 +0000 (GMT)
Received: from [9.124.212.60] (unknown [9.124.212.60])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Apr 2026 08:18:09 +0000 (GMT)
Message-ID: <424743ec-a34d-4af0-adfb-c8392ee5e5be@linux.ibm.com>
Date: Fri, 10 Apr 2026 13:48:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 11.0-rc3] accel/kvm: Fix BQL lock imbalance in
 kvm_cpu_exec
Content-Language: en-GB
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, npiggin@gmail.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260409161042.55281-1-harshpb@linux.ibm.com>
 <C0822D91-E199-4FEB-B1AA-28652D0F3453@redhat.com>
 <4b3044b1-4ea0-4f3a-8a0a-04e09d071a15@linux.ibm.com>
 <451942FA-0056-466C-AD42-AB0BBE88472E@redhat.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <451942FA-0056-466C-AD42-AB0BBE88472E@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FKArAeos c=1 sm=1 tr=0 ts=69d8b248 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VnNF1IyMAAAA:8 a=4Vvs_npgFDSUEtlqYM4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: K65FOcmf5VoFE-lbOJLJqh07Uw0k2X4u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA3NiBTYWx0ZWRfXzSBySWoZW9PO
 wX+oyP6HtZg3UB9jY8uhE26R8SrEufOA3qihIwkTQ04FayBKdeCHRTMAU/L+RUvUVJqs0ydsTLQ
 aMmHAWJkKySwljXyMGRRhRJAXPg9OUS6Zvk6OXoaZUopg0ohlVBJeC4/sClZdjZGGjIarJgeavd
 YDRA2TQnCXQn7VBoqqcYrrnatBsVIyE0xJDAPBJh0M5oRv4oWInhlX40sbNcZ7YEHSxjeRvqdvv
 xqsMbBbwavrvhncXOM3Pp12oOqtkHZewtpYJ2ldksFDr507EmExSEjRtL7CWQu/t8CWKIJkRXTO
 8Ib6kdMb/mQUXvnOz4WtsBgmzPwCKCTov4+QtSoU0gMgdG9iCj6gv03OzY9nZq2ML6Xf+rZPHiJ
 jaNG/x7v6n17MhDBHx1f7YrH2Fh1mz3bUls67uZe2QZJMbdtQVJHQLC0rtlFIcz3asunrEJYFJY
 YD3RSBuzcLmp0BWADdQ==
X-Proofpoint-GUID: K9zOq34lySPhy_-586nQu2S7aftVUI45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100076
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/04/26 12:05 pm, Ani Sinha wrote:
> 
> 
>> On 10 Apr 2026, at 10:55 AM, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>>
>> Hi Ani,
>>
>> On 10/04/26 9:12 am, Ani Sinha wrote:
>>>> On 9 Apr 2026, at 9:40 PM, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>>>>
>>>> When kvm_cpu_exec() returns EXCP_HLT due to kvm_arch_process_async_events()
>>>> returning true, it was returning before releasing the BQL (Big QEMU Lock).
>>>> This caused a lock imbalance where the vCPU thread would loop back to
>>>> kvm_cpu_exec() while still holding the BQL, leading to deadlocks.
>>> I am not sure I understand this. Seems kvm_cpu_exec() does expect that the caller holds bql before calling the function. Where is the lock imbalance?
>>
>> The issue is not that kvm_cpu_exec() doesn't expect the caller to hold the BQL - it does. The problem is that kvm_cpu_exec() has inconsistent BQL handling across its return paths.
>>
>> Normal execution path:
>>
>> int kvm_cpu_exec(CPUState *cpu)
>> {
>>     // BQL held on entry (from caller)
>>
>>     if (kvm_arch_process_async_events(cpu)) {
>>         return EXCP_HLT;  // ← Returns with BQL STILL HELD
>>     }
>>
>>     bql_unlock();  // ← Normal path unlocks here
>>     // ... KVM execution loop ...
>>     bql_lock();    // ← Re-acquires before returning
>>     return ret;
>> }
> 
> Yes the semantics of the function kvm_cpu_exec() is that it should always return with bql in locked state. This is because the caller kvm_vcpu_thread_fn() calls this function with bql locked and if you see the end of kvm_vcpu_thread_fn(), it releases the lock.
> 
> So if kvm_cpu_exec() unlocks bql internally, it has the responsibility to lock it again before returning. This makes the locking and unlocking symmetric.
> 
> 
>>
>> The lock imbalance:
>>
>> When kvm_arch_process_async_events() returns true, the function returns EXCP_HLT before the bql_unlock() call.
> 
> Why should it unlock it before returning? In fact it’s opposite. If the function had unlocked bql, it should lock it again before returning.
> 
>> This means the early return path keeps the BQL held,
> 
> This would be the correct thing to do.
> 
>> while the normal execution path releases and re-acquires it.
> 
> Because the functions it calls after unlocking requires bql to be unlocked. Since it had to unlock it, it locks it again before returning.

It had to unlock it for the same reason - to give others a chance to 
lock. We need to handle failure/exception cases for the same purpose as 
well.

> 
>> The caller (kvm_vcpu_thread_fn()) loops back and calls kvm_cpu_exec() again, but now the BQL is already held from the previous iteration
>> This creates a situation where the BQL is never released between iterations when EXCP_HLT is returned.
>>
>> Why this matters:
>> On PowerPC pseries with halted secondary vCPUs (start-powered-off=true), these vCPUs repeatedly call kvm_cpu_exec() which returns EXCP_HLT. Each iteration accumulates BQL holds, preventing other threads (including CPU 0) from making progress.
> 
> This seems like some kind of architectural issue with PowerPC. Shouldn’t qemu_process_cpu_events() -> qemu_cond_wait(cpu->halt_cond, &bql) block other secondary cpus? Then the main cpu does a qemu_cpu_kick() to make them active again at some point?

KVM vCPUs need to enter the kernel to handle the halted state and 
therefore can run. On spapr, it is handled via start-cpu rtas call for 
which the handler in qemu does a qemu_cpu_kick(). However CPU 0 needs to 
be able to proceed before that stage is reached, but it hangs while 
trying to acquire bql_lock in qemu_default_main() whereas secondary vcpu 
is spinning with BQL held returning EXCP_HLT. This is causing deadlock.

> 
>>
>>>>
>>>> The issue manifests as boot hangs on PowerPC pseries machines with multiple
>>>> vCPUs, where secondary vCPUs with start-powered-off=true remain halted and
>>>> repeatedly call kvm_cpu_exec() which returns EXCP_HLT. Each iteration held
>>>> the BQL, preventing other operations from proceeding.
>>>>
>>>> The fix has two parts:
>>>>
>>>> 1. In kvm_cpu_exec() (kvm-all.c):
>>>>    Release the BQL before returning EXCP_HLT in the early return path,
>>>>    matching the behavior of the normal execution path where bql_unlock()
>>>>    is called before entering the main KVM execution loop.
>>>>
>>>> 2. In kvm_vcpu_thread_fn() (kvm-accel-ops.c):
>>>>    Re-acquire the BQL after kvm_cpu_exec() returns EXCP_HLT, since the
>>>>    loop expects to hold the BQL when calling kvm_cpu_exec() again.
>>>>
>>>> This ensures proper BQL lock/unlock pairing:
>>>> - kvm_vcpu_thread_fn() holds BQL before calling kvm_cpu_exec()
>>>> - kvm_cpu_exec() releases BQL before returning (for EXCP_HLT)
>>>> - kvm_vcpu_thread_fn() re-acquires BQL if EXCP_HLT was returned
>>>> - Next iteration has BQL held as expected
>>>>
>>>> This is a regression introduced by commit 98884e0cc1 ("accel/kvm: add
>>>> changes required to support KVM VM file descriptor change") which
>>>> refactored kvm_irqchip_create() and changed the initialization timing,
>>>> exposing this lock imbalance issue.
>>>>
>>>> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
>>> I do not think this is the right reference. The above commit may have exposed some underlying issue but is certainly not the cause of it. Further, as we have discussed in the other thread, the changes in that commit are not even getting executed.
>>> Personally I think the core issue is somewhere else. I am not convinced this is the proper fix.
>>
>> Regarding commit 98884e0cc1:
>>
>> Reverting the kvm_irqchip_create refactoring makes the problem go away. This commit may have changed timing that exposed the issue, but the root cause is the pre-existing BQL lock imbalance in kvm_cpu_exec(). We can either:
>>
>> Remove the "Fixes:" tag entirely, or
> 
> Lets remove fixes tag entirely unless you can pin point the exact commit that introduced the architectural issues.
> 
>> Add a note that this is a pre-existing issue exposed by timing changes
>> The core fix (releasing BQL before returning EXCP_HLT) is correct and addresses the actual deadlock mechanism.
>>
>>>> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
>>>> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
>>>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>> ---
>>>> accel/kvm/kvm-accel-ops.c | 4 ++++
>>>> accel/kvm/kvm-all.c       | 1 +
>>>> 2 files changed, 5 insertions(+)
>>>>
>>>> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
>>>> index 6d9140e549..d684fd0840 100644
>>>> --- a/accel/kvm/kvm-accel-ops.c
>>>> +++ b/accel/kvm/kvm-accel-ops.c
>>>> @@ -52,6 +52,10 @@ static void *kvm_vcpu_thread_fn(void *arg)
>>>>
>>>>          if (cpu_can_run(cpu)) {
>>>>              r = kvm_cpu_exec(cpu);
>>>> +            if (r == EXCP_HLT) {
>>>> +                /* kvm_cpu_exec() released BQL, re-acquire for next iteration */
>>>> +                bql_lock();
>>>> +            }
>>>>              if (r == EXCP_DEBUG) {
>>>>                  cpu_handle_guest_debug(cpu);
>>>>              }
>>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>>> index 774499d34f..00b8018664 100644
>>>> --- a/accel/kvm/kvm-all.c
>>>> +++ b/accel/kvm/kvm-all.c
>>>> @@ -3439,6 +3439,7 @@ int kvm_cpu_exec(CPUState *cpu)
>>>>      trace_kvm_cpu_exec();
>>>>
>>>>      if (kvm_arch_process_async_events(cpu)) {
>>>> +        bql_unlock();
>>>>          return EXCP_HLT;
>>>>      }
>>>>
>>>> -- 
>>>> 2.52.0
> 
> 
> 


