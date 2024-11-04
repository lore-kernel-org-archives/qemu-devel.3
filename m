Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7F4D1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84He-0005Op-9y; Mon, 04 Nov 2024 16:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Hd-0005NJ-9A
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Hb-0005Kp-Nf
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ldHFm0meIbKDqoWxpc3iPUWnS5CVTfeooEj5YgrtdIU=;
 b=dM3QoqtuwDYh/ovg5dqdaGfoszc1jR9+QizypTODP6putBnDXQsPcbDYsWmJKNGtSM5Uru
 xmsdhed6tUp1F7WfI2r3mSIPcG1PIdundQoUrDjtfsLu69J12XDgiWpqdVZ8gGyhRXplrR
 6ftcWL85PFD06dSh2/j3AftND5vsmQs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-oF0UFrFzMYO4ZDvo7aOEKQ-1; Mon, 04 Nov 2024 16:06:42 -0500
X-MC-Unique: oF0UFrFzMYO4ZDvo7aOEKQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315b7b0c16so32374395e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754400; x=1731359200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ldHFm0meIbKDqoWxpc3iPUWnS5CVTfeooEj5YgrtdIU=;
 b=vKtls4+LK9LVMs0sxsBJSrJOGUYaZpIetg5weB9r7nBbSPdRzGhw5gRQRqHcNpb6rH
 M5lkKadBW2KBmNBsqpey8F5DpmhsknENLhKoCzPVh7Adv1CdyMvFQx6dPO8RGVTm+4Rj
 CAZaI6FI34q1UlN+Q/1CXl8NSNjc4IKdyxOaVlyRy5LEA8raTMcXB5stht/fVGsT/9xd
 HFRcBieBEergAjIua3c4rxAQneOvlUi4e02daHb2OLSsYfo4tRR63hYgW2Em3Ijfac64
 xZ27O5UUh/0WAAyhVYLV8KiYM4dDK2O9eXzBZkyzJVEKGZf5+XsgvYFVcJIx7x9hUsCx
 vUdQ==
X-Gm-Message-State: AOJu0YwDNj5a6f4QlaV+c7zldp0cbUU8KQTa/HFEGm26gMs8aUfZjWDN
 8UA8NBe6I1HI9BTgqMnK6Mi42zIsT0x9fN9NlKfaFxnK0fNCZNsRLKtX6lViEO5ReZ7MTbUMhMl
 haE4x4K9rcOC0pmcoKtxrkPyXugW86npDRjJ2p2vr7Wfj2SgJuqp46r+woJjTxh9a5Y+ljzxT2i
 IdQbcfVHWkF3PEujKUvp7/IwvHgwuChg==
X-Received: by 2002:a05:600c:1989:b0:42f:7ed4:4c26 with SMTP id
 5b1f17b1804b1-4319aca5580mr299680375e9.12.1730754400363; 
 Mon, 04 Nov 2024 13:06:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGs7XgrkbR4/eVV6oIN5hIK9/ism9YbX541CK78pFhR0dr269E1bj+aB1snAwIqzgFAAv1MIw==
X-Received: by 2002:a05:600c:1989:b0:42f:7ed4:4c26 with SMTP id
 5b1f17b1804b1-4319aca5580mr299680045e9.12.1730754399819; 
 Mon, 04 Nov 2024 13:06:39 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116abb5sm14080603f8f.100.2024.11.04.13.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:06:39 -0800 (PST)
Date: Mon, 4 Nov 2024 16:06:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 17/65] hw/pcie: Factor out PCI Express link register filling
 common to EP.
Message-ID: <6d1bda91337dcd0e7bf78da6f6b15af497966052.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst not all link related registers are common between RP / Switch DSP
and EP / Switch USP many of them are.  Factor that group out to save
on duplication when adding EP / Swtich USP configurability.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240916173518.1843023-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie.c | 91 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 41 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 4b2f0805c6..1ac6d89dcf 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -105,6 +105,55 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
     pci_set_word(cmask + PCI_EXP_LNKSTA, 0);
 }
 
