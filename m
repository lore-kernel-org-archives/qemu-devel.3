Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4386BFB5185
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9wBP-00080Y-2l; Mon, 06 Apr 2026 22:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAr-0007eR-9l
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:17 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAn-000713-4x
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:16 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2aae4816912so28515145ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 19:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775528891; x=1776133691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=huvcXnMs/4HjTKO88sCRvIdI93uZJ7KONvYohCQFmDE=;
 b=QKnYFBu8Dg5apEXbZHuB7UrYq2aU3r5V+IrY+nZXnmg1qDaiwm8hE+s32HNrePPu3y
 BaC1y2kX3QhRPBXkaUalo8saSdvrF31zd33sFITci7UCw0ghrxqmulMiyhQ5P4BkMc80
 j7R5mfwoIeDqzlPpz028ulpSJDVWAWnJD16Sj+BlSgkvJsEm1+bdTedKZ8P4xgDH26wT
 hrj6okjJKAyYIttRX9s+10IYfnJ/xUboqx8vPoqW/0ae2u+Kq3mNyK/temlxpluidHHO
 QVqXz6ivBI9bkbvnsdkDaaIEswhOP7sDFfWSeFJ3CRi6N5EoRc4jSl5kBSy9a1/ZVf/r
 7aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775528891; x=1776133691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=huvcXnMs/4HjTKO88sCRvIdI93uZJ7KONvYohCQFmDE=;
 b=Pi67Bd0Rj2iiJLDbICN5KghVp2r8kAuYgquim+ChaygYXDtTBkSHf8wbUSm0NBhIwL
 H3Zfe5IK8grlY3niJIa0QiEcapG5U4HQ+BsjD4RivHL3dUXnbWv8ctEKjsQzp8A6IzLK
 2tswjpk0eqABbYNY9JKHlLhigIrD78kKbreasxm37XSEyXCsqnFKt84y4HitPfn7axjZ
 BVQEQVYY4+/wmSHrMelPk6Ep5E9jYD61htcoWnIesMmQH7tSxZi7R8RoRJTQFBeues9B
 +2fSCKjlbWSOLTsl28SVN1xjAuUHrevTdRPQIX6H7HS63Cp5mwSAU1/DHfsntuEiDrhv
 1RvQ==
X-Gm-Message-State: AOJu0YxM2qV6c0oVWxYZ7WK8QYWoA1bvsia+nS6PnhKFe+gTdhQ6r9ve
 XkN+2Lt9po0sxLuo0k8QSB+9Nv8AlTnLBnObKNdZ+oRCw66RIzzG9RcdAnq2RWsWmFyWfyiXmk9
 nkLEp6Zh0/Q==
X-Gm-Gg: AeBDiesPSf317P8m6DsPXCvjAtZxi1IQHPiiDeG2uY5EQlQ69qhUwbHdUb8EnBy/iRg
 1jWh4QnoBRyo1DrSn6pq04cid7ffxDrCD6DTD585kowXpjCs4iso6gFsjeHn4pojUI5Wz1wZTgn
 mSfMzXz9G4RK8yZzVMECMm0nFu5rJa6DeH7rwb5js6ohpkMhgrwayTKytk/JsUnJ8eFcIsdMSV3
 64IZPE/HgOaSdEbWZ/UYrIIgrvbq4YHLst18wt+hM+o5YNHiP51R3vj8puHTTUVn+pbm7HXbBZ8
 opM1sFnerMBmrvUMQF1lZGvjs8TQTKzBRiX7LLbc4kYZryy4jTkNLb74A+d3AT8zvyN4gcS3Hfs
 XAHAT9qO8te1DlALtajzqfK0UV/JuEY/0ZXHTi09EQ0P+wythszatXQsfKkyj21wwiRNy88jEMP
 8XdRDjls+j+mHtpNDgFHvynn/vAorS71xcxII0NB/K7pPf1wpEoZoGhzw6/hF1+hL8/Rxv+kYZF
 hfb
X-Received: by 2002:a17:903:3c47:b0:2b2:4ded:954e with SMTP id
 d9443c01a7336-2b281801b5amr175135735ad.24.1775528890538; 
 Mon, 06 Apr 2026 19:28:10 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749794e8sm161423685ad.53.2026.04.06.19.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 19:28:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
Subject: [PATCH v9 17/20] target/arm/tcg/arm_ldst.h: merge in translate.c
Date: Mon,  6 Apr 2026 19:27:45 -0700
Message-ID: <20260407022748.57629-18-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Only translate.c uses those functions, thus move them back to this file.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/arm_ldst.h  | 47 --------------------------------------
 target/arm/tcg/translate.c | 22 +++++++++++++++++-
 2 files changed, 21 insertions(+), 48 deletions(-)

diff --git a/target/arm/tcg/arm_ldst.h b/target/arm/tcg/arm_ldst.h
index cee0548a1c7..e69de29bb2d 100644
--- a/target/arm/tcg/arm_ldst.h
+++ b/target/arm/tcg/arm_ldst.h
@@ -1,47 +0,0 @@
-/*
- * ARM load/store instructions for code (armeb-user support)
- *
- *  Copyright (c) 2012 CodeSourcery, LLC
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef ARM_LDST_H
-#define ARM_LDST_H
-
-#include "exec/translator.h"
-#include "qemu/bswap.h"
-
-/* Load an instruction and return it in the standard little-endian order */
-static inline uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
-                                    target_ulong addr, bool sctlr_b)
-{
-    return translator_ldl_swap(env, s, addr, bswap_code(sctlr_b));
-}
-
-/* Ditto, for a halfword (Thumb) instruction */
-static inline uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
-                                     target_ulong addr, bool sctlr_b)
-{
-#ifndef CONFIG_USER_ONLY
-    /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
-       within each word.  Undo that now.  */
-    if (sctlr_b) {
-        addr ^= 2;
-    }
-#endif
-    return translator_lduw_swap(env, s, addr, bswap_code(sctlr_b));
-}
-
-#endif
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index b3c95fb66cb..1fbe41ec643 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -25,7 +25,6 @@
 #define TCG_ADDRESS_BITS 32
 #include "tcg/tcg-op-mem.h"
 #include "qemu/log.h"
-#include "arm_ldst.h"
 #include "semihosting/semihost.h"
 #include "cpregs.h"
 #include "exec/target_page.h"
@@ -6280,6 +6279,20 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     }
 }
 
+/* Ditto, for a halfword (Thumb) instruction */
+static uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
+                              target_ulong addr, bool sctlr_b)
+{
+#ifndef CONFIG_USER_ONLY
+    /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
+       within each word.  Undo that now.  */
+    if (sctlr_b) {
+        addr ^= 2;
+    }
+#endif
+    return translator_lduw_swap(env, s, addr, bswap_code(sctlr_b));
+}
+
 static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
 {
     /* Return true if the insn at dc->base.pc_next might cross a page boundary.
@@ -6514,6 +6527,13 @@ static void arm_post_translate_insn(DisasContext *dc)
     }
 }
 
+/* Load an instruction and return it in the standard little-endian order */
+static uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
+                             target_ulong addr, bool sctlr_b)
+{
+    return translator_ldl_swap(env, s, addr, bswap_code(sctlr_b));
+}
+
 static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-- 
2.47.3


