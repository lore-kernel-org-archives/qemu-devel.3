Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE63C61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIc1-0003y5-7w; Wed, 26 Aug 2026 14:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wzIbz-0003sp-C0
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:44:35 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wzIbu-0002k7-Gu
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:44:35 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2d5cad1a6baso13433975ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787769869; x=1788374669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ocNlaKj0Aj7r7mfXj5r6DZmfYzPBHg5nq6gU1YFSqCw=;
 b=RpmPGuoigPpQeSw8tqwwXnqLu35NPTQ70J0DiaYeys1i6R+jKYjqPa3YZiOOk1Apmv
 jv+b3C4G3klxSWhGodg+sTzV07wJIvExibh1RoW08tPRleIhd2NHQI6TMTESgTqlc775
 du6KbWRtUD56yxu0TxlLOBg+BtKrgR9+HYY3dHGp7F/alDUVbo+FPup8TJuDUvhMAtVB
 usfxmwXEwZz6MFkIAldNT5RHPX99YSEUVoaVj8WX46dkj2BVLJGuyGKVzHvIKsewEBLN
 aRC2fr8Jd92UXL6PtbKswQt2snQcmUGfNXedlILI+Ec/xCIP7KhMOXNJJnmJNz81CV9I
 fI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787769869; x=1788374669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ocNlaKj0Aj7r7mfXj5r6DZmfYzPBHg5nq6gU1YFSqCw=;
 b=R2Xgr5QMgp8tsgtPaMMUZVySvNNhR3TfhHJZU9TtDWwTjuLCNaWTjQCJV3dc/kOyM8
 /i781sFSHuDNym+xslmaMcptOeVBGysz4cCnPZbx9F4P5rPmCgvod5ChHjzKpXmLxCBD
 vJlt0qqrWDtNP2aAbNN2adrvfvVjDsGUDiMSchMPCzcbDegIzdfNlevI0cPmQwSgdnCT
 K6FVACyOauyuIzKj6LEETWmbQs3ytaMGz+6kBZNB2hxhi3g+aYk0VhQke/cnvCfi8Xv1
 WkjupDSxPKsaVATo5HPmACGvNeLdxIuOHuJ7pLLm9UbQwSzInQTvkpDkbLAfAcLfzLhJ
 czFw==
X-Gm-Message-State: AFuF++n8FWvGGfniFN+Y89O9LaTsB8RkVzNpK19GndLxaGUacC7gVlkz
 YMXkrvUlHJyZ95lNsDHWfeVyeW7Qq8LCzYzm1AjEz2W7LSzh36mvbqsuTm1QGa/yZbU=
X-Gm-Gg: AR+sD12f3imdPQGJd2TjPJTtxs8KRRdgutKV1ObdlI/tTYy9cht9IxO2jLvvD5Sroks
 6HCh96gXGJwQB0bcBoIgCLpyX2v13cuwIDHDRN6PpZAQBKxdioZ6KOuJevU6YdASX0hTTn1RJDN
 1dlq6Pv3C9c1xrVT+N1JqKoRORS+hMmJrrkA6vf4R+E4kRVuM18k9n6/vUJjbO7QOfHWEgtzeyH
 bx1+dEQNTzx11JLPNo/FPJQfaC281hZ97AuK2ZzkrsKObZnv2Un0EzLu45g6MulQrSbuWWleS+N
 HWgtu/icuXF5Vvw0eifGzVlhptY53q6E8IWgRUjyRhrWv1IOHJxAqylozurAf53hGCVyDC62prS
 IWLwCmdSCt5HQI9Fgs7MVJc7NiVQ2koEMPJhuiT5bQOrIts9op/+FpIs0e/IQdfiOIKxqmfJx2k
 Uezkc+uXrMYhSAWvX2FWFfjSebAo6ghgPkun9w9qa/tPg+mkOpIhFkZB1+7YlNs1stXZKGRgl43
 BfFamMGYr5mtPTS0lr9Fxg=
X-Received: by 2002:a17:903:94c:b0:2cf:8131:75e8 with SMTP id
 d9443c01a7336-2d707b61486mr164693075ad.13.1787769868770; 
 Wed, 26 Aug 2026 11:44:28 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-3283d60c291sm17681846eec.6.2026.08.26.11.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 11:44:27 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-riscv@nongnu.org,
 Song Gao <17746591750@163.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>, David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Bibo Mao <maobibo@loongson.cn>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alexander Bulekov <alxndr@bu.edu>, Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-arm@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH v2 12/13] target-info: dispatch CPU QMP, dump,
 and arm/riscv semihosting
Date: Thu, 27 Aug 2026 02:42:26 +0800
Message-ID: <20260826184229.1145-13-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260826184229.1145-1-luoyonggang@gmail.com>
References: <20260826184229.1145-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

- Combined binaries cannot keep one global C symbol per arch for
  query-cpu-definitions, dump notes, or Angel semihosting. Put those
  handlers on a process-wide TargetCpuOps table and fill one member
  at a time.
