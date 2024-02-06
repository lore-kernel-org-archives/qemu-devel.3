Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8B2C48286
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 09:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHhJ-0004fz-TL; Tue, 06 Feb 2024 04:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHhI-0004fn-1i
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:24:56 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHhF-0004mA-So
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:24:55 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40fdd65a9bdso12809285e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 01:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707211491; x=1707816291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqcOdG+TO25rW2RA/w0FgjbgxpUpC13Aauz7MMRyDks=;
 b=tnqsRDBOErl9j4NhdnKbDMQmZVf4M+scgI3qYxbd6kiZL5GvOrnWv05FCzKFF4ZF31
 acEWj4h6mmaF13xR9MZVVu5LSdrAJ40tcKpH+peAqWJKZiBi696vG1AkI8GBy/UHBBRn
 GiqE/HpSZAugg/pEAtOWO2glvpat6LC9IAbbxnRdLzc8uZO+VETONdBF+xNhE98zzEPT
 YP41QTn8XRXQnar/b4UXr6WxI8h9s0Aj2MApL7MAi4dfGlFmTgGeIAslyoSwzuckkOjJ
 8Z/bCtH1lSY00b8r8ggpiBoNMizWvw2QdsTAwvhgXGTHTtzFn2N42ghWrRXN9slUjPLN
 EY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707211491; x=1707816291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RqcOdG+TO25rW2RA/w0FgjbgxpUpC13Aauz7MMRyDks=;
 b=cIuqdKwR3trOQPLzwCnYxJuG+xPwYKAFNBn1gPL+eEqQSkcuiYYusipyLAN4Xms4A5
 e8Yyl77kS7XZ9auOJ7+FHuBVkGicvxV+Nlbu81UIFeOqqRIGLn5a1sY9SeEVTvCKBw7A
 znxh7kWgA23T9SdZE5IqzBxqALUCYYpZdTy9tPVhv+HpGBy255PKU7BYjg+B6GBqcqla
 azmyc7aZXuNmevmyuMKNBzbtnYAfNdxxsckTAiASu9dXcLc31RkxDf0ZdrFebuRYOxA1
 J1wJOOYXuXV15MuU4HuuV20iRMgxeCTE56hynQ9MpaoHdcr6444DrGYUY5gi69MVzQHn
 w4Ug==
X-Gm-Message-State: AOJu0Yxuc6b5oIR8dIReQTntdH3u98BZ5LwixR3urtp6GdX0u2+3ENIb
 2duBHNWI98gMMwYusVPXOzpC9fozkiDg3+SN/zFq+P3JS0t/zpMNukh+k1+yhETp6d5OocDs2Ke
 t5Vo=
X-Google-Smtp-Source: AGHT+IEpfg6UGMrEpAVi3iALrURHodRnSPL89mTtgahZPSDFZ5mGdT985Ml9AeFAkAL1T6u1/8KlRA==
X-Received: by 2002:a05:600c:4691:b0:40f:d84c:ac68 with SMTP id
 p17-20020a05600c469100b0040fd84cac68mr1619120wmo.11.1707211491624; 
 Tue, 06 Feb 2024 01:24:51 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV/H74HIjJSo4WTZq6L0iCE1vPRUOeJQ1J/eEBVP2871sIhpnuDTp5j2MLRQmSA9+dzYvtc+PBD9WqsO6psDKkWaG0di6iRMbHp1/RfAdRFKOy9oBfh00XatSclZC0PyD1Plvrf88tiqTT+XelBD7qaTGR6yDt3ahdlVu5yJoe0MNM7wcnvL9L2Xp2hWkK1/E1cNoXW0Zdwvc4ro3lypHsSWZwoLsu9UoXe0eI4D23lGACxu/WxM50Bhf1tVg9IeMd68yOGn2Os+9VUOft96U+cTt7E2oojUdGbMx3hOJTHziDA4FQR9NpsRaPdZWCs313UPAGrUYLz0zijpVlwzmz7rPkdI13K2Q==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c211100b0040fc5460109sm1312756wml.35.2024.02.06.01.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 01:24:51 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 05/17] plugins: scoreboard API
Date: Tue,  6 Feb 2024 13:24:10 +0400
Message-ID: <20240206092423.3005995-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We introduce a cpu local storage, automatically managed (and extended)
by QEMU itself. Plugin allocate a scoreboard, and don't have to deal
with how many cpus are launched.

