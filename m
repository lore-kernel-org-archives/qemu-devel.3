Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4704C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgwb-0003kJ-IJ; Fri, 03 Jul 2026 12:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgwZ-0003gJ-ST
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:40:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgwL-0000tF-A7
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:40:47 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIkLA511251
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N1PBqMH+hLMejvI1ptL3ZXYqZI8VHjW54Lgdz3rihtM=; b=QoFiyv9KqGwJdmuf
 BjzXi5Z7wBmp8UcqrrJvzplUKi1nJcOTSkWyomNOLFc5g0vn0E/A7llcJKNtbH7R
 xETGFkOF59a4r7dxoSLFMXj48d+CZlB/bbrr1ijl/OVtV+7uohGuWMWJKLU1CxTw
 d5o6gxe1hOrKosnER/QkwxhTLt/cbcUTXnmJbl2ySQCarNxPoAgMrEm5xR7TdZUD
 e9CRYNX1W5dWC0P0MYHXB+tyANIEjif8BryfUnnbNj0LHELTXH13dESWkhCaS/Bb
 T+BzWnlOIHiVWHthimNTaH0yu57HFqh9ARoD8AKx4CbbYc6+prk/cOMMe3jHdFIm
 3O7WEg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6a849k8n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:40:31 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8eac2620cb0so9554406d6.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096831; x=1783701631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1PBqMH+hLMejvI1ptL3ZXYqZI8VHjW54Lgdz3rihtM=;
 b=kueoiU78+ahrfFgexWQf4+b8OdzwGgojMQA1XxbKlwfx+h/Mo1zg5xpGCaZHiQpOBd
 xS7BC2ev9uL94D9QE/cfiks1PQjtpqtka19foBZC93aQREW34OKM9ST0SIrPBvyg+n6s
 NOPCim2xTex7JKWscLde64nZU60sMucql79O2k6G5jY2huvXdhloHYXQ4zkXBWB+gkcq
 /VhyDnKIZcM4SzJzk44b3KmC4NwcoosWxAZas2HZ3UUzlvHyOoUDMRug2bE0RbfEM7FH
 8ytYkkl3h5Y8RHInhkC7hZYvSC6XgQIrM4tZFjBIQC25yTLjeuUwyfIGYvvGUfxQzjnJ
 Q1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096831; x=1783701631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N1PBqMH+hLMejvI1ptL3ZXYqZI8VHjW54Lgdz3rihtM=;
 b=hGcl8E8katST6aWREAsqEnAoIMtbGEFRpGf+QetT8WV6SuAq7KxD+5SNhyH3urBldo
 Rbd1337us1zDq7A1Xuw+68sm7JZ7l7QHxgohmvZZVbAUHR0JlQbPGNp2mSttC9NOaEZO
 hzZlbn9OnNIoIQel3wXaMVOabt4Fl71sp+JovKcrpkEFz0yU6VK9rTv+a+2xwG84Wtgu
 9eJFE4FVOAYI5ZCHgK6zNKCMObYW+VwMBwr+RKE+S7RIA2D4ruhQew3UoqBEDBPaALUE
 h7lAqWhlqTc42LTiGTnh0udQiE0YFWkTS9tVnYELPHsY1Ueyc3rkOb2dX3szhB0l62+n
 gp6g==
X-Gm-Message-State: AOJu0YwcDNdzMgcp3c/p1VbY4mEJAQJL485G9MDsaueiAbS1yw0KfFmZ
 gPjANserPKhfMxLd0BGIC+19yt4aYKJ/GKz28qoQMpM3SzY6b7Te3nXX3gZktDfvgs6Wax5RH0+
 CPqUTJ2Z2W7mYnXKNsp3HS3X75TW6sK6LIgU4D7ECrg6vFfxHhwBS6TVvnR0TFsrFTg==
