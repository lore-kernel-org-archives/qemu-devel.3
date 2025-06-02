Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55468C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 06:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLyZE-0006zO-FT; Mon, 02 Jun 2025 02:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLyLP-0006dB-9p
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:08:41 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLyLN-000267-1P
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:08:22 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-742c46611b6so4770241b3a.1
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 23:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748844499; x=1749449299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPW9cvoZQOFKn265fT0C9YsWhp1QsIxLy+heF7oF2xw=;
 b=fqpFth/FPDh65EfP4VAuNIMxYXTBvs12HZnfTK9in5T615bnu/OBpwb6L1ioQFX6on
 ZS90eZm4GcvhyoFBN4d6OwGW5NeMUjoRol661+sshsGt3sVqEK5j39VblQGvUy1T/fD+
 Uk1cKOwz/Xj1nOCdOrg4U9wHFHh6Rg8HliJ2hAo9HM4L+ohKx8uGRwR7R5pnj/QN/OTA
 pPw2szkKENnHkZ9rukNeZfY+KmOqO+bnjoL9kinBpeT4UY70C6QY25NeOOMjJ4dUsx3G
 te3K+A03DikuO+sEaZlBc3AXzSrhfwbwYSmoC8F8sD05SkhDuxXGpiL8ifg9iXAalRSq
 /+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748844499; x=1749449299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPW9cvoZQOFKn265fT0C9YsWhp1QsIxLy+heF7oF2xw=;
 b=HDjKsETKfYv1OpSY7LgnIP9xNJ10kIIyTrrR05UIYogMdA+Eqsvnf7BuKe6sgTZpG8
 rDohEOLusc0BdRlQVtB4sMZ/zc8U8hAvU3qKKQq968CBa0+jAdR7f3lm3pM8faaRm7R5
 34LIa56vCSx9FmouYwMoML17nsTjjObIlJGLaDnkN3C+VhSWSrJl8YLZEtr6yAdbgBf6
 rFLNeZoSGF6SvPv+3L4G6lBHr0bIApKihtKYKvwVh9oVFd2/gIMowh8D06TStzLZZsNs
 tt3Uq7H5c3uV0vd3y4h1OA27jkKtKb9uanXoZ0TyalUCt3buQpYqk8WihSjnXOuvWvzm
 VsBA==
X-Gm-Message-State: AOJu0YyTkVkuRolnPAXhqZ+dt55w13Lz2XHGHUlpzJGcG4pRss2iR7Nl
 cv4QQNMDHpHRJOxaTQvfZfX4v6+9Atvo2GeekDTsSTSBYYu9xZqI+GM1kYU14WN6CoI=
X-Gm-Gg: ASbGncurTfzW4Dm1fcCxHsyOu6PwyXfJeUqFdvuGxSQPCigtSabajClMCMy2T4uyxzU
 l6JNNHcUXIP3Jz3qDsYal0Ahv4gio3jABlyLlNc/cZNOBy9/Rh2nqS7bpGcEMj2hJsHap2ecII1
 5vlPF5xFTIu8LYVvhOCqVadMgj+OGlPNV2rke9o8WgV76pUkoLEsbu1PKEPW5wrhsejvNqteLAx
 eOymKWm0g+BeWTpmWKuJla7NOnd96z5HaFAqyXvVULitNhMgOI+gUHjjErZprN4nFASidGxAc2e
 NNDk/p42asIW9tVyCdSWn9rPfsWr7vQfwJXBAOEiVLHj5pLOM40=
X-Google-Smtp-Source: AGHT+IHGAk4WQQyiuQbeksAnTVG0kFzCtNRgDv0ui2SI/N7pSl74Sww6LYK1nUIFkVQuftZ2sY+Bpw==
X-Received: by 2002:a05:6a00:982:b0:740:9331:78f0 with SMTP id
 d2e1a72fcca58-747c1c657f7mr12715284b3a.22.1748844499308; 
 Sun, 01 Jun 2025 23:08:19 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afff7388sm7036966b3a.171.2025.06.01.23.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 23:08:18 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v6 3/9] plugins: Add enforcement of QEMU_PLUGIN_CB flags in
 register R/W callbacks
Date: Sun,  1 Jun 2025 23:08:09 -0700
Message-ID: <20250602060815.328261-4-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602060815.328261-1-rowanbhart@gmail.com>
References: <20250602060815.328261-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x42f.google.com
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

