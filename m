Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66ACE99068
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 10:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB8vC-0002w2-Df; Fri, 10 Apr 2026 06:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wB8v9-0002vF-8z; Fri, 10 Apr 2026 06:17:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wB8v7-0003mM-9R; Fri, 10 Apr 2026 06:17:02 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A1iO3m2298432; Fri, 10 Apr 2026 10:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/UHNg6
 cyNaixJPFd2I27xfAXRNvI652l2wGrfTl3TxY=; b=L7lfqWuq9MFePKZlIFT0EH
 FWgC3KoO2yOa+Koo3jlwdUbQTSTg2NPeL9vzROu6BWQg15Ts1eKqNneG+6yE5wEM
 50s0KOGkh/849yoACIixFwCBFWf6g4yx9stKMc/Ew0pT6cLI7OXa+P5dRmOMJFnP
 hpO1aoNqjTan+9ONptM0Z28JRalIhp0YxjYWou9MzblPvO/2e9nixpSHKSGEPwXW
 FuTVhJUyoWUEkJBhTcFWHJTGsoicEhA8I3iwuuQPVvAUoG3syjKkDKr8wufQVAPx
 oVSKtkWd8uktozLmW1OJOKNlYm946TDl1eCV9miUxCK0XiSxWjz+l3td8/mhfq9w
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2g8bad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 10:16:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A8ZA4h026646;
 Fri, 10 Apr 2026 10:16:57 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg87f7w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 10:16:57 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63AAGu6c983980
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Apr 2026 10:16:56 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A78358066;
 Fri, 10 Apr 2026 10:16:56 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5723F58055;
 Fri, 10 Apr 2026 10:16:53 +0000 (GMT)
