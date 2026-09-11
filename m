Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A12C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xBg-0000US-4Q; Fri, 11 Sep 2026 05:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xBL-0007kD-4c
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:04:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4xBJ-0008Vm-1x
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NJG8zAQc5H+oCN0LN3glhJqYJbaYPku/Yu37P8u17zg=;
 b=MDzxfVhjRq8WrNHVmBugnqKdlmjQqr9OfbPkywG1oWRequb0/ERbt4aoUKbRZcRiqTiovd
 kgoVQ05CQZdwV/9OecMTWWJsZ3J1QPteubA4DCLE0BuGtpMnOpAzMAYJO+Xff3PSadTOCy
 aKmq43Cir2yLSkx6EmIvHsbLgavd/5s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-jzHfd-BBMZeH-sqfdtINyg-1; Fri, 11 Sep 2026 05:04:23 -0400
X-MC-Unique: jzHfd-BBMZeH-sqfdtINyg-1
X-Mimecast-MFC-AGG-ID: jzHfd-BBMZeH-sqfdtINyg_1789117462
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49953abe51fso3685665e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117462; x=1789722262; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NJG8zAQc5H+oCN0LN3glhJqYJbaYPku/Yu37P8u17zg=;
 b=i2gV/hX14I6JijnCIXHm4bygsklWA3/qeBMh2sBlZ4CBFDSlCeT6QwkZPNRQSByHza
 9Fd6wVVDlHsO9z7qlKP+ek0OfW54Aoe9n/HIt01fCK8w29hCapBbZem4vya7TQ7xq9Bf
 G7adD9Clh0eFUgYPsMp88FdzfHIdYcLHiuDsLJyDRwZp2IHAdKomsJz4SByIKXWNE4Y8
 ZxjoZi2D5pEyvb4VM4/OGHflJFv6lqYOvWWPeQGi4G/fDUG1reBLKku0l2pleLTc+Ko2
 qeLnV+zT45SDpmvpEwhVJk9p92qLl7DIqP0sEhE5aypue5yzKclgOV88AnWQ0fERLnOx
 zyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117462; x=1789722262;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NJG8zAQc5H+oCN0LN3glhJqYJbaYPku/Yu37P8u17zg=;
 b=VsYtUCUg/SbVBBzvobI2rlAaHkS8J3cOPoTidAeKbO0wzNHHB4vApiXquSKCdQrYyQ
 lvCfenx88ZUoXCOfoqeFvMnmKOTdZnBgqiSeWGict0s+FPTlVzgIX/4tZ1IcQR3n2yTl
 9CZikH3dp2Y3izUUZHvFBIHHLr5/1ws46VlufjjesqP3nsoEqFb7JPDsSqx4rfZmg1i9
 ANqa4IzFvcEY1c3ZBRFa7hkyXmeUJ8t1vHZ38t7YKswlRgZSqGa+oPC1eUJZ9VouHC1a
 czaFxrh18uzeVgOwgOLjlqnoO9AA4scvAds7fPHF3JWnG5syY7ZI+QEPBCPEaytA0yPu
 71Dw==
X-Gm-Message-State: AFuF++nfMbzT3QbBFrq52+T7Mns7jA5Ke0yhu6FbzYeSCeWrG8b/XgQc
 01mmGwf7tUG5/lHWlVZ3p7CnECTy4boAodmY4q+vA+M8FWBKKHRmGZJsxdzOpqf1YKns/ezBSis
 nrDNYZBicf4qmrwJg60xbEmZQgC96dVq9vWSiL2DYFzaNF5wSR7zvnSGPWTmApx3moHzmP9IuTv
 7LmFBKW47zi0KUWfytdxvXDNuCKdPg03QR+Q==
X-Gm-Gg: AYBFou0hI8hmm2SwSiiMKkV53l6zET6++V9Z9OzldBzXR/N8gBiuaUw5mcyga3BYELA
 4+ypEjODi8o/v0p9E+scWHsPQv5VUgv/nuT/ODwQ7AJ3gMfcwAosuGWo+b/5haOKcLZSQbl0iiU
 5jfuou/c9QKtvHTJ7nF3Z/jj+HVbF2ZoyydinEp2+QfWkpf78mM4h65hE9JjlGuKHr5P8uyu6ly
 awsNhD6Rd7FJN87xigSBBxgWu/lezsCL3FdLgx5eHe0TXK3a0wYom88hDXrVL+f9Hi3xDpjMMZG
 zeA33lwJ8eEQ3KzNM4YTpoDFCJ5pCmkqo/+g/KOjnG79tfkknyd18Fg09nPsA7LnqqSyFNyqEFW
 HXTLMMNduAKSw5WhQPSNkFys=
X-Received: by 2002:a05:600c:c490:b0:49c:fc6c:bdfa with SMTP id
 5b1f17b1804b1-49e619e1cf0mr31565225e9.17.1789117461949; 
 Fri, 11 Sep 2026 02:04:21 -0700 (PDT)
