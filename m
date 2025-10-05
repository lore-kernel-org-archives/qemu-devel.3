Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677CFCAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UGB-0005D3-Gl; Sun, 05 Oct 2025 15:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFc-0003J0-AW
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFa-0006ea-40
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GAfEAfK1eJRI4y+l49JKxdN48bM3wTU5KpeG8sWwPz0=;
 b=K6kxiPsL+Owij3wb/iYmeZ9wLEBUizuqm3kczLbpNk6D84oQJ43I0cuqCm+bfsa8jo1/m6
 FXPiyniXvqG24Q4a9Ki9oPLvLnoQdX5PNa4TyjiloaaetnLWoANF2KpWQk7YjBtfgB1Z4f
 Axt0d8Q/7PhTeiYhbRUXMYrZdr+syLA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-1YW-cOrWOca1WXvQZoLvNQ-1; Sun, 05 Oct 2025 15:18:28 -0400
X-MC-Unique: 1YW-cOrWOca1WXvQZoLvNQ-1
X-Mimecast-MFC-AGG-ID: 1YW-cOrWOca1WXvQZoLvNQ_1759691907
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e3e177893so22926425e9.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691907; x=1760296707;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAfEAfK1eJRI4y+l49JKxdN48bM3wTU5KpeG8sWwPz0=;
 b=WuVGEwkQIPxkAWsIs81wnzSFdTufh5E5XK75BGi5NoHNcTh0tb3Xd6XPuO7YgSnWMu
 1L9n1jb6nTjUxezyC7kBwRVcEFzE9rCXlyZ3fpC0+9kcxYyhRuM/5YZgP/0MKBGqGIfQ
 uM0BZrEoheenSGNnaowLe9bBroQL8CjWhRpd3xEPFMrRAf2OKtFaWEwtL2/W1/tRGuyq
 FYlzsNCD+ibLI2742/ivUvZIDBWqrBI4tNj/HRaNrxn6FabhctPa13BzIh+bOqAVS6Im
 tvp2zZCdcG3xqE1QbdHJ5nRRWsjL7b2QhmpQAy1RXWFG0WYU/mLUEIXpZl5IK3zEXjxy
 ZPKw==
X-Gm-Message-State: AOJu0YzS8K5xed/2KMarbLWZM3h6CibWK7+ws3Uso6u7yzH3O2LIVs6l
 PQ1ZmJ8sqUsQhoyibaSaQiCNvVz37n2T7CaXQ3M3lGok+Smp8KmBsuiK+pPvV3JXZ8Xg41haMr+
 JEh21ChFwieBdFg71ftpmAl9FeIyegvNlZY8bCdjAUW9LicK9owB7nI8PztnOjb+7x9rE+OhC0g
 zvHtDNXOlPuVoi3RcH12Xd+kbMVuv5KmTceA==
X-Gm-Gg: ASbGncsC52uyjYl82Q7ABg+T2SqI848lm1YGjVOKhjFUXeXECaPJZsIVRegjpugzGdW
 qHNBviHXmXDk8Bwqrfds+/dCR8ygmr/KjMEeWrPAlsw6VJjdjf/poRCTYcmWxK91MhfYFH0fTbP
 s31DAq0qQ2Pjo0tETIlkYfdGm2pA3tc0kHnkNFKyXd6xS+yyTxC/kFRA0BoFkIGAfBVhWxiHK8b
 QDNVbj+OPsLy87y7LuyzTRpCfT+EmCxo+fHFFifOGxu5Cbzcji1i2A1NsMlO5SW7mG9FseESM2+
 L0BwMH4VPRtWlwFw5+Qv9iWsiu6wx3L3/LwV4k0=
X-Received: by 2002:a05:600c:4e0e:b0:46e:5df3:190d with SMTP id
 5b1f17b1804b1-46f9d694446mr4446805e9.11.1759691906550; 
 Sun, 05 Oct 2025 12:18:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwAiE/GhgIC5s9WAyAruzTtPbjdNa4Zo+puE0+Wr3p5V9yqU3sznEJbYynSmdoE4ZP5H6F5g==
X-Received: by 2002:a05:600c:4e0e:b0:46e:5df3:190d with SMTP id
 5b1f17b1804b1-46f9d694446mr4446655e9.11.1759691906014; 
 Sun, 05 Oct 2025 12:18:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f45e9sm17826290f8f.51.2025.10.05.12.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:25 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 64/75] amd_iommu: Toggle memory regions based on address
 translation mode
Message-ID: <75fd28e3a754487a675a094cf9990a60437d8167.1759691708.git.mst@redhat.com>
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

Enable the appropriate memory region for an address space depending on the
address translation mode selected for it. This is currently based on a
generic x86 IOMMU property, and only done during the address space
initialization. Extract the code into a helper and toggle the regions based
on whether the specific address space is using address translation (via the
newly introduced addr_translation field). Later, region activation will also
be controlled by availability of DMA remapping capability (via dma-remap
property to be introduced in follow up changes).

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-16-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index d74d42b3dd..67a26f5247 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -74,6 +74,8 @@ struct AMDVIAddressSpace {
     QLIST_ENTRY(AMDVIAddressSpace) next;
     /* Record DMA translation ranges */
     IOVATree *iova_tree;
+    /* DMA address translation active */
+    bool addr_translation;
 };
 
 /* AMDVI cache entry */
@@ -982,6 +984,23 @@ static void amdvi_iommu_address_space_sync_all(AMDVIState *s)
     }
 }
 
+/*
+ * Toggle between address translation and passthrough modes by enabling the
+ * corresponding memory regions.
+ */
+static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
+{
+    if (amdvi_as->addr_translation) {
+        /* Enabling DMA region */
+        memory_region_set_enabled(&amdvi_as->iommu_nodma, false);
+        memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), true);
+    } else {
+        /* Disabling DMA region, using passthrough */
+        memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), false);
+        memory_region_set_enabled(&amdvi_as->iommu_nodma, true);
+    }
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
@@ -2070,6 +2089,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         iommu_as[devfn]->iommu_state = s;
         iommu_as[devfn]->notifier_flags = IOMMU_NOTIFIER_NONE;
         iommu_as[devfn]->iova_tree = iova_tree_new();
+        iommu_as[devfn]->addr_translation = false;
 
         amdvi_dev_as = iommu_as[devfn];
 
@@ -2112,8 +2132,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
                                             AMDVI_INT_ADDR_FIRST,
                                             &amdvi_dev_as->iommu_ir, 1);
 
-        memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
-        memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu), true);
+        amdvi_switch_address_space(amdvi_dev_as);
     }
     return &iommu_as[devfn]->as;
 }
-- 
MST


