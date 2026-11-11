Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A37B606A331
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=OXfyqZ/h;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=v5t34WNU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR9RD-00012X-AA; Wed, 11 Nov 2026 09:36:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9Qy-0000uA-34
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:20 -0500
Received: from mx1.catap.net ([2a01:4f8:271:125e::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9Qv-0002Oi-Tc
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=vOfExtK
 3a7END849du/VCCaqvK2L0xMxl7q0EVrbMa3UmO3Ds/Ii0g2RF9sAFUscex5AyUkfINUMN
 sR6V1ajKRs24a1q7+UApU1/KVu+3NTjHEuBtnyturVFGGxk7xeSA6ILbxTKk+ugruF6BkC
 KKdbQBgXdIk/E+YYJl8hvJX2R8wrJnN1fMuGZcO0ZxZu2cPvc0a0bFgE7zhef6hOL4BKWs
 QeKJS04rMmcqfgQWqRNgVNHY1wBxBDlnzBmk88YKUVr+af+McWEeVC/bMmnZrwP88a3/Lu
 EDwakWsItZme2UjVaM1kmf/wCesTLymnZlHyzp4WDnpSRkNhOFcr2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=K
 McNPPX61uJwAtosH+EXVaB+S2v71lOckl1tAfM8S6I=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=jXKDLfQwWrFlD9/avLKdTLJpKJQkHZndgLhXrWgiLHNmRbnTcfpsIVoBjRwO3J+BtOiL
 SgZMd2ngYn9yoT1HY23KsLkeh8/CnhKmjZshg7/mrkLPaqpu2Mol8AaIe/A4l04gdvowFe
 E+COhceC3cKPHUYokvHXBWtfVKXQh+S5ZmikA6s8qqUAOkua/GxZmtuY1UpfvCj7NGY7W6
 BesVqx6k6VEzTRnIfvR6FM7L7KxjIUXNj9I1WGV+sCpjRRwev7JHnhH7dvMVU5LnNVgRwh
 5Mtm69Y0DSQiVDju/AyHPLnyED+W7IhchOV4LEQpEXlSWJYXQ0f1u/hQJ1BNfSAg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=OXfyqZ/h; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=v5t34WNU;
 arc=none; iprev=fail; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=KMcNPPX6
 1uJwAtosH+EXVaB+S2v71lOckl1tAfM8S6I=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=OXfyqZ/hCGtLuwI3Bx3U5xa/mfIAxAWiIoD
 rZ37g0eWZ4LOZPQ4FAI0YJdEZgaXbjEhVt+aChfiyHx92gGFuCIHxCGVb+IH4X+267jpNO
 GwQjYQ+dpKY6fU3LYGrs5OFpaBKxl2cZ5U70W9eu5bOkqBAgldyzunrePGG9fGE8hHl6hZ
 YrHU91wKikIEsJNaPa4HFkj94aygWA5Krnadwtz1p4zawvlklPXgRWcfkYVHL6QHAzA1eu
 katlJ+Y2v9I/o3KLJu9RHtUEgex1gj3WragNYWD8z36W/9UmtcMGnb3Q27iDts0VsA/wY0
 UkHvG1pJsUXOzF9K1yT9rZ6Ek/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=KMcNPPX61uJwAtosH+EXVaB+S2v71lOckl1tAfM8S6I=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=v5t34WNUWjzrhIs0ln
 fwFzG88G/prapyBHiTKBaDuPU2hHsibrA86lmiUX3PS9agiIG6P53XSs8U7V9AkoydDQ==
Received: by mx1.catap.net (OpenSMTPD) id 549cf58c;
 Wed, 11 Nov 2026 15:36:08 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 84458815;
 Wed, 11 Nov 2026 15:35:54 +0100 (CET)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PATCH v7 11/26] hw/mips: add Octeon reset controller
Date: Wed, 11 Nov 2026 15:32:11 +0100
Message-ID: <20261111143533.1775-12-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111143533.1775-1-kirill@korins.ky>
References: <20261111143533.1775-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:271:125e::2;
 envelope-from=kirill@korins.ky; helo=mx1.catap.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: "Kirill A. Korinsky" <kirill@korins.ky>

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