- TARGET_INFO_CPU_OP is type_init (MODULE_INIT_QOM). That runs after
  target_info_qom_set_target(), so ELF constructors only queue the
  callback. target_info_register_cpu_op() stores the impl only when
  cpu_type matches the selected TargetInfo; a duplicate slot is
  reported and ignored. A NULL member means this target has no
  handler, not "too early".
- Keep the table in target-info.c (common_ss) and filter with
  target_info()->cpu_type so user-mode can resolve TARGET_INFO_CPU_OP.
  Take the address of the impl so the same macro stores both function
  pointers and ops tables.
- QMP query-cpu-definitions and query-cpu-model-expansion dispatch
  from hw/core/machine-qmp-cmds.c. Dump cpu_get_dump_info and
  cpu_get_note_size dispatch from hw/core/cpu-system.c. Arch handlers
  are static with an arch prefix (s390_query_*, arm_get_dump_info,
  ...). ppc and mips drop expansion stubs; the dispatcher errors
  instead.
- Angel semihosting uses CPUSemihostingOps on TargetCpuOps.semihosting.
  ARM and RISC-V keep a static ops table in common-semi-target.c and
  register it with TARGET_INFO_CPU_OP. Wrappers in common-semi.h call
  target_info_cpu_ops()->semihosting. Always compile those files so
  both tables exist in a combined link.
- Drop stubs/qmp-cpu.c and stubs/dump.c: every system binary has the
  wrappers, and tools do not implement these commands. Keep
  stubs/qmp-cpu-s390x.c for comparison/baseline.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 MAINTAINERS                           |  1 -
 hw/core/cpu-system.c                  | 23 +++++++++++
 hw/core/machine-qmp-cmds.c            | 26 +++++++++++++
 include/qemu/target-info-qom.h        | 39 +++++++++++++++++++
 include/semihosting/common-semi.h     | 56 ++++++++++++++++++++++++---
 stubs/dump.c                          | 27 -------------
 stubs/meson.build                     |  2 -
 stubs/qmp-cpu.c                       | 21 ----------
 target-info.c                         | 32 +++++++++++++++
 target/arm/arch_dump.c                |  8 +++-
 target/arm/arm-qmp-cmds.c             | 15 +++++--
 target/arm/common-semi-target.c       | 23 ++++++++---
 target/arm/meson.build                |  7 +---
 target/i386/arch_dump.c               |  8 +++-
 target/i386/cpu-system.c              | 12 ++++--
 target/i386/cpu.c                     |  6 ++-
 target/loongarch/arch_dump.c          |  8 +++-
 target/loongarch/loongarch-qmp-cmds.c | 15 +++++--
 target/mips/system/mips-qmp-cmds.c    | 15 +++----
 target/ppc/arch_dump.c                |  8 +++-
 target/ppc/ppc-qmp-cmds.c             | 15 +++----
 target/riscv/arch_dump.c              |  8 +++-
 target/riscv/common-semi-target.c     | 25 ++++++++----
 target/riscv/meson.build              |  4 +-
 target/riscv/riscv-qmp-cmds.c         | 15 +++++--
 target/s390x/arch_dump.c              |  8 +++-
 target/s390x/cpu_models_system.c      | 15 +++++--
 27 files changed, 311 insertions(+), 131 deletions(-)
 delete mode 100644 stubs/dump.c
 delete mode 100644 stubs/qmp-cpu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 902db77218e..08e84e4ac6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3348,7 +3348,6 @@ F: include/system/dump-arch.h
 F: include/system/dump.h
 F: qapi/dump.json
 F: scripts/dump-guest-memory.py
-F: stubs/dump.c
 F: docs/specs/vmcoreinfo.rst
 F: tests/qtest/vmcoreinfo-test.c
 F: tests/qtest/dump-test.c
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 14eb4ed87f8..6dfbbac7f24 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -24,7 +24,9 @@
 #include "exec/cputlb.h"
 #include "exec/target_page.h"
 #include "system/memory.h"
+#include "system/dump-arch.h"
 #include "qemu/target-info.h"
+#include "qemu/target-info-qom.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/sysemu-cpu-ops.h"
@@ -127,6 +129,27 @@ int cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
     return (*cpu->cc->sysemu_ops->write_elf64_note)(f, cpu, cpuid, opaque);
 }
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const struct GuestPhysBlockList *guest_phys_blocks)
+{
+    const TargetCpuOps *ops = target_info_cpu_ops();
+
+    if (!ops->get_dump_info) {
+        return -1;
+    }
+    return ops->get_dump_info(info, guest_phys_blocks);
+}
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    const TargetCpuOps *ops = target_info_cpu_ops();
+
+    if (!ops->get_note_size) {
+        return -1;
+    }
+    return ops->get_note_size(class, machine, nr_cpus);
+}
+
 bool cpu_internal_is_big_endian(CPUState *cpu)
 {
     if (cpu->cc->sysemu_ops->internal_is_big_endian) {
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index e6e6ecc31e3..f8297203848 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -449,3 +449,29 @@ void qmp_dump_skeys(const char *filename, Error **errp)
     }
     DUMP_SKEYS_INTERFACE_CLASS(oc)->qmp_dump_skeys(filename, errp);
 }
