Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E748C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 16:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tveoE-0001KM-Cg; Fri, 21 Mar 2025 12:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tveme-0000aS-HY
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:59:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvemc-0004RB-Nc
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:59:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so10667355e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 08:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742572781; x=1743177581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vgu1GHyuouw+Ha/3MC9IKsCVm+XO3DMQUE/IPBZdLMg=;
 b=ca9HbrnWyLvf9xe+zMLOl/ww/cupSDGAzbSvrqKnEdIM+sKh47It0O60JoFWmYMmZy
 cT5cSZbV22hHbBNT+rZTvDXtDXI0K5NR+8nCjDJ/zHuR2tG73ElmxSzG+vz576PJDcoC
 7oQN9Rv9iZ2LBMjbxF3hRZywUNl85Lhznox7o9Ib9VFflvCu3JtdoInFcu0FKKGvZ6AA
 +p90+QznttUM65B2CfLQGO2hw0gKan8NtOKJeIapfebXF8e87zwSqAimgzh4uSWEFipF
 w1iaUw8eTwXE0xrqZgb0Pdaw+DB5pNX9afk38tekDgJ81h8YlVYtguAL7KyVrZ1PO+qh
 sykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742572781; x=1743177581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vgu1GHyuouw+Ha/3MC9IKsCVm+XO3DMQUE/IPBZdLMg=;
 b=vRwLWHN5QRv0BpFBl8RIbeNLhwb0XEcmqHx6duXRNca9ZGQuMWnkm/g6GLQSgfTuBD
 i3kuOrRdi+o2fYwSJLVY9w71+AedYH91JAfndqmMc2zrm4Vcdx6IO1jAwKdgEk/L2d+F
 TouHhxygjg2I0e3p0sbCk/Z78R/5D7GeRSpOxSeA71lsu+PNQqpj57VVgIoA1ObMF0su
 xRqmR/FvqatnYj+BNB2IuV+2NcHK61fFwREU4wrFs7CP8XUsIBOLjA/L7f53KMUjoSIX
 7pmoLVzv93Y1TNEwfkZHdEwLzZuYDNPLTWalLsbCrxaFYIvi2q6SBxLJGV+5WSAnLcOV
 BfBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG2bCOxOrvv/Qcd1tc8JpNrgWdTjKyHRfH2IBGP6xF8TuAJMSfcc9jM/TuM1+fRAEOzJ2oz9/UyPH7@nongnu.org
X-Gm-Message-State: AOJu0YyKolGbGX/EsY5M8i+PU9l9aFgUiV2hx0kgLfMPQUqSovIVBIdv
 YR7th/p+/CNzcgcwVxwv0B/nS5cNVQ5F5WoqTds9zNf2nYNtSviT0z8IVR85bgw=
X-Gm-Gg: ASbGncsObPQaos18R9WHM7eDK6upTNCE7g4BqsNPEKU5Ryth6Sn+4ijHrIswGiyk4oq
 SZcK++bBbGgB+5hW/60HM0TVv8ZgQY7HkIwqcd8wjl7jbq3ZVj3MKUN/6lFOCGiUbF0C26RFqSb
 sO0PshBLzInRfkdgKTRmAR1P8KwuMxe6HPgFPzMDXIlKhs2hyF70eRHAfzHV67xNKeDm+ImLRkX
 v7vw5N0qweQa3H6RuWClZa1yzricN7+oDcMoFZ8P05JYr/xUDEXsfXu/D+TwinrNKI7fGgYAdCf
 6nKM+C8aIJAlrqGkMywD3+MwGMdZ1yYcnHn9oEmYDlyv2SNnoPaRDpwZfkHv4cjCZat6tSCzOHO
 jPngiWiz+mu2SNQAyiY8=
X-Google-Smtp-Source: AGHT+IG70OC1Gxa9Pggya81vm0rgOeiP6kgooXOINEtpu3Tt9YYcU9paDceeFM3WoZM5SZ/LN0/mQQ==
X-Received: by 2002:a05:600c:1992:b0:43c:f332:703a with SMTP id
 5b1f17b1804b1-43d50a553f2mr30586725e9.31.1742572780944; 
 Fri, 21 Mar 2025 08:59:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e674fsm2649634f8f.80.2025.03.21.08.59.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 08:59:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 3/4] tcg: Convert TCGState::mttcg_enabled to TriState
Date: Fri, 21 Mar 2025 16:59:23 +0100
Message-ID: <20250321155925.96626-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321155925.96626-1-philmd@linaro.org>
References: <20250321155925.96626-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Use the OnOffAuto type as 3-state.

Since the TCGState instance is zero-initialized, the
mttcg_enabled is initialzed as AUTO (ON_OFF_AUTO_AUTO).

