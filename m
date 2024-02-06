Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4244C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 09:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXHh5-0004cx-AM; Tue, 06 Feb 2024 04:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHh3-0004bb-02
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:24:41 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rXHh1-0004kX-6s
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 04:24:40 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40fe2d3d5cbso3069555e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 01:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707211477; x=1707816277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HXH7ocyncB0lY9SgnkHxBEuiEnRgV5eLtUY0jbLrGRM=;
 b=slicdj46WLpzASEsqejrWUXQEBz7dohFkXSJw8KsUdc5EGVRXARLBs9Sls/IoKlFLe
 2EwvPi3xCay63wK5ZCw7jHXulMyiUkgsS6AHjKskSF6wiS0O/Xicrd5t9pxKYn+BBc0H
 KqjIdMfxXMjFBTd7dwPyOmhbMU+m/WFt1y8LD6XvFn8i455OqMoDw0VRd04nODUVzk+l
 M+6cWsXVO9X5eXM2N6cVd4gPTGM8k1tVxkCe2ux2WVybKX7e8owep+IctpahewIPCXrB
 VMtvAUvz6QbVaCwbKZ2oIYVOi8DEDDbnYZ2xO5dQXo+X3A4+VJ18/vwhCd1Rd0O0qSvP
 zHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707211477; x=1707816277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HXH7ocyncB0lY9SgnkHxBEuiEnRgV5eLtUY0jbLrGRM=;
 b=I9QcKV2koWvA+YFLoSmxEWjgRaAriOyMJ1j7+5KbNcpLIBCAhpRCRkK7DKiIx2J6WA
 Or8JWfhsvC4fe9Bg50QFiONjptyZw4jTCf+hWPGYJSDTt7SmoCYCpfDSKlRQEmuUPd9R
 fIxsZ7f8022elq//SU3VtoPT24QJRVHh3KzkVjvoqbQ7SVTBIsvfhh6jtYicu7BsZTnK
 5Pkzc83fgWt8/AUQiF2XJXpE3YbS/GP5c1GQi+L+Xp3fvivQ4gOnrcNSOXfGi16QGcly
 MsR2CWAlzGbBLW+snpnAZfAnIpr4GCt2q9Lp+GaACP/aCCLJlvF/jkRISFqQapXltkyL
 424A==
X-Gm-Message-State: AOJu0YyZ5kURfa48DlR5mu0AYIYJfIDd9pqqx6ok1vVO/D2GAvztXeKs
 gSX/Kb8TEIlgb95CoQG+ZB7QsXKrFzl7gjjws/h7gzsP2TSi1+WuOZiCw6fo+PLArOh5Otx9Hsp
 s5as=
X-Google-Smtp-Source: AGHT+IF0GQ7WicCNpQtI0lDnNMO3dkTibxN9ma/0Vs3RzRG0cUiK6Kw2I6ViIjq5iRB1KX/A5rE9eg==
X-Received: by 2002:a05:600c:4fcd:b0:40e:d2da:fc6b with SMTP id
 o13-20020a05600c4fcd00b0040ed2dafc6bmr1719988wmq.38.1707211477459; 
 Tue, 06 Feb 2024 01:24:37 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXBnk1SOLUSowyBb+G/8ptWtFV0dXinU/A9ascoqNxK09UtRIN6La8DR57nYr6numsiNm1ApPzzRDgjcR28P17TXsAOkV5/Y6t+SpjcrYtuQR8wPpYAqT8IuvtcMVJf7qluQTDiGsFK6FHodR4/W3oFd4L5nSvXOXZn0BvjS/+WdTKKbG8i2Q8GaTNtnkufC2N4OdIpEBQpKMX8pfbYuG3VHaHjVQFXWoAxDMyypIagdEaUTNz4h3P2CUTRlQNtL5carar5BKahIWiZ9r56JtfgkS0nWTRXl17KWh6hn6pzn7mIAa58+urwMvY93F5taQz89/OMhD1F6nTmrAhTeZ2gHZESDGk/bg==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c211100b0040fc5460109sm1312756wml.35.2024.02.06.01.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 01:24:37 -0800 (PST)
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
Subject: [PATCH v3 01/17] plugins: remove previous n_vcpus functions from API
Date: Tue,  6 Feb 2024 13:24:06 +0400
Message-ID: <20240206092423.3005995-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32b.google.com
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

