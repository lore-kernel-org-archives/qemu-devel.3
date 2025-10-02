Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D81CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mvk-00019f-Af; Thu, 02 Oct 2025 13:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Mum-0000h1-KG
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MuW-0005ip-UV
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BW2WJxOS4xr7mxNzCkKr1ZJuFLGZN8Iw793SnaBQLK8=;
 b=UIERgK6buM1YnKgWfoBFDLy99/KLssRzslnRPMDnWjXozoCN/2WD3nk/d+j11WehVf3xea
 57J8FgvsE8OfG9qvJ6aeIABlpT8gHa4Vu4aHn7m8Ekc301CdddYs5Jv3odg95Btv/6I9Q6
 dU1C4xIioAHRlP0MyPzNj14kTMUnCwQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-tyYv4D4QPYqZ8jjgPGoaaw-1; Thu, 02 Oct 2025 13:15:59 -0400
X-MC-Unique: tyYv4D4QPYqZ8jjgPGoaaw-1
X-Mimecast-MFC-AGG-ID: tyYv4D4QPYqZ8jjgPGoaaw_1759425358
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b448c864d45so91250066b.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425356; x=1760030156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BW2WJxOS4xr7mxNzCkKr1ZJuFLGZN8Iw793SnaBQLK8=;
 b=Sos8ZY/jd1tjeb6OmVDPpkufBODz6om5Qd8f32VKQ+DDpmv0kEW9vXTaZQ+RvfbhmI
 0oXht7w1J2P1W88PMKxY1eQOTnVhhPkolKDUNtB+mgbN7MeW54jeQZwvn6ZKDm1XcQ1G
 lDj+TbMQjUlk/TFvZoumSUYxjwi6JmG8SbcEeWlXQgFaublVhNJzjyAiUAByKeLzT0pt
 K8tW447ceTRWCs6HFNdaWplwKimI05yE/Hqbuua+8y4vdUa5QJZjqPsmoNxqhzmE0R5b
 vL+xT2fmuK9EQuepQD+6M39dkh3QFOSLnIyMd2jEjrWzi1vCyEqNoi0GdmGL6PpIXxJd
 iitg==
X-Gm-Message-State: AOJu0Yw+/Hj10AKga3QVAh7NfOesoPqQPKKc6Gw18r2Q7uk2nTHIQcZ0
 i1lNbpYcWuwI7ep1mIdXfxFd5SCYPjdD8cIjR/O7IUzgm7cwbE5ME06LtXk8yDawotbLHmBapjI
 IbLO+mFPXy2LJ956GWHxZPCScOlGLBkeLNeZlXHVJuS4AJDGiVjzvKDeXY4/Bi1a7kCPOhKfYlG
 a5i0iDRIaes/oRp06SaSuCXPMRm2SdxYfHlWpV6l+Y
X-Gm-Gg: ASbGncvly2r8joa6H6qUMvxvbd2sHbZHBsMPAN1v0neHCqUxiuYN4i7iISBs65EMuHg
 cu5hhJxHCqdd+MU8Zm3rh4+q+aVsKnG4s8SJJfcEJD2UZHyCnxcb/x+6t22powHeFkEu4CHyL7z
 CTCoXBYE3Ak+/I6F16WcGFnKFB2ARFvCDbXA7Y+VBImXH7vaEgcxeoaA8AIKCu+qxsK0+9YWn2D
 yy/niBC8tTv8uPSTupKeolaNuOStO9mqDCJniLYajaZdIKxcyLu8vDVyStvkJK3mfghvzM7nzwe
 uL3PdzWt7oEBljAK5/Qv7JkD5PnUxlbtcACGEC8kNfbTJrUNlj2XU+Oo4wCco1Er1+3orJiPru/
 qcpN7XdbJV8Ai+3JKb9zozrycvnbLg0lAnHwBCg60MW1kLHut
