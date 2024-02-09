Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222B6C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 06:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYKa0-0005yf-6w; Fri, 09 Feb 2024 01:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rYKZq-0005oG-SD
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 01:41:34 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1rYKZo-0002P0-5u
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 01:41:33 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a2f79e79f0cso81094466b.2
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 22:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1707460890; x=1708065690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nJiaJKCuzUzPChMbWkGwMdFArNUhgZ5ZSPilG6i32Y=;
 b=L18zqnmRJprRX6etLHTSu+b+1+a0S8nO8BxVQqlYTurrpwXJlR/JYn+Bb1sbINWqva
 /0/bWN5sXbKN14iH6+uhB839YbfDTbmReS+XlnWKBJwTNI+HmF8pL9+QNr/S2/tdFKjc
 IZQug9fgYr5ZHFknCNoGsSm5ltBHxEDmOEuEwnx7R7wZ5v8R9O61cp6PeuwQc7EdVWhN
 UA+5qGj7K0GffMIgKs0rrzejEhukyNb7rqBRgLWXaJen3xiBI2PvuP8wcSY5WF38tX1C
 WWwBpMFo7ChQLzmLKxPDwHHKD2Zz2d7gM71mYy66XT4lUE9XenCDb2rFooQzwncVZ7qK
 i9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707460890; x=1708065690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/nJiaJKCuzUzPChMbWkGwMdFArNUhgZ5ZSPilG6i32Y=;
 b=FRw31ZwMXXBewbJtSTwFjuU5HT+F2giCiM3HSEoji0io0P7/KwPYrY2DRejks/FhSV
 2Q7Kf5MvlX4nJ67DHhHk0l8BrECzet1vXdR8pulhHYyCe9D5yIoMb6HsY3LWFWJI85qd
 bsP+boD+t6S5f2il6gt7vjKd4pjCdvTxhc/u3yZmhBOW70nScc6SDnhWyqmdTAariyKt
 ySRPU6pIwH+31Ara4uRO0tHQ4Mtz5AYv/NC3r6kS+A7mtosfjhPS58svWn8BR49sBbA/
 2lAxuMurRNnV32YQ6QjLZyIYKpBbQQ3v3/7WvVCuBRpPD764Ae9aRIgzdkVccqepfG3V
 xtMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2kA4XXMC6lIdWG8UbrTTgwLBeON6w5/976spgXt6CJFGcCR5r0yxHCflfAJjdVIqoA0RzYo1pDDFtEC7AWT6g6Turud8=
X-Gm-Message-State: AOJu0YxtkPLMFQQ/PoS82Vwm+3L2jQt8cmQ9W999tNjNLY4fxsqpmbpI
 +9dMmIO+7iECBiWKFp3LObqcdrBn3h+VGbs4bk3n3Emt2EewAHUPR/C90ZaMaow=
X-Google-Smtp-Source: AGHT+IFB6zbDt8USaW4Fygr3gycFlYc5raNVU0XxxE2AGBqm/iK0fLZo6dSrSq4P4mhQz/mhYpHKWQ==
X-Received: by 2002:a17:906:407:b0:a38:421c:876c with SMTP id
 d7-20020a170906040700b00a38421c876cmr449361eja.19.1707460890727; 
 Thu, 08 Feb 2024 22:41:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWXFfFzEpbv5Ch2UC92cQCDa2zHx/3tdtlK6A8FVdI7yPzKl8rdHrd2Bnw/HKp1ikdfErtTDOJQ5MucBZCrzk3ww5GSdWtIrd9K5U1Rks0RQ3TSvicTEqocH/EOoPe11ABThfFQ5ZIEVL8n1tH6HcOtAdxUst7fiq36nqH59Pbx5ayy0Huq1sLUqj7qhCHUxiP187tt20JBWunGQBRWlEQOb44YLHuEneXdLu4GKVj4/Oulnxpj3wISzkdbGRpZv+QMYDq8e0yMavreAaD+S2VkawSCXgi+FBHwXkf2Rf+e8MqVGrTdwHttK9nY90l02N8MVSsLvhYStc2XTTSoQmGMJEMU1Ne+aYJPOHhCPi4jnK29EFHXRLXDmIMVo9RpMF2/MyiV1jF33DJoj+iS5BgjwN+KkWbmTugJoRdhug==
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 vk9-20020a170907cbc900b00a36c499c935sm450575ejc.43.2024.02.08.22.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 22:41:30 -0800 (PST)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [RFC PATCH v2 4/4] linux-user/riscv: Implement dynamic memory
 consistency model support
