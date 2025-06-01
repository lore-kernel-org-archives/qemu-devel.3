Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55060C5B555
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLka1-0003rZ-49; Sun, 01 Jun 2025 11:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZe-0003KT-G8
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkZb-0004hA-N8
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwblXR8nhghJfmmOV1A/vOPLGOORroiZAipr6mzYif0=;
 b=KUEHHVZ4FYNMNDja1MmcOyuvBOB6AQVoErniTopqZf+QJr1REg/YXsXYqSHwxYYX6eyLwr
 TpvnBJ/pH0X5pKHx5+zBMTKtH2nEoJZyXk76ks1JI481/RrbLp8GXmFGzA0tF8D9vqmnR9
 ow/235jeBNbQg25bLqYle8KyBvI9xMY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-7O6_xdQTM1eSza8wc0hF8Q-1; Sun, 01 Jun 2025 11:26:05 -0400
X-MC-Unique: 7O6_xdQTM1eSza8wc0hF8Q-1
X-Mimecast-MFC-AGG-ID: 7O6_xdQTM1eSza8wc0hF8Q_1748791564
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4eb6fcd88so2219833f8f.1
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791564; x=1749396364;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kwblXR8nhghJfmmOV1A/vOPLGOORroiZAipr6mzYif0=;
 b=G2kJCvcyVTdXTX5nr/40Z8LFrnzZpDyyBOqW+SMh4Kw/NqmoJFRb8aLbyVC7LElk8b
 VeU7bIlNibrnW+BabkYXh2T2z6FjV9+Y9y7/XTKp/f5Va394XklcNgQi8VFHo9ZySyzB
 Y7k0veaxEcaVE0jgf39bWo3mw/oXbmbJbhXbGGAP+4K5h4eEmCi2fL20mCDPeCGGdrai
 d34XDEI4LUipaZVHAA10EKFlwN0YrhVAAZ4Ks+lilkLmL2OXKRnm4MAiE55NREiCCl21
 wdu3rV338yrfW3Vvy/hgGmhrAfIbkXH3nT2bt7W4QMkpZuVlAWgX+fHby+65j6hVvpuW
 T0wg==
X-Gm-Message-State: AOJu0Yz0y8UfuKEDYo7arScZBIZ2nxIal437FPWGj+Jt0Vnr0NdHZWno
 A8epxCVATbsheeatNz0DnMM8UI5oT+aLmbuQstY1PSHgyR0kmG2YnnyAB++0wesDcgeLoVqkes1
 3o+ZXZVKcZbrWiPFr3ifmnW7p7H2G/ESBvgcEtPi5z9L8oU6I2v2/EY6s1iNEXQKAztVXacKBnf
 1ER0EfgdcSrNB+LB4UAWf2Z5N1h18ir9vEpw==
X-Gm-Gg: ASbGncvayxOhAk3M1aujvVVM0L+Jco6j8IylmS9zmBp69luDqWvCnGCcA0j/4cTqLAE
 iA0SGCUXqsjoa/PLpI2YqDG7N189r8E4XfFnw/kgnjAQXkLQ1WjZ8rv+si91oLM2KmTwDcwhe3q
 0wWqp+EUj6X/Ve6xj6Y6csHbyuEc8BPZtCYRS8/kCKEdjiBgsmIgJX9uL6/r+8bLo9c3zKJvYbq
 DaY6VMoG0aHx31Y7YvMCVfHuQgml3genR4pYGazTi7WT4l1ksWbJOlVOLA0E/eCUHxpf+a4gS+k
 rI17ww==
X-Received: by 2002:a05:6000:2008:b0:3a4:cfbf:51ae with SMTP id
 ffacd0b85a97d-3a4fe154ecfmr3770229f8f.4.1748791563636; 
 Sun, 01 Jun 2025 08:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3ajmpWOSOacybeulf9x/QRFjv7ffKxo4Z/GkRUc0eVlAlutWA6CAJnwlIR4yXAqKz8FO9ZQ==
X-Received: by 2002:a05:6000:2008:b0:3a4:cfbf:51ae with SMTP id
 ffacd0b85a97d-3a4fe154ecfmr3770204f8f.4.1748791563126; 
 Sun, 01 Jun 2025 08:26:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8eceasm88604985e9.7.2025.06.01.08.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:26:01 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:25:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 29/31] vdpa: move iova_tree allocation to net_vhost_vdpa_init
Message-ID: <fac4a20c49f673686e7f30e0c9bb50af308af292.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Eugenio Pérez <eperezma@redhat.com>

As we are moving to keep the mapping through all the vdpa device life
instead of resetting it at VirtIO reset, we need to move all its
dependencies to the initialization too.  In particular devices with
x-svq=on need a valid iova_tree from the beginning.

