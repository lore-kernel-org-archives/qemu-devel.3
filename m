Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B215AC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVglc-0002sW-GM; Sun, 21 Jul 2024 20:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglL-0002Au-P3
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglJ-0005wC-Fj
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2MFU5YluLJy3dMwMtCRKC5eZxelIcmwO+t8tRGjROFc=;
 b=fyU7JAlDE6XfI9DXhzVO5DF2SaHhnemXSMGGVvWNiRhLsqPwaegrs18xRCfrPSwUik5JNs
 jSFsVEALuMZckp6R5xPiCkZ48sjD1Op3f+vbmyd4SIO1STkrql7g9CeXZ1ZzDY/tT03Upi
 Wpg2Hqdx+1JLHkOOn8fUXx8O4FqXOjg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-NWlMjow5Np-UUeG9blZMqw-1; Sun, 21 Jul 2024 20:18:42 -0400
X-MC-Unique: NWlMjow5Np-UUeG9blZMqw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36835daf8b7so2715769f8f.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607521; x=1722212321;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MFU5YluLJy3dMwMtCRKC5eZxelIcmwO+t8tRGjROFc=;
 b=Tf6exIy3f9LWp0+eeufqXc+STC6xkQETmjFMnU00mp4til+7X/xKxFwShp7ZStVPgj
 uMCit2DVvQYhVMSAT3NaEf/opKvADgNJCkIpJyPIeH7qfG847iQ0Nd3NWVLuOe4ywVuA
 OEYETLgX1RZ2tFi6D3V6e9NApU5SuG0uJ2MUAhUHGdEFAGn+e8WXKHbc83Q7pH0/dXla
 /mPdMCe7b2jYZOMzB205Dk1Go/ybxJnQ4QguckX7mLgSRU/8g38KzBazXFEjsZo+dP3A
 1e2Gt0Qp9daewn2u7ZIGyPufzwiLSdxcr7Js0qWAqAHFnlLzVMVrTb+5ThsV/mhVCnj7
 iJQA==
X-Gm-Message-State: AOJu0YxGgAWM2m0b3cfbPrK8eIr3MiRRhwgyEfyqmGzioYVmQ2nTCM6S
 T+CjlWszXhV19d057JBw91tfHWiEEMel+4y5YC/QlUnfoWbBInWwc3lJnvSZ79D3TsJRaJ/Q23b
 qQ5o0IUtOl57oPTyiEqAkDDZTCFoFjTWSFodsTcqIenGYg7WvpbIR3QtvF54jYFUejTfu8Ybk/q
 AunzT8czzCwVVI2dUd6xNxxaWMEAVvAQ==
X-Received: by 2002:a5d:4604:0:b0:368:7282:51d6 with SMTP id
 ffacd0b85a97d-369bae4d54dmr4227556f8f.21.1721607521257; 
 Sun, 21 Jul 2024 17:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWzKtRRYHll+mm01uoqHoCxQ2/pCyfQk0/jmxFlqOHMnxJDo0jZlLMmPQiMvL27rYFpYlwMQ==
X-Received: by 2002:a5d:4604:0:b0:368:7282:51d6 with SMTP id
 ffacd0b85a97d-369bae4d54dmr4227530f8f.21.1721607520599; 
 Sun, 21 Jul 2024 17:18:40 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684204sm7029703f8f.2.2024.07.21.17.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:40 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PULL 51/63] hw/riscv/virt-acpi-build.c: Add namespace devices for
 PLIC and APLIC
Message-ID: <dbd4cc00ca249b75170c2c0fd60ee2db452352a9.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sunil V L <sunilvl@ventanamicro.com>

As per the requirement ACPI_080 in the RISC-V Boot and Runtime Services
(BRS) specification [1],  PLIC and APLIC should be in namespace as well.
So, add them using the defined HID.

[1] - https://github.com/riscv-non-isa/riscv-brs/releases/download/v0.0.2/riscv-brs-spec.pdf
      (Chapter 6)

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716144306.2432257-2-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/riscv/virt-acpi-build.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 0925528160..5f5082a35b 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -141,6 +141,30 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
     }
 }
 
+static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
+                                     uint64_t mmio_base, uint64_t mmio_size,
+                                     const char *hid)
+{
+    uint64_t plic_aplic_addr;
+    uint32_t gsi_base;
+    uint8_t  socket;
+
+    for (socket = 0; socket < socket_count; socket++) {
+        plic_aplic_addr = mmio_base + mmio_size * socket;
+        gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
+        Aml *dev = aml_device("IC%.02X", socket);
+        aml_append(dev, aml_name_decl("_HID", aml_string("%s", hid)));
+        aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
+        aml_append(dev, aml_name_decl("_GSB", aml_int(gsi_base)));
+
+        Aml *crs = aml_resource_template();
+        aml_append(crs, aml_memory32_fixed(plic_aplic_addr, mmio_size,
+                                           AML_READ_WRITE));
+        aml_append(dev, aml_name_decl("_CRS", crs));
+        aml_append(scope, dev);
+    }
+}
+
 static void
 acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
                     uint32_t uart_irq)
@@ -411,6 +435,14 @@ static void build_dsdt(GArray *table_data,
 
     socket_count = riscv_socket_count(ms);
 
+    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
+        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_PLIC].base,
+                                 memmap[VIRT_PLIC].size, "RSCV0001");
+    } else {
+        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_APLIC_S].base,
+                                 memmap[VIRT_APLIC_S].size, "RSCV0002");
+    }
+
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
 
     if (socket_count == 1) {
-- 
MST


