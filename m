Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8BAC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp6on-0006n7-1q; Tue, 26 Mar 2024 09:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rp6ol-0006mR-By
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:26:19 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rp6oj-0002Wo-3j
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:26:19 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e74aa08d15so3741991b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1711459574; x=1712064374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QgrS4ttSycuJ4qqEHqxmJzoOkmMPczj0AzC2izbEKKo=;
 b=ckvE1hACyEJZDHJYIAMQrwF6DM4iHy9rQmnOPEQWvVuozuechEyMwb4cauwn00lzSP
 7/qBUKTv04BueqrD0ZcRLfSP/QRpv8cOxJ3vbwspt3fe0HDFoFdV3r1oV53w+ip/fXvG
 TVSiCEisrQAzUKTYefeJrsDvQmfhJiKtXp0XcYCOFgl+rNFBLKys9SY6Vr+h7xLuc9MU
 oR7LnN06wNk+ccVuZPV95ZCbCUJhn/NT5BTfG/SSFZxvXYEq0PjO7/b7UM3YTZ621Jqx
 CV4A5cIPkUz4dKsJs72c5bS6g95XgL203RtrJfBEYlasyWXMlB8CbjOElE7nYOeT8xsH
 Dg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711459574; x=1712064374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QgrS4ttSycuJ4qqEHqxmJzoOkmMPczj0AzC2izbEKKo=;
 b=Kkm58LYxdGFIjjQvbbRnaaGMxy4lHGJmZAAamMReAxnoRWDRSIS11MPxYGfHdLQlZ9
 BhvOSWk3hOq8Z3VO565eoT+Nk2CSNrEq4Cz5FZRd6dejor7DXtjS22Tjrv9TV+sDpyjg
 zIqzIOPpVY8bSdUNHSXrD1BJqSdrQvz//E3aeoi5jeCdr07xrvJn2juJLRzKm6VOgICb
 0MlqOElsy6SSg9kkFoEQy6pEEFTy13zHIf+BLhl9tXCR0VBFg1i5RjviOemPR9wYWuH+
 QfroFOEp/wG/z6p/g722O9BkEE1xepdUGyZ8aKA32W6yHap6Jf7Bi8Jzf3+X3tMu/Frx
 Au/Q==
X-Gm-Message-State: AOJu0YzMM2aD2zRGR6bNvFkToMIN2z7Pyb22hVidi9RndHWfD8DxYOll
 ZS52rAlTGT6hPd12Idb0szlBwpHz+SWMBMpk9v7Px5Br8K1dHR6Z3H3KkO+sJNm2C3MzcaiVxWl
 P
X-Google-Smtp-Source: AGHT+IHFQvrcfeuCLEUD73/40GJvHgDRigVOTDPc1EhyOkcVqoA5CWE4l9Z2yKZ7p41Xx02fsnHMHw==
X-Received: by 2002:a05:6a20:5043:b0:1a3:572b:d4e3 with SMTP id
 o3-20020a056a20504300b001a3572bd4e3mr9407774pza.27.1711459574510; 
 Tue, 26 Mar 2024 06:26:14 -0700 (PDT)
Received: from grind.. ([177.45.186.241]) by smtp.gmail.com with ESMTPSA id
 v10-20020aa799ca000000b006e9afb31e4bsm6080236pfi.12.2024.03.26.06.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 06:26:14 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org, qemu_oss@crudebyte.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 1/3] qtest/virtio-9p-test.c: consolidate create dir,
 file and symlink tests
Date: Tue, 26 Mar 2024 10:26:04 -0300
Message-ID: <20240326132606.686025-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326132606.686025-1-dbarboza@ventanamicro.com>
References: <20240326132606.686025-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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

The local 9p driver in virtio-9p-test.c its temporary dir right at the
start of qos-test (via virtio_9p_create_local_test_dir()) and only
deletes it after qos-test is finished (via
virtio_9p_remove_local_test_dir()).

This means that any qos-test machine that ends up running virtio-9p-test local
tests more than once will end up re-using the same temp dir. This is
what's happening in [1] after we introduced the riscv machine nodes: if
we enable slow tests with the '-m slow' flag using qemu-system-riscv64,
this is what happens:

