Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E16960A2601
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TIbm83gz;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OKSiEAFg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7HF-0002HC-AF; Wed, 28 Oct 2026 13:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Gm-0001UJ-20
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Gk-0003yc-6d
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cir+mFJzA4Bj65dFGKcajxs4xlnVmewfcGaQZuCK4tM=;
 b=TIbm83gz3t2e8YnhHE2Ua7cRb22Qzsh6Zan0uJpqnYNQ/TjiTlmaVXqznIyEzfNR0DcHih
 eIFJFtY9tEpm+3mAVgPUFqEEdJ0O3KY8/m6uagURD7bqk5l6mVZj0IE0BM7/gMJblr5yHt
 4CC4y76k8HnwzNLD1dX8/C7CKp2m/l8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-IsHORdTnPYqd0TO5YLKn7A-1; Wed, 28 Oct 2026 13:16:55 -0400
X-MC-Unique: IsHORdTnPYqd0TO5YLKn7A-1
X-Mimecast-MFC-AGG-ID: IsHORdTnPYqd0TO5YLKn7A_1793207814
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a1d1f26a63so10989175e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207814; x=1793812614; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Cir+mFJzA4Bj65dFGKcajxs4xlnVmewfcGaQZuCK4tM=;
 b=OKSiEAFgGfeaYG6p9WO353s4iESRw6xBAfU513Cy0uFhwd/a3qJt6wY0vp2obmrgvg
 rjBLR8vvi9k2rcFMe0+FIPLFXvKkyuPnSzOmLUxQv+eETP1HRYGy7QVjFrnG0uQHw05O
 5lN6Ak3reRRj5xUVKx5pFCF4BwsJJmQV20k2CyDeCs6X8LtHvNxPwZ3KGP6gH/6zGo3Y
 kMpkABR/sILdgB1fBk8Mz8GnGH2xR70MUw/DKIpsD5CdjSHaxbv4vRdc2X6PrVg/9iSw
 v9kaWuzUlbfnYvKltsKMV/c7kkmzjFfW1z8nq73FDgQKjK0uoIftsULUFbszgYTFQAB9
 OSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207814; x=1793812614;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cir+mFJzA4Bj65dFGKcajxs4xlnVmewfcGaQZuCK4tM=;
 b=hn+JCCKMv4pXWEZyMBoMyeSA0Y9MMm58244ZaFaxGTsyx2TqrJD9EfFgn3YqQ1XCLM
 X1jKTjkuQg8TgoceuFZj17Lo+KplXvmYyeorjEaVyNcopxxDVfk/ft3vM7sQDAmN/rA3
 /6nbxPM6re0iSCC6kXAjGqI8xQXp7OZGO31bfJTs6xAkpepQ90snQnNqvoGUxflpdyMd
 88DWgLkG3fuxoIOMLxpj0LmbZ9vI6sQaD+2Lb5E4/wHultXm+1yfrSojjkY0QjxuCHff
 5h8Fg9J6tN9cDK1PHCub++oHX89gYwjx2h4CIbDSnJNUg97opfWp7uyKwebTtTyRFGC/
 EopQ==
X-Gm-Message-State: AFq9FYJzV0w9xdyrnMx8jY82Op4fTYjJSNk+ERNoov1qyCPDYjvLymAX
 ySHBKiTHtENVFB/kxrgQgEsJGjsZed5YfndoUMVcbNV68Y4V57D6/Xj/rgt6dydxpAN6mFqdgkn
 MzKcai3N6o5LRK+0MU4ItDUF8TWd+dZm4pW7TevIQAngXe6fwt/H4CTidN3K87367TJun33peIy
 yIOTDj+7Prpjy4vntEt3R7UHaYb3KDfijm2A==
X-Gm-Gg: AYBFou3R3jz64yfXhTk8hjFjlkDaAPTdU7JXVllB8FaaPOxSmYar7hOsfUHkr06YG2q
 rjdVSh9T8YFKb7X7QNz/BOo//uG9A1koFSlA07/nBKo6dECW2naJqn6zUKIr2jP/V6WROH6rggk
 rqxPlPAp49MF1ARvwOAn9P348KdyFz84TslBWeUKeCXWDvW0aivhX+ldyVxYoh8VH0yQT+sURyR
 VCydHRSoWnnsbI/JJJNoa/dspt87Jr8IKMCMqw5aEuRYkL65bhBuKj8Punb1VAcbeeXAAZFFP83
 Yti5NiFudB5HF6jgigcWFuJxncPtBPh3JlEvzdqZ5AgjYYgUqx0YyxdZyeoz+1I3NfpRIrWuXTa
 eOaGQ2AA2WvWLZj3BHgGf+v/AgvIxUgXSmm42luEH
