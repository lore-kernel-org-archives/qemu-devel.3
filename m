Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB658C54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 06:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkHpC-0000YM-5Q; Wed, 13 Mar 2024 02:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkHot-0000Ut-1B
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:10:32 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkHog-0008QR-VT
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:10:24 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-29c5fb12dc5so15047a91.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 23:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710310217; x=1710915017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xz3w+mDWMDgJw9nQRW0HwoHzHRFLsNnJGM8gyyh7lkw=;
 b=l+go3+XVHTTTijkO7hyOoex6emW/x1QuwdgoPUdO3OkeLPqSYmHp40f4j9B/MfzJLD
 iWSrZerXUzChL/6a4VBTR43Hh42y5B7syi3l8NRx0uq9D5T/5IaS5Q7A1beiS8W1+Mod
 idGzwBIY4eACFlobWQekmJXRQdiiVN+3p5Z85tHW3fz2QUK+1ptAiZe2pfT/9z5VbGNF
 vgceukcuj+FZCobBVTCYVvQWjqyiA9F1ZHZdLD2XgS1KCVuQSimD3Lv7sL+eT/Ba3icL
 8efSKOdv/ox2CzdN+4NFTqRcgVOWFzlb2hvBSCDZQOvXpx5fppJoSmtEzC4UgjQspvYv
 8qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710310217; x=1710915017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xz3w+mDWMDgJw9nQRW0HwoHzHRFLsNnJGM8gyyh7lkw=;
 b=uVI2rP/8wlO6i3VtghsRCSVAAqYC73l7kC2wI0bwdjvdxF2VmbNMy4e4OOxnOHWB9u
 QGuG1LRVklrrQUMpDzR/gltVMOrNAgQwFTK0tQbnIiziDyNe+ziMisDYyE8+5u9QcWn5
 P3Caw7d3HcmIm17UT2U8AmDZbTADoUp9cUdQRGL2ulVvRCcog5mM9qIrQtcoZzI0G0Hr
 M30kXxl+cQGDcAgRz+Kl3qOM9lR+L6h6C2xbpTaeAkwT0t6EBhuQJ1q973CuJ1qlHrhp
 /QRmPskMMYVZeI9PAqb1XMH0irf0QEaMhlO6rPE9JDEfXd8iH2vXF31xzt/RbQcGstgH
 Nq6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT6GnZyhJu1kI/fOQy31+AT9oGtz+IaL+pV+QqA7DFPQ59DAcZQMfWdefXnlXf4W4diuCkhSAWtFvXbY3kkugMgMxXaXA=
X-Gm-Message-State: AOJu0YyW6xnxC53AdKucierBEk87PSDZtSlZP5aPvB2zWglA8YREplw9
 ZXfJtdCZe5y9SDHDbympY15JDipYCx3vM0bw5qFOm4x8maq34oP66lWkqPLBC/PtB4EoIQ//sXT
 l
X-Google-Smtp-Source: AGHT+IE+cmomPnadAVMRQTvKY33qRoYXpC7rlSSlU/rduHW3isJVUtCXA5FNPRGvc3prfbtSj1Afdw==
X-Received: by 2002:a17:902:e88a:b0:1dd:667f:bf1b with SMTP id
 w10-20020a170902e88a00b001dd667fbf1bmr723048plg.0.1710310216738; 
 Tue, 12 Mar 2024 23:10:16 -0700 (PDT)
Received: from localhost.localdomain ([106.51.83.242])
 by smtp.gmail.com with ESMTPSA id
 kj14-20020a17090306ce00b001dd3bc79142sm7755402plb.264.2024.03.12.23.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 23:10:16 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 1/3] target/riscv: Enable mcontrol6 triggers only when
 sdtrig is selected
Date: Wed, 13 Mar 2024 11:39:29 +0530
Message-Id: <20240313060931.242161-2-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313060931.242161-1-hchauhan@ventanamicro.com>
References: <20240313060931.242161-1-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pj1-x102f.google.com
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

The mcontrol6 triggers are not defined in debug specification v0.13
These triggers are defined in sdtrig ISA extension.

This patch:
   * Adds ext_sdtrig capability which is used to select mcontrol6 triggers
   * Keeps the debug property. All triggers that are defined in v0.13 are
     exposed.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 target/riscv/cpu.c     |  4 +-
 target/riscv/cpu_cfg.h |  1 +
 target/riscv/csr.c     |  2 +-
 target/riscv/debug.c   | 92 +++++++++++++++++++++++++-----------------
 target/riscv/machine.c |  2 +-
 5 files changed, 60 insertions(+), 41 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c160b9216b..2602aae9f5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1008,7 +1008,7 @@ static void riscv_cpu_reset_hold(Object *obj)
     set_default_nan_mode(1, &env->fp_status);
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
         riscv_trigger_reset_hold(env);
     }
 
