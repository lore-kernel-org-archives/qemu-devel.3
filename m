Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F6CCD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKclX-00080t-AU; Wed, 06 May 2026 09:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKclU-0007v4-6M
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:58:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKclS-0008Os-9v
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:58:15 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso9727835e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075892; x=1778680692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8fEn5pkJWA65oSQIEFnruXn9B2oJ43OnPg+gNauUAyA=;
 b=BWIEeDSE2A1kkKIjhuB+vcAbM678pmsio2Qm5+B4G1pr4eyZh53dVWWnWQ/M4k7qvQ
 xaJoZaCn9f48FJS2rByWwG6tGdyBGPLIHbAdDRyA74q0qjesWWkIjc2WjsTVvhp1K5aA
 9Md19+6L9mkizHBimDeHglq0ghgj52iUs4W+gi3r07O/JeJU8DVMjzTR71zbcIqYY0BG
 zLOP/8Rp8mWtjeaGWjmNGdJ629vsOyseqVlSkuH0BE2X0BtInXFDtsNoMzKsbovGK4RD
 obQ9ig8dAnkgQ5y7pJ2rOW8t3EhyDTqK0gDfQJWNqnxlKylkEud0imgCVZgntLMnefpd
 5F9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075892; x=1778680692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8fEn5pkJWA65oSQIEFnruXn9B2oJ43OnPg+gNauUAyA=;
 b=NHvLuF9VWbIKscUgk0pKRO/SSUb6UT3gbylb1GguDP0l2gdo5/4B9Q8rmvk6koOz2l
 5RHVSG41A84xUzRF+54Xlk+Rz2NNRWxWwaT/SPMfk3Soucmw4u2ygl/7cHmjC1JfNBcP
 8m+qxSfHGVfMSfWGGcxrcaD7qVj3UDEdSG0KDS2K7vZStJUnwxXbreCN0eWpInFQloSL
 msSSEY4Dt2qBd+cxJnTSNIZM0cApxXD5IUZjbk+uakBPI5jxxNTi70Y3/d/zx3t6FL+j
 t4AO2hs+bLjPBuOWaFr7VgjKS/u9Sp6xyQHXyBh5K2E/XANCrvev1/54Md6jFv8p2yS2
 PdDA==
X-Gm-Message-State: AOJu0YwcxnFOhFgR8QK4Y1qWfgqx99nZLQDRiR3TjNi81n+BlNpXqlIi
 Sr96fdXWTpJ7TS5Uk3ulCcjiZZnzJUlH+ya13I9EKZ9gTVxfuu5kxL88QcoWwe0X9z43hxK3qzC
 Fb/uzRzU=
X-Gm-Gg: AeBDieuAJ/qIZ5NDr6ogGKfg8lI9S/EBFR5PPF7ISY30PSYe2Iq+cE1fZWdwCswBsyd
 rM0ik3rjEgMh3ORBYFqlCBtgWIMtN9y2urHeWgXQXxhuzovZdwx7iCW4WCjPAGEr0J8jk1ySeIz
 bxKkH9dKsi0tPIjGOH/NBZe2DcYSvfj4833T1KKoqVpUoOYJVXvDm/v/8e/X4ktjWCy2gvliPVW
 atFEcRcG8YD4YD/iuXhixkxzV9x8LPDR2H1jiPTNJFLdW7FwuD3IcUCklLSvbD4mtMxkCvZoIc9
 Li4++Q/p03TBnvZQctaisruGfqy12FxoFF9C238abH1aH5f6fwTy+58rHJEMrl+55dLfyfTjcJR
 M5duKxEvlzRUw2fO+IeaYXrvs3ebpxJj3viqUaj6r5F75S+QKcASSoAyexN8yCqAFdjN/2gAiTR
 5WTymEEzdMH46TAOqyHtLmmNmxXVCqzK9M/O1VVwbzXCDx/Ow9tGl0sbH36NXZDwjrQorKdEiXE
 BfYYIJQkOE=
X-Received: by 2002:a05:600c:5291:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-48e52285af1mr47473525e9.6.1778075891791; 
 Wed, 06 May 2026 06:58:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538ca8c0sm46383205e9.13.2026.05.06.06.58.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:58:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 022/110] monitor: Remove MonitorDef::type field and MD_TLONG /
 MD_I32
Date: Wed,  6 May 2026 15:53:54 +0200
Message-ID: <20260506135524.20617-23-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
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

