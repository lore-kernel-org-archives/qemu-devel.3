Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271F1CA601F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 17:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFEnU-0000h7-5S; Fri, 09 Oct 2026 13:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3LirJagsKCgUsfrfslzqfynlttlqj.htrvjrz-ij0jqstslsz.twl@flex--namangulati.bounces.google.com>)
 id 1xFEn5-0000V2-F2
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 13:53:55 -0400
Received: from mail-qv1-xf47.google.com ([2607:f8b0:4864:20::f47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3LirJagsKCgUsfrfslzqfynlttlqj.htrvjrz-ij0jqstslsz.twl@flex--namangulati.bounces.google.com>)
 id 1xFEn3-0006FD-28
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 13:53:55 -0400
Received: by mail-qv1-xf47.google.com with SMTP id
 6a1803df08f44-917a2de2cc1so1399566d6.1
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 10:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791568431; x=1792173231; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FppzXirk5nbi9kcMOQQwDE1EGZz6Q2GpCC2ECGaKeOQ=;
 b=WnAdPo+wVSnt6K0X0Ap+f32VUcsY9j4b7l4JCXMYMbqpT+dIujpECn632YZiuBHVMM
 BHce5UriMJoIbScB7nD3Js0uX8qh3hqkKbRoZW5EP8ZUwmYO0HXeEoTm+Sc5HB3H/ep/
 TtueyI9yamMwTtP7GHw+CNkkG/8dK2k9uEjGSRQ6N6U5RcebpSnWSj0pZ26W4ewnSFY9
 Akc/2rutUbvKz6drdt3vO3oMz+oZKUpwq1k+f7gWfeokGWDzyAmwyTysgClWko5CPw/1
 dv4hzZhSN9smQAg+zS8RRgZ0VRgjd6im128c+BkzBdaTNpaVYCjIEjnCAt8RO5uiz2RU
 CkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791568431; x=1792173231;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FppzXirk5nbi9kcMOQQwDE1EGZz6Q2GpCC2ECGaKeOQ=;
 b=cnj6abxkMHurDo7lzOYKXrm8exE83OEFKa39s0hQevpMeaVV5hH/K6lR9b0qq3iA0G
 n/Jsb8KF4P4+2dVm15dhprCVHu3wQ6w4bhqYAryG49gEvHh+SK2f/NPulPkTSPvS/7J0
 JwcLI01baYKZaj1uJXd04qDe4B7naLL95VxJ/zENRCdUed8zsuTKu/cYcV7QoDrjdwJR
 XaXM0m3LNt2Z0gp+9jbsziTUU7B5VmJojBHMRY2nx1NtMpOz6T4FL/HTn4Ngxfx427af
 n/3AIqFDQqwb5dsLy+hKsEJ3p2ch5eBepV+5UF9uvHI68OV9jd8QynnYLchnMafyu32f
 //cg==
X-Gm-Message-State: AFq9FYIJ5pTZCsK1hp8Ijd/tqnACEPCKSPnO87VdcDWuitm23QS6z/lt
 LbID7/egJfbaOHBFWrTi+6R8DudUhUXbhLazTE8eBXyUnpsff9spswYAeuyB5uU3pBmOz5MnJ4x
 67WeLiGIHrVtFIMnMjMUxSB3zG9+iAp4Op9lj9/JSshxBt1DC7TLwjSZIfx8QkJ/pMsbHqiL6QH
 8DUHVSeStP/2rHfT3P0v7cmjAgcU3EBa0GnqfX+L7T2YmGCoQWuM69auUrdcmeWQ==
X-Received: from qtbkc3.prod.google.com ([2002:a05:622a:44c3:b0:535:27c9:d69f])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1c15:b0:533:21c6:f4e2 with SMTP id
 d75a77b69052e-5359fa9087cmr41452201cf.20.1791568430294; 
 Fri, 09 Oct 2026 10:53:50 -0700 (PDT)
Date: Fri,  9 Oct 2026 17:53:12 +0000
In-Reply-To: <20261009175314.1823347-1-namangulati@google.com>
Mime-Version: 1.0
References: <20261009175314.1823347-1-namangulati@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261009175314.1823347-3-namangulati@google.com>
Subject: [PATCH v4 2/4] vfio: add 'fd' and 'fd_offset' to VFIOMmap
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f47;
 envelope-from=3LirJagsKCgUsfrfslzqfynlttlqj.htrvjrz-ij0jqstslsz.twl@flex--namangulati.bounces.google.com;
 helo=mail-qv1-xf47.google.com
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


