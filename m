Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D4DC19F53
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mbn-0006zy-1H; Tue, 30 Apr 2024 08:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mbb-0006k7-4p
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:29:07 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mbY-0001of-4I
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:29:05 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a58872c07d8so1154699466b.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714480141; x=1715084941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBGkki3XoBfIeLSBwHuc796dXQHmu3Ot2VHczarNrMY=;
 b=kqRLcn5YLQQQhtF8RBWNWErFNPj75UFb7cBIZq7h3uM6XBTHqCMROG10TniACieJNf
 S4zTOsuMgczfhyo2j+lJK6cO2QNIWJiZ/uo7aRNn51sgWgPchgTEgYnIpL8wVF9UI2F+
 lDYUHV0bhlw9FU+JpCHSq9f6PVzCrp36V7oL3JPQifDqiLtUo8aT2z4NIdbln2JmISrA
 MYgAhUHp3Zmrsgvyj98Udg2GSPikcrL5bjpF42+Gd8gOB0YlYEtIleNNm5/ybyymIsWz
 e89tpqW6/gbup/lieMdn+yj6JMe1FgV9Ippr4Q4OegnNlMlypi1PyJMpjiz6CajTTR2W
 HkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714480141; x=1715084941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BBGkki3XoBfIeLSBwHuc796dXQHmu3Ot2VHczarNrMY=;
 b=uMiu3ivuRt6s25WaSf+zeuljrZ1TCk1DI7v6RxnxpNKdqU3vMwxUb+Z5nTV6v1GdFN
 Ln4sfVVBRILOw3HyjWHh20o9SJx2H5qOws9i4+pHUjGEUzywvrQBHOo2V+HHLINS/qVx
 l2xh6/WKdjLs68bca23SUqCbM+uCe9FOJA2Z+ZTFUSmY01L5HKvDkInOPsAmVMdg9LZO
 hc1uZndJSMUT/7kQgEZIHhpB+aFbhEyKdnBa7gbVDGe/HQttpoYoMGqqniv3/RQtohYd
 s5WWDN3Enu/pBMFLyyNyqmEBHwu8MXYSGweW48uLfAfYv7dgRdY6y+vzcsoGyUlTRrqr
 LOcA==
X-Gm-Message-State: AOJu0YyQ/azdRKOcVtvopJuhpkxDERnpKcAZJkS74qH9a9c1cwx7hteL
 EAppI9YFc/fPO0k2dlldYTLNgS3kkXTkXd2yjpU747fPchxNEqyNSoGfPnymSeYg3/luwqlUgUd
 V
X-Google-Smtp-Source: AGHT+IH2muPDunWpQvLAG1KhhAyuKsaVLoPnDczmVIgryUBO4+ACGZQsloBkOfw8yO1/berAhBciFw==
X-Received: by 2002:a17:907:1704:b0:a55:5698:3ea6 with SMTP id
 le4-20020a170907170400b00a5556983ea6mr2404261ejc.29.1714480141176; 
 Tue, 30 Apr 2024 05:29:01 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 a7-20020a170906670700b00a522bef9f06sm15005420ejp.181.2024.04.30.05.28.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 05:29:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/13] accel/tcg: Move @iommu_notifiers from CPUState to
 TCG AccelCPUState
Date: Tue, 30 Apr 2024 14:28:03 +0200
Message-ID: <20240430122808.72025-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430122808.72025-1-philmd@linaro.org>
References: <20240430122808.72025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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


