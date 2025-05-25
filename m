Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C43C54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 09:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJ7uE-0000tC-99; Sun, 25 May 2025 05:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7u7-0000ia-Pa; Sun, 25 May 2025 05:44:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJ7u6-0004lB-3M; Sun, 25 May 2025 05:44:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D2E1C124DEB;
 Sun, 25 May 2025 12:42:47 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B6B2B215F13;
 Sun, 25 May 2025 12:42:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Rakesh Jeyasingh <rakeshjb010@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.4 57/62] hw/pci-host: Remove unused pci_host_data_be_ops
Date: Sun, 25 May 2025 12:42:40 +0300
Message-Id: <20250525094246.174612-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.4-20250525112803@cover.tls.msk.ru>
References: <qemu-stable-9.2.4-20250525112803@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Rakesh Jeyasingh <rakeshjb010@gmail.com>

pci_host_data_be_ops became unused after endianness fixes

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/r/20250429170354.150581-3-rakeshjb010@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 560375cff3ccedabf1fe5ca1bc7a31b13fdc68e5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index dfe6fe6184..20d864ad91 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -217,12 +217,6 @@ const MemoryRegionOps pci_host_data_le_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-const MemoryRegionOps pci_host_data_be_ops = {
-    .read = pci_host_data_read,
-    .write = pci_host_data_write,
-    .endianness = DEVICE_BIG_ENDIAN,
-};
-
 static bool pci_host_needed(void *opaque)
 {
     PCIHostState *s = opaque;
diff --git a/include/hw/pci-host/dino.h b/include/hw/pci-host/dino.h
index fd7975c798..5dc8cdf610 100644
--- a/include/hw/pci-host/dino.h
+++ b/include/hw/pci-host/dino.h
@@ -109,10 +109,6 @@ static const uint32_t reg800_keep_bits[DINO800_REGS] = {
 struct DinoState {
     PCIHostState parent_obj;
 
-    /*
-     * PCI_CONFIG_ADDR is parent_obj.config_reg, via pci_host_conf_be_ops,
-     * so that we can map PCI_CONFIG_DATA to pci_host_data_be_ops.
-     */
     uint32_t config_reg_dino; /* keep original copy, including 2 lowest bits */
 
     uint32_t iar0;
diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index e52d8ec2cd..954dd446fa 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -68,6 +68,5 @@ uint32_t pci_data_read(PCIBus *s, uint32_t addr, unsigned len);
 extern const MemoryRegionOps pci_host_conf_le_ops;
 extern const MemoryRegionOps pci_host_conf_be_ops;
 extern const MemoryRegionOps pci_host_data_le_ops;
-extern const MemoryRegionOps pci_host_data_be_ops;
 
 #endif /* PCI_HOST_H */
-- 
2.39.5