- a temp dir is created, e.g. qtest-9p-local-WZLDL2;

- virtio-9p-device tests will run virtio-9p-test successfully;

- virtio-9p-pci tests will run virtio-9p-test, and fail right at the
  first slow test at fs_create_dir() because the "01" file was already
  created by fs_create_dir() test when running with the virtio-9p-device.

We can fix it by making every test clean up their changes in the
filesystem after they're done. But we don't need every test either:
what fs_create_file() does is already exercised in fs_unlinkat_dir(),
i.e. a dir is created, verified to be created, and then removed. Fixing
fs_create_file() would turn it into fs_unlikat_dir(), so we don't need
both. The same theme follows every test in virtio-9p-test.c, where the
'unlikat' variant does the same thing the 'create' does but with some
cleaning in the end.

Consolide some tests as follows:

- fs_create_dir() is removed. fs_unlinkat_dir() is renamed to
  fs_create_unlinkat_dir();

- fs_create_file() is removed. fs_unlinkat_file() is renamed to
  fs_create_unlinkat_file(). The "04" dir it uses is now being removed;

- fs_symlink_file() is removed. fs_unlinkat_symlink() is renamed to
  fs_create_unlinkat_symlink(). Both "real_file" and the "06" dir it
  creates is now being removed.

We're still missing the 'hardlink' tests. We'll do it in the next patch
since it's less trivial to consolidate than these.

