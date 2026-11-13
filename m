Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E637D606A32D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OYEDtll+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRnYY-0000dg-46; Fri, 13 Nov 2026 04:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYV-0000cB-SC
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:26:48 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xRnYT-00060C-RB
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:26:47 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2e9eb579c0eso4083705ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 01:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794562004; x=1795166804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CWZOQqO+lHf+7x9HQxty2nhhjD/yR6AHU1HcExeqxHA=;
 b=OYEDtll+PElnrPnTdnYbZwaUc0D120JxkALnHNbohGNZfpPV0G/AjLwzdw2NxvfIgR
 ozT8dzYAi42y4j/edYxOiajbxRIe+1Tr10HFeDAOTEmUg/abUL+xSKcRgaUIxMRrpRuA
 OvqZGY8qxzaTDTxgkLzMDg1cNTFHN60RgXJgZbTrx1ek3MPINPeQHbMN9gw17D9w8V5u
 MrdZujCvcyX3zRbcaKjoaqLlzGFNZpTvPeVLxL7Is8zBWLgLzkzQAGasOEO0IHGOo49t
 CHl3rOhI9O1PHPqlNrSblntQsyC0e5afj31PLonbTknaVALcdADB+5c3A53GODmwT9hu
 WwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794562004; x=1795166804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CWZOQqO+lHf+7x9HQxty2nhhjD/yR6AHU1HcExeqxHA=;
 b=u41Ayb7EG6I3JYBLXokqKLDqZi2bm4s3tGbXaIS904KYCXHQd15Nzc5b9dBp8vZHje
 szqBfpak3TgHtxyD9rxcEYnO0qDVWQMizClh7/KsqNviqGGqVlxrc2ZhGG5AEkjAFEVl
 4qVXiB6j/V2qhxA2Ez4RdrX6i970J0XWHPa7CtjVIepQpCGgpGWZZvLSIcQsvEne6qUg
 rTBPN2e18NTJ2JLHJwfcHZ3GU154C9r0DswhaQyX4jg12oD6Jd47kdxMJBgH/ojnQPXG
 Zi9VDEHtTkBcN4YLb98W0Ee/miKuOSLTp4PeuuE9iyd1L75DZ53PU+9OQ4EeftG8rod1
 rZWA==
X-Gm-Message-State: APuU4Z8mdkvYkaOxkVmJkgDvcHg+uCbqn5mFcAk+6HBS9vWFrawFNjBc
 pT72vAJbqSuuQvalYd7LDGtmNg8o4FiTgFo/8UHg731B5uT91AtIWn1p5HMEdem6
X-Gm-Gg: AYBFou2oftxzc3dw9FEbB/ry5yT9BgpwONeahxhlYKd2S9vRjzRbOBt4yYnHweVbdCc
 EoeFht7xfQsPKNj0EFmeBtdvp9fOqhU+PUneinoI4MfcGHQXip3I2g11QdjeMR3y1ompy6669X1
 zZP7nIGpuXog04sKcKfwXiDBxiD5NefO8myyH/GhmP6ZpvHbOmXXeoGON7Ms3S8V0ovs4ZXHF+l
 is0DEUisGrFa3okXGN6kx1EwTZCC5ltwLJbE7X8LyWkRRAnX6XlM3mPnY0+QXAR8oHmfr/TS5fx
 SLHayHl8IFeKHdx2QVsK9DYYe1vJ0m92LFtetDVAy8FWFwFOLVVgReOC1iIWpHzUSrOOPY80E9p
 0MCAVymrBSlazuHDRyLhjBhH37xo8a3EGQJOBLJnB6z8ykxaVqLAcw8ejjBmNLzviDqznqyphzS
 Pc7RlSLxQEAc7/J32OPqNcrqQjHUtgESJuA/svbTLR6773DA3x1n15HIRBvUVZcd6tHcfJT029r
 CZ9ZJjMiulysXAV4h93mFX7FtNbQEQkgiX6eQ8pJ7ew/1tL8IG8VI+Iv5TIhsJMhOTqY5ML4op7
 oTXoMaTg7/K3doEfC/231ScsDXNJC0E1QHB9SDqqGGhkDCLxTuBkL7qrMq0=
X-Received: by 2002:a17:902:e84a:b0:2e9:7dda:bfc7 with SMTP id
 d9443c01a7336-2ee0dcd0647mr17167045ad.66.1794562004295; 
 Fri, 13 Nov 2026 01:26:44 -0800 (PST)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f7d0887sm7428605ad.32.2026.11.13.01.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 01:26:43 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V20 05/14] virtio-vq-mapping: track iothread-vq-mapping
 references using device path
Date: Fri, 13 Nov 2026 17:25:56 +0800
Message-ID: <20261113092605.942292-6-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113092605.942292-1-zhangckid@gmail.com>
References: <20261113092605.942292-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace raw object_ref/unref calls with iothread_ref_and_get/
unref_and_put_aio_context in iothread-vq-mapping. This allows
tracking IOThread users via the device's canonical QOM path,
improving lifecycle traceability for virtio-blk and
virtio-scsi devices.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/virtio-blk.c                   |  8 +++++++-
 hw/scsi/virtio-scsi-dataplane.c         |  9 +++++++--
 hw/virtio/iothread-vq-mapping.c         | 20 +++++++++++++++-----
 include/hw/virtio/iothread-vq-mapping.h |  6 +++++-
 iothread.c                              | 13 +++++++++++++
 5 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 9b7c84fda6..6d1d19fa64 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1613,9 +1613,12 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
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
@@ -1647,7 +1650,10 @@ static void virtio_blk_vq_aio_context_cleanup(VirtIOBlock *s)
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
index bcb6e44133..ac13f4a1ca 100644
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
diff --git a/iothread.c b/iothread.c
index 774c356b71..d4328fc214 100644
--- a/iothread.c
+++ b/iothread.c
@@ -377,12 +377,25 @@ static void iothread_set_poll_param(Object *obj, Visitor *v,
     }
 }
 
+static bool iothread_prepare_delete(EventLoopBase *base, Error **errp)
+{
+    IOThread *iothread = IOTHREAD(base);
+
+    if (iothread->holders) {
+        error_setg(errp, "Cannot delete IOThread '%s' while it is in use",
+                   object_get_canonical_path_component(OBJECT(iothread)));
+        return false;
+    }
+    return true;
+}
+
 static void iothread_class_init(ObjectClass *klass, const void *class_data)
 {
     EventLoopBaseClass *bc = EVENT_LOOP_BASE_CLASS(klass);
 
     bc->init = iothread_init;
     bc->update_params = iothread_set_aio_context_params;
+    bc->prepare_delete = iothread_prepare_delete;
 
     object_class_property_add(klass, "poll-max-ns", "int64", &int64_type_info,
                               iothread_get_poll_param,
-- 
2.53.0


