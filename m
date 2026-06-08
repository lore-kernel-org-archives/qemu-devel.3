Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC82CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWaJ7-0001eB-BU; Mon, 08 Jun 2026 09:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wWaJ3-0001du-Mk
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:46:22 -0400
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wWaJ2-0001ms-BY
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:46:21 -0400
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-138129a622dso293850c88.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 06:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780926379; x=1781531179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cUkgsoVilVlPYda9uQfkBVnUfVlq2StBmKHYa49s4ww=;
 b=lHu5BfIbnFal5PpclzSnLxLK7h75uxu2bYlJxvdGUXYjT6bPzCNGYgNeEQApz8YKdS
 Z3PhIawfatE7+V6G1nV5kekmfdceAIpc2I1I8kvrF3f6AmZIX9I65is/oGAFgO2nI/Yq
 vd1TxvhA3Lt4xN9xpK3rOI1D5hwECbPIVHkHULhuChkcAl3SeTqn6Z6SmUaAkDoSEeu9
 v+DSpliLPaztnzeGLNL4OglTioURhh/UXPPlP6tD7222CEIp2fal7kEdo14rQtIJ3QDR
 otjTon9bHEaaROx1vdd5ksa/81EjOG/QVa2IiimekORYT+KBTQ4MVVTvjeZ3OcK/uSfy
 zXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780926379; x=1781531179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cUkgsoVilVlPYda9uQfkBVnUfVlq2StBmKHYa49s4ww=;
 b=ZN2KYebtAHvAfDpCue87FCzrKyrmqVEVSwRyItz+zrNR1ChVo8EvEoIybKbpJ23fia
 yNYNVH9gUKbo8j67cq24nFL2H9LsnUNUs0ZNzQvPs8oBDJ9UTLiblzxVoF2dyzcdUG+T
 zbJeSe8Cug2aU11NV5fuErsvXtzQ012/FYeOrTKdiuIfMUNSTaU7xeeFDLRFfab7+LuN
 BwUdEwtbdpO/UGFUaGl8Z0DRK8cM2fDTce8FISp30Z2KRKg/7b7RXrPjfMpPOV6swMpz
 lhlQwTfQoEg4f+XWRoCgTYeLUo/+LFtmr8p754uNDKhCW/4S4+zTKxq6Dxiu8gE8WFNp
 yRMw==
X-Gm-Message-State: AOJu0YxuMg5YDwVV/WEJI0aX4+iiShFHqOmChsruZTYRZjAtHSphdAFF
 I6J4gEojdTNUkedo89iEssoB2mdlHIrAAb2mnhOBsE3dYX/GOwnUqwuMrjfkxOLIKA==
X-Gm-Gg: Acq92OGLUXgL1kotBVTZHtBpQflG83X5a5yqln0AdUbHhZRvw3xEWojKNspw4gghqlo
 oZmlXdZyDd8qkSwuKDqIce6JtF0OJ3cFa/Tnvvne36AWVUm/hxuf0NkTOW492KlFa1kXUjHX4Zd
 s5pxSroljX7dpJJWZ+pn1IPOVgkbfjq8mMij+D7l6sQEjUJZd7YafJelqvaJA+3N3DuXEZhlQoD
 94kitClGyGr8mc0Oo83UDHbdcg86Y1eCo+2NIa8arOux8BYWTE4d7iXVKllnum1rW1nWT3K948e
 YcvQdJzsjJWJHEnHTV+HJzIq+6+Qs6F/PI/NsX6hTJ4V1SBtJiNEuk80Kb0T91IGFWr4g2rrhnO
 NHOJIfFiMevclnCfv9Tov6frUoB9MXJPlZkPJOmYqVbtf1yKlefHTI4eakBdUdiRQKQc3jMhOWL
 JzATL5XfS/F1EdXqstDLaMUchIm70ToW/pK2iHTwRsOg==
X-Received: by 2002:a05:7022:390:b0:137:f4ec:2a12 with SMTP id
 a92af1059eb24-138065b6fb1mr7016503c88.0.1780926378949; 
 Mon, 08 Jun 2026 06:46:18 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffd:b5b0:12ba:d5b5:2236:f1f1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f54c9c12sm12335970c88.6.2026.06.08.06.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 06:46:17 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v2 2/7] hw/pci: Skip EFI option ROM in pci_patch_ids()
Date: Mon,  8 Jun 2026 21:45:53 +0800
Message-ID: <20260608134559.23971-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608134559.23971-1-tomitamoeko@gmail.com>
References: <20260608134559.23971-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dl1-x1242.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

pci_patch_ids() patches the checksum at the reserved 0x06 byte, but
for EFI option ROMs the 32 bits at 0x04 are the EFI signature and
must be 0x00000EF1. Since OVMF does not check vendor/device IDs in
the PCIR header or the checksum, skip patching for EFI ROMs.

Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/pci/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 742917f79d..eb10e586d5 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2521,6 +2521,11 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
         return;
     }
 
+    /* OVMF won't check IDs in PCIR header, skip EFI roms */
+    if (pci_get_byte(ptr + pcir_offset + 0x14) == 0x03) {
+        return;
+    }
+
     vendor_id = pci_get_word(pdev->config + PCI_VENDOR_ID);
     device_id = pci_get_word(pdev->config + PCI_DEVICE_ID);
     rom_vendor_id = pci_get_word(ptr + pcir_offset + 4);
-- 
2.53.0


