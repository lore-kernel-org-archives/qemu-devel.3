Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FF7C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbKe-0005jv-GE; Tue, 18 Jun 2024 12:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbKb-0005aj-Lj
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:05:14 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbKZ-0007YX-Rq
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:05:13 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a6efe62f583so568368466b.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726709; x=1719331509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQ/vKPLAFvWQQZA4qFYQnETyiIwxVEeu0Q/3lMWAKrA=;
 b=K/WB8J+4gGHPyztQnH9Q7qehrD0qHF3E8pYqEvAexxkegpnZEJboO107KyGm95dAMs
 cUkQHcB9MDvMD0vwzAeNRdKbA8mY0JmFDdGnEwwdux+VM79d87wCMfI8NJ7za5PVCHHZ
 AwZ+AKy/QLFkLrMPd0p7mWo+wJnRA75Np8PFMikvRz9OjE7Rnl+AzQ2flGpOHFOC/NtI
 Qt7wSLj4hi4VaoeKrdEABXVcSqjhfRdDKcfcJwItV1776t6FhBOIM3fNWM231b+rAZAJ
 LK7zLBScgquMuYWRiBHXtZtc43g1pVtVlI5IgGY97xeYadOyamedWZcLJv1bqdJTxeRm
 Cxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726709; x=1719331509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UQ/vKPLAFvWQQZA4qFYQnETyiIwxVEeu0Q/3lMWAKrA=;
 b=nkSUkmHHu5K8nOjqrX5146Y0gBr+0awcwvfvTezlapi36Zn43IhxSPxeU9D8uFVuh7
 Bql6+SzGCHPBZ/x/6dzW4FuVWKmzmVD5Ou3edNmzRF6JfRQvEXoM1T2WH8w7PqkeYfpS
 39YhwckRp8nxE7JiHnjY16WD/6dtJ6h5g9HJzBtM486HxKMWBA0F2M8KZ2F92PVF1GRD
 7cacmODvmLpQScNO8GFWnpv0RBh4PvX9JmwBkIFsBlW75N0i8h1F21eIf9mwxcI8OPLP
 XVF97hPQycLBsvUNXx844WoM4ELdmVInJL7ZcwAFR3szbsXFdh4XOwAu994pim1sU2ER
 SDPA==
X-Gm-Message-State: AOJu0YxVNNT1nY0RNBgFh7PGEXBpRaJ5asaFFUtZ0USsVlbmCYLTRvlI
 MC2lFzFczdlRyfJeAZfwTtUTyQyqCTRq6KyipLL+wu4GSM+T1pRKsvBwqJmgzqdH/76nxrEL0dz
 6
X-Google-Smtp-Source: AGHT+IFykRa0PGNS6eCdb7IPjVQVm4WpA1jj6imDxrBYQ2/I1blsqacL5oELr7NeSsXionO1xR5NPg==
X-Received: by 2002:a17:907:874e:b0:a6f:7834:d40a with SMTP id
 a640c23a62f3a-a6f7834d63fmr593235266b.24.1718726709556; 
 Tue, 18 Jun 2024 09:05:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f99b67sm625233066b.201.2024.06.18.09.05.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:05:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 46/76] hw/ppc: Avoid using Monitor in pnv_xive2_pic_print_info()
Date: Tue, 18 Jun 2024 18:00:08 +0200
Message-ID: <20240618160039.36108-47-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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
Message-Id: <20240610062105.49848-23-philmd@linaro.org>
---
 include/hw/ppc/pnv_xive.h | 2 +-
 hw/intc/pnv_xive2.c       | 9 +--------
 hw/ppc/pnv.c              | 2 +-
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/include/hw/ppc/pnv_xive.h b/include/hw/ppc/pnv_xive.h
index 7d634e469c..5b4cb4167b 100644
--- a/include/hw/ppc/pnv_xive.h
+++ b/include/hw/ppc/pnv_xive.h
@@ -163,6 +163,6 @@ typedef struct PnvXive2Class {
     DeviceRealize parent_realize;
 } PnvXive2Class;
 
-void pnv_xive2_pic_print_info(PnvXive2 *xive, Monitor *mon);
+void pnv_xive2_pic_print_info(PnvXive2 *xive, GString *buf);
 
 #endif /* PPC_PNV_XIVE_H */
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 10914b04df..2fb4fa29d4 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -10,11 +10,9 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "qapi/type-helpers.h"
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
 #include "sysemu/dma.h"
-#include "monitor/monitor.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_chip.h"
@@ -2105,7 +2103,7 @@ static uint64_t pnv_xive2_vst_per_subpage(PnvXive2 *xive, uint32_t type)
     return (1ull << page_shift) / info->size;
 }
 
-void pnv_xive2_pic_print_info(PnvXive2 *xive, Monitor *mon)
+void pnv_xive2_pic_print_info(PnvXive2 *xive, GString *buf)
 {
     Xive2Router *xrtr = XIVE2_ROUTER(xive);
     uint8_t blk = pnv_xive2_block_id(xive);
@@ -2117,8 +2115,6 @@ void pnv_xive2_pic_print_info(PnvXive2 *xive, Monitor *mon)
     Xive2Nvp nvp;
     int i;
     uint64_t xive_nvp_per_subpage;
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
     g_string_append_printf(buf, "XIVE[%x] Source %08x .. %08x\n",
                            blk, srcno0, srcno0 + nr_esbs - 1);
@@ -2156,7 +2152,4 @@ void pnv_xive2_pic_print_info(PnvXive2 *xive, Monitor *mon)
             xive2_nvp_pic_print_info(&nvp, i++, buf);
         }
     }
-
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 4a1a302a25..5b9dbff754 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -864,7 +864,7 @@ static void pnv_chip_power10_pic_print_info(PnvChip *chip, Monitor *mon)
     g_autoptr(GString) buf = g_string_new("");
     g_autoptr(HumanReadableText) info = NULL;
 
-    pnv_xive2_pic_print_info(&chip10->xive, mon);
+    pnv_xive2_pic_print_info(&chip10->xive, buf);
 
     pnv_psi_pic_print_info(&chip10->psi, buf);
     info = human_readable_text_from_str(buf);
-- 
2.41.0


