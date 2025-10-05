Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E3CCAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UG8-00053i-QK; Sun, 05 Oct 2025 15:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFT-0002ao-3y
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFL-0006bQ-O6
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VRpFNHgPPbK5fpFtNVbPj3sQYNUpsLNHYrc3Cj0nCsg=;
 b=LGtL+nFSnnZLUr0fLxMbinCBtc1uuXeGSWNjw8RAvKbvtO7+SvkH/8p6m7XXbRN5AtIN72
 D9F8mWDOM20EJK2uCeQO4WycZnqIlLZ94ETuP/S7+BSb9rZ0QkyV4+ULVVmn36qv+mEuND
 zBZkW8cteh7GcUGBBYotSrwmCe6yQH8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-0ZS5dOcAP_Kwj4TSD2nzLg-1; Sun, 05 Oct 2025 15:18:13 -0400
X-MC-Unique: 0ZS5dOcAP_Kwj4TSD2nzLg-1
X-Mimecast-MFC-AGG-ID: 0ZS5dOcAP_Kwj4TSD2nzLg_1759691892
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e3dcb36a1so24953165e9.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691892; x=1760296692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRpFNHgPPbK5fpFtNVbPj3sQYNUpsLNHYrc3Cj0nCsg=;
 b=GOnOrSTuZxTQXmRMo/grkXrl8fUR428DpPZtHoPGxN+4Li1CPTm615NxqyZv4cIaQV
 8IW+tRAVUmQHcf/WDUn9hXMD/t5blEaM2hKHyjtMdi9tExMUxIYWTt6mssq0T3UzTs9v
 JwgnDSsnwLGdqjhjf0ymX3BZi1Y3quPXUhvvnb/iZSYFiG0BWoig6D03XxEOfEMkwus0
 fy6fcFUPJNqrg31YuMkpdF5cqHYVcJDnCqQo6kSUfpS6M0z7ZpmzLwtOul+BpadyEhK4
 1bRkfXAuwiakUxObrjBpmnbMdjNWW8SaxfkwsFQFl1GgHJyRkwZdp5YI+Uk/psKIaDzG
 bZPQ==
X-Gm-Message-State: AOJu0YxFKD0SD2vIHSs5vv/2pHUtJAQ247hQFlnG+MdXK4/+m4cpvsJ0
 AP4rOx3Z7k/IhftH7Tfi/T5GDeDlndp0CfOJXd/9WDfogM7jgPJUR4eTkHTc4ngiJ3WNmoAm/6O
 TB31nP1iiD19dHCytKmXBUM84YHrFOec0A+xLhwFwhS9EBi1JkX1PloX1Yf2Z4iANaBH0/MaRmV
 S08URrhkyvhMv8VeMYCyluMJOXnTw8AIz1uw==
X-Gm-Gg: ASbGncsAKejOKgDiu/mN1XC0Ui0caVLL+CJc18YOJF0sykhtuT2pYTZmh7SfD6BUEVu
 M6eOBRudNs0MXuoxHf8bWf28XAaAnCJFGXm0LT+3AGmaMXTyjZgzf9YO7KviyXWEYPxZlAgVbqV
 TlNSVWO3Q5SXp6ZPOe8VeZOTiCEeuujzBb1g7wzjValOeqRx7h+HrDO3SPW6yBDsxKP9R9TTrIN
 QXui0MXiQm97pWAgrUwqtfAwSAhS3U4Oj+pzxttsmehbqwaZSzylamVI1N3Vq7M8F9LGxC613KS
 xlGDYgBTQpFBIBYzCeow8ELKz15ONllXgON0yiI=
X-Received: by 2002:a05:600c:c111:b0:46e:1b89:77f1 with SMTP id
 5b1f17b1804b1-46e793feb40mr30967525e9.9.1759691891486; 
 Sun, 05 Oct 2025 12:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl3ZecWmg6mZlVpPSyYDkX74MDKqzRZ1HNJ0XHkecduebYpDX4xkqUVMX9nClZ1xreciYFrw==
X-Received: by 2002:a05:600c:c111:b0:46e:1b89:77f1 with SMTP id
 5b1f17b1804b1-46e793feb40mr30967395e9.9.1759691890929; 
 Sun, 05 Oct 2025 12:18:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97fbsm17251517f8f.34.2025.10.05.12.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:09 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 57/75] amd_iommu: Add a page walker to sync shadow page tables
 on invalidation
Message-ID: <a513b8ef6c7679449ac9bc6fe7c98e6664a6c9f5.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

For the specified address range, walk the page table identifying regions
as mapped or unmapped and invoke registered notifiers with the
corresponding event type.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-9-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 80 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index c25981ff93..0e45435c77 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -681,6 +681,86 @@ fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte, uint64_t *pte,
     return 0;
 }
 
+/*
+ * Walk the guest page table for an IOVA and range and signal the registered
+ * notifiers to sync the shadow page tables in the host.
+ * Must be called with a valid DTE for DMA remapping i.e. V=1,TV=1
+ */
+static void __attribute__((unused))
+amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as, uint64_t *dte,
+                                   hwaddr addr, uint64_t size, bool send_unmap)
+{
+    IOMMUTLBEvent event;
+
+    hwaddr iova_next, page_mask, pagesize;
+    hwaddr iova = addr;
+    hwaddr end = iova + size - 1;
+
+    uint64_t pte;
+    int ret;
+
+    while (iova < end) {
+
+        ret = fetch_pte(as, iova, dte[0], &pte, &pagesize);
+
+        if (ret == -AMDVI_FR_PT_ROOT_INV) {
+            /*
+             * Invalid conditions such as the IOVA being larger than supported
+             * by current page table mode as configured in the DTE, or a failure
+             * to fetch the Page Table from the Page Table Root Pointer in DTE.
+             */
+            assert(pagesize == 0);
+            return;
+        }
+        /* PTE has been validated for major errors and pagesize is set */
+        assert(pagesize);
+        page_mask = ~(pagesize - 1);
+        iova_next = (iova & page_mask) + pagesize;
+
+        if (ret == -AMDVI_FR_PT_ENTRY_INV) {
+            /*
+             * Failure to read PTE from memory, the pagesize matches the current
+             * level. Unable to determine the region type, so a safe strategy is
+             * to skip the range and continue the page walk.
+             */
+            goto next;
+        }
+
+        event.entry.target_as = &address_space_memory;
+        event.entry.iova = iova & page_mask;
+        /* translated_addr is irrelevant for the unmap case */
+        event.entry.translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) &
+                                      page_mask;
+        event.entry.addr_mask = ~page_mask;
+        event.entry.perm = amdvi_get_perms(pte);
+
+        /*
+         * In cases where the leaf PTE is not found, or it has invalid
+         * permissions, an UNMAP type notification is sent, but only if the
+         * caller requested it.
+         */
+        if (!IOMMU_PTE_PRESENT(pte) || (event.entry.perm == IOMMU_NONE)) {
+            if (!send_unmap) {
+                goto next;
+            }
+            event.type = IOMMU_NOTIFIER_UNMAP;
+        } else {
+            event.type = IOMMU_NOTIFIER_MAP;
+        }
+
+        /* Invoke the notifiers registered for this address space */
+        memory_region_notify_iommu(&as->iommu, 0, event);
+
+next:
+        /* Check for 64-bit overflow and terminate walk in such cases */
+        if (iova_next < iova) {
+            break;
+        } else {
+            iova = iova_next;
+        }
+    }
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
-- 
MST


