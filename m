Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6BB606A329
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gdzSkZEU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP2HS-00058R-2w; Thu, 05 Nov 2026 13:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2HF-00056y-Ee
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:33:34 -0500
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2HA-0007e9-Hs
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:33:30 -0500
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-36eb1cb7aabso1098904eec.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 10:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793903607; x=1794508407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EFNSrzxzwfKs1jErYYgeJAHc5AJGMN0OaeLJcCaY8O4=;
 b=gdzSkZEU/SFeTIu2o4n9dtHpqPTKMtjwNmMabat86uD29Z2jsKrpFOFSfFmJvlGERR
 RKU71RWSerlgcr9O3kvf6w+mPAIlxpoHpX/YIAootbpBXcRDVVBzEkz70W8aEa4c1T6h
 V6KrXaCvD1jImRbWzDc4LHZyWYJ6q169iYq9oogZytI8M4swXS7tY9vqO5QXJIVZL8a1
 LN5ZB+N766YxHa+WObppwQdnlcZ0hMGM71TUeegARFnqhpjmpPgx/Hz+5MqqqXIgdsX8
 EOHSQfxOBG1FgMt+YkoRvEor5mwD4SJdwF3ZuLXlj99CnvQr2ce1Ii6Zfru7Qv9cvhGo
 pTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793903607; x=1794508407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EFNSrzxzwfKs1jErYYgeJAHc5AJGMN0OaeLJcCaY8O4=;
 b=N6SgZCIltCR9WndtbWjCX8dk+RHy+bVvzKdz9SaDTF7Wc3KVuI0tkqsnOheZA3nyCI
 4iSfHdxyhNWQhgmNDAnGu5o/O1R7wglfIIp9boQ4EZzklC7ODlqRqpEYDb/Y+Ya41xgB
 hm7y8NmzwX63mZItCRhHkjfClhIoQGL787RQOWQJlNyBd+sirgbwSw0/vA54vWmnd7Dv
 3FfNI4QXP+gD2IeIS3qC4B2JYKH8HYcYI9pjeBs+zD7lBZh5ayJDxxAnftBzlmi9Cn4l
 6HAPHyIReXufKU+KZcPHmZDwRcusLbt/oZFUZRAX64UlbF1e/xXASWhAavieNxN7oDIP
 AFzA==
X-Gm-Message-State: APuU4Z9DzMUiPnHdp8xUyiDPwT3r2f32pThAuZPjIVSz871o61FYPdwh
 AL1GQxLpou0OdN2dWMgT5Smc54Kkb6c+K/484oIBe1ftc0jki7UjHG/QCCrTKjyeBzU=
X-Gm-Gg: AYBFou2heYilndVEVl1twcJGhl4I8NcHXyDXSt8n/UDtdDwgePOt/p1ekwQxOdH8Wsr
 DzZEy/H5kCHjwkubkiNqJNwl+Pe34NRlWrRnzj/YZy8GrqeD0VgBjTH8S3FPgFlpZ5aCzOlX8On
 GNBtcFZ8ZdW6WuS22i+zCAgDYZ3OXLLJbB0yAdNZCMbJUfL3Q0A5A0aCts9BSu4bHPLCUg4u5Iu
 0oGg7L0vYA32hML3slgc6wcvwWncRvQT1gsuth6UT5DHxdQkqXvO562a9SiZlmKA/9PnW+DmUNC
 AZjTQJ45CnqoZbwoYIPlS26EXuIxLvVs7Fl8uwc/3qw/5t6Dzo1RCJNwN0WZUfG+sseiL6fxKvY
 dBIjJMUwi92fqH2Q7Asmm7vNwYeTU9fOnNCqJ0ICQ0voUvpxhyMkPGdfRC/vvitMXVP4mxJcFp5
 sNHlVdjwIRZAbInkz8aYQ9GyY8cLwA9phLIQaaPDxBndFT/fLhT8ebj5tdrWdyzeC1Qqc/eWB0X
 A0GL21/7t6cllVZiYkWffiKWUOdTxY8yXKDtIGO6bjQ+sUgYrOki33nBgu7jmIJfH/XGDz3ixeE
 Z2HMddGPfZ285zLLndwnIpfTK414u1TwO/I8rDPQlnBXNKFk
X-Received: by 2002:a05:693c:839a:20b0:36e:371:8255 with SMTP id
 5a478bee46e88-36f6fb7f6b0mr36858eec.0.1793903606279; 
 Thu, 05 Nov 2026 10:33:26 -0800 (PST)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-36f66086a4asm277795eec.0.2026.11.05.10.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 10:33:25 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Peter Maydell <peter.maydell@linaro.org>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v4 1/3] accel: register CPU parent only for AccelCPU subclasses
Date: Fri,  6 Nov 2026 02:33:07 +0800
Message-ID: <20261105183310.1614-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261105183310.1614-1-luoyonggang@gmail.com>
References: <20261105183310.1614-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132e.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
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
test-multi-target checks the parent only for the CPU types that
register it.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 accel/accel-common.c           |  6 ++----
 include/accel/accel-cpu.h      |  2 ++
 target/arm/cpu.c               |  2 ++
 target/i386/cpu.c              |  2 ++
 target/ppc/cpu_init.c          |  2 ++
 target/riscv/cpu.c             |  8 ++++++++
 tests/unit/test-multi-target.c | 25 +++++++++++++++++++++++++
 7 files changed, 43 insertions(+), 4 deletions(-)

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
diff --git a/tests/unit/test-multi-target.c b/tests/unit/test-multi-target.c
index c7559827a0..fd44cf74ca 100644
--- a/tests/unit/test-multi-target.c
+++ b/tests/unit/test-multi-target.c
@@ -30,6 +30,28 @@
 /* stub for system/main.c */
 int (*qemu_main)(void);
 
+static void test_accel_cpu_parent(const TargetInfo *ti)
+{
+    static const char * const needed[] = {
+        "arm-cpu",
+        "i386-cpu",
+        "powerpc-cpu",
+        "powerpc64-cpu",
+        "riscv-cpu",
+        "x86_64-cpu",
+    };
+    size_t i;
+    g_autofree char *name = NULL;
+
+    for (i = 0; i < ARRAY_SIZE(needed); i++) {
+        if (g_str_equal(ti->cpu_type, needed[i])) {
+            name = g_strconcat("accel-", ti->cpu_type, NULL);
+            g_assert_nonnull(object_class_by_name(name));
+            return;
+        }
+    }
+}
+
 static void test_qom_types_are_unique(const void *data)
 {
     const TargetInfo *ti = data;
@@ -49,6 +71,9 @@ static void test_qom_types_are_unique(const void *data)
     module_call_init(MODULE_INIT_QOM);
     /* trigger type_initialize for all types */
     object_class_get_list("", false);
+
+    /* Accel parent lookup depends on the QOM types above being unique. */
+    test_accel_cpu_parent(ti);
 }
 
 int main(int argc, char **argv)
-- 
2.55.0.windows.3


