Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E80C606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n19OKedg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNYJW-0004a0-LK; Sun, 01 Nov 2026 11:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1xNYJS-0004Xu-A6
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 11:21:42 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1xNYJQ-0008Mp-LP
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 11:21:42 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4ae34ad9bb6so1884305e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 08:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793550099; x=1794154899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QNmwF2Dh91QQRjJUcxKTTlI814KBb5gis7Xe9e9Z6qU=;
 b=n19OKedgrPf2VfupaPL/ERbxitjL6OG87Wg8hQgTaALBXkXmYwlQdnUa9stsdrvo0E
 JGxmscZYk/OBhphI3c53VBCD1i08iUl9bYdaO2cY+86YFNYsXxL0N7PHA+mPWk/7+r1U
 IJxyhgJw6ZxcoWtvrOSa8DUtUOoddT48eYd3xDtX1lOmLUP9N0pWJeUA55m1agzPjR+8
 xGJ9rQQSYmVxsKNG6bdNOw/nbiGxdva1agYR0jJUzPVlF/OfwJzHPqFA/Rqlzp8IzGdL
 1sZIQkONFEmVbsFa9ra7cV6XvJc863cwnQ9h7wU5T8ChUSNOVX6UZz9jw9VangtR/fXO
 bpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793550099; x=1794154899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QNmwF2Dh91QQRjJUcxKTTlI814KBb5gis7Xe9e9Z6qU=;
 b=ePO+OT9pHAauiCr2L3Cr2a5fzN51eENsSOELSsgyXK2eEM55i15VnD6H7cI+Y6ArXV
 6D+lFBGNiW8CLNTJn52dussrJM6+C9uR1F+TDxYVkQ3YAiUJFccrRTHDv9atKuH4m+kk
 HU09Q9dwcQFemipiKlwGzvhG7H/HAjrOWa25e0u3LDzhzH6Zd15pTWlilZWk0yDRa+Cf
 kRE2cJ7bHtIND8RUmL9LK1+G0AdKdRL4tNrRa/82dghJGTGfGrz1qabviKuKHeimtEWh
 VX3Z+n1fcspvY15Q3sDRfcdFiqFrPc2GNPt6IwBf6OjvVB7gY9xsdqblqSMueN43GbmF
 YH7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFx1ajBOeyqFEszkQVHRVDbn9QQYPnv7IPgzwfDAHrpYAyB2S0ovd/kIvWSDcnUwRhpu3DTEDIlRl2@nongnu.org
X-Gm-Message-State: AFq9FYI4RxIl7P6AJtIKecs9vblMQtF4P4EtQus+irWjgzNLoo4qTlwS
 Mu1DhzABy35LO59Z0XYywAfXRCGwd+Vn8D2hL6UYulx1T2qbDbRACXN9
X-Gm-Gg: AYBFou3sL76R/PLtqhZMh00xsBLKAIxw78ELqq0SuerSHL3ceFFdBfSnHKK4GbOMDpu
 F8lEvTsCXCVpbif5vL+VY1FokunFH7E3HuztYZWX6lHVJoeVqwpjMT4mWaaXaJ6ERxkUVxqEZDe
 0CKW4c31L7Moo4vcSgjtJ+lMgiL57ZVQPR4D5d4ijZNERIODVBkDAlJJB5/M55Y1TU9qdkJN7O5
 trU8uAmlMjRuTK1K/ay/SHZ14rBPSTy+T5w+laR2Z11lsmz7UwKEXb8cAO8YbHBMYGPVNCoKDci
 +YupPWW52pfHpJxurCsB7dH5KW+L/PBvdZlvZmyQjlojZt4K/DBakS11TQawDYcB0Kv+CJEvBf6
 RG1B8GIsB9lyfcT7ahlq/fPOa2sLbMbfbsACv9DUrBMyfGSEqhc4s0/vO1fbsDBs9SRKsHqhZNA
 G+7ks93lLAPjgJinZpwXBYi6wQIx2zh+55eU6GBpDdNigzV/zquZK+z8kom3I61cC7mQOTmB4Ld
 8fhjFG3H8jKt4OZeAsp+PwxASQDc7actYuvRzPuAAnX0xdb3ScQ5T2v+ayQiQNURzrhmghgvhxN
 eHUoQB3lne/Tcfr4QhmO92WXpXujSEcIgtiOIRFskM8SWNB7taHF3Oc8qAc7Z88I