+/* Includes setting the target speed default */
+static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
+                              PCIExpLinkSpeed speed)
+{
+    /* Clear and fill LNKCAP from what was configured above */
+    pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKCAP,
+                                 PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS);
+    pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP,
+                               QEMU_PCI_EXP_LNKCAP_MLW(width) |
+                               QEMU_PCI_EXP_LNKCAP_MLS(speed));
+
+    if (speed > QEMU_PCI_EXP_LNK_2_5GT) {
+        /*
+         * Target Link Speed defaults to the highest link speed supported by
+         * the component.  2.5GT/s devices are permitted to hardwire to zero.
+         */
+        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKCTL2,
+                                     PCI_EXP_LNKCTL2_TLS);
+        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKCTL2,
+                                   QEMU_PCI_EXP_LNKCAP_MLS(speed) &
+                                   PCI_EXP_LNKCTL2_TLS);
+    }
+
+    /*
+     * 2.5 & 5.0GT/s can be fully described by LNKCAP, but 8.0GT/s is
+     * actually a reference to the highest bit supported in this register.
+     * We assume the device supports all link speeds.
+     */
+    if (speed > QEMU_PCI_EXP_LNK_5GT) {
+        pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKCAP2, ~0U);
+        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
+                                   PCI_EXP_LNKCAP2_SLS_2_5GB |
+                                   PCI_EXP_LNKCAP2_SLS_5_0GB |
+                                   PCI_EXP_LNKCAP2_SLS_8_0GB);
+        if (speed > QEMU_PCI_EXP_LNK_8GT) {
+            pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
+                                       PCI_EXP_LNKCAP2_SLS_16_0GB);
+        }
+        if (speed > QEMU_PCI_EXP_LNK_16GT) {
+            pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
+                                       PCI_EXP_LNKCAP2_SLS_32_0GB);
+        }
+        if (speed > QEMU_PCI_EXP_LNK_32GT) {
+            pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
+                                       PCI_EXP_LNKCAP2_SLS_64_0GB);
+        }
+    }
+}
+
 static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
 {
     PCIESlot *s = (PCIESlot *)object_dynamic_cast(OBJECT(dev), TYPE_PCIE_SLOT);
@@ -115,13 +164,6 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
         return;
     }
 
-    /* Clear and fill LNKCAP from what was configured above */
-    pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKCAP,
-                                 PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS);
-    pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP,
-                               QEMU_PCI_EXP_LNKCAP_MLW(s->width) |
-                               QEMU_PCI_EXP_LNKCAP_MLS(s->speed));
-
     /*
      * Link bandwidth notification is required for all root ports and
      * downstream ports supporting links wider than x1 or multiple link
@@ -144,42 +186,9 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
         pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP,
                                    PCI_EXP_LNKCAP_DLLLARC);
         /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
-
-        /*
-         * Target Link Speed defaults to the highest link speed supported by
-         * the component.  2.5GT/s devices are permitted to hardwire to zero.
-         */
-        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKCTL2,
-                                     PCI_EXP_LNKCTL2_TLS);
-        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKCTL2,
-                                   QEMU_PCI_EXP_LNKCAP_MLS(s->speed) &
-                                   PCI_EXP_LNKCTL2_TLS);
     }
 
-    /*
-     * 2.5 & 5.0GT/s can be fully described by LNKCAP, but 8.0GT/s is
-     * actually a reference to the highest bit supported in this register.
-     * We assume the device supports all link speeds.
-     */
-    if (s->speed > QEMU_PCI_EXP_LNK_5GT) {
-        pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKCAP2, ~0U);
-        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
-                                   PCI_EXP_LNKCAP2_SLS_2_5GB |
-                                   PCI_EXP_LNKCAP2_SLS_5_0GB |
-                                   PCI_EXP_LNKCAP2_SLS_8_0GB);
-        if (s->speed > QEMU_PCI_EXP_LNK_8GT) {
-            pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
-                                       PCI_EXP_LNKCAP2_SLS_16_0GB);
-        }
-        if (s->speed > QEMU_PCI_EXP_LNK_16GT) {
-            pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
-                                       PCI_EXP_LNKCAP2_SLS_32_0GB);
-        }
-        if (s->speed > QEMU_PCI_EXP_LNK_32GT) {
-            pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
-                                       PCI_EXP_LNKCAP2_SLS_64_0GB);
-        }
-    }
+    pcie_cap_fill_lnk(exp_cap, s->width, s->speed);
 }
 
 int pcie_cap_init(PCIDevice *dev, uint8_t offset,
-- 
MST


