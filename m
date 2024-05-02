Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE59C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 05:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2PFE-0008Om-AG; Thu, 02 May 2024 01:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PF7-0008Mc-U7
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:29 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2PF1-0002bY-D1
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:44:28 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f43ee95078so28285b3a.1
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 22:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714628662; x=1715233462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvsEkhTyf169sgF1OovUL2phPwJdfZB/cbb8N0Y+skM=;
 b=rU4Ga/SVeG7LO0tdfNSL/A8iTnPuh+Om3yG2gxqPuffoQLavZNv7OVl1O/jVnWHaAc
 qhF1QBMfmkaCvicNvOrTdau4UFuEsn8DWEvclpBxvzsZBHJtn2jP/+3mF0h2VmVgCYCo
 Wr0crZ9uG+g18hzkTGLJMKaaw/mYz7XIPAzGYvFXbv8o69iY2P0WCprxjgBssTJ55/nA
 K8W0gZgeXsZSKvUtGKVMolqJbfwTiea2G1D8ZCUo2p0UY5BhWXV2xCmYOXzSrpRxQ6lj
 UD4nIbQMD/Em/Z//z23S2FSlki1XdlFMPcOd1QhhnFpC85TIZSGCSIZZhL+UAxo9J9g/
 Ivqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714628662; x=1715233462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kvsEkhTyf169sgF1OovUL2phPwJdfZB/cbb8N0Y+skM=;
 b=TCiYi2DBMJ6iIEZl30CBwZt1o1UPAC7oSNM7WIYGhmmG4On4Qo+bLdm461EPURQ5wd
 Suf8JlFfXGg6oZI+iKRWrM+hNM4mxjQ2OgSddZqSK4K2OknRqsBX1sUqnasQnaPB6kuM
 hLZp7zcDK8/B4GcR/LBO0Rb/rIxnEpjgr8VlcDhIdcsjL2H3NT5CL5rchL78N7pGCJ40
 nLNTuxW0tiEgBJ7v7A5oGAMxD6R3as01BEspzRej1BXyTBksGruI1fkmyOjFyyMHTYHK
 iBsXqUk9D5g4zp4KO0h9A733c4YYizSQz6M4rZJ70R4GO960COsqkcq6eDVhhgYHuWLL
 2Brw==
X-Gm-Message-State: AOJu0Yw9rJlg9sgCN0ba/Lg1pojuDcLlmAq5cvdU6Zip4wYqlIaReeW4
 edaBjuPloti8QKmQbvAFJuI2icF4xEDGtGTk5tY1p5xb9UFPFHWhzlmcv9gpJ5jQiD/Jy65TuVi
 Q
X-Google-Smtp-Source: AGHT+IElX8RYnS0cKxoeFG4Cg/giq6cl8wKxn249nQ8Dh4EY/2pzFXp9gEcjl/wEVz2aRhrnwxyUpg==
X-Received: by 2002:a05:6a00:842:b0:6f3:f062:c09b with SMTP id
 q2-20020a056a00084200b006f3f062c09bmr5716409pfk.6.1714628661898; 
 Wed, 01 May 2024 22:44:21 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a656492000000b006089cf2cde5sm294401pgv.26.2024.05.01.22.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 22:44:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, iii@linux.ibm.com, david@redhat.com,
 thuth@redhat.com
Subject: [PATCH 02/14] target/s390x: Move cpu_get_tb_cpu_state out of line
Date: Wed,  1 May 2024 22:44:05 -0700
Message-Id: <20240502054417.234340-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502054417.234340-1-richard.henderson@linaro.org>
References: <20240502054417.234340-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.h | 23 ++---------------------
 target/s390x/cpu.c | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 414680eed1..950f84f316 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -413,27 +413,8 @@ static inline int s390x_env_mmu_index(CPUS390XState *env, bool ifetch)
 
 #include "tcg/tcg_s390x.h"
 
-static inline void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
-                                        uint64_t *cs_base, uint32_t *flags)
-{
-    if (env->psw.addr & 1) {
-        /*
-         * Instructions must be at even addresses.
-         * This needs to be checked before address translation.
-         */
-        env->int_pgm_ilen = 2; /* see s390_cpu_tlb_fill() */
-        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, 0);
-    }
-    *pc = env->psw.addr;
-    *cs_base = env->ex_value;
-    *flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
-    if (env->cregs[0] & CR0_AFP) {
-        *flags |= FLAG_MASK_AFP;
-    }
-    if (env->cregs[0] & CR0_VECTOR) {
-        *flags |= FLAG_MASK_VECTOR;
-    }
-}
+void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags);
 
 #endif /* CONFIG_TCG */
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index f7194534ae..a8428b5a1e 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -324,6 +324,28 @@ static void s390_cpu_reset_full(DeviceState *dev)
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
 
+void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *flags)
+{
+    if (env->psw.addr & 1) {
+        /*
+         * Instructions must be at even addresses.
+         * This needs to be checked before address translation.
+         */
+        env->int_pgm_ilen = 2; /* see s390_cpu_tlb_fill() */
+        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, 0);
+    }
+    *pc = env->psw.addr;
+    *cs_base = env->ex_value;
+    *flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
+    if (env->cregs[0] & CR0_AFP) {
+        *flags |= FLAG_MASK_AFP;
+    }
+    if (env->cregs[0] & CR0_VECTOR) {
+        *flags |= FLAG_MASK_VECTOR;
+    }
+}
+
 static const TCGCPUOps s390_tcg_ops = {
     .initialize = s390x_translate_init,
     .restore_state_to_opc = s390x_restore_state_to_opc,
-- 
2.34.1


