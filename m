Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB39AC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 08:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV6JX-0001vN-D1; Wed, 31 Jan 2024 03:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JR-0001u9-Ia
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:17 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JP-0007qD-JJ
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:17 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51124d43943so635099e87.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 00:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1706691073; x=1707295873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e4h/3nnPQ8lnDqMYJQ1DshvzX1Bc/jBjk24rZPsboDU=;
 b=Q+FkKS3pg8S9D4DeQDRGiO5mYibsrvzSXj9hCa2xpw9q+4ediJyu4+cLa5r5WELms7
 67d3d4BukJanKFTaqbg1wv7XPi2aP3BfhR74suQM8/VGvLZ1rUkM0pjN5ei8/GY+j14m
 23j20kaP8tJlAEy5mt8cTyRlQpuYvmnMsq5ZTamwRktpKv9E4+ixgoTwmrPFk2CKAnt4
 BpOpuDKFGX5GZVAgMJGmszVcoOD0iRK0mLuEFa4XA/cWCa0uIZLXV1c80wk4B+sqKQZq
 MquwlJbWrk+leOJPa7j0LWhVuRCWzH9F4dYy9NcgMqaB8H7BgcUCDxXOgk/PONy8xaGB
 9dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706691073; x=1707295873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e4h/3nnPQ8lnDqMYJQ1DshvzX1Bc/jBjk24rZPsboDU=;
 b=emgRWF+r/iW6Kq7Fb1cIzt6hA2VmKPZynvJ5Dz4hs4Fd5A5GSf58NFeAO7Or3otSMu
 bLvPJki5pRYhpuwCJFY5qB4CxWBAM09DNVCfq2SthcogFOJhywEhqD+BzMUWXxXNxWhb
 vPsk/+69PqkesDiCnBqfg1mDP1KwbYnj+Tqq8oKJ7Ajffjdew+2NYFOFYwUaRnU6hx4j
 nAsn7NJnVD3WIxf2vn35RaGtT6QkA8SfuaL2IjUDfgCJTgnP8FKzIp1nobmISW/2RBTY
 9KdWn0FHkN1Oz+UjRo8Cd7PKnn0rCbOCU66vCxv66CHe+hkxa9IT1+uTHMaUZOcgdTXj
 JROQ==
X-Gm-Message-State: AOJu0Yx2PQfRVEh9ioUJljeFXecJAzVSb+pdIf9Vt+0D9Ns05BVk+e58
 dutoKYhKb+9qBhsWQ7egnFeT/agfFY/TSYKooILWxG4hmbAP6/x4XY7bWCR07cJZZY3HXhtnXV8
 =
X-Google-Smtp-Source: AGHT+IGs/9949DPA8sdmmtLemwNf6uWUnk3kuyBkOfnfv1ZgZbkHVq6CiA+SBZF+lheNQWwh1jxlQQ==
X-Received: by 2002:a05:6512:3092:b0:50d:1c9d:59e4 with SMTP id
 z18-20020a056512309200b0050d1c9d59e4mr853925lfd.47.1706691073040; 
 Wed, 31 Jan 2024 00:51:13 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXDYY265u549utEEB7gQkiGGb4xfpLe4jc21uCG5k8gM2WzmrATkv6Kvn5s226dmOssumjmRu62PWSEPAFmshlYmGwyP+BakTb/GipL4DxZo1OUorw+n4AvAlW/
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:aea2:cdf3:9482:a36])
 by smtp.gmail.com with ESMTPSA id
 n28-20020a05600c181c00b0040efd216050sm909926wmp.35.2024.01.31.00.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 00:51:12 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/9] intc/grlib_irqmp: implements multicore irq
