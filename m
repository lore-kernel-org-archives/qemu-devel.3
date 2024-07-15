Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8869DC3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 17:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTPEw-00051o-3z; Mon, 15 Jul 2024 13:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTPEq-0004w4-F9
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 13:11:50 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTPEn-0007Em-L6
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 13:11:47 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70b03ffbb3aso3614975b3a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 10:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721063503; x=1721668303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OnHpblZbVd3FRfJ45qGiQCVGtJlN2GB4v5fdYVeQ9C0=;
 b=cp6g9yMm3OGhMUQKBt8eWoskYZcfZQAE/2nxsQc2xLHn3dqXvlN9xqn2YVjhTQgBO2
 sNKKOx4e8Z72Lc8R4DqIPHi9AeJEDiU6VQhZaz5P4o1o6EzfZNfdw5hFkEjQgM5iMynh
 bRxb9Ky5K7V8K4o+18zItVmIeXBi3OQEYK0Gf3CrzPnTaryP3HH899glSGY833Cne/wt
 LA6jxgD5uuE2ai+CEsNwNc2TzpoWjlxgJcKjOFumq7Jh2JflrosXDddeR1mb938h3dwU
 2msM1Ol0YjZQoVOGCVuZWPlhShAb6LJOg77DvPZVnLPOQmAhZQHzu5cp/HJbaL8SjRxt
 xmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721063503; x=1721668303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OnHpblZbVd3FRfJ45qGiQCVGtJlN2GB4v5fdYVeQ9C0=;
 b=A8YSkEVOmR82mgd9KFCxD5kYMtOs/zn5KmeKif1FGrv6hCy8H46qIgX8omcgbo2fvw
 dELlhcJVqWrvLbcvdhw/KtTzVMtkwonTHbFiorBThSOwkgL7DAIdHR+fyB3tq1vhqcQs
 LFX5sYZtincP0aWjE6nBMvLKOm8POR2SPf1+hni6rFU1tatqFSzQhr1qlnmhQi9ea7vw
 q2/IxCVWHPqIdCSIxFDJpTmX44t5n1THY/yk7AxaTKX61sjGIRF1jyTD1NawrCy5Xxp4
 aleCT2LThmAXSxJPA2CpbXg5OteZw6Px33TdgOiG+5cF0bXJDIaZUKgv58M5lnTehCpN
 3scw==
X-Gm-Message-State: AOJu0YwdOJTzto9NBNaF8ewhiBUxU5jacPPPyqIf1017bmLKga2lR9vM
 C5cKQmYD4uWQeJ2/vNCwPbk+EYeBc1s+gNcb8DiFg5EjzJHCaXTNSdQiMKtkUBs2YZ6Zob/s/nv
 JR84=
X-Google-Smtp-Source: AGHT+IEZvzfAzfb26V65Qnelq7TR1JaOpHc8pEN0webbBfMjmZwc5mEwUqAhkW3GvT2MZX35yCowjA==
X-Received: by 2002:a05:6a20:430c:b0:1c0:f267:11ad with SMTP id
 adf61e73a8af0-1c3ee4d120emr747976637.19.1721063503459; 
 Mon, 15 Jul 2024 10:11:43 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca85ccsm4752618b3a.178.2024.07.15.10.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 10:11:42 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 2/9] hw/riscv/virt-acpi-build.c: Update the HID of RISC-V
 UART
Date: Mon, 15 Jul 2024 22:41:22 +0530
Message-ID: <20240715171129.1168896-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240715171129.1168896-1-sunilvl@ventanamicro.com>
References: <20240715171129.1168896-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x430.google.com
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

The requirement ACPI_060 in the RISC-V BRS specification [1], requires
NS16550 compatible UART to have the HID RSCV0003. So, update the HID for
the UART.

[1] - https://github.com/riscv-non-isa/riscv-brs/commits/main/acpi.adoc
      (commit: 7bfa87e86ad5658283731207dbfc8ab3744d3265)

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 5f5082a35b..36d6a3a412 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -170,7 +170,7 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
                     uint32_t uart_irq)
 {
     Aml *dev = aml_device("COM0");
-    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
+    aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0003")));
     aml_append(dev, aml_name_decl("_UID", aml_int(0)));
 
     Aml *crs = aml_resource_template();
-- 
2.43.0


