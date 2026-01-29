Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C239FD6B09D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlV5B-0000xv-Q8; Thu, 29 Jan 2026 11:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV58-0000vC-3c
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:41:23 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlV54-0005EZ-3Q
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:41:21 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso10738345e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769704875; x=1770309675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7onpzEg5oFF81Cr9JNPbzUwDH4GaGSfQFJXvSw5++8=;
 b=fJjlxiTRewpRQgXskZ0pf4WljIYUslMD0BraJt1rbuKI01oSu4YO4xoStjCuL/wULF
 S6VJVS04MC1XWGr5H0rtoPLvz358kCRZ41hW/aWDo00S5EztKPxkHO3xFyXluLpChtqf
 yvKFLLDbYM9Ex1S/gm6Scqtn8tQhfgGw0J5TnvctK2cGoo/0v0OZvz9IV7YCEIk6JXOU
 FNTIpuwwj1OFvo+qZsvNX5+/zmMF3G2c0VXmy6Wf4YLcaGOvVXRUaA/J4rx88jgDPmsc
 aLm6fR4Hkk2byBPEmUiSiSxHvLQvpECQVKMMvaFntW/4TtuXovNoLCykpIa7CXCt7HQJ
 aUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769704875; x=1770309675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D7onpzEg5oFF81Cr9JNPbzUwDH4GaGSfQFJXvSw5++8=;
 b=evN3eJzmJtt4I3tBH80VOQ3xzHGbGfu7wxMNEx4jOJb+MmQXoKG/F94+BuaMQx7SDX
 TeHuPt+Df+kbcNBLo20ldvPUPjyHdI33r6j/cNem72OycTvVpUxO1RkQxjKw3NbLcQ/w
 z23/4eyDKUuE1yi6UQRfS/3Aa4LpzS+O8srYXH4c4qrbMyl/7sD0Lx6q9UMF+XHefMBs
 iUZ5QTxwebf1rM8PCxAw0PdLhnxELdioqL71tqcuLcHX9eobA9itQa5mHoetv2xI25Yo
 N/WHc6V4p1YeGxrogEZe1DzYIAMccM/Wrs7xiaumb6Zwj48njk05UJbmtM5xn1+UlH10
 P+qg==
X-Gm-Message-State: AOJu0YzHv90T3jv/2e3zS79wpPLI2HWzRfzXcnLKO5x8zbDO1hN5kmOS
 Vr7hO53GxwR8Mnyt9edSLooJJzHPRavq1RuZkbgCv3MZoMOLaF+rtXZbRDt+sipn4mLDLJh4uQv
 WfM8kHtw=
X-Gm-Gg: AZuq6aIUe/14zp20a2cJaKj44zsK8uqJc0RwSEHspfJRALyVflzEbscMrbl+53iHagu
 6/PLsjeV7xjh5i4YGivQGvsmc1ptUfXJVhsNnlj0eBzgmK7OErnA1gUONMux/sXItLAwdLS4fHZ
 i1WXjJ7f7eYd6QHxMPPdlI/2G7KC8fA4G4MsH7Ub2CJJpEMHuMofVGvQCjbP/jsfmimw+hzmK1S
 xTEm37r4gCCu9CM23MAwLAWN22pMabfPc3A/Q2TGYax8nYtdpYfmbW4ZBPxX8DigfFCeqiuhhLZ
 d6x8Dt2bGhQ0JH/c276mPcTgMESEGcIneMgh12LOvv1wrJeE0Iuyx6ANk4lIQVp4aib41EBo63a
 zkPOdckM7jJagvV8uwQoSK1KnaJV9yfQAe+Yq6vo6NBif2S8/2Sr+1er27Kft6iArBARjiJQsl+
 MGj2RbwlhkmQjYcVJzKhlm87ru8iBEnEmgFXcMCVCSvlGO/L6rair4iOp9zecb
