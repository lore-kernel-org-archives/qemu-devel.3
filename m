Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0322FC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbJA-0008Fc-63; Tue, 18 Jun 2024 12:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJ7-0008AG-GL
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:41 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJ5-0007CW-JC
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:41 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6f176c5c10so689472866b.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726618; x=1719331418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RbmmnCUJBjQWo1lmiofvPL4byDgdBrAqOfBylHKE/0k=;
 b=oqNZLc/NhQz1X+mJbZsecpMWzGNcxBGSQkxsNbFMnftoS1wMSoblwQTqJNpVZ/0qZG
 sTsdPkTdLL+z7KHRYJeKntiDTvP+3YhmNcCAu9QH7WsdJTRCNGfqszaDKiTvfBsuzOPT
 qCHuwDW9I/QyHJXOQdZuooIop4HT+C5guTR0+KeQa0DxreuEYCPQYM4OJHfIlkKEteYj
 EO2xvqug3w+MRtRbyGQzsbhnYovg11OSaq6a3NNoi42gDcUgWcpRwg13Rlaiol/DUTO2
 vMZCSy/SGYS0XjQ3lGen4VMnDYLosFS1q72e+iJ7cwQuiUoaVR71g5jjye9JiGOb54KO
 DenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726618; x=1719331418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RbmmnCUJBjQWo1lmiofvPL4byDgdBrAqOfBylHKE/0k=;
 b=UedaKTOJ+1EEOamY3X100G5Eou6JDSnplCAX6IsR+EpjI9mII+b6QxwXQ3fC9sdaVm
 IioCcnMxAr4AAYcj1+DZQ0QGZYEjDlGTB/GvWTTi2AP6AEuFcEW/yJBuuD3NGWROSzhN
 hHu443zJBCHuW1qE8HKTP6uXy1EKc2dIN4HgHjDR+VenC1dodGlmdSWmOPXGBZtNkNqS
 SzlI9h4sJyuw8W2vSuA4FtJ2P91LZS7Ra9xgXmPAryEMb/+pMcHhNrJwgFoUDhgu/tBc
 coLyEXzdxAshh/dwuyj6BRzVyrOpYRzyU6KsK7sIvgO9TjkE1znMPHgy/4eivnASte0N
 guaQ==
X-Gm-Message-State: AOJu0YxSPVYfCKLMfjWPWb1u2yj0NqZPhl1E4Wc0DrBC4oAsTkdNc/5k
 xUDAZPE/rlQgpJjT5Tms8zTtQAMR1eRRiq91sMGPlCbZT2yjQhrqXo1jD90byfFTEwvE1kHXUoa
 2
X-Google-Smtp-Source: AGHT+IEzIAb7UjCWs+OYgeQnjIr+/+N1Wd0JEhUYr+ZQytIe8DtzcwsaZd0WhpV/Yoy/dzGdcRDugQ==
X-Received: by 2002:a17:906:3693:b0:a6f:5318:b8f7 with SMTP id
 a640c23a62f3a-a6f60d420f5mr964758566b.43.1718726617915; 
 Tue, 18 Jun 2024 09:03:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db6182sm630018366b.51.2024.06.18.09.03.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:03:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 30/76] hw/ppc: Avoid using Monitor in
 xive_end_queue_pic_print_info()
Date: Tue, 18 Jun 2024 17:59:52 +0200
Message-ID: <20240618160039.36108-31-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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
Message-Id: <20240610062105.49848-7-philmd@linaro.org>
---
 include/hw/ppc/xive_regs.h |  2 +-
 hw/intc/spapr_xive.c       |  7 ++++++-
 hw/intc/xive.c             | 17 +++++++++++------
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 4a3c9badd3..51e9a2152e 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -262,7 +262,7 @@ static inline uint64_t xive_end_qaddr(XiveEND *end)
 }
 
 void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mon);
-void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, Monitor *mon);
+void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, GString *buf);
 void xive_end_eas_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mon);
 
 /* Notification Virtual Target (NVT) */
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index b7c12aa432..3357f6325f 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -142,12 +142,17 @@ static void spapr_xive_end_pic_print_info(SpaprXive *xive, XiveEND *end,
     uint32_t qentries = 1 << (qsize + 10);
     uint32_t nvt = xive_get_field32(END_W6_NVT_INDEX, end->w6);
     uint8_t priority = xive_get_field32(END_W7_F0_PRIORITY, end->w7);
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
 
     monitor_printf(mon, "%3d/%d % 6d/%5d @%"PRIx64" ^%d",
                    spapr_xive_nvt_to_target(0, nvt),
                    priority, qindex, qentries, qaddr_base, qgen);
 
-    xive_end_queue_pic_print_info(end, 6, mon);
+    xive_end_queue_pic_print_info(end, 6, buf);
+
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 }
 
 /*
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index a0d7e7ca67..260a94e2ca 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -11,6 +11,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qapi/type-helpers.h"
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
 #include "sysemu/dma.h"
@@ -1323,7 +1324,7 @@ static const TypeInfo xive_source_info = {
  * XiveEND helpers
  */
 
-void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, Monitor *mon)
+void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, GString *buf)
 {
     uint64_t qaddr_base = xive_end_qaddr(end);
     uint32_t qsize = xive_get_field32(END_W0_QSIZE, end->w0);
@@ -1334,7 +1335,7 @@ void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, Monitor *mon)
     /*
      * print out the [ (qindex - (width - 1)) .. (qindex + 1)] window
      */
-    monitor_printf(mon, " [ ");
+    g_string_append_printf(buf, " [ ");
     qindex = (qindex - (width - 1)) & (qentries - 1);
     for (i = 0; i < width; i++) {
         uint64_t qaddr = qaddr_base + (qindex << 2);
@@ -1346,11 +1347,11 @@ void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, Monitor *mon)
                           HWADDR_PRIx "\n", qaddr);
             return;
         }
-        monitor_printf(mon, "%s%08x ", i == width - 1 ? "^" : "",
-                       be32_to_cpu(qdata));
+        g_string_append_printf(buf, "%s%08x ", i == width - 1 ? "^" : "",
+                               be32_to_cpu(qdata));
         qindex = (qindex + 1) & (qentries - 1);
     }
-    monitor_printf(mon, "]");
+    g_string_append_c(buf, ']');
 }
 
 void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mon)
@@ -1365,6 +1366,8 @@ void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mon)
     uint32_t nvt_idx = xive_get_field32(END_W6_NVT_INDEX, end->w6);
     uint8_t priority = xive_get_field32(END_W7_F0_PRIORITY, end->w7);
     uint8_t pq;
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
 
     if (!xive_end_is_valid(end)) {
         return;
@@ -1389,8 +1392,10 @@ void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mon)
     if (qaddr_base) {
         monitor_printf(mon, " eq:@%08"PRIx64"% 6d/%5d ^%d",
                        qaddr_base, qindex, qentries, qgen);
-        xive_end_queue_pic_print_info(end, 6, mon);
+        xive_end_queue_pic_print_info(end, 6, buf);
     }
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
     monitor_printf(mon, "\n");
 }
 
-- 
2.41.0


