Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B86CF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQpU-0000u4-Ht; Mon, 12 Jan 2026 17:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQpR-0000hg-Rz
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:56:05 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQpO-0004RH-ND
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:56:05 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-432dc56951eso2153198f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258558; x=1768863358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CcYUWFRetdP2hpvvwiCaCND6NKm0LxnGywFq2yDIOV0=;
 b=Psi5i7hSdBjEXAFA2kZ8tGJNZrLT14Zz3Hv+a/su4rlRzlxTgAQiiIaalizFBIrpjT
 Zfv4zs20xezvKBkcLELIPuqhqEzB4lyjcjxURjnHT9bMy4htw3KnR80xPc9OyMl6Qyqx
 mUzZXeU5UTC0+2qgDGx1p0Gd1POV6K63VVm6rcX8DzUFJG7qjasO9jYMeCvVH4pfAQHg
 VHhJXpjQmw6kWNiypRx570WIrgQ76uY8ExZrQYzJPi0iFxJgIQp0ik86OV2C0yq53Dl0
 VSzxqY/kbqWroVS2jx9PDD4F9MJfl9eKQhdO9dNkcBoe7KqcFpEtdLs4k/Eagxp9ABOd
 CmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258558; x=1768863358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CcYUWFRetdP2hpvvwiCaCND6NKm0LxnGywFq2yDIOV0=;
 b=mfOUkUvpLSsONtAJ++2oDgLM+ATIjdK/iVj43ZzDOBQ/mrMApPkviRKPovJbTDt+24
 XZAA23KjmkHool9pITbdzO2xkLAjJvxg56bWurE91oiyKBl8a/IFumWFFpxHV5oPdF0o
 kY9uluj2mLVSF5LZxKqBvo2tCsgB5De2km/52u+NJ3OkEaNlFhm+DuC0tDaEmlExp9Q6
 twNMHOa392Ritv4nq3rvKCoC1dZEqa8H2ju6j7S2UqqHTjwd4cKzwE3WrIrx7bRLVmxY
 Ytqc22fbs88JGHOhPgdzuztxu+bQaBbeYf7qTMsD/C1r45lH7/bULI1SQlv4zRyvzimk
 vUaw==
X-Gm-Message-State: AOJu0YySfPnXn1vELgMrmaP6Ia2XrFKo0sACjQ7zQ9TUenzpsJa/ILHV
 6JXapVqtEMnennkD+hYBCYfTKWFpjWlcdjVyrTT9fCxYwPRgrW2UW4ox9v6juPqwwMTs87Y5Jk4
 Lui8PJjw=
X-Gm-Gg: AY/fxX5ELd8ChpbehFOtCZEu4I/6soHQ3iuGS3njFJXvzOSxjpfoR2mmec+5R3mAWby
 yqXJZEuZfT5DjA7Bn1e9L1wQXNBAGfv2UJWfq68Udiy+/PAJqfZMtWCdJySh/buCjl583XnhxFW
 gxsbgl/KcWDo+1As/Zq5r9LWWwCmoblIMpdbzdb5OL6/rrYlXwYkd2kz05+/yp45X3XdCjyq+Su
 5WTd+Zv25FlKTk2MEXiqNdoeBNg48tHfZehG0KyKWjU8jdjrXI+Vk7D/aK7Nb3Tmhjm+EjgyOPx
 UkgGssSDuh3weGJNrTvVhdfhazA5Utx40p7WpFYoOWhfl3l9wplgUBY8prKi9MDryQOc3L0uOKj
 GFFVwtZayHMKSv+gasdwxHZnYySYUGfo8+A7ZFg41+BU6mH1xMe03Ef44wyKvQytcrKa4paue44
 +7/CFowrrczr5jqZoZPS6AGEBw3S0f/WCsxrT+iF7dvvB4CPvJKWAbBQlz+I5Pv05mK5SVhIB2Y
 FMgWJnyQg==
X-Google-Smtp-Source: AGHT+IHaIqoEWLRlx4xZRh3mNnbB3H8oviPYltkkwoc97CYTbRJfk5iwP9HTqK6gv7AabC0zH7OvIQ==
X-Received: by 2002:a05:6000:4287:b0:430:f494:6abb with SMTP id
 ffacd0b85a97d-432c378a793mr19654896f8f.8.1768258558172; 
 Mon, 12 Jan 2026 14:55:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee243sm40956009f8f.31.2026.01.12.14.55.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:55:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 61/61] target/arm/gdbstub: make compilation unit common
Date: Mon, 12 Jan 2026 23:48:56 +0100
Message-ID: <20260112224857.42068-62-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Expose and stubs aarch64 functions. All call sites are under a
"is_aarch64" check.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109053158.2800705-4-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu32-stubs.c | 21 +++++++++++++++++++++
 target/arm/gdbstub.c     |  8 --------
 target/arm/meson.build   | 12 ++++++------
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/target/arm/cpu32-stubs.c b/target/arm/cpu32-stubs.c
index 81be44d8462..f0ce1595725 100644
--- a/target/arm/cpu32-stubs.c
+++ b/target/arm/cpu32-stubs.c
@@ -24,3 +24,24 @@ void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
 {
     g_assert_not_reached();
 }
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
2.52.0


