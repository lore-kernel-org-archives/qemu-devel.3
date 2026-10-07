Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9055DCA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 00:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEFfU-0004Cn-Ht; Tue, 06 Oct 2026 20:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ho3FagsKChU8v7v81F6vE319916z.x97Bz7F-yzGz689818F.9C1@flex--namangulati.bounces.google.com>)
 id 1xEFHm-0001Km-2w
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:14:00 -0400
Received: from mail-qt1-x846.google.com ([2607:f8b0:4864:20::846])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ho3FagsKChU8v7v81F6vE319916z.x97Bz7F-yzGz689818F.9C1@flex--namangulati.bounces.google.com>)
 id 1xEFH8-0000lG-HD
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:13:08 -0400
Received: by mail-qt1-x846.google.com with SMTP id
 d75a77b69052e-5338f659170so55121491cf.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 17:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791331719; x=1791936519; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QRS73chvJqOCdqEfGNpEpRd63O/QrAFEMU7J5ZoA3Yg=;
 b=r3nZPHNKni2kFVCtcEDQuEAH6djB6DS5Vh0G3KjKluCKOO/3oxKDp+DjSE/ITLCch/
 n7+P9dTXI7QchhsLwuEa/uVV6YtEuEqz5qtALl4jGyjYlSt9gk2YJ04RWLGPSaIOIGev
 IhlboZHTZrM71FSBsccZcF1TEsEwfJbXshRyy5jwzWbqz97GhAJq2RnJtw7klLkYutQk
 2v0ZFBEBBipYZeVaWkzZENbYnABkBnorZ8LcNZg6vKie8p9Y7ZyOHgvKiGeMD3ipHhq9
 PYrdvfHd6WVtZ037O0Eu/vGRHQZEtQlJ4PKXAJ2MO8Elv7Si/U3nvjXi1QLkikIJ6IGj
 dotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791331719; x=1791936519;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QRS73chvJqOCdqEfGNpEpRd63O/QrAFEMU7J5ZoA3Yg=;
 b=UzEw1YXjnykCXvMQeXt1uJtEW9VftZjS4gbFKVDz4Gi0i0MRpCGB3Wdk4o1WqWgeJW
 6l0LjLGb6ZiTTXPi+MfWKzxQ4DU0IlRcHsJG4L/Lk9RcOy9eVHUwwqpFNBLiQHE4rSZ/
 IN6KPk8eXasJsaGaIjOTI2z1Yeccho/LgHWmjrvxVeJFSNkiysDbHVkL9c387mhYd30o
 sn7JWsKTT50E+PSc6xQhb8l8hBGSSvqJdODTwUB2tkjTI7bOkSGbNWXn3/K8UU06a9tN
 /XwwxS8EjxDtfGdH1NmsgNf/gPnlM/NNdd3qufwo/Gntjb+bubobiRj1rzrSXnBeDlIh
 70iA==
X-Gm-Message-State: AFuF++lQLxiKMN5z+L2yYYKgJ1cPMZYIQLdRHv+OPvYttFnlGxH1Q9co
 5MwvDfSYXw/mtk0ZDMnGM2TBh3ETmME/28fRcn7dToMUyVwu4e4EXKV0yZllE5KurbHR3t5/XKM
 iLWlxTvl2a551Nhk20Qn9zQcqD17mDJdTEp2j50jyRKMwxOf8+bAdtmEutfVJWGGYFsxWZKYCx2
 vyLdAFH4B8LM8H49ns2Pme18/2B3zNYSYoYSRfgEBT6+RsHToivnHU5uz5lHs7gg==
X-Received: from qto20.prod.google.com ([2002:a05:622a:a6d4:b0:533:6ff9:e7b7])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:64f:b0:530:f86a:5e30 with SMTP id
 d75a77b69052e-53575605576mr10432341cf.47.1791331718318; 
 Tue, 06 Oct 2026 17:08:38 -0700 (PDT)
