Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3876106FD8B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vwa-0001I4-Oi; Fri, 13 Mar 2026 02:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vwZ-00016U-Mn
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:24:19 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vwX-0007HD-Lc
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:24:19 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439b7c2788dso1119181f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383056; x=1773987856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=99ck0rNhy9Odl9YN+puJD18uHAX/TuhY16Q8is+taGc=;
 b=Bi0eqUY2CEKGW/uOE99gjkZUzWvceihIjcIYYamH8eRX4UBIGev5By8PcvCxXLfeqS
 h+TWP3yVa/27W8x2vk8acq5oc9iXUv1oau/oEDPdfPX09UCJWreZlm6Plh+BUAAb6JKD
 /7e4fwe5wOHU1F7r5YDozrQiH832kVOOcT9CuysnN7m/ID5bwi5fXk+v400yHtwkHsA7
 bpeog3glFnEG9eqT/uk1B3v3PYRDUqeC0neHoPJk1YfRONAXWuF9pvWyX88VmmDOu4rz
 qL+0VoPttc8D0WPQs1tlSQ8pDEzzIYLAaXlP1tdJJwHkULlM2qQd8hD3Vc14DphPr5KG
 UETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383056; x=1773987856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=99ck0rNhy9Odl9YN+puJD18uHAX/TuhY16Q8is+taGc=;
 b=HWyPe3qLY7f7/Ok9ZHwTQpjdavbtdE2KqTMnV2fGOCXo3/1L3hRZtAt9LimWdvXLeV
 pRSZrycu0rjCpMefa2nfVjJx02HGhTkXdfuTyTSrR78W5ApEVC1uaOeBSmHk+UrjAHbD
 wlzLAmm7Qo8eHp/RiSr8bCfgaLy1YNEmeZ86pCrmJMjPl5AkblEnpabOVNtMY+/mzl2M
 5kdVDxjZnm2zlsNOI0vc8vXsl2JhktuGcFzSvqjMoFq+gdgzXv2QYo3UoB0DoXMD3TRK
 wOD1ib1tE6zK44QJnZogZN8WH1JtwNKGLN+bDdvkcuP54vcG2EyFY1E3Ay8NMka6o/1V
 iTag==
X-Gm-Message-State: AOJu0Yxj69cTmLMVv6cQuIQF7mp+0zsYEBs3Q3gyOgf0faYWIXxmYUnT
 jAvDbTc06Ph3IHzVASD6F+xi3IhCcDWk7qwFv9DNYSaSNM3Buvyk/Equh7Ow61YFsmxzCCL91Rh
 vUHuhAtQ=
X-Gm-Gg: ATEYQzxoVGzFz83eaDqcL89ZKYhI2Wl1he18IZ3bH4mQ7RjXDasK/XCspdX/Xcsnl6B
 jbr7WtbLE3mEBbZIYIv67sDJ1uI5vR3QLdH9Mt+MI8nx3cg/BBFCxLkyplAEg6o3R/sxd/f9Unc
 0N24c+XGef8qyExZLfy3t4xgIcLmwhnOCIHTdWkdyuVWbkotN8EE52eOmDB6b72lRGrQ00eOMWT
 p88IN4x1ziXY7ecwHQu1tz5kvqX+E4bydIIvFT6d8pfcAJD4AdGNhrYf1fxFtPuhOpjLGryJ0Nd
 a2RD/YGVDVbr4OweW4EttKBKDu5Go3k4cogyqKZfr9upa/lU1FuSCyUGZuI4yO7CTd3fL019csH
 /J1c4EuNutkQ4qLcA7bhbFYE1YKn/sXIjMUrKAYJgAblHeF7ThOQClV5DXVtHi5RBmJSbj0HDcU
 hdKt+9hkUcPpPTkkkFjRsAnO6gv+n5b87DF1ywUUitKWKV4bUg9NvP/FZa0Zt2S5WMNMYjc7y9a
 9Noyg==
