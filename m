Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928F3C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlwd-000508-7N; Thu, 27 Jun 2024 06:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwP-0004xk-NJ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:25 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwN-0001aE-Cq
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:20 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70698bcd19eso2194010b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482478; x=1720087278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Os9dSPxVJFr6h4ij+p8yPFL3Km5u7oyL3YdiKrf7h8=;
 b=babtBiKDnf4m0T9FiUgY1/GJxjuAzSc0RNV7Xekb+hKhLsjQv2bIOiKdTTK2BwK5Ej
 n7kik76zLlhGRqZNACAU+y/hNQaL4zsO8NfQPeRsBldMKNgevJKJSemQPQLhp0j85tVP
 LtpcUf2ejb6dRBZ4OHBPwUnDYs0z448frXJ+Qoy1DnwryFtwVseo3oYb2CLsK3xVgtqk
 u+LvWmeeghv/vdhorgzjOsr9VFXa09UELBWq05RO3pgDL1UBUXS3cvWfjU79LfoeX4P+
 Dt3S5MuHrQ6iPPe+Pfqt3kwtgDeoKDhypTDg9Kj6XR3zo3AQ+MMTKvlXH/wO6a8C70wZ
 uFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482478; x=1720087278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Os9dSPxVJFr6h4ij+p8yPFL3Km5u7oyL3YdiKrf7h8=;
 b=H60AmP0vNHgohV8XNmxL5Zk3z4lXUjOtqiEr/zVqyW/fTkQDG3NV9Ii1gSj2uY5Qr7
 U151u3CJiJRNsCGb2VtpAd83avYE/dtTTDvux6XCyQ3siu/Ci8GQU/0FFmvZ/j1CRWYB
 1jJJMptUGBNOMYT7IUy9qmKqG1VZa0LuQSddgCdNyuCakNpV5yg46qCZM67HoSP3eT2G
 BzejGIK+qQA1Gk1rJJGlJq8eyCiL5Dpn2ZVgblj5W+iPT7oY/j/ue2+Cu/Bkaug/P0P0
 q9cOhKoo8UI2+P7AnrPKeQAWlR+4JkELbK86kDeN4MbyqHk2dXLy+x7X0IjqXtxZIB53
 n5aA==
X-Gm-Message-State: AOJu0YzOmQrA342/C/11VyQ38IKXkfIMlza45e1xm/pG3Bu1O1w9yC/N
 uDLyTiDKS7emI2RHstsW6yzo+zQCA1XasYbC087qc2W4JJi9dzWn67reeWuO
X-Google-Smtp-Source: AGHT+IHPnhcEx335l/QMUu2R0HLdkqWzGMCNJM2jLYcikSA3C6F1sAav/BfGKry7hCI3/EsKiMuCEQ==
X-Received: by 2002:a05:6a00:1387:b0:706:a5f9:5240 with SMTP id
 d2e1a72fcca58-706a5f9535dmr5509454b3a.13.1719482477605; 
 Thu, 27 Jun 2024 03:01:17 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:01:17 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/32] hw/riscv/virt.c: add address-cells in
 create_fdt_one_aplic()
Date: Thu, 27 Jun 2024 20:00:25 +1000
Message-ID: <20240627100053.150937-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x429.google.com
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

We need #address-cells properties in all interrupt controllers that are
referred by an interrupt-map [1]. For the RISC-V machine, both PLIC and
APLIC controllers must have this property.

PLIC already sets it in create_fdt_socket_plic(). Set the property for
APLIC in create_fdt_one_aplic().

[1] https://lore.kernel.org/linux-arm-kernel/CAL_JsqJE15D-xXxmELsmuD+JQHZzxGzdXvikChn6KFWqk6NzPw@mail.gmail.com/

Suggested-by: Anup Patel <apatel@ventanamicro.com>
Fixes: e6faee65855b ("hw/riscv: virt: Add optional AIA APLIC support to virt machine")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240531202759.911601-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/virt.h | 1 +
 hw/riscv/virt.c         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 3db839160f..c0dc41ff9a 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -118,6 +118,7 @@ enum {
 #define FDT_PLIC_ADDR_CELLS   0
 #define FDT_PLIC_INT_CELLS    1
 #define FDT_APLIC_INT_CELLS   2
+#define FDT_APLIC_ADDR_CELLS  0
 #define FDT_IMSIC_INT_CELLS   0
 #define FDT_MAX_INT_CELLS     2
 #define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 5676d66d12..e903f05851 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -609,6 +609,8 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
     aplic_name = g_strdup_printf("/soc/aplic@%lx", aplic_addr);
     qemu_fdt_add_subnode(ms->fdt, aplic_name);
     qemu_fdt_setprop_string(ms->fdt, aplic_name, "compatible", "riscv,aplic");
+    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "#address-cells",
+                          FDT_APLIC_ADDR_CELLS);
     qemu_fdt_setprop_cell(ms->fdt, aplic_name,
                           "#interrupt-cells", FDT_APLIC_INT_CELLS);
     qemu_fdt_setprop(ms->fdt, aplic_name, "interrupt-controller", NULL, 0);
-- 
2.45.2


