Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7590606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=hyi/i5FV;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=ocMAK5YL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWZ0-0000WK-TV; Sun, 01 Nov 2026 09:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWXA-0006bg-Cv
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:47 -0500
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWX7-000853-E4
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=liVrWrs
 0AS73MLJupleGghEWKt5HC4dFqCiirg7iJQpSQeVWv+O++zhZr/24le//TV2X5UqeUMznl
 BzBo7ZtNsivxy2JdOtqpO44cTINdTGvzOwupdurojv9l/s0WEbE09jFM4KNn0faC7IkZPV
 q6ZGMU2tJyRLssuqfCM/YUttCil0aBMTrpxfWJdAcxgjsnF5720Hpak0YWs0yuLOtXhEZr
 LPGDAIv+vkprWGlEcHgiBGE1t6bc/nHmSCz55NcowRpN3CycejXbJYVUgEwJ6wi7sLP45e
 kIfEqKHEzb4YiKjKn/f/ld2dbat4nkhf8qvQac060x6p0gGGD/6FkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=y
 ewn5fgQb7gf72CSVv+Xi8zkXCrIochAerkaY2Or9Hg=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=msZ/ihdfHdhRRHICAMqv6wwr9fzD5OhGlykAnyvmzJ1YdUqPUvkZp9J0zJ+l2QIxJNkp
 6Dj3glrrtjvJK4db3BODXe5cd1Hg2RdcgGKOOEz6I1yE6s84jjfi23OBIlwt+EKOndsjVs
 gJ27vNKLGgxGRmj2+IF+woYizOVj4jw5T9eNx1+lY8b/UjxUnEvqbMTsHUti7zdFhkHGUd
 3tBroQb3/Lm+e5ikpYpj59fJAzt5Nbkd7T5W2hK9xFNUhQ0zb95lgUFl7FWkEe6wwNXrxb
 Lak5JLRjw8vvavL1NWLofrgdYCI+vg52kRxfKwo+2SuMXBV0kgxHklJ5KgWJoLNg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=hyi/i5FV; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=ocMAK5YL;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=yewn5fgQ
 b7gf72CSVv+Xi8zkXCrIochAerkaY2Or9Hg=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=hyi/i5FV1zM1LNjAPG6P4JUWdjNrLzQxZd1
 RhUthI1XQWCh5WEIeR7OLktnwtp60qcWJo8RIMxbuJFmnH45k7DtvyVSbUGzEX0Oc4/zkV
 3DiraojycE3UKxAwrm3O7ArLc5WiJka6Xpr50KtdUAsMalpkzkJ+PUPoW9WWKp9R8zCIQZ
 G5q2drS5XFfz66EXNTYqs8qx0chWifng5eEIoqtS0/z6I4bnoTIUOAzA1AMd52utV5BP5v
 CCVLiGT8p+W/xhUuSCSiw0PxfGQEXF+UkWZVMSeXsljavs2JgpSF6cc84+sXq6wi2NfRC7
 zBN7CQ0B64C7Xh9kvMxTCuGnQOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=yewn5fgQb7gf72CSVv+Xi8zkXCrIochAerkaY2Or9Hg=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=ocMAK5YL65/yJKIuaX
 lyusqVMgBjkvyvDumjykbLvt6rRi7eyi+ou+dzTb5kSNGK7/YTYCz3XlKfxC8sk1n4Cg==
Received: by mx2.catap.net (OpenSMTPD) id ec13b896;
 Sun, 1 Nov 2026 15:27:36 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 93344f23;
 Sun, 1 Nov 2026 15:27:31 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v6 11/26] hw/mips: add Octeon reset controller
Date: Sun,  1 Nov 2026 15:23:27 +0100
Message-ID: <20261101142723.41346-12-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101142723.41346-1-kirill@korins.ky>
References: <20261101142723.41346-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
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

Add the common resettable peripheral base and model the Octeon RST
state used to hold secondary cores in reset. Create and realize the
controller as part of the machine without exposing its CSR interface
yet.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/mips/octeon.c          | 105 ++++++++++++++++++++++++++++++++++++++
 hw/mips/octeon_internal.h |   2 +
 2 files changed, 107 insertions(+)

diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
index 0e02d3693d..4fc5a71a90 100644
--- a/hw/mips/octeon.c
+++ b/hw/mips/octeon.c
@@ -29,6 +29,13 @@
 #define TYPE_OCTEON_MACHINE MACHINE_TYPE_NAME("octeon3")
 OBJECT_DECLARE_SIMPLE_TYPE(OcteonMachineState, OCTEON_MACHINE)
 
