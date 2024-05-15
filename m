Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD53C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7IUU-0005Ew-4V; Wed, 15 May 2024 13:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1s7IUN-0005Dk-Qb
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:32:28 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1s7IUL-0002Lo-Gd
 for qemu-devel@nongnu.org; Wed, 15 May 2024 13:32:27 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f6765226d0so863648b3a.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 10:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715794344; x=1716399144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MookKR+/GmP35DnsiVAP+dRajwJAWlDX42VUKJPxMJA=;
 b=Uy4zcatInChOMXqn6crPWOjGfXXI73UFeU/3firoY/F8Mxiiae4NeghHcjy0GrlRmu
 CFJjd+S3L0ZODhAn1gln60ngc+JCub1X1Qf+UXD9l9lnjdWz4TlWQXUKJxwGTo+QrWWH
 IcjF5p/UMZ7lIz6VyRHrbvhV4QuWSJB3d3JL6TrgviwFGCZkpiB2THEFA6h45QpBj4YB
 XV6RGgi+R9YYKogEKDqlFUp7ZzRJsr7w1zg7EKbtL+uk9c8G+DhRLx0kDBg1LEZ0aPlm
 opge+2vcqbN4MAH2ffkL8kkFqMclOv5+fue2AWgZM6mXhLWvLMKd3lHohZkImGOkga18
 AGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715794344; x=1716399144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MookKR+/GmP35DnsiVAP+dRajwJAWlDX42VUKJPxMJA=;
 b=bjjHsYzOlvkvQjeBYdfX7EJ3BOXOGBvUdsniikus6ZCpHkqxsG83nYvPyBlMtjF+V6
 8MJujQOXwyaXY9sM9mKEntf3diA81QcCLLOlk1wC9jkERNfgnThZIwcRdbCzyJU7PGS1
 2w8dAz4MjwEAz/7f4zS+gYqaxT/J/Bo8EOJ0GbC1jNGh3zG2RHpBD4c3eCrRqjXzx7Mw
 yNX3B4Pyfp74wau6zl057Mv29e3JFd28xkejuhH1kteUdWeTUHYV6WvdnOep0dFTtJem
 rOD3+uHryV9D0u/apEZjjSYeFN9kpn/n/acDqzD+FgcBJfwKJ+f+wFRkqbRQGuLM4jd5
 t4lw==
X-Gm-Message-State: AOJu0YxQdPCA2ulpYlzCZ9DRMrgIHMGAGEtt5rThUsdETA89w9Z65Keg
 TuWR9QW+ygmUVjKhLh5sA8RG3Y1GhYJzuSUZyGxEZI+uAfdmr6X17A18fdmfHb5qYbzBzC+1SYN
 D+xc=
X-Google-Smtp-Source: AGHT+IG3AycnlZJFGNJFhJsPVK1ZuT6WhEtAjwuk3isCdUooMDI0Kk9BnhptbN+JBaD7Cq/kKX5Atw==
X-Received: by 2002:a05:6a20:9697:b0:1af:d1b2:4c21 with SMTP id
 adf61e73a8af0-1afde197972mr15766294637.41.1715794343629; 
 Wed, 15 May 2024 10:32:23 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:224b:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a66c6asm11365133b3a.6.2024.05.15.10.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 10:32:23 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH 2/4] gdbstub: Add support for MTE in user mode
Date: Wed, 15 May 2024 17:31:30 +0000
Message-Id: <20240515173132.2462201-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515173132.2462201-1-gustavo.romero@linaro.org>
References: <20240515173132.2462201-1-gustavo.romero@linaro.org>
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
implements the get/set function for the special GDB MTE register
'tag_ctl', used to control the MTE fault type at runtime.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 configs/targets/aarch64-linux-user.mak |   2 +-
 target/arm/cpu.c                       |   1 +
 target/arm/gdbstub.c                   | 321 +++++++++++++++++++++++++
 target/arm/internals.h                 |   2 +
 4 files changed, 325 insertions(+), 1 deletion(-)

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
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 77f8c9c748..29f7b99a88 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2479,6 +2479,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
     register_cp_regs_for_features(cpu);
     arm_cpu_register_gdb_regs_for_features(cpu);
