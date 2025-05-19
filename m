Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5C1C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3K-0000ba-9s; Mon, 19 May 2025 00:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmf-0004jb-AZ; Mon, 19 May 2025 00:07:28 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrmd-00045J-Iu; Mon, 19 May 2025 00:07:25 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-231e8553248so18879615ad.1; 
 Sun, 18 May 2025 21:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627641; x=1748232441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yphhlPS9biEieFLOj3eoHey74pP4qWULE21z6B5e0ew=;
 b=QJSfTuQ70z6jrVWmrlXDXSYWw8hXZ75GIGYknF90Y4z6/oaG5x/T3eKct8k3+Uv55y
 cpeCKfAFJjOauRgg89UAm2XDR4Ro+SimzDAxa0wYXe/sM0UAiZPxtXV2LbYX9xuEJ5vg
 g16zIICGVg3FiDnP5EFjbdbpsDbgr9Fd4vs3BEk5jZeaEJElhqpY+WaGHvQ766dLhIy7
 SmPwr8dIaf7kWy+jpuDuCMKJ5jpWf/PQMCsJ4Oatt+GlJR8w6MRdBSkjVRgU5iGfcQP6
 rXEWKpYz582mYf2TLQuoZzhUpZ7dnP2N8b1SiuN4DBJ8DYtr/kuzb6P+0LlQG2DCrmxQ
 owgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627641; x=1748232441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yphhlPS9biEieFLOj3eoHey74pP4qWULE21z6B5e0ew=;
 b=GZCElpHRZuwxZSg9tUZUHlI/FXW6k6feaUsA4vQZsbiJHq6vcmYn1lML12LFzkEkj0
 svYMitcOap80vgal7+Gy9Sy+VJ0rvtewb+SHw0TfT08twLoY9I4jieerCDS4P9ms+qFd
 C7kJtYtjBiuQHWjMRKyD9M/t/pVmXhhW4E9LjGF5CgYPYbP5LFGcl3hcnhP4BRpnqlXo
 V64tmEpAj5OsaEpjhJEQitbdFOnBiPUPRGff0BsCwkv8dA7ay0uDLs+xyQsRxuGboxkw
 621HagDarM8+HOtbgO6661tBrADFm8y3OZX9BdGgDuFgZekzcJX5B37vw00lal5ZZ86Q
 IHqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb4Zvp7qDavlpaRFGcq5MKUjH6k+aRLT63BdwET2DZ2bFpxz8QHm5MZkCJ2TM0TQdBLIcwAeDdl69dsQ==@nongnu.org
X-Gm-Message-State: AOJu0YzKBNHv9f4OX6NdnkwWZr+1q5db7eCx6bjVxnWTxfLlTklA5NXY
 JvKMKvMenVC8FmeQeA29EQEoJlZX71V8hdqIQrtIDCWjvrFFgaRaqYUNoaEVNg==
X-Gm-Gg: ASbGncv9mK7lqrm7WFCXUwmH69VIRQpqBt0C9pqUdUC/CqGmUKiMdCwGV6UoR8gfkoN
 XNcKgpboYd14u0GAsREKL2+YqVhA1ERMKtG+NrPuoplIoKUy3CyOybHzqYN+BlXIEzTVOKchYRi
 8uNdnUtm7Yf562cQGdWgioYwvxx9Z3dGPohYS+v+0awrr+GY/rk44L2PKAY6P6v/uXNFQGQip4b
 8eLJwLNC7i+6XnO9Kmlh/Ing4juRg6x2OBlfLksNuPADjinAOwz3FKLBhzTx0Y8UUjSmeH+80FY
 U4oWg7NBhl22kVjoahee9Kb5xCrFt7Mf87MLao3hl3pLPzjkY4jjPRof/6YCyIcXqynTDhAiDhQ
 kUPkavW+ysJxjdjcxMjoamvNc+eWLOjjFr3HTJ7RD8acrwh/awmxJ2+D6
X-Google-Smtp-Source: AGHT+IF2SbYzmKD4t2kfiJHwg8vFDp1BaIPMU9eTFNos2vaxug5Vm8cSNMY2x3QhZW+oviLaXegBTg==
X-Received: by 2002:a17:903:40d0:b0:22e:847b:5bbd with SMTP id
 d9443c01a7336-231de370cebmr165048535ad.32.1747627641437; 
 Sun, 18 May 2025 21:07:21 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:07:20 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 05/56] target/riscv: pmp: fix checks on writes to pmpcfg in
 Smepmp MML mode
