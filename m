Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7739FC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1YbB-0007Xj-M5; Mon, 29 Apr 2024 17:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Yb8-0007Mp-6k
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:31:42 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Yb3-0003Lh-Dd
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:31:41 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2dd19c29c41so60879941fa.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 14:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714426295; x=1715031095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBGkki3XoBfIeLSBwHuc796dXQHmu3Ot2VHczarNrMY=;
 b=oK+Qr0EnvQ0D481wAVEBqqxDeEDM33HSXGggjpvnPs4kt/a6im9SaB/A/fko97PPDD
 9KXZCjt6FPUZO13hKpekJHJtDw/Q5nxASNdB0mp44OpCCskFLSDwozrF6uBVQ9lFBTQ3
 d6UJxL4ZJZpdXU2i+sPQKbnKn+8v2lNIQLF0zp65LFTEmglkviKWUVLf0J4ZS5xEWbll
 PJBO/oqxOX+TXoWXM41o8c+x9DXFjKKRTiHs2OI39HjLNVkDDo4F0s5CGYr1JBdIV+LO
 uxcxSi4VD9WVOZo5DWVFVXE4rLJhUl+pkPSSHDsAAvdzts3lwoj1I6bmZ2JWcMVrbVXe
 MMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714426295; x=1715031095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BBGkki3XoBfIeLSBwHuc796dXQHmu3Ot2VHczarNrMY=;
 b=S0ysf88QNmFCnjhafzavkWkJg4f1EHl6iLg8xU+bn7up8tOUOA5ABPckrY/UfPZ6+m
 8oCzi0pGlJJXcA6KUVolxEstw2qP4qGWUK3AjfgBqevJym7m1yZzmycy/rES17l7VNZO
 yQi/bXrJDTg7+8pwrWXgoCoI3LQL9uvb159BmEoHCZ1ox34uniCNebJMhNmocia6fgPT
 6D1g9bhB7yFg0ZYGDSW4SqOwVOLGTxGRhv4FBeV0FzB4v2m4sP7OtLHupPAI2XqIxkO0
 eo3vT5uLQHLXk14mKs4zfl8FEC92DQPDt3PrRf+lHBknekMhnUuKTlWgD9He0mHKcmR5
 YJhQ==
X-Gm-Message-State: AOJu0YwU6NBYTdV+P5SiN6ziZXoJErJ6wpDu+sZp1BOM45Oecr8f90J6
 SEsCKg+uBn3O6kyXFPhWCjET9fOYM3HK1z5IxkVpGwWYKOJdC1cANLYzP3a8Gu2GmvtF2lbu2Bm
 2J1E=
X-Google-Smtp-Source: AGHT+IE1Ng6rHYsChopirmAPj2VPYY1D5otyUz9pBjjYA0XtLjNTMtJwjw7dWoGuXdYsHCfhW9MFgw==
X-Received: by 2002:a2e:8e8d:0:b0:2dc:bd10:2944 with SMTP id
 z13-20020a2e8e8d000000b002dcbd102944mr6649437ljk.53.1714426295300; 
 Mon, 29 Apr 2024 14:31:35 -0700 (PDT)
Received: from m1x-phil.lan (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 p8-20020a05600c358800b00418f72d9027sm40703434wmq.18.2024.04.29.14.31.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Apr 2024 14:31:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/13] accel/tcg: Move @iommu_notifiers from CPUState to
 TCG AccelCPUState
Date: Mon, 29 Apr 2024 23:30:45 +0200
Message-ID: <20240429213050.55177-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240429213050.55177-1-philmd@linaro.org>
References: <20240429213050.55177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428221450.26460-20-philmd@linaro.org>
---
 accel/tcg/vcpu-state.h |  3 +++
 include/hw/core/cpu.h  |  3 ---
 system/physmem.c       | 37 ++++++++++++++++++++++++++++---------
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index 5b09279140..51e54ca535 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -19,6 +19,9 @@ struct AccelCPUState {
 
 #ifdef CONFIG_USER_ONLY
     TaskState *ts;
+#else
+    /* track IOMMUs whose translations we've cached in the TCG TLB */
+    GArray *iommu_notifiers;
 #endif /* !CONFIG_USER_ONLY */
 
 #ifdef CONFIG_PLUGIN
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 97a0baf874..f3cbb944eb 100644
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


