Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83DCC531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn1wN-0004KE-6n; Thu, 23 Jul 2026 18:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wM-0004I7-08
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:30:54 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wJ-0001Pl-MQ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:30:53 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-664b05d408bso1015839d50.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 15:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784845851; x=1785450651; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AVzyy6xZ5ydOSxUHCiFZ8bWfqWfIoo+z7BTzm4kXyz0=;
 b=NaskgMdBRwjBNWT5uYWg1pNJ0vuI/syhSSvxj62Ha3SiXdEDDXMeTaS1KnuOh05TZA
 NvxrQUluD8R5zVtayr8SzZCGoe0DY5QWXc2+dQ4Rl9hWzd60a2Wfmg0d2RYHGjEv9e1/
 jDkWA/QiB5x76D+6A1NPPA7PMNeTo/6IiAPBS7qZPtN/y8thYVdXSSh3rWzVjJRClJ/p
 pDkEBe2jpCy46LUch649fhgAyU3xrDXbM6MohZXTaD66OYDPdoszug2hRRapd8eAQ6TS
 Fbbo2To3K15uIBwj/sBRuw5RR2EBjp9DaNpSEL5vaNnesb/pb8qkcZmaM7WqSyauggbV
 ka1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784845851; x=1785450651;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AVzyy6xZ5ydOSxUHCiFZ8bWfqWfIoo+z7BTzm4kXyz0=;
 b=NYFaXMKR/KgLJr1bv5bn0lEAltG+hrLl2PbVUTebBOJo8/YhOxOXHxjbeTXn1I+rby
 Sq3cXYwS7b8I4qurVzNW1Kd/UuzCoAeu7G6G0v+XO1u3kWzjk/wUYxGUpIzyDhZsFiFf
 5VRYPNYwob73gskA8LMp7nOqFtmB+lrionhBMi6lYVuE10DFdHYG2/GUtZJJbXrJC75W
 8dZJG/4A+zweozOUzMWIpF9/tGIrYRxr7D+tqQFDb5bOw7eDsxFh4uZ0UbG7H+xuIto/
 TwUyKqz8WbKozCHMzYl6J88ildPTp9xlZxSHqxjlPoxs1GtwWW4xTSwpGzMycl9tMrDa
 HA/A==
X-Gm-Message-State: AOJu0YzH4F+OR8d4zB2cae+HlpbzdMVrxbJTFYTDhzoWro81EFzzgNAa
 R9yp7t5k6q8GKgsWezIP/tihZ9926V/d27bfIBsj0Ph7johk/B+FqUZI
X-Gm-Gg: AR+sD10pDszRatb/54kTlya5IBtYaHAOhDaozBmABDZg3mox16lvdY2CeWVZzSapuNS
 NHQSZcrjouysC4vjeOsEmdw4o+Qp1JqclZROe++QHj+ET7gRlSZvtTNmUxcdl/tXRoeOGtS40xE
 cXjvIslCdfUnqN+PvyXc4G+5mOagyDkLFDi+ig0o2Rj68Z654i4bOrIRSPjmq84Ev3ONrgtUtA1
 L8Cc8F7MYFe4Fh54nsP9ohCOo7wjX45V0y2EROuG0O1glW2KPmOQI8j3MSf5n54k7hALrNdRM5c
 SsG7lgb5pF+KZCyXHw5p7AHgC04OuFyIrUSfpWPPCf+JLVqL2NAq5eYbX03qB/5tZsJyuFmuAp3
 cLNlzWiA8ToSO30kaqrUqaZsGsrDxC9+uAT8deAMI47bpiGqs+j9FZsFsFSidnoHN2+f1mBy9hC
 s8+6iXTAc=
X-Received: by 2002:a53:a6c5:0:b0:667:b84f:e402 with SMTP id
 956f58d0204a3-668a4d72958mr799067d50.50.1784845850482; 
 Thu, 23 Jul 2026 15:30:50 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:446f:49ff:37bd:d45a])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33c3c1c5sm35766777b3.17.2026.07.23.15.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 15:30:49 -0700 (PDT)
