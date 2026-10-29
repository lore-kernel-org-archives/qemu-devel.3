Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29594606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=dCt5+7Tw;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=//U81oqZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMX1Z-0000Wk-KM; Thu, 29 Oct 2026 16:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX12-0008BX-4t
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:28 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX0z-0007VF-Mv
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=NelDSnZ
 YhF+F1VqdMBIWesB598fizy3k6r0xkc9QhtX+swv/Z0xb9V6gXXIbuw9oXY7cL044g7wF/
 rYDD+pS4wj1grfERS+b9D2vHcpriwF2ePBojlQfa7GKfMc+lXM6oEgUZO5OvaFwL9H3ymJ
 0ltKhiznNn0YmfPoX+ul5MC4nMMKpYYkLB/buXd+qWCWhnnd5DJSsohDzKpw9u9GuoC7ba
 s+E0tgKj/ZCP3Tbl9D7P7QJAv7X120M5cyQjRpURISDV2H5rFCHIlq8aayN8B9deMgWtf0
 ac2O3cqmLagpqy7ZWKXubBG1IPm/t8TxBAVkxF44OHbQVSyfglKQ9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=+
 HXg0ZkTW5fvTDj9En9rifQ7KSTeAyiK9bLOK3tK8gA=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=DpcbLVCFp+ZXbY0vCJ/YDGVdLiQacSZCTaTXyltVL95xMc8W+rMRVoSeC3d75HKr+ehY
 o7oDM95KxlRgJzEvPWMD5dkPzB5AgTlEFXmcjkhSh1Q903Je0PrEmRgK0MB7BRdA6gYSto
 e0LjH2/SkGjWONv42TA6la0OHABqvRk60rJAfl70lTrceU6gGOuqTKdRttFHNCTEBTNoR4
 B+cvoIQ4V8M26Lr8X8AUAKIqGy0MFYK6qe0wZrqwBscbbUPQRoFGN8ArkTZ9SCYjBQrFtb
 MHoyfuPMolWvFiYe3eqlJkGizhN6GnndkQlPpABw8zSh9GvPJSXC6HB1qbqIgmkw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=dCt5+7Tw; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=//U81oqZ;
 arc=none; iprev=fail; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=+HXg0ZkT
 W5fvTDj9En9rifQ7KSTeAyiK9bLOK3tK8gA=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=dCt5+7TwpE+A3M0wmulpfNH6tN78XrAOyGL
 6+t03DwMXB53TyLJzzSbFnEZygXAySqMbW0rQ1njR9EF+3cEQl4Av6q1r1L6k14zhxCKuk
 olaZa6YVlEEZmcTES6FkprNXnZE7x5LU3wI67dh8Q8Pm1+uUg2rlD/T3Ynw1JR94fqwRyL
 1N7UNRw4Q4wrHljmnLu3MSMx/LQV+mDuVTdSGHGb4lvmvHDEN9oESCjuu4Rk0AsaOEnLGT
 VwODa1E2Dhm8STgUnjI3Fqttq8nzXCkxVUlJXYFYxIJdHo/BpPbUXZOP8RB/4F7zGxaNw+
 Xk8IhL5yncYVHQK7PSxqIYdPDoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=+HXg0ZkTW5fvTDj9En9rifQ7KSTeAyiK9bLOK3tK8gA=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=//U81oqZrhiZraRdJg
 5SCX1RwbQ3O+E4tVq419slPdb+FdpU3gehCeiKZeF5WyLdy5On4xKWSZCLibkKsqUWBA==
Received: by mx1.catap.net (OpenSMTPD) id 288c1b17;
 Thu, 29 Oct 2026 21:46:18 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 89231896;
 Thu, 29 Oct 2026 21:46:13 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v5 15/26] hw/mips: add Octeon CSR window
Date: Thu, 29 Oct 2026 21:44:00 +0100
Message-ID: <20261029204609.38989-16-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029204609.38989-1-kirill@korins.ky>
References: <20261029204609.38989-1-kirill@korins.ky>
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

Add the shared CSR window and backing register storage. Keep mutable
state in a resettable CSR bank device so later controllers can route
their registers through it.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
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


