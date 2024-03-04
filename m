Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC080C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7wR-00014j-Hl; Mon, 04 Mar 2024 08:01:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rh7wF-0000oe-Ro
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:01:05 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rh7wD-0000Ws-0P
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:01:03 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56698eb5e1dso5842354a12.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 05:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709557258; x=1710162058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oYjfIB8otldj7nOTeEAU6E3VxeKPpH0lZMwsxPa1los=;
 b=e/V7+2eYT6ipYp4lPzw1lDNIXmf0Ty24PS1caX3eGoFFXDfWb+GWG9xPLzGH6CWyJ+
 zIqsO6YmSfmoDxWTzELUoDx9ibLgN4OAqpPRtFMnCyrDpPLlunwBsBRZ9252cUBHSMyO
 iInRQToKJ7KveG4kNuQgYqr9K+hNO/Rl6NZ22kTklfGVUABHWgn8IZTxiKNkUppLHN9N
 +1Grf3HdlTUudL522tvhxn88ukz+UEoUtB3Co4DmSs7pZYDDHtAPGBKasee6muzVmaUe
 CTI+2AA3LRBok1JF3ZCBj+HS2EbSbsC/EckEytKhgMSHyMpz9xaQuo01s/IgCgQzjM/M
 PtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709557258; x=1710162058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oYjfIB8otldj7nOTeEAU6E3VxeKPpH0lZMwsxPa1los=;
 b=w8GSVCHdGugR8IbiBGSteH5Wnss2SlI6Az3pR6L8WlhN9eGfe1nw544Fol3f/m/Dan
 fx4CNNxJfAF/rS9PNODr3NjcQjthvNf5ZLf7enBWxIB6hAgvmKa9HJWm1YzUNvWdv71/
 WZsLy6HYquHRIRh/kOHSgrdCdqi3ROXY1RQlDNFZWYN11cB+WQSdQl/J+FQ9vBHHy1qL
 fFHHHDuVd0U/yQRZFy9R5o9TDDyHM3PnebAbYw9kHqFu+hO3cCklw5ljmM8waiFIWRQ4
 rnCfi7Yz5w3KTyMF2RlOHv2IaEdFpNt/pKcLvQtT70h/7kO32YVkd+QVk/5wUFAOaJyr
 SZKQ==
X-Gm-Message-State: AOJu0YwnO8YcJendv5n7eV2Pb1hIMo+LDcwWZe1ORaiChP1PBEwh+A5C
 1Sip/5s9TeSOhb8MeQ1MAtc76m25rMWw+4gI1N9bx0vb9nT07NclBpAJeUufZZm4i+CSs3PuqU8
 v3uw=
X-Google-Smtp-Source: AGHT+IGp023GnxR+h9cGKZdmTb0x4+iBZ0rVH4eXbPUS8HGoy5bXOR/qCaJIQfbu8iAZa0EZZg3+Dw==
X-Received: by 2002:a17:906:d0d4:b0:a45:22e2:bd6 with SMTP id
 bq20-20020a170906d0d400b00a4522e20bd6mr2521418ejb.23.1709557258014; 
 Mon, 04 Mar 2024 05:00:58 -0800 (PST)
Received: from debian.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 tj7-20020a170907c24700b00a413d1eda4bsm4806136ejc.87.2024.03.04.05.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 05:00:57 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v7 01/12] plugins: scoreboard API
Date: Mon,  4 Mar 2024 17:00:25 +0400
Message-Id: <20240304130036.124418-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304130036.124418-1-pierrick.bouvier@linaro.org>
References: <20240304130036.124418-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ed1-x52c.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/plugin.h        |  6 ++++
 include/qemu/qemu-plugin.h   | 31 ++++++++++++++++++++
 plugins/plugin.h             |  6 ++++
 plugins/api.c                | 19 ++++++++++++
 plugins/core.c               | 57 ++++++++++++++++++++++++++++++++++++
 plugins/qemu-plugins.symbols |  3 ++
 6 files changed, 122 insertions(+)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index b3c94a34aa4..bf96d2c2aa3 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -112,6 +112,12 @@ struct qemu_plugin_insn {
     bool mem_only;
 };
 
+/* A scoreboard is an array of values, indexed by vcpu_index */
+struct qemu_plugin_scoreboard {
+    GArray *data;
+    QLIST_ENTRY(qemu_plugin_scoreboard) entry;
+};
+
 /*
  * qemu_plugin_insn allocate and cleanup functions. We don't expect to
  * cleanup many of these structures. They are reused for each fresh
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 45e2ebc8f8f..31c468ddb2c 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -222,6 +222,8 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
 struct qemu_plugin_tb;
 /** struct qemu_plugin_insn - Opaque handle for a translated instruction */
 struct qemu_plugin_insn;
