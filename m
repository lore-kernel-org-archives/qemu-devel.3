Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383BACC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 04:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHDHX-0000Ab-Am; Thu, 15 Oct 2026 00:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xHDHV-00009f-2r
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 00:41:29 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xHDHL-0005ja-SP
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 00:41:28 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-33fb4680717so4612648eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 21:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792039278; x=1792644078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+DZ1jsqwTfgH5aimMfmjoml+Aari6eVWbh1Wwpcjr+A=;
 b=KcJQ56mmC2eXMgYfexlu1Z4wpcZtL4n8e/u46YqdYkcDbUA0EVoL5rhOauRbgq3MEo
 SrfimHMrlTLcEcO3Lj7vaUCbUFxVISRGtifLU6aK6dXCknDf+5DepiJZfKH5AUvrErUT
 5onIBzG291bu27SRQSpGlKj2Misq/+ca68wxLp2FhDXLuoUzVT68e91ggrS8ybXQDa3Y
 svlxFlnsOBPx1pAHJFfeABPyiAOrNxQCYaIrhBVKGQGm5HDJq1e7iUH06sUNwkyycrYA
 YSt37oDKFoDFLm3umteZEtkbKnlhtJFJnORatGJgIsgZDoPouevRBmToITcK1oDF5VAa
 ShsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792039278; x=1792644078;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+DZ1jsqwTfgH5aimMfmjoml+Aari6eVWbh1Wwpcjr+A=;
 b=e5Cbfco+Z6+Zwo0of+InPf+tBdWJh37igQhIRyNFbQoGkr/vkN51WkVNooq0FH6OFN
 kl7Cq3EDCwsXYUbyItY7LWXOEFcRpIKM0X2NIKSFyFGf6e4lfqEaTwidohlo1gA7DLl0
 YRjRnoLNnS1uLInb5CK1l5ExAp0kTJoAS2T99oidyp1Z1+vdin0yRWgkMjDgUpt3rIXC
 t3pm0LScvOVuM8HWo7Gbe/TvpHvPro3nUk+CH+pbEn0seB1snVkGSzVWFUHk5T51LTgB
 YNSR0JHNpMX+eeM299WJwpzqO41CatUUQfA+5kUth4QTrkE4NN+RtDNxPMXU1gBzoywk
 OTqg==
X-Gm-Message-State: AFq9FYIgHXLwlN87s35SyYwx6dbXqYVyXGbidmTERUIdLFiUpYKdSQ9+
 noXLNrfF6dSW2Yj8eIS/FJ4uFWJdtKpAmeS2QZSyqNAUoRQEaHVlaRhftpIGPND0dg4=
X-Gm-Gg: AYBFou1H3CLT8z/EEYq/kdvfUOBtAvZhj3+69toOE6SgciQInH7iSfKyyf4UpxLn9Cm
 ORpwi1H76CdkaLmIWyEusYJ1gJcJQW73UqE6XExjJR0367OUCB1fmc7ysOjD2/Gdp/mGOabCW3F
 RIEYjYckBx7yrrWCl5Kz50S0CpuwKPUY47FOe5WwxRI4yR5J+qgtyN+GdB2qx8xz7UjXJseYazn
 +JbqLV6AFaJUM0Zt4NgkhpaBdZfWZBE97ZRkClOq844SE1/H8dSf4l69WhNOEq2pAPxzHkdfbGh
 R03ihTge9k8W7K8p0p2NdXqNQK5HdTBYphvspgtHapqDZYk0z0apebbR2QDDZSmOGU9ZGS3IMQe
 TwWDwXDTa4XALIRYIiSNrzsKNfERvNBLLY5W1FA1FE/DP8QRKQSPdm5qyUKc0vbs+71k7gwP4Ak
 CL9/6moGydyv49LRGZc3aFLuFWBpSoimhzXqVbGNo1c5/yvpe3tfUS/JrrPVCfymV+jmkbg3a4m
 qsguQbbfFRXGPteTQ==
X-Received: by 2002:a05:701b:4541:10b0:144:ed03:8972 with SMTP id
 a92af1059eb24-16a5dee12c8mr23761434c88.16.1792039277544; 
 Wed, 14 Oct 2026 21:41:17 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-17dc865cbffsm16016982c88.6.2026.10.14.21.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 21:41:16 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@kernel.org>, Glenn Miles <milesg@linux.ibm.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Song Gao <17746591750@163.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eric Farman <farman@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Xianglai Li <lixianglai@loongson.cn>,
 Chao Liu <chao.liu@processmission.com>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH] target-info: dispatch CPU QMP, dump, monitor,
 and Angel semihosting
