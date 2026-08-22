Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57744C5B572
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 21:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxtMI-0003hf-Np; Sat, 22 Aug 2026 17:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtMG-0003h9-Ne
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:32 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtME-0000jH-TI
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:32 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cbeea240819so1288597a12.1
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 14:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787434469; x=1788039269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OfTK4NEmm/XRmWubXK0Z8g5arShKsR66Fb+JdHHZVEI=;
 b=eA4VJR9N4N9OVKYHxtPU1WyZRZhzyNF0mywewZjqBHzbaBVP06/wfBrQ3lWSacy5Ge
 RE24ZrHa9BBrhkJRDYc07wFysXgUpx1h4MkV3QJgzvTEJJ+PygZlM+NKSD/rOw2+QYL8
 l+03ZLdeDENc8Ee75P+qWdjcRhYOLYgwQGSPX19f+tjNZSk+hae8jjmTxQ94IbjME1Vy
 pMJdpVwMX+IDHA5p03zf+QuSoY5MKLNdM5/FQZvPhGGRUy+ypEjEVeJlXNzwwNJUrM+v
 pJEDTg2+GOA97DNG2o/RdciRm6R4qtNU3wBoj0qOfLx2Zf64WuhdbjpP/NoQSZfhgfCN
 P9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787434469; x=1788039269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OfTK4NEmm/XRmWubXK0Z8g5arShKsR66Fb+JdHHZVEI=;
 b=G+HhMDLO+ZlCHCWAa7ugy1zALK4K7mvgSZgHAfC8ATc9bdIfPETkzBf1VpbvCxSgvg
 nDpKQli1l/SVy+rkXIMSBKEVpK0T/4TTQG/J9AF6HUIwc5yw4QjEHmkx6zJjftFKs5/n
 9JsePSm/9PcsJS51+dNykXQ6DNoxYqPDsV5SmTFjvCYEWEyh2uySnkMOkYx8TZl7kIej
 K0MLo6m7kiXFKOTRYnFpi7AVea1eKOcIgFf0lp+OQbItXXTiouvemEy2/iZpdTMHg2VM
 v5OFc2nDZFoxSrAwcxCN/ZwK98N3ZzVj7+Du13IAXDMGuByS1DzqBElyxKnM4mfr0T25
 h0Zg==
X-Gm-Message-State: AFuF++klIm+YFBICLSy/Kb98ZLU1D8TU2HloFR0G3nPGtBZbi/JMOehL
 RANLJ2Vak4igLTvEQQHHtNmDgO/aH2250VgxoBYd816i1szkUpeu6ylClbyCopkOqxNzQ2pL
X-Gm-Gg: AR+sD129Oj423hcD1sj6pPiBaQt6cBEB9UIf+D8kBpFQoxRrs9xxFDfZnH1s9KaObln
 z7z4EbiDGPTBMVT6LO105IS6OEjilazLU3Xsx78vC2t6ic0DB5mHci1IYjohbQs4UJGS874qZ2C
 19lYgYPfomPK/MDk6i4F7aHAw1+rT4qbqWFyQdUW+wITdHAw+juwqZN0sc8jDGIqfJ0664h30l5
 /rxWoJbvS4q37J1Ui4sKE4AwH+Uz6InJ1Zmbo3Lv1w66I4O4VXZZmU/6/kbLAA/U5QSpM0WqBbC
 IL7um/1exYYEIp1kBEd+niV3pLyqXLgn0GL4+z7M8BD/3dSlNcuTjDsZCAQhLpqlzThuYM/BjzJ
 xU7bhBW29Vhw31DtDccE+XYtoPG0OzhOAI/hV1lUKuqIDoq442n/cd47W/zVyZ6A+yVrUX89G4j
 VLiuZeZPn4pkC/muE3zJXHYVn4D6BFU7EvgbiJdF3T5JBlorUGWbch7RDWU6CF0BBSJEcuB5t9/
 REkZ/we
X-Received: by 2002:a05:6a21:1191:b0:3cd:2e96:5929 with SMTP id
 adf61e73a8af0-3cd30156961mr31745905637.14.1787434469423; 
 Sat, 22 Aug 2026 14:34:29 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f909c6c9sm11633181eec.6.2026.08.22.14.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 14:34:28 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V13 07/15] virtio-vq-mapping: track iothread-vq-mapping
 references using device path
Date: Sun, 23 Aug 2026 05:33:30 +0800
Message-ID: <20260822213343.661939-8-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822213343.661939-1-zhangckid@gmail.com>
References: <20260822213343.661939-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace raw object_ref/unref calls with iothread_ref_and_get/
unref_and_put_aio_context in iothread-vq-mapping. This allows
tracking IOThread users via the device's canonical QOM path,
improving lifecycle traceability for virtio-blk and
virtio-scsi devices.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/virtio-blk.c                   |  8 +++++++-
 hw/scsi/virtio-scsi-dataplane.c         |  9 +++++++--
 hw/virtio/iothread-vq-mapping.c         | 20 +++++++++++++++-----
 include/hw/virtio/iothread-vq-mapping.h |  6 +++++-
 4 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 6b92066aff..4b2cf3d52f 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1493,9 +1493,12 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
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
@@ -1527,7 +1530,10 @@ static void virtio_blk_vq_aio_context_cleanup(VirtIOBlock *s)
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
index 55ce62986c..60e1d55005 100644
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
@@ -93,10 +94,13 @@ bool iothread_vq_mapping_apply(
 
     for (node = list; node; node = node->next) {
         IOThread *iothread = iothread_by_id(node->value->iothread);
-        AioContext *ctx = iothread_get_aio_context(iothread);
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)holder,
+        };
 
-        /* Released in virtio_blk_vq_aio_context_cleanup() */
-        object_ref(OBJECT(iothread));
+        AioContext *ctx = iothread_ref_and_get_aio_context(iothread,
+                                                           &io_holder);
 
         if (node->value->vqs) {
             uint16List *vq;
@@ -120,13 +124,19 @@ bool iothread_vq_mapping_apply(
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
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)holder,
+        };
+
+        iothread_unref_and_put_aio_context(iothread, &io_holder);
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
2.55.0