Date: Mon, 19 May 2025 14:05:02 +1000
Message-ID: <20250519040555.3797167-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Loïc Lefort <loic@rivosinc.com>

With Machine Mode Lockdown (mseccfg.MML) set and RLB not set, checks on pmpcfg
writes would match the wrong cases of Smepmp truth table.

The existing code allows writes for the following cases:
- L=1, X=0: cases 8, 10, 12, 14
- L=0, RWX!=WX: cases 0-2, 4-6
This leaves cases 3, 7, 9, 11, 13, 15 for which writes are ignored.

From the Smepmp specification: "Adding a rule with executable privileges that
either is M-mode-only or a locked Shared-Region is not possible (...)" This
description matches cases 9-11, 13 of the truth table.

This commit implements an explicit check for these cases by using
pmp_get_epmp_operation to convert between PMP configuration and Smepmp truth
table cases.

Signed-off-by: Loïc Lefort <loic@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-ID: <20250313193011.720075-4-loic@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/pmp.c | 79 +++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 36 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 3afa16917e..8fc313990a 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -76,6 +76,44 @@ static int pmp_is_readonly(CPURISCVState *env, uint32_t pmp_index)
     return pmp_is_locked(env, pmp_index) && !MSECCFG_RLB_ISSET(env);
 }
 
+/*
+ * Check whether `val` is an invalid Smepmp config value
+ */
+static int pmp_is_invalid_smepmp_cfg(CPURISCVState *env, uint8_t val)
+{
+    /* No check if mseccfg.MML is not set or if mseccfg.RLB is set */
+    if (!MSECCFG_MML_ISSET(env) || MSECCFG_RLB_ISSET(env)) {
+        return 0;
+    }
+
+    /*
+     * Adding a rule with executable privileges that either is M-mode-only
+     * or a locked Shared-Region is not possible
+     */
+    switch (pmp_get_smepmp_operation(val)) {
+    case 0:
+    case 1:
+    case 2:
+    case 3:
+    case 4:
+    case 5:
+    case 6:
+    case 7:
+    case 8:
+    case 12:
+    case 14:
+    case 15:
+        return 0;
+    case 9:
+    case 10:
+    case 11:
+    case 13:
+        return 1;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /*
  * Count the number of active rules.
  */
@@ -104,44 +142,13 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
 static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
 {
     if (pmp_index < MAX_RISCV_PMPS) {
-        bool readonly = true;
-
-        if (riscv_cpu_cfg(env)->ext_smepmp) {
-            /* mseccfg.RLB is set */
-            if (MSECCFG_RLB_ISSET(env)) {
-                readonly = false;
-            }
-
-            /* mseccfg.MML is not set */
-            if (!MSECCFG_MML_ISSET(env) && !pmp_is_readonly(env, pmp_index)) {
-                readonly = false;
-            }
-
-            /* mseccfg.MML is set */
-            if (MSECCFG_MML_ISSET(env)) {
-                /* not adding execute bit */
-                if ((val & PMP_LOCK) != 0 && (val & PMP_EXEC) != PMP_EXEC) {
-                    readonly = false;
-                }
-                /* shared region and not adding X bit */
-                if ((val & PMP_LOCK) != PMP_LOCK &&
-                    (val & 0x7) != (PMP_WRITE | PMP_EXEC)) {
-                    readonly = false;
-                }
-            }
-        } else {
-            readonly = pmp_is_readonly(env, pmp_index);
-        }
-
-        if (readonly) {
+        if (pmp_is_readonly(env, pmp_index)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "ignoring pmpcfg write - read only\n");
-        } else if (env->pmp_state.pmp[pmp_index].cfg_reg != val) {
-            /* If !mseccfg.MML then ignore writes with encoding RW=01 */
-            if ((val & PMP_WRITE) && !(val & PMP_READ) &&
-                !MSECCFG_MML_ISSET(env)) {
-                return false;
-            }
+        } else if (pmp_is_invalid_smepmp_cfg(env, val)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "ignoring pmpcfg write - invalid\n");
+        } else {
             env->pmp_state.pmp[pmp_index].cfg_reg = val;
             pmp_update_rule_addr(env, pmp_index);
             return true;
-- 
2.49.0


