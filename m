Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E327BC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 22:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6yHK-00037T-59; Wed, 16 Sep 2026 18:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3eBqragsKCrUiVhVibpgVodbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--namangulati.bounces.google.com>)
 id 1x6yHF-00036f-KS
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 18:38:53 -0400
Received: from mail-qk1-x747.google.com ([2607:f8b0:4864:20::747])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3eBqragsKCrUiVhVibpgVodbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--namangulati.bounces.google.com>)
 id 1x6yHC-0006zR-Ft
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 18:38:52 -0400
Received: by mail-qk1-x747.google.com with SMTP id
 af79cd13be357-934956beec8so34862585a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 15:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789598328; x=1790203128; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=63YJ0YQfQIblNFZSy78YMF4B/IKo3iiX9RepmEXFxiU=;
 b=mR05M2YmCQHTF1DgX8GE9wpnGMOSEDaOrSZz6o3wfP248UXgwWcUxeCaYYm8YeDF3x
 CZb14uRze5GrmscGIFL7MlxG6XfdMy7ffHbgaNkOQ8Nt+s97Sftn5qW4EtrRQccY9hgr
 boy21YPJ7O5tVx3QRzZYIt5zrQ+kyczKxqPJ83pzetAokn2VJiE1Y+hYDFXdwKJNs/Ws
 H5X5zbTQ/w+RQtByVcvOJl/PO0NrqX8ZFFMkK0ZMlVCcXR7CvC3xdTRe77rYcqdcJ6bp
 ZBhpSqRS2aDCC/S5kzj/NTp39kKCmAUL7kjdv/tVYxpkNv18gWdQ8iFQsTQqnhUIpuuX
 T+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789598328; x=1790203128;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=63YJ0YQfQIblNFZSy78YMF4B/IKo3iiX9RepmEXFxiU=;
 b=VCYofUXsgA3SekrXkurpGGXc8NcBSMa1BeBuLKqaXBAU0uCVcKggYvesi75FgZFIkT
 +NVGS8k6989/GHATs1Ev8rX26ina8k4ZX3WOrhmPQoQoA7nuACyN5moyw1Ald6voh24h
 od9+feM8UnyXD6UzkS98fNiCD7ZmPlzcmGWg/CnAh0pQTEvyq/4m4i21duxBNJmQQeoR
 ovvRamUoCsJiRgz4QUtiTCUTQbDaT/QRoOnDIA1xFGrgk+W/TVI8eFR5BX9TrNHPRGL2
 f/9Wv39JnAlV2Xmt5ghvZCN8J+NNVOCVaKpx6sNWboWIrep/1AE3Pnp482W3NccwIoQT
 mTig==
X-Gm-Message-State: AFuF++lDGVZaQbBT3sEbCINQgyrYoMiiu26DUz6N1wYYoo6W8FRDgXkn
 cUGQMX5sv7w6+tlSh1fIk4JWHrkt331u8dCnXFNdxHL9w4UHj510HRbIL0KRGH7BIOJTR4SNiM9
 KsKDsESyNv+2mjflAoXuLlKX6HqBXahpsyTkU+barUL8bbFpMSI+0a+wPpj//6hKXaycCOT5JeR
 41jWTPrmGh5FyoHk4rVmZXav/LP2lTBYAxQSaTpIiypbtKsmfnMsCSajgmVTCRFQ==
X-Received: from qkbe17-n2.prod.google.com
 ([2002:a05:620a:a411:20b0:939:fefa:5251])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:28cc:b0:939:6dea:4f1b with SMTP id
 af79cd13be357-93bb7947dd8mr718538685a.49.1789598328144; 
 Wed, 16 Sep 2026 15:38:48 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:38:41 +0000
In-Reply-To: <20260916223843.3995552-1-namangulati@google.com>
Mime-Version: 1.0
References: <20260916223843.3995552-1-namangulati@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916223843.3995552-3-namangulati@google.com>
Subject: [PATCH v3 2/4] vfio: add 'fd' and 'fd_offset' to VFIOMmap
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::747;
 envelope-from=3eBqragsKCrUiVhVibpgVodbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--namangulati.bounces.google.com;
 helo=mail-qk1-x747.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Allow each sparse mmap subregion to specify its own file descriptor and
file offset for the mmap call.

Add 'fd' (set to -1 when the region fd should be used) and 'fd_offset'
to VFIOMmap, and update vfio_region_mmap() to use them.

