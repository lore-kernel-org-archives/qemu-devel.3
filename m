Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BCBCAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UGP-0005qm-IT; Sun, 05 Oct 2025 15:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFl-0004UC-FD
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFi-0006fJ-1R
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r7Zh1GmB+h9beTPga1Sxsa0PNr++51jOf+TUxOiKSc0=;
 b=SUZL3n8Jo4anVZXZj0BAlt7JPgxsCEcPxbuqI8Uk08M2yQAnwlaOiyfYqHMMLntP93Tyom
 KXb2WPUSg7+muyzB9dHjTUZ+PjpvHr/eJ2mqgmO8BWXlVygIl5jgKiuGsRM2RBPEGWbtYg
 tInJuIHrYaUJf7NRBoQsItC1WTwrxDg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-Wvxl2j1oPkGF_yLDZ3oNAQ-1; Sun, 05 Oct 2025 15:18:34 -0400
X-MC-Unique: Wvxl2j1oPkGF_yLDZ3oNAQ-1
X-Mimecast-MFC-AGG-ID: Wvxl2j1oPkGF_yLDZ3oNAQ_1759691914
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f93db57449so1943986f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691913; x=1760296713;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7Zh1GmB+h9beTPga1Sxsa0PNr++51jOf+TUxOiKSc0=;
 b=i+zuuwqaMMDDahK/UFNtgxgFv3Wv43UU59KCwyEDv0hmdnPqFjJ2T/6AA784h5rOEH
 4sFkINtGDCfd4Xt0J4J8L+Ge+ygIaYV59VLHvBQGpVbhLCEOQiuFUopupXJKgz1C6vSF
 qktTqDJg+bUX0lQdMH7sAk7/q2kdjYM4UnqZ0mL+uyrG7bp1rMyJIAaCNnrgWCulRuqL
 j/Xcoe2vP01BEScOWuxhzo2I+F70U+btrnrmjOi+sud6ngJPn0kkfrrDsitTe2UfVfsQ
 7SJ4aFpvsu8axNDEJqB9pElYPAZg85fBGc3Hd/ZSf5px+DNcpa7YieKUlZXo42tB51i0
 N20w==
X-Gm-Message-State: AOJu0YzvaqEEwb7Xi2CimDMS5JhV1us0KmNoM+NtkMmr75dsZwc9eMR/
 x4vs50C7EsqBo3ozXUGdxcjkAoFiuErdjv6YuAEUNJ400m3Xjv4ULwoEpBuUPGxtPDz8gruBKJu
 b/FAOpIyJcyaOb43UsSIGKh+/Bm3DlSVyXsPw/7X+PB8X2rbdud70H3a/+9Q+79gn9BOF4gx3xV
 QnD3mBqnH8uDPAn0ASPeZTvqBedEanp/Wf1A==
X-Gm-Gg: ASbGnctgmSrdkkz1yCxGh8kHFQJdExeUtaHLpihu4K96hxxwi0Ywfoa0F5W4cn1QR6g
 p9xikTM9MaL9cDumJYfZsCPqicCfihpDwvYOkjV6ub5MgAQTDvA5pyc55N7UzTx/IfPsseUd9B8
 dxw4u27PObtLOeYak7gM3lk3setPs6ET5nCHv9CJQA1qYQmAaiW4pjKG4rfEHOykjqGNtoOjYIG
 DVvajpA+9LK829qTRfvgwM9vuBhCg1RE3lZvni2z5eWKE/H4rRo8BaYqqeK56j1QbeyM2a2sTRN
 KmkEaXW+clfRkyZEMHSuVMSKn/WPkV4h6bOJQjo=
X-Received: by 2002:a05:6000:2204:b0:408:5363:8266 with SMTP id
 ffacd0b85a97d-425671b07c1mr6599710f8f.44.1759691913227; 
 Sun, 05 Oct 2025 12:18:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8cxAq4obRj8OFJxz7gB7jh0hMkedXPXfzEp4BqapU+YwJSQpNhn/5MQ4NMlydgu6dcYmpxw==
X-Received: by 2002:a05:6000:2204:b0:408:5363:8266 with SMTP id
 ffacd0b85a97d-425671b07c1mr6599684f8f.44.1759691912604; 
 Sun, 05 Oct 2025 12:18:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f0392sm17629852f8f.42.2025.10.05.12.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:31 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 67/75] amd_iommu: Toggle address translation mode on devtab
 entry invalidation
Message-ID: <5670069df966ac146cc404011af23c257380368d.1759691708.git.mst@redhat.com>
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

