Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA96CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDs4-0005rq-H6; Tue, 24 Sep 2024 18:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDs2-0005fC-56
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:58 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDs0-0001gD-BZ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:57 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-718d6ad6050so4451652b3a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216334; x=1727821134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bEmBPhRtysBtPpiKelgvSVTEamC5FPrpVzPYJCYDzDI=;
 b=dgNveYE/UZfRXZJu251CiOY+ongKce0lnjLseIqxnmjAxX5wUwU4K1+pfDqS3EPKDY
 QSXP3JcPQme1cMIUiXwR1ltritgLJ96J1y5aO4/NI6XOmGbBqRIYzKEdKS3vJdvjaSOB
 0MTAikhk9HRqG9Tjf0ufthTgNFvh3dj3cotU/5KqQfJr9N48OQSmSo4XHBQtZsqrM6QL
 thFjMdWAWmpOyEg96YzeumPzedAqeqX4Ckc7DQUSp35bpglvPHZdw6smgeG6PscRBftK
 LQ4nzttm3RdQSNuAMbyOq5nzGMDye5TtZoB4OGIub+lxb1v5jjx/nwkGzmp404Qk9kNY
 K1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216334; x=1727821134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bEmBPhRtysBtPpiKelgvSVTEamC5FPrpVzPYJCYDzDI=;
 b=Ea3xGlbla/IVE0iz1eOnNEpJ5thKHgDlqgtMn8xD8/6wkPUJf0iv6R3QY7PgaFTMAM
 E7nX6APpJ+KXmAN+rtxGUS0qMQu5sgtkA4OyLoL8uGiyyoZ4evvsdIgfnJtJYTfbY5ww
 7Ee1JON4Sjyqe9ph6U88mq6kvAjA3TDjCJHEsMpoSE+UkJ3NZA3f8reJG4FULU1T5a3M
 7kfUzo1m2JwvG/BWhd9qMPS4tANkPKANqX998zPKhEn5q+OSq/hhft0vHbToD/rXq67w
 4EtxnT5bqIN8oTMFqk1O68+L/NwVCG8RDe8C9B3c9lsplZBfbACMaPoreSnkULV4SeoE
 J5Bg==
X-Gm-Message-State: AOJu0Yywb24RW96lwK2pHJxL+gQi7XDZCQRF0tRtBLqKFj9zob+YAYEd
 igaheIL6UKsczy0pN8w7MoYJY/U7JsDRXAxCd/5ZFRU2885JEOsmPzJ5xA==
X-Google-Smtp-Source: AGHT+IGmVBiIcMqIz7GjcuK2NSBRqQEWSkGU8FAyP6bCACz/D0pYPi2xSk+SPO4eRgzIiKn7N2tQFw==
X-Received: by 2002:a05:6a00:1702:b0:717:8f0d:ec37 with SMTP id
 d2e1a72fcca58-71b0acc4177mr923028b3a.25.1727216333608; 
 Tue, 24 Sep 2024 15:18:53 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:18:53 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 17/47] pci-ids.rst: add Red Hat pci-id for RISC-V IOMMU
 device
Date: Wed, 25 Sep 2024 08:17:18 +1000
Message-ID: <20240924221751.2688389-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20240903201633.93182-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/specs/pci-ids.rst | 2 ++
 include/hw/pci/pci.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index 328ab31fe8..261b0f359f 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -98,6 +98,8 @@ PCI devices (other than virtio):
   PCI ACPI ERST device (``-device acpi-erst``)
 1b36:0013
   PCI UFS device (``-device ufs``)
+1b36:0014
+  PCI RISC-V IOMMU device
 
 All these devices are documented in :doc:`index`.
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index eb26cac810..35d4fe0bbf 100644
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
2.46.1


