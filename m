Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242DFC3DA45
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 11:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRVR6-0008Vp-IS; Wed, 10 Jul 2024 07:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sRVR3-0008V6-Qx
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 07:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sRVR1-0005ql-Qd
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 07:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720610670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zJo5e/BrLfOsarDZ4d3gQo8/j7R+MYdNJBn7lF9aR2k=;
 b=C2U5R1drKRsMKY27ljkdUWUNko982xMxiWy69cJNPTCuuKx+96o42CBbbpXrGY5nBj0aON
 SPdyzRENWsE72xeG352Er6w49d86nY7NYMa7tqUXsjFw3sYX6oDzz/ik+QkC3f43VT1INS
 U5AUXMcs5yLLSnXfd6UNhn9VmjK9Rl8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-1AZHT_9zPyCqFW8iQ6MdRA-1; Wed, 10 Jul 2024 07:23:20 -0400
X-MC-Unique: 1AZHT_9zPyCqFW8iQ6MdRA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-58b1cfea1f4so5749645a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 04:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720610598; x=1721215398;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zJo5e/BrLfOsarDZ4d3gQo8/j7R+MYdNJBn7lF9aR2k=;
 b=lKr0IJnNDZC404oekGnXSUOjSptpiZZOFYWUuc7MzxgMGOAcr3iGkl/ARe6AA8cIAb
 G38SGKUFo1IGHdu5sRnvyYbOLzbK9ozzXOdFOIfDfwZuvnlZkKAXmo+AlMqDK65BLYuA
 3j6eXw4ziIijDtyddsjVsqssI9BLJ44U1rQelkM9XqjU5jMvUtQQn3zVyhBMoPfjzHVT
 Js5OVnFsdWdj8DZwvLcuTJpNtIGric7/JwRzlIxttdfcOC9TwJZIFfqWVo6TuhUi+N2Z
 N9wQ5wmz+L7GAQWih2Zdto/MQxIOcgr8d+LxhV5SWftZ5CNh4v6hub+fdbZWlQYf6/vS
 s9/A==
X-Gm-Message-State: AOJu0Yxlq5UfcmmEiEEO3eaW3zRH+RHEg5bDGo87ToBEIqgkPXJLQB9c
 a0B7YvqYHWaO82oZi/UeYwhIt1icQisjTspZkUSnPVrlsKsGzdvbYnePLzXis4l1OCOSV4nmXRv
 Ft2FIqXpUvheUTGJU0QC096akg3BwAAHbwMUdCYjwglB5qBe/xL/VfnCN8O5WUKcgxbf6+WLcvH
 ssOpCJZeauNT9WsfF+9RLCr+YIdPYyBdyBMg==
X-Received: by 2002:a05:6402:27d4:b0:595:698b:c4d4 with SMTP id
 4fb4d7f45d1cf-595698bc620mr2995964a12.25.1720610598596; 
 Wed, 10 Jul 2024 04:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZfMOdnJT2YJ6QDdAVI8Wmhx3zWbXiu2vVZCknqkJSWjEdvXclrEmHqi0yjxjWVFa50iFaJA==
X-Received: by 2002:a05:6402:27d4:b0:595:698b:c4d4 with SMTP id
 4fb4d7f45d1cf-595698bc620mr2995939a12.25.1720610597954; 
 Wed, 10 Jul 2024 04:23:17 -0700 (PDT)
Received: from localhost
 (p200300cfd74b1ce0c033e72e9d5ff8c4.dip0.t-ipconnect.de.
 [2003:cf:d74b:1ce0:c033:e72e:9d5f:f8c4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-594bb9605dcsm2114098a12.6.2024.07.10.04.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 04:23:17 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio: Always reset vhost devices
Date: Wed, 10 Jul 2024 13:23:10 +0200
Message-ID: <20240710112310.316551-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Requiring `vhost_started` to be true for resetting vhost devices in
`virtio_reset()` seems like the wrong condition: Most importantly, the
preceding `virtio_set_status(vdev, 0)` call will (for vhost devices) end
up in `vhost_dev_stop()` (through vhost devices' `.set_status`
implementations), setting `vdev->vhost_started = false`.  Therefore, the
gated `vhost_reset_device()` call is unreachable.

`vhost_started` is not documented, so it is hard to say what exactly it
is supposed to mean, but judging from the fact that `vhost_dev_start()`
sets it and `vhost_dev_stop()` clears it, it seems like it indicates
whether there is a vhost back-end, and whether that back-end is
currently running and processing virtio requests.

Making a reset conditional on whether the vhost back-end is processing
virtio requests seems wrong; in fact, it is probably better to reset it
only when it is not currently processing requests, which is exactly the
current order of operations in `virtio_reset()`: First, the back-end is
stopped through `virtio_set_status(vdev, 0)`, then we want to send a
reset.

Therefore, we should drop the `vhost_started` condition, but in its
stead we then have to verify that we can indeed send a reset to this
vhost device, by not just checking `k->get_vhost != NULL` (introduced by
commit 95e1019a4a9), but also that the vhost back-end is connected
(`hdev = k->get_vhost(); hdev != NULL && hdev->vhost_ops != NULL`).

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/virtio/virtio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 893a072c9d..4410d62126 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2146,8 +2146,12 @@ void virtio_reset(void *opaque)
         vdev->device_endian = virtio_default_endian();
     }
 
-    if (vdev->vhost_started && k->get_vhost) {
-        vhost_reset_device(k->get_vhost(vdev));
+    if (k->get_vhost) {
+        struct vhost_dev *hdev = k->get_vhost(vdev);
+        /* Only reset when vhost back-end is connected */
+        if (hdev && hdev->vhost_ops) {
+            vhost_reset_device(hdev);
+        }
     }
 
     if (k->reset) {
-- 
2.45.2


