Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19E3C98328
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMRr-00057Z-MP; Sat, 26 Sep 2026 03:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMQF-0002nL-Fb
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:02:12 -0400
Received: from mail-dl2-x0f.google.com ([2607:f8b0:4864:38::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMQD-0000Uz-NC
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:02:11 -0400
Received: by mail-dl2-x0f.google.com with SMTP id
 a92af1059eb24-144f7915355so1353795c88.3
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406128; x=1791010928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bnB/iWAyXAxW1TeHJut1enjEPN/SkInFqx09vCaNhBQ=;
 b=AKGJA1xTPEf7WTCpy144cfkwtzvLzIhsMn9pKEuNGOp+ck3v1V7AwrnBWP97QELVNa
 NRQCt+6JhnLNSl/MoVfBLlPXy+wM6Fro/enjeo5hECI+ZVV335ubSuNz8E9v/WbR0Zod
 VufDjdSrF5fmKjJRH7gY5H+cQp/nIVv1cJTff7IN2ymd0KWjWM5WKWwj56OjZcLhYuOj
 NigEOmnph/BXoxiNIR4OuMg6Iabi/f+d/71zgln7l625/WmTIMgZVnJu+Xk+QEtE2iPj
 YikGM9ctYStZhbh13LsHCY0yOKmcLkPGBWr2wmB4jnCv6saptflfGqxkuhIFaVqsOwL4
 lSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406128; x=1791010928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bnB/iWAyXAxW1TeHJut1enjEPN/SkInFqx09vCaNhBQ=;
 b=VwSyIMjkLM2h+TLCvdVq0aLiSBZP+pvdZjwp5Z30vPar1PZKnH6cWSaB5uNr5VhE/a
 IeBEL85DRkeOapvm/oirXO6ALFyQL5eYoenM33QiDJWd6SfhECavkVt5DdRXkkuh4/Im
 B75V8Ub9bRt6sLEteNMjMfoLGiILQ/EbFcIuI3B19T6gqwA15EZfnrDQIvh1vUf+iyEh
 QkgcYRD029wx42sPU8fAnTINMjL+uYl6hZEWQaY5h3wcMH8hVdb7g7vb3B07CYtkInEO
 4yio/j+0II6Wm2oj+Ajl+ZMIAXX6mt4zBFUk6Rf6cmGwv1FomURDqdj4F2NODx9B2TSf
 Ht/Q==
X-Gm-Message-State: AFuF++kkgR/MMpvWm2RxUpMDFCO+4z3jeGoXHo+p3M6mnmAwwF2b95Ts
 IowEWZ+xHJV1GGNemg0INKsXTvIwvvqQju3kYQcC6QdN0h5DMq2uUN5dzzty2v75
X-Gm-Gg: AYBFou3W3KvStHBS4quNC+iBLCv8Ya4mZkFqcgcBd7ZYzWE9aicDQ2KQ9XmRQeYw/hk
 vAWvnI94bMeu9CKsuuXJUY8GyBMLCIsqsOse20gSrT0NnLkIAdYiTg8uu0MSscAOsyQOjIJLmrM
 9zGuW/pPZIgy1UZ3biOYEyEnDU6XRD+VXMlcHmBe9/KJ/n1bXzsPML8KMpWhCt45a144AqWRgeH
 B9bjdUBAXGzcrQzSiPvtHKfizocoT9P5cVjf37O5ZS+WF0VQkIJuD+c6B0CdBGn1qfXLgBJKUtH
 8L8vR6ze7NGgM3dGaBqHbe1+W/3G70hoouTH3D9bcwxgSfdVMqjfOVFqFi0sUK4gHO24CwUIbIZ
 Y4IgdGsl4JIsKzGgQoSvosIGqui2vHQtGfAcnu6mYlg0xRgyc9Zyig6VweTIXfvb2Tolouk5tIp
 0/HCfyffoEy6GhqO788wvNPwZ9JNiyWQsN6QR5g+/1XbhCl9qRPiSUYHumUmZNqpUuR7sx7Ldyl
 oPfFUWkWntGOAhfC4/vnRrIpeJwNAc=
X-Received: by 2002:a05:701b:2059:20b0:143:7001:7643 with SMTP id
 a92af1059eb24-146d096d4bamr2224508c88.46.1790406128075; 
 Sat, 26 Sep 2026 00:02:08 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:02:07 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 16/55] target/arm: gate -cpu host with TypeIsAvailable
Date: Sat, 26 Sep 2026 15:00:15 +0800
Message-ID: <20260926070057.1234-17-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Register the host ARMCPU type for every target and hide it with
is_available. aarch64_host_initfn picks kvm, hvf, whpx, or nitro
from TargetKconfig instead of CONFIG_* ifdefs.

- Add ARMCPUInfo.is_available and pass it from arm_cpu_register
- target_has_arm_host_cpu covers kvm, hvf, whpx, and nitro
- Add hvf and whpx set_cpu_features_from_host stubs

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/arm/cpu.c            |  1 +
 target/arm/cpu.h            |  1 +
 target/arm/cpu64.c          | 43 +++++++++++++++++++++----------------
 target/arm/hvf/hvf-stub.c   | 14 ++++++++++++
 target/arm/hvf/meson.build  |  1 +
 target/arm/whpx/whpx-stub.c |  5 +++++
 6 files changed, 47 insertions(+), 18 deletions(-)
 create mode 100644 target/arm/hvf/hvf-stub.c

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c138c4c0587..9b498632c86 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2685,6 +2685,7 @@ void arm_cpu_register(const ARMCPUInfo *info)
         .instance_init = arm_cpu_instance_init,
         .class_init = info->class_init ?: cpu_register_class_init,
         .class_data = info,
+        .is_available = info->is_available,
     };
 
     type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e3f931dba26..87de7e9ff09 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1177,6 +1177,7 @@ typedef struct ARMCPUInfo {
     const char *deprecation_note;
     void (*initfn)(Object *obj);
     void (*class_init)(ObjectClass *oc, const void *data);
+    TypeIsAvailable *is_available;
 } ARMCPUInfo;
 
 /**
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 03f3d55f6ba..168639ac2f4 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -20,6 +20,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/target-info.h"
+#include "qemu/target-kconfig-has.h"
 #include "cpu.h"
 #include "cpregs.h"
 #include "qemu/module.h"
@@ -757,37 +759,42 @@ static void aarch64_a53_initfn(Object *obj)
 void aarch64_host_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
+    const TargetInfo *ti = target_info();
 
-#if defined(CONFIG_NITRO)
-    if (nitro_enabled()) {
+    if (target_has_kconfig_nitro(ti) && nitro_enabled()) {
         /* The nitro accel uses -cpu host, but does not actually consume it */
         return;
     }