None of the few targets still using MonitorDef use MD_TLONG,
they either use MD_I32 or the %get_value handler. Remove the
MonitorDef::type and its definitions altogether: simply check
for the %get_value handler, if NULL then consider 32-bit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260320091019.59902-3-philmd@linaro.org>
---
 include/monitor/hmp-target.h |  4 ----
 monitor/hmp-target.c         | 12 +-----------
 target/i386/monitor.c        |  2 +-
 target/m68k/monitor.c        | 24 ++++++++++++------------
 target/sparc/monitor.c       | 14 +++++++-------
 5 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index 898473b3ed0..ce0bb1983cc 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -34,13 +34,9 @@ struct MonitorDef {
     int offset;
     target_long (*get_value)(Monitor *mon, const struct MonitorDef *md,
                              int val);
-    int type;
 };
 #endif
 
-#define MD_TLONG 0
-#define MD_I32   1
-
 const MonitorDef *target_monitor_defs(void);
 int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
 
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 420969bd6eb..3f019ae2a28 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -82,17 +82,7 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
             } else {
                 CPUArchState *env = mon_get_cpu_env(mon);
                 ptr = (uint8_t *)env + md->offset;
-                switch(md->type) {
-                case MD_I32:
-                    *pval = *(int32_t *)ptr;
-                    break;
-                case MD_TLONG:
-                    *pval = *(target_long *)ptr;
-                    break;
-                default:
-                    *pval = 0;
-                    break;
-                }
+                *pval = *(int32_t *)ptr;
             }
             return 0;
         }
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 446428602ef..977f65fe16c 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -602,7 +602,7 @@ static target_long monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
 
 const MonitorDef monitor_defs[] = {
 #define SEG(name, seg) \
-    { name ".limit", offsetof(CPUX86State, segs[seg].limit), NULL, MD_I32 },
+    { name ".limit", offsetof(CPUX86State, segs[seg].limit) },
     SEG("cs", R_CS)
     SEG("ds", R_DS)
     SEG("es", R_ES)
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 08ced037b47..94bb12833af 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -24,18 +24,18 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 }
 
 static const MonitorDef monitor_defs[] = {
-    { "ssp", offsetof(CPUM68KState, sp[0]), NULL, MD_I32 },
-    { "usp", offsetof(CPUM68KState, sp[1]), NULL, MD_I32 },
-    { "isp", offsetof(CPUM68KState, sp[2]), NULL, MD_I32 },
-    { "sfc", offsetof(CPUM68KState, sfc), NULL, MD_I32 },
-    { "dfc", offsetof(CPUM68KState, dfc), NULL, MD_I32 },
-    { "urp", offsetof(CPUM68KState, mmu.urp), NULL, MD_I32 },
-    { "srp", offsetof(CPUM68KState, mmu.srp), NULL, MD_I32 },
-    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]), NULL, MD_I32 },
-    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]), NULL, MD_I32 },
-    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]), NULL, MD_I32 },
-    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]), NULL, MD_I32 },
-    { "mmusr", offsetof(CPUM68KState, mmu.mmusr), NULL, MD_I32 },
+    { "ssp", offsetof(CPUM68KState, sp[0]) },
+    { "usp", offsetof(CPUM68KState, sp[1]) },
+    { "isp", offsetof(CPUM68KState, sp[2]) },
+    { "sfc", offsetof(CPUM68KState, sfc) },
+    { "dfc", offsetof(CPUM68KState, dfc) },
+    { "urp", offsetof(CPUM68KState, mmu.urp) },
+    { "srp", offsetof(CPUM68KState, mmu.srp) },
+    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]) },
+    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]) },
+    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]) },
+    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]) },
+    { "mmusr", offsetof(CPUM68KState, mmu.mmusr) },
     { NULL },
 };
 
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index e9300ded4ad..a60671a60a4 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -41,13 +41,13 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 
 const MonitorDef monitor_defs[] = {
 #ifdef TARGET_SPARC64
-    { "asi", offsetof(CPUSPARCState, asi), NULL, MD_I32 },
-    { "pstate", offsetof(CPUSPARCState, pstate), NULL, MD_I32 },
-    { "cansave", offsetof(CPUSPARCState, cansave), NULL, MD_I32 },
-    { "canrestore", offsetof(CPUSPARCState, canrestore), NULL, MD_I32 },
-    { "otherwin", offsetof(CPUSPARCState, otherwin), NULL, MD_I32 },
-    { "wstate", offsetof(CPUSPARCState, wstate), NULL, MD_I32 },
-    { "cleanwin", offsetof(CPUSPARCState, cleanwin), NULL, MD_I32 },
+    { "asi", offsetof(CPUSPARCState, asi) },
+    { "pstate", offsetof(CPUSPARCState, pstate) },
+    { "cansave", offsetof(CPUSPARCState, cansave) },
+    { "canrestore", offsetof(CPUSPARCState, canrestore) },
+    { "otherwin", offsetof(CPUSPARCState, otherwin) },
+    { "wstate", offsetof(CPUSPARCState, wstate) },
+    { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
 #endif
     { NULL },
 };
-- 
2.53.0


