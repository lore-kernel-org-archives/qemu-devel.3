Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65061FCB632
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyYZ3-0008R2-KS; Fri, 06 Mar 2026 12:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyYYQ-0008Fe-Cm
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:01:35 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyYYO-0007Sd-LF
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:01:34 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439baf33150so4529350f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 09:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772816491; x=1773421291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iVlTbEEuPuWgxQ8t93zbN/RtKLcNUdmbeRgR5wJf0c4=;
 b=H0SzRoYlNNKuPZP1Bu/SOvyo8Xi9pgIMdcLJmfO6NeeBYfapS49U1NmgehCJx6PDqB
 d6qz9h/vtiiSqL1Rcg8qURdJ7cdq8snwKVnH1g+L6HvRz8GducB4Fa/y/C16bEv4ymwJ
 74MZ0JMg0F+1Om3aZ18+LjSOLKAh1dOy9zZf70X4xJScRtBMNMlWhspUQ12M58EII/kG
 Y1OrgJMa/BKv0u9sKqR3MqqRaI6GYbwVmaYLMc6joh12e7QCUgGYm+mZGq3NAhhv4tIp
 8B++s/X5Gnl7rKOVEcPSbbfn9ZbjaQUhjD8uJUI5SBbN7xlxI5GCpDKtk8eDxqjNd6BR
 VUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772816491; x=1773421291;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVlTbEEuPuWgxQ8t93zbN/RtKLcNUdmbeRgR5wJf0c4=;
 b=cQ/W6wunTWpX1/ueqYATWDIEH75bObgDiCcAMGD3b6bmKCbPDBmKYF2QgpzA0QJkRI
 WsORHi81MSx0VelJPWsWBaR3VUCvZrBd0usdzkWkHaMqdz7ClnFbxfmDTqFlEatygjCy
 BvmRky5Y0p7N2xjkcR3WgcYTSFzQHqKT+X2FfRDAnMqIMApMSRuSW8g1UyNQhuDPhByT
 dKsBpBvgqlO1g9pwrKM6A5mxdgIykQ+Fmj2WCyF4zBMN/ahwHrF8FTthngxSmRn80Jd8
 TQ8MY9Ek3SS1YlqzjbZ5gphwLzNetsQSxRCxak9Yqgt5QPaIWWq2cYVU7z9PH/5INuzQ
 Dvmw==
X-Gm-Message-State: AOJu0YyYPeDjmAGAPyuLjF8DdCLM4OK6Ok57J1V4gLBDs0cpjqIvPh7v
 9GNs53mu9mfvAVdDaGY+YNMY+OzBj9XZV53IUxEOouMJXRDktiASmA05nqg/fqsdquhMQUlksE/
 deNNg
X-Gm-Gg: ATEYQzwdCxqmDwMs/WjHvLNIsoETWQ+8D3SG75pv54KzXJGMMWjyWJHN6b+ZQlUbOEI
 Jh16IfAYjQiiZQR4FUY0r6G0hKf3+QvJM2fH7MUqfzqVm7+R5KX9oSj3A7xlyTXxQeu2AeJO5ru
 XCGoWsnVIVgziB7gFlF30b/OR1m13Q1ZFkFXcfEkJiRfhQXOJR5PvjJGlUdAHtPQWkPAuKuqUz/
 ZyJdZNKyRBUyfdHbMSJeFJOHEwpVd+P0TUXxPx+pkbPGN01LEtih10OasOW6sEh23N70hX5GVgg
 xIhp1PyOA1NqZ+cr7PozV+CP3v14jyRicR9qMaZyo33ldTPMkxHM3Fu06V5FJTFo4IiSvYrapjF
 zwMnpK2FMyWpPK8lY626DxwibQM/ZA2hZYZcb/H/pYUg5rBLJoVQFO5GSvt2DG5Os25qxJQNTxE
 p+Cq4YDfBH0rw8E1HP65kIP5c/axuMY3qHWO//DsyzE2Ib/2eMPai8PaS8nFJv3SNE+mvv5tn2t
 4FgU9tvi8G7nZt/ky41SshrDuHelqk=
X-Received: by 2002:adf:e981:0:b0:439:d0ac:8a8f with SMTP id
 ffacd0b85a97d-439d0ac8ae1mr8251867f8f.1.1772816491115; 
 Fri, 06 Mar 2026 09:01:31 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae45786sm5801257f8f.32.2026.03.06.09.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 09:01:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] tests/qtest/vhost-user-test: Use g_timeout_add() to schedule
 connect