X-Received: by 2002:a17:907:805:b0:b07:c90a:8ade with SMTP id
 a640c23a62f3a-b49c19775b6mr29723066b.20.1759425355851; 
 Thu, 02 Oct 2025 10:15:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0b+3nsde2BMgobtlCVFI+Ok8Qdftpcfk8KlCN71AOyvqFjtc/XYLC5KuztPn9oy6hFg98+w==
X-Received: by 2002:a17:907:805:b0:b07:c90a:8ade with SMTP id
 a640c23a62f3a-b49c19775b6mr29718566b.20.1759425355310; 
 Thu, 02 Oct 2025 10:15:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b486970b222sm242866166b.55.2025.10.02.10.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:15:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 07/27] accel/mshv: Add accelerator skeleton
Date: Thu,  2 Oct 2025 19:15:16 +0200
Message-ID: <20251002171536.1460049-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Introduce the initial scaffold for the MSHV (Microsoft Hypervisor)
accelerator backend. This includes the basic directory structure and
stub implementations needed to integrate with QEMU's accelerator
framework.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-8-magnuskulke@linux.microsoft.com
[Move include of linux/mshv.h in the per-target section; create
 include/system/mshv_int.h. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv.h     |  12 ++++
 include/system/mshv_int.h |  41 +++++++++++
 accel/mshv/mshv-all.c     | 144 ++++++++++++++++++++++++++++++++++++++
 accel/meson.build         |   1 +
 accel/mshv/meson.build    |   6 ++
 5 files changed, 204 insertions(+)
 create mode 100644 include/system/mshv_int.h
 create mode 100644 accel/mshv/mshv-all.c
 create mode 100644 accel/mshv/meson.build

diff --git a/include/system/mshv.h b/include/system/mshv.h
index 2a504ed81f2..434ea9682e1 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -14,8 +14,17 @@
 #ifndef QEMU_MSHV_H
 #define QEMU_MSHV_H
 
+#include "qemu/osdep.h"
+#include "qemu/accel.h"
+#include "hw/hyperv/hyperv-proto.h"
+#include "hw/hyperv/hvhdk.h"
+#include "qapi/qapi-types-common.h"
+#include "system/memory.h"
+#include "accel/accel-ops.h"
+
 #ifdef COMPILING_PER_TARGET
 #ifdef CONFIG_MSHV
+#include <linux/mshv.h>
 #define CONFIG_MSHV_IS_POSSIBLE
 #endif
 #else
@@ -30,6 +39,9 @@ extern bool mshv_allowed;
 #endif
 #define mshv_msi_via_irqfd_enabled() false
 
+typedef struct MshvState MshvState;
+extern MshvState *mshv_state;
+
 /* interrupt */
 int mshv_irqchip_add_msi_route(int vector, PCIDevice *dev);
 int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev);
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
new file mode 100644
index 00000000000..132491b599d
--- /dev/null
+++ b/include/system/mshv_int.h
@@ -0,0 +1,41 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors: Ziqiao Zhou  <ziqiaozhou@microsoft.com>
+ *          Magnus Kulke <magnuskulke@microsoft.com>
+ *          Jinank Jain  <jinankjain@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef QEMU_MSHV_INT_H
+#define QEMU_MSHV_INT_H
+
+struct AccelCPUState {
+    int cpufd;
+    bool dirty;
+};
+
+typedef struct MshvMemoryListener {
+    MemoryListener listener;
+    int as_id;
+} MshvMemoryListener;
+
+typedef struct MshvAddressSpace {
+    MshvMemoryListener *ml;
+    AddressSpace *as;
+} MshvAddressSpace;
+
+struct MshvState {
+    AccelState parent_obj;
+    int vm;
+    MshvMemoryListener memory_listener;
+    /* number of listeners */
+    int nr_as;
+    MshvAddressSpace *as;
+};
+
+#endif
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
new file mode 100644
index 00000000000..ae12f0f58b9
--- /dev/null
+++ b/accel/mshv/mshv-all.c
@@ -0,0 +1,144 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors:
+ *  Ziqiao Zhou       <ziqiaozhou@microsoft.com>
+ *  Magnus Kulke      <magnuskulke@microsoft.com>
+ *  Jinank Jain       <jinankjain@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/event_notifier.h"
+#include "qemu/module.h"
+#include "qemu/main-loop.h"
+#include "hw/boards.h"
+
+#include "hw/hyperv/hvhdk.h"
+#include "hw/hyperv/hvhdk_mini.h"
+#include "hw/hyperv/hvgdk.h"
+#include "linux/mshv.h"
+
+#include "qemu/accel.h"
+#include "qemu/guest-random.h"
+#include "accel/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
+#include "system/cpus.h"
+#include "system/runstate.h"
+#include "system/accel-blocker.h"
+#include "system/address-spaces.h"
+#include "system/mshv.h"
+#include "system/mshv_int.h"
+#include "system/reset.h"
+#include "trace.h"
+#include <err.h>
+#include <stdint.h>
+#include <sys/ioctl.h>
+
+#define TYPE_MSHV_ACCEL ACCEL_CLASS_NAME("mshv")
+
+DECLARE_INSTANCE_CHECKER(MshvState, MSHV_STATE, TYPE_MSHV_ACCEL)
+
+bool mshv_allowed;
+
+MshvState *mshv_state;
+
+static int mshv_init(AccelState *as, MachineState *ms)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static void mshv_start_vcpu_thread(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static void mshv_cpu_synchronize_post_init(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static void mshv_cpu_synchronize_post_reset(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static void mshv_cpu_synchronize(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static bool mshv_cpus_are_resettable(void)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static void mshv_accel_class_init(ObjectClass *oc, const void *data)
+{
+    AccelClass *ac = ACCEL_CLASS(oc);
+
+    ac->name = "MSHV";
+    ac->init_machine = mshv_init;
+    ac->allowed = &mshv_allowed;
+}
+
+static void mshv_accel_instance_init(Object *obj)
+{
+    MshvState *s = MSHV_STATE(obj);
+
+    s->vm = 0;
+}
+
+static const TypeInfo mshv_accel_type = {
+    .name = TYPE_MSHV_ACCEL,
+    .parent = TYPE_ACCEL,
+    .instance_init = mshv_accel_instance_init,
+    .class_init = mshv_accel_class_init,
+    .instance_size = sizeof(MshvState),
+};
+
+static void mshv_accel_ops_class_init(ObjectClass *oc, const void *data)
+{
+    AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
+
+    ops->create_vcpu_thread = mshv_start_vcpu_thread;
+    ops->synchronize_post_init = mshv_cpu_synchronize_post_init;
+    ops->synchronize_post_reset = mshv_cpu_synchronize_post_reset;
+    ops->synchronize_state = mshv_cpu_synchronize;
+    ops->synchronize_pre_loadvm = mshv_cpu_synchronize_pre_loadvm;
+    ops->cpus_are_resettable = mshv_cpus_are_resettable;
+    ops->handle_interrupt = generic_handle_interrupt;
+}
+
+static const TypeInfo mshv_accel_ops_type = {
+    .name = ACCEL_OPS_NAME("mshv"),
+    .parent = TYPE_ACCEL_OPS,
+    .class_init = mshv_accel_ops_class_init,
+    .abstract = true,
+};
+
+static void mshv_type_init(void)
+{
+    type_register_static(&mshv_accel_type);
+    type_register_static(&mshv_accel_ops_type);
+}
+
+type_init(mshv_type_init);
diff --git a/accel/meson.build b/accel/meson.build
index 6349efe682f..983dfd0bd55 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -10,6 +10,7 @@ if have_system
   subdir('kvm')
   subdir('xen')
   subdir('stubs')
+  subdir('mshv')
 endif
 
 # qtest
diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
new file mode 100644
index 00000000000..4c03ac79219
--- /dev/null
+++ b/accel/mshv/meson.build
@@ -0,0 +1,6 @@
+mshv_ss = ss.source_set()
+mshv_ss.add(if_true: files(
+  'mshv-all.c'
+))
+
+specific_ss.add_all(when: 'CONFIG_MSHV', if_true: mshv_ss)
-- 
2.51.0


