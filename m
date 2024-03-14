Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B51C54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 19:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkqJN-0000tz-IY; Thu, 14 Mar 2024 15:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkqJG-0000rv-PU
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 15:00:11 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkqJD-0001Ad-Vu
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 15:00:10 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e6c38be762so305941b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 12:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710442806; x=1711047606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWmALFGWJKqYhXbwjbmytVpu9a+2H7aO4i8AojXFIjw=;
 b=DUsFJfmGGKRBJo/p60TZc6/fURYfb/9UjYArEZvy4AQm1eXTnc5N4NkzPVd99ov+8F
 qloCwZnueSO5OhPN3bo7gA3N+d9KE8ZC013ON6f2VjoewRscySfNM6+rFLB+Dbta3yXz
 lgr9YSb0vxPLGI9IyFUvASLMqHRzkSRzBp1WulBNfgYIVj++Rxzp3ocSWeMaCkJxNwtB
 nrryBXYMpUdN3ZYXRUtasc4xZUSOWXOURYfyqI2OE96Yr2kyJI9wjZUW6KQeHv+t99vA
 ChejBJJbl+CSFp0zAamhXdiWRjUwLo3H8yxYVvGlCh2+TdGHv2H9IOJceIUi5+ZxvWZ8
 sg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710442806; x=1711047606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWmALFGWJKqYhXbwjbmytVpu9a+2H7aO4i8AojXFIjw=;
 b=rqUoRLzC5xHxssryZ7zn/Uspgea5uXXatBQxcIOxqzwEFN8QMuRmTz0HQDzUjfJ6pD
 oqqXhjgR7GNy4gwfUg/84zcBp5SdgYPPq0H8RgRYa0Ayw8qYnfWAvFW/YlV7iCsHoBjK
 XRVv5LfwlalxKIxS4hR/XuVTOI5jH74GpfNVJJWWH+mIcVJQs4WrCqhQCHcRNJ63AXXU
 +9uQY0Ksp8K6onycEW+7l5tOCoVp3mb2PF28iEZD+fTgL4FyZoOo9teysht885MoA0t9
 UFGVFPBD9ip8qj8Ae0WHu8Uob/KsNdm+cY3Rm6GkdRMEM+NH71q5KKs02KoT41+nC33E
 4Cvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5q6DD1N+0iuXVqgNkahgO+qtoJzKzseVLLYyKZ4E8FMzIzobZxdxFyfy3knOPtbgHr51ARoisgBLNkAKsOqmHDBDZuwU=
X-Gm-Message-State: AOJu0YzAz0WVH5JrBLd2etZM7V7ZEvgtRTj9UdqcYNq8wdcQxdirLdD0
 nwGPrqp34kQ9852cYJkyFKteCCPu2fBLg8kpJfryQT+rH7KdrupjGOBznn0nSMY=
X-Google-Smtp-Source: AGHT+IEmklMbPNblmgYzog+waxoaGUxpVNb092swQ+ts2Nq7ARiS94SzzW0hVBUStxwerJFJMq30zg==
X-Received: by 2002:a05:6a20:958c:b0:1a1:7528:b45e with SMTP id
 iu12-20020a056a20958c00b001a17528b45emr3328579pzb.3.1710442805833; 
 Thu, 14 Mar 2024 12:00:05 -0700 (PDT)
Received: from aryabhatta.. ([49.37.251.185]) by smtp.gmail.com with ESMTPSA id
 e8-20020a170902784800b001dd1096e365sm2105732pln.281.2024.03.14.12.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 12:00:05 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com
Subject: [PATCH v7 2/4] target/riscv: Enable mcontrol6 triggers only when
 sdtrig is selected
Date: Fri, 15 Mar 2024 00:29:55 +0530
Message-Id: <20240314185957.36940-3-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314185957.36940-1-hchauhan@ventanamicro.com>
References: <20240314185957.36940-1-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pf1-x42d.google.com
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
 target/riscv/cpu.c     |  5 +++++
 target/riscv/cpu_cfg.h |  1 +
 target/riscv/debug.c   | 30 +++++++++++++++++++++++++-----
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c160b9216b..ab631500ac 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1008,6 +1008,11 @@ static void riscv_cpu_reset_hold(Object *obj)
     set_default_nan_mode(1, &env->fp_status);
 
 #ifndef CONFIG_USER_ONLY
+    if (!cpu->cfg.debug && cpu->cfg.ext_sdtrig) {
+        warn_report("Enabling 'debug' since 'sdtrig' is enabled.");
+        cpu->cfg.debug = true;
+    }
+
     if (cpu->cfg.debug) {
         riscv_trigger_reset_hold(env);
     }
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
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 5f14b39b06..c40e727e12 100644
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
+        if (cfg->ext_sdtrig) {
+            action = (tdata1 & TYPE6_ACTION) >> 12;
+        }
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
@@ -750,9 +758,13 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
 
 target_ulong tinfo_csr_read(CPURISCVState *env)
 {
-    /* assume all triggers support the same types of triggers */
-    return BIT(TRIGGER_TYPE_AD_MATCH) |
-           BIT(TRIGGER_TYPE_AD_MATCH6);
+    target_ulong ts = BIT(TRIGGER_TYPE_AD_MATCH);
+
+    if (riscv_cpu_cfg(env)->ext_sdtrig) {
+        ts |= BIT(TRIGGER_TYPE_AD_MATCH6);
+    }
+
+    return ts;
 }
 
 void riscv_cpu_debug_excp_handler(CPUState *cs)
@@ -803,6 +815,10 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
                 }
                 break;
             case TRIGGER_TYPE_AD_MATCH6:
+                if (!cpu->cfg.ext_sdtrig) {
+                    break;
+                }
+
                 ctrl = env->tdata1[i];
                 pc = env->tdata2[i];
 
@@ -869,6 +885,10 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
             }
             break;
         case TRIGGER_TYPE_AD_MATCH6:
+            if (!cpu->cfg.ext_sdtrig) {
+                break;
+            }
+
             ctrl = env->tdata1[i];
             addr = env->tdata2[i];
             flags = 0;
-- 
2.34.1


