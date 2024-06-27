Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA28DC30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlxp-00089Z-Vl; Thu, 27 Jun 2024 06:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxm-0007gd-PK
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:46 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlxk-0002hS-EP
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:02:46 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-25cb3f1765bso3965839fac.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482563; x=1720087363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDQcF84dre27NKrwxyR57edDUqmhHmvi6h4uP6eUGW4=;
 b=gTgh/koDtKWDZLXV3XOeA+ArnkcO7w2jGSAM8Kf+JBzQrIm1FKTJJvA0pn/OjyNuSq
 GlxgWdRXA8arVw4u0XTZ/O1PJCcBO8naPkieZRvzTcYzX463nnA+IjhZBCEWXVqVZJ7a
 sde9rRz9qcM7c3nv9p1NZOvwtsWsoPuVJnCNubIYrVtXoYjWrnfiOF0YCz/b0dn8whgE
 0gCsnlTYmRysPdl4MLi/cgc91dmEH7VKWLavgThS7tosxpJYYM6kX1/xYp8xgT1s8doh
 lV1W+aQzn4k29LtMnY9essgpo40jlz4zquXrs35iFkCPga/J1vkdcuFeyglLoTd94uID
 U03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482563; x=1720087363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cDQcF84dre27NKrwxyR57edDUqmhHmvi6h4uP6eUGW4=;
 b=f4EYStEI/SPUy/Q1lSvovZRotNPIQwrXlr1fhdjyLq1huts6UBC/nuJzo9d6t6F2Qh
 lHVNaQquUVQioHt+lzwSZ/QVNnHomLhUzfQNxYYiUYMyzXpgjf60y24LWXtiZ5uzlizQ
 Wlw8N1LGy5rJ7wUezo/gre3tqZWqY9qIgeHv/qZAQBFt6ie5p/zXbcn8HGTQcTPitKLt
 mRKqfIMrEwQANA4gYh1NqEe0KlCmTCU3C2yrY3DGnkL63KWvZxq4oClNZiVM4s6QV49W
 YzV23lIWdl6G1RIHXhPIqwFQHL0z/MZ1GuOu0wIZUmGwmeHvfYJvH0JFiv5tU6U5ausr
 TtZA==
X-Gm-Message-State: AOJu0YyXV6tlk/yOO/nDPOfIEQbZ0Wqzi+5Q5LYwx6BlutJK9Fsu0DK3
 pO4E6TUNQjVJ38gRsDTHRbiMjsnf+pHQcAKyVijvfqYF1SdwOiKQpRksnb9g
X-Google-Smtp-Source: AGHT+IHaR4uoCayL/kQbVJIxOjQmdU+U6FiaTlptZ719Vt61JO3ifSee0Yz734yodVkLat7Z6nof9g==
X-Received: by 2002:a05:6870:828b:b0:25c:c42b:5349 with SMTP id
 586e51a60fabf-25d06f021c4mr12401782fac.59.1719482562789; 
 Thu, 27 Jun 2024 03:02:42 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:02:42 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 30/32] target/riscv: Add functions for common matching
 conditions of trigger
Date: Thu, 27 Jun 2024 20:00:51 +1000
Message-ID: <20240627100053.150937-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alvin Chang <alvinga@andestech.com>

According to RISC-V Debug specification version 0.13 [1] (also applied
to version 1.0 [2] but it has not been ratified yet), there are several
common matching conditions before firing a trigger, including the
enabled privilege levels of the trigger.

This commit adds trigger_common_match() to prepare the common matching
conditions for the type 2/3/6 triggers. For now, we just implement
trigger_priv_match() to check if the enabled privilege levels of the
trigger match CPU's current privilege level.

Remove the related code in riscv_cpu_debug_check_breakpoint() and invoke
trigger_common_match() to check the privilege levels of the type 2 and
type 6 triggers for the breakpoints.

This commit also changes the behavior of looping the triggers. In
previous implementation, if we have a type 2 trigger and
env->virt_enabled is true, we directly return false to stop the loop.
Now we keep looping all the triggers until we find a matched trigger.

Only the execution bit and the executed PC should be futher checked in
riscv_cpu_debug_check_breakpoint().

[1]: https://github.com/riscv/riscv-debug-spec/releases/tag/task_group_vote
[2]: https://github.com/riscv/riscv-debug-spec/releases/tag/1.0.0-rc1-asciidoc

