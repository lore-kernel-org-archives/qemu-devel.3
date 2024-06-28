Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4974EC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 05:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN43A-0003ZU-MN; Fri, 28 Jun 2024 01:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sN435-0003Td-NW
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 01:21:27 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sN433-0008FQ-Ao
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 01:21:27 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-706b14044cbso200238b3a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 22:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719552083; x=1720156883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZT6BjdHhM0XdF9YTqRtBuRMtjA3/M/ng5tTzxuf0g8=;
 b=JkkqfMXWqzzGavQb5Tc3rDr/bMAXHRv+DTaojF+KHMqWc/OFHskZIbX2/UQooUlQLy
 ibxDm7OkFZwLnEXAFbhvLLrCb9Vq3Kp+Ii/gHvUnLlTd75kw8/nfcruwBpUaXGQpiqsv
 kO5Q4gbQMKwA+6yWY1Ee9PvDZIbM5gLvAC0hsINTjNmT/gpRgosFn9U1FruwiTb3M8iU
 VpsgA0kineFX4zqqqIQgBXOKjLWavU0a/VG+OYzpfLG17RBF9PfsAU1jJG03L+gwe5nm
 D5aN8lQUQvmd0L4It6BnxYkMxctdVHw4jDOub5Zn1aOPrK2ER76IT/oJ181JZhz4FVLf
 efJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719552083; x=1720156883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZT6BjdHhM0XdF9YTqRtBuRMtjA3/M/ng5tTzxuf0g8=;
 b=CspcJLjHgi3AJxBdQLWMjoadNbeHJlGTZiOxjJqahfPRsukPtRSLQKPv9DdASE1nXo
 27SKSoBrdU7Am5tgYl6Rl1pCOwkbC/6XS0rnFXP69M9IiX0v3XvFELCfnwXUALirECYU
 Lpsjki1+ehT4uGnNh+1zpctQmoTi1JFB5JoxwDM+woVwzmdpRZQxYlEQW8bCjslO64QA
 715QMSdQHEykfek0m6Bq0hzmeD+A8eET5iyzlP8nd6b1TZC+IT+8a5W12gVqELTAN+rn
 N2DWiQcW3v82a4UsksLxUvwoxmDYBkvNtP8mcOtAUhWKqBYloRf6xEnuRXR0BxgOvfar
 qIgA==
X-Gm-Message-State: AOJu0YxsDNRY7d2Kthkp9KEzSwvGAHuvIMkMy5B801iOhxKLzNc13ew8
 lAa8KA9Ci3O9neKD78J+sND43FBTBEp1i+G8c7RIQ7FvgedymWPpeevjQr/7PYkyx4+BJYRRafa
 /
X-Google-Smtp-Source: AGHT+IHdmLlLaNJy9lkPLu27htjJ6Vx+W3pDSVIY3nUEC7+rdrGr9iF7wFuSWX2+DPaT5pXqxc9i+Q==
X-Received: by 2002:a05:6a00:80d5:b0:706:3329:5533 with SMTP id
 d2e1a72fcca58-7067469450amr13823003b3a.24.1719552083070; 
 Thu, 27 Jun 2024 22:21:23 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:391e:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72c6b2a16cdsm423932a12.46.2024.06.27.22.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 22:21:22 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 10/11] gdbstub: Add support for MTE in user mode
Date: Fri, 28 Jun 2024 05:08:49 +0000
Message-Id: <20240628050850.536447-11-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628050850.536447-1-gustavo.romero@linaro.org>
References: <20240628050850.536447-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x433.google.com
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

This commit implements the stubs to handle the qIsAddressTagged,
qMemTag, and QMemTag GDB packets, allowing all GDB 'memory-tag'
subcommands to work with QEMU gdbstub on aarch64 user mode. It also
implements the get/set functions for the special GDB MTE register
'tag_ctl', used to control the MTE fault type at runtime.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 configs/targets/aarch64-linux-user.mak |   2 +-
 gdb-xml/aarch64-mte.xml                |  11 ++
 target/arm/cpu.c                       |   1 +
 target/arm/gdbstub.c                   |  46 +++++
 target/arm/gdbstub64.c                 | 223 +++++++++++++++++++++++++
 target/arm/internals.h                 |   6 +
 6 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 gdb-xml/aarch64-mte.xml

