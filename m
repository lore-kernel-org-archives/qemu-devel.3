Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E019AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXyR-0007PG-5M; Thu, 01 Aug 2024 11:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sZXyF-0006c2-7X
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:44:03 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sZXyB-0004xO-7Y
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:44:02 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70d162eef54so5071100b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 08:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1722527036; x=1723131836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KeU1QbF2gaj9I9NQwdGm88T60V2e4JrgFRF1GFggIjc=;
 b=Ej/knylLgOqdD7bKFMrL71CB0Zr5lh1Ia5mx6XYCvdMOrTf0eLyny+C5OrYT5sVdSV
 pr2uDGgsnHWHTQR07RA7Fdl+liH9WpMwgLo4vtSf9CAmVHWz3xfiNcrbssKxbstGRAVG
 vKVVfHFKb3hoPX/8lp/M8IbPD3TC/x1lRpDj6/Javc+SdJLNjYDAJvJITtbhv/ygb7IS
 eY4tlGDulTB8WG/x2S45qydZK+4cyuhI1Qghbc1CS/kEXWT+DV2+Ehbz98nGCCCXz5Y0
 305s0F8BuANPUt53fCoragGmLfaiToQ6AoD9pGZ2hGogxfEQU6TOa2GJEt+ptW0NSRJE
 MZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722527036; x=1723131836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KeU1QbF2gaj9I9NQwdGm88T60V2e4JrgFRF1GFggIjc=;
 b=bTib5AK+jImlQg0MfBvrRwvfvLxyKGFV/4AUKjlQMBCW/k/iA11LucY1HOm4tOo1vg
 Qqjyhg7fiCFYm45hEf1JUz1Q6uninyMQ+YvMisbqc7PLOomil0gvPldvBV8MLD24F5z9
 VgmKiu4w4zGRBA11HjdM52ZEnDNaukeUM7XOFxn19wSqiSZIr9OP96iHskO+0PQ4aIT0
 QDZtoTubEg/DibtERBAatNbV1YUiIhfB8NLMsNxmZmkWfxf/ZrFZ+uGlvXbQs3mEh5Dy
 ttaHj4BQl4IiOMs9ExYVy4xrQzJQ7z4E+QZsqLnL4hFOio1cYVNIJ2LjxBuNoGDFESYT
 hkFg==
X-Gm-Message-State: AOJu0YwRk0fgxaiuwMIeyp3OumKX6swb2g1p9FeONN73RRiqpnZD42Xs
 E88nmHolp40rMrghyXeZwU26txCiWnXHdluA4JdfprzGvJ6DAKCWY3xLSKIcorc7H3wk/isvCJ0
 b
X-Google-Smtp-Source: AGHT+IHLI0NWTVnF3sCk8PptfLVeXcL8BCWSYAtITHppP1WgiQsetP0VJVxCxDql0DhiJlCUZcA3iQ==
X-Received: by 2002:a05:6a21:788e:b0:1c4:944c:41c5 with SMTP id
 adf61e73a8af0-1c69953a239mr1050714637.8.1722527036592; 
 Thu, 01 Aug 2024 08:43:56 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.197.107.101])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b762e9c650sm17183a12.16.2024.08.01.08.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 08:43:56 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 jason.chien@sifive.com, frank.chang@sifive.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH for-9.2 v6 04/12] pci-ids.rst: add Red Hat pci-id for RISC-V
 IOMMU device
Date: Thu,  1 Aug 2024 12:43:25 -0300
Message-ID: <20240801154334.1009852-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801154334.1009852-1-dbarboza@ventanamicro.com>
References: <20240801154334.1009852-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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

The RISC-V IOMMU PCI device we're going to add next is a reference
implementation of the riscv-iommu spec [1], which predicts that the
IOMMU can be implemented as a PCIe device.

However, RISC-V International (RVI), the entity that ratified the
riscv-iommu spec, didn't bother assigning a PCI ID for this IOMMU PCIe
implementation that the spec predicts. This puts us in an uncommon
situation because we want to add the reference IOMMU PCIe implementation
but we don't have a PCI ID for it.

Given that RVI doesn't provide a PCI ID for it we reached out to Red Hat
and Gerd Hoffman, and they were kind enough to give us a PCI ID for the
RISC-V IOMMU PCI reference device.

Thanks Red Hat and Gerd for this RISC-V IOMMU PCIe device ID.

[1] https://github.com/riscv-non-isa/riscv-iommu/releases/tag/v1.0.0

Cc: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 docs/specs/pci-ids.rst | 2 ++
 include/hw/pci/pci.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index c0a3dec2e7..a89a9d0939 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -94,6 +94,8 @@ PCI devices (other than virtio):
   PCI ACPI ERST device (``-device acpi-erst``)
 1b36:0013
   PCI UFS device (``-device ufs``)
+1b36:0014
+  PCI RISC-V IOMMU device
 
 All these devices are documented in :doc:`index`.
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 14a869eeaa..bed62f1de2 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -116,6 +116,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0011
 #define PCI_DEVICE_ID_REDHAT_ACPI_ERST   0x0012
 #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
+#define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
-- 
2.45.2


