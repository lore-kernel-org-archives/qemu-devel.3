Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D50AE9381A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 05:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCA6H-0004o2-Tt; Mon, 13 Apr 2026 01:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wCA6G-0004nk-9R; Mon, 13 Apr 2026 01:44:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wCA6E-0003IU-1d; Mon, 13 Apr 2026 01:44:43 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63CKfhbD3344222; Mon, 13 Apr 2026 05:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jfRqSa
 XLxujPZJrH37YGpEURwColteq3LuWBnyLJU/w=; b=ezl538jKqjRW7OWnpJNSZ9
 t45IZV1dTvkJSFEwrq4FdNsJcJZCPwP30Y1t3Y31CN35C7R8MjvHILtKqDKM1EFp
 lH1Q6VKzbR1bpTHKjE8XjA0y07JxGGyxfkLMw1QafqsSAW1ORDScz4oopQdH7u0a
 PpAZ4ejBz4xaxRwESR1/mGcboMBDV96Lq00+UucXHA0QK2xEcqi92icyV/g+0tE6
 3FhmaMlpOwY2x54FESp1IcUR2ee9ZtoWHsMhv1mRmG/eJ25rBuMccswc8xrzgCPt
 Jev7jZQwGoIvU1+mjpYDoSA0H6tSXL8uq3vIamBPriUACN8wsoX1SZ3sdcI1B2gA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdt3p6h8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Apr 2026 05:44:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D2d1b7031240;
 Mon, 13 Apr 2026 05:44:26 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10y3xbt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Apr 2026 05:44:26 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63D5iPXM50790772
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Apr 2026 05:44:25 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19F0258058;
 Mon, 13 Apr 2026 05:44:25 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E910958059;
 Mon, 13 Apr 2026 05:44:21 +0000 (GMT)
Received: from [9.124.214.170] (unknown [9.124.214.170])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Apr 2026 05:44:21 +0000 (GMT)
Message-ID: <d4ca5f6a-c810-407b-b089-839e0a7d6d06@linux.ibm.com>
Date: Mon, 13 Apr 2026 11:14:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 11.0-rc3] accel/kvm: Fix BQL lock imbalance in
 kvm_cpu_exec
Content-Language: en-GB
To: Fabiano Rosas <farosas@suse.de>, balaton@eik.bme.hu, anisinha@redhat.com, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: pbonzini@redhat.com, npiggin@gmail.com, misanjum@linux.ibm.com,
 gautam@linux.ibm.com, peter.maydell@linaro.org
References: <20260409161042.55281-1-harshpb@linux.ibm.com>
 <87qzomznto.fsf@suse.de>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <87qzomznto.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: aKQ2Uc-c-qCGH0JP2Td9R-LcFprhSmCB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA0OCBTYWx0ZWRfX534yr1tSlO+k
 qRr6TzHrtP+NU+13UEVHGKoxtlhj2DoXuO0FKckqoBq5wjIY2M61VxsclWoqL5bDh7jNT2SRrZv
 IGQGmpFBzMFr3LGCySEmIWQAx1Ja7BK+m4IaFXwYhxfIsh8gTX62H1mHeUjmhJKkxBWOuqZhbfh
 XSlIvJrKvo+sgNa0im2vk9CiWJa268p50MPu/gIjs+4k0kCKABT5y8JwrRn8wwT52xY88HgMX7x
 q4RAv1LaMDIgMND6V93OXffkKgZOVVOKH9Yppy3TGwlGDxSenf07MCTJgjRCrVgNscGzXMnzXPp
 pOauYIO1qXRVAlIlC9+6qFUBCrZCnuSbPlQx9vdSG5mboXfeUlPx8D2ln+kJsHTMZHBS73PD8fQ
 JDmyGhjMxotsCPOn6xTnH+I8NviazeeO/sY21IfFxPAqdkypU1/EsBAMq8pUK0nVir0aCtOHMSb
 9VtFFgKoephf5oGxgzw==
X-Proofpoint-GUID: pyYhuyNNb68s5KOVGq8Sc56tZ915Yvcc
X-Authority-Analysis: v=2.4 cv=WpEb99fv c=1 sm=1 tr=0 ts=69dc82bb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=VnNF1IyMAAAA:8 a=mAafe1QSjR4qlSFeF0IA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_01,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130048
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

Hi Fabiano, Balaton,

Thanks for pitching in and the suggestions.