X-Gm-Gg: AfdE7cm77rBv6RgR4lxqQZqHk93aT7vM4jrq0Nbr8LNdTdhtdSpNmpb2ZUWoC6xIiaQ
 95h/aZ9cH/6rIZ3xkn1h7ryOh4a8Ls2O76VEfC7AkyXW/F34Oe5MH14ZvtuULPSFtp6gyXwoQVr
 Xf8KJ9TGW5B0ABeMF+Zd1UN8kJDK3yqbYX+J5O+f/uowP9zH48cD4lr2A/B+UApVlH+NDSsz2mF
 3QGChiCcHDJzRPzKPl5JjNrSNzuKbKLE12uwm3LCZSRbKmiZkbNGu+M/iz+/WZ4Ys46zSqIU/tu
 7+rwhdtf7zJoXycZftusrgIyp6SHS/cQ+F6H7I+99AMt+PUlN0TFu4Yt+6BJqDln24zmA3AIQcl
 rRMNFe0rpk/UuPH2H/hz8uxY4yS5ZpDggjYkaGwYYsBy8qXJ9q/fsZ+fQRkK4C1KjNInk
X-Received: by 2002:a05:620a:4441:b0:92e:779a:fec6 with SMTP id
 af79cd13be357-92e9a4d1e4bmr25083085a.52.1783096830385; 
 Fri, 03 Jul 2026 09:40:30 -0700 (PDT)
X-Received: by 2002:a05:620a:4441:b0:92e:779a:fec6 with SMTP id
 af79cd13be357-92e9a4d1e4bmr25076385a.52.1783096829671; 
 Fri, 03 Jul 2026 09:40:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef23feasm177494755e9.2.2026.07.03.09.40.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:40:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 20/33] cpu: Define BreakpointFlags type
Date: Fri,  3 Jul 2026 18:37:43 +0200
Message-ID: <20260703163757.55500-21-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7x7lAsny2AWwix1D4i3cmvazh-FDJrNF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX55Oc2MwKrlcV
 aeUjWV/038dBeacWWSsisddo140hAjuDdqZyPm0XrJggHKrbPwqkbhx8F17J10byIJvBSlaxUfR
 AXlbW35qzGcYQtKw+GgX10TdNvSCMaM=
X-Authority-Analysis: v=2.4 cv=a6QAM0SF c=1 sm=1 tr=0 ts=6a47e5ff cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=9jKa8Ys6bur2UUCdWgEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX24QieQsUpUlX
 IISatDF5NQgcPrCGq0+xcNgMv2h1eB1JLZ9unexLvv8o+gr0tsl0zacAZ3PTZEuoHJG+Q6IBJB8
 /ekcCjKFfaQMvaxrg+0bYG0XWj5sWJSgepT2/nvjj78whyHcreetQTg6EfFefpGwlZp79hWuA1q
 EGA25VYupUsMWEBX76/vF4tiVeOe3Q+/M/d4Hyx2B/ufKwngdA/xPsymm8QVUkvS+tdUjPmV+/E
 8mlnbL1LoSMZVSNme9M9Opn1hP+ObPNYI+BA08FBnzl0knFrj4xkAwQP66Y83knBiKIMx6x3bg0
 BMkonsZZ4Migrr0Fpr8GP20U5+O8ZywELSu7yEsCJo3onprBzGJ9WONHPftZlOzRXKCjdvBuYSQ
 nmI+7ogFZmqEeMDMsGTYaj4aJOQAfc4u2O+AB5aq13vuETPkNpv96fz6d0gF86fhfqrWz/W4oOY
 xSZzluW3IH6jKpQI58g==
X-Proofpoint-ORIG-GUID: 7x7lAsny2AWwix1D4i3cmvazh-FDJrNF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use the BreakpointFlags typedef to better follow when
we deal with breakpoint flags (BP_*).

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h |  6 ++++--
 include/exec/breakpoint.h   |  3 ++-
 include/exec/watchpoint.h   |  8 +++++---
 include/hw/core/cpu.h       |  8 ++++----
 accel/tcg/cputlb.c          | 12 +++++++-----
 accel/tcg/tcg-accel-ops.c   | 10 +++++-----
 accel/tcg/user-exec-stub.c  | 11 ++++++-----
 accel/tcg/watchpoint.c      |  9 +++++----
 cpu-common.c                | 12 ++++++------
 system/watchpoint.c         |  8 ++++----
 target/arm/tcg/debug.c      |  4 ++--
 target/arm/tcg/mte_helper.c |  3 ++-
 target/ppc/cpu.c            |  2 +-
 target/ppc/kvm.c            |  5 +++--
 target/riscv/cpu_helper.c   |  2 +-
 target/riscv/debug.c        | 12 +++++-------
 target/s390x/tcg/debug.c    |  3 ++-
 target/xtensa/dbg_helper.c  |  2 +-
 18 files changed, 65 insertions(+), 55 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 710da12b828..f64d94b2b50 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -298,7 +298,8 @@ struct TCGCPUOps {
  * specified by @flags.  Exit via exception with a hit.
  */
 void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
-                          MemTxAttrs attrs, int flags, uintptr_t ra);
+                          MemTxAttrs attrs, BreakpointFlags flags,
+                          uintptr_t ra);
 
 /**
  * cpu_watchpoint_address_matches:
@@ -309,7 +310,8 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
  * Return the watchpoint flags that apply to [addr, addr+len).
  * If no watchpoint is registered for the range, the result is 0.
  */
