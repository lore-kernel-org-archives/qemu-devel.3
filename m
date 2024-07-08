Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4C8C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 17:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQsHD-00069x-92; Mon, 08 Jul 2024 13:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sQsGt-0005om-74
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 13:35:32 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sQsGr-00082c-CP
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 13:35:26 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fb53bfb6easo15549155ad.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720460123; x=1721064923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KeU1QbF2gaj9I9NQwdGm88T60V2e4JrgFRF1GFggIjc=;
 b=UUBpiOIiMzosrqSmUaOJlBC+bKQMtSOzcJNrhRvuR36cPSlVQ/j4giMeeB93oMmxar
 /UceG43LLci5+emQ8aZccQoGl04LKVciu98gNVvqvaPotxgJyz0ZS5q2wGHmr8/fg0d9
 P3kS9ajXMNxHh8P/5YL+WjKg3ljhsdJjXT65EUXQILF1CEop6LRFwOo9o/R1+Nopv5J2
 uZAYpj3tynsTZJoqnS4GfG5Yg8YOP6x7XPwpRwK5BTpMRv6+izKxUspO5M6Hsea08Vi0
 p5ZhXSvmOzPBO0nRehDAm0J+2p1IWIzfp75V5i5tD7JQkxyIpYV8HBckRfsZNxf34j+6
 Vi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720460123; x=1721064923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KeU1QbF2gaj9I9NQwdGm88T60V2e4JrgFRF1GFggIjc=;
 b=JGVBftuAgUOTzoMPlu5i4eyt2H9S345Ux3WSvkjxF86xxCH1FKdN0TlORVTFPCIpTQ
 tUohUf9S8z8QrsgUp3F9zsQ3lYyQcGEDzEOR3jxnWnfqyqSfLRGRJ92nAvAUoHjtl1rZ
 qF+X7jkTooC7cgwnSd7Lw5QFlvyou2RGDUfcGG9tQ/lA7FC1mD9SgoCpFzL9TR0LOi5u
 qPSMocIuRV6XEKFQGHekMBS88K1JW2pKEhJ+dnw7Tq6Mb2YvJ5eYeMIOoDmapOaJI+X4
 +/w52ROWpRiFMyiS4iGqFkoIXNtNRh0wlpIEjDmDOrbA38xFO9jwnjJo9ldfP7PlWOos
 ycCQ==
X-Gm-Message-State: AOJu0Yz4XJnjwoBmvyV6I0DXKWzXgNl0vr/EoUdm6GiCog7b2bpC7IlP
 CT7zcof7+lzqj99X8CJP57kPdVBjVr7rJP6AuoJGi5LX8QyhsLW1DJ4gZUV1qM0pCRepQWZZ3Gh
 T
X-Google-Smtp-Source: AGHT+IFLnxcK5u4ZOWHn2IAYqzItLmVVXhU3Ko5Dk7t8NcM8CZ7SQhM/l4+4g8CfF+WkRNf+1eex0g==
X-Received: by 2002:a17:902:c946:b0:1fb:8797:beff with SMTP id
 d9443c01a7336-1fbb6d2ac74mr1823785ad.36.1720460123390; 
 Mon, 08 Jul 2024 10:35:23 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6ad3829sm1153765ad.299.2024.07.08.10.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 10:35:23 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 frank.chang@sifive.com, tjeznach@rivosinc.com, jason.chien@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v5 04/13] pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU
 device
Date: Mon,  8 Jul 2024 14:34:51 -0300
Message-ID: <20240708173501.426225-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708173501.426225-1-dbarboza@ventanamicro.com>
References: <20240708173501.426225-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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


