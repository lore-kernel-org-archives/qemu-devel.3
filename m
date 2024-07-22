Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C9EC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 23:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW2Nv-0003KC-Ct; Mon, 22 Jul 2024 19:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sW2Nu-0003Jc-2Z
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:24:02 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sW2Nr-0005sI-Sg
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:24:01 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7a0c6ab3354so1175799a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 16:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721690637; x=1722295437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0+uLDbPOBc6/sa8hO77HJpmu18+6zhuVLLtb6K+hv70=;
 b=HyRql5tCb64ySPVlPA5RKzTQ4CNwXYK/mJ1hWnNoTx5qGHhO9nO4lRF2g9gBP5h7lM
 hWuuoUAqqiYprT9B4j3xAvh9TpQv/qpLEpmdrjqjpOmO5uHCa14s0mJ/Zm6Jjgp7QWpi
 7mBB/FbgvztlE7HMRgMsh30v5HSPTvxdEAkCMQmc0Lu5WzLTFRru11TYrXmIzi5gL5tU
 BxpF4PRkI01Z66H0byYVe3aFatW7887drQyG38vPLYvTF6zBD3QVFp0ergYU/5OtoN+v
 XpndYcOPjgCqPsHo/M+9d+YWiHpiAxYSXjkIhNzxozVrqKhpxNXTvC5dOvTsm4FfiH1m
 Krag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721690637; x=1722295437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0+uLDbPOBc6/sa8hO77HJpmu18+6zhuVLLtb6K+hv70=;
 b=BJAZ13k5yWK4hWTGl0aSQYSKFbHM0h79pAvJkGKXjuI2CzZqydLqtAt/ixxjN78a6Z
 Hp230E0Axi8pcptBXQ1mDhyfrX7Lqp9hQbCUoPU32pu93vxmu7dpgUG8yoojANTaUamU
 TysyksSUO+xtFGi6GlIsswLqEwrIA/gnJx7wOl3kidlbXAlcV1yVVQByR3g+F/+mdsCz
 Kv5aZA6LckUxziJk3ErtARijHWdJM/82SNXyKOAoVHHBEkCEwqnkzGeQgF5BSXnSoY3L
 8d6NMGq2mT3OJph+yrNXIzYfrhz4DOeqYKLlbjLq9uJntizOwcGCP4h3RX0ZD9cA2iHM
 hTtQ==
X-Gm-Message-State: AOJu0YwRYXWx7ln8y+btq7zxE0PGLAFUoRUidMvOuBlBJ/LOo5SGTqSa
 31LsjldvOsIx8n8fbN6rDoFLOY5U2FfxNfx1mQbLelFqlJ+8xfpLbYiv503NG/bFgHLHxycfhTl
 gxGc=
X-Google-Smtp-Source: AGHT+IE7QPQCyIpPtIjkPPwzKEmd2Ewrbpcj+jRx3+OlyXJq9NLHX+/paojK2TWpPb38vSXvi1W+IA==
X-Received: by 2002:a05:6a20:9325:b0:1c3:b1e6:d27f with SMTP id
 adf61e73a8af0-1c4229a6effmr6513777637.46.1721690637051; 
 Mon, 22 Jul 2024 16:23:57 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ccf7c723bbsm7733188a91.30.2024.07.22.16.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 16:23:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH] plugins: fix race condition with scoreboards
Date: Mon, 22 Jul 2024 16:23:44 -0700
Message-Id: <20240722232344.2203257-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

A deadlock can be created if a new vcpu (a) triggers a scoreboard
reallocation, and another vcpu (b) wants to create a new scoreboard at
the same time.

In this case, (a) holds the plugin lock, and starts an exclusive
section, waiting for (b). But at the same time, (b) is waiting for
plugin lock.

The solution is to drop the lock before entering the exclusive section.

This bug can be easily reproduced by creating a callback for any tb
exec, that allocates a new scoreboard. In this case, as soon as we reach
more than 16 vcpus, the deadlock occurs.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2344
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 plugins/core.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/plugins/core.c b/plugins/core.c
index 12c67b4b4eb..e31a5c1c9cc 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -214,28 +214,45 @@ CPUPluginState *qemu_plugin_create_vcpu_state(void)
 
 static void plugin_grow_scoreboards__locked(CPUState *cpu)
 {
-    if (cpu->cpu_index < plugin.scoreboard_alloc_size) {
+    size_t scoreboard_size = plugin.scoreboard_alloc_size;
+    if (cpu->cpu_index < scoreboard_size) {
         return;
     }
 
     bool need_realloc = FALSE;
-    while (cpu->cpu_index >= plugin.scoreboard_alloc_size) {
-        plugin.scoreboard_alloc_size *= 2;
+    while (cpu->cpu_index >= scoreboard_size) {
+        scoreboard_size *= 2;
         need_realloc = TRUE;
     }
 
+    if (!need_realloc) {
+        return;
+    }
 
-    if (!need_realloc || QLIST_EMPTY(&plugin.scoreboards)) {
-        /* nothing to do, we just updated sizes for future scoreboards */
+    if (QLIST_EMPTY(&plugin.scoreboards)) {
+        /* just update size for future scoreboards */
+        plugin.scoreboard_alloc_size = scoreboard_size;
         return;
     }
 
+    /*
+     * A scoreboard creation/deletion might be in progress. If a new vcpu is
+     * initialized at the same time, we are safe, as the new
+     * plugin.scoreboard_alloc_size was not yet written.
+     */
+    qemu_rec_mutex_unlock(&plugin.lock);
+
     /* cpus must be stopped, as tb might still use an existing scoreboard. */
     start_exclusive();
+    /* re-acquire lock */
+    qemu_rec_mutex_lock(&plugin.lock);
+    /* in case another vcpu is created between unlock and exclusive section. */
+    scoreboard_size = MAX(scoreboard_size, plugin.scoreboard_alloc_size);
     struct qemu_plugin_scoreboard *score;
     QLIST_FOREACH(score, &plugin.scoreboards, entry) {
-        g_array_set_size(score->data, plugin.scoreboard_alloc_size);
+        g_array_set_size(score->data, scoreboard_size);
     }
+    plugin.scoreboard_alloc_size = scoreboard_size;
     /* force all tb to be flushed, as scoreboard pointers were changed. */
     tb_flush(cpu);
     end_exclusive();
-- 
2.39.2


