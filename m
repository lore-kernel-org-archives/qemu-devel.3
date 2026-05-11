Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90325CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRH8-0001F3-VM; Mon, 11 May 2026 10:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRG2-0000O7-Jn
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:20 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRFz-0007Ed-1q
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:17 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ba4efedbeaso31143205ad.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508310; x=1779113110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bgUF3HiJphzj1Syby/WQ1ZPvl1qvI2+cLYn11/J12tg=;
 b=q4WswfOgNnra0tm9AEQYz1PBqer31KjzNf44jzmlB8C1T+tkTThw5lELptw1TG574J
 OD3OXgSeBtaTtd1oPbST5xdONNl0aeLY4ZM1vVCW9P1ZQyi9nxksyZPGYH90w1TQ07eU
 FYzIfoWx7a2H80vvEecT/UU2E3ob4vnCv3rjpEGLaQR0tLetfL8KGRhF3ANbeN4//eeo
 46NGA4o/KDlWkQixbjcLEs4EbyOa+t7sWHYo+78MIFKT6ob6M+DOjxsXRri6krsZ/cON
 H3KeV9RdcsA8yjcCATDUuaDSKjT8Znp5i0gpeGsUt39rzsfHBk/b5IsYm4Ph0S7qx8vC
 F2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508310; x=1779113110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bgUF3HiJphzj1Syby/WQ1ZPvl1qvI2+cLYn11/J12tg=;
 b=CySvGkcDYIM3K+P7D7eG2MzepvaKH5juGWr4Tw5skDSsuhID2BTa59RboUsi1lSmTc
 yC2nvzZS0aJmtpnbJ8RVUr4e0tMsxXz0NMTaZdAdfTzMnsLBuGaoI8ZbWhcbQU/qziXr
 HSGI9kUOPVLV+9GsWQzBZ040+Dc+YuFUki6ymqI9Ku78BfDIjM6rE9nH8h+PYy0M57rW
 bdjwt7vcaNYGyQXXA4Xon6tgkx6lY4mFL6eJsfn2kfI3CGDTfVU0JmWMc98vl6ey/bKf
 fx5YyBFZ0CM8tg+jDatDtuxGZkfhka9god8sRalOp8xX7zcRsslGwW3dCvX7I+a+qfcu
 Li5Q==
X-Gm-Message-State: AOJu0YwseD7FjQeIWYZGc+WQuIgQFbkAHg5msn8UdnfXP6w33J5bILv4
 E+GGECSU1W7bzZOoXLMAGKo5QafnUKoNIOUYApxinwwVbmZwi/T7z0vOM1ZfV6KY/7A=
X-Gm-Gg: Acq92OE90NNRX4e+ojjJBf1t6JEFLbGW/9HqpLcGXW1DNGqYZP8eg5lCR5B0igxI8Xa
 ZGCOHZ1VQgSo3HsL37nQ7SsVclsTByJa3mur+g/r1iuJYPXCn+nPdTjfWWt8dL3DLWeCB+4C+HC
 IGPMfGOxiRoavu0D0NRoQyD3kaHyLjfUX24OuoMaSQBAm6AvVXUtkGg2PPoEqOF7EP1rvJ4WTVS
 H9jyPCfT82YiB5NZYjz5QupDR3baA9fj+qC+feXF9oAwcUdMAIJ6tfKPIkoSB2SYPfruXGkFC1o
 8oYXLoCp1bkS6H0WBOiTEuTxJzqqrMIauMivkmz/alXzuHnoM9Vtz5erInEKJ3/ae3/SIcZLCCq
 +M/bhmsksuHGlzSXgyG4MnKTo1P5CeR2cRfeLv+D2AzWbtULF8mF5YYY+GC7KHu1wMAxTyzMwOQ
 sfvTAZOPtIzg7wZWv+GTKmn5Z/5xlKSt4eqe4tYRqdoeAy9FLXbhw+kapI
X-Received: by 2002:a17:902:da85:b0:2b9:7051:2c18 with SMTP id
 d9443c01a7336-2ba78ac4fe0mr254898595ad.0.1778508309833; 
 Mon, 11 May 2026 07:05:09 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([115.108.63.147])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e90854sm105113435ad.66.2026.05.11.07.05.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 07:05:09 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V7 07/14] virtio-vq-mapping: track iothread-vq-mapping
 references using device path
Date: Mon, 11 May 2026 22:04:09 +0800
Message-ID: <20260511140416.28271-8-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511140416.28271-1-zhangckid@gmail.com>
References: <20260511140416.28271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x631.google.com
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

Replace raw object_ref/unref calls with iothread_get/put_aio_context
in iothread-vq-mapping. This allows tracking IOThread users via
the device's canonical QOM path, improving lifecycle traceability
for virtio-blk and virtio-scsi devices.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/virtio-blk.c                   |  8 +++++++-
 hw/scsi/virtio-scsi-dataplane.c         |  9 +++++++--
 hw/virtio/iothread-vq-mapping.c         | 11 +++++------
 include/hw/virtio/iothread-vq-mapping.h |  6 +++++-
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9cb9f1fb2b..30e9fcf870 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1487,9 +1487,12 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     s->vq_aio_context = g_new(AioContext *, conf->num_queues);
 
     if (conf->iothread_vq_mapping_list) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
