Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBDCC27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYPR-0002b6-EC; Mon, 10 Jun 2024 02:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYPO-0002WD-SR
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:21:34 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYPN-0004Ky-4S
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:21:34 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2e72224c395so36848891fa.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000491; x=1718605291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3whwfc3MxBP/Dl6fgI6kmvp8DpuAv6UONsu09faipM=;
 b=M4mCSfWPSgVHO2J0i7Zq5Bi62VUq/1UlCokJwA8gpDKJzS0X+AQu0AdhdHg9Mc0vBA
 f7jBbCCilTXkpCR5JF6qkYPdtAp9dRKI4MzZu6lbMk+ICUKTtEL43Jz6RBhlYkr2XlKp
 DZwmecaU7NxvBEPbcyWQQeBXy3nqv5CyFWbM7oddPA66wHFoBaRDz4+gUg1bovGQb1Qq
 XqqxXqyy9RiUQuUEUL9Sn4PXHXsAWNRRWgTn9iBmrzH6iXOy3b7v7abBHJ7YQtTtPiTj
 WGJmZ5E1HkxD5CZGmSNcdHZFLfeQ5jsAIE3++0BahkmIFbUHxgXchjyBZx9OhvsdJ/sb
 sVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000491; x=1718605291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F3whwfc3MxBP/Dl6fgI6kmvp8DpuAv6UONsu09faipM=;
 b=uTJA0oeWDawzoGezdiA3V8O5UWkci33ofdKBMn9OBlheS89JOfEfzkvSb34qd8Ef1h
 nNLXLofo5Rh1tHSqkzctWu42mh9GFjf5OsaJrqYP5w+kATRDO9KRgJB1UlehZK2+jw9X
 rt00Iy5FCHHffI2uBuMGpoKQXyzaC1lgWMp6katLUd/CX1RQixkyMo0Ze4+Nw0Z6KQCb
 EiZvvR5E06AJrW61Hfvqm4ZnZ+BsuKkJNfb4b20/qRRUQ8DL1VbN8TJ6Vd9TPpD6VcTG
 Sn4LqMYfEBTkbl06SCHu7KY1jkQ8+UUXpBrzDiRjdPbNNzvifgwvV+Lq6bE+CUmmOTx/
 ASBQ==
X-Gm-Message-State: AOJu0YwK3vpFcpqQaKEWiEQyG0zz3bUzN47mQ5PPBuvcB8KDzqUuv/I1
 apZbsy24ejN9DFlaW25p9nUF6Lv+jwerxDglIZizjEb9GFzmSzD3nBKH6V+su/HhWyKF+0L2uXp
 7
X-Google-Smtp-Source: AGHT+IESZW54dI91FB4qHok+l/AQe/8yc5sUbXpwbzx2SWrO2X6QBi7ohb+Nb2YBQXdx7Il46brPqA==
X-Received: by 2002:a05:651c:1a20:b0:2ea:83b5:40cf with SMTP id
 38308e7fff4ca-2eadce1e0e8mr70589411fa.3.1718000490837; 
 Sun, 09 Jun 2024 23:21:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421661ecda2sm101183575e9.2.2024.06.09.23.21.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:21:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/26] hw/ppc: Avoid using Monitor in ics_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:42 +0200
Message-ID: <20240610062105.49848-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Replace Monitor API by HumanReadableText one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/xics.h |  2 +-
 hw/intc/xics.c        | 17 ++++++++---------
 hw/intc/xics_spapr.c  |  4 ++--
 hw/ppc/pnv.c          | 15 ++++++++-------
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 1116aa6953..e94d53405f 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -172,7 +172,7 @@ static inline bool ics_irq_free(ICSState *ics, uint32_t srcno)
 
 void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
 void icp_pic_print_info(ICPState *icp, GString *buf);
-void ics_pic_print_info(ICSState *ics, Monitor *mon);
+void ics_pic_print_info(ICSState *ics, GString *buf);
 
 void ics_resend(ICSState *ics);
 void icp_resend(ICPState *ss);
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 039e10a0e4..6f4d5271ea 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -35,7 +35,6 @@
 #include "qemu/module.h"
 #include "qapi/visitor.h"
 #include "migration/vmstate.h"
-#include "monitor/monitor.h"
 #include "hw/intc/intc.h"
 #include "hw/irq.h"
 #include "sysemu/kvm.h"
@@ -68,12 +67,12 @@ void icp_pic_print_info(ICPState *icp, GString *buf)
                            icp->pending_priority, icp->mfrr);
 }
 
-void ics_pic_print_info(ICSState *ics, Monitor *mon)
+void ics_pic_print_info(ICSState *ics, GString *buf)
 {
     uint32_t i;
 
-    monitor_printf(mon, "ICS %4x..%4x %p\n",
-                   ics->offset, ics->offset + ics->nr_irqs - 1, ics);
+    g_string_append_printf(buf, "ICS %4x..%4x %p\n",
+                           ics->offset, ics->offset + ics->nr_irqs - 1, ics);
 
     if (!ics->irqs) {
         return;
@@ -89,11 +88,11 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
         if (!(irq->flags & XICS_FLAGS_IRQ_MASK)) {
             continue;
         }
-        monitor_printf(mon, "  %4x %s %02x %02x\n",
-                       ics->offset + i,
-                       (irq->flags & XICS_FLAGS_IRQ_LSI) ?
-                       "LSI" : "MSI",
-                       irq->priority, irq->status);
+        g_string_append_printf(buf, "  %4x %s %02x %02x\n",
+                               ics->offset + i,
+                               (irq->flags & XICS_FLAGS_IRQ_LSI) ?
+                               "LSI" : "MSI",
+                               irq->priority, irq->status);
     }
 }
 
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index bab9d88218..1926373ebd 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -409,10 +409,10 @@ static void xics_spapr_print_info(SpaprInterruptController *intc, Monitor *mon)
 
         icp_pic_print_info(spapr_cpu_state(cpu)->icp, buf);
     }
+    ics_pic_print_info(ics, buf);
+
     info = human_readable_text_from_str(buf);
     monitor_puts(mon, info->human_readable_text);
-
-    ics_pic_print_info(ics, mon);
 }
 
 static int xics_spapr_post_load(SpaprInterruptController *intc, int version_id)
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 5854358f65..3eaf674efa 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -770,20 +770,21 @@ static void pnv_chip_power8_pic_print_info(PnvChip *chip, Monitor *mon)
     Pnv8Chip *chip8 = PNV8_CHIP(chip);
     int i;
 
-    ics_pic_print_info(&chip8->psi.ics, mon);
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
+
+    ics_pic_print_info(&chip8->psi.ics, buf);
 
     for (i = 0; i < chip8->num_phbs; i++) {
         PnvPHB *phb = chip8->phbs[i];
         PnvPHB3 *phb3 = PNV_PHB3(phb->backend);
-        g_autoptr(GString) buf = g_string_new("");
-        g_autoptr(HumanReadableText) info = NULL;
 
         pnv_phb3_msi_pic_print_info(&phb3->msis, buf);
-        info = human_readable_text_from_str(buf);
-        monitor_puts(mon, info->human_readable_text);
-
-        ics_pic_print_info(&phb3->lsis, mon);
+        ics_pic_print_info(&phb3->lsis, buf);
     }
+
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 }
 
 static int pnv_chip_power9_pic_print_info_child(Object *child, void *opaque)
-- 
2.41.0


