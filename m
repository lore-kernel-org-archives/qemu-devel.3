Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFEAC48BEB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpHL-0000xS-Sq; Tue, 13 Feb 2024 04:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHK-0000xI-QW
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:40:38 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHJ-0000D6-2F
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:40:38 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-51032058f17so5003271e87.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707817235; x=1708422035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HXH7ocyncB0lY9SgnkHxBEuiEnRgV5eLtUY0jbLrGRM=;
 b=HTv+B/a+diHFyi57DMKAZ6K0XUCRIn5k41ReoLgYTjpwR8cPQjwNBgEEx81pkCfYHZ
 a4YEW8LjxQcNklJ75tURYBRImqREZaB9inWguAMCw0LJm4Z222N+Gt6DGF3FgsmKfotI
 gRgaK4rx4qp/zwVKzLdx5ldOvPDW8lJashDmS+Fv1JxsUj6CPWnOPMxPreSQ3DYXO7is
 keUcjklVe+MMle/dqwhSZ0Y0DNEzEZIBmgHR51AptvgQFF2j8ykz+39tII94AOC+Rh79
 /PjP78QNuUPYCCo8Fp29hIwGMsp6pagfo3sKI+vOFbheP1DtJIE4B1dC2juB5WxsJggu
 c1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817235; x=1708422035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HXH7ocyncB0lY9SgnkHxBEuiEnRgV5eLtUY0jbLrGRM=;
 b=tag1FlP9JoENxEV69x1PD1RCb1a28O0l1gVn/f4FiJfA2U7IJPJU8zcvH+FHF+5uAj
 Bjqgq8ZRaplntTHyDDiCAVod7CJC/ZBJCi3WeR4EKNyWDRqf9U3MEnEIfhAf1pJuqjUK
 M/MXSy1J/fsrv/m5G8HQGeQ1SqxTa/aJYYyEnZEmPwadzzJnCLroJyOSNNZJi5LMslxK
 dpOcrs9ZouLgtJVU0+9CL9pJ3q030aV1yJn/wvpBPxd1xTglmjIg/WuzwqomEzsdf0KC
 bVORW2GoguPihED0gOLcxz6LH+lK4Us0j7RcAqyP89NaB2VQg1+Gr2PMIt+blbpkwsZR
 8big==
X-Gm-Message-State: AOJu0YwRsmXklr2+Ja/WvXktSXhwdnHf76WSFh1n+c92zPtNr3ZfMFI3
 g5bArHtZMOMetVTj/BRtwJkkfhqMEU3CNWwlb4U0Ouq4Jv4TiYBJvqo5nEOE1Drb+diBS23WIGB
 7
X-Google-Smtp-Source: AGHT+IEpAn3UH4tKFMxt3gz4i+bRCojlY+Xzc0WM96PQXHflhwH/ia4hQllZZMyRXisMPuzIkW17zg==
X-Received: by 2002:a05:6512:475:b0:511:78cf:968a with SMTP id
 x21-20020a056512047500b0051178cf968amr5090128lfd.68.1707817234926; 
 Tue, 13 Feb 2024 01:40:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVoz/QBEqFokc9fO3O9vMVUwfb1w53d8XYUvLlo14SacGcMUg0FNLBVN5nN6CRXs5csl9tz3zTaJTCCdVdFqIWzLV5H/CRB8Z/6xMYxpN7J9Gtik7Dg0MZkASteXHpnhuGKDO3zUApgc4msuiX9rsyplwdXymZKSWPp/8NGoTFW7CvCXnYPuxbhORi1yU7qXBIybbJUYrn3rcQxmO6lMATcFmHN2RIHUuCnH+x3E68a0A21ePC9Csbr7DNeOKxuMW+9vAvpND9oSTcMTkNido6FW7/cQ9X7P5zhSK7ZiwdgftcH0VCtDs5A3YFSDdRZ7bN18wQCHW56DyQy3st3xl9BxniULg==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033b728190c1sm8550261wrb.79.2024.02.13.01.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:40:34 -0800 (PST)
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
Subject: [PATCH v4 01/18] plugins: remove previous n_vcpus functions from API
Date: Tue, 13 Feb 2024 13:39:51 +0400
Message-ID: <20240213094009.150349-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x130.google.com
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


