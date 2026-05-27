Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C1CCD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 05:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS6OQ-0001PF-Nu; Wed, 27 May 2026 01:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wS6ON-0001OX-47; Wed, 27 May 2026 01:01:19 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wS6OL-0004GB-C4; Wed, 27 May 2026 01:01:18 -0400
Received: from localhost (unknown [131.107.147.136])
 by linux.microsoft.com (Postfix) with ESMTPSA id 81E6420B7178;
 Tue, 26 May 2026 22:00:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 81E6420B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1779858043;
 bh=nSRviMTjzY05eP4undoQCtpa2DSIEGk82eY16zPUOpM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=CHewVDOJN82yKN5HDhsfL/MhxVtptAZtKNTDFaKojpz/B6IaCba97yM8rP9+cGLzN
 +jYc5pf2e05oISsuea9HtOmYMKK0X5fFMBi7gBSSOfrhQs0n9wzA0zBcn7FqYOYroJ
 yOUnJx+qG+HxkpdgHgagaDKbdmJ4hepBHFGEhQdQ=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Date: Wed, 27 May 2026 05:00:49 +0000
Subject: [PATCH v4 13/15] include/hw/hyperv: adjust hv_interrupt_control
 structure for arm64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-mshv_accel_arm64_supp-v4-13-66d871dcdc53@linux.microsoft.com>
References: <20260527-mshv_accel_arm64_supp-v4-0-66d871dcdc53@linux.microsoft.com>
In-Reply-To: <20260527-mshv_accel_arm64_supp-v4-0-66d871dcdc53@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 =?utf-8?q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Magnus Kulke <magnus.kulke@linux.microsoft.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>

Add the arm64 specific fields to the hv_interrupt_control struct and
adjust the existing usage accordingly. mshv_request_interrupt is only
needed only for x86 so compile it out entirely for arm64.

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 accel/mshv/irq.c               |  2 ++
 include/hw/hyperv/hvgdk_mini.h | 25 +++++++++++++++++++++++++
 include/system/mshv.h          |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index 3c238c33c3..a391d7db86 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -310,6 +310,7 @@ int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev)
     return 0;
 }
 
+#if defined(__x86_64__)
 int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint32_t vector,
                            uint32_t vp_index, bool logical_dest_mode,
                            bool level_triggered)
@@ -346,6 +347,7 @@ int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint3
     }
     return 0;
 }
+#endif
 
 void mshv_irqchip_commit_routes(void)
 {
diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index 192d464d22..c3424b760a 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -510,13 +510,38 @@ typedef struct hv_input_set_vp_registers {
     struct hv_register_assoc elements[];
 } QEMU_PACKED hv_input_set_vp_registers;
 
+enum hv_interrupt_type {
+#if defined(__x86_64__)
+    HV_X64_INTERRUPT_TYPE_FIXED             = 0x0000,
+    HV_X64_INTERRUPT_TYPE_LOWESTPRIORITY    = 0x0001,
+    HV_X64_INTERRUPT_TYPE_SMI               = 0x0002,
+    HV_X64_INTERRUPT_TYPE_REMOTEREAD        = 0x0003,
+    HV_X64_INTERRUPT_TYPE_NMI               = 0x0004,
+    HV_X64_INTERRUPT_TYPE_INIT              = 0x0005,
+    HV_X64_INTERRUPT_TYPE_SIPI              = 0x0006,
+    HV_X64_INTERRUPT_TYPE_EXTINT            = 0x0007,
+    HV_X64_INTERRUPT_TYPE_LOCALINT0         = 0x0008,
+    HV_X64_INTERRUPT_TYPE_LOCALINT1         = 0x0009,
+    HV_X64_INTERRUPT_TYPE_MAXIMUM           = 0x000A,
+#elif defined(__aarch64__)
+    HV_ARM64_INTERRUPT_TYPE_FIXED           = 0x0000,
+    HV_ARM64_INTERRUPT_TYPE_MAXIMUM         = 0x0008,
+#endif
+};
+
 union hv_interrupt_control {
     uint64_t as_uint64;
     struct {
         uint32_t interrupt_type; /* enum hv_interrupt type */
+#if defined(__x86_64__)
         uint32_t level_triggered:1;
         uint32_t logical_dest_mode:1;
         uint32_t rsvd:30;
+#elif defined(__aarch64__)
+        uint32_t rsvd1:2;
+        uint32_t asserted:1;
+        uint32_t rsvd2:29;
+#endif
     };
 };
 
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 75286baf16..0db18fcee9 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -47,10 +47,12 @@ extern bool mshv_allowed;
 typedef struct MshvState MshvState;
 extern MshvState *mshv_state;
 
+#if defined(__x86_64__)
 /* interrupt */
 int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint32_t vector,
                            uint32_t vp_index, bool logical_destination_mode,
                            bool level_triggered);
+#endif
 
 int mshv_irqchip_add_msi_route(int vector, PCIDevice *dev);
 int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev);

-- 
2.45.4