X-Received: by 2002:a05:600c:4e55:b0:4a2:1655:87e2 with SMTP id
 5b1f17b1804b1-4a966f22108mr68349535e9.19.1793207814351; 
 Wed, 28 Oct 2026 10:16:54 -0700 (PDT)
X-Received: by 2002:a05:600c:4e55:b0:4a2:1655:87e2 with SMTP id
 5b1f17b1804b1-4a966f22108mr68348525e9.19.1793207813685; 
 Wed, 28 Oct 2026 10:16:53 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4bc5sm29495209f8f.34.2026.10.28.10.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:53 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: [PULL 65/78] i386/kvm: Use x86_iommu_device_get() for per-device
 IOMMU lookup
Message-ID: <70c046b180c8f85c5199d691c51715dd42a65efb.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sairaj Kodilkar <sarunkod@amd.com>

Currently, kvm_arch_fixup_msi_route() unconditionally uses the default
system IOMMU for interrupt remapping when IOMMU is present. This
approach fails when an IOMMU is attached to a non-system bus and serves
only a subset of devices, because the kernel does not program IRT
(Interrupt Remapping Table) entries for devices outside the IOMMU's
scope.

This patch changes the behavior to perform per-device IOMMU lookup:
- For PCI devices: Use pci_device_get_x86_iommu() to find the specific
  IOMMU serving that device, if any
- For non-PCI devices (IOAPIC): Fall back to the default IOMMU
  only if interrupt remapping is enabled (ioapic_as != address_space_memory)

This ensures MSI route translation occurs only for devices actually
managed by an IOMMU, enabling proper interrupt remapping in configurations
where IOMMUs are attached to arbitrary buses.

NOTE: This patch assumes that only non-PCI device calling is IOAPIC and
checks ioapic_as to determine interrupt remapping.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261014053433.24564-6-sarunkod@amd.com>
---
 hw/intc/ioapic.c      |  3 ++-
 target/i386/kvm/kvm.c | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 1932b14642..e171cf8432 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -438,8 +438,9 @@ static void ioapic_machine_done_notify(Notifier *notifier, void *data)
 #ifdef ACCEL_GSI_IRQFD_POSSIBLE
     IOAPICCommonState *s = container_of(notifier, IOAPICCommonState,
                                         machine_done);
+    X86MachineState *x86ms = X86_MACHINE(qdev_get_machine());
 
-    if (accel_irqchip_is_split()) {
+    if (accel_irqchip_is_split() && x86ms->ioapic_as != &address_space_memory) {
         X86IOMMUState *iommu = x86_iommu_get_default();
         if (iommu) {
             /* Register this IOAPIC with IOMMU IEC notifier, so that
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index da922f72d7..072da8b9f1 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6746,7 +6746,15 @@ uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address)
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
-    X86IOMMUState *iommu = x86_iommu_get_default();
+    X86IOMMUState *iommu = NULL;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    X86MachineState *x86ms = X86_MACHINE(ms);
+
+    if (dev) {
+        iommu = x86_iommu_device_get(dev);
+    } else if (x86ms->ioapic_as != &address_space_memory) {
+        iommu = x86_iommu_get_default();
+    }
 
     if (iommu) {
         X86IOMMUClass *class = X86_IOMMU_DEVICE_GET_CLASS(iommu);
@@ -6848,6 +6856,7 @@ int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
 {
     static bool notify_list_inited = false;
     MSIRouteEntry *entry;
+    X86IOMMUState *iommu = NULL;
 
     if (!dev) {
         /* These are (possibly) IOAPIC routes only used for split
@@ -6867,13 +6876,13 @@ int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
     if (!notify_list_inited) {
         /* For the first time we do add route, add ourselves into
          * IOMMU's IEC notify list if needed. */
-        X86IOMMUState *iommu = x86_iommu_get_default();
+        iommu = x86_iommu_device_get(dev);
         if (iommu) {
             x86_iommu_iec_register_notifier(iommu,
                                             kvm_update_msi_routes_all,
                                             NULL);
+            notify_list_inited = true;
         }
-        notify_list_inited = true;
     }
     return 0;
 }
-- 
MST