X-Received: by 2002:a05:600c:a10b:b0:47d:52ef:c572 with SMTP id
 5b1f17b1804b1-480828745e6mr40202315e9.1.1769704874775; 
 Thu, 29 Jan 2026 08:41:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cde00e8sm146475515e9.6.2026.01.29.08.41.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jan 2026 08:41:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Subject: [PATCH v5 5/9] monitor: Have MonitorDef::get_value() return an
 unsigned type
Date: Thu, 29 Jan 2026 17:40:34 +0100
Message-ID: <20260129164039.58472-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129164039.58472-1-philmd@linaro.org>
References: <20260129164039.58472-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All implementations of the get_value() handler return an
unsigned type:

- target/i386/monitor.c

  monitor_get_pc() -> target_ulong eip;

- target/ppc/ppc-qmp-cmds.c

  monitor_get_ccr() -> uint64_t ppc_get_cr(const CPUPPCState *env);

  monitor_get_xer() -> target_ulong cpu_read_xer(const CPUPPCState *env);

  monitor_get_decr() -> target_ulong cpu_ppc_load_decr(CPUPPCState *env);

  monitor_get_tbu() -> uint32_t cpu_ppc_load_tbu(CPUPPCState *env);

  monitor_get_tbl() -> uint64_t cpu_ppc_load_tbl(CPUPPCState *env);

- target/sparc/monitor.c

  monitor_get_psr() -> target_ulong cpu_get_psr(CPUSPARCState *env1);

  monitor_get_reg() -> target_ulong *regwptr;

Convert the MonitorDef::get_value() handler to return unsigned.

Rename the MD_I32/MD_TLONG definitions mechanically doing:

 $ sed -i -e s/MD_I32/MD_U32/g $(git grep -lw MD_I32)
 $ sed -i -e s/MD_TLONG/MD_TULONG/g $(git grep -lw MD_TLONG)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 include/monitor/hmp-target.h |  7 ++---
 monitor/hmp-target.c         | 12 ++++----
 target/i386/monitor.c        |  8 ++---
 target/m68k/monitor.c        | 60 ++++++++++++++++++------------------
 target/ppc/ppc-qmp-cmds.c    | 25 +++++++--------
 target/sparc/monitor.c       | 10 +++---
 6 files changed, 59 insertions(+), 63 deletions(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index 5167d17d41d..6d6653aee6e 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -32,14 +32,13 @@ typedef struct MonitorDef MonitorDef;
 struct MonitorDef {
     const char *name;
     int offset;
-    target_long (*get_value)(Monitor *mon, const struct MonitorDef *md,
-                             int val);
+    uint64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int val);
     int type;
 };
 #endif
 
-#define MD_TLONG 0
-#define MD_I32   1
+#define MD_TULONG 0
+#define MD_U32    1
 
 const MonitorDef *target_monitor_defs(void);
 int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 420969bd6eb..1600666ee92 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -67,7 +67,6 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
 {
     const MonitorDef *md = target_monitor_defs();
     CPUState *cs = mon_get_cpu(mon);
-    void *ptr;
     uint64_t tmp = 0;
     int ret;
 
@@ -81,13 +80,14 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
                 *pval = md->get_value(mon, md, md->offset);
             } else {
                 CPUArchState *env = mon_get_cpu_env(mon);
-                ptr = (uint8_t *)env + md->offset;
+                void *ptr = (uint8_t *)env + md->offset;
+
                 switch(md->type) {
-                case MD_I32:
-                    *pval = *(int32_t *)ptr;
+                case MD_U32:
+                    *pval = *(uint32_t *)ptr;
                     break;
-                case MD_TLONG:
-                    *pval = *(target_long *)ptr;
+                case MD_TULONG:
+                    *pval = *(target_ulong *)ptr;
                     break;
                 default:
                     *pval = 0;
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 99b32cb7b0f..427f1990399 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -593,8 +593,8 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
     }
 }
 
-static target_long monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
-                                  int val)
+static uint64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
+                               int val)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
     return env->eip + env->segs[R_CS].base;
