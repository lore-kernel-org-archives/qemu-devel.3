Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C0BCF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQpJ-0008Nk-W5; Mon, 12 Jan 2026 17:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQpH-0007z2-DJ
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:55:55 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQpF-0004QP-JR
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:55:55 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so3727178f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258552; x=1768863352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0v+2OnVOsTI/bCFGO0OtJvlwuMqs+IwSJ72vCxsdZTc=;
 b=N7sx0jj0p5z4ZCwHXYQy/BW9nfOfxw80sdDQulO9HWh4r95oCqC80SL0Vk8aHGdyuF
 5e6pUMfMq8eYIhtAXtg30G+qrnRIOcFj8OY16jgIqHvOLPljSdZLmzTPQwPcvYuJQOYm
 j9MwFSeywAb14eGFTeeESai7eo6NfapsukT1SkhLdiR4JaiGvtGqOwHB/mnUiHUQcMHq
 REMPeCyHbo5a+Gs/oF9pqtutRBCdkwKyu7owf5bGt74Bw1nzvKPVlavmKJ33GVywtOb4
 ZW1IYRyNyeqgi50Y6qpOPNAq0dTIfk7J/lCxp03JmrR4gO1zWSWIlfeA0wDQPL7jmQdO
 O6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258552; x=1768863352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0v+2OnVOsTI/bCFGO0OtJvlwuMqs+IwSJ72vCxsdZTc=;
 b=Vdp5EiFXUjT2SQe7vYS5xg5G4DVGqdHIQ/EvK+ugkdIaRkngIEiLDJ1Fa9UXYquYcU
 t3eDodB0MP5g44dBvM0thbUPGqpgA8xwf45Ey6ajlxxcDqXuKBmArW26QmwRqsJzZ0j0
 8i+bR7kYp9fChTJjEDovYg6aWELy/xmi1XE+7DeJieYsYNHfA4Di3aUH5NTakKn+koO9
 EZdLS4kQfXe+k5aW7E9ayi/aC86ZtkC0mkJjf++V9ef2t3LESLiyLONujIFzWitF+PBN
 6V56WJn83HyCA4QQ8cBA+NE7W450giVq7Ewyt3eU1XB6Yl62NAMd0EVMEPqL67aDDLXu
 32Wg==
X-Gm-Message-State: AOJu0YwRhb9RU1hb7nsJhU5L3EnO3XWQkEMeqZKW/9+lwfk8ZJ7/QcK4
 ihUYX4IlEpv4l5b01J3/MdkmrcNT8FAAYhhHl52yG9SewmtqM2aIY0b3MgjYG8TwyyPfshioNTr
 lO44zuOU=
X-Gm-Gg: AY/fxX5SbouCyZSXzBOEEsgscQLdWYoyfypbhiVCWlhPO1Dtz/kV7/2dVvHm3v+dVw5
 zj6hmeigMqWOxiDfAFgdag6Rd5XEzIUQ7By4LRDnmJDo5f1agLaKeYoaLHTHqGKrbuSNi2rqTor
 cTDt+IuYC/W8cziRgYXsXGENMmAFFzwFSSAyJWgVA+7oodTV5HJOymilSwrWANN904FDQdHGfai
 uCnoU1qEQ8QgUDEQxPnuwiV134ywldwKRmbLkLEB8mJNkKV3YGWPhiYGA14rlA57zYPjsLU4Rre
 lfMm/TCnPXDswS95PWUpebDpU+nSvqCbcleMg6Tizmz6PItHkbnP2mdi2JYdEFjC+YGAleIX7yN
 0sgkSYa0CeQHw4rpf6HBZ+wUmlmSayP8XK2RNu8k/uOYFnE2S44fQ26yH052e0Twqqb3sb9eMKD
 VGs/smZrhkwQPQUbcm1rC1MYSscCWSM505CJ2ifqd8WZUqelVTCABqNPs3YX5w
X-Google-Smtp-Source: AGHT+IHJb9LEBrkY0TIE8w6z5iLodVhdAfetqmJoA7o7Jg1pzUH9L/ii1gAHXMCfkNK+0UqMSgKEDg==
X-Received: by 2002:a05:6000:40da:b0:430:f23f:4bc5 with SMTP id
 ffacd0b85a97d-432c3760d02mr21573654f8f.45.1768258551665; 
 Mon, 12 Jan 2026 14:55:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dad8bsm41238875f8f.8.2026.01.12.14.55.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:55:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 60/61] target/arm/gdbstub: extract
 aarch64_cpu_register_gdb_regs_for_features
Date: Mon, 12 Jan 2026 23:48:55 +0100
Message-ID: <20260112224857.42068-61-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109053158.2800705-3-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h |  1 +
 target/arm/gdbstub.c   | 53 +--------------------------------------
 target/arm/gdbstub64.c | 57 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 52 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 9cd4bf74efb..440072d8206 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -387,6 +387,7 @@ void arm_translate_code(CPUState *cs, TranslationBlock *tb,
 void arm_cpu_register_gdb_commands(ARMCPU *cpu);
 void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *,
                                        GPtrArray *, GPtrArray *);
