Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B574EC1112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZM8-0004UG-A8; Mon, 23 Feb 2026 12:04:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZL9-0002lp-Jh
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:27 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZL4-0000Q9-P5
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:23 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso34590135e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866194; x=1772470994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bURXc6DgG6dev9YjdHqHr0hS90pivhx67OlSlLCve5Y=;
 b=nB11IaeEFXFieX+qXCkPoznjem/GEsMFU2AdKrcdZ9FN1YsSBNWSbw00wti8zdpfvw
 2TINHFkzTHxGHoYIlQ1m3TxILcsZFmLB7r13MLaiSVP253p9ATmiJNTo+i8zKd4zGOpH
 f2bcjotoiSaOIDss2par9XQztHV5bXoN0m77b3gnmbRbrCCY4mgSQb8GRP6n0kadQ/BW
 n/CfM0tgkztKVvahgoJHeOiCNZxFBV33CeBrvptayIyBTmoFyWMCc2/TSIKt9jG8ZlTs
 8x7x6qAPXNhFFTsmxOZOSR01PNK5TbLvAZcR1qhbp1bSytdgonEpYi1E0kAVA+TdIB4V
 SQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866194; x=1772470994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bURXc6DgG6dev9YjdHqHr0hS90pivhx67OlSlLCve5Y=;
 b=Zf47mLRvXiVCZT4faXykirD2WrmC0OfvkzrckhC/xen9uKe19gIiHTDmLwbg3ZbB7r
 PNDgMPi8y1MT26dNll6R1bj5PYF/hf46ZnBV41DSBFA6BhyJ7r12FKXf4Ko3/R1780GY
 RwCe3uFa0dgqXpyTnvscDzNdbxxD6h9G4OYGIQdmWay7AaQ4mjGW/VOKeq9U3uTcR/Uu
 EqXUi8kV3WIlAiMkwLJGh0mR9vPlkahlhUAuczMyI/89alJGfOJKKdBKAH+QdfYSNJEh
 r0A1VLJ+Dc61DYlpTmvKAw740xAoYlZg+SHfTKmjAXApmw4Lnit76xx5rMLbG1PCBbHd
 KEqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSC/J7CET/32CPgQIoyW/ZKmZ7IiUO7KJ9Z5RbVpeavTfD/mbkZstD3QZI+nACN8AI9BICqxxlLQ3r@nongnu.org
X-Gm-Message-State: AOJu0YzGDxIHs3g8/3hjPGsPKYLtGN9/otkHo9SdemLFVMZkvcIH01qV
 reazRn734iDu19L2n5LCMAP/Z8LehtPtbiqG8h9L4324Qrtl5s9C3X2AjiFBN8lg39uOjnYnh+f
 eCxrK
X-Gm-Gg: AZuq6aLtJkBYvOg4rc5VbMSU5d0RH9z8XWpWSsaKWvkqoZKtnuiuOB3PoSZGxwXvphP
 nmNILZhGa0tkyI1ZDNT/aKdtOvUS5j74ANi2wp28mkGaYfQFn/NIzw+iVzrgnf2iqLqfoqCYQLb
 sSiaupFmjsuMqztzO5v79BNcd/YznKK13iEoMuqtp4433VO9iCAqlz26qS1sQO7LxIWRrYAC19S
 rKgELHD9MvyrW/enfYP+HDDtgiiQRFlGyQMDVe8BfuPAood164gK98b4aDn4QtF/qtm6jjCurmb
 rzk3zYaB+HqwQBakaiUyqF9rI/eiS3QFTTHQ0kvBCWVMSFZNn9YouXgSCReZeHSIaton7y3jdX2
 lCC1G4e1qOB9ZfK1gBQ2N4ZZf/YpoEBiUn+aOQGMGiDXdRRRBTiwXntQtlzb9j2Yl3ieMvKBGBm
 Qi6cY93nhXSffr09imOq5grkY7tNxo2XfZNbNLyh322EM5iwomj3WLkWEIRjC9ikGTLKl31ELFj
 CVUyJsRTziWiAh4D4l4Y9R2mcpzD68=
X-Received: by 2002:a05:600c:529b:b0:483:348a:d3f3 with SMTP id
 5b1f17b1804b1-483a95dde23mr171839585e9.18.1771866194355; 
 Mon, 23 Feb 2026 09:03:14 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:03:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 54/65] hw/intc/arm_gicv3_cpuif: Don't allow GICv3 if CPU has
 GICv5 cpuif
Date: Mon, 23 Feb 2026 17:02:01 +0000
Message-ID: <20260223170212.441276-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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


