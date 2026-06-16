Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E34CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVou-00024N-AK; Tue, 16 Jun 2026 11:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVos-000234-O8
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:35:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVoq-0005IB-SM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:35:18 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GDxlAl3970296
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nYrBXz9JCsBBTqmEmF5WL2AQ9KJg8a+iVzB8DU5JPw0=; b=APD+rZiB8jtSXB6p
 Pckjavi15oj1H91JiIPX9ZEgB5e1+/YU1roM2ItquBgd6eCpBqVWw7u73Q/UEpyo
 q5nmOZomXB3tPJGjrACJHYoJ1gEk3jyyModAomkSsHEqMeLkYwMXvVn5HHREruLu
 aGbF4y5umHjLiUlOKw1qBtV22fxHtFIPvftsQImZCDD910CFuO9WEbKlC5BpfJT/
 7VnJtviukH468r3CgHmTescZBUDd6pkrVoMpTjYEI2AEQNRMUHwknUSuW6uVNY44
 6kcIX7bg+E7Aekidm95Gqt7BBZgt/QcKbXOEP98XhjXO5Lsos0Dlp9DsjwdnmsX+
 qqQBfQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu4dkhgrg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:35:15 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5a10b940840so6046415e0c.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781624115; x=1782228915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nYrBXz9JCsBBTqmEmF5WL2AQ9KJg8a+iVzB8DU5JPw0=;
 b=CVhgcP6s/cJVsCgdAW/gHn4QxEs59W70ZxmOf//PXQvusi8KHuLxZCejWhndKtYqiG
 oflvp3kfboFZu3uX8n3eLSwXOfwfqXVcRpwjAnGY22P5YHtR9kkpn5IBrCJWQX8Ej9KE
 dCN3bs9KY+6GNPJQ3jECvBcSUoyCZ7FRyl/cG8ZV+Q0lb2ybe6yKNKzNcDnvwMSx1vLe
 1wJ5EI7wWy+z9JRScBpOwcK9VfX1gCFvXd7+b22DC+WnaiMoDgxC1loH7qblrJY6l5Pi
 yuNXbVEL/Y7p4yeHPd/z02qHEe4VbuWX5/ORe73B/YsGKUATQNHpLaircWNTo5/bY2pA
 Kxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781624115; x=1782228915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nYrBXz9JCsBBTqmEmF5WL2AQ9KJg8a+iVzB8DU5JPw0=;
 b=UDg26dLvKJHnr4+grK55W13OrvMvBeJ9CgGAxT1GhWFLfVevxCGFYJ4Ru9AaGOnPfn
 EIA8r/+rTK+Q7t9rvtn1cWNRJn+VdCzuMnfObzlDRMS7FH+JxtKaardbmAqWa49DkauA
 zPN0555+LWYWuYwsDwRy80v5YmY+BiXqzRmBDajdWjV3t642/JDOY/zp1cPIoMUgwN8y
 ylbMXiCxn3QsNlEOWlqWAl6+eUVzo172o+uZbQr5rbTebQMqXJFSFWnPBq5aANVmLkzi
 HdOWBoFDaZoLUrKd13s+5lkNxTDRUhYH5wgaqR96Am3qVrQe0uSZoLI4/KjXKrFOLznP
 Blcw==
X-Gm-Message-State: AOJu0YyQ5NjwrDOmEInLpzEAOXesBgdiEBDXm0smRJ09tGdRhbsF16E/
 jSMBfiy+0+a3UTsJgq7Qmnpe+m/tr6FCuEkffyfH2q34qIdJqF+cSbRJCMiQ7olsS6lgY92INVK
 Dq+bqBj4wcGkFGsFjJDkS0R/5ijdQGMU1zw8wh5hxVCIWgD3JDVuaEiFNF6zt+PzGrQ==
