Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207D8C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 07:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2mYF-0000WT-Ed; Thu, 10 Apr 2025 03:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u2mYC-0000Vx-Hp
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 03:42:16 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u2mY9-0004x9-7V
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 03:42:15 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso4990835ad.2
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 00:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1744270931; x=1744875731;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UkQpfw1hDCX4olrPMmH5MMGz1UomU+n/rPKZA38OVuM=;
 b=CD+KmuFPUsQDZN72wSSrZ4/d3NpCUd6QBEpY2UjtGiAP2NMRdL0rKEZTjSPi1nzguB
 uljxyX5BVSs48sQP8j4o5QgewpYQPcdGeSvgC1qmo7X3/qxfzMpjNZ5gKorztRBjKN2C
 EkIuniDIDSRvUg8M0DBQrTdX2Ky3stgvirp/gNZDam3H6IqeSWzfexx3IMnUBe+DRq6B
 p1i+RLVxY1ernvMmMPdW+UR5Eoa42oKFxmNB1mzSBCBdp12uxJ1+yPjDnuIo9UGVkJJ6
 CoqLmvNAVsGTBjFoB/fJcDP85Q7YS2Ks3+R5PXNq5sc+mVA0tSHBu9mihbUKebdkEDBy
 zkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744270931; x=1744875731;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UkQpfw1hDCX4olrPMmH5MMGz1UomU+n/rPKZA38OVuM=;
 b=ksEbWQBSj5CadLQ5AMvkawGP2OW8E1bFnyus0ByHrCjPgmgkUjR0LDDNgBQwid1xYN
 +KFGLKYApFYwXFsLzdJT1h/Yn9rAUi3OikxWTdQH/3X8zFCGq8NvWaf9y77TDUTbA3yD
 BeIKHwFDTrSoXg+FRz4XKvtJ+9o4eISBlONZ5Dcw6ZiPez6HqAvIBACPkViB/Ik/fUgt
 4y84rwydFb4fYyncQmVjPQ/KBOz8nNVV/sfV0gvdyZnC1L7vJl3TiLKBqgAQG8c833c9
 BlBTlSKjCGW4Q9/PFg8Lnzey0LofjlRk3L+iubYAyfVIAYFrIholOaPwnpwHVaCqXsEj
 PVTg==
X-Gm-Message-State: AOJu0YxKNYYzSTpUsEKUZ7N5SU4xPnjLU5C3OGQzLUns1+npXBIl//9A
 /2em+auz16WdDMwLBKgJ0wtusgco73DOgaWaU+87tMve74pip73wKMBI+6ALH/gzl+auaTAHN5w
 WcWE=
X-Gm-Gg: ASbGnctutJNAev2nd2IU7R7CM1ud7Ovx8E1XkQeuBMBkw5jsEudk58c+Y4f9IDN4Gzw
 1v31wYH/Tmv74ZcvDUiY34eZ6oip25kStRhDzvQQuhUtY5NsqGdz2c7NmGQ70tQGG/mH9ACvKY3
 5IPHkkgV6SzVP6bv2Np3HJBxLPB675Q1CqDFUbFJNlOy44p4D4twrkqq/aAvvfaGprkQyELNcr8
 b+UfFgw/twg+0p5Tb6rVeR9xh7B5R3iTBTfZELAJpjIlK6gIrYQaoiW2iFcKUj8xe6swRExad27
 osTZOFrugdTSB5TmSwrzLa+Xz86s+qXCa7PohcgYmgbtQDY=
X-Google-Smtp-Source: AGHT+IF3dFSlSU3Iot0v2IeZdIPc9ENi9AITAGett26HXJrOSV4o5l7oUtZvwoQDhUkgtlMBUVYjyQ==
X-Received: by 2002:a17:903:2343:b0:224:826:279e with SMTP id
 d9443c01a7336-22be03af567mr19253735ad.50.1744270931145; 
 Thu, 10 Apr 2025 00:42:11 -0700 (PDT)