Date: Thu, 15 Oct 2026 12:41:02 +0800
Message-ID: <20261015044104.879-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1336.google.com
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

Put query-cpu-definitions, dump notes, monitor, and Angel semihosting on
TargetOps[SYS_EMU_TARGET__MAX] and look up by target_arch().
Keep the table in target-ops.c and with a stub

- Register with a QEMU_ARCH_* bitmask so shared base-arch objects
  can fill both slots (e.g. QEMU_ARCH_ARM is ARM|AARCH64).
- TARGET_INFO_CPU_OP is type_init. A NULL member means no handler.
- Drop stubs/qmp-cpu.c
       stubs/hmp-cmd-info_tlb.c
       stubs/hmp-cmd-info_mem.c
       stubs/dump.c

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 MAINTAINERS                           |  1 -
 hw/core/cpu-system.c                  | 23 ++++++++++
 hw/core/machine-qmp-cmds.c            | 27 ++++++++++++
 include/qemu/target-ops.h             | 59 +++++++++++++++++++++++++
 include/semihosting/common-semi.h     | 63 ++++++++++++++++++++++++---
 meson.build                           |  1 +
 monitor/hmp.c                         | 25 +++++++++++
 stubs/dump.c                          | 27 ------------
 stubs/hmp-cmd-info_mem.c              | 12 -----
 stubs/hmp-cmd-info_tlb.c              | 12 -----
 stubs/meson.build                     |  4 --
 stubs/qmp-cpu.c                       | 21 ---------
 target-ops.c                          | 49 +++++++++++++++++++++
 target/arm/arch_dump.c                |  8 +++-
 target/arm/arm-qmp-cmds.c             | 15 +++++--
 target/arm/common-semi-target.c       | 26 ++++++++---
 target/arm/meson.build                |  7 +--
 target/hexagon/common-semi-target.c   | 26 ++++++++---
 target/i386/arch_dump.c               |  8 +++-
 target/i386/cpu-system.c              | 12 +++--
 target/i386/cpu.c                     |  6 ++-
 target/i386/monitor.c                 |  8 +++-
 target/loongarch/arch_dump.c          |  8 +++-
 target/loongarch/loongarch-qmp-cmds.c | 15 +++++--
 target/m68k/monitor.c                 |  4 +-
 target/mips/system/mips-qmp-cmds.c    | 15 +++----
 target/ppc/arch_dump.c                |  8 +++-
 target/ppc/monitor.c                  |  4 +-
 target/ppc/ppc-qmp-cmds.c             | 15 +++----
 target/riscv/arch_dump.c              |  8 +++-
 target/riscv/common-semi-target.c     | 28 ++++++++----
 target/riscv/meson.build              |  4 +-
 target/riscv/monitor.c                |  4 +-
 target/riscv/riscv-qmp-cmds.c         | 15 +++++--
 target/s390x/arch_dump.c              |  8 +++-
 target/s390x/cpu_models_system.c      | 15 +++++--
 target/sh4/monitor.c                  |  4 +-
 target/sparc/monitor.c                |  4 +-
 target/xtensa/monitor.c               |  4 +-
 39 files changed, 428 insertions(+), 175 deletions(-)
 create mode 100644 include/qemu/target-ops.h
 delete mode 100644 stubs/dump.c
 delete mode 100644 stubs/hmp-cmd-info_mem.c
 delete mode 100644 stubs/hmp-cmd-info_tlb.c
 delete mode 100644 stubs/qmp-cpu.c
 create mode 100644 target-ops.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fc60193aa3f..3d5e5d0f31a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3420,7 +3420,6 @@ F: include/system/dump-arch.h
 F: include/system/dump.h
 F: qapi/dump.json
 F: scripts/dump-guest-memory.py
-F: stubs/dump.c
 F: docs/specs/vmcoreinfo.rst
 F: tests/qtest/vmcoreinfo-test.c
 F: tests/qtest/dump-test.c
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index a64e8c2b687..c688e39c5bb 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -24,7 +24,9 @@
 #include "exec/cputlb.h"
 #include "exec/target_page.h"
 #include "system/memory.h"
+#include "system/dump-arch.h"
 #include "qemu/target-info.h"
