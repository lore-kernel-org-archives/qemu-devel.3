Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A71CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL126-0005t3-TE; Thu, 07 May 2026 11:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL121-0005fA-0E
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11v-00041s-Fy
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:56 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso9870625e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169170; x=1778773970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wnWhtlm4IAr1WhwLbB5MRPiTCqVb37Q2LdPl5T2SX8w=;
 b=dRkQoIucKqNPEUkUnRSic2f1RmFwknFReQTH9+BNxaOi1Oo+S0gQblfhrh2hA3ME/D
 hfgT/G1xfun+rpXkA+m1we6d+byvwjQMgSQPHKsmM9Wx4XESBpsHiYXL6kbDMDEPUixk
 dBt8xRiaptwpe6WHW6YJ5Uiyzv5ce0hEMSr2pWs2NiBhyYe5S69ASV3wq0MDmN34DVsC
 jUaBj8OntsfYBYXRzYsyIpYFW52YkoPM7HMuMVfxsWRx+5BLP6F+kUIA/yvrY4xk29wg
 GvOqUM6PyaHGonlSLd7ntyoiVe3L7SMQBf4p2bEscWe2FNnH6WU0b24dGASvrlT3vlS+
 xHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169170; x=1778773970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wnWhtlm4IAr1WhwLbB5MRPiTCqVb37Q2LdPl5T2SX8w=;
 b=drMgxVo0cKYoW4l8U5oayKVUWXhMTFtoIMLojWVpAjf1MS6e8i5CMAWhC9W1K1R7uL
 8noofMFJ8J7t6Q5qAsyEv7CICogDGlL3Nd5KF7l3Kh5G2BJ9FO3UKDp0xbzFpnYDsBNd
 OZpKf7nObye4Pg5P5ZicRdiqHSi516qpIsyz1je4JexjJYp8PVLEA4Qw+0um4Z+hzD1x
 LeIo/w5cn5zJYwVxmz+VyMDdfVo48eh8140wYNFnLchKazWknS0Sd9JGuQF42bYcx9Qv
 GGORQQzR4hmSrMBOQdPqKP/V/0mNi/taoGcFb4YWGzx0NV2OBs6LWmxv3AdzhbTkMxuA
 ah3A==
X-Gm-Message-State: AOJu0YzmlO03UIgahEc/e3dT8aW5qOugeNvqnJwaXGvIK9jyNHshi6Hu
 edVeSi4RX9ysJ61uTZBj0AXMaW3ooNT5+hoh5XuKVhKzg3b/Ul5C8S9Qt6EIlwTZiWvYEBrztik
 cE29M
X-Gm-Gg: AeBDiesvImPVQEmhFnSSu50fmht8PQ70u5FhRZaAqGzKnVQmZBkBHdOh0osafW+hQoF
 qoiP9faZx7T4jqFABZBmNYVEX+JUXez3toNf+rCjcZ9AOWLLmMEYePOKsSZE1wc11feJ09TdeIO
 v06uCSwVVV39iFdL75ElkRDlFLoYfG8y5L5GBoQwxHzAHAiY4DHtlmxQ3wOQR9v4nXDaaYASxCD
 CJL/MKaY8Qu05d9tALLICUvaRHXOXpdWUzX07y+joCmkY+X6uXCr6T0iiNrn/37Sv/GNf+UZHLO
 7WetWvrATRRk/zQYw8hpW+bQOeR6xfKBDYRs6AohwCDUCO8nIOO3oasqMBDpNxn8A5ogflqGQew
 uYxxqZXnAW+9N/CeUhQBujKH5oHU/1DWsiZ7xBnT2Ii20OEu0NSqMylM15K9MP5zzKOb3lPBu8B
 5XA8OmvBxGGjhjvAr51dxZ5z70wFU6XUFXwGjDsca07t72h6/bLp5OohJdpp1u7JSVfZzXGfLQc
 MR2ygDwDwvOp+RiXYyTZnSYzZ40KsI=
X-Received: by 2002:a05:600c:c4a3:b0:48a:6fd4:d3d4 with SMTP id
 5b1f17b1804b1-48e51f46e38mr141491395e9.29.1778169169686; 
 Thu, 07 May 2026 08:52:49 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 55/67] hw/intc/arm_gicv3_cpuif: Don't allow GICv3 if CPU has
 GICv5 cpuif
Date: Thu,  7 May 2026 16:51:42 +0100
Message-ID: <20260507155154.1886557-56-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

The GICv3 and GICv5 CPU interfaces are not compatible, and a CPU will
only implement either one or the other.  If we find that we're trying
to connect a GICv3 to a CPU that implements FEAT_GCIE, fail.  This
will only happen if the board code has a bug and doesn't configure
its CPUs and its GIC consistently.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-56-peter.maydell@linaro.org
---
 hw/intc/arm_gicv3.c       |  2 +-
 hw/intc/arm_gicv3_cpuif.c | 14 +++++++++++++-
 hw/intc/gicv3_internal.h  |  2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 542f81ea49..e93c1df5b4 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -449,7 +449,7 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
 
     gicv3_init_irqs_and_mmio(s, gicv3_set_irq, gic_ops);
 
-    gicv3_init_cpuif(s);
+    gicv3_init_cpuif(s, errp);
 }
 
 static void arm_gicv3_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 921d1fdfde..67a0bba4b0 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -16,6 +16,7 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
+#include "qapi/error.h"
 #include "trace.h"
 #include "gicv3_internal.h"
 #include "hw/core/irq.h"
@@ -3047,7 +3048,7 @@ static void gicv3_cpuif_el_change_hook(ARMCPU *cpu, void *opaque)
     gicv3_cpuif_virt_irq_fiq_update(cs);
 }
 
-void gicv3_init_cpuif(GICv3State *s)
+void gicv3_init_cpuif(GICv3State *s, Error **errp)
 {
     /* Called from the GICv3 realize function; register our system
      * registers with the CPU
@@ -3058,6 +3059,17 @@ void gicv3_init_cpuif(GICv3State *s)
         ARMCPU *cpu = ARM_CPU(qemu_get_cpu(s->first_cpu_idx + i));
         GICv3CPUState *cs = &s->cpu[i];
 
+        if (cpu_isar_feature(aa64_gcie, cpu)) {
+            /*
+             * Attempt to connect GICv3 to a CPU with GICv5 cpuif
+             * (almost certainly a bug in the board code)
+             */
+            error_setg(errp,
+                       "Cannot connect GICv3 to CPU %d which has GICv5 cpuif",
+                       i);
+            return;
+        }
+
         /*
          * If the CPU doesn't define a GICv3 configuration, probably because
          * in real hardware it doesn't have one, then we use default values
diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index 880dbe52d8..c01be70464 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -722,7 +722,7 @@ void gicv3_redist_mov_vlpi(GICv3CPUState *src, uint64_t src_vptaddr,
 void gicv3_redist_vinvall(GICv3CPUState *cs, uint64_t vptaddr);
 
 void gicv3_redist_send_sgi(GICv3CPUState *cs, int grp, int irq, bool ns);
-void gicv3_init_cpuif(GICv3State *s);
+void gicv3_init_cpuif(GICv3State *s, Error **errp);
 
 /**
  * gicv3_cpuif_update:
-- 
2.43.0


