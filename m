Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6461C606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=Wdx++2ml;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=4iDyvmQs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLehG-0005xk-5W; Tue, 27 Oct 2026 06:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLeg4-0005O4-DL
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:45:13 -0400
Received: from mx2.catap.net ([2a01:4f9:3b:5410::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLeg2-0007zM-Cd
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:45:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=xEjU2G9
 pqFO5rsEQ9hPVDscSu7zuBN87tq4STQ4i7tbySg1nblBAi996sAd+z9eGwe3zU5zm3XFhL
 dhdeZyYN0/ZMPk09vPA1Yu/h1GcPT/O80XKTNOlFOo9qxJ7wmY2LwnQhRWxuJE1Sm4jHzE
 QXmxOjwUmTvv0FtigScGp2Gr7U5hjD+N0dTDptH2KEI6VbwDqngIu4E5++gL9NUVXmCE5k
 fMvV++iwtqZytrZ2Pd4t5Uj/0ERfKD5XFVTQmuOKcsYd/l8hbnOJOelmw8jRKTuj20OXP8
 42p0eSMrQXdyKE17D0eGPFCPjip8OJ8SXFuN4Yr/C5SEmXxJb2GASmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=T
 u4amzxW4ef/VlcuaC2Edr0DTsc/fFoaGL2nrhQOVDg=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=jitFxStDEpTzBucMJDJdsmwGBMFKMckmvEUbuMb+SEMJ3GLEO/CCLlMEw2bYXBlBGDe2
 8FJJtXjejVMtRXujXVTQODscsJIRnlDac7Cyl7vAUNJgDmEiE+KtV5OHAAz0zy8KdlRjGc
 cDo8qH7GPXUv/YDccQ4xsuhFkMVoa7HW5hwqEB9lnfzOLYzsGPlujC9jzISEJUP2Rbk814
 Ny7iF4BWEuvV2PtImaMzaL35bKNQnq8KO+CjApz/yQIm7NoVgMQ1R0C3+qf2v7rYi6GzBu
 I25DXMdQDgwgrtwCcsnRZYPCjOjGD8Hbe0wFGn7fX/BtyIuoo9vuWyiQJwl+3kOQ==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=Wdx++2ml; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=4iDyvmQs;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=Tu4amzxW
 4ef/VlcuaC2Edr0DTsc/fFoaGL2nrhQOVDg=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=Wdx++2mllVsVIeq3x7+r5MjsYRK4FyrLkVg
 UOh80+EZ7qKi2IpSVYqYLea4Uxe3fNxFn5fPjpIWMcr9U9z2R8pVp4ZuFMH5RPZMQSnNBH
 tGT5ULRtK9n/+pDskcLaqjUphoy1U0HV5qt8CKvQt636PBEbIq3D7N2R23+CIlaG6m2oe+
 bYgtXbPsThSb5pQE0T4NHp5e6Ryk3EDXgInUkG11TFoUCDL+Wb8aZaEYXjMOW9j+hkRnAx
 jK0BWCz6hlJVIugvy/7iKjJPbmctqN58mr4qOcLYljJM1uBE4odWrqVk5XpDnBGMo/ZwNh
 mjPoAqbi/slAN8dqGNlIFE03riw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=Tu4amzxW4ef/VlcuaC2Edr0DTsc/fFoaGL2nrhQOVDg=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=4iDyvmQsoN3MUvt3+n
 MiisK/d85mVavf4bfwYgKcluiCJ7xkjIUFKIRQGEvTunWJ46w6XQ/LXAq6n6+qRF+ADQ==
Received: by mx2.catap.net (OpenSMTPD) id 448ad86a;
 Tue, 27 Oct 2026 11:44:58 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 81a93c3d;
 Tue, 27 Oct 2026 11:44:51 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v4 10/25] hw/mips: add Octeon reset controller
Date: Tue, 27 Oct 2026 11:41:34 +0100
Message-ID: <20261027104433.25720-11-kirill@korins.ky>
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

Add the common resettable peripheral base and model the Octeon RST
state used to hold secondary cores in reset. Create and realize the
controller as part of the machine without exposing its CSR interface
yet.
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


