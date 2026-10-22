Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E155606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=as8MVZhv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJt9p-00017O-MP; Thu, 22 Oct 2026 09:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xJt9R-0000SP-K4
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:48:18 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xJt9L-00056T-0L
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:48:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a2001dd4e7so20120825e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 06:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792676881; x=1793281681; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uCO4jWd/GCl+BQESy4pd/ThUis2N7ZU3bVWGeRHDfMM=;
 b=as8MVZhvsA4ddgBGhW/aocwesRrfK8ZkW9hvl2xNWt7Or4mmKfVAtIL3Vzj+qR7EPG
 f9HP80eAi86lqr+d0HDzftf2wgPvBa19JlnVsT/2Z+kiItZetVBy4tDX8A96BzoWvjbd
 7EsV6TNLN9nqv9egn2sSahkuwmEwmlv4ABQ55si/uaviWg7BmchZx0ykoQ+P7sqJ/kuP
 IYyIVvrCPw+X4SVV8OSDYB7gvpW49D1k+SOLcJ12Spj88aT7s2vVRXLt0HgpghbB0VbL
 VQJ1h5j5Vwhn74QcQo5WAnxWGRM16eXtqvAKjkMJ/FpF/hIx+82guEef973s5ubjRRJk
 vdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792676881; x=1793281681;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uCO4jWd/GCl+BQESy4pd/ThUis2N7ZU3bVWGeRHDfMM=;
 b=hsSC6swnBOZ449zO9QfxhOi63aNn1qd25g03SosInlrsj11MBK01o6LfXIwfcxHlKH
 Lf0fwcPeRxNQUmNHfdGtp6i/svLBRaNPdhC6+PJQ82wix+JeE6jF411vP0JOc4jjyLMf
 7+Ym1We8ctoBCCpeWLm+JF9inDdcn6Mm9iWi/fqO5oog19s46EbaoZi1fKc6p91u8+R2
 SY8Tx9ryA+7MwIc8f/x9fPTuLZ6xTsgeBUodOg0XHPfkUOfUXL1v9ToFsNV93r/dhVJc
 soGv8yAtwBpSJ7ywJEsppPWRQn5m/DnGFWERdtM+74t/oA5auD2hpqNTx8XllbTHOZXB
 6kxA==
X-Gm-Message-State: AFq9FYLctJCCQS1cQadox2SvdjYPq9iUNMYwPSpHLWY1OrcszTk0o3ET
 1OYSNus89j3Z+a2VjDf6Ti48st6ad8O9BHcM3woqgES9kNH6BhN7GkHU
X-Gm-Gg: AYBFou3Zx0LICmE8yVNVEUXdptAEky+x3ete9DH/+9bhAwDOmQy8wba+fdFHSLHKd6P
 Nwg11BI9Nve+g7Mn36r6bhc/Kb9xmzBO4pKDH+0Bp51cyfZlpuJKG8pPVQvTK/xU9rH1jFndPrV
 pdlyhf7RMEpmzTbAGRfhyPuhj4Fmkblb2kqDijeB8CRCu3ZHJtEmh1GsPn6nkONANZSJbTYoDob
 qZRYAqZqMz7vk7xQrERbWnZ+gcYcLIxfIWXmRh2fZNUNcDWyvbwhEGxOAaWDyYgS3rAkcnzdc6U
 BS3c2ZfTyYTq8743gXA7Yzg2e/9pkQ/0Pv9FnocNx1Uhw1tzGUaQUbAuBhquWWsR3JOp2l0KQOd
 4CC03aKjgiL/OTcWIobob/BlEKHhcgpGevsxPX7h+QwT+kPgR+pGNt4xaG4dHIwDTgI/FaNZO0t
 9Ni6TYsuxvoJFZw6SWC96t324XdSl2tCUdKtvaDR7WuYa7LljogtabYflUNdElvadJz5MrtItvM
 zXxISWgDpZcpCaSQUhj0KEjKnaGgRSfsrEB3DGDTkPBRHAIoxcotZpLkZrypUHXHvU+jGqVDlR4
 NY9nRRTYc9HjJNFaggQQgrcDN4jnLyl7ZdUTPcWbWVbCqrLw3GXPQceZBP9ZSiEbpdTkt1SBLkJ
 KEh3LOxZgFw==
