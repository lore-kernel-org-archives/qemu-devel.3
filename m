Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609F7CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQkG-0002OX-BB; Tue, 16 Jun 2026 06:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQkE-00029R-4L
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:10:10 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQkC-0004Q2-0X
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:10:09 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c8585c51f1fso1923239a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604606; x=1782209406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V89OmXjJ6i0x2VVOQnLfX1TIcadCG73wFIW02DeqfbQ=;
 b=MblsKFVzinoJBx/AgzGkcDk2KMjqWsw0jpWq4/La/pORDAj4Ft2BKnlqGNrqu/C1CU
 auD0srLrICzmxG+3+DE+LCGZCPg6hAZrT0V2aw6XUXSmFujMzvv4rsQlb75bXqNglOHx
 Ul6MCHqLURRtdhaDrxd69CyE9c+jwocSNQ0Z4TKsPo+ygLWFDW9TDrdtCPJIc1Wl7HdX
 WmNVRg1PXONvhcByP6054IBGwAso5YM2Y7C4Z42zWoi3HVeK1/k1TyFn7AL3Q01J1SLK
 SCuVCOwIHnGqvm7Q8M0HqpLCWvZKCV0ObAtacneww4WrOP/wHnjS2VQEPGDjzCPRR9UM
 Vvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604606; x=1782209406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V89OmXjJ6i0x2VVOQnLfX1TIcadCG73wFIW02DeqfbQ=;
 b=sVdErzJujYX4k+E8kTdxNgnJMJAEPmD37xbOCPApFeIUI1BuBnBj5Xh2bwExvmR0zs
 kws5bxu8hQOz+g1K8YlVlnhAn0Q1OCzGcfDe1hI65b4YlMhUAUM5GaNmu/SeDr7HWVIb
 bKvGyoF6yzR1lXFSqoMZfBgppNy02ebLrl8JlMSl57DHraFUUeof1rXPlZcATO0oo66E
 W3D1Md2PRiuHUpTiyAXc/3njNWBtERifM7zEQbEmqygvELxl02jwPACvZH8yuK/3yWnl
 1JIOp5rmSsbDm2arwTjS3oA4W8s3srW14eUQJeoy8i3Srnvh5lCqmWEIr/uth3DVTQos
 yEnQ==
X-Gm-Message-State: AOJu0YzX65iQ1Nk8jrmPcWujeNyix7ic4GuFyeEX0PyHP6db6iz7P2Mu
 rwpczomR/whx3bsCszVShu5wWS0jyHPIFdLzoTxsSOHlyGFzIGGl+QAYpnx7WLCO
X-Gm-Gg: Acq92OGZ0LHQnOZ9fotmR9ztr2MZlTwf2u5cwhOlxJ60206jmOh9LOJVabG/c0tqgmM
 u66O9tgzG7eN+7o6t9Zl/vovej/6wnULoN4Mj8QLLNbhUOGcRf2Tum1jnPmFDGtkA/X5XQU/jhj
 b+o6ORN9bu0+6lXMLnHsUn1kWZEfvSZfYNJ1OGWzfhOp5X7GibRbSMekpYOw54LZ8nKXlStar4n
 bTn3bxAoIIjbu5dlzrQUUECMmYSMgb88k9pYqna04vAG/Zyln2n4lVnhqEC9EyjLdK5c9g8ciJA
 a5FpKy2piM7ZUCLNI675r/GnCSzqQGwVxjv3uL7rpGwHMFZVYOgIR5A4z5zBp4ptf33aSdk5hUJ
 R/Z9Dxn0i4IpYfkyuBrovc+qrTiuE5ZNvlXiggoJ1g86aw/4CGGiPm+wF5mc4bBVCI3+tCMQaLV
 cw5i1WljS3IGU70QQaDB1BXv/7tpGan/vOf3SkVc5l
X-Received: by 2002:a05:6a21:2d07:b0:3b3:ccd0:cf62 with SMTP id
 adf61e73a8af0-3b7e266e35bmr2847178637.36.1781604606556; 
 Tue, 16 Jun 2026 03:10:06 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:10:05 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 78/83] hw/riscv/sifive_u.c: add cpu-map, cluster and core DTs
Date: Tue, 16 Jun 2026 20:05:21 +1000
Message-ID: <20260616100527.1939565-79-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We want to consolidate the CPU socket FDT creation into a single helper.
'virt' and spike has the same code but sifive_u does not have cpu-map,
cluster and core subnodes.

These subnodes are present in other boards even in single socket configs
without NUMA.  This is a strong indicator that their presence doesn't
hurt a NUMA-less board like sifive_u.

Add these DTs to make the FDT standardization straightforward.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260615203734.954428-9-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9a791b36d6..a4265fed0f 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -109,6 +109,7 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         "sifive,plic-1.0.0", "riscv,plic0"
     };
     g_autofree uint32_t *intc_phandles = g_new0(uint32_t, ms->smp.cpus);
+    g_autofree char *clust_name = NULL;
 
     fdt = ms->fdt = create_board_device_tree("SiFive HiFive Unleashed A00",
         "sifive,hifive-unleashed-a00", &s->fdt_size);
@@ -143,11 +144,17 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         CLINT_TIMEBASE_FREQ);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
+    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
+
+    clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", 0);
+    qemu_fdt_add_subnode(fdt, clust_name);
 
     for (cpu = ms->smp.cpus - 1; cpu >= 0; cpu--) {
         int cpu_phandle = phandle++;
         nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
+        g_autofree char *core_name = NULL;
+
         qemu_fdt_add_subnode(fdt, nodename);
         /* cpu 0 is the management hart that does not have mmu */
         if (cpu != 0) {
@@ -173,6 +180,11 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
         qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
         qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
+
+        core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
+        qemu_fdt_add_subnode(fdt, core_name);
+        qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
+
         g_free(intc);
         g_free(nodename);
     }
-- 
2.54.0