+
         if (!iothread_vq_mapping_apply(conf->iothread_vq_mapping_list,
                                        s->vq_aio_context,
                                        conf->num_queues,
+                                       path,
                                        errp)) {
             g_free(s->vq_aio_context);
             s->vq_aio_context = NULL;
@@ -1521,7 +1524,10 @@ static void virtio_blk_vq_aio_context_cleanup(VirtIOBlock *s)
     assert(!s->ioeventfd_started);
 
     if (conf->iothread_vq_mapping_list) {
-        iothread_vq_mapping_cleanup(conf->iothread_vq_mapping_list);
+        g_autofree char *path = object_get_canonical_path(
+                                OBJECT(VIRTIO_DEVICE(s)));
+
+        iothread_vq_mapping_cleanup(conf->iothread_vq_mapping_list, path);
     }
 
     if (conf->iothread) {
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 95f13fb7c2..26ecefd547 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -65,9 +65,11 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
     s->vq_aio_context[1] = qemu_get_aio_context();
 
     if (vs->conf.iothread_vq_mapping_list) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
+
         if (!iothread_vq_mapping_apply(vs->conf.iothread_vq_mapping_list,
                     &s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED],
-                    vs->conf.num_queues, errp)) {
+                    vs->conf.num_queues, path, errp)) {
             g_free(s->vq_aio_context);
             s->vq_aio_context = NULL;
             return;
@@ -94,7 +96,10 @@ void virtio_scsi_dataplane_cleanup(VirtIOSCSI *s)
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
 
     if (vs->conf.iothread_vq_mapping_list) {
-        iothread_vq_mapping_cleanup(vs->conf.iothread_vq_mapping_list);
+        g_autofree char *path = object_get_canonical_path(
+                                OBJECT(VIRTIO_DEVICE(s)));
+
+        iothread_vq_mapping_cleanup(vs->conf.iothread_vq_mapping_list, path);
     }
 
     if (vs->conf.iothread) {
diff --git a/hw/virtio/iothread-vq-mapping.c b/hw/virtio/iothread-vq-mapping.c
index 55ce62986c..c993281d7f 100644
--- a/hw/virtio/iothread-vq-mapping.c
+++ b/hw/virtio/iothread-vq-mapping.c
@@ -77,6 +77,7 @@ bool iothread_vq_mapping_apply(
         IOThreadVirtQueueMappingList *list,
         AioContext **vq_aio_context,
         uint16_t num_queues,
+        const char *holder,
         Error **errp)
 {
     IOThreadVirtQueueMappingList *node;
@@ -93,10 +94,7 @@ bool iothread_vq_mapping_apply(
 
     for (node = list; node; node = node->next) {
         IOThread *iothread = iothread_by_id(node->value->iothread);
-        AioContext *ctx = iothread_get_aio_context(iothread);
-
-        /* Released in virtio_blk_vq_aio_context_cleanup() */
-        object_ref(OBJECT(iothread));
+        AioContext *ctx = iothread_ref_and_get_aio_context(iothread, holder);
 
         if (node->value->vqs) {
             uint16List *vq;
@@ -120,13 +118,14 @@ bool iothread_vq_mapping_apply(
     return true;
 }
 
-void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list)
+void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list,
+                                 const char *holder)
 {
     IOThreadVirtQueueMappingList *node;
 
     for (node = list; node; node = node->next) {
         IOThread *iothread = iothread_by_id(node->value->iothread);
-        object_unref(OBJECT(iothread));
+        iothread_put_aio_context(iothread, holder);
     }
 }
 
diff --git a/include/hw/virtio/iothread-vq-mapping.h b/include/hw/virtio/iothread-vq-mapping.h
index 57335c3703..0d39caddf3 100644
--- a/include/hw/virtio/iothread-vq-mapping.h
+++ b/include/hw/virtio/iothread-vq-mapping.h
@@ -17,6 +17,7 @@
  * @list: The mapping of virtqueues to IOThreads.
  * @vq_aio_context: The array of AioContext pointers to fill in.
  * @num_queues: The length of @vq_aio_context.
+ * @holder: The QOM paths for attached device.
  * @errp: If an error occurs, a pointer to the area to store the error.
  *
  * Fill in the AioContext for each virtqueue in the @vq_aio_context array given
@@ -31,15 +32,18 @@ bool iothread_vq_mapping_apply(
         IOThreadVirtQueueMappingList *list,
         AioContext **vq_aio_context,
         uint16_t num_queues,
+        const char *holder,
         Error **errp);
 
 /**
  * iothread_vq_mapping_cleanup:
  * @list: The mapping of virtqueues to IOThreads.
+ * @holder: The QOM paths for attached device.
  *
  * Release IOThread object references that were acquired by
  * iothread_vq_mapping_apply().
  */
-void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list);
+void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list,
+                                 const char *holder);
 
 #endif /* HW_VIRTIO_IOTHREAD_VQ_MAPPING_H */
-- 
2.49.0