@@ -602,9 +602,9 @@ static target_long monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
 
 const MonitorDef monitor_defs[] = {
 #define SEG(name, seg) \
-    { name, offsetof(CPUX86State, segs[seg].selector), NULL, MD_I32 },\
+    { name, offsetof(CPUX86State, segs[seg].selector), NULL, MD_U32 },\
     { name ".base", offsetof(CPUX86State, segs[seg].base) },\
-    { name ".limit", offsetof(CPUX86State, segs[seg].limit), NULL, MD_I32 },
+    { name ".limit", offsetof(CPUX86State, segs[seg].limit), NULL, MD_U32 },
 
     { "eax", offsetof(CPUX86State, regs[0]) },
     { "ecx", offsetof(CPUX86State, regs[1]) },
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 6d101c75df0..1bb5012da91 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -24,36 +24,36 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 }
 
 static const MonitorDef monitor_defs[] = {
-    { "d0", offsetof(CPUM68KState, dregs[0]), NULL, MD_I32 },
-    { "d1", offsetof(CPUM68KState, dregs[1]), NULL, MD_I32 },
-    { "d2", offsetof(CPUM68KState, dregs[2]), NULL, MD_I32 },
-    { "d3", offsetof(CPUM68KState, dregs[3]), NULL, MD_I32 },
-    { "d4", offsetof(CPUM68KState, dregs[4]), NULL, MD_I32 },
-    { "d5", offsetof(CPUM68KState, dregs[5]), NULL, MD_I32 },
-    { "d6", offsetof(CPUM68KState, dregs[6]), NULL, MD_I32 },
-    { "d7", offsetof(CPUM68KState, dregs[7]), NULL, MD_I32 },
-    { "a0", offsetof(CPUM68KState, aregs[0]), NULL, MD_I32 },
-    { "a1", offsetof(CPUM68KState, aregs[1]), NULL, MD_I32 },
-    { "a2", offsetof(CPUM68KState, aregs[2]), NULL, MD_I32 },
-    { "a3", offsetof(CPUM68KState, aregs[3]), NULL, MD_I32 },
-    { "a4", offsetof(CPUM68KState, aregs[4]), NULL, MD_I32 },
-    { "a5", offsetof(CPUM68KState, aregs[5]), NULL, MD_I32 },
-    { "a6", offsetof(CPUM68KState, aregs[6]), NULL, MD_I32 },
-    { "a7", offsetof(CPUM68KState, aregs[7]), NULL, MD_I32 },
-    { "pc", offsetof(CPUM68KState, pc), NULL, MD_I32 },
-    { "sr", offsetof(CPUM68KState, sr), NULL, MD_I32 },
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
+    { "d0", offsetof(CPUM68KState, dregs[0]), NULL, MD_U32 },
+    { "d1", offsetof(CPUM68KState, dregs[1]), NULL, MD_U32 },
+    { "d2", offsetof(CPUM68KState, dregs[2]), NULL, MD_U32 },
+    { "d3", offsetof(CPUM68KState, dregs[3]), NULL, MD_U32 },
+    { "d4", offsetof(CPUM68KState, dregs[4]), NULL, MD_U32 },
+    { "d5", offsetof(CPUM68KState, dregs[5]), NULL, MD_U32 },
+    { "d6", offsetof(CPUM68KState, dregs[6]), NULL, MD_U32 },
+    { "d7", offsetof(CPUM68KState, dregs[7]), NULL, MD_U32 },
+    { "a0", offsetof(CPUM68KState, aregs[0]), NULL, MD_U32 },
+    { "a1", offsetof(CPUM68KState, aregs[1]), NULL, MD_U32 },
+    { "a2", offsetof(CPUM68KState, aregs[2]), NULL, MD_U32 },
+    { "a3", offsetof(CPUM68KState, aregs[3]), NULL, MD_U32 },
+    { "a4", offsetof(CPUM68KState, aregs[4]), NULL, MD_U32 },
+    { "a5", offsetof(CPUM68KState, aregs[5]), NULL, MD_U32 },
+    { "a6", offsetof(CPUM68KState, aregs[6]), NULL, MD_U32 },
+    { "a7", offsetof(CPUM68KState, aregs[7]), NULL, MD_U32 },
+    { "pc", offsetof(CPUM68KState, pc), NULL, MD_U32 },
+    { "sr", offsetof(CPUM68KState, sr), NULL, MD_U32 },
+    { "ssp", offsetof(CPUM68KState, sp[0]), NULL, MD_U32 },
+    { "usp", offsetof(CPUM68KState, sp[1]), NULL, MD_U32 },
+    { "isp", offsetof(CPUM68KState, sp[2]), NULL, MD_U32 },
+    { "sfc", offsetof(CPUM68KState, sfc), NULL, MD_U32 },
+    { "dfc", offsetof(CPUM68KState, dfc), NULL, MD_U32 },
+    { "urp", offsetof(CPUM68KState, mmu.urp), NULL, MD_U32 },
+    { "srp", offsetof(CPUM68KState, mmu.srp), NULL, MD_U32 },
+    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]), NULL, MD_U32 },
+    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]), NULL, MD_U32 },
+    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]), NULL, MD_U32 },
+    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]), NULL, MD_U32 },
+    { "mmusr", offsetof(CPUM68KState, mmu.mmusr), NULL, MD_U32 },
     { NULL },
 };
 
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index 7022564604f..07938abb15f 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -33,26 +33,23 @@
 #include "cpu-models.h"
 #include "cpu-qom.h"
 