+void aarch64_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
 
 void arm_restore_state_to_opc(CPUState *cs,
                               const TranslationBlock *tb,
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 8865f27089d..4e8e341cc04 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -537,58 +537,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
          * registers so we don't need to include both.
          */
 #ifdef TARGET_AARCH64
-        if (isar_feature_aa64_sve(&cpu->isar) ||
-            isar_feature_aa64_sme(&cpu->isar)) {
-            GDBFeature *feature = arm_gen_dynamic_svereg_feature(cs, cs->gdb_num_regs);
-            gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
-                                     aarch64_gdb_set_sve_reg, feature, 0);
-        } else {
-            gdb_register_coprocessor(cs, aarch64_gdb_get_fpu_reg,
-                                     aarch64_gdb_set_fpu_reg,
-                                     gdb_find_static_feature("aarch64-fpu.xml"),
-                                     0);
-        }
-
-        if (isar_feature_aa64_sme(&cpu->isar)) {
-            GDBFeature *sme_feature =
-                arm_gen_dynamic_smereg_feature(cs, cs->gdb_num_regs);
-            gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
-                                     aarch64_gdb_set_sme_reg, sme_feature, 0);
-            if (isar_feature_aa64_sme2(&cpu->isar)) {
-                gdb_register_coprocessor(cs, aarch64_gdb_get_sme2_reg,
-                                         aarch64_gdb_set_sme2_reg,
-                                         gdb_find_static_feature("aarch64-sme2.xml"),
-                                         0);
-            }
-        }
-        /*
-         * Note that we report pauth information via the feature name
-         * org.gnu.gdb.aarch64.pauth_v2, not org.gnu.gdb.aarch64.pauth.
-         * GDB versions 9 through 12 have a bug where they will crash
-         * if they see the latter XML from QEMU.
-         */
-        if (isar_feature_aa64_pauth(&cpu->isar)) {
-            gdb_register_coprocessor(cs, aarch64_gdb_get_pauth_reg,
-                                     aarch64_gdb_set_pauth_reg,
-                                     gdb_find_static_feature("aarch64-pauth.xml"),
-                                     0);
-        }
-
-#ifdef CONFIG_USER_ONLY
-        /* Memory Tagging Extension (MTE) 'tag_ctl' pseudo-register. */
-        if (cpu_isar_feature(aa64_mte, cpu)) {
-            gdb_register_coprocessor(cs, aarch64_gdb_get_tag_ctl_reg,
-                                     aarch64_gdb_set_tag_ctl_reg,
-                                     gdb_find_static_feature("aarch64-mte.xml"),
-                                     0);
-        }
-#endif
-
-        /* All AArch64 CPUs have at least TPIDR */
-        gdb_register_coprocessor(cs, aarch64_gdb_get_tls_reg,
-                                 aarch64_gdb_set_tls_reg,
-                                 arm_gen_dynamic_tls_feature(cs, cs->gdb_num_regs),
-                                 0);
+        aarch64_cpu_register_gdb_regs_for_features(cpu);
 #endif
     } else {
         if (arm_feature(env, ARM_FEATURE_NEON)) {
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 3bc7ff45d57..c584e5b4e69 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -879,3 +879,60 @@ void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *qsupported,
     }
 #endif
 }
+
+void aarch64_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+    if (isar_feature_aa64_sve(&cpu->isar) ||
+        isar_feature_aa64_sme(&cpu->isar)) {
+        GDBFeature *feature = arm_gen_dynamic_svereg_feature(cs, cs->gdb_num_regs);
+        gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
+                                 aarch64_gdb_set_sve_reg, feature, 0);
+    } else {
+        gdb_register_coprocessor(cs, aarch64_gdb_get_fpu_reg,
+                                 aarch64_gdb_set_fpu_reg,
+                                 gdb_find_static_feature("aarch64-fpu.xml"),
+                                 0);
+    }
+
+    if (isar_feature_aa64_sme(&cpu->isar)) {
+        GDBFeature *sme_feature =
+            arm_gen_dynamic_smereg_feature(cs, cs->gdb_num_regs);
+        gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
+                                 aarch64_gdb_set_sme_reg, sme_feature, 0);
+        if (isar_feature_aa64_sme2(&cpu->isar)) {
+            gdb_register_coprocessor(cs, aarch64_gdb_get_sme2_reg,
+                                     aarch64_gdb_set_sme2_reg,
+                                     gdb_find_static_feature("aarch64-sme2.xml"),
+                                     0);
+        }
+    }
+    /*
+     * Note that we report pauth information via the feature name
+     * org.gnu.gdb.aarch64.pauth_v2, not org.gnu.gdb.aarch64.pauth.
+     * GDB versions 9 through 12 have a bug where they will crash
+     * if they see the latter XML from QEMU.
+     */
+    if (isar_feature_aa64_pauth(&cpu->isar)) {
+        gdb_register_coprocessor(cs, aarch64_gdb_get_pauth_reg,
+                                 aarch64_gdb_set_pauth_reg,
+                                 gdb_find_static_feature("aarch64-pauth.xml"),
+                                 0);
+    }
+
+#ifdef CONFIG_USER_ONLY
+    /* Memory Tagging Extension (MTE) 'tag_ctl' pseudo-register. */
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        gdb_register_coprocessor(cs, aarch64_gdb_get_tag_ctl_reg,
+                                 aarch64_gdb_set_tag_ctl_reg,
+                                 gdb_find_static_feature("aarch64-mte.xml"),
+                                 0);
+    }
+#endif
+
+    /* All AArch64 CPUs have at least TPIDR */
+    gdb_register_coprocessor(cs, aarch64_gdb_get_tls_reg,
+                             aarch64_gdb_set_tls_reg,
+                             arm_gen_dynamic_tls_feature(cs, cs->gdb_num_regs),
+                             0);
+}
-- 
2.52.0