+
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+{
+    const TargetCpuOps *ops = target_info_cpu_ops();
+
+    if (!ops->query_cpu_definitions) {
+        error_setg(errp,
+                   "CPU model definitions are not supported on this target");
+        return NULL;
+    }
+    return ops->query_cpu_definitions(errp);
+}
+
+CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
+                                                     CpuModelInfo *model,
+                                                     Error **errp)
+{
+    const TargetCpuOps *ops = target_info_cpu_ops();
+
+    if (!ops->query_cpu_model_expansion) {
+        error_setg(errp,
+                   "CPU model expansion is not supported on this target");
+        return NULL;
+    }
+    return ops->query_cpu_model_expansion(type, model, errp);
+}
diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index 9e56383ea6b..438663f9e1b 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -13,6 +13,45 @@
 #include "qapi/error.h"
 #include "qom/object.h"
 
+#include <stddef.h>
+
+typedef struct ArchDumpInfo ArchDumpInfo;
+struct GuestPhysBlockList;
+typedef struct CPUSemihostingOps CPUSemihostingOps;
+
+typedef struct TargetCpuOps {
+    CpuDefinitionInfoList *(*query_cpu_definitions)(Error **errp);
+    CpuModelExpansionInfo *(*query_cpu_model_expansion)(
+        CpuModelExpansionType type, CpuModelInfo *model, Error **errp);
+    int (*get_dump_info)(ArchDumpInfo *info,
+                         const struct GuestPhysBlockList *guest_phys_blocks);
+    ssize_t (*get_note_size)(int class, int machine, int nr_cpus);
+    const CPUSemihostingOps *semihosting;
+} TargetCpuOps;
+
+/**
+ * target_info_register_cpu_op:
+ * @cpu_type: CPU_RESOLVING_TYPE of the registering architecture
+ * @offset: offsetof(TargetCpuOps, member) for the slot being filled
+ * @impl: handler or ops table stored at that offset
+ *
+ * Combined binaries merge one member at a time so QMP, dump, and
+ * semihosting (or split QMP files) can register independently.
+ * MODULE_INIT_QOM runs after target_info_qom_set_target(), so only
+ * the selected cpu_type is stored.
+ */
+void target_info_register_cpu_op(const char *cpu_type, size_t offset,
+                                 void *impl);
+const TargetCpuOps *target_info_cpu_ops(void);
+
+#define TARGET_INFO_CPU_OP(cpu_type, member, impl)                            \
+static void glue(target_info_cpu_op_, impl)(void)                             \
+{                                                                             \
+    target_info_register_cpu_op((cpu_type), offsetof(TargetCpuOps, member),   \
+                                (void *)&(impl));                             \
+}                                                                             \
+type_init(glue(target_info_cpu_op_, impl))
+
 #define TYPE_TARGET_INFO "target-info"
 
 #define TYPE_TARGET_SPECIFIC "target-specific"
diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
index aa511a46f42..f86a855a3dd 100644
--- a/include/semihosting/common-semi.h
+++ b/include/semihosting/common-semi.h
@@ -34,12 +34,56 @@
 #ifndef COMMON_SEMI_H
 #define COMMON_SEMI_H
 
+#include "exec/cpu-common.h"
+#include "qemu/target-info-qom.h"
+
+typedef struct CPUSemihostingOps {
+    uint64_t (*arg)(CPUState *cs, int argno);
+    void (*set_ret)(CPUState *cs, uint64_t ret);
+    bool (*is_64bit)(CPUArchState *env);
+    bool (*sys_exit_is_extended)(CPUState *cs);
+    uint64_t (*stack_bottom)(CPUState *cs);
+    bool (*has_synccache)(CPUArchState *env);
+} CPUSemihostingOps;
+
 void do_common_semihosting(CPUState *cs);
