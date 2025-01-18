Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D490C02187
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 16:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZBt3-00040a-LX; Sat, 18 Jan 2025 11:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tZBsv-0003we-5N
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 11:41:23 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tZBss-0007oU-Qn
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 11:41:20 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so463605966b.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 08:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737218477; x=1737823277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YY54bev7L3dmyzD400AvB/ybrot8HwOgUnWozmkH4kE=;
 b=UqWAhfm5yh4Pg96aONX7C3ZR0DrirIWZ1byIc9GwgmIprTNOvmvf8jsekb72HqxHWE
 7CCf3JGszbua6/gVpzzLKb6wIdJhPgElTEE/isP59+ZDTfqBUroovv86YJqQxGwhOPOH
 s0AnaCFceHDj+QtA7b1W3ZpM3BBwQ73QrGof9C2zlGek9cDYZdyE5fpPSZBiBy0HbbIR
 5G8UkJ25dRre4BHRUsHVjLMFBYkIPdQmLDPvopgJH87s0EcqudkGwDkxPcMVUcX/jZ3p
 bfbGhU+9fIDi9vXlgMJdfc4Cbl+x39s5VSop+1WS8IEmakhQdt95+cJToy/sec32MDtM
 zfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737218477; x=1737823277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YY54bev7L3dmyzD400AvB/ybrot8HwOgUnWozmkH4kE=;
 b=CU4x2SwtjzxAGZQ8Q9mQ8iqWjm52PatlqyblSsi/+Tg1rmMzPKvQ9fa3aTdwfNxQ81
 87YY3sa1PVTXje16hG+4HVFqAgKHmyWz+RRG1IM8qKhthXXbp5+MwOGJwVu7Y2ZKgWqW
 X4V2g8U4sillCTAF0YE9K1Du5Eq7Ty6YONad7191Fn10eXOfwyveTiEQHHoGbI75bFuS
 vN/5j5JVGu00pDTEQGhWQVsK2mEJwA0D/83I0kHP2sgjbothIVvylLx3qylI1AJhEJPl
 ksNiZYrKHqrtByTq3k6GkDzQa7mnAsmIyqe/B3Br4xczKJBxrBnI8iEYzmVuFR07jjFj
 bTow==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8MasGm1Ty91+C3xR8/UCk5AFezhitsM5sMsXKZka8dqyDONYVfHETKg44TETF1PWbelgYI6Q5+Qz6@nongnu.org
X-Gm-Message-State: AOJu0YwVoH6mffHjx5ddUgPxcKuY7XDSVLWbrtimq0R7zcouGDtukYza
 3NVaoVov0KPytRyxjwoYJADNHzbeXqG3YeVVSgpj36htdAPUBFlv
X-Gm-Gg: ASbGncvFYl/vIeAeKM2h9rLROgv24uuYhy2J6dINBJN4RS4NbMhyhmOXAXFTXB2/QDV
 ILQiqVTq/mHZYDThJyFkAuLdHZAmvYU2bLxsfvW5fx2llOtpHz1PO0pLSTrCoA48CS2TXp0RkUT
 2bw7s5fzG82Ua22YMCS9nUvyDjP1qlU7cuFnrdq1h/fXmDJ2CdjlXizxJYvt1XSfVMJEUjeslU+
 c1hKL4ZYTUe36bIU3LOUj9AlmPZejIaqP/ZKqOg2qPD1jMhYB84m7lAxMI2IW4O0hQcuecOnzkS
 MdE=
X-Google-Smtp-Source: AGHT+IHfYtK4ipygTEJharwXyH1UErQ1CAfSiTJRDSTUb6Ahriony8M51rfZJqDw6jIkMsBxbLfDiA==
X-Received: by 2002:a17:906:dc8f:b0:ab3:ed0:8d7 with SMTP id
 a640c23a62f3a-ab38b15cd26mr668831566b.23.1737218476563; 
 Sat, 18 Jan 2025 08:41:16 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:d15a:20d8:4bbe:9a4c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f8624fsm358331266b.150.2025.01.18.08.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 08:41:16 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v7 3/4] tests/unit/test-char: add unit tests for hub chardev
 backend
