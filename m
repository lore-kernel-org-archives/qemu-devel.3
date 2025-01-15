Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8313AC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7op-0006JP-90; Wed, 15 Jan 2025 13:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7oo-0006JG-8Z
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:08:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7ol-0006V9-UL
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J6zW/tI+F7p0x6goRAt5C2uJU7HPuN9SAqTiBTbnTho=;
 b=Laq/U5vRDVw4pQCyrUVnqUJukEjlJETIaaarWCfkyl2P0hsKTGnDN5Of03XfhTioFlcAhJ
 FDm8ON/tNGQFEJe1rAWXPN67awkykbS1siyQ/t8U4+awfLB61s3XMF24+I57q7qJSZGFgY
 PR84CB2ayKw9YJxxUbHK/tJDdJ53IxI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-Q5go176UMyeaYCDL9LuoAw-1; Wed, 15 Jan 2025 13:08:36 -0500
X-MC-Unique: Q5go176UMyeaYCDL9LuoAw-1
X-Mimecast-MFC-AGG-ID: Q5go176UMyeaYCDL9LuoAw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361ecebc5bso36861405e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:08:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964515; x=1737569315;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6zW/tI+F7p0x6goRAt5C2uJU7HPuN9SAqTiBTbnTho=;
 b=dxHr3uIZ0J+FWkJflLtzhWYc2us7ZGPG6+gF3hZH/kzN5avPyXhmMncP5GgaEbrkkf
 /30NH0O44D8AW8YbAfEHX2YZDM4g2DUKgZEt1FVyfScJcaHwyJv/Qxx1BfeClngyWAMg
 xP7nDi704HCSqKXk6eoyaka5h/Mjp1FRukuWzv6MPUc0Lghe15oHVRQY0Nk0xUqbBH7h
 1KPCt0GWgf3UGYA+fXiMrRBkdD+6iqCB7T5YNPcn0ycRCYElP6CrgY+BO+dmJBGsdIJq
 Xi22q4eiKv/5tlR5QGoxY96d24LXnd5bBHUNmndPNv2P9vzSdVcdqXbt/KfKBhS00Cv+
 qfyQ==
X-Gm-Message-State: AOJu0Yx+ZN22Lu2xM7CYkuBxMgRJHYvZIuT3u/yyJf3uuyPmUvw0nHGZ
 KpNSO2B7FCFsOqhUeCmkaXZBc+vkqugKcZeZ2/udNZxBvFeFAGBojMvHAwQPk9PVJDwXpcCwM2B
 CrXqve9KmCObYSZBgM1o7cqteil+gPrzGV380teWZn4NfgcfdS8ZNaygGmN678Fi09QbxhQFfAR
 jAhe/O6XJm2vwdxeqzkyVM6bgv8YMxjA==
X-Gm-Gg: ASbGncstlvkJy/V4hHA1nUiljOSX2rz3p+PhWedg/K6xavCWlVWg+DsCsFycJnlCR60
 4BHwusjNIoxVMe1aarxc/eV0UwFMc2pSwc1c3IRbtIAeZn+o8qxoGnge3W8EbAwMcDqJXTHePUa
 sST+Usfhw8w6p9IvK4Dcqc5z3ibUa0KcdAqtV8ed4EalZ5STpKDIfjDCvrAUCf5D0XzzlNFD+IQ
 zGjkvUi6YxM0mQ9ImaDnRZ7jHY3ni2OvCqweRlNxWoBXa9wv/CZ
X-Received: by 2002:a5d:5f85:0:b0:387:86cf:4e87 with SMTP id
 ffacd0b85a97d-38a872deb33mr27774461f8f.15.1736964515263; 
 Wed, 15 Jan 2025 10:08:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkEdSlnyCI6GfyLWe8aYr6j8sU27WGhXY9nSoAfTgOoEkAxv8uLmqHuGImGuQOR/4iNrkrjw==
X-Received: by 2002:a5d:5f85:0:b0:387:86cf:4e87 with SMTP id
 ffacd0b85a97d-38a872deb33mr27774423f8f.15.1736964514878; 
 Wed, 15 Jan 2025 10:08:34 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383882sm18422257f8f.34.2025.01.15.10.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:08:34 -0800 (PST)
Date: Wed, 15 Jan 2025 13:08:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sebastian Ott <sebott@redhat.com>, Zhenyu Zhang <zhenyzha@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 02/48] pci: ensure valid link status bits for downstream ports
Message-ID: <694632fd44987cc4618612a38ad151047524a590.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Sebastian Ott <sebott@redhat.com>

PCI hotplug for downstream endpoints on arm fails because Linux'
PCIe hotplug driver doesn't like the QEMU provided LNKSTA:

  pcieport 0000:08:01.0: pciehp: Slot(2): Card present
  pcieport 0000:08:01.0: pciehp: Slot(2): Link Up
  pcieport 0000:08:01.0: pciehp: Slot(2): Cannot train link: status 0x2000

There's 2 cases where LNKSTA isn't setup properly:
* the downstream device has no express capability
* max link width of the bridge is 0

Move the sanity checks added via 88c869198aa63
("pci: Sanity test minimum downstream LNKSTA") outside of the
branch to make sure downstream ports always have a valid LNKSTA.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
Message-Id: <20241203121928.14861-1-sebott@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 0b455c8654..1b12db6fa2 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1113,18 +1113,22 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
         if ((lnksta & PCI_EXP_LNKSTA_NLW) > (lnkcap & PCI_EXP_LNKCAP_MLW)) {
             lnksta &= ~PCI_EXP_LNKSTA_NLW;
             lnksta |= lnkcap & PCI_EXP_LNKCAP_MLW;
-        } else if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
-            lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
         }
 
         if ((lnksta & PCI_EXP_LNKSTA_CLS) > (lnkcap & PCI_EXP_LNKCAP_SLS)) {
             lnksta &= ~PCI_EXP_LNKSTA_CLS;
             lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
-        } else if (!(lnksta & PCI_EXP_LNKSTA_CLS)) {
-            lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
         }
     }
 
+    if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
+        lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
+    }
+
+    if (!(lnksta & PCI_EXP_LNKSTA_CLS)) {
+        lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
+    }
+
     pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
                                  PCI_EXP_LNKSTA_CLS | PCI_EXP_LNKSTA_NLW);
     pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA, lnksta &
-- 
MST