-static target_long monitor_get_ccr(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
+static uint64_t monitor_get_ccr(Monitor *mon, const struct MonitorDef *md,
+                               int val)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
-    unsigned int u;
 
-    u = ppc_get_cr(env);
-
-    return u;
+    return ppc_get_cr(env);
 }
 
-static target_long monitor_get_xer(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
+static uint64_t monitor_get_xer(Monitor *mon, const struct MonitorDef *md,
+                                int val)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
     return cpu_read_xer(env);
 }
 
-static target_long monitor_get_decr(Monitor *mon, const struct MonitorDef *md,
-                                    int val)
+static uint64_t monitor_get_decr(Monitor *mon, const struct MonitorDef *md,
+                                 int val)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
     if (!env->tb_env) {
@@ -61,8 +58,8 @@ static target_long monitor_get_decr(Monitor *mon, const struct MonitorDef *md,
     return cpu_ppc_load_decr(env);
 }
 
-static target_long monitor_get_tbu(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
+static uint64_t monitor_get_tbu(Monitor *mon, const struct MonitorDef *md,
+                                int val)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
     if (!env->tb_env) {
@@ -71,8 +68,8 @@ static target_long monitor_get_tbu(Monitor *mon, const struct MonitorDef *md,
     return cpu_ppc_load_tbu(env);
 }
 
-static target_long monitor_get_tbl(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
+static uint64_t monitor_get_tbl(Monitor *mon, const struct MonitorDef *md,
+                                int val)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
     if (!env->tb_env) {
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 73f15aa272d..378967f8164 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -40,8 +40,8 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 }
 
 #ifndef TARGET_SPARC64
-static target_long monitor_get_psr(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
+static uint64_t monitor_get_psr(Monitor *mon, const struct MonitorDef *md,
+                                int val)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
 
@@ -49,8 +49,8 @@ static target_long monitor_get_psr(Monitor *mon, const struct MonitorDef *md,
 }
 #endif
 
-static target_long monitor_get_reg(Monitor *mon, const struct MonitorDef *md,
-                                   int val)
+static uint64_t monitor_get_reg(Monitor *mon, const struct MonitorDef *md,
+                                int val)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
     return env->regwptr[val];
@@ -154,7 +154,7 @@ const MonitorDef monitor_defs[] = {
     { "otherwin", offsetof(CPUSPARCState, otherwin) },
     { "wstate", offsetof(CPUSPARCState, wstate) },
     { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
-    { "fprs", offsetof(CPUSPARCState, fprs), NULL, MD_I32 },
+    { "fprs", offsetof(CPUSPARCState, fprs), NULL, MD_U32 },
 #endif
     { NULL },
 };
-- 
2.52.0