In tcg_init_machine(), if mttcg_enabled is still AUTO,
set a default value (effectively inlining the
default_mttcg_enabled() method content).

Instead of emiting a warning when the 'thread' property
is set in tcg_set_thread(), emit it in tcg_init_machine()
where it is consumed.

In the tcg_get_thread() getter, consider AUTO / OFF states
as "single", otherwise ON is "multi".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-all.c | 68 ++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index d75ecf531b6..2b7f89eaa20 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -32,6 +32,7 @@
 #include "qemu/error-report.h"
 #include "qemu/accel.h"
 #include "qemu/atomic.h"
+#include "qapi/qapi-types-common.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qemu/units.h"
 #if defined(CONFIG_USER_ONLY)
@@ -47,7 +48,7 @@
 struct TCGState {
     AccelState parent_obj;
 
-    bool mttcg_enabled;
+    OnOffAuto mttcg_enabled;
     bool one_insn_per_tb;
     int splitwx_enabled;
     unsigned long tb_size;
@@ -68,37 +69,10 @@ bool qemu_tcg_mttcg_enabled(void)
 }
 #endif
 
-/*
- * We default to false if we know other options have been enabled
- * which are currently incompatible with MTTCG. Otherwise when each
- * guest (target) has been updated to support:
- *   - atomic instructions
- *   - memory ordering primitives (barriers)
- * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
- *
- * Once a guest architecture has been converted to the new primitives
- * there is one remaining limitation to check:
- *   - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
- */
-
-static bool default_mttcg_enabled(void)
-{
-    if (icount_enabled()) {
-        return false;
-    }
-#ifdef TARGET_SUPPORTS_MTTCG
-    return true;
-#else
-    return false;
-#endif
-}
-
 static void tcg_accel_instance_init(Object *obj)
 {
     TCGState *s = TCG_STATE(obj);
 
-    s->mttcg_enabled = default_mttcg_enabled();
-
     /* If debugging enabled, default "auto on", otherwise off. */
 #if defined(CONFIG_DEBUG_TCG) && !defined(CONFIG_USER_ONLY)
     s->splitwx_enabled = -1;
@@ -117,9 +91,37 @@ static int tcg_init_machine(MachineState *ms)
 #else
     unsigned max_cpus = ms->smp.max_cpus;
 #endif
+#ifdef TARGET_SUPPORTS_MTTCG
+    bool mttcg_supported = true;
+#else
+    bool mttcg_supported = false;
+#endif
 
     tcg_allowed = true;
     mttcg_enabled = s->mttcg_enabled;
+    if (mttcg_enabled == ON_OFF_AUTO_AUTO) {
+        /*
+         * We default to false if we know other options have been enabled
+         * which are currently incompatible with MTTCG. Otherwise when each
+         * guest (target) has been updated to support:
+         *   - atomic instructions
+         *   - memory ordering primitives (barriers)
+         * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
+         *
+         * Once a guest architecture has been converted to the new primitives
+         * there is one remaining limitation to check:
+         *   - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
+         */
+        if (icount_enabled()) {
+            mttcg_enabled = ON_OFF_AUTO_OFF;
+        } else {
+            mttcg_enabled = mttcg_supported;
+        }
+    }
+    if (mttcg_enabled == ON_OFF_AUTO_ON && !mttcg_supported) {
+        warn_report("Guest not yet converted to MTTCG - "
+                    "you may get unexpected results");
+    }
 
     page_init();
     tb_htable_init();
@@ -144,7 +146,7 @@ static char *tcg_get_thread(Object *obj, Error **errp)
 {
     TCGState *s = TCG_STATE(obj);
 
-    return g_strdup(s->mttcg_enabled ? "multi" : "single");
+    return g_strdup(s->mttcg_enabled == ON_OFF_AUTO_ON ? "multi" : "single");
 }
 
 static void tcg_set_thread(Object *obj, const char *value, Error **errp)
@@ -155,14 +157,10 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
         if (icount_enabled()) {
             error_setg(errp, "No MTTCG when icount is enabled");
         } else {
-#ifndef TARGET_SUPPORTS_MTTCG
-            warn_report("Guest not yet converted to MTTCG - "
-                        "you may get unexpected results");
-#endif
-            s->mttcg_enabled = true;
+            s->mttcg_enabled = ON_OFF_AUTO_ON;
         }
     } else if (strcmp(value, "single") == 0) {
-        s->mttcg_enabled = false;
+        s->mttcg_enabled = ON_OFF_AUTO_OFF;
     } else {
         error_setg(errp, "Invalid 'thread' setting %s", value);
     }
-- 
2.47.1