+#include "qemu/target-ops.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
@@ -130,6 +132,27 @@ int cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
     return (*cpu->cc->sysemu_ops->write_elf64_note)(f, cpu, cpuid, opaque);
 }
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const struct GuestPhysBlockList *guest_phys_blocks)
+{
+    const TargetOps *ops = target_ops();
+
+    if (!ops->get_dump_info) {
+        return -1;
+    }
+    return ops->get_dump_info(info, guest_phys_blocks);
+}
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    const TargetOps *ops = target_ops();
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
index 9c08b17510a..27a9900d125 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -22,6 +22,7 @@
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
 #include "qemu/target-info.h"
+#include "qemu/target-ops.h"
 #include "qemu/target-info-qapi.h"
 #include "qom/qom-qobject.h"
 #include "system/hostmem.h"
@@ -455,3 +456,29 @@ void qmp_inject_nmi(Error **errp)
 {
     nmi_inject(errp);
 }
+
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+{
+    const TargetOps *ops = target_ops();
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
+    const TargetOps *ops = target_ops();
+
+    if (!ops->query_cpu_model_expansion) {
+        error_setg(errp,
+                   "CPU model expansion is not supported on this target");
+        return NULL;
+    }
+    return ops->query_cpu_model_expansion(type, model, errp);
+}
diff --git a/include/qemu/target-ops.h b/include/qemu/target-ops.h
new file mode 100644
index 00000000000..f657c6fa054
--- /dev/null
+++ b/include/qemu/target-ops.h
@@ -0,0 +1,59 @@
+/*
+ * QEMU target info QOM types
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_TARGET_OPS_H
+#define QEMU_TARGET_OPS_H
+
+#include <stddef.h>
+
+#include "qapi/error.h"
+#include "qemu/base-arch-defs.h"
+#include "qemu/target-info-def.h"
+#include "qom/object.h"
+
+typedef struct ArchDumpInfo ArchDumpInfo;
+struct GuestPhysBlockList;
+typedef struct CPUSemihostingOps CPUSemihostingOps;
+typedef struct MonitorHMP MonitorHMP;
+
+typedef struct TargetOps {
+    void (*info_tlb)(MonitorHMP *hmp, const QDict *qdict);
+    void (*info_mem)(MonitorHMP *hmp, const QDict *qdict);
+    CpuDefinitionInfoList *(*query_cpu_definitions)(Error **errp);
+    CpuModelExpansionInfo *(*query_cpu_model_expansion)(
+        CpuModelExpansionType type, CpuModelInfo *model, Error **errp);
+    int (*get_dump_info)(ArchDumpInfo *info,
+                         const struct GuestPhysBlockList *guest_phys_blocks);
+    ssize_t (*get_note_size)(int class, int machine, int nr_cpus);
+    const CPUSemihostingOps *semihosting;
+} TargetOps;
+
+/**
+ * target_ops_register:
+ * @arch_bitmask: QEMU_ARCH_* bitmask of SysEmuTarget slots to fill
+ * @offset: offsetof(TargetOps, member) for the slot being filled
+ * @impl: handler or ops table stored at that offset
+ *
+ * Combined binaries merge one member at a time so HMP, QMP, dump, and
+ * semihosting (or split QMP files) can register independently.
+ * Stores into every map[SysEmuTarget] bit set in @arch_bitmask
+ * (QEMU_ARCH_ARM fills ARM and AARCH64). Lookup is
+ * map[target_arch()].
+ */
+void target_ops_register(uint64_t arch_bitmask, size_t offset,
+                         void *impl);
+const TargetOps *target_ops(void);
+
+#define TARGET_OPS_REGISTER(arch_bitmask, member, impl)                       \
+static void glue(target_op_, impl)(void)                                      \
+{                                                                             \
+    target_ops_register((arch_bitmask),                                       \
+                        offsetof(TargetOps, member),                          \
+                        (void *)&(impl));                                     \
+}                                                                             \
+type_init(glue(target_op_, impl))
+
+#endif /* QEMU_TARGET_OPS_H */
diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
index 1e7699d7bbd..de54276b1dc 100644
--- a/include/semihosting/common-semi.h
+++ b/include/semihosting/common-semi.h
@@ -34,14 +34,63 @@
 #ifndef COMMON_SEMI_H
 #define COMMON_SEMI_H
 
+#include "exec/cpu-common.h"
+#include "qemu/target-ops.h"
+
+typedef struct CPUSemihostingOps {
+    uint64_t (*arg)(CPUState *cs, int argno);
+    void (*set_ret)(CPUState *cs, uint64_t ret);
+    void (*set_err)(CPUState *cs, int err);
+    bool (*is_64bit)(CPUArchState *env);
+    bool (*sys_exit_is_extended)(CPUState *cs);
+    uint64_t (*stack_bottom)(CPUState *cs);
+    bool (*has_synccache)(CPUArchState *env);
+} CPUSemihostingOps;
+
 void common_semi_cb(CPUState *cs, uint64_t ret, int err);
 void do_common_semihosting(CPUState *cs);
