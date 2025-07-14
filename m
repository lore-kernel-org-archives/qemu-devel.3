Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39857C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSIS-00036P-8f; Mon, 14 Jul 2025 19:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHC-00068q-Cx
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSHA-0005ct-Mo
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZnCiPK9qjMPW1GxC0I9MN0RmWn7FrkbvPqd5JVEOfwc=;
 b=KRJRy+kAbNevPqbjUSbhZakhfWXQjNopxkhjpTl8Sn++Umfl0J1U/MBylgiiHa4x9HMIlA
 98J39OLG8eFAP0J9Ju21E1IFNXZ8wjlRcqZppMGoc2QS5apHqhZiA6w+IA/GP2uZhp4D5k
 Eb49a3lomYetDQWLB09BbzQy5m/4KFY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-Oqz4j4abOIeaxu6RviGqiA-1; Mon, 14 Jul 2025 19:07:56 -0400
X-MC-Unique: Oqz4j4abOIeaxu6RviGqiA-1
X-Mimecast-MFC-AGG-ID: Oqz4j4abOIeaxu6RviGqiA_1752534474
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4eeed54c2so2649442f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534474; x=1753139274;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnCiPK9qjMPW1GxC0I9MN0RmWn7FrkbvPqd5JVEOfwc=;
 b=YgFaFku5IVgJg4ajM9YUYFdjcNSp8nhlVzHWJ0+Tes836zMwSNQRmjOBrSeS0M2ALt
 ZLEWXv4//tL9u3c276UU4JkrvPd/AmtOnvDyxH4FvVUe+iXn999wJKXOwG52nr1Y7EdU
 xS7nVi8IHNJ55ENfSBgv1DofR9RDVDNkBTsiHMsyjhhd/B8/FyKH6Kc2evEf0bv7/ZHa
 PS08P9JlDM74aZoqbsu3M5aDpTNpw/S46J+zltayXM3+eRbWCk6BtZiPfeeXFVhCOKL6
 JgzB6w85B7A9Rj0cnGtSTI3lhZgOyMYU+ZvrVibtxdaAlWtw0Ck4vORdOjYMXSOavvpk
 hNPg==
X-Gm-Message-State: AOJu0YxiXVY7KaEwcNC7hbYJ8QjLH67ggQXR4sN14ihy+LTeUhRYVkqu
 fMsTIjoa/Pzg9qpZB0wEg6+RD/J02KcuZtStNmKV0TNn6psMCsBdfNYQXF3b0uBJi7dJqMJxaLy
 TBA1U3OA8DK9lkVHN0Kq/aSOmozlkbs+ZKV0XbVnUgOEsEZSlUTDnR2G1ikUiJWpzWQWsC0QWbq
 nMjbBtEurn3i3L4Qb7OHYtw0b8lqXz9shrcw==
X-Gm-Gg: ASbGncuc3qOrsIeGdBzw1XCBccjAMYuDTlEQNHEJM+SDxO5wAFO0OsTA4OAKSaX/ySF
 KHj9iXwWPLzkzaTbAmODgy0TDRRnM0O1sDF6VdelDfCAkNOf17yLCDRNG0w78J3saV/oQt5RWzU
 KB7TYu5CEnEM8mvQVt+u/H5u5OBfzt3GVv2Pxj5bKCefZUavj+7ayXo4EHwFSl9UkRPVlXonEes
 uHei5bU3AdfJA4Rh9flA1r1enP2FD3mJ4e1eCVqbc7eJDx1SGzg1nZz402xHc9iOFZllmqOOLoN
 2UBTa/XXf8ku4pFSK7JDVHnX2xTAUz+m
X-Received: by 2002:a05:6000:2c0f:b0:3a4:d4cd:b06 with SMTP id
 ffacd0b85a97d-3b5f18d98c1mr14125309f8f.34.1752534473771; 
 Mon, 14 Jul 2025 16:07:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6pEKK3EPDqVZib5+SFZk7ZHqkDLC3XsS5JHU/WFt9XPKUX9gOExa/rRNntoFfMnO/iCOwCA==