This API will be used by new inline functions but callbacks can benefit
from this as well. This way, they can operate without a global lock for
simple operations.

At any point during execution, any scoreboard will be dimensioned with
at least qemu_plugin_num_vcpus entries.

New functions:
- qemu_plugin_scoreboard_find
- qemu_plugin_scoreboard_free
- qemu_plugin_scoreboard_new

In more, we define a qemu_plugin_u64, which is a simple struct holding
a pointer to a scoreboard, and a given offset.
This allows to have a scoreboard containing structs, without having to
bring offset for all operations on a specific field.

Since most of the plugins are simply collecting a sum of per-cpu values,
qemu_plugin_u64 directly support this operation as well.

New functions:
- qemu_plugin_u64_add
- qemu_plugin_u64_get
- qemu_plugin_u64_set
- qemu_plugin_u64_sum
New macros:
- qemu_plugin_scoreboard_u64
- qemu_plugin_scoreboard_u64_in_struct

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/plugin.h        |  5 +++
 include/qemu/qemu-plugin.h   | 83 ++++++++++++++++++++++++++++++++++++
 plugins/plugin.h             |  7 +++
 plugins/api.c                | 53 +++++++++++++++++++++++
 plugins/core.c               | 67 +++++++++++++++++++++++++++++
 plugins/qemu-plugins.symbols |  7 +++
 6 files changed, 222 insertions(+)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index b0c5ac68293..af4aeef4d78 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -112,6 +112,11 @@ struct qemu_plugin_insn {
     bool mem_only;
 };
 
+/* A scoreboard is an array of values, indexed by vcpu_index */
+struct qemu_plugin_scoreboard {
+    GArray *data;
+};
+
 /*
  * qemu_plugin_insn allocate and cleanup functions. We don't expect to
  * cleanup many of these structures. They are reused for each fresh
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index e94ae4d2abb..a48586ef0c1 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -222,6 +222,19 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
 struct qemu_plugin_tb;
 /** struct qemu_plugin_insn - Opaque handle for a translated instruction */
 struct qemu_plugin_insn;
+/** struct qemu_plugin_scoreboard - Opaque handle for a scoreboard */
+struct qemu_plugin_scoreboard;
+
+/**
+ * typedef qemu_plugin_u64 - uint64_t member of an entry in a scoreboard
+ *
+ * This field allows to access a specific uint64_t member in one given entry,
+ * located at a specified offset. Inline operations expect this as entry.
+ */
+typedef struct {
+    struct qemu_plugin_scoreboard *score;
+    size_t offset;
+} qemu_plugin_u64;
 
 /**
  * enum qemu_plugin_cb_flags - type of callback
@@ -753,5 +766,75 @@ int qemu_plugin_read_register(unsigned int vcpu,
                               struct qemu_plugin_register *handle,
                               GByteArray *buf);
 
+/**
+ * qemu_plugin_scoreboard_new() - alloc a new scoreboard
+ *
+ * @element_size: size (in bytes) for one entry
+ *
+ * Returns a pointer to a new scoreboard. It must be freed using
+ * qemu_plugin_scoreboard_free.
+ */
+QEMU_PLUGIN_API
+struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size);
+
+/**
+ * qemu_plugin_scoreboard_free() - free a scoreboard
+ * @score: scoreboard to free
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_scoreboard_free(struct qemu_plugin_scoreboard *score);
+
+/**
+ * qemu_plugin_scoreboard_find() - get pointer to an entry of a scoreboard
+ * @score: scoreboard to query
+ * @vcpu_index: entry index
+ *
+ * Returns address of entry of a scoreboard matching a given vcpu_index. This
+ * address can be modified later if scoreboard is resized.
+ */
+QEMU_PLUGIN_API
+void *qemu_plugin_scoreboard_find(struct qemu_plugin_scoreboard *score,
+                                  unsigned int vcpu_index);
+
+/* Macros to define a qemu_plugin_u64 */
+#define qemu_plugin_scoreboard_u64(score) \
+    (qemu_plugin_u64) {score, 0}
+#define qemu_plugin_scoreboard_u64_in_struct(score, type, member) \
+    (qemu_plugin_u64) {score, offsetof(type, member)}
+
+/**
+ * qemu_plugin_u64_add() - add a value to a qemu_plugin_u64 for a given vcpu
+ * @entry: entry to query
+ * @vcpu_index: entry index
+ * @added: value to add
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_u64_add(qemu_plugin_u64 entry, unsigned int vcpu_index,
+                         uint64_t added);
+
+/**
+ * qemu_plugin_u64_get() - get value of a qemu_plugin_u64 for a given vcpu
+ * @entry: entry to query
+ * @vcpu_index: entry index
+ */
+QEMU_PLUGIN_API
+uint64_t qemu_plugin_u64_get(qemu_plugin_u64 entry, unsigned int vcpu_index);
+
+/**
+ * qemu_plugin_u64_set() - set value of a qemu_plugin_u64 for a given vcpu
+ * @entry: entry to query
+ * @vcpu_index: entry index
+ * @val: new value
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_u64_set(qemu_plugin_u64 entry, unsigned int vcpu_index,
+                         uint64_t val);
+
+/**
+ * qemu_plugin_u64_sum() - return sum of all vcpu entries in a scoreboard
+ * @entry: entry to sum
+ */
+QEMU_PLUGIN_API
+uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry);
 
 #endif /* QEMU_QEMU_PLUGIN_H */
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 00b3509f708..fd93a372803 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -31,6 +31,9 @@ struct qemu_plugin_state {
      * but with the HT we avoid adding a field to CPUState.
      */
     GHashTable *cpu_ht;
+    /* Scoreboards, indexed by their addresses. */
+    GHashTable *scoreboards;
+    size_t scoreboard_alloc_size;
     DECLARE_BITMAP(mask, QEMU_PLUGIN_EV_MAX);
     /*
      * @lock protects the struct as well as ctx->uninstalling.
@@ -101,4 +104,8 @@ void exec_inline_op(struct qemu_plugin_dyn_cb *cb);
 
 int plugin_num_vcpus(void);
 
+struct qemu_plugin_scoreboard *plugin_scoreboard_new(size_t element_size);
+
+void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score);
+
 #endif /* PLUGIN_H */
diff --git a/plugins/api.c b/plugins/api.c
index dbfc5e83729..15edad6769b 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -521,3 +521,56 @@ static void __attribute__((__constructor__)) qemu_api_init(void)
     qemu_mutex_init(&reg_handle_lock);
 
 }
