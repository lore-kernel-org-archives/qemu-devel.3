Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1359606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=aE65My7C;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=X4CSzK44
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWYw-0008TT-Nm; Sun, 01 Nov 2026 09:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWXF-0006c8-3O
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:52 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWXC-00083i-Fi
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=iH57Tfd
 8QFpDO2wz6pbnIgKrydTaPb6StBv8+Fb5g7WP0GX+BuX0VqxkkTWl0eq40t/1FB/el62G/
 77QY0TS296UnBOs+dhFm3FVaiah/8xfPQbnwonaZxx69mrfZzLCThebg1DmNeufBCRnQpw
 3sqlS9VE3kOkFH5LQUXIHCvUP3lVYgSC1gqSGVuWO+hVqBZoKwxwgjMQUywogO0jRMPKHH
 U8bVRKUgD2Ul/KMPBm/+xVJHo1cWVxUmW7eVYZ3tdlm+/2LlWkQiEpuoDCxrNGtkGdhUSZ
 vACm6J52qHv2CtIbJTxw5hrb878WG7EdZrJQeLxaBlM45UBDFmkqviA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=v
 Wc06SqrxaROOzRriTOs7HSznSYcdFjAEe1lgq/d4nE=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=yjzjezsLIzzSUt3wUwzwYDoAGBOH970GsZYrZfSnAJDwWBI3B0W0L54MgtnomnoImUeL
 2m2tfiIx7xKL55Nc9kiOyUcdacu45FGc1Wc42V15MgOncTRytKngyFeGpq/PVGlKbfKOtF
 e0DskhUUJ4Wh/p6tBO8NNrUdXyizxCyX06co2TkQcqVLwqBqHoyi2dGO5Xwk5Tdpvq1DGd
 aQQhEvMJsvkJ+gRDlK1H6CI0Nb9OuGr/Ncx5ZIHpdhqBSQotxLOpeXtiGET7j78MpGromo
 m4HRSotnky1TOvewCdEYKCyAMe6FOqLl5BFauvvQT/6iFX5vwCCpbait68kLshvA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=aE65My7C; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=X4CSzK44;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=vWc06Sqr
 xaROOzRriTOs7HSznSYcdFjAEe1lgq/d4nE=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=aE65My7Ci4MMFA0OUeGeRfMHBz3qT4vifKm
 QqYiPKnSWO08nacOk2HdWg9mN4gmMsrRKwSlw3CM22lDZyXyB3VAAEaK7/1eZ3eNWSq6MX
 s2SGmDcxDZrnDEvvqy1aDKzROJ1G1weaQZi8B+gMqqCPXEAFygK7eU4jkMPG1GvmrIeQK0
 bQuS4K/v3o9GJQ4MVrm9qjYJ5MCuHeKXCvnqXJH/5FNkgw47JA6qMY77kI+suJx2wS6zfX
 w/5PohgUr39M2KJ+WYCIJWlzzVDWbBBltigYB52QIs15rAjn866Sto3Q2b56fCMh2lC6SO
 LQdcA//ayU5iXtvq8tm/VOxJ8EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=vWc06SqrxaROOzRriTOs7HSznSYcdFjAEe1lgq/d4nE=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=X4CSzK44S6xFFUUL85
 I93wwqaN01Ai9V9IyWm6JQ7yzNLbWrnQSaidXtA7GkvNZjS9W4ACcFzVNkKMW2xnSzAQ==
Received: by mx1.catap.net (OpenSMTPD) id ac7b8a70;
 Sun, 1 Nov 2026 15:27:38 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 750fb9ef;
 Sun, 1 Nov 2026 15:27:31 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v6 17/26] hw/mips: add Octeon MIO boot support
Date: Sun,  1 Nov 2026 15:23:33 +0100
Message-ID: <20261101142723.41346-18-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101142723.41346-1-kirill@korins.ky>
References: <20261101142723.41346-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add MIO boot bus configuration, boot location storage and fuse
responses. Keep mutable state and memory mappings in a resettable MIO
device.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/mips/octeon.c          | 248 +++++++++++++++++++++++++++++++++++++-
 hw/mips/octeon_internal.h |   4 +
 2 files changed, 250 insertions(+), 2 deletions(-)

diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
index 007fc4b537..59754cb741 100644
--- a/hw/mips/octeon.c
+++ b/hw/mips/octeon.c
@@ -39,6 +39,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonMachineState, OCTEON_MACHINE)
 OBJECT_DECLARE_TYPE(OcteonPeripheralState, OcteonPeripheralClass,
                     OCTEON_PERIPHERAL)
 
+#define TYPE_OCTEON_MIO "octeon-mio"
+OBJECT_DECLARE_SIMPLE_TYPE(OcteonMioState, OCTEON_MIO)
 #define TYPE_OCTEON_RST "octeon-rst"
 OBJECT_DECLARE_SIMPLE_TYPE(OcteonRstState, OCTEON_RST)
 #define TYPE_OCTEON_INTC "octeon-intc"
@@ -126,12 +128,33 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonCsrBankState, OCTEON_CSR_BANK)
 #define OCTEON_CIU3_UART0_INTSN     0x8000
 #define OCTEON_CSR_BASE             0x1180000000000ULL
 #define OCTEON_CSR_SIZE             0x100000000ULL
+#define OCTEON_MIO_BOOT_REG_CFGX(x) \
+    (0x0000000 + (x) * OCTEON_CSR_64BIT_SIZE)
+#define OCTEON_MIO_BOOT_REG_CFG_INDEX(reg) \
+    ((reg) / OCTEON_CSR_64BIT_SIZE)
+#define OCTEON_MIO_BOOT_REG_CFG_BASE 0x000000000000ffffULL
+#define OCTEON_MIO_BOOT_LOC_CFGX(x) \
+    (0x0000080 + ((x) & 1) * OCTEON_CSR_64BIT_SIZE)
+#define OCTEON_MIO_BOOT_LOC_CFG_INDEX(reg) \
+    (((reg) - OCTEON_MIO_BOOT_LOC_CFGX(0)) / OCTEON_CSR_64BIT_SIZE)
+#define OCTEON_MIO_BOOT_LOC_ADR     0x0000090
+#define OCTEON_MIO_BOOT_LOC_DAT     0x0000098
+#define OCTEON_MIO_BOOT_LOC_CFG_BASE 0x000000000ffffff8ULL
+#define OCTEON_MIO_BOOT_LOC_CFG_BASE_SHIFT 3
+#define OCTEON_MIO_BOOT_LOC_CFG_EN  0x0000000080000000ULL
+#define OCTEON_MIO_BOOT_LOC_ADR_MASK 0xf8
+/* Fuses are left unprogrammed; firmware only needs reads to complete. */
+#define OCTEON_MIO_FUS_DAT2         0x0001410
+#define OCTEON_MIO_FUS_RCMD         0x0001500
+#define OCTEON_MIO_FUS_RCMD_PEND    0x0000000000001000ULL
+#define OCTEON_MIO_FUS_RCMD_DAT     0x0000000000ff0000ULL
 #define OCTEON_RST_BOOT             0x6001600
 #define OCTEON_RST_SOFT_RST         0x6001680
 /* U-Boot uses the reset controller to park and release secondary cores. */
 #define OCTEON_RST_PP_POWER         0x6001700
 #define OCTEON_RST_BOOT_C_MUL_SHIFT 30
 #define OCTEON_RST_BOOT_PNR_MUL_SHIFT 24
