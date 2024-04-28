Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B714DC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CpU-0001iF-Io; Sun, 28 Apr 2024 18:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Cp5-0000x9-Bw
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:42 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Cp3-0005ik-F7
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:16:39 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5708d8beec6so4685502a12.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342596; x=1714947396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ToTLt6YxD1s2pYbiLl6kqeNVfIHsdKCMcl6fReELYBM=;
 b=j0IgXlv+9XI93ElGBoTxjjsUw7buP4n6n/PmiESG9GtIq1+W6Ng6EgmPh+8MPDz7Cb
 QHdvwvITKOX2QByBY7dM1JW+i/+iHArR8n7M6RHegpQMTlh+D/gS8WDXFjbroMyN2ZF/
 dviqUdcpThITpIPkzo+H3pZVqD/Vhme/fWl0I5JR8iuFZMPsTuuJuFods4Pu9bHVCXcj
 dJ/c5XKHw5DIgO4DSOZPOJqK5sfZyjHqa+fT/vHbm7VQ6mf7cpDyNRaxqnm8z5MTfedX
 zxOknwUJ+Q7n9k/DnFLGxqCbpQEmkJCAwl56Gpb72dutrwhwUJ5ATe3bI/VfbHVVMHVT
 txdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342596; x=1714947396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ToTLt6YxD1s2pYbiLl6kqeNVfIHsdKCMcl6fReELYBM=;
 b=Bl2BRYWzTm/xT0PY7tiS6gVxUGfelCXDNHQMtzLbr2VOYa3gcV+TKmAL7RhCHA2Y7m
 aYhp1fccPmmEsN1W7c25v8ztFcUMycD5oYc0ij4a1gALy98FNzjDEzoXAxt543SBes5u
 /nCFDWKUnp4H+WG9BhUJY2QmYwx0KeI4GkXYyHvS2YvMh8xfOAYEW3g+ODNfRzcvDlII
 08q16zhgRbT9r9Qe6ofNqR8Bhp9g6MqK/SHBmyuV7QeRVLFYG0mBZpqYvGU3CPpdI+DI
 DVOlQ11NVwazxc580yc2X5hD75FYTUv1344Io8kVFhktxoCW1/f1OYAT/bh5lCutc/Am
 JH2A==
X-Gm-Message-State: AOJu0YxLwy7jG/8MvOBK/7Bse8pMVGHz+vmuSNQa9OegeXqdD7Sesh2X
 DerpzYQLj3v+qKlpnh4oqALADEvTbLE7IIfhUGRHXl1yegx5tL+4XPQpIbUwWJbSjv3r8QfXPyR
 0
X-Google-Smtp-Source: AGHT+IEBC6n6IhAJ1mUvhsmOenWOffuwvIauLTbhaoEB+ycrZAfDShkR3Fh662BHiNy8a2skcMTa2w==
X-Received: by 2002:a17:906:3905:b0:a55:a1d4:84f5 with SMTP id
 f5-20020a170906390500b00a55a1d484f5mr6751423eje.43.1714342595724; 
 Sun, 28 Apr 2024 15:16:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 fy7-20020a170906b7c700b00a55b1253fe5sm9144596ejb.194.2024.04.28.15.16.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:16:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 19/24] accel/tcg: Move @iommu_notifiers from CPUState to TCG
 AccelCPUState
Date: Mon, 29 Apr 2024 00:14:45 +0200
Message-ID: <20240428221450.26460-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

@iommu_notifiers is specific to TCG system emulation, move it to
AccelCPUState.

