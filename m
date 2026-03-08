Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4465F55132
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8Q4-0006tE-1N; Sun, 08 Mar 2026 03:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Q3-0006sy-1s
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:19 -0400
Received: from mail-dy1-x1344.google.com ([2607:f8b0:4864:20::1344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Q1-0001fg-Et
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:18 -0400
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2bdfd129c52so7067451eec.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954356; x=1773559156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TiAc2gpOs4pCutUIgdmQYazSr1mmoQIwHbzFJpAjzzk=;
 b=OP6gVvW7oLMDE5EN0f9DHsU5iz4l0+P+8QcdUEJm22d2j1lhyufWSUPIzcotvoZ8IP
 J9diYIH6YKHeugpMsClk31/dGfQlMT1DjOlg7nBAqrxQrDA/O8hBy1gmvxS/QN+f/Vfk
 Wm3XLEFAwypsvmOqECrqppBPk88put1KwSCUTCuKxp4kk2e/N1TIz1DDkCIcRHvDfXSi
 nVsauTUZlAxwT4mlRcdTm2+2ySLUfdl/WpsySpM79fqfGdyj9t3ph054L2ZyjTP7dVOI
 Y9KSYCnWZSTHVajU7kxrIFiKkPPfCj74BMQL7hye6xsyRWn1GUI2YoCyV1BHrcKdGhn3
 Ht9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954356; x=1773559156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TiAc2gpOs4pCutUIgdmQYazSr1mmoQIwHbzFJpAjzzk=;
 b=fWD+T2+UyKA8rHqs7G7YG6Zbj93zd/gC2s3xH80DsleOKQ/0cjiae+x8GXXltvyTVU
 Cqmxi26oStqY9rn2fvSkDTUAzJQN6BjRKSksZ++GKMDs7ITeF3wIfnDAiivr1j2WhRXL
 9KufWIQG2IlLtF0rUcQwQqZsyiaModDgtjp3bz95s7VruAa2ZZ3kFst8oJxESWla5FK2
 WqbueYZdJhjYwJiHhRfrbQbljllGxZUhO/VWJ7Ree7ne+Xkx/2wvi5OrPNEm0GiiUxpi
 WfULzxD7zTu0dlxYwO/RE8kmi6VuC6oaORGscO6AidR10iJeVlggEL+yVlzePKyBc5cY
 tdsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP9FcpE9tTLBoPl7Qd49UOxLBK/omHKScP3GG1XaHEjXZVnVYArxHql+xonV5EOMkWwf74/EHVe9Ex@nongnu.org
X-Gm-Message-State: AOJu0YxWF3XbmG3H3dTZrIZ6PlEgdfiPEKhNQTWR3BSVSVPOD2d6tmbx
 f5alIysHDhDsr6iK43I7WjYy6c+cetE10/u7Z6HgQvSH6m0Yc53EAZV3
X-Gm-Gg: ATEYQzxu4/ddz2mrIaZMWO+3gWdnBWOL3uFuBgQFzC/YBoQFyOv+OsNV+juxfFKCGLI
 +Cut+KrN97QlSc8F+/aRUUkInBtU/z1Dfz/jpkfFHDBV1cbLXB/GHu5b0Oo1c4KVjs+gkNKh+Fv
 BY40iaK8HnGstGxoebQdo5iwTZ46lyPLinyKbcGFtku2tKDUd2xiUZiTnAzHQP+SAeeRFttOQK/
 uH2CyED58YVTyBlHbHBCwROTyOXRqeE2uvjjuzkksO+XqBQoUuEtUTab+G5Pee6ZJbI7autOm+g
 S1OP4u5h8HWS7fHIwsW9xdiQrKSdY57TyeUN6Tl01I2O9s1XIY6d8mCYIdQwQz/pS4fG3sPhoVp
 yaz9mldkdiibSQ+D/2T8gnTb2KmXL8YAs/rhSfRcudj1IBZGeymdF67VR3yML0hob609w0bNJkL
 rBtAlmU+DuAVLuYymsouMf6VyQugNLsrSDWN+otjf6kiDyJPlSk2yQWOtrWbpii5vj1NKr+Dr3Z
 1IZDLNF1fz7M6VLnqLKnll+LoMk9CE3ODU0Sw==
X-Received: by 2002:a05:7301:1015:b0:2be:171c:5040 with SMTP id
 5a478bee46e88-2be4de8fca7mr2623367eec.3.1772954356001; 
 Sat, 07 Mar 2026 23:19:16 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:19:15 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 08/28] target/riscv: track the exact breakpoint trigger hit
Date: Sun,  8 Mar 2026 15:17:11 +0800
Message-ID: <ac804c0bc3b0561e45c2e2a347bd3a7da339a6ce.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1344;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1344.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Store the exact breakpoint trigger index in CPU state when a
trigger-backed CPU breakpoint matches so later debug handling can
distinguish which slot fired.

This simplifies the post-hit path because the expensive matching
work has already been done when the trigger was programmed into a
QEMU breakpoint object. By the time debug handling runs, the
matching breakpoint pointer already identifies the trigger slot,
so there is no need to re-decode the execute bits or compare the
program counter against tdata2 again. The remaining dynamic
checks are the common privilege and textra conditions, which are
still revalidated before the trigger action is taken.

This avoids collapsing all breakpoint hits into a generic stop
and lets ROM-backed Debug Mode entry preserve the original
trigger action and metadata.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/cpu.h   |  1 +
 target/riscv/debug.c | 81 +++++++++++++++++++++-----------------------
 2 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0bc14f6953..65c7b66596 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -452,6 +452,7 @@ struct CPUArchState {
     struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
     QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
     int64_t last_icount;
+    int pending_trigger_hit;
     bool itrigger_enabled;
 
     /* machine specific rdtime callback */
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 6c69c2f796..ef2fafcbef 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -558,6 +558,34 @@ static void type2_breakpoint_remove(CPURISCVState *env, target_ulong index)
     }
 }
 
