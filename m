Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB091C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbIo-0007Nn-Id; Tue, 18 Jun 2024 12:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbIf-0007Cf-Bq
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:14 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbId-00078I-CF
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:12 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57cad452f8bso6398504a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726589; x=1719331389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qA5Ge8ZtgAa4V9zb3xBkrJO7P0viojUBuVQA89Wmlaw=;
 b=mmpgc3qscMeX33sSISLRWxVI6CMrUo9Qk9QPYcFgWBmwl4IvqJBPb7Y7xhr/9toVZk
 4PGhu8xVEhdup/VIfJbjlu0h9kffXeeliSNpVy8yubXCrYtxG3DFkVo8ltoqkeOpWu4m
 M7Zv4jJxleuA6WuMmLxHCvlg0g/50mLXivomcuMzh7+YAwyxgDh9rsxFqkaM7n/s0aLI
 M5HCLqNYrQJ+gvODsUZ3+kDAJrTXQzUoLpvmGc8lrYKuVCCkis//O1qr+wiIS4g3LWMm
 O+qkTdsho3gyGJr/kj4e8oDbSsufyLryixaEuNDhI05PGq+h73z7Dhi3RRBfPhCPKkgW
 70cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726589; x=1719331389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qA5Ge8ZtgAa4V9zb3xBkrJO7P0viojUBuVQA89Wmlaw=;
 b=oHH5pDKUwcj9wY/sTbG9gRGPqMIM2cvelwZ5NeHokOvztXcSZCGN8adUqxKf62CEwf
 7chgegV4C141zWhQXuuEFV3j41Jg+wHgUCAgKD1zk9VgOEQLp+0Dq2ZyPxmLXMBqxjzB
 VI+8fBXFXzarO2TOSaYKUB5hMUJclIsafzZIF1C3M9Hw5w6Yk+z/1SU+jbAiXJI7A2TW
 XukqgwFXLsvE6Y3uMUHWRhJ1w9eYAtgY8VRw5EILoMRLgHEtABUhmWeV5fap6RE4vDvI
 WIBH5Wa6bxiaJec4DVyWicU4RAjJkZfawEYlh9fukt1BYR2bqMMik5Rn6n6aajUiovMo
 T6UA==
X-Gm-Message-State: AOJu0YwC/+HkxDI1jnhTjfwojlN7FVkooYXkj1xSv0LLAtt1nVuo+2qg
 Gy2mXSKqmXaEA1w/lYIGswT0PRBu2sqOmYkrBmNDlLCdrGr7o/2XX7fAXjyN3o/mUzNpQeXDkU1
 0
X-Google-Smtp-Source: AGHT+IFy0oiue5Dz/DCvSfhpx294G2YRBwMeQIqgbCN1v/b8zf5gfz/K0Wez1T8ZHhd7/RjhUURJkg==
X-Received: by 2002:a50:d681:0:b0:57d:579:3ca8 with SMTP id
 4fb4d7f45d1cf-57d05793e00mr449766a12.22.1718726589417; 
 Tue, 18 Jun 2024 09:03:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb743ade6sm7856056a12.95.2024.06.18.09.03.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:03:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 25/76] hw/ppc: Avoid using Monitor in
 pnv_phb3_msi_pic_print_info()