-uint64_t common_semi_arg(CPUState *cs, int argno);
-void common_semi_set_ret(CPUState *cs, uint64_t ret);
-bool is_64bit_semihosting(CPUArchState *env);
-bool common_semi_sys_exit_is_extended(CPUState *cs);
-uint64_t common_semi_stack_bottom(CPUState *cs);
-bool common_semi_has_synccache(CPUArchState *env);
+
+static inline const CPUSemihostingOps *cpu_semihosting_ops(void)
+{
+    const CPUSemihostingOps *ops = target_info_cpu_ops()->semihosting;
+
+    g_assert(ops);
+    return ops;
+}
+
+static inline uint64_t common_semi_arg(CPUState *cs, int argno)
+{
+    return cpu_semihosting_ops()->arg(cs, argno);
+}
+
+static inline void common_semi_set_ret(CPUState *cs, uint64_t ret)
+{
+    cpu_semihosting_ops()->set_ret(cs, ret);
+}
+
+static inline bool is_64bit_semihosting(CPUArchState *env)
+{
+    return cpu_semihosting_ops()->is_64bit(env);
+}
+
+static inline bool common_semi_sys_exit_is_extended(CPUState *cs)
+{
+    return cpu_semihosting_ops()->sys_exit_is_extended(cs);
+}
+
+static inline uint64_t common_semi_stack_bottom(CPUState *cs)
+{
+    return cpu_semihosting_ops()->stack_bottom(cs);
+}
+
+static inline bool common_semi_has_synccache(CPUArchState *env)
+{
+    return cpu_semihosting_ops()->has_synccache(env);
+}
 
 #endif /* COMMON_SEMI_H */
diff --git a/stubs/dump.c b/stubs/dump.c
deleted file mode 100644
index df7897b72b1..00000000000
--- a/stubs/dump.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * QEMU dump
- *
- * Copyright Fujitsu, Corp. 2011, 2012
- *
- * Authors:
- *     Wen Congyang <wency@cn.fujitsu.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "system/dump-arch.h"
-
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
-{
-    return -1;
-}
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
-{
-    return -1;
-}
-
diff --git a/stubs/meson.build b/stubs/meson.build
index 3b2f2680b19..94024aef868 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -68,7 +68,6 @@ if have_system
   # adding more of these.  If the symbol is used in specific_ss,
   # in particular, consider defining a preprocessor macro via
   # Kconfig or configs/targets/.
-  stub_ss.add(files('dump.c'))
   stub_ss.add(files('cmos.c'))
   stub_ss.add(files('fw_cfg.c'))
   if igvm.found()
@@ -82,7 +81,6 @@ if have_system
   stub_ss.add(files('qmp-i386-sev.c'))
   stub_ss.add(files('qmp-i386-sgx.c'))
   stub_ss.add(files('qmp-i386-xen.c'))
-  stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
   stub_ss.add(files('hmp-cmd-info_mem.c'))
diff --git a/stubs/qmp-cpu.c b/stubs/qmp-cpu.c
deleted file mode 100644
index a8c7ee89b9d..00000000000
--- a/stubs/qmp-cpu.c
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "qapi/qapi-commands-machine.h"
-
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    error_setg(errp, "CPU model expansion is not supported on this target");
-    return NULL;
-}
-
-CpuDefinitionInfoList *
-qmp_query_cpu_definitions(Error **errp)
-{
-    error_setg(errp, "CPU model definitions are not supported on this target");
-    return NULL;
-}
diff --git a/target-info.c b/target-info.c
index ce7f9797dce..aa4be08bb94 100644
--- a/target-info.c
+++ b/target-info.c
@@ -7,9 +7,11 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-qapi.h"
 #include "qemu/target-info-impl.h"
+#include "qemu/target-info-qom.h"
 #include "qapi/error.h"
 
 const char *target_name(void)
@@ -124,3 +126,33 @@ bool target_config_xen(void)
 {
     return target_info()->config_xen;
 }
+
+static TargetCpuOps target_cpu_ops;
+
+void target_info_register_cpu_op(const char *cpu_type, size_t offset,
+                                 void *impl)
+{
+    const TargetInfo *ti = target_info();
+    void **slot;
+
+    g_assert(ti);
+    g_assert(offset + sizeof(void *) <= sizeof(TargetCpuOps));
+    g_assert((offset % sizeof(void *)) == 0);
+
+    if (strcmp(cpu_type, ti->cpu_type)) {
+        return;
+    }
+
+    slot = (void **)((char *)&target_cpu_ops + offset);
+    if (*slot) {
+        error_report("TargetCpuOps already registered for type '%s' (offset %zu)",
+                     cpu_type, offset);
+        return;
+    }
+    *slot = impl;
+}
+
+const TargetCpuOps *target_info_cpu_ops(void)
+{
+    return &target_cpu_ops;
+}
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 1dd79849c13..e072516bdac 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -24,6 +24,7 @@
 #include "system/dump.h"
 #include "cpu-features.h"
 #include "internals.h"
+#include "qemu/target-info-qom.h"
 
 /* struct user_pt_regs from arch/arm64/include/uapi/asm/ptrace.h */
 struct aarch64_user_regs {
@@ -385,7 +386,7 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
+static int arm_get_dump_info(ArchDumpInfo *info,
                       const GuestPhysBlockList *guest_phys_blocks)
 {
     ARMCPU *cpu;
@@ -439,7 +440,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+static ssize_t arm_get_note_size(int class, int machine, int nr_cpus)
 {
     ARMCPU *cpu = ARM_CPU(first_cpu);
     size_t note_size;
@@ -459,3 +460,6 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return note_size * nr_cpus;
 }
+
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, get_dump_info, arm_get_dump_info);
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, get_note_size, arm_get_note_size);
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 83ec95c290f..c85bde5d79d 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -32,6 +32,7 @@
 #include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
 #include "cpu.h"
