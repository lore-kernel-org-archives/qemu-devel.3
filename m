Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20FCE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9RZ-0008TN-0d; Fri, 13 Dec 2024 12:27:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3YW5cZwgKCvAoZWfVjacYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--whendrik.bounces.google.com>)
 id 1tM9RS-0008Py-Ut
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:27:08 -0500
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3YW5cZwgKCvAoZWfVjacYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--whendrik.bounces.google.com>)
 id 1tM9RO-0007nV-2G
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:27:04 -0500
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-43582d49dacso17629675e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1734110817; x=1734715617; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=0qxThtaigL4hm6xxENqva0i9sj2hAquO7ovF8w3qP/0=;
 b=jKz6DMkPLUSlDw84ejNeXwx1acnh9qDLcZ+yBV843Wm6OmFLELqKkC5Qh2xGbvntnU
 B0GDbzQ5/HA5fJpfKmXf5DwB7lKg8vpzXlNY9XsRz8kgny+iAJbn2DFQ1JmOgc1YFeSu
 vITIm6+Vcmg0a/r26Pe3nQHhTYdwDS2o6NDrX3vOxilBXkbk7zutlYk6zo5C6Mcuui4Y
 3VTG2+0dp7aFedrMYssTk4arsFeVAPHnUcq4cMNsivuQl17ihbiPSJJZepvMtu3tATA5
 zV70SFu3gtT1fojL1ACvTTVYZN2y+w6CVLHwIWTRkh+JL1k02uYIvK3f29u1UoekkxWH
 nzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734110817; x=1734715617;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0qxThtaigL4hm6xxENqva0i9sj2hAquO7ovF8w3qP/0=;
 b=QQth6QlpTIwTmqItaOuKmqItAMLA3WwamUe6rX8sCMzpdCRgFneMfM94ZGHHAgr9g8
 FWLyvAcgxYyls/mvwVQ8PU13/QDaW1cxXwYbXm/NdPtBm0mPabWeIIC//Ym12Wp36yoZ
 6n1YlCsV0whYPfPO0RjbtxcLLeJD7i3jxZSMeVcuZ/KbijghAIslhlQ5jEbgfdfjotIo
 x+9faWCp3DXARjkhSm8rkEAG/HAnGtsrjCJvYe5/pf+GMti4oqfEhlfxu4pYG0hahc/Q
 C8awlSxTvZNJnVrbs0MAtErLrMKB/iutQkxYSBH4q0RcL0fu8JEmuAB0gxSQ98DCGuQZ
 sVkA==
X-Gm-Message-State: AOJu0Yx1/ziVYD8KzDHXBHwL/Wuhj8YkLJkYsF16gWSdR4G8/4319A81
 uWgUB5s3ykQLFdKsS7bwkD0DGVkSKixR8tlYXM8Hhsxw77yK27uC1z6pXDkZcek3L7WKwOjb/uY
 r/z7I8z+FzlqAiOhkCCgfFFXxY6aefDPM/PJue1059FQiNuRBv18GBRhzwXavzuPFf8And0RcWd
 lVeUbg6pSTyScwKVCk/h0WW+DOUo/yCBNSbdB5etJPLw==
X-Google-Smtp-Source: AGHT+IENncRwa8hd6Dw0n9kYhcZmJhMWgrU9EYCmfrVqUteZ6VatKyKp9fps09tz30CVyCAPWNa1l2xUK+XM5A==
X-Received: from wmnm21.prod.google.com ([2002:a05:600c:1615:b0:436:1923:6cf5])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5029:b0:434:a815:2b5d with SMTP id
 5b1f17b1804b1-4362aa93dc9mr27447265e9.24.1734110817318; 
 Fri, 13 Dec 2024 09:26:57 -0800 (PST)
Date: Fri, 13 Dec 2024 17:26:38 +0000
In-Reply-To: <20241213172645.2751696-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241213172645.2751696-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213172645.2751696-2-whendrik@google.com>
Subject: [PATCH v5 1/8] i386: Add Intel RDT device and State to config.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com, 
 zhao1.liu@intel.com, xiaoyao.li@intel.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3YW5cZwgKCvAoZWfVjacYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--whendrik.bounces.google.com;
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

From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>

