Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF652C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1ohX-00019q-Kt; Mon, 07 Apr 2025 11:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prantoran@gmail.com>)
 id 1u1ohW-00016v-CQ; Mon, 07 Apr 2025 11:47:54 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <prantoran@gmail.com>)
 id 1u1ohU-0003L8-8r; Mon, 07 Apr 2025 11:47:53 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7376dd56eccso4912641b3a.0; 
 Mon, 07 Apr 2025 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744040868; x=1744645668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8BeD7FRlhSxFj5q4qqPupWTyYaP5bZ/s/rvekPFIBK0=;
 b=Uf8FUmppb/tIF1pfQPGzbrKTUjT5sVggR5FjiixSoclqERhUYnFqnLAFO6sxV4wbUj
 9WHYzLTB4nBgRmNFfx3lG3iti1fRu0WZqEfzW1DPhMix4BRi2ADEk/W5Et7yGCTDlNrO
 u/NhzbvMvL0E7KyucfDZzSzE95AneI8O6fnXbYyzbx+VMEpUTTI9tYoFiqLi/1xLBwnW
 zd6iH+BuWTpOJu9xVjipYnZGjr7O7ndP9IY56LY/NVQ3xRWwiPKMIyOGF1qzYJPPUG7h
 kH7SS41p12l41Mm58DJbnyI6FntjkR+zLFE1O8XmsT1v9BG08654/X51knJs0MRCzEeR
 Hm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744040868; x=1744645668;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8BeD7FRlhSxFj5q4qqPupWTyYaP5bZ/s/rvekPFIBK0=;
 b=kbAjI+siYxbk4k8T+UaVBlnIOvPoBcX6h6b+yZpTcMO47BI6brNILX8UOy5lKV9k2V
 OipBzn2ksmfTuiqdoFW+o6Rlu6xD+lRmgi6ZVj1acX6Zj9lr9W+z4oSu7xk+khpcbBfu
 8YQQlb8tssUMbKDVSbm0btiTCne5+SbN9Oar8vhI6yfd9OYwpe4E0ZBpp6F9/XMlUB40
 1zoyNpNSOeLQrdpvfbYFFf53d1SCa6SMDFG8mMNrgS/aK28YuawT8nxePlYNrwyrGnLj
 U05ZvFL38rBPaiScqZdTyKzorPiaskhRPrwXN26MPpVs70zPuHfUL4s6F+7zkUWwfGtp
 C9Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMPf8Qxm7D2IqqOOZk6ybbKCBAh9DKnp7jKnBYXSkpbKxirwxSPZ/cugNjK1fMoXwkKaupL4mPNiXI@nongnu.org
X-Gm-Message-State: AOJu0YySUkL1QoIfUO4Z38lWHu9fAfOo1RbuHtF798mL09lSyle77ZRI
 4KN6ZNfhoaA2JEYZFEoz1bfhu2EAQ+L6WPiWYWrJRZA/sZ0tdtab
X-Gm-Gg: ASbGncsoI+V6e/k/vMtK3xIwnHfnfH4y2dB478BuE/5/XE6luQNKz6AmllRdaz2lZdw
 ZZ0EBtwHqTR8ciYfdPV37u2C1V+qSyiS8e27OGzLQZF3dhDC/R//8AjIAwCHKNPREYIGjpyySpi
 /QVBLE05Hf/rqK/l1nNuN5mZMBeziezHB0W0AQwTJLsv3bHD8noLCpvtFj0W/YTc3KxSJ9Mc4uE
 cU7i25KHl6fGZnehOhSOJ4uuXWu8x2f2ZIEnAUOhSigC8QBvwYhEeLVCz0DNtMvaotyXtlEYqKh
 k2kbVUKSkdeGawZ3SWwN2QagX47MDQG4wSDV61tmMzJTwcGT4c8=
X-Google-Smtp-Source: AGHT+IEIW1BWWJd95o+cMOgG/HBI4PeD93a2E4l3CwixPQJxTNlvzCDjvcCQyswYRmJ93f+OUdeU6Q==
X-Received: by 2002:a05:6a00:2e08:b0:736:692e:129 with SMTP id
 d2e1a72fcca58-739e716650fmr20022222b3a.24.1744040868142; 
 Mon, 07 Apr 2025 08:47:48 -0700 (PDT)
