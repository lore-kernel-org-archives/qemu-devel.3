Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60F2CC6B2D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6FV-0007M9-Ux; Wed, 14 Oct 2026 17:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <31e_PagsKClI7u6u70E5uD208805y.w86Ay6E-xyFy578707E.8B0@flex--namangulati.bounces.google.com>)
 id 1xH6FS-0007Cn-Os
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:10:54 -0400
Received: from mail-qv1-xf45.google.com ([2607:f8b0:4864:20::f45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <31e_PagsKClI7u6u70E5uD208805y.w86Ay6E-xyFy578707E.8B0@flex--namangulati.bounces.google.com>)
 id 1xH6FQ-0001Di-5S
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:10:54 -0400
Received: by mail-qv1-xf45.google.com with SMTP id
 6a1803df08f44-91b8c60c550so81487026d6.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792012246; x=1792617046; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FppzXirk5nbi9kcMOQQwDE1EGZz6Q2GpCC2ECGaKeOQ=;
 b=u/9ecppcNrMnAxU62XTywYU5QRMIYbBJ3BPtqfIDfnYnNm1gappG302AOsQB6W3g06
 9AAnWwduPJUxw7R+atjNH/vkIMoncHmeUpnqV5tj1Apyz6jIR/i/djSMAJI0Ih4efIie
 Cd8w2fxxGFYbKDjYxXN1Yp1tcw574bgw6KuHbzkT+8x7URD4NJ1DJGnzXk5J7htL73rt
 egXoCafM25i6VtCwueSAeaHOmrMMunS6YUQMtGu2sWBjDkuTctchm5UF3OdUtFoEiNqD
 kIWb8hsen5j7cymZSMPNDycHkiqqSATmaO/IKtTCywFJUitj+cUKLpa1uNFGl8HwZfbL
 b0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792012246; x=1792617046;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FppzXirk5nbi9kcMOQQwDE1EGZz6Q2GpCC2ECGaKeOQ=;
 b=Nhw/ae7J6BeIDGS1u6giDUF0mQF3NA1X6lA1YhL9IzkYoaXRUFTr1MBF0io2k43tiv
 31DkCk7LvbDvM+uzltJAPWlxHYydUvKDH3eEVYgZaOnbga90sMQO87UQr1n4aX7Dbs0q
 aUx4VuObkrwzauKOdfSZnaLVcaKD8nG07+qKEGfZZEN8J4jDJb+wSH5hCnrqLIWDhxLH
 2J7f7kb+3jmHIDQ5VPeXlEAPAh0JEQkM0cau4/lU1tG/uK7zGSykIvAWKcPH7DIjd7bz
 Dw6kmBJNqax/MffMeUCoJ8E7BZEkAunftJdNS9tIuBk7xWl3IBCMyuRhVf+CEy4fx3Y3
 FKUw==
X-Gm-Message-State: AFq9FYLGpBSufOl1KW+72TGRjcdo8SxqEOiZKfCo7AX2Jt3qFbsP4TLV
 PJ/4h1yOvltIHO0dKQc5p6dir2BdnaoxpUVuVwY+XaywmefqVmHT3+1htwHGMCtJiY0L5uZh2q9
 olDP0qyKIYss1wSW+L2tNsGvWcf7IB9eUfhiXwToyFREY8H4tKuE7eT2OO5vRGxSgDFP5Gq2Eus
 kXe2ZWQNZwRfZExojWi7H1eZ/9prtTxksgEl/PjpDhKu316hX0pt21HRvFV/cWuA==
X-Received: from qvuc11.prod.google.com ([2002:a05:6214:1eb:b0:919:85db:35a7])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:5085:b0:917:8d3f:29da with SMTP id
 6a1803df08f44-91b557cbea3mr298663626d6.27.1792012245728; 
 Wed, 14 Oct 2026 14:10:45 -0700 (PDT)
Date: Wed, 14 Oct 2026 21:10:39 +0000
In-Reply-To: <20261014211041.1087331-1-namangulati@google.com>
Mime-Version: 1.0
References: <20261014211041.1087331-1-namangulati@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261014211041.1087331-3-namangulati@google.com>
Subject: [PATCH v5 2/4] vfio: add 'fd' and 'fd_offset' to VFIOMmap
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f45;
 envelope-from=31e_PagsKClI7u6u70E5uD208805y.w86Ay6E-xyFy578707E.8B0@flex--namangulati.bounces.google.com;
 helo=mail-qv1-xf45.google.com
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

Reviewed-by: Thanos Makatos <thanos.makatos@nutanix.com>
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
index 428ab2f069..f851082114 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1623,6 +1623,7 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
                                   vdev->msix->table_bar, 0, 0);
         } else {
             region->mmaps[0].offset = end;
+            region->mmaps[0].fd_offset += end;
             region->mmaps[0].size = region->size - end;
             trace_vfio_msix_fixup(vdev->vbasedev.name,
                               vdev->msix->table_bar, region->mmaps[0].offset,
@@ -1649,6 +1650,7 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
                               region->mmaps[0].offset + region->mmaps[0].size);
 
         region->mmaps[1].offset = end;
+        region->mmaps[1].fd_offset += end;
         region->mmaps[1].size = region->size - end;
         trace_vfio_msix_fixup(vdev->vbasedev.name,
                               vdev->msix->table_bar, region->mmaps[1].offset,
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 54ad11a6c8..16efed2fce 100644
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
@@ -354,7 +359,6 @@ int vfio_region_mmap(VFIORegion *region)
     off_t map_offset = 0;
     size_t align;
     char *name;
-    int fd;
 
     if (!region->mem || !region->nr_mmaps) {
         return 0;
@@ -391,8 +395,6 @@ int vfio_region_mmap(VFIORegion *region)
         return ret;
     }
 
-    fd = vfio_device_get_region_fd(region->vbasedev, region->nr);
-
     map_align = (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
     munmap(map_base, map_align - map_base);
     munmap(map_align + region->size,
@@ -404,12 +406,22 @@ int vfio_region_mmap(VFIORegion *region)
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
@@ -454,8 +466,8 @@ int vfio_region_mmap(VFIORegion *region)
 
 no_mmap:
     trace_vfio_region_mmap_fault(memory_region_name(region->mem), i,
-                                 region->fd_offset + region->mmaps[i].offset,
-                                 region->fd_offset + region->mmaps[i].offset +
+                                 region->mmaps[i].fd_offset,
+                                 region->mmaps[i].fd_offset +
                                  region->mmaps[i].size - 1, ret);
 
     region->mmaps[i].mmap = NULL;
-- 
2.56.0.385.gd3acb90ef8-goog


