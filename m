Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E758C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 22:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sddCx-0000y8-ES; Mon, 12 Aug 2024 18:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sddCt-0000jq-5W
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 18:08:03 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sddCq-0002by-JM
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 18:08:02 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fd90c2fc68so32876215ad.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 15:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723500479; x=1724105279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ttAfjKeU6u7wb2c6jWg45GDLBDcHd62FQu7Ts/cTRl4=;
 b=kQNu9gLvQOkAGthh83MNyyQ5skgg1MmXhF5KLd1+qY9CYr7K2nQawOcaD6ijat/01Z
 0QQ1m/kdtoefI2Y2Xa43NIDTVdmIYwrflQV2eix4oneCATMA2RgI7qBvxhqDhk8qDHy6
 RUPzytpGSHvN2/6HLySdNDyC94d5xGJSOsS2w10N0qqQS8sTpsqECpgdrQ1VNLu3uJXb
 jghqS3maT18fpDHz4V0cJ9G3LargzbrDebi/+cU9IJwSgMfWSdx5eHL24ulmHnuATY1w
 WBhLPpLQoDlyA3Kf73VKS05DbA2XWulepqDlWmRHPo1S2rMXjHcfV/2LC228egZtQ58G
 e7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723500479; x=1724105279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ttAfjKeU6u7wb2c6jWg45GDLBDcHd62FQu7Ts/cTRl4=;
 b=IjaP9BAyOfC+tg37eoDnUVBU7etY7+/qHvwCPjL5zNRLn0TnbGw9LTuqU2eB7YjxkM
 fDevav3uVQg+7Uz5IyFkLBkoQPLMlItSV42LZkT20mHW+GNBjLp1uuBQJ0DKTU+6Vlit
 Hs00mxPA/DKbD7FDK9lWdlRQGxIHZTdGh3Pry+63XfcjeEnl4vr90+2aWyCf096zgXfF
 6vFBnm1/1fU4g5lhw1O/gOUY2rnduYucdpyiWjOryiH0Wr3j0aUSV6tO+5dVbHB1Y/a4
 1qrBWod/Y0XjIJJZXOLhBuVXzpMbeou3KJc5Q4xeGzIjwA98ZT8CeYpB/0eMu4HV0D9n
 gUpA==
X-Gm-Message-State: AOJu0Yzim1QYzyifi/+ux6qtA8I9zz1U62Fen00HMNtBY0B7HcUpSI3X
 HV/TEbm1jn3aYMEELKSYYxl7b08bJWdrCVHb4K0r2djiTRkshD5VlQaQ9rkTsKs66gLljO+7NES
 evUQ=
X-Google-Smtp-Source: AGHT+IFoXzPf1tPP2YUV33LBmqXc2qxZ2X0JGpjvGphbW+QDNcumBa6glbWAWYRbY8ufg3JKfRTsfg==
X-Received: by 2002:a17:902:f54c:b0:1fb:67e0:2e0a with SMTP id
 d9443c01a7336-201ca1acaf7mr20732765ad.48.1723500478864; 
 Mon, 12 Aug 2024 15:07:58 -0700 (PDT)
Received: from linaro.vn.shawcable.net
 ([2604:3d08:9384:1d00:5b09:8db7:b002:cf61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd13169esm1588355ad.24.2024.08.12.15.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 15:07:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 1/1] plugins: fix race condition with scoreboards
Date: Mon, 12 Aug 2024 15:07:48 -0700
Message-Id: <20240812220748.95167-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240812220748.95167-1-pierrick.bouvier@linaro.org>
References: <20240812220748.95167-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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
 plugins/core.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/plugins/core.c b/plugins/core.c
index 12c67b4b4eb..84e2872083b 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -214,30 +214,48 @@ CPUPluginState *qemu_plugin_create_vcpu_state(void)
 
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
-    struct qemu_plugin_scoreboard *score;
-    QLIST_FOREACH(score, &plugin.scoreboards, entry) {
-        g_array_set_size(score->data, plugin.scoreboard_alloc_size);
+    /* re-acquire lock */
+    qemu_rec_mutex_lock(&plugin.lock);
+    /* in case another vcpu is created between unlock and exclusive section. */
+    if (scoreboard_size > plugin.scoreboard_alloc_size) {
+        struct qemu_plugin_scoreboard *score;
+        QLIST_FOREACH(score, &plugin.scoreboards, entry) {
+            g_array_set_size(score->data, scoreboard_size);
+        }
+        plugin.scoreboard_alloc_size = scoreboard_size;
+        /* force all tb to be flushed, as scoreboard pointers were changed. */
+        tb_flush(cpu);
     }
-    /* force all tb to be flushed, as scoreboard pointers were changed. */
-    tb_flush(cpu);
     end_exclusive();
 }
 
-- 
2.39.2