This patch adds functionality to enforce the requested QEMU_PLUGIN_CB_
flags level passed when registering a callback function using the
plugins API. Each time a callback is about to be invoked, a thread-local
variable will be updated with the level that callback requested. Then,
called API functions (in particular, the register read and write API)
will call qemu_plugin_get_cb_flags() to check the level is at least the
level they require.

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 accel/tcg/plugin-gen.c     | 30 ++++++++++++++++++++++++++++++
 include/hw/core/cpu.h      |  1 +
 include/qemu/plugin.h      |  4 ++++
 include/qemu/qemu-plugin.h |  3 ---
 plugins/api.c              |  8 ++++++++
 plugins/core.c             | 32 ++++++++++++++++++++++++++------
 6 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index c1da753894..9920381a84 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -117,10 +117,20 @@ static TCGv_i32 gen_cpu_index(void)
 static void gen_udata_cb(struct qemu_plugin_regular_cb *cb)
 {
     TCGv_i32 cpu_index = gen_cpu_index();
+    enum qemu_plugin_cb_flags cb_flags =
+        tcg_call_to_qemu_plugin_cb_flags(cb->info->flags);
+    TCGv_i32 flags = tcg_constant_i32(cb_flags);
+    TCGv_i32 clear_flags = tcg_constant_i32(QEMU_PLUGIN_CB_NO_REGS);
+    tcg_gen_st_i32(flags, tcg_env,
+           offsetof(CPUState, neg.plugin_cb_flags) - sizeof(CPUState));
     tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
+    tcg_gen_st_i32(clear_flags, tcg_env,
+           offsetof(CPUState, neg.plugin_cb_flags) - sizeof(CPUState));
     tcg_temp_free_i32(cpu_index);
+    tcg_temp_free_i32(flags);
+    tcg_temp_free_i32(clear_flags);
 }
 
 static TCGv_ptr gen_plugin_u64_ptr(qemu_plugin_u64 entry)
@@ -173,10 +183,20 @@ static void gen_udata_cond_cb(struct qemu_plugin_conditional_cb *cb)
     tcg_gen_ld_i64(val, ptr, 0);
     tcg_gen_brcondi_i64(cond, val, cb->imm, after_cb);
     TCGv_i32 cpu_index = gen_cpu_index();