Received: from queen.. ([2604:3d08:7485:e900:41:4d42:a3db:f9b6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97effb7sm8986877b3a.60.2025.04.07.08.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 08:47:47 -0700 (PDT)
From: Pinku Deb Nath <prantoran@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Pinku Deb Nath <prantoran@gmail.com>
Subject: [PATCH v6] block/file-posix.c: Use pwritev2() with RWF_DSYNC for FUA
Date: Mon,  7 Apr 2025 08:47:30 -0700
Message-ID: <20250407154730.23008-1-prantoran@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=prantoran@gmail.com; helo=mail-pf1-x431.google.com
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

Full Unit Access (FUA) is an optimization where a disk write with the
flag set will be persisted to disk immediately instead of potentially
remaining in the disk's write cache.

This commit address the todo task
for using pwritev2() with RWF_DSYNC in the thread pool section of
raw_co_prw(), if pwritev2() with RWF_DSYNC is available in the host,
which is always the case for Linux kernel >= 4.7.

The intent for FUA is indicated with the BDRV_REQ_FUA flag.
The old code paths are preserved in case BDRV_REQ_FUA is off
or pwritev2() with RWF_DSYNC is not available.

Support for disk writes with FUA is handled in qemu_pwritev_fua(),
which uses pwritev2() with RWF_DSYNC if available, otherwise falls
back to pwritev2() with no flags followed by flush using
handle_aiocb_flush().

If pwritev2() is not implemented, then disk write in the linear FUA
will fallback to pwrite() + handle_aiocb_flush().

Signed-off-by: Pinku Deb Nath <prantoran@gmail.com>

---

v5:
- Use pwritev for unsupported OSes

v4:
- Add fallback when qemu_pwritev_fua() returns ENOSYS
- Similar fallback was not added for handle_aiocb_rw_vector()
since there is a preadv_present check in handle_aiocb_rw()

v3:
- Changed signature to add fd, iov, nr_iov
- Return -ENOSYS for non-Linux hosts

v2:
- Moved handle_aiocb_flush() into qemu_pwritev_fua()
- In handle_aiocb_rw_linear(), iovec with iovcnt=1 is created
based on the assumption that there will be only one buffer
---
 block/file-posix.c | 68 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 12 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 56d1972d15..380f709917 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -229,6 +229,7 @@ typedef struct RawPosixAIOData {
             unsigned long op;
         } zone_mgmt;
     };
+    BdrvRequestFlags flags;
 } RawPosixAIOData;
 
 #if defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
@@ -1674,6 +1675,20 @@ qemu_pwritev(int fd, const struct iovec *iov, int nr_iov, off_t offset)
     return pwritev(fd, iov, nr_iov, offset);
 }
 
+static ssize_t
+qemu_pwritev_fua(int fd, struct iovec *iov, int nr_iov, off_t offset, RawPosixAIOData *aiocb)
+{
+#ifdef RWF_DSYNC
+    return pwritev2(fd, iov, nr_iov, offset, RWF_DSYNC);
+#else
+    ssize_t len = pwritev(fd, iov, nr_iov, offset);
+    if (len == 0) {
+        len = handle_aiocb_flush(aiocb);
+    }
+    return len;
+#endif
+}
+
 #else
 
 static bool preadv_present = false;
@@ -1690,6 +1705,11 @@ qemu_pwritev(int fd, const struct iovec *iov, int nr_iov, off_t offset)
     return -ENOSYS;
 }
 
+static ssize_t
+qemu_pwritev_fua(int fd, struct iovec *iov, int nr_iov, off_t offset, const RawPosixAIOData *aiocb)
+{
+    return -ENOSYS;
+}
 #endif
 
 static ssize_t handle_aiocb_rw_vector(RawPosixAIOData *aiocb)
@@ -1698,10 +1718,16 @@ static ssize_t handle_aiocb_rw_vector(RawPosixAIOData *aiocb)
 
     len = RETRY_ON_EINTR(
         (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) ?
-            qemu_pwritev(aiocb->aio_fildes,
-                           aiocb->io.iov,
-                           aiocb->io.niov,
-                           aiocb->aio_offset) :
+            (aiocb->flags &  BDRV_REQ_FUA) ?
+                qemu_pwritev_fua(aiocb->aio_fildes,
+                                aiocb->io.iov,
+                                aiocb->io.niov,
+                                aiocb->aio_offset,
+                                aiocb) :
+                qemu_pwritev(aiocb->aio_fildes,
+                            aiocb->io.iov,
+                            aiocb->io.niov,
+                            aiocb->aio_offset) :
             qemu_preadv(aiocb->aio_fildes,
                           aiocb->io.iov,
                           aiocb->io.niov,
@@ -1727,10 +1753,31 @@ static ssize_t handle_aiocb_rw_linear(RawPosixAIOData *aiocb, char *buf)
 
     while (offset < aiocb->aio_nbytes) {
         if (aiocb->aio_type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) {
-            len = pwrite(aiocb->aio_fildes,
-                         (const char *)buf + offset,
-                         aiocb->aio_nbytes - offset,
-                         aiocb->aio_offset + offset);
+            if (aiocb->flags & BDRV_REQ_FUA) {
+                struct iovec iov = {
+                    .iov_base = buf + offset,
+                    .iov_len = aiocb->aio_nbytes - offset,
+                };
+                len = qemu_pwritev_fua(aiocb->aio_fildes,
+                                    &iov,
+                                    1,
+                                    aiocb->aio_offset + offset,
+                                    aiocb);
+                if (len == -ENOSYS) {
+                    len = pwrite(aiocb->aio_fildes,
+                                (const char *)buf + offset,
+                                aiocb->aio_nbytes - offset,
+                                aiocb->aio_offset + offset);
+                    if (len == 0) {
+                        len = handle_aiocb_flush(aiocb);
+                    }
+                }
+            } else {
+                len = pwrite(aiocb->aio_fildes,
+                            (const char *)buf + offset,
+                            aiocb->aio_nbytes - offset,
+                            aiocb->aio_offset + offset);
+            }
         } else {
             len = pread(aiocb->aio_fildes,
                         buf + offset,
@@ -2539,14 +2586,11 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
             .iov            = qiov->iov,
             .niov           = qiov->niov,
         },
+        .flags          = flags,
     };
 
     assert(qiov->size == bytes);
     ret = raw_thread_pool_submit(handle_aiocb_rw, &acb);
-    if (ret == 0 && (flags & BDRV_REQ_FUA)) {
-        /* TODO Use pwritev2() instead if it's available */
-        ret = raw_co_flush_to_disk(bs);
-    }
     goto out; /* Avoid the compiler err of unused label */
 
 out:
-- 
2.43.0


