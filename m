Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBC8C88E42
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4tQ2-0006I1-O3; Fri, 11 Sep 2026 01:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oss.patchbox@gmail.com>)
 id 1x4mQq-00025M-TF
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 17:38:32 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oss.patchbox@gmail.com>)
 id 1x4mQl-0005qW-Hp
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 17:35:42 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-92edb12cdf2so13395185a.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 14:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789076136; x=1789680936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fYkt7DD91S7eXg1jKSZt1wKCwqOy7up5oCafkVxbKYQ=;
 b=JI+L03iVoQipQFJk6ZdcIDLVR17ZhBTWH61NAia7ro0AU7TRAStNXns8Mu8+JegkDj
 7Y7SHrdxDRR4/7VuYEK2QNyXCYk09C94mgkG4VUpaEA13v/rn1ng5kobXlAgSeM5CDfE
 MjJoap5nkxkmFWh9Fq4BH6PKRUxS2hTdZT68wg15PKbo9m3MWC3/wQOpAiHxMcu86+6A
 hVJubB68kU9psbA6TBOdMQ/03sPC+kouxMfpM8HDuVpkMsBFDD3DyYBn6AReFUPCXGGI
 WYaMynpzkHlXPxiDOfiWYkUDL09av4HU71D+BUydln7E1taAEGzEr1LJ6lizGzt2wsM7
 eCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789076136; x=1789680936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fYkt7DD91S7eXg1jKSZt1wKCwqOy7up5oCafkVxbKYQ=;
 b=lFR9MWc3S+OuebM+O5ldgggyOFALph5SPtp6eTot9HJC75ff+jG7N41i+geIH1AFJ9
 iFWuB0dvpPPKeoRBEPKS96eJdu/EcpNap4Uir2XoRcK07DPteXwODpLIoDS/an4XqpVl
 Sc+916SvXQrLPgDTZ2zXkzGvYYElC2Q2gN5c2mUNyCOYZMSnLh9PbjpI8DZGk/OuhHv+
 zqhf8NpEEYGE82lUvQ5UVlgz6B+B+ew7Dn8w9dhsd1hT01Tu48o0rCMyKA+K9Y9W3kfv
 VzfvXj98jj9UDrC2fwdOum/twEyuUafUYC+CCiJF0SrTS33Gevo8k8K46Db3qViJfIcU
 CLPg==
X-Gm-Message-State: AFuF++mdbNb68dBfIOUxy77Ls5nkw+7l66myYX2oosXuWz4aWUXbCaJ7
 5Ofe0N3vZQBig5CLewlaXRPokPJVepwYawLsUJ5KOOsswJYMJcccCAso2+pWXLwxkjU=
X-Gm-Gg: AYBFou1XlJ9OYAkEMFTOfe/tDi36IPnVXS26ZrXR1cCxiYYwvjnSl2pxGi8cFqHwbTV
 WuJ/yKIsBQhQetlKhvOlzv1/zeiWE6wpW4dMth7sbNuMH5mrJFhBV1XVpWgAKaCMDyOqrTrInc9
 v2So03dXkceXRoBSL6Wqa2ZgK/8BAxnRjtZ2mh0r4Dobb86gaUvW8Zos+qw3tPFXrv6ANjtIdQe
 S31ROJwvCap7dO8ZAxlfmbkopHandzyAIl2Lmztm9KYyIjREJw96QvYJ3WtxxKqY4qTNsR3Dgno
 dnveOMTUPLSpDRAtWxU76JEN0qSnsBEhU45yelYw+/ryYyM4ug5Ag9dy0Exep21xBgoon3bd0T+
 MrROr/lMV7jGCCXsrXVdNlylO5IGPMirokxsjbeMNvC1arCIXMns3YGLle2FIT+oRge9oQQ13sr
 2kLg4oPcg2ugpNKg198bqV9HrBRzvD7JKWcBm0ic+uIeStqjeMjGGVknWdXE0Bx04XUfDpJoTXW
 A==