+    enum qemu_plugin_cb_flags cb_flags =
+        tcg_call_to_qemu_plugin_cb_flags(cb->info->flags);
+    TCGv_i32 flags = tcg_constant_i32(cb_flags);
+    TCGv_i32 clear_flags = tcg_constant_i32(QEMU_PLUGIN_CB_NO_REGS);
+    tcg_gen_st_i32(flags, tcg_env,
+           offsetof(CPUState, neg.plugin_cb_flags) - sizeof(CPUState));
     tcg_gen_call2(cb->f.vcpu_udata, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
+    tcg_gen_st_i32(clear_flags, tcg_env,
+           offsetof(CPUState, neg.plugin_cb_flags) - sizeof(CPUState));
     tcg_temp_free_i32(cpu_index);
+    tcg_temp_free_i32(flags);
+    tcg_temp_free_i32(clear_flags);
     gen_set_label(after_cb);
 
     tcg_temp_free_i64(val);
@@ -210,12 +230,22 @@ static void gen_mem_cb(struct qemu_plugin_regular_cb *cb,
                        qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
 {
     TCGv_i32 cpu_index = gen_cpu_index();
+    enum qemu_plugin_cb_flags cb_flags =
+        tcg_call_to_qemu_plugin_cb_flags(cb->info->flags);
+    TCGv_i32 flags = tcg_constant_i32(cb_flags);
+    TCGv_i32 clear_flags = tcg_constant_i32(QEMU_PLUGIN_CB_NO_REGS);
+    tcg_gen_st_i32(flags, tcg_env,
+           offsetof(CPUState, neg.plugin_cb_flags) - sizeof(CPUState));
     tcg_gen_call4(cb->f.vcpu_mem, cb->info, NULL,
                   tcgv_i32_temp(cpu_index),
                   tcgv_i32_temp(tcg_constant_i32(meminfo)),
                   tcgv_i64_temp(addr),
                   tcgv_ptr_temp(tcg_constant_ptr(cb->userp)));
+    tcg_gen_st_i32(clear_flags, tcg_env,
+           offsetof(CPUState, neg.plugin_cb_flags) - sizeof(CPUState));
     tcg_temp_free_i32(cpu_index);
+    tcg_temp_free_i32(flags);
+    tcg_temp_free_i32(clear_flags);
 }
 
 static void inject_cb(struct qemu_plugin_dyn_cb *cb)
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 1e87f7d393..d3cc9a5224 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -368,6 +368,7 @@ typedef struct CPUNegativeOffsetState {
     GArray *plugin_mem_cbs;
     uint64_t plugin_mem_value_low;
     uint64_t plugin_mem_value_high;
+    int32_t plugin_cb_flags;
 #endif
     IcountDecr icount_decr;
     bool can_do_io;
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 9726a9ebf3..2fef2e7d71 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -209,6 +209,10 @@ void qemu_plugin_user_prefork_lock(void);
  */
 void qemu_plugin_user_postfork(bool is_child);
 
+enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_flags(int flags);
+
+enum qemu_plugin_cb_flags qemu_plugin_get_cb_flags(void);
+
 #else /* !CONFIG_PLUGIN */
 
 static inline void qemu_plugin_add_opts(void)
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index cfe1692ecb..120fb626a6 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -254,9 +254,6 @@ typedef struct {
  * @QEMU_PLUGIN_CB_NO_REGS: callback does not access the CPU's regs
  * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
  * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
- *
- * Note: currently QEMU_PLUGIN_CB_RW_REGS is unused, plugins cannot change
- * system register state.
  */
 enum qemu_plugin_cb_flags {
     QEMU_PLUGIN_CB_NO_REGS,
diff --git a/plugins/api.c b/plugins/api.c
index 3a7add50d2..16141f5c25 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -437,6 +437,10 @@ int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
 {
     g_assert(current_cpu);
 
+    if (qemu_plugin_get_cb_flags() == QEMU_PLUGIN_CB_NO_REGS) {
+        return -1;
+    }
+
     return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
 }
 
@@ -445,6 +449,10 @@ int qemu_plugin_write_register(struct qemu_plugin_register *reg,
 {
     g_assert(current_cpu);
 
+    if (buf->len == 0 || qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS) {
+        return 0;
+    }
+
     return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
 }
 
diff --git a/plugins/core.c b/plugins/core.c
index eb9281fe54..34bddb6c1c 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -364,14 +364,15 @@ void plugin_register_dyn_cb__udata(GArray **arr,
                                    enum qemu_plugin_cb_flags flags,
                                    void *udata)
 {
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
+        [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
          */
-        [0 ... 2].typemask = (dh_typemask(void, 0) |
+        [0 ... 3].typemask = (dh_typemask(void, 0) |
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
@@ -393,14 +394,15 @@ void plugin_register_dyn_cond_cb__udata(GArray **arr,
                                         uint64_t imm,
                                         void *udata)
 {
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
+        [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
          */
-        [0 ... 2].typemask = (dh_typemask(void, 0) |
+        [0 ... 3].typemask = (dh_typemask(void, 0) |
                               dh_typemask(i32, 1) |
                               dh_typemask(ptr, 2))
     };
@@ -431,14 +433,15 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t) &&
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
 
-    static TCGHelperInfo info[3] = {
+    static TCGHelperInfo info[4] = {
         [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
         [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
+        [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
         /*
          * Match qemu_plugin_vcpu_mem_cb_t:
          *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
          */
-        [0 ... 2].typemask =
+        [0 ... 3].typemask =
             (dh_typemask(void, 0) |
              dh_typemask(i32, 1) |
              (__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t)
@@ -760,3 +763,20 @@ void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score)
     g_array_free(score->data, TRUE);
     g_free(score);
 }
+
+enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_flags(int flags)
+{
+    if (flags & TCG_CALL_NO_RWG) {
+        return QEMU_PLUGIN_CB_NO_REGS;
+    } else if (flags & TCG_CALL_NO_WG) {
+        return QEMU_PLUGIN_CB_R_REGS;
+    } else {
+        return QEMU_PLUGIN_CB_RW_REGS;
+    }
+}
+
+enum qemu_plugin_cb_flags qemu_plugin_get_cb_flags(void)
+{
+    assert(current_cpu);
+    return current_cpu->neg.plugin_cb_flags;
+}
-- 
2.49.0


