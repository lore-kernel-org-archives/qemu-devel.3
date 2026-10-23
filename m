Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F666606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RyH4CiYY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKNus-0006fA-M6; Fri, 23 Oct 2026 18:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3DOLbagsKCp0K7J7KDRI7QFDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--namangulati.bounces.google.com>)
 id 1xKNur-0006eK-1q
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 18:39:13 -0400
Received: from mail-qk1-x748.google.com ([2607:f8b0:4864:20::748])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3DOLbagsKCp0K7J7KDRI7QFDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--namangulati.bounces.google.com>)
 id 1xKNuo-0002li-WD
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 18:39:12 -0400
Received: by mail-qk1-x748.google.com with SMTP id
 af79cd13be357-936aa34873bso265597285a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792795149; x=1793399949; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=i3s6G9UXyyWKN96oYix/BdTbsZN/E2nnhD3cWxRyhVQ=;
 b=RyH4CiYYG8K23FaHPWfouNbiNKhMTY5M0kmKOCfA3QDHtjDjsiravinhXQlOhs/J5o
 +QWhfkJFr1i/hggpueEhVE/oP3uI7MSBLIBQ8AvGYuanA55v+FG7/6AZDTv4lROS5aoi
 EAKjVxez8mE/xukS6dhTMp4j9x7JSlllZJhPFQuT4b+CR1mdqQG4021sQgDWWAxqZp8B
 fjDbRBEalljWU4HPQQAf7rTso7rEOAWmptfYzetBc9fw0g/9loAsmBl5KkcVDFaG43R6
 xc1UioPHgEpXOYMyv09f8F1RkR48MqV9DfFW/yFEHCF1y3mLZn9aVZBmV6WhZHmIzSnP
 6rTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792795149; x=1793399949;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i3s6G9UXyyWKN96oYix/BdTbsZN/E2nnhD3cWxRyhVQ=;
 b=0USFPZA7aO9plsEfd9Am39tPZ5bSmjJ0g4yIAue3QuXrI9BBi4PML9WpqTwv6MR4CJ
 VIOs+m7H8RiZDYZziDCJPplCwo2J/F6Kbwn4eGkHJ2mRYm+XcanByt6XlPGcJQm+OBtP
 4dQT0ujclBNXdQOL2h0jZp0EwCfwfomDXEFh7YBqffH9fUohnaW4LPwnOcV9wEGgEaCc
 BZRmB/Vr3G7jIpc3jYEdDQq+CS1rcpQQMUnzf9Xxm67WIuALASVk0dlabWyooyL18v4e
 LzkDfLZeIWku0SMtUlSon43D9ESW0ceMtoAoANA/FS27MlVGiq588BZ8zG2pRnn0IPN5
 Pg7w==
X-Gm-Message-State: AFq9FYLtPjrnuGkmBARXs06te0cBPjXt0ivHPzMmvQl0MQfTB1+FhXjq
 06gG0W3EKU4uYtjhfPa+dJHH+fVFmNRj4AfFT42mBJyUpLE8fboPOla5wBvFGeTOxpLgiGKIyRB
 TtAwfp7E8gYp/g+LA/ChK0UYmllqR6KPqKpvcnLgf7ydHdcCybagPaSQCjSiphT6AhDIQnSQ0ZL
 tqaEPob0H4pNUUtpi6qo382nvZU2ZU29g2E9shdviAFVYWQN18OZA9GYn2vJrdZA==
X-Received: from qkla13.prod.google.com ([2002:a05:620a:124d:b0:93f:a6c:3612])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6887:b0:93f:567b:6157 with SMTP id
 af79cd13be357-940ef964f93mr73649685a.46.1792795148719; 
 Fri, 23 Oct 2026 15:39:08 -0700 (PDT)
Date: Fri, 23 Oct 2026 22:39:00 +0000
In-Reply-To: <20261023223902.1275539-1-namangulati@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261023223902.1275539-1-namangulati@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023223902.1275539-3-namangulati@google.com>
Subject: [PATCH v6 2/4] vfio: add 'fd' and 'fd_offset' to VFIOMmap
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::748;
 envelope-from=3DOLbagsKCp0K7J7KDRI7QFDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--namangulati.bounces.google.com;
 helo=mail-qk1-x748.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow each sparse mmap subregion to specify its own file descriptor and
file offset for the mmap call.