-int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);
+BreakpointFlags cpu_watchpoint_address_matches(CPUState *cpu,
+                                               vaddr addr, vaddr len);
 
 /*
  * Common pointer_wrap implementations.
diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
index cc6fedd09fe..0c3cc0c8ff3 100644
--- a/include/exec/breakpoint.h
+++ b/include/exec/breakpoint.h
@@ -12,6 +12,7 @@
 #include "exec/vaddr.h"
 #include "exec/memattrs.h"
 
+typedef int BreakpointFlags;
 /* Breakpoint/watchpoint flags */
 #define BP_MEM_READ           0x01
 #define BP_MEM_WRITE          0x02
@@ -28,7 +29,7 @@
 
 typedef struct CPUBreakpoint {
     vaddr pc;
-    int flags; /* BP_* */
+    BreakpointFlags flags;
     QTAILQ_ENTRY(CPUBreakpoint) entry;
 } CPUBreakpoint;
 
diff --git a/include/exec/watchpoint.h b/include/exec/watchpoint.h
index c4d069425ba..ba148eff3d1 100644
--- a/include/exec/watchpoint.h
+++ b/include/exec/watchpoint.h
@@ -8,11 +8,13 @@
 #ifndef EXEC_WATCHPOINT_H
 #define EXEC_WATCHPOINT_H
 
+#include "exec/breakpoint.h"
+
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          int flags, CPUWatchpoint **watchpoint);
+                          BreakpointFlags flags, CPUWatchpoint **watchpoint);
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
-                          vaddr len, int flags);
+                          vaddr len, BreakpointFlags flags);
 void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
-void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
+void cpu_watchpoint_remove_all(CPUState *cpu, BreakpointFlags flags);
 
 #endif /* EXEC_WATCHPOINT_H */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index e5b68bced3d..77884b827aa 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1138,12 +1138,12 @@ void qemu_init_vcpu(CPUState *cpu);
  */
 void cpu_single_step(CPUState *cpu, int enabled);
 
-int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
+int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
                           CPUBreakpoint **breakpoint);
-int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags);
+int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, BreakpointFlags flags);
 void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint);
-void cpu_breakpoint_remove_all(CPUState *cpu, int mask);
-bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask);
+void cpu_breakpoint_remove_all(CPUState *cpu, BreakpointFlags flags);
+bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, BreakpointFlags flags);
 
 /**
  * cpu_get_address_space:
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7f7c208ba12..e2911e3aac6 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1033,7 +1033,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     CPUTLBEntry *te, tn;
     hwaddr iotlb, xlat, sz, paddr_page;
     vaddr addr_page;
-    int asidx, wp_flags, prot;
+    int asidx, prot;
+    BreakpointFlags wp_flags;
     bool is_ram, is_romd;
 
     assert_cpu_is_self(cpu);
@@ -1499,8 +1500,8 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
     if (unlikely(flags & (TLB_NOTDIRTY | TLB_WATCHPOINT))) {
         /* Handle watchpoints.  */
         if (flags & TLB_WATCHPOINT) {
-            int wp_access = (access_type == MMU_DATA_STORE
-                             ? BP_MEM_WRITE : BP_MEM_READ);
+            BreakpointFlags wp_access = (access_type == MMU_DATA_STORE
+                                        ? BP_MEM_WRITE : BP_MEM_READ);
             cpu_check_watchpoint(env_cpu(env), addr, size,
                                  full->attrs, wp_access, retaddr);
         }
