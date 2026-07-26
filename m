Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08B4C53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6Q3-0007p4-QO; Sun, 26 Jul 2026 17:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Py-0007mN-D5
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Pw-0004Km-HE
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yu5Eow4quXrOU9AMKD8Z8Ai53r05ckm98VKvtDP9cP0=;
 b=VqPOIVr/WAzBkZuOPKNiVdFscmy/ugKskCEV8ES105PF702mI3u6e+8pfu3igeQKFuFEWI
 V2aQXbRRsqfBrFu1dCVaiqXXqtrm8FJcGYMaX6/Lgd6/lpq6XAaYaQB7kJj0OIASUqziqO
 q66gMJnziziYSif9C7eygLDWvOx4ZaM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-6Ag8W0xAONK_IhWEE8dEIw-1; Sun, 26 Jul 2026 17:29:50 -0400
X-MC-Unique: 6Ag8W0xAONK_IhWEE8dEIw-1
X-Mimecast-MFC-AGG-ID: 6Ag8W0xAONK_IhWEE8dEIw_1785101389
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-495529a93f9so18603005e9.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101389; x=1785706189; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yu5Eow4quXrOU9AMKD8Z8Ai53r05ckm98VKvtDP9cP0=;
 b=P+Ps/pIhD+K0/PK2NwEc4VDC/yqsU3hdCrZDqfEFsK3hWq8ktEYv+kj7M9w4HQ4ZwV
 uMY5tG0xUvAZXvd1E8PT5F7ofsiAFLRVkU3ukeQXC+EkItkMMz6MlJTo9Ij0PQcbruEZ
 ribYr4d6HkbkK5AAQvazx+UibKkJjA7dqZyK5RFw7sM5JvfMueO2NfBDUYVHU/ab1NfV
 sdd6NjGA1SlcXx+Xn9rsLYQSPpQ3brUwe2g+eWRDZ5UZL6njAQV0vrU0ZdStRakOJq4R
 vOYbjz2eSkHaabxZKgHXYJavdSNVVwtV6Y89pvJad24KvjYChgxcR5zOJEK77xQou0iy
 ZoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101389; x=1785706189;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yu5Eow4quXrOU9AMKD8Z8Ai53r05ckm98VKvtDP9cP0=;
 b=cpzJ8QcJBTZrG/bOGJF/FndNDRK5MKGzyJuEvZqx1X9UXamySHB7ofoDx6D7mVnQmy
 DoOjx3TLp8HiXHxJvtLKuvGWbK8mSFygjcmgQ/7/WcZzHuoaDqydcj5B7oF23+cuc9RA
 jvhDg8R9OMJ4YN9A4MgBz2QkcX45FJcClxmZE72kniUuaBeF3ujeQvzlWOgkOCW2HYZT
 rtKEOgavMpqsmfPRKWbq8A/YcQfQVo3sOu2LTugXF9jxdWWjdVGxr+C3EbQTEM6h4+vs
 1XjNFLoZZ/KHu/cXuqVmtErG5JnkinyOVN2Om2QmqIAyXc7c2JiefdrdiRc3sZieEnJ0
 qJBQ==
X-Gm-Message-State: AOJu0YwqH45nshvsNTPgrRbHhPFPfdGGfhSTwVEsnxL+s8F5r59gxjbn
 YqAMJzCN2FJhAFgwGJuqJ5iTb7+qvTwgvgtvEl+UDcEGYCXqce1ymlntrYhAEMSbQidoRLx6KBL
 WWneNL5ai2IzVpBh1NPBx0zRrW7sRk+vPE+bkPyj9CN/vI/zpnn6p84oS6ZBgtSnhRTNnQEQZvP
 kvtKK1Pi709sti+0iERHneOW7VnXUC3S7jNQ==
X-Gm-Gg: AR+sD10W3iai5b80Kz78k7jFCNhdSwVDjlzjdWxLDCkQjoofWC3PXYjxgaO4CAFc7Ym
 r6hoiZkEyx4/9o/uIBAjkRPiJjtcyILuOtoUI14UkJPXa76hWCObMorJ18SM+aL3M+X9WZLizkL
 OIahewTlWHDsavBwBqpjuHFAyyeROyYszIyrldYSVj/l7q5ovIM0KfiVpKD63z16HaQa7pfbFRl
 V8JApvBtQqTjSSzKvz6U2+GwW2xmi4cFVefp8wrksDdLC8W/l26gSOIEp6NHPt5864f0ySn3YBe
 6rN9++Ad5B9Myh3T8VIOsSsS2NsMOJC3WggV2PXOsp8jwNSf0yM3grxnEjdbQgLjypPfVGLJGAY
 sTw7rGMvKdIvGnEHAz6NKEQ==