+#include "qemu/target-info-qom.h"
 
 static GICCapability *gic_cap_new(int version)
 {
@@ -79,9 +80,10 @@ static const char *cpu_model_advertised_features[] = {
     NULL
 };
 
-CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                                                     CpuModelInfo *model,
-                                                     Error **errp)
+static CpuModelExpansionInfo *
+arm_query_cpu_model_expansion(CpuModelExpansionType type,
+                              CpuModelInfo *model,
+                              Error **errp)
 {
     CpuModelExpansionInfo *expansion_info;
     const QDict *qdict_in;
@@ -216,7 +218,7 @@ static void arm_cpu_add_definition(gpointer data, gpointer user_data)
     QAPI_LIST_PREPEND(*cpu_list, info);
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+static CpuDefinitionInfoList *arm_query_cpu_definitions(Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
@@ -227,3 +229,8 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 
     return cpu_list;
 }
+
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, query_cpu_definitions,
+                   arm_query_cpu_definitions);
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, query_cpu_model_expansion,
+                   arm_query_cpu_model_expansion);
diff --git a/target/arm/common-semi-target.c b/target/arm/common-semi-target.c
index 2b77ce9c17b..eccd3735df8 100644
--- a/target/arm/common-semi-target.c
+++ b/target/arm/common-semi-target.c
@@ -12,7 +12,7 @@
 #include "semihosting/common-semi.h"
 #include "target/arm/cpu-qom.h"
 
-uint64_t common_semi_arg(CPUState *cs, int argno)
+static uint64_t arm_common_semi_arg(CPUState *cs, int argno)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -23,7 +23,7 @@ uint64_t common_semi_arg(CPUState *cs, int argno)
     }
 }
 
-void common_semi_set_ret(CPUState *cs, uint64_t ret)
+static void arm_common_semi_set_ret(CPUState *cs, uint64_t ret)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -34,25 +34,36 @@ void common_semi_set_ret(CPUState *cs, uint64_t ret)
     }
 }
 
-bool common_semi_sys_exit_is_extended(CPUState *cs)
+static bool arm_common_semi_sys_exit_is_extended(CPUState *cs)
 {
     return is_a64(cpu_env(cs));
 }
 
-bool is_64bit_semihosting(CPUArchState *env)
+static bool arm_is_64bit_semihosting(CPUArchState *env)
 {
     return is_a64(env);
 }
 
-uint64_t common_semi_stack_bottom(CPUState *cs)
+static uint64_t arm_common_semi_stack_bottom(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     return is_a64(env) ? env->xregs[31] : env->regs[13];
 }
 
-bool common_semi_has_synccache(CPUArchState *env)
+static bool arm_common_semi_has_synccache(CPUArchState *env)
 {
     /* Ok for A64, invalid for A32/T32 */
     return is_a64(env);
 }
+
+static const CPUSemihostingOps arm_semihosting_ops = {
+    .arg = arm_common_semi_arg,
+    .set_ret = arm_common_semi_set_ret,
+    .is_64bit = arm_is_64bit_semihosting,
+    .sys_exit_is_extended = arm_common_semi_sys_exit_is_extended,
+    .stack_bottom = arm_common_semi_stack_bottom,
+    .has_synccache = arm_common_semi_has_synccache,
+};
+
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, semihosting, arm_semihosting_ops);
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 0369f96b4cc..dfcec55bd97 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -44,13 +44,10 @@ arm_stubs_ss.add(files(
 arm_user_ss.add(files(
   'el2-stubs.c',
   'cpregs-omap-stub.c',
+  'common-semi-target.c',
 ))
-arm_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
-		        if_true: files('common-semi-target.c'))
 
-arm_common_system_ss.add(files('cpu.c'))
-arm_common_system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
-		                 if_true: files('common-semi-target.c'))
+arm_common_system_ss.add(files('cpu.c', 'common-semi-target.c'))
 arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 16e47c4747d..c060b2b4ccb 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -16,6 +16,7 @@
 #include "system/dump.h"
 #include "elf.h"
 #include "system/memory_mapping.h"
+#include "qemu/target-info-qom.h"
 
 #define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
     ((DIV_ROUND_UP((hdr_size), 4)                       \
@@ -394,7 +395,7 @@ int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cs,
     return cpu_write_qemu_note(f, &cpu->env, s, 0);
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
+static int x86_get_dump_info(ArchDumpInfo *info,
                       const GuestPhysBlockList *guest_phys_blocks)
 {
     bool lma = false;
@@ -429,7 +430,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+static ssize_t x86_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 5; /* "CORE" or "QEMU" */
     size_t elf_note_size = 0;
@@ -459,3 +460,6 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return (elf_note_size + qemu_note_size) * nr_cpus;
 }
+
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, get_dump_info, x86_get_dump_info);
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, get_note_size, x86_get_note_size);
diff --git a/target/i386/cpu-system.c b/target/i386/cpu-system.c
index c8bbf0cbafd..d2babd1ba09 100644
--- a/target/i386/cpu-system.c
+++ b/target/i386/cpu-system.c
@@ -29,6 +29,7 @@
 #include "qapi/qapi-commands-machine.h"
 
 #include "cpu-internal.h"
