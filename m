Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C722C48285
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 08:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV6JW-0001vL-7b; Wed, 31 Jan 2024 03:51:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JR-0001u8-FT
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:17 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rV6JO-0007po-7A
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 03:51:17 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e7065b7bdso54152165e9.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 00:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1706691071; x=1707295871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhFG2si/8hc7valLejRKh0mzo2o2mJ+vEmfkcumKKLU=;
 b=YKGnv2XA2PnlOK2/PmfJfQUJgIPRHq8xSAxajHe2DC9dmtmPaybWCb5L68mAliR7h/
 QY9Pcjpb1toMmoYVxDHgqnaj5cUv7iKL89OSMXIto/uSmDmxZKEk0atMaSCbJLK9LK+m
 WiFr3T3wscw5Y15lh5sIM39j1BJJ/FONoqU2xHeHdHpZHjh5sHYFHO5SBYksd9yWKSHU
 kYpTcE0TWTTjkNa+sdeTN7lMN41YGXOnghhI2gRsCqci+5fStkISExFcFia32syKqk4o
 awFvpOTa+NQkJ+Ynbc4PM6JGWK6lDKw/gAN/ervx0prn7BNmar/Od3MGa+2oVVGzwAQ1
 6/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706691071; x=1707295871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhFG2si/8hc7valLejRKh0mzo2o2mJ+vEmfkcumKKLU=;
 b=QEeBMbmgU+AvjrX7wepoPNGIagAfn3CMg0HGJFWhstF+OWa5317ocY7MRKpICRCfXj
 OWphRa8pSzbX1CnzEkM8TlM26G50dWPED4e5dtTfw0Nm5e95c7vRtv5PPWaW87fi5Jux
 Ju+hN71syl/89Zifgm2lteSBjXKIeh+U7+oOOUgEsP6UWW+ZxqvdDpuFfWMQv3KnmKoO
 fS6k+0/kj/9Slks/Zv4b8Knu+/YjqWommU7XEJVyUWxA05hGSIINUyGQZWvJgKNgSb7j
 g2KGgPffNz8S6VievVxBmgCjXqGcS3pkGq78LMxU8pYhfTmABdFPGiw73QdkBuLc2L1m
 ylSA==
X-Gm-Message-State: AOJu0YxZAY3pPMnwxImJIgKSuaK2yR7Nor0E59sul7J6QbUKcoNvpLWI
 T5pFBx43sfQwR2wE5KTwHM/Lk2mij7+D5jJg+L3ORMdwUV5hDnBlTxXggX5W4z1PsdQ4QYnm+eU
 =
X-Google-Smtp-Source: AGHT+IEOySXRt+Zv0KqHA3NQdMAyKw+lwax13cU07sBZ+Vm/YhAP1SfjpDKZzWEA5EjPSDlEtGAr0A==
X-Received: by 2002:a05:600c:3c83:b0:40e:d4d1:2e0b with SMTP id
 bg3-20020a05600c3c8300b0040ed4d12e0bmr765092wmb.19.1706691071599; 
 Wed, 31 Jan 2024 00:51:11 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVHOZmqgxzeK7aNB0hAoyg5OHAPd4uqCFh4thHu418hTgoo4PzYgIcuCsPqedbNtUkTlHr8BkMjAHYMj/8ixrzDPP021JrFGo+QV8XdZfOA83FIMbo6wCA+Kzyk
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:aea2:cdf3:9482:a36])
 by smtp.gmail.com with ESMTPSA id
 n28-20020a05600c181c00b0040efd216050sm909926wmp.35.2024.01.31.00.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 00:51:11 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/9] intc/grlib_irqmp: implements the multiprocessor status
 register
Date: Wed, 31 Jan 2024 09:50:41 +0100
Message-Id: <20240131085047.18458-4-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131085047.18458-1-chigot@adacore.com>
References: <20240131085047.18458-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x334.google.com
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

This implements the multiprocessor status register in grlib-irqmp and bind
it to a start signal, which will be later wired in leon3-generic to
start a cpu.

