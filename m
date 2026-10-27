Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0780260A260C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=cZIdAhLL;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=hLJsg2EZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLeiU-0000J1-52; Tue, 27 Oct 2026 06:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLeg7-0005QE-Jo
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:45:22 -0400
Received: from mx2.catap.net ([2a01:4f9:3b:5410::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLeg4-0007zM-Vi
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:45:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=VB/gjuh
 O8/v00Ny8yXJ1imBM4wJTSc0v+e9c/h2f9p8XhozJo+PA44Hdcm+M9/lVHCsy97/svYoq2
 igIFVGfrJiKC81CydV3GDtieYVCXy8yIRYjpIEy8R3Zzz6sc3PqMZ/xFPf2HY7WWeIDHI9
 V1jsHHYMZUs7A6D8AjS+bGZgWHa0nlTzQA5OxVunrArOkZ5fncLm6V8Y23VSewUUnQiz0m
 VCeh1a7bMJHrY5LLbwDeS//N90rxNRXSSCDnbUrrcZkmDIPvlXQBvGQw8Ot9G6bPjxNmYk
 s/hTG59BdrT3U7JIshoBTy7ClCW8mMDQzcn66rjmIxzaxxdymWJZBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=a
 4XQwlbIaHGMlnLjkFxXpYCE6t9GppwSSynic7+S/aw=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=MHAceAzsRMt0tbiXID7xpLDOIMpSJeGvaE090TAutbcVpnD1ZRFphR2DBTx2/vjtJyQX
 hhHKth+ggOZAy6LyBvZMuRQ4eEGwqGJ6GPRqqpOH2hRjKTykcQUv1iFS3As7gV+8fzLqBj
 fT2BGLR75E/ZtqtckNFb4a6zufRYeOyeuTLP1U3pXbsg1HBsn1J12QxdkKRDjaZgi85O0Y
 xLSMz79++amsAsR2GNPdei0JRNT20IVvgMd4ZnukMmbiILOL9uzqsco6tovRZmTI9nO1Rv
 62Q9gdVqG48XqopIcpIg8aCae70xduPOICEQ+tXSfwooVpQ/op6eqFHavE2ojLaA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=cZIdAhLL; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=hLJsg2EZ;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=a4XQwlbI
 aHGMlnLjkFxXpYCE6t9GppwSSynic7+S/aw=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=cZIdAhLLUyKQS+uM+q+tVyP3ZLEspth+dI3
 BFt45Pp0AktE7E/Sc0fAZp7dHOVFX2JJmFtP/D5CM/wF0PasDz5XdejxV+UofSj6Q4nk16
 bvEA4x+oDeCijbooM17cj8xnfU0/gzAE8IF6L8TXOqq0VWKagbiTWE5TaAUNEeHb5uLotM
 d49FBV7uDk4BPNsTWx0yQyYGb6elBKbs9JpaprwOlS9CT4a5IPr0qBQy28pyFLaBLMLYM2
 Va9Rr4fmPaWGeXILYfGainRE3vpgh5BEhhyij21EZMt+wYX4Tf7aLMBGgNRG1D8L4kv+My
 cCJB3x3p2SZpZAg9SIaMZylk/Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=a4XQwlbIaHGMlnLjkFxXpYCE6t9GppwSSynic7+S/aw=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=hLJsg2EZ5BkzhjU7Gc
 v1QG04Rbz44U0SRXjY+p7JpeP4ilkkHVt0r5wo4pHvEHfY2KDKotcdNOknPQLyRGaIAg==
Received: by mx2.catap.net (OpenSMTPD) id 6cb27173;
 Tue, 27 Oct 2026 11:45:00 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 31c9fa3f;
 Tue, 27 Oct 2026 11:44:52 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v4 14/25] hw/mips: add Octeon CSR window
Date: Tue, 27 Oct 2026 11:41:38 +0100
Message-ID: <20261027104433.25720-15-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027104433.25720-1-kirill@korins.ky>
References: <20261027104433.25720-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f9:3b:5410::2;
 envelope-from=kirill@korins.ky; helo=mx2.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the shared CSR window and backing register storage. Keep mutable
state in a resettable CSR bank device so later controllers can route
their registers through it.
---
 hw/mips/octeon.c          | 146 ++++++++++++++++++++++++++++++++++++++
 hw/mips/octeon_internal.h |   7 ++
 2 files changed, 153 insertions(+)

diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
index 638d96559f..0caf088adf 100644
--- a/hw/mips/octeon.c
+++ b/hw/mips/octeon.c
@@ -41,6 +41,8 @@ OBJECT_DECLARE_TYPE(OcteonPeripheralState, OcteonPeripheralClass,
 OBJECT_DECLARE_SIMPLE_TYPE(OcteonRstState, OCTEON_RST)
 #define TYPE_OCTEON_INTC "octeon-intc"
 OBJECT_DECLARE_SIMPLE_TYPE(OcteonIntcState, OCTEON_INTC)
+#define TYPE_OCTEON_CSR_BANK "octeon-csr-bank"
+OBJECT_DECLARE_SIMPLE_TYPE(OcteonCsrBankState, OCTEON_CSR_BANK)
 
 #define OCTEON_CSR_64BIT_SIZE       8
 
@@ -120,6 +122,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonIntcState, OCTEON_INTC)
 #define OCTEON_CIU3_ISC_SIZE        (OCTEON_CIU3_NINTSN * 8)
 #define OCTEON_CIU3_MBOX_INTSN(cpu) ((cpu) + 0x4000U)
 #define OCTEON_CIU3_UART0_INTSN     0x8000
+#define OCTEON_CSR_BASE             0x1180000000000ULL
+#define OCTEON_CSR_SIZE             0x100000000ULL
 /*
  * QEMU-only backing for per-core CVMSEG. Keep it outside guest DRAM;
  * the guest sees the virtual CVMSEG window, not this physical address.
@@ -187,6 +191,24 @@ struct OcteonIntcState {
     uint8_t ciu3_irq_line[OCTEON_MAX_CPUS][OCTEON_CIU3_CP0_IRQ_COUNT];
 };
 
+struct OcteonCsrBankState {
+    OcteonPeripheralState parent_obj;
+    MemoryRegion csr;
+    GHashTable *values;
+};
+
+guint octeon_uint64_hash(gconstpointer v)
+{
+    uint64_t value = *(const uint64_t *)v;
+
+    return value ^ (value >> 32);
+}
+
+gboolean octeon_uint64_equal(gconstpointer a, gconstpointer b)
+{
+    return *(const uint64_t *)a == *(const uint64_t *)b;
+}
+
 uint64_t octeon_read64(uint64_t value, hwaddr addr, unsigned size)
 {
     if (size == 4) {
@@ -248,6 +270,38 @@ static void octeon_validate_clocks(OcteonMachineState *oms)
     }
 }
 
+bool octeon_reg_lookup(GHashTable *regs, uint64_t reg, uint64_t *value)
+{
+    uint64_t *stored = g_hash_table_lookup(regs, &reg);
+
+    if (!stored) {
+        return false;
+    }
+
+    *value = *stored;
+    return true;
+}
+
+void octeon_reg_store(GHashTable *regs, uint64_t reg, uint64_t value)
+{
+    uint64_t *key = g_new(uint64_t, 1);
+    uint64_t *stored = g_new(uint64_t, 1);
+
+    *key = reg;
+    *stored = value;
+    g_hash_table_replace(regs, key, stored);
+}
+
+bool octeon_csr_lookup(OcteonState *s, uint64_t reg, uint64_t *value)
+{
+    return octeon_reg_lookup(s->csr_bank->values, reg, value);
+}
+
+static void octeon_csr_store(OcteonState *s, uint64_t reg, uint64_t value)
+{
+    octeon_reg_store(s->csr_bank->values, reg, value);
+}
+
 static bool octeon_ciu3_source_from_intsn(uint32_t intsn,
                                           unsigned int *source)
 {
@@ -1022,6 +1076,42 @@ static const MemoryRegionOps octeon_ciu3_ops = {
     },
 };
 
+static uint64_t octeon_csr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    OcteonState *s = opaque;
+    hwaddr reg = addr & ~7ULL;
+    uint64_t value;
+
+    if (!octeon_csr_lookup(s, reg, &value)) {
+        value = 0;
+    }
+    return octeon_read64(value, addr, size);
+}
+
+static void octeon_csr_write(void *opaque, hwaddr addr,
+                             uint64_t value, unsigned size)
+{
+    OcteonState *s = opaque;
+    hwaddr reg = addr & ~7ULL;
+    uint64_t old;
+
+    if (!octeon_csr_lookup(s, reg, &old)) {
+        old = 0;
+    }
+    value = octeon_write64(old, addr, value, size);
+    octeon_csr_store(s, reg, value);
+}
+
+static const MemoryRegionOps octeon_csr_ops = {
+    .read = octeon_csr_read,
+    .write = octeon_csr_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
 void octeon_irq_set(void *opaque, int irq, int level)
 {
     OcteonState *s = opaque;
@@ -1294,6 +1384,18 @@ static void octeon_intc_reset_hold(Object *obj, ResetType type)
     octeon_intc_update_all_cpus(s);
 }
 
+static void octeon_csr_bank_reset_hold(Object *obj, ResetType type)
+{
+    OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_GET_CLASS(obj);
+    OcteonCsrBankState *bank = OCTEON_CSR_BANK(obj);
+
+    if (opc->parent_phases.hold) {
+        opc->parent_phases.hold(obj, type);
+    }
+
+    g_hash_table_remove_all(bank->values);
+}
+
 static void octeon_peripheral_class_init(ObjectClass *klass,
                                           const void *data)
 {
@@ -1302,6 +1404,23 @@ static void octeon_peripheral_class_init(ObjectClass *klass,
     dc->user_creatable = false;
 }
 
+static GHashTable *octeon_reg_table_new(void)
+{
+    return g_hash_table_new_full(octeon_uint64_hash,
+                                 octeon_uint64_equal,
+                                 g_free, g_free);
+}
+
+static void octeon_csr_bank_init(Object *obj)
+{
+    OCTEON_CSR_BANK(obj)->values = octeon_reg_table_new();
+}
+
+static void octeon_csr_bank_finalize(Object *obj)
+{
+    g_hash_table_destroy(OCTEON_CSR_BANK(obj)->values);
+}
+
 static void octeon_rst_class_init(ObjectClass *klass, const void *data)
 {
     OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_CLASS(klass);
@@ -1320,6 +1439,16 @@ static void octeon_intc_class_init(ObjectClass *klass, const void *data)
                                        NULL, &opc->parent_phases);
 }
 
+static void octeon_csr_bank_class_init(ObjectClass *klass, const void *data)
+{
+    OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    resettable_class_set_parent_phases(rc, NULL,
+                                       octeon_csr_bank_reset_hold, NULL,
+                                       &opc->parent_phases);
+}
+
 static OcteonPeripheralState *octeon_new_peripheral(OcteonState *s,
                                                      const char *type,
                                                      unsigned int index)
@@ -1336,6 +1465,8 @@ static void octeon_create_peripherals(OcteonState *s)
 {
     s->rst = OCTEON_RST(octeon_new_peripheral(s, TYPE_OCTEON_RST, 0));
     s->intc = OCTEON_INTC(octeon_new_peripheral(s, TYPE_OCTEON_INTC, 0));
+    s->csr_bank = OCTEON_CSR_BANK(octeon_new_peripheral(
+        s, TYPE_OCTEON_CSR_BANK, 0));
 }
 
 static void octeon_realize_peripheral(OcteonPeripheralState *dev)
@@ -1347,6 +1478,7 @@ static void octeon_realize_peripherals(OcteonState *s)
 {
     octeon_realize_peripheral(&s->intc->parent_obj);
     octeon_realize_peripheral(&s->rst->parent_obj);
+    octeon_realize_peripheral(&s->csr_bank->parent_obj);
 }
 
 static void mips_octeon_init(MachineState *machine)
@@ -1386,6 +1518,12 @@ static void mips_octeon_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), OCTEON_CIU3_BASE,
                                 &s->intc->ciu3);
 
+    memory_region_init_io(&s->csr_bank->csr, OBJECT(s->csr_bank),
+                          &octeon_csr_ops, s,
+                          "octeon.csr", OCTEON_CSR_SIZE);
+    memory_region_add_subregion_overlap(get_system_memory(), OCTEON_CSR_BASE,
+                                        &s->csr_bank->csr, -1);
+
     octeon_realize_peripherals(s);
 }
 
@@ -1464,6 +1602,14 @@ static const TypeInfo octeon_machine_types[] = {
         .instance_size = sizeof(OcteonIntcState),
         .class_init = octeon_intc_class_init,
     },
+    {
+        .name = TYPE_OCTEON_CSR_BANK,
+        .parent = TYPE_OCTEON_PERIPHERAL,
+        .instance_size = sizeof(OcteonCsrBankState),
+        .instance_init = octeon_csr_bank_init,
+        .instance_finalize = octeon_csr_bank_finalize,
+        .class_init = octeon_csr_bank_class_init,
+    },
     {
         .name = TYPE_OCTEON_MACHINE,
         .parent = TYPE_MACHINE,
diff --git a/hw/mips/octeon_internal.h b/hw/mips/octeon_internal.h
index cd810f3dd5..6327103f52 100644
--- a/hw/mips/octeon_internal.h
+++ b/hw/mips/octeon_internal.h
@@ -32,6 +32,7 @@ typedef enum OcteonCiu3Source {
 typedef struct OcteonState OcteonState;
 typedef struct OcteonRstState OcteonRstState;
 typedef struct OcteonIntcState OcteonIntcState;
+typedef struct OcteonCsrBankState OcteonCsrBankState;
 
 typedef struct OcteonCPUState {
     OcteonState *board;
@@ -58,11 +59,17 @@ struct OcteonState {
     MemoryRegion cvmseg;
     OcteonRstState *rst;
     OcteonIntcState *intc;
+    OcteonCsrBankState *csr_bank;
 };
 
+guint octeon_uint64_hash(gconstpointer v);
+gboolean octeon_uint64_equal(gconstpointer a, gconstpointer b);
 uint64_t octeon_read64(uint64_t value, hwaddr addr, unsigned size);
 uint64_t octeon_write64(uint64_t old, hwaddr addr,
                         uint64_t value, unsigned size);
+bool octeon_reg_lookup(GHashTable *regs, uint64_t reg, uint64_t *value);
+void octeon_reg_store(GHashTable *regs, uint64_t reg, uint64_t value);
+bool octeon_csr_lookup(OcteonState *s, uint64_t reg, uint64_t *value);
 void octeon_irq_set(void *opaque, int irq, int level);
 
 #endif
-- 
2.56.0