X-Received: by 2002:a05:6000:2c06:b0:439:b715:6f49 with SMTP id
 ffacd0b85a97d-43a04dceabbmr4204512f8f.59.1773383055813; 
 Thu, 12 Mar 2026 23:24:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20c473sm15019752f8f.24.2026.03.12.23.24.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:24:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 29/38] hw/ppc: Include full path to target 'cpu.h' header
Date: Fri, 13 Mar 2026 07:20:45 +0100
Message-ID: <20260313062055.2188-30-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/pnv.h          | 2 +-
 include/hw/ppc/spapr_fadump.h | 2 +-
 hw/ppc/mpc8544_guts.c         | 2 +-
 hw/ppc/mpc8544ds.c            | 2 +-
 hw/ppc/ppc440_uc.c            | 2 +-
 hw/ppc/ppc4xx_devs.c          | 2 +-
 hw/ppc/ppc_booke.c            | 2 +-
 hw/ppc/prep_systemio.c        | 2 +-
 hw/ppc/spapr_vhyp_mmu.c       | 2 +-
 hw/ppc/virtex_ml507.c         | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 24f8843a409..5581ba0f683 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -20,7 +20,7 @@
 #ifndef PPC_PNV_H
 #define PPC_PNV_H
 
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 #include "hw/core/boards.h"
 #include "hw/core/sysbus.h"
 #include "hw/ipmi/ipmi.h"
diff --git a/include/hw/ppc/spapr_fadump.h b/include/hw/ppc/spapr_fadump.h
index 82681fb9a6a..778981bc95e 100644
--- a/include/hw/ppc/spapr_fadump.h
+++ b/include/hw/ppc/spapr_fadump.h
@@ -6,7 +6,7 @@
 #ifndef PPC_SPAPR_FADUMP_H
 #define PPC_SPAPR_FADUMP_H
 
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 
 /* Fadump commands */
 #define FADUMP_CMD_REGISTER            1
diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index 88ae573d1e8..3f2bbc0a511 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "system/runstate.h"
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 #include "hw/core/sysbus.h"
 #include "qom/object.h"
 
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index 582698559d2..6a5d3edc490 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -15,7 +15,7 @@
 #include "hw/ppc/openpic.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 
 static void mpc8544ds_fixup_devtree(void *fdt)
 {
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 0f28a7937fb..634046506e8 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -19,7 +19,7 @@
 #include "hw/pci/pci.h"
 #include "exec/cpu-common.h"
 #include "system/reset.h"
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 #include "ppc440.h"
 
 /*****************************************************************************/
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 1e6b6fec5da..ae1ac4f4672 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 #include "hw/ppc/ppc4xx.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index 7c6e5df9fde..052c8c931ae 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 #include "exec/target_page.h"
 #include "hw/ppc/ppc.h"
 #include "qemu/timer.h"
diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
index bc8b0964e75..5cd18a9e123 100644
--- a/hw/ppc/prep_systemio.c
+++ b/hw/ppc/prep_systemio.c
@@ -33,7 +33,7 @@
 #include "qemu/error-report.h" /* for error_report() */
 #include "qemu/module.h"
 #include "system/runstate.h"
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 #include "trace.h"
 
 #define TYPE_PREP_SYSTEMIO "prep-systemio"
diff --git a/hw/ppc/spapr_vhyp_mmu.c b/hw/ppc/spapr_vhyp_mmu.c
index 2d41d7f77b7..9cc3aeb2a29 100644
--- a/hw/ppc/spapr_vhyp_mmu.c
+++ b/hw/ppc/spapr_vhyp_mmu.c
@@ -11,7 +11,7 @@
 #include "qemu/cutils.h"
 #include "qemu/memalign.h"
 #include "qemu/error-report.h"
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 #include "helper_regs.h"
 #include "hw/ppc/spapr.h"
 #include "mmu-hash64.h"
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 51b3d7d7121..d10d9135890 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -26,7 +26,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "exec/page-protection.h"
-#include "cpu.h"
+#include "target/ppc/cpu.h"
 #include "hw/core/sysbus.h"
 #include "hw/char/serial-mm.h"
 #include "hw/block/flash.h"
-- 
2.53.0