Date: Sat, 18 Jan 2025 17:40:51 +0100
Message-ID: <20250118164056.830721-4-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250118164056.830721-1-r.peniaev@gmail.com>
References: <20250118164056.830721-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x636.google.com
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

This commit introduces a new test function `char_hub_test` to validate
the functionality and constraints of the "hub" chardev backend in QEMU.
The test includes multiple scenarios:

1. Invalid hub creation:
   - Creating a hub without defining `chardevs.N` (expects an error).
   - Creating a hub with an embedded multiplexer (`mux=on`) or a chardev
     already in use (expects errors).

2. Max backend limit:
   - Ensures the hub does not accept more backends than the maximum
     allowed, with appropriate error handling.

3. Valid hub creation and data aggregation:
   - Successfully creating a hub with two ring buffer backends.
   - Verifying data aggregation from backends to a frontend and vice versa.
   - Ensuring correct error handling for attempts to attach a hub multiple
     times or remove busy chardevs.

4. Extended EAGAIN simulation (non-Windows only):
   - Simulates a setup with three backends, including a pipe, to test
     EAGAIN handling and watcher behavior.
   - Verifies data flow and recovery in scenarios involving buffer
     overflows and drained pipes.

The test also ensures correct cleanup of chardevs in all cases, covering
both valid and invalid configurations.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-hub.c     |   4 +-
 tests/unit/test-char.c | 399 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 401 insertions(+), 2 deletions(-)

diff --git a/chardev/char-hub.c b/chardev/char-hub.c
index 9b53df51de44..fb514d92111b 100644
--- a/chardev/char-hub.c
+++ b/chardev/char-hub.c
@@ -223,8 +223,8 @@ static void hub_chr_update_read_handlers(Chardev *chr)
 bool hub_chr_attach_frontend(HubChardev *d, CharBackend *b, Error **errp)
 {
     if (d->frontend) {
-        error_setg(errp, "hub: multiplexed chardev '%s' is already used "
-                   "for multiplexing", d->parent.label);
+        error_setg(errp, "hub: chardev '%s' is already used",
+                   d->parent.label);
         return false;
     }
     d->frontend = b;
diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index 98a60d86b143..e0b15f0b5d0d 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -359,6 +359,404 @@ static void char_mux_test(void)
     qmp_chardev_remove("mux-label", &error_abort);
 }
 