X-Gm-Gg: Acq92OHPJ0PFkmOriilMhUMWV2WWKyH7OhpTlxlw39RibjdFORSagXSjHXXyAD++3SS
 g7xnNr5cgBavlwMmCezNik2frh7EUVjDYy8Qgk7vm+CjR1YwHIf0NaGUdrpmY5TcGYmpjK7L0gx
 ll5GYnGT2SvwuUCdEwZgfZKFWOqABjjs5gA2pT7yP/Na/aIsXOvbwSgR3TMhkXoy7+hS7IqnPEO
 B2bYilGBXR99L8QI7LeUxKeE/gGDRDlRNjN0dPxStDkVEJf/rwuB+a6v0imlfNKCVQp1avVwJWQ
 zKdR8VNhA1Tlhp7wSEpslTBQCj2rkpoHH0Ret8xt3Brq50Sg/1q0qQh6qhbspwG5/UK7goc+UfS
 IPBYtpWXICW/157QiJdXNbmh35UvSE9wjWwylg5OtrOn5NWlle9/r9A9YX9ySx4DQFlH4HFUXeh
 AUQB8=
X-Received: by 2002:a05:6102:3582:b0:62f:2d6f:cc11 with SMTP id
 ada2fe7eead31-71e88ad70f7mr13455074137.2.1781624110388; 
 Tue, 16 Jun 2026 08:35:10 -0700 (PDT)
X-Received: by 2002:a05:6102:3582:b0:62f:2d6f:cc11 with SMTP id
 ada2fe7eead31-71e88ad70f7mr13455015137.2.1781624109969; 
 Tue, 16 Jun 2026 08:35:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a9a399sm64654075e9.14.2026.06.16.08.35.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 08:35:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 5/5] accel/tcg: Remove pre-vCPU
 ignore_memory_transaction_failures flag
Date: Tue, 16 Jun 2026 17:34:31 +0200
Message-ID: <20260616153432.92939-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616153432.92939-1-philmd@oss.qualcomm.com>
References: <20260616153432.92939-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gzzmGotZT7fBpmPahYXKxdfI9PjctIah
X-Proofpoint-ORIG-GUID: gzzmGotZT7fBpmPahYXKxdfI9PjctIah
X-Authority-Analysis: v=2.4 cv=Ibi3n2qa c=1 sm=1 tr=0 ts=6a316d33 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=fsqqm1fM6BaVY0jH1QMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX4z/m/pcfWYus
 ASU+NRM/WJ+Z9ysngE4QdeJeKvr95jzMKxQD3M6PEyHPTqx6x227ajHpYaOL1D3k8qzgfKd8kJh
 0VyY2qDu4hYlAYbY98vEO79UMVxdMjY22xwNxObtDBk3PVGGr1TOP8IsPF4R8N60VDpgQZukKCL
 UPWpHLIB93d7pihMWyrBtv9t/RKrFGdzUsnEBgVdnMV5lZFpy0qWke9VXOs3rjTBYBhWwMhDbYv
 iQeDvzy9pdmxSv/+iKaXWBBamoDqzmXe9MBlG3nz9XE0OVTpO1S53M2XFuUmTudhvgtRtZZkegw
 NPMiTx6e39R2u/gDY8a0/nCP2ING9I0wAK4FCk8ev8vhWoIs9r+kXLxy197R9M2tEUpUdQ2gvqB
 8mvpO6SJrqVcIE1BY/AsCM8bkJo1NH5Ju4Qtt3DGxlSxL/Jw1p4C2QWHoBmpPCPl/3qgM6CVape
 Y3pWebTCT6nXdwwr4nQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX9x6GdKKpdCaT
 QwYCkhVbtxUxoe5fN13nqyo/ePEC04M6zCaJIixy0c9zFyo5bvgLDUrByiDJ0ct1qKsxqBmvUIA
 +Bgyg/sNF6O71XNhhBxS7WMAhQJKrj8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160159
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

