Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BDDC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 18:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x55gS-0005PX-LZ; Fri, 11 Sep 2026 14:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x55gO-0005Od-Ri
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 14:09:04 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x55gL-0000Gf-I3
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 14:09:04 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 7FDACC0B5C;
 Fri, 11 Sep 2026 21:08:59 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:641::1:4])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id u8VTLcTagiE0-BdrIiJBt; Fri, 11 Sep 2026 21:08:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789150139;
 bh=GDufTV9ny9B/lcMIYmpLimUU7/eWy5Qwi37faHkBCJc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=e+vPJ8pdhfpv/YTx3tY1J6o4DIHgYOhfJ1oF3dKDXbavluKd092nVUsXz2IYVa+MZ
 E/M4uKyIkUgcM54VUh44klYCZtgb3tFuiEJyOFdqI8E2gWwHNeeV4nU/v9ys1afNnK
 f6TOHlPai4m6YjiDu75eyL3bBep2d40E52PFFvXw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, eperezma@redhat.com, sgarzare@redhat.com,
 mst@redhat.com, jag.raman@oracle.com, elena.ufimtseva@oracle.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 3/4] vhost: stop set event notifier to -1
Date: Fri, 11 Sep 2026 21:08:53 +0300
Message-ID: <20260911180854.123969-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911180854.123969-1-vsementsov@yandex-team.ru>
References: <20260911180854.123969-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

When notifier is zeroed, it's already "uninitialized", and getter
correctly returns -1. No reason to directly set fd=-1.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-shadow-virtqueue.c | 32 +++++++++++++++++-------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index bcb7f2ffc79..46520549b4f 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -745,6 +745,15 @@ static void vhost_svq_handle_call(EventNotifier *n)
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
@@ -755,17 +764,13 @@ static void vhost_svq_handle_call(EventNotifier *n)
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
@@ -808,14 +813,14 @@ size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq)
 void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_fd)
 {
     EventNotifier *svq_kick = &svq->svq_kick;
-    bool poll_stop = VHOST_FILE_UNBIND != event_notifier_get_fd(svq_kick);
+    bool poll_stop = event_notifier_get_fd(svq_kick) >= 0;
     bool poll_start = svq_kick_fd != VHOST_FILE_UNBIND;
 
     if (poll_stop) {
         event_notifier_set_handler(svq_kick, NULL);
     }
 
-    event_notifier_init_fd(svq_kick, svq_kick_fd);
+    event_notifier_set_or_zero(&svq->svq_kick, svq_kick_fd);
     /*
      * event_notifier_set_handler already checks for guest's notifications if
      * they arrive at the new file descriptor in the switch, so there is no
@@ -922,7 +927,6 @@ VhostShadowVirtqueue *vhost_svq_new(const VhostShadowVirtqueueOps *ops,
 {
     VhostShadowVirtqueue *svq = g_new0(VhostShadowVirtqueue, 1);
 
-    event_notifier_init_fd(&svq->svq_kick, VHOST_FILE_UNBIND);
     svq->ops = ops;
     svq->ops_opaque = ops_opaque;
     return svq;
-- 
2.43.0


