Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B44D232E2
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56h-0004MH-TZ; Fri, 09 Jan 2026 00:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56a-0004E5-Ok
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:12 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56Y-0003gX-V2
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:12 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7bab7c997eeso2918862b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936729; x=1768541529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rGO5t6yhWgb8pIauU6B5HnqUDD8NxKcUMjfi55ekFSs=;
 b=UAOJEENAcDhFRK9TL7XgVD7s6eGiZ7zsIQHRBQaiTUvzwu6yeain92x2JZmyD8xmAo
 o106uxv6XyQ5Af1PEEOM0+jQUnPpivv92E9kKk6Ts87Fr6NlCqabQGGxIW+ZgqvM7IzK
 DetbgzpcGsaa2T1H4/xI78mkxJiYlynv3zbcvHJmFfFVXXd3iqUJ7d3zkzq6d+yqh6bN
 mvLef2wmij4QMsuHHZujWAEFxgqlnDR+p56NOSCP//FvBtSy4WL/ytZALcDOF/gZsvb+
 2OKOMN0PjTRcKScGZwZnoTt3vOq0qnvmeahI921+LKntVvtIDqtX6/+uvyAfVMyWxlb0
 eDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936729; x=1768541529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rGO5t6yhWgb8pIauU6B5HnqUDD8NxKcUMjfi55ekFSs=;
 b=IETEPPoBmjSy8/TeWSksuoRZAb4fI1BUu44GBd8Nlq+zUtxmmAB/y7IWurMJWyViW9
 BSmAKcWUfDVwIj9r+WSd5pRtYXxj7kPQEY76v/GXKON6zoWFbIo2aAf8bpU5ohcbxovV
 PopgnVruNDK31hCT8K8JSE2f/bMqK9NoSl37iSSV0a2gmvecnB13GJVk6AnLGRekst7r
 ww9QPF87nl7U1eBJPVEZZgBrHijwAjNFuqkLV5fOfql7bkQhDexfpKcwyfrK+iGdjT4U
 Qi4yXimzC1QjmvoQPK00ib5A1YAGdt0rOIITFc07TJS5rBpntPwCfdCPXSGWodECYLia
 6rEw==
X-Gm-Message-State: AOJu0YyO9Kqha8Rvz+7aAvClYD5IEJVbWfAKFjiXNwtpb78uGvPvTbUH
 B4LMEdl0oLhCdYos0bV4qotm14KNTZcLXW5gzU/J0fwxsWB85rfD+xOsXSWEUoFwHLa10xj46S3
 ZKSD5
X-Gm-Gg: AY/fxX6sbhQHpuvjB1Cxrrt3o/sKEtlbo6EFtL+E281e+ayY61gVioefowneaavzRbQ
 2czXZfTdQJuaLIMWqCO6miDaXJHbRkvTXVmIjyx6p0wRAPm8NGXx8I/QLg0YbEc9j9DTZZE+DNz
 8CqPTqxmFj2a6juHJGslg7DFfkOjtDKMvj54sHTvF5aWvDsPrMLwxUS5emKjXWCY4Ec6qfbc4GY
 dzIamMvoST8CZTX2LZI04SOQSYI1zdERme9QS21jgdb+luTrvFI3ZZC2BIVqyHZVkv3z+zEfPe5
 QWpqhbFjY3MSfgnlh4yxuxO+of7h9LiiQ6mgI1WgVH+j34q/PeGa+Qrc4gB8cHQsg7+yAeTzjyF
 UqtZzo4b1ly8Yfl+FWIfb8296iAzF1wh8ByY3GP/MVuf+bwCWkPGPmhNV7mhl9kCscSfpjjjjA6
 qjMgTFaekM2nHSayrWIJ4gXezLTD/vFtq5eC/yf3NeNq7ng0l8CTh9VnI6lPbnQahz
X-Google-Smtp-Source: AGHT+IF/kVHoGU+LDMx5rVKI1zyPjKapv+1iuAXKcjCLoOEJN4Ge52NevQuBECmS129e50pYGm4NPA==
X-Received: by 2002:a05:6a20:7490:b0:389:8f3f:50ce with SMTP id
 adf61e73a8af0-3898f9af60amr7872544637.56.1767936729246; 
 Thu, 08 Jan 2026 21:32:09 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.08
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
Subject: [PATCH 03/29] target/arm/gdbstub: make compilation unit common
Date: Thu,  8 Jan 2026 21:31:32 -0800
Message-ID: <20260109053158.2800705-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

Expose and stubs aarch64 functions. All call sites are under a
"is_aarch64" check.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu32-stubs.c | 22 ++++++++++++++++++++++
 target/arm/gdbstub.c     |  8 --------
 target/arm/meson.build   | 12 ++++++------
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/target/arm/cpu32-stubs.c b/target/arm/cpu32-stubs.c
index 81be44d8462..6c524d84198 100644
--- a/target/arm/cpu32-stubs.c
+++ b/target/arm/cpu32-stubs.c
@@ -24,3 +24,25 @@ void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
 {
     g_assert_not_reached();
 }
+
+
+int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
+{
+    g_assert_not_reached();
+}
+
+int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg)
+{
+    g_assert_not_reached();
+}
+
+void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *qsupported,
+                                       GPtrArray *qtable, GPtrArray *stable)
+{
+    g_assert_not_reached();
+}
+
+void aarch64_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 4e8e341cc04..c7d59fd3726 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -44,11 +44,9 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
 
-#ifdef TARGET_AARCH64
     if (arm_gdbstub_is_aarch64(cpu)) {
         return aarch64_cpu_gdb_read_register(cs, mem_buf, n);
     }
-#endif
 
     if (n < 16) {
         /* Core integer register.  */
@@ -72,11 +70,9 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     CPUARMState *env = &cpu->env;
     uint32_t tmp;
 
-#ifdef TARGET_AARCH64
     if (arm_gdbstub_is_aarch64(cpu)) {
         return aarch64_cpu_gdb_write_register(cs, mem_buf, n);
     }
-#endif
 
     tmp = ldl_p(mem_buf);
 
@@ -504,10 +500,8 @@ void arm_cpu_register_gdb_commands(ARMCPU *cpu)
     g_autoptr(GString) qsupported_features = g_string_new(NULL);
 
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-    #ifdef TARGET_AARCH64
         aarch64_cpu_register_gdb_commands(cpu, qsupported_features, query_table,
                                           set_table);
-    #endif
     }
 
     /* Set arch-specific handlers for 'q' commands. */
@@ -536,9 +530,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
          * The lower part of each SVE register aliases to the FPU
          * registers so we don't need to include both.
          */
-#ifdef TARGET_AARCH64
         aarch64_cpu_register_gdb_regs_for_features(cpu);
-#endif
     } else {
         if (arm_feature(env, ARM_FEATURE_NEON)) {
             gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 3df7e03654e..462c71148d2 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,8 +1,11 @@
 arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
-arm_ss.add(files(
-  'gdbstub.c',
-))
+arm_common_system_ss = ss.source_set()
+arm_system_ss = ss.source_set()
+arm_user_ss = ss.source_set()
+
+arm_common_system_ss.add(files('gdbstub.c'))
+arm_user_ss.add(files('gdbstub.c'))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
@@ -13,15 +16,12 @@ arm_common_ss.add(files(
   'mmuidx.c',
 ))
 
-arm_system_ss = ss.source_set()
-arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
 ))
 arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
-arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c',
-- 
2.47.3