+#define TYPE_OCTEON_PERIPHERAL "octeon-peripheral"
+OBJECT_DECLARE_TYPE(OcteonPeripheralState, OcteonPeripheralClass,
+                    OCTEON_PERIPHERAL)
+
+#define TYPE_OCTEON_RST "octeon-rst"
+OBJECT_DECLARE_SIMPLE_TYPE(OcteonRstState, OCTEON_RST)
+
 /*
  * Clock defaults follow a Ubiquiti E1000 EBB7304 U-Boot banner.
  * DDR follows the upstream EBB7304 U-Boot board default.
@@ -85,6 +92,22 @@ struct OcteonMachineState {
     uint64_t ddr_hz;
 };
 
+struct OcteonPeripheralState {
+    SysBusDevice parent_obj;
+    OcteonState *board;
+    unsigned int index;
+};
+
+struct OcteonPeripheralClass {
+    SysBusDeviceClass parent_class;
+    ResettablePhases parent_phases;
+};
+
+struct OcteonRstState {
+    OcteonPeripheralState parent_obj;
+    uint64_t rst_pp_power;
+};
+
 static void octeon_validate_clocks(OcteonMachineState *oms)
 {
     if (!oms->cpu_hz || !oms->ref_hz || !oms->io_hz || !oms->ddr_hz) {
@@ -99,6 +122,16 @@ static void octeon_validate_clocks(OcteonMachineState *oms)
     }
 }
 
+static uint64_t octeon_present_cpu_mask(OcteonState *s)
+{
+    return (1ULL << s->cpu_count) - 1;
+}
+
+static uint64_t octeon_secondary_cpu_mask(OcteonState *s)
+{
+    return octeon_present_cpu_mask(s) & ~1ULL;
+}
+
 static void octeon_cpu_after_reset(OcteonCPUState *cs)
 {
     CPUMIPSState *env = &cs->cpu->env;
@@ -303,6 +336,62 @@ static void octeon_init_flash(OcteonState *s)
                                 &s->boot_flash_alias);
 }
 
+static void octeon_rst_reset_hold(Object *obj, ResetType type)
+{
+    OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_GET_CLASS(obj);
+    OcteonRstState *rst = OCTEON_RST(obj);
+
+    if (opc->parent_phases.hold) {
+        opc->parent_phases.hold(obj, type);
+    }
+
+    rst->rst_pp_power = octeon_secondary_cpu_mask(rst->parent_obj.board);
+}
+
+static void octeon_peripheral_class_init(ObjectClass *klass,
+                                          const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->user_creatable = false;
+}
+
+static void octeon_rst_class_init(ObjectClass *klass, const void *data)
+{
+    OcteonPeripheralClass *opc = OCTEON_PERIPHERAL_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    resettable_class_set_parent_phases(rc, NULL, octeon_rst_reset_hold,
+                                       NULL, &opc->parent_phases);
+}
+
+static OcteonPeripheralState *octeon_new_peripheral(OcteonState *s,
+                                                     const char *type,
+                                                     unsigned int index)
+{
+    DeviceState *qdev = qdev_new(type);
+    OcteonPeripheralState *dev = OCTEON_PERIPHERAL(qdev);
+
+    dev->board = s;
+    dev->index = index;
+    return dev;
+}
+
+static void octeon_create_peripherals(OcteonState *s)
+{
+    s->rst = OCTEON_RST(octeon_new_peripheral(s, TYPE_OCTEON_RST, 0));
+}
+
+static void octeon_realize_peripheral(OcteonPeripheralState *dev)
+{
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+}
+
+static void octeon_realize_peripherals(OcteonState *s)
+{
+    octeon_realize_peripheral(&s->rst->parent_obj);
+}
+
 static void mips_octeon_init(MachineState *machine)
 {
     OcteonMachineState *oms = OCTEON_MACHINE(machine);
@@ -316,6 +405,7 @@ static void mips_octeon_init(MachineState *machine)
     s->ref_hz = oms->ref_hz;
     s->io_hz = oms->io_hz;
     s->ddr_hz = oms->ddr_hz;
+    octeon_create_peripherals(s);
 
     if (machine->kernel_filename) {
         error_report("-kernel is not implemented for octeon3; "
@@ -328,6 +418,7 @@ static void mips_octeon_init(MachineState *machine)
     octeon_load_firmware(s);
     octeon_create_cpus(s);
 
+    octeon_realize_peripherals(s);
 }
 
 static void octeon_machine_reset(MachineState *machine, ResetType type)
@@ -385,6 +476,20 @@ static void octeon_machine_class_init(ObjectClass *oc, const void *data)
 }
 
 static const TypeInfo octeon_machine_types[] = {
+    {
+        .name = TYPE_OCTEON_PERIPHERAL,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(OcteonPeripheralState),
+        .class_size = sizeof(OcteonPeripheralClass),
+        .class_init = octeon_peripheral_class_init,
+        .abstract = true,
+    },
+    {
+        .name = TYPE_OCTEON_RST,
+        .parent = TYPE_OCTEON_PERIPHERAL,
+        .instance_size = sizeof(OcteonRstState),
+        .class_init = octeon_rst_class_init,
+    },
     {
         .name = TYPE_OCTEON_MACHINE,
         .parent = TYPE_MACHINE,
diff --git a/hw/mips/octeon_internal.h b/hw/mips/octeon_internal.h
index 2e568c29ea..9c1baee292 100644
--- a/hw/mips/octeon_internal.h
+++ b/hw/mips/octeon_internal.h
@@ -15,6 +15,7 @@
 
 #define OCTEON_MAX_CPUS             16
 typedef struct OcteonState OcteonState;
+typedef struct OcteonRstState OcteonRstState;
 
 typedef struct OcteonCPUState {
     OcteonState *board;
@@ -39,6 +40,7 @@ struct OcteonState {
     MemoryRegion boot_flash;
     MemoryRegion boot_flash_alias;
     MemoryRegion cvmseg;
+    OcteonRstState *rst;
 };
 
 #endif
-- 
2.56.0