+#include "qemu/target-info-qom.h"
 
 /* Return a QDict containing keys for all properties that can be included
  * in static expansion of CPU models. All properties set by x86_cpu_load_model()
@@ -188,10 +189,10 @@ out:
     return xc;
 }
 
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                                                      CpuModelInfo *model,
-                                                      Error **errp)
+static CpuModelExpansionInfo *
+x86_query_cpu_model_expansion(CpuModelExpansionType type,
+                              CpuModelInfo *model,
+                              Error **errp)
 {
     X86CPU *xc = NULL;
     Error *err = NULL;
@@ -241,6 +242,9 @@ out:
     return ret;
 }
 
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, query_cpu_model_expansion,
+                   x86_query_cpu_model_expansion);
+
 void cpu_clear_apic_feature(CPUX86State *env)
 {
     env->features[FEAT_1_EDX] &= ~CPUID_APIC;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5805d33ab92..4e31b8a2a60 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -48,6 +48,7 @@
 #include "system/address-spaces.h"
 #include "hw/core/boards.h"
 #include "hw/i386/sgx-epc.h"
+#include "qemu/target-info-qom.h"
 #endif
 #include "system/qtest.h"
 #include "tcg/tcg-cpu.h"
@@ -8191,7 +8192,7 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
     QAPI_LIST_PREPEND(*cpu_list, info);
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+static CpuDefinitionInfoList *x86_query_cpu_definitions(Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list = get_sorted_cpu_model_list();
@@ -8200,6 +8201,9 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     return cpu_list;
 }
 
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, query_cpu_definitions,
+                   x86_query_cpu_definitions);
+
 #endif /* !CONFIG_USER_ONLY */
 
 static uint8_t x86_cpu_get_host_avx10_version(void)
diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index 9d84faef969..af4ab5df5b5 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -22,6 +22,7 @@
 #include "elf.h"
 #include "system/dump.h"
 #include "internals.h"
+#include "qemu/target-info-qom.h"
 
 /* struct user_pt_regs from arch/loongarch/include/uapi/asm/ptrace.h */
 struct loongarch_user_regs {
@@ -142,7 +143,7 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
     return ret;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
+static int loongarch_get_dump_info(ArchDumpInfo *info,
                       const GuestPhysBlockList *guest_phys_blocks)
 {
     info->d_machine = EM_LOONGARCH;
@@ -152,7 +153,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+static ssize_t loongarch_get_note_size(int class, int machine, int nr_cpus)
 {
     size_t note_size = 0;
 
@@ -162,3 +163,6 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return note_size * nr_cpus;
 }
+
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, get_dump_info, loongarch_get_dump_info);
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, get_note_size, loongarch_get_note_size);
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index f053f22bb8c..848ad640aee 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -14,6 +14,7 @@
 #include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qom/qom-qobject.h"
+#include "qemu/target-info-qom.h"
 
 static void loongarch_cpu_add_definition(gpointer data, gpointer user_data)
 {
@@ -28,7 +29,7 @@ static void loongarch_cpu_add_definition(gpointer data, gpointer user_data)
     QAPI_LIST_PREPEND(*cpu_list, info);
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+static CpuDefinitionInfoList *loongarch_query_cpu_definitions(Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
@@ -45,9 +46,10 @@ static const char *cpu_model_advertised_features[] = {
     "ptw", NULL
 };
 
-CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                                                     CpuModelInfo *model,
-                                                     Error **errp)
+static CpuModelExpansionInfo *
+loongarch_query_cpu_model_expansion(CpuModelExpansionType type,
+                                    CpuModelInfo *model,
+                                    Error **errp)
 {
     Visitor *visitor;
     CpuModelExpansionInfo *expansion_info;
@@ -133,3 +135,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
 
     return expansion_info;
 }
+
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, query_cpu_definitions,
+                   loongarch_query_cpu_definitions);
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, query_cpu_model_expansion,
+                   loongarch_query_cpu_model_expansion);
diff --git a/target/mips/system/mips-qmp-cmds.c b/target/mips/system/mips-qmp-cmds.c
index b6a2874f2dd..ff78487423b 100644
--- a/target/mips/system/mips-qmp-cmds.c
+++ b/target/mips/system/mips-qmp-cmds.c
@@ -11,15 +11,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "cpu.h"
-
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    error_setg(errp, "CPU model expansion is not supported on this target");
-    return NULL;
-}
+#include "qemu/target-info-qom.h"
 
 static void mips_cpu_add_definition(gpointer data, gpointer user_data)
 {
@@ -36,7 +28,7 @@ static void mips_cpu_add_definition(gpointer data, gpointer user_data)
     QAPI_LIST_PREPEND(*cpu_list, info);
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+static CpuDefinitionInfoList *mips_query_cpu_definitions(Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
@@ -47,3 +39,6 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 
     return cpu_list;
 }
+
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, query_cpu_definitions,
+                   mips_query_cpu_definitions);
diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 80ac6c3e320..07f0c75c45e 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -17,6 +17,7 @@
 #include "elf.h"
 #include "system/dump.h"
 #include "system/kvm.h"
