Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D881FD88D4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 01:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w08XZ-00045n-Sr; Tue, 10 Mar 2026 21:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XO-0003zb-0U
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:39:02 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XK-0004qq-P0
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:39:01 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2adbfab4501so60889225ad.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 18:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773193137; x=1773797937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08eAXx3XNNpBcu81/7JUf7iRyO8aIJLNzW90zKT1YnQ=;
 b=MFKx1v142wQajgCsQzlIjRRZ6X5SQss1bdPvF7ZszcvWNDBsphNPIBvqlCrOzLhyqb
 5rIdeNCISugI0UJ5AensTw3tTSAjsSlBuv4tGiLSAWRlpZmzPp0mw6O+M+FBtJMncQVJ
 D2y9YT1ao2z1elva0s+3FqgjgpdrmXDeWWPRerlSVfV1odfKzm0PDTb9OzTFgIoIDXkS
 vPcLbYRBpLVPKtFoay7PPmoTjwNJ+QJQ1yfOFSVBqUJYVI0lHwAfMRu3hAKndwNUyMFt
 jnEF7o/TDZNCGMOLk4UrQDrpBHxb9VJtW8pZf1QBuUx/rd9lZHIWejvWzcnZGwQ6ykDt
 PJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773193137; x=1773797937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=08eAXx3XNNpBcu81/7JUf7iRyO8aIJLNzW90zKT1YnQ=;
 b=UKzTPSk7vxxYjbD0orS4pLRbJks+cwioMjv8Z3lt+BLvHwNJ6F9+hvZ6DmsTQ7objG
 89ZNPqzpNo1l9WqXZcXRvTjnmZbx4L/eLcS717XMQTp/ZWl/HHvUViDE1fpYZM46fwLk
 h/AVwcUj/QYnlWjV5nEhrervNppbv3vH07g9EnXqIXNFpBqcothGJwFEcXrE8+w4vkQ+
 cBoDsj3eHtcNKjyOOwV96LAOBGunExzoZwK/Q2Stvgy/EbwKLmBQ5N7HoU5PB+mHnIii
 wJtiApTJ2DJRAvFATWEFeZzX1FWqAMrOm364+u/AafrspY54hijkhwnYWuFj15vDoXen
 iteg==
X-Gm-Message-State: AOJu0YxSg3yQiDPRMEwlMDX9IKeLj9+M4FYpf17r+lQKSK1apeCf0jp3
 tyJLC9b7N/sSsJlp5urPksECMD0/N0V7yON0zb/YoUouwyig050FXyO9MjDtm8SP9LgWF0tZrsm
 VYfsm
X-Gm-Gg: ATEYQzyTGGXlVCFtBzq5OodQWZwDN7Pqb2EWOOo2dst6dDpnRXWOmsdGlDEgTqklFc4
 aorAebRPTsS5lTqkFqFCufrtoxg4VIN431j2Oe0AzhjJFEjp4K3vaeWa8yVyXRyCOnbGJ/F18sN
 7UsGPIRgTdYfZyvbPbxB75KWigPFRHg5Plx0hMg7XUE9KNAvQao0HlETCV/wLVGBYo2G3wB9MfB
 mr9jIK2S+kzQK5+PxQqbuXThrpnsFD1CAmBexZPozxBlI8aJrqphGPnBGZVGV8hhpiY7sY+gF6w
 QpiW4yx4p0+nuGXcttCs8zBtkG7ls8i4j0oxqRy+kzNCOQPkpwiLGo40CLdD9a/BYPA2ZY2KQBc
 GBLo5jRxSG6QIcU3kau6pnJJkcehtuEueXhgBzUhXK+gMo3hez+6SFRE8dNDF3ODzzkq/HxdKor
 hQPDtZzUwDtv5C1CEUL449IvVdzTgWZ4h+Bn+LTNi6LgM/RDCGaV2RdZ20SIw4FMKxW8mLpGaBL
 E4F
