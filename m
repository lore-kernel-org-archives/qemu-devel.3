Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9AE606A32E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LdB+uXmQ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=heSa9BkV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Gy-0001VU-Vx; Wed, 28 Oct 2026 13:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7G3-0008NT-88
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7G0-0003rY-RX
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/4+nVuF1n+7w5mLhhi4CBpEK3+OESC4r67fDjlzbe2c=;
 b=LdB+uXmQgcrBLL0/w0pfExZQ7MTJec31bBqAScao7MzTgpBMLLTtvffYNQolHzjguvSalt
 ZUOBxNN/INWdPCfJ5lvxmw/zEBVimgrUIZCqwj4cqvDpe+T/dqDWBCj2KVdmu8UJSM8HIo
 ycuRF7cDjcqZ6m5AmQ0NAd9XZm4KOVc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-AquWZ5u6MBKztrO0XK4Jbg-1; Wed, 28 Oct 2026 13:16:10 -0400
X-MC-Unique: AquWZ5u6MBKztrO0XK4Jbg-1
X-Mimecast-MFC-AGG-ID: AquWZ5u6MBKztrO0XK4Jbg_1793207769
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48e00f3929bso1386637f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207769; x=1793812569; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/4+nVuF1n+7w5mLhhi4CBpEK3+OESC4r67fDjlzbe2c=;
 b=heSa9BkVxF0lee9ZGxWER3VXAPvsLmygU91y42C9yWLXYFfAZp7gZjUjgg1d40Gak6
 ub4TF5REZLiqlrKDXbkVF+ZhWNDGy1NWMhAcKu6SRRjvpd5Ix7BRPqkJvFVN1zkBAT2M
 68PFM+eX4Vj5DOZb78o4Tu1rsZe3IWTjZ3wcci+ib74OpJVUniWBJsQYJbMscALJrSIW
 Ol2PCb6hppTJIBORaTD6A7yazc9vwov+zvCwV3cYjpZFRRlwoL+Nt/G8Pnia0O+KycPv
 lJvofoxc4fNS9ZzOTWv7y36YURNXZZj+B7ZOCZEjkvq/I7oK7GlyW7IXZ76whyd/muS1
 rtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207769; x=1793812569;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/4+nVuF1n+7w5mLhhi4CBpEK3+OESC4r67fDjlzbe2c=;
 b=BZ90Idi2jxuEz5puCchtMmkKhz08JwtFRaaZxvd41p5Xggc/a6OY+G0wN3XAwfDc3P
 nlG3d7aRFqJ6LA2D9F2gF+497GnPntAF8c+H20jRky9wQaEpOBMRDqMqWsaYmV63WIJe
 wVz5zElyr3qcH47nZHwELms+OIT6MHC7BTZDTQBMlgfhCRMJzRnT0Xz+Li9nivdb77ai
 udacwZdoVNdRBXUTeNlbMKr8OllIPZPfqlfuFPlc6rWhihZx17Wb3pIu1qMPqoeYrdX7
 5x/JsGW9cVwZGVYC3rJUimx3NaVqMfBTg06tmwomjPreqD+V/HCjf/iBbwKgB5q/P6Kv
 +MEw==
X-Gm-Message-State: AFq9FYKpScjR0/BZttBC7d2kTqJdvlpEoDH/0ZpNNg50BUXyfTbdikcp
 O9wwF9kJN0rR+RsMQdqDxtC9WjqKQVFazhgeqtWOeTsGwibAGhZ64lVZodGa5Ux5VsMINRadCQ2
 OSbDPfQ6vMMaxIFj3Nle+GF5Fr4bmNqGvlnTFnJyKZjOwEv+BqERcNBrOUqbBZW594oAY8Cw8Qm
 WS6HoB0qqoW8vj36y0+RvbmvZHrPT+NFtJEQ==