+
+struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
+{
+    return plugin_scoreboard_new(element_size);
+}
+
+void qemu_plugin_scoreboard_free(struct qemu_plugin_scoreboard *score)
+{
+    plugin_scoreboard_free(score);
+}
+
+void *qemu_plugin_scoreboard_find(struct qemu_plugin_scoreboard *score,
+                                  unsigned int vcpu_index)
+{
+    g_assert(vcpu_index < qemu_plugin_num_vcpus());
+    /* we can't use g_array_index since entry size is not statically known */
+    char *base_ptr = score->data->data;
+    return base_ptr + vcpu_index * g_array_get_element_size(score->data);
+}
+
+static uint64_t *plugin_u64_address(qemu_plugin_u64 entry,
+                                    unsigned int vcpu_index)
+{
+    char *ptr = qemu_plugin_scoreboard_find(entry.score, vcpu_index);
+    return (uint64_t *)(ptr + entry.offset);
+}
+
+void qemu_plugin_u64_add(qemu_plugin_u64 entry, unsigned int vcpu_index,
+                         uint64_t added)
+{
+    *plugin_u64_address(entry, vcpu_index) += added;
+}
+
+uint64_t qemu_plugin_u64_get(qemu_plugin_u64 entry,
+                             unsigned int vcpu_index)
+{
+    return *plugin_u64_address(entry, vcpu_index);
+}
+
+void qemu_plugin_u64_set(qemu_plugin_u64 entry, unsigned int vcpu_index,
+                         uint64_t val)
+{
+    *plugin_u64_address(entry, vcpu_index) = val;
+}
+
+uint64_t qemu_plugin_u64_sum(qemu_plugin_u64 entry)
+{
+    uint64_t total = 0;
+    for (int i = 0; i < qemu_plugin_num_vcpus(); ++i) {
+        total += qemu_plugin_u64_get(entry, i);
+    }
+    return total;
+}
diff --git a/plugins/core.c b/plugins/core.c
index 609d9d5c184..fd8604bcb79 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -209,6 +209,44 @@ plugin_register_cb_udata(qemu_plugin_id_t id, enum qemu_plugin_event ev,
     do_plugin_register_cb(id, ev, func, udata);
 }
 