-uint64_t common_semi_arg(CPUState *cs, int argno);
-void common_semi_set_ret(CPUState *cs, uint64_t ret);
-void common_semi_set_err(CPUState *cs, int err);
-bool is_64bit_semihosting(CPUArchState *env);
-bool common_semi_sys_exit_is_extended(CPUState *cs);
-uint64_t common_semi_stack_bottom(CPUState *cs);
-bool common_semi_has_synccache(CPUArchState *env);
+
+static inline const CPUSemihostingOps *cpu_semihosting_ops(void)
+{
+    const CPUSemihostingOps *ops = target_ops()->semihosting;
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
+static inline void common_semi_set_err(CPUState *cs, int err)
+{
+    cpu_semihosting_ops()->set_err(cs, err);
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
diff --git a/meson.build b/meson.build
index 255c887e8e6..faa3f26afa1 100644
--- a/meson.build
+++ b/meson.build
@@ -3853,6 +3853,7 @@ if have_block
 endif
 
 common_ss.add(files('cpu-common.c'))
+common_ss.add(files('target-ops.c'))
 user_ss.add(files('cpu-target.c'))
 system_ss.add(files('cpu-target.c'))
 
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 488ec23937d..eadeec1d807 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -39,6 +39,7 @@
 #include "qemu/option.h"
 #include "qemu/base-arch-defs.h"
 #include "qemu/target-info.h"
+#include "qemu/target-ops.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
@@ -58,6 +59,30 @@ MonitorHMP *monitor_cur_hmp(void)
     return NULL;
 }
 
+void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
+{
+    const TargetOps *ops = target_ops();
+
+    if (ops->info_mem) {
+        ops->info_mem(hmp, qdict);
+    } else {
+        monitor_hmp_printf(hmp,
+                           "info mem is not supported on this architecture\n");
+    }
+}
+
+void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
+{
+    const TargetOps *ops = target_ops();
+
+    if (ops->info_tlb) {
+        ops->info_tlb(hmp, qdict);
+    } else {
+        monitor_hmp_printf(hmp,
+                           "info tlb is not supported on this architecture\n");
+    }
+}
+
 static void monitor_hmp_finalize(Object *obj)
 {
     MonitorHMP *hmp = MONITOR_HMP(obj);
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
diff --git a/stubs/hmp-cmd-info_mem.c b/stubs/hmp-cmd-info_mem.c
deleted file mode 100644
index 8a53e367a9f..00000000000
--- a/stubs/hmp-cmd-info_mem.c
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * Human Monitor 'info mem' stub
- *
- * Copyright (c) Linaro
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "monitor/hmp.h"
-
-HMP_STUB(info_mem)
diff --git a/stubs/hmp-cmd-info_tlb.c b/stubs/hmp-cmd-info_tlb.c
deleted file mode 100644
index a144e68c1c7..00000000000
--- a/stubs/hmp-cmd-info_tlb.c
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * Human Monitor 'info tlb' stub
- *
- * Copyright (c) Linaro
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "monitor/hmp.h"
-
-HMP_STUB(info_tlb)
diff --git a/stubs/meson.build b/stubs/meson.build
index 29b6644b254..41d3f114df9 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -71,7 +71,6 @@ if have_system
   # adding more of these.  If the symbol is used in specific_ss,
   # in particular, consider defining a preprocessor macro via
   # Kconfig or configs/targets/.
-  stub_ss.add(files('dump.c'))
   stub_ss.add(files('cmos.c'))
   stub_ss.add(files('fw_cfg.c'))
   if igvm.found()
@@ -85,13 +84,10 @@ if have_system
   stub_ss.add(files('qmp-i386-sev.c'))
   stub_ss.add(files('qmp-i386-sgx.c'))
   stub_ss.add(files('qmp-i386-xen.c'))
-  stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
   if have_hmp
-    stub_ss.add(files('hmp-cmd-info_mem.c'))
     stub_ss.add(files('hmp-cmd-info_sev.c'))
-    stub_ss.add(files('hmp-cmd-info_tlb.c'))
     stub_ss.add(files('hmp-cmds-hw-s390x.c'))
     stub_ss.add(files('hmp-cmds-target-i386.c'))
   endif
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
diff --git a/target-ops.c b/target-ops.c
new file mode 100644
index 00000000000..84ec427b680
--- /dev/null
+++ b/target-ops.c
@@ -0,0 +1,49 @@
+/*
+ * QEMU target CPU ops table
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/target-info-qapi.h"
+#include "qemu/target-ops.h"
+
+static TargetOps target_ops_table[SYS_EMU_TARGET__MAX];
+
+static void target_ops_store(SysEmuTarget arch, size_t offset, void *impl)
+{
+    void **slot;
+
+    slot = (void **)((char *)&target_ops_table[arch] + offset);
+    if (*slot && *slot != impl) {
+        error_report("TargetOps already registered for %s (offset %zu)",
+                     SysEmuTarget_str(arch), offset);
+        exit(1);
+    }
+    *slot = impl;
+}
+
+void target_ops_register(uint64_t arch_bitmask, size_t offset,
+                         void *impl)
+{
+    unsigned arch;
+
+    g_assert(offset + sizeof(void *) <= sizeof(TargetOps));
+    g_assert((offset % sizeof(void *)) == 0);
+    g_assert(arch_bitmask);
+
+    for (arch = 0; arch < SYS_EMU_TARGET__MAX; arch++) {
+        if (arch_bitmask & (1ULL << arch)) {
+            target_ops_store(arch, offset, impl);
+        }
+    }
+}
+
+const TargetOps *target_ops(void)
+{
+    SysEmuTarget arch = target_arch();
+
+    g_assert((unsigned)arch < SYS_EMU_TARGET__MAX);
+    return &target_ops_table[arch];
+}
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 1dd79849c13..feef7bc290b 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -24,6 +24,7 @@
 #include "system/dump.h"
 #include "cpu-features.h"
 #include "internals.h"
+#include "qemu/target-ops.h"
 
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
+TARGET_OPS_REGISTER(QEMU_ARCH_ARM, get_dump_info, arm_get_dump_info);
+TARGET_OPS_REGISTER(QEMU_ARCH_ARM, get_note_size, arm_get_note_size);
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 83ec95c290f..7fbe64b5252 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -32,6 +32,7 @@
 #include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
 #include "cpu.h"
+#include "qemu/target-ops.h"
 
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
+TARGET_OPS_REGISTER(QEMU_ARCH_ARM, query_cpu_definitions,
+                    arm_query_cpu_definitions);
+TARGET_OPS_REGISTER(QEMU_ARCH_ARM, query_cpu_model_expansion,
+                    arm_query_cpu_model_expansion);
diff --git a/target/arm/common-semi-target.c b/target/arm/common-semi-target.c
index 38d52deb3d6..f57715f378f 100644
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
@@ -34,29 +34,41 @@ void common_semi_set_ret(CPUState *cs, uint64_t ret)
     }
 }
 
-void common_semi_set_err(CPUState *cs, int err)
+static void arm_common_semi_set_err(CPUState *cs, int err)
 {
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
+    .set_err = arm_common_semi_set_err,
+    .is_64bit = arm_is_64bit_semihosting,
+    .sys_exit_is_extended = arm_common_semi_sys_exit_is_extended,
+    .stack_bottom = arm_common_semi_stack_bottom,
+    .has_synccache = arm_common_semi_has_synccache,
+};
+
+TARGET_OPS_REGISTER(QEMU_ARCH_ARM, semihosting, arm_semihosting_ops);
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
diff --git a/target/hexagon/common-semi-target.c b/target/hexagon/common-semi-target.c
index 210d33e54e2..86b6e1bcff4 100644
--- a/target/hexagon/common-semi-target.c
+++ b/target/hexagon/common-semi-target.c
@@ -11,41 +11,53 @@
 #include "cpu_helper.h"
 #include "semihosting/common-semi.h"
 
-uint64_t common_semi_arg(CPUState *cs, int argno)
+static uint64_t hexagon_common_semi_arg(CPUState *cs, int argno)
 {
     CPUHexagonState *env = cpu_env(cs);
     return env->gpr[HEX_REG_R00 + argno];
 }
 
-void common_semi_set_ret(CPUState *cs, uint64_t ret)
+static void hexagon_common_semi_set_ret(CPUState *cs, uint64_t ret)
 {
     CPUHexagonState *env = cpu_env(cs);
     env->gpr[HEX_REG_R00] = ret;
 }
 
-void common_semi_set_err(CPUState *cs, int err)
+static void hexagon_common_semi_set_err(CPUState *cs, int err)
 {
     CPUHexagonState *env = cpu_env(cs);
     env->gpr[HEX_REG_R01] = err;
 }
 
-bool common_semi_sys_exit_is_extended(CPUState *cs)
+static bool hexagon_common_semi_sys_exit_is_extended(CPUState *cs)
 {
     return false;
 }
 
-bool is_64bit_semihosting(CPUArchState *env)
+static bool hexagon_is_64bit_semihosting(CPUArchState *env)
 {
     return false;
 }
 
-uint64_t common_semi_stack_bottom(CPUState *cs)
+static uint64_t hexagon_common_semi_stack_bottom(CPUState *cs)
 {
     CPUHexagonState *env = cpu_env(cs);
     return env->gpr[HEX_REG_SP];
 }
 
-bool common_semi_has_synccache(CPUArchState *env)
+static bool hexagon_common_semi_has_synccache(CPUArchState *env)
 {
     return false;
 }
+
+static const CPUSemihostingOps hexagon_semihosting_ops = {
+    .arg = hexagon_common_semi_arg,
+    .set_ret = hexagon_common_semi_set_ret,
+    .set_err = hexagon_common_semi_set_err,
+    .is_64bit = hexagon_is_64bit_semihosting,
+    .sys_exit_is_extended = hexagon_common_semi_sys_exit_is_extended,
+    .stack_bottom = hexagon_common_semi_stack_bottom,
+    .has_synccache = hexagon_common_semi_has_synccache,
+};
+
+TARGET_OPS_REGISTER(QEMU_ARCH_HEXAGON, semihosting, hexagon_semihosting_ops);
diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index 16e47c4747d..2a035551ba6 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -16,6 +16,7 @@
 #include "system/dump.h"
 #include "elf.h"
 #include "system/memory_mapping.h"
+#include "qemu/target-ops.h"
 
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
+TARGET_OPS_REGISTER(QEMU_ARCH_I386, get_dump_info, x86_get_dump_info);
+TARGET_OPS_REGISTER(QEMU_ARCH_I386, get_note_size, x86_get_note_size);
diff --git a/target/i386/cpu-system.c b/target/i386/cpu-system.c
index c8bbf0cbafd..e3645a96f08 100644
--- a/target/i386/cpu-system.c
+++ b/target/i386/cpu-system.c
@@ -29,6 +29,7 @@
 #include "qapi/qapi-commands-machine.h"
 
 #include "cpu-internal.h"
+#include "qemu/target-ops.h"
 
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
 
+TARGET_OPS_REGISTER(QEMU_ARCH_I386, query_cpu_model_expansion,
+                    x86_query_cpu_model_expansion);
+
 void cpu_clear_apic_feature(CPUX86State *env)
 {
     env->features[FEAT_1_EDX] &= ~CPUID_APIC;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 74eebeabd7a..b240621c2b2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -48,6 +48,7 @@
 #include "system/address-spaces.h"
 #include "hw/core/boards.h"
 #include "hw/i386/sgx-epc.h"
+#include "qemu/target-ops.h"
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
 
+TARGET_OPS_REGISTER(QEMU_ARCH_I386, query_cpu_definitions,
+                    x86_query_cpu_definitions);
+
 #endif /* !CONFIG_USER_ONLY */
 
 static uint8_t x86_cpu_get_host_avx10_version(void)
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index ce61132e0f5..c3c2fabf7a8 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -26,6 +26,7 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
+#include "qemu/target-ops.h"
 #include "qobject/qdict.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
@@ -211,7 +212,7 @@ static void tlb_info_la57(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as)
 }
 #endif /* TARGET_X86_64 */
 
-void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
+static void hmp_info_tlb_i386(MonitorHMP *hmp, const QDict *qdict)
 {
     CPUArchState *env;
     AddressSpace *as;
@@ -537,7 +538,7 @@ static void mem_info_la57(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as)
 }
 #endif /* TARGET_X86_64 */
 
-void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
+static void hmp_info_mem_i386(MonitorHMP *hmp, const QDict *qdict)
 {
     CPUArchState *env;
     AddressSpace *as;
@@ -571,6 +572,9 @@ void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
     }
 }
 
