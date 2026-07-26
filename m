Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94E4C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6QC-00082C-ND; Sun, 26 Jul 2026 17:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Q7-0007v4-Oi
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6Q5-0004M8-SA
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=myr2FfCTdeCEuGnVsWMQ9NAAavu++eEZIA6gyuM1QZg=;
 b=GgJWfja1ZnzX46I3aaUNKu1nrWUEyjhRLabaPLYjaEnpDwAhgbmC6SzaDl0LSpN8EriD2y
 29aPA5jD6BGBnibC6YRzb2Kr9SoDnQ2F7qU6WVGmlm7Gj0AhaW/1vwibYAt3s7vgCiAszG
 2XpG9Pan1M7B+d9jODGOpayEyyYzXVM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-GK_8LeQDM0uUAqeZgV-PXQ-1; Sun, 26 Jul 2026 17:29:59 -0400
X-MC-Unique: GK_8LeQDM0uUAqeZgV-PXQ-1
X-Mimecast-MFC-AGG-ID: GK_8LeQDM0uUAqeZgV-PXQ_1785101398
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f8580ed9eso1795586f8f.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101398; x=1785706198; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=myr2FfCTdeCEuGnVsWMQ9NAAavu++eEZIA6gyuM1QZg=;
 b=dvBg2rVAvIlwpuNFCGeyUin1NPR3wnL3f2bbsTAtRviPWsX7qHHj3YqO8VeBSZWpJf
 uvQGDqK07GhneTKrMKCs5D37Sc62YwcFO4HZK5uNoJvWh6IvhUeQLI5KzYka9Mw4rwXb
 LzajUpUYmjLpnpMUEOck8tCaPcSRQzuEqC8ao9kavnUr9+j8Mjp6jUXgPAWvlTovv1kJ
 bOAfaJQbNJXmE5hARcTkZeGuOlQKGpYrGGHZN5MZfUft9ssN9dnms1kalD5Hw/Fjio3X
 XT1J/ZbV2eco5Qq1L555zMkmaRE9/LDkmggtisHDhBooDTnFeuuxQwQBLzl5gX+mUbTY
 6f+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101398; x=1785706198;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=myr2FfCTdeCEuGnVsWMQ9NAAavu++eEZIA6gyuM1QZg=;
 b=VkpGiH2yF8mVzYAhGUV9Dj1KFafnAMyZMtNAXhzYpO90r/mCIaW+VR3U3Vm3EJp9sQ
 XKeqaZD0QkYG6H86W5ZRvPOvSDRTquj5l7vgWPmo2M2Mk9c1u8PaUPjRVcudmRx/LzhT
 c81946TVy8IaSs7nG20MRnie3FXXi0W05474cC8pziTY4asxNm6x5AuQKGAD1peG6aD3
 cGWRcjJvMkxLZOaN3IYuu6czNR/35nlfOx2p84FM/59IrWR3kYt4EDZedvtvV/uBYQVE
 84XyiCvqNXBCxbd0Z6HpjGSBbvMwcXdzbrSjFMdpEtdr8c4DIEys3YYunl4NH3qOtfvI
 nNOA==
X-Gm-Message-State: AOJu0YxWTS8x0H9IxPoGOFDbDqpYtYbfq48HmZWyCLTBY+CyoDbQDgS0
 V3CcpRsBi4RA7D6YRBBvuOWqc0OFQG1eqTPBoMEfonYHipIImZsWG5qc+r8cusVU9i/yICLp/DF
 VUnniLVBsXqg+NRMZuklF9FX4FW2qIHLO+yZWWNqDPrbmxrKpFrMBr7feyBUwcggooHqF0sNQse
 cSr6zOrE/01z+bYKixFNcIDCqdEhqG8pf4Pw==
X-Gm-Gg: AR+sD107QsNA13LVSdurtxcTIiXBwU94NAx8JWp+TPR5VkA5izLJrGn/e7inoMn3bY4
 9HgEvR6VmyM6z3872nsZgomphqM5FtRnqJgQlwMEmHea3dwkJNK+ckb2rFf3pper/fWbWKIm+y3
 pnzouH2JZDr+/ReVQW7FA/SfluvOHQdE9EdVe8wuJKHyx3BRIReV93wasb8NzXuxs2TWznoZ7vi
 guRfrO4bpw4LAgof/SQwXOPq9N/2GAS8zHkEVmJRsAPcMGY4w9I7L1B/G6va5nt9/5ehjtwG+Od
 gMmYSvtR69WgJlKLkuDGjvh6HuQdBEtAkr01kiESuHwU8bC9r5CQfJLQMWhd2QNvLu6NtIjOjDq
 t+lgrgt7SVCt0GYxGEaqycg==
X-Received: by 2002:a5d:64e4:0:b0:47f:93a1:116a with SMTP id
 ffacd0b85a97d-47f9fc92ec4mr7933613f8f.17.1785101398246; 
 Sun, 26 Jul 2026 14:29:58 -0700 (PDT)
X-Received: by 2002:a5d:64e4:0:b0:47f:93a1:116a with SMTP id
 ffacd0b85a97d-47f9fc92ec4mr7933590f8f.17.1785101397644; 
 Sun, 26 Jul 2026 14:29:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f864305f5sm41832093f8f.17.2026.07.26.14.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:29:57 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:29:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 23/30] hw/pci-host/q35.c: Factor out creation of SMRAM MRs
Message-ID: <394b11b87123a1730019b7df9def2c00e6cb28e0.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

