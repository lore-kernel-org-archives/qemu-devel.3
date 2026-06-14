Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29B8CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqAG-0007Y3-7D; Sun, 14 Jun 2026 15:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAE-0007XQ-LV
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAC-0001jD-EG
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fy9wZhglxIMjpKMCGO1yq1BTn0dcp39QWhOcas9r+Qs=;
 b=hxw7Ad1Ygu2IKk/ESTonIzNh+rN6ChV5SZgRONuRGcvW3tTq/7c9jF210tS4J3GG7issjm
 84hW6CR/CWTUs58bYigU5JLTDmvw/itbuRtb0TQomGd+FtgZ82tiqrGxgge5rK/3xjqDEb
 FRLIVg+CIgJP9J8YoMP4KSLEL/pwy8k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-NsW3a6U8Ot6VJSFE4cm96Q-1; Sun, 14 Jun 2026 15:06:30 -0400
X-MC-Unique: NsW3a6U8Ot6VJSFE4cm96Q-1
X-Mimecast-MFC-AGG-ID: NsW3a6U8Ot6VJSFE4cm96Q_1781463989
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-46067b07571so1599888f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463989; x=1782068789; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fy9wZhglxIMjpKMCGO1yq1BTn0dcp39QWhOcas9r+Qs=;
 b=sS5aNh8NF8LpN37si8mNwZh9D1yqWcc3oOXJAHFGNkM+5KXeKwjLVg8iEw32o6wr+j
 XbiyOXYV3qW7/hEEYuAnw7KR5QQ6NUnoDn72TdHsgctxzSXan8se4/bp9Q01WoFD5f8i
 oajQQbrzSsMVxSXdrNR+5uUxgt8tuddvInAdqhMzEQDoV/rG0r5ekE5T/z148L7+F5qE
 YBisrSOdz+gAu4CgltDKS6doSH5U2GySNWq4jgFjOYpfJGIjCNYuBU8XkCPiCGIcnp9k
 H7zhzSymnKpZl97ZGGBpeGLPEP/Zi0Met3NzJG7Y0LG2kFGOCXGjnX7stLTZn/1KTaNd
 d5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463989; x=1782068789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fy9wZhglxIMjpKMCGO1yq1BTn0dcp39QWhOcas9r+Qs=;
 b=F5yZsVicOP7wScnMckPXHhG0u9jFg8ekcd7M0S2zks+B4DRCzEtnD/Bezeul5PbNDM
 D7Pog4Vg511AISOlXtyAS5E9F7G3ciydzajJ4LVI+TMBmNTqDPCPO7ygLthTntTqkLzH
 aFscvcrJG+Em19V/OeU5edye+Uoc2TDwTMbtTZjt/M++Hc8UWNevqWqTti0A7UupgnfA
 iF5cfAuq3DrP/eAFkp5r/+BuRG3eJbjdZUD/auAsVMrT4KdzPs+RFjjw5JM0ZqRAgJmk
 GaRGdidcUaCUoLsdmJ4ts41K5z91pE1XVXqAtdR8ZTYq1yv7wm/nx0DPkTXmTabBKXvL
 Rqtg==
X-Gm-Message-State: AOJu0YwBB+jNZRZs7ycsVLm77ofgxbJs0QxTWJq1Tf7OpGeMnV8tYO5J
 0ILkwesW53H8os+hWNO/4G2leZHJHHwRjv+DuKnXhAPDZ5jkCqbKgijoE1JI6m4Zx3SrXczcRMU
 bDTi1nCOKyuTL9V2EJV45vj6vFCNWwaDFRkLhBniFEbdIGZjhxsrsaZhS0jqkQbsJQ/ouKFv1kg
 WtMqCTrla2x99yjsdO3RDNrUh1Cq/9A+qSeg==
