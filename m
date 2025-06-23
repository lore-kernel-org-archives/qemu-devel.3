Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E11C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 20:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTnRn-000626-7s; Mon, 23 Jun 2025 16:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRl-00061d-By
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uTnRj-0003XN-0F
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 16:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750709234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/3L0JgRIIpPvnyIt/DuhPM++hXdQ8FkNjZdS8qxC18=;
 b=cn9KHomSOlzJZUE4YTFXT0Z1iQXiO6MbET6rdLdj7BAJDBwxEXbbTHskq8YMsm/iAvEqLV
 1sa7AU2eFsNGAg+lZXXZf12W2jZj2omR6jpiUtnCMEobuvCa+uzcqSL2MGWWS4CheGE6wp
 tOonT3+v91dFAAh1mdntLWwwCRrXmqc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-JjMvXiGEP2i2IrlYlQkQ1w-1; Mon, 23 Jun 2025 16:07:13 -0400
X-MC-Unique: JjMvXiGEP2i2IrlYlQkQ1w-1
X-Mimecast-MFC-AGG-ID: JjMvXiGEP2i2IrlYlQkQ1w_1750709233
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6facf4cf5e1so81559436d6.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 13:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750709232; x=1751314032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A/3L0JgRIIpPvnyIt/DuhPM++hXdQ8FkNjZdS8qxC18=;
 b=W3OBhv3EVH0a7H9yBaC5QEZSBj+lfss6zoBIkCI3ZomqAKjJqm1HeRHW3S6UjqnhA+
 kV6kIiN/3TANPtrlAQTLH7CBT8fin8wYTgdFd3RLa130Frnhxqr55nT990dBOc+1OKOZ
 XkkPWXjsQ48BMLomjO+cbtUMjdq6n0ZWpZoRIpWQNUc//IQCRWuUxAQA7t/iunl/3Pbi
 HnJFqKDDA8JYPpphoXGuRpxxF8/PGYoGP8BUFlJa8UYt94brTIuM2FmsZbouaTMS4mqu
 AI8Tb4sdfADTRuYgCOAvinzlmW0slxB0cVyS7VwigSXj5H3GSrThozB1th2VpCvpHjP2
 L3TA==
X-Gm-Message-State: AOJu0YyPl2sXZGEejyLIrjztvubAIyXrMdzjslEk4ECdT6lOPIl2WPH1
 2Wv5e+9J56XlhiRNs0RflXDcUeNAzIOQYxXZm+9iC3FYr3xcP/xBBNmylUb2u5mpG9ynOtrGUqm
 ft9pkGcYZkDxs9XsFbR4MCY23/lU0meOcTTVA4BBuTRvUcypp2wJ3bQbc/d6Yc1dFVzmszqI6WS
 KtWIdH7KeTZdzuxE4oE7wqgpMUJuXJ7kGcRGGs5g==
X-Gm-Gg: ASbGnct8PeZqmQcPVmhkSM8H4XXnuRLBvkvabIAvTsoVNtkJ/93kaRO2un7NfUC9ell
 5cjzUT0zGHgJT4hKLRxXilTWzh7iKi8+oYuWJ4ORJeCVtqL/yKirSLnPWsej4GTRTwIXwIhK5G9
 HMSqlhj0mD/lSHt3Hg4utWdHdnLwTz8wjB60Se67UoSeKLU34Npc5Ba21m8Of53F40dpE7eZHUQ
 nQlN2h2hX188znh8e0Z+DlIvXBMLkPcfjzvORSHEiV5/SZkvhkgqaCQDefEfiaG9StchFWdCwHt
 29oTT5+n8ok=
X-Received: by 2002:a05:6214:2427:b0:6fb:43d:65b7 with SMTP id
 6a1803df08f44-6fd0a5c1776mr253078406d6.36.1750709231835; 
 Mon, 23 Jun 2025 13:07:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq5HPDjvueENdrq/gVsj5vd+l29loefqeDGS8NXsvUWup9Z1OAaICTKWFBM9aqx+t2oxjYlQ==
X-Received: by 2002:a05:6214:2427:b0:6fb:43d:65b7 with SMTP id
 6a1803df08f44-6fd0a5c1776mr253077936d6.36.1750709231376; 
 Mon, 23 Jun 2025 13:07:11 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd095a775bsm48427976d6.112.2025.06.23.13.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 13:07:10 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Alexey Kardashevskiy <aik@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 08/11] memory: Change memory_region_set_ram_discard_manager()
 to return the result
Date: Mon, 23 Jun 2025 16:06:53 -0400
Message-ID: <20250623200656.1882674-9-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623200656.1882674-1-peterx@redhat.com>
References: <20250623200656.1882674-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Modify memory_region_set_ram_discard_manager() to return -EBUSY if a
RamDiscardManager is already set in the MemoryRegion. The caller must
handle this failure, such as having virtio-mem undo its actions and fail
the realize() process. Opportunistically move the call earlier to avoid
complex error handling.