@@ -1702,7 +1703,8 @@ static void mmu_watch_or_dirty(CPUState *cpu, MMULookupPageData *data,
 
     /* On watchpoint hit, this will longjmp out.  */
     if (flags & TLB_WATCHPOINT) {
-        int wp = access_type == MMU_DATA_STORE ? BP_MEM_WRITE : BP_MEM_READ;
+        BreakpointFlags wp = access_type == MMU_DATA_STORE ? BP_MEM_WRITE
+                                                           : BP_MEM_READ;
         cpu_check_watchpoint(cpu, addr, size, full->attrs, wp, ra);
         flags &= ~TLB_WATCHPOINT;
     }
@@ -1885,7 +1887,7 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
     }
 
     if (unlikely(tlb_addr & TLB_WATCHPOINT)) {
-        int wp_flags = 0;
+        BreakpointFlags wp_flags = 0;
 
         if (full->slow_flags[MMU_DATA_STORE] & TLB_WATCHPOINT) {
             wp_flags |= BP_MEM_WRITE;
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 927af6c1db0..26d34c72d9a 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -110,20 +110,20 @@ void tcg_handle_interrupt(CPUState *cpu, int mask)
 }
 
 /* Translate GDB watchpoint type to a flags value for cpu_watchpoint_* */
-static inline int xlat_gdb_type(CPUState *cpu, int gdbtype)
+static inline BreakpointFlags xlat_gdb_type(CPUState *cpu, int gdbtype)
 {
-    static const int xlat[] = {
+    static const BreakpointFlags xlat[] = {
         [GDB_WATCHPOINT_WRITE]  = BP_GDB | BP_MEM_WRITE,
         [GDB_WATCHPOINT_READ]   = BP_GDB | BP_MEM_READ,
         [GDB_WATCHPOINT_ACCESS] = BP_GDB | BP_MEM_ACCESS,
     };
 
-    int cputype = xlat[gdbtype];
+    BreakpointFlags cpuflags = xlat[gdbtype];
 
     if (cpu->cc->gdb_stop_before_watchpoint) {
-        cputype |= BP_STOP_BEFORE_ACCESS;
+        cpuflags |= BP_STOP_BEFORE_ACCESS;
     }
-    return cputype;
+    return cpuflags;
 }
 
 static int tcg_insert_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 28286e11a60..7b6c25c4738 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -22,13 +22,13 @@ void cpu_exec_reset_hold(CPUState *cpu)
 }
 
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          int flags, CPUWatchpoint **watchpoint)
+                          BreakpointFlags flags, CPUWatchpoint **watchpoint)
 {
     return -ENOSYS;
 }
 
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
-                          vaddr len, int flags)
+                          vaddr len, BreakpointFlags flags)
 {
     return -ENOSYS;
 }
@@ -37,17 +37,18 @@ void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *wp)
 {
 }
 
-void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
+void cpu_watchpoint_remove_all(CPUState *cpu, BreakpointFlags flags)
 {
 }
 
-int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
+BreakpointFlags cpu_watchpoint_address_matches(CPUState *cpu,
+                                               vaddr addr, vaddr len)
 {
     return 0;
 }
 
 void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
-                          MemTxAttrs atr, int fl, uintptr_t ra)
+                          MemTxAttrs atr, BreakpointFlags flags, uintptr_t ra)
 {
 }
 
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index c75ed278459..5ea66e9763a 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -52,10 +52,11 @@ static inline bool watchpoint_address_matches(CPUWatchpoint *wp,
 }
 
 /* Return flags for watchpoints that match addr + prot.  */
-int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
+BreakpointFlags cpu_watchpoint_address_matches(CPUState *cpu,
+                                               vaddr addr, vaddr len)
 {
     CPUWatchpoint *wp;
-    int ret = 0;
+    BreakpointFlags ret = 0;
 
     QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
         if (watchpoint_address_matches(wp, addr, len)) {
@@ -67,7 +68,7 @@ int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
 
 /* Generate a debug exception if a watchpoint has been hit.  */
 void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
-                          MemTxAttrs attrs, int flags, uintptr_t ra)
+                          MemTxAttrs attrs, BreakpointFlags flags, uintptr_t ra)
 {
     CPUWatchpoint *wp;
 
@@ -91,7 +92,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
 
     assert((flags & ~BP_MEM_ACCESS) == 0);
     QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
-        int hit_flags = wp->flags & flags;
+        BreakpointFlags hit_flags = wp->flags & flags;
 
         if (hit_flags && watchpoint_address_matches(wp, addr, len)) {
             if (replay_running_debug()) {
diff --git a/cpu-common.c b/cpu-common.c
index adb76b3a786..69ddf15b46a 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -389,13 +389,13 @@ void process_queued_cpu_work(CPUState *cpu)
 }
 
 /* Return true if PC matches an installed breakpoint.  */
-bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
+bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, BreakpointFlags flags)
 {
     CPUBreakpoint *bp;
 
     if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
         QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-            if (bp->pc == pc && (bp->flags & mask)) {
+            if (bp->pc == pc && (bp->flags & flags)) {
                 return true;
             }
         }
@@ -404,7 +404,7 @@ bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
 }
 
 /* Add a breakpoint.  */
-int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
+int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, BreakpointFlags flags,
                           CPUBreakpoint **breakpoint)
 {
     CPUBreakpoint *bp;
@@ -434,7 +434,7 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
 }
 
 /* Remove a specific breakpoint.  */