X-Received: by 2002:a05:620a:390f:b0:939:cb1a:2c59 with SMTP id
 af79cd13be357-939ea149d34mr134313785a.22.1789076135344; 
 Thu, 10 Sep 2026 14:35:35 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939e80471a3sm79432185a.22.2026.09.10.14.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 14:35:34 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
X-Google-Original-From: Yuho Choi <dbgh9129@gmail.com>
To: qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, thanos.makatos@nutanix.com, clg@redhat.com,
 qemu-stable@nongnu.org, Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] vfio-user: propagate DMA map/unmap request errors
Date: Thu, 10 Sep 2026 17:35:26 -0400
Message-ID: <20260910213526.1472467-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=oss.patchbox@gmail.com; helo=mail-qk1-x733.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 11 Sep 2026 01:03:12 -0400
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

From: Yuho Choi <oss.patchbox@gmail.com>

vfio_user_wait_reqs() uses the youngest nowait request as an ordering
fence, but error replies for older requests are logged and recycled. An
error reply or timeout for the youngest request is also only logged. The
memory listener therefore commits even when QEMU and the server may
disagree about DMA mappings.

Preserve the first error from each nowait batch and return it to the
listener commit callback. Propagate failures during listener registration
so device realization fails cleanly. After initialization, report the
error and stop with hw_error(), matching the existing VFIO DMA mapping
failure policy.

The memory listener commit callback cannot roll back a FlatView that has
already advanced. Treat listener teardown the same way: until the proxy is
disconnected, a failed unmap leaves the server's DMA access unconfirmed.
Stopping QEMU avoids continued execution with inconsistent DMA state.

Add unit coverage for an older failed request followed by a successful
youngest fence, a timeout, and an all-success batch.

Fixes: 18e899e63dd9 ("vfio-user: implement VFIO_USER_DMA_MAP/UNMAP")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 MAINTAINERS                       |   1 +
 hw/vfio-user/container.c          |  18 ++-
 hw/vfio-user/proxy.c              |  89 +++++++++---
 hw/vfio-user/proxy.h              |   3 +-
 tests/unit/meson.build            |   8 ++
 tests/unit/test-vfio-user-proxy.c | 222 ++++++++++++++++++++++++++++++
 6 files changed, 320 insertions(+), 21 deletions(-)
 create mode 100644 tests/unit/test-vfio-user-proxy.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7183babd6aa..10516ee4213 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4582,6 +4582,7 @@ F: docs/system/devices/vfio-user.rst
 F: hw/vfio-user/*
 F: subprojects/libvfio-user.wrap
 F: tests/functional/x86_64/test_vfio_user_client.py
+F: tests/unit/test-vfio-user-proxy.c
 
 EBPF
 M: Jason Wang <jasowangio@gmail.com>
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index dc23b06eebf..95f0e922d65 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -10,6 +10,7 @@
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
 
+#include "hw/core/hw-error.h"
 #include "hw/vfio-user/container.h"
 #include "hw/vfio-user/device.h"
 #include "hw/vfio-user/trace.h"
@@ -33,10 +34,25 @@ static void vfio_user_listener_begin(VFIOContainer *bcontainer)
 static void vfio_user_listener_commit(VFIOContainer *bcontainer)
 {
     VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
+    Error *local_err = NULL;
 
     /* wait here for any async requests sent during the transaction */
     container->proxy->async_ops = false;
-    vfio_user_wait_reqs(container->proxy);
+    if (vfio_user_wait_reqs(container->proxy, &local_err)) {
+        return;
+    }
+
+    error_prepend(&local_err, "vfio-user DMA mapping transaction failed: ");
+    if (!bcontainer->initialized) {
+        if (!bcontainer->error) {
+            error_propagate(&bcontainer->error, local_err);
+        } else {
+            error_free(local_err);
+        }
+    } else {
+        error_report_err(local_err);
+        hw_error("vfio-user: DMA mapping failed, unable to continue");
+    }
 }
 
 static int vfio_user_dma_unmap(const VFIOContainer *bcontainer,
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 197aee07bf7..d43ddde7a0b 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -52,6 +52,26 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy)
                                    proxy->ctx, NULL, NULL);
 }
 