This information is already accessible using qemu_info_t during plugin
install.

We will introduce another function (qemu_plugin_num_vcpus) which
represent how many cpus were enabled, by tracking new cpu indexes.

It's a breaking change, so we bump API version.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h   | 10 +++-------
 plugins/plugin.h             |  2 +-
 contrib/plugins/cache.c      |  2 +-
 plugins/api.c                | 30 ------------------------------
 plugins/qemu-plugins.symbols |  2 --
 5 files changed, 5 insertions(+), 41 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 2c1930e7e45..0e506ee644d 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -51,11 +51,13 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * The plugins export the API they were built against by exposing the
  * symbol qemu_plugin_version which can be checked.
+ *
+ * version 2: removed qemu_plugin_n_vcpus and qemu_plugin_n_max_vcpus
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 1
+#define QEMU_PLUGIN_VERSION 2
 
 /**
  * struct qemu_info_t - system information for plugins
@@ -644,12 +646,6 @@ QEMU_PLUGIN_API
 void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
                                     qemu_plugin_udata_cb_t cb, void *userdata);
 
-/* returns -1 in user-mode */
-int qemu_plugin_n_vcpus(void);
-
-/* returns -1 in user-mode */
-int qemu_plugin_n_max_vcpus(void);
-
 /**
  * qemu_plugin_outs() - output string via QEMU's logging system
  * @string: a string
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 5eb2fdbc85e..90f3f324ab6 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -15,7 +15,7 @@
 #include <gmodule.h>
 #include "qemu/qht.h"
 
-#define QEMU_PLUGIN_MIN_VERSION 0
+#define QEMU_PLUGIN_MIN_VERSION 2
 
 /* global state */
 struct qemu_plugin_state {
diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 9e7ade3b374..c5c8ac75a9c 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -767,7 +767,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
 
     policy = LRU;
 
-    cores = sys ? qemu_plugin_n_vcpus() : 1;
+    cores = sys ? info->system.smp_vcpus : 1;
 
     for (i = 0; i < argc; i++) {
         char *opt = argv[i];
diff --git a/plugins/api.c b/plugins/api.c
index 8d5cca53295..2aaae4e47f3 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -353,36 +353,6 @@ const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h)
 #endif
 }
 
-/*
- * Queries to the number and potential maximum number of vCPUs there
- * will be. This helps the plugin dimension per-vcpu arrays.
- */
-
-#ifndef CONFIG_USER_ONLY
-static MachineState * get_ms(void)
-{
-    return MACHINE(qdev_get_machine());
-}
-#endif
-
-int qemu_plugin_n_vcpus(void)
-{
-#ifdef CONFIG_USER_ONLY
-    return -1;
-#else
-    return get_ms()->smp.cpus;
-#endif
-}
-
-int qemu_plugin_n_max_vcpus(void)
-{
-#ifdef CONFIG_USER_ONLY
-    return -1;
-#else
-    return get_ms()->smp.max_cpus;
-#endif
-}
-
 /*
  * Plugin output
  */
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 6963585c1ea..6088dd3714a 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -17,8 +17,6 @@
   qemu_plugin_mem_is_sign_extended;
   qemu_plugin_mem_is_store;
   qemu_plugin_mem_size_shift;
-  qemu_plugin_n_max_vcpus;
-  qemu_plugin_n_vcpus;
   qemu_plugin_outs;
   qemu_plugin_path_to_binary;
   qemu_plugin_read_register;
-- 
2.43.0