Signed-off-by: Naman Gulati <namangulati@google.com>
---
 hw/vfio/vfio-region.h |  4 +++-
 hw/vfio/pci.c         |  2 ++
 hw/vfio/region.c      | 26 +++++++++++++++++++-------
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
index 58b236f113..9f6a5cf7d5 100644
--- a/hw/vfio/vfio-region.h
+++ b/hw/vfio/vfio-region.h
@@ -14,8 +14,10 @@
 typedef struct VFIOMmap {
     MemoryRegion mem;
     void *mmap;
-    off_t offset;
+    off_t offset;       /* offset within the region */
     size_t size;
+    int fd;             /* per-mmap fd, or -1 to use the region fd */
+    uint64_t fd_offset; /* offset within fd for the mmap call */
 } VFIOMmap;
 
 typedef struct VFIODevice VFIODevice;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c204706e63..0a61a060d9 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1608,6 +1608,7 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
                                   vdev->msix->table_bar, 0, 0);
         } else {
             region->mmaps[0].offset = end;
+            region->mmaps[0].fd_offset += end;
             region->mmaps[0].size = region->size - end;
             trace_vfio_msix_fixup(vdev->vbasedev.name,
                               vdev->msix->table_bar, region->mmaps[0].offset,
@@ -1634,6 +1635,7 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
                               region->mmaps[0].offset + region->mmaps[0].size);
 
         region->mmaps[1].offset = end;
+        region->mmaps[1].fd_offset += end;
         region->mmaps[1].size = region->size - end;
         trace_vfio_msix_fixup(vdev->vbasedev.name,
                               vdev->msix->table_bar, region->mmaps[1].offset,
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index dbde339180..3c746200ca 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -189,6 +189,9 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
                                             sparse->areas[i].size - 1);
             region->mmaps[j].offset = sparse->areas[i].offset;
             region->mmaps[j].size = sparse->areas[i].size;
+            region->mmaps[j].fd = -1;
+            region->mmaps[j].fd_offset = region->fd_offset +
+                                         sparse->areas[i].offset;
             j++;
         }
     }
@@ -262,6 +265,8 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                 region->mmaps = g_new0(VFIOMmap, region->nr_mmaps);
                 region->mmaps[0].offset = 0;
                 region->mmaps[0].size = region->size;
+                region->mmaps[0].fd = -1;
+                region->mmaps[0].fd_offset = region->fd_offset;
             } else if (ret) {
                 return ret;
             }
@@ -355,7 +360,6 @@ int vfio_region_mmap(VFIORegion *region)
     off_t map_offset = 0;
     size_t align;
     char *name;
-    int fd;
 
     if (!region->mem || !region->nr_mmaps) {
         return 0;
@@ -392,8 +396,6 @@ int vfio_region_mmap(VFIORegion *region)
         return ret;
     }
 
-    fd = vfio_device_get_region_fd(region->vbasedev, region->nr);
-
     map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
     munmap(map_base, map_align - map_base);
     munmap(map_align + region->size,
@@ -405,12 +407,22 @@ int vfio_region_mmap(VFIORegion *region)
      * offsets being in ascending order.
      */
     for (i = 0; i < region->nr_mmaps; i++) {
+        int fd = region->mmaps[i].fd;
+
+        if (fd < 0) {
+            fd = vfio_device_get_region_fd(region->vbasedev, region->nr);
+        }
+        if (fd < 0) {
+            ret = -EINVAL;
+            munmap(map_align + map_offset, region->size - map_offset);
+            goto no_mmap;
+        }
+
         munmap(map_align + map_offset, region->mmaps[i].offset - map_offset);
         region->mmaps[i].mmap = mmap(map_align + region->mmaps[i].offset,
                                      region->mmaps[i].size, prot,
                                      MAP_SHARED | MAP_FIXED, fd,
-                                     region->fd_offset +
-                                     region->mmaps[i].offset);
+                                     region->mmaps[i].fd_offset);
         if (region->mmaps[i].mmap == MAP_FAILED) {
             ret = -errno;
             /*
@@ -455,8 +467,8 @@ int vfio_region_mmap(VFIORegion *region)
 
 no_mmap:
     trace_vfio_region_mmap_fault(memory_region_name(region->mem), i,
-                                 region->fd_offset + region->mmaps[i].offset,
-                                 region->fd_offset + region->mmaps[i].offset +
+                                 region->mmaps[i].fd_offset,
+                                 region->mmaps[i].fd_offset +
                                  region->mmaps[i].size - 1, ret);
 
     region->mmaps[i].mmap = NULL;
-- 
2.55.0.1082.g2b9226bbc0-goog


