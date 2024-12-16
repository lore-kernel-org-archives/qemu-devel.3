Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29D6E77183
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 00:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMzJO-0001TY-9W; Sun, 15 Dec 2024 19:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tMzJM-0001S2-BI
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 19:50:12 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tMzJK-0007JZ-7y
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 19:50:12 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-728f1e66418so2885876b3a.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 16:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1734310208; x=1734915008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FWmGdfs7I/39bU6vTy0i46WBke+O98sxD/aRcDZSQXA=;
 b=BEtw417p0hbGy2kmGzuSeU97E0qDM6CoKLm5ZZUe6/GsGhtHD6yWVRoIIgfW+JqQkW
 qEdUIcATUmN3gHqbXIA13AXG4Ln3zwExn4lxKq/LgUwMsdNVlCrJouGvcU5nQD/iOXQC
 EBtkdzwEryWQfnBMaLTQFPi8TTXlwhT66nv2YerUd3zXcD71uhbCn/jzK2DRbffqP+Hn
 x8taTB3HysBOtjZleMrzoauCbmj/t0hLJkNXlBDmJlYcqSntGp5iKd8QKeqmUyjZbiJQ
 fHxRcybq3TMbcDB9w3E9VLNUBxDbImvzYwF0I/4+rM44OOYap5w/AAH2r2NCcFYFrajN
 UFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734310208; x=1734915008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FWmGdfs7I/39bU6vTy0i46WBke+O98sxD/aRcDZSQXA=;
 b=mr1Q0icLqPw81LqHrD497dYGcyWttw8TK3YqZoGpvbG3CONk+nhKefZfeD1zIhVfTv
 xK66R+UiM70bDm2kD2HsQeEJd9OlUrCvBZTPCqccLUY1PRkGs+PSVfyNk+MLO7wq8UBB
 HLwkQI5VhMZz0hK8Jbwu5SdzfWHKNFLl/hBybrrypYmvFpugUO2dsd2TKo3lbnqHYwGU
 XU2Fg66WbM2SYfcmycXyXIvErx4TcL/GjRXxhtnyhSiK/SkwXGUThvHxB+wxfxe01ZVT
 8/m3D+zfPn3sFQ7lKiWzFCPdx+35ihcgb+FMYY936vgBDq9Pgcd4dslJIMTRIvU6Gfds
 mXvw==
X-Gm-Message-State: AOJu0Yz3z3ZenQmh5Pqyhx3Ygz8UzR5wOd9cGZgnpNIIs+aeoLJqQs7d
 i5ypITCVaSxdq8xbq0Pii2P5k0bPsRBWtsvwNUPnlVzMP7zBEUji4HIoi9pKmZaI5vEahg5Ohvp
 9ebUMt5zZWOMoygumk2pi6BuLPTRF/w+nmJ5NgdHzolJQ97MtVnsnYf6T3qZM+0FqRiBFBm1xKz
 7UgWE9/lwj8NGpQYi8fQIY2B/jAZu3K7Nax36+oWF5wPgdik4=
X-Gm-Gg: ASbGncvS0qxYjePezCS3cTGmEnbmzZ3Pws+XccW2fy9yAK4qAUGv+9YJfOiWc4Rt/oa
 HSSWp/oKrh3JbxVSbd1m4YMoeMIaQf/4saa025fR2/NMgDb+rvc+2A+4IID8UY4fBvAfFo9X6As
 KZTCQ4GlgpSkBjU6GKqQAqrr7Qj63ek7okDEY6vyqUbGZLIG8q7BmPGrUmfeP6b10xQ1xd4DzuM
 CHfxtNRAoL/opY69Nt/uCI8dN28Qezn9cOTRzOpoLCjohQliPsTGlE7G4725WepYHgeCWKNql3w
 NWsMzc3W
X-Google-Smtp-Source: AGHT+IEUS1j5PJe2vcxu53unoG7gkVeDB2mRvah5pKoextxKD6OEt13xB3poaEE9+1mKa223oiQq8g==
X-Received: by 2002:a05:6a21:7185:b0:1e1:f281:8cfd with SMTP id
 adf61e73a8af0-1e1f281925dmr8531798637.15.1734310207905; 
 Sun, 15 Dec 2024 16:50:07 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5addbf9sm3059586a12.47.2024.12.15.16.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 16:50:07 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org (open list:MCIMX7D SABRE / i...),
 Jason Chien <jason.chien@sifive.com>
Subject: [RFC PATCH 6/6] include/hw/pci: Send PCI dma requests with memory
 attributes containing BDF
Date: Mon, 16 Dec 2024 08:48:57 +0800
Message-ID: <20241216004857.9367-7-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241216004857.9367-1-jason.chien@sifive.com>
References: <20241216004857.9367-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=jason.chien@sifive.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In order to distinguish which PCIe device sends the request over the IOMMU,
the requester_id must be set with the BDF of the device.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
---
 include/hw/pci/pci_device.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 8eaf0d58bb..e22d05dae8 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -263,8 +263,11 @@ static inline MemTxResult pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
 static inline MemTxResult pci_dma_read(PCIDevice *dev, dma_addr_t addr,
                                        void *buf, dma_addr_t len)
 {
+    MemTxAttrs attrs = {};
+    attrs.requester_id = pci_requester_id(dev);
+
     return pci_dma_rw(dev, addr, buf, len,
-                      DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFIED);
+                      DMA_DIRECTION_TO_DEVICE, attrs);
 }
 
 /**
@@ -282,8 +285,11 @@ static inline MemTxResult pci_dma_read(PCIDevice *dev, dma_addr_t addr,
 static inline MemTxResult pci_dma_write(PCIDevice *dev, dma_addr_t addr,
                                         const void *buf, dma_addr_t len)
 {
+    MemTxAttrs attrs = {};
+    attrs.requester_id = pci_requester_id(dev);
+
     return pci_dma_rw(dev, addr, (void *) buf, len,
-                      DMA_DIRECTION_FROM_DEVICE, MEMTXATTRS_UNSPECIFIED);
+                      DMA_DIRECTION_FROM_DEVICE, attrs);
 }
 
 #define PCI_DMA_DEFINE_LDST(_l, _s, _bits) \
@@ -327,8 +333,11 @@ PCI_DMA_DEFINE_LDST(q_be, q_be, 64);
 static inline void *pci_dma_map(PCIDevice *dev, dma_addr_t addr,
                                 dma_addr_t *plen, DMADirection dir)
 {
+    MemTxAttrs attrs = {};
+    attrs.requester_id = pci_requester_id(dev);
+
     return dma_memory_map(pci_get_address_space(dev), addr, plen, dir,
-                          MEMTXATTRS_UNSPECIFIED);
+                          attrs);
 }
 
 static inline void pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len,
-- 
2.43.2


