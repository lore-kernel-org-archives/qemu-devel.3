Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7950C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 23:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1DJe-00059A-47; Sat, 05 Apr 2025 19:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prantoran@gmail.com>)
 id 1u1DJb-00058K-UX; Sat, 05 Apr 2025 19:52:44 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <prantoran@gmail.com>)
 id 1u1DJa-0001yd-6n; Sat, 05 Apr 2025 19:52:43 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-30384072398so2445346a91.0; 
 Sat, 05 Apr 2025 16:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743897160; x=1744501960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6FSOuURE/MX3/VXP5/K8vkozrmRKU1K9euxgsgr2Y+Q=;
 b=EvKpbMTX3YXd0HxGyRweLCMRCvc6wR+ID0bHdy4+LXAuvIltztRMrlGyi+28uh8ap4
 umM/BE7ybN6O+sPleYBLlXkHBiPmMA6te1U7xybsWdfP6odugJUUfbr03HKnjKtbrWxC
 FNFD2lrW+ZIEG6Y7FZ9nlEracL0jyOrQdtwqFQmbQ5dWXAhjzbjutHI/Wr7l5biTtsf6
 rgVAHZBNw2DhwPqc4D1GG0ZHBxEY57Ax4evHgW9bfOiKpEAsiRZfRI4KuvHGRPFt0h4N
 6syhcgRHbBkVJPMGVBYNq978MrvvXHKLkRLEotSU9HwvbfrRZQiHOlNgLdLsTklDyp+Q
 wvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743897160; x=1744501960;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6FSOuURE/MX3/VXP5/K8vkozrmRKU1K9euxgsgr2Y+Q=;
 b=g0otAVLFPglqAtNzdbScWR2sN4wAX4Tz2L/ZRkw+5NXWTGViUoy33wTzixLsnltSBK
 dlvmP8Ypy+uYRlB9qAvdg1daxK17l2iqXlu7DfxMPH6Qjoixw+E4CpTSL1hbiY/GtP/h
 BltFiUZTRCBV42gRpYbiX8XECUh6XS18v5IpMXOoJkT/kb7d1suvaiVkd+H8lElDBV/5
 7y42KaFDlO8tXoFWevVPgrbwg2oIqZmI0Y6y6zZpZC2Yf6nUAFdWaeeUzW/q5TKmHH5t
 O6t0O8BX+FZNtDdh6cyCiLykbdXY6mf2S7K2C6lV1AkhtUV8XlT/ZL1lnsnQCpeLOH+8
 tK2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9bxRQqMlctFbzjLEs/YOt6Z19yPTVgQmqpjvbPeKn/Tgvcd1jPWwsWJ7SPe4iJgkkfY/r58wpNo8d@nongnu.org
X-Gm-Message-State: AOJu0YylwjqyppQYdDaiB2jSPNlIuCkh8Xv1yU/aXKVrWBLMJzF6e2TC
 zpnqbnrYGumV14z35aqr6hBF32QGsVRUvWNqnQFfVrQNH0giuU4B
X-Gm-Gg: ASbGncsOclnvFKo6OwTOz4kq1JzOIxr0uoaw5wifccm4ooyqMMTj1hsZe5rKsprHzNG
 q14q0y2CzzMPlCOlIjdRtbfzw0002gFbXRuhu1UJePe1aHBrUGNZet+sXQuDI9XS0YA11S58F03
 +GNFxRYwAwIIPg7MZBUY6MdLAaPUz10aeBFUMK3i/9NrPo9CLPlkUqCArUZ2bzGyLsWsxup9uQe
 M9Q9r9XKrhMYxa5MSkgrJw53XttmAlbTpYGQQDXwkmC9uafoojDUOawHeNhmDem5GSB8xTUcKHD
 Dt48TUo1pJWYCoevoB7KtLMwp03ZlbfSe/oWZ1GCAN0mitieoRYg5Q==
X-Google-Smtp-Source: AGHT+IFUaeLCR5mv7hoNh6dldAJPqYSPzN+W6bqmHYW9L25s1jeSCN+FjD6dP2AvtGJYll2Pl2KYAQ==
X-Received: by 2002:a17:90b:51cb:b0:2fe:861b:1ae3 with SMTP id
 98e67ed59e1d1-306af7178cemr5903910a91.8.1743897159999; 
 Sat, 05 Apr 2025 16:52:39 -0700 (PDT)
Received: from queen.. ([2604:3d08:7485:e900:5b0d:511e:2265:c0aa])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057ca1f778sm6940189a91.2.2025.04.05.16.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 16:52:39 -0700 (PDT)
From: Pinku Deb Nath <prantoran@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Pinku Deb Nath <prantoran@gmail.com>
Subject: [PATCH v5] block/file-posix.c: Use pwritev2() with RWF_DSYNC for FUA
Date: Sat,  5 Apr 2025 16:52:29 -0700
Message-ID: <20250405235229.215582-1-prantoran@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=prantoran@gmail.com; helo=mail-pj1-x102e.google.com
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
index 56d1972d15..59bed7866a 100644
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
+qemu_pwritev_fua(int fd, struct iovec *iov, int nr_iov, off_t offset, const RawPosixAIOData *aiocb)
+{
+#ifdef RWF_DSYNC
+    return pwritev2(fd, iov, nr_iov, offset, RWF_DSYNC);
+#else
+    ssize_t len = pwritev2(fd, iov, nr_iov, offset, 0);
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


