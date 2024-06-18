Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA74C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbIr-0007an-W4; Tue, 18 Jun 2024 12:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbIk-0007Ly-Uk
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:20 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbIi-00078m-Vc
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:18 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a6f9fe791f8so65682066b.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726595; x=1719331395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2h5hZc6LXMjCThYre/XODwbhy/fDBZZML+oz5gALLWA=;
 b=d1EXL3myi9i9PZt9+kVwyP9RdCN6V+FdpXCPAhlpWaJJTv6S8VuCOEekepdbhdS+0r
 whDH7V4hb7unkRDM5LzU+cejFPsRncVjS4P5C9Wu4EHXrYC55DNRNoQMnQN+tUjw1oTm
 JrBgTI09AoOb9FQoD+G/IRpZV8YliPv1pRYRJKQPacBXk3u0X9DEYRZcivP7H5HI6dVX
 xse6T7VIH6KRJWjxxMkbr4X9dnG1AfuggFabCIZ/vAicNXqxcNwZpnLpttO+3PrEXNPj
 MUiqUOaiAxce2aKq4dHwwRUud7MsjcZi/hbdGFz321czFEbEokXakgFLbAeyppNpyfPV
 oKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726595; x=1719331395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2h5hZc6LXMjCThYre/XODwbhy/fDBZZML+oz5gALLWA=;
 b=nGjoX2H7btaGEACO9Ra5T1fKVMbGS5FH2wRCifO1oyXQDX6BTyFW0A/nGE0lvx+YNS
 YfYS+7ba0K0NQscXFBAEfh5Uf3l38MVmDPrmVrwQXHOjEmpF8nQ2UAz5dgu02G39LiLR
 Tp6qSGyuNL7J1CCSHstvV86C5M8WYPuq+vffHHXm3QAIRqWxwaBq0LhpNc6syRIh17yU
 7OKf6e0/fyzTRiy4KlNPv0VIs+HwPSP/FxYHmLgGfQp+dbCME9nAWt3R0lwkJ+886kfH
 GoWoAgkOoHYBx7enwzxzuf11Qvts8MwyEeC17POxWzo7z3P60l0BTdT1Q/+DZPfFsw2x
 Mt4g==
X-Gm-Message-State: AOJu0YyUM3UGzS5f8+wxkhOppIln6TM6olayez4tzlhRNpIJ/t6ZDayN
 dfLyxxjlUICMqVIsnaKGvK442KPm40Z/owptmQone9KzxGdf7jE40mISDCh6/eHSJDumNPtHUYq
 B
X-Google-Smtp-Source: AGHT+IGFHLkAzXgnMVF953doTFT7+WsvM3vKWHZEFWE3fwourM4SYc8AkG8sUsdruwNlTNXVkfAdIQ==
X-Received: by 2002:a17:906:370a:b0:a6f:a262:2f89 with SMTP id
 a640c23a62f3a-a6fa26234b5mr34753666b.12.1718726595178; 
 Tue, 18 Jun 2024 09:03:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db618dsm626220166b.75.2024.06.18.09.03.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:03:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 26/76] hw/ppc: Avoid using Monitor in icp_pic_print_info()
Date: Tue, 18 Jun 2024 17:59:48 +0200
Message-ID: <20240618160039.36108-27-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

Replace Monitor API by HumanReadableText one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-Id: <20240610062105.49848-3-philmd@linaro.org>
---
 include/hw/ppc/xics.h | 2 +-
 hw/intc/xics.c        | 8 ++++----
 hw/intc/xics_spapr.c  | 8 +++++++-
 hw/ppc/pnv.c          | 8 +++++++-
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 95ead0dd7c..1116aa6953 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -171,7 +171,7 @@ static inline bool ics_irq_free(ICSState *ics, uint32_t srcno)
 }
 
 void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
-void icp_pic_print_info(ICPState *icp, Monitor *mon);
+void icp_pic_print_info(ICPState *icp, GString *buf);
 void ics_pic_print_info(ICSState *ics, Monitor *mon);
 
 void ics_resend(ICSState *ics);
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 9b3b7abaea..039e10a0e4 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -42,7 +42,7 @@
 #include "sysemu/reset.h"
 #include "target/ppc/cpu.h"
 
-void icp_pic_print_info(ICPState *icp, Monitor *mon)
+void icp_pic_print_info(ICPState *icp, GString *buf)
 {
     int cpu_index;
 
@@ -63,9 +63,9 @@ void icp_pic_print_info(ICPState *icp, Monitor *mon)
         icp_synchronize_state(icp);
     }
 
-    monitor_printf(mon, "CPU %d XIRR=%08x (%p) PP=%02x MFRR=%02x\n",
-                   cpu_index, icp->xirr, icp->xirr_owner,
-                   icp->pending_priority, icp->mfrr);
+    g_string_append_printf(buf, "CPU %d XIRR=%08x (%p) PP=%02x MFRR=%02x\n",
+                           cpu_index, icp->xirr, icp->xirr_owner,
+                           icp->pending_priority, icp->mfrr);
 }
 
 void ics_pic_print_info(ICSState *ics, Monitor *mon)
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 37b2d99977..bab9d88218 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -34,6 +34,8 @@
 #include "hw/ppc/xics_spapr.h"
 #include "hw/ppc/fdt.h"
 #include "qapi/visitor.h"
+#include "qapi/type-helpers.h"
+#include "monitor/monitor.h"
 
 /*
  * Guest interfaces
@@ -399,12 +401,16 @@ static void xics_spapr_print_info(SpaprInterruptController *intc, Monitor *mon)
 {
     ICSState *ics = ICS_SPAPR(intc);
     CPUState *cs;
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
 
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
 
-        icp_pic_print_info(spapr_cpu_state(cpu)->icp, mon);
+        icp_pic_print_info(spapr_cpu_state(cpu)->icp, buf);
     }
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 
     ics_pic_print_info(ics, mon);
 }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 5356a4e295..fa23b27a2b 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1130,7 +1130,13 @@ static void pnv_chip_power8_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
 static void pnv_chip_power8_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
                                             Monitor *mon)
 {
-    icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), mon);
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
+
+    icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), buf);
+
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 }
 
 /*
-- 
2.41.0


