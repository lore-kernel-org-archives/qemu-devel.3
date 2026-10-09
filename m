Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2995BCA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 17:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFEnA-0000VO-Dd; Fri, 09 Oct 2026 13:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3LyrJagsKCgYtgsgtm0rgzomuumrk.iuswks0-jk1krtutmt0.uxm@flex--namangulati.bounces.google.com>)
 id 1xFEn5-0000V1-Bm
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 13:53:55 -0400
Received: from mail-qt1-x845.google.com ([2607:f8b0:4864:20::845])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3LyrJagsKCgYtgsgtm0rgzomuumrk.iuswks0-jk1krtutmt0.uxm@flex--namangulati.bounces.google.com>)
 id 1xFEn3-0006FP-7s
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 13:53:55 -0400
Received: by mail-qt1-x845.google.com with SMTP id
 d75a77b69052e-5358515b4easo53176091cf.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 10:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791568432; x=1792173232; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Mzd5o5IQRC5mpUnF9WcyCQ/We7DI2JhVUFlgIldA7t8=;
 b=tt6oXVZSkBHt5bl4Ieed3ElpbaEqod20BFbzxE/v/X7N+rIr/jLAYdUz0ao6Vj5A8x
 tGCrk8WxZX71GcXmXRV/oZL1/+WsjOQrFDt36H9wQQ2Ku/rQNJ1LF3ipFE2aUYwbKnyy
 GkTx6VD23HXskRACh0LWidblBXnDBtTGUtLjelqkDLB9C+2bhEFwuZGzkjqJE97T9AuG
 uNpPFOXgVCftW90tHMT6UEb38I2QcjkHjZRxiciwiZg3lIbT7z6V8Dmkws6cufIaDuab
 ttALiquoKQt1qZbA1buL7gT9KWk2y6U9/ExgAFu87QJr5d3I8Xg2XqSHv2U2FESmy+WH
 Q95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791568432; x=1792173232;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mzd5o5IQRC5mpUnF9WcyCQ/We7DI2JhVUFlgIldA7t8=;
 b=PZF6d9ogh2Q9hq2qkJAm1UQL9gxnFm6DYseJemWjn7kLoAOyivN2pE4bPx3ltKVk7h
 fNFPKZpw49Z7fX/AJJ21xbwt6gwSgllm7ffC74IZu84w2eK+9Glhl1Y+RXQBZd4CgwMV
 pddX95MGByDpzBILZV53wTiquFkipqmPUaiUvsjaqISvgfMbPMKByAxNULIKECcxXnLF
 GuTZOmLf7yCtsXkN8uMWkmZjX9bd5v+4pu/3idZ4HHT1dSoiNbw0Mf2+sQ+18K7ikN6o
 kZi0KotHgy+dfbWuwvVcqD/scEbShrPqdSGTcMunYKrnhaw9iaQB/SProhYKJZ0gbYYd
 ji6Q==
X-Gm-Message-State: AFuF++nqWpIn4tUAU9xprA4dgMwrMh7/JWs6/1q2ggoS7udqJtad5kHw
 e0lnpvuKwnEzDcUt+zvqvU+ZsZHiGl0n2P4Pq3tdi33qNyBfnq48kbexyGWqMOwKtbV54Zb+CTn
 Q8gt/D2Kluj90/fpgLncHOyCuICLbW6OYEJVK6TTuObkSKCBqiyw2ZZ6GaZ6+t/Fc7bzOtHWzFT
 aWmClGxYaJV+UziGIeYZXTnEa3jpVpT9cUtqHQYGaUZpf1t90zvNEEsEJ11RGZWw==
X-Received: from qvwl14.prod.google.com ([2002:ad4:4bce:0:b0:919:ad7f:e1aa])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2506:b0:533:3868:1f6d with SMTP id
 d75a77b69052e-5359fdf53f0mr42174941cf.59.1791568431508; 
 Fri, 09 Oct 2026 10:53:51 -0700 (PDT)
Date: Fri,  9 Oct 2026 17:53:13 +0000
In-Reply-To: <20261009175314.1823347-1-namangulati@google.com>
Mime-Version: 1.0
References: <20261009175314.1823347-1-namangulati@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261009175314.1823347-4-namangulati@google.com>
Subject: [PATCH v4 3/4] vfio: add setup_sparse_mmaps hook to VFIODeviceIOOps
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::845;
 envelope-from=3LyrJagsKCgYtgsgtm0rgzomuumrk.iuswks0-jk1krtutmt0.uxm@flex--namangulati.bounces.google.com;
 helo=mail-qt1-x845.google.com
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
2.56.0.385.gd3acb90ef8-goog


