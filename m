Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7414C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 20:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to6bu-0005Ku-Ut; Fri, 28 Feb 2025 15:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <36xbCZwgKCmYaLIRHVMOKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--whendrik.bounces.google.com>)
 id 1to6ba-0004on-17
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:05:06 -0500
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <36xbCZwgKCmYaLIRHVMOKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--whendrik.bounces.google.com>)
 id 1to6bX-0000xm-1r
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 15:05:05 -0500
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-43ab5baf62cso18737895e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 12:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740773099; x=1741377899; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DolmQsqndmFLMXgbOTcrfWM8vLPEPuQ/PPLa+E6wyHc=;
 b=38XuES/Vm+B7W999d7fnJHBYIJogfFuPE6Q/Wfc2Fs4M8VWilQEbHcI1wxdlPdnqoU
 lpcddH9I0dsoqCkbg/GtrSPfqG4mgRS03OoJC1yJA1VJAz3PPDzEegx10DqEi4Aa6kPr
 sx0hLMx2uGpCQEJEvzdmEGHEzmXy5bgJSImA8rAHYzYsQmApUUFZ4yVWGg7YAS8T7H5N
 GcIeAzN+WXO1LAdzxNWkwYRox1z75iueAZVfIBEDGGzlGD44mn9hkIOmTl6T1jCwzrfY
 3yqbRMXN4jneWiq5Jscf5EYKNrd7cu8OmACAglx+8keiV2jah6q/Mi7vz4OgBih5PwY1
 PPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740773099; x=1741377899;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DolmQsqndmFLMXgbOTcrfWM8vLPEPuQ/PPLa+E6wyHc=;
 b=r34bj4Gk6INk7IrIR7jTuJe7Y/2YGgxIUTGfvnomtKorfZIFShww4hYkwO/j0RLZjd
 Sf3iaYjsrKYYGoiQjKOh3lfE+8dKp8ajIsvbek+EBMC8ctikhyIQenCo8DyyofbzaRvM
 SKIEhUXX3ax4Qri8IkPC3b7kXS1S8kKP0mD4rm05Pm6uPO26Scn7Rvu5dTDmaUHsQhxW
 3OVw+G9TmkEmeVhQihGhXqfXhK+sh3cOug1S8uy/1dR6kp4tAYWzz/0oTgbFrxsoMriG
 Ci6LgCq76kcwxwcXIxlhkX0xFUsq9efndG2hfbhG4a9ovz2N7vyOP0kYgaRVNWlwqutB
 YeOA==
X-Gm-Message-State: AOJu0Yw4LDWuJM/ZJFzBKnJTUoQFOdxo8hN7D0A/lmW4DIYHMVXlgHqh
 wySsKPClGm09db48flUY0GMPP9tWuebtXMGZtQw6edKRvIjgePbSGo3slfHzT+GYtUW+LI2bCrJ
 wFoCNgp0wI0uJj1ZdBWW/4LL+EWCoGwqb5JOTMF5PzDh0l4XWd2DdQ1C6e1RRTT/O+Veb/H5jvJ
 5zb6YwTg8EhcU3+QxvP6J8Qt1adWsvoTBZ4oBYDBMgmQ==
X-Google-Smtp-Source: AGHT+IG7w9KVqYnW/iUiH6FcHTHOtUoSFA69ouOf77jdVo8p2tdo6oeabuuM+uwA+AwZflT0lU2vSd3u9LmTbQ==
X-Received: from wmbhc26.prod.google.com
 ([2002:a05:600c:871a:b0:439:916e:3c57])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3c93:b0:439:8bc3:a697 with SMTP id
 5b1f17b1804b1-43ba66cfe5dmr41066515e9.4.1740773099324; 
 Fri, 28 Feb 2025 12:04:59 -0800 (PST)
Date: Fri, 28 Feb 2025 20:04:46 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228200453.45173-1-whendrik@google.com>
Subject: [PATCH v6 1/8] i386: Add Intel RDT device and State to config.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 zhao1.liu@intel.com, xiaoyao.li@intel.com, Jonathan.Cameron@huawei.com, 
 v6-0000-cover-letter.patch@google.com
Cc: peternewman@google.com, Hendrik Wuethrich <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=36xbCZwgKCmYaLIRHVMOKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x349.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Change config to show RDT, add minimal code to the rdt.c module to make
sure things still compile.

Signed-off-by: Hendrik Wuethrich <whendrik@google.com>
---
 hw/i386/Kconfig       |  4 ++
 hw/i386/meson.build   |  1 +
 hw/i386/rdt.c         | 97 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/rdt.h | 35 ++++++++++++++++
 target/i386/cpu.h     |  4 ++
 5 files changed, 141 insertions(+)
 create mode 100644 hw/i386/rdt.c
 create mode 100644 include/hw/i386/rdt.h

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index d34ce07b21..a3a6b2259c 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -10,6 +10,9 @@ config SGX
     bool
     depends on KVM
 