diff --git a/configs/targets/aarch64-linux-user.mak b/configs/targets/aarch64-linux-user.mak
index ba8bc5fe3f..8f0ed21d76 100644
--- a/configs/targets/aarch64-linux-user.mak
+++ b/configs/targets/aarch64-linux-user.mak
@@ -1,6 +1,6 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
-TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml
+TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
diff --git a/gdb-xml/aarch64-mte.xml b/gdb-xml/aarch64-mte.xml
new file mode 100644
index 0000000000..4b70b4f17a
--- /dev/null
+++ b/gdb-xml/aarch64-mte.xml
@@ -0,0 +1,11 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2021-2023 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.aarch64.mte">
+  <reg name="tag_ctl" bitsize="64" type="uint64" group="system" save-restore="no"/>
+</feature>
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 35fa281f1b..14d4eca127 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2518,6 +2518,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
     register_cp_regs_for_features(cpu);
     arm_cpu_register_gdb_regs_for_features(cpu);
+    arm_cpu_register_gdb_commands(cpu);
 
     init_cpreg_list(cpu);
 
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index a3bb73cfa7..c3a9b5eb1e 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/helpers.h"
+#include "gdbstub/commands.h"
 #include "sysemu/tcg.h"
 #include "internals.h"
 #include "cpu-features.h"
@@ -474,6 +475,41 @@ static GDBFeature *arm_gen_dynamic_m_secextreg_feature(CPUState *cs,
 #endif
 #endif /* CONFIG_TCG */
 
+void arm_cpu_register_gdb_commands(ARMCPU *cpu)
+{
+    GArray *query_table =
+        g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
+    GArray *set_table =
+        g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
+    GString *qsupported_features = g_string_new(NULL);
+
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+    #ifdef TARGET_AARCH64
+        aarch64_cpu_register_gdb_commands(cpu, qsupported_features, query_table,
+                                          set_table);
+    #endif
+    }
+
+    /* Set arch-specific handlers for 'q' commands. */
+    if (query_table->len) {
+        gdb_extend_query_table(&g_array_index(query_table,
+                                              GdbCmdParseEntry, 0),
+                                              query_table->len);
+    }
+
+    /* Set arch-specific handlers for 'Q' commands. */
+    if (set_table->len) {
+        gdb_extend_set_table(&g_array_index(set_table,
+                             GdbCmdParseEntry, 0),
+                             set_table->len);
+    }
+
+    /* Set arch-specific qSupported feature. */
+    if (qsupported_features->len) {
+        gdb_extend_qsupported_features(qsupported_features->str);
+    }
+}
+
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
@@ -507,6 +543,16 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                                      gdb_find_static_feature("aarch64-pauth.xml"),
                                      0);
         }
+
+#ifdef CONFIG_USER_ONLY
+        /* Memory Tagging Extension (MTE) 'tag_ctl' pseudo-register. */
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            gdb_register_coprocessor(cs, aarch64_gdb_get_tag_ctl_reg,
+                                     aarch64_gdb_set_tag_ctl_reg,
+                                     gdb_find_static_feature("aarch64-mte.xml"),
+                                     0);
+        }
+#endif
 #endif
     } else {
         if (arm_feature(env, ARM_FEATURE_NEON)) {
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index caa31ff3fa..2e2bc2700b 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -21,6 +21,12 @@
 #include "cpu.h"
 #include "internals.h"
 #include "gdbstub/helpers.h"
+#include "gdbstub/commands.h"
+#include "tcg/mte_helper.h"
+#if defined(CONFIG_USER_ONLY) && defined(CONFIG_LINUX)
+#include <sys/prctl.h>
+#include "mte_user_helper.h"
+#endif
 
 int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
@@ -381,3 +387,220 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cs, int base_reg)
 
     return &cpu->dyn_svereg_feature.desc;
 }
