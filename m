Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9828DC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyqw-0005lo-C7; Tue, 25 Aug 2026 17:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqt-0005k7-LF
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:39 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqq-0004za-VH
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:39 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id D7A20C0962;
 Wed, 26 Aug 2026 00:38:34 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-m8ix9V4V; Wed, 26 Aug 2026 00:38:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693914;
 bh=t0e2I1m920XciUnl8p+3NgqDLRnZSJTAzO03yTxRpb8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=z7rWjslp+H/o4XiXuoaWZsz9AKYtPaeQ4Y9HNeZuQxGRT2C+V7UhSfcyj5S3+p9OA
 AYWFXu2cfY26wxlaMvvvq4kk+E+lmnJdWncS7Obz2MHnCRUC3TT0NKutWwAFsA7tnd
 Qnp4D5VEyweQmdVLJih2wSlX3sV9Nndxc60rQT/0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 05/30] hw/virtio: make virtio_save() and virtio_load() static
Date: Wed, 26 Aug 2026 00:37:45 +0300
Message-ID: <20260825213811.3725682-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

These functions are used only in virtio.c, no reason to make
them public.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/virtio.c         | 7 +++++--
 include/hw/virtio/virtio.h | 4 ----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 0f7c8acead0..a9338af6d00 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -62,6 +62,9 @@
  */
 #define VIRTIO_PCI_VRING_ALIGN         4096
 
+static int coroutine_mixed_fn
+virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id);
+
 typedef struct VRingDesc
 {
     uint64_t addr;
@@ -3067,7 +3070,7 @@ static const VMStateDescription vmstate_virtio = {
     }
 };
 
-int virtio_save(VirtIODevice *vdev, QEMUFile *f)
+static int virtio_save(VirtIODevice *vdev, QEMUFile *f)
 {
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
@@ -3510,7 +3513,7 @@ size_t virtio_get_config_size(const VirtIOConfigSizeParams *params,
     return config_size;
 }
 
-int coroutine_mixed_fn
+static int coroutine_mixed_fn
 virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
 {
     int i, ret;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c99cb19d886..9628ae3bcb8 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -338,8 +338,6 @@ int virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
 
 void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
 
-int virtio_save(VirtIODevice *vdev, QEMUFile *f);
-
 /**
  * virtio_new_shmem_region() - Create a new shared memory region
  * @vdev: VirtIODevice
@@ -443,8 +441,6 @@ extern const VMStateInfo virtio_vmstate_info;
         .flags = VMS_SINGLE,                  \
     }
 
-int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id);
-
 /**
  * virtio_notify_config() - signal a change to device config
  * @vdev: the virtio device
-- 
2.43.0