X-Gm-Gg: AYBFou2aVqPo1L35FKk0llhehIkRwTSq+IdUcrMdNqgSCT/GdCsSYGcoheVqVLTm0ns
 s9pOVCQYF5yxgTBP2Mk8rtXogycjZ8t8wjhZC/QMfm8AXYG5H4gT+g3atEoiCK/nsMLGlWueIi1
 XUD+QUDnmunFEBcwoI1wZBT9spTgaLV8vEG77fWeH2cs10sQASg0JuQuF57jGv7DT0U2XZvrLKs
 31nAKu5UlEm5dRJIBS6yqPUoUUoGXq9a5+9jTmNPCtTslwrHFkRTDbqzTA2Vq2EJ+HGR7QRxnCZ
 /wENAvp1zUr+vbFVfGFV0AvI8p87QLCz7J/Zc6B+bOcCC1U7tiviwaOI0aB4X9EnIPq9xMj5Ef1
 dBBViIJ5+W+77ab4ma/HACXmuvAvJRfYahb50btN5
X-Received: by 2002:a5d:6f0e:0:b0:48e:850:c0b7 with SMTP id
 ffacd0b85a97d-48e64945980mr488370f8f.1.1793207769252; 
 Wed, 28 Oct 2026 10:16:09 -0700 (PDT)
X-Received: by 2002:a5d:6f0e:0:b0:48e:850:c0b7 with SMTP id
 ffacd0b85a97d-48e64945980mr488275f8f.1.1793207768578; 
 Wed, 28 Oct 2026 10:16:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3705sm35316129f8f.45.2026.10.28.10.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:07 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 49/78] util/event_notifier: more strict API
Message-ID: <05f5ab90ea52b0151958fd2506c15858e3e80442.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We have .initialized in EventNotifier to track was it actually
initialized, and we have a comment that @fd passed to
event_notifier_init_fd() must be an eventfd object.

Still, there are two specific users, which ignore these things,
and use -1 as specific value storing in notifier, to mark it
"uninitialized".

Let's make strict API:

- store only valid FDs in initialized notifier
- _set() asserts that passed fd is valid
- _get() asserts that notifier is initialized (actually, except
  the two specific cases we rework, all other callers are not
  prepared to notifier being uninitialized when _get() is called.
  In this case _get() returns 0 (which is a valid fd), and caller
  will mistakenly use it, which is worse than abort())
- for two specific cases, implement additional getter for .initialized
  field itself
- zeroed notifier is uninitialized(.initialized is false)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260911185800.134135-1-vsementsov@yandex-team.ru>
---
 include/qemu/event_notifier.h      |  1 +
 hw/remote/iohub.c                  | 11 +++++-----
 hw/virtio/vhost-shadow-virtqueue.c | 32 +++++++++++++++++-------------
 util/event_notifier-posix.c        | 10 ++++++++++
 4 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/include/qemu/event_notifier.h b/include/qemu/event_notifier.h
index 8a4ff308e1..820efe7722 100644
--- a/include/qemu/event_notifier.h
+++ b/include/qemu/event_notifier.h
@@ -39,6 +39,7 @@ int event_notifier_test_and_clear(EventNotifier *);
 void event_notifier_init_fd(EventNotifier *, int fd);
 int event_notifier_get_fd(const EventNotifier *);
 int event_notifier_get_wfd(const EventNotifier *);
+bool event_notifier_initialized(const EventNotifier *e);
 #else
 HANDLE event_notifier_get_handle(EventNotifier *);
 #endif
diff --git a/hw/remote/iohub.c b/hw/remote/iohub.c
index 988d3285cc..ab698d9f03 100644
--- a/hw/remote/iohub.c
+++ b/hw/remote/iohub.c
@@ -28,8 +28,6 @@ void remote_iohub_init(RemoteIOHubState *iohub)
     for (pirq = 0; pirq < REMOTE_IOHUB_NB_PIRQS; pirq++) {
         qemu_mutex_init(&iohub->irq_level_lock[pirq]);
         iohub->irq_level[pirq] = 0;
-        event_notifier_init_fd(&iohub->irqfds[pirq], -1);
-        event_notifier_init_fd(&iohub->resamplefds[pirq], -1);
     }
 }
 
@@ -85,9 +83,12 @@ void process_set_irqfd_msg(PCIDevice *pci_dev, MPQemuMsg *msg)
 
     pirq = remote_iohub_map_irq(pci_dev, intx);
 
