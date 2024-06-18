Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8121C2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbJz-0004kA-Rq; Tue, 18 Jun 2024 12:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJx-0004dD-Md
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:33 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJv-0007Fs-R5
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:04:33 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a6ef793f4b8so579261166b.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726670; x=1719331470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQOeE1YU7c9+9ll5qN8I/U6cfEvkRwOcyGoeslhCPQU=;
 b=DbQrUav0EH3hE385aLcb3D+pazryUW96O8dpr/dT/7OnAPzh6/BJTrBiTNXLfTpHu6
 qGYn1fP4p1HO+Jyn8AVfVWzEXHZh20kSN0IQjYJdyoPF/lPsNNpMdRKMEhT0vnyvrIEq
 o/+OGNc9r2rJiKEpl6hpcMZta+WaYBKNeBjrh/aVsyWMYWH72xb/Q4/9Sscb2e1Fc1XY
 ckfY1tl/BJy7PrrqXWI0oUf9uk4JIlfqFUZYUwA/xCmd7zOR2qZI72CO1V14m+XpE5/H
 Zq8hLEUOcWgDHE7vlqH0PgkcT2Nox3pElbAs9iAbciXEZIiJxE7W8N/JZEbCCTu7SfCf
 Lf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726670; x=1719331470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KQOeE1YU7c9+9ll5qN8I/U6cfEvkRwOcyGoeslhCPQU=;
 b=LFcTnpORQPq9PuHPpPVUNBVO3thYYcM+NFiI1oXZGpuPkfz5py1TjSKN9lTZhmWWi9
 /HZjzm1A4h++WgqUIAuoN578uUj2/NCBxQnMxDNI5qVLjTfhVMtLMPwu4MDUIDgm8stF
 6dkwp0UEt5iOKc7L6fOHnRB12Xw1ZQnMULis6shz7RlaUEhSOfEHpGeaT86Z9j9wwNed
 pAp58A2SZ98M9Tw34vfkR9gWI0kTw0UD7N9x75zeH8Olk8RsZt/uIMViXVqg4GVag93c
 TyXYG4R40DnG36buu5MNC5v1aScOOSyqPGcbcQq1hMWGQAA0x+/h2pYKLJ5mJoC8uWQp
 DuDQ==
X-Gm-Message-State: AOJu0Yye7/l/npYKkSC785roU3Nsyewalh/WWkg67KxpKqz+HIksnnA+
 U45ZDeG+Jc7NqUHP3mLsJ1yrPPQOlCY3UKKUycABRkzBBgZloZjHyR6mu/EANZrFCosX+A4S3+h
 s
X-Google-Smtp-Source: AGHT+IGch9ZqM5DAjyexwC2JgCCq6DLZl9eXVtAmrQf98GIVVx1UKU3TpxVyBDJjHaeqonaGmh/fTQ==
X-Received: by 2002:a17:906:b858:b0:a68:ece7:8db5 with SMTP id
 a640c23a62f3a-a6f60d2c9e0mr786413166b.31.1718726670048; 
 Tue, 18 Jun 2024 09:04:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db5bafsm630006166b.50.2024.06.18.09.04.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:04:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 39/76] hw/ppc: Avoid using Monitor in pnv_xive_pic_print_info()
Date: Tue, 18 Jun 2024 18:00:01 +0200
Message-ID: <20240618160039.36108-40-philmd@linaro.org>
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
Message-Id: <20240610062105.49848-16-philmd@linaro.org>
---
 include/hw/ppc/pnv_xive.h | 2 +-
 hw/intc/pnv_xive.c        | 9 +--------
 hw/ppc/pnv.c              | 8 +++++++-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/hw/ppc/pnv_xive.h b/include/hw/ppc/pnv_xive.h
index 9c48430ee4..7d634e469c 100644
--- a/include/hw/ppc/pnv_xive.h
+++ b/include/hw/ppc/pnv_xive.h
@@ -93,7 +93,7 @@ struct PnvXiveClass {
     DeviceRealize parent_realize;
 };
 
-void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon);
+void pnv_xive_pic_print_info(PnvXive *xive, GString *buf);
 
 /*
  * XIVE2 interrupt controller (POWER10)
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 3ad4ac8e7d..5bacbce6a4 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -11,12 +11,10 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "qapi/type-helpers.h"
 #include "target/ppc/cpu.h"
 #include "sysemu/cpus.h"
 #include "sysemu/dma.h"
 #include "sysemu/reset.h"
-#include "monitor/monitor.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_chip.h"
@@ -1846,7 +1844,7 @@ static void xive_nvt_pic_print_info(XiveNVT *nvt, uint32_t nvt_idx,
                            xive_get_field32(NVT_W4_IPB, nvt->w4));
 }
 
-void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
+void pnv_xive_pic_print_info(PnvXive *xive, GString *buf)
 {
     XiveRouter *xrtr = XIVE_ROUTER(xive);
     uint8_t blk = pnv_xive_block_id(xive);
@@ -1858,8 +1856,6 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
     XiveNVT nvt;
     int i;
     uint64_t xive_nvt_per_subpage;
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
     g_string_append_printf(buf, "XIVE[%x] #%d Source %08x .. %08x\n",
                            chip_id, blk, srcno0, srcno0 + nr_ipis - 1);
@@ -1897,9 +1893,6 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
             xive_nvt_pic_print_info(&nvt, i++, buf);
         }
     }
-
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
 
 static void pnv_xive_reset(void *dev)
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index df187c5180..7e6f923c7e 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -808,8 +808,14 @@ static int pnv_chip_power9_pic_print_info_child(Object *child, void *opaque)
 static void pnv_chip_power9_pic_print_info(PnvChip *chip, Monitor *mon)
 {
     Pnv9Chip *chip9 = PNV9_CHIP(chip);
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
+
+    pnv_xive_pic_print_info(&chip9->xive, buf);
+
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 
-    pnv_xive_pic_print_info(&chip9->xive, mon);
     pnv_psi_pic_print_info(&chip9->psi, mon);
 
     object_child_foreach_recursive(OBJECT(chip),
-- 
2.41.0