+TARGET_OPS_REGISTER(QEMU_ARCH_I386, info_tlb, hmp_info_tlb_i386);
+TARGET_OPS_REGISTER(QEMU_ARCH_I386, info_mem, hmp_info_mem_i386);
+
 void hmp_mce(MonitorHMP *hmp, const QDict *qdict)
 {
     X86CPU *cpu;
diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index 9d84faef969..2cc494d9e82 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -22,6 +22,7 @@
 #include "elf.h"
 #include "system/dump.h"
 #include "internals.h"
+#include "qemu/target-ops.h"
 
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
+TARGET_OPS_REGISTER(QEMU_ARCH_LOONGARCH, get_dump_info, loongarch_get_dump_info);
+TARGET_OPS_REGISTER(QEMU_ARCH_LOONGARCH, get_note_size, loongarch_get_note_size);
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index f053f22bb8c..edf1a2a8773 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -14,6 +14,7 @@
 #include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qom/qom-qobject.h"
+#include "qemu/target-ops.h"
 
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
+TARGET_OPS_REGISTER(QEMU_ARCH_LOONGARCH, query_cpu_definitions,
+                    loongarch_query_cpu_definitions);
+TARGET_OPS_REGISTER(QEMU_ARCH_LOONGARCH, query_cpu_model_expansion,
+                    loongarch_query_cpu_model_expansion);
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index e8b1b25a43c..6f901898e22 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -8,10 +8,11 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/hmp.h"
+#include "qemu/target-ops.h"
 #include "monitor/monitor.h"
 
 #ifdef CONFIG_HMP
-void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
+static void hmp_info_tlb_m68k(MonitorHMP *hmp, const QDict *qdict)
 {
     CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
 
@@ -22,4 +23,5 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 
     dump_mmu(env1);
 }
+TARGET_OPS_REGISTER(QEMU_ARCH_M68K, info_tlb, hmp_info_tlb_m68k);
 #endif
diff --git a/target/mips/system/mips-qmp-cmds.c b/target/mips/system/mips-qmp-cmds.c
index b6a2874f2dd..3cd5dda3f8c 100644
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
+#include "qemu/target-ops.h"
 
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
+TARGET_OPS_REGISTER(QEMU_ARCH_MIPS, query_cpu_definitions,
+                    mips_query_cpu_definitions);
diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 80ac6c3e320..3cadf7525c8 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -17,6 +17,7 @@
 #include "elf.h"
 #include "system/dump.h"
 #include "system/kvm.h"
+#include "qemu/target-ops.h"
 
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
+TARGET_OPS_REGISTER(QEMU_ARCH_PPC, get_dump_info, ppc_get_dump_info);
+TARGET_OPS_REGISTER(QEMU_ARCH_PPC, get_note_size, ppc_get_note_size);
diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index 5a21c01593b..52930609251 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -9,10 +9,11 @@
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
+#include "qemu/target-ops.h"
 #include "cpu.h"
 
 #ifdef CONFIG_HMP
-void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
+static void hmp_info_tlb_ppc(MonitorHMP *hmp, const QDict *qdict)
 {
     CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
 
@@ -22,4 +23,5 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
     }
     dump_mmu(env1);
 }