X-Received: by 2002:a05:6000:2612:b0:48e:7fb:aed3 with SMTP id
 ffacd0b85a97d-48e264a5a5bmr11307183f8f.17.1792676881121; 
 Thu, 22 Oct 2026 06:48:01 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-5a78-7100-00df-217a-667a-8b0a.310.pool.telefonica.de.
 [2a02:3100:5a78:7100:df:217a:667a:8b0a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254ef1bfsm13120414f8f.6.2026.10.22.06.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:48:00 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Thu, 22 Oct 2026 15:47:23 +0200
Subject: [PATCH 2/8] libvhost-user: self-kick through a library-owned notifier
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-vhost-user-posix-v1-2-0bd4d450d23c@gmail.com>
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
In-Reply-To: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-block@nongnu.org, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Brad Smith <brad@comstyle.com>, 
 Tim Pambor <timpambor@gmail.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=timpambor@gmail.com; helo=mail-wm1-x32b.google.com
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

When a ring is started, it may already hold requests: ones the driver
queued while the back-end was away and ones the previous instance left
in flight. The spec says front-ends SHOULD send a kick after
SET_VRING_KICK and back-ends SHOULD NOT rely on it, so libvhost-user
kicks itself by writing to the kick fd it has received from the
front-end. With an eventfd that fd is writable, but when pipes are used
it is the read end and the write fails.

Replace it with a notifier the library owns. vu_init() creates it, the
embedder watches its read end through set_watch() like a kick fd, and
the library writes it when a started ring has available entries or
in-flight requests to resubmit. The watch callback drains it and runs
the handler of every queue flagged kick_pending. This way the handler
still runs from the event loop after the reply to SET_VRING_KICK has
gone out, as with the kick-fd self-kick.

Signed-off-by: Tim Pambor <timpambor@gmail.com>
---
 subprojects/libvhost-user/libvhost-user.c | 145 +++++++++++++++++++++++++++---
 subprojects/libvhost-user/libvhost-user.h |  10 +++
 2 files changed, 141 insertions(+), 14 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 2fed792e85..e323e32cab 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -23,6 +23,7 @@
 #include <unistd.h>
 #include <stdarg.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <string.h>
 #include <assert.h>
 #include <inttypes.h>
@@ -40,7 +41,6 @@
 
 #if defined(__linux__)
 #include <sys/syscall.h>
-#include <fcntl.h>
 #include <sys/ioctl.h>
 #include <linux/vhost.h>
 #include <sys/vfs.h>
@@ -1305,6 +1305,7 @@ vu_get_vring_base_exec(VuDev *dev, VhostUserMsg *vmsg)
     vmsg->size = sizeof(vmsg->payload.state);
 
     dev->vq[index].started = false;
+    dev->vq[index].kick_pending = false;
     if (dev->iface->queue_set_started) {
         dev->iface->queue_set_started(dev, index, false);
     }
@@ -1440,6 +1441,121 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
     return 0;
 }
 
+static bool
+vu_self_kick_init(VuDev *dev)
+{
+#ifdef CONFIG_EVENTFD
+    int fd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
+
+    if (fd < 0) {
+        return false;
+    }
+
+    dev->self_kick_rfd = dev->self_kick_wfd = fd;
+#else
+    int fds[2];
+    int i;
+
+    if (pipe(fds) < 0) {
+        return false;
+    }
+
+    for (i = 0; i < 2; i++) {
+        int flags = fcntl(fds[i], F_GETFL);
+
+        if (flags < 0 ||
+            fcntl(fds[i], F_SETFL, flags | O_NONBLOCK) < 0 ||
+            fcntl(fds[i], F_SETFD, FD_CLOEXEC) < 0) {
+            close(fds[0]);
+            close(fds[1]);
+            return false;
+        }
+    }
+
+    dev->self_kick_rfd = fds[0];
+    dev->self_kick_wfd = fds[1];
+#endif
+
+    return true;
+}
+
+static void
+vu_self_kick_deinit(VuDev *dev)
+{
+    if (dev->self_kick_watched) {
+        dev->remove_watch(dev, dev->self_kick_rfd);
+        dev->self_kick_watched = false;
+    }
+
+    if (dev->self_kick_wfd != -1 && dev->self_kick_wfd != dev->self_kick_rfd) {
+        close(dev->self_kick_wfd);
+    }
+
+    if (dev->self_kick_rfd != -1) {
+        close(dev->self_kick_rfd);
+    }
+
+    dev->self_kick_rfd = dev->self_kick_wfd = -1;
+}
+
+static void
+vu_self_kick_cb(VuDev *dev, int condition, void *data)
+{
+    eventfd_t value;
+    unsigned int i;
+
+    while (eventfd_read(dev->self_kick_rfd, &value) == 0) {
+        continue;
+    }
+
+    for (i = 0; i < dev->max_queues; i++) {
+        VuVirtq *vq = &dev->vq[i];
+
+        if (!vq->kick_pending) {
+            continue;
+        }
+        vq->kick_pending = false;
+
+        DPRINT("Running handler for pending requests on vq: %u\n", i);
+        if (vq->handler) {
+            vq->handler(dev, i);
+        }
+    }
+}
+
+static void
+vu_schedule_pending_requests(VuDev *dev, int index)
+{
+    VuVirtq *vq = &dev->vq[index];
+    int ret;
+
+    if (!vq->handler) {
+        return;
+    }
+
+    if (vq->resubmit_num == 0 && vu_queue_empty(dev, vq)) {
+        return;
+    }
+
+    DPRINT("Scheduling pending requests on vq: %d (resubmit: %d)\n",
+           index, vq->resubmit_num);
+    vq->kick_pending = true;
+
+    if (!dev->self_kick_watched) {
+        dev->set_watch(dev, dev->self_kick_rfd, VU_WATCH_IN,
+                       vu_self_kick_cb, NULL);
+        dev->self_kick_watched = true;
+    }
+
+    ret = eventfd_write(dev->self_kick_wfd, 1);
+
+    /* EAGAIN: the notifier is already pending, which is all we need */
+    if (ret < 0 && errno != EAGAIN) {
+        vu_panic(dev, "Failed to kick ourselves for vq: %d: %s\n",
+                 index, strerror(errno));
+    }
+}
+
 static bool
 vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -1478,19 +1594,7 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
         vu_panic(dev, "Failed to check inflights for vq: %d\n", index);
     }
 
