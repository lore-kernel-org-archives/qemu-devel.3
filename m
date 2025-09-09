Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402CFCAC582
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 22:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw6aP-0007d4-JG; Tue, 09 Sep 2025 18:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3EabAaAYKCqwkgNUZlSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--yubinz.bounces.google.com>)
 id 1uw6Z2-0007Fu-3F
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 18:11:48 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3EabAaAYKCqwkgNUZlSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--yubinz.bounces.google.com>)
 id 1uw6Yp-00050Y-Q7
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 18:11:47 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-24caf28cce0so144548745ad.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 15:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757455890; x=1758060690; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=G/LP6fTHBZkghRvQJyUqTkcACbgbCjWb3Gp/fpwioow=;
 b=eZTGCHawkY5g/Zo0sq6x+7rPmGuinGlaWcayGI86L0jl7n0sSNv+YiTz3OC3xFvPwa
 Tm5TqsMrovomnQ83K61HPIe9XK+mjfIxeyJHiDCSzFYqHIKXcTTwa5yhZKcsTllCpmBY
 DzQQxeQrQp+6wBd2oG0yockFaSQdzdXKJKXLIR3iLvFQ1uy4OmDlooxwqFD3imu5MkDX
 fJRZ6EpwHjq/lZ8jC8gonT8wYv3i+5pYnf51aT3AIrwylrITJkkAT71QUrz/d1BVofym
 hGFmsxP5d7POBOjZVhFVVJT4imfT7gYvJVfMEjipmTH/VaOh7Iv/6Rw14yOd4w/a6G73
 EvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757455890; x=1758060690;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G/LP6fTHBZkghRvQJyUqTkcACbgbCjWb3Gp/fpwioow=;
 b=lYf3xLaRsA36U1Dm+nvrRL8tHq+jMQrE8krbnlKRUa2aT12NR1Lmq/iEwIAyfdRaqw
 Mr55GB6DP0/h7O4ZjLtWDSABjM/BHUJoxHke5UC0CW1P7dLV7VNpTOpniqqJdBLsdm8v
 mVeMaVy6/3WasreelIzmyH4XuJNeU0e6q04OwBbdUGiHWL0PJSbbe3K3Av+GWNgYEDI2
 Qsq6CHUGg3CDvnnjU7RxUj8UuMBmrnP1zDebQTxVlFSVe1FE1KNXjTWXGVdtKzRx/7e2
 vCPyIj5rSDRoLnbuy4EhwzfVwMH2z4pnEdjP7qxMGo0ae9vXZX2sX/ZAjGn1477I2rLs
 uKEw==
X-Gm-Message-State: AOJu0Ywv1k5JucYLVAPuBc7lGyC8TKfyt2s5LSzIwe5dfzKaM5R9bATS
 qgdL0VEFMnV+Zvyqj7Sq3xAGidCVPx2QIJpNCp8Rpm37Dcc7AEzyOMF1zbQeqROHN9DKGiX5Eo0
 cZrPgENa00t1jvBdzzDuIhl2ba4z81sqQzPTkn81nHoVThnM69ZjE3Gi70buAqHM/s4FRwsyTJe
 0FgwDIYsqcQCwgUwubJzhtxyjfNUN2JSbwqJ4=
X-Google-Smtp-Source: AGHT+IHH4qu8wF32SPlJxkXsZfzuY+S4V3Ffo0txGNpbpcarWbDIS9gQh8G3oZB2I5R52nYg9FMPN3howA8=
X-Received: from pjg4.prod.google.com ([2002:a17:90b:3f44:b0:327:e021:e61d])
 (user=yubinz job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d54e:b0:246:24d:2394
 with SMTP id d9443c01a7336-2516ef54ef2mr151541235ad.8.1757455889902; Tue, 09
 Sep 2025 15:11:29 -0700 (PDT)
Date: Tue, 09 Sep 2025 22:11:00 +0000
In-Reply-To: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
Mime-Version: 1.0
References: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250909-pcie-root-upstream-v1-5-d85883b2688d@google.com>
Subject: [PATCH 5/7] hw/pci-host: enable MSI on npcm PCIe root complex
From: Yubin Zou <yubinz@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Yubin Zou <yubinz@google.com>, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3EabAaAYKCqwkgNUZlSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--yubinz.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Sep 2025 18:12:49 -0400
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

From: Titus Rwantare <titusr@google.com>

This allows MSI capable qemu devices to attach to the root complex

Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/pci-host/npcm_pcierc.c         | 5 +++++
 include/hw/pci-host/npcm_pcierc.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/hw/pci-host/npcm_pcierc.c b/hw/pci-host/npcm_pcierc.c
index a1767335fe79a30464acf32ae94fc14e417c89eb..0af76d1067a78bdbb169af3e3d5c4a2514cd0ff5 100644
--- a/hw/pci-host/npcm_pcierc.c
+++ b/hw/pci-host/npcm_pcierc.c
@@ -10,6 +10,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci-host/npcm_pcierc.h"
+#include "hw/pci/msi.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/units.h"
@@ -442,6 +443,10 @@ static void npcm_pcierc_realize(DeviceState *dev, Error **errp)
     address_space_init(&s->pcie_space, &s->pcie_root, "pcie-address-space");
     pci_realize_and_unref(root, pci->bus, &error_fatal);
     pci_setup_iommu(pci->bus, &npcm_pcierc_iommu_ops, s);
+
+    msi_nonbroken = true;
+    msi_init(root, NPCM_PCIERC_MSI_OFFSET, NPCM_PCIERC_MSI_NR,
+             true, true, errp);
 }
 
 static void npcm_pcie_root_port_realize(DeviceState *dev, Error **errp)
diff --git a/include/hw/pci-host/npcm_pcierc.h b/include/hw/pci-host/npcm_pcierc.h
index a47eae0084b88ba4388681b24ab97f77a4338594..7d18177510f60d49f7fae7908dd1e3bfbe9ae12b 100644
--- a/include/hw/pci-host/npcm_pcierc.h
+++ b/include/hw/pci-host/npcm_pcierc.h
@@ -87,6 +87,8 @@
 #define NPCM_PCIERC_NUM_PA_WINDOWS          2
 #define NPCM_PCIERC_NUM_AP_WINDOWS          5
 
+#define NPCM_PCIERC_MSI_NR                  32
+#define NPCM_PCIERC_MSI_OFFSET              0x50
 /* PCIe extended config space offsets */
 #define NPCM_PCIE_HEADER_OFFSET             0x80
 #define NPCM_PCIE_AER_OFFSET                0x100

-- 
2.51.0.384.g4c02a37b29-goog