X-Received: by 2002:a17:902:c946:b0:2ae:4a6b:68ea with SMTP id
 d9443c01a7336-2aeae8e1027mr7802975ad.43.1773193137195; 
 Tue, 10 Mar 2026 18:38:57 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae2466d3sm5390175ad.22.2026.03.10.18.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 18:38:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 10/16] gdbstub: Remove @g_pos argument in
 gdb_register_coprocessor()
Date: Tue, 10 Mar 2026 18:38:31 -0700
Message-ID: <20260311013837.69945-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

gdb_register_coprocessor()'s @g_pos argument is always '0',
meaning it is inferred from cpu->gdb_num_regs. Use instead
feature->base_reg.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-11-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/gdbstub.h     |  3 +--
 gdbstub/gdbstub.c          | 10 +---------
 target/arm/gdbstub.c       | 21 ++++++++-------------
 target/arm/gdbstub64.c     | 19 +++++++------------
 target/hexagon/cpu.c       |  2 +-
 target/i386/gdbstub.c      |  8 +++-----
 target/loongarch/gdbstub.c |  6 +++---
 target/m68k/helper.c       |  4 ++--
 target/microblaze/cpu.c    |  3 +--
 target/ppc/gdbstub.c       | 11 +++++------
 target/riscv/gdbstub.c     | 18 ++++++------------
 target/s390x/gdbstub.c     | 15 +++++++--------
 target/sparc/gdbstub.c     | 12 ++++--------
 13 files changed, 49 insertions(+), 83 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index bd7182c4d32..79e47a024ec 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -34,11 +34,10 @@ void gdb_init_cpu(CPUState *cpu);
  * @set_reg - set function (gdb modifying)
  * @num_regs - number of registers in set
  * @xml - xml name of set
- * @gpos - non-zero to append to "general" register set at @gpos
  */
 void gdb_register_coprocessor(CPUState *cpu,
                               gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
-                              const GDBFeature *feature, int g_pos);
+                              const GDBFeature *feature);
 
 /**
  * gdb_unregister_coprocessor_all() - unregisters supplemental set of registers
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 5c1a18e055c..69038c66f2b 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -616,7 +616,7 @@ void gdb_init_cpu(CPUState *cpu)
 
 void gdb_register_coprocessor(CPUState *cpu,
                               gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
-                              const GDBFeature *feature, int g_pos)
+                              const GDBFeature *feature)
 {
     GDBRegisterState *s;
     guint i;
@@ -634,14 +634,6 @@ void gdb_register_coprocessor(CPUState *cpu,
 
     /* Add to end of list.  */
     cpu->gdb_num_regs += feature->num_regs;
-    if (g_pos) {
-        if (g_pos != base_reg) {
-            error_report("Error: Bad gdb register numbering for '%s', "
-                         "expected %d got %d", feature->xml, g_pos, base_reg);
-        } else {
-            cpu->gdb_num_g_regs = cpu->gdb_num_regs;
-        }
-    }
 }
 
 void gdb_unregister_coprocessor_all(CPUState *cpu)
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index c7d59fd3726..d6e29c4cf46 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -534,15 +534,13 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
     } else {
         if (arm_feature(env, ARM_FEATURE_NEON)) {
             gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
-                                     gdb_find_static_feature("arm-neon.xml"),
-                                     0);
+                                     gdb_find_static_feature("arm-neon.xml"));
         } else if (cpu_isar_feature(aa32_simd_r32, cpu)) {
             gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
-                                     gdb_find_static_feature("arm-vfp3.xml"),
-                                     0);
+                                     gdb_find_static_feature("arm-vfp3.xml"));
         } else if (cpu_isar_feature(aa32_vfp_simd, cpu)) {
             gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
-                                     gdb_find_static_feature("arm-vfp.xml"), 0);
+                                     gdb_find_static_feature("arm-vfp.xml"));
         }
         if (!arm_feature(env, ARM_FEATURE_M)) {
             /*
@@ -550,29 +548,26 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
              * expose to gdb.
              */
             gdb_register_coprocessor(cs, vfp_gdb_get_sysreg, vfp_gdb_set_sysreg,
-                                     gdb_find_static_feature("arm-vfp-sysregs.xml"),
-                                     0);
+                                     gdb_find_static_feature("arm-vfp-sysregs.xml"));
         }
     }
     if (cpu_isar_feature(aa32_mve, cpu) && tcg_enabled()) {
         gdb_register_coprocessor(cs, mve_gdb_get_reg, mve_gdb_set_reg,
-                                 gdb_find_static_feature("arm-m-profile-mve.xml"),
-                                 0);
+                                 gdb_find_static_feature("arm-m-profile-mve.xml"));
     }
     gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