+    arm_cpu_register_gdb_commands(cpu);
 
     init_cpreg_list(cpu);
 
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index a3bb73cfa7..f3897f75b3 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -474,6 +474,317 @@ static GDBFeature *arm_gen_dynamic_m_secextreg_feature(CPUState *cs,
 #endif
 #endif /* CONFIG_TCG */
 
+#ifdef TARGET_AARCH64
+#ifdef CONFIG_USER_ONLY
+static int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, struct _GByteArray *buf, int reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    uint64_t tcf0;
+
+    assert(reg == 0);
+
+    /* TCF0, bits [39:38]. */
+    tcf0 = extract64(env->cp15.sctlr_el[1], 38, 2);
+
+    return gdb_get_reg64(buf, tcf0);
+}
+
+static int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    assert(reg == 0);
+
+    /* Sanitize TCF0 bits. */
+    *buf &= 0x03;
+
+    if (!isar_feature_aa64_mte3(&cpu->isar) && *buf == 3) {
+        /*
+         * If FEAT_MTE3 is not implemented, the value 0b11 is reserved, hence
+         * ignore setting it.
+         */
+        return 0;
+    }
+
+    /*
+     * 'tag_ctl' register is actually a "pseudo-register" provided by GDB to
+     * expose options that can be controlled at runtime and has the same effect
+     * of prctl() with option PR_SET_TAGGED_ADDR_CTRL,
+     * i.e. prctl(PR_SET_TAGGED_ADDR_CTRL, tcf, 0, 0, 0), hence it controls
+     * the effect of Tag Check Faults (TCF) due to Loads and Stores in EL0.
+     */
+    env->cp15.sctlr_el[1] = deposit64(env->cp15.sctlr_el[1], 38, 2, *buf);
+
+    return 1;
+}
+
+static void handle_q_memtag(GArray *params, G_GNUC_UNUSED void *user_ctx)
+{
+    uint64_t addr = get_param(params, 0)->val_ull;
+    uint64_t len = get_param(params, 1)->val_ul;
+    int type = get_param(params, 2)->val_ul;
+
+    uint64_t clean_addr;
+    uint8_t *tags;
+    int granules_index;
+    int granule_index;
+    uint8_t addr_tag;
+
+    g_autoptr(GString) str_buf = g_string_new(NULL);
+
+    /*
+     * GDB does not query tags for a memory range on remote targets, so that's
+     * not supported either by gdbstub.
+     */
+    if (len != 1) {
+        gdb_put_packet("E02");
+    }
+
+    /* GDB never queries a tag different from an allocation tag (type 1). */
+    if (type != 1) {
+        gdb_put_packet("E02");
+    }
+
+    /* Remove any non-addressing bits. */
+    clean_addr = useronly_clean_ptr(addr);
+
+    /*
+     * Get pointer to all tags in the page where the address is. Note that tags
+     * are packed, so there are 2 tags packed in one byte.
+     */
+    tags = page_get_target_data(clean_addr);
+
+    /*
+     * Tags are per granule (16 bytes). 2 tags (4 bits each) are kept in a
+     * single byte for compactness, so first a page tag index for 2 packed
+     * granule tags (1 byte) is found, and then an index for a single granule
+     * tag (nibble) is found, and finally the address tag is obtained.
+     */
+    granules_index = extract32(clean_addr, LOG2_TAG_GRANULE + 1,
+                               TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
+    granule_index = extract32(clean_addr, LOG2_TAG_GRANULE, 1);
+
+    addr_tag = *(tags + granules_index);
+    /* Extract tag from the right nibble. */
+    if (granule_index == 0) {
+        addr_tag &= 0xF;
+    } else {
+        addr_tag >>= 4;
+    }
+
+    g_string_printf(str_buf, "m%.2x", addr_tag);
+
+    gdb_put_packet(str_buf->str);
+}
+
+static void handle_q_isaddresstagged(GArray *params, G_GNUC_UNUSED void *user_ctx)
+{
+    uint64_t addr = get_param(params, 0)->val_ull;
+
+    uint64_t clean_addr;
+    int mflags;
+
+    g_autoptr(GString) str_buf = g_string_new(NULL);
+
+    /* Remove any non-addressing bits. */
+    clean_addr = useronly_clean_ptr(addr);
+
+    mflags = page_get_flags(clean_addr);
+    if (mflags & PAGE_ANON && mflags & PAGE_MTE) {
+        /* Address is tagged. */
+        g_string_printf(str_buf, "%.2x", 1 /* true */);
+    } else {
+        /* Address is not tagged. */
+        g_string_printf(str_buf, "%.2x", 0 /* false */);
+    }
+
+    gdb_put_packet(str_buf->str);
+}
+
+static void handle_Q_memtag(GArray *params, G_GNUC_UNUSED void *user_ctx)
+{
+    uint64_t addr = get_param(params, 0)->val_ull;
+    uint64_t len = get_param(params, 1)->val_ul;
+    int type = get_param(params, 2)->val_ul;
+    char const *new_tags = get_param(params, 3)->data;
+
+    uint64_t clean_addr;
+    int last_addr_index;
+
+    uint64_t start_addr_page;
+    uint64_t end_addr_page;
+
+    uint32_t first_tag_index;
+    uint32_t last_tag_index;
+
+    uint8_t *tags; /* Pointer to the current tags in a page. */
+    int num_new_tags;
+
+    g_autoptr(GString) str_buf = g_string_new(NULL);
+
+    /*
+     * Only the allocation tag (type 1) can be set at the stub side.
+     */
+    if (type != 1) {
+        gdb_put_packet("E02");
+        return;
+    }
+
+    /*
+     * 'len' is always >= 1 and refers to the size of the memory range about to
+     * have its tags updated. However, it's convenient to obtain the index for
+     * the last byte of the memory range for page boundary checks and for
+     * obtaining the indexes for the tags in the page.
+     */
+    last_addr_index = len - 1;
+
+    /* Remove any non-addressing bits. */
+    clean_addr = useronly_clean_ptr(addr);
+
+    start_addr_page = extract64(clean_addr, TARGET_PAGE_BITS,
+                                64 - TARGET_PAGE_BITS);
+    end_addr_page = extract64(clean_addr + last_addr_index, TARGET_PAGE_BITS,
+                              64 - TARGET_PAGE_BITS);
+
+    /*
+     * Check if memory range is within page boundaries.
+     */
+    if (start_addr_page != end_addr_page) {
+        gdb_put_packet("E03");
+        return;
+    }
+
+    /*
+     * Get pointer to all tags in the page where the address is. Note that here
+     * tags are packed, so there are 2 tags packed in one byte.
+     */
+    tags = page_get_target_data(clean_addr);
+
+    /* Tag indices below refer to unpacked tags. */
+    first_tag_index = extract32(clean_addr, LOG2_TAG_GRANULE,
+                                TARGET_PAGE_BITS - LOG2_TAG_GRANULE);
+    last_tag_index = extract32(clean_addr + last_addr_index, LOG2_TAG_GRANULE,
+                               TARGET_PAGE_BITS - LOG2_TAG_GRANULE);
+
+    /*
+     * GDB sends 2 hex digits per tag number, i.e. tags are not represented in
+     * a packed way.
+     */
+    num_new_tags = strlen(new_tags) / 2;
+
+    /*
+     * If the number of tags provided is greater than the number of tags
+     * in the provided memory range, the exceeding tags are ignored. If the
+     * number of tags is less than the number of tags in the provided memory
+     * range, then the provided tags are used as a repeating pattern to fill
+     * the tags in the provided memory range.
+     */
+    for (int i = first_tag_index, j = 0; i <= last_tag_index; i++, j++) {
+        int new_tag_value;
+        int packed_granules_index;
+        int nibble_index;
+
+        sscanf(new_tags + 2 * (j % num_new_tags), "%2x", &new_tag_value);
+        /*
+         * Find packed tag index from unpacked tag index. There are two tags
+         * packed in one packed index. One tag per nibble.
+         */
+        packed_granules_index = i / 2;
+        /* Find nibble index in the packed tag from unpacked tag index. */
+        nibble_index = i % 2;
+
+        if (nibble_index == 0) { /* Update low nibble */
+            *(tags + packed_granules_index) &= 0xF0;
+            *(tags + packed_granules_index) |= (new_tag_value & 0x0F);
+        } else { /* Update high nibble */
+            *(tags + packed_granules_index) &= 0x0F;
+            *(tags + packed_granules_index) |= ((new_tag_value & 0x0F) << 4);
+        }
+    }
+
+    g_string_printf(str_buf, "OK");
+
+    gdb_put_packet(str_buf->str);
+}
+
+enum Packet {
+    qMemTags,
+    qIsAddressTagged,
+    QMemTags,
+    NUM_PACKETS
+};
+
+static GdbCmdParseEntry packet_handler_table[NUM_PACKETS] = {
+    [qMemTags] = {
+        .handler = handle_q_memtag,
+        .cmd_startswith = 1,
+        .cmd = "MemTags:",
+        .schema = "L,l:l0"
+    },
+    [qIsAddressTagged] = {
+        .handler = handle_q_isaddresstagged,
+        .cmd_startswith = 1,
+        .cmd = "IsAddressTagged:",
+        .schema = "L0"
+    },
+    [QMemTags] = {
+        .handler = handle_Q_memtag,
+        .cmd_startswith = 1,
+        .cmd = "MemTags:",
+        .schema = "L,l:l:s0"
+    },
+};
+
+static void add_packet_handler(GArray *handlers, enum Packet packet) {
+    g_array_append_val(handlers, packet_handler_table[packet]);
+}
+#endif /* CONFIG_USER_ONLY */
+#endif /* TARGET_AARCH64 */
+
+void arm_cpu_register_gdb_commands(ARMCPU *cpu)
+{
+    GArray *gdb_gen_query_table_arm =
+        g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
+    GArray *gdb_gen_set_table_arm =
+        g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
+    GString *supported_features = g_string_new(NULL);
+
+#ifdef TARGET_AARCH64
+#ifdef CONFIG_USER_ONLY
+    /* MTE */
+    if (isar_feature_aa64_mte(&cpu->isar)) {
+        g_string_append(supported_features, ";memory-tagging+");
+
+        add_packet_handler(gdb_gen_query_table_arm, qMemTags);
+        add_packet_handler(gdb_gen_query_table_arm, qIsAddressTagged);
+
+        add_packet_handler(gdb_gen_set_table_arm, QMemTags);
+    }
+#endif
+#endif
+
+    /* Set arch-specific handlers for 'q' commands. */
+    if (gdb_gen_query_table_arm->len) {
+        set_gdb_gen_query_table_arch(&g_array_index(gdb_gen_query_table_arm,
+                                                    GdbCmdParseEntry, 0),
+                                                    gdb_gen_query_table_arm->len);
+    }
+
+    /* Set arch-specific handlers for 'Q' commands. */
+    if (gdb_gen_set_table_arm->len) {
+        set_gdb_gen_set_table_arch(&g_array_index(gdb_gen_set_table_arm,
+                                   GdbCmdParseEntry, 0),
+                                   gdb_gen_set_table_arm->len);
+    }
+
+    /* Set arch-specific qSupported feature. */
+    if (supported_features->len) {
+        set_query_supported_arch(supported_features->str);
+    }
+}
+
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
@@ -507,6 +818,16 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                                      gdb_find_static_feature("aarch64-pauth.xml"),
                                      0);
         }
+
+#ifdef CONFIG_USER_ONLY
+        /* Memory Tagging Extension (MTE) 'tag_ctl' register. */
+        if (isar_feature_aa64_mte(&cpu->isar)) {
+            gdb_register_coprocessor(cs, aarch64_gdb_get_tag_ctl_reg,
+                                     aarch64_gdb_set_tag_ctl_reg,
+                                     gdb_find_static_feature("aarch64-mte.xml"),
+                                     0);
+        }
+#endif
 #endif
     } else {
         if (arm_feature(env, ARM_FEATURE_NEON)) {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index ee3ebd383e..3750591b44 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -358,6 +358,8 @@ void init_cpreg_list(ARMCPU *cpu);
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
 void arm_translate_init(void);
 
+void arm_cpu_register_gdb_commands(ARMCPU *cpu);
+
 void arm_restore_state_to_opc(CPUState *cs,
                               const TranslationBlock *tb,
                               const uint64_t *data);
-- 
2.34.1


