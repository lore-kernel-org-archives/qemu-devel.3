Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20A51093193
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3VsQ-0006zA-FK; Fri, 20 Mar 2026 05:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3VsO-0006yy-Ln
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:10:40 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3VsM-0003eb-3O
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 05:10:40 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48628ce9ab5so4449005e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 02:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773997836; x=1774602636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hK6MVq5BCRm3GyrK2RzGIife9yAh2ZpRT6sg7CANAuI=;
 b=u6y+4yJLB9T2cHSiL+SLWuNdTheZSMhkw2gDaPYL9gLvHCEsGL4NK7+V6J9LvXx9lY
 YnIqxfDH3iiMyz48myxSJzrTZ+0B7LcNaow5653w4R+1LKVpUstVSeC1p3eQKt9u5HAH
 i8zXo7Q/tQzuJfON7GLj8OhYzv04fdZXxaDmXYAuBJxwLt0xddN2JFpDa9q83FeZCfvq
 WtfUo3joF2dooSzJEIs9yEi61VZW0cj0BLeSdj3LctMskbGqk2A/dAVqAOArZlbVWULC
 iSCzj1B5qeePYmnCnl0H/CvckSvGrf5TAn96unqaE6UjG0jVniHqoH4Z7WhSGmcf/H4n
 T+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773997836; x=1774602636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hK6MVq5BCRm3GyrK2RzGIife9yAh2ZpRT6sg7CANAuI=;
 b=jH7xanpSlD2syZXX4tm3xxZX+o32hCxed6siVE8dFusUoV+e/0K/he95o10EDc9G9i
 r2BjPEoFdD/RoAi8W1Rn6yoMCd3W4TlVCZ2UmPm0sDMpDkjL11iY++r2pjt0vXYkZqzJ
 tNHv7O2pv/rcHW9F2PjOK823F/G2Ytf6d7jjqVEmp3dhDpCYyjSl3gKMKzRbCg38uf4f
 UAOv4Ln5qMeFAaqHzb5IlXGS+NCWFZN/7b9xlr8idQHDhMtbOoLgPyoDG8JA5FtTm36N
 VJsalOV+tk0yavhvuw1NeZjc1Gs4IJNvNHUfMPH/2hoVkNNnN7HTbzWfMHk/7yNZdzh/
 cLvA==
X-Gm-Message-State: AOJu0YxhxTMwo+DeZKS7W13groHfGEaxse2x9pKAfZz6WR0RdOAv2TuZ
 Wmlnhusi6ohfopG5aB4RbMUvgq9/0c5d3xz/LYkSy4J0JJNdO6zxOrdYZ9N7pmHJ/dMvgFpTTeQ
 c4Lc4Bxg=
X-Gm-Gg: ATEYQzzOzNlcz6Z9JhzwOzfiTFQm0tVfNLFHOHLfOgN1tE2LwlJNCliub54+MtdS1C+
 YXP9ookTutlSIIcyJ26r3hYAEMDo93JX6PlhshGZdsi/cMqgeYfyZnvzC2sS/lK5v087Hn9qHVf
 dhAIoWNy3LsU9iy6pwrFKflPsVppZtuUiwND1vMcaB2I8x+dgzb62OEmpzO7XTzNLJ/Z327VT5z
 Pdnb5RdIgAg5BJv9kTEysImSO5rC9iw4j8TZqEHFyA7ncC9vXtVhhIrzXOi3VNZLBVojs1uAbH5
 bKc2Ha/y3KBDVupdJbUFKB4PCCUa3sEACvps6iAP2TYcKA9ljCFP9R90kWiYQ38OCxqmeaSzF7w
 IPYEbBbQ4r5t4idhaRBOZAiH5bQtCp7P9HPRXlQDMc3NeO2A1BSBACCCkiwMn3Igfl9f5e+gXay
 JeFEBbDCqwPUt6ohyhggIKJA0uTzb1BBI1OQxlCUuL8A/sO8giK/xRhVP1VqDVjZ0DV5rHQo2Z
X-Received: by 2002:a05:600c:3f19:b0:483:badb:618e with SMTP id
 5b1f17b1804b1-486fedf70a8mr33296675e9.8.1773997835939; 
 Fri, 20 Mar 2026 02:10:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe880c21sm13404465e9.8.2026.03.20.02.10.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 02:10:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH-for-11.1 v6 2/6] monitor: Remove MonitorDef::type field and
 MD_TLONG / MD_I32
Date: Fri, 20 Mar 2026 10:10:14 +0100
Message-ID: <20260320091019.59902-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320091019.59902-1-philmd@linaro.org>
References: <20260320091019.59902-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
---
 include/monitor/hmp-target.h |  4 ----
 monitor/hmp-target.c         | 12 +-----------
 target/i386/monitor.c        |  2 +-
 target/m68k/monitor.c        | 24 ++++++++++++------------
 target/sparc/monitor.c       | 14 +++++++-------
 5 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index 5167d17d41d..56322ceddd4 100644
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