[1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg05807.html

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/qtest/virtio-9p-test.c | 97 +++++++++++-------------------------
 1 file changed, 29 insertions(+), 68 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 65e69491e5..cdbe3e78ea 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -506,26 +506,8 @@ static void fs_readdir_split_512(void *obj, void *data,
 
 /* tests using the 9pfs 'local' fs driver */
 
-static void fs_create_dir(void *obj, void *data, QGuestAllocator *t_alloc)
-{
-    QVirtio9P *v9p = obj;
-    v9fs_set_allocator(t_alloc);
-    struct stat st;
-    g_autofree char *root_path = virtio_9p_test_path("");
-    g_autofree char *new_dir = virtio_9p_test_path("01");
-
-    g_assert(root_path != NULL);
-
-    tattach({ .client = v9p });
-    tmkdir({ .client = v9p, .atPath = "/", .name = "01" });
-
-    /* check if created directory really exists now ... */
-    g_assert(stat(new_dir, &st) == 0);
-    /* ... and is actually a directory */
-    g_assert((st.st_mode & S_IFMT) == S_IFDIR);
-}
-
-static void fs_unlinkat_dir(void *obj, void *data, QGuestAllocator *t_alloc)
+static void fs_create_unlinkat_dir(void *obj, void *data,
+                                   QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
@@ -551,28 +533,13 @@ static void fs_unlinkat_dir(void *obj, void *data, QGuestAllocator *t_alloc)
     g_assert(stat(new_dir, &st) != 0);
 }
 
-static void fs_create_file(void *obj, void *data, QGuestAllocator *t_alloc)
-{
-    QVirtio9P *v9p = obj;
-    v9fs_set_allocator(t_alloc);
-    struct stat st;
-    g_autofree char *new_file = virtio_9p_test_path("03/1st_file");
-
-    tattach({ .client = v9p });
-    tmkdir({ .client = v9p, .atPath = "/", .name = "03" });
-    tlcreate({ .client = v9p, .atPath = "03", .name = "1st_file" });
-
-    /* check if created file exists now ... */
-    g_assert(stat(new_file, &st) == 0);
-    /* ... and is a regular file */
-    g_assert((st.st_mode & S_IFMT) == S_IFREG);
-}
-
-static void fs_unlinkat_file(void *obj, void *data, QGuestAllocator *t_alloc)
+static void fs_create_unlinkat_file(void *obj, void *data,
+                                    QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
+    g_autofree char *new_dir = virtio_9p_test_path("04");
     g_autofree char *new_file = virtio_9p_test_path("04/doa_file");
 
     tattach({ .client = v9p });
@@ -587,37 +554,22 @@ static void fs_unlinkat_file(void *obj, void *data, QGuestAllocator *t_alloc)
     tunlinkat({ .client = v9p, .atPath = "04", .name = "doa_file" });
     /* file should be gone now */
     g_assert(stat(new_file, &st) != 0);
-}
-
-static void fs_symlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
-{
-    QVirtio9P *v9p = obj;
-    v9fs_set_allocator(t_alloc);
-    struct stat st;
-    g_autofree char *real_file = virtio_9p_test_path("05/real_file");
-    g_autofree char *symlink_file = virtio_9p_test_path("05/symlink_file");
 
-    tattach({ .client = v9p });
-    tmkdir({ .client = v9p, .atPath = "/", .name = "05" });
-    tlcreate({ .client = v9p, .atPath = "05", .name = "real_file" });
-    g_assert(stat(real_file, &st) == 0);
-    g_assert((st.st_mode & S_IFMT) == S_IFREG);
-
-    tsymlink({
-        .client = v9p, .atPath = "05", .name = "symlink_file",
-        .symtgt = "real_file"
+    /* also cleanup dir*/
+    tunlinkat({
+        .client = v9p, .atPath = "/", .name = "04",
+        .flags = P9_DOTL_AT_REMOVEDIR
     });
-
-    /* check if created link exists now */
-    g_assert(stat(symlink_file, &st) == 0);
+    g_assert(stat(new_dir, &st) != 0);
 }
 
-static void fs_unlinkat_symlink(void *obj, void *data,
-                                QGuestAllocator *t_alloc)
+static void fs_create_unlinkat_symlink(void *obj, void *data,
+                                       QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
     v9fs_set_allocator(t_alloc);
     struct stat st;
+    g_autofree char *new_dir = virtio_9p_test_path("06");
     g_autofree char *real_file = virtio_9p_test_path("06/real_file");
     g_autofree char *symlink_file = virtio_9p_test_path("06/symlink_file");
 
@@ -636,6 +588,16 @@ static void fs_unlinkat_symlink(void *obj, void *data,
     tunlinkat({ .client = v9p, .atPath = "06", .name = "symlink_file" });
     /* symlink should be gone now */
     g_assert(stat(symlink_file, &st) != 0);
+
+    /* remove real file and dir */
+    tunlinkat({ .client = v9p, .atPath = "06", .name = "real_file" });
+    g_assert(stat(real_file, &st) != 0);
+
+    tunlinkat({
+        .client = v9p, .atPath = "/", .name = "06",
+        .flags = P9_DOTL_AT_REMOVEDIR
+    });
+    g_assert(stat(new_dir, &st) != 0);
 }
 
 static void fs_hardlink_file(void *obj, void *data, QGuestAllocator *t_alloc)
@@ -746,13 +708,12 @@ static void register_virtio_9p_test(void)
 
     opts.before = assign_9p_local_driver;
     qos_add_test("local/config", "virtio-9p", pci_config,  &opts);
-    qos_add_test("local/create_dir", "virtio-9p", fs_create_dir, &opts);
-    qos_add_test("local/unlinkat_dir", "virtio-9p", fs_unlinkat_dir, &opts);
-    qos_add_test("local/create_file", "virtio-9p", fs_create_file, &opts);
-    qos_add_test("local/unlinkat_file", "virtio-9p", fs_unlinkat_file, &opts);
-    qos_add_test("local/symlink_file", "virtio-9p", fs_symlink_file, &opts);
-    qos_add_test("local/unlinkat_symlink", "virtio-9p", fs_unlinkat_symlink,
-                 &opts);
+    qos_add_test("local/create_unlinkat_dir", "virtio-9p",
+                 fs_create_unlinkat_dir, &opts);
+    qos_add_test("local/create_unlinkat_file", "virtio-9p",
+                 fs_create_unlinkat_file, &opts);
+    qos_add_test("local/create_unlinkat_symlink", "virtio-9p",
+                 fs_create_unlinkat_symlink, &opts);
     qos_add_test("local/hardlink_file", "virtio-9p", fs_hardlink_file, &opts);
     qos_add_test("local/unlinkat_hardlink", "virtio-9p", fs_unlinkat_hardlink,
                  &opts);
-- 
2.44.0


