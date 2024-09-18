Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0079CDD555
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 19:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr0Gs-00059V-Ql; Wed, 18 Sep 2024 15:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3myjrZgUKCtYL2NAH8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--tavip.bounces.google.com>)
 id 1sr0Gd-0004WT-NB
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:13 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3myjrZgUKCtYL2NAH8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--tavip.bounces.google.com>)
 id 1sr0Gb-0007Ji-AA
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:10 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e1cf5a262a1so1891781276.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726687387; x=1727292187; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=N0mLLGE0rv2nvuRlLPnX33wbjS5E+YrP6ov3cBLBWZc=;
 b=0m+g1g3jS+XnaulJIfhooxcEi94bm0jRNye9SD9g3hETthWoMs3Xmb+TVliqNgO1VE
 awH76I4FRzZSCRsIhMgiUwXZImCAAJ9OobDk1fejXygKdkl88P20KydInRR84KNuLV6y
 Jrqerd0+4DIyAAvAbATQx2O0xu3UwE4z1hacaNq4Tw44FcRUHcx7VDDCzmmSTX/zKgrI
 LZGk4DlSjfVicRyYkMUWtru0K5swlvxl7nWX5JdPYZ26c1EZY+FKjpHc4FEEGQ/COQYS
 4VTS3Ktb0WcptV6IlT6nBAEvEjpN7+3ba9JpxQxAyePyglKjzFae6Xg/ha5dcmvfJEOq
 xibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726687387; x=1727292187;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N0mLLGE0rv2nvuRlLPnX33wbjS5E+YrP6ov3cBLBWZc=;
 b=gmZphhLgusDWnqt1B1l/mJl/yx2GC44pmxRh7q88YiUC6wTPwt/1ZPi7ZgR5+k6J2P
 VpCiyeSiuUgzShrPV6EHLCyORPsUF/Iew6hb9FZoGxRNGqFMuDivRVb9/rVchC/p2e2C
 pKfsbG1CwLdNrgaNCjm5S6nXTr/4JQe/QjXiSEl3BU2/QW8SiG5z2AiJ1y9NjWClylJI
 l+ulIqX7Q3Eko1GRCI0J570OkeASqoFoD0ADIUVCNzuiqin/eTEWnXN+CYRLxRgo1E9Y
 V8ykKYtuuxASDbTTyt/HV4g/PcnVcRK4PTs6TejNIVA2q3LMu/BJoemytNKjIedSS6q4
 eADg==
X-Gm-Message-State: AOJu0YxbUdx7A+5ObIIv4x3IsYzsnU8YrjDULzXmuWTG/Slqca1KCge3
 UHFL703XXYMw1EEagXRUu9yHFdxqusv8X9IdhZabhC//iM+sh9cxMUdjzC9l5SSdXctBng6a+QW
 D47Xo4E18h2TM8R7fVHUkF6V4zowGgpxssZy0J9FrFJH5DwM81LrTIvri5amODVJNdlkN/jMPvL
 EZVJ/ZTceip0NOK+7lXKeDkeA7WA==
X-Google-Smtp-Source: AGHT+IGiN+24hJHARIxCHe91zgdsq5LVt36r+C7rV42PSxNyzYourZrlN5RLRH4+YDF/damEVPHqm/iAsQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6902:b0a:b0:e1a:a30e:3393
 with SMTP id
 3f1490d57ef6-e202732b68fmr4158276.0.1726687387063; Wed, 18 Sep 2024 12:23:07
 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:22:34 -0700
In-Reply-To: <20240918192254.3136903-1-tavip@google.com>
Mime-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918192254.3136903-7-tavip@google.com>
Subject: [PATCH 06/25] hw/misc/flexcomm.c: add common fifo functionality
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3myjrZgUKCtYL2NAH8GG8D6.4GEI6EM-56N6DFGF8FM.GJ8@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

FLEXCOMM SPI and USART share FIFO functionality. Add common helper
functions to avoid code duplication.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/misc/flexcomm.h          |  2 +
 include/hw/misc/flexcomm_function.h |  8 +++
 hw/misc/flexcomm.c                  | 83 +++++++++++++++++++++++++++++
 hw/misc/trace-events                |  1 +
 4 files changed, 94 insertions(+)

