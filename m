Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F02EF4EC8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 08:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9fjS-0001Zx-52; Mon, 06 Apr 2026 04:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1w9fjP-0001Z7-M4; Mon, 06 Apr 2026 04:54:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1w9fjN-0004Q7-U0; Mon, 06 Apr 2026 04:54:51 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6362tbbm4143886; Mon, 6 Apr 2026 08:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=oDG+1I
 R8bz/XmayiwvjFBgbm2EqbPnEiNImi03vhj64=; b=bzQjdD4tvawAbUWUDJBDNF
 wOBZYJkrV/h2WQiK1IAalA7we3fFxPYpa6zl6DmKU/MeuYoIF+KC3edMZ4+DZ3hz
 aJfPHgUjaQ/cWLMbF2YGUpJKNj4ciRpewEt0+0pnIL4v4/HPqKKf6HUiMfyySXKD
 I4O2HErn1HVgzxIu25ROK8gUeUmuOnLQwbWjxW5n2N3PCxSEr9x+6yvGtNRiavAj
 Jt/F4xp6TA+C7ERzeWM338VSjzE/yDLSFWk1edWkXKsCyY0vaH0nUkBSgZUJmLTE
 ArDuVygH4/O/oApn4GmlQuJfOUDOz0YxjniEEhPDdQz1U+uZQyr83crNeslSvbCA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4das2bwfyg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Apr 2026 08:54:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6365aDAG020298;
 Mon, 6 Apr 2026 08:54:45 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dbdync0s0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Apr 2026 08:54:45 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6368shfC7537190
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Apr 2026 08:54:44 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8F68580AF;
 Mon,  6 Apr 2026 08:54:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36650580B0;
 Mon,  6 Apr 2026 08:54:43 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Apr 2026 08:54:43 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 06 Apr 2026 14:24:42 +0530
From: Misbah Anjum N <misanjum@linux.ibm.com>
To: Ani Sinha <anisinha@redhat.com>, Pbonzini <pbonzini@redhat.com>, Qemu
 Devel <qemu-devel@nongnu.org>, Qemu Ppc <qemu-ppc@nongnu.org>
Cc: npiggin@gmail.com, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com
Subject: Re: [BUG] [powerpc] KVM guest boot failure - hangs on startup after
 commit 98884e0c
In-Reply-To: <DCB3A7E9-412C-402D-A4C9-EA558CD1FE29@redhat.com>
References: <e0fa0840fa7758499aa8c64a148e5367@linux.ibm.com>
 <2cc23a5ce64847dd8a9278c87f58119b@linux.ibm.com>
 <5bc7997d-329e-47a9-9b4d-750a3104094a@linux.ibm.com>
 <4797B580-7853-490E-8852-B6312619FE95@redhat.com>
 <e966c053-2e69-b185-532e-fcb4173b4daf@redhat.com>
 <b088f554af34cbcc4d88271e227074e1@linux.ibm.com>
 <ED4A083D-2B96-468A-BE77-211E9F3FA88D@redhat.com>
 <7bbeb3cb105934e95bf1a5356cfc4613@linux.ibm.com>
 <7ACBCD63-B759-47FD-824F-0327726E47F6@redhat.com>
 <35f6361f69ef4f09f80bd915f3460a28@linux.ibm.com>
 <B2B682DB-1467-4C42-AF74-346BC61DE31B@redhat.com>
 <526d7172f3933baf913bf4b105a6fa9a@linux.ibm.com>
 <9794AFF9-DFD9-48D0-B4EA-7745ABDED6F7@redhat.com>
 <DCB3A7E9-412C-402D-A4C9-EA558CD1FE29@redhat.com>
Message-ID: <ab72cb8395bcc2b1f489c5611bb7c00d@linux.ibm.com>
X-Sender: misanjum@linux.ibm.com
Organization: IBM
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 7uPK7diby7oWe1YGlHDNfWWgsO9X8u3B
X-Proofpoint-GUID: CgrWcfld9QKffDhuWAiv6kLjV9iF0BWC
X-Authority-Analysis: v=2.4 cv=U9qfzOru c=1 sm=1 tr=0 ts=69d374d6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=zYzd7YLIzAHjMBLa044A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA4NSBTYWx0ZWRfX1ULnp2n/G+cz
 24zlWlSSBV08pJjzWAUvDPOCB2W97yYbnVV8qc1SKxnAKzU2bmH7KsQiWw7F4dpsHPypys7ctL0
 1cZIINm45Jqlta+ccH8/4a902UYstEHWpjPW8fkp1xpdbpsqUBkhTUftrPNcNMRs4pEA3qWZxdZ
 ekf7XMYdxNNtQ+4ZGxVKchMzcWM2qGl/spK5VHZd1KPQoFp3ythDG4U33wyk04NJKHEcFA0gTYI
 yHV3eoLGu+4VQEe19E0lthvTVH4cmauJWFvfdMsR+x9n+s1B9N2EF6p7SNabZ63SXse70ua8rCi
 2Rhc/d4KXPBG8B7Sd5t3XspUweuW8ZF3B0YopR0CMPZztV9PuWGxAL9j7iZ2zxo8hYz3CV1H95o
 IC7tyuigKNpHiTd7MpQZB9KbvC1WvQFtv8LRkB16WnzE1IYLn/ABwhiFX9xdbdxjuPWDQGS3utK
 hLcsTODJCa6OYXZk+Ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060085
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=misanjum@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
I've completed the testing you suggested. Unfortunately, the SMP hang 
still persists with these changes.

