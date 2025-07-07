Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F33C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 17:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYpY3-0003l2-9j; Mon, 07 Jul 2025 13:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpVu-0000Qr-DC
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:20:25 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYpVr-0004yr-Qy
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 13:20:22 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso1539368f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 10:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751908817; x=1752513617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPKj5S3tHFubjMvOc+FpSPzyOTtYDrCXYgAF/148ssQ=;
 b=vi/0Szt/odD7mCaQ3ijnqksRBn0A+3My0nPWR8NfldWdiMvdLbD424LL89MXpAasBX
 VsY0q4DxVs+1Y6qPi1m5vKjhZv8t3i4+tBqAHIUa1WjJdAvO3ubojOQbUCQUp5wARxPx
 Lp+xWQPE+tdecEA4ZsHahdW/X8maanKJTKvWnvarxzD3zIwR4OoSMmt8T1UztpU1G1Fu
 nuDvSjKVdkksvzVHHVKqJTej4h8cNWlEgaZSlJqZBZPeG4WH7WgeIBVT8IJi1gqXwkoH
 OPju/cu9/yml2/MLQTo5mzEiXfZZdnVPXTEXrXrFryS7LYMGa6IwAneTJ7asw8M4+s5o
 fWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751908817; x=1752513617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPKj5S3tHFubjMvOc+FpSPzyOTtYDrCXYgAF/148ssQ=;
 b=PhxveBzKfRueBSkiRFM0oMDLZpG7c7CMatBHYK9Lxq5GAUGcZilY9l+51m0kEn4jma
 VmCpjQjmlgZKxs/AW18XLQLqC5gdp78pIWAB2gd3ro6qi2KDk6Cxsottg9jcFzQ3AVdm
 W9bJJYpQuYl5AIvw8CZWL30Tcr1fQdrB9LtAgcf8PrPCWJz9SqSisxQjJwmVdDTh4C3n
 X52LCVSRrhA1wKTgNxidEz/K8fKyEp6/skEOtHm/lA5hyuKQNwodEDcJcYfr0Glc5FZv
 JhUo0G3mmqcJJPLfqlO97bY3/aL8klILawg/8WB+hMZvmYfHGpK5PvY5V28X3X1/IZY0
 fW1w==
X-Gm-Message-State: AOJu0Yyvr+QWgdrCiVGZQeZ/utxYmJ5yXo7oUebxLf1HsF7RDMKfLUDO
 n+s6Jck4/eq654u/BacNCWLSQVY0NeZM7lVgdBXrOPDHWwNya2OCIS/qv7xn2H0KZ3BXiRnGUrW
 VI6ToNVY=
X-Gm-Gg: ASbGncu62O7a5jKIJPTYjcUhZlVIV/U67mpYh/plhTEfoQHBtmsunLDp0bTrqUoFwwe
 UVpQjBtGT/fXmHfOaJ82QiuQme4ntOIOtTsQb8k01qkEP/qIrrOKzWebETn63E0dhpF36vrEh84
 VgADNsZLWvj/oIAnfyYBqE3iPrWQU7XQIHlWNQKNc67/dxG65rXlmjnH2etp9FO7hAFq4QtulAQ
 Mn6UPNd/A8FonxVQdtzE7Nbajk3TXNT4cmXnDMw5nRca76Y/i0WxKHc0vdkUjmcP3g/7NV9WxHa
 haeKHptXfHXf3/CIt8TNMcHYODiupN3deYwbgEf70P/ya4pVOOB8Q2Lq5HgJxgdaZLHZP3AekjU
 6gohrA52bComUDDlMlohF/y7eeZq5v7k+xuRp
X-Google-Smtp-Source: AGHT+IGCSV5kO8RY5wl3hODLRNtupRcCVEnCURNmqdz6EdIEC8nno86Za7JhyuoqB207ZkzMCGrdVA==
X-Received: by 2002:a05:6000:98e:b0:3a4:e387:c0bb with SMTP id
 ffacd0b85a97d-3b49aabdc06mr7100887f8f.59.1751908816657; 
 Mon, 07 Jul 2025 10:20:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030baa5sm11084319f8f.12.2025.07.07.10.20.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 07 Jul 2025 10:20:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH-for-10.1 v6 01/14] target/qmp: Use target_cpu_type()
Date: Mon,  7 Jul 2025 19:19:55 +0200
Message-ID: <20250707172009.3884-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250707172009.3884-1-philmd@linaro.org>
References: <20250707172009.3884-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/arm-qmp-cmds.c             | 3 ++-
 target/loongarch/loongarch-qmp-cmds.c | 3 ++-
 target/mips/system/mips-qmp-cmds.c    | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index cefd2352638..d292c974c44 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -21,6 +21,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "hw/boards.h"
 #include "kvm_arm.h"
 #include "qapi/error.h"
@@ -241,7 +242,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
 
-    list = object_class_get_list(TYPE_ARM_CPU, false);
+    list = object_class_get_list(target_cpu_type(), false);
     g_slist_foreach(list, arm_cpu_add_definition, &cpu_list);
     g_slist_free(list);
 
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index f5f1cd0009d..1d8cd32f5fc 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "cpu.h"
@@ -32,7 +33,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
 
-    list = object_class_get_list(TYPE_LOONGARCH_CPU, false);
+    list = object_class_get_list(target_cpu_type(), false);
     g_slist_foreach(list, loongarch_cpu_add_definition, &cpu_list);
     g_slist_free(list);
 
diff --git a/target/mips/system/mips-qmp-cmds.c b/target/mips/system/mips-qmp-cmds.c
index d98d6623f2f..b6a2874f2dd 100644
--- a/target/mips/system/mips-qmp-cmds.c
+++ b/target/mips/system/mips-qmp-cmds.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "cpu.h"
@@ -40,7 +41,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
 
-    list = object_class_get_list(TYPE_MIPS_CPU, false);
+    list = object_class_get_list(target_cpu_type(), false);
     g_slist_foreach(list, mips_cpu_add_definition, &cpu_list);
     g_slist_free(list);
 
-- 
2.49.0


