Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20F4606A33C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cybjgd1s;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=POPIv/Zw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Hh-0004Dg-M6; Wed, 28 Oct 2026 13:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7G2-0008K8-FF
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7G0-0003rO-GU
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WuWjhEJMTOpZxB6niRJEcwhK7CIR3d2EGQIrtVaGOzM=;
 b=Cybjgd1sZDiJWrH3Ca3ERyOPr46+iMPSKiw0yUGsdQ8S6cfirwzHPsd5kp+FD1JLJU4+45
 k3ncHwQyl3LKVVOhX7iNsYuYrB8vJg+1Al1VSBTzhPoKuZTu54NE3qavD6C+C1AXSxS0JQ
 MnA2fX/XDxSNs3VkLuwuF716aA22NcY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-pUrtaA4sOHGDgijxSJEFKw-1; Wed, 28 Oct 2026 13:16:07 -0400
X-MC-Unique: pUrtaA4sOHGDgijxSJEFKw-1
X-Mimecast-MFC-AGG-ID: pUrtaA4sOHGDgijxSJEFKw_1793207767
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48af4046a3bso1029956f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207766; x=1793812566; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WuWjhEJMTOpZxB6niRJEcwhK7CIR3d2EGQIrtVaGOzM=;
 b=POPIv/Zwkp4ffrUe2yU3UiCs0kOUfD1HO1+A9G6XE1g8VMSRPNHVXFybRttM6a2+hg
 u/18ImkheLE81ZhK76EoTD7xSMH9S/K3URZL0hqcU6d4qLamt7La8P/2NWkLXh2CODal
 C8lvtiLIJIYk3XqzEaqQUSzSlImmcNijYVRY96s0qNZSCjOMod3kwrAIvnVv6Pq+Eb8V
 ROQ86yxiAViyTdmNUf3femZHBGEhMoq4iT0oHY7SZvlOnp8zH2PiPJQKf00dwRCex7Hh
 VKt/btXLfcEFfZLpxhj91nwA4mEd7i1VQX299MsjhC3koW258SIrS0o4dRvj7H9ypzCT
 lARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207766; x=1793812566;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WuWjhEJMTOpZxB6niRJEcwhK7CIR3d2EGQIrtVaGOzM=;
 b=NO56qNoqPXhTU3xHmMaXVj2Zq0VV2c0pIerw/OBtyBHsLT6sXBd0mA1M1hPhcQph7t
 dO1nQYcl7KOmtzmyGj2DjvCJXyWmIrr1MrbvOyw1AEFAqceaTuOV32RH89BNDIxy/3CA
 4j/T6amPzy34ozV4+pvf59v+nvtZtzrQNBSE46P/JdG2IaGQH8Q/XP0AKQbBBAIj4FvK
 +bK0jgPnP2AomW8Mxf/JUVAdCi5miaU2XHMDlle+LXeJeOWbtmo+ZbyhVTurwE4Icbw5
 U3GUBYLt17AJgaZldfR714/UqEaX6uT+VdSf4iLSI2LsDdOfLEPkqktT4ObAgFATgXak
 RP9Q==
X-Gm-Message-State: AFq9FYIA7lWAb3wPIe8zevHUe/4zoUO5mpJkNx7bA677D++m27nXunCy
 wFOuMFxHNsFG+g1ku8/qr7LSZnC9kLyP07KrubL8BNmqxO0k+oHcTMODlatI+ZctCbNTxRdnI0v
 TgK6A7Cm0nL+4TJymjh4q9pORSIPRPGLrhyHEGHvAeHJtxQYq0SGzxXq72tIuW6rdc25FjCCFNH
 B+IMlC/5b4Xivb3/pKQINkjQ5UZHuS3fNRLg==
X-Gm-Gg: AYBFou1HbtcQB0bmZYJch4ISXqA1KRYY1LrcRuPcaMy2TqBjNWVAHN9jlECOfHzqwkz
 OuCV4e36klTyHAyxvSjUfJuQVEcytXcbqycNbNH/O3viCgJ99pWoqNGumZO4oWhU8XVRAl3H8tN
 /+5VibpGy8KVRaesO2dGVX39VUnQLt1UG9IcgQHVVBtJ1CULzaWAt18fd+yLKClbgao6q6t+VAJ
 +RlOi0X1U0tbR9Xal2xZKRUkrf2YGFxVqwxxd/Vv+GPJbCwtbpABuE4Wxg4UAJYeBdTSO2+zmrT
 CPF+pWrP4KiJF/yi0dBIRdbyoGtW+18np7+fIWnfRc427GteOUo74ybStV/F6FheYWRGM+YC4UN
 g2TWz1eokWdpT7WMQIriTSkNnwlkc7JN6iuHH239h
