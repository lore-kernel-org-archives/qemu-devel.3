Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5541F36BAC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 05:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB4Nf-0007UU-Jq; Fri, 10 Apr 2026 01:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wB4Nb-0007UC-Lg; Fri, 10 Apr 2026 01:26:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wB4NZ-0006Ww-A2; Fri, 10 Apr 2026 01:26:07 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639NMjGe2315079; Fri, 10 Apr 2026 05:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Dk5iov
 uqyQlNW6p1kUmMfoBh43avLJBdH6SFpfMUKKg=; b=XZvkAQlM7y3cogsDKKm43m
 VQtwY7Yo5UcW4dWGmC3Tilms93pT0SAXNkYypqde11DiVAPHS9+/dBnqK4E0VxVe
 /8NKqHohHzzpT08zYMSmEgKqrqWYYsoKyuXatjgwBPC++z0Is9EQSx+4f69rN7sK
 /3m99KkL4eEyZFh8wdJHz8h6I1ixt3HUBLe53I7S7GlOtOGxsoJfkwZyZDKcMSEZ
 lAMof4CxL05HHdCoy3xj63NcIB2Mpx3W9JYuXyu120BvemLGKEGMEQ1BzmzMfar0
 kh1L6/DrB6/eRrifA/4i9lcNRjg/q/jBGF+kcehhraHSYByjzs6gYrT6iNAgpoHw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2g8ems-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 05:26:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A2VEkX013882;
 Fri, 10 Apr 2026 05:26:00 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf4eped-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 05:26:00 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63A5Pw8M24838878
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Apr 2026 05:25:58 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43DC058056;
 Fri, 10 Apr 2026 05:25:58 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C4215805A;
 Fri, 10 Apr 2026 05:25:55 +0000 (GMT)
Received: from [9.124.212.60] (unknown [9.124.212.60])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Apr 2026 05:25:55 +0000 (GMT)
Message-ID: <4b3044b1-4ea0-4f3a-8a0a-04e09d071a15@linux.ibm.com>
Date: Fri, 10 Apr 2026 10:55:53 +0530
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
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <C0822D91-E199-4FEB-B1AA-28652D0F3453@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FKArAeos c=1 sm=1 tr=0 ts=69d889e9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VnNF1IyMAAAA:8 a=w4t-TaBqUuFs90xPVssA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: IBlTKh2k6U6dyEcgjtp32SmolDJfxxnE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA0NiBTYWx0ZWRfX++9UpGhiXo6U
 P58J3JyCoX1Rabk8/E4rv59LNEwFZ+f7LLKFpJNmqYovIoB01f+MDC9GbPPLzRuNwZumBfBvqli
 gabQridAxLfNMXZpkV0VYq6S71E+sUAT44oeECsmJcs2csr6LRPxmRHziXYj/qh5d9fkFA5Eea8
 GXIZ16CjaMMG80m0aunaEMGJaEJj0i9mojhogLe9GdHiuF+C3PWjM+CAwssPVe06e2ok34qGlko
 xp0Ym2SkJATvm5UF2gC5MGVn2G6k7LPFLNnJT8/rL6alOtXjC3c4NJ/MUYJZvBZT7hmr3ogwifS
 HW9cm6NbVzAeNe14O5tnjNYm4IL6OrlsEkJb6lLcK0h4jXX3vJdRPb+FRjZl0H4que+D4idrXxI
 8YXG6NTVzMpaymT9zX+bJgKVLSJCdKONis1cZlNo78TFZM9w+Edb9DAeWiL9sfFwwhP6wmoD9/R
 ZgtnnFvV4CfzecsaXeA==
X-Proofpoint-GUID: Vpdr0Co6l27B53CpIggg0OQEJN8M0qFt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_01,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100046
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

Hi Ani,

On 10/04/26 9:12 am, Ani Sinha wrote:
> 
> 
>> On 9 Apr 2026, at 9:40 PM, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>>
>> When kvm_cpu_exec() returns EXCP_HLT due to kvm_arch_process_async_events()
>> returning true, it was returning before releasing the BQL (Big QEMU Lock).
>> This caused a lock imbalance where the vCPU thread would loop back to
>> kvm_cpu_exec() while still holding the BQL, leading to deadlocks.
> 
> I am not sure I understand this. Seems kvm_cpu_exec() does expect that the caller holds bql before calling the function. Where is the lock imbalance?

The issue is not that kvm_cpu_exec() doesn't expect the caller to hold 
the BQL - it does. The problem is that kvm_cpu_exec() has inconsistent 
BQL handling across its return paths.

Normal execution path:

int kvm_cpu_exec(CPUState *cpu)
{
     // BQL held on entry (from caller)

     if (kvm_arch_process_async_events(cpu)) {
         return EXCP_HLT;  // ← Returns with BQL STILL HELD
     }

     bql_unlock();  // ← Normal path unlocks here
     // ... KVM execution loop ...
     bql_lock();    // ← Re-acquires before returning
     return ret;
}

The lock imbalance:

When kvm_arch_process_async_events() returns true, the function returns 
EXCP_HLT before the bql_unlock() call.
This means the early return path keeps the BQL held, while the normal 
execution path releases and re-acquires it.
The caller (kvm_vcpu_thread_fn()) loops back and calls kvm_cpu_exec() 
again, but now the BQL is already held from the previous iteration
This creates a situation where the BQL is never released between 
iterations when EXCP_HLT is returned.

Why this matters:
On PowerPC pseries with halted secondary vCPUs (start-powered-off=true), 
these vCPUs repeatedly call kvm_cpu_exec() which returns EXCP_HLT. Each 
iteration accumulates BQL holds, preventing other threads (including CPU 
0) from making progress.

> 
>>
>> The issue manifests as boot hangs on PowerPC pseries machines with multiple
>> vCPUs, where secondary vCPUs with start-powered-off=true remain halted and
>> repeatedly call kvm_cpu_exec() which returns EXCP_HLT. Each iteration held
>> the BQL, preventing other operations from proceeding.
>>
>> The fix has two parts:
>>
>> 1. In kvm_cpu_exec() (kvm-all.c):
>>    Release the BQL before returning EXCP_HLT in the early return path,
>>    matching the behavior of the normal execution path where bql_unlock()
>>    is called before entering the main KVM execution loop.
>>
>> 2. In kvm_vcpu_thread_fn() (kvm-accel-ops.c):
>>    Re-acquire the BQL after kvm_cpu_exec() returns EXCP_HLT, since the
>>    loop expects to hold the BQL when calling kvm_cpu_exec() again.
>>
>> This ensures proper BQL lock/unlock pairing:
>> - kvm_vcpu_thread_fn() holds BQL before calling kvm_cpu_exec()
>> - kvm_cpu_exec() releases BQL before returning (for EXCP_HLT)
>> - kvm_vcpu_thread_fn() re-acquires BQL if EXCP_HLT was returned
>> - Next iteration has BQL held as expected
>>
>> This is a regression introduced by commit 98884e0cc1 ("accel/kvm: add
>> changes required to support KVM VM file descriptor change") which
>> refactored kvm_irqchip_create() and changed the initialization timing,
>> exposing this lock imbalance issue.
>>
>> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
> 
> I do not think this is the right reference. The above commit may have exposed some underlying issue but is certainly not the cause of it. Further, as we have discussed in the other thread, the changes in that commit are not even getting executed.
> 
> Personally I think the core issue is somewhere else. I am not convinced this is the proper fix.

Regarding commit 98884e0cc1:

Reverting the kvm_irqchip_create refactoring makes the problem go away. 
This commit may have changed timing that exposed the issue, but the root 
cause is the pre-existing BQL lock imbalance in kvm_cpu_exec(). We can 
either:

Remove the "Fixes:" tag entirely, or
Add a note that this is a pre-existing issue exposed by timing changes
The core fix (releasing BQL before returning EXCP_HLT) is correct and 
addresses the actual deadlock mechanism.

> 
>> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
>> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>> accel/kvm/kvm-accel-ops.c | 4 ++++
>> accel/kvm/kvm-all.c       | 1 +
>> 2 files changed, 5 insertions(+)
>>
>> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
>> index 6d9140e549..d684fd0840 100644
>> --- a/accel/kvm/kvm-accel-ops.c
>> +++ b/accel/kvm/kvm-accel-ops.c
>> @@ -52,6 +52,10 @@ static void *kvm_vcpu_thread_fn(void *arg)
>>
>>          if (cpu_can_run(cpu)) {
>>              r = kvm_cpu_exec(cpu);
>> +            if (r == EXCP_HLT) {
>> +                /* kvm_cpu_exec() released BQL, re-acquire for next iteration */
>> +                bql_lock();
>> +            }
>>              if (r == EXCP_DEBUG) {
>>                  cpu_handle_guest_debug(cpu);
>>              }
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 774499d34f..00b8018664 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -3439,6 +3439,7 @@ int kvm_cpu_exec(CPUState *cpu)
>>      trace_kvm_cpu_exec();
>>
>>      if (kvm_arch_process_async_events(cpu)) {
>> +        bql_unlock();
>>          return EXCP_HLT;
>>      }
>>
>> -- 
>> 2.52.0
>>
> 