+static void vfio_user_record_nowait_error(VFIOUserProxy *proxy,
+                                           const Error *err)
+{
+    if (proxy->nowait_error == NULL) {
+        proxy->nowait_error = error_copy(err);
+    }
+}
+
+static void vfio_user_record_nowait_reply_error(VFIOUserProxy *proxy,
+                                                 const VFIOUserMsg *msg)
+{
+    if (proxy->nowait_error == NULL) {
+        int error = msg->hdr->error_reply ?: EIO;
+
+        error_setg_errno(&proxy->nowait_error, error,
+                         "vfio-user command 0x%x failed",
+                         msg->hdr->command);
+    }
+}
+
 /*
  * Same return values as qio_channel_writev_full():
  *
@@ -162,10 +182,14 @@ static void vfio_user_process(VFIOUserProxy *proxy, VFIOUserMsg *msg)
             qemu_cond_signal(&msg->cv);
         } else {
             if (msg->hdr->flags & VFIO_USER_ERROR) {
-                error_printf("vfio_user_process: error reply on async ");
-                error_printf("request command %x error %s\n",
-                             msg->hdr->command,
-                             strerror(msg->hdr->error_reply));
+                if (msg->type == VFIO_MSG_NOWAIT) {
+                    vfio_user_record_nowait_reply_error(proxy, msg);
+                } else {
+                    error_printf("vfio_user_process: error reply on async ");
+                    error_printf("request command %x error %s\n",
+                                 msg->hdr->command,
+                                 strerror(msg->hdr->error_reply));
+                }
             }
             /* youngest nowait msg has been ack'd */
             if (proxy->last_nowait == msg) {
@@ -426,7 +450,15 @@ err:
              */
             vfio_user_set_error(msg->hdr, EINVAL);
             msg->complete = true;
-            qemu_cond_signal(&msg->cv);
+            if (msg->type == VFIO_MSG_NOWAIT) {
+                vfio_user_record_nowait_reply_error(proxy, msg);
+                if (proxy->last_nowait == msg) {
+                    proxy->last_nowait = NULL;
+                }
+                vfio_user_recycle(proxy, msg);
+            } else {
+                qemu_cond_signal(&msg->cv);
+            }
         }
     }
     return -1;