Date: Wed,  7 Oct 2026 00:08:32 +0000
In-Reply-To: <20261007000833.2445641-1-namangulati@google.com>
Mime-Version: 1.0
References: <20261007000833.2445641-1-namangulati@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261007000833.2445641-4-namangulati@google.com>
Subject: [PATCH v3 RESEND 3/4] vfio: add setup_sparse_mmaps hook to
 VFIODeviceIOOps
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::846;
 envelope-from=3ho3FagsKChU8v7v81F6vE319916z.x97Bz7F-yzGz689818F.9C1@flex--namangulati.bounces.google.com;
 helo=mail-qt1-x846.google.com
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

Add a setup_sparse_mmaps callback to VFIODeviceIOOps so transport
backends (such as vfio-user) can parse custom sparse mmap capabilities,
falling back to vfio_default_setup_sparse_mmaps() to process shared
VFIO mmap capabilities.

Signed-off-by: Naman Gulati <namangulati@google.com>
---
 hw/vfio/vfio-region.h         |  5 +++++
 include/hw/vfio/vfio-device.h | 16 ++++++++++++++++
 hw/vfio/region.c              | 25 ++++++++++++++++++++++---
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
index 9f6a5cf7d5..a0c9533f9f 100644
--- a/hw/vfio/vfio-region.h
+++ b/hw/vfio/vfio-region.h
@@ -46,4 +46,9 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled);
 void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 
+struct vfio_region_info;
+int vfio_default_setup_sparse_mmaps(VFIORegion *region,
+                                    struct vfio_region_info *info,
+                                    Error **errp);
+
 #endif /* HW_VFIO_REGION_H */
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 8472420d3f..3136e152f2 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -43,6 +43,7 @@ enum {
 
 typedef struct VFIODeviceOps VFIODeviceOps;
 typedef struct VFIODeviceIOOps VFIODeviceIOOps;
+typedef struct VFIORegion VFIORegion;
 typedef struct VFIOMigration VFIOMigration;
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
@@ -218,6 +219,21 @@ struct VFIODeviceIOOps {
     int (*get_region_info)(VFIODevice *vdev,
                            struct vfio_region_info *info, int *fd);
 
+    /**
+     * @setup_sparse_mmaps
+     *
+     * Parse sparse mmap capabilities for a region and initialize region->mmaps.
+     *
+     * @region: #VFIORegion to set up
+     * @info: region info struct containing capabilities
+     * @errp: pointer to Error*, to store an error if it happens
+     *
+     * Returns 0 on success, -ENODEV if not sparse, or negative error code.
+     */
+    int (*setup_sparse_mmaps)(VFIORegion *region,
+                              struct vfio_region_info *info,
+                              Error **errp);
+
     /**
      * @get_irq_info
      *
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 16efed2fce..d6cd5d4743 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -162,9 +162,9 @@ static int vfio_mmap_compare_offset(const void *a, const void *b)
     return 0;
 }
 
-static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
-                                          struct vfio_region_info *info,
-                                          Error **errp)
+int vfio_default_setup_sparse_mmaps(VFIORegion *region,
+                                    struct vfio_region_info *info,
+                                    Error **errp)
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_region_info_cap_sparse_mmap *sparse;
@@ -198,6 +198,25 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
 
     region->nr_mmaps = j;
     region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
+    return 0;
+}
+
+static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
+                                          struct vfio_region_info *info,
+                                          Error **errp)
+{
+    int ret, i;
+
+    if (region->vbasedev->io_ops &&
+        region->vbasedev->io_ops->setup_sparse_mmaps) {
+        ret = region->vbasedev->io_ops->setup_sparse_mmaps(region, info, errp);
+    } else {
+        ret = vfio_default_setup_sparse_mmaps(region, info, errp);
+    }
+
+    if (ret) {
+        return ret;
+    }
 
     /*
      * Sort sparse mmaps by offset to ensure proper handling of gaps
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


