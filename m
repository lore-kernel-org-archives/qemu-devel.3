Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5B0C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpHQ-00014m-GM; Tue, 13 Feb 2024 04:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHO-00012E-V1
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:40:42 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHN-0000DO-8t
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:40:42 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d0e2adfeefso41934911fa.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707817238; x=1708422038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tr3Be+F/pb6UoTGk/xigsw32PICcW54rqyyS4zJsi9I=;
 b=kW7B4rIsdzCg86mF8yIUte+XlsF7qMMO8pte19yPK0dm/dRhqGNUU9NH/9K3e8xo1e
 1hHs2+qMxPyAgO269xnBu8VGZUAV+srggyU2TvZZF3bhRsNj034bWkMFuX9n5GFjM8YY
 P+/eExWYaVnsHKOiR8G8sldXldCbi4iYMPrDhE+tmDb6VyjGVo5svhUzZ0Y0+bK4/0d4
 MdwfaT9wRZ/RRpsZMG05db9WRkYrsbAX9h/2AS9zoCXGOJAfhCBDdUUiM12nVLPj8CXw
 7kNAxC4k0sLhYRlzboBzxp1QTPvxfyNF2WvvqdAdDiglp0rbkAZ3JgVb8klMWkBc2N89
 cwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817238; x=1708422038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tr3Be+F/pb6UoTGk/xigsw32PICcW54rqyyS4zJsi9I=;
 b=AsTH0yJdn0JgyhNO1TM8FGS5PqDG5ecVZrLBsKmamvQRW0r8gGKKz2BpFwYdfodOA1
 hdRBxRFt6NX3IINXpofSS12YVBEfRJtoZuzTlvH1izrzRnMCuhBleyenqb0V4TKwmSaB
 IupZuVYOe3Ws78p82f2GBHNaduYu1npsV01XiZUvi6NFBb8mQJX6PLVnK0wzun1cZdx8
 o3m0UQir6u9AGGeHsPl9T/FteCwhArr1vBLkROWlnqkKKvmtCofP4Murgho8nCuWhN6J
 YvHoMFa9QQWmaoGZOCHWZB8ur6lhOBlQlkiX02qe7zkFM87mwnBCGwwsFcwH6b2iUmKz
 5r7w==
X-Gm-Message-State: AOJu0YzcS9SZfLgnXq1nNd83fjJJf5BxE+0QrJTU62VD95lFWPy2PtGY
 oXXoUOzjLTV/K8oKe6sC87T2NNvn9Kuehb9+96oEDuy74A4YdzyfwRdu6/JchrnBs4zJ7s7mkdg
 l
X-Google-Smtp-Source: AGHT+IHr7DhJaXcnqT88/IhKgqB6pNUDAWyOGiTzYJfuP74AoCb0MjzNw1tBQs0T61tGGFC//VegsA==
X-Received: by 2002:a2e:b5a7:0:b0:2d0:d40c:e83b with SMTP id
 f7-20020a2eb5a7000000b002d0d40ce83bmr5510414ljn.30.1707817238531; 
 Tue, 13 Feb 2024 01:40:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVhsbef9t/X5AxL6Tl6B24s9WHqvyksnAG0y0rfdBUUcKOZWPNzPKl9176x5IwDlZJeI/RoRBPgGJI3pwfwF7UxcmuPKtd1ZTfWF2cUFVFRj6uuYJE5gDVAAqbsWW1erjwsa7Tt5pO56JTRHdRInnW/mSAw/OvxkNztNY7X9C8ewwFy68JrVs5iUOsTs90MoqKS1+fUMXw7j9qG0IipPns3ZzcrDd7DxzXDTqKq6nVqXLBTYgRZQ73g9anvmfFrEqXdrsggyRCjJOGx5c4E3aNqMC4GVwC+NKjOPflGPB7yxUJVYCp2J5U07urSLL3k+jQZQq+VXkEaE7O+wGMyE8Dju5DiFA==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033b728190c1sm8550261wrb.79.2024.02.13.01.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:40:38 -0800 (PST)
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
Subject: [PATCH v4 02/18] plugins: add qemu_plugin_num_vcpus function
Date: Tue, 13 Feb 2024 13:39:52 +0400
Message-ID: <20240213094009.150349-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lj1-x235.google.com
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

We now keep track of how many vcpus were started. This way, a plugin can
easily query number of any vcpus at any point of execution, which
unifies user and system mode workflows.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h   | 3 +++
 plugins/plugin.h             | 4 ++++
 plugins/api.c                | 5 +++++
 plugins/core.c               | 6 ++++++
 plugins/qemu-plugins.symbols | 1 +
 5 files changed, 19 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 0e506ee644d..e94ae4d2abb 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -646,6 +646,9 @@ QEMU_PLUGIN_API
 void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
                                     qemu_plugin_udata_cb_t cb, void *userdata);
 
+/* returns how many vcpus were started at this point */
+int qemu_plugin_num_vcpus(void);
+
 /**
  * qemu_plugin_outs() - output string via QEMU's logging system
  * @string: a string
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 90f3f324ab6..00b3509f708 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -44,6 +44,8 @@ struct qemu_plugin_state {
      * the code cache is flushed.
      */
     struct qht dyn_cb_arr_ht;
+    /* How many vcpus were started */
+    int num_vcpus;
 };
 
 
@@ -97,4 +99,6 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
 
 void exec_inline_op(struct qemu_plugin_dyn_cb *cb);
 
+int plugin_num_vcpus(void);
+
 #endif /* PLUGIN_H */
diff --git a/plugins/api.c b/plugins/api.c
index 2aaae4e47f3..dbfc5e83729 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -353,6 +353,11 @@ const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h)
 #endif
 }
 
+int qemu_plugin_num_vcpus(void)
+{
+    return plugin_num_vcpus();
+}
+
 /*
  * Plugin output
  */
diff --git a/plugins/core.c b/plugins/core.c
index 49588285dd0..9e64820ad02 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -214,6 +214,7 @@ void qemu_plugin_vcpu_init_hook(CPUState *cpu)
     bool success;
 
     qemu_rec_mutex_lock(&plugin.lock);
+    plugin.num_vcpus = MAX(plugin.num_vcpus, cpu->cpu_index + 1);
     plugin_cpu_update__locked(&cpu->cpu_index, NULL, NULL);
     success = g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
                                   &cpu->cpu_index);
@@ -571,3 +572,8 @@ static void __attribute__((__constructor__)) plugin_init(void)
              QHT_MODE_AUTO_RESIZE);
     atexit(qemu_plugin_atexit_cb);
 }
+
+int plugin_num_vcpus(void)
+{
+    return plugin.num_vcpus;
+}
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 6088dd3714a..27fe97239be 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -17,6 +17,7 @@
   qemu_plugin_mem_is_sign_extended;
   qemu_plugin_mem_is_store;
   qemu_plugin_mem_size_shift;
+  qemu_plugin_num_vcpus;
   qemu_plugin_outs;
   qemu_plugin_path_to_binary;
   qemu_plugin_read_register;
-- 
2.43.0