+static void char_hub_test(void)
+{
+    QemuOpts *opts;
+    Chardev *hub, *chr1, *chr2, *base;
+    char *data;
+    FeHandler h = { 0, false, 0, false, };
+    Error *error = NULL;
+    CharBackend chr_be;
+    int ret, i;
+
+#define RB_SIZE 128
+
+    /*
+     * Create invalid hub
+     * 1. Create hub without a 'chardevs.N' defined (expect error)
+     */
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "hub0",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "hub", &error_abort);
+    hub = qemu_chr_new_from_opts(opts, NULL, &error);
+    g_assert_cmpstr(error_get_pretty(error), ==,
+                    "hub: 'chardevs' list is not defined");
+    error_free(error);
+    error = NULL;
+    qemu_opts_del(opts);
+
+    /*
+     * Create invalid hub
+     * 1. Create chardev with embedded mux: 'mux=on'
+     * 2. Create hub which refers mux
+     * 3. Create hub which refers chardev already attached
+     *    to the mux (already in use, expect error)
+     */
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "chr0",
+                            1, &error_abort);
+    qemu_opt_set(opts, "mux", "on", &error_abort);
+    qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
+    qemu_opt_set(opts, "size", stringify(RB_SIZE), &error_abort);
+    base = qemu_chr_new_from_opts(opts, NULL, &error_abort);
+    g_assert_nonnull(base);
+    qemu_opts_del(opts);
+
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "hub0",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "hub", &error_abort);
+    qemu_opt_set(opts, "chardevs.0", "chr0", &error_abort);
+    hub = qemu_chr_new_from_opts(opts, NULL, &error);
+    g_assert_cmpstr(error_get_pretty(error), ==,
+                    "hub: multiplexers and hub devices can't be "
+                    "stacked, check chardev 'chr0', chardev should "
+                    "not be a hub device or have 'mux=on' enabled");
+    error_free(error);
+    error = NULL;
+    qemu_opts_del(opts);
+
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "hub0",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "hub", &error_abort);
+    qemu_opt_set(opts, "chardevs.0", "chr0-base", &error_abort);
+    hub = qemu_chr_new_from_opts(opts, NULL, &error);
+    g_assert_cmpstr(error_get_pretty(error), ==,
+                    "chardev 'chr0-base' is already in use");
+    error_free(error);
+    error = NULL;
+    qemu_opts_del(opts);
+
+    /* Finalize chr0 */
+    qmp_chardev_remove("chr0", &error_abort);
+
+    /*
+     * Create invalid hub with more than maximum allowed backends
+     * 1. Create more than maximum allowed 'chardevs.%d' options for
+     *    hub (expect error)
+     */
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "hub0",
+                            1, &error_abort);
+    for (i = 0; i < 10; i++) {
+        char key[32], val[32];
+
+        snprintf(key, sizeof(key), "chardevs.%d", i);
+        snprintf(val, sizeof(val), "chr%d", i);
+        qemu_opt_set(opts, key, val, &error);
+        if (error) {
+            char buf[64];
+
+            snprintf(buf, sizeof(buf), "Invalid parameter 'chardevs.%d'", i);
+            g_assert_cmpstr(error_get_pretty(error), ==, buf);
+            error_free(error);
+            break;
+        }
+    }
+    g_assert_nonnull(error);
+    error = NULL;
+    qemu_opts_del(opts);
+
+    /*
+     * Create hub with 2 backend chardevs and 1 frontend and perform
+     * data aggregation
+     * 1. Create 2 ringbuf backend chardevs
+     * 2. Create 1 frontend
+     * 3. Create hub which refers 2 backend chardevs
+     * 4. Attach hub to a frontend
+     * 5. Attach hub to a frontend second time (expect error)
+     * 6. Perform data aggregation
+     * 7. Remove chr1 ("chr1 is busy", expect error)
+     * 8. Remove hub0 ("hub0 is busy", expect error);
+     * 9. Finilize frontend, hub and backend chardevs in correct order
+     */
+
+    /* Create first chardev */
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "chr1",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
+    qemu_opt_set(opts, "size", stringify(RB_SIZE), &error_abort);
+    chr1 = qemu_chr_new_from_opts(opts, NULL, &error_abort);
+    g_assert_nonnull(chr1);
+    qemu_opts_del(opts);
+
+    /* Create second chardev */
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "chr2",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
+    qemu_opt_set(opts, "size", stringify(RB_SIZE), &error_abort);
+    chr2 = qemu_chr_new_from_opts(opts, NULL, &error_abort);
+    g_assert_nonnull(chr2);
+    qemu_opts_del(opts);
+
+    /* Create hub0 and refer 2 backend chardevs */
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "hub0",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "hub", &error_abort);
+    qemu_opt_set(opts, "chardevs.0", "chr1", &error_abort);
+    qemu_opt_set(opts, "chardevs.1", "chr2", &error_abort);
+    hub = qemu_chr_new_from_opts(opts, NULL, &error_abort);
+    g_assert_nonnull(hub);
+    qemu_opts_del(opts);
+
+    /* Attach hub to a frontend */
+    qemu_chr_fe_init(&chr_be, hub, &error_abort);
+    qemu_chr_fe_set_handlers(&chr_be,
+                             fe_can_read,
+                             fe_read,
+                             fe_event,
+                             NULL,
+                             &h,
+                             NULL, true);
+
+    /* Fails second time */
+    qemu_chr_fe_init(&chr_be, hub, &error);
+    g_assert_cmpstr(error_get_pretty(error), ==, "hub: chardev "
+                    "'hub0' is already used");
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
+    /* Can't be removed, depends on hub0 */
+    qmp_chardev_remove("chr1", &error);
+    g_assert_cmpstr(error_get_pretty(error), ==, "Chardev 'chr1' is busy");
+    error_free(error);
+    error = NULL;
+
+    /* Can't be removed, depends on frontend chr_be */
+    qmp_chardev_remove("hub0", &error);
+    g_assert_cmpstr(error_get_pretty(error), ==, "Chardev 'hub0' is busy");
+    error_free(error);
+    error = NULL;
+
+    /* Finalize frontend */
+    qemu_chr_fe_deinit(&chr_be, false);
+
+    /* Finalize hub0 */
+    qmp_chardev_remove("hub0", &error_abort);
+
+    /* Finalize backend chardevs */
+    qmp_chardev_remove("chr1", &error_abort);
+    qmp_chardev_remove("chr2", &error_abort);
+
+#ifndef _WIN32
+    /*
+     * Create 3 backend chardevs to simulate EAGAIN and watcher.
+     * Mainly copied from char_pipe_test().
+     * 1. Create 2 ringbuf backend chardevs
+     * 2. Create 1 pipe backend chardev
+     * 3. Create 1 frontend
+     * 4. Create hub which refers 2 backend chardevs
+     * 5. Attach hub to a frontend
+     * 6. Perform data aggregation and check watcher
+     * 7. Finilize frontend, hub and backend chardevs in correct order
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
+        /* Create first chardev */
+        opts = qemu_opts_create(qemu_find_opts("chardev"), "chr1",
+                                1, &error_abort);
+        qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
+        qemu_opt_set(opts, "size", stringify(RB_SIZE), &error_abort);
+        chr1 = qemu_chr_new_from_opts(opts, NULL, &error_abort);
+        g_assert_nonnull(chr1);
+        qemu_opts_del(opts);
+
+        /* Create second chardev */
+        opts = qemu_opts_create(qemu_find_opts("chardev"), "chr2",
+                                1, &error_abort);
+        qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
+        qemu_opt_set(opts, "size", stringify(RB_SIZE), &error_abort);
+        chr2 = qemu_chr_new_from_opts(opts, NULL, &error_abort);
+        g_assert_nonnull(chr2);
+        qemu_opts_del(opts);
+
+        /* Create third chardev */
+        opts = qemu_opts_create(qemu_find_opts("chardev"), "chr3",
+                                1, &error_abort);
+        qemu_opt_set(opts, "backend", "pipe", &error_abort);
+        qemu_opt_set(opts, "path", pipe, &error_abort);
+        chr3 = qemu_chr_new_from_opts(opts, NULL, &error_abort);
+        g_assert_nonnull(chr3);
+
+        /* Create hub0 and refer 3 backend chardevs */
+        opts = qemu_opts_create(qemu_find_opts("chardev"), "hub0",
+                                1, &error_abort);
+        qemu_opt_set(opts, "backend", "hub", &error_abort);
+        qemu_opt_set(opts, "chardevs.0", "chr1", &error_abort);
+        qemu_opt_set(opts, "chardevs.1", "chr2", &error_abort);
+        qemu_opt_set(opts, "chardevs.2", "chr3", &error_abort);
+        hub = qemu_chr_new_from_opts(opts, NULL, &error_abort);
+        g_assert_nonnull(hub);
+        qemu_opts_del(opts);
+
+        /* Attach hub to a frontend */
+        qemu_chr_fe_init(&chr_be, hub, &error_abort);
+        qemu_chr_fe_set_handlers(&chr_be,
+                                 fe_can_read,
+                                 fe_read,
+                                 fe_event,
+                                 NULL,
+                                 &h,
+                                 NULL, true);
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
+
+        /* Finalize frontend */
+        qemu_chr_fe_deinit(&chr_be, false);
+
+        /* Finalize hub0 */
+        qmp_chardev_remove("hub0", &error_abort);
+
+        /* Finalize backend chardevs */
+        qmp_chardev_remove("chr1", &error_abort);
+        qmp_chardev_remove("chr2", &error_abort);
+        qmp_chardev_remove("chr3", &error_abort);
+    }
+#endif
+}
 
 static void websock_server_read(void *opaque, const uint8_t *buf, int size)
 {
@@ -1507,6 +1905,7 @@ int main(int argc, char **argv)
     g_test_add_func("/char/invalid", char_invalid_test);
     g_test_add_func("/char/ringbuf", char_ringbuf_test);
     g_test_add_func("/char/mux", char_mux_test);
+    g_test_add_func("/char/hub", char_hub_test);
 #ifdef _WIN32
     g_test_add_func("/char/console/subprocess", char_console_test_subprocess);
     g_test_add_func("/char/console", char_console_test);
-- 
2.43.0