diff --git a/include/hw/misc/flexcomm.h b/include/hw/misc/flexcomm.h
index ea0fe77f26..832d4cd29d 100644
--- a/include/hw/misc/flexcomm.h
+++ b/include/hw/misc/flexcomm.h
@@ -44,6 +44,8 @@ struct FlexcommState {
     uint32_t functions;
     qemu_irq irq;
     bool irq_state;
+    Fifo32 rx_fifo;
+    Fifo32 tx_fifo;
 };
 
 #endif /* HW_FLEXCOMM_H */
diff --git a/include/hw/misc/flexcomm_function.h b/include/hw/misc/flexcomm_function.h
index e498976927..3ff1677ff6 100644
--- a/include/hw/misc/flexcomm_function.h
+++ b/include/hw/misc/flexcomm_function.h
@@ -23,6 +23,8 @@ struct FlexcommFunction {
 
     MemoryRegion mmio;
     uint32_t *regs;
+    Fifo32 *tx_fifo;
+    Fifo32 *rx_fifo;
 };
 
 typedef void (*FlexcommFunctionSelect)(FlexcommFunction *f, bool selected);
@@ -32,6 +34,7 @@ struct FlexcommFunctionClass {
 
     const MemoryRegionOps *mmio_ops;
     const char *name;
+    bool has_fifos;
     FlexcommFunctionSelect select;
 };
 
@@ -43,5 +46,10 @@ static inline void flexcomm_select(FlexcommFunction *obj, bool selected)
 }
 
 void flexcomm_set_irq(FlexcommFunction *f, bool irq);
+void flexcomm_update_fifostat(FlexcommFunction *f);
+void flexcomm_clear_fifostat(FlexcommFunction *f, uint64_t value);
+void flexcomm_init_fifos(FlexcommFunction *f, unsigned num);
+void flexcomm_cleanup_fifos(FlexcommFunction *f);
+void flexcomm_reset_fifos(FlexcommFunction *f);
 
 #endif /* HW_FLEXCOMM_FUNCTION_H */
diff --git a/hw/misc/flexcomm.c b/hw/misc/flexcomm.c
index 2337fb814c..a98d8845aa 100644
--- a/hw/misc/flexcomm.c
+++ b/hw/misc/flexcomm.c
@@ -22,6 +22,7 @@
 #include "trace.h"
 #include "migration/vmstate.h"
 #include "hw/misc/flexcomm.h"
+#include "hw/arm/svd/flexcomm_usart.h"
 
 #define REG(s, reg) (s->regs[R_FLEXCOMM_##reg])
 #define RF_WR(s, reg, field, val) \
@@ -219,12 +220,22 @@ static void flexcomm_init(Object *obj)
     sysbus_init_irq(sbd, &s->irq);
 }
 
+static void flexcomm_finalize(Object *obj)
+{
+    FlexcommState *s = FLEXCOMM(obj);
+
+    /* release resources allocated by the function select (e.g. fifos) */
+    flexcomm_func_select(s, false);
+}
+
 static void flexcomm_func_realize_and_unref(FlexcommFunction *f, Error **errp)
 {
     FlexcommState *s = FLEXCOMM(OBJECT(f)->parent);
     FlexcommFunctionClass *fc = FLEXCOMM_FUNCTION_GET_CLASS(f);
 
     f->regs = s->regs;
+    f->tx_fifo = &s->tx_fifo;
+    f->rx_fifo = &s->rx_fifo;
     memory_region_add_subregion_overlap(&s->container, 0, &f->mmio, 0);
     DEVICE(f)->id = g_strdup_printf("%s-%s", DEVICE(s)->id, fc->name);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(f), errp);
@@ -274,11 +285,82 @@ void flexcomm_set_irq(FlexcommFunction *f, bool irq)
     }
 }
 