The %ignore_memory_transaction_failures flag is meant for legacy
machines, and is defined once per machine, then applied to all vCPUs
such machine creates, to be eventually only used by the TCG soft MMU
layer.
We can decouple it of the vCPU layer by making it a global, setting
it once when the machine is initialized, allowing to remove machine
code in the common vCPU Realize() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Even better is to make it an accelerator property.
---
 include/hw/core/cpu.h  |  2 --
 include/system/tcg.h   |  2 ++
 accel/stubs/tcg-stub.c |  1 +
 accel/tcg/cputlb.c     |  9 +++++++--
 hw/core/cpu-common.c   | 15 ---------------
 hw/core/machine.c      |  5 +++++
 6 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 59d601465b4..72666189774 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -575,8 +575,6 @@ struct CPUState {
      */
     int64_t throttle_us_per_full;
 
-    bool ignore_memory_transaction_failures;
-
     /* Used for user-only emulation of prctl(PR_SET_UNALIGN). */
     bool prctl_unalign_sigbus;
 
diff --git a/include/system/tcg.h b/include/system/tcg.h
index 7622dcea302..0c5af81b511 100644
--- a/include/system/tcg.h
+++ b/include/system/tcg.h
@@ -25,4 +25,6 @@ extern bool tcg_allowed;
  */
 bool qemu_tcg_mttcg_enabled(void);
 
+extern bool tcg_ignore_memory_transaction_failures;
+
 #endif
diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 77055e39644..855e5d43171 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "system/tcg.h"
 #include "exec/cpu-common.h"
 
 G_NORETURN void cpu_loop_exit(CPUState *cpu)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d6115bbb0a4..31c8351231a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -26,6 +26,7 @@
 #include "exec/page-protection.h"
 #include "system/memory.h"
 #include "system/physmem.h"
+#include "system/tcg.h"
 #include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/cputlb.h"
@@ -90,6 +91,8 @@
  */
 QEMU_BUILD_BUG_ON(sizeof(vaddr) > sizeof(run_on_cpu_data));
 
+bool tcg_ignore_memory_transaction_failures;
+
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
 static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
@@ -1291,8 +1294,10 @@ static void io_failed(CPUState *cpu, CPUTLBEntryFull *full, vaddr addr,
                       unsigned size, MMUAccessType access_type, int mmu_idx,
                       MemTxResult response, uintptr_t retaddr)
 {
-    if (!cpu->ignore_memory_transaction_failures
-        && cpu->cc->tcg_ops->do_transaction_failed) {
+    if (unlikely(tcg_ignore_memory_transaction_failures)) {
+        return;
+    }
+    if (cpu->cc->tcg_ops->do_transaction_failed) {
         hwaddr physaddr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
 
         cpu->cc->tcg_ops->do_transaction_failed(cpu, physaddr, addr, size,
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index e314f916f84..b74a39c96ac 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -32,7 +32,6 @@
 #include "exec/log.h"
 #include "exec/gdbstub.h"
 #include "system/tcg.h"
-#include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "trace.h"
 #ifdef CONFIG_PLUGIN
@@ -247,20 +246,6 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
 static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cpu = CPU(dev);
-    Object *machine = qdev_get_machine();
-
-    /* qdev_get_machine() can return something that's not TYPE_MACHINE
-     * if this is one of the user-only emulators; in that case there's
-     * no need to check the ignore_memory_transaction_failures board flag.
-     */
-    if (object_dynamic_cast(machine, TYPE_MACHINE)) {
-        MachineClass *mc = MACHINE_GET_CLASS(machine);
-
-        if (mc) {
-            cpu->ignore_memory_transaction_failures =
-                mc->ignore_memory_transaction_failures;
-        }
-    }
 
     if (dev->hotplugged) {
         cpu_synchronize_post_init(cpu);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4d8b15d99e9..bc388dd8442 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -29,6 +29,7 @@
 #include "system/runstate.h"
 #include "system/xen.h"
 #include "system/qtest.h"
+#include "system/tcg.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/mem/nvdimm.h"
 #include "migration/global_state.h"
@@ -1213,6 +1214,10 @@ static void machine_class_base_init(ObjectClass *oc, const void *data)
                             strlen(cname) - strlen(TYPE_MACHINE_SUFFIX));
         mc->compat_props = g_ptr_array_new();
     }
+    if (tcg_enabled()) {
+        tcg_ignore_memory_transaction_failures
+            = mc->ignore_memory_transaction_failures;
+    }
 }
 
 static void machine_initfn(Object *obj)
-- 
2.53.0