@@ -669,6 +701,7 @@ static bool vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg,
 bool vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                            VFIOUserFDs *fds, int rsize, Error **errp)
 {
+    Error *local_err = NULL;
     VFIOUserMsg *msg;
 
     QEMU_LOCK_GUARD(&proxy->lock);
@@ -679,12 +712,17 @@ bool vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
     msg->type = VFIO_MSG_NOWAIT;
 
     if (hdr->flags & VFIO_USER_NO_REPLY) {
-        error_setg_errno(errp, EINVAL, "%s on NO_REPLY message", __func__);
+        error_setg_errno(&local_err, EINVAL,
+                         "%s on NO_REPLY message", __func__);
+        vfio_user_record_nowait_error(proxy, local_err);
+        error_propagate(errp, local_err);
         vfio_user_recycle(proxy, msg);
         return false;
     }
 
-    if (!vfio_user_send_queued(proxy, msg, errp)) {
+    if (!vfio_user_send_queued(proxy, msg, &local_err)) {
+        vfio_user_record_nowait_error(proxy, local_err);
+        error_propagate(errp, local_err);
         vfio_user_recycle(proxy, msg);
         return false;
     }
@@ -777,21 +815,24 @@ bool vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
     return true;
 }
 
-void vfio_user_wait_reqs(VFIOUserProxy *proxy)
+/*
+ * Wait for completion of the current nowait batch.  DMA map/unmap requests
+ * sent during a memory transaction are nowait requests.  The server processes
+ * commands in receive order, so the youngest reply is a completion fence for
+ * all older requests.  Errors from older replies are saved until the fence is
+ * reached.
+ */
+bool vfio_user_wait_reqs(VFIOUserProxy *proxy, Error **errp)
 {
-    VFIOUserMsg *msg;
+    bool success = true;
 
-    /*
-     * Any DMA map/unmap requests sent in the middle
-     * of a memory region transaction were sent nowait.
-     * Wait for them here.
-     */
     qemu_mutex_lock(&proxy->lock);
     if (proxy->last_nowait != NULL) {
+        VFIOUserMsg *msg = proxy->last_nowait;
+
         /*
          * Change type to WAIT to wait for reply
          */
-        msg = proxy->last_nowait;
         msg->type = VFIO_MSG_WAIT;
         proxy->last_nowait = NULL;
         while (!msg->complete) {
@@ -801,15 +842,16 @@ void vfio_user_wait_reqs(VFIOUserProxy *proxy)
 
                 list = msg->pending ? &proxy->pending : &proxy->outgoing;
                 QTAILQ_REMOVE(list, msg, next);
-                error_printf("vfio_wait_reqs - timed out\n");
+                if (proxy->nowait_error == NULL) {
+                    error_setg_errno(&proxy->nowait_error, ETIMEDOUT,
+                                     "timed out waiting for vfio-user reply");
+                }
                 break;
             }
         }
 
         if (msg->hdr->flags & VFIO_USER_ERROR) {
-            error_printf("vfio_user_wait_reqs - error reply on async ");
-            error_printf("request: command %x error %s\n", msg->hdr->command,
-                         strerror(msg->hdr->error_reply));
+            vfio_user_record_nowait_reply_error(proxy, msg);
         }
 
         /*
@@ -819,7 +861,15 @@ void vfio_user_wait_reqs(VFIOUserProxy *proxy)
         vfio_user_recycle(proxy, msg);
     }
 
+    if (proxy->nowait_error != NULL) {
+        error_propagate(errp, proxy->nowait_error);
+        proxy->nowait_error = NULL;
+        success = false;
+    }
+
     qemu_mutex_unlock(&proxy->lock);
+
+    return success;
 }
 
 /*
@@ -1018,6 +1068,7 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
 
     /* we now hold the only ref to proxy */
     qemu_mutex_unlock(&proxy->lock);
+    error_free(proxy->nowait_error);
     qemu_cond_destroy(&proxy->close_cv);
     qemu_mutex_destroy(&proxy->lock);
 
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 7b97460cc50..e8021c9f952 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -83,6 +83,7 @@ typedef struct VFIOUserProxy {
     VFIOUserMsgQ incoming;
     VFIOUserMsgQ outgoing;
     VFIOUserMsg *last_nowait;
+    Error *nowait_error;
     VFIOUserMsg *part_recv;
     size_t recv_left;
     VFIOUserWRMulti *wr_multi;
@@ -116,7 +117,7 @@ void vfio_user_disable_posted_writes(VFIOUserProxy *proxy);
 
 void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
                            uint32_t size, uint32_t flags);
-void vfio_user_wait_reqs(VFIOUserProxy *proxy);
+bool vfio_user_wait_reqs(VFIOUserProxy *proxy, Error **errp);
 bool vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize, Error **errp);
 bool vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index e47bc7225ab..146ab38a923 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -148,6 +148,14 @@ if have_system
       genh, qemuutil, qom
     ],
   }
+  if host_os == 'linux'
+    tests += {
+      'test-vfio-user-proxy': [
+        'iothread.c', io,
+        meson.project_source_root() / 'hw/vfio-user/proxy.c',
+      ],
+    }
+  endif
   if config_host_data.get('CONFIG_INOTIFY1')
     tests += {'test-util-filemonitor': []}
   endif
