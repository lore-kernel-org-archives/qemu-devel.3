Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D91AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 17:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZCgf-0008PC-76; Wed, 31 Jul 2024 13:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZCga-0008OR-DE
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 13:00:24 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZCgY-0005aa-N7
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 13:00:24 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42816ca782dso37738205e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722445220; x=1723050020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GVfQXyh9sObTktsvqbAirmP7HyrwY7BxoUCuAv78J14=;
 b=ujv7dLxR1dBgeGoDDzzTZ9hPx1vchtrSDLJClP9epAvM7bjXwpCaCrlIQP/MpLIxMJ
 KbSEcYSWpLRF/wohlx6JG/wBhuOlYF0kJs59dsP5AkKVfz7Gy7i6053F1ElsE8ssP4Hm
 1c+wiDnS8pnSxymvkctTKTqppjQdh5+xlodzDNJGTnAcQ8bGfEMH1as0vZylw3SOjo1w
 C7ZXK3+xLWvOtKhCJ7Z1yS3RV4ZVtNhQ494Te89muTHOWdeVuYqeJ6r3EWGWPcr/ZEQ8
 ONh4PJxQCPWFNIJwUcjbXpGZ4OOktN5Oyrvt62aM8UAJOSw8byLSVqjRQPDnKsCTSXPT
 om3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722445220; x=1723050020;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GVfQXyh9sObTktsvqbAirmP7HyrwY7BxoUCuAv78J14=;
 b=B1X967EFvK9fUlhX44CL0N9UEMW4FhAtluK2Lpw265SlpbMu6dnruo6NuSU+kRkYmj
 Boibv5UKvw337tHBDzlsivsFAEeY3o845Rc1wJIhkr4wEptA8hiNckxvdxgG4rOnqJWI
 7OgWyzgFbOvUVRWei13V0JmZBTV3Qpb21Hr+6AeFvxFtoGVkBy/u+v+ImAMBil4T0u1f
 LbGbXoBKMVgr//q8TfNmhYp28HB+5od/ovR2ZGrNMpz4K9+RSYhBnmPvbJNvg9Zwv+zk
 lZJxFw45mwQlJMb87Hw1ak4DrGhfrBA5MTrnIM6zAnOalc+40qCP1dD5+wDNKdQaqsat
 ylfA==
X-Gm-Message-State: AOJu0YwqnR7anyC946Qj5VAxLLTGqPBA6de3MAFtVkESPiM0cIeIMbrY
 6D1r31lnahVHeg9vvT10NZUg0otSDnOZDnj3PpogSyCsTRvoFnWeYhZMAQ9bNjZZ4/NT5RHbfjC
 s
X-Google-Smtp-Source: AGHT+IF4TXho/YVsnna+vH0liMMYR2EbE1VnukyTO/yor6mA7qsb/pUaEWUF/e08c/AHpNytvmbSuQ==
X-Received: by 2002:a1c:770f:0:b0:426:6667:bbbe with SMTP id
 5b1f17b1804b1-428a9bdb988mr517715e9.9.1722445220416; 
 Wed, 31 Jul 2024 10:00:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b8a1840sm28186975e9.5.2024.07.31.10.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:00:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH] hw/i386/amd_iommu: Don't leak memory in amdvi_update_iotlb()
Date: Wed, 31 Jul 2024 18:00:19 +0100
Message-Id: <20240731170019.3590563-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In amdvi_update_iotlb() we will only put a new entry in the hash
table if to_cache.perm is not IOMMU_NONE.  However we allocate the
memory for the new AMDVIIOTLBEntry and for the hash table key
regardless.  This means that in the IOMMU_NONE case we will leak the
memory we alloacted.

Move the allocations into the if() to the point where we know we're
going to add the item to the hash table.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2452
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Tested with 'make check' and 'make check-avocado' only, but the
bug and fix seem straightforward...
---
 hw/i386/amd_iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6d4fde72f9b..87643d28917 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -357,12 +357,12 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
                                uint64_t gpa, IOMMUTLBEntry to_cache,
                                uint16_t domid)
 {
-    AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
-    uint64_t *key = g_new(uint64_t, 1);
-    uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
-
     /* don't cache erroneous translations */
     if (to_cache.perm != IOMMU_NONE) {
+        AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
+        uint64_t *key = g_new(uint64_t, 1);
+        uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
+
         trace_amdvi_cache_update(domid, PCI_BUS_NUM(devid), PCI_SLOT(devid),
                 PCI_FUNC(devid), gpa, to_cache.translated_addr);
 
-- 
2.34.1


