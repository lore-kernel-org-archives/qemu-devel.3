Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED63D1AD43
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 10:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t11Gg-0003kx-21; Wed, 16 Oct 2024 06:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t11GY-0003jl-QN
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:28:30 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t11GW-0004A8-4y
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 06:28:29 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c962c3e97dso4679393a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 03:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729074507; x=1729679307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NtGdGZ/zn8WcWNHkcuhdBpfqRucUKp/hW6ytn0g9Z6I=;
 b=Bl5LvzlXu7muOxE7wqSa0dLKiexjDAGoqcSI4c0vpvuitT6TANy2typkA04UZb/KdP
 gZ1b5WinyWYjjY7PGO8U8+19l9J9A01lNBNmwtrhN2iOBb/MIWkJMmC/Xb6NWxYmjhcX
 v9RrKinOeQEVgSEceWuR1BLZ63MVY2ne8JG6YOA5hV4trMx+//PNjvoZv2+pjaRa2yQ6
 AbSwvCCnbyhKrfUr/a4Ec40flGJKfdZriVyaw/hvAh/fp5NMCIQUMxt0cP3OIaCtrTS8
 6sUVUQCVWjqxkeHob2pEqebgdvT+SapIwRy/LmoM8eiEqwe9HozwGcHtdZgHhsqXwbsC
 veAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729074507; x=1729679307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NtGdGZ/zn8WcWNHkcuhdBpfqRucUKp/hW6ytn0g9Z6I=;
 b=AvMu+ajFs4MXrqN/Kw1hvwgc0aO+lh/lkIupTAWPTi1gwPBNnyUrQTSaBmJXOBB/su
 uSySqQlibnOMg723ZzhTJwjijIAaWMuot79c6pvjJzxSfbojPKbdqq3dXxfNDCS0/8Us
 3aVmyffMndN9SU91IoQF8noTgWz36sGHphWVYzDkyx+HYCISagqYMhTMuvJm2cRBuarr
 lnKiytpmnNH+ibVClKv6fssl8U9xpI6XIw2fmROSS533ad8PgYDHZhs5ri6RGoGZh8jh
 SagzoXI7vk/pVaa9edeUpHXv4txqsx56K6DYWGCsnmYsO1+N4XUHg2ofeszqXDwAtwsH
 aFNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhQhFRqjattUhnomP8WKs2gUghE0/Ddgs9+iCzL2IjniTBMN42NThtwlZ0Mxu7llM6gvVy7nLHrUfa@nongnu.org
X-Gm-Message-State: AOJu0YwZy0OMIxlDBefq9GUrXBBgTj7MrpIDvGGfHFy9mAnVp2GTtXSc
 cHwifh6vPu2o85pI9IYSmknLST4BCciklmDiMa7AuEygOnq/SZPM
X-Google-Smtp-Source: AGHT+IExrIANhl29jKyslrSdYdC8026kESn+4GOFQdmZKGtqlKE11ShnDqBmwlrcsOf45q9P95ONIw==
X-Received: by 2002:a05:6402:2748:b0:5c9:4a9b:31f9 with SMTP id
 4fb4d7f45d1cf-5c94a9b5292mr14227939a12.35.1729074506532; 
 Wed, 16 Oct 2024 03:28:26 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c98d4f85dcsm1566680a12.22.2024.10.16.03.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 03:28:26 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v4 7/8] tests/unit/test-char: add unit test for the `mux-be`
 multiplexer
Date: Wed, 16 Oct 2024 12:26:04 +0200
Message-Id: <20241016102605.459395-8-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016102605.459395-1-r.peniaev@gmail.com>
References: <20241016102605.459395-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The test is trivial: several backends, 1 `mux-be`, 1 frontend
do the buffer write and read. Pipe is used for EAGAIN verification.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 tests/unit/test-char.c | 306 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 304 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index a1c6bb874c8e..3eb0692b199f 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -178,7 +178,7 @@ static void char_ringbuf_test(void)
     qemu_opts_del(opts);
 }
 
-static void char_mux_test(void)
+static void char_mux_fe_test(void)
 {
     QemuOpts *opts;
     Chardev *chr, *base;
@@ -359,6 +359,307 @@ static void char_mux_test(void)
     qmp_chardev_remove("mux-label", &error_abort);
 }
 
