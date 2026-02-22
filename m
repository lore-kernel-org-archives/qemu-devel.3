Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17ACC6369E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuImy-0003ev-Ut; Sun, 22 Feb 2026 18:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuImy-0003ef-4t
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:23:00 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuImw-00015b-Ge
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:22:59 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48372efa020so29119845e9.2
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771802576; x=1772407376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LyPAFfKaBurKN88V6LreaWGImyyKpmiLDGPyKjV7EJc=;
 b=SGo0AosjRixQfiiLGl/hrHP/OrGobskSNWOuEx3RvFIt+kHtXD9/16UxeCRZqRrw5e
 5LD1KF05S8fZOkC5BBb4jn/3tmGsDVcKSKYrLk/erIDbrPLL9hw8AY4rfkg/TKjt4kBK
 68ePl/YdxHWGxO8cZYLKd6CVlJ7ZF5InhoezFCOtEpHf5vlqPAvUcphzoEF9UVcezn32
 MKwlMZik5xUjO2g0eNb6lzSh/8iHH8+QOTCKtFuYMULtly7yCDg9E2R3mvqiCqS7C7ql
 QobpWnEt3GjTC1UVgdzuO3+sb4hlXtV8oUdPntnW1//7nX4ba9vgUcvFPjEcue5MFd3M
 MTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771802576; x=1772407376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LyPAFfKaBurKN88V6LreaWGImyyKpmiLDGPyKjV7EJc=;
 b=DXHlElQaRktSK7+lhASHOM5zQpcSTsl8i667UMm9EsWTK6q1k9zEYOJ7/YbSHGMssl
 Th1+04W3/uepFQwiu3cf/zp5mawD+faGeHvRKCxCBpibg16YAXmggEwMvdWCW2d+AScV
 JZ/npPYCKx5U5HE+TAFFofWTTMJeChOYtNdH5ogAFwblS9jvdz7lc2dSUrk8j8nDvdmh
 cHLFLEZLPKd1Db/HV17qeH0LJDMhzy9a4ilQjw475Gyu8wjAAqdfcnZa22F06Fkyx6R+
 sXCA1oCIe1X75rIvkcQKUrSEgiPauo/3uEyG/c7xRh/qUsGZTUupl0epLrM2067MqTI4
 CvKg==
X-Gm-Message-State: AOJu0YzxkhAqPCbe1WHJMIeE2+tZBWkXS4PUNLbi8g58MLqKzLxZOJbR
 fT7dhxHZqQrDwSZAT3/cCeAK5OZZL3dWA2XjaoxD8G7HT1ZPOwWw1TkfsdUMnNuHrZLCaDaX8ur
 K/RupoQI=
X-Gm-Gg: AZuq6aI9bcVJr1Z0H2r3Pm44XxDG//3dfvcilHDmPHJwJHwnFBusZ7D52wqis85JRaa
 +XytVLt+YHkbau/6iGze0mkimP2nVa+h+Qccthwz0indZCu1fZUx1pvMX3NDYn7UPgODJ5KElHz
 x+GFcUg8uNoNydiW/emBn87zgsfu2hlU0tIfp7xBrNxzg6QEF+IUJrj7BxKwqeDoWbDnoQZSsZ1
 aqmhuzbMN5Catu9yp6d8iBsfSbtfZZmt1AwEOnaN26uSUnC4GJZf6mEoCjlJkbkdolWuc+VJF1T
 SlN7TPqXokcIzYX8OGi398f6R/QAhWb1o2WQtOl2H8S/slMNaPqKHWWjDKc9IGLOoTwzV/OgQOm
 JHMlds8UkV5T4tBSiYfS2OptDMLzPqMKzJd8nRpGls52e07Gu2G3+XrjUGiu4bvHR4vgIwFUbyF
 23kc4Ll6BqeDAVQQhvwzVsdGXjGA/xxauJcUs7BYJBYA1QYjvX5GG0F+XdgzhN3HGxixGqgd+A
X-Received: by 2002:a05:600c:37cd:b0:47d:586e:2fea with SMTP id
 5b1f17b1804b1-483a9605ce0mr129436955e9.15.1771802576379; 
 Sun, 22 Feb 2026 15:22:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bf9f6csm16659875f8f.7.2026.02.22.15.22.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:22:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 11/21] hw/ppc: Set graphic display dimensions generically
Date: Mon, 23 Feb 2026 00:22:21 +0100
Message-ID: <20260222232222.7183-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222232222.7183-1-philmd@linaro.org>
References: <20260222232222.7183-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If a dimension is not set, have the machine init code set
the default values.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260216213121.47122-8-philmd@linaro.org>
---
 hw/ppc/mac_newworld.c   | 9 +++++++++
 hw/ppc/mac_oldworld.c   | 9 +++++++++
 hw/ppc/prep.c           | 9 +++++++++
 hw/ppc/spapr.c          | 9 +++++++++
 system/globals-target.c | 6 ------
 5 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 7275563a155..3680d96ed39 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -432,6 +432,15 @@ static void ppc_core99_init(MachineState *machine)
 
     pci_vga_init(pci_bus);
 
+    if (!graphic_width) {
+        graphic_width = 800;
+    }
+    if (!graphic_height) {
+        graphic_height = 600;
+    }
+    if (!graphic_depth) {
+        graphic_depth = 32;
+    }
     if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth != 8) {
         graphic_depth = 15;
     }
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index e679d338985..24d9f2e3d5c 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -288,6 +288,15 @@ static void ppc_heathrow_init(MachineState *machine)
         pci_create_simple(pci_bus, -1, "pci-ohci");
     }
 
+    if (!graphic_width) {
+        graphic_width = 800;
+    }
+    if (!graphic_height) {
+        graphic_height = 600;
+    }
+    if (!graphic_depth) {
+        graphic_depth = 32;
+    }
     if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth != 8) {
         graphic_depth = 15;
     }
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index c4efd1d3908..e973b340992 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -412,6 +412,15 @@ static void ibm_40p_init(MachineState *machine)
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, ARCH_PREP);
 
+    if (!graphic_width) {
+        graphic_width = 800;
+    }
+    if (!graphic_height) {
+        graphic_height = 600;
+    }
+    if (!graphic_depth) {
+        graphic_depth = 32;
+    }
     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 274f38785f2..0ab39dfea6b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1177,6 +1177,15 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
         if (machine->boot_config.has_menu && machine->boot_config.menu) {
             _FDT((fdt_setprop_cell(fdt, chosen, "qemu,boot-menu", true)));
         }
+        if (!graphic_width) {
+            graphic_width = 800;
+        }
+        if (!graphic_height) {
+            graphic_height = 600;
+        }
+        if (!graphic_depth) {
+            graphic_depth = 32;
+        }
         _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-width", graphic_width));
         _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-height", graphic_height));
         _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-depth", graphic_depth));
diff --git a/system/globals-target.c b/system/globals-target.c
index 17a27a06218..ffa6c308b59 100644
--- a/system/globals-target.c
+++ b/system/globals-target.c
@@ -9,12 +9,6 @@
 #include "qemu/osdep.h"
 #include "system/system.h"
 
-#if defined(TARGET_SPARC) || defined(TARGET_M68K)
 int graphic_width;
 int graphic_height;
 int graphic_depth;
-#else
-int graphic_width = 800;
-int graphic_height = 600;
-int graphic_depth = 32;
-#endif
-- 
2.52.0


