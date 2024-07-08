Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6012C3DA44
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 11:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQmqn-0001le-Qo; Mon, 08 Jul 2024 07:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sQmqb-0001Wk-HD
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:47:59 -0400
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sQmqY-0000zB-OH
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 07:47:57 -0400
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-37613975e20so16930945ab.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 04:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1720439272; x=1721044072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yavw6aCB+cL8jfGAWIFAWUU098X5XflaXF6SwWqsWrI=;
 b=ZRw5GvFpJ+tw0UbHgWnccG9XLYqiL10Imn2zqruVXr2fOc2qS8ZTINBROxjHXRRPaO
 SsuBZaLxPao4Sow/P/+XmD3uPyArBPtRHZTlVZmQoQN0qJHDD4ZkbJ9A/dNC/Hg/od8N
 jALeZPE6usUZTg+Cw6T2ZX0nUquw2mev4HzRHv2F5/8Z5eL8cya7h3P592Fnexw0Eh28
 dlID0JR/4a/w1HiAPAzPIW9Slh5P6W9UcTiTSdtr+7BBJjVen7j4y0iEBz3Yzon4UJrJ
 s7PBbVbkFTPWrq+e9RS7pEUsJX72uPShZvGbVS1obts7lzl8mg75DpzJtDm7RBmtZiD0
 LEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720439272; x=1721044072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yavw6aCB+cL8jfGAWIFAWUU098X5XflaXF6SwWqsWrI=;
 b=IbqVaUwx5A3zM62QfRG3Tr0JO6QGUdlZZu7BdyPPx5rQWMbCdhyaf4rDb5EsiMAC0G
 YoVStdjZg3GYgADM3ht8p2yOxTKHOBp+E9C7PJSOEtvNgRpQdFuNJwCtDXBbXTo7TlIL
 MeLdx8iQIe5YzcCzp4un1r8v35lbYHUMqwQlYVpgRXcJSL9BZBht3CLBnsWOkqO8me4N
 MQTtcs6ZFej6Hc6V0V7dF/ZpTHtAHCcG+aTlosj98O3jXv77K9WhtHfYkmnbwU64yp6K
 npF5eQhXIV2hoBMGG5HHg48DPHzmPJrqj8PpXbc3l75Km9Qb2o391Qc+RfU6e6zPiblj
 B8hg==
X-Gm-Message-State: AOJu0Yw0PlBOu/NGfIYYksLf7wuQHelcyn5keRX2HIZYrBLe6kcA1y8a
 K55vn9EfrKtAuG242R1dUccIS1lOXQYmEOQXaTvu6mpPxW8UiBCoJ4Wp5PrlosLk9Gd0aY1dNyX
 Y
X-Google-Smtp-Source: AGHT+IGv4vGfBmcPrKYwIoaZuLU4rFy6FeNL3UozVweyRstjMcTt5Qg5dP56f6ahf7jlg3pMUqigyw==
X-Received: by 2002:a05:6e02:1a8c:b0:382:a99f:fd16 with SMTP id
 e9e14a558f8ab-3839833c683mr160097885ab.4.1720439272467; 
 Mon, 08 Jul 2024 04:47:52 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b2a432ac6sm2769642b3a.94.2024.07.08.04.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 04:47:52 -0700 (PDT)
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
Subject: [PATCH v2 1/9] hw/riscv/virt-acpi-build.c: Add namespace devices for
 PLIC and APLIC
Date: Mon,  8 Jul 2024 17:17:33 +0530
Message-ID: <20240708114741.3499585-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-il1-x12c.google.com
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

PLIC and APLIC should be in namespace as well. So, add them using the
defined HID.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt-acpi-build.c | 47 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 0925528160..87fe882af0 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -141,6 +141,52 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
     }
 }
 
+static void acpi_dsdt_add_plic_aplic(Aml *scope, RISCVVirtState *s)
+{
+    MachineState *ms = MACHINE(s);
+    uint64_t plic_aplic_addr;
+    uint32_t gsi_base;
+    uint8_t  socket;
+
+    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
+        /* PLICs */
+        for (socket = 0; socket < riscv_socket_count(ms); socket++) {
+            plic_aplic_addr = s->memmap[VIRT_PLIC].base +
+                         s->memmap[VIRT_PLIC].size * socket;
+            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
+            Aml *dev = aml_device("IC%.02X", socket);
+            aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0001")));
+            aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
+            aml_append(dev, aml_name_decl("_GSB", aml_int(gsi_base)));
+
+            Aml *crs = aml_resource_template();
+            aml_append(crs, aml_memory32_fixed(plic_aplic_addr,
+                                               s->memmap[VIRT_PLIC].size,
+                                               AML_READ_WRITE));
+            aml_append(dev, aml_name_decl("_CRS", crs));
+            aml_append(scope, dev);
+        }
+    } else {
+        /* APLICs */
+        for (socket = 0; socket < riscv_socket_count(ms); socket++) {
+            plic_aplic_addr = s->memmap[VIRT_APLIC_S].base +
+                             s->memmap[VIRT_APLIC_S].size * socket;
+            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
+            Aml *dev = aml_device("IC%.02X", socket);
+            aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0002")));
+            aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
+            aml_append(dev, aml_name_decl("_GSB", aml_int(gsi_base)));
+
+            Aml *crs = aml_resource_template();
+            aml_append(crs, aml_memory32_fixed(plic_aplic_addr,
+                                               s->memmap[VIRT_APLIC_S].size,
+                                               AML_READ_WRITE));
+            aml_append(dev, aml_name_decl("_CRS", crs));
+            aml_append(scope, dev);
+        }
+    }
+}
+
 static void
 acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
                     uint32_t uart_irq)
@@ -411,6 +457,7 @@ static void build_dsdt(GArray *table_data,
 
     socket_count = riscv_socket_count(ms);
 
+    acpi_dsdt_add_plic_aplic(scope, s);
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
 
     if (socket_count == 1) {
-- 
2.43.0


