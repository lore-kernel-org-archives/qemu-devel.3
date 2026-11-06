Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86374606D802
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 02:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yHZqTA/w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP9sR-0006Oq-9s; Thu, 05 Nov 2026 21:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP9s5-00066k-Ug
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 21:40:08 -0500
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP9rw-0005xs-DI
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 21:40:02 -0500
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-1ae18eb9b69so297853c88.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 18:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793932794; x=1794537594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LAgFtZI3pjCQTGA6+IKL/nBbms5kZLlBrfMfKvaI13I=;
 b=yHZqTA/w3iCEb3Ey7Nxjnv+f9bo/ZWfL2eM0EIG13r+eRWOJX2Oe4EnQH/daa4rPov
 nCnu5sGouX5nBQqCovtWXazyE+8UDNtNS1Lh27t0gPtJRHZD3oOx6pTOo0CEb9Iavbv2
 zGk4byVZiwFluI9MlNRSrm4u8ejAEvrpPfed6/UDA4q2b+OKEhASGYv1JrZEHznl9POL
 jzJPu7RyGvuwqxZ9P//IojbWiupidU1EXNqj1G6LKGA9jbXmn4XMWUkYbGs6FP4s5jtb
 2hC4ytawiDlRjTT3oXb3wz7raA8gHf+xvIlQFnnoxI2pdH9SQGEtUj8UvmYxy1QLo1ok
 kUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793932794; x=1794537594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LAgFtZI3pjCQTGA6+IKL/nBbms5kZLlBrfMfKvaI13I=;
 b=fZ4hhx4z0U9XxMr5XI7IzEcvdSVeTlHa4Wr6U2494za5EJwo7XRJVyGvHcdAeb+Dq3
 86bIMGdXcCMIBosLrMkCc+w2CCkXA+K5QVDGlOWzoJr9vJHC7z8sc8U3LQTsU+wdI0Xj
 WK8iJhxFVW2e5ESvNVtWvWop01EYecGL7SiZXkfc6RbgXuZBM3dfsqphQGJ1TnwRekXe
 STYQ/tZv4Q6bIMom7gCTIjbIbMubjlxViLw9cnypPQWFcmkUR2rSjME/gz3229fs7QUb
 iss6HzMn8NH/VJCU6f2Whzy2Ydn+XUHeuMuaSj/D/BZtKsabEapyTxEuHjAmzKpQLzTP
 /uWg==
X-Gm-Message-State: APuU4Z9cy23C0NDEyS7v71ibS7+UsJfEnyTMXS6ZHimPBaPacLRJglPL
 aVur+GDJwQLZ/mhGcADEhh+ZPVQL0gEgcT9pnDlgVaY6JZ043VN1lLds/O1mLukc
X-Gm-Gg: AYBFou3vCAMyfH0yhQ6+hJgrh4luNqkpzCIpGHfJkICdWYXsW3CLDMxc1LJBapf6/s+
 MR033m5zUNK3Dy7kysYp82p7hwVOtd23vSoIOQ0MQh7W13QBEjlqspbCtwwAqEvPh9SxmzENLV2
 gQFpbCaK2Udx0nQB7PsxhZlzt9M1q8YEqcgu1dpRLMyj+YAFoVcR+DALlKJrqubLqQl1EAHUCQu
 k5x1G4ZFZ76ToByJXmXXEuIaR/t7K6ikfJ2WRDC0EyQct2DNfa3PvJOcIZlG2fsfdP/eeS59RQD
 Q+1iJjiWfg/SKcFamBTUHvlGKQQgjwG5DErfDCrPn/Tn56gUmztRGoO6gKobbu2l1bsm7nqf8Do
 q6kjT3i5/LNZA1vUlARfZdQjGdRmwTSl8NQhBRnpP4ACA88+XeDB5E3e4VmSOQV2PmZbt7a0VNS
 4bT/tXM+rZMlSSwGH34tBMkh4JRWFhXSfM7vVhZKPGMt+xKZC/RNaGd3ajxf+JlZuURrM/5sRl5
 x8Df/Za7wCV4CsJPTzy9c04HFv2F7q4sF7czgMv/dprv0wm/VtwKbuSU8W70LOesXQ8/u7Ry6ic
 Y6c6Yu7vaAh/YBoQVxQu1vh/BH+Fp7nQY8WmnhTM7/hzwlYS
X-Received: by 2002:a05:701b:4346:b0:18d:9eec:e0be with SMTP id
 a92af1059eb24-1b25d286bafmr1250066c88.2.1793932793411; 
 Thu, 05 Nov 2026 18:39:53 -0800 (PST)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1b25e4efa6fsm1108318c88.20.2026.11.05.18.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 18:39:52 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Chao Liu <chao.liu@processmission.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v5 1/3] accel: register CPU parent only for AccelCPU subclasses
Date: Fri,  6 Nov 2026 10:39:33 +0800
Message-ID: <20261106023936.772-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261106023936.772-1-luoyonggang@gmail.com>
References: <20261106023936.772-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