+/** struct qemu_plugin_scoreboard - Opaque handle for a scoreboard */
+struct qemu_plugin_scoreboard;
 
 /**
  * enum qemu_plugin_cb_flags - type of callback
@@ -752,5 +754,34 @@ QEMU_PLUGIN_API
 int qemu_plugin_read_register(struct qemu_plugin_register *handle,
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
 
 #endif /* QEMU_QEMU_PLUGIN_H */
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 00b3509f708..043c740067d 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -31,6 +31,8 @@ struct qemu_plugin_state {
      * but with the HT we avoid adding a field to CPUState.
      */
     GHashTable *cpu_ht;
+    QLIST_HEAD(, qemu_plugin_scoreboard) scoreboards;
+    size_t scoreboard_alloc_size;
     DECLARE_BITMAP(mask, QEMU_PLUGIN_EV_MAX);
     /*
      * @lock protects the struct as well as ctx->uninstalling.
@@ -101,4 +103,8 @@ void exec_inline_op(struct qemu_plugin_dyn_cb *cb);
 
 int plugin_num_vcpus(void);
 
+struct qemu_plugin_scoreboard *plugin_scoreboard_new(size_t element_size);
+
+void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score);
+
 #endif /* PLUGIN_H */
diff --git a/plugins/api.c b/plugins/api.c
index 81f43c9ce8a..f8b15510ff7 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -465,3 +465,22 @@ int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
 
     return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg));
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
diff --git a/plugins/core.c b/plugins/core.c
index 2db4d31354b..63f4c6c6ce3 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -18,6 +18,7 @@
 #include "qemu/lockable.h"
 #include "qemu/option.h"
 #include "qemu/plugin.h"
+#include "qemu/queue.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/xxhash.h"
 #include "qemu/rcu.h"
@@ -215,6 +216,35 @@ CPUPluginState *qemu_plugin_create_vcpu_state(void)
     return g_new0(CPUPluginState, 1);
 }
 
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
+    if (!need_realloc || QLIST_EMPTY(&plugin.scoreboards)) {
+        /* nothing to do, we just updated sizes for future scoreboards */
+        return;
+    }
+
+    /* cpus must be stopped, as tb might still use an existing scoreboard. */
+    start_exclusive();
+    struct qemu_plugin_scoreboard *score;
+    QLIST_FOREACH(score, &plugin.scoreboards, entry) {
+        g_array_set_size(score->data, plugin.scoreboard_alloc_size);
+    }
+    /* force all tb to be flushed, as scoreboard pointers were changed. */
+    tb_flush(cpu);
+    end_exclusive();
+}
+
 void qemu_plugin_vcpu_init_hook(CPUState *cpu)
 {
     bool success;
@@ -225,6 +255,7 @@ void qemu_plugin_vcpu_init_hook(CPUState *cpu)
     success = g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
                                   &cpu->cpu_index);
     g_assert(success);
+    plugin_grow_scoreboards__locked(cpu);
     qemu_rec_mutex_unlock(&plugin.lock);
 
     plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
@@ -578,6 +609,8 @@ static void __attribute__((__constructor__)) plugin_init(void)
     qemu_rec_mutex_init(&plugin.lock);
     plugin.id_ht = g_hash_table_new(g_int64_hash, g_int64_equal);
     plugin.cpu_ht = g_hash_table_new(g_int_hash, g_int_equal);
+    QLIST_INIT(&plugin.scoreboards);
+    plugin.scoreboard_alloc_size = 16; /* avoid frequent reallocation */
     QTAILQ_INIT(&plugin.ctxs);
     qht_init(&plugin.dyn_cb_arr_ht, plugin_dyn_cb_arr_cmp, 16,
              QHT_MODE_AUTO_RESIZE);
@@ -588,3 +621,27 @@ int plugin_num_vcpus(void)
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
+    QLIST_INSERT_HEAD(&plugin.scoreboards, score, entry);
+    qemu_rec_mutex_unlock(&plugin.lock);
+
+    return score;
+}
+
+void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score)
+{
+    qemu_rec_mutex_lock(&plugin.lock);
+    QLIST_REMOVE(score, entry);
+    qemu_rec_mutex_unlock(&plugin.lock);
+
+    g_array_free(score->data, TRUE);
+    g_free(score);
+}
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 27fe97239be..3f93e7d6b13 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -37,6 +37,9 @@
   qemu_plugin_register_vcpu_tb_exec_inline;
   qemu_plugin_register_vcpu_tb_trans_cb;
   qemu_plugin_reset;
+  qemu_plugin_scoreboard_free;
+  qemu_plugin_scoreboard_find;
+  qemu_plugin_scoreboard_new;
   qemu_plugin_start_code;
   qemu_plugin_tb_get_insn;
   qemu_plugin_tb_n_insns;
-- 
2.39.2