Add 'fd' (set to -1 when the region fd should be used) and 'fd_offset'
to VFIOMmap, and update vfio_region_mmap() to use them.

Reviewed-by: Thanos Makatos <thanos.makatos@nutanix.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
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
=20
 typedef struct VFIODevice VFIODevice;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 428ab2f069..f851082114 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1623,6 +1623,7 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice =
*vdev)
                                   vdev->msix->table_bar, 0, 0);
         } else {
             region->mmaps[0].offset =3D end;
+            region->mmaps[0].fd_offset +=3D end;
             region->mmaps[0].size =3D region->size - end;
             trace_vfio_msix_fixup(vdev->vbasedev.name,
                               vdev->msix->table_bar, region->mmaps[0].offs=
et,
@@ -1649,6 +1650,7 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice =
*vdev)
                               region->mmaps[0].offset + region->mmaps[0].s=
ize);
=20
         region->mmaps[1].offset =3D end;
+        region->mmaps[1].fd_offset +=3D end;
         region->mmaps[1].size =3D region->size - end;
         trace_vfio_msix_fixup(vdev->vbasedev.name,
                               vdev->msix->table_bar, region->mmaps[1].offs=
et,
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 54ad11a6c8..16efed2fce 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -189,6 +189,9 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *r=
egion,
                                             sparse->areas[i].size - 1);
             region->mmaps[j].offset =3D sparse->areas[i].offset;
             region->mmaps[j].size =3D sparse->areas[i].size;
+            region->mmaps[j].fd =3D -1;
+            region->mmaps[j].fd_offset =3D region->fd_offset +
+                                         sparse->areas[i].offset;
             j++;
         }
     }
@@ -262,6 +265,8 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev=
, VFIORegion *region,
                 region->mmaps =3D g_new0(VFIOMmap, region->nr_mmaps);
                 region->mmaps[0].offset =3D 0;
                 region->mmaps[0].size =3D region->size;
+                region->mmaps[0].fd =3D -1;
+                region->mmaps[0].fd_offset =3D region->fd_offset;
             } else if (ret) {
                 return ret;
             }
@@ -354,7 +359,6 @@ int vfio_region_mmap(VFIORegion *region)
     off_t map_offset =3D 0;
     size_t align;
     char *name;
-    int fd;
=20
     if (!region->mem || !region->nr_mmaps) {
         return 0;
@@ -391,8 +395,6 @@ int vfio_region_mmap(VFIORegion *region)
         return ret;
     }
=20
-    fd =3D vfio_device_get_region_fd(region->vbasedev, region->nr);
-
     map_align =3D (void *)ROUND_UP((uintptr_t)map_base, (uintptr_t)align);
     munmap(map_base, map_align - map_base);
     munmap(map_align + region->size,
@@ -404,12 +406,22 @@ int vfio_region_mmap(VFIORegion *region)
      * offsets being in ascending order.
      */
     for (i =3D 0; i < region->nr_mmaps; i++) {
+        int fd =3D region->mmaps[i].fd;
+
+        if (fd < 0) {
+            fd =3D vfio_device_get_region_fd(region->vbasedev, region->nr)=
;
+        }
+        if (fd < 0) {
+            ret =3D -EINVAL;
+            munmap(map_align + map_offset, region->size - map_offset);
+            goto no_mmap;
+        }
+
         munmap(map_align + map_offset, region->mmaps[i].offset - map_offse=
t);
         region->mmaps[i].mmap =3D mmap(map_align + region->mmaps[i].offset=
,
                                      region->mmaps[i].size, prot,
                                      MAP_SHARED | MAP_FIXED, fd,
-                                     region->fd_offset +
-                                     region->mmaps[i].offset);
+                                     region->mmaps[i].fd_offset);
         if (region->mmaps[i].mmap =3D=3D MAP_FAILED) {
             ret =3D -errno;
             /*
@@ -454,8 +466,8 @@ int vfio_region_mmap(VFIORegion *region)
=20
 no_mmap:
     trace_vfio_region_mmap_fault(memory_region_name(region->mem), i,
-                                 region->fd_offset + region->mmaps[i].offs=
et,
-                                 region->fd_offset + region->mmaps[i].offs=
et +
+                                 region->mmaps[i].fd_offset,
+                                 region->mmaps[i].fd_offset +
                                  region->mmaps[i].size - 1, ret);
=20
     region->mmaps[i].mmap =3D NULL;
--=20
2.56.0.307.g5fe7bd680c-goog