mch_realize has a large section that deals with initializing the
SMRAM-specific MemoryRegions.  Currently we do an early return from
the realize function if mch->has_smm_ranges is false, but this has
the potential for bugs if somebody adds new code at the end of the
function that isn't SMM-specific.  Pull the MR init code out into its
own function, so we can do the smm-ranges specific handling in the
realize function in a more obvious way.

This commit shouldn't change behaviour at all.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260708121011.1653365-3-peter.maydell@linaro.org>
---
 hw/pci-host/q35.c | 91 ++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 44 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 47e726c41d..e42b84b978 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -572,49 +572,9 @@ static void mch_reset(DeviceState *qdev)
     mch_update(mch);
 }
 
-static void mch_realize(PCIDevice *d, Error **errp)
+static void mch_init_smram_regions(MCHPCIState *mch)
 {
-    int i;
-    MCHPCIState *mch = MCH_PCI_DEVICE(d);
-
-    if (mch->ext_tseg_mbytes > MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_MAX) {
-        error_setg(errp, "invalid extended-tseg-mbytes value: %" PRIu16,
-                   mch->ext_tseg_mbytes);
-        return;
-    }
-
-    /* setup pci memory mapping */
-    pc_pci_as_mapping_init(mch->system_memory, mch->pci_address_space);
-
-    /* PAM */
-    init_pam(&mch->pam_regions[0], OBJECT(mch), mch->ram_memory,
-             mch->system_memory, mch->pci_address_space,
-             PAM_BIOS_BASE, PAM_BIOS_SIZE);
-    for (i = 0; i < ARRAY_SIZE(mch->pam_regions) - 1; ++i) {
-        init_pam(&mch->pam_regions[i + 1], OBJECT(mch), mch->ram_memory,
-                 mch->system_memory, mch->pci_address_space,
-                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
-    }
-
-    /*
-     * This memory region looks like it's SMM specific, but it is not.
-     * It's an alias that makes the pci_address_space appear in system
-     * memory at the SMRAM_C_BASE address. The alias is enabled when the
-     * CPU should not see SMRAM, and *disabled* when the low SMRAM should be
-     * visible. So for non-SMM configs we need to create the alias, and
-     * leave it permanently enabled.
-     */
-    memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
-                             mch->pci_address_space, MCH_HOST_BRIDGE_SMRAM_C_BASE,
-                             MCH_HOST_BRIDGE_SMRAM_C_SIZE);
-    memory_region_add_subregion_overlap(mch->system_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
-                                        &mch->smram_region, 1);
-    memory_region_set_enabled(&mch->smram_region, true);
-
-    if (!mch->has_smm_ranges) {
-        return;
-    }
-
+    /* Initialize all the SMRAM specific MemoryRegions */
     memory_region_init_alias(&mch->open_high_smram, OBJECT(mch), "smram-open-high",
                              mch->ram_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
                              MCH_HOST_BRIDGE_SMRAM_C_SIZE);
@@ -670,9 +630,52 @@ static void mch_realize(PCIDevice *d, Error **errp)
     memory_region_set_enabled(&mch->smbase_window, false);
     memory_region_add_subregion(&mch->smram, MCH_HOST_BRIDGE_SMBASE_ADDR,
                                 &mch->smbase_window);
+}
 
-    object_property_add_const_link(qdev_get_machine(), "smram",
-                                   OBJECT(&mch->smram));
+static void mch_realize(PCIDevice *d, Error **errp)
+{
+    int i;
+    MCHPCIState *mch = MCH_PCI_DEVICE(d);
+
+    if (mch->ext_tseg_mbytes > MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_MAX) {
+        error_setg(errp, "invalid extended-tseg-mbytes value: %" PRIu16,
+                   mch->ext_tseg_mbytes);
+        return;
+    }
+
+    /* setup pci memory mapping */
+    pc_pci_as_mapping_init(mch->system_memory, mch->pci_address_space);
+
+    /* PAM */
+    init_pam(&mch->pam_regions[0], OBJECT(mch), mch->ram_memory,
+             mch->system_memory, mch->pci_address_space,
+             PAM_BIOS_BASE, PAM_BIOS_SIZE);
+    for (i = 0; i < ARRAY_SIZE(mch->pam_regions) - 1; ++i) {
+        init_pam(&mch->pam_regions[i + 1], OBJECT(mch), mch->ram_memory,
+                 mch->system_memory, mch->pci_address_space,
+                 PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
+    }
+
+    /*
+     * This memory region looks like it's SMM specific, but it is not.
+     * It's an alias that makes the pci_address_space appear in system
+     * memory at the SMRAM_C_BASE address. The alias is enabled when the
+     * CPU should not see SMRAM, and *disabled* when the low SMRAM should be
+     * visible. So for non-SMM configs we need to create the alias, and
+     * leave it permanently enabled.
+     */
+    memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
+                             mch->pci_address_space, MCH_HOST_BRIDGE_SMRAM_C_BASE,
+                             MCH_HOST_BRIDGE_SMRAM_C_SIZE);
+    memory_region_add_subregion_overlap(mch->system_memory, MCH_HOST_BRIDGE_SMRAM_C_BASE,
+                                        &mch->smram_region, 1);
+    memory_region_set_enabled(&mch->smram_region, true);
+
+    if (mch->has_smm_ranges) {
+        mch_init_smram_regions(mch);
+        object_property_add_const_link(qdev_get_machine(), "smram",
+                                       OBJECT(&mch->smram));
+    }
 }
 
 static const Property mch_props[] = {
-- 
MST