accel_cpu_register_type() creates the abstract parent
accel-<cpu type>. A subclass names that parent, and
type_initialize() aborts when the parent is missing. The old
type_init registered only target_cpu_type(), which is one name
in a multi-target process. Call the helper from the CPU type
init of each target that has an AccelCPU subclass.

ARM calls it because whpx-common.c parents accel-arm-cpu on
aarch64-softmmu. i386 calls it for TCG, KVM, HVF, NVMM, and
MSHV. i386-softmmu and x86_64-softmmu each pass their own
CPU_RESOLVING_TYPE, so WHPX on x86_64-softmmu finds
accel-x86_64-cpu. RISC-V calls it for TCG and KVM. PowerPC
calls it for KVM.

Other targets have no AccelCPU subclass. Machine init looks up
tcg-accel-<cpu type> or kvm-accel-<cpu type> and skips a missing
class, so those targets do not need the parent.

No extra tests is needed, as these QOM types already be
tested by the existing logic instantiating all QOM types.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 accel/accel-common.c      | 6 ++----
 include/accel/accel-cpu.h | 2 ++
 target/arm/cpu.c          | 2 ++
 target/i386/cpu.c         | 2 ++
 target/ppc/cpu_init.c     | 2 ++
 target/riscv/cpu.c        | 8 ++++++++
 6 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/accel/accel-common.c b/accel/accel-common.c
index 00a400243f..441d1b77fa 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -130,9 +130,9 @@ static const TypeInfo accel_types[] = {
 
 DEFINE_TYPES(accel_types)
 
-static void register_accel_target_type(void)
+void accel_cpu_register_type(const char *cpu_type)
 {
-    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
+    g_autofree char *name = g_strconcat("accel-", cpu_type, NULL);
     const TypeInfo accel_cpu_type = {
         .name = name,
         .parent = TYPE_OBJECT,
@@ -142,5 +142,3 @@ static void register_accel_target_type(void)
 
     type_register_static(&accel_cpu_type);
 }
-
-type_init(register_accel_target_type);
diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
index 9e7eede7c3..2fdb64d2ae 100644
--- a/include/accel/accel-cpu.h
+++ b/include/accel/accel-cpu.h
@@ -20,4 +20,6 @@ typedef struct AccelCPUClass {
     bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
 } AccelCPUClass;
 
+void accel_cpu_register_type(const char *cpu_type);
+
 #endif /* ACCEL_CPU_H */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 71681447b2..725f1f3a5f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "accel/accel-cpu.h"
 #ifdef CONFIG_TCG
 #include "exec/translation-block.h"
 #include "accel/tcg/cpu-ops.h"
@@ -2753,6 +2754,7 @@ static const TypeInfo arm_cpu_type_info = {
 
 static void arm_cpu_register_types(void)
 {
+    accel_cpu_register_type(CPU_RESOLVING_TYPE);
     type_register_static(&arm_cpu_type_info);
 }
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eab0d5a4d4..31b09e6f8e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/qemu-print.h"
 #include "qemu/hw-version.h"
 #include "cpu.h"
+#include "accel/accel-cpu.h"
 #include "tcg/helper-tcg.h"
 #include "exec/translation-block.h"
 #include "system/hvf.h"
@@ -11093,6 +11094,7 @@ static void x86_cpu_register_types(void)
 {
     int i;
 
+    accel_cpu_register_type(CPU_RESOLVING_TYPE);
     type_register_static(&x86_cpu_type_info);
     for (i = 0; i < ARRAY_SIZE(builtin_x86_defs); i++) {
         x86_register_cpudef_types(&builtin_x86_defs[i]);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7f3036d903..fe3f2549b7 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -43,6 +43,7 @@
 #include "exec/page-protection.h"
 #include "exec/watchpoint.h"
 #include "helper_regs.h"
+#include "accel/accel-cpu.h"
 #include "internal.h"
 #include "spr_common.h"
 #include "power8-pmu.h"
@@ -7589,6 +7590,7 @@ static const TypeInfo ppc_vhyp_type_info = {
 
 static void ppc_cpu_register_types(void)
 {
+    accel_cpu_register_type(CPU_RESOLVING_TYPE);
     type_register_static(&ppc_cpu_type_info);
 #ifndef CONFIG_USER_ONLY
     type_register_static(&ppc_vhyp_type_info);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 362e561809..10e24f20e8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -25,6 +25,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/atomic.h"
 #include "cpu.h"
+#include "accel/accel-cpu.h"
 #include "cpu_vendorid.h"
 #include "target/riscv/tcg/csr.h"
 #include "internals.h"
@@ -3931,3 +3932,10 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 };
 
 DEFINE_TYPES(riscv_cpu_type_infos)
+
+static void riscv_accel_cpu_register_type(void)
+{
+    accel_cpu_register_type(CPU_RESOLVING_TYPE);
+}
+
+type_init(riscv_accel_cpu_register_type)
-- 
2.55.0.windows.3


