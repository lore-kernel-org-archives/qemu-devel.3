Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E5F606A32E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d9k3ME+n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRXUo-00049a-Rf; Thu, 12 Nov 2026 11:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xRXUk-00045G-BY
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 11:17:52 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xRXUh-0002KB-V7
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 11:17:50 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-490585eddfcso3459881f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 08:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794500266; x=1795105066; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vvwfM3Xj3yjPW0g7yjscIndQLwY3Haalp6yrtFEeAK8=;
 b=d9k3ME+n6aS9Vm7/3PmrLT63GZTvll0fknPIgOEW2z1M4d0Ft7XDY2EDVG7K7OX1g7
 ol6T/UZsnTMciXxsjoiJ8vrMuC1Mv4wmFSW7dZ77vBXHWvVpbco/8wTeMg8Ea5Q/m8q0
 1UkLmxYbDNSL4TswW1gHxmr3hgjbnp5dnoro7wiNAlnO6zHM3TBJthJ+akrarMHoJcXi
 7kbyhbXSll71yBojRhmo9BRZs3ig9TTZHfT7cRikYNPFH5wzaSRYKcDjAVslFoqPqHba
 NJHxwIFg9IVxkWz6S2PjTNsSdUKwhjMwlpQDzlpozVAFM1fGI0upule0tsPzgdauXjoD
 1R3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794500266; x=1795105066;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vvwfM3Xj3yjPW0g7yjscIndQLwY3Haalp6yrtFEeAK8=;
 b=KZNOCenHo7HgWvrOzSvJhzrLCIenb5vZZPcy4AQH6Hgv/cgopAEyh8xGrrTRf6+swu
 fxncFeTsfV+756e/WZWmjQUPI9V5AUN2hyK+1K/ybZ+aTDT+bx6Utnl5xrzJJJb5q891
 GyjWaD0DQv8lV8Z4nc1sZcuLUjp1SZvX1DKTXBWMZaXZ4xNfCpzoltGsriX+9gSEOLz1
 0yS+Z42tQpfp/CQNbQsCIgA6lqs9tus6oDwZym/Zv0bTTnAgC25vUTY9eBVYj6zIdaAJ
 eiSNBJFIDthUR+wzflMv71lX8UQg7yxyM6zGq9+RMNe4DwS5GR+uoJcB8E/0cVGGFq5R
 5Brw==
X-Gm-Message-State: APuU4Z/1ieWNltzuT5AiOXwxUQgOE/bLnb40BMCLw7yTxRaDT+IO1+P3
 1VdIDs3IkjvIBzjwkOv6O7xl1u8RneoV3PZ9t2JGGy8QbEodYeVXFnYy
X-Gm-Gg: AYBFou0H6nbx4x7x0l+vNeNqYZNcD00yosBnwgKIV9pxGyw+SYbOb50xDLkHCjdrmXh
 5Ev/jKM2doXW9efdhIDItxWoDaOhwoMtIQHz0a2nFv203njl7Owv6zAqkz/abgsD90gIbIBMSg3
 r9RquW9EbDbGgWGvecN33OXnk0ciyFQ53rW/XkNMnqa7+kjoJhnACbwfx0/UcNgvEd0BH2hWT0s
 WMhjhygeFGN6Y9VrsW1tVwculrzymqmz2VPec4/mYzXZlyWtIBGLE7vZLEMDG5wIeNmeSDHLXUN
 Z18c/pBiWrvnXMtk/YdgREx8ZVUQrqP00B2Mg5/lpegrQOJmO269qLAKSDFyzlHY9ddknhDRVN/
 KbXUkzqI1dvh4kCHeiNfX1cs93T7hMDABF56EZtLMXanUMmfgHeU93Q0nakeFbKvzhW8cekd52h
 MhGHidlp0yzI85z8sYSFm3wa0p9CyUukeQFQgmLFGla6PqYp8g0VCVSAWp5s690BlBYQVUh8/ME
 2d3qHzJGvS4hF+tGigjU9ptFhqBth+YWLCaobyMOUqDX6aCWNB8eQBx2BSQZS9jlC8zz851dkSn
 BT1Afy9DoihfLI57xcPSX/HW9wsR7cQSGp114o2eyPDmcDoYFIZdZF6esA==
X-Received: by 2002:a05:6000:40cd:b0:490:a3e7:8af3 with SMTP id
 ffacd0b85a97d-499c764a963mr11925055f8f.35.1794500265692; 
 Thu, 12 Nov 2026 08:17:45 -0800 (PST)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c603f4d29sm55871f8f.35.2026.11.12.08.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 08:17:44 -0800 (PST)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Thu, 12 Nov 2026 17:17:30 +0100
