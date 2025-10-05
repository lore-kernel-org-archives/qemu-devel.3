Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B9ECAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UDg-0007Rf-S8; Sun, 05 Oct 2025 15:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDV-0007Qp-Ex
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDT-0006LY-Ie
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SHoGkBd1TLD0drMrg57V42M4WtKetbvg9QyJe5+quVA=;
 b=enJ4d7HlBXMQdyJ6TCJMdaNWZ+9a2t+iX/Rs+LaeqrMSPIYqu7l38cfF7xIaAujpMgM1QP
 7R7rTQnj750Ubk9Ev7wTVxATzP99mT0PkU8aYpk678em4vnEcwoRfQ43BgcqhIVa6DJdSS
 kHcITlRWHYX7mrdJP9n6vLMfxrofTIU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-_G5q818VPku01xaWhWiGmQ-1; Sun, 05 Oct 2025 15:16:16 -0400
X-MC-Unique: _G5q818VPku01xaWhWiGmQ-1
X-Mimecast-MFC-AGG-ID: _G5q818VPku01xaWhWiGmQ_1759691776
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ecdd80ea44so2979708f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691775; x=1760296575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHoGkBd1TLD0drMrg57V42M4WtKetbvg9QyJe5+quVA=;
 b=scre/1IblHZwCdclEe5UV1gacjAWetkNBEc9P4nttqjMD1hoNr2VL35hg+bFJZ6xC9
 FJvyhIzD3SS4FVoWPc1h3d9dE0EGVN1AhbOpgMLgKf6YnUkfDc0c04i1Vxe8+wsuIlnL
 eT8eHk4XyKCfc+sCUbbAYNRTx3oD1kHlB0yhCFLktMz28OAraQu2riSGD1FfMre4TbNi
 w3D2avNjIystMQhQ7oOO8qPOgitVs2nC1VUUVkQfcqm33gomLVGHsWV7KdQm11Xn1CAj
 nrEOY/Gl+3iZg0jLc/1NuIK3gEHUwHPwipJ0vIQ0OMjbMR9+m29SgFzjjF3W+mSccMJp
 lzKg==
X-Gm-Message-State: AOJu0Yz1alqAsALOqqSgV2xUugumcYHwbVuOn4xYi5SIuXaQKmTsKY+7
 3EeeBWUHqs7Fa8G25batNj/pej6XMPmg0elzq/q5ONrzcENeeN0wk+bvri3wND5y13wrQye+2/y
 H7OABpiVPtO9NrYeUjFVs4IV98RaBdzNzj72hSdO3Hr8jG3e/wnxMpKMJWaYuZUfh7EovnQ0fTG
 UmxyDzwKttCY1GJ4wPwkW74GUwzvdr4n4Alw==
X-Gm-Gg: ASbGncuvGnN/JEn8+UaU80YDaCK22nIsZT55KfIdL4XtU82VD1fUJkpgJMTA83gD51u
 7p5Kf8zYmvbql6OkiN0rFRiMJIYZ4KJ7Kz7+TMfraAVawhIlFyC2GsEdN3RBUHaNVRoXuVe2YP7
 LvtsSrqVl210LXbegjgaEoxZ0kiL4EDHfUfsbbaLReeqytqIK+5j0fHoMYJ6HeupsslgoOb6hbh
 PMvQTcXfb4agsw/BiyUH7mx288/ec7ixoPyWC3C4gXlxYSOrH9Orp8TZ8fOz2OjBpWD3ioiPnMr
 HzZzTAKHxkgP9d2/VbS5GLz6OOPIxwRnH0Kd/mA=
X-Received: by 2002:a05:6000:2303:b0:401:ae97:a1ab with SMTP id
 ffacd0b85a97d-42566c0cb9fmr7741150f8f.10.1759691775187; 
 Sun, 05 Oct 2025 12:16:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL3qv77mJxwODQWdwHDFHPTrBRsqOo14oFf2LwqnJfkdsa/dTsrcMqaFNQ68enIl1DOQZ+zQ==
X-Received: by 2002:a05:6000:2303:b0:401:ae97:a1ab with SMTP id
 ffacd0b85a97d-42566c0cb9fmr7741131f8f.10.1759691774613; 
 Sun, 05 Oct 2025 12:16:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6bbesm17264105f8f.12.2025.10.05.12.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:16:14 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Abeni <pabeni@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Subject: [PULL 05/75] virtio: serialize extended features state
Message-ID: <0a49a97433279512a03f3d9f36164a46caf498c6.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Abeni <pabeni@redhat.com>

If the driver uses any of the extended features (i.e. 64 or above),
store the extended features range (64-127 bits).

At load time, let legacy features initialize the full features range
and pass it to the set helper; sub-states loading will have filled-up
the extended part as needed.

This is one of the few spots that need explicitly to know and set
in stone the extended features array size; add a build bug to prevent
breaking the migration should such size change again in the future:
more serialization plumbing will be needed.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <d5d9d398675bee6c4c7d7308c5d3d5d3c6d17d87.1758549625.git.pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 88 ++++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9a81ad912e..bf53c211e5 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2964,6 +2964,30 @@ static const VMStateDescription vmstate_virtio_disabled = {
     }
 };
 