-int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags)
+int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, BreakpointFlags flags)
 {
     CPUBreakpoint *bp;
 
@@ -461,12 +461,12 @@ void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *bp)
 }
 
 /* Remove all matching breakpoints. */
-void cpu_breakpoint_remove_all(CPUState *cpu, int mask)
+void cpu_breakpoint_remove_all(CPUState *cpu, BreakpointFlags flags)
 {
     CPUBreakpoint *bp, *next;
 
     QTAILQ_FOREACH_SAFE(bp, &cpu->breakpoints, entry, next) {
-        if (bp->flags & mask) {
+        if (bp->flags & flags) {
             cpu_breakpoint_remove_by_ref(cpu, bp);
         }
     }
diff --git a/system/watchpoint.c b/system/watchpoint.c
index 21d0bb36cae..f96aa24210f 100644
--- a/system/watchpoint.c
+++ b/system/watchpoint.c
@@ -26,7 +26,7 @@
 
 /* Add a watchpoint.  */
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                          int flags, CPUWatchpoint **watchpoint)
+                          BreakpointFlags flags, CPUWatchpoint **watchpoint)
 {
     CPUWatchpoint *wp;
     vaddr in_page;
@@ -65,7 +65,7 @@ int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
 
 /* Remove a specific watchpoint.  */
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr, vaddr len,
-                          int flags)
+                          BreakpointFlags flags)
 {
     CPUWatchpoint *wp;
 
@@ -90,12 +90,12 @@ void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint)
 }
 
 /* Remove all matching watchpoints.  */