The EIRQ and BA bits are not implemented.

Based on https://gaisler.com/doc/gr712rc-usermanual.pdf, §8.3.5.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/grlib_irqmp.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 744cd64c58..1e073bd232 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -52,6 +52,10 @@
 #define FORCE_OFFSET     0x80
 #define EXTENDED_OFFSET  0xC0
 
+/* Multiprocessor Status Register  */
+#define MP_STATUS_CPU_STATUS_MASK ((1 << IRQMP_MAX_CPU)-2)
+#define MP_STATUS_NCPU_SHIFT      28
+
 #define MAX_PILS 16
 
 OBJECT_DECLARE_SIMPLE_TYPE(IRQMP, GRLIB_IRQMP)
@@ -65,6 +69,7 @@ struct IRQMP {
 
     unsigned int ncpus;
     IRQMPState *state;
+    qemu_irq start_signal[IRQMP_MAX_CPU];
     qemu_irq irq;
 };
 
@@ -72,6 +77,7 @@ struct IRQMPState {
     uint32_t level;
     uint32_t pending;
     uint32_t clear;
+    uint32_t mpstatus;
     uint32_t broadcast;
 
     uint32_t mask[IRQMP_MAX_CPU];
@@ -182,10 +188,12 @@ static uint64_t grlib_irqmp_read(void *opaque, hwaddr addr,
         return state->force[0];
 
     case CLEAR_OFFSET:
-    case MP_STATUS_OFFSET:
         /* Always read as 0 */
         return 0;
 
+    case MP_STATUS_OFFSET:
+        return state->mpstatus;
+
     case BROADCAST_OFFSET:
         return state->broadcast;
 
@@ -224,8 +232,9 @@ static uint64_t grlib_irqmp_read(void *opaque, hwaddr addr,
 static void grlib_irqmp_write(void *opaque, hwaddr addr,
                               uint64_t value, unsigned size)
 {
-    IRQMP      *irqmp = opaque;
+    IRQMP *irqmp = opaque;
     IRQMPState *state;
+    int i;
 
     assert(irqmp != NULL);
     state = irqmp->state;
@@ -258,7 +267,18 @@ static void grlib_irqmp_write(void *opaque, hwaddr addr,
         return;
 
     case MP_STATUS_OFFSET:
-        /* Read Only (no SMP support) */
+        /*
+         * Writing and reading operations are reversed for the CPU status.
+         * Writing "1" will start the CPU, but reading "1" means that the CPU
+         * is power-down.
+         */
+        value &= MP_STATUS_CPU_STATUS_MASK;
+        for (i = 0; i < irqmp->ncpus; i++) {
+            if ((value >> i) & 1) {
+                qemu_set_irq(irqmp->start_signal[i], 1);
+                state->mpstatus &= ~(1 << i);
+            }
+        }
         return;
 
     case BROADCAST_OFFSET:
@@ -325,6 +345,8 @@ static void grlib_irqmp_reset(DeviceState *d)
 
     memset(irqmp->state, 0, sizeof *irqmp->state);
     irqmp->state->parent = irqmp;
+    irqmp->state->mpstatus = ((irqmp->ncpus - 1) << MP_STATUS_NCPU_SHIFT) |
+        ((1 << irqmp->ncpus) - 2);
 }
 
 static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
@@ -338,6 +360,13 @@ static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS);
+
+    /*
+     * Transitionning from 0 to 1 starts the CPUs. The opposite can't
+     * happen.
+     */
+    qdev_init_gpio_out_named(dev, irqmp->start_signal, "grlib-start-cpu",
+                             IRQMP_MAX_CPU);
     qdev_init_gpio_out_named(dev, &irqmp->irq, "grlib-irq", 1);
     memory_region_init_io(&irqmp->iomem, OBJECT(dev), &grlib_irqmp_ops, irqmp,
                           "irqmp", IRQMP_REG_SIZE);
-- 
2.25.1


