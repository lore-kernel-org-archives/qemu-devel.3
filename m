Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD92CCA472
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UG5-0004wf-JV; Sun, 05 Oct 2025 15:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFQ-0002Rv-OC
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFN-0006bh-FN
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+0h9FTrsqm/g/IFQsQ8t5vQ0TqkRAGX49Oc6QIoc2zU=;
 b=fFfKuH7W0+gApFj/LUDzNq7IA3l6vngQ5AhxD/rXUH2SgTWxivR2TPD1Ajf0leDLzhfM2I
 wQC4SokUXHI1zWSXqQplubFrspRAlIEgR2Ryb0zsyIOref5if96g8C01us5K0Tr15YuMtH
 61rnNYDLI3F1mNyBrC0aGkKC9+6gaRs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-wwPX6j4dO0G7fy4ypblObQ-1; Sun, 05 Oct 2025 15:18:15 -0400
X-MC-Unique: wwPX6j4dO0G7fy4ypblObQ-1
X-Mimecast-MFC-AGG-ID: wwPX6j4dO0G7fy4ypblObQ_1759691894
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ee12ab7f33so2159564f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691894; x=1760296694;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0h9FTrsqm/g/IFQsQ8t5vQ0TqkRAGX49Oc6QIoc2zU=;
 b=aLwoQWS5PHjv+rTatCrn0d7QbGeEAw25A8L6QmPF3oNI/EQQOYNduLzSUdGV5WU0kR
 962Kml8lNKOBkbjOKEEcAW4Jcg/+c5J/O9Mkniyq6/4p2awl7tRGIa29FvjESmidyDSC
 Tq9EGuPZ81+ml4chU2INbTLiGG3UVpLlWq5kWl7vd54zJRpAIPqYicfEQ7ciIVRuNFxD
 VnpALdr9TlAtHVjL8tsTfMzTBA9DqoBXaKXXhq7VJmM9bUxv8eYRbq2FaynvhLfZvrfu
 hmTAuZmUDUJQD/4GIxWGOOM01LAZvOU0g4ePxtlfNNKN/cK1u+9Cgjf37mcJXyFInmYf
 y2aQ==
X-Gm-Message-State: AOJu0Yxrw7OST51Y8AsB9pPoQTjd/Hoqr8Pr/+d+omtaQqKEs8sScQ/h
 DBSmPqMfIUbVUtUeaGgVksepwDDyYUffkeY1UrNPSYLUgFokQHf+bfsdBKMZdmkxxWjiyBYlFQ8
 l/ynLH0kRSVVYYQd2dLwtVcOw4EDj8OY/+a2ysrbA+TcPiH87l0IISgTB12NdoDAy667vgOfeBN
 hO+V9Ed0L4KoAZ1SWEe4GWp9cmJt6TQojeZQ==
X-Gm-Gg: ASbGncsgoQ+CBRhXwpHq/OztJzlX7gS73FiCPK/EkJMsNPJY8pgSvKhWcGHVSYHM12s
 oK0QuEBfEUu/SAAHR1LnsVzE4FhossBT0j+W0zdi4NAgxfGuqQ+kFeEUpOKqAvmqagOEWcNccWc
 G6Cod1QkYVqOKNaxUD6+1gqYLT9SmMKRBurnkYyu/R8A8TgbWsAGpFDDRdII1FhIF1nP2VHMuRf
 1OLpUtGWMfS0Wo+rF+FKOn/VtdjiW8RZuRKVrV6a+ps6Pl98tzb9HIx5lDYln0CPhWbyOKW6uW/
 vQfrNloECKmdx6RRHjYTDqd3QA1Sv6TgklLGj7U=
X-Received: by 2002:a05:6000:2287:b0:3ec:dc9d:bfcd with SMTP id
 ffacd0b85a97d-425671c8e29mr6571893f8f.63.1759691893529; 
 Sun, 05 Oct 2025 12:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL2HBwSu01KsmCEmh/1Yz/m4hN2iR8zjs/od1K9bPylvxZTcm+UyNQRCkNCBAoCoj1hnK/RQ==
X-Received: by 2002:a05:6000:2287:b0:3ec:dc9d:bfcd with SMTP id
 ffacd0b85a97d-425671c8e29mr6571876f8f.63.1759691892936; 
 Sun, 05 Oct 2025 12:18:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b86e1sm216945195e9.5.2025.10.05.12.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:12 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 58/75] amd_iommu: Add basic structure to support IOMMU
 notifier updates
Message-ID: <325b2562600e0c25e4fe172d1a1e9499fc854250.1759691708.git.mst@redhat.com>
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

Add the minimal data structures required to maintain a list of address
spaces (i.e. devices) with registered notifiers, and to update the type of
events that require notifications.
Note that the ability to register for MAP notifications is not available.
It will be unblocked by following changes that enable the synchronization of
guest I/O page tables with host IOMMU state, at which point an amd-iommu
device property will be introduced to control this capability.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-10-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h |  3 +++
 hw/i386/amd_iommu.c | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 9f833b297d..b51aa74368 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -409,6 +409,9 @@ struct AMDVIState {
     /* for each served device */
     AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
 
+    /* list of address spaces with registered notifiers */
+    QLIST_HEAD(, AMDVIAddressSpace) amdvi_as_with_notifiers;
+
     /* IOTLB */
     GHashTable *iotlb;
 
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 0e45435c77..d8a451b3a5 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -66,6 +66,11 @@ struct AMDVIAddressSpace {
     MemoryRegion iommu_nodma;   /* Alias of shared nodma memory region  */
     MemoryRegion iommu_ir;      /* Device's interrupt remapping region  */
     AddressSpace as;            /* device's corresponding address space */
+
+    /* DMA address translation support */
+    IOMMUNotifierFlag notifier_flags;
+    /* entry in list of Address spaces with registered notifiers */
+    QLIST_ENTRY(AMDVIAddressSpace) next;
 };
 
 /* AMDVI cache entry */
@@ -1773,6 +1778,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         iommu_as[devfn]->bus_num = (uint8_t)bus_num;
         iommu_as[devfn]->devfn = (uint8_t)devfn;
         iommu_as[devfn]->iommu_state = s;
+        iommu_as[devfn]->notifier_flags = IOMMU_NOTIFIER_NONE;
 
         amdvi_dev_as = iommu_as[devfn];
 
@@ -1846,6 +1852,7 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
                                            Error **errp)
 {
     AMDVIAddressSpace *as = container_of(iommu, AMDVIAddressSpace, iommu);
+    AMDVIState *s = as->iommu_state;
 
     if (new & IOMMU_NOTIFIER_MAP) {
         error_setg(errp,
@@ -1854,6 +1861,19 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
                    PCI_FUNC(as->devfn));
         return -EINVAL;
     }
+
+    /*
+     * Update notifier flags for address space and the list of address spaces
+     * with registered notifiers.
+     */
+    as->notifier_flags = new;
+
+    if (old == IOMMU_NOTIFIER_NONE) {
+        QLIST_INSERT_HEAD(&s->amdvi_as_with_notifiers, as, next);
+    } else if (new == IOMMU_NOTIFIER_NONE) {
+        QLIST_REMOVE(as, next);
+    }
+
     return 0;
 }
 
-- 
MST