+TARGET_OPS_REGISTER(QEMU_ARCH_PPC, info_tlb, hmp_info_tlb_ppc);
 #endif
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index 96228919966..0bf2031fed1 100644
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
+#include "qemu/target-ops.h"
 
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
+TARGET_OPS_REGISTER(QEMU_ARCH_PPC, query_cpu_definitions,
+                    ppc_query_cpu_definitions);
diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 12b68799070..7f581aca220 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "elf.h"
 #include "system/dump.h"
+#include "qemu/target-ops.h"
 
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
+TARGET_OPS_REGISTER(QEMU_ARCH_RISCV, get_dump_info, riscv_get_dump_info);
+TARGET_OPS_REGISTER(QEMU_ARCH_RISCV, get_note_size, riscv_get_note_size);
diff --git a/target/riscv/common-semi-target.c b/target/riscv/common-semi-target.c
index 38a00e160c3..954c64c3c08 100644
--- a/target/riscv/common-semi-target.c
+++ b/target/riscv/common-semi-target.c
@@ -12,42 +12,54 @@
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
 
-void common_semi_set_err(CPUState *cs, int err)
+static void riscv_common_semi_set_err(CPUState *cs, int err)
 {
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
+    .set_err = riscv_common_semi_set_err,
+    .is_64bit = riscv_is_64bit_semihosting,
+    .sys_exit_is_extended = riscv_common_semi_sys_exit_is_extended,
+    .stack_bottom = riscv_common_semi_stack_bottom,
+    .has_synccache = riscv_common_semi_has_synccache,
+};
+
+TARGET_OPS_REGISTER(QEMU_ARCH_RISCV, semihosting, riscv_semihosting_ops);
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index e1b51d2bd4d..93be2f599f2 100644
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
 
 riscv_stubs_ss = ss.source_set()
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 7e61ae2a471..64bc196387b 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -26,6 +26,7 @@
 #include "cpu_bits.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
