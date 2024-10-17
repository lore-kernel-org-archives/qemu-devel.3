Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991AAD374A2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Rl8-0003Zk-Bf; Thu, 17 Oct 2024 10:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t1Rl5-0003XQ-UU
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:45:47 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t1Rl2-0005fB-OA
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:45:47 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fb518014b9so9839151fa.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729176343; x=1729781143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OuAtGnIZeBLL9MISZlOD/G0pLbwC3CAC1YLQSZfl9F0=;
 b=XGnw0b/dtJEBmYQCmMHDpCGR2nhLMPJlzRWQ8c5Lg6v35AbnnqxdeSBNP9AKjuf76f
 We71ySOH6xkO9y4qmUvIxsw4nkVOwTtfoYUIsb0exegGf3Q9WF4Va3wSI8R9dN+Pg7K1
 E+lOwEtISQwpvhzzn/ZLSC/LdOKWFTkeJnrTbQdeMGK60G/WWo85j+LVgWxFhQ1H0e0F
 B4B5rnc5vH5hvebBWjdjHXaaqmLrvnNKLgAdAM6JwAjgfnmH/QQpbtJ0WNP56SP5MWvt
 GX6ZDftN8lShDNqRx2F0SZSYhZItK1UiCWtew/XgufW0MqOCBm4NB/D9yIOSUuxQrBd9
 93KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176343; x=1729781143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OuAtGnIZeBLL9MISZlOD/G0pLbwC3CAC1YLQSZfl9F0=;
 b=iZ/uD+5YwhByB7SYdroFz08LnCDWJrszDTHo3geoGvXjbet5V9W0c+ajRVVh+gez7g
 A+ufMU5OxDgGbxThvXUIMqpaxgZ3TBpkVsd3haqekG49Cn2pFaTb38AeTlCPLS/cZXKn
 AuB/2fTNGONqNXzT1/EZMog93u9f22IY9KJtkP/b/BLrqEy+HjAYa9pL+e3sbRQWh7Jh
 9yq5kOxOP/q6G8js/3IoFh5NUP7pcH2l8XZ0+C6JAoHnrl/5LhrPNkVXT2FzrhUrhbpv
 Og5HB5GLX0NebfkjQDIAwFiqku9IMb8HLpb5iboPZtrnspO0ZkJ09Ati4gb0B9er2hd1
 WVOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViQrZ+K7LWsJGU/FXj2FOiiMok9yWKO81vG6NaF7yQE/SiaIwPgNcoGDsfdg/1CbGGi2pHZxBrttbk@nongnu.org
X-Gm-Message-State: AOJu0YwTax1UkgT0FXv3y61gXSsQAE63QTURknH8TLpG4GF/O/wjhkAU
 e2GUoHDXVj1ztHlFzpuwdtG8gLVYuGmDPtgwq2uMIoBEPp6ZFY/B
X-Google-Smtp-Source: AGHT+IEOwDjU+zn5pLKv89ew8WYvkh3H0ofRVToa0jUlRmou0BDJaApFcCtFgtV94kCOMlBFA4Z4ew==
X-Received: by 2002:a2e:be9d:0:b0:2fb:48f6:27e4 with SMTP id
 38308e7fff4ca-2fb61b3e646mr53709811fa.3.1729176342843; 
 Thu, 17 Oct 2024 07:45:42 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:9c4:b066:486:f408])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c98d507a14sm2867581a12.49.2024.10.17.07.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:45:42 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v5 7/8] tests/unit/test-char: add unit test for the `mux-be`
 multiplexer
Date: Thu, 17 Oct 2024 16:43:15 +0200
Message-Id: <20241017144316.517709-8-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017144316.517709-1-r.peniaev@gmail.com>
References: <20241017144316.517709-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x22b.google.com
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
 tests/unit/test-char.c | 323 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 321 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index a1c6bb874c8e..25bb5b70347e 100644
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
@@ -359,6 +359,324 @@ static void char_mux_test(void)
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
+    /* Create mux-be with invalid mux-be-id */
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "mux0",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "mux-be", &error_abort);
+    qemu_opt_set(opts, "mux-be-id", "something", &error_abort);
+    mux_be = qemu_chr_new_from_opts(opts, NULL, &error);
+    g_assert_cmpstr(error_get_pretty(error), ==, "chardev: multiplexers "
+                    "can't be stacked");
+    error_free(error);
+    error = NULL;
+    qemu_opts_del(opts);
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
+
+        g_free(in);
+        g_free(out);
+        g_free(tmp_path);
+        g_free(pipe);
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
@@ -1506,7 +1824,8 @@ int main(int argc, char **argv)
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


