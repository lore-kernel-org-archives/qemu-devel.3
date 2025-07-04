Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367BFC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeOF-0007VR-NK; Fri, 04 Jul 2025 07:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMo-0003nZ-CQ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:06 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeMm-0004JK-F3
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:06 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-234fcadde3eso12985965ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627642; x=1752232442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gx2HRg6Bew7f9wcetISBp5wLA5aYtu8HS5SyZMirBf0=;
 b=KeN9Gi7Tsi9cQTXxHrI5dBuRHaegfyTIHZehSewcYee5C5/75NCyt9ovcHrZksl03p
 kkcMoTVVmT57fJH9gtyLAZRPS5TfeAGBRo/w1lFjJYGsQu87maQ2drI5CAo/BpQIGarh
 gErdi+L1IQfBKwOFlDm2UQz62d965FI5w+P4papkeDC0hERKtXTFaZ+IGbYJTm6e8HsU
 oN8q+Oig30F44aLZuKqKoxfx6aD9JE3QMIH5tF4e/wYqjNTPwaN55JKTE1+YviFsrpuP
 RTLp8E6hDfNt2Qwd1ebNxWPtDyoGFsmzkxvATT9x7zOXxLdEsC1q+UaS8W4uOqk5eJ/p
 Y+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627642; x=1752232442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gx2HRg6Bew7f9wcetISBp5wLA5aYtu8HS5SyZMirBf0=;
 b=rWAYkwen/wVdc+Gl8iA0+O5k6udA7s2Km8hunYHRNZdNgjxsvVYbxPfzmg2WFZDeLL
 2m9DT24+oUEbYnKCdUt98Sn2hZ/cMqVwasMgz84mmX3OAWD0EUV7XttjpNJrBTcUO4GD
 ewswRStZtOBOJgBwU1tir7bIhMyIvjAiN7w3kX/zPGLS4J2HGWG7bhi0kEM/Y7cCPt0q
 smis6d3wqi3miyuc1Q6+MNqftkDx8xXbqfU1HnVIU0DWJBDY0kLg2TeUL1FYO83ysHF4
 fA+wZZSEIJeqi9ZlQ0Fj/swm1myX+ksXFZTL6qj39OvkYpeL+78GfwpRkEgGtLuWTIxx
 g3Xg==
X-Gm-Message-State: AOJu0Yw9UxmODeHb5wtfV9Ls3+BK+L2e/iyrHzMASq8HoL/hi0caU1F+
 2nZbb2l3s03HBoKBdJsnUCT5TdPxRoHoBhesZEplkhMXwporMGGI0k5QAREGcA==
X-Gm-Gg: ASbGncsPHQIkt88EBxNsWB34TbxPlbV6eZtjpRDaeXMVYmedZgdU+FYTyCJV6am6r30
 veKnRtslaFuaEiZYTkArRAjpe4NO4dpbOEUt/5HGfu2aSthvP6X/Wi0UsiLXZZBb9HRaPMnjm6M
 I8ifIekS1krJgJvJi2HSO0SIeew9yxaJblxSrNaCtNwpNQeR3Afur1jKniEkgCCRgHkhpW2bBp4
 E9ZAdoC/v6t8QiN6sKPs6zkMLLf7RdrfCCBosUF0SiWxdldgm/6DxdJLrq5iWR/z2kWGm7YWrb1
 +ft/SoClMhO7xoyTaawkKylM52ecr2+Y2G9xBP3MJ9q+45ThppbntAStatMetkgIoavKlyAd9Su
 FwGaoESNYxPAyfwkLBTmbcqkGeu1xUW4D2120ZeXca0QbHttJVjD8f8O+73yfigClAbIaQpoPLg
 ob0A==
X-Google-Smtp-Source: AGHT+IGVEaLUZ51Yrz2z5YGeh4NWa5AIHENBKNx6vE3mAIgazPcu4WDnTiqLyguqMQ2I9Xp70nQUqw==
X-Received: by 2002:a17:903:3c47:b0:235:efbb:953c with SMTP id
 d9443c01a7336-23c8747b332mr24921865ad.13.1751627642565; 
 Fri, 04 Jul 2025 04:14:02 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:14:02 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/40] hw/riscv/virt: Use setprop_sized_cells for iommu
Date: Fri,  4 Jul 2025 21:11:58 +1000
Message-ID: <20250704111207.591994-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Joel Stanley <joel@jms.id.au>

The current device tree property uses two cells for the address (and for
the size), but assumes the they are less than 32 bits by hard coding the
high cell to zero.

Use qemu_fdt_setprop_sized_cells to do the job of splitting the upper
and lower 32 bits across cells.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20250604025450.85327-12-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 4fa2bad248..67490c5c69 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1088,8 +1088,7 @@ static void create_fdt_iommu_sys(RISCVVirtState *s, uint32_t irq_chip,
     qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
     qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
 
-    qemu_fdt_setprop_cells(fdt, iommu_node, "reg",
-                           addr >> 32, addr, size >> 32, size);
+    qemu_fdt_setprop_sized_cells(fdt, iommu_node, "reg", 2, addr, 2, size);
     qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip);
 
     qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
-- 
2.50.0


