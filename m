Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD47C282E5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdz8-0007TQ-2c; Tue, 04 Mar 2025 20:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdya-0006Rl-48
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:12 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyY-0000OC-7z
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:11 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2238d965199so61668545ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139708; x=1741744508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=geC3U75yXm61oV1WPeiHQMiW6u0uu3Ls5xAzTiODQ6A=;
 b=ZXFQg7g7+V891TG94WnW6BqqpS56WxXCY077iY6Dld6qz3qrNRlEYd+ZIqSfr7z4+K
 h8K4vdUOv7nxYZqDbeVFDdmE0aDZsN659IiVz4dw0CPTKEIkDOnQDV8Ow16X9FvzdVI4
 vv0g9B466GxfPqIevW3lmy+DHyhRFxVEJYowKPJCwByWmq56M43tpvwiruXeJbpXb8s4
 nJLdvmAAbpfg4jBFGXr/5Mo8pIgD5HBgUC7efgLSFPrfyR7BfVwHgiozJ/9XPnFPHr8/
 hDLFksSrd8vB8CM5vYhiN2vpX5vo2rR1UhuNAU7sP0BYm/5Uprks/nzAx+ov6ggYoRkQ
 TJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139708; x=1741744508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=geC3U75yXm61oV1WPeiHQMiW6u0uu3Ls5xAzTiODQ6A=;
 b=nrU7gCzJpFwJ8O8X0XJ+gQmW0a0tsXe23/Eoy5p8uUpJCCbNWSMbdUyPhMkPSE7fvv
 RgF73qyKhyST3PXf7fu13LvGpBSc52mX16PWBpqJtudPOtoZz8w89G96ioYyOArmEh40
 2xTR4GfU36CDGldR2A7EcNxT/s6YOVy4ZOn0UGJRIi6Qwm/py+dJIfDCKQWZ338Hj8KZ
 9x3jLfKRCJzBtGSsvOnjlNc4HrSVlA7lCShBmK6Wicq6HOmhvXMr6Jv6gWbyBxb2SupA
 vrQNO1LVTNipOuZMLRlMFQlbAaJCgLg8SD2YiBlpHY34GJqqzpYgaflkkev+gbGMAq66
 9tUQ==
X-Gm-Message-State: AOJu0YyK/ABU007+kwuv2HAEXsmN06qYCCxmETprDQNgERsK55d24lbm
 kfURN5IQFNq9fk2A1ZEma+AL7MsSkNCj/w3E3M0Q/QaLmGX379KhASjQJCOdnL4=
X-Gm-Gg: ASbGncufaHp3xDzR16IBJWsNhu8/lAMPuslLbxQKsXGMNCT3mlNkRj4MpGGuG6HX36b
 w6E4Nhxyrac5SFbvCjfCLrj4wUSqWiWgFZ08jOYF5CcShvqTpEqYoeG5RorspgY7uaduUCUIXf0
 8v4kTBPx/dYqgrxt4FJJXpj7DtNab1fCN4HdGR2gZcxzX+J6WATHlyrhyp5oFsoF4NGUxkJSbSM
 SBOJKATukZ1kc1evaGF1lRMez9eMm9T4gPYLeg4xX5KkehoBSpnVJZGEtIv0yhUJWriWI4iEsxF
 0MjKI68A7yW7QEBif76szmQbcy/ptM7QHQEtnnR4ewtK7DA2XQ0qA8nURfRGBnWj+X/ib8GVnpQ
 Zn98ry3VxQ+mmX1k2nqbL8QOooJEy+CDCs6u4hprU5MntI2+zrZQ=
X-Google-Smtp-Source: AGHT+IEWTl1/CoGcnaeNYvn7fnYILo7umEFWSa9BsUKsMARmYD2c3QD/hr4QtlPEYg9J061thkjsbQ==
X-Received: by 2002:a17:903:186:b0:21a:8300:b9d5 with SMTP id
 d9443c01a7336-223f1ca5aecmr17107215ad.23.1741139708455; 
 Tue, 04 Mar 2025 17:55:08 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:07 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 39/59] hw/riscv/riscv-iommu.h: add missing headers
Date: Wed,  5 Mar 2025 11:52:47 +1000
Message-ID: <20250305015307.1463560-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

This header is incomplete, i.e. it is using definitions that are being
supplied by the .c files that are including it.

Adding this header into a fresh .c file will result in errors:

/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:30:17: error: field ‘parent_obj’ has incomplete type
   30 |     DeviceState parent_obj;
      |                 ^~~~~~~~~~
/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:50:5: error: unknown type name ‘dma_addr_t’; did you mean ‘in_addr_t’?
   50 |     dma_addr_t cq_addr;   /* Command queue base physical address */
      |     ^~~~~~~~~~
      |     in_addr_t
(...)
/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:62:5: error: unknown type name ‘QemuThread’; did you mean ‘GThread’?
   62 |     QemuThread core_proc; /* Background processing thread */
      |     ^~~~~~~~~~
      |     GThread
/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:63:5: error: unknown type name ‘QemuCond’
   63 |     QemuCond core_cond;   /* Background processing wake up signal */
      |     ^~~~~~~~
/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:71:18: error: field ‘trap_as’ has incomplete type
   71 |     AddressSpace trap_as;
      |                  ^~~~~~~
/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:72:18: error: field ‘trap_mr’ has incomplete type
   72 |     MemoryRegion trap_mr;
      |                  ^~~~~~~
/home/danielhb/work/qemu/hw/riscv/riscv-iommu.h:80:18: error: field ‘regs_mr’ has incomplete type
   80 |     MemoryRegion regs_mr;
      |                  ^~~~~~~

Fix it by adding the missing headers for these definitions.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250224190826.1858473-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index fa8a50fa24..d2608d2f9b 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -20,6 +20,8 @@
 #define HW_RISCV_IOMMU_STATE_H
 
 #include "qom/object.h"
+#include "hw/qdev-properties.h"
+#include "system/dma.h"
 #include "hw/riscv/iommu.h"
 #include "hw/riscv/riscv-iommu-bits.h"
 
-- 
2.48.1


