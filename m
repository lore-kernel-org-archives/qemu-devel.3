Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49703CC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH6FT-0007Ga-Vk; Wed, 14 Oct 2026 17:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <31u_PagsKClM8v7v81F6vE319916z.x97Bz7F-yzGz689818F.9C1@flex--namangulati.bounces.google.com>)
 id 1xH6FS-0007CU-HE
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:10:54 -0400
Received: from mail-yw1-x1146.google.com ([2607:f8b0:4864:20::1146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <31u_PagsKClM8v7v81F6vE319916z.x97Bz7F-yzGz689818F.9C1@flex--namangulati.bounces.google.com>)
 id 1xH6FP-0001Dm-P5
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 17:10:54 -0400
Received: by mail-yw1-x1146.google.com with SMTP id
 00721157ae682-88322409239so52774117b3.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 14:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792012247; x=1792617047; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BHAaWWEJMCHHxNcrFC5T+b9snoojTnLGaAfiiw4oB8c=;
 b=AhKq1em9azmIrc41DYw/mBp3H54wGBXvnHTR0yRWSnCMfetR7KUGgEjWPprGjUXEbC
 bN47xLvCVXmAsqWiuo0VZbhoj62tI40fuiR44ZHEKD94kNSP72YYUbi4EvqCl8ENqZBV
 0af/b0/2wk/QCM35aEiEG5kKmCyRaRUU7T5DN/wgmd+jgUIeZJ48scWmJDpqzqCBPC3G
 8JnvkqF+HBgMiJIihvleL0p2S+g71yCtDCyrD2SU1LjO2OYLRmHsYE433o+g6VCuuDWD
 fkRvm7rxPdEgEsPEEOYqZkmG/T76QuebpWan/lshbqqqXYZjXK6AoWY93NQG3YpLSWzM
 +NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792012247; x=1792617047;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BHAaWWEJMCHHxNcrFC5T+b9snoojTnLGaAfiiw4oB8c=;
 b=Q62WrxxaWcIegQNfBQlfPNEtowzmbNRv2TVZ38g1PSnTBxde5FtV7bB0TrEYOVN4LR
 cMnEgrLIHgThrVc2n1qp0j4N7eL1dQUHnDjA0GX2V8P1VStCcj3CRUByrjFoTQaTEUj2
 wn+eC021k0ttNf51t4QDsNemsEmPQoJvQzttCsI/maNNOxeT7+a6tFSlPC7ZoxK5cyP0
 Pt6jqcTsFZOZiEdZmXORUIBXpFs3lKQ33v3+dXHLmnOa4GOrvytD3nkS/3tetUvkZ7v8
 ZeIC3K7Uryy4ot7iEDzlcpne9uBcCTXkK97g81A1W+5WAIzleKPyDLT7rgsgUcspiZVb
 xeww==
X-Gm-Message-State: AFq9FYLmbJJGA3v3NjiIoUxROvkCPe4GWAlPNqmuiePuNP8GVH8TJlne
 eMCSycHeWo/TFulcFO3Xf2B1zVerJYqQrRMdB2EaMSrWh/4lKKT+2YFWif8JMsg0n5B7feX9BaQ
 C5hMdLwM0AC/WDu8VkTWQURBFl2rkCv41t0U9q3xE7ATTsRd9l3Blo0vLpPnnEYL0T+8b6g5Tu6
 r8tsDROkyYqUobXmpOqFm33KN2si/1UN5K1UUIoZwMKFI6oyCCJ9FnhfWC3rvIKA==
X-Received: from ywb9.prod.google.com ([2002:a05:690c:9509:b0:8ac:6bf3:16a6])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:10d:b0:8b0:88b7:cfe3 with SMTP id
 00721157ae682-8b088b7d19bmr60655457b3.40.1792012246749; 
 Wed, 14 Oct 2026 14:10:46 -0700 (PDT)
Date: Wed, 14 Oct 2026 21:10:40 +0000
In-Reply-To: <20261014211041.1087331-1-namangulati@google.com>
Mime-Version: 1.0
References: <20261014211041.1087331-1-namangulati@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261014211041.1087331-4-namangulati@google.com>
Subject: [PATCH v5 3/4] vfio: add setup_sparse_mmaps hook to VFIODeviceIOOps
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1146;
 envelope-from=31u_PagsKClM8v7v81F6vE319916z.x97Bz7F-yzGz689818F.9C1@flex--namangulati.bounces.google.com;
 helo=mail-yw1-x1146.google.com
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

Reviewed-by: Thanos Makatos <thanos.makatos@nutanix.com>
Signed-off-by: Naman Gulati <namangulati@google.com>
---
 hw/vfio/vfio-region.h         |  5 +++++
 include/hw/vfio/vfio-device.h | 16 ++++++++++++++++
 hw/vfio/device.c              |  1 +
 hw/vfio/region.c              | 19 ++++++++++++++++---
 4 files changed, 38 insertions(+), 3 deletions(-)

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
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 4f11959633..94d6e7ce09 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -662,6 +662,7 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
 
     .device_feature = vfio_device_io_device_feature,
     .get_region_info = vfio_device_io_get_region_info,
+    .setup_sparse_mmaps = vfio_default_setup_sparse_mmaps,
     .get_irq_info = vfio_device_io_get_irq_info,
     .set_irqs = vfio_device_io_set_irqs,
     .region_read = vfio_device_io_region_read,
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 16efed2fce..94cfb708bf 100644
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
@@ -198,6 +198,19 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
 
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
+    ret = region->vbasedev->io_ops->setup_sparse_mmaps(region, info, errp);
+    if (ret) {
+        return ret;
+    }
 
     /*
      * Sort sparse mmaps by offset to ensure proper handling of gaps
-- 
2.56.0.385.gd3acb90ef8-goog


