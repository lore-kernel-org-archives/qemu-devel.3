Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5177C98327
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 16:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh9Bd-00040f-1T; Sat, 17 Jan 2026 11:30:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vh9BZ-0003qh-TK
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 11:30:02 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vh9BW-0006GH-QY
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 11:30:00 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47ee301a06aso26559855e9.0
 for <qemu-devel@nongnu.org>; Sat, 17 Jan 2026 08:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768667397; x=1769272197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tTL19823FH19/6si1G6zkC5F9UNrL4PM4Uw7tbX82d8=;
 b=iWBaOWXQl6HEktbzAqv6Lza6rtMf3GZKb6zGPmurC51ZKeqjc3MVXyuZpr3fKC23Ir
 jdGJDKx1nwsY+95/iTztQARLB/eQzB1ABUYAYx0BrbXKWajdgSneRrLeMSj7qk7Kqilp
 OLVvDmchpqe8REy0gZKtvrHPpetrrNwhIM65NjQo2xwZq5HNuA/O7wqrsXHXBwuJi52M
 epsV7lt5wXBC2QvBSbA/hkxPvyQInW9teqzUwQWuk17w+95dcTxH2ZSfvzLfzlSK8aHo
 7sIhM42Vzlk+juD+o6R04Xy355vOPzllwfhkVOkbqr22F6WyPYwKohZl9ZCdEEMcfzYi
 iu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768667397; x=1769272197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tTL19823FH19/6si1G6zkC5F9UNrL4PM4Uw7tbX82d8=;
 b=AEilEee32do2vsPQBIaKZw/jICZ9O/SWrELRbuFCb4CrEPgNqCYdtvI62K+dBHlwu1
 0CKLNNcwr26AhwhZRB+xKY3HthiAk1EmwNZWvOkDKGmOM5dq/8nUMc5NF6YzB9htQSch
 DdC0aJHKiNQDH9gGnetc5BxBoRVOxDBQR8C4n8I5Ta8y2o9x57DLaIx/FNApHHQsQVnW
 YXtEmO9ExhAwYjHaOqhypuVP9aWqNmaHrGzb+0ffdmpXNipCkuttN+PX87HCO3qrHLHr
 UE1cGxarVzbd+fZkH8yHflh5Ha+EESj3UdYZEovSIqk2rhwAy7tfJFAirfOLyfrRVaxQ
 pDXw==
X-Gm-Message-State: AOJu0Yysr8j1Wvq9h6cVUG+SbpsCW3QVXBbR8Fn2XNbTRyG8pEAgDRZ3
 Cy+QySrTQ8CQXJA9A3AMOq0qk5woaON4B2faCZXQ7cSf/SFkbKcWFhZcBYxZ4wj/+9VZmDHZMUI
 NPO3LmZg=
X-Gm-Gg: AY/fxX6+Bf7KA11ZRc3grDXE2IiD2K8Q/RHKdkO+0kgUYekGBIT/sXL8wlti7yPd7EI
 ifvI91FwY3jMu1oM7JYJk7pUM4X/Y1G75edKO8adeiMNNavH4hxWPEJ4HHK2RRVTaNZSWE8FtPv
 UNgtLk4LEMe2dqacJAqLQ1uZOly/ZQKaYOL3odgo5WVfxMIk3ebzgk/eTYCXVJDnpxQurKWNYAi
 AdNVIobzdbZ2QCL1RzTGV+F9UHsYZVJCfIFFtGY49FTqNKzFwrtiKSaiCa4lR35YwrpejcJzc7o
 +bf7zXyBTzNax7zO3ZBnWDb6hheJ3gi5+aHzBW9h8Hlt2z9Vk4K5Ogwq3MOwwNPU3kT3xGBXEZ0
 Q/xD7tvZTBlhqUTPLOzIEBk+/JGmSIjgmehN2P2kV0t0yl5zxe5AhdfDHV9HCtD6InIzjUW67Ss
 RKUKS1dvRKlykneXZsbRrWoooNA87awHzDFO+fZhLKNn7wOXqCjCphaJTvFNQ+ZH4DZbeisaY=
X-Received: by 2002:a05:600c:37c8:b0:477:af07:dd21 with SMTP id
 5b1f17b1804b1-4801eb0d71cmr64769005e9.25.1768667396953; 
 Sat, 17 Jan 2026 08:29:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801ea09747sm41825295e9.7.2026.01.17.08.29.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 17 Jan 2026 08:29:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 4/8] monitor: Have MonitorDef::get_value() return an
 unsigned type
Date: Sat, 17 Jan 2026 17:29:22 +0100
Message-ID: <20260117162926.74225-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260117162926.74225-1-philmd@linaro.org>
References: <20260117162926.74225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp-target.h |  3 +--
 monitor/hmp-target.c         |  8 ++++----
 target/i386/monitor.c        |  4 ++--
 target/ppc/ppc-qmp-cmds.c    | 25 +++++++++++--------------
 target/sparc/monitor.c       |  8 ++++----
 5 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index b679aaebbff..bd9baeaa3ad 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -32,8 +32,7 @@ typedef struct MonitorDef MonitorDef;
 struct MonitorDef {
     const char *name;
     int offset;
-    target_long (*get_value)(Monitor *mon, const struct MonitorDef *md,
-                             int val);
+    uint64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int val);
     int type;
 };
 #endif
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 420969bd6eb..3fb4fb12508 100644
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
                 case MD_I32:
-                    *pval = *(int32_t *)ptr;
+                    *pval = *(uint32_t *)ptr;
                     break;
                 case MD_TLONG:
-                    *pval = *(target_long *)ptr;
+                    *pval = *(target_ulong *)ptr;
                     break;
                 default:
                     *pval = 0;
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 99b32cb7b0f..cce23f987ef 100644
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
index 73f15aa272d..3e1f4dd5c9c 100644
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
-- 
2.52.0


