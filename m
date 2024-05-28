Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D64FC27C43
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 07:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBrIu-0003eH-6b; Tue, 28 May 2024 03:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sBrIs-0003dV-3x
 for qemu-devel@nongnu.org; Tue, 28 May 2024 03:31:26 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sBrIq-0001fF-Lg
 for qemu-devel@nongnu.org; Tue, 28 May 2024 03:31:25 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6f850ff30c0so388987b3a.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 00:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716881482; x=1717486282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CjhHPP7vOg4Je4fWmMAQqc6bZgvVI0+REKHt2VsCjAE=;
 b=cpWzqzT/C8oWMG4FnHggiapJtVuKvitCFxDE7ajW8jHRfnKPuvVYk12Nd4jr6ZkCbz
 Znt+pKlTaM6p+Oa4FtbVVmbA9V0nviC8DX1wFjpDDIC+vMZOH9lOZ7Q8n6ciD9v+Wx0J
 5uYajpk/CvnlErWirmgkkyngxQB0iIfnRWBT1kkIfOTW0yoROhGLKWCm/PeE4qCgWEZ7
 ti3Hz1TfuLOc/+tVZsqggpr3ohVjb3bwu/FmFlcFfSWXYGzKAsdwhn1S+JWfCDegGiU/
 VWwSnxBy+WZvuVHTREgaZjm+wkIJfW/yzWi6CcvoT17lPbJ6sNV6m7hw3cpB0cH7IrC/
 q7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716881482; x=1717486282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CjhHPP7vOg4Je4fWmMAQqc6bZgvVI0+REKHt2VsCjAE=;
 b=xPwy8RUyaRUeX7BYcRYoPnsU4vgBmRsnVoj+Fqm+eRPbHnj++ZrzgeGI5skcB2EdXS
 xZjk6Wgk60tK7NDmYzlCKRoIlMvL3hqt0S07Zgu4N9JdtCs6Yig5ZgqAHszuALUnDDX4
 zJjb18EhDZzHF3oR7ikVFPJpVAHaFrXIAq9PW75I0tLiluydQgeSbfYZFE4VhkRVrsTh
 GI7PxdUgwb1qe+p6urOujorsAo7klm22WhzQMrg0XRZES194a68F/Fb+26sniCpdT+up
 oESEalkg5Sb1wJDbQ0rvl9VOagET6zMY+uhKgQRwWn7IG6Rp8lfUHcM5NdorHuDYzG8a
 b31A==
X-Gm-Message-State: AOJu0YxQBUBUwBFteDRjrU5ZtTLVUkMtYma9OSzKOQ7v8h0nppITgj6V
 v3U6IXo32iQ94sBsTfOjVAowELKIDMrHaMRqUXF70HOS/XDZG1+yY9xQ+/3dDmIohsZ88MOWJAK
 OXnM=
X-Google-Smtp-Source: AGHT+IHYK0ZPPN4VaxpomOg8fdu+YLnB+8841SSBGz3Z+UQro/bIcIuQzWMMW+pdnTk22S5murylDA==
X-Received: by 2002:a05:6a00:6c9f:b0:6f8:ec8e:a273 with SMTP id
 d2e1a72fcca58-6f8f38f9588mr13609241b3a.19.1716881482121; 
 Tue, 28 May 2024 00:31:22 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.31])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd4d51a2sm5881080b3a.189.2024.05.28.00.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 00:31:21 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 3/3] hw/riscv/virt-acpi-build.c: Update the HID of RISC-V UART
Date: Tue, 28 May 2024 13:01:03 +0530
Message-Id: <20240528073103.1075812-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240528073103.1075812-1-sunilvl@ventanamicro.com>
References: <20240528073103.1075812-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

RISC-V is going to use new HID RSCV0003 for generi UART. So, update the
HID.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 hw/riscv/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 47ec78e432..7f80368415 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -192,7 +192,7 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
                     uint32_t uart_irq)
 {
     Aml *dev = aml_device("COM0");
-    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
+    aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0003")));
     aml_append(dev, aml_name_decl("_UID", aml_int(0)));
 
     Aml *crs = aml_resource_template();
-- 
2.40.1