Date: Fri,  9 Feb 2024 07:41:17 +0100
Message-ID: <20240209064117.2746701-5-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209064117.2746701-1-christoph.muellner@vrull.eu>
References: <20240209064117.2746701-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ej1-x632.google.com
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

This patch implements the dynamic memory consistency model prctl calls
for RISC-V. The implementation introduces a single boolean variable to
keep the DTSO state.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 linux-user/riscv/target_prctl.h | 76 ++++++++++++++++++++++++++++++++-
 target/riscv/cpu.c              |  5 +++
 target/riscv/cpu.h              |  1 +
 3 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/linux-user/riscv/target_prctl.h b/linux-user/riscv/target_prctl.h
index eb53b31ad5..e54321d872 100644
--- a/linux-user/riscv/target_prctl.h
+++ b/linux-user/riscv/target_prctl.h
@@ -1 +1,75 @@
-/* No special prctl support required. */
+/*
+ * RISC-V specific prctl functions for linux-user
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef RISCV_TARGET_PRCTL_H
+#define RISCV_TARGET_PRCTL_H
+
+static inline void riscv_dtso_set_enable(CPURISCVState *env, bool enable)
+{
+    env->dtso_ena = enable;
+}
+
+static inline bool riscv_dtso_is_enabled(CPURISCVState *env)
+{
+    return env->dtso_ena;
+}
+
+static abi_long do_prctl_set_memory_consistency_model(CPUArchState *cpu_env,
+                                                      abi_long arg2)
+{
+    RISCVCPU *cpu = env_archcpu(cpu_env);
+    bool dtso_ena_old = riscv_dtso_is_enabled(cpu_env);
+    bool dtso_ena_new;
+    bool has_dtso = cpu->cfg.ext_ssdtso;
+
+    switch (arg2) {
+        case PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO:
+            dtso_ena_new = false;
+            break;
+        case PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO:
+	    dtso_ena_new = true;
+            break;
+        default:
+            return -TARGET_EINVAL;
+    }
+
+    /* No change requested. */
+    if (dtso_ena_old == dtso_ena_new)
+	    return 0;
+
+    /* Enabling TSO only works if DTSO is available. */
+    if (dtso_ena_new && !has_dtso)
+	    return -TARGET_EINVAL;
+
+    /* Switchin TSO->WMO is not allowed. */
+    if (!dtso_ena_new)
+	    return -TARGET_EINVAL;
+
+    riscv_dtso_set_enable(cpu_env, dtso_ena_new);
+
+    /*
+     * No need to reschedule other threads, because the emulation
+     * of DTSO is fine (from a memory model view) if they are out
+     * of sync until they will eventually reschedule.
+     */
+
+    return 0;
+}
+
+#define do_prctl_set_memory_consistency_model \
+        do_prctl_set_memory_consistency_model
+
+static abi_long do_prctl_get_memory_consistency_model(CPUArchState *cpu_env)
+{
+    if (riscv_dtso_is_enabled(cpu_env))
+	    return PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO;
+
+    return PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO;
+}
+
+#define do_prctl_get_memory_consistency_model \
+        do_prctl_get_memory_consistency_model
+
+#endif /* RISCV_TARGET_PRCTL_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ee90c09600..2e2aac73dc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -922,6 +922,11 @@ static void riscv_cpu_reset_hold(Object *obj)
     if (mcc->parent_phases.hold) {
         mcc->parent_phases.hold(obj);
     }
+#ifdef CONFIG_USER_ONLY
+    /* Default is true if Ztso is enabled, false otherwise. */
+    env->dtso_ena = cpu->cfg.ext_ztso;
+#endif
+
 #ifndef CONFIG_USER_ONLY
     env->misa_mxl = mcc->misa_mxl_max;
     env->priv = PRV_M;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f52dce78ba..69420b2ae3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -200,6 +200,7 @@ struct CPUArchState {
 
 #ifdef CONFIG_USER_ONLY
     uint32_t elf_flags;
+    bool dtso_ena; /* Dynamic TSO enable */
 #endif
 
 #ifndef CONFIG_USER_ONLY
-- 
2.43.0