+
 /*
  * QEMU-only backing for per-core CVMSEG. Keep it outside guest DRAM;
  * the guest sees the virtual CVMSEG window, not this physical address.
@@ -153,6 +176,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonCsrBankState, OCTEON_CSR_BANK)
 #define OCTEON_FLASH_ENV_OFFSET     \
     (OCTEON_FLASH_SIZE - OCTEON_FLASH_ENV_SECTOR_SIZE)
 #define OCTEON_FLASH_WIDTH          2
+#define OCTEON_MIO_BOOT_REG_CFG_RESET_BASE (OCTEON_FLASH_RESET_BASE >> 16)
+#define OCTEON_BOOTBUS_LED_CS       4
+#define OCTEON_BOOTBUS_LED_SIZE     (64 * KiB)
 
 struct OcteonMachineState {
     MachineState parent_obj;
@@ -174,6 +200,21 @@ struct OcteonPeripheralClass {
     ResettablePhases parent_phases;
 };
 
+struct OcteonMioState {
+    OcteonPeripheralState parent_obj;
+    MemoryRegion bootbus_led;
+    MemoryRegion mio_boot_loc;
+    uint64_t mio_boot_reg_cfg[OCTEON_MIO_BOOT_REG_CFG_COUNT];
+    uint64_t mio_boot_loc_cfg[2];
+    uint64_t mio_boot_loc_adr;
+    uint64_t mio_fus_rcmd;
+    hwaddr mio_boot_loc_base;
+    uint8_t mio_boot_loc_data[OCTEON_MIO_BOOT_LOC_SIZE];
+    bool mio_boot_loc_mapped;
+    hwaddr bootbus_led_base;
+    bool bootbus_led_mapped;
+};
+
 struct OcteonRstState {
     OcteonPeripheralState parent_obj;
     GHashTable *regs;
@@ -318,6 +359,89 @@ static void octeon_csr_store(OcteonState *s, uint64_t reg, uint64_t value)
     octeon_reg_store(s->csr_bank->values, reg, value);
 }
 
+static hwaddr octeon_mio_boot_loc_base(uint64_t cfg)
+{
+    uint64_t base = (cfg & OCTEON_MIO_BOOT_LOC_CFG_BASE) >>
+                    OCTEON_MIO_BOOT_LOC_CFG_BASE_SHIFT;
+
+    return base << 7;
+}
+
+static void octeon_mio_boot_loc_update(OcteonState *s)
+{
+    MemoryRegion *sysmem = get_system_memory();
+    bool enabled = s->mio->mio_boot_loc_cfg[0] & OCTEON_MIO_BOOT_LOC_CFG_EN;
+    hwaddr base = octeon_mio_boot_loc_base(s->mio->mio_boot_loc_cfg[0]);
+
+    if (s->mio->mio_boot_loc_mapped) {
+        if (enabled && base == s->mio->mio_boot_loc_base) {
+            return;
+        }
+        memory_region_del_subregion(sysmem, &s->mio->mio_boot_loc);
+        s->mio->mio_boot_loc_mapped = false;
+    }
+
+    if (enabled) {
+        memory_region_add_subregion_overlap(sysmem, base,
+                                            &s->mio->mio_boot_loc, 1);
+        s->mio->mio_boot_loc_base = base;
+        s->mio->mio_boot_loc_mapped = true;
+    }
+}
+
+static hwaddr octeon_mio_boot_reg_cfg_base(uint64_t cfg)
+{
+    return (cfg & OCTEON_MIO_BOOT_REG_CFG_BASE) << 16;
+}
+
+static void octeon_bootbus_led_update(OcteonState *s)
+{
+    MemoryRegion *sysmem = get_system_memory();
+    hwaddr base = octeon_mio_boot_reg_cfg_base(
+        s->mio->mio_boot_reg_cfg[OCTEON_BOOTBUS_LED_CS]);
+
+    if (s->mio->bootbus_led_mapped) {
+        if (base == s->mio->bootbus_led_base) {
+            return;
+        }
+        memory_region_del_subregion(sysmem, &s->mio->bootbus_led);
+        s->mio->bootbus_led_mapped = false;
+    }
+
+    if (base) {
+        memory_region_add_subregion(sysmem, base, &s->mio->bootbus_led);
+        s->mio->bootbus_led_base = base;
+        s->mio->bootbus_led_mapped = true;
+    }
+}
+
+static uint64_t octeon_mio_boot_loc_dat_read(OcteonState *s)
+{
+    unsigned int offset = s->mio->mio_boot_loc_adr &
+                          OCTEON_MIO_BOOT_LOC_ADR_MASK;
+    uint64_t value = ldq_be_p(s->mio->mio_boot_loc_data + offset);
+
+    s->mio->mio_boot_loc_adr =
+        (s->mio->mio_boot_loc_adr + OCTEON_CSR_64BIT_SIZE) &
+        OCTEON_MIO_BOOT_LOC_ADR_MASK;
+    return value;
+}
+
+static void octeon_mio_boot_loc_dat_write(OcteonState *s, hwaddr addr,
+                                          uint64_t value, unsigned size)
+{
+    unsigned int offset = s->mio->mio_boot_loc_adr &
+                          OCTEON_MIO_BOOT_LOC_ADR_MASK;
+    uint64_t old = ldq_be_p(s->mio->mio_boot_loc_data + offset);
+
+    value = octeon_write64(old, addr, value, size);
+    stq_be_p(s->mio->mio_boot_loc_data + offset, value);
+    memory_region_set_dirty(&s->mio->mio_boot_loc, offset, sizeof(value));
+    s->mio->mio_boot_loc_adr =
+        (s->mio->mio_boot_loc_adr + OCTEON_CSR_64BIT_SIZE) &
+        OCTEON_MIO_BOOT_LOC_ADR_MASK;
+}
+
 static bool octeon_ciu3_source_from_intsn(uint32_t intsn,
                                           unsigned int *source)
 {
@@ -1125,7 +1249,28 @@ static uint64_t octeon_csr_read(void *opaque, hwaddr addr, unsigned size)
     hwaddr reg = addr & ~7ULL;
     uint64_t value;
 
+    if (reg >= OCTEON_MIO_BOOT_REG_CFGX(0) &&
+        reg < OCTEON_MIO_BOOT_REG_CFGX(OCTEON_MIO_BOOT_REG_CFG_COUNT)) {
+        unsigned int index = OCTEON_MIO_BOOT_REG_CFG_INDEX(reg);
+
+        return octeon_read64(s->mio->mio_boot_reg_cfg[index], addr, size);
+    }
+
     switch (reg) {
+    case OCTEON_MIO_BOOT_LOC_CFGX(0):
+    case OCTEON_MIO_BOOT_LOC_CFGX(1): {
+        unsigned int index = OCTEON_MIO_BOOT_LOC_CFG_INDEX(reg);
+
+        return octeon_read64(s->mio->mio_boot_loc_cfg[index], addr, size);
+    }
+    case OCTEON_MIO_BOOT_LOC_ADR:
+        return octeon_read64(s->mio->mio_boot_loc_adr, addr, size);
+    case OCTEON_MIO_BOOT_LOC_DAT:
+        return octeon_read64(octeon_mio_boot_loc_dat_read(s), addr, size);
+    case OCTEON_MIO_FUS_DAT2:
+        return 0;
+    case OCTEON_MIO_FUS_RCMD:
+        return octeon_read64(s->mio->mio_fus_rcmd, addr, size);
     case OCTEON_RST_BOOT:
         value = ((uint64_t)(s->cpu_hz / s->ref_hz) <<
                  OCTEON_RST_BOOT_C_MUL_SHIFT) |
@@ -1156,11 +1301,56 @@ static void octeon_csr_write(void *opaque, hwaddr addr,
         return;
     }
 
+    if (reg == OCTEON_MIO_BOOT_LOC_CFGX(0) ||
+        reg == OCTEON_MIO_BOOT_LOC_CFGX(1)) {
+        unsigned int index = OCTEON_MIO_BOOT_LOC_CFG_INDEX(reg);
+
+        old = s->mio->mio_boot_loc_cfg[index];
+        s->mio->mio_boot_loc_cfg[index] =
+            octeon_write64(old, addr, value, size);
+        if (index == 0) {
+            octeon_mio_boot_loc_update(s);
+        }
+        return;
+    }
+
+    if (reg == OCTEON_MIO_BOOT_LOC_ADR) {
+        old = s->mio->mio_boot_loc_adr;
+        value = octeon_write64(old, addr, value, size);
+        s->mio->mio_boot_loc_adr = value & OCTEON_MIO_BOOT_LOC_ADR_MASK;
+        return;
+    }
+
+    if (reg == OCTEON_MIO_BOOT_LOC_DAT) {
+        octeon_mio_boot_loc_dat_write(s, addr, value, size);
+        return;
+    }
+
+    if (reg == OCTEON_MIO_FUS_RCMD) {
+        value = octeon_write64(s->mio->mio_fus_rcmd, addr, value, size);
+        s->mio->mio_fus_rcmd = value & ~(OCTEON_MIO_FUS_RCMD_PEND |
+                                    OCTEON_MIO_FUS_RCMD_DAT);
+        return;
+    }
+
     if (reg == OCTEON_RST_PP_POWER) {
         octeon_rst_pp_power_write(s, addr, value, size);
         return;
     }
 
+    if (reg >= OCTEON_MIO_BOOT_REG_CFGX(0) &&
+        reg < OCTEON_MIO_BOOT_REG_CFGX(OCTEON_MIO_BOOT_REG_CFG_COUNT)) {
+        unsigned int index = OCTEON_MIO_BOOT_REG_CFG_INDEX(reg);
+
+        old = s->mio->mio_boot_reg_cfg[index];
+        s->mio->mio_boot_reg_cfg[index] =
+            octeon_write64(old, addr, value, size);
+        if (index == OCTEON_BOOTBUS_LED_CS) {
+            octeon_bootbus_led_update(s);
+        }
+        return;
+    }
+
     if (!octeon_csr_lookup(s, reg, &old)) {
         old = 0;
     }
@@ -1411,6 +1601,42 @@ static void octeon_init_flash(OcteonState *s)
                                 &s->boot_flash_alias);
 }
 
+static void octeon_init_mio_boot_loc(OcteonState *s)
+{
+    memory_region_init_ram(&s->mio->bootbus_led, OBJECT(s->mio),
+                           "octeon.bootbus-led",
+                           OCTEON_BOOTBUS_LED_SIZE, &error_fatal);
+    memory_region_init_ram_ptr(&s->mio->mio_boot_loc, OBJECT(s->mio),
+                               "octeon.mio-boot-loc",
+                               OCTEON_MIO_BOOT_LOC_SIZE,
+                               s->mio->mio_boot_loc_data);
+}
+
+
+static void octeon_mio_reset_hold(Object *obj, ResetType type)
+{
+    OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_GET_CLASS(obj);
+    OcteonMioState *mio = OCTEON_MIO(obj);
+    OcteonState *s = mio->parent_obj.board;
+
+    if (opc->parent_phases.hold) {
+        opc->parent_phases.hold(obj, type);
+    }
+
+    if (mio->bootbus_led_mapped) {
+        memory_region_del_subregion(get_system_memory(), &mio->bootbus_led);
+        mio->bootbus_led_mapped = false;
+    }
+    memset(mio->mio_boot_reg_cfg, 0, sizeof(mio->mio_boot_reg_cfg));
+    mio->mio_boot_reg_cfg[0] = OCTEON_MIO_BOOT_REG_CFG_RESET_BASE;
+    mio->mio_boot_loc_cfg[0] = 0;
+    mio->mio_boot_loc_cfg[1] = 0;
+    mio->mio_boot_loc_adr = 0;
+    mio->mio_fus_rcmd = 0;
+    memset(mio->mio_boot_loc_data, 0, sizeof(mio->mio_boot_loc_data));
+    octeon_mio_boot_loc_update(s);
+}
+
 static void octeon_rst_reset_hold(Object *obj, ResetType type)
 {
     OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_GET_CLASS(obj);
@@ -1498,6 +1724,15 @@ static void octeon_csr_bank_finalize(Object *obj)
     g_hash_table_destroy(OCTEON_CSR_BANK(obj)->values);
 }
 
+static void octeon_mio_class_init(ObjectClass *klass, const void *data)
+{
+    OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    resettable_class_set_parent_phases(rc, NULL, octeon_mio_reset_hold,
+                                       NULL, &opc->parent_phases);
+}
+
 static void octeon_rst_class_init(ObjectClass *klass, const void *data)
 {
     OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_CLASS(klass);
@@ -1540,10 +1775,11 @@ static OcteonPeripheralState *octeon_new_peripheral(OcteonState *s,
 
 static void octeon_create_peripherals(OcteonState *s)
 {
+    s->mio = OCTEON_MIO(octeon_new_peripheral(s, TYPE_OCTEON_MIO, 0));
     s->rst = OCTEON_RST(octeon_new_peripheral(s, TYPE_OCTEON_RST, 0));
     s->intc = OCTEON_INTC(octeon_new_peripheral(s, TYPE_OCTEON_INTC, 0));
     s->csr_bank = OCTEON_CSR_BANK(octeon_new_peripheral(
-        s, TYPE_OCTEON_CSR_BANK, 0));
+                                      s, TYPE_OCTEON_CSR_BANK, 0));
 }
 
 static void octeon_realize_peripheral(OcteonPeripheralState *dev)
@@ -1553,9 +1789,10 @@ static void octeon_realize_peripheral(OcteonPeripheralState *dev)
 
 static void octeon_realize_peripherals(OcteonState *s)
 {
+    octeon_realize_peripheral(&s->csr_bank->parent_obj);
     octeon_realize_peripheral(&s->intc->parent_obj);
     octeon_realize_peripheral(&s->rst->parent_obj);
-    octeon_realize_peripheral(&s->csr_bank->parent_obj);
+    octeon_realize_peripheral(&s->mio->parent_obj);
 }
 
 static void mips_octeon_init(MachineState *machine)
@@ -1581,6 +1818,7 @@ static void mips_octeon_init(MachineState *machine)
 
     octeon_map_ram(s);
     octeon_init_flash(s);
+    octeon_init_mio_boot_loc(s);
     octeon_load_firmware(s);
     octeon_create_cpus(s);
 
@@ -1667,6 +1905,12 @@ static const TypeInfo octeon_machine_types[] = {
         .class_init = octeon_peripheral_class_init,
         .abstract = true,
     },
+    {
+        .name = TYPE_OCTEON_MIO,
+        .parent = TYPE_OCTEON_PERIPHERAL,
+        .instance_size = sizeof(OcteonMioState),
+        .class_init = octeon_mio_class_init,
+    },
     {
         .name = TYPE_OCTEON_RST,
         .parent = TYPE_OCTEON_PERIPHERAL,
diff --git a/hw/mips/octeon_internal.h b/hw/mips/octeon_internal.h
index 6327103f52..7b45daba10 100644
--- a/hw/mips/octeon_internal.h
+++ b/hw/mips/octeon_internal.h
@@ -17,6 +17,8 @@
 #define OCTEON_CIU_GPIO_COUNT       32
 #define OCTEON_CIU3_CP0_IRQ_COUNT   4
 #define OCTEON_CIU3_IDT_COUNT       (OCTEON_MAX_CPUS * 4)
+#define OCTEON_MIO_BOOT_REG_CFG_COUNT 8
+#define OCTEON_MIO_BOOT_LOC_SIZE    0x100
 
 typedef enum OcteonIRQ {
     OCTEON_IRQ_UART,
@@ -30,6 +32,7 @@ typedef enum OcteonCiu3Source {
 } OcteonCiu3Source;
 
 typedef struct OcteonState OcteonState;
+typedef struct OcteonMioState OcteonMioState;
 typedef struct OcteonRstState OcteonRstState;
 typedef struct OcteonIntcState OcteonIntcState;
 typedef struct OcteonCsrBankState OcteonCsrBankState;
@@ -57,6 +60,7 @@ struct OcteonState {
     MemoryRegion boot_flash;
     MemoryRegion boot_flash_alias;
     MemoryRegion cvmseg;
+    OcteonMioState *mio;
     OcteonRstState *rst;
     OcteonIntcState *intc;
     OcteonCsrBankState *csr_bank;
-- 
2.56.0