+static bool virtio_128bit_features_needed(void *opaque)
+{
+    VirtIODevice *vdev = opaque;
+
+    return virtio_features_use_ex(vdev->host_features_ex);
+}
+
+static const VMStateDescription vmstate_virtio_128bit_features = {
+    .name = "virtio/128bit_features",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = &virtio_128bit_features_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(guest_features_ex[1], VirtIODevice),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+/*
+ * Avoid silently breaking migration should the feature space increase
+ * even more in the (far away) future
+ */
+QEMU_BUILD_BUG_ON(VIRTIO_FEATURES_NU64S != 2);
+
 static const VMStateDescription vmstate_virtio = {
     .name = "virtio",
     .version_id = 1,
@@ -2973,6 +2997,7 @@ static const VMStateDescription vmstate_virtio = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_virtio_device_endian,
+        &vmstate_virtio_128bit_features,
         &vmstate_virtio_64bit_features,
         &vmstate_virtio_virtqueues,
         &vmstate_virtio_ringsize,
@@ -3069,23 +3094,28 @@ const VMStateInfo  virtio_vmstate_info = {
     .put = virtio_device_put,
 };
 
-static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val)
+static int virtio_set_features_nocheck(VirtIODevice *vdev, const uint64_t *val)
 {
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
-    bool bad = (val & ~(vdev->host_features)) != 0;
+    uint64_t tmp[VIRTIO_FEATURES_NU64S];
+    bool bad;
+
+    bad = virtio_features_andnot(tmp, val, vdev->host_features_ex);
+    virtio_features_and(tmp, val, vdev->host_features_ex);
 
-    val &= vdev->host_features;
     if (k->set_features) {
-        k->set_features(vdev, val);
+        bad = bad || virtio_features_use_ex(tmp);
+        k->set_features(vdev, tmp[0]);
     }
-    vdev->guest_features = val;
+
+    virtio_features_copy(vdev->guest_features_ex, tmp);
     return bad ? -1 : 0;
 }
 
 typedef struct VirtioSetFeaturesNocheckData {
     Coroutine *co;
     VirtIODevice *vdev;
-    uint64_t val;
+    uint64_t val[VIRTIO_FEATURES_NU64S];
     int ret;
 } VirtioSetFeaturesNocheckData;
 
@@ -3098,14 +3128,15 @@ static void virtio_set_features_nocheck_bh(void *opaque)
 }
 
 static int coroutine_mixed_fn
-virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev, uint64_t val)
+virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev,
+                                     const uint64_t *val)
 {
     if (qemu_in_coroutine()) {
         VirtioSetFeaturesNocheckData data = {
             .co = qemu_coroutine_self(),
             .vdev = vdev,
-            .val = val,
         };
+        virtio_features_copy(data.val, val);
         aio_bh_schedule_oneshot(qemu_get_current_aio_context(),
                                 virtio_set_features_nocheck_bh, &data);
         qemu_coroutine_yield();
@@ -3117,6 +3148,7 @@ virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev, uint64_t val)
 
 int virtio_set_features(VirtIODevice *vdev, uint64_t val)
 {
+    uint64_t features[VIRTIO_FEATURES_NU64S];
     int ret;
     /*
      * The driver must not attempt to set features after feature negotiation
@@ -3132,7 +3164,8 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
                       __func__, vdev->name);
     }
 
-    ret = virtio_set_features_nocheck(vdev, val);
+    virtio_features_from_u64(features, val);
+    ret = virtio_set_features_nocheck(vdev, features);
     if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
         /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
         int i;
@@ -3155,6 +3188,7 @@ void virtio_reset(void *opaque)
 {
     VirtIODevice *vdev = opaque;
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    uint64_t features[VIRTIO_FEATURES_NU64S];
     int i;
 
     virtio_set_status(vdev, 0);
@@ -3181,7 +3215,8 @@ void virtio_reset(void *opaque)
     vdev->start_on_kick = false;
     vdev->started = false;
     vdev->broken = false;
-    virtio_set_features_nocheck(vdev, 0);
+    virtio_features_clear(features);
+    virtio_set_features_nocheck(vdev, features);
     vdev->queue_sel = 0;
     vdev->status = 0;
     vdev->disabled = false;
@@ -3264,7 +3299,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
      * Note: devices should always test host features in future - don't create
      * new dependencies like this.
      */
-    vdev->guest_features = features;
+    virtio_features_from_u64(vdev->guest_features_ex, features);
 
     config_len = qemu_get_be32(f);
 
@@ -3343,26 +3378,17 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         vdev->device_endian = virtio_default_endian();
     }
 
-    if (virtio_64bit_features_needed(vdev)) {
-        /*
-         * Subsection load filled vdev->guest_features.  Run them
-         * through virtio_set_features to sanity-check them against
-         * host_features.
-         */
-        uint64_t features64 = vdev->guest_features;
-        if (virtio_set_features_nocheck_maybe_co(vdev, features64) < 0) {
-            error_report("Features 0x%" PRIx64 " unsupported. "
-                         "Allowed features: 0x%" PRIx64,
-                         features64, vdev->host_features);
-            return -1;
-        }
-    } else {
-        if (virtio_set_features_nocheck_maybe_co(vdev, features) < 0) {
-            error_report("Features 0x%x unsupported. "
-                         "Allowed features: 0x%" PRIx64,
-                         features, vdev->host_features);
-            return -1;
-        }
+    /*
+     * guest_features_ex is fully initialized with u32 features and upper
+     * bits have been filled as needed by the later load.
+     */
+    if (virtio_set_features_nocheck_maybe_co(vdev,
+                                             vdev->guest_features_ex) < 0) {
+        error_report("Features 0x" VIRTIO_FEATURES_FMT " unsupported. "
+                     "Allowed features: 0x" VIRTIO_FEATURES_FMT,
+                     VIRTIO_FEATURES_PR(vdev->guest_features_ex),
+                     VIRTIO_FEATURES_PR(vdev->host_features_ex));
+        return -1;
     }
 
     if (!virtio_device_started(vdev, vdev->status) &&
-- 
MST