Date: Tue, 18 Jun 2024 17:59:47 +0200
Message-ID: <20240618160039.36108-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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
Message-Id: <20240610062105.49848-2-philmd@linaro.org>
---
 include/hw/pci-host/pnv_phb3.h |  2 +-
 hw/pci-host/pnv_phb3_msi.c     | 21 ++++++++++-----------
 hw/ppc/pnv.c                   |  8 +++++++-
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/hw/pci-host/pnv_phb3.h b/include/hw/pci-host/pnv_phb3.h
index d62b3091ac..24ca3dddaa 100644
--- a/include/hw/pci-host/pnv_phb3.h
+++ b/include/hw/pci-host/pnv_phb3.h
@@ -40,7 +40,7 @@ void pnv_phb3_msi_update_config(Phb3MsiState *msis, uint32_t base,
 void pnv_phb3_msi_send(Phb3MsiState *msis, uint64_t addr, uint16_t data,
                        int32_t dev_pe);
 void pnv_phb3_msi_ffi(Phb3MsiState *msis, uint64_t val);
-void pnv_phb3_msi_pic_print_info(Phb3MsiState *msis, Monitor *mon);
+void pnv_phb3_msi_pic_print_info(Phb3MsiState *msis, GString *buf);
 
 
 /*
diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
index a6d827f903..77d673da54 100644
--- a/hw/pci-host/pnv_phb3_msi.c
+++ b/hw/pci-host/pnv_phb3_msi.c
@@ -13,7 +13,6 @@
 #include "hw/pci-host/pnv_phb3.h"
 #include "hw/ppc/pnv.h"
 #include "hw/pci/msi.h"
-#include "monitor/monitor.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/reset.h"
@@ -316,13 +315,13 @@ static void pnv_phb3_msi_register_types(void)
 
 type_init(pnv_phb3_msi_register_types);
 
-void pnv_phb3_msi_pic_print_info(Phb3MsiState *msi, Monitor *mon)
+void pnv_phb3_msi_pic_print_info(Phb3MsiState *msi, GString *buf)
 {
     ICSState *ics = ICS(msi);
     int i;
 
-    monitor_printf(mon, "ICS %4x..%4x %p\n",
-                   ics->offset, ics->offset + ics->nr_irqs - 1, ics);
+    g_string_append_printf(buf, "ICS %4x..%4x %p\n",
+                           ics->offset, ics->offset + ics->nr_irqs - 1, ics);
 
     for (i = 0; i < ics->nr_irqs; i++) {
         uint64_t ive;
@@ -335,12 +334,12 @@ void pnv_phb3_msi_pic_print_info(Phb3MsiState *msi, Monitor *mon)
             continue;
         }
 
-        monitor_printf(mon, "  %4x %c%c server=%04x prio=%02x gen=%d\n",
-                       ics->offset + i,
-                       GETFIELD(IODA2_IVT_P, ive) ? 'P' : '-',
-                       GETFIELD(IODA2_IVT_Q, ive) ? 'Q' : '-',
-                       (uint32_t) GETFIELD(IODA2_IVT_SERVER, ive) >> 2,
-                       (uint32_t) GETFIELD(IODA2_IVT_PRIORITY, ive),
-                       (uint32_t) GETFIELD(IODA2_IVT_GEN, ive));
+        g_string_append_printf(buf, "  %4x %c%c server=%04x prio=%02x gen=%d\n",
+                               ics->offset + i,
+                               GETFIELD(IODA2_IVT_P, ive) ? 'P' : '-',
+                               GETFIELD(IODA2_IVT_Q, ive) ? 'Q' : '-',
+                               (uint32_t) GETFIELD(IODA2_IVT_SERVER, ive) >> 2,
+                               (uint32_t) GETFIELD(IODA2_IVT_PRIORITY, ive),
+                               (uint32_t) GETFIELD(IODA2_IVT_GEN, ive));
     }
 }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6e3a5ccdec..5356a4e295 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -38,6 +38,7 @@
 #include "hw/loader.h"
 #include "hw/nmi.h"
 #include "qapi/visitor.h"
+#include "qapi/type-helpers.h"
 #include "monitor/monitor.h"
 #include "hw/intc/intc.h"
 #include "hw/ipmi/ipmi.h"
@@ -774,8 +775,13 @@ static void pnv_chip_power8_pic_print_info(PnvChip *chip, Monitor *mon)
     for (i = 0; i < chip8->num_phbs; i++) {
         PnvPHB *phb = chip8->phbs[i];
         PnvPHB3 *phb3 = PNV_PHB3(phb->backend);
+        g_autoptr(GString) buf = g_string_new("");
+        g_autoptr(HumanReadableText) info = NULL;
+
+        pnv_phb3_msi_pic_print_info(&phb3->msis, buf);
+        info = human_readable_text_from_str(buf);
+        monitor_puts(mon, info->human_readable_text);
 
-        pnv_phb3_msi_pic_print_info(&phb3->msis, mon);
         ics_pic_print_info(&phb3->lsis, mon);
     }
 }
-- 
2.41.0