X-Received: by 2002:a05:600c:c490:b0:49c:fc6c:bdfa with SMTP id
 5b1f17b1804b1-49e619e1cf0mr31564545e9.17.1789117461355; 
 Fri, 11 Sep 2026 02:04:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49db038401fsm128804265e9.13.2026.09.11.02.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:04:20 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:04:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL v2 74/75] vhost-user-blk: use GET_VRING_BASE_SKIP_DRAIN when
 inflight-migration is on
Message-ID: <684fbddb62362a910aa0251624ba0f692048c906.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

Currently during live migration vhost-user-blk sends GET_VRING_BASE to
stop vrings, which causes the back-end to drain all in-flight I/O before
returning. This blocks the migration source until all I/O completes,
adding significant downtime proportional to the I/O load.

When inflight-migration is enabled, send GET_VRING_BASE_SKIP_DRAIN
instead. This instructs the back-end to immediately suspend in-flight
I/O and record it in the shared inflight region, which is then migrated
to the destination host along with the rest of the device state.

Since inflight-migration can only be toggled while the VM is running,
i2ts value at stop time reliably reflects the intent set on a live VM.
There is no need to check migration runstate to decide whether to skip
draining. Using GET_VRING_BASE_SKIP_DRAIN on a regular VM stop is
safe - the back-end records any in-flight requests in the shared
inflight region, and they will be resubmitted when the VM starts again
via SET_INFLIGHT_FD.

If the back-end does not support
VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN,
migration is aborted with an error in pre_save rather than hitting an
assert at runtime.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260803072853.2920007-7-dtalexundeer@yandex-team.ru>
---
 include/hw/virtio/vhost-user.h |  1 -
 hw/block/vhost-user-blk.c      | 29 +++++++++++++++++++++++------
 hw/virtio/vhost-user.c         |  3 +--
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 47c13f8677..78b4fba27f 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -73,7 +73,6 @@ typedef struct VhostUserState {
     GPtrArray *notifiers;
     int memory_slots;
     bool supports_config;
-    bool supports_inflight_migration;
 } VhostUserState;
 
 /**
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 3eaaa19719..3dade143c9 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -141,10 +141,7 @@ static bool vhost_user_blk_inflight_needed(void *opaque)
 {
     struct VHostUserBlk *s = opaque;
 
-    bool inflight_migration = virtio_has_feature(s->dev.protocol_features,
-                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
-
-    return inflight_migration;
+    return s->inflight_migration;
 }
 
 
@@ -245,11 +242,13 @@ static int vhost_user_blk_stop(VirtIODevice *vdev)
         return 0;
     }
 
+    bool skip_drain = vhost_user_blk_inflight_needed(s);
+
     force_stop = s->skip_get_vring_base_on_force_shutdown &&
                  qemu_force_shutdown_requested();
 
     ret = force_stop ? vhost_dev_force_stop(&s->dev, vdev, true) :
-                       vhost_dev_stop(&s->dev, vdev, true, false);
+                       vhost_dev_stop(&s->dev, vdev, true, skip_drain);
 
     err = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
     if (err < 0) {
@@ -381,7 +380,6 @@ static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
     vhost_dev_set_config_notifier(&s->dev, &blk_ops);
 
     s->vhost_user.supports_config = true;
-    s->vhost_user.supports_inflight_migration = s->inflight_migration;
     ret = vhost_dev_init(&s->dev, &s->vhost_user, VHOST_BACKEND_TYPE_USER, 0,
                          errp);
     if (ret < 0) {
@@ -608,10 +606,29 @@ static struct vhost_dev *vhost_user_blk_get_vhost(VirtIODevice *vdev)
     return &s->dev;
 }
 
+static bool vhost_user_blk_pre_save(void *opaque, Error **errp)
+{
+    VHostUserBlk *s = VHOST_USER_BLK(opaque);
+
+    bool inflight_migration_enabled = vhost_user_has_protocol_feature(&s->dev,
+                               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN);
+
+    if (vhost_user_blk_inflight_needed(s) && !inflight_migration_enabled) {
+        error_setg(errp, "can't migrate vhost-user-blk device: "
+                         "backend doesn't support "
+                         "VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN "
+                         "protocol feature");
+        return false;
+    }
+
+    return true;
+}
+
 static const VMStateDescription vmstate_vhost_user_blk_inflight = {
     .name = "vhost-user-blk/inflight",
     .version_id = 1,
     .needed = vhost_user_blk_inflight_needed,
+    .pre_save_errp = vhost_user_blk_pre_save,
     .fields = (const VMStateField[]) {
         VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
         VMSTATE_END_OF_LIST()
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 5fb5d61afb..65889b0776 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2596,8 +2596,7 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
             }
         }
 
-        if (!u->user->supports_inflight_migration ||
-            !virtio_has_feature(protocol_features,
+        if (!virtio_has_feature(protocol_features,
                                 VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
             protocol_features &= ~(1ULL <<
                                VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT);
-- 
MST


