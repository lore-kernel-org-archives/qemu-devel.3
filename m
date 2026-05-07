Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889A6CD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 04:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKqWs-0000ZJ-M3; Thu, 07 May 2026 00:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKqWq-0000UV-Ml
 for qemu-devel@nongnu.org; Thu, 07 May 2026 00:40:04 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKqWo-0003tu-Jy
 for qemu-devel@nongnu.org; Thu, 07 May 2026 00:40:04 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ba0fc8b1f0so2605695ad.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 21:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778128801; x=1778733601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=13lu9MkgMDO/GCkyMxzJaolOgnQJRxha13QXdWrCjBw=;
 b=CXXcit8qUDgaAnyTvbut5ekvJCLCMK9mIjEQSAMmtKj1EiVFH5j2Lz1U9rg1eAwrmG
 6aYWcuhxUb6lCwY/dzfPeQeZiUuN0xPI4nW16XlAlRFQty2Kc00xQg1cie5QjMPpoamB
 Wn14/GnnIe52r/u8Kl6bj6ZKpZF1OAqJaspWoYyXkhgbpKnymASH4gOuNn05ikZrT1K/
 DclacsnOp8k1Ibh5SxPg0hAtdw/6ZI42xVaNBhkuNGPuvzrrgsrCwVxCof92vF9C0P2V
 0J6ZnmBuQe/fqiHHeDWKOBDgd2mRz02rTMXMKaBLa7poTfjtwy6xuctiaWfP0JHAqIxz
 5dDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778128801; x=1778733601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=13lu9MkgMDO/GCkyMxzJaolOgnQJRxha13QXdWrCjBw=;
 b=hjjGVtmpIrqpu35lP5nZDZY+N+3EV0PEwDjZSZAqdeREi3Rud/H+rWuc0/JymIHJzq
 eKauJd/3vQMS82v+cY+7oTEkGM/iwWjQSOnsIgozCes8CNLimnGVKIRP1nAkmW9c7lvX
 0Cvpyy0DbM0UcvuJ1G16Peubn7u0+JohXDzjXfZoqik0+ZTxJ+/XzsY6s2yzS/CULp2g
 b/H2YOkUq0KFl0THlAbFVzPCW4SuVUN6/Qa97OTFzjwvZ1Ll7MaBPGjc6Pa6ueoVuFRf
 oqVsUKwVNjVPFn6kWWX50x9W1VOcbij/sgKXNO4tcgr45by75zYL8XfvkvMhu3Jp3510
 OiFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Te4RHAv4jLPgC4NrEUoh9bK854KYZJNV2Wx7UHcYuJ2EheOUjzkFL9pegN3zBHj2esAihsY0otr5D@nongnu.org
X-Gm-Message-State: AOJu0YztEL/FcPh23FUZfVwGE9rIMH4B6AZZFCmfag7KV5z01vJGbEoL
 Bpj6QintTCIY3+mVXMKS8BOCQiov2eueQIJ6sUg9tmVetABQ/29Iq/Lw
X-Gm-Gg: AeBDieu6X37SRivTq21M62ylfQkHZ13hup5POg3ZglwzRxnCJXSFXmatwWFZrDW2D9c
 ASB8RBMBdsvfElBaYM0QS+jjYngOM60p58FUgP1+mJGOgI41xq08XkvlB5q7oLoZQVx/Fuax4oq
 Dmg39mmRraTctC8XOKn9/cedTpWxp8MkM2V+oKyxkHScpuU0uvTBBchBPo0BKAkXbOY0OGtTbtn
 AVI8fERNzV8L34YyFd2yqxOS61d29afyn8E59q1sL0l8HT4q4wOfIqXo0o5bTLGCzsRcfdxCPJu
 9Ml5KwhIKNJ+bm7dqBVgoycRva/KbsanUhR3EYr76fbpnjmI994odiBPQeviqbyQ6I8b+lA/yTN
 +VxdXaVTR7lGL54OoQ+OnaL2uhyheXPmZYZiH2toSkRh56E6G/lXVm40QLlaNwf6Wk2vkEt85s5
 gwmvDs0yFnxtXG76d10/pc89/CYV7a4HVv/GOibdhYRMv5zgrx4VJJSiAKrYaE1wLQb3eFhqQLJ
 kj7c21x
X-Received: by 2002:a17:903:1a2c:b0:2b4:6470:760d with SMTP id
 d9443c01a7336-2ba78f473a2mr71631285ad.14.1778128800909; 
 Wed, 06 May 2026 21:40:00 -0700 (PDT)
Received: from localhost (124.158.97.178.qld.leaptel.network. [124.158.97.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2babadef254sm9006215ad.61.2026.05.06.21.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 21:40:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Nutty Liu <nutty.liu@hotmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 4/9] hw/riscv/aia: Provide number of irq sources
Date: Thu,  7 May 2026 14:38:32 +1000
Message-ID: <20260507043838.45652-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507043838.45652-1-npiggin@gmail.com>
References: <20260507043838.45652-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/riscv/aia.c             |  8 ++++++--
 hw/riscv/aia.h             |  3 +--
 hw/riscv/virt-acpi-build.c | 25 ++++++++++++++++---------
 hw/riscv/virt.c            |  2 ++
 include/hw/riscv/virt.h    |  1 +
 5 files changed, 26 insertions(+), 13 deletions(-)

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
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 145f8d92ad..9ef3ef842a 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -146,6 +146,7 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
 }
 
 static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
+                                     uint16_t num_sources,
                                      uint64_t mmio_base, uint64_t mmio_size,
                                      const char *hid)
 {
@@ -153,9 +154,12 @@ static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
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
@@ -474,10 +478,13 @@ static void build_dsdt(GArray *table_data,
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
 
@@ -494,15 +501,15 @@ static void build_dsdt(GArray *table_data,
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
@@ -581,7 +588,7 @@ static void build_madt(GArray *table_data,
         for (socket = 0; socket < riscv_socket_count(ms); socket++) {
             aplic_addr = s->memmap[VIRT_APLIC_S].base +
                              s->memmap[VIRT_APLIC_S].size * socket;
-            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
+            gsi_base = s->num_sources * socket;
             build_append_int_noprefix(table_data, 0x1A, 1);    /* Type */
             build_append_int_noprefix(table_data, 36, 1);      /* Length */
             build_append_int_noprefix(table_data, 1, 1);       /* Version */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ce0fd6f50c..6c5bcd43dc 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1548,6 +1548,7 @@ static void virt_machine_init(MachineState *machine)
         } else {
             s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
                                              s->aia_guests,
+                                             s->num_sources,
                                              &s->memmap[VIRT_APLIC_M],
                                              &s->memmap[VIRT_APLIC_S],
                                              &s->memmap[VIRT_IMSIC_M],
@@ -1691,6 +1692,7 @@ static void virt_machine_instance_init(Object *obj)
     s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     s->acpi = ON_OFF_AUTO_AUTO;
     s->iommu_sys = ON_OFF_AUTO_AUTO;
+    s->num_sources = VIRT_IRQCHIP_NUM_SOURCES;
 }
 
 static char *virt_get_aia_guests(Object *obj, Error **errp)
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
-- 
2.53.0