+/* FIFO is shared between USART and SPI, provide common functions here */
+#define FIFO_REG(s, reg) (s->regs[R_FLEXCOMM_USART_FIFO##reg])
+#define FIFO_WR(s, reg, field, val) \
+    ARRAY_FIELD_DP32(s->regs, FLEXCOMM_USART_FIFO##reg, field, val)
+#define FIFO_RD(s, reg, field) \
+    ARRAY_FIELD_EX32(s->regs, FLEXCOMM_USART_FIFO##reg, field)
+
+void flexcomm_update_fifostat(FlexcommFunction *f)
+{
+    int rxlvl = fifo32_num_used(f->rx_fifo);
+    int txlvl = fifo32_num_used(f->tx_fifo);
+
+    FIFO_WR(f, STAT, RXLVL, rxlvl);
+    FIFO_WR(f, STAT, TXLVL, txlvl);
+    FIFO_WR(f, STAT, RXFULL, fifo32_is_full(f->rx_fifo) ? 1 : 0);
+    FIFO_WR(f, STAT, RXNOTEMPTY, !fifo32_is_empty(f->rx_fifo) ? 1 : 0);
+    FIFO_WR(f, STAT, TXNOTFULL, !fifo32_is_full(f->tx_fifo) ? 1 : 0);
+    FIFO_WR(f, STAT, TXEMPTY, fifo32_is_empty(f->tx_fifo) ? 1 : 0);
+
+    if (FIFO_RD(f, TRIG, RXLVLENA) && (rxlvl > FIFO_RD(f, TRIG, RXLVL))) {
+        FIFO_WR(f, INTSTAT, RXLVL, 1);
+    } else {
+        FIFO_WR(f, INTSTAT, RXLVL, 0);
+    }
+
+    if (FIFO_RD(f, TRIG, TXLVLENA) && (txlvl <= FIFO_RD(f, TRIG, TXLVL))) {
+        FIFO_WR(f, INTSTAT, TXLVL, 1);
+    } else {
+        FIFO_WR(f, INTSTAT, TXLVL, 0);
+    }
+
+    trace_flexcomm_fifostat(DEVICE(f)->id, FIFO_REG(f, STAT),
+                            FIFO_REG(f, INTSTAT));
+}
+
+void flexcomm_reset_fifos(FlexcommFunction *f)
+{
+    if (FIFO_RD(f, CFG, EMPTYRX)) {
+        FIFO_WR(f, CFG, EMPTYRX, 0);
+        fifo32_reset(f->rx_fifo);
+    }
+    if (FIFO_RD(f, CFG, EMPTYTX)) {
+        FIFO_WR(f, CFG, EMPTYTX, 0);
+        fifo32_reset(f->tx_fifo);
+    }
+}
+
+void flexcomm_clear_fifostat(FlexcommFunction *f, uint64_t value)
+{
+    bool rxerr = FIELD_EX32(value, FLEXCOMM_USART_FIFOSTAT, RXERR);
+    bool txerr = FIELD_EX32(value, FLEXCOMM_USART_FIFOSTAT, TXERR);
+
+    if (rxerr) {
+        FIFO_WR(f, STAT, RXERR, 0);
+    }
+    if (txerr) {
+        FIFO_WR(f, STAT, TXERR, 0);
+    }
+}
+
 static void flexcomm_function_select(FlexcommFunction *f, bool selected)
 {
     FlexcommFunctionClass *fc = FLEXCOMM_FUNCTION_GET_CLASS(f);
 
     memory_region_set_enabled(&f->mmio, selected);
+    if (fc->has_fifos) {
+        if (selected) {
+            unsigned num = FIFO_RD(f, SIZE, FIFOSIZE);
+
+            fifo32_create(f->tx_fifo, num);
+            fifo32_create(f->rx_fifo, num);
+        } else {
+            fifo32_destroy(f->tx_fifo);
+            fifo32_destroy(f->rx_fifo);
+        }
+    }
 }
 
 static void flexcomm_function_init(Object *obj)
@@ -303,6 +385,7 @@ static const TypeInfo flexcomm_types[] = {
         .parent        = TYPE_SYS_BUS_DEVICE,
         .instance_size = sizeof(FlexcommState),
         .instance_init = flexcomm_init,
+        .instance_finalize = flexcomm_finalize,
         .class_init    = flexcomm_class_init,
     },
     {
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 419879fd65..dc245905dc 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -367,3 +367,4 @@ flexcomm_reset(void) ""
 flexcomm_irq(const char *id, uint8_t irq) "%s %d"
 flexcomm_reg_read(const char *devname, const char *regname, uint32_t addr, uint32_t val) "%s: %s[0x%04x] -> 0x%08x"
 flexcomm_reg_write(const char *dename, const char *regname, uint32_t addr, uint32_t val) "%s: %s[0x%04x] <- 0x%08x"
+flexcomm_fifostat(const char *id, uint32_t fifostat, uint32_t fifoinstat) "%s: %08x %08x"
-- 
2.46.0.662.g92d0881bb0-goog