+#include "qemu/target-ops.h"
 #include "system/memory.h"
 #include "internals.h"
 
@@ -217,7 +218,7 @@ static void mem_info_svxx(MonitorHMP *hmp, CPUArchState *env)
               last_paddr + last_size - pbase, last_attr);
 }
 
-void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
+static void hmp_info_mem_riscv(MonitorHMP *hmp, const QDict *qdict)
 {
     CPUArchState *env;
 
@@ -246,6 +247,7 @@ void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
 
     mem_info_svxx(hmp, env);
 }
+TARGET_OPS_REGISTER(QEMU_ARCH_RISCV, info_mem, hmp_info_mem_riscv);
 #endif /* CONFIG_HMP */
 
 #ifdef CONFIG_TCG
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 2647deef916..0b2c685f22b 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -36,6 +36,7 @@
 #include "cpu-qom.h"
 #include "cpu.h"
 #include "target/riscv/tcg/csr.h"
+#include "qemu/target-ops.h"
 
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
+TARGET_OPS_REGISTER(QEMU_ARCH_RISCV, query_cpu_definitions,
+                    riscv_query_cpu_definitions);
+TARGET_OPS_REGISTER(QEMU_ARCH_RISCV, query_cpu_model_expansion,
+                    riscv_query_cpu_model_expansion);
diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 2c26e992959..246fe529438 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -18,6 +18,7 @@
 #include "elf.h"
 #include "system/dump.h"
 #include "kvm/kvm_s390x.h"