+#include "qemu/target-info-qom.h"
 
 #ifdef TARGET_PPC64
 #define ELFCLASS ELFCLASS64
@@ -229,7 +230,7 @@ static const struct NoteFuncDescStruct {
 
 typedef struct NoteFuncDescStruct NoteFuncDesc;
 
-int cpu_get_dump_info(ArchDumpInfo *info,
+static int ppc_get_dump_info(ArchDumpInfo *info,
                       const struct GuestPhysBlockList *guest_phys_blocks)
 {
     PowerPCCPU *cpu;
@@ -257,7 +258,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+static ssize_t ppc_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 8; /* "CORE" or "QEMU" rounded */
     size_t elf_note_size = 0;
@@ -313,3 +314,6 @@ int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     return ppc_write_all_elf_notes("CORE", f, cpu, cpuid, s);
 }
+
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, get_dump_info, ppc_get_dump_info);
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, get_note_size, ppc_get_note_size);
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index 96228919966..70fca0170b1 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -29,15 +29,7 @@
 #include "qapi/qapi-commands-machine.h"
 #include "cpu-models.h"
 #include "cpu-qom.h"
-
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    error_setg(errp, "CPU model expansion is not supported on this target");
-    return NULL;
-}
+#include "qemu/target-info-qom.h"
 
 static void ppc_cpu_defs_entry(gpointer data, gpointer user_data)
 {
@@ -53,7 +45,7 @@ static void ppc_cpu_defs_entry(gpointer data, gpointer user_data)
     QAPI_LIST_PREPEND(*first, info);
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+static CpuDefinitionInfoList *ppc_query_cpu_definitions(Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
@@ -82,3 +74,6 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 
     return cpu_list;
 }
+
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, query_cpu_definitions,
+                   ppc_query_cpu_definitions);
diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 12b68799070..7e4b584faa0 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "elf.h"
 #include "system/dump.h"
+#include "qemu/target-info-qom.h"
 
 /* struct user_regs_struct from arch/riscv/include/uapi/asm/ptrace.h */
 struct riscv64_user_regs {
@@ -161,7 +162,7 @@ int riscv_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
     return ret;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
+static int riscv_get_dump_info(ArchDumpInfo *info,
                       const GuestPhysBlockList *guest_phys_blocks)
 {
     RISCVCPU *cpu;
@@ -187,7 +188,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+static ssize_t riscv_get_note_size(int class, int machine, int nr_cpus)
 {
     size_t note_size;
 
@@ -199,3 +200,6 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return note_size * nr_cpus;
 }
+
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, get_dump_info, riscv_get_dump_info);
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, get_note_size, riscv_get_note_size);
diff --git a/target/riscv/common-semi-target.c b/target/riscv/common-semi-target.c
index aeaeb88d536..aed9dfc5b68 100644
--- a/target/riscv/common-semi-target.c
+++ b/target/riscv/common-semi-target.c
@@ -12,38 +12,49 @@
 #include "cpu.h"
 #include "semihosting/common-semi.h"
 
-uint64_t common_semi_arg(CPUState *cs, int argno)
+static uint64_t riscv_common_semi_arg(CPUState *cs, int argno)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     return env->gpr[xA0 + argno];
 }
 
-void common_semi_set_ret(CPUState *cs, uint64_t ret)
+static void riscv_common_semi_set_ret(CPUState *cs, uint64_t ret)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     env->gpr[xA0] = ret;
 }
 
-bool is_64bit_semihosting(CPUArchState *env)
+static bool riscv_is_64bit_semihosting(CPUArchState *env)
 {
     return riscv_cpu_mxl(env) != MXL_RV32;
 }
 
-bool common_semi_sys_exit_is_extended(CPUState *cs)
+static bool riscv_common_semi_sys_exit_is_extended(CPUState *cs)
 {
-    return is_64bit_semihosting(cpu_env(cs));
+    return riscv_is_64bit_semihosting(cpu_env(cs));
 }
 
-uint64_t common_semi_stack_bottom(CPUState *cs)
+static uint64_t riscv_common_semi_stack_bottom(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     return env->gpr[xSP];
 }
 
-bool common_semi_has_synccache(CPUArchState *env)
+static bool riscv_common_semi_has_synccache(CPUArchState *env)
 {
     return true;
 }