Subject: [PATCH v4] treewide: use qemu_dup() instead of dup()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-use-qemu-dup-v4-1-c9032f94bc2c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNyw6CMBCF4VchXVvTTimgK9/DuOhlhBq5SIFoC
 O9uixtC4vIk8/0zE4+9Q0/OyUx6nJx3bRNGekiIqVRTInU2bAIMMs440NEjfWE9Ujt2VBQZFFY
 rIxBJIF2Pd/dec9fbb/tRP9AMsREvKueHtv+s/yYe7/6kJ045ZcKe0kKCykxxKWvlnkfT1iSmJ
 9hiscMQMAc0gUMmdL7HYovlDouAjWKg5QnyHOQWL8vyBQX4m2o0AQAA
X-Change-ID: 20261012-use-qemu-dup-38628dbac3ee
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 Eric Blake <eblake@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 qemu-block@nongnu.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794500263; l=8386;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=G3dhWRQSq5CmidyPBWw3tMxsfSriocBZtxWPgXbm4kE=;
 b=73LSlHbu1tQmSo++iUzPeSldcA6F2YOXsL/u9Fx26At4gnS0mAtne7d2HUVz0Ej2m3iX33kKJ
 Azv5KzPcy/RALhPDhCborhMY28MWqsyM6+IzJZUGaV7ZHxSpATozXOr
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move qemu_dup() out of an #ifndef so it can be called from code that
runs on Windows. Then use it instead of dup() to ensure the cloexec
flag is set on dup'd fds.

The only direct users of dup() are now guest syscalls in the user
emulators and the implementation of qemu_dup() itself.

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
I fixed the Windows build now, checked with docker-test-mingw. I had
to remove ENABLE_RUST=1 in fedora-win64-cross.docker, because Rust
cross-compilation was broken.

Changes in v4:
- Fix Windows build
- Link to v3: https://lore.kernel.org/qemu-devel/20261015-use-qemu-dup-v3-1-ca02b5927725@gmail.com

Changes in v3:
- Also replace the use in migration/cpr-exec.c and the tests
- Link to v2: https://lore.kernel.org/qemu-devel/20261013-use-qemu-dup-v2-1-12ecd94263b7@gmail.com

Changes in v2:
- Replace the use in qemu-nbd.c too
- Changed commit message
- Link to v1: https://lore.kernel.org/qemu-devel/20261012-use-qemu-dup-v1-1-03d94852a6c8@gmail.com
---
 hw/virtio/virtio.c             |  2 +-
 include/qemu/osdep.h           |  2 +-
 io/channel-file.c              |  2 +-
 migration/cpr-exec.c           |  2 +-
 qemu-nbd.c                     |  2 +-
 system/vl.c                    |  9 +--------
 tests/qtest/bios-tables-test.c |  2 +-
 tests/unit/test-util-sockets.c |  6 +++---
 tests/unit/test-vmstate.c      |  2 +-
 ui/dmabuf.c                    |  2 +-
 util/osdep.c                   | 28 ++++++++++++++--------------
 11 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index c9f9e5b511..70779fbd56 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3204,7 +3204,7 @@ VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t shmid,
         return NULL;
     }
 
