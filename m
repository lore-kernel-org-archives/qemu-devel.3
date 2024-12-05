Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D04E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJI1j-0002rI-9L; Thu, 05 Dec 2024 15:00:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3XgZSZwgKCvMrcZiYmdfbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--whendrik.bounces.google.com>)
 id 1tJI1g-0002qf-11
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:00:40 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3XgZSZwgKCvMrcZiYmdfbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--whendrik.bounces.google.com>)
 id 1tJI1Y-0001d9-PQ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:00:34 -0500
Received: by mail-wm1-x34a.google.com with SMTP id
 5b1f17b1804b1-434a96889baso8143985e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1733428831; x=1734033631; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=sczQpCntEV4pWQdfCwwJkDKiQSND8KcLmMCFvvS8Q/4=;
 b=KOwJRqaDLRGv8LXk4jtQxJQTkqjwldfrjxQuqymZ/qi4P07e3s0xG3t4rlkIrRQBC2
 QODL0eUmTGuTbGzCJmYJbA6NcOxa7wyGoW/mxh/2pPnW/OlQFDs4We1ZYFK1lu+0Seqp
 DAooVyD3d3cU0KHxwCyPYwOjTbis6V9CdGuvNz+WRO7EMq6bHROzzF8sUSerTetT4ZWh
 AeVTKiegMrqirv7AdF9f1pTFbLpj61Xq7eT2HJzmdLZJlBnS+/JeReyNOq4rW0912T5s
 lv9LTQWSYwbLMNxzxJrJSM0ilETTeXv1OexeMRUZIpRstxo/3thDmSo3TYr8oVrGXZvP
 UzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428831; x=1734033631;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sczQpCntEV4pWQdfCwwJkDKiQSND8KcLmMCFvvS8Q/4=;
 b=PP7nCEdAxuHrq7yWafUee4OlrJNuiCNZL6UOd9IBc2ps6hMVaxIAQqWnXVy8hQYy4F
 KZqGRgR9kTvW1XYqqamWVwEjjQxDimkBpLA/eGr6H4NJrcwKXnW4Ho3QD/+kUdX43Hwd
 OBGNbT/0Pc9alryp9nbe4dDB3nQOcnY7aOVKEEQqscpSWFuoZMQqjV7etROi2AgJeXdw
 iCU7zUS00uRy3zbsWN0BHGMj0F4eR8bKIxgq1LLpT2AplOA4cut3FsRn92oZ/H0n3aIv
 HYw4hh9MfbIz9RApYcBW/4zza2zOfaQ5DXFCnJp47ynEwyBm9C4i+zuIYO1CpAliqM1D
 WJoA==
X-Gm-Message-State: AOJu0YxP8Oct1dOkPU5bZaY6GhKIwsqjR53mcGS/Bmj0WhN4Uq//6X3F
 YjQRY20CF898lOHqQEeU+AmIB9QQh1rSaR+qVZ1WvVluz517Q8oPEeJWI7oZxeGz6m73Gkuvgpn
 Jz6ZtMZN4G7SEsdvK8YiC1LMz/QghoqltgROMi23f43Xt9mAy9Mcgp4ExEzuOvptnLfeXfvHMVg
 T4Saw+Q1e6WKs2vSXLx62YaYwNBw91J95IXvdHG9n4ig==
X-Google-Smtp-Source: AGHT+IFwRDUkPdK2A5S2YS1TruDhZDlph6latXsv8JuEy+hzMxCjJhZ6jVRl2TZTQbRVldVI4sZVn9tK8obtdw==
X-Received: from wmsl24.prod.google.com ([2002:a05:600c:1d18:b0:434:a90a:3986])
 (user=whendrik job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f8c:0:b0:385:e67d:9e0 with SMTP id
 ffacd0b85a97d-3862b37d51amr245577f8f.29.1733428830448; 
 Thu, 05 Dec 2024 12:00:30 -0800 (PST)
Date: Thu,  5 Dec 2024 20:00:18 +0000
In-Reply-To: <20241205200025.2081863-1-whendrik@google.com>
Mime-Version: 1.0
References: <20241205200025.2081863-1-whendrik@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205200025.2081863-2-whendrik@google.com>
Subject: [PATCH v4 1/8] i386: Add Intel RDT device and State to config.
From: Hendrik Wuethrich <whendrik@google.com>
To: qemu-devel@nongnu.org, eduardo@habkost.net, richard.henderson@linaro.org, 
 marcel.apfelbaum@gmail.com, mst@redhat.com, pbonzini@redhat.com
Cc: peternewman@google.com, 
 "=?UTF-8?q?=E2=80=AAHendrik=20W=C3=BCthrich?=" <whendrik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::34a;
 envelope-from=3XgZSZwgKCvMrcZiYmdfbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--whendrik.bounces.google.com;
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
2.47.0.338.g60cca15819-goog