On 10/04/26 11:42 pm, Fabiano Rosas wrote:
> Harsh Prateek Bora <harshpb@linux.ibm.com> writes:
> 
>> When kvm_cpu_exec() returns EXCP_HLT due to kvm_arch_process_async_events()
>> returning true, it was returning before releasing the BQL (Big QEMU Lock).
>> This caused a lock imbalance where the vCPU thread would loop back to
>> kvm_cpu_exec() while still holding the BQL, leading to deadlocks.
>>
>> The issue manifests as boot hangs on PowerPC pseries machines with multiple
>> vCPUs, where secondary vCPUs with start-powered-off=true remain halted and
>> repeatedly call kvm_cpu_exec() which returns EXCP_HLT. Each iteration held
>> the BQL, preventing other operations from proceeding.
>>
> 
> AFAIU, with halted=1, the thread should be waiting at the
> qemu_process_cpu_events() qemu_cond_wait invocation which will release
> the BQL during the wait.
> 
> What is your irqchip setting? on/off/split? Aren't you just hitting the
> early return at do_kvm_irqchip_create()? The refactoring from commit
> 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file
> descriptor change") made it so a few lines that would have been skipped
> are now executed.
> 
> In this case, probably kvm_halt_in_kernel_allowed=true is making
> cpu_thread_is_idle() return false and skip the wait at
> qemu_process_cpu_events().

You caught it right, the early return changed the behaviour with the
commit mentioned. I just tried with below change which retains the
behaviour prior to the commit mentioned and it works as expected (no 
more BQL deadlocks).

Ani, would you like to post the patch fixing the behaviour change
introduced with commit 98884e0cc1 or I can send below patch if looks fine?

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 774499d34f..a388c00d71 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, 
qemu_irq irq, int gsi)
      g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
  }

-static void do_kvm_irqchip_create(KVMState *s)
+static int do_kvm_irqchip_create(KVMState *s)
  {
      int ret;
      if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
@@ -2587,7 +2587,7 @@ static void do_kvm_irqchip_create(KVMState *s)
              exit(1);
          }
      } else {
-        return;
+        return -1;
      }

      if (kvm_check_extension(s, KVM_CAP_IRQFD) <= 0) {
@@ -2610,13 +2610,17 @@ static void do_kvm_irqchip_create(KVMState *s)
          fprintf(stderr, "Create kernel irqchip failed: %s\n", 
strerror(-ret));
          exit(1);
      }
+    return 0;
  }

  static void kvm_irqchip_create(KVMState *s)
  {
      assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
-
-    do_kvm_irqchip_create(s);
+    int ret = 0;
+
+    ret = do_kvm_irqchip_create(s);
+    if (ret < 0)
+        return;
      kvm_kernel_irqchip = true;
      /* If we have an in-kernel IRQ chip then we must have asynchronous
       * interrupt delivery (though the reverse is not necessarily true)


> 
>> The fix has two parts:
>>
>> 1. In kvm_cpu_exec() (kvm-all.c):
>>     Release the BQL before returning EXCP_HLT in the early return path,
>>     matching the behavior of the normal execution path where bql_unlock()
>>     is called before entering the main KVM execution loop.
>>
>> 2. In kvm_vcpu_thread_fn() (kvm-accel-ops.c):
>>     Re-acquire the BQL after kvm_cpu_exec() returns EXCP_HLT, since the
>>     loop expects to hold the BQL when calling kvm_cpu_exec() again.
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
>> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
>> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   accel/kvm/kvm-accel-ops.c | 4 ++++
>>   accel/kvm/kvm-all.c       | 1 +
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
>> index 6d9140e549..d684fd0840 100644
>> --- a/accel/kvm/kvm-accel-ops.c
>> +++ b/accel/kvm/kvm-accel-ops.c
>> @@ -52,6 +52,10 @@ static void *kvm_vcpu_thread_fn(void *arg)
>>   
>>           if (cpu_can_run(cpu)) {
>>               r = kvm_cpu_exec(cpu);
>> +            if (r == EXCP_HLT) {
>> +                /* kvm_cpu_exec() released BQL, re-acquire for next iteration */
>> +                bql_lock();
>> +            }
>>               if (r == EXCP_DEBUG) {
>>                   cpu_handle_guest_debug(cpu);
>>               }
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 774499d34f..00b8018664 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -3439,6 +3439,7 @@ int kvm_cpu_exec(CPUState *cpu)
>>       trace_kvm_cpu_exec();
>>   
>>       if (kvm_arch_process_async_events(cpu)) {
>> +        bql_unlock();
>>           return EXCP_HLT;
>>       }


