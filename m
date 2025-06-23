Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E012C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 20:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTnRo-00062L-65; Mon, 23 Jun 2025 16:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRm-00061v-6G
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRk-0003XX-1H
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750709235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lUT4tA+I1mPhrKrO2EQ1v652RlxqlKsmxz8JH5eS1nQ=;
 b=RyAzGsMZppPbWUxtRjRVzCvBYrt8QQ32yTeNxJKAV9bLrOnljRZiUoq9M+JT7hQzvn774k
 gIquxcZhiKfrNXDPzGQH6Mofbn9ICTVEkiBlo+0nt9eiN4E2LyolP7WXgpVeBZTRn9a+rB
 HNVLoSNvEbTMMpasRwpE0nm9ilk+rQA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-RVoaFDRMNW-CXeo4f8bMfg-1; Mon, 23 Jun 2025 16:07:14 -0400
X-MC-Unique: RVoaFDRMNW-CXeo4f8bMfg-1
X-Mimecast-MFC-AGG-ID: RVoaFDRMNW-CXeo4f8bMfg_1750709233
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6faca0f2677so119562226d6.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 13:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750709233; x=1751314033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lUT4tA+I1mPhrKrO2EQ1v652RlxqlKsmxz8JH5eS1nQ=;
 b=oYN3eV4Sm8qIxsSD5KhYzucJenGUNH3kC3pWt97WZTRGF68lsUxFs9uWLHqOfu7sEx
 5Ymz2ScCx4gZOOrEroWNNey6/D2FRbIvkEa/NOVIddLeZ3o1297HuMl7ZCVy9cDEKuod
 xzd3X9VbossDWfXH22zeEU/y0GePZUje44itWgNc0bdlmpGgaWxsk7eZRKMYpAMTnvjC
 vc416lk6zhX7GLTtKpSQEWShYlXV3oIwc3ngEFf4Cjr7nA4l6pXvcbrJPDkquzSN/Elg
 u7N4qq73K4LdWKu5lvAMWwhC/qOJyB4Zr3HG3XuwHyGJGxADgJH4k/7/gShPFiWtuhl7
 A8Nw==
X-Gm-Message-State: AOJu0YwuaJ37SW+PiyqTbYDDh+Qn048AxZafzvlboldEsCM3T7ZhPVk6
 FSgpITgU5QMbQf2vD9FdU60864sjBMy1oTUBdArX77fcBsAHZ+lGvzJNYnNFXpEB2NifEvkyLF1
 GTnnRlHcbv8s1voLNL9WClIYHLxbZsfCl2j3+ggao/vPpMijnD8JmEwIm7x+ocQcVnQW+O9bkRt
 My6ah/RurpKfc66OpfrmC0W5f+n81flxdRgXa1eg==
X-Gm-Gg: ASbGnctucTUE79oJU4ZCMCKyvIELKsWQqwUGi9wNInnKNcSX8OesR4CyPB8F6t0yFn2
 whQE5oIbDO0rkph4oXEcR588PolcvD3RkWNKvaAKubBj0zfdNCwoLL9LZsrohbhswv3yFJAKDFu
 dmTVl/qlEe3wkEHBcfO4LntWkN9vBeQPY7c8hUi+BXTJo/5wvWJibqvG0nPAylhUK5G51BZlvCt
 +P4zUvfgjkamSsNRIeVqDmU8urIcL21iRcfGi5gNkEG/afvkSMy2ds8Y4rVzypq7PSLpsMsIM+z
 TH5L+2qGcvQ=
X-Received: by 2002:a05:6214:3215:b0:6e8:ddf6:d11e with SMTP id
 6a1803df08f44-6fd0a51c380mr259710916d6.21.1750709233124; 
 Mon, 23 Jun 2025 13:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/Z83eO7wheNim+h2DDKT/NnR2LLQgNr7jwC1IqZ+qELfvGFTqRrrwtg+gWVtyUR0AuinwaQ==
X-Received: by 2002:a05:6214:3215:b0:6e8:ddf6:d11e with SMTP id
 6a1803df08f44-6fd0a51c380mr259710396d6.21.1750709232584; 
 Mon, 23 Jun 2025 13:07:12 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd095a775bsm48427976d6.112.2025.06.23.13.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 13:07:11 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 09/11] memory: Unify the definiton of ReplayRamPopulate() and
 ReplayRamDiscard()
Date: Mon, 23 Jun 2025 16:06:54 -0400
Message-ID: <20250623200656.1882674-10-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623200656.1882674-1-peterx@redhat.com>
References: <20250623200656.1882674-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Chenyi Qiang <chenyi.qiang@intel.com>