-                             arm_gen_dynamic_sysreg_feature(cs, cs->gdb_num_regs),
-                             0);
+                             arm_gen_dynamic_sysreg_feature(cs, cs->gdb_num_regs));
 
 #ifdef CONFIG_TCG
     if (arm_feature(env, ARM_FEATURE_M) && tcg_enabled()) {
         gdb_register_coprocessor(cs,
             arm_gdb_get_m_systemreg, arm_gdb_set_m_systemreg,
-            arm_gen_dynamic_m_systemreg_feature(cs, cs->gdb_num_regs), 0);
+            arm_gen_dynamic_m_systemreg_feature(cs, cs->gdb_num_regs));
 #ifndef CONFIG_USER_ONLY
         if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
             gdb_register_coprocessor(cs,
                 arm_gdb_get_m_secextreg, arm_gdb_set_m_secextreg,
-                arm_gen_dynamic_m_secextreg_feature(cs, cs->gdb_num_regs), 0);
+                arm_gen_dynamic_m_secextreg_feature(cs, cs->gdb_num_regs));
         }
 #endif
     }
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index b71666c3a1d..a4fa740caf6 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -887,24 +887,22 @@ void aarch64_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
         isar_feature_aa64_sme(&cpu->isar)) {
         GDBFeature *feature = arm_gen_dynamic_svereg_feature(cs, cs->gdb_num_regs);
         gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
-                                 aarch64_gdb_set_sve_reg, feature, 0);
+                                 aarch64_gdb_set_sve_reg, feature);
     } else {
         gdb_register_coprocessor(cs, aarch64_gdb_get_fpu_reg,
                                  aarch64_gdb_set_fpu_reg,
-                                 gdb_find_static_feature("aarch64-fpu.xml"),
-                                 0);
+                                 gdb_find_static_feature("aarch64-fpu.xml"));
     }
 
     if (isar_feature_aa64_sme(&cpu->isar)) {
         GDBFeature *sme_feature =
             arm_gen_dynamic_smereg_feature(cs, cs->gdb_num_regs);
         gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
-                                 aarch64_gdb_set_sme_reg, sme_feature, 0);
+                                 aarch64_gdb_set_sme_reg, sme_feature);
         if (isar_feature_aa64_sme2(&cpu->isar)) {
             gdb_register_coprocessor(cs, aarch64_gdb_get_sme2_reg,
                                      aarch64_gdb_set_sme2_reg,
-                                     gdb_find_static_feature("aarch64-sme2.xml"),
-                                     0);
+                                     gdb_find_static_feature("aarch64-sme2.xml"));
         }
     }
     /*
@@ -916,8 +914,7 @@ void aarch64_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
     if (isar_feature_aa64_pauth(&cpu->isar)) {
         gdb_register_coprocessor(cs, aarch64_gdb_get_pauth_reg,
                                  aarch64_gdb_set_pauth_reg,
-                                 gdb_find_static_feature("aarch64-pauth.xml"),
-                                 0);
+                                 gdb_find_static_feature("aarch64-pauth.xml"));
     }
 
 #ifdef CONFIG_USER_ONLY
@@ -925,14 +922,12 @@ void aarch64_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_mte, cpu)) {
         gdb_register_coprocessor(cs, aarch64_gdb_get_tag_ctl_reg,
                                  aarch64_gdb_set_tag_ctl_reg,
-                                 gdb_find_static_feature("aarch64-mte.xml"),
-                                 0);
+                                 gdb_find_static_feature("aarch64-mte.xml"));
     }
 #endif
 
     /* All AArch64 CPUs have at least TPIDR */
     gdb_register_coprocessor(cs, aarch64_gdb_get_tls_reg,
                              aarch64_gdb_set_tls_reg,
-                             arm_gen_dynamic_tls_feature(cs, cs->gdb_num_regs),
-                             0);
+                             arm_gen_dynamic_tls_feature(cs, cs->gdb_num_regs));
 }
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 58a22ee41f2..ffd14bb4678 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -322,7 +322,7 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
 
     gdb_register_coprocessor(cs, hexagon_hvx_gdb_read_register,
                              hexagon_hvx_gdb_write_register,
-                             gdb_find_static_feature("hexagon-hvx.xml"), 0);
+                             gdb_find_static_feature("hexagon-hvx.xml"));
 
     qemu_init_vcpu(cs);
     cpu_reset(cs);
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index b86520f8f9c..5c5fa727216 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -501,8 +501,7 @@ void x86_cpu_gdb_init(CPUState *cs)
     if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF) {
         gdb_register_coprocessor(cs, i386_cpu_gdb_get_egprs,
                                  i386_cpu_gdb_set_egprs,
-                                 gdb_find_static_feature("i386-64bit-apx.xml"),
-                                 0);
+                                 gdb_find_static_feature("i386-64bit-apx.xml"));
     }
 #endif
 