+#include "qemu/target-ops.h"
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
+TARGET_OPS_REGISTER(QEMU_ARCH_S390X, get_dump_info, s390_get_dump_info);
+TARGET_OPS_REGISTER(QEMU_ARCH_S390X, get_note_size, s390_get_note_size);
diff --git a/target/s390x/cpu_models_system.c b/target/s390x/cpu_models_system.c
index 5b846048675..156008ebdec 100644
--- a/target/s390x/cpu_models_system.c
+++ b/target/s390x/cpu_models_system.c
@@ -20,6 +20,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qobject/qdict.h"
 #include "qapi/qapi-commands-machine.h"
+#include "qemu/target-ops.h"
 
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
+TARGET_OPS_REGISTER(QEMU_ARCH_S390X, query_cpu_definitions,
+                   s390_query_cpu_definitions);
+TARGET_OPS_REGISTER(QEMU_ARCH_S390X, query_cpu_model_expansion,
+                   s390_query_cpu_model_expansion);
diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
index 14261c05970..c40c3543ce8 100644
--- a/target/sh4/monitor.c
+++ b/target/sh4/monitor.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
+#include "qemu/target-ops.h"
 
 #ifdef CONFIG_HMP
 static void print_tlb(MonitorHMP *hmp, int idx, tlb_t *tlb)
@@ -39,7 +40,7 @@ static void print_tlb(MonitorHMP *hmp, int idx, tlb_t *tlb)
                        tlb->d, tlb->wt);
 }
 
-void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
+static void hmp_info_tlb_sh4(MonitorHMP *hmp, const QDict *qdict)
 {
     CPUArchState *env = monitor_hmp_get_cpu_env(hmp);
     int i;
@@ -56,4 +57,5 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
     for (i = 0 ; i < UTLB_SIZE ; i++)
         print_tlb(hmp, i, &env->utlb[i]);
 }
+TARGET_OPS_REGISTER(QEMU_ARCH_SH4, info_tlb, hmp_info_tlb_sh4);
 #endif
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index ed1e76fe73f..a22fb376e5d 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -25,10 +25,11 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
+#include "qemu/target-ops.h"
 
 
 #ifdef CONFIG_HMP
-void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
+static void hmp_info_tlb_sparc(MonitorHMP *hmp, const QDict *qdict)
 {
     CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
 
@@ -38,4 +39,5 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
     }
     dump_mmu(env1);
 }
+TARGET_OPS_REGISTER(QEMU_ARCH_SPARC, info_tlb, hmp_info_tlb_sparc);
 #endif
diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
index e0fcac8565d..e31c0dfcc28 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -25,9 +25,10 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
+#include "qemu/target-ops.h"
 
 #ifdef CONFIG_HMP
-void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
+static void hmp_info_tlb_xtensa(MonitorHMP *hmp, const QDict *qdict)
 {
     CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
 
@@ -37,4 +38,5 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
     }
     dump_mmu(env1);
 }
+TARGET_OPS_REGISTER(QEMU_ARCH_XTENSA, info_tlb, hmp_info_tlb_xtensa);
 #endif
-- 
2.55.0.windows.3


