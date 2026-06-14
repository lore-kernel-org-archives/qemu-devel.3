Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A68ECD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYq9y-0007Rf-GN; Sun, 14 Jun 2026 15:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9w-0007R2-QX
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYq9v-0001f5-B3
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781463974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l7ykQEO4cm1Z2dMhNA5jiGYbkk53qAUW66mFa/lcCaU=;
 b=jTpdu8d4k5CgMb6wry6BIKd0/+keWi34QHVvAoKb0EEguF7nFpswyKr4nDhlxk2ROY++Zt
 tnuWrBV957WSYDaE+AsVvpnfp1z/PIz53GIp29p1TVdRX/lD3hP0h9eGJFhxYMD/ckMOpR
 5j1juQwHRg6MZ1e4E4nGFjUX7UuSK9Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-D4luajW0O8qVddhRajfTTw-1; Sun, 14 Jun 2026 15:06:13 -0400
X-MC-Unique: D4luajW0O8qVddhRajfTTw-1
X-Mimecast-MFC-AGG-ID: D4luajW0O8qVddhRajfTTw_1781463972
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4600c8cb13aso1820279f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781463972; x=1782068772; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l7ykQEO4cm1Z2dMhNA5jiGYbkk53qAUW66mFa/lcCaU=;
 b=bADKhcnZ7WEBH+GkpFgYfcxRenlukELFNM0vGDq0NMnfCt9OekaZDX5zZKqOZ2hrpW
 yEn3J/nSTvPIceSGV5HK5bWD5r8Bup5Apvr3eOH0DIBGcAtB27/R8x1jWp8xjhe3daVi
 alFUtIQtH/e7M4G9DANHSKvyJ9O6r2COw3YhDtRJPd1qH151AbYwL4amy1qLtPQWiLeU
 N4260TWhZcg7glVosheNBhOUgBEWpUKxgnjqsbcahIgselw8YzZ3DsW5IcCRwKyMblox
 C3DBQbUf9SHMHpNwbODypLYxA4SZQBV5fl/LKchfZdtJk3jdS6YVeio/gZRnd233vW0V
 YoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781463972; x=1782068772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l7ykQEO4cm1Z2dMhNA5jiGYbkk53qAUW66mFa/lcCaU=;
 b=cywojqOm/XMLFbAeJyDMcKRpiVX48OX6djMyoxEsrXVmeb52xa+DBTJsmhO0cbED8X
 CwsrlJBsL5IpOU/pJhsEVHxgY2HEHk+EpXDIB+kSBstPdQBav6Z13nH4JUNQb0xL5/rC
 XtTTcT0/1Ibbjsxl5cDrjjn3NvMzTV1h3va3+OSsl+0zAJg6f/D84WEs/iIl5YTgYT8+
 jdGdVpol2787q99WwYuUtT5zp/xIedMedsMgC6PNiKt244QbSYle5cA9wt4/y1PO0WXj
 iI2H7vDAFhPVTfRuMVk5FhS78sQ6u+VL1PM1g8kWf8ZzXdb6SipWUjadpv+HJjEesuTs
 5+zg==
X-Gm-Message-State: AOJu0Yy0+4qnbZf3MXXQipZliJ6N6r4VSxf/jU4MlrGne/j6OjSNpb99
 fa0OWlyXgXBd1kK8b9jrd9jEpj1AbvcrJvI3vIcgYaF4tCWeHmL2gwOBFesEri8YkEILZINYjzS
 VZGfa8UcNNYGQWhcb+TVFAOxXMwU5qtFQJrnjMFwehryQDu1qQH6bGMc6dMl5AM1Bmuf4bPkLyv
 ENOXpkXnRWuqnMHfV8AXDWxeYxhiFsqkvTSA==
X-Gm-Gg: Acq92OGlLYhlMugY67S6s1pHZfvDsna1w2Kw2scFe7xKqUPdyODc2ztLNX0lGV9REGh
 SQqQpQpEpQp/k6j/XZ2ShwLDUpzPHX1UyHkiPdppLFl2d0qY3HNNaIbSYzL0t+AQDdlkOTAeenI
 6ktp2iWhkBM/P1J5jLj9lVX8ITJPZ6+5aGsIp8XkmuG7gPXefwiQHAYH/yfhKTN4aOVhREWuWuW
 ynWkJmZVzMALkNHP7Og6N4vJslaosEwg1TGJImObsFYMV3pH4ARiQLfoCLZHmJ4/hsDs1PsrnPV
 P7p5y+QjI3jhBndLTFfe1hFeCVWpd3wbUmRsL4QxarhPHMPYt146MjpmaGTp1+X3tUxul5HpHR3
 KfvYNrXt1JUUHwSs6b2df3s0UwSDbpK9gB0EnT6V33iE=
X-Received: by 2002:a5d:5f56:0:b0:460:1e9d:31a5 with SMTP id
 ffacd0b85a97d-4606dbad7femr16916396f8f.35.1781463972206; 
 Sun, 14 Jun 2026 12:06:12 -0700 (PDT)
X-Received: by 2002:a5d:5f56:0:b0:460:1e9d:31a5 with SMTP id
 ffacd0b85a97d-4606dbad7femr16916343f8f.35.1781463971628; 
 Sun, 14 Jun 2026 12:06:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d28sm27629646f8f.20.2026.06.14.12.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:06:11 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:06:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Clement Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 011/106] intel_iommu: make vtd_dev_get_pe_from_pasid() more
 generic
Message-ID: <db2bc1f3353c32e011bb6dbec675228cb1410fbe.1781463125.git.mst@redhat.com>
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

Refactor vtd_dev_get_pe_from_pasid() to take individual parameters
(IntelIOMMUState, PCIBus, devfn, pasid) instead of VTDAddressSpace.

This makes the function more reusable and prepares it for export to be
used in the acceleration path. Remove inline qualifier as the function
will be exported in a subsequent patch.

No functional changes intended.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260527054658.1021096-7-zhenzhong.duan@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b22feb0301..632df21034 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3113,10 +3113,10 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
     return true;
 }
 
-static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
-                                            VTDPASIDEntry *pe)
+static int vtd_dev_get_pe_from_pasid(IntelIOMMUState *s, PCIBus *bus,
+                                     uint8_t devfn, uint32_t pasid,
+                                     VTDPASIDEntry *pe)
 {
-    IntelIOMMUState *s = vtd_as->iommu_state;
     VTDContextEntry ce;
     int ret;
 
@@ -3124,13 +3124,12 @@ static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
         return -VTD_FR_RTADDR_INV_TTM;
     }
 
-    ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus), vtd_as->devfn,
-                                   &ce);
+    ret = vtd_dev_to_context_entry(s, pci_bus_num(bus), devfn, &ce);
     if (ret) {
         return ret;
     }
 
-    return vtd_ce_get_pasid_entry(s, &ce, pe, vtd_as->pasid);
+    return vtd_ce_get_pasid_entry(s, &ce, pe, pasid);
 }
 
 static int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
@@ -3151,7 +3150,8 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     const char *err_prefix = "Attaching to HWPT failed: ";
     Error *local_err = NULL;
 
-    if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
+    if (vtd_dev_get_pe_from_pasid(vtd_as->iommu_state, vtd_as->bus,
+                                  vtd_as->devfn, vtd_as->pasid, &pe)) {
         if (!pc_entry->valid) {
             return;
         }
-- 
MST