Changes made:
As requested, I reverted everything in stubs/kvm.c and the related 
changes in stubs/meson.build, include/system/kvm.h, and 
target/i386/kvm/kvm.c. I also commented out the calls to 
kvm_arch_supports_vmfd_change() and kvm_arch_on_vmfd_change() in 
kvm_reset_vmfd().

Test result:
The issue persists - guests still hang indefinitely during boot when SMP 
is configured.

Git diff:
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index cc5c42ce4d..04b9cbe7c9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2622,11 +2622,12 @@ static int kvm_reset_vmfd(MachineState *ms)
       * bail if the current architecture does not support VM file
       * descriptor change.
       */
-    if (!kvm_arch_supports_vmfd_change()) {
+    /*if (!kvm_arch_supports_vmfd_change()) {
          error_report("This target architecture does not support KVM VM 
"
                       "file descriptor change.");
          return -EOPNOTSUPP;
      }
+    */

      s = KVM_STATE(ms->accelerator);
      kml = &s->memory_listener;
@@ -2659,10 +2660,10 @@ static int kvm_reset_vmfd(MachineState *ms)
      }
      assert(!err);

-    ret = kvm_arch_on_vmfd_change(ms, s);
+    /*ret = kvm_arch_on_vmfd_change(ms, s);
      if (ret < 0) {
          return ret;
-    }
+    }*/

      if (s->kernel_irqchip_allowed) {
          do_kvm_irqchip_create(s);

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5fc7251fd9..0dad0079ed 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -456,8 +456,6 @@ int kvm_physical_memory_addr_from_host(KVMState *s, 
void *ram_addr,

  #endif /* COMPILING_PER_TARGET */

-bool kvm_arch_supports_vmfd_change(void);
-int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s);

  void kvm_cpu_synchronize_state(CPUState *cpu);

diff --git a/stubs/kvm.c b/stubs/kvm.c
deleted file mode 100644
index 2db61d89a7..0000000000
--- a/stubs/kvm.c
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * kvm target arch specific stubs
- *
- * Copyright (c) 2026 Red Hat, Inc.
- *
- * Author:
- *   Ani Sinha <anisinha@redhat.com>
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-#include "qemu/osdep.h"
-#include "system/kvm.h"
-
-int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s)
-{
-    abort();
-}
-
-bool kvm_arch_supports_vmfd_change(void)
-{
-    return false;
-}

diff --git a/stubs/meson.build b/stubs/meson.build
index 6ae478bacc..8a07059500 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -74,7 +74,6 @@ if have_system
    if igvm.found()
      stub_ss.add(files('igvm.c'))
    endif
-  stub_ss.add(files('kvm.c'))
    stub_ss.add(files('target-get-monitor-def.c'))
    stub_ss.add(files('target-monitor-defs.c'))
    stub_ss.add(files('win32-kbd-hook.c'))

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 524b5276a6..3dfd9a5974 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3389,15 +3389,6 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
      return 0;
  }

-int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s)
-{
-    abort();
-}
-
-bool kvm_arch_supports_vmfd_change(void)
-{
-    return false;
-}

  int kvm_arch_init(MachineState *ms, KVMState *s)
  {


I've also tested with the latest QEMU build from master, and the issue 
still persists there as well. Could you suggest what additional 
debugging steps I should take to help identify the root cause?

Thanks,
Misbah Anjum N <misanjum@linux.ibm.com>


On 2026-03-18 15:00, Ani Sinha wrote:
> One possible thing to try is:
> 
> Revert everything in stubs/kvm.c and hence changes in
> stubs/meson.build, include/system/kvm.h and in target/i386/kvm/kvm.c
> introduced by 98884e0cc1 .
> You will have to comment out calls to kvm_arch_supports_vmfd_change()
> and kvm_arch_on_vmfd_change() in kvm_reset_vmfd(). Since
> kvm_reset_vmfd() is not called anyway, not should make no difference
> if those calls are commented out.
> 
> Let me know what you get after doing the above.

