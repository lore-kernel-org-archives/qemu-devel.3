Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBCAC48286
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 09:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHh8-0004ds-67; Tue, 06 Feb 2024 04:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHh7-0004dE-4r
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:24:45 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHh5-0004kw-En
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:24:44 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40fe282b8e2so3433825e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 01:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707211481; x=1707816281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tr3Be+F/pb6UoTGk/xigsw32PICcW54rqyyS4zJsi9I=;
 b=Tg3htUDo9r92+5gZeugfoI+R2AauBsIDVelezMWLoZSPQZ0ubQ5vTVikE8fWadclLf
 lPlYFNtlxfbwTAsCfT6LEetsPzkfqa3BN3qwfRejqLB4HTa+BKzbJwPbkmgPExk2sfWk
 DJYGYWKNmZM6uflP7HKwq/f6mhc4hDZIQsfjAuRWmFE0kygQkQS8gOfvXO4/b5fWFVbH
 0PBXU7bVOCXsekqUxgt/mh/gQTfRvRzHs97Zp2Ue+YJ8JhyPPjg1cnPwW2eCkPgBDzEv
 +BSXsGp24w02LS83B2o9+88Bm9cpze1dP7Xwq9L/s8n1K7GEbyINNH1ssU957cG/oTGS
 CGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707211481; x=1707816281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tr3Be+F/pb6UoTGk/xigsw32PICcW54rqyyS4zJsi9I=;
 b=Comb/bjAOrx1OWzwZwXqzsXV24XmnE2Q0AdK5IdWiJ7Kgaq0lXFPwNyx17m1oVpoaO
 1xPpLjQATLfl/044Yqwr8DJkto2dCW85/bL1UGiaBEz346P4hanAfFFQ9r+3mJfdUUyR
 lHhIxyVuiooHJoib4IDrdRRbzDAGhlZfvlBSGOXx5Xity0gcHa7OHPIS7O8u78QiCvxd
 fj4PK5sfp9kvew3joNfB+SAhS7ACGyWFZpciWQKkxHpbPVSGQozm6PtsOLpx2NS1XETq
 XYsN/2abaQIHEJgDcsmjNtFazBAoWLcfSb46v4bCg0DZE+v8yRaNzFk8yH6Ru6IvmItH
 DyAQ==
X-Gm-Message-State: AOJu0YzQ3J+zxb4UDgav12M820ZZrNvHgUs1zLDe9r4XeCf6QWMG/WfY
 Tz7JlAb5heeUJd1/oDB2kx65WP0pVzAr9tDPY0x8AnWv5FtnuUo4j6iM/XWrKQnFiBn7JVDMz5S
 R4lg=
X-Google-Smtp-Source: AGHT+IEvFY2zRx+smBpQ/P27gN4KA+fQ1gR/ptPtwnOAeaAssLvOqwLUWnppgqKs8nVLuK7OGyCWFQ==
X-Received: by 2002:a05:600c:3b11:b0:40e:fb8f:76b2 with SMTP id
 m17-20020a05600c3b1100b0040efb8f76b2mr1227643wms.12.1707211481006; 
 Tue, 06 Feb 2024 01:24:41 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWAdSywLF8zYD6TJZg28zqfmrAJ/ySRwUTjBTDZTJtNtCSoKxH2rEmjDqha6JfHGZ2evLeoPZxSjnd4dMnOTLQgu0czccd2qTX6nluMML0q/PBvZEAnQSBEgUKFuqnQ5rz8LDik4gLkw0ErFL9VkNWUzq6ZK455w3ueRZ1zOQZYGJUEvGdWPaCbqS0LNxGuhxauYhaSYkRVDdvCJ2w5gUv/FErVeWgrtoS0afbfsBASdfl3A9rzICOowTjd6BtOKbzpTMwOhRzNpidG34KP4k2aTShyBETcpafBA4lRnSsJFrEuYPAMrwB8D76wkCldqxkQFTS4oyp+IBaxp761ysMs9WIg/lcXcw==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c211100b0040fc5460109sm1312756wml.35.2024.02.06.01.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 01:24:40 -0800 (PST)
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
Subject: [PATCH v3 02/17] plugins: add qemu_plugin_num_vcpus function
Date: Tue,  6 Feb 2024 13:24:07 +0400
Message-ID: <20240206092423.3005995-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32a.google.com
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


