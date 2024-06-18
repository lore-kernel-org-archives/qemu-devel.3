Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F91C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbKG-0004x9-29; Tue, 18 Jun 2024 12:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbK3-0004qc-VS
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:42 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbK2-0007HR-3f
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:39 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57c75464e77so6953614a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726676; x=1719331476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qVtSo8VEN7VL+g7C38Zor1BdlGunwOz0xsqYxtmzihw=;
 b=hE+/VqK81K73qBgO7Y2KJqfW017ORMRdnibDWIyKo3N1qxuHY8BHLtV/UKv4H6ynXx
 WO5/Ctjbec364HyEpthragOkwrB3g1OULUkRKfh4tBiurfj+h0aOiejNpof1XQOmaUgF
 Bssysx9DuIZ7dBTwrYgYkrQpOzoWfO8BzhEfB0zl0wfDpC1+hut4Q+pL0GNB441SJkve
 SfhuTBEoqKILleF6c9myVdoInRiB08VOsHGxQp1H/lttoEEtLfCFqX+jb4CknnUdJQKM
 aQ6PqfjmfBThLRYnEvcsiDPHoqwjFJdhfwg2YpUUPZ0rfj2B2MRdvH2GphUqHZu5Ga0K
 J2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726676; x=1719331476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qVtSo8VEN7VL+g7C38Zor1BdlGunwOz0xsqYxtmzihw=;
 b=fGsAcQ/kUqPoRCt9QkBTZKFkEy5iWUcxK5a2aJjhIgPxMvIUokVcSiBlwQ/jq62C9l
 NYD7MECjTgxgdNk9N3s1dgbGlvhK4Z9SRs8txUo9kZ+uYd0rrdPuLCu7Hsikiy/WASjR
 TN/mPMfQ0jZTIg/sEWKUmh1NwtPLVbzmOxNH2I6BIbmUC5w8Q5XU/4poGtHlNhWIDwpK
 sVixEPMH7/+nCWIk3kmpdeiNpge+EuraTo0LKShLhYDXNYs089XG/KtiaT0Y9h6LORfz
 fDP0zTF/q9I+TlHG1GI8qzzTaNJs1ioqX0iTtsMUMHW68o5E+hfXuYm6myGZVcbK0r06
 fbjQ==
X-Gm-Message-State: AOJu0YzL9IG8k80GEfvR5s6gqPuw+oZx3Y/qlMhHbjmVlnhha7wI5s9p
 oga2fXfx/vNy5Gd+9fFi6oQJ/qHPvHd5dyn4KI7cds2rVa4ihBQzwH+2ecUDRJv9n84DKjxd4Fd
 1
X-Google-Smtp-Source: AGHT+IFOkzLkum8+s9YcJz2PTFMw9+rkPGeUiRbusom/nCTkP7Jr3bMJP52xt+pfL0+TypXD/0Csxw==
X-Received: by 2002:a17:906:48d:b0:a6f:5fa8:1b7 with SMTP id
 a640c23a62f3a-a6f60cf333amr861278666b.15.1718726675685; 
 Tue, 18 Jun 2024 09:04:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f9bbc2136sm62937066b.123.2024.06.18.09.04.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:04:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 40/76] hw/ppc: Avoid using Monitor in pnv_psi_pic_print_info()
Date: Tue, 18 Jun 2024 18:00:02 +0200
Message-ID: <20240618160039.36108-41-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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
Message-Id: <20240610062105.49848-17-philmd@linaro.org>
---
 include/hw/ppc/pnv_psi.h |  2 +-
 hw/ppc/pnv.c             | 10 +++++++---
 hw/ppc/pnv_psi.c         |  9 +--------
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index 2a6f715350..cf7f95a6b1 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -110,6 +110,6 @@ typedef enum PnvPsiIrq {
 #define PSIHB9_IRQ_PSU          13
 #define PSIHB9_NUM_IRQS         14
 
-void pnv_psi_pic_print_info(Pnv9Psi *psi, Monitor *mon);
+void pnv_psi_pic_print_info(Pnv9Psi *psi, GString *buf);
 
 #endif /* PPC_PNV_PSI_H */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7e6f923c7e..4a1a302a25 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -812,12 +812,11 @@ static void pnv_chip_power9_pic_print_info(PnvChip *chip, Monitor *mon)
     g_autoptr(HumanReadableText) info = NULL;
 
     pnv_xive_pic_print_info(&chip9->xive, buf);
+    pnv_psi_pic_print_info(&chip9->psi, buf);
 
     info = human_readable_text_from_str(buf);
     monitor_puts(mon, info->human_readable_text);
 
-    pnv_psi_pic_print_info(&chip9->psi, mon);
-
     object_child_foreach_recursive(OBJECT(chip),
                          pnv_chip_power9_pic_print_info_child, mon);
 }
@@ -862,9 +861,14 @@ static void pnv_ipmi_bt_init(ISABus *bus, IPMIBmc *bmc, uint32_t irq)
 static void pnv_chip_power10_pic_print_info(PnvChip *chip, Monitor *mon)
 {
     Pnv10Chip *chip10 = PNV10_CHIP(chip);
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
 
     pnv_xive2_pic_print_info(&chip10->xive, mon);
-    pnv_psi_pic_print_info(&chip10->psi, mon);
+
+    pnv_psi_pic_print_info(&chip10->psi, buf);
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 
     object_child_foreach_recursive(OBJECT(chip),
                          pnv_chip_power9_pic_print_info_child, mon);
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 922ac07b2f..18cc76a7e4 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -25,8 +25,6 @@
 #include "qemu/module.h"
 #include "sysemu/reset.h"
 #include "qapi/error.h"
-#include "qapi/type-helpers.h"
-#include "monitor/monitor.h"
 
 
 #include "hw/ppc/fdt.h"
@@ -978,11 +976,9 @@ static void pnv_psi_register_types(void)
 
 type_init(pnv_psi_register_types);
 
-void pnv_psi_pic_print_info(Pnv9Psi *psi9, Monitor *mon)
+void pnv_psi_pic_print_info(Pnv9Psi *psi9, GString *buf)
 {
     PnvPsi *psi = PNV_PSI(psi9);
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
     uint32_t offset =
         (psi->regs[PSIHB_REG(PSIHB9_IVT_OFFSET)] >> PSIHB9_IVT_OFF_SHIFT);
@@ -990,7 +986,4 @@ void pnv_psi_pic_print_info(Pnv9Psi *psi9, Monitor *mon)
     g_string_append_printf(buf, "PSIHB Source %08x .. %08x\n",
                            offset, offset + psi9->source.nr_irqs - 1);
     xive_source_pic_print_info(&psi9->source, offset, buf);
-
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
-- 
2.41.0