+config RDT
+    bool
+
 config PC
     bool
     imply APPLESMC
@@ -26,6 +29,7 @@ config PC
     imply QXL
     imply SEV
     imply SGX
+    imply RDT
     imply TEST_DEVICES
     imply TPM_CRB
     imply TPM_TIS_ISA
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 10bdfde27c..3a697dcc03 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -22,6 +22,7 @@ i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport.c'))
 i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
 i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
                                 if_false: files('sgx-stub.c'))
+i386_ss.add(when: 'CONFIG_RDT', if_true: files('rdt.c'))
 
 i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
 i386_ss.add(when: 'CONFIG_PC', if_true: files(
diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
new file mode 100644
index 0000000000..76a253902b
--- /dev/null
+++ b/hw/i386/rdt.c
@@ -0,0 +1,97 @@
+/*
+ * Intel Resource Director Technology (RDT).
+ *
+ * Copyright 2025 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#include "hw/i386/rdt.h"
+#include "qemu/osdep.h" /* Needs to be included before isa.h */
+#include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
+#include "qom/object.h"
+
+#define TYPE_RDT "rdt"
+#define RDT_NUM_RMID_PROP "rmids"
+
+OBJECT_DECLARE_TYPE(RDTState, RDTStateClass, RDT);
+
+struct RDTMonitor {
+    uint64_t count_local;
+    uint64_t count_remote;
+    uint64_t count_l3;
+};
+
+struct RDTAllocation {
+    QemuMutex lock;
+    uint32_t active_cos;
+};
+
+struct RDTStatePerCore {
+    QemuMutex lock;
+    uint32_t active_rmid;
+};
+
+struct RDTStatePerL3Cache {
+    QemuMutex lock;
+
+    RDTMonitor *monitors;
+
+    /* RDT Allocation bitmask MSRs */
+    uint32_t msr_L3_ia32_mask_n[RDT_MAX_L3_MASK_COUNT];
+    uint32_t msr_L2_ia32_mask_n[RDT_MAX_L2_MASK_COUNT];
+    uint32_t ia32_L2_qos_ext_bw_thrtl_n[RDT_MAX_MBA_THRTL_COUNT];
+
+    /* Parent RDTState */
+    RDTState *rdtstate;
+};
+
+/* One instance of RDT-internal state to be shared by all cores */
+struct RDTState {
+    ISADevice parent;
+
+    /* Max amount of RMIDs */
+    uint32_t rmids;
+
+    uint16_t l3_caches;
+
+    RDTStatePerL3Cache *rdtInstances;
+    RDTAllocation *allocations;
+};
+
+struct RDTStateClass {
+};
+
+OBJECT_DEFINE_TYPE(RDTState, rdt, RDT, ISA_DEVICE);
+
+static Property rdt_properties[] = {
+    DEFINE_PROP_UINT32(RDT_NUM_RMID_PROP, RDTState, rmids, 256),
+};
+
+static void rdt_init(Object *obj)
+{
+}
+
+static void rdt_finalize(Object *obj)
+{
+}
+
+static void rdt_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->hotpluggable = false;
+    dc->desc = "RDT";
+    dc->user_creatable = true;
+
+    device_class_set_props(dc, rdt_properties);
+}
diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
new file mode 100644
index 0000000000..1f99f98f7f
--- /dev/null
+++ b/include/hw/i386/rdt.h
@@ -0,0 +1,35 @@
+/*
+ * Intel Resource Director Technology (RDT).
+ *
+ * Copyright 2025 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#ifndef HW_RDT_H
+#define HW_RDT_H
+
+/* Max counts for allocation masks or CBMs. In other words, the size of
+ * respective MSRs.
+ * L3_MASK and L3_mask are architectural limitations. THRTL_COUNT is just
+ * the space left until the next MSR.
+ * */
+#define RDT_MAX_L3_MASK_COUNT      127
+#define RDT_MAX_L2_MASK_COUNT      63
+#define RDT_MAX_MBA_THRTL_COUNT    63
+
+typedef struct RDTState RDTState;
+typedef struct RDTStatePerL3Cache RDTStatePerL3Cache;
+typedef struct RDTStatePerCore RDTStatePerCore;
+typedef struct RDTMonitor RDTMonitor;
+typedef struct RDTAllocation RDTAllocation;
+
+#endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c67b42d34f..2cbcc8fe4e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2253,6 +2253,10 @@ struct ArchCPU {
     struct MemoryRegion *cpu_as_root, *cpu_as_mem, *smram;
     Notifier machine_done;
 
+    /* Help the RDT MSRs find the RDT device state */
+    struct RDTStatePerL3Cache *rdtStatePerL3Cache;
+    struct RDTStatePerCore *rdtPerCore;
+
     struct kvm_msrs *kvm_msr_buf;
 
     int32_t node_id; /* NUMA node this CPU belongs to */
-- 
2.48.1.711.g2feabab25a-goog