From: ConKite <connorkite@gmail.com>
Date: Thu, 23 Jul 2026 15:30:01 -0700
Subject: [PATCH RFC 02/15] vhost-user: Add memory-isolation qdev property
 to vhost-user devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-vhost-user-isolated-memory-v1-2-6b97c439eb28@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 Connor Kite <connorkite@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784845839; l=8255;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=XqOLo5frjAV4wg3rR/2wYEwsGon0SXS6Qu2Lm8kDZ9g=;
 b=igaD/fidgbsGc0CjOz/z1UUNIZCHaMg5VqOMnvLkV9N9Lk5yh9x2BcjZIrVD4lEK0h6wqWSEx
 vAjAQ9rpNBDCWY1aPyvxOovuk8WLb+r2oJgANcGyZX60CVMnopTsfXQ
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=connorkite@gmail.com; helo=mail-yx1-xb131.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In support of future work to add a memory isolation mode to vhost-user devices, a
qdev property, "memory-isolation", is added to all vhost-user devices. This is
simply a bool representing whether the mode is active or not.

Signed-off-by: Connor Kite <connorkite@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/vhost-user-blk.c            | 1 +
 hw/display/vhost-user-gpu.c          | 1 +
 hw/scsi/vhost-user-scsi.c            | 1 +
 hw/virtio/vhost-user-base.c          | 3 ++-
 hw/virtio/vhost-user-fs.c            | 1 +
 hw/virtio/vhost-user-scmi.c          | 1 +
 hw/virtio/vhost-user-vsock.c         | 1 +
 include/hw/virtio/vhost-user-base.h  | 1 +
 include/hw/virtio/vhost-user-blk.h   | 1 +
 include/hw/virtio/vhost-user-fs.h    | 1 +
 include/hw/virtio/vhost-user-scmi.h  | 1 +
 include/hw/virtio/vhost-user-vsock.h | 1 +
 include/hw/virtio/virtio-gpu.h       | 1 +
 include/hw/virtio/virtio-scsi.h      | 1 +
 14 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 2e5b3ae1b1..9830dc6c35 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -631,6 +631,7 @@ static const VMStateDescription vmstate_vhost_user_blk = {
 
 static const Property vhost_user_blk_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserBlk, memory_isolation, false),
     DEFINE_PROP_UINT16("num-queues", VHostUserBlk, num_queues,
                        VHOST_USER_BLK_AUTO_NUM_QUEUES),
     DEFINE_PROP_UINT32("queue-size", VHostUserBlk, queue_size, 128),
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 57360898ca..6d0ede672a 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -659,6 +659,7 @@ static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
 
 static const Property vhost_user_gpu_properties[] = {
     VIRTIO_GPU_BASE_PROPERTIES(VhostUserGPU, parent_obj.conf),
+    DEFINE_PROP_BOOL("memory-isolation", VhostUserGPU, memory_isolation, false),
 };
 
 static void
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 5070178dc2..c1a0393220 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -346,6 +346,7 @@ static void vhost_user_scsi_unrealize(DeviceState *dev)
 
 static const Property vhost_user_scsi_properties[] = {
     DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VirtIOSCSICommon, conf.memory_isolation, false),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
                        VIRTIO_SCSI_AUTO_NUM_QUEUES),
diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 90bd2903db..d2a74a2860 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -409,7 +409,8 @@ static void vub_device_unrealize(DeviceState *dev)
 
 /*Define common qdev properties.  Inherited by all children*/
 static const Property vub_properties[] = {
-    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev)
+    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserBase, memory_isolation, false)
 };
 
 
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 209993918a..3d980d814b 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -410,6 +410,7 @@ static const VMStateDescription vuf_backend_vmstate = {
 
 static const Property vuf_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserFS, conf.chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserFS, conf.memory_isolation, false),
     DEFINE_PROP_STRING("tag", VHostUserFS, conf.tag),
     DEFINE_PROP_UINT16("num-request-queues", VHostUserFS,
                        conf.num_request_queues, 1),
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index 02dc088ea9..d514d89392 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -287,6 +287,7 @@ static const VMStateDescription vu_scmi_vmstate = {
 
 static const Property vu_scmi_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserSCMI, chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserSCMI, memory_isolation, false),
 };
 
 static void vu_scmi_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