+static int riscv_debug_find_breakpoint_trigger(CPUState *cs)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+    CPUBreakpoint *bp;
+
+    QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
+        if (!(bp->flags & BP_CPU) || bp->pc != env->pc) {
+            continue;
+        }
+
+        for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
+            int trigger_type = get_trigger_type(env, i);
+
+            if (!trigger_common_match(env, trigger_type, i)) {
+                continue;
+            }
+
+            if (bp == env->cpu_breakpoint[i]) {
+                env->badaddr = bp->pc;
+                return i;
+            }
+        }
+    }
+
+    return -1;
+}
+
 static void type2_reg_write(CPURISCVState *env, target_ulong index,
                             int tdata_index, target_ulong val)
 {
@@ -975,6 +1003,9 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+    int hit = env->pending_trigger_hit;
+
+    env->pending_trigger_hit = -1;
 
     /* Triggers must not match or fire while in Debug Mode. */
     if (env->debug_mode) {
@@ -986,8 +1017,11 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
             do_trigger_action(env, DBG_ACTION_BP);
         }
     } else {
-        if (cpu_breakpoint_test(cs, env->pc, BP_CPU)) {
-            do_trigger_action(env, DBG_ACTION_BP);
+        if (hit < 0) {
+            hit = riscv_debug_find_breakpoint_trigger(cs);
+        }
+        if (hit >= 0) {
+            do_trigger_action(env, hit);
         }
     }
 }
@@ -996,47 +1030,9 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-    CPUBreakpoint *bp;
-    target_ulong ctrl;
-    target_ulong pc;
-    int trigger_type;
-    int i;
-
-    QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
-        for (i = 0; i < RV_MAX_TRIGGERS; i++) {
-            trigger_type = get_trigger_type(env, i);
 
-            if (!trigger_common_match(env, trigger_type, i)) {
-                continue;
-            }
-
-            switch (trigger_type) {
-            case TRIGGER_TYPE_AD_MATCH:
-                ctrl = env->tdata1[i];
-                pc = env->tdata2[i];
-
-                if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
-                    env->badaddr = pc;
-                    return true;
-                }
-                break;
-            case TRIGGER_TYPE_AD_MATCH6:
-                ctrl = env->tdata1[i];
-                pc = env->tdata2[i];
-
-                if ((ctrl & TYPE6_EXEC) && (bp->pc == pc)) {
-                    env->badaddr = pc;
-                    return true;
-                }
-                break;
-            default:
-                /* other trigger types are not supported or irrelevant */
-                break;
-            }
-        }
-    }
-
-    return false;
+    env->pending_trigger_hit = riscv_debug_find_breakpoint_trigger(cs);
+    return env->pending_trigger_hit >= 0;
 }
 
 bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
@@ -1137,4 +1133,5 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
     }
 
     env->mcontext = 0;
+    env->pending_trigger_hit = -1;
 }
-- 
2.53.0