This change is beneficial when introducing a new RamDiscardManager
instance besides virtio-mem. After
ram_block_coordinated_discard_require(true) unlocks all
RamDiscardManager instances, only one instance is allowed to be set for
one MemoryRegion at present.

Suggested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Tested-by: Alexey Kardashevskiy <aik@amd.com>
Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
Link: https://lore.kernel.org/r/20250612082747.51539-3-chenyi.qiang@intel.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h |  6 +++---
 hw/virtio/virtio-mem.c  | 30 +++++++++++++++++-------------
 system/memory.c         | 10 +++++++---
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index da97753e28..60983d4977 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2499,13 +2499,13 @@ static inline bool memory_region_has_ram_discard_manager(MemoryRegion *mr)
  *
  * This function must not be called for a mapped #MemoryRegion, a #MemoryRegion
  * that does not cover RAM, or a #MemoryRegion that already has a
- * #RamDiscardManager assigned.
+ * #RamDiscardManager assigned. Return 0 if the rdm is set successfully.
  *
  * @mr: the #MemoryRegion
  * @rdm: #RamDiscardManager to set
  */
-void memory_region_set_ram_discard_manager(MemoryRegion *mr,
-                                           RamDiscardManager *rdm);
+int memory_region_set_ram_discard_manager(MemoryRegion *mr,
+                                          RamDiscardManager *rdm);
 
 /**
  * memory_region_find: translate an address/size relative to a
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index b3c126ea1e..2e491e8c44 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1047,6 +1047,17 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /*
+     * Set ourselves as RamDiscardManager before the plug handler maps the
+     * memory region and exposes it via an address space.
+     */
+    if (memory_region_set_ram_discard_manager(&vmem->memdev->mr,
+                                              RAM_DISCARD_MANAGER(vmem))) {
+        error_setg(errp, "Failed to set RamDiscardManager");
+        ram_block_coordinated_discard_require(false);
+        return;
+    }
+
     /*
      * We don't know at this point whether shared RAM is migrated using
      * QEMU or migrated using the file content. "x-ignore-shared" will be
@@ -1061,6 +1072,7 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
         ret = ram_block_discard_range(rb, 0, qemu_ram_get_used_length(rb));
         if (ret) {
             error_setg_errno(errp, -ret, "Unexpected error discarding RAM");
+            memory_region_set_ram_discard_manager(&vmem->memdev->mr, NULL);
             ram_block_coordinated_discard_require(false);
             return;
         }
@@ -1122,13 +1134,6 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
     vmem->system_reset = VIRTIO_MEM_SYSTEM_RESET(obj);
     vmem->system_reset->vmem = vmem;
     qemu_register_resettable(obj);
-
-    /*
-     * Set ourselves as RamDiscardManager before the plug handler maps the
-     * memory region and exposes it via an address space.
-     */
-    memory_region_set_ram_discard_manager(&vmem->memdev->mr,
-                                          RAM_DISCARD_MANAGER(vmem));
 }
 
 static void virtio_mem_device_unrealize(DeviceState *dev)
@@ -1136,12 +1141,6 @@ static void virtio_mem_device_unrealize(DeviceState *dev)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOMEM *vmem = VIRTIO_MEM(dev);
 
-    /*
-     * The unplug handler unmapped the memory region, it cannot be
-     * found via an address space anymore. Unset ourselves.
-     */
-    memory_region_set_ram_discard_manager(&vmem->memdev->mr, NULL);
-
     qemu_unregister_resettable(OBJECT(vmem->system_reset));
     object_unref(OBJECT(vmem->system_reset));
 
@@ -1154,6 +1153,11 @@ static void virtio_mem_device_unrealize(DeviceState *dev)
     virtio_del_queue(vdev, 0);
     virtio_cleanup(vdev);
     g_free(vmem->bitmap);
+    /*
+     * The unplug handler unmapped the memory region, it cannot be
+     * found via an address space anymore. Unset ourselves.
+     */
+    memory_region_set_ram_discard_manager(&vmem->memdev->mr, NULL);
     ram_block_coordinated_discard_require(false);
 }
 
diff --git a/system/memory.c b/system/memory.c
index 306e9ff9eb..d0c186e9f6 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2106,12 +2106,16 @@ RamDiscardManager *memory_region_get_ram_discard_manager(MemoryRegion *mr)
     return mr->rdm;
 }
 
-void memory_region_set_ram_discard_manager(MemoryRegion *mr,
-                                           RamDiscardManager *rdm)
+int memory_region_set_ram_discard_manager(MemoryRegion *mr,
+                                          RamDiscardManager *rdm)
 {
     g_assert(memory_region_is_ram(mr));
-    g_assert(!rdm || !mr->rdm);
+    if (mr->rdm && rdm) {
+        return -EBUSY;
+    }
+
     mr->rdm = rdm;
+    return 0;
 }
 
 uint64_t ram_discard_manager_get_min_granularity(const RamDiscardManager *rdm,
-- 
2.49.0