Signed-off-by: Alvin Chang <alvinga@andestech.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240626132247.2761286-2-alvinga@andestech.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/debug.c | 101 +++++++++++++++++++++++++++++++++----------
 1 file changed, 78 insertions(+), 23 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index b110370ea6..11125f333b 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -241,6 +241,76 @@ static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
     }
 }
 
+/*
+ * Check the privilege level of specific trigger matches CPU's current privilege
+ * level.
+ */
+static bool trigger_priv_match(CPURISCVState *env, trigger_type_t type,
+                               int trigger_index)
+{
+    target_ulong ctrl = env->tdata1[trigger_index];
+
+    switch (type) {
+    case TRIGGER_TYPE_AD_MATCH:
+        /* type 2 trigger cannot be fired in VU/VS mode */
+        if (env->virt_enabled) {
+            return false;
+        }
+        /* check U/S/M bit against current privilege level */
+        if ((ctrl >> 3) & BIT(env->priv)) {
+            return true;
+        }
+        break;
+    case TRIGGER_TYPE_AD_MATCH6:
+        if (env->virt_enabled) {
+            /* check VU/VS bit against current privilege level */
+            if ((ctrl >> 23) & BIT(env->priv)) {
+                return true;
+            }
+        } else {
+            /* check U/S/M bit against current privilege level */
+            if ((ctrl >> 3) & BIT(env->priv)) {
+                return true;
+            }
+        }
+        break;
+    case TRIGGER_TYPE_INST_CNT:
+        if (env->virt_enabled) {
+            /* check VU/VS bit against current privilege level */
+            if ((ctrl >> 25) & BIT(env->priv)) {
+                return true;
+            }
+        } else {
+            /* check U/S/M bit against current privilege level */
+            if ((ctrl >> 6) & BIT(env->priv)) {
+                return true;
+            }
+        }
+        break;
+    case TRIGGER_TYPE_INT:
+    case TRIGGER_TYPE_EXCP:
+    case TRIGGER_TYPE_EXT_SRC:
+        qemu_log_mask(LOG_UNIMP, "trigger type: %d is not supported\n", type);
+        break;
+    case TRIGGER_TYPE_NO_EXIST:
+    case TRIGGER_TYPE_UNAVAIL:
+        qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exist\n",
+                      type);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return false;
+}
+
+/* Common matching conditions for all types of the triggers. */
+static bool trigger_common_match(CPURISCVState *env, trigger_type_t type,
+                                 int trigger_index)
+{
+    return trigger_priv_match(env, type, trigger_index);
+}
+
 /* type 2 trigger */
 
 static uint32_t type2_breakpoint_size(CPURISCVState *env, target_ulong ctrl)
@@ -785,22 +855,18 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
         for (i = 0; i < RV_MAX_TRIGGERS; i++) {
             trigger_type = get_trigger_type(env, i);
 
+            if (!trigger_common_match(env, trigger_type, i)) {
+                continue;
+            }
+
             switch (trigger_type) {
             case TRIGGER_TYPE_AD_MATCH:
-                /* type 2 trigger cannot be fired in VU/VS mode */
-                if (env->virt_enabled) {
-                    return false;
-                }
-
                 ctrl = env->tdata1[i];
                 pc = env->tdata2[i];
 
                 if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
-                    /* check U/S/M bit against current privilege level */
-                    if ((ctrl >> 3) & BIT(env->priv)) {
-                        env->badaddr = pc;
-                        return true;
-                    }
+                    env->badaddr = pc;
+                    return true;
                 }
                 break;
             case TRIGGER_TYPE_AD_MATCH6:
@@ -808,19 +874,8 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
                 pc = env->tdata2[i];
 
                 if ((ctrl & TYPE6_EXEC) && (bp->pc == pc)) {
-                    if (env->virt_enabled) {
-                        /* check VU/VS bit against current privilege level */
-                        if ((ctrl >> 23) & BIT(env->priv)) {
-                            env->badaddr = pc;
-                            return true;
-                        }
-                    } else {
-                        /* check U/S/M bit against current privilege level */
-                        if ((ctrl >> 3) & BIT(env->priv)) {
-                            env->badaddr = pc;
-                            return true;
-                        }
-                    }
+                    env->badaddr = pc;
+                    return true;
                 }
                 break;
             default:
-- 
2.45.2