@@ -510,10 +509,9 @@ void x86_cpu_gdb_init(CPUState *cs)
     gdb_register_coprocessor(cs, x86_cpu_gdb_read_linux_register,
                              x86_cpu_gdb_write_linux_register,
 #ifdef TARGET_X86_64
-                             gdb_find_static_feature("i386-64bit-linux.xml"),
+                             gdb_find_static_feature("i386-64bit-linux.xml"));
 #else
-                             gdb_find_static_feature("i386-32bit-linux.xml"),
+                             gdb_find_static_feature("i386-32bit-linux.xml"));
 #endif
-                             0);
 #endif
 }
diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
index 23a5eecc20b..3e9bdfa8bbf 100644
--- a/target/loongarch/gdbstub.c
+++ b/target/loongarch/gdbstub.c
@@ -180,16 +180,16 @@ void loongarch_cpu_register_gdb_regs_for_features(CPUState *cs)
 
     if (FIELD_EX32(env->cpucfg[2], CPUCFG2, FP)) {
         gdb_register_coprocessor(cs, loongarch_gdb_get_fpu, loongarch_gdb_set_fpu,
-                                 gdb_find_static_feature("loongarch-fpu.xml"), 0);
+                                 gdb_find_static_feature("loongarch-fpu.xml"));
     }
 
     if (FIELD_EX32(env->cpucfg[2], CPUCFG2, LSX)) {
         gdb_register_coprocessor(cs, loongarch_gdb_get_lsx, loongarch_gdb_set_lsx,
-                                 gdb_find_static_feature("loongarch-lsx.xml"), 0);
+                                 gdb_find_static_feature("loongarch-lsx.xml"));
     }
 
     if (FIELD_EX32(env->cpucfg[2], CPUCFG2, LASX)) {
         gdb_register_coprocessor(cs, loongarch_gdb_get_lasx, loongarch_gdb_set_lasx,
-                                 gdb_find_static_feature("loongarch-lasx.xml"), 0);
+                                 gdb_find_static_feature("loongarch-lasx.xml"));
     }
 }
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index c566cb0a16c..9bab1843892 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -129,10 +129,10 @@ void m68k_cpu_init_gdb(M68kCPU *cpu)
 
     if (m68k_feature(env, M68K_FEATURE_CF_FPU)) {
         gdb_register_coprocessor(cs, cf_fpu_gdb_get_reg, cf_fpu_gdb_set_reg,
-                                 gdb_find_static_feature("cf-fp.xml"), 0);
+                                 gdb_find_static_feature("cf-fp.xml"));
     } else if (m68k_feature(env, M68K_FEATURE_FPU)) {
         gdb_register_coprocessor(cs, m68k_fpu_gdb_get_reg, m68k_fpu_gdb_set_reg,
-                                 gdb_find_static_feature("m68k-fp.xml"), 0);
+                                 gdb_find_static_feature("m68k-fp.xml"));
     }
     /* TODO: Add [E]MAC registers.  */
 }
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index ae41a1a3287..ec513ae82d4 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -265,8 +265,7 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
 
     gdb_register_coprocessor(cs, mb_cpu_gdb_read_stack_protect,
                              mb_cpu_gdb_write_stack_protect,
-                             gdb_find_static_feature("microblaze-stack-protect.xml"),
-                             0);
+                             gdb_find_static_feature("microblaze-stack-protect.xml"));
 
     qemu_init_vcpu(cs);
 
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index e0aae9c9eaf..4d622c5cad5 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -502,24 +502,23 @@ void ppc_gdb_init(CPUState *cs, PowerPCCPUClass *pcc)
 {
     if (pcc->insns_flags & PPC_FLOAT) {
         gdb_register_coprocessor(cs, gdb_get_float_reg, gdb_set_float_reg,
-                                 gdb_find_static_feature("power-fpu.xml"), 0);
+                                 gdb_find_static_feature("power-fpu.xml"));
     }
     if (pcc->insns_flags & PPC_ALTIVEC) {
         gdb_register_coprocessor(cs, gdb_get_avr_reg, gdb_set_avr_reg,
-                                 gdb_find_static_feature("power-altivec.xml"),
-                                 0);
+                                 gdb_find_static_feature("power-altivec.xml"));
     }
     if (pcc->insns_flags & PPC_SPE) {
         gdb_register_coprocessor(cs, gdb_get_spe_reg, gdb_set_spe_reg,
-                                 gdb_find_static_feature("power-spe.xml"), 0);
+                                 gdb_find_static_feature("power-spe.xml"));
     }
     if (pcc->insns_flags2 & PPC2_VSX) {
         gdb_register_coprocessor(cs, gdb_get_vsx_reg, gdb_set_vsx_reg,
-                                 gdb_find_static_feature("power-vsx.xml"), 0);
+                                 gdb_find_static_feature("power-vsx.xml"));
     }
 #ifndef CONFIG_USER_ONLY
     gdb_gen_spr_feature(cs);
     gdb_register_coprocessor(cs, gdb_get_spr_reg, gdb_set_spr_reg,
-                             &pcc->gdb_spr, 0);
+                             &pcc->gdb_spr);
 #endif
 }
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index a053009ccd3..6a5b7a82fd4 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -348,32 +348,27 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
     CPURISCVState *env = &cpu->env;
     if (env->misa_ext & RVD) {
         gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
-                                 gdb_find_static_feature("riscv-64bit-fpu.xml"),
-                                 0);
+                                 gdb_find_static_feature("riscv-64bit-fpu.xml"));
     } else if (env->misa_ext & RVF) {
         gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
-                                 gdb_find_static_feature("riscv-32bit-fpu.xml"),
-                                 0);
+                                 gdb_find_static_feature("riscv-32bit-fpu.xml"));
     }
     if (cpu->cfg.ext_zve32x) {
         gdb_register_coprocessor(cs, riscv_gdb_get_vector,
                                  riscv_gdb_set_vector,
-                                 ricsv_gen_dynamic_vector_feature(cs, cs->gdb_num_regs),
-                                 0);
+                                 ricsv_gen_dynamic_vector_feature(cs, cs->gdb_num_regs));
     }
     switch (mcc->def->misa_mxl_max) {
     case MXL_RV32:
         gdb_register_coprocessor(cs, riscv_gdb_get_virtual,
                                  riscv_gdb_set_virtual,
-                                 gdb_find_static_feature("riscv-32bit-virtual.xml"),
-                                 0);
+                                 gdb_find_static_feature("riscv-32bit-virtual.xml"));
         break;
     case MXL_RV64:
     case MXL_RV128:
         gdb_register_coprocessor(cs, riscv_gdb_get_virtual,
                                  riscv_gdb_set_virtual,
-                                 gdb_find_static_feature("riscv-64bit-virtual.xml"),
-                                 0);
+                                 gdb_find_static_feature("riscv-64bit-virtual.xml"));
         break;
     default:
         g_assert_not_reached();
