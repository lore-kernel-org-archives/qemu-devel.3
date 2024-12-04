Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EEFE7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 08:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIl3z-00008x-V8; Wed, 04 Dec 2024 03:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3bRdQZwgKCh4QB8H7LCEAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--whendrik.bounces.google.com>)
 id 1tIl3x-00005c-Jr
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:48:49 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3bRdQZwgKCh4QB8H7LCEAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--whendrik.bounces.google.com>)
 id 1tIl3v-00010j-RR
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:48:49 -0500
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-4349e97bfc4so60197595e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 00:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733302126; x=1733906926; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=139eJ467S0+ud6wwoqOA+04OQp0idjTX9nXsFXEiqo4=;
 b=3xol754HROCyFX3Oimb4AhCARlm6IREMjJ+JEndwCWEqu3n7ZFKEs7U2R5aYmbezAD
 7Q5b8D72ytuxTTZnUuXQRVzFUzhS+SGetkhmfFm/mkVC1VnIwGGjyNkgC4oUbibQaWwV
 /znr0bGsziB5JSjbkMZiQEa+R4szbF7T9rED76144bHji2FW5BgJX0KrWyvOqbSVnpjt
 nJ9tGuOsH0DFrLYiK3ylRd2X5uULV9SQsazgMRDJf5xTbiOcq94FZCyI/J0AsLBTa1fU
 CA1Anjs/BI0zn6mJuBEzw+Uj5D/J75I8ooyRKKbSAssnLAmGlXt92b4uH264lwOOiVH+
 yDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733302126; x=1733906926;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=139eJ467S0+ud6wwoqOA+04OQp0idjTX9nXsFXEiqo4=;
 b=YWhXPCugJTI1a/N5bqaEAfdlAG5vtUrKH9UYrqeN4pdtg1vaDTuyDOk+R5EpeLZU7c
 7g0k9/E7w9D3MZP5aW3xDn1r1CAab+cFoCVMMf7IdnuYODgoozCqikTrZheSsKm9/KzE
 yxmlunMQ2YZSAEQYhSBrXK1AOxB7xmpvS3/e2/h9NCjV0PF54YExDlLnZuC+u5krrHCZ
 yeKjgeyjNbcxOs/8WGmxf3n437anrtxVlSsgAHZ6mF8Qm7VNzx7TA8Dj/I2M/YLj/Cig
 Vm9M85zLSYexU3bVtz4JZcXFiNdGnrSNn1gRJ7g1Whkjf0NXN3Czk0k1q12Qls6Q+AGj
 2KqA==
X-Gm-Message-State: AOJu0Ywm3oyNJhQGLWfYPfSvE78e9y1q/pbz7Th0/7tBVxD4GXkB3fTJ
 beumAinUs81khMIlU2uFYU8BH/yoAxCTA/Ku3vwtNQdghH9uv5K09esQNwHgDYEdBfTxJPkRnCO
 V3HWR3JcATeEgTyjNVWSuX0KUw7GqgyRFXidfvjUPzNi+MwiWrWwf3vx1D3A0aVXtpDDUtM31lc
 445z4sI5Y9VnivSbs+PmWc2SxqkMNZp67z/o/owUcGXw==
X-Google-Smtp-Source: AGHT+IGn3gBumleApIgsT05daGDt4z2wpuEy2AgXXAFxJQI/PZ6KbE2dtn9k06oiivsHp+xhuhwi72t/EgRhOg==
X-Received: from wmil16.prod.google.com ([2002:a7b:c450:0:b0:434:a08d:7adb])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fc9:b0:434:a986:11cf with SMTP id
 5b1f17b1804b1-434d09c0faamr50818825e9.8.1733302125840; 
 Wed, 04 Dec 2024 00:48:45 -0800 (PST)
Date: Wed,  4 Dec 2024 08:48:30 +0000
In-Reply-To: <20241204084837.517299-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241204084837.517299-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204084837.517299-2-whendrik@google.com>
Subject: [PATCH v3 1/8] i386: Add Intel RDT device and State to config.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, eduardo@habkost.net, 
 richard.henderson@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3bRdQZwgKCh4QB8H7LCEAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--whendrik.bounces.google.com;
 helo=mail-wm1-x34a.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.453,
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
 hw/i386/rdt.c         | 96 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/rdt.h | 25 +++++++++++
 target/i386/cpu.h     |  3 ++
 5 files changed, 129 insertions(+)
 create mode 100644 hw/i386/rdt.c
 create mode 100644 include/hw/i386/rdt.h

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index f4a33b6c08..4dd05ed6f2 100644
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
index 03aad10df7..fdbf5962b5 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -21,6 +21,7 @@ i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport=
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
index 0000000000..d0afbd04fb
--- /dev/null
+++ b/hw/i386/rdt.c
@@ -0,0 +1,96 @@
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
+/* Max counts for allocation masks or CBMs. In other words, the size of re=
spective MSRs*/
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
+
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
index 1e121acef5..a2941f98eb 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2143,6 +2143,9 @@ struct ArchCPU {
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
2.47.0.338.g60cca15819-goog