diff --git a/tests/unit/test-vfio-user-proxy.c b/tests/unit/test-vfio-user-proxy.c
new file mode 100644
index 00000000000..c46025e974e
--- /dev/null
+++ b/tests/unit/test-vfio-user-proxy.c
@@ -0,0 +1,222 @@
+/*
+ * vfio-user proxy tests
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include <glib/gstdio.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include "hw/vfio/vfio-device.h"
+#include "hw/vfio-user/proxy.h"
+#include "qapi/error.h"
+#include "qemu/cutils.h"
+#include "qemu/main-loop.h"
+#include "qemu/module.h"
+#include "qemu/sockets.h"
+#include "system/iothread.h"
+#include "iothread.h"
+
+typedef enum TestReplyMode {
+    TEST_REPLY_SUCCESS,
+    TEST_REPLY_PRIOR_ERROR,
+    TEST_REPLY_TIMEOUT,
+} TestReplyMode;
+
+typedef struct TestServer {
+    char *tmpdir;
+    char *path;
+    int listen_fd;
+    TestReplyMode reply_mode;
+    GThread *thread;
+} TestServer;
+
+IOThread *iothread_create(const char *id, Error **errp)
+{
+    (void)id;
+    (void)errp;
+    return iothread_new();
+}
+
+void iothread_destroy(IOThread *iothread)
+{
+    iothread_join(iothread);
+}
+
+static void read_all(int fd, void *buf, size_t len)
+{
+    char *p = buf;
+
+    while (len) {
+        ssize_t ret = read(fd, p, len);
+
+        if (ret < 0 && errno == EINTR) {
+            continue;
+        }
+        g_assert_cmpint(ret, >, 0);
+        p += ret;
+        len -= ret;
+    }
+}
+
+static void write_all(int fd, const void *buf, size_t len)
+{
+    const char *p = buf;
+
+    while (len) {
+        ssize_t ret = write(fd, p, len);
+
+        if (ret < 0 && errno == EINTR) {
+            continue;
+        }
+        g_assert_cmpint(ret, >, 0);
+        p += ret;
+        len -= ret;
+    }
+}
+
+static gpointer test_server_thread(gpointer opaque)
+{
+    TestServer *server = opaque;
+    int conn_fd;
+    int i;
+
+    do {
+        conn_fd = accept(server->listen_fd, NULL, NULL);
+    } while (conn_fd < 0 && errno == EINTR);
+    g_assert_cmpint(conn_fd, >=, 0);
+
+    for (i = 0; i < 2; i++) {
+        VFIOUserHdr request;
+        VFIOUserHdr reply;
+
+        read_all(conn_fd, &request, sizeof(request));
+        g_assert_cmpuint(request.size, ==, sizeof(request));
+
+        reply = request;
+        reply.size = sizeof(reply);
+        reply.flags = VFIO_USER_REPLY;
+        reply.error_reply = 0;
+        if (i == 0 && server->reply_mode == TEST_REPLY_PRIOR_ERROR) {
+            reply.flags |= VFIO_USER_ERROR;
+            reply.error_reply = EIO;
+        }
+        if (server->reply_mode != TEST_REPLY_TIMEOUT) {
+            write_all(conn_fd, &reply, sizeof(reply));
+        }
+    }
+
+    while (read(conn_fd, &i, sizeof(i)) < 0 && errno == EINTR) {
+        ;
+    }
+
+    close(conn_fd);
+    return NULL;
+}
+
+static void test_server_start(TestServer *server, TestReplyMode reply_mode)
+{
+    struct sockaddr_un addr = { .sun_family = AF_UNIX };
+
+    server->tmpdir = g_dir_make_tmp("qemu-test-vfio-user.XXXXXX", NULL);
+    g_assert_nonnull(server->tmpdir);
+    server->path = g_build_filename(server->tmpdir, "socket", NULL);
+    g_assert_cmpuint(strlen(server->path), <, sizeof(addr.sun_path));
+    pstrcpy(addr.sun_path, sizeof(addr.sun_path), server->path);
+
+    server->listen_fd = socket(AF_UNIX, SOCK_STREAM, 0);
+    g_assert_cmpint(server->listen_fd, >=, 0);
+    g_assert_no_errno(bind(server->listen_fd, (struct sockaddr *)&addr,
+                           sizeof(addr)));
+    g_assert_no_errno(listen(server->listen_fd, 1));
+
+    server->reply_mode = reply_mode;
+    server->thread = g_thread_new("vfio-user-test-server",
+                                  test_server_thread, server);
+}
+
+static void test_server_stop(TestServer *server)
+{
+    g_thread_join(server->thread);
+    close(server->listen_fd);
+    g_assert_cmpint(g_unlink(server->path), ==, 0);
+    g_assert_cmpint(g_rmdir(server->tmpdir), ==, 0);
+    g_free(server->path);
+    g_free(server->tmpdir);
+}
+
+static void unexpected_request(void *opaque, VFIOUserMsg *msg)
+{
+    (void)opaque;
+    (void)msg;
+    g_assert_not_reached();
+}
+
+static void send_nowait(VFIOUserProxy *proxy)
+{
+    VFIOUserHdr *hdr = g_new0(VFIOUserHdr, 1);
+
+    vfio_user_request_msg(hdr, VFIO_USER_DMA_UNMAP, sizeof(*hdr), 0);
+    g_assert_true(vfio_user_send_nowait(proxy, hdr, NULL, 0, &error_abort));
+}
+
+static void test_nowait_replies(gconstpointer opaque)
+{
+    TestReplyMode reply_mode = GPOINTER_TO_INT(opaque);
+    TestServer server = { 0 };
+    SocketAddress addr = { .type = SOCKET_ADDRESS_TYPE_UNIX };
+    VFIOUserProxy *proxy;
+    VFIODevice vbasedev = { 0 };
+    Error *err = NULL;
+
+    test_server_start(&server, reply_mode);
+    addr.u.q_unix.path = server.path;
+
+    proxy = vfio_user_connect_dev(&addr, &error_abort);
+    proxy->wait_time = reply_mode == TEST_REPLY_TIMEOUT ? 50 : 5000;
+    vbasedev.proxy = proxy;
+    vfio_user_set_handler(&vbasedev, unexpected_request, NULL);
+
+    send_nowait(proxy);
+    send_nowait(proxy);
+
+    if (reply_mode == TEST_REPLY_PRIOR_ERROR) {
+        g_assert_false(vfio_user_wait_reqs(proxy, &err));
+        g_assert_nonnull(err);
+        g_assert_nonnull(strstr(error_get_pretty(err), strerror(EIO)));
+        error_free(err);
+    } else if (reply_mode == TEST_REPLY_TIMEOUT) {
+        g_assert_false(vfio_user_wait_reqs(proxy, &err));
+        g_assert_nonnull(err);
+        g_assert_nonnull(strstr(error_get_pretty(err), "timed out"));
+        error_free(err);
+    } else {
+        g_assert_true(vfio_user_wait_reqs(proxy, &err));
+        g_assert_null(err);
+    }
+
+    vfio_user_disconnect(proxy);
+    test_server_stop(&server);
+}
+
+int main(int argc, char **argv)
+{
+    module_call_init(MODULE_INIT_QOM);
+    qemu_init_main_loop(&error_abort);
+    socket_init();
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_data_func("/vfio-user/proxy/nowait/prior-error",
+                         GINT_TO_POINTER(TEST_REPLY_PRIOR_ERROR),
+                         test_nowait_replies);
+    g_test_add_data_func("/vfio-user/proxy/nowait/timeout",
+                         GINT_TO_POINTER(TEST_REPLY_TIMEOUT),
+                         test_nowait_replies);
+    g_test_add_data_func("/vfio-user/proxy/nowait/success",
+                         GINT_TO_POINTER(TEST_REPLY_SUCCESS),
+                         test_nowait_replies);
+
+    return g_test_run();
+}
-- 
2.43.0