Update ReplayRamDiscard() function to return the result and unify the
ReplayRamPopulate() and ReplayRamDiscard() to ReplayRamDiscardState() at
the same time due to their identical definitions. This unification
simplifies related structures, such as VirtIOMEMReplayData, which makes
it cleaner.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
Link: https://lore.kernel.org/r/20250612082747.51539-4-chenyi.qiang@intel.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h | 74 +++++++++++++++++++++++++++++++----------
 hw/virtio/virtio-mem.c  | 21 ++++++------
 migration/ram.c         |  5 +--
 system/memory.c         | 12 +++----
 4 files changed, 76 insertions(+), 36 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 60983d4977..46248d4a52 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -576,8 +576,20 @@ static inline void ram_discard_listener_init(RamDiscardListener *rdl,
     rdl->double_discard_supported = double_discard_supported;
 }
 
-typedef int (*ReplayRamPopulate)(MemoryRegionSection *section, void *opaque);
-typedef void (*ReplayRamDiscard)(MemoryRegionSection *section, void *opaque);
+/**
+ * typedef ReplayRamDiscardState:
+ *
+ * The callback handler for #RamDiscardManagerClass.replay_populated/
+ * #RamDiscardManagerClass.replay_discarded to invoke on populated/discarded
+ * parts.
+ *
+ * @section: the #MemoryRegionSection of populated/discarded part
+ * @opaque: pointer to forward to the callback
+ *
+ * Returns 0 on success, or a negative error if failed.
+ */
+typedef int (*ReplayRamDiscardState)(MemoryRegionSection *section,
+                                     void *opaque);
 
 /*
  * RamDiscardManagerClass:
@@ -651,36 +663,38 @@ struct RamDiscardManagerClass {
     /**
      * @replay_populated:
      *
-     * Call the #ReplayRamPopulate callback for all populated parts within the
-     * #MemoryRegionSection via the #RamDiscardManager.
+     * Call the #ReplayRamDiscardState callback for all populated parts within
+     * the #MemoryRegionSection via the #RamDiscardManager.
      *
      * In case any call fails, no further calls are made.
      *
      * @rdm: the #RamDiscardManager
      * @section: the #MemoryRegionSection
-     * @replay_fn: the #ReplayRamPopulate callback
+     * @replay_fn: the #ReplayRamDiscardState callback
      * @opaque: pointer to forward to the callback
      *
      * Returns 0 on success, or a negative error if any notification failed.
      */
     int (*replay_populated)(const RamDiscardManager *rdm,
                             MemoryRegionSection *section,
-                            ReplayRamPopulate replay_fn, void *opaque);
+                            ReplayRamDiscardState replay_fn, void *opaque);
 
     /**
      * @replay_discarded:
      *
-     * Call the #ReplayRamDiscard callback for all discarded parts within the
-     * #MemoryRegionSection via the #RamDiscardManager.
+     * Call the #ReplayRamDiscardState callback for all discarded parts within
+     * the #MemoryRegionSection via the #RamDiscardManager.
      *
      * @rdm: the #RamDiscardManager
      * @section: the #MemoryRegionSection
-     * @replay_fn: the #ReplayRamDiscard callback
+     * @replay_fn: the #ReplayRamDiscardState callback
      * @opaque: pointer to forward to the callback
+     *
+     * Returns 0 on success, or a negative error if any notification failed.
      */
-    void (*replay_discarded)(const RamDiscardManager *rdm,
-                             MemoryRegionSection *section,
-                             ReplayRamDiscard replay_fn, void *opaque);
+    int (*replay_discarded)(const RamDiscardManager *rdm,
+                            MemoryRegionSection *section,
+                            ReplayRamDiscardState replay_fn, void *opaque);
 
     /**
      * @register_listener:
@@ -721,15 +735,41 @@ uint64_t ram_discard_manager_get_min_granularity(const RamDiscardManager *rdm,
 bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
                                       const MemoryRegionSection *section);
 
+/**
+ * ram_discard_manager_replay_populated:
+ *
+ * A wrapper to call the #RamDiscardManagerClass.replay_populated callback
+ * of the #RamDiscardManager.
+ *
+ * @rdm: the #RamDiscardManager
+ * @section: the #MemoryRegionSection
+ * @replay_fn: the #ReplayRamDiscardState callback
+ * @opaque: pointer to forward to the callback
+ *
+ * Returns 0 on success, or a negative error if any notification failed.
+ */
 int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
                                          MemoryRegionSection *section,
-                                         ReplayRamPopulate replay_fn,
+                                         ReplayRamDiscardState replay_fn,
                                          void *opaque);
 