index c2cd376e73..89aa789e22 100644
--- a/hw/virtio/vhost-user-vsock.c
+++ b/hw/virtio/vhost-user-vsock.c
@@ -154,6 +154,7 @@ static void vuv_device_unrealize(DeviceState *dev)
 
 static const Property vuv_properties[] = {
     DEFINE_PROP_CHR("chardev", VHostUserVSock, conf.chardev),
+    DEFINE_PROP_BOOL("memory-isolation", VHostUserVSock, conf.memory_isolation, false),
 };
 
 static void vuv_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/virtio/vhost-user-base.h b/include/hw/virtio/vhost-user-base.h
index d5d2f081ae..29bc40736c 100644
--- a/include/hw/virtio/vhost-user-base.h
+++ b/include/hw/virtio/vhost-user-base.h
@@ -25,6 +25,7 @@ struct VHostUserBase {
     uint32_t num_vqs;
     uint32_t vq_size; /* can't exceed VIRTIO_QUEUE_MAX */
     uint32_t config_size;
+    bool memory_isolation;
     /* State tracking */
     VhostUserState vhost_user;
     struct vhost_virtqueue *vhost_vq;
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-user-blk.h
index dee848cfd8..8126447a86 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -30,6 +30,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserBlk, VHOST_USER_BLK)
 struct VHostUserBlk {
     VirtIODevice parent_obj;
     CharFrontend chardev;
+    bool memory_isolation;
     int32_t bootindex;
     struct virtio_blk_config blkcfg;
     uint16_t num_queues;
diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vhost-user-fs.h
index 5699ea03a1..bf71990b9c 100644
--- a/include/hw/virtio/vhost-user-fs.h
+++ b/include/hw/virtio/vhost-user-fs.h
@@ -28,6 +28,7 @@ typedef struct {
     char *tag;
     uint16_t num_request_queues;
     uint16_t queue_size;
+    bool memory_isolation;
 } VHostUserFSConf;
 
 struct VHostUserFS {
diff --git a/include/hw/virtio/vhost-user-scmi.h b/include/hw/virtio/vhost-user-scmi.h
index 30ab0d7ab7..d346b42ed8 100644
--- a/include/hw/virtio/vhost-user-scmi.h
+++ b/include/hw/virtio/vhost-user-scmi.h
@@ -19,6 +19,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCMI, VHOST_USER_SCMI);
 struct VHostUserSCMI {
     VirtIODevice parent;
     CharFrontend chardev;
+    bool memory_isolation;
     struct vhost_virtqueue *vhost_vqs;
     struct vhost_dev vhost_dev;
     VhostUserState vhost_user;
diff --git a/include/hw/virtio/vhost-user-vsock.h b/include/hw/virtio/vhost-user-vsock.h
index 5db6938b8b..6288b26fa4 100644
--- a/include/hw/virtio/vhost-user-vsock.h
+++ b/include/hw/virtio/vhost-user-vsock.h
@@ -21,6 +21,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserVSock, VHOST_USER_VSOCK)
 
 typedef struct {
     CharFrontend chardev;
+    bool memory_isolation;
 } VHostUserVSockConf;
 
 struct VHostUserVSock {
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index b9bad27c97..707612c3a4 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -277,6 +277,7 @@ struct VhostUserGPU {
     CharFrontend vhost_chr;
     QemuDmaBuf *dmabuf[VIRTIO_GPU_MAX_SCANOUTS];
     bool backend_blocked;
+    bool memory_isolation;
 };
 
 #define MAX_SLOTS 4096
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index b6028bb5cd..47fdc3785c 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -59,6 +59,7 @@ struct VirtIOSCSIConf {
     char *vhostfd;
     char *wwpn;
     CharFrontend chardev;
+    bool memory_isolation;
     uint32_t boot_tpgt;
     IOThread *iothread;
     IOThreadVirtQueueMappingList *iothread_vq_mapping_list;

-- 
2.43.0