-    fd = dup(fd);
+    fd = qemu_dup(fd);
     if (fd < 0) {
         error_report("Failed to duplicate fd: %s", strerror(errno));
         return NULL;
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index b27d159d5b..b5dbfc8a8a 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -653,9 +653,9 @@ int qemu_open(const char *name, int flags, Error **errp);
 int qemu_create(const char *name, int flags, mode_t mode, Error **errp);
 int qemu_close(int fd);
 int qemu_unlink(const char *name);
+int qemu_dup(int fd);
 #ifndef _WIN32
 int qemu_dup_flags(int fd, int flags);
-int qemu_dup(int fd);
 int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
 int qemu_unlock_fd(int fd, int64_t start, int64_t len);
 int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
diff --git a/io/channel-file.c b/io/channel-file.c
index 4c9da6619b..548a633be8 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -54,7 +54,7 @@ qio_channel_file_new_fd(int fd)
 QIOChannelFile *
 qio_channel_file_new_dupfd(int fd, Error **errp)
 {
-    int newfd = dup(fd);
+    int newfd = qemu_dup(fd);
 
     if (newfd < 0) {
         error_setg_errno(errp, errno, "Could not dup FD %d", fd);
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index daa50916d2..2f38db30bb 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -44,7 +44,7 @@ bool cpr_exec_persist_state(QEMUFile *f, Error **errp)
 {
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
     /* coverity[leaked_storage] - mfd intentionally kept open across exec() */
-    int mfd = dup(fioc->fd);
+    int mfd = qemu_dup(fioc->fd);
     char val[16];
 
     /* Remember mfd in environment for post-exec load */
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 4f7e965edb..b283a1b0e6 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -1027,7 +1027,7 @@ int main(int argc, char **argv)
 
             /* Remember parent's stderr if we will be restoring it. */
             if (opts.verbose /* fork_process is set */) {
-                opts.old_stderr = dup(STDERR_FILENO);
+                opts.old_stderr = qemu_dup(STDERR_FILENO);
                 if (opts.old_stderr < 0) {
                     error_report("Could not dup original stderr: %s",
                                  strerror(errno));
diff --git a/system/vl.c b/system/vl.c
index e7b759d544..14db77dfee 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -614,14 +614,7 @@ static int parse_add_fd(void *opaque, QemuOpts *opts, Error **errp)
         return -1;
     }
 
-#ifdef F_DUPFD_CLOEXEC
-    dupfd = fcntl(fd, F_DUPFD_CLOEXEC, 0);
-#else
-    dupfd = dup(fd);
-    if (dupfd != -1) {
-        qemu_set_cloexec(dupfd);
-    }
-#endif
+    dupfd = qemu_dup(fd);
     if (dupfd == -1) {
         error_setg_errno(errp, errno, "error duplicating fd");
         return -1;
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index f6dfa4131b..c4838322fb 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -529,7 +529,7 @@ static void test_acpi_asl(test_data *data)
                     const char *diff_cmd = diff_env ? diff_env : "diff -U 16";
                     char *diff = g_strdup_printf("%s %s %s", diff_cmd,
                                                  exp_sdt->asl_file, sdt->asl_file);
-                    int out = dup(STDOUT_FILENO);
+                    int out = qemu_dup(STDOUT_FILENO);
                     int ret G_GNUC_UNUSED;
                     int dupret;
 
diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index 006f5e579c..c47ad6c82d 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -62,7 +62,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
         error_setg(errp, "No fd named %s", fdname);
         return -1;
     }
-    return dup(mon_fd);
+    return qemu_dup(mon_fd);
 }
 
 /*
@@ -115,7 +115,7 @@ static void test_socket_fd_pass_name_bad(void)
 
     cur_mon = g_malloc(1); /* Fake a monitor */
     mon_fdname = "myfd";
-    mon_fd = dup(STDOUT_FILENO);
+    mon_fd = qemu_dup(STDOUT_FILENO);
     g_assert_cmpint(mon_fd, >, STDERR_FILENO);
 
     addr.type = SOCKET_ADDRESS_TYPE_FD;
@@ -189,7 +189,7 @@ static void test_socket_fd_pass_num_bad(void)
     int fd, sfd;
 
     g_assert(cur_mon == NULL);
-    sfd = dup(STDOUT_FILENO);
+    sfd = qemu_dup(STDOUT_FILENO);
 
     addr.type = SOCKET_ADDRESS_TYPE_FD;
     addr.u.fd.str = g_strdup_printf("%d", sfd);
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index 23f3173070..57f1e3263f 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -42,7 +42,7 @@ static QEMUFile *open_test_file(bool write)
     QIOChannel *ioc;
     QEMUFile *f;
 
-    fd = dup(temp_fd);
+    fd = qemu_dup(temp_fd);
     g_assert(fd >= 0);
     lseek(fd, 0, SEEK_SET);
     if (write) {
diff --git a/ui/dmabuf.c b/ui/dmabuf.c
index 497f82cc61..6d5dffdf84 100644
--- a/ui/dmabuf.c
+++ b/ui/dmabuf.c
@@ -95,7 +95,7 @@ void qemu_dmabuf_dup_fds(QemuDmaBuf *dmabuf, int *fds, int nfds)
     assert(nfds >= dmabuf->num_planes);
 
     for (i = 0; i < dmabuf->num_planes; i++) {
-        fds[i] = dmabuf->fd[i] >= 0 ? dup(dmabuf->fd[i]) : -1;
+        fds[i] = dmabuf->fd[i] >= 0 ? qemu_dup(dmabuf->fd[i]) : -1;
     }
 }
 
diff --git a/util/osdep.c b/util/osdep.c
index 4a8b8b5a90..efb9dea3f3 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -117,6 +117,20 @@ int qemu_mprotect_none(void *addr, size_t size)
 #endif
 }
 
+int qemu_dup(int fd)
+{
+    int ret;
+#ifdef F_DUPFD_CLOEXEC
+    ret = fcntl(fd, F_DUPFD_CLOEXEC, 0);
+#else
+    ret = dup(fd);
+    if (ret != -1) {
+        qemu_set_cloexec(ret);
+    }
+#endif
+    return ret;
+}
+
 #ifndef _WIN32
 
 static int fcntl_op_setlk = -1;
@@ -170,20 +184,6 @@ fail:
     return -1;
 }
 
-int qemu_dup(int fd)
-{
-    int ret;
-#ifdef F_DUPFD_CLOEXEC
-    ret = fcntl(fd, F_DUPFD_CLOEXEC, 0);
-#else
-    ret = dup(fd);
-    if (ret != -1) {
-        qemu_set_cloexec(ret);
-    }
-#endif
-    return ret;
-}
-
 static int qemu_parse_fdset(const char *param)
 {
     return qemu_parse_fd(param);

---
base-commit: 29760efaf96bbe5928f8111881eddbf5ac06439e
change-id: 20261012-use-qemu-dup-38628dbac3ee

Best regards,
--  
Filip Hejsek <filip.hejsek@gmail.com>


