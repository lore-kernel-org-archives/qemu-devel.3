Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0805DD232E1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56h-0004LW-AI; Fri, 09 Jan 2026 00:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56a-0004Dq-K8
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:12 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56Y-0003gV-9f
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:12 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-34c71f462d2so3322588a91.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936729; x=1768541529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAbwyXuoI73BHnFhyp9ohGbUk3GZSQxWNqd4WXALw+o=;
 b=mG4wKhZIz3jeAmP9rdcMuYviflqLm5U7sAfvTUF+Pdn8qO8AcrmVkKQCUeasxlnzh4
 7vJ5lKwkCAVu+WDrW5VFfNIQ6cu+ZbaHdY0YGr09XXK+VNs/+hzBcNcfvch7xiy8wgsw
 BarurR5gojx2/8Qjaueifkd0qlSYXH4UYY0+orz1kqNxDYuVesP9h+NJ6rdq4xbCr9wI
 Cq7x+pymPPkFYrs4Vl+ISYRqfWZLemsl/BpsicS9AYjdvpfNRHrtYw455QYCBIjXvyAO
 kzqMuZ2WETsjum0wJboIFtgp4WazTwssNLymCZ+/WTshPCjf667S0Tz1OiriEowChda7
 f5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936729; x=1768541529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mAbwyXuoI73BHnFhyp9ohGbUk3GZSQxWNqd4WXALw+o=;
 b=OdR/mVFl5+m71hH4VZHB/yjZo/celg98LchHTrRfqtvUbndyQpVw3HLFXTwDZormBg
 8mHYrkDjlrk8Zm3kO2Y5xO+tspIPRRAmNQg2uOGysctEpc3qU7Lh5rMXIREDqj4XeANm
 01QF9cp2LxkhB3E60b+HXVZgffzMWRaeMhq/uj4T3Y81LPT3y+T07kV/cQNKnvFytydJ
 gT5TWSEpzWmiusTBgJOQ0IdgaJEwcXMR7NpDthXt6NGDMsxTwMjzhB8O71kyBhKuq8bC
 AhJYMRdnL8blKhQ9CAhjtCBDLF0ES600jgGkx6u9SYNhUwtxLjyNTCt0OwRUaiWGva8C
 ETlg==
X-Gm-Message-State: AOJu0Yx/11RGJ5tGFoV01DnWkhQ3W/8d7ph/WzW81SfQpfj4AaaLR867
 iUXgY6n1zOv6H797/oJXay6ZV0rFshWWgoOMpKg0Ec3orfpa5WE+0CL78zH7G+ZsDdOPNmcPUPU
 1QdS1
X-Gm-Gg: AY/fxX7yA/9o8rTi3/xQS1YYEdgRAfSERmVbf2H9PGH3m3KfI+51oQOlhxkQb5vnpsx
 Uo1L+21AjSY/MbIDMMMkjWcx4/7opErGarVxgTOcwCXVKpUQOhU4Di0uGxwisSIfIXEKI4G+BGX
 prfA933WXZou5guP9OJEO74UDINSVqCCg9E9R14Savf0dJTGY6UugPkRFgQFBzLUWzr0kHRh4CR
 GrOLwb+Q3G9mn8aDLza/FiE6n1Pvc8fM+NN8UIaVt1famti6km4oJx0qatJ8vRiZVPn8TOfZkD3
 aawG9K1FsfzWQXRdGxTH+UUzQpGZGJyPTUrUhVJuBLe3iFIBUXNq1EBYjKJJCEqeeaEXtO77kZf
 MicB1wxLWcVj82SKNgcbg85gtEsj44OtSvRNtNoe3Ie50p+itzD8D94PBIejBH5A5y0Rj2KkOei
 WMJA1y2hWo3upC3BwXMFUXm0iPJquAHFDpmGB5KUmok6u27nsDlbXsXvqarKTrjyeI
X-Google-Smtp-Source: AGHT+IF96dZd23PEOwoHqqe786+hfnBGjfFjl8sUW+fEO/ObKJzlF2gVFNa8ifbWTyfzy9bXdwN0cQ==
X-Received: by 2002:a17:90b:4b0b:b0:330:6d5e:f174 with SMTP id
 98e67ed59e1d1-34f68d0bc5fmr8902062a91.20.1767936728486; 
 Thu, 08 Jan 2026 21:32:08 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:08 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 02/29] target/arm/gdbstub: extract
 aarch64_cpu_register_gdb_regs_for_features
Date: Thu,  8 Jan 2026 21:31:31 -0800
Message-ID: <20260109053158.2800705-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
2.47.3


