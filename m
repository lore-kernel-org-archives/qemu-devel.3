Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CACCCD1A0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 12:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqtuR-0008TW-Mb; Wed, 18 Sep 2024 08:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqtuP-0008SG-0l
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:35:49 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqtuM-0000Vb-SF
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=EaFCSeAddCX2V80eWWKUALbStKoCzTbK+KMlu1GeSqI=; b=qOvpSBrKGPEDC9gi
 L+kwh5OdUGufXs9QR/QA2f1jaZSKFKJAx04/hN5Ha52zl+mpb3jlINDA250YcASzEbqj7Yoren+XX
 zJLAxLnymAoNlfbV/6P15YZ4sXZdHT+VRHO/wKmZ1c/wqF6OlRF32HV57mYC3KQA/BWQk7TG7LiCz
 dmOqcWHajIKv/ct04Xk6IY8HAOMhpVu4rc/91Z+hqCA9y2pPtf+rgwUblymNunXlLWp4xrRNqAzzL
 JT0Pe/ivEe/wTROWPWUzM2uJ3ZEhrK8CWokCMhPaTfGTHYonPfS5Hk/Cv2nyHAXxhOdWEKjyY5ufX
 Gj9UZkMrWwcu1PAkQg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sqtuJ-006Hl4-0o;
 Wed, 18 Sep 2024 12:35:43 +0000
From: dave@treblig.org
To: philmd@linaro.org,
	kraxel@redhat.com
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] hw: Remove unused fw_cfg_init_io
Date: Wed, 18 Sep 2024 13:35:42 +0100
Message-ID: <20240918123542.25319-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

fw_cfg_init_io has been unused since
  918a7f706b ("i386: load kernel on xen using DMA")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 hw/nvram/fw_cfg.c         | 5 -----
 include/hw/nvram/fw_cfg.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 2dadfd6e1f..b644577734 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1171,11 +1171,6 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
     return s;
 }
 
-FWCfgState *fw_cfg_init_io(uint32_t iobase)
-{
-    return fw_cfg_init_io_dma(iobase, 0, NULL);
-}
-
 FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
                                  hwaddr data_addr, uint32_t data_width,
                                  hwaddr dma_addr, AddressSpace *dma_as)
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index d173998803..fa42677619 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -321,7 +321,6 @@ void fw_cfg_add_extra_pci_roots(PCIBus *bus, FWCfgState *s);
 
 FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
                                 AddressSpace *dma_as);
-FWCfgState *fw_cfg_init_io(uint32_t iobase);
 FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr);
 FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
                                  hwaddr data_addr, uint32_t data_width,
-- 
2.46.0