X-Received: by 2002:a05:6000:2c0f:b0:3a4:d4cd:b06 with SMTP id
 ffacd0b85a97d-3b5f18d98c1mr14125284f8f.34.1752534473285; 
 Mon, 14 Jul 2025 16:07:53 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd180fsm13366964f8f.2.2025.07.14.16.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:52 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 38/97] intel_iommu: Add support for ATS
Message-ID: <47c3dcd3ffc6d187b97fe494a14fb61dd3911ccd.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250628180226.133285-11-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 63 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1b1b0b5632..fe9a5f2872 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4738,6 +4738,68 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &vtd_as->as;
 }
 
+static IOMMUTLBEntry vtd_iommu_ats_do_translate(IOMMUMemoryRegion *iommu,
+                                                hwaddr addr,
+                                                IOMMUAccessFlags flags)
+{
+    IOMMUTLBEntry entry;
+    VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
+
+    if (vtd_is_interrupt_addr(addr)) {
+        vtd_report_ir_illegal_access(vtd_as, addr, flags & IOMMU_WO);
+        entry.target_as = &address_space_memory;
+        entry.iova = 0;
+        entry.translated_addr = 0;
+        entry.addr_mask = ~VTD_PAGE_MASK_4K;
+        entry.perm = IOMMU_NONE;
+        entry.pasid = PCI_NO_PASID;
+    } else {
+        entry = vtd_iommu_translate(iommu, addr, flags, 0);
+    }
+
+    return entry;
+}
+
+static ssize_t vtd_ats_request_translation(PCIBus *bus, void *opaque,
+                                           int devfn, uint32_t pasid,
+                                           bool priv_req, bool exec_req,
+                                           hwaddr addr, size_t length,
+                                           bool no_write, IOMMUTLBEntry *result,
+                                           size_t result_length,
+                                           uint32_t *err_count)
+{
+    IntelIOMMUState *s = opaque;
+    VTDAddressSpace *vtd_as;
+    IOMMUAccessFlags flags = IOMMU_ACCESS_FLAG_FULL(true, !no_write, exec_req,
+                                                    priv_req, false, false);
+    ssize_t res_index = 0;
+    hwaddr target_address = addr + length;
+    IOMMUTLBEntry entry;
+
+    vtd_as = vtd_find_add_as(s, bus, devfn, pasid);
+    *err_count = 0;
+
+    while ((addr < target_address) && (res_index < result_length)) {
+        entry = vtd_iommu_ats_do_translate(&vtd_as->iommu, addr, flags);
+        entry.perm &= ~IOMMU_GLOBAL; /* Spec 4.1.2: Global Mapping never set */
+
+        if ((entry.perm & flags) != flags) {
+            *err_count += 1; /* Less than expected */
+        }
+
+        result[res_index] = entry;
+        res_index += 1;
+        addr = (addr & (~entry.addr_mask)) + (entry.addr_mask + 1);
+    }
+
+    /* Buffer too small */
+    if (addr < target_address) {
+        return -ENOMEM;
+    }
+
+    return res_index;
+}
+
 static void vtd_init_iotlb_notifier(PCIBus *bus, void *opaque, int devfn,
                                     IOMMUNotifier *n, IOMMUNotify fn,
                                     void *user_opaque)
@@ -4787,6 +4849,7 @@ static PCIIOMMUOps vtd_iommu_ops = {
     .init_iotlb_notifier = vtd_init_iotlb_notifier,
     .register_iotlb_notifier = vtd_register_iotlb_notifier,
     .unregister_iotlb_notifier = vtd_unregister_iotlb_notifier,
+    .ats_request_translation = vtd_ats_request_translation,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
-- 
MST


