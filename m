Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63662FF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH0h-0000az-Ac; Mon, 27 Apr 2026 04:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH0f-0000an-PD
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:08:05 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH0e-0001LH-69
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:08:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so49147635e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277283; x=1777882083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cBuj8J+8c77rLL4d5hAULRShpRlZCQscvo/9rmO1W0M=;
 b=rWALb7mwTDx4gEQzdA0NarRnVNW/sXb4kqjQwgrb01BKZTs6NTpIMhJvWOKAdoiydz
 8LL7vhaWJi9F/p9ALYzvQghEKQVbpPIp2j/YK1zNWygrBXv57iau5Ugp0yAyaWTuJojT
 12hKageMklIjod+8SQBqCLFLyCjXXUFKMzwjt7DeKd/WRMnescnMpHNb+xrQYWDdirDo
 PYx6AGVChrscOf/2K4hEHAKmZbeCsJr6ExXV13/q95CgYVG0OhDsq9VVdkz/MgfO7/AI
 7iVr3awyH5we87Vt6TF3DGXvXEiIYCo6VKETS+99OUhTUGQpYsgQh5v7+2WSrFq2KKXr
 jPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277283; x=1777882083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cBuj8J+8c77rLL4d5hAULRShpRlZCQscvo/9rmO1W0M=;
 b=hGt9esblfi8i5jIcEiph72dZpzY1WuBmq7/WGyCMrO9/l2WiE46dwZtn1wi6xpWn2y
 nJOoA53gCtpkZnbqK9OScm+zvzdDcovY3xE9U+ij4DiAjcgkfYtvfpOAZN/6PggTnmTd
 C59mFTECsk6h3mfw9IS/qPTFqPq9o1Y4qPhNxZAPyU+yQuFVqc0HMfn4jKwsbApL9t4D
 7xLjxd3CWrAuHeTmnI1nDjH8LMmBPreQOL53Jag/tVCkrZ1T5NoAQfzKl9ixj847kyuJ
 if6+uWWbtmirAIb85dol2m1+W5sGiqroYwFdTeS8jBW8nEdNllJf3tbb6ii2UnRwtET7
 EWmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gaoL/Y9zOW6BcRB3I8kcldonPuYH713TC6yrFu/+1mTs3midhW3IlZPz4RV4D4LN1HhIiwTkV3nRK@nongnu.org
X-Gm-Message-State: AOJu0Yzv2a4EhIPKrvML8IaI23yIl+s6+xz2LHw1nLTl/tWGgswOGBaN
 +vQjvu2BYfmJUTAzkAswKSqN/JRDt4xegbbNSvd6aQdO6X35vkcm0e7rZtIVha9vk2XtJv9I2li
 L16PSsv0=
X-Gm-Gg: AeBDietKlWedA4eHKnLO+jrIcnim3ACgi5k/zjXJc1fHbv2dAxq4XisGL4qTPKSwSdb
 KW0BeeL6QXPA11Yo2E0ziEMTsvCEIhB/BNhmjyHnlwvDyJAZF2N5YSeCrpdT3VHQtyV0txaxJ4J
 DCit2vEnGRQE+nSBnLcIcMp0BXfbvO5WH7xQH4A1VMlqHq5w1Mv90DNyzdP804oRPVKMgJyVj1g
 9qoGep6YsJ+v77voeY2jofzKx4I8lXXQ/upABCGJbrwgTcRQYckZCs8JQd2omLOT8FZvvKvkOH/
 erL8h+hKNyAaybFomdKzqOOwv3eeuwkHhi+pf0tLxJ7VZjc1Pr6Y4jp+9j2XFEhF35MkJ5/ePYd
 hye12VU5xKdZqFTAeMfkB2ZAN6uXujCSxdJjKbMSNvRhL+A2vXm/ZzQ4j2x121bdw16xe/9ZPWO
 H6Jrhik7rQrW9bkXnoKUeQLeP1bvY6wwqTrnvyi0aObpONKuMu3x4G01dpNV3KOrJxXV/JfiVwR
 /oV9MBnnUY=
X-Received: by 2002:a05:600c:33a4:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-4891abb574amr245058715e9.5.1777277282572; 
 Mon, 27 Apr 2026 01:08:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a575ad67asm391204825e9.2.2026.04.27.01.08.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:08:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 03/32] monitor: Remove MonitorDef::type field and MD_TLONG
 / MD_I32
Date: Mon, 27 Apr 2026 10:07:09 +0200
Message-ID: <20260427080738.77138-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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