-#endif
 
-#if defined(CONFIG_KVM)
-    kvm_arm_set_cpreg_mig_tolerances(cpu);
-    kvm_arm_set_cpu_features_from_host(cpu);
-    aarch64_add_sve_properties(obj);
-#elif defined(CONFIG_HVF)
-    hvf_arm_set_cpu_features_from_host(cpu);
-#elif defined(CONFIG_WHPX)
-    whpx_arm_set_cpu_features_from_host(cpu);
-#else
-    cpu->host_cpu_probe_failed = true;
-#endif
+    if (target_has_kconfig_kvm(ti)) {
+        kvm_arm_set_cpreg_mig_tolerances(cpu);
+        kvm_arm_set_cpu_features_from_host(cpu);
+        aarch64_add_sve_properties(obj);
+    } else if (target_has_kconfig_hvf(ti)) {
+        hvf_arm_set_cpu_features_from_host(cpu);
+    } else if (target_has_kconfig_whpx(ti)) {
+        whpx_arm_set_cpu_features_from_host(cpu);
+    } else {
+        cpu->host_cpu_probe_failed = true;
+    }
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_pauth_properties(obj);
     }
 }
 
+static bool target_has_arm_host_cpu(const TargetInfo *ti)
+{
+    return target_has_kconfig_kvm(ti)
+        || target_has_kconfig_hvf(ti)
+        || target_has_kconfig_whpx(ti)
+        || target_has_kconfig_nitro(ti);
+}
+
 static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "cortex-a57",         .initfn = aarch64_a57_initfn },
     { .name = "cortex-a53",         .initfn = aarch64_a53_initfn },
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF) || defined(CONFIG_WHPX) || \
-    defined(CONFIG_NITRO)
-    { .name = "host",               .initfn = aarch64_host_initfn },
-#endif
+    { .name = "host",               .initfn = aarch64_host_initfn,
+      .is_available = target_has_arm_host_cpu },
 };
 
 static void aarch64_cpu_register_types(void)
diff --git a/target/arm/hvf/hvf-stub.c b/target/arm/hvf/hvf-stub.c
new file mode 100644
index 00000000000..3c8148316c9
--- /dev/null
+++ b/target/arm/hvf/hvf-stub.c
@@ -0,0 +1,14 @@
+/*
+ * QEMU HVF ARM specific function stubs
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hvf_arm.h"
+
+void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/hvf/meson.build b/target/arm/hvf/meson.build
index afc509a470e..055fab56fb6 100644
--- a/target/arm/hvf/meson.build
+++ b/target/arm/hvf/meson.build
@@ -1,3 +1,4 @@
 arm_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
   'hvf.c',
 ))
+arm_stubs_ss.add(files('hvf-stub.c'))
diff --git a/target/arm/whpx/whpx-stub.c b/target/arm/whpx/whpx-stub.c
index 32e434a5f6a..3d1cbb33a28 100644
--- a/target/arm/whpx/whpx-stub.c
+++ b/target/arm/whpx/whpx-stub.c
@@ -13,3 +13,8 @@ uint32_t whpx_arm_get_ipa_bit_size(void)
 {
     g_assert_not_reached();
 }
+
+void whpx_arm_set_cpu_features_from_host(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
-- 
2.52.0.windows.1