+
+static const CPUSemihostingOps riscv_semihosting_ops = {
+    .arg = riscv_common_semi_arg,
+    .set_ret = riscv_common_semi_set_ret,
+    .is_64bit = riscv_is_64bit_semihosting,
+    .sys_exit_is_extended = riscv_common_semi_sys_exit_is_extended,
+    .stack_bottom = riscv_common_semi_stack_bottom,
+    .has_synccache = riscv_common_semi_has_synccache,
+};
+
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, semihosting, riscv_semihosting_ops);
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 42d0f6d538a..5adb6d1c9e7 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -11,12 +11,10 @@ gen = [
 riscv_ss = ss.source_set()
 riscv_ss.add(gen)
 
-riscv_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
-		     if_true: files('common-semi-target.c'))
-
 riscv_ss.add(files(
   'cpu.c',
   'gdbstub.c',
+  'common-semi-target.c',
 ))
 
 riscv_system_ss = ss.source_set()
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 2647deef916..248e6a0eaf0 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -36,6 +36,7 @@
 #include "cpu-qom.h"
 #include "cpu.h"
 #include "target/riscv/tcg/csr.h"
+#include "qemu/target-info-qom.h"
 
 static void riscv_cpu_add_definition(gpointer data, gpointer user_data)
 {
@@ -54,7 +55,7 @@ static void riscv_cpu_add_definition(gpointer data, gpointer user_data)
     QAPI_LIST_PREPEND(*cpu_list, info);
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+static CpuDefinitionInfoList *riscv_query_cpu_definitions(Error **errp)
 {
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list = object_class_get_list(TYPE_RISCV_CPU, false);
@@ -154,9 +155,10 @@ err:
     visit_free(visitor);
 }
 
-CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                                                     CpuModelInfo *model,
-                                                     Error **errp)
+static CpuModelExpansionInfo *
+riscv_query_cpu_model_expansion(CpuModelExpansionType type,
+                                CpuModelInfo *model,
+                                Error **errp)
 {
     CpuModelExpansionInfo *expansion_info;
     QDict *qdict_out;
@@ -225,3 +227,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
 
     return expansion_info;
 }
+
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, query_cpu_definitions,
+                   riscv_query_cpu_definitions);
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, query_cpu_model_expansion,
+                   riscv_query_cpu_model_expansion);
diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 2c26e992959..c0334baa72f 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -18,6 +18,7 @@
 #include "elf.h"
 #include "system/dump.h"
 #include "kvm/kvm_s390x.h"
+#include "qemu/target-info-qom.h"
 #include "target/s390x/kvm/pv.h"
 
 struct S390xUserRegsStruct {
@@ -449,7 +450,7 @@ static void arch_cleanup(DumpState *s)
     }
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
+static int s390_get_dump_info(ArchDumpInfo *info,
                       const struct GuestPhysBlockList *guest_phys_blocks)
 {
     info->d_machine = EM_S390;
@@ -469,7 +470,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+static ssize_t s390_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 8; /* "LINUX" or "CORE" + pad */
     size_t elf_note_size = 0;
@@ -495,3 +496,6 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return (elf_note_size) * nr_cpus;
 }
+
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, get_dump_info, s390_get_dump_info);
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, get_note_size, s390_get_note_size);
diff --git a/target/s390x/cpu_models_system.c b/target/s390x/cpu_models_system.c
index 5b846048675..5470bf55e20 100644
--- a/target/s390x/cpu_models_system.c
+++ b/target/s390x/cpu_models_system.c
@@ -20,6 +20,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qobject/qdict.h"
 #include "qapi/qapi-commands-machine.h"
+#include "qemu/target-info-qom.h"
 
 static void list_add_feat(const char *name, void *opaque);
 
@@ -82,7 +83,7 @@ static void create_cpu_model_list(ObjectClass *klass, void *opaque)
     QAPI_LIST_PREPEND(*cpu_list, info);
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+static CpuDefinitionInfoList *s390_query_cpu_definitions(Error **errp)
 {
     struct CpuDefinitionInfoListData list_data = {
         .list = NULL,
@@ -208,9 +209,10 @@ static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
     }
 }
 
-CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                                                      CpuModelInfo *model,
-                                                      Error **errp)
+static CpuModelExpansionInfo *
+s390_query_cpu_model_expansion(CpuModelExpansionType type,
+                               CpuModelInfo *model,
+                               Error **errp)
 {
     Error *err = NULL;
     CpuModelExpansionInfo *expansion_info = NULL;
@@ -434,3 +436,8 @@ void apply_cpu_model(const S390CPUModel *model, Error **errp)
         applied_model = *model;
     }
 }
+
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, query_cpu_definitions,
+                   s390_query_cpu_definitions);
+TARGET_INFO_CPU_OP(CPU_RESOLVING_TYPE, query_cpu_model_expansion,
+                   s390_query_cpu_model_expansion);
-- 
2.52.0.windows.1