-void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
+void cpu_watchpoint_remove_all(CPUState *cpu, BreakpointFlags flags)
 {
     CPUWatchpoint *wp, *next;
 
     QTAILQ_FOREACH_SAFE(wp, &cpu->watchpoints, entry, next) {
-        if (wp->flags & mask) {
+        if (wp->flags & flags) {
             cpu_watchpoint_remove_by_ref(cpu, wp);
         }
     }
diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 07a52643e71..11043ecd589 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -550,7 +550,7 @@ void hw_watchpoint_update(ARMCPU *cpu, int n)
     vaddr wvr = env->cp15.dbgwvr[n];
     uint64_t wcr = env->cp15.dbgwcr[n];
     int mask;
-    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
+    BreakpointFlags flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
 
     if (env->cpu_watchpoint[n]) {
         cpu_watchpoint_remove_by_ref(CPU(cpu), env->cpu_watchpoint[n]);
@@ -656,7 +656,7 @@ void hw_breakpoint_update(ARMCPU *cpu, int n)
     uint64_t bcr = env->cp15.dbgbcr[n];
     vaddr addr;
     int bt;
-    int flags = BP_CPU;
+    BreakpointFlags flags = BP_CPU;
 
     if (env->cpu_breakpoint[n]) {
         cpu_breakpoint_remove_by_ref(CPU(cpu), env->cpu_breakpoint[n]);
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index dca4ef5a942..17f920b3f35 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -190,7 +190,8 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
 
     /* Any debug exception has priority over a tag check exception. */
     if (!probe && unlikely(flags & TLB_WATCHPOINT)) {
-        int wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ : BP_MEM_WRITE;
+        BreakpointFlags wp = ptr_access == MMU_DATA_LOAD ? BP_MEM_READ
+                                                         : BP_MEM_WRITE;
         assert(ra != 0);
         cpu_check_watchpoint(env_cpu(env), ptr, ptr_size, attrs, wp, ra);
     }
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 41edb18643d..913920d55b8 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -145,7 +145,7 @@ void ppc_update_daw(CPUPPCState *env, int rid)
     bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
     bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
     vaddr len;
-    int flags;
+    BreakpointFlags flags;
 
     if (env->dawr_watchpoint[rid]) {
         cpu_watchpoint_remove_by_ref(cs, env->dawr_watchpoint[rid]);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index b94c2997a07..2a3711fb1df 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1429,7 +1429,7 @@ static int find_hw_breakpoint(target_ulong addr, int type)
     return -1;
 }
 
-static int find_hw_watchpoint(target_ulong addr, int *flag)
+static int find_hw_watchpoint(target_ulong addr, BreakpointFlags *flag)
 {
     int n;
 
@@ -1575,7 +1575,6 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
 {
     int handle = DEBUG_RETURN_GUEST;
     int n;
-    int flag = 0;
 
     if (nb_hw_breakpoint + nb_hw_watchpoint > 0) {
         if (arch_info->status & KVMPPC_DEBUG_BREAKPOINT) {
@@ -1585,6 +1584,8 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
             }
         } else if (arch_info->status & (KVMPPC_DEBUG_WATCH_READ |
                                         KVMPPC_DEBUG_WATCH_WRITE)) {
+            BreakpointFlags flag = 0;
+
             n = find_hw_watchpoint(arch_info->address,  &flag);
             if (n >= 0) {
                 handle = DEBUG_RETURN_GDB;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2db07f5dfb6..c318dcd633c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -2000,7 +2000,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     } else if (probe) {
         return false;
     } else {
-        int wp_access = 0;
+        BreakpointFlags wp_access = 0;
 
         if (access_type == MMU_DATA_LOAD) {
             wp_access |= BP_MEM_READ;
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index ba5bc6ae13d..082ced71bb7 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -480,7 +480,7 @@ static void type2_breakpoint_insert(CPURISCVState *env, target_ulong index)
     target_ulong addr = env->tdata2[index];
     bool enabled = type2_breakpoint_enabled(ctrl);
     CPUState *cs = env_cpu(env);
-    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
+    BreakpointFlags flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
     uint32_t size, def_size;
 
     if (!enabled) {
@@ -605,7 +605,7 @@ static void type6_breakpoint_insert(CPURISCVState *env, target_ulong index)
     target_ulong addr = env->tdata2[index];
     bool enabled = type6_breakpoint_enabled(ctrl);
     CPUState *cs = env_cpu(env);
-    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
+    BreakpointFlags flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
     uint32_t size;
 
     if (!enabled) {
@@ -993,12 +993,10 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     CPURISCVState *env = &cpu->env;
     target_ulong ctrl;
     target_ulong addr;
-    int trigger_type;
-    int flags;
-    int i;
 
-    for (i = 0; i < env->num_triggers; i++) {
-        trigger_type = get_trigger_type(env, i);
+    for (int i = 0; i < env->num_triggers; i++) {
+        int trigger_type = get_trigger_type(env, i);
+        BreakpointFlags flags;
 
         if (!trigger_common_match(env, trigger_type, i)) {
             continue;
diff --git a/target/s390x/tcg/debug.c b/target/s390x/tcg/debug.c
index 99140b1ac9a..d10e9ed8922 100644
--- a/target/s390x/tcg/debug.c
+++ b/target/s390x/tcg/debug.c
@@ -14,7 +14,8 @@
 
 void s390_cpu_recompute_watchpoints(CPUState *cs)
 {
-    const int wp_flags = BP_CPU | BP_MEM_WRITE | BP_STOP_BEFORE_ACCESS;
+    const BreakpointFlags wp_flags = BP_CPU | BP_MEM_WRITE
+                                     | BP_STOP_BEFORE_ACCESS;
     CPUS390XState *env = cpu_env(cs);
 
     /* We are called when the watchpoints have changed. First
diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
index 3b91f7c38ac..990012f60e6 100644
--- a/target/xtensa/dbg_helper.c
+++ b/target/xtensa/dbg_helper.c
@@ -85,7 +85,7 @@ static void set_dbreak(CPUXtensaState *env, unsigned i, uint32_t dbreaka,
         uint32_t dbreakc)
 {
     CPUState *cs = env_cpu(env);
-    int flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
+    BreakpointFlags flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
     uint32_t mask = dbreakc | ~DBREAKC_MASK;
 
     if (env->cpu_watchpoint[i]) {
-- 
2.53.0


