Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AE5C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 05:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfYvB-0002g0-Gp; Thu, 29 Feb 2024 00:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfYv9-0002fD-RG
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:25:27 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfYv7-0005vH-U4
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:25:27 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-412bf8262caso145325e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 21:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709184324; x=1709789124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lsTM3pV8KdzbVuK5oQ1BIScgwFBKY5WsDX0K1DDX2g4=;
 b=ZfelCL3yv+SSTTSccXNPFmCXWDfyVOHsZd592gx8pVjvwmsWYEv5vqpknrOYQtdWiO
 JVvB7rdhNrmyFWFOSiNYXUoCOJnAk/CWeTYAUM5Ti3latnPu2ub4hFEAYTel6qVERo5f
 F7WPBlfyT0uUfhhtiyAaaeHTdF536B/shyY3r5vev2WOLpZZ5FfNsA6Slwu2tCwlWNJG
 yVa/bNyKexX+G5HPN1D3JS3/R10VuXVn0dA927T0VIRUkyVyIpUCEwxEydOdNBzJSCQS
 XYoEvnN5bT+diSCiKT4ufz8yvd8Stq16bY7/l0lMKj8z+9fWJldjbmXM8vzBadF0wZ5f
 xqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709184324; x=1709789124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lsTM3pV8KdzbVuK5oQ1BIScgwFBKY5WsDX0K1DDX2g4=;
 b=CfgXZVUJItRMl2qqN1M2Zm7rZ3xoZ8v6jD2sXn7hlCy9bop9R8yKjpcejCuurpeMy8
 7cVx52qY3nUa9Bi3etqOS3Mlk1+EyFWVVz/4ELKfjUH9k7uR57L+9k3ccwBuoItR7XqA
 U6KtzWdHs5u970qKtDvR0abPkKsRYxUiZ3pjSq8ANmYSUFNPdd7QDL7fU4qi+hR3Xqkw
 5CnF5E5XSJI/gqAkv4ik62XO5tro/J3tmT55zo59rwY73CweCPurYYb9bzikYm3yPbiQ
 u8eI1utoyXV8NzYZLOdXXrB+uy2b5NaO6XbjJrWg3NbvfQN5NPln+pM+z8uanjYxCWXu
 /hww==
X-Gm-Message-State: AOJu0YwNwaWE0KeoxHd4NkhrlhUnUW0FdqmrGKodLqGtyHSgWUibUMmW
 kr8nxWsPIFSIsu2yr1cQKcDf11Lajfx8GOsOEliXtiPBA4GsW7gZyN305q9KHkrktWRw+p54yQC
 zmbI=
X-Google-Smtp-Source: AGHT+IEey+M+9XtaLT/n1eznCiBUc59+gTypwWZ2pGgz80fgtReQuVdsyDppgoJrynVqL/LbQTSifA==
X-Received: by 2002:a5d:54cd:0:b0:33d:3ee3:cc11 with SMTP id
 x13-20020a5d54cd000000b0033d3ee3cc11mr505384wrv.47.1709184324337; 
 Wed, 28 Feb 2024 21:25:24 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 e14-20020adffc4e000000b0033dfa7ecd33sm660241wrs.61.2024.02.28.21.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 21:25:24 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v6 02/12] plugins: define qemu_plugin_u64
Date: Thu, 29 Feb 2024 09:24:56 +0400
Message-ID: <20240229052506.933222-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229052506.933222-1-pierrick.bouvier@linaro.org>
References: <20240229052506.933222-1-pierrick.bouvier@linaro.org>
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

Additionally to the scoreboard, we define a qemu_plugin_u64, which is a
simple struct holding a pointer to a scoreboard, and a given offset.
This allows to have a scoreboard containing structs, without having to
bring offset to operate on a specific field.

Since most of the plugins are simply collecting a sum of per-cpu values,
qemu_plugin_u64 directly support this operation as well.

All inline operations defined later will use a qemu_plugin_u64 as input.

New functions:
- qemu_plugin_u64_add
- qemu_plugin_u64_get
- qemu_plugin_u64_set
- qemu_plugin_u64_sum
New macros:
- qemu_plugin_scoreboard_u64
- qemu_plugin_scoreboard_u64_in_struct

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h   | 52 ++++++++++++++++++++++++++++++++++++
 plugins/api.c                | 34 +++++++++++++++++++++++
 plugins/qemu-plugins.symbols |  4 +++
 3 files changed, 90 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 31c468ddb2c..ebf9a645e15 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -225,6 +225,17 @@ struct qemu_plugin_insn;
 /** struct qemu_plugin_scoreboard - Opaque handle for a scoreboard */
 struct qemu_plugin_scoreboard;
 
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
+
 /**
  * enum qemu_plugin_cb_flags - type of callback
  *
@@ -784,4 +795,45 @@ QEMU_PLUGIN_API
 void *qemu_plugin_scoreboard_find(struct qemu_plugin_scoreboard *score,
                                   unsigned int vcpu_index);
 
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
+
 #endif /* QEMU_QEMU_PLUGIN_H */
diff --git a/plugins/api.c b/plugins/api.c
index f8b15510ff7..f4518a68afe 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -484,3 +484,37 @@ void *qemu_plugin_scoreboard_find(struct qemu_plugin_scoreboard *score,
     char *base_ptr = score->data->data;
     return base_ptr + vcpu_index * g_array_get_element_size(score->data);
 }
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
+    for (int i = 0, n = qemu_plugin_num_vcpus(); i < n; ++i) {
+        total += qemu_plugin_u64_get(entry, i);
+    }
+    return total;
+}
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 3f93e7d6b13..6204453d0fd 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -44,6 +44,10 @@
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


