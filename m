Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF5FCD5BC9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBXH-0002Vs-2N; Wed, 27 May 2026 06:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBXG-0002Vi-25
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:30:50 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBXE-0000UP-C3
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:30:49 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49042aeeb75so66823685e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877847; x=1780482647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BtN+imCP9amar/84bgqStd8DEqBoZpM9N9xe//uTSQ4=;
 b=mnEA68bC5BPtUZwekOzGSI5WG5RLh4PHkbt99VDDxGZSIzoqWfPh7+fdW51VPm2rAt
 21m9eg0dzHQy7RMrUdnUV6So55aEn5tQiShAufUP4UAbcedY5FcDEstwGQXbLF6F+PlQ
 ctMIPHOE9ebUZRgtGnqjLuKMMwOmIE+94X8hMOKATJAYMhqTprVfgq4WeOUjsVyHzqSs
 4S715JEt8IsIF2pbMiNuTnoPUHS/eUAEvgQky9xSdw8pahhBR+AdzOec0XM1wDMeLxab
 DuyJA3W9uh95dacsPUmMDlrqrfAS33icAhSuQ1H/NYIUIojZuWsie7VPMiOsh9VGW996
 AH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877847; x=1780482647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BtN+imCP9amar/84bgqStd8DEqBoZpM9N9xe//uTSQ4=;
 b=qkjka3yb+6ENThhlGAy9nWAMuXze6Q3INJiMTlk9f1YjpyJN/AslKkiv0jdmFruSJ9
 jHO369SBrEhLUqd9FNGvWEcq2n/TZ/Thg97cNHtSaWlbaO5nCFI6j8RnO+ZgZwliud2M
 dvRes3RyuaoENa05rTYYfXEDJ5CG2PU9F6MeN4qvNzVSfsAiXM4iwzPB0fDAVFu/ERVV
 /P4o2ewky9yY5MuXVNdGfLns0MEbJPk+3lE3fyOzIgs4k2s+m2hdC2xojfJqcbMD+Ehw
 Ydy+UChUO+uXYeMIcfu9+aF3i8HYESZ4Fi21UmkvicDvi42QEZkML7bVgbTqlMyVHYcs
 +uCg==
X-Gm-Message-State: AOJu0YzSbOFkik+hUunWG46ncVzZpUw7VcjKkDkW8iwpBGt/drsUiD/F
 +Wmk2K3Sva0JISSEzgdS+wCVxxTPC81ZsVcEURoVekSmKJCnHBue7YJqi5NUQH71P3y5sUchzDZ
 qB+tOtMRbhA==
X-Gm-Gg: Acq92OHgPdZ1NitWxcyRy1fAJWP6MADuaPLVXFvWtzO5U8UPyu0TOgwPQ/QGo8RYP3I
 9FpTyl8aUqUyPrgAyR4Aa6wWUWEOPInNZw9DbpZzM65OXL41ZFiM/W7BrSpzD1opMH6RCvYCFCj
 bdsokrhLdOM/vfYK58HU1fKBDm+8jvXkH5SyT1O4SA9QinTwN6zMzXl/kFu5uVpfNpYUhiDFp5o
 XZmi3JYSmmdt2xnTxvJBPxZq2+hvn3MPLR7zYE5zZvekV61wlPwwq4hXpdVzTV11xRD/Srift6n
 OABF0gxeVnV8hGdmtiqdXJNSM/ckItgES3R7KaK0M90gQHafdeWvkIZZeHLGNHlQKfxCzWnPb3D
 rFKFulLmV/peoD+onVHoDs8t6eBHtd3arCNv/1+t6N7YSiSA9u9wswSMNs7DBnW9Ew5fX9hXSr8
 9A7PKdzH24ZQU7To3pH8ZRWUMn951qMVMHo3bxB3mDPxr7K95D/TUeCf7vbN+z7nhXkw==
X-Received: by 2002:a05:600c:3b97:b0:490:52fb:12dd with SMTP id
 5b1f17b1804b1-49052fb14fdmr345123415e9.10.1779877846552; 
 Wed, 27 May 2026 03:30:46 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4907e627b1csm23105915e9.0.2026.05.27.03.30.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:30:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/32] hw/riscv: Register generic riscv[32|64] QOM interfaces
Date: Wed, 27 May 2026 12:30:05 +0200
Message-ID: <20260527103037.4461-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Anton Johansson <anjo@rev.ng>

Defines generic 32- and 64-bit riscv machine interfaces for machines to
implement.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20260520-hw-riscv-cpu-int-v3-1-d1123ea63d9c@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/riscv/machines-qom.h | 20 ++++++++++++++++++++
 target-info-qom.c               |  9 +++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 include/hw/riscv/machines-qom.h

diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
new file mode 100644
index 00000000000..69fcf61fd72
--- /dev/null
+++ b/include/hw/riscv/machines-qom.h
@@ -0,0 +1,20 @@
+/*
+ * QOM type definitions for riscv32 / riscv64 machines
+ *
+ *  Copyright (c) rev.ng Labs Srl.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_RISCV_MACHINES_QOM_H
+#define HW_RISCV_MACHINES_QOM_H
+
+#include "hw/core/boards.h"
+
+#define TYPE_TARGET_RISCV32_MACHINE \
+        "target-info-riscv32-machine"
+
+#define TYPE_TARGET_RISCV64_MACHINE \
+        "target-info-riscv64-machine"
+
+#endif
diff --git a/target-info-qom.c b/target-info-qom.c
index b48714cc77f..7958a5cc685 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -13,6 +13,7 @@
 #include "qemu/target-info-init.h"
 #include "qemu/target-info-qom.h"
 #include "hw/arm/machines-qom.h"
+#include "hw/riscv/machines-qom.h"
 
 static const TypeInfo target_info_types[] = {
     {
@@ -23,6 +24,14 @@ static const TypeInfo target_info_types[] = {
         .name           = TYPE_TARGET_AARCH64_MACHINE,
         .parent         = TYPE_INTERFACE,
     },
+    {
+        .name           = TYPE_TARGET_RISCV32_MACHINE,
+        .parent         = TYPE_INTERFACE,
+    },
+    {
+        .name           = TYPE_TARGET_RISCV64_MACHINE,
+        .parent         = TYPE_INTERFACE,
+    },
 };
 
 DEFINE_TYPES(target_info_types)
-- 
2.53.0


