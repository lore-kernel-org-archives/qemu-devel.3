Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E4910ED660
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65DJ-0000Cr-2O; Fri, 27 Mar 2026 07:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CT-0007RZ-P7
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:18:03 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CO-00005M-CM
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:58 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439bcec8613so1482460f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610274; x=1775215074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1a+4VgJGkwP3gKjTiIhrHr9y9Q94+K/thWEGPABWjoI=;
 b=tQ0U+vZkkrdFzQFVLB0RMBI1PpqQvChnbYcyX5ug+8eeaJqUuMwgI+meUH+ZNMa0f0
 IKlHVJfLYTC0J9AIIpMYp2YS+JMdBAOIbAOgTXUtkgTMHS+QzCw/iqfdGCWiJGebZgJi
 uUTE3LK9IIk/2s/nuo3EQ5zPiyhsRNtv3MnzEeQ2XEb+987HvtpJNFDkT+oLCc7sDie5
 fWk4q2mYnkMsvSWcM43COkWqQqq+I59twTkrrv4wGw3ivfnGgFJxIyhcn944FP6GFm3J
 QL/VvpeHTkR4IRfr4Z+gzXnUO2Av3oefjkbJizPTz63juh0P9Pbhaq1CsRDlDr1YkLTl
 UUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610274; x=1775215074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1a+4VgJGkwP3gKjTiIhrHr9y9Q94+K/thWEGPABWjoI=;
 b=bKLCCbVELZ19q5yidrEKxoM52gxc7rWLc4vsP0KUokQR3VlRnYb3Jqg3dmXrgFy4io
 e0plBR8L1bwXQ1o/ilY6bARVtRhlriaNvtSzke3/CA9LqzAX9jyJb5YnqVpc0av1XSNn
 ZK8IuB9qulkWTPVuND+9tfou+in9gW7zEY8SftSXcr7L+7SW2dcwE876ruUc0W6+LZI1
 ULXMUi4jnMUjvNJ4R3EZkoIBjiC7GvLLb1a07GTksQLBHPHibn17sTOAfkitGVdZ/9X/
 fVWvMppasXaRFrcXSQmtqtZYpU+vTCf9u/TehozaU3zANT5oY71KaSm1OaVTR/0ysWuv
 cLUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIScXu2phII1Dl4Rl7NVHEEZaz4FASGSgb+pv3qmDK+vmmEWCfBREqfSxZ801AioPotuqgdrdaS8KN@nongnu.org
X-Gm-Message-State: AOJu0YxY/ButYJ5LxEGVgFTxofGa764ZiLjnS3C72hzio+tlH81t/M2a
 S9SQvPASqe9QcTRpPn09Y9AzRVj7Q9hutHU8kkTofCfveOYoT8dvHdH3da6ZHuWfdII=
X-Gm-Gg: ATEYQzzON+N4Leg3YVLmTZAUX1qJNBTG4wtx5IekE+Z9f758h/hNxT2Ylb2fYvNvsHA
 LDb/z58Czmbssf9EMtuFBOYKJXuM064P422XXBh46objq1dXxBvCykImwnc9EyV4V4l1m6Xjd93
 puoDBeqcn4hdpx1sr/HQvquV5pWLFBx/5nd5Zc5PGAYvRjU4U/n1f+5bNKuiQRJD79Z4BVYH7Fv
 aLb+e1scj7b4c5dKMOBEqOxkq+/piVycobungaQGS90wpmxdiiZaGxA9Oy58MxJ5mYruISG63zr
 lyVGiPG4CLKTACcFfseIpv8ZnZ/PMdj2G793EBjxKotOpwHhfSdXcnQ8H+0VNxj81UQAcm7SqbS
 cD4Uuf2umb/bvc9oKq/tVsGiZQAPdL/grLzP3TxweomNIuTcnDDgZs9mwvh+CzIFTmcDjUZ2srC
 sPStwtWyXDE1IInW2H+b8XmX4CNVHayVLfioM+15eJGMMaA8bPC3gXtidup7firjc5AnNcelDLv
 xU7mZKA9BDSK1GlPq/XIikjl/FJecI=
X-Received: by 2002:a05:6000:2dc3:b0:43b:9986:2fbe with SMTP id
 ffacd0b85a97d-43b9ea76342mr2999444f8f.49.1774610274349; 
 Fri, 27 Mar 2026 04:17:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 55/65] hw/intc/arm_gicv3_cpuif: Don't allow GICv3 if CPU
 has GICv5 cpuif
Date: Fri, 27 Mar 2026 11:16:50 +0000
Message-ID: <20260327111700.795099-56-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
index eaf1e512ed..73e06f87d4 100644
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
@@ -3016,7 +3017,7 @@ static void gicv3_cpuif_el_change_hook(ARMCPU *cpu, void *opaque)
     gicv3_cpuif_virt_irq_fiq_update(cs);
 }
 
-void gicv3_init_cpuif(GICv3State *s)
+void gicv3_init_cpuif(GICv3State *s, Error **errp)
 {
     /* Called from the GICv3 realize function; register our system
      * registers with the CPU
@@ -3027,6 +3028,17 @@ void gicv3_init_cpuif(GICv3State *s)
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