+static void plugin_resize_one_scoreboard(gpointer key,
+                                         gpointer value,
+                                         gpointer user_data)
+{
+    struct qemu_plugin_scoreboard *score =
+        (struct qemu_plugin_scoreboard *) value;
+    size_t new_alloc_size = (size_t) user_data;
+    g_array_set_size(score->data, new_alloc_size);
+}
+
+static void plugin_grow_scoreboards__locked(CPUState *cpu)
+{
+    if (cpu->cpu_index < plugin.scoreboard_alloc_size) {
+        return;
+    }
+
+    bool need_realloc = FALSE;
+    while (cpu->cpu_index >= plugin.scoreboard_alloc_size) {
+        plugin.scoreboard_alloc_size *= 2;
+        need_realloc = TRUE;
+    }
+
+
+    if (!need_realloc || g_hash_table_size(plugin.scoreboards) == 0) {
+        /* nothing to do, we just updated sizes for future scoreboards */
+        return;
+    }
+
+    /* cpus must be stopped, as tb might still use an existing scoreboard. */
+    start_exclusive();
+    g_hash_table_foreach(plugin.scoreboards,
+                         &plugin_resize_one_scoreboard,
+                         GSIZE_TO_POINTER(plugin.scoreboard_alloc_size));
+    /* force all tb to be flushed, as scoreboard pointers were changed. */
+    tb_flush(cpu);
+    end_exclusive();
+}
+
 void qemu_plugin_vcpu_init_hook(CPUState *cpu)
 {
     bool success;
@@ -219,6 +257,7 @@ void qemu_plugin_vcpu_init_hook(CPUState *cpu)
     success = g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
                                   &cpu->cpu_index);
     g_assert(success);
+    plugin_grow_scoreboards__locked(cpu);
     qemu_rec_mutex_unlock(&plugin.lock);
 
     plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
@@ -572,6 +611,8 @@ static void __attribute__((__constructor__)) plugin_init(void)
     qemu_rec_mutex_init(&plugin.lock);
     plugin.id_ht = g_hash_table_new(g_int64_hash, g_int64_equal);
     plugin.cpu_ht = g_hash_table_new(g_int_hash, g_int_equal);
+    plugin.scoreboards = g_hash_table_new(g_int64_hash, g_int64_equal);
+    plugin.scoreboard_alloc_size = 16; /* avoid frequent reallocation */
     QTAILQ_INIT(&plugin.ctxs);
     qht_init(&plugin.dyn_cb_arr_ht, plugin_dyn_cb_arr_cmp, 16,
              QHT_MODE_AUTO_RESIZE);
@@ -582,3 +623,29 @@ int plugin_num_vcpus(void)
 {
     return plugin.num_vcpus;
 }
+
+struct qemu_plugin_scoreboard *plugin_scoreboard_new(size_t element_size)
+{
+    struct qemu_plugin_scoreboard *score =
+        g_malloc0(sizeof(struct qemu_plugin_scoreboard));
+    score->data = g_array_new(FALSE, TRUE, element_size);
+    g_array_set_size(score->data, plugin.scoreboard_alloc_size);
+
+    qemu_rec_mutex_lock(&plugin.lock);
+    bool inserted = g_hash_table_insert(plugin.scoreboards, score, score);
+    g_assert(inserted);
+    qemu_rec_mutex_unlock(&plugin.lock);
+
+    return score;
+}
+
+void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score)
+{
+    qemu_rec_mutex_lock(&plugin.lock);
+    bool removed = g_hash_table_remove(plugin.scoreboards, score);
+    g_assert(removed);
+    qemu_rec_mutex_unlock(&plugin.lock);
+
+    g_array_free(score->data, TRUE);
+    g_free(score);
+}
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 27fe97239be..6204453d0fd 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -37,10 +37,17 @@
   qemu_plugin_register_vcpu_tb_exec_inline;
   qemu_plugin_register_vcpu_tb_trans_cb;
   qemu_plugin_reset;
+  qemu_plugin_scoreboard_free;
+  qemu_plugin_scoreboard_find;
+  qemu_plugin_scoreboard_new;
   qemu_plugin_start_code;
   qemu_plugin_tb_get_insn;
   qemu_plugin_tb_n_insns;
   qemu_plugin_tb_vaddr;
+  qemu_plugin_u64_add;
+  qemu_plugin_u64_get;
+  qemu_plugin_u64_set;
+  qemu_plugin_u64_sum;
   qemu_plugin_uninstall;
   qemu_plugin_vcpu_for_each;
 };
-- 
2.43.0