Date: Wed, 31 Jan 2024 09:50:42 +0100
Message-Id: <20240131085047.18458-5-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131085047.18458-1-chigot@adacore.com>
References: <20240131085047.18458-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=chigot@adacore.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now there is an ncpus property, use it in order to deliver the IRQ to
multiple CPU.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/grlib_irqmp.c         | 41 +++++++++++++++++------------------
 hw/sparc/leon3.c              |  3 ++-
 include/hw/intc/grlib_irqmp.h |  2 +-
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 1e073bd232..144b121d48 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -70,7 +70,7 @@ struct IRQMP {
     unsigned int ncpus;
     IRQMPState *state;
     qemu_irq start_signal[IRQMP_MAX_CPU];
-    qemu_irq irq;
+    qemu_irq irq[IRQMP_MAX_CPU];
 };
 
 struct IRQMPState {
@@ -89,37 +89,35 @@ struct IRQMPState {
 
 static void grlib_irqmp_check_irqs(IRQMPState *state)
 {
-    uint32_t      pend   = 0;
-    uint32_t      level0 = 0;
-    uint32_t      level1 = 0;
+    int i;
 
     assert(state != NULL);
     assert(state->parent != NULL);
 
-    /* IRQ for CPU 0 (no SMP support) */
-    pend = (state->pending | state->force[0])
-        & state->mask[0];
-
-    level0 = pend & ~state->level;
-    level1 = pend &  state->level;
+    for (i = 0; i < state->parent->ncpus; i++) {
+        uint32_t pend = (state->pending | state->force[i]) & state->mask[i];
+        uint32_t level0 = pend & ~state->level;
+        uint32_t level1 = pend &  state->level;
 
-    trace_grlib_irqmp_check_irqs(state->pending, state->force[0],
-                                 state->mask[0], level1, level0);
+        trace_grlib_irqmp_check_irqs(state->pending, state->force[i],
+                                     state->mask[i], level1, level0);
 
-    /* Trigger level1 interrupt first and level0 if there is no level1 */
-    qemu_set_irq(state->parent->irq, level1 ?: level0);
+        /* Trigger level1 interrupt first and level0 if there is no level1 */
+        qemu_set_irq(state->parent->irq[i], level1 ?: level0);
+    }
 }
 
-static void grlib_irqmp_ack_mask(IRQMPState *state, uint32_t mask)
+static void grlib_irqmp_ack_mask(IRQMPState *state, unsigned int cpu,
+                                 uint32_t mask)
 {
     /* Clear registers */
     state->pending  &= ~mask;
-    state->force[0] &= ~mask; /* Only CPU 0 (No SMP support) */
+    state->force[cpu] &= ~mask;
 
     grlib_irqmp_check_irqs(state);
 }
 
-void grlib_irqmp_ack(DeviceState *dev, int intno)
+void grlib_irqmp_ack(DeviceState *dev, unsigned int cpu, int intno)
 {
     IRQMP        *irqmp = GRLIB_IRQMP(dev);
     IRQMPState   *state;
@@ -133,7 +131,7 @@ void grlib_irqmp_ack(DeviceState *dev, int intno)
 
     trace_grlib_irqmp_ack(intno);
 
-    grlib_irqmp_ack_mask(state, mask);
+    grlib_irqmp_ack_mask(state, cpu, mask);
 }
 
 static void grlib_irqmp_set_irq(void *opaque, int irq, int level)
@@ -159,7 +157,6 @@ static void grlib_irqmp_set_irq(void *opaque, int irq, int level)
             s->pending |= 1 << irq;
         }
         grlib_irqmp_check_irqs(s);
-
     }
 }
 
@@ -263,7 +260,9 @@ static void grlib_irqmp_write(void *opaque, hwaddr addr,
 
     case CLEAR_OFFSET:
         value &= ~1; /* clean up the value */
-        grlib_irqmp_ack_mask(state, value);
+        for (i = 0; i < irqmp->ncpus; i++) {
+            grlib_irqmp_ack_mask(state, i, value);
+        }
         return;
 
     case MP_STATUS_OFFSET:
@@ -367,7 +366,7 @@ static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
      */
     qdev_init_gpio_out_named(dev, irqmp->start_signal, "grlib-start-cpu",
                              IRQMP_MAX_CPU);
-    qdev_init_gpio_out_named(dev, &irqmp->irq, "grlib-irq", 1);
+    qdev_init_gpio_out_named(dev, irqmp->irq, "grlib-irq", irqmp->ncpus);
     memory_region_init_io(&irqmp->iomem, OBJECT(dev), &grlib_irqmp_ops, irqmp,
                           "irqmp", IRQMP_REG_SIZE);
 
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index b72761b959..7866f0a049 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -170,7 +170,8 @@ static void leon3_cache_control_int(CPUSPARCState *env)
 
 static void leon3_irq_ack(CPUSPARCState *env, int intno)
 {
-    grlib_irqmp_ack(env->irq_manager, intno);
+    /* No SMP support yet, only CPU #0 available so far.  */
+    grlib_irqmp_ack(env->irq_manager, 0, intno);
 }
 
 /*
diff --git a/include/hw/intc/grlib_irqmp.h b/include/hw/intc/grlib_irqmp.h
index c5a90cbb3e..a76acbf940 100644
--- a/include/hw/intc/grlib_irqmp.h
+++ b/include/hw/intc/grlib_irqmp.h
@@ -36,6 +36,6 @@
 /* IRQMP */
 #define TYPE_GRLIB_IRQMP "grlib-irqmp"
 
-void grlib_irqmp_ack(DeviceState *dev, int intno);
+void grlib_irqmp_ack(DeviceState *dev, unsigned int cpu, int intno);
 
 #endif /* GRLIB_IRQMP_H */
-- 
2.25.1


