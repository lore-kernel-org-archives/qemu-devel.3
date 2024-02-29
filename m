Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0DEC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 13:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfgcc-0002q0-GJ; Thu, 29 Feb 2024 08:38:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rfgcY-0002ow-9I
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:38:46 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rfgcW-0000DZ-Cy
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:38:45 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-58962bf3f89so218004a12.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 05:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709213923; x=1709818723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VYtawO62PZ7QiKIlYPihG5XQZyGfh5EpqKxdTqBdzLU=;
 b=QgopYMW2U9Lu4D0NuG0XtMQzaG8klSdIMUjERvLIT4BZ9MsiJXSeEqeooxVLI9lAht
 i4RkLdgIjjxim1/7GCPvrZ461wd0Ui1US0Pi1JF7ZIUPdppLIIQV9JF6N18C//3X6K9g
 NhQZqFhIgtZPvTVCZVuH7WQndRnUBoY0FyveVRbqa8Gmm4hAZkG5sNoMZ3ufzCu7gTMq
 BCTu/wqeKIQkR7rrNqpqXfhtQ3Zeo+FbiE+imMvs/UNHpHwcgaDFV9AWFmENDMb7KUR1
 e3VjMnQnmGJZiAF9D5S42VyU1nkccDenBQkGTywfRLw8ULeljJ2HH/Z0Lhp2uXm3Q/uV
 qphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709213923; x=1709818723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VYtawO62PZ7QiKIlYPihG5XQZyGfh5EpqKxdTqBdzLU=;
 b=uAb7qfNMLROAjd9ztVdHWYQvQLa/MJ1ggRnpI22rUz7G2wO9+R6B7D1l8XaqnRjuP1
 puQPvRgYWgnfyVO6FjrTM0pf06ZbB6MGikgsvQMqr/We5mxeJClOZw337dZIzay9PxdK
 hE3HKUazbd81Bb45O05S4XF/pCVxHdiDD/f2JLLTndQ+9eGJdP/2uhiIBZ5dspK3iO1F
 baozx/YHJrIl65AZIikumx9eD2rTf9WdTK+VGKoezj9uRZpKOjJKnEB50OqHqeBWYJkR
 Y5KvRCJoVkSi5FAD4oimvSGeEIOX7QALY3iZiGjB+KY9VZc/FJ5y6DaQbkfF2KnLrXs8
 ANhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+cgG/4yTq46R2GPtRWDKsMl39m7LkxmDoTE9ROTuyB8mJggma5KoJDeiYHeI1A6z0WL8EEFUZbjJdPMHX6zOSplP1LGI=
X-Gm-Message-State: AOJu0YwYbq3NUPxxkSYHzZ2s/otCB0WcoHC4BJcRcivYK6ZZ1U24TWIg
 1Yx7ayKxMaYoVLf0hWx6+eLWhEOfCH/ktA3/s9igEmTqds+nAoNONGm4alGKpVgfkraBXoS9wMD
 v
X-Google-Smtp-Source: AGHT+IE1VzJK5SeYe+FbitQHrcbJJs2xQp8E11za1WNfOZoQ6iRS106KFQJIpUN0sOLOTbvbiHYnbw==
X-Received: by 2002:a05:6a20:1581:b0:1a1:2d3f:c613 with SMTP id
 h1-20020a056a20158100b001a12d3fc613mr871001pzj.3.1709213922890; 
 Thu, 29 Feb 2024 05:38:42 -0800 (PST)
Received: from localhost.localdomain ([49.37.249.67])
 by smtp.gmail.com with ESMTPSA id
 g1-20020a170902fe0100b001dc941f145dsm1454918plj.253.2024.02.29.05.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 05:38:42 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [PATCH v3 1/2] target/riscv: Mark debug property as deprecated
Date: Thu, 29 Feb 2024 19:07:44 +0530
Message-Id: <20240229133745.771154-2-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229133745.771154-1-hchauhan@ventanamicro.com>
References: <20240229133745.771154-1-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The debug property implements the ratified debug specification v0.13.
This specification is superseded by (now frozen) RISC-V debug specification v1.0
It defines sdtrig ISA extension which is forward and backward comptible with
the debug specification v0.13.

This patch deprecates the debug property and replaces with ext_sdtrig.
A deprecation warning is displayed if debug property is used.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 target/riscv/cpu.c        | 37 ++++++++++++++++++++++++++++++++++---
 target/riscv/cpu_cfg.h    |  2 +-
 target/riscv/cpu_helper.c |  2 +-
 target/riscv/csr.c        |  2 +-
 target/riscv/machine.c    |  2 +-
 5 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5ff0192c52..5d5d8f0375 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -996,7 +996,7 @@ static void riscv_cpu_reset_hold(Object *obj)
     set_default_nan_mode(1, &env->fp_status);
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.ext_sdtrig) {
         riscv_trigger_reset_hold(env);
     }
 
@@ -1156,7 +1156,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     riscv_cpu_register_gdb_regs_for_features(cs);
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.ext_sdtrig) {
         riscv_trigger_realize(&cpu->env);
     }
 #endif
@@ -1718,6 +1718,37 @@ static const PropertyInfo prop_mmu = {
     .set = prop_mmu_set,
 };
 
+static void prop_debug_set(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    bool value;
+
+    warn_report("\"debug\" property is being deprecated.");
+
+    visit_type_bool(v, name, &value, errp);
+
+    if (cpu->cfg.ext_sdtrig != value && !riscv_cpu_is_dynamic(obj)) {
+        return;
+    }
+
+    cpu->cfg.ext_sdtrig = value;
+}
+
+static void prop_debug_get(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    bool value = RISCV_CPU(obj)->cfg.ext_sdtrig;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_debug = {
+    .name = "debug",
+    .get = prop_debug_get,
+    .set = prop_debug_set,
+};
+
 static void prop_pmp_set(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
@@ -2229,7 +2260,7 @@ RISCVCPUProfile *riscv_profiles[] = {
 };
 
 static Property riscv_cpu_properties[] = {
-    DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
+    {.name = "debug", .info = &prop_debug}, /* Deprecated */
 
     {.name = "pmu-mask", .info = &prop_pmu_mask},
     {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 833bf58217..9fb4ca577f 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -113,6 +113,7 @@ struct RISCVCPUConfig {
     bool ext_zvfbfwma;
     bool ext_zvfh;
     bool ext_zvfhmin;
+    bool ext_sdtrig;
     bool ext_smaia;
     bool ext_ssaia;
     bool ext_sscofpmf;
@@ -148,7 +149,6 @@ struct RISCVCPUConfig {
     uint16_t cboz_blocksize;
     bool mmu;
     bool pmp;
-    bool debug;
     bool misa_w;
 
     bool short_isa_string;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d462d95ee1..b2ad97d601 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -129,7 +129,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
              ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
     }
 
-    if (cpu->cfg.debug && !icount_enabled()) {
+    if (cpu->cfg.ext_sdtrig && !icount_enabled()) {
         flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
     }
 #endif
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index d4e8ac13b9..e60599d74e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -546,7 +546,7 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
 
 static RISCVException debug(CPURISCVState *env, int csrno)
 {
-    if (riscv_cpu_cfg(env)->debug) {
+    if (riscv_cpu_cfg(env)->ext_sdtrig) {
         return RISCV_EXCP_NONE;
     }
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 81cf22894e..1b775342d2 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -230,7 +230,7 @@ static bool debug_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
-    return cpu->cfg.debug;
+    return cpu->cfg.ext_sdtrig;
 }
 
 static int debug_post_load(void *opaque, int version_id)
-- 
2.34.1


