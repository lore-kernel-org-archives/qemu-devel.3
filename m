Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7BAC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 22:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6yHN-000386-7p; Wed, 16 Sep 2026 18:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3eRqragsKCrYjWiWjcqhWpeckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--namangulati.bounces.google.com>)
 id 1x6yHF-00036g-Kf
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 18:38:53 -0400
Received: from mail-qk1-x746.google.com ([2607:f8b0:4864:20::746])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3eRqragsKCrYjWiWjcqhWpeckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--namangulati.bounces.google.com>)
 id 1x6yHD-0006zV-GL
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 18:38:53 -0400
Received: by mail-qk1-x746.google.com with SMTP id
 af79cd13be357-93a082c014aso35328285a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 15:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789598329; x=1790203129; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iAdMALx2mMoLKGnIQ4bKYCrFV5RPfccmk6okLE1XBSc=;
 b=jZfxIz4jRF/tmTRVLG5en5MDh8kuLoxjTOKOxkZ+4YC26ECW+waASnD7eTDaaGUKL4
 5c+3Jo56d3b59gJl7MIIrb7MNNTAamMkVFrPc/Tyffb83Z8/FqlC/qf4tZOb//oql+yO
 70zD3Ge9ovDWGaNr3nkJtaMp+wme/sZLpRVd6WQTrI99QU/ZtWUv2JpGCKPuTmfunGft
 tvPl7Tr3alPIUIIeN4huN5A9eToPe87S8NiHrFHRTHcYlyHR/VWTJUy0OP2qNgizynrv
 Wqn1ruPyAKInDaETufPvWGSKjVLMvcWoAMBJ4Oqv7sZSn1lfaY2jL/cTgQs6tpmckPcJ
 Ohjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789598329; x=1790203129;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iAdMALx2mMoLKGnIQ4bKYCrFV5RPfccmk6okLE1XBSc=;
 b=q3J3G5MP+wR4vj1FNJrkIs8pWkooz2oRpyjUmsnSS2kSrhpUSziHOSMHDL3e4UgIIO
 dBu/GeTDd/n1ca4ASb+a3ZudsFoP3BLP4dv9/20z+F8BVj1jnn7e9mBFOYJBbX9r6mUl
 8H0r1LVBhcyMPuIGln2BKUSYgkv5RtDYN9LFjHDoO5+4YGq5ZT4r45mxwxMf/SMN7EWw
 8S29Nw0KVDrzVPkkQ61bq4JvbqkG1REKWOiD5YjN140ymEZVA/YAIvdQznIshToJqhgL
 UywY7DhtPZ07rW/9AN0NsCGr6W8PP/wWPqUdbQpKITXkRnlaIHzbdzHVUgGGyI1Bcl5t
 5Aog==
X-Gm-Message-State: AFuF++nh4NHM0aYm2g0LtVCaxat4nd28Kh+yWEnI9h8+tYU2aybH7kNV
 9Q6YUy/3ybfvk4Q/0W1uaxkQuj2Ibui1AxtQVtfL/vqFJzH2OnzTPi/1HLmB8PspWhD9dN4D1Ba
 7HCSV0L3ZIuTihlaXcga2ueEjaMzeiQ/1KxOP5s8PIv7obaW4iRy7PTcLkwsLRVwe7ed+FTItDP
 DVjqsg3NKhUmM4mnDrwM3vSJjFB3rk/1aMfekd+Dq3ON13La1JE7sbUrf1xNDv1w==
X-Received: from qkbc9.prod.google.com ([2002:a05:620a:31c9:b0:939:2bbb:b2ae])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2810:b0:939:a1d0:b5b3 with SMTP id
 af79cd13be357-93bc629d4ddmr207659985a.11.1789598329159; 
 Wed, 16 Sep 2026 15:38:49 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:38:42 +0000
In-Reply-To: <20260916223843.3995552-1-namangulati@google.com>
Mime-Version: 1.0
References: <20260916223843.3995552-1-namangulati@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916223843.3995552-4-namangulati@google.com>
Subject: [PATCH v3 3/4] vfio: add setup_sparse_mmaps hook to VFIODeviceIOOps
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::746;
 envelope-from=3eRqragsKCrYjWiWjcqhWpeckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--namangulati.bounces.google.com;
 helo=mail-qk1-x746.google.com
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
index 3c746200ca..3525f4183f 100644
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
2.55.0.1082.g2b9226bbc0-goog


