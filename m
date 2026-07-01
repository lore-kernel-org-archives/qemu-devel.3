Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B06C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes2l-00045V-71; Wed, 01 Jul 2026 06:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2k-0003xW-0a
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:46 -0400
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2i-0004sb-3O
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:45 -0400
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-137335bc3caso975611c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901183; x=1783505983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TpMN+VkpYKe5eeWv6ivWdJjbIBFCT/o2DjQCDwuTuVM=;
 b=jGd9Q02F/hmb87TWMO0oSjugRmHaCJlgTuAb/tO52FNyavv+Y9JKZVP308Q7Ybp1o0
 mNgmj1hgMggGVNmbMCRtva13/IkacmYJquWdsoKwX9HBkWnAi4qUuR8AMmWfgj5Yyp8/
 Pz69j7w3b3NH+01RDY6q874BCyEXuXFHi7FZrwO9mZ2K1D6FJgZovLhRtJXgNadlmbI0
 yNyF1QdEvdTbrrqWz1FJsQ7bbZeQvk448y4FPJtbxxfL89gVOIGg+Es9QK28i0Gn8KCP
 LR2H2+IfYb3FmR9tSGm+mP8rlPm64L3Fy///JOz9Ev+dWMzzzp/kNd+f3Cqwcb33FsHS
 A3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901183; x=1783505983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TpMN+VkpYKe5eeWv6ivWdJjbIBFCT/o2DjQCDwuTuVM=;
 b=HmSlrmosPRdB58zZ52NB3nQjQWfEnxfSFRyP8VGSp2y15CrSMAxiUoLPeiggXkxZeT
 gVONOeZxxyzQNGvBJonS6TYX3UoN85zjZKjj4+TPTw7Xf0KTr6RYUIMi9NBO0EN8DG55
 CrPNBtCiy40WwmOZ+kLIuxp4lod4b4ClrbhPaMkkIpIEE9dWJ5lMhmEVwkrddIS8ZnMM
 wXAbEgL7nWb4L6aaidlbtgftA8v7mRndeQPu1jYNSEcj4aIZsPk7OSUbrb7JVnyTs+GL
 xoP00s0+wWpuF8/tLJxRHCil7a/w7yVTrnDiRoegzMsB1RCDYvZOj8G4uQ6m3wAUzxLx
 WYyQ==
X-Gm-Message-State: AOJu0YwbxmROyS40kpKM/FHufuMkOTJLFS3NnZ71On44izYmnBWGvPNT
 AS8WdCA3f94gj36QvlHz2mDXA6wmJ4jBaQJZAn8Sw7CPgZhG19HteLuQyLIyAA==
X-Gm-Gg: AfdE7ckLj+61Go1bt+ld0txVbf6iVDxV3HMik7dUx9Jr91sLsBx6uH+Pav1a4fvFqZE
 Dn1EqFLeAyUomNw/ZSfKbh1X9TuwC/Fov414YH3IlnxqSzkjzVH5ECncKpWkvWtPpnHt4HzCnym
 yNhFnFgS5jrCvwWGJoJyxXHlNAUcLhvjTHgLo2/wfV1UlPwUUTnWJfJc6Qlp5GeRf0RnVgiRX9h
 w3xz7L/zLhj7O8AdCI3qzFpkEXcxrUjtnGFfgBE/fYUJd0DZQmWeLzyKSxMwOoWckIBpWSLMwzM
 7J4VF18gUVi45TD7Igm/L3zz8DEIp9Z0YuHoBR4OhAYVu8vviayskTY/e2yxMj44SRatIWDuMoY
 OVGZiLLHy1yBn9sgzOvcx/2nC9TW65RR8DG8dFokvfqsNrLpRVGhx93P9AiOp6yOjEObGGu25kV
 JLuW6bbnXWnxCPyJz5SGbI3rZEKp1/llI=
X-Received: by 2002:a05:7022:42:b0:139:f62c:9587 with SMTP id
 a92af1059eb24-13b39124eb8mr195672c88.22.1782901182682; 
 Wed, 01 Jul 2026 03:19:42 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:19:41 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Joel Stanley <joel@jms.id.au>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 30/39] hw/riscv/aia: Provide number of irq sources
Date: Wed,  1 Jul 2026 20:17:43 +1000
Message-ID: <20260701101752.2522962-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122a;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x122a.google.com
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

From: Joel Stanley <joel@jms.id.au>

Instead of hard coding the number of IRQ sources used by the APLIC pass
it in as a parameter. This allows other machines to configure this as
required.

The maximum number of sources is 1023.

Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260630024952.1520546-5-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/aia.h             |  3 +--
 include/hw/riscv/virt.h    |  1 +
 hw/riscv/aia.c             |  8 ++++++--
 hw/riscv/virt-acpi-build.c | 25 ++++++++++++++++---------
 hw/riscv/virt.c            |  2 ++
 5 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
index dbb8333402..5ad0a902be 100644
--- a/hw/riscv/aia.h
+++ b/hw/riscv/aia.h
@@ -11,11 +11,10 @@
 
 #include "exec/hwaddr.h"
 
