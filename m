Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05C8606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=c30ETfrv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKNut-0006fQ-88; Fri, 23 Oct 2026 18:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3DeLbagsKCp4L8K8LESJ8RGEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--namangulati.bounces.google.com>)
 id 1xKNur-0006ec-Kp
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 18:39:13 -0400
Received: from mail-qk1-x745.google.com ([2607:f8b0:4864:20::745])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3DeLbagsKCp4L8K8LESJ8RGEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--namangulati.bounces.google.com>)
 id 1xKNup-0002lq-MC
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 18:39:13 -0400
Received: by mail-qk1-x745.google.com with SMTP id
 af79cd13be357-93f1e62510cso348880485a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 15:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792795150; x=1793399950; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TG/3qCag+2MZxljLg2V3FvMRPJf+QVtBuFAEftc9fWc=;
 b=c30ETfrvjVwVpuQqeMhW7rwuZfNfn9SQqPhPF+bldIKlKHwiz7Lnn+ndPDhzeaEzKV
 uk+8bpyaz6P4cd5aQV87ju6fHlh9Mq7LtRY4YKnsrPZfyAS9SZeGYrLJgiqDu6qnc17L
 SWRW+52Od75WjEqKNXheDyj+qfI/ZtL7kqaVnn6vyQxpf9lb1UYcYfJdm0A7ZTO8gG0f
 j+mhhTkszEBZZ1ACwMw19gfigJfZtU8bRZwbvr2ykhnye7Qi9+dbow8jrO5PvZ+C3H8C
 6Nm2J8qTdfDmssRDLxkELiWug6/YujdZcxtjedWGzTaf2x7maptlrh9Z/R8Tdx1bINxU
 kJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792795150; x=1793399950;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TG/3qCag+2MZxljLg2V3FvMRPJf+QVtBuFAEftc9fWc=;
 b=20J0DXAzFsnPynPDPxdaz6ZjQ3ew4xDUQrD9zO4cu48vM7C6JFG2fRqlkvto/o5dHu
 U2fRQHiVij/iq4e/5m+w5xzCTUcZ9IJh235sDEkd46AG7GjvM4y6fEkmE6JS5Mm5BtVB
 Y361POqKdmlf9XXV9xbVA+nkbYoe81zcH60JPPzPvsJS3TwVL/ro5qsLff8UVeRDqp8n
 LmKPBjZ1NQA+VnciSmIFzEXGWG+IvhsDcpoo4Um8ZKPzwE7MtkjzDpddBYNyi5vZwPqJ
 eru/X7EFK/f0LFvzD8mjVJcfI209neHcu6aZgT4r2wTxi18V323uJIXf0Q/nRbdNTyQ3
 NtBA==
X-Gm-Message-State: AFq9FYI5qXguxNzdIJPYBhvzrPP7k7ZABx0YNerFVzPStMH+OJv7+m+P
 wfNOiP/H5X6j7nMZ0eUGxArAWfCnIENQfmlxgcVM+PQlp2UM5OBFQvwFTpZIyqOrE7wo1XDJPFh
 ahMSGuqeN7LRbOUHj/WvjdSXZSPVjowjB/TCldOZFgqKgPthTXGPzfg/SiFAJKLO+yOK9YRa/8W
 /NNnwLEMJ9qRihUwWVYnevXLNXgChHtyLyBLQirJX3j7IzMollK7MROnMmV97glg==
X-Received: from qvnv9.prod.google.com ([2002:a0c:f909:0:b0:919:91a7:dc5c])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:458e:b0:93a:83d:1d0e with SMTP id
 af79cd13be357-940ef9526a1mr76758885a.38.1792795149604; 
 Fri, 23 Oct 2026 15:39:09 -0700 (PDT)
Date: Fri, 23 Oct 2026 22:39:01 +0000
In-Reply-To: <20261023223902.1275539-1-namangulati@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261023223902.1275539-1-namangulati@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023223902.1275539-4-namangulati@google.com>
Subject: [PATCH v6 3/4] vfio: add setup_sparse_mmaps hook to VFIODeviceIOOps
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::745;
 envelope-from=3DeLbagsKCp4L8K8LESJ8RGEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--namangulati.bounces.google.com;
 helo=mail-qk1-x745.google.com
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