Change config to show RDT, add minimal code to the rdt.c module to make
sure things still compile.

Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
---
 hw/i386/Kconfig       |  4 ++
 hw/i386/meson.build   |  1 +
 hw/i386/rdt.c         | 99 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/rdt.h | 25 +++++++++++
 target/i386/cpu.h     |  3 ++
 5 files changed, 132 insertions(+)
 create mode 100644 hw/i386/rdt.c
 create mode 100644 include/hw/i386/rdt.h

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 32818480d2..0186b85c3e 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -10,6 +10,9 @@ config SGX
     bool
     depends on KVM
=20
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
@@ -22,6 +22,7 @@ i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport=
.c'))
 i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
 i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
                                 if_false: files('sgx-stub.c'))
+i386_ss.add(when: 'CONFIG_RDT', if_true: files('rdt.c'))
=20
 i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
 i386_ss.add(when: 'CONFIG_PC', if_true: files(
diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
new file mode 100644
index 0000000000..b2203197e3
--- /dev/null
+++ b/hw/i386/rdt.c
@@ -0,0 +1,99 @@
+/*
+ * Intel Resource Director Technology (RDT).
+ *
+ * Copyright 2024 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WIT=
HOUT
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
+/* Max counts for allocation masks or CBMs. In other words, the size of
+ * respective MSRs.
+ * L3_MASK and L3_mask are architectural limitations. THRTL_COUNT is just
+ * the space left until the next MSR.
+ * */
+#define RDT_MAX_L3_MASK_COUNT      127
+#define RDT_MAX_L2_MASK_COUNT      63
+#define RDT_MAX_MBA_THRTL_COUNT    63
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
+    uint32_t active_cos;
+};
+
+struct RDTStatePerCore {
+    uint32_t active_rmid;
+    GArray *monitors;
+
+    /*Parent RDTState*/
+    RDTState *rdtstate;
+};
+
+/*One instance of RDT-internal state to be shared by all cores*/
+struct RDTState {
+    ISADevice parent;
+
+    /*Max amount of RMIDs*/
+    uint32_t rmids;
+
+    /*Per core state*/
+    RDTStatePerCore *rdtInstances;
+    RDTAllocation *allocations;
+
+    /*RDT Allocation bitmask MSRs*/
+    uint32_t msr_L3_ia32_mask_n[RDT_MAX_L3_MASK_COUNT];
+    uint32_t msr_L2_ia32_mask_n[RDT_MAX_L2_MASK_COUNT];
+    uint32_t ia32_L2_qos_ext_bw_thrtl_n[RDT_MAX_MBA_THRTL_COUNT];
+};
+
+struct RDTStateClass {
+};
+
+OBJECT_DEFINE_TYPE(RDTState, rdt, RDT, ISA_DEVICE);
+
+static Property rdt_properties[] =3D {
+    DEFINE_PROP_UINT32(RDT_NUM_RMID_PROP, RDTState, rmids, 256),
+    DEFINE_PROP_END_OF_LIST(),
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
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->hotpluggable =3D false;
+    dc->desc =3D "RDT";
+    dc->user_creatable =3D true;
+
+    device_class_set_props(dc, rdt_properties);
+}
diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
new file mode 100644
index 0000000000..a21d95b265
--- /dev/null
+++ b/include/hw/i386/rdt.h
@@ -0,0 +1,25 @@
+/*
+ * Intel Resource Director Technology (RDT).
+ *
+ * Copyright 2024 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WIT=
HOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#ifndef HW_RDT_H
+#define HW_RDT_H
+
+typedef struct RDTState RDTState;
+typedef struct RDTStatePerCore RDTStatePerCore;
+typedef struct RDTMonitor RDTMonitor;
+typedef struct RDTAllocation RDTAllocation;
+
+#endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 4c239a6970..0f73c1244d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2213,6 +2213,9 @@ struct ArchCPU {
     struct MemoryRegion *cpu_as_root, *cpu_as_mem, *smram;
     Notifier machine_done;
=20
+    /* Help the RDT MSRs find the RDT device */
+    struct RDTStatePerCore *rdt;
+
     struct kvm_msrs *kvm_msr_buf;
=20
     int32_t node_id; /* NUMA node this CPU belongs to */
--=20
2.47.1.613.gc27f4b7a9f-goog