@@ -381,7 +376,6 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
 
     if (cpu->cfg.ext_zicsr) {
         gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
-                                 riscv_gen_dynamic_csr_feature(cs, cs->gdb_num_regs),
-                                 0);
+                                 riscv_gen_dynamic_csr_feature(cs, cs->gdb_num_regs));
     }
 }
diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index 9ae715add4d..efdaaefa6d0 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -347,34 +347,33 @@ void s390_cpu_gdb_init(CPUState *cs)
 {
     gdb_register_coprocessor(cs, cpu_read_ac_reg,
                              cpu_write_ac_reg,
-                             gdb_find_static_feature("s390-acr.xml"), 0);
+                             gdb_find_static_feature("s390-acr.xml"));
 
     gdb_register_coprocessor(cs, cpu_read_fp_reg,
                              cpu_write_fp_reg,
-                             gdb_find_static_feature("s390-fpr.xml"), 0);
+                             gdb_find_static_feature("s390-fpr.xml"));
 
     gdb_register_coprocessor(cs, cpu_read_vreg,
                              cpu_write_vreg,
-                             gdb_find_static_feature("s390-vx.xml"), 0);
+                             gdb_find_static_feature("s390-vx.xml"));
 
     gdb_register_coprocessor(cs, cpu_read_gs_reg,
                              cpu_write_gs_reg,
-                             gdb_find_static_feature("s390-gs.xml"), 0);
+                             gdb_find_static_feature("s390-gs.xml"));
 
 #ifndef CONFIG_USER_ONLY
     gdb_register_coprocessor(cs, cpu_read_c_reg,
                              cpu_write_c_reg,
-                             gdb_find_static_feature("s390-cr.xml"), 0);
+                             gdb_find_static_feature("s390-cr.xml"));
 
     gdb_register_coprocessor(cs, cpu_read_virt_reg,
                              cpu_write_virt_reg,
-                             gdb_find_static_feature("s390-virt.xml"), 0);
+                             gdb_find_static_feature("s390-virt.xml"));
 
     if (kvm_enabled()) {
         gdb_register_coprocessor(cs, cpu_read_virt_kvm_reg,
                                  cpu_write_virt_kvm_reg,
-                                 gdb_find_static_feature("s390-virt-kvm.xml"),
-                                 0);
+                                 gdb_find_static_feature("s390-virt-kvm.xml"));
     }
 #endif
 }
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 792bf70a145..2874ce1b350 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -271,20 +271,16 @@ void sparc_cpu_register_gdb_regs(CPUState *cs)
 #if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
     gdb_register_coprocessor(cs, sparc_fpu_gdb_read_register,
                              sparc_fpu_gdb_write_register,
-                             gdb_find_static_feature("sparc32-fpu.xml"),
-                             0);
+                             gdb_find_static_feature("sparc32-fpu.xml"));
     gdb_register_coprocessor(cs, sparc_cp0_gdb_read_register,
                              sparc_cp0_gdb_write_register,
-                             gdb_find_static_feature("sparc32-cp0.xml"),
-                             0);
+                             gdb_find_static_feature("sparc32-cp0.xml"));
 #else
     gdb_register_coprocessor(cs, sparc_fpu_gdb_read_register,
                              sparc_fpu_gdb_write_register,
-                             gdb_find_static_feature("sparc64-fpu.xml"),
-                             0);
+                             gdb_find_static_feature("sparc64-fpu.xml"));
     gdb_register_coprocessor(cs, sparc_cp0_gdb_read_register,
                              sparc_cp0_gdb_write_register,
-                             gdb_find_static_feature("sparc64-cp0.xml"),
-                             0);
+                             gdb_find_static_feature("sparc64-cp0.xml"));
 #endif
 }
-- 
2.47.3


