Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C753C54E51
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reX4n-0003NC-0f; Mon, 26 Feb 2024 04:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1reX4l-0003MV-F9
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:15:07 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1reX4j-00058r-Ja
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:15:07 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d24a727f78so40475351fa.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 01:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708938903; x=1709543703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8AWKRaOtLsPflMexUu/NAAwKkc6F+cV+H803nuHaV0=;
 b=mEoSVDduxsZJrg7cphVxDu3n9gZ6uIcLevJmTR2Op15uxuRPm/RBCqaBOAtdzvsejl
 woCcNvZRXs2GFjfUMETLelcpTFTs1cTjvF4eyI22R6hA82ivLWaGq5dXD1aU4DlbiTDN
 ceCzuK3agoZuYjLH4w6jft4aHM4rlYEjplT4K6iGvqRRfFVCmczccGmTKWkoqcOhrB78
 lAQHS4q7mRrfbVkA7abftHXwmNvT32sWJqtqGZEQFzQBU0/XjLOwEz9193F2tNESz9Nt
 Qq5W4Py9HHQp3PqmZxG2d928XVBV4k4KcOd9PhjyAq0chc7URNyMm9jRdhXNFKUEV8/T
 BpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708938903; x=1709543703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8AWKRaOtLsPflMexUu/NAAwKkc6F+cV+H803nuHaV0=;
 b=S2Uw+7lwpcFOYnPzEYj1dfdkQ2+ske5eTZeRTT03M3zC+21e/q6F+jCuBIkboXlzfq
 NSZ7pfYk8hOKhWMMJJn2eqllXXAGSVA+1CxKC88zht95hYCG0B3w+sey31BtxmNUtNgl
 z2lvcM9CMbUT1NWPTVY+B8yMiGJjmMpnhUCGTKupI7Xpljo6tIcIw8jJtyhNDyDjFM27
 5AUjfMIFh4uHiYkJQzQUYvFB3oSARUQCouWLmBTklEE5Bf900RwT9lit4Ea002kbufON
 J16F1c8VkL7JTuTDIpGhqXMjPBLtpqs9Vaagx3Ntstb4E/ZyV8tdXCtJbtwddZlqq4Ii
 qMYA==
X-Gm-Message-State: AOJu0YyHsemu2VqP8x4JhZD66DNnga1If7tbL9kZyRR5z1KrKVnBM43w
 kUgshsH+hV5AG2NFW5aaOo8mPmIevxn1h7Zy81CullLje17Ke9NH8XSUI63cXj/4ZLQCX++GrOU
 R634G5Q==
X-Google-Smtp-Source: AGHT+IFKOrNXMB9ppJvF1SPjl3pzZWv4mHtsJmUKtAD2Y1iGeCvf68LwXLwKRJEhh3A5xETs5gMKsA==
X-Received: by 2002:a2e:9902:0:b0:2d2:3a2b:7ad3 with SMTP id
 v2-20020a2e9902000000b002d23a2b7ad3mr3581633lji.26.1708938903522; 
 Mon, 26 Feb 2024 01:15:03 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 g7-20020adfe407000000b0033d2ae84fafsm7578814wrm.52.2024.02.26.01.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 01:15:03 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v5 02/12] plugins: define qemu_plugin_u64
Date: Mon, 26 Feb 2024 13:14:34 +0400
Message-ID: <20240226091446.479436-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lj1-x229.google.com
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
index f0c26827e04..6442ab041be 100644
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
@@ -782,4 +793,45 @@ QEMU_PLUGIN_API
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
index 2dfc3ce4eaf..579fe4a6e54 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -517,3 +517,37 @@ void *qemu_plugin_scoreboard_find(struct qemu_plugin_scoreboard *score,
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