+
+#ifdef CONFIG_USER_ONLY
+int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    uint64_t tcf0;
+
+    assert(reg == 0);
+
+    tcf0 = extract64(env->cp15.sctlr_el[1], 38, 2);
+
+    return gdb_get_reg64(buf, tcf0);
+}
+
+int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    uint8_t tcf;
+
+    assert(reg == 0);
+
+    tcf = *buf << PR_MTE_TCF_SHIFT;
+
+    if (!tcf) {
+        return 0;
+    }
+
+    /*
+     * 'tag_ctl' register is actually a "pseudo-register" provided by GDB to
+     * expose options regarding the type of MTE fault that can be controlled at
+     * runtime.
+     */
+    arm_set_mte_tcf0(env, tcf);
+
+    return 1;
+}
+
+static void handle_q_memtag(GArray *params, void *user_ctx)
+{
+    ARMCPU *cpu = ARM_CPU(user_ctx);
+    CPUARMState *env = &cpu->env;
+
+    uint64_t addr = gdb_get_cmd_param(params, 0)->val_ull;
+    uint64_t len = gdb_get_cmd_param(params, 1)->val_ul;
+    int type = gdb_get_cmd_param(params, 2)->val_ul;
+
+    uint8_t *tags;
+    uint8_t addr_tag;
+
+    g_autoptr(GString) str_buf = g_string_new(NULL);
+
+    /*
+     * GDB does not query multiple tags for a memory range on remote targets, so
+     * that's not supported either by gdbstub.
+     */
+    if (len != 1) {
+        gdb_put_packet("E02");
+    }
+
+    /* GDB never queries a tag different from an allocation tag (type 1). */
+    if (type != 1) {
+        gdb_put_packet("E03");
+    }
+
+    /* Note that tags are packed here (2 tags packed in one byte). */
+    tags = allocation_tag_mem_probe(env, 0, addr, MMU_DATA_LOAD, 8 /* 64-bit */,
+                                    MMU_DATA_LOAD, true, 0);
+    if (!tags) {
+        /* Address is not in a tagged region. */
+        gdb_put_packet("E04");
+        return;
+    }
+
+    /* Unpack tag from byte. */
+    addr_tag = load_tag1(addr, tags);
+    g_string_printf(str_buf, "m%.2x", addr_tag);
+
+    gdb_put_packet(str_buf->str);
+}
+
+static void handle_q_isaddresstagged(GArray *params, void *user_ctx)
+{
+    ARMCPU *cpu = ARM_CPU(user_ctx);
+    CPUARMState *env = &cpu->env;
+
+    uint64_t addr = gdb_get_cmd_param(params, 0)->val_ull;
+
+    uint8_t *tags;
+    const char *reply;
+
+    tags = allocation_tag_mem_probe(env, 0, addr, MMU_DATA_LOAD, 8 /* 64-bit */,
+                                    MMU_DATA_LOAD, true, 0);
+    reply = tags ? "01" : "00";
+
+    gdb_put_packet(reply);
+}
+
+static void handle_Q_memtag(GArray *params, void *user_ctx)
+{
+    ARMCPU *cpu = ARM_CPU(user_ctx);
+    CPUARMState *env = &cpu->env;
+
+    uint64_t start_addr = gdb_get_cmd_param(params, 0)->val_ull;
+    uint64_t len = gdb_get_cmd_param(params, 1)->val_ul;
+    int type = gdb_get_cmd_param(params, 2)->val_ul;
+    char const *new_tags_str = gdb_get_cmd_param(params, 3)->data;
+
+    uint64_t end_addr;
+
+    int num_new_tags;
+    uint8_t *tags;
+
+    g_autoptr(GByteArray) new_tags = g_byte_array_new();
+
+    /*
+     * Only the allocation tag (i.e. type 1) can be set at the stub side.
+     */
+    if (type != 1) {
+        gdb_put_packet("E02");
+        return;
+    }
+
+    end_addr = start_addr + (len - 1); /* 'len' is always >= 1 */
+    /* Check if request's memory range does not cross page boundaries. */
+    if ((start_addr ^ end_addr) & TARGET_PAGE_MASK) {
+        gdb_put_packet("E03");
+        return;
+    }
+
+    /*
+     * Get all tags in the page starting from the tag of the start address.
+     * Note that there are two tags packed into a single byte here.
+     */
+    tags = allocation_tag_mem_probe(env, 0, start_addr, MMU_DATA_STORE,
+                                    8 /* 64-bit */, MMU_DATA_STORE, true, 0);
+    if (!tags) {
+        /* Address is not in a tagged region. */
+        gdb_put_packet("E04");
+        return;
+    }
+
+    /* Convert tags provided by GDB, 2 hex digits per tag. */
+    num_new_tags = strlen(new_tags_str) / 2;
+    gdb_hextomem(new_tags, new_tags_str, num_new_tags);
+
+    uint64_t address = start_addr;
+    int new_tag_index = 0;
+    while (address <= end_addr) {
+        uint8_t new_tag;
+        int packed_index;
+
+        /*
+         * Find packed tag index from unpacked tag index. There are two tags
+         * in one packed index (one tag per nibble).
+         */
+        packed_index = new_tag_index / 2;
+
+        new_tag = new_tags->data[new_tag_index % num_new_tags];
+        store_tag1(address, tags + packed_index, new_tag);
+
+        address += TAG_GRANULE;
+        new_tag_index++;
+    }
+
+    gdb_put_packet("OK");
+}
+
+enum Command {
+    qMemTags,
+    qIsAddressTagged,
+    QMemTags,
+    NUM_CMDS
+};
+
+static GdbCmdParseEntry cmd_handler_table[NUM_CMDS] = {
+    [qMemTags] = {
+        .handler = handle_q_memtag,
+        .cmd_startswith = true,
+        .cmd = "MemTags:",
+        .schema = "L,l:l0",
+        .need_cpu_context = true
+    },
+    [qIsAddressTagged] = {
+        .handler = handle_q_isaddresstagged,
+        .cmd_startswith = true,
+        .cmd = "IsAddressTagged:",
+        .schema = "L0",
+        .need_cpu_context = true
+    },
+    [QMemTags] = {
+        .handler = handle_Q_memtag,
+        .cmd_startswith = true,
+        .cmd = "MemTags:",
+        .schema = "L,l:l:s0",
+        .need_cpu_context = true
+    },
+};
+#endif /* CONFIG_USER_ONLY */
+
+void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *qsupported,
+                                       GArray *qtable, GArray *stable)
+{
+#ifdef CONFIG_USER_ONLY
+    /* MTE */
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        g_string_append(qsupported, ";memory-tagging+");
+
+        g_array_append_val(qtable, cmd_handler_table[qMemTags]);
+        g_array_append_val(qtable, cmd_handler_table[qIsAddressTagged]);
+
+        g_array_append_val(stable, cmd_handler_table[QMemTags]);
+    }
+#endif
+}
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 11b5da2562..e1aa1a63b9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -358,6 +358,10 @@ void init_cpreg_list(ARMCPU *cpu);
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
 void arm_translate_init(void);
 
+void arm_cpu_register_gdb_commands(ARMCPU *cpu);
+void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *, GArray *,
+                                       GArray *);
+
 void arm_restore_state_to_opc(CPUState *cs,
                               const TranslationBlock *tb,
                               const uint64_t *data);
@@ -1640,6 +1644,8 @@ int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg);
 int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_pauth_reg(CPUState *cs, uint8_t *buf, int reg);
+int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg);
+int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg);
 void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
 void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp);
 void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
-- 
2.34.1


