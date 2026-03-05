Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB99F30930
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6Jz-0001Hv-CC; Thu, 05 Mar 2026 05:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6Jy-0001Hm-MX
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:52:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy6Jw-0005UX-3Y
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772707963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NGxdHjGhHX6nGTrNQWL0dAkWcG12NReciU8nGm0/SDo=;
 b=SHiLL3sFTU5+giMX/KIHEEh6w3zk5CXNRrdoW1HEaOXmDGd/XnhbQvduCKEAQSS84ZaGZZ
 zWJltDHs03hYVxSLCaTD1nB2P8/AaeJcs9xxal9/iP8Y6J/2MqxV3tw/fLsKSh0HcAwTZO
 g/Re2cD+7U1YIUNe7SQ/ErpN6hcUbPA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-KHfd_2dXPxOOmwHZz2ftNg-1; Thu,
 05 Mar 2026 05:52:39 -0500
X-MC-Unique: KHfd_2dXPxOOmwHZz2ftNg-1
X-Mimecast-MFC-AGG-ID: KHfd_2dXPxOOmwHZz2ftNg_1772707958
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43F691800344; Thu,  5 Mar 2026 10:52:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.75])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B658D3003E98; Thu,  5 Mar 2026 10:52:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/28] hw/pci/pcie: Remove QEMU_PCIE_EXTCAP_INIT definition
Date: Thu,  5 Mar 2026 11:51:53 +0100
Message-ID: <20260305105215.302571-7-thuth@redhat.com>
In-Reply-To: <20260305105215.302571-1-thuth@redhat.com>
References: <20260305105215.302571-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

QEMU_PCIE_EXTCAP_INIT was only used by the hw_compat_2_8[]
array, via the 'x-pcie-extcap-init=off' property. We removed
all machines using that array, let's remove all the code around
QEMU_PCIE_EXTCAP_INIT.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250501210456.89071-8-philmd@linaro.org>
[thuth: Don't remove pci_set_long(), execute it always instead]
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260225092024.794595-7-thuth@redhat.com>
---
 include/hw/pci/pci.h | 2 --
 hw/pci/pci.c         | 2 --
 hw/pci/pcie.c        | 6 ++----
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index d9835dfd0dd..64141e92fec 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -219,8 +219,6 @@ enum {
     /* Link active status in endpoint capability is always set */
 #define QEMU_PCIE_LNKSTA_DLLLA_BITNR 8
     QEMU_PCIE_LNKSTA_DLLLA = (1 << QEMU_PCIE_LNKSTA_DLLLA_BITNR),
-#define QEMU_PCIE_EXTCAP_INIT_BITNR 9
-    QEMU_PCIE_EXTCAP_INIT = (1 << QEMU_PCIE_EXTCAP_INIT_BITNR),
 #define QEMU_PCIE_CXL_BITNR 10
     QEMU_PCIE_CAP_CXL = (1 << QEMU_PCIE_CXL_BITNR),
 #define QEMU_PCIE_ERR_UNC_MASK_BITNR 11
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 90d6d71efdc..6399ebd41cb 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -84,8 +84,6 @@ static const Property pci_props[] = {
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
                     QEMU_PCIE_LNKSTA_DLLLA_BITNR, true),
-    DEFINE_PROP_BIT("x-pcie-extcap-init", PCIDevice, cap_present,
-                    QEMU_PCIE_EXTCAP_INIT_BITNR, true),
     DEFINE_PROP_STRING("failover_pair_id", PCIDevice,
                        failover_pair_id),
     DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index cae5061e69c..4622c75e48c 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -250,10 +250,8 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset,
 
     pci_set_word(dev->wmask + pos + PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_EETLPPB);
 
-    if (dev->cap_present & QEMU_PCIE_EXTCAP_INIT) {
-        /* read-only to behave like a 'NULL' Extended Capability Header */
-        pci_set_long(dev->wmask + PCI_CONFIG_SPACE_SIZE, 0);
-    }
+    /* read-only to behave like a 'NULL' Extended Capability Header */
+    pci_set_long(dev->wmask + PCI_CONFIG_SPACE_SIZE, 0);
 
     return pos;
 }
-- 
2.53.0