Date: Fri,  6 Mar 2026 17:01:29 +0000
Message-ID: <20260306170129.2475815-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In vhost-user-test, we currently create a new g_thread to run the
connect_thread() function.  This function sleeps for 1 second, and
then calls test_server_create_chr() to create and configure a
chardev:

    chr = qemu_chr_new(server->chr_name, chr_path, server->context);
    g_assert(chr);

    qemu_chr_fe_init(&server->chr, chr, &error_abort);
    qemu_chr_fe_set_handlers(&server->chr, chr_can_read, chr_read,
                             chr_event, NULL, server, server->context, true);

This has a race condition, because when we set the
'reconnect-ms=1000' option on the chardev the socket chardev's
implementation handles the connect asynchronously, via a background
thread and a callback invoked in the main-loop thread.  This means
that that callback and the test_server_create_chr() call to
qemu_chr_fe_set_handlers() can both enter the char-socket code
simultaneously.  The result is random assertion failures and memory
leaks reported by the clang address-sanitizer.

Fix this by using g_timeout_source_new() to set up a GSource that
will run test_server_connect() on the main-loop thread.  This ensures
it can't execute in parallel with the callback that the socket
chardev sets up.  This is similar to how we already handle the
reconnect_cb() in test_reconnect().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Having finally tracked down the root cause of the leak reports in
the vhost-user-tests, this seems to me a fairly straightforward
way to deal with it.

 tests/qtest/vhost-user-test.c | 36 ++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index d2bb21d5b9..c8b5f8ff71 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -930,26 +930,42 @@ reconnect_cb(gpointer user_data)
     return FALSE;
 }
 
-static gpointer
-connect_thread(gpointer data)
+static gboolean connect_cb(gpointer user_data)
 {
-    TestServer *s = data;
+    TestServer *s = user_data;
 
-    /* wait for qemu to start before first try, to avoid extra warnings */
-    g_usleep(G_USEC_PER_SEC);
     test_server_connect(s);
 
-    return NULL;
+    /* We only need to be called once */
+    return G_SOURCE_REMOVE;
+}
+
+/* Initial delay before connect, in milliseconds (1 second) */
+#define INITIAL_CONNECT_DELAY_MS (1 * 1000)
+
+static void test_schedule_connect(TestServer *s)
+{
+    /*
+     * Wait for a bit for QEMU to start before we first try to connect,
+     * to avoid extra warnings. We must run the "connect" on the
+     * main-loop thread so it doesn't race with a callback that
+     * the socket-chardev sets up on the main-loop.
+     */
+    GSource *src = g_timeout_source_new(INITIAL_CONNECT_DELAY_MS);
+    g_source_set_callback(src, connect_cb, s, NULL);
+    g_source_attach(src, s->context);
+    g_source_unref(src);
 }
 
 static void *vhost_user_test_setup_reconnect(GString *cmd_line, void *arg)
 {
     TestServer *s = test_server_new("reconnect", arg);
 
-    g_thread_unref(g_thread_new("connect", connect_thread, s));
     append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
     s->vu_ops->append_opts(s, cmd_line, ",server=on");
 
+    test_schedule_connect(s);
+
     g_test_queue_destroy(vhost_user_test_cleanup, s);
 
     return s;
@@ -983,10 +999,11 @@ static void *vhost_user_test_setup_connect_fail(GString *cmd_line, void *arg)
 
     s->test_fail = true;
 
-    g_thread_unref(g_thread_new("connect", connect_thread, s));
     append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
     s->vu_ops->append_opts(s, cmd_line, ",server=on");
 
+    test_schedule_connect(s);
+
     g_test_queue_destroy(vhost_user_test_cleanup, s);
 
     return s;
@@ -998,10 +1015,11 @@ static void *vhost_user_test_setup_flags_mismatch(GString *cmd_line, void *arg)
 
     s->test_flags = TEST_FLAGS_DISCONNECT;
 
-    g_thread_unref(g_thread_new("connect", connect_thread, s));
     append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
     s->vu_ops->append_opts(s, cmd_line, ",server=on");
 
+    test_schedule_connect(s);
+
     g_test_queue_destroy(vhost_user_test_cleanup, s);
 
     return s;
-- 
2.43.0