Restrict TCG specific code in system/physmem.c, adding an empty
stub for tcg_register_iommu_notifier().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/vcpu-state.h |  3 +++
 include/hw/core/cpu.h  |  3 ---
 system/physmem.c       | 37 ++++++++++++++++++++++++++++---------
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index 79e1490631..2d09dc3857 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -21,6 +21,9 @@ struct AccelCPUState {
     TaskState *ts;
 #else
     uintptr_t mem_io_pc;
+
+    /* track IOMMUs whose translations we've cached in the TCG TLB */
+    GArray *iommu_notifiers;
 #endif
 };
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index a8b4ae25f1..9e192f739a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -539,9 +539,6 @@ struct CPUState {
     /* Used for user-only emulation of prctl(PR_SET_UNALIGN). */
     bool prctl_unalign_sigbus;
 
-    /* track IOMMUs whose translations we've cached in the TCG TLB */
-    GArray *iommu_notifiers;
-
     /*
      * MUST BE LAST in order to minimize the displacement to CPUArchState.
      */
diff --git a/system/physmem.c b/system/physmem.c
index 44e477a1a5..1e003e42bb 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -27,6 +27,8 @@
 #include "qemu/madvise.h"
 
 #ifdef CONFIG_TCG
+#include "exec/translate-all.h"
+#include "accel/tcg/vcpu-state.h"
 #include "hw/core/tcg-cpu-ops.h"
 #endif /* CONFIG_TCG */
 
@@ -578,6 +580,8 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
     return mr;
 }
 
+#ifdef CONFIG_TCG
+
 typedef struct TCGIOMMUNotifier {
     IOMMUNotifier n;
     MemoryRegion *mr;
@@ -614,17 +618,20 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
     TCGIOMMUNotifier *notifier = NULL;
     int i;
 
-    for (i = 0; i < cpu->iommu_notifiers->len; i++) {
-        notifier = g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier *, i);
+    for (i = 0; i < cpu->accel->iommu_notifiers->len; i++) {
+        notifier = g_array_index(cpu->accel->iommu_notifiers,
+                                 TCGIOMMUNotifier *, i);
         if (notifier->mr == mr && notifier->iommu_idx == iommu_idx) {
             break;
         }
     }
-    if (i == cpu->iommu_notifiers->len) {
+    if (i == cpu->accel->iommu_notifiers->len) {
         /* Not found, add a new entry at the end of the array */
-        cpu->iommu_notifiers = g_array_set_size(cpu->iommu_notifiers, i + 1);
+        cpu->accel->iommu_notifiers = g_array_set_size(cpu->accel->iommu_notifiers,
+                                                       i + 1);
         notifier = g_new0(TCGIOMMUNotifier, 1);
-        g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier *, i) = notifier;
+        g_array_index(cpu->accel->iommu_notifiers,
+                      TCGIOMMUNotifier *, i) = notifier;
 
         notifier->mr = mr;
         notifier->iommu_idx = iommu_idx;
@@ -656,19 +663,31 @@ void tcg_iommu_free_notifier_list(CPUState *cpu)
     int i;
     TCGIOMMUNotifier *notifier;
 
-    for (i = 0; i < cpu->iommu_notifiers->len; i++) {
-        notifier = g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier *, i);
+    for (i = 0; i < cpu->accel->iommu_notifiers->len; i++) {
+        notifier = g_array_index(cpu->accel->iommu_notifiers,
+                                 TCGIOMMUNotifier *, i);
         memory_region_unregister_iommu_notifier(notifier->mr, &notifier->n);
         g_free(notifier);
     }
-    g_array_free(cpu->iommu_notifiers, true);
+    g_array_free(cpu->accel->iommu_notifiers, true);
 }
 
 void tcg_iommu_init_notifier_list(CPUState *cpu)
 {
-    cpu->iommu_notifiers = g_array_new(false, true, sizeof(TCGIOMMUNotifier *));
+    cpu->accel->iommu_notifiers = g_array_new(false, true,
+                                              sizeof(TCGIOMMUNotifier *));
 }
 
+#else
+
+static void tcg_register_iommu_notifier(CPUState *cpu,
+                                        IOMMUMemoryRegion *iommu_mr,
+                                        int iommu_idx)
+{
+}
+
+#endif
+
 /* Called from RCU critical section */
 MemoryRegionSection *
 address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
-- 
2.41.0