@@ -1168,7 +1168,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     riscv_cpu_register_gdb_regs_for_features(cs);
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
         riscv_trigger_realize(&cpu->env);
     }
 #endif
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2040b90da0..0c57e1acd4 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -114,6 +114,7 @@ struct RISCVCPUConfig {
     bool ext_zvfbfwma;
     bool ext_zvfh;
     bool ext_zvfhmin;
+    bool ext_sdtrig;
     bool ext_smaia;
     bool ext_ssaia;
     bool ext_sscofpmf;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 726096444f..26623d3640 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -546,7 +546,7 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
 
 static RISCVException debug(CPURISCVState *env, int csrno)
 {
-    if (riscv_cpu_cfg(env)->debug) {
+    if (riscv_cpu_cfg(env)->debug || riscv_cpu_cfg(env)->ext_sdtrig) {
         return RISCV_EXCP_NONE;
     }
 
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index e30d99cc2f..c6a92ba0f7 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -100,13 +100,16 @@ static trigger_action_t get_trigger_action(CPURISCVState *env,
     target_ulong tdata1 = env->tdata1[trigger_index];
     int trigger_type = get_trigger_type(env, trigger_index);
     trigger_action_t action = DBG_ACTION_NONE;
+    const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
 
     switch (trigger_type) {
     case TRIGGER_TYPE_AD_MATCH:
         action = (tdata1 & TYPE2_ACTION) >> 12;
         break;
     case TRIGGER_TYPE_AD_MATCH6:
-        action = (tdata1 & TYPE6_ACTION) >> 12;
+        /* Only sdtrig ISA extension supports type 6 match */
+        if (cfg->ext_sdtrig)
+            action = (tdata1 & TYPE6_ACTION) >> 12;
         break;
     case TRIGGER_TYPE_INST_CNT:
     case TRIGGER_TYPE_INT:
@@ -727,7 +730,12 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
         type2_reg_write(env, env->trigger_cur, tdata_index, val);
         break;
     case TRIGGER_TYPE_AD_MATCH6:
-        type6_reg_write(env, env->trigger_cur, tdata_index, val);
+        if (riscv_cpu_cfg(env)->ext_sdtrig) {
+            type6_reg_write(env, env->trigger_cur, tdata_index, val);
+        } else {
+            qemu_log_mask(LOG_UNIMP, "trigger type: %d is not supported\n",
+                          trigger_type);
+        }
         break;
     case TRIGGER_TYPE_INST_CNT:
         itrigger_reg_write(env, env->trigger_cur, tdata_index, val);
@@ -750,9 +758,15 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
 
 target_ulong tinfo_csr_read(CPURISCVState *env)
 {
-    /* assume all triggers support the same types of triggers */
-    return BIT(TRIGGER_TYPE_AD_MATCH) |
-           BIT(TRIGGER_TYPE_AD_MATCH6);
+    target_ulong ts = 0;
+
+    ts = BIT(TRIGGER_TYPE_AD_MATCH);
+
+    /* sdtrig ISA extension supports type 6 match */
+    if (riscv_cpu_cfg(env)->ext_sdtrig)
+        ts |= BIT(TRIGGER_TYPE_AD_MATCH6);
+
+    return ts;
 }
 
 void riscv_cpu_debug_excp_handler(CPUState *cs)
@@ -803,19 +817,21 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
                 }
                 break;
             case TRIGGER_TYPE_AD_MATCH6:
-                ctrl = env->tdata1[i];
-                pc = env->tdata2[i];
-
-                if ((ctrl & TYPE6_EXEC) && (bp->pc == pc)) {
-                    if (env->virt_enabled) {
-                        /* check VU/VS bit against current privilege level */
-                        if ((ctrl >> 23) & BIT(env->priv)) {
-                            return true;
-                        }
-                    } else {
-                        /* check U/S/M bit against current privilege level */
-                        if ((ctrl >> 3) & BIT(env->priv)) {
-                            return true;
+                if (cpu->cfg.ext_sdtrig) {
+                   ctrl = env->tdata1[i];
+                    pc = env->tdata2[i];
+
+                    if ((ctrl & TYPE6_EXEC) && (bp->pc == pc)) {
+                        if (env->virt_enabled) {
+                            /* check VU/VS bit against current privilege level */
+                            if ((ctrl >> 23) & BIT(env->priv)) {
+                                return true;
+                            }
+                        } else {
+                            /* check U/S/M bit against current privilege level */
+                            if ((ctrl >> 3) & BIT(env->priv)) {
+                                return true;
+                            }
                         }
                     }
                 }
@@ -869,27 +885,29 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
             }
             break;
         case TRIGGER_TYPE_AD_MATCH6:
-            ctrl = env->tdata1[i];
-            addr = env->tdata2[i];
-            flags = 0;
+            if (cpu->cfg.ext_sdtrig) {
+                ctrl = env->tdata1[i];
+                addr = env->tdata2[i];
+                flags = 0;
 
-            if (ctrl & TYPE6_LOAD) {
-                flags |= BP_MEM_READ;
-            }
-            if (ctrl & TYPE6_STORE) {
-                flags |= BP_MEM_WRITE;
-            }
+                if (ctrl & TYPE6_LOAD) {
+                    flags |= BP_MEM_READ;
+                }
+                if (ctrl & TYPE6_STORE) {
+                    flags |= BP_MEM_WRITE;
+                }
 
-            if ((wp->flags & flags) && (wp->vaddr == addr)) {
-                if (env->virt_enabled) {
-                    /* check VU/VS bit against current privilege level */
-                    if ((ctrl >> 23) & BIT(env->priv)) {
-                        return true;
-                    }
-                } else {
-                    /* check U/S/M bit against current privilege level */
-                    if ((ctrl >> 3) & BIT(env->priv)) {
-                        return true;
+                if ((wp->flags & flags) && (wp->vaddr == addr)) {
+                    if (env->virt_enabled) {
+                        /* check VU/VS bit against current privilege level */
+                        if ((ctrl >> 23) & BIT(env->priv)) {
+                            return true;
+                        }
+                    } else {
+                        /* check U/S/M bit against current privilege level */
+                        if ((ctrl >> 3) & BIT(env->priv)) {
+                            return true;
+                        }
                     }
                 }
             }
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 76f2150f78..1cb8656191 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -230,7 +230,7 @@ static bool debug_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
-    return cpu->cfg.debug;
+    return (cpu->cfg.debug || cpu->cfg.ext_sdtrig);
 }
 
 static int debug_post_load(void *opaque, int version_id)
-- 
2.34.1