-    if (event_notifier_get_fd(&iohub->irqfds[pirq]) != -1) {
-        qemu_set_fd_handler(event_notifier_get_fd(&iohub->resamplefds[pirq]),
-                            NULL, NULL, NULL);
+    if (event_notifier_initialized(&iohub->irqfds[pirq])) {
+        if (event_notifier_initialized(&iohub->resamplefds[pirq])) {
+            qemu_set_fd_handler(
+                event_notifier_get_fd(&iohub->resamplefds[pirq]),
+                NULL, NULL, NULL);
+        }
         event_notifier_cleanup(&iohub->irqfds[pirq]);
         event_notifier_cleanup(&iohub->resamplefds[pirq]);
         memset(&iohub->token[pirq], 0, sizeof(ResampleToken));
diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 0fae35ba1a..c97bd9f93f 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -751,6 +751,15 @@ static void vhost_svq_handle_call(EventNotifier *n)
     vhost_svq_flush(svq, true);
 }
 
+static void event_notifier_set_or_zero(EventNotifier *e, int fd)
+{
+    if (fd == VHOST_FILE_UNBIND) {
+        memset(e, 0, sizeof(*e));
+    } else {
+        event_notifier_init_fd(e, fd);
+    }
+}
+
 /**
  * Set the call notifier for the SVQ to call the guest
  *
@@ -761,17 +770,13 @@ static void vhost_svq_handle_call(EventNotifier *n)
  */
 void vhost_svq_set_svq_call_fd(VhostShadowVirtqueue *svq, int call_fd)
 {
-    if (call_fd == VHOST_FILE_UNBIND) {
-        /*
-         * Fail event_notifier_set if called handling device call.
-         *
-         * SVQ still needs device notifications, since it needs to keep
-         * forwarding used buffers even with the unbind.
-         */
-        memset(&svq->svq_call, 0, sizeof(svq->svq_call));
-    } else {
-        event_notifier_init_fd(&svq->svq_call, call_fd);
-    }
+    /*
+     * Fail event_notifier_set if called handling device call.
+     *
+     * SVQ still needs device notifications, since it needs to keep
+     * forwarding used buffers even with the unbind.
+     */
+    event_notifier_set_or_zero(&svq->svq_call, call_fd);
 }
 
 /**
@@ -814,14 +819,14 @@ size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq)
 void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_fd)
 {
     EventNotifier *svq_kick = &svq->svq_kick;
-    bool poll_stop = VHOST_FILE_UNBIND != event_notifier_get_fd(svq_kick);
+    bool poll_stop = event_notifier_initialized(svq_kick);
     bool poll_start = svq_kick_fd != VHOST_FILE_UNBIND;
 
     if (poll_stop) {
         event_notifier_set_handler(svq_kick, NULL);
     }
 
-    event_notifier_init_fd(svq_kick, svq_kick_fd);
+    event_notifier_set_or_zero(&svq->svq_kick, svq_kick_fd);
     /*
      * event_notifier_set_handler already checks for guest's notifications if
      * they arrive at the new file descriptor in the switch, so there is no
@@ -928,7 +933,6 @@ VhostShadowVirtqueue *vhost_svq_new(const VhostShadowVirtqueueOps *ops,
 {
     VhostShadowVirtqueue *svq = g_new0(VhostShadowVirtqueue, 1);
 
-    event_notifier_init_fd(&svq->svq_kick, VHOST_FILE_UNBIND);
     svq->ops = ops;
     svq->ops_opaque = ops_opaque;
     return svq;
diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
index 83fdbb96bb..f595945af7 100644
--- a/util/event_notifier-posix.c
+++ b/util/event_notifier-posix.c
@@ -27,6 +27,7 @@
  */
 void event_notifier_init_fd(EventNotifier *e, int fd)
 {
+    assert(fd >= 0);
     e->rfd = fd;
     e->wfd = fd;
     e->initialized = true;
@@ -96,14 +97,23 @@ void event_notifier_cleanup(EventNotifier *e)
 
 int event_notifier_get_fd(const EventNotifier *e)
 {
+    assert(e->initialized);
+    assert(e->rfd >= 0);
     return e->rfd;
 }
 
 int event_notifier_get_wfd(const EventNotifier *e)
 {
+    assert(e->initialized);
+    assert(e->wfd >= 0);
     return e->wfd;
 }
 
+bool event_notifier_initialized(const EventNotifier *e)
+{
+    return e->initialized;
+}
+
 int event_notifier_set(EventNotifier *e)
 {
     static const uint64_t value = 1;
-- 
MST


