Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA07FC28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 05:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsxOa-0005iV-Bt; Fri, 14 Mar 2025 01:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1tsxOY-0005hr-Tn
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 01:15:43 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1tsxOX-0006tb-70
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 01:15:42 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso32529955ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 22:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741929338; x=1742534138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRmwwscyRwEDqCnI3abF+NUYE7gKd59kQM35HmG7LFE=;
 b=OO1nldY2o+UNsUNcw3GqmNQ/Fnyq7pyvK9nIOud1dHVlcsNQA1DjTxwxanuNEnbh08
 bVt/Vz6yS1F1YuegBtXyUdlEbaPpW+jatScsv/12ZBbnTMAh9F64OB0YyI7rvl3ckssD
 yecT26Cj6kO1Q37cV9kggx+8zs8MgLDthmc1Zt2xuW1gH3emCRJe+bqbxMymzv2oYJyW
 3m1EV7MvXBsiFht8Hl5VTyraL1mzXZevpIGN1PSl//JbUngAJjdrCHIH7dqvcCrw4hMr
 L8zj8B5sU5W8LovmtVu4f+9IYeJDORLKY1tGCCLBbhvCaQzXuu36KFnQk76wcEcwVwqb
 xl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741929338; x=1742534138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PRmwwscyRwEDqCnI3abF+NUYE7gKd59kQM35HmG7LFE=;
 b=gcDQLWQTxOaXgs1QPmLZRE1JtxJpePHtP3rioyOWZxRVyGfSDomKXGfoq8sGNtL2vz
 Gn6PzRiP9yqI92NAHCtCYeZGKU8IsRVudNFMT1AHWVVftT5QYCTIxVtFqJkupBM6S0fh
 7Hp57RMSYWw5L4jUYhAJaAsRg+MOZHI1pmnK03PljjYFJ3U3Y8pNhbng9nsRpf5lzCKa
 AwrgT+lPjEF+raJ1t+pCkHUBjoSwhZQCdlN6qG+h0wxZB4oiJX6l/PLv21nu6ha/5a+W
 1eSwtYBvVmbzAb8uKtZsQZKPVb2EOY59a5FQu93FKaxSJh5761Sq47u2ZkhX6q17P+UZ
 cpQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZJHClVTttiq+Un161Xd99zWw2rOOkaFYnWuxfpiJIiInCHpPNtDLDCF569yXJ4zQVPFimv8wxRWjy@nongnu.org
X-Gm-Message-State: AOJu0Ywo+QqRJwNU2HU8FZLQEiklmDn988UtCPIB2kXsyj03+kuUcyiY
 lcdkqQ6vqMZp/to1LXnmRQmAVIydGS3putvDcypi7A/Bk4DdbU6UnUo9MygQX1g=
X-Gm-Gg: ASbGncvBrK5ddfDNfd1Aq/NfcYpZRKgeSQPS7+riAFDZmLHyzewTV3MdDA7Iz96r9Wv
 1ufiygnotNQHQYAAudAmNtHPT01o72B+4VqL6vf2mXco/88ZMVSaVTbnQJ0tZFEez4o8/Y9XoHg
 Cz+XlCaTcqVynQPHv4t/vemQ7cjZJwVgcrfbKkL0kpUNw78uRiUI7TQ41/txDiYA5/jYyC4iNS3
 jx/V5kgPBKh1V+PG2SLJo0davLDYyutaVoorwYLjzrrLYOaCIaiGQn3PAB68sbfbE4xrXJDsw6b
 iodf6Aoum6sraNYErB8OFD3opgKuMcTkgryuqAYlf1i2GAFIbQQZrWE=
X-Google-Smtp-Source: AGHT+IGIQfF6a57pV1C3XgDWL4bJFohqoWYOoIiBoPXgfA6s++2BoFcKnL/BsufqQJtkR6GxzeJfkg==
X-Received: by 2002:a17:902:e750:b0:223:607c:1d99 with SMTP id
 d9443c01a7336-225e1594eacmr18767765ad.0.1741929338230; 
 Thu, 13 Mar 2025 22:15:38 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.199.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bbeb94sm22278225ad.199.2025.03.13.22.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 22:15:37 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Atish Patra <atishp@rivosinc.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 1/2] hw/riscv/virt: Add the BDF of IOMMU to RISCVVirtState
 structure
Date: Fri, 14 Mar 2025 10:45:26 +0530
Message-ID: <20250314051527.1892488-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314051527.1892488-1-sunilvl@ventanamicro.com>
References: <20250314051527.1892488-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When the IOMMU is implemented as a PCI device, its BDF is created
locally in virt.c. However, the same BDF is also required in
virt-acpi-build.c to support ACPI. Therefore, make this information part
of the global RISCVVirtState structure so that it can be accessed
outside of virt.c as well.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 hw/riscv/virt.c         | 1 +
 include/hw/riscv/virt.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index dae46f4733..ce256fb3b3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1116,6 +1116,7 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
     qemu_fdt_setprop_cells(fdt, pci_node, "iommu-map",
                            0, iommu_phandle, 0, bdf,
                            bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
+    s->pci_iommu_bdf = bdf;
 }
 
 static void finalize_fdt(RISCVVirtState *s)
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 48a14bea2e..7b4c2c8b7d 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -63,6 +63,7 @@ struct RISCVVirtState {
     const MemMapEntry *memmap;
     struct GPEXHost *gpex_host;
     OnOffAuto iommu_sys;
+    uint16_t pci_iommu_bdf;
 };
 
 enum {
-- 
2.43.0


