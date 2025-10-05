Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A04CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFf-0003ZK-2E; Sun, 05 Oct 2025 15:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFP-0002RV-8p
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFL-0006aq-Ly
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8mgXBMkIPaubzZRCiKt5I0VhsqUbMTTDfaPPFluJjSA=;
 b=dEiq5tknojR4X2Y20DUqSUalxHKV0c0euPC/sySvRaXGQYMiD1vdn2XYEMqeN3FjI/Ypbh
 ZScVITroWv3ai5k7gi5Kmzp4kOJKFkl8K3vaMOenpmyj/7F1vqFw3Zdcbef6Qp2JyuR2zn
 SYU72IiqUOBuh5xPJydYMp4uNRepoK4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-oHMdGESXPgeYMsF-oD7qDg-1; Sun, 05 Oct 2025 15:18:05 -0400
X-MC-Unique: oHMdGESXPgeYMsF-oD7qDg-1
X-Mimecast-MFC-AGG-ID: oHMdGESXPgeYMsF-oD7qDg_1759691885
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e46486972so11982155e9.0
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691884; x=1760296684;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mgXBMkIPaubzZRCiKt5I0VhsqUbMTTDfaPPFluJjSA=;
 b=OAldMTjPAbHmOwygQOgSdQvRfZAFS/bsMZ/dVgjNuDQOC+kdGVJfzFlytvQNszPCNt
 er82yuotNWRiyzvNea3ub9bb4liFDj1l4vtMwi242tl+/KOuyELqDs+44xWHgqrzM6Us
 5lrrA+L9hznQFs7RLrLJyQiF5mRdF/7iIEsIRLrcGia1lygkZtq4jeLnMhDkObatZv/h
 3tgNdTDDkV6ZIuRZLw/HqU+TcvSz+XyDrGWTzIOmbl851xtPiS/GQddm87JKRYPTkgvQ
 KoZfv/vfPc+7xXAJRwiz9b0BbHzNtd/f2MTeIvU6FsMWEcG3qqTVyyE/n2ICqCkU8++p
 p6Ng==
X-Gm-Message-State: AOJu0YwrMiUdTPiqUgTlESV12uJRLgLyf4G9mZ7RtqrHD//8FQfL+doB
 J7BsL6o+tel0gDl1B1cCWk5HwWRiM9j4qbchgRa1qRCeo8FMecbborxUD4YBfIOvsxNqmJ8MKsu
 gILx+UDasqPoRYpE5M8bWzNj3K5IQfjElCuQ1V9hoDmbQfzmTzqzQMPYpgT0S+OCUphn6Nf/ZxM
 w6tH1YZ7ILF8f9oQPOy6p7hXCEMaJuNdozqA==
X-Gm-Gg: ASbGncsp2votcgbMS04ubLcknrTvdAshBsIUilPS1W2h+toUVotDVX1lawgmKNA06Jf
 aRkYa23FjIYIOsv1zgXX1RJK1hIvOC0bljttJKTAxa2AGs0aqrFIYLFhXxQXqs6buFYA9mkuLCm
 Aw2dtjJVX7FI/HnZ0LPXppkfhnGqEZ9YBjLY3qQ2YlfNPDEafclKaO+xTNittHp5hYocwgp+JCU
 TfOIuWC+Lgxb0UPYhNKtz37T7alzHE7cSU/o34QX1IzC1j1g3UvugSGLy3DrrIvQ0JgOZ2ksm8M
 wj5jORbRPxwMKn1uiBV5GE6DtNWLnbuxMDPAmUo=
X-Received: by 2002:a05:600c:1394:b0:46e:6d5f:f6c with SMTP id
 5b1f17b1804b1-46e7110032dmr63962175e9.3.1759691884297; 
 Sun, 05 Oct 2025 12:18:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE23IHBJvq+WxVfWuqq8+rVTeCQwqcgRfqyCH4iHiw25WeSpRhdFRbzASr//FtcbI9qYF0SuA==
X-Received: by 2002:a05:600c:1394:b0:46e:6d5f:f6c with SMTP id
 5b1f17b1804b1-46e7110032dmr63961955e9.3.1759691883727; 
 Sun, 05 Oct 2025 12:18:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723432c9sm124177185e9.1.2025.10.05.12.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:03 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 54/75] amd_iommu: Add helper function to extract the DTE
Message-ID: <a76eeefed36c262ec1654f4930685efff272688d.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Extracting the DTE from a given AMDVIAddressSpace pointer structure is a
common operation required for syncing the shadow page tables. Implement a
helper to do it and check for common error conditions.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-6-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 48 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 202f0f8c6e..dc7531fd4a 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -77,6 +77,18 @@ typedef struct AMDVIIOTLBEntry {
     uint64_t page_mask;         /* physical page size  */
 } AMDVIIOTLBEntry;
 
+/*
+ * These 'fault' reasons have an overloaded meaning since they are not only
+ * intended for describing reasons that generate an IO_PAGE_FAULT as per the AMD
+ * IOMMU specification, but are also used to signal internal errors in the
+ * emulation code.
+ */
+typedef enum AMDVIFaultReason {
+    AMDVI_FR_DTE_RTR_ERR = 1,   /* Failure to retrieve DTE */
+    AMDVI_FR_DTE_V,             /* DTE[V] = 0 */
+    AMDVI_FR_DTE_TV,            /* DTE[TV] = 0 */
+} AMDVIFaultReason;
+
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
@@ -524,6 +536,28 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
     return pte;
 }
 
+static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
+{
+    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
+    AMDVIState *s = as->iommu_state;
+
+    if (!amdvi_get_dte(s, devid, dte)) {
+        /* Unable to retrieve DTE for devid */
+        return -AMDVI_FR_DTE_RTR_ERR;
+    }
+
+    if (!(dte[0] & AMDVI_DEV_VALID)) {
+        /* DTE[V] not set, address is passed untranslated for devid */
+        return -AMDVI_FR_DTE_V;
+    }
+
+    if (!(dte[0] & AMDVI_DEV_TRANSLATION_VALID)) {
+        /* DTE[TV] not set, host page table not valid for devid */
+        return -AMDVI_FR_DTE_TV;
+    }
+    return 0;
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
@@ -1081,6 +1115,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
     uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
     AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
     uint64_t entry[4];
+    int dte_ret;
 
     if (iotlb_entry) {
         trace_amdvi_iotlb_hit(PCI_BUS_NUM(devid), PCI_SLOT(devid),
@@ -1092,13 +1127,14 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
         return;
     }
 
-    if (!amdvi_get_dte(s, devid, entry)) {
-        return;
-    }
+    dte_ret = amdvi_as_to_dte(as, entry);
 
-    /* devices with V = 0 are not translated */
-    if (!(entry[0] & AMDVI_DEV_VALID)) {
-        goto out;
+    if (dte_ret < 0) {
+        if (dte_ret == -AMDVI_FR_DTE_V) {
+            /* DTE[V]=0, address is passed untranslated */
+            goto out;
+        }
+        return;
     }
 
     amdvi_page_walk(as, entry, ret,
-- 
MST


