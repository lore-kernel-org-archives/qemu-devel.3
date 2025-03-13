Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65083C35FF1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 19:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsoGa-0001yN-Bv; Thu, 13 Mar 2025 15:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tsoGB-0001qm-Tr
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 15:30:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <loic@rivosinc.com>) id 1tsoG5-0001g2-Ui
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 15:30:27 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso12505455e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 12:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741894216; x=1742499016;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O2n7JF8AZ9NmYBCXnfUnWio1/+gHcnlvYMH9yn19jrQ=;
 b=VoQiyiKb5F/wQkH9gtEc/1Sua3H8OqXZADuNSa6DuOxkzVnNxaa/60Vgeof4lplT9h
 ELfQkud42rx836TJcg7Y6IWrb2yjgc5D7wMyBFv1WDumFYpHnfDOjSWiqlmGy8TdD2/0
 D6urQEhP6PSSPM+4gJ9ILHSCfVzg4cgXnXT6f/Dw8KDH0cK/gNN3/DM3W+HOY8Q0uN8d
 rnNgVl+qHcsaU6INGjCLTTBYtYTNLuqfmWCBy2Rxvc9uN2yBpcYpbpk2gDMsE/hsJ1ZK
 P6T8YheB6HiKWlGN60RRdks0Z6gGsGmwc9LSX5OQv9IqZaXP3dOg6Bj6+wfdYSWQcyye
 ofpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741894216; x=1742499016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O2n7JF8AZ9NmYBCXnfUnWio1/+gHcnlvYMH9yn19jrQ=;
 b=nX71YuI3TpJ5VXRe6FgLk7ZVI634FJozSAOSuqz/Y6sco8B3BXSpJjL7G1OZMFIZWO
 4S39OrZ02M1t6au6+kec+uxcv0/88dsT4GeVKuTwPoTK99iZVIG1x+8VEOp64zaNOSTe
 dpJCBTQuGBvfpoB0yJJGpozwCFCPh5ZQHGwBK+UN75IAe0XXZBKhsO0TetaRSFSRrixx
 +w5vMuQNg1/mNtQ2qtUtBCb0gX+SZmzE2M8EmP8Fr5BsvQGhA8C5enidBOEDOU64M8CG
 heryvX9QgOIRqEpbuDgcrunK+1VN8targ954WO/9X2frnij9SIL/yQJezTRPaXFJ5zh5
 ys3g==
X-Gm-Message-State: AOJu0YzeBm2JVeFd83d6hOl6fzA41cwlPnSSxzgeoLXhzBDGeng5Eg7/
 krBszRCO2XYVd2c8eQEPB69YaLDJuOIqsVRot39gdaec8ljDxwL3rHZlwYN2kgCs9HjevVwymuk
 M+ufyTANF
X-Gm-Gg: ASbGnctTY/i1ZiJFJc2hCZysbp0cgT/AxQW8srtxSA1kG0NRC7kd5bUM1Yh1BFvZjR2
 cH9GsYMe577tCbOTf0uJipadmYCx9KVxVvshOCtDDEGvKa86VoSgVeArhj7WPHTZkGwAd9YUcVL
 9b6bVZZ1xfbBo3A+kRtnwhhZjvIKDhFVd860U3sheAPBQTGar/6i4dAhXzJhhS/OZn3dQIVlaID
 QoJqWtsEUni3jqZZVQLT9K+0Q0N2BgThf8DJUn9LjSPmc9amCNtQixJYjGmIUKDvKXgA+eVZPVK
 HAeZMTzGnUYLc0DlrBOh63dGegr9F3OorN1O1ou2hmzJkoHc9ZE75jaWQRsVbrSR1qlAum4Tpzk
 BDDMgux7l+VUE3a40R74=
X-Google-Smtp-Source: AGHT+IEL022FRnh1FL8l5QNgk+V7HaSw2qSS+VsXVLqZENhyOz0v3BzdNiLhVtJNQn/LrklUdjPhGg==
X-Received: by 2002:a05:600c:4b89:b0:43a:b0ac:b10c with SMTP id
 5b1f17b1804b1-43d1dd0b000mr3381725e9.26.1741894216174; 
 Thu, 13 Mar 2025 12:30:16 -0700 (PDT)
Received: from llx1.ba.rivosinc.com (lfbn-mar-1-50-94.w86-229.abo.wanadoo.fr.
 [86.229.28.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c888152dsm3016421f8f.48.2025.03.13.12.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 12:30:15 -0700 (PDT)
From: =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Lo=C3=AFc=20Lefort?= <loic@rivosinc.com>
Subject: [PATCH v2 3/5] target/riscv: pmp: fix checks on writes to pmpcfg in
 Smepmp MML mode
Date: Thu, 13 Mar 2025 20:30:09 +0100
Message-ID: <20250313193011.720075-4-loic@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313193011.720075-1-loic@rivosinc.com>
References: <20250313193011.720075-1-loic@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=loic@rivosinc.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
---
 target/riscv/pmp.c | 79 +++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 36 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 7d65dc24a5..c5f6cdaccb 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -75,6 +75,44 @@ static int pmp_is_readonly(CPURISCVState *env, uint32_t pmp_index)
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
@@ -103,44 +141,13 @@ static inline uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t pmp_index)
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
2.47.2