Received: from [9.124.212.238] (unknown [9.124.212.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Apr 2026 10:16:53 +0000 (GMT)
Message-ID: <c56cf0e3-6d95-40a3-b00f-0b95c8137b14@linux.ibm.com>
Date: Fri, 10 Apr 2026 15:46:51 +0530
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
 <424743ec-a34d-4af0-adfb-c8392ee5e5be@linux.ibm.com>
 <69167029-AE49-4BB3-9A5C-D16E51E5D40F@redhat.com>
 <07f76b99-ff79-4480-af02-c43e2779d179@linux.ibm.com>
 <34DB9C06-ED15-42BF-A7BB-AF1BBC170ADA@redhat.com>
 <852c5863-8f56-473d-ad92-a56a80f3ce71@linux.ibm.com>
 <89EDA797-28E3-46A1-A464-8AFE9FB534BD@redhat.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <89EDA797-28E3-46A1-A464-8AFE9FB534BD@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d8ce1a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=VnNF1IyMAAAA:8 a=tNryw6az7MBK7zL6OWoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: QmVloEOwyCRIS9kpvTr2hO6csjjL_ZOm
X-Proofpoint-GUID: G3kji3VUuDmS5CQuV4wAyHOAzGG1eLfu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA5MSBTYWx0ZWRfX68YkYsVVNi7x
 EhC2jLsxQudt80LEUtA/ZLVa+zHZWbCVqg2tvPtgLau0rLFBxNvXGzRGsxoum08+celQowcZC11
 CWYfzQfYVI+6agKWiPo4jCeBE+VvOnBg/5LikysrV1EuOnrADkxV2QNHOAEYCsFH/Ie0Cl1ulzP
 q5XRAPBxYqHDq9impchXjWYJYQKyrB6DZUWVPxHVzQ81FKiNvHMX3RjlNnB+lYlyYE2v1qzHeN4
 jIuPEWD7ARq/7ZaroFixjVTZaQps5DbTmWPSNtyri1HnKl3bKj+4u36Io9v++PUCqOppcaMkJLb
 GloEXXLLbLdtxjUi3hnoXeuvbevyNyJsUrOkB4t6BpFyBkkibveRB0c2373NM+e/aC1JybosCPy
 olzuKD/ADJGydfCRZvOxM6Lhq83a+1ik2wQtfRF7VKpQWFnSe5mibnvph1fywkt4ClQKNJF+kGW
 oblv2GOVT7dPEcOQfAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100091
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 10/04/26 3:35 pm, Ani Sinha wrote:
> 
> 
>> On 10 Apr 2026, at 3:32 PM, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>>
>>
>>
>> On 10/04/26 3:01 pm, Ani Sinha wrote:
>>>> On 10 Apr 2026, at 2:31 PM, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 10/04/26 1:59 pm, Ani Sinha wrote:
>>>>>> On 10 Apr 2026, at 1:48 PM, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 10/04/26 12:05 pm, Ani Sinha wrote:
>>>>>>>> On 10 Apr 2026, at 10:55 AM, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>>>>>>>>
>>>>>>>> Hi Ani,
>>>>>>>>
>>>>>>>> On 10/04/26 9:12 am, Ani Sinha wrote:
>>>>>>>>>> On 9 Apr 2026, at 9:40 PM, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>>>>>>>>>>
>>>>>>>>>> When kvm_cpu_exec() returns EXCP_HLT due to kvm_arch_process_async_events()
>>>>>>>>>> returning true, it was returning before releasing the BQL (Big QEMU Lock).
>>>>>>>>>> This caused a lock imbalance where the vCPU thread would loop back to
>>>>>>>>>> kvm_cpu_exec() while still holding the BQL, leading to deadlocks.
>>>>>>>>> I am not sure I understand this. Seems kvm_cpu_exec() does expect that the caller holds bql before calling the function. Where is the lock imbalance?
>>>>>>>>
>>>>>>>> The issue is not that kvm_cpu_exec() doesn't expect the caller to hold the BQL - it does. The problem is that kvm_cpu_exec() has inconsistent BQL handling across its return paths.
>>>>>>>>
>>>>>>>> Normal execution path:
>>>>>>>>
>>>>>>>> int kvm_cpu_exec(CPUState *cpu)
>>>>>>>> {
>>>>>>>>     // BQL held on entry (from caller)
>>>>>>>>
>>>>>>>>     if (kvm_arch_process_async_events(cpu)) {
>>>>>>>>         return EXCP_HLT;  // ← Returns with BQL STILL HELD
>>>>>>>>     }
>>>>>>>>
>>>>>>>>     bql_unlock();  // ← Normal path unlocks here
>>>>>>>>     // ... KVM execution loop ...
>>>>>>>>     bql_lock();    // ← Re-acquires before returning
>>>>>>>>     return ret;
>>>>>>>> }
>>>>>>> Yes the semantics of the function kvm_cpu_exec() is that it should always return with bql in locked state. This is because the caller kvm_vcpu_thread_fn() calls this function with bql locked and if you see the end of kvm_vcpu_thread_fn(), it releases the lock.
>>>>>>> So if kvm_cpu_exec() unlocks bql internally, it has the responsibility to lock it again before returning. This makes the locking and unlocking symmetric.
>>>>>>>>
>>>>>>>> The lock imbalance:
>>>>>>>>
>>>>>>>> When kvm_arch_process_async_events() returns true, the function returns EXCP_HLT before the bql_unlock() call.
>>>>>>> Why should it unlock it before returning? In fact it’s opposite. If the function had unlocked bql, it should lock it again before returning.
>>>>>>>> This means the early return path keeps the BQL held,
>>>>>>> This would be the correct thing to do.
>>>>>>>> while the normal execution path releases and re-acquires it.
>>>>>>> Because the functions it calls after unlocking requires bql to be unlocked. Since it had to unlock it, it locks it again before returning.
>>>>>>
>>>>>> It had to unlock it for the same reason - to give others a chance to lock. We need to handle failure/exception cases for the same purpose as well.
>>>>> But by unlocking and returning you are breaking the semantics of the function and introducing imbalance.
>>>>
>>>> I think it is better to unlock bql early in failure cases.
>>>> Even Otherwise, it would become a bql_unlock followed by a bql_lock in the caller for EXCP_HLT, which might look a bit odd as well.
>>> But you are doing exactly that across a function call.
>>
>> I am fine with either/or maintainer's choice.
>>
>>>>
>>>> Paolo, suggestions?
>>>>
>>>>>>
>>>>>>>> The caller (kvm_vcpu_thread_fn()) loops back and calls kvm_cpu_exec() again, but now the BQL is already held from the previous iteration
>>>>>>>> This creates a situation where the BQL is never released between iterations when EXCP_HLT is returned.
>>>>>>>>
>>>>>>>> Why this matters:
>>>>>>>> On PowerPC pseries with halted secondary vCPUs (start-powered-off=true), these vCPUs repeatedly call kvm_cpu_exec() which returns EXCP_HLT. Each iteration accumulates BQL holds, preventing other threads (including CPU 0) from making progress.
>>>>>>> This seems like some kind of architectural issue with PowerPC. Shouldn’t qemu_process_cpu_events() -> qemu_cond_wait(cpu->halt_cond, &bql) block other secondary cpus? Then the main cpu does a qemu_cpu_kick() to make them active again at some point?
>>>>>>
>>>>>> KVM vCPUs need to enter the kernel to handle the halted state and therefore can run. On spapr, it is handled via start-cpu rtas call for which the handler in qemu does a qemu_cpu_kick(). However CPU 0 needs to be able to proceed before that stage is reached, but it hangs while trying to acquire bql_lock in qemu_default_main() whereas secondary vcpu is spinning with BQL held returning EXCP_HLT. This is causing deadlock.
>>>>> Without looking at the code, it seems there is a race condition in the way the vcpu threads are initialised in spapr. I think that needs fixing.
>>>>
>>>> I did explain the race condition observed above.
>>> So why not fix it properly?
>>
>> I think the suggested fix is appropriate for this scenario.
>> Keeping BQL held forever in a loop for EXCP_HLT case isnt the right thing to do.
> 
> IMHO that loop is a symptom of a deeper architectural issue. The fix proposed here feels more like a incorrect hack.

I do not think so. Irrespective of the issue, there's no reason to keep 
holding BQL forever in a loop like that for EXCP_HLT case.


> 