X-Received: by 2002:a05:600c:8b48:b0:495:3fe8:880f with SMTP id
 5b1f17b1804b1-496b56e6ea8mr66886695e9.4.1785101388929; 
 Sun, 26 Jul 2026 14:29:48 -0700 (PDT)
X-Received: by 2002:a05:600c:8b48:b0:495:3fe8:880f with SMTP id
 5b1f17b1804b1-496b56e6ea8mr66886475e9.4.1785101388342; 
 Sun, 26 Jul 2026 14:29:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4ee1d31sm182954335e9.5.2026.07.26.14.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:47 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PULL 19/30] virtio-iommu: fix OOM due to unbounded call_rcu
Message-ID: <e8d1467eca821d2c8b837853004d40f0c1098182.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Currently, within virtio-iommu, handle_command processes the command vq
without any limits on the number of entries processed.
This can easily and repeatedly enable/disable multiple memory regions.
Within the memory code, this causes an accumulation of an
unbounded number of RCU-deferred FlatViews - each of these
is supposed to be freed with call_rcu, but that never happens
because the main thread never returns to the main loop.

Given FlatView is big, it's easy to have this balloon out to multiple
Gigabytes of memory.

Limit the loop defer any remaining work to a timer.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3930
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <eb46ab360dbe28c29cfa78812a7440dcb7444d59.1784807826.git.mst@redhat.com>
---
 include/hw/virtio/virtio-iommu.h |  1 +
 hw/virtio/virtio-iommu.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 3b86050f2c..1f265540ad 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -65,6 +65,7 @@ struct VirtIOIOMMU {
     GTree *domains;
     QemuRecMutex mutex;
     GTree *endpoints;
+    QEMUTimer *cmd_timer;
     bool boot_bypass;
     Notifier machine_done;
     bool granule_frozen;
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 08f7e8b783..533bd5073f 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -993,6 +993,18 @@ static int virtio_iommu_handle_probe(VirtIOIOMMU *s,
     return ret ? ret : virtio_iommu_probe(s, &req, buf);
 }
 
+static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq);
+
+static void virtio_iommu_handle_command_timer(void *opaque)
+{
+    VirtIOIOMMU *s = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    if (virtio_device_started(vdev, vdev->status) && !vdev->broken) {
+        virtio_iommu_handle_command(vdev, s->req_vq);
+    }
+}
+
 static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
@@ -1003,10 +1015,17 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
     struct iovec *iov;
     void *buf = NULL;
     size_t sz;
+    unsigned int batch = 0;
 
     for (;;) {
         size_t output_size = sizeof(tail);
 
+        if (++batch > virtio_queue_get_num(vdev, virtio_get_queue_index(vq))) {
+            timer_mod(s->cmd_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) + 1);
+            break;
+        }
+
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
             return;
@@ -1416,6 +1435,8 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
     s->req_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE,
                              virtio_iommu_handle_command);
     s->event_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE, NULL);
+    s->cmd_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
+                                virtio_iommu_handle_command_timer, s);
 
     /*
      * config.bypass is needed to get initial address space early, such as
@@ -1498,6 +1519,7 @@ static void virtio_iommu_device_unrealize(DeviceState *dev)
 
     qemu_rec_mutex_destroy(&s->mutex);
 
+    timer_free(s->cmd_timer);
     virtio_delete_queue(s->req_vq);
     virtio_delete_queue(s->event_vq);
     virtio_cleanup(vdev);
@@ -1509,6 +1531,8 @@ static void virtio_iommu_device_reset_exit(Object *obj, ResetType type)
 
     trace_virtio_iommu_device_reset_exit();
 
+    timer_del(s->cmd_timer);
+
     if (s->domains) {
         g_tree_destroy(s->domains);
     }
@@ -1628,6 +1652,11 @@ static int iommu_post_load(void *opaque, int version_id)
      * still correct.
      */
     virtio_iommu_switch_address_space_all(s);
+
+    if (virtio_device_started(VIRTIO_DEVICE(s), VIRTIO_DEVICE(s)->status)) {
+        timer_mod(s->cmd_timer,
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) + 1);
+    }
     return 0;
 }
 
-- 
MST