X-Gm-Gg: Acq92OEu9LBkFWjEyfJkyy7pJ2pbA2kxgv1dVQMrZSHSV/0GMN2sxO6/2weur7VB4vd
 myLZh5F7CgR4LcslaT56b90jEr18FcnSvgwkvc9OjBFsQJi3Xzzlt2jM3j1HkDyLuGiBVUClfqs
 o+saTLJi8cH48AJyeGdmws7XyfQVpRPxMlySXmdbKnecjECL5dLQRa4oy4UUMGgjJ7vSexFLK88
 c/uFIh+4L9/PvFvkzBsbXQ8iiFum2WCr7q7TrAHFs3FtYTViujVAIyYWMIcrHg2b4fauQJUe5W3
 dIwBRqOFvMrRat60Ttbkq3ZJLpwBI2qKxi+amAFCh5dbPhDymYuqN3Ax9F6nrQSOROl4QZnMcNC
 4RmLIWAHOf6FoVCKxWE5cOoCNoFiFwZpsiBM6VCa0M6Q=
X-Received: by 2002:a05:6000:184e:b0:460:d18:865c with SMTP id
 ffacd0b85a97d-4606cb2160dmr13945644f8f.1.1781463989130; 
 Sun, 14 Jun 2026 12:06:29 -0700 (PDT)
X-Received: by 2002:a05:6000:184e:b0:460:d18:865c with SMTP id
 ffacd0b85a97d-4606cb2160dmr13945594f8f.1.1781463988635; 
 Sun, 14 Jun 2026 12:06:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm25980565f8f.34.2026.06.14.12.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:28 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 018/106] intel_iommu_accel: Bypass PASID entry addition for
 just deleted entry
Message-ID: <6afd98cef5f040754ff20fb512fcf92068d114cf.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

For VTD_INV_DESC_PASIDC_G_PASID_SI typed pc_inv_dsc invalidation, if an
pasid entry is just removed, it can never be a new entry to add. So
calling vtd_replay_pasid_bind_for_dev() is unnecessary.

Introduce a new field accel_pce_deleted in VTDPASIDCacheInfo to mark
this case and to do the bypassing.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260527054658.1021096-14-zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.c    | 16 +++++++++++++---
 hw/i386/intel_iommu_internal.h |  1 +
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index ed0d6bda7e..b823c405a1 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -280,10 +280,15 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
     QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
 }
 
-static void vtd_accel_delete_pc(VTDAccelPASIDCacheEntry *vtd_pce)
+static void vtd_accel_delete_pc(VTDAccelPASIDCacheEntry *vtd_pce,
+                                VTDPASIDCacheInfo *pc_info)
 {
     QLIST_REMOVE(vtd_pce, next);
     g_free(vtd_pce);
+
+    if (pc_info->type == VTD_INV_DESC_PASIDC_G_PASID_SI) {
+        pc_info->accel_pce_deleted = true;
+    }
 }
 
 static void
@@ -319,7 +324,7 @@ vtd_accel_pasid_cache_invalidate_one(VTDAccelPASIDCacheEntry *vtd_pce,
          * to be either all-zero or non-present. Either case means existing
          * pasid cache should be invalidated.
          */
-        vtd_accel_delete_pc(vtd_pce);
+        vtd_accel_delete_pc(vtd_pce, pc_info);
     }
 }
 
@@ -472,7 +477,12 @@ void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
          * removals before additions to optimize the replay process.
          */
         vtd_accel_pasid_cache_invalidate(vtd_hiod, pc_info);
-        vtd_accel_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
+
+        if (pc_info->accel_pce_deleted) {
+            pc_info->accel_pce_deleted = false;
+        } else {
+            vtd_accel_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
+        }
     }
 }
 
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 9307825017..64a38afa85 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -630,6 +630,7 @@ typedef struct VTDPASIDCacheInfo {
     uint8_t type;
     uint16_t did;
     uint32_t pasid;
+    bool accel_pce_deleted;
 } VTDPASIDCacheInfo;
 
 typedef struct VTDPIOTLBInvInfo {
-- 
MST