X-Received: by 2002:a05:600c:2604:b0:4a1:b027:99ef with SMTP id
 5b1f17b1804b1-4ac16acfa8emr133908255e9.2.1793550098883; 
 Sun, 01 Nov 2026 08:21:38 -0800 (PST)
Received: from AtiePC ([2a0c:5a87:5006:4800:78cf:63bd:d449:f7bc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm283897765e9.4.2026.11.01.08.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 08:21:38 -0800 (PST)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel Paziyski <danielpaziyski@gmail.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 2/3] pcie_sriov: perform additional checks after pci device
 realization
Date: Sun,  1 Nov 2026 17:21:30 +0100
Message-ID: <20261101162132.147838-3-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101162132.147838-1-danielpaziyski@gmail.com>
References: <20261101162132.147838-1-danielpaziyski@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Handle two cases after realization, which were implicitly handled back when PCI
SR-IOV device registration was done after PCI realization before commit
432ea8cc7d27 ("pcie_sriov: register user created virtual function before realizing it")

- If a device is a PF of user created VFs, make sure that it has initialized its
  list of VFs. This check seems to be superfluous, because the only way it can
  fail is:

  - if PCI device realization forgets to initialize the user created virtual
    functions via pcie_sriov_pf_init_from_user_created_vfs, despite having set
    sriov_vf_user_creatable in the device class;

  - if the pcie_sriov_pf_init_from_user_created_vfs function fails, but forgets
    to set errp (which does not happen), and the device specific realization
    code forgets to check and/or propagate if an error has happened.

  However, this check was present, so let's include it again for good measure.

- If a device is a user created VF, make sure that the device is still a
  PCI Express device. This edge case occurs on devices that before realization
  have the PCIe capability set, but then during realization they clear it for
  some reason. This only seems to happen to modern virtio-net-pci devices, which
  have their PCIe capability on, as any other modern virtio device, on object
  instantiation, but is then cleared in its realize function when it is located
  at the root complex or not in a PCIe bus.

Cc: qemu-stable@nongnu.org
Fixes: 432ea8cc7d27 ("pcie_sriov: register user created virtual function before realizing it")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
---
 hw/pci/pci.c                |  5 +++++
 hw/pci/pcie_sriov.c         | 19 +++++++++++++++++++
 include/hw/pci/pcie_sriov.h |  2 ++
 3 files changed, 26 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1ea388be37..e85b34d06d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2347,6 +2347,11 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
+    if (!pcie_sriov_check_after_realize(pci_dev, errp)) {
+        pci_qdev_unrealize(DEVICE(pci_dev));
+        return;
+    }
+
     /*
      * A PCIe Downstream Port that do not have ARI Forwarding enabled must
      * associate only Device 0 with the device attached to the bus
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 6a748c3626..618d2a4a64 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -392,6 +392,25 @@ bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
     return true;
 }
 
+bool pcie_sriov_check_after_realize(PCIDevice *dev, Error **errp)
+{
+    if (!dev->exp.sriov_pf.vf && dev->qdev.id &&
+        pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
+        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
+        return false;
+    }
+
+    if (dev->sriov_pf) {
+        /* some devices might clear their PCIe capability during realization */
+        if (!pci_is_express(dev)) {
+            error_setg(errp, "PCI Express is required for SR-IOV VF");
+            return false;
+        }
+    }
+
+    return true;
+}
+
 void pcie_sriov_unregister_device(PCIDevice *dev)
 {
     if (dev->sriov_pf && pfs) {
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index b0ea6a62c7..00fe8c4ada 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -57,6 +57,8 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
 bool pcie_sriov_register_device(PCIDevice *dev, Error **errp);
 void pcie_sriov_unregister_device(PCIDevice *dev);
 
+bool pcie_sriov_check_after_realize(PCIDevice *dev, Error **errp);
+
 /*
  * Default (minimal) page size support values
  * as required by the SR/IOV standard:
-- 
2.56.0


