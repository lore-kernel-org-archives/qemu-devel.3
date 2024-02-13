Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60210C4829F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpHd-0001Du-Ii; Tue, 13 Feb 2024 04:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHY-0001DL-W1
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:40:53 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHX-0000EG-1k
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:40:52 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33cdedb40c4so115643f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707817249; x=1708422049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCBh+sFjh3zKr3oSSR0kXcIxKMfrzUcKpwKGEsMrXDk=;
 b=pGyBTzOwt1pO4wasGYZ663qBL63F5iAAzateDsIsees73x5CyuM4kdhAaGYpPbiGhv
 zso++uxasw4KtGU0qLsmaeWoLNjaHwvkgLPHhSkqrf1Z/JFx6RWR5BlbCm7e4tHs24k6
 RXrKKQez9W577AaphQEgag+ruGVTu2ZAOp3J/ZKsd8dO4PuZXJsL7XjDV1AFRvdGJMj7
 sYE5G5E9zIAGfqR3dbzK/EVdEBe0+IwrLhv6vWRCYJpRrhCezeFMPr/wvZUQz5gDmAP7
 STVVlIRtAfyXOTODQfw1eOwF3b0H4meHyQYm9gDUbsLAVDOrskcDLTMK50iLiAYp2Aar
 psfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817249; x=1708422049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCBh+sFjh3zKr3oSSR0kXcIxKMfrzUcKpwKGEsMrXDk=;
 b=IynKsScfeq9TAeN/+Ea7i3nMitawZcRnyB3P11HiN1cWUlLgRXenlzHAb4Wn8Aajyh
 7GLZRgBpRUESzc6734J6iL9jQZirJhNQt66GtvpahRM0N5tqXMuObNcOoBLFEbRWhPSh
 W0gfYDEGibCcDbd4edeVapNi6KJTP4DyfFz6Od3YV9v/cmjfJTXIFn2ELWBTrLbAuys3
 U0C3qZROq6Tfm7f7tlJJdUaj/PrX5XC8UKLEpiKOoND257Bn8deYm2wOUrtQNIe65Ab9
 qtDubVOFGye568wH8DefLagdgLHgBE3KcjAG7usAbJVs+AoSqhTAi2hJbdhRUNlSzXRD
 6JhQ==
X-Gm-Message-State: AOJu0YyMxCDE3tCGoaWkT/kqJBm2eskLvHkpkMwiUMcCBCzz5w8K3D3X
 HLuAF0njqzm9tSgjKniMk7MGDtxIBV5IcV+zaHlGPnjCjS9DdniiGruGaM5uUlShOMG+2zRHcga
 y
X-Google-Smtp-Source: AGHT+IGUc5IY6bvOK54MA5TPnJ/Eam+9+6k+7C3RSE97dklNxCpFI0w83yLrXx0LxiNwhoWnHP97QA==
X-Received: by 2002:a5d:64cd:0:b0:33b:80a7:6538 with SMTP id
 f13-20020a5d64cd000000b0033b80a76538mr5540062wri.9.1707817248913; 
 Tue, 13 Feb 2024 01:40:48 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUoNh9OoWmD91vZ6JyXJYp7SRfT+u1wr4q5CDbFVCZSB6nUlbR3XD8qg5oTEvioJJJOIOOSCUDgcBtzuXoELGka8SU9p+cmJ9A6DA3SyMDLnoSSH2EkU6Ia8TI6s8tTcxR+FC4hOdDM9DdtqemOaXhM/dSoe7GgfrUreU7EXMSMjdW0I6bGzXvCDLDuNocrDYS00xeRmSqtD2BD/clv3qmQGngjVssoizK7PAv86sfeJXrWLp2X60fNOnpK5oM4zNaKbEvwhslTpp3bH4k7oEt6iiHG87C9LdTmxAiXH4+bKBTn4oHtqhmwkD0X7S7yiM8JnfhR6oXiEms6m3rq+UidwI1HUQ==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033b728190c1sm8550261wrb.79.2024.02.13.01.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:40:48 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 05/18] plugins: scoreboard API
Date: Tue, 13 Feb 2024 13:39:55 +0400
Message-ID: <20240213094009.150349-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x436.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/plugin.h        |  6 ++++
 include/qemu/qemu-plugin.h   | 31 ++++++++++++++++++++
 plugins/plugin.h             |  6 ++++
 plugins/api.c                | 20 +++++++++++++
 plugins/core.c               | 57 ++++++++++++++++++++++++++++++++++++
 plugins/qemu-plugins.symbols |  3 ++
 6 files changed, 123 insertions(+)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index b0c5ac68293..ccf9d2ebd2d 100644
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
index e94ae4d2abb..0994935d4a2 100644
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
@@ -753,5 +755,34 @@ int qemu_plugin_read_register(unsigned int vcpu,
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
index dbfc5e83729..76fbca685f4 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -521,3 +521,23 @@ static void __attribute__((__constructor__)) qemu_api_init(void)
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
diff --git a/plugins/core.c b/plugins/core.c
index 609d9d5c184..cd0c717e291 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "qemu/lockable.h"
 #include "qemu/option.h"
+#include "qemu/queue.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/xxhash.h"
 #include "qemu/rcu.h"
@@ -209,6 +210,35 @@ plugin_register_cb_udata(qemu_plugin_id_t id, enum qemu_plugin_event ev,
     do_plugin_register_cb(id, ev, func, udata);
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
@@ -219,6 +249,7 @@ void qemu_plugin_vcpu_init_hook(CPUState *cpu)
     success = g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
                                   &cpu->cpu_index);
     g_assert(success);
+    plugin_grow_scoreboards__locked(cpu);
     qemu_rec_mutex_unlock(&plugin.lock);
 
     plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
@@ -572,6 +603,8 @@ static void __attribute__((__constructor__)) plugin_init(void)
     qemu_rec_mutex_init(&plugin.lock);
     plugin.id_ht = g_hash_table_new(g_int64_hash, g_int64_equal);
     plugin.cpu_ht = g_hash_table_new(g_int_hash, g_int_equal);
+    QLIST_INIT(&plugin.scoreboards);
+    plugin.scoreboard_alloc_size = 16; /* avoid frequent reallocation */
     QTAILQ_INIT(&plugin.ctxs);
     qht_init(&plugin.dyn_cb_arr_ht, plugin_dyn_cb_arr_cmp, 16,
              QHT_MODE_AUTO_RESIZE);
@@ -582,3 +615,27 @@ int plugin_num_vcpus(void)
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
2.43.0


