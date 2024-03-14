Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC0FC5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 11:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkjNC-0001OO-3r; Thu, 14 Mar 2024 07:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkjMt-0001LI-Jx
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:35:29 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkjMn-0007H7-Di
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:35:27 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dee5daedf6so37915ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 04:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710416117; x=1711020917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w95im1M9b1r9dx+OwwC+H9D+z8DADQonKsqvNMhtKqw=;
 b=Wy+98mSPATXeInT920615WIoxreV8nYJru5IV3iOZ30bQAfaehv+7HLYCguEAwUztL
 tLMxXi2QSA5j55k4WdOUALJtGOVYlEKQX9XNZ8JuXQl2zLAROBwpODC5lWLvy0bMiK6h
 RLoUCD17miKkjVm9bTUjA9xeW32GnvMAwdSdgIW0Ae/gEOQXISQN7NV4Vc1NGqY1n+Mo
 8jWXEW8wQCimT7FxrnxzWiF8IrJrdzyc80YVcBJpL9RZHWG+SDrCQFoT9zIl7U1+D51j
 cdA2MkpJipMJDPm4MxfyolO+6wajYxAa3irUTtGfNmNGNj8miHR/NoxQ7wo5fR4n5Xmr
 Vw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710416117; x=1711020917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w95im1M9b1r9dx+OwwC+H9D+z8DADQonKsqvNMhtKqw=;
 b=O4ri0IjDstcxhj9ncQkPk2HtiRxC78WwpwzrKxUtrb3FfZFn6eimNF4Ohl5XLvVViV
 lofRsc7LMrXhpLDqYGwFInK/fbEpNm6gejI2GT54aIVWOtctYiZKrVcExD3sA6dx64nC
 UNLOnk6M64sNy+Daqz3Vn0/o+yadYPHpTtbQZoVTc7dmEW9lfkRpGo1AYiRRHKzVsYD3
 nsHmIC8scfS260lGoPrYgXvnwX0kugGMBjn+VQsKV0jQh/D/4Nwxl+pnlSuSbdMg+6Kb
 DpKkvrEaAbNhNK0NZ8KKPg8hH9Iu6pqRaR/xU3wksht/BNWdWdgtNnv8djwfo30hiU2d
 ZT4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWEbSzKhbDjksVwVay+x/vVJraaE2jWtkkDNbsrpinID8j8iPf/XMC6OZ5inHlf1nj0GRKRlFvLol0yrlbERyrjVu10Ug=
X-Gm-Message-State: AOJu0Yw8bvmsofAHPp2NcFdYx0ac3hRDiUAde28pPGMZCD0Dd+VW8oas
 G/9C7NsUUzQFRJWplz8MoaESRsecLk1fG2kistCRfprWAMs9zTu1wrtNTdj5MRQ=
X-Google-Smtp-Source: AGHT+IFXSnT+cB26Vobh5LUfdhAMgQ2yWqL/FIUmwHZcAS2Z4lOX3q2rqJR1WaAX9W+HlDUGcGnsYw==
X-Received: by 2002:a17:902:d501:b0:1dd:db2a:62a7 with SMTP id
 b1-20020a170902d50100b001dddb2a62a7mr1554931plg.3.1710416116615; 
 Thu, 14 Mar 2024 04:35:16 -0700 (PDT)
Received: from aryabhatta.. ([49.37.251.185]) by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001dc6f7e794dsm1465859plg.16.2024.03.14.04.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 04:35:15 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com
Subject: [PATCH v6 1/3] target/riscv: Enable mcontrol6 triggers only when
 sdtrig is selected
Date: Thu, 14 Mar 2024 17:05:08 +0530
Message-Id: <20240314113510.477862-2-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314113510.477862-1-hchauhan@ventanamicro.com>
References: <20240314113510.477862-1-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pl1-x62e.google.com
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
 target/riscv/debug.c   | 90 +++++++++++++++++++++++++-----------------
 4 files changed, 57 insertions(+), 40 deletions(-)

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
index e30d99cc2f..674223e966 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -100,13 +100,15 @@ static trigger_action_t get_trigger_action(CPURISCVState *env,
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
+        if (cfg->ext_sdtrig)
+            action = (tdata1 & TYPE6_ACTION) >> 12;
         break;
     case TRIGGER_TYPE_INST_CNT:
     case TRIGGER_TYPE_INT:
@@ -727,7 +729,12 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
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
@@ -750,9 +757,14 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
 
 target_ulong tinfo_csr_read(CPURISCVState *env)
 {
-    /* assume all triggers support the same types of triggers */
-    return BIT(TRIGGER_TYPE_AD_MATCH) |
-           BIT(TRIGGER_TYPE_AD_MATCH6);
+    target_ulong ts = 0;
+
+    ts = BIT(TRIGGER_TYPE_AD_MATCH);
+
+    if (riscv_cpu_cfg(env)->ext_sdtrig)
+        ts |= BIT(TRIGGER_TYPE_AD_MATCH6);
+
+    return ts;
 }
 
 void riscv_cpu_debug_excp_handler(CPUState *cs)
@@ -803,19 +815,21 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
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
+                    ctrl = env->tdata1[i];
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
@@ -869,27 +883,29 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
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
-- 
2.34.1