Add a setup_sparse_mmaps callback to VFIODeviceIOOps so transport
backends (such as vfio-user) can parse custom sparse mmap capabilities,
falling back to vfio_region_setup_sparse_mmaps() to process shared
VFIO mmap capabilities.

Reviewed-by: Thanos Makatos <thanos.makatos@nutanix.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
Reviewed-by: John Levon <john.levon@nutanix.com>
Signed-off-by: Naman Gulati <namangulati@google.com>
---
 hw/vfio/vfio-region.h         |  5 +++++
 include/hw/vfio/vfio-device.h | 16 ++++++++++++++++
 hw/vfio/device.c              |  1 +
 hw/vfio/region.c              | 19 ++++++++++++++++---
 4 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
index 9f6a5cf7d5..abcfbacfff 100644
--- a/hw/vfio/vfio-region.h
+++ b/hw/vfio/vfio-region.h
@@ -46,4 +46,9 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bo=
ol enabled);
 void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
=20
+struct vfio_region_info;
+int vfio_region_setup_sparse_mmaps(VFIORegion *region,
+                                    struct vfio_region_info *info,
+                                    Error **errp);
+
 #endif /* HW_VFIO_REGION_H */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 8472420d3f..3136e152f2 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -43,6 +43,7 @@ enum {
=20
 typedef struct VFIODeviceOps VFIODeviceOps;
 typedef struct VFIODeviceIOOps VFIODeviceIOOps;
+typedef struct VFIORegion VFIORegion;
 typedef struct VFIOMigration VFIOMigration;
=20
 typedef struct IOMMUFDBackend IOMMUFDBackend;
@@ -218,6 +219,21 @@ struct VFIODeviceIOOps {
     int (*get_region_info)(VFIODevice *vdev,
                            struct vfio_region_info *info, int *fd);
=20
+    /**
+     * @setup_sparse_mmaps
+     *
+     * Parse sparse mmap capabilities for a region and initialize region->=
mmaps.
+     *
+     * @region: #VFIORegion to set up
+     * @info: region info struct containing capabilities
+     * @errp: pointer to Error*, to store an error if it happens
+     *
+     * Returns 0 on success, -ENODEV if not sparse, or negative error code=
.
+     */
+    int (*setup_sparse_mmaps)(VFIORegion *region,
+                              struct vfio_region_info *info,
+                              Error **errp);
+
     /**
      * @get_irq_info
      *
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 4f11959633..339c7242ed 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -662,6 +662,7 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl =3D {
=20
     .device_feature =3D vfio_device_io_device_feature,
     .get_region_info =3D vfio_device_io_get_region_info,
+    .setup_sparse_mmaps =3D vfio_region_setup_sparse_mmaps,
     .get_irq_info =3D vfio_device_io_get_irq_info,
     .set_irqs =3D vfio_device_io_set_irqs,
     .region_read =3D vfio_device_io_region_read,
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 16efed2fce..8de26f3d9b 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -162,9 +162,9 @@ static int vfio_mmap_compare_offset(const void *a, cons=
t void *b)
     return 0;
 }
=20
-static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
-                                          struct vfio_region_info *info,
-                                          Error **errp)
+int vfio_region_setup_sparse_mmaps(VFIORegion *region,
+                                    struct vfio_region_info *info,
+                                    Error **errp)
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_region_info_cap_sparse_mmap *sparse;
@@ -198,6 +198,19 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *=
region,
=20
     region->nr_mmaps =3D j;
     region->mmaps =3D g_realloc(region->mmaps, j * sizeof(VFIOMmap));
+    return 0;
+}
+
+static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
+                                          struct vfio_region_info *info,
+                                          Error **errp)
+{
+    int ret, i;
+
+    ret =3D region->vbasedev->io_ops->setup_sparse_mmaps(region, info, err=
p);
+    if (ret) {
+        return ret;
+    }
=20
     /*
      * Sort sparse mmaps by offset to ensure proper handling of gaps
--=20
2.56.0.307.g5fe7bd680c-goog


