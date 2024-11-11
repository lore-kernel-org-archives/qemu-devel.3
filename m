Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6044BD2E9E4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 12:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAThp-00017L-8H; Mon, 11 Nov 2024 07:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tAThg-00016c-6k
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 07:39:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tAThe-0003Ft-E2
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 07:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731328773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WMhLV5ORPZJ5YifFAAioGwxF/TCtbPmpt4T+iwY7TNk=;
 b=HrPa0D11pmeXHvboKc6Su2f68FGAF+AvCud5mdjN8+Zd9xArzsh8bU52ijus1/4Lb/P8KN
 gxqNewJwxz31IovAH4SHrI//UPrJy8azA9zQsddEZ4cXHgqvTA1PgFp8z0TeSEDoLypLrk
 FSNfIT8bOvL4G2nJfv4mUlQ0vRNIf0o=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-vHjDTJbIOdGziycP3bYaqQ-1; Mon, 11 Nov 2024 07:38:26 -0500
X-MC-Unique: vHjDTJbIOdGziycP3bYaqQ-1
X-Mimecast-MFC-AGG-ID: vHjDTJbIOdGziycP3bYaqQ
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-460ba8f6a5aso81221881cf.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 04:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731328704; x=1731933504;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WMhLV5ORPZJ5YifFAAioGwxF/TCtbPmpt4T+iwY7TNk=;
 b=c8wf4CrXCGeG3jB0pM8MEOwfW5Dm7Z1ipAwPIAxeToSV61NbbayX2LHcw/8Ip7yngs
 ObHPkRe0lkiLgD0vUIA1hVhrVoXUCOoTjyEfH+S4vKMX5rZFo9jRqb3IJ6dYYncHxv/S
 BFQZLk09cuf8MZ7Ntr0zDgJ+ajAGUr9pd9BqAzlvrFPSJ9HFlogqMV3ObrLAQpMjxruJ
 MbYlRvKj3lIqvVhWY1HVWM4ZgOWx9AcCV014LacBpmYKSt2OPG7cw2uTEZaEiKZzGJZt
 KuTGKMnFeOnHbRICXU5CeMscnEGD8UPKWBp3x/Lv+TAo9K6OhJ1CCa9aLlYQv+RCbw/Z
 EpHw==
X-Gm-Message-State: AOJu0Yz3ne8B6zbJGb/3HIzI/J75e0OM4fJNGdjiklO0RGO3YP3D5Uxy
 Wd3OLXKT7PikRR/0/ydGIXSaBfHl1LlmpLAvy9LVCM+Fvr2hx0bIz7HjAqybixHsidip+jz3cAC
 4G0J+1TXoMNkNx95nG8f5DVErRkQBKmSGqOSuBIofOsOw/nnegbQl492XCJhiyKnZF0ZVXwztEd
 6qc8IsoDSewBYZLToQ0O7tqlFghgVRraV/7w==
X-Received: by 2002:a05:622a:22a9:b0:458:532c:2059 with SMTP id
 d75a77b69052e-46309321746mr201183781cf.18.1731328704537; 
 Mon, 11 Nov 2024 04:38:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDvvGLkqLMjktenVi6pOwSTYQRnuvfLSfj9C8o5qHkVX+80Ef67xO4r+lPxSHRek8eOamm+A==
X-Received: by 2002:a05:622a:22a9:b0:458:532c:2059 with SMTP id
 d75a77b69052e-46309321746mr201183491cf.18.1731328704193; 
 Mon, 11 Nov 2024 04:38:24 -0800 (PST)
Received: from rh.fritz.box
 (p200300f6af368f00f7bae606b15f3bdb.dip0.t-ipconnect.de.
 [2003:f6:af36:8f00:f7ba:e606:b15f:3bdb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ff3df35fsm62264511cf.13.2024.11.11.04.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 04:38:23 -0800 (PST)
From: Sebastian Ott <sebott@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH] pci: ensure valid link status bits for downstream ports
Date: Mon, 11 Nov 2024 13:37:56 +0100
Message-ID: <20241111123756.18393-1-sebott@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

PCI hotplug for downstream endpoints on arm fails because Linux'
PCIe hotplug driver doesn't like the QEMU provided LNKSTA:

  pcieport 0000:08:01.0: pciehp: Slot(2): Card present
  pcieport 0000:08:01.0: pciehp: Slot(2): Link Up
  pcieport 0000:08:01.0: pciehp: Slot(2): Cannot train link: status 0x2000

There's 2 cases where LNKSTA isn't setup properly:
* the downstream device has no express capability
* max link width of the bridge is 0

Fix these by making the LNKSTA modifications independent of each other.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 hw/pci/pcie.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 0b455c8654..f714f4fb7c 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1109,20 +1109,20 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
         lnksta = target->config_read(target,
                                      target->exp.exp_cap + PCI_EXP_LNKSTA,
                                      sizeof(lnksta));
-
-        if ((lnksta & PCI_EXP_LNKSTA_NLW) > (lnkcap & PCI_EXP_LNKCAP_MLW)) {
-            lnksta &= ~PCI_EXP_LNKSTA_NLW;
-            lnksta |= lnkcap & PCI_EXP_LNKCAP_MLW;
-        } else if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
-            lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
-        }
-
-        if ((lnksta & PCI_EXP_LNKSTA_CLS) > (lnkcap & PCI_EXP_LNKCAP_SLS)) {
-            lnksta &= ~PCI_EXP_LNKSTA_CLS;
-            lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
-        } else if (!(lnksta & PCI_EXP_LNKSTA_CLS)) {
-            lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
-        }
+    }
+    if ((lnksta & PCI_EXP_LNKSTA_NLW) > (lnkcap & PCI_EXP_LNKCAP_MLW)) {
+        lnksta &= ~PCI_EXP_LNKSTA_NLW;
+        lnksta |= lnkcap & PCI_EXP_LNKCAP_MLW;
+    }
+    if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
+        lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
+    }
+    if ((lnksta & PCI_EXP_LNKSTA_CLS) > (lnkcap & PCI_EXP_LNKCAP_SLS)) {
+        lnksta &= ~PCI_EXP_LNKSTA_CLS;
+        lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
+    }
+    if (!(lnksta & PCI_EXP_LNKSTA_CLS)) {
+        lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
     }
 
     pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
-- 
2.42.0


