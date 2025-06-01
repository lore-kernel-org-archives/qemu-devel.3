Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96A2C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkYx-00024m-7g; Sun, 01 Jun 2025 11:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYh-0001rb-LM
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYZ-0004ON-NM
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M7r5BkbW1mUobtgoU/VoVdhf/Ou78PkCr7ce5yIfFgU=;
 b=Y4bWQZlkpV/xxPmQhHdn6Ho7k6fKNB1jtSXvyYZsOtKU2oPgewjcnLj6fqvzlAWtP0zQZt
 7yKxKU791ZKGGOod1g5wFFe7HvKEKSufjDM5M3yfru5jYQhoeNJgQKVGkQgfbPW1AOBoWc
 AqPQfKT+MVaBhfg/qorvU2whG+gXsOA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-LtG99R3YMEyK27iBG9IV3g-1; Sun, 01 Jun 2025 11:24:58 -0400
X-MC-Unique: LtG99R3YMEyK27iBG9IV3g-1
X-Mimecast-MFC-AGG-ID: LtG99R3YMEyK27iBG9IV3g_1748791498
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4e713e05bso1679973f8f.3
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791497; x=1749396297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7r5BkbW1mUobtgoU/VoVdhf/Ou78PkCr7ce5yIfFgU=;
 b=iENKT7QeAA0L5nmug1lHiCGMi7A5jg0eAZkC4IlOkFNsBE4etgzyjBs8TGr9Ttl1HT
 RpWbRQqtlO36QBC+XXbj3TZCZapYVNoEEK8nEs362LqRZI+1OD06Dr2R0nslGOx4snyT
 HW0L81c2J/U7LFJLSGYOVksd0dQ3WZScR7/HR+UjkTGTUtgl7RyhryACABLaDifOci+b
 tyIFRwR4RAhYSGrO1FVEA9CmfFuaKvCM+3Ieij80bSSNePR6a/0p0u9fVRzfYCq2xFtW
 4//5OhQktm0ROG8nRACgq0GztjWLkytzgosJSHzNGp+0ueLszPsaJEyp4Zr9+Kf6WBed
 zWtg==
X-Gm-Message-State: AOJu0Yz4wHCTfDBIsFOjKDz9uyOPjPshONhOJtqDwaOXUYdtUbKjPz/A
 ONl1SxpRK9LwEJnl9fgAy1L3DcKVtOMtLXpGP3xsouW+QjR/ZvktQge9r/pbWSkxWMHf3qYmED1
 E0I/MEV1LLCW4rwa4UurbU7ghXNk2bYCiVRcrQrDb+XxY4jq+rw8vUWur8AO8oK+GSnX2/LATFa
 W59Lzl+Y8Dy8w3EuNHmd2QJGFJpVBwb+fjaw==
X-Gm-Gg: ASbGncuHlk8d1s8JcDQxFCArVjhjxcMbhfJwrwJjul8EV8dw40XHYlKKTCUa/DOdw7+
 sK60GgR2xHDYYl47GFdSSC4ReyDZDreNV8ewLA9iajB1baCfo3FVFolUP5odhp01iIth7j643a/
 JPms+CV4ktpgzE+joVN8FKv2I2ZeFFHRJH1817YGGDnAvpiGlIWN3Kddv+FSKIlc8A+JWUlxeJG
 kt45MSc8WCJWBzYB85RCwZLAj6hQ938uN7bm6O0BS9kvo9xhOC1XRI14/0J9DPGQxhrYQ4hCABg
 2e0zDg==
X-Received: by 2002:a05:6000:420a:b0:3a4:e0e1:8d9d with SMTP id
 ffacd0b85a97d-3a4fe394737mr3422857f8f.32.1748791497213; 
 Sun, 01 Jun 2025 08:24:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk6IqIOqua+smqV1E0pvvYEMaeMu9/TCuwRyz7w0a6T8Vni51W7WZ4QcsOTkDexDd+Dib2Bw==
X-Received: by 2002:a05:6000:420a:b0:3a4:e0e1:8d9d with SMTP id
 ffacd0b85a97d-3a4fe394737mr3422838f8f.32.1748791496768; 
 Sun, 01 Jun 2025 08:24:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009fd9bsm11617081f8f.82.2025.06.01.08.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:24:56 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:24:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 04/31] pcie: Add helper to declare PASID capability for a pcie
 device
Message-ID: <a8d178e1492a1a803898501a84829ac517ae2fb0.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250520071823.764266-2-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie.h      |  6 +++++-
 include/hw/pci/pcie_regs.h |  5 +++++
 hw/pci/pcie.c              | 25 +++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 70a5de09de..fe82e0a915 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -70,8 +70,9 @@ struct PCIExpressDevice {
     uint16_t aer_cap;
     PCIEAERLog aer_log;
 
-    /* Offset of ATS capability in config space */
+    /* Offset of ATS and PASID capabilities in config space */
     uint16_t ats_cap;
+    uint16_t pasid_cap;
 
     /* ACS */
     uint16_t acs_cap;
@@ -150,4 +151,7 @@ void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                              Error **errp);
 void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp);
+
+void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
+                     bool exec_perm, bool priv_mod);
 #endif /* QEMU_PCIE_H */
diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
index 9d3b6868dc..4d9cf4a29c 100644
--- a/include/hw/pci/pcie_regs.h
+++ b/include/hw/pci/pcie_regs.h
@@ -86,6 +86,11 @@ typedef enum PCIExpLinkWidth {
 #define PCI_ARI_VER                     1
 #define PCI_ARI_SIZEOF                  8
 
+/* PASID */
+#define PCI_PASID_VER                   1
+#define PCI_EXT_CAP_PASID_MAX_WIDTH     20
+#define PCI_PASID_CAP_WIDTH_SHIFT       8
+
 /* AER */
 #define PCI_ERR_VER                     2
 #define PCI_ERR_SIZEOF                  0x48
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 1b12db6fa2..4f935ff420 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1214,3 +1214,28 @@ void pcie_acs_reset(PCIDevice *dev)
         pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, 0);
     }
 }
+
+/* PASID */
+void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
+                     bool exec_perm, bool priv_mod)
+{
+    static const uint16_t control_reg_rw_mask = 0x07;
+    uint16_t capability_reg;
+
+    assert(pasid_width <= PCI_EXT_CAP_PASID_MAX_WIDTH);
+
+    pcie_add_capability(dev, PCI_EXT_CAP_ID_PASID, PCI_PASID_VER, offset,
+                        PCI_EXT_CAP_PASID_SIZEOF);
+
+    capability_reg = ((uint16_t)pasid_width) << PCI_PASID_CAP_WIDTH_SHIFT;
+    capability_reg |= exec_perm ? PCI_PASID_CAP_EXEC : 0;
+    capability_reg |= priv_mod  ? PCI_PASID_CAP_PRIV : 0;
+    pci_set_word(dev->config + offset + PCI_PASID_CAP, capability_reg);
+
+    /* Everything is disabled by default */
+    pci_set_word(dev->config + offset + PCI_PASID_CTRL, 0);
+
+    pci_set_word(dev->wmask + offset + PCI_PASID_CTRL, control_reg_rw_mask);
+
+    dev->exp.pasid_cap = offset;
+}
-- 
MST