-#define VIRT_IRQCHIP_NUM_SOURCES 96
-
 uint32_t imsic_num_bits(uint32_t count);
 
 DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+                             uint16_t num_sources,
                              const MemMapEntry *aplic_m,
                              const MemMapEntry *aplic_s,
                              const MemMapEntry *imsic_m,
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index ad858deb76..36a2def410 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -64,6 +64,7 @@ struct RISCVVirtState {
     struct GPEXHost *gpex_host;
     OnOffAuto iommu_sys;
     uint16_t pci_iommu_bdf;
+    uint16_t num_sources;
 };
 
 enum {
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index c724612a50..82ea9d48ea 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -25,6 +25,7 @@ uint32_t imsic_num_bits(uint32_t count)
 }
 
 DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+                             uint16_t num_sources,
                              const MemMapEntry *aplic_m,
                              const MemMapEntry *aplic_s,
                              const MemMapEntry *imsic_m,
@@ -38,6 +39,9 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
     DeviceState *aplic_s_dev = NULL;
     DeviceState *aplic_m_dev = NULL;
 
+    /* The RISC-V Advanced Interrupt Architecture, Chapter 1.2. Limits */
+    g_assert(num_sources <= 1023);
+
     if (msimode) {
         if (!kvm_enabled()) {
             /* Per-socket M-level IMSICs */
@@ -66,7 +70,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
                                      aplic_m->size,
                                      (msimode) ? 0 : base_hartid,
                                      (msimode) ? 0 : hart_count,
-                                     VIRT_IRQCHIP_NUM_SOURCES,
+                                     num_sources,
                                      num_prio_bits,
                                      msimode, true, NULL);
     }
@@ -77,7 +81,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
                                  aplic_s->size,
                                  (msimode) ? 0 : base_hartid,
                                  (msimode) ? 0 : hart_count,
-                                 VIRT_IRQCHIP_NUM_SOURCES,
+                                 num_sources,
                                  num_prio_bits,
                                  msimode, false, aplic_m_dev);
 
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 02ab460e58..59c454f4f9 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -148,6 +148,7 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
 }
 
 static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
+                                     uint16_t num_sources,
                                      uint64_t mmio_base, uint64_t mmio_size,
                                      const char *hid)
 {
@@ -155,9 +156,12 @@ static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
     uint32_t gsi_base;
     uint8_t  socket;
 
+    /* The RISC-V Advanced Interrupt Architecture, Chapter 1.2. Limits */
+    g_assert(num_sources <= 1023);
+
     for (socket = 0; socket < socket_count; socket++) {
         plic_aplic_addr = mmio_base + mmio_size * socket;
-        gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
+        gsi_base = num_sources * socket;
         Aml *dev = aml_device("IC%.02X", socket);
         aml_append(dev, aml_name_decl("_HID", aml_string("%s", hid)));
         aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
@@ -476,10 +480,13 @@ static void build_dsdt(GArray *table_data,
     socket_count = riscv_socket_count(ms);
 
     if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_PLIC].base,
-                                 memmap[VIRT_PLIC].size, "RSCV0001");
+        acpi_dsdt_add_plic_aplic(scope, socket_count, s->num_sources,
+                                 memmap[VIRT_PLIC].base,
+                                 memmap[VIRT_PLIC].size,
+                                 "RSCV0001");
     } else {
-        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_APLIC_S].base,
+        acpi_dsdt_add_plic_aplic(scope, socket_count, s->num_sources,
+                                 memmap[VIRT_APLIC_S].base,
                                  memmap[VIRT_APLIC_S].size, "RSCV0002");
     }
 
@@ -496,15 +503,15 @@ static void build_dsdt(GArray *table_data,
     } else if (socket_count == 2) {
         virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
                              memmap[VIRT_VIRTIO].size,
-                             VIRTIO_IRQ + VIRT_IRQCHIP_NUM_SOURCES, 0,
+                             VIRTIO_IRQ + s->num_sources, 0,
                              VIRTIO_COUNT);
-        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES);
+        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + s->num_sources);
     } else {
         virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
                              memmap[VIRT_VIRTIO].size,
-                             VIRTIO_IRQ + VIRT_IRQCHIP_NUM_SOURCES, 0,
+                             VIRTIO_IRQ + s->num_sources, 0,
                              VIRTIO_COUNT);
-        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES * 2);
+        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + s->num_sources * 2);
     }
 
     aml_append(dsdt, scope);
@@ -583,7 +590,7 @@ static void build_madt(GArray *table_data,
         for (socket = 0; socket < riscv_socket_count(ms); socket++) {
             aplic_addr = s->memmap[VIRT_APLIC_S].base +
                              s->memmap[VIRT_APLIC_S].size * socket;
-            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
+            gsi_base = s->num_sources * socket;
             build_append_int_noprefix(table_data, 0x1A, 1);    /* Type */
             build_append_int_noprefix(table_data, 36, 1);      /* Length */
             build_append_int_noprefix(table_data, 1, 1);       /* Version */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index b76bbb62f8..8f80c0607b 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1401,6 +1401,7 @@ static void virt_machine_init(MachineState *machine)
         } else {
             s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
                                              s->aia_guests,
+                                             s->num_sources,
                                              &s->memmap[VIRT_APLIC_M],
                                              &s->memmap[VIRT_APLIC_S],
                                              &s->memmap[VIRT_IMSIC_M],
@@ -1557,6 +1558,7 @@ static void virt_machine_instance_init(Object *obj)
     s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     s->acpi = ON_OFF_AUTO_AUTO;
     s->iommu_sys = ON_OFF_AUTO_AUTO;
+    s->num_sources = VIRT_IRQCHIP_NUM_SOURCES;
 }
 
 static char *virt_get_aia_guests(Object *obj, Error **errp)
-- 
2.54.0