Simplify the code also consolidating the two creation points: the first
data vq in case of SVQ active and CVQ start in case only CVQ uses it.

Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20250522145839.59974-7-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h | 16 ++++++++++++++-
 net/vhost-vdpa.c               | 36 +++-------------------------------
 2 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 221840987e..449bf5c840 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -43,7 +43,21 @@ typedef struct vhost_vdpa_shared {
     struct vhost_vdpa_iova_range iova_range;
     QLIST_HEAD(, vdpa_iommu) iommu_list;
 
-    /* IOVA mapping used by the Shadow Virtqueue */
+    /*
+     * IOVA mapping used by the Shadow Virtqueue
+     *
+     * It is shared among all ASID for simplicity, whether CVQ shares ASID with
+     * guest or not:
+     * - Memory listener need access to guest's memory addresses allocated in
+     *   the IOVA tree.
+     * - There should be plenty of IOVA address space for both ASID not to
+     *   worry about collisions between them.  Guest's translations are still
+     *   validated with virtio virtqueue_pop so there is no risk for the guest
+     *   to access memory that it shouldn't.
+     *
+     * To allocate a iova tree per ASID is doable but it complicates the code
+     * and it is not worth it for the moment.
+     */
     VhostIOVATree *iova_tree;
 
     /* Copy of backend features */
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index decb826868..58d738945d 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -235,6 +235,7 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
         return;
     }
     qemu_close(s->vhost_vdpa.shared->device_fd);
+    g_clear_pointer(&s->vhost_vdpa.shared->iova_tree, vhost_iova_tree_delete);
     g_free(s->vhost_vdpa.shared);
 }
 
@@ -362,16 +363,8 @@ static int vdpa_net_migration_state_notifier(NotifierWithReturn *notifier,
 
 static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
 {
-    struct vhost_vdpa *v = &s->vhost_vdpa;
-
     migration_add_notifier(&s->migration_state,
                            vdpa_net_migration_state_notifier);
-
-    /* iova_tree may be initialized by vhost_vdpa_net_load_setup */
-    if (v->shadow_vqs_enabled && !v->shared->iova_tree) {
-        v->shared->iova_tree = vhost_iova_tree_new(v->shared->iova_range.first,
-                                                   v->shared->iova_range.last);
-    }
 }
 
 static int vhost_vdpa_net_data_start(NetClientState *nc)
@@ -418,19 +411,12 @@ static int vhost_vdpa_net_data_load(NetClientState *nc)
 static void vhost_vdpa_net_client_stop(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
-    struct vhost_dev *dev;
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
     if (s->vhost_vdpa.index == 0) {
         migration_remove_notifier(&s->migration_state);
     }
-
-    dev = s->vhost_vdpa.dev;
-    if (dev->vq_index + dev->nvqs == dev->vq_index_end) {
-        g_clear_pointer(&s->vhost_vdpa.shared->iova_tree,
-                        vhost_iova_tree_delete);
-    }
 }
 
 static NetClientInfo net_vhost_vdpa_info = {
@@ -602,24 +588,6 @@ out:
         return 0;
     }
 
-    /*
-     * If other vhost_vdpa already have an iova_tree, reuse it for simplicity,
-     * whether CVQ shares ASID with guest or not, because:
-     * - Memory listener need access to guest's memory addresses allocated in
-     *   the IOVA tree.
-     * - There should be plenty of IOVA address space for both ASID not to
-     *   worry about collisions between them.  Guest's translations are still
-     *   validated with virtio virtqueue_pop so there is no risk for the guest
-     *   to access memory that it shouldn't.
-     *
-     * To allocate a iova tree per ASID is doable but it complicates the code
-     * and it is not worth it for the moment.
-     */
-    if (!v->shared->iova_tree) {
-        v->shared->iova_tree = vhost_iova_tree_new(v->shared->iova_range.first,
-                                                   v->shared->iova_range.last);
-    }
-
     r = vhost_vdpa_cvq_map_buf(&s->vhost_vdpa, s->cvq_cmd_out_buffer,
                                vhost_vdpa_net_cvq_cmd_page_len(), false);
     if (unlikely(r < 0)) {
@@ -1728,6 +1696,8 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
         s->vhost_vdpa.shared->device_fd = vdpa_device_fd;
         s->vhost_vdpa.shared->iova_range = iova_range;
         s->vhost_vdpa.shared->shadow_data = svq;
+        s->vhost_vdpa.shared->iova_tree = vhost_iova_tree_new(iova_range.first,
+                                                              iova_range.last);
     } else if (!is_datapath) {
         s->cvq_cmd_out_buffer = mmap(NULL, vhost_vdpa_net_cvq_cmd_page_len(),
                                      PROT_READ | PROT_WRITE,
-- 
MST