A guest must issue an INVALIDATE_DEVTAB_ENTRY command after changing a
Device Table entry (DTE) e.g. after attaching a device and setting up its
DTE. When intercepting this event, determine if the DTE has been configured
for paging or not, and toggle the appropriate memory regions to allow DMA
address translation for the address space if needed. Requires dma-remap=on.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-19-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 122 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 120 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index ce5d4c3662..e916dcb2be 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1032,18 +1032,136 @@ static void amdvi_reset_address_translation_all(AMDVIState *s)
     }
 }
 
+static void enable_dma_mode(AMDVIAddressSpace *as, bool inval_current)
+{
+    /*
+     * When enabling DMA mode for the purpose of isolating guest devices on
+     * a failure to retrieve or invalid DTE, all existing mappings must be
+     * dropped.
+     */
+    if (inval_current) {
+        IOMMUNotifier *n;
+        IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
+            amdvi_address_space_unmap(as, n);
+        }
+    }
+
+    if (as->addr_translation) {
+        return;
+    }
+
+    /* Installing DTE enabling translation, activate region */
+    as->addr_translation = true;
+    amdvi_switch_address_space(as);
+    /* Sync shadow page tables */
+    amdvi_address_space_sync(as);
+}
+
+/*
+ * If paging was previously in use in the address space
+ * - invalidate all existing mappings
+ * - switch to no_dma memory region
+ */
+static void enable_nodma_mode(AMDVIAddressSpace *as)
+{
+    IOMMUNotifier *n;
+
+    if (!as->addr_translation) {
+        /* passthrough is already active, nothing to do */
+        return;
+    }
+
+    as->addr_translation = false;
+    IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
+        /* Drop all mappings for the address space */
+        amdvi_address_space_unmap(as, n);
+    }
+    amdvi_switch_address_space(as);
+}
+
+/*
+ * A guest driver must issue the INVALIDATE_DEVTAB_ENTRY command to the IOMMU
+ * after changing a Device Table entry. We can use this fact to detect when a
+ * Device Table entry is created for a device attached to a paging domain and
+ * enable the corresponding IOMMU memory region to allow for DMA translation if
+ * appropriate.
+ */
+static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
+{
+    uint8_t bus_num, devfn, dte_mode;
+    AMDVIAddressSpace *as;
+    uint64_t dte[4] = { 0 };
+    int ret;
+
+    /*
+     * Convert the devid encoded in the command to a bus and devfn in
+     * order to retrieve the corresponding address space.
+     */
+    bus_num = PCI_BUS_NUM(devid);
+    devfn = devid & 0xff;
+
+    /*
+     * The main buffer of size (AMDVIAddressSpace *) * (PCI_BUS_MAX) has already
+     * been allocated within AMDVIState, but must be careful to not access
+     * unallocated devfn.
+     */
+    if (!s->address_spaces[bus_num] || !s->address_spaces[bus_num][devfn]) {
+        return;
+    }
+    as = s->address_spaces[bus_num][devfn];
+
+    ret = amdvi_as_to_dte(as, dte);
+
+    if (!ret) {
+        dte_mode = (dte[0] >> AMDVI_DEV_MODE_RSHIFT) & AMDVI_DEV_MODE_MASK;
+    }
+
+    switch (ret) {
+    case 0:
+        /* DTE was successfully retrieved */
+        if (!dte_mode) {
+            enable_nodma_mode(as); /* DTE[V]=1 && DTE[Mode]=0 => passthrough */
+        } else {
+            enable_dma_mode(as, false); /* Enable DMA translation */
+        }
+        break;
+    case -AMDVI_FR_DTE_V:
+        /* DTE[V]=0, address is passed untranslated */
+        enable_nodma_mode(as);
+        break;
+    case -AMDVI_FR_DTE_RTR_ERR:
+    case -AMDVI_FR_DTE_TV:
+        /*
+         * Enforce isolation by using DMA in rare scenarios where the DTE cannot
+         * be retrieved or DTE[TV]=0. Existing mappings are dropped.
+         */
+        enable_dma_mode(as, true);
+        break;
+    }
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
     uint16_t devid = cpu_to_le16((uint16_t)extract64(cmd[0], 0, 16));
 
+    trace_amdvi_devtab_inval(PCI_BUS_NUM(devid), PCI_SLOT(devid),
+                             PCI_FUNC(devid));
+
     /* This command should invalidate internal caches of which there isn't */
     if (extract64(cmd[0], 16, 44) || cmd[1]) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
+        return;
+    }
+
+    /*
+     * When DMA remapping capability is enabled, check if updated DTE is setup
+     * for paging or not, and configure the corresponding memory regions.
+     */
+    if (s->dma_remap) {
+        amdvi_update_addr_translation_mode(s, devid);
     }
-    trace_amdvi_devtab_inval(PCI_BUS_NUM(devid), PCI_SLOT(devid),
-                             PCI_FUNC(devid));
 }
 
 static void amdvi_complete_ppr(AMDVIState *s, uint64_t *cmd)
-- 
MST