+static void char_mux_be_test(void)
+{
+    QemuOpts *opts;
+    Chardev *mux_be, *chr1, *chr2, *base;
+    char *data;
+    FeHandler h = { 0, false, 0, false, };
+    Error *error = NULL;
+    CharBackend chr_be;
+    int ret, i;
+
+#define RB_SIZE 128
+
+    /* Create mux-be */
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "mux0",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "mux-be", &error_abort);
+    mux_be = qemu_chr_new_from_opts(opts, NULL, &error_abort);
+    g_assert_nonnull(mux_be);
+    qemu_opts_del(opts);
+
+    /* Check maximum allowed backends */
+    for (i = 0; true; i++) {
+        char name[8];
+
+        snprintf(name, sizeof(name), "chr%d", i);
+        opts = qemu_opts_create(qemu_find_opts("chardev"), name,
+                                1, &error_abort);
+        qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
+        qemu_opt_set(opts, "size", stringify(RB_SIZE), &error_abort);
+        qemu_opt_set(opts, "mux-be-id", "mux0", &error_abort);
+        base = qemu_chr_new_from_opts(opts, NULL, &error);
+        if (error) {
+            const char *err_fmt =
+                "too many uses of multiplexed chardev 'mux0' (maximum is %u)";
+            unsigned n;
+
+            ret = sscanf(error_get_pretty(error), err_fmt, &n);
+            error_free(error);
+            error = NULL;
+            g_assert_cmpint(ret, ==, 1);
+            g_assert_cmpint(i, ==, n);
+            break;
+        }
+        g_assert_nonnull(base);
+        qemu_opts_del(opts);
+    }
+    /* Finalize mux0 */
+    qmp_chardev_remove("mux0", &error_abort);
+
+    /* Finalize all backends */
+    while (i--) {
+        char name[8];
+        snprintf(name, sizeof(name), "chr%d", i);
+        qmp_chardev_remove(name, &error_abort);
+    }
+
+    /* Create mux-be */
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "mux0",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "mux-be", &error_abort);
+    mux_be = qemu_chr_new_from_opts(opts, NULL, &error_abort);
+    g_assert_nonnull(mux_be);
+    qemu_opts_del(opts);
+
+    /* Create chardev which fails */
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "chr1",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
+    qemu_opt_set(opts, "size", stringify(RB_SIZE), &error_abort);
+    qemu_opt_set(opts, "mux-be-id", "mux0", &error_abort);
+    qemu_opt_set(opts, "mux", "on", &error_abort);
+    chr1 = qemu_chr_new_from_opts(opts, NULL, &error);
+    g_assert_cmpstr(error_get_pretty(error), ==, "chardev: mux and mux-be "
+                    "can't be used for the same device");
+    error_free(error);
+    error = NULL;
+    qemu_opts_del(opts);
+
+    /* Create first chardev */
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "chr1",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
+    qemu_opt_set(opts, "size", stringify(RB_SIZE), &error_abort);
+    qemu_opt_set(opts, "mux-be-id", "mux0", &error_abort);
+    chr1 = qemu_chr_new_from_opts(opts, NULL, &error_abort);
+    g_assert_nonnull(chr1);
+    qemu_opts_del(opts);
+
+    /* Create second chardev */
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "chr2",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
+    qemu_opt_set(opts, "size", stringify(RB_SIZE), &error_abort);
+    qemu_opt_set(opts, "mux-be-id", "mux0", &error_abort);
+    chr2 = qemu_chr_new_from_opts(opts, NULL, &error_abort);
+    g_assert_nonnull(chr2);
+    qemu_opts_del(opts);
+
+    /* Attach mux-be to a frontend */
+    qemu_chr_fe_init(&chr_be, mux_be, &error_abort);
+    qemu_chr_fe_set_handlers(&chr_be,
+                             fe_can_read,
+                             fe_read,
+                             fe_event,
+                             NULL,
+                             &h,
+                             NULL, true);
+
+    /* Fails second time */
+    qemu_chr_fe_init(&chr_be, mux_be, &error);
+    g_assert_cmpstr(error_get_pretty(error), ==, "multiplexed chardev 'mux0' "
+                    "is already used for multiplexing");
+    error_free(error);
+    error = NULL;
+
+    /* Write to backend, chr1 */
+    base = qemu_chr_find("chr1");
+    g_assert_cmpint(qemu_chr_be_can_write(base), !=, 0);
+
+    qemu_chr_be_write(base, (void *)"hello", 6);
+    g_assert_cmpint(h.read_count, ==, 6);
+    g_assert_cmpstr(h.read_buf, ==, "hello");
+    h.read_count = 0;
+
+    /* Write to backend, chr2 */
+    base = qemu_chr_find("chr2");
+    g_assert_cmpint(qemu_chr_be_can_write(base), !=, 0);
+
+    qemu_chr_be_write(base, (void *)"olleh", 6);
+    g_assert_cmpint(h.read_count, ==, 6);
+    g_assert_cmpstr(h.read_buf, ==, "olleh");
+    h.read_count = 0;
+
+    /* Write to frontend, chr_be */
+    ret = qemu_chr_fe_write(&chr_be, (void *)"heyhey", 6);
+    g_assert_cmpint(ret, ==, 6);
+
+    data = qmp_ringbuf_read("chr1", RB_SIZE, false, 0, &error_abort);
+    g_assert_cmpint(strlen(data), ==, 6);
+    g_assert_cmpstr(data, ==, "heyhey");
+    g_free(data);
+
+    data = qmp_ringbuf_read("chr2", RB_SIZE, false, 0, &error_abort);
+    g_assert_cmpint(strlen(data), ==, 6);
+    g_assert_cmpstr(data, ==, "heyhey");
+    g_free(data);
+
+
+#ifndef _WIN32
+    /*
+     * Create third chardev to simulate EAGAIN and watcher.
+     * Mainly copied from char_pipe_test().
+     */
+    {
+        gchar *tmp_path = g_dir_make_tmp("qemu-test-char.XXXXXX", NULL);
+        gchar *in, *out, *pipe = g_build_filename(tmp_path, "pipe", NULL);
+        Chardev *chr3;
+        int fd, len;
+        char buf[128];
+
+        in = g_strdup_printf("%s.in", pipe);
+        if (mkfifo(in, 0600) < 0) {
+            abort();
+        }
+        out = g_strdup_printf("%s.out", pipe);
+        if (mkfifo(out, 0600) < 0) {
+            abort();
+        }
+
+        opts = qemu_opts_create(qemu_find_opts("chardev"), "chr3",
+                                1, &error_abort);
+        qemu_opt_set(opts, "backend", "pipe", &error_abort);
+        qemu_opt_set(opts, "path", pipe, &error_abort);
+        qemu_opt_set(opts, "mux-be-id", "mux0", &error_abort);
+        chr3 = qemu_chr_new_from_opts(opts, NULL, &error_abort);
+        g_assert_nonnull(chr3);
+
+        /* Write to frontend, chr_be */
+        ret = qemu_chr_fe_write(&chr_be, (void *)"thisis", 6);
+        g_assert_cmpint(ret, ==, 6);
+
+        data = qmp_ringbuf_read("chr1", RB_SIZE, false, 0, &error_abort);
+        g_assert_cmpint(strlen(data), ==, 6);
+        g_assert_cmpstr(data, ==, "thisis");
+        g_free(data);
+
+        data = qmp_ringbuf_read("chr2", RB_SIZE, false, 0, &error_abort);
+        g_assert_cmpint(strlen(data), ==, 6);
+        g_assert_cmpstr(data, ==, "thisis");
+        g_free(data);
+
+        fd = open(out, O_RDWR);
+        ret = read(fd, buf, sizeof(buf));
+        g_assert_cmpint(ret, ==, 6);
+        buf[ret] = 0;
+        g_assert_cmpstr(buf, ==, "thisis");
+        close(fd);
+
+        /* Add watch. 0 indicates no watches if nothing to wait for */
+        ret = qemu_chr_fe_add_watch(&chr_be, G_IO_OUT | G_IO_HUP,
+                                    NULL, NULL);
+        g_assert_cmpint(ret, ==, 0);
+
+        /*
+         * Write to frontend, chr_be, until EAGAIN. Make sure length is
+         * power of two to fit nicely the whole pipe buffer.
+         */
+        len = 0;
+        while ((ret = qemu_chr_fe_write(&chr_be, (void *)"thisisit", 8))
+               != -1) {
+            len += ret;
+        }
+        g_assert_cmpint(errno, ==, EAGAIN);
+
+        /* Further all writes should cause EAGAIN */
+        ret = qemu_chr_fe_write(&chr_be, (void *)"b", 1);
+        g_assert_cmpint(ret, ==, -1);
+        g_assert_cmpint(errno, ==, EAGAIN);
+
+        /*
+         * Add watch. Non 0 indicates we have a blocked chardev, which
+         * can wakes us up when write is possible.
+         */
+        ret = qemu_chr_fe_add_watch(&chr_be, G_IO_OUT | G_IO_HUP,
+                                    NULL, NULL);
+        g_assert_cmpint(ret, !=, 0);
+        g_source_remove(ret);
+
+        /* Drain pipe and ring buffers */
+        fd = open(out, O_RDWR);
+        while ((ret = read(fd, buf, MIN(sizeof(buf), len))) != -1 && len > 0) {
+            len -= ret;
+        }
+        close(fd);
+
+        data = qmp_ringbuf_read("chr1", RB_SIZE, false, 0, &error_abort);
+        g_assert_cmpint(strlen(data), ==, 128);
+        g_free(data);
+
+        data = qmp_ringbuf_read("chr2", RB_SIZE, false, 0, &error_abort);
+        g_assert_cmpint(strlen(data), ==, 128);
+        g_free(data);
+
+        /*
+         * Now we are good to go, first repeat "lost" sequence, which
+         * was already consumed and drained by the ring buffers, but
+         * pipe have not recieved that yet.
+         */
+        ret = qemu_chr_fe_write(&chr_be, (void *)"thisisit", 8);
+        g_assert_cmpint(ret, ==, 8);
+
+        ret = qemu_chr_fe_write(&chr_be, (void *)"streamisrestored", 16);
+        g_assert_cmpint(ret, ==, 16);
+
+        data = qmp_ringbuf_read("chr1", RB_SIZE, false, 0, &error_abort);
+        g_assert_cmpint(strlen(data), ==, 16);
+        /* Only last 16 bytes, see big comment above */
+        g_assert_cmpstr(data, ==, "streamisrestored");
+        g_free(data);
+
+        data = qmp_ringbuf_read("chr2", RB_SIZE, false, 0, &error_abort);
+        g_assert_cmpint(strlen(data), ==, 16);
+        /* Only last 16 bytes, see big comment above */
+        g_assert_cmpstr(data, ==, "streamisrestored");
+        g_free(data);
+
+        fd = open(out, O_RDWR);
+        ret = read(fd, buf, sizeof(buf));
+        g_assert_cmpint(ret, ==, 24);
+        buf[ret] = 0;
+        /* Both 8 and 16 bytes */
+        g_assert_cmpstr(buf, ==, "thisisitstreamisrestored");
+        close(fd);
+    }
+#endif
+
+    /* Can't be removed, depends on mux0 */
+    qmp_chardev_remove("chr1", &error);
+    g_assert_cmpstr(error_get_pretty(error), ==, "Chardev 'chr1' is busy");
+    error_free(error);
+    error = NULL;
+
+    /* Can't be removed, depends on frontend chr_be */
+    qmp_chardev_remove("mux0", &error);
+    g_assert_cmpstr(error_get_pretty(error), ==, "Chardev 'mux0' is busy");
+    error_free(error);
+    error = NULL;
+
+    /* Finalize frontend */
+    qemu_chr_fe_deinit(&chr_be, false);
+
+    /* Finalize mux0 */
+    qmp_chardev_remove("mux0", &error_abort);
+
+    /* Finalize backend chardevs */
+    qmp_chardev_remove("chr1", &error_abort);
+    qmp_chardev_remove("chr2", &error_abort);
+#ifndef _WIN32
+    qmp_chardev_remove("chr3", &error_abort);
+#endif
+}
 
 static void websock_server_read(void *opaque, const uint8_t *buf, int size)
 {
@@ -1506,7 +1807,8 @@ int main(int argc, char **argv)
     g_test_add_func("/char/null", char_null_test);
     g_test_add_func("/char/invalid", char_invalid_test);
     g_test_add_func("/char/ringbuf", char_ringbuf_test);
-    g_test_add_func("/char/mux", char_mux_test);
+    g_test_add_func("/char/mux", char_mux_fe_test);
+    g_test_add_func("/char/mux-be", char_mux_be_test);
 #ifdef _WIN32
     g_test_add_func("/char/console/subprocess", char_console_test_subprocess);
     g_test_add_func("/char/console", char_console_test);
-- 
2.34.1


