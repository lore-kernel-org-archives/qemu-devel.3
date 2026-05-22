Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3250CD5BB4
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDQO-0005kV-Nx; Thu, 21 May 2026 20:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOj-0003G3-JO
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:58 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDOh-0004q2-RG
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:05:53 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2bd80b3aa13so43719775ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408350; x=1780013150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZq1TS4SRxhc1zRU0AK8gAJHqXbVMRKeP3nPDewB9R8=;
 b=ga+5yiRTPMQb0kSZt7EA1WAoqWF0Rtm93S9f6N3Gm4c9xdD0r0Ozi/+H4JFKoW8hhS
 cg9j9rdollVFr0qDiQSaEi3P+g6oyTN/Zr5+3QdsupXA+CRbCFkC+v4sbsy0T8V5qPSW
 9gPQXG+cMuNqseCyGc0hGxmTC+P18ShpVyOwrzHDNiN4qdmV+c3irNWvtaYnReNyxXZ+
 MfYRVbvNZqWdC9VWHH8jDqMJkN4Cl84JB45xYcOUIcSiR+6R1pvKHWd7U6uZigu1nNYE
 /F0Zu4gGMmGu14nVjhEDseY0+8LwwjEpmzYj6rbNpmm7bZ4FXfz6PmlyBE9XufymkFox
 sgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408350; x=1780013150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SZq1TS4SRxhc1zRU0AK8gAJHqXbVMRKeP3nPDewB9R8=;
 b=L8agm9oCV/RB1NgXhk+FLwTYB1XRb9hVl/KCYTS/VcjR2pyNu3wXCwc4bbGmNjjclv
 9kX33MKWLIIzL7E9OXF/o4J+GWlc7CRWMhFSR5lPeZrQqU8bX9lgs9hCAcf7l3rc/l0t
 vUnhyhpC0s0/h7CQZyMnu9yTHZM7GztGa0nxvai+HWvDd89v/ZAQCalqBU2p7lByPwaR
 yKwXmsE1ci73SHQ6M9CyT4bq45TajpH/0lMxpT9pxoViHXNza7hjW8Wt6mh9m4msr0pF
 jNXK2eXCHe7SKJhFjFnec6DfqbhDG5YYLXjIjPeb+4VH61tE6kXZ37F6cP97pPxwwVLh
 96wQ==
X-Gm-Message-State: AOJu0Yyy2z3USeEnFtB4UaJwSLAd1pG9CvrnLyukRgDmKIgFGgvVgBGp
 QJFyzxUWSQCe7OvWiZHigXeL/qVVNZCIZ1fs84NjsutO06myEmGguFz36UdnWITc
X-Gm-Gg: Acq92OFt8zjAqJxOq86cLCFvpjLpoi+7MNCvZJ4WVaU/FgVy85LqbTGLc9S++ChjjNp
 ZJOQ3LTEG9ubHoXhDsBiG5123DDI17BskqgiFgq6tbfPIfjCRH9ftMkbbrNxLF4En6XJ9HntPBr
 s0bf1jqztt9olTJXayTpMiTKLex+3zD1fTCnH5EQl+BvkNmoNKYcp4vGsKOV/iBVoQTO9Q8O2rF
 wgEmImvLt1gwSA+tKPM7jgWJK2JTp7YPr3lOionMn8/lazk++DhGaoFCM59yv/sJ27fAZ5IC54l
 lTZz4mBW23zN7YvCbJa52+lLKOkKzp/cCET2LPMxj+t3IphljN8bwYF5xhMrJe+qzhxbGHLLcoz
 rtTQm2LGVUEi3mUP9SgMHPND39oelxQTTIzA/32WXO9aqO/bHEG1eBiQQRsRc2X3D8b/ZsZGI+a
 Gceq0CbcDb91lY/ziMvxHoQKNW+vSd4JnQVMdyBiCrqQ==
X-Received: by 2002:a17:903:46c4:b0:2ae:54b2:27c7 with SMTP id
 d9443c01a7336-2beb085795dmr8421945ad.39.1779408350390; 
 Thu, 21 May 2026 17:05:50 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:05:49 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Zishun Yi <vulab@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 42/48] hw/riscv/virt-acpi-build: Fix off-by-one error in RIMT
 ID mapping
Date: Fri, 22 May 2026 10:03:18 +1000
Message-ID: <20260522000324.23255-43-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Zishun Yi <vulab@iscas.ac.cn>

In build_rimt(), the calculation of `num_ids` for the ID mapping array
incorrectly uses the same formula (`0xffff - s->pci_iommu_bdf`) for both
System IOMMU and PCI IOMMU topologies.

For a System IOMMU, `s->pci_iommu_bdf` is 0. This results in a `num_ids`
value of 0xffff. Since the source ID base starts at 0, the mapping only
covers Requester IDs from 0 to 0xfffe. The final valid PCI Requester ID
(0xffff) is erroneously omitted from the RIMT table.

Fix this by decoupling the `num_ids` calculation. For System IOMMUs,
explicitly set `num_ids` to 0x10000 to cover the entire PCI Requester ID
space.

This issue was discovered and reported by SpecHunter, an AI-driven
architecture specification analysis tool.

Link: https://github.com/yizishun/rv-isa-sec/blob/c78dacf66c8acd677b3538c837fde310bb71a97b/output/riscv-server-platform/pr-102/qemu.txt#L32
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260512062310.348208-1-vulab@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt-acpi-build.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index fd6ca5dbc4..413d47d70e 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -802,10 +802,11 @@ static void build_rimt(GArray *table_data, BIOSLinker *linker,
         range = &g_array_index(iommu_idmaps, AcpiRimtIdMapping, i);
         if (virt_is_iommu_sys_enabled(s)) {
             range->source_id_base = 0;
+            range->num_ids = 0x10000;
         } else {
             range->source_id_base = s->pci_iommu_bdf + 1;
+            range->num_ids = 0xffff - s->pci_iommu_bdf;
         }
-        range->num_ids = 0xffff - s->pci_iommu_bdf;
         build_rimt_id_mapping(table_data, range->source_id_base,
                               range->num_ids, iommu_offset);
     }
-- 
2.53.0