-void ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
-                                          MemoryRegionSection *section,
-                                          ReplayRamDiscard replay_fn,
-                                          void *opaque);
+/**
+ * ram_discard_manager_replay_discarded:
+ *
+ * A wrapper to call the #RamDiscardManagerClass.replay_discarded callback
+ * of the #RamDiscardManager.
+ *
+ * @rdm: the #RamDiscardManager
+ * @section: the #MemoryRegionSection
+ * @replay_fn: the #ReplayRamDiscardState callback
+ * @opaque: pointer to forward to the callback
+ *
+ * Returns 0 on success, or a negative error if any notification failed.
+ */
+int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
+                                         MemoryRegionSection *section,
+                                         ReplayRamDiscardState replay_fn,
+                                         void *opaque);
 
 void ram_discard_manager_register_listener(RamDiscardManager *rdm,
                                            RamDiscardListener *rdl,
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 2e491e8c44..c46f6f9c3e 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1732,7 +1732,7 @@ static bool virtio_mem_rdm_is_populated(const RamDiscardManager *rdm,
 }
 
 struct VirtIOMEMReplayData {
-    void *fn;
+    ReplayRamDiscardState fn;
     void *opaque;
 };
 
@@ -1740,12 +1740,12 @@ static int virtio_mem_rdm_replay_populated_cb(MemoryRegionSection *s, void *arg)
 {
     struct VirtIOMEMReplayData *data = arg;
 
-    return ((ReplayRamPopulate)data->fn)(s, data->opaque);
+    return data->fn(s, data->opaque);
 }
 
 static int virtio_mem_rdm_replay_populated(const RamDiscardManager *rdm,
                                            MemoryRegionSection *s,
-                                           ReplayRamPopulate replay_fn,
+                                           ReplayRamDiscardState replay_fn,
                                            void *opaque)
 {
     const VirtIOMEM *vmem = VIRTIO_MEM(rdm);
@@ -1764,14 +1764,13 @@ static int virtio_mem_rdm_replay_discarded_cb(MemoryRegionSection *s,
 {
     struct VirtIOMEMReplayData *data = arg;
 
-    ((ReplayRamDiscard)data->fn)(s, data->opaque);
-    return 0;
+    return data->fn(s, data->opaque);
 }
 
-static void virtio_mem_rdm_replay_discarded(const RamDiscardManager *rdm,
-                                            MemoryRegionSection *s,
-                                            ReplayRamDiscard replay_fn,
-                                            void *opaque)
+static int virtio_mem_rdm_replay_discarded(const RamDiscardManager *rdm,
+                                           MemoryRegionSection *s,
+                                           ReplayRamDiscardState replay_fn,
+                                           void *opaque)
 {
     const VirtIOMEM *vmem = VIRTIO_MEM(rdm);
     struct VirtIOMEMReplayData data = {
@@ -1780,8 +1779,8 @@ static void virtio_mem_rdm_replay_discarded(const RamDiscardManager *rdm,
     };
 
     g_assert(s->mr == &vmem->memdev->mr);
-    virtio_mem_for_each_unplugged_section(vmem, s, &data,
-                                          virtio_mem_rdm_replay_discarded_cb);
+    return virtio_mem_for_each_unplugged_section(vmem, s, &data,
+                                                 virtio_mem_rdm_replay_discarded_cb);
 }
 
 static void virtio_mem_rdm_register_listener(RamDiscardManager *rdm,
diff --git a/migration/ram.c b/migration/ram.c
index 024d8b3d03..2140785a05 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -856,8 +856,8 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
     return ret;
 }
 
-static void dirty_bitmap_clear_section(MemoryRegionSection *section,
-                                       void *opaque)
+static int dirty_bitmap_clear_section(MemoryRegionSection *section,
+                                      void *opaque)
 {
     const hwaddr offset = section->offset_within_region;
     const hwaddr size = int128_get64(section->size);
@@ -876,6 +876,7 @@ static void dirty_bitmap_clear_section(MemoryRegionSection *section,
     }
     *cleared_bits += bitmap_count_one_with_offset(rb->bmap, start, npages);
     bitmap_clear(rb->bmap, start, npages);
+    return 0;
 }
 
 /*
diff --git a/system/memory.c b/system/memory.c
index d0c186e9f6..76b44b8220 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2138,7 +2138,7 @@ bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
 
 int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
                                          MemoryRegionSection *section,
-                                         ReplayRamPopulate replay_fn,
+                                         ReplayRamDiscardState replay_fn,
                                          void *opaque)
 {
     RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_GET_CLASS(rdm);
@@ -2147,15 +2147,15 @@ int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
     return rdmc->replay_populated(rdm, section, replay_fn, opaque);
 }
 
-void ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
-                                          MemoryRegionSection *section,
-                                          ReplayRamDiscard replay_fn,
-                                          void *opaque)
+int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
+                                         MemoryRegionSection *section,
+                                         ReplayRamDiscardState replay_fn,
+                                         void *opaque)
 {
     RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_GET_CLASS(rdm);
 
     g_assert(rdmc->replay_discarded);
-    rdmc->replay_discarded(rdm, section, replay_fn, opaque);
+    return rdmc->replay_discarded(rdm, section, replay_fn, opaque);
 }
 
 void ram_discard_manager_register_listener(RamDiscardManager *rdm,
-- 
2.49.0