X-Received: by 2002:a05:6000:4312:b0:48e:5fde:8437 with SMTP id
 ffacd0b85a97d-48e5fde8536mr4959409f8f.56.1793207766341; 
 Wed, 28 Oct 2026 10:16:06 -0700 (PDT)
X-Received: by 2002:a05:6000:4312:b0:48e:5fde:8437 with SMTP id
 ffacd0b85a97d-48e5fde8536mr4959308f8f.56.1793207765638; 
 Wed, 28 Oct 2026 10:16:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4bc5sm29492213f8f.34.2026.10.28.10.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:05 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li RongQing <lirongqing@baidu.com>
Subject: [PULL 48/78] pcie_sriov: fix wrong write width and off-by-one in
 pf_reset
Message-ID: <1482c4bfad87d5ca741706ff5c9ea677dfd152e1.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Li RongQing <lirongqing@baidu.com>

pcie_sriov_pf_reset() restores the VF BAR type registers using
pci_set_quad() with a 4-byte stride. Since each VF BAR register is
4 bytes wide, the 8-byte write also covers the following BAR
register. Although subsequent iterations overwrite most of the
unintended writes, the access is incorrect and the final iteration
can write beyond the VF BAR registers.

SR-IOV defines six VF BAR registers and does not provide a VF ROM BAR.
However, several SR-IOV code paths use PCI_NUM_REGIONS, which includes
the ROM slot and therefore has a value of seven.

In particular, the final iteration in pcie_sriov_pf_reset() currently
writes a quadword at the offset of the seventh region. This starts at
the byte immediately following the six VF BAR registers and can
overwrite subsequent fields in the SR-IOV capability.

Use pci_set_long() to match the 4-byte VF BAR register width, and use
PCI_SRIOV_NUM_BARS when iterating over SR-IOV VF BARs. This also makes
the BAR count consistent with the assertion in
pcie_sriov_pf_init_vf_bar().

Fixes: 19e55471d4e8 ("pcie_sriov: Allow user to create SR-IOV device")
Fixes: c8bc4db403e1 ("pcie_sriov: Reset SR-IOV extended capability")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260918063526.2191-1-lirongqing@baidu.com>
---
 hw/pci/pcie_sriov.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 69930c7b8c..6a748c3626 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -229,7 +229,7 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
 
     assert(sriov_cap > 0);
     assert(region_num >= 0);
-    assert(region_num < PCI_NUM_REGIONS);
+    assert(region_num < PCI_SRIOV_NUM_BARS);
     assert(region_num != PCI_ROM_SLOT);
 
     wmask = ~(size - 1);
@@ -308,7 +308,7 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
             return -1;
         }
 
-        for (size_t j = 0; j < PCI_NUM_REGIONS; j++) {
+        for (size_t j = 0; j < PCI_SRIOV_NUM_BARS; j++) {
             if (vfs[i]->io_regions[j].size != vfs[0]->io_regions[j].size ||
                 vfs[i]->io_regions[j].type != vfs[0]->io_regions[j].type) {
                 error_setg(errp, "inconsistent SR-IOV BARs");
@@ -344,7 +344,7 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
     dev->exp.sriov_pf.vf = vfs;
     dev->exp.sriov_pf.vf_user_created = true;
 
-    for (i = 0; i < PCI_NUM_REGIONS; i++) {
+    for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
         PCIIORegion *region = &vfs[0]->io_regions[i];
 
         if (region->size) {
@@ -457,8 +457,8 @@ void pcie_sriov_pf_reset(PCIDevice *dev)
      */
     pci_set_word(dev->config + sriov_cap + PCI_SRIOV_SYS_PGSIZE, 0x1);
 
-    for (uint16_t i = 0; i < PCI_NUM_REGIONS; i++) {
-        pci_set_quad(dev->config + sriov_cap + PCI_SRIOV_BAR + i * 4,
+    for (uint16_t i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+        pci_set_long(dev->config + sriov_cap + PCI_SRIOV_BAR + i * 4,
                      dev->exp.sriov_pf.vf_bar_type[i]);
     }
 }
-- 
MST