Received: from localhost ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22ac7c971bfsm24028835ad.123.2025.04.10.00.42.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 00:42:10 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 10 Apr 2025 16:42:06 +0900
Subject: [PATCH] virtio: Call set_features during reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-reset-v1-1-751cd0064395@daynix.com>
X-B4-Tracking: v=1; b=H4sIAE1292cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEwMz3aLU4tQSXdPUFFMjE4vUVONkQyWg2oKi1LTMCrA50bG1tQClQ0l
 fVwAAAA==
X-Change-ID: 20250406-reset-5ed5248ee3c1
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, devel@daynix.com, 
 qemu-stable@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

virtio-net expects set_features() will be called when the feature set
used by the guest changes to update the number of virtqueues. Call it
during reset as reset clears all features and the queues added for
VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS will need to be removed.

Fixes: f9d6dbf0bf6e ("virtio-net: remove virtio queues if the guest doesn't support multiqueue")
Buglink: https://issues.redhat.com/browse/RHEL-73842
Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/virtio/virtio.c | 86 +++++++++++++++++++++++++++---------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 85110bce3744..033e87cdd3b9 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2316,49 +2316,6 @@ void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index)
     }
 }
 
-void virtio_reset(void *opaque)
-{
-    VirtIODevice *vdev = opaque;
-    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
-    int i;
-
-    virtio_set_status(vdev, 0);
-    if (current_cpu) {
-        /* Guest initiated reset */
-        vdev->device_endian = virtio_current_cpu_endian();
-    } else {
-        /* System reset */
-        vdev->device_endian = virtio_default_endian();
-    }
-
-    if (k->get_vhost) {
-        struct vhost_dev *hdev = k->get_vhost(vdev);
-        /* Only reset when vhost back-end is connected */
-        if (hdev && hdev->vhost_ops) {
-            vhost_reset_device(hdev);
-        }
-    }
-
-    if (k->reset) {
-        k->reset(vdev);
-    }
-
-    vdev->start_on_kick = false;
-    vdev->started = false;
-    vdev->broken = false;
-    vdev->guest_features = 0;
-    vdev->queue_sel = 0;
-    vdev->status = 0;
-    vdev->disabled = false;
-    qatomic_set(&vdev->isr, 0);
-    vdev->config_vector = VIRTIO_NO_VECTOR;
-    virtio_notify_vector(vdev, vdev->config_vector);
-
-    for(i = 0; i < VIRTIO_QUEUE_MAX; i++) {
-        __virtio_queue_reset(vdev, i);
-    }
-}
-
 void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
 {
     if (!vdev->vq[n].vring.num) {
@@ -3169,6 +3126,49 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
     return ret;
 }
 
+void virtio_reset(void *opaque)
+{
+    VirtIODevice *vdev = opaque;
+    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    int i;
+
+    virtio_set_status(vdev, 0);
+    if (current_cpu) {
+        /* Guest initiated reset */
+        vdev->device_endian = virtio_current_cpu_endian();
+    } else {
+        /* System reset */
+        vdev->device_endian = virtio_default_endian();
+    }
+
+    if (k->get_vhost) {
+        struct vhost_dev *hdev = k->get_vhost(vdev);
+        /* Only reset when vhost back-end is connected */
+        if (hdev && hdev->vhost_ops) {
+            vhost_reset_device(hdev);
+        }
+    }
+
+    if (k->reset) {
+        k->reset(vdev);
+    }
+
+    vdev->start_on_kick = false;
+    vdev->started = false;
+    vdev->broken = false;
+    virtio_set_features_nocheck(vdev, 0);
+    vdev->queue_sel = 0;
+    vdev->status = 0;
+    vdev->disabled = false;
+    qatomic_set(&vdev->isr, 0);
+    vdev->config_vector = VIRTIO_NO_VECTOR;
+    virtio_notify_vector(vdev, vdev->config_vector);
+
+    for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+        __virtio_queue_reset(vdev, i);
+    }
+}
+
 static void virtio_device_check_notification_compatibility(VirtIODevice *vdev,
                                                            Error **errp)
 {

---
base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
change-id: 20250406-reset-5ed5248ee3c1

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