-    /* Inject a kick to look for available vq buffers */
-    if (dev->vq[index].kick_fd != -1) {
-        int ret;
-
-        do {
-            ret = eventfd_write(dev->vq[index].kick_fd, 1);
-        } while (ret != 0 && errno == EINTR);
-
-        if (ret != 0 && errno != EAGAIN /* already readable */) {
-            vu_panic(dev, "Failed to inject kick during SET_VRING_KICK "
-                     "on vq: %d with error: %m\n", index);
-        }
-    }
+    vu_schedule_pending_requests(dev, index);
 
     return false;
 }
@@ -1509,6 +1613,10 @@ void vu_set_queue_handler(VuDev *dev, VuVirtq *vq,
             dev->remove_watch(dev, vq->kick_fd);
         }
     }
+
+    if (handler && vq->started) {
+        vu_schedule_pending_requests(dev, qidx);
+    }
 }
 
 bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
@@ -2379,6 +2487,7 @@ vu_deinit(VuDev *dev)
     }
 
     vu_close_log(dev);
+    vu_self_kick_deinit(dev);
     if (dev->backend_fd != -1) {
         close(dev->backend_fd);
         dev->backend_fd = -1;
@@ -2426,10 +2535,17 @@ vu_init(VuDev *dev,
     pthread_mutex_init(&dev->backend_mutex, NULL);
     dev->backend_fd = -1;
     dev->max_queues = max_queues;
+    dev->self_kick_rfd = dev->self_kick_wfd = -1;
+
+    if (!vu_self_kick_init(dev)) {
+        DPRINT("%s: failed to create the self-kick notifier\n", __func__);
+        return false;
+    }
 
     dev->regions = malloc(VHOST_USER_MAX_RAM_SLOTS * sizeof(dev->regions[0]));
     if (!dev->regions) {
         DPRINT("%s: failed to malloc mem regions\n", __func__);
+        vu_self_kick_deinit(dev);
         return false;
     }
 
@@ -2438,6 +2554,7 @@ vu_init(VuDev *dev,
         DPRINT("%s: failed to malloc virtqueues\n", __func__);
         free(dev->regions);
         dev->regions = NULL;
+        vu_self_kick_deinit(dev);
         return false;
     }
 
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index a534d70771..ddd5cbb90e 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -392,6 +392,7 @@ typedef struct VuVirtq {
     int err_fd;
     unsigned int enable;
     bool started;
+    bool kick_pending;
 
     /* Guest addresses of our ring */
     struct vhost_vring_addr vra;
@@ -471,6 +472,15 @@ struct VuDev {
     /* Postcopy data */
     int postcopy_ufd;
     bool postcopy_listening;
+
+    /*
+     * Notifier owned by the library, used to run queue handlers from the
+     * event loop when a ring is started with requests already pending.
+     * Either the same eventfd on both sides or the two ends of a pipe.
+     */
+    int self_kick_rfd;
+    int self_kick_wfd;
+    bool self_kick_watched;
 };
 
 typedef struct VuVirtqElement {

-- 
2.55.0


