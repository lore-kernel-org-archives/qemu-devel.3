Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFD8606A325
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=NN0uWhJ/;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=FfxLtm/b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLei7-000770-LZ; Tue, 27 Oct 2026 06:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLeg4-0005O3-Ba
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:45:13 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xLeg0-0007wv-OE
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 06:45:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=s1mUVSL
 DfkBrmozsl88B7TX0WfjkZmx8jMJYWEbzKCOUSYFMzgzEyCR4z+T4ZUjw8kTdqOPpBqook
 VGRRgP1zd57C48V5P9ugaQUsmX+8pW3efVap9WqbgoSznCPLmx/l6QzeFfOS+m7PEuRwH7
 im6+txHQrgw6pfA5RQihd1Q1SFLshDCSHAoH6gClakjJq3lPOHsUjEiYdpEth+H2qa1ogJ
 QrMlgI7dIJJnbur3IMNVbF2XOORMZmAeXmAYy9WvTJahnDA+nOBSh1FBKF5YsvzvtwtQnn
 bqMtGrRfbzW9CXCSzbNWy6gJeLpgNULqPHSCYYYDh0VYEaYjxJQlWVw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=P
 jCc4VNCDlvASJ9XCW6nS2kfMtWtAn872SB2HWzDBq4=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=GcFhuo5dR9v3KGxYE6VdnUviwDDuDaNrrR6aguNalZ+NZ/T7d2lniis+0+ZzcNW8o+Lh
 0akkCEQuYFnhtf8YBItce6tG4WywgYB6/zZ+hKvzrhfvS/SITWYnqgI06PkYsnJdZvc+UV
 wVV7GNkEKfcNZZ5cIYy1NidCFbBujyiPo9ydjA1xYa77vxC0O3dguoVIVTfpgyQhErUvfm
 l935Xh8CNwkqgUJAGBa3Ny848kkiwQvHgsf3pwzWPzqi0Kb5FO8zOVm5MbzSIpY0h0PCzf
 ZeZ9W3t6DtHGfi/3H+GTSEka6paEFT7dhQY9fcFva7bt/q4OiiHVYYF3F9V/i2yg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=NN0uWhJ/; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=FfxLtm/b;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=PjCc4VNC
 DlvASJ9XCW6nS2kfMtWtAn872SB2HWzDBq4=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=NN0uWhJ/J7VIb260O6p6ls48PqbPQ5pTaVE
 BpwrLQitGzTQ7iOrPDfRgQqZFwFfD0s2vjTUoWr++rB0teOgl41Plw2pil6K4VMq1PxjL+
 bhXavg5MDqt9eIgNVQ8CioYdefGNYs2E2Zwg92acVWnPjz9DOKGmwdghlXsjA+UkzsL9D4
 0J86OhfKcB1YcG22BUuLXd2k71BznHrJWhBQiCTRBQUsl/F8p0NQ4ZmxHeLjLi02lxOlF3
 /07SVpw1RNDvsGiG5dmrHA634XZcRZWjcjxserfU+OFTXFMvbyohpLQ1ICrTO4cCFdDx5E
 /CUkPfgE4fZ4YhRBebXwFGeTCXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=PjCc4VNCDlvASJ9XCW6nS2kfMtWtAn872SB2HWzDBq4=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=FfxLtm/bIYyVZahFnu
 u+0JYHlUbBPOcqEEM+Z9/z+o8rNyKIaQOIRVRMwdzSAPwEcTyXNjaUVko6ZpUttQwyDw==
Received: by mx2.catap.net (OpenSMTPD) id 3334df30;
 Tue, 27 Oct 2026 11:44:57 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id aea819f4;
 Tue, 27 Oct 2026 11:44:51 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v4 09/25] hw/mips: add Octeon CPUs and boot memory
Date: Tue, 27 Oct 2026 11:41:33 +0100
Message-ID: <20261027104433.25720-10-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027104433.25720-1-kirill@korins.ky>
References: <20261027104433.25720-1-kirill@korins.ky>
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
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Create the Octeon CPUs and clock, map the split DRAM layout and
per-core CVMSEG storage, and provide the EBB7304 boot flash windows.
Load firmware into the flash reset alias and restore the boot PC during
machine reset.
---
 hw/mips/Kconfig           |   1 +
 hw/mips/octeon.c          | 308 ++++++++++++++++++++++++++++++++++++++
 hw/mips/octeon_internal.h |  28 ++++
 3 files changed, 337 insertions(+)

diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 2e71e6dee6..cb6057fe38 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -71,6 +71,7 @@ config MIPS_OCTEON
     bool
     default y
     depends on MIPS64 && TARGET_BIG_ENDIAN
+    select PFLASH_CFI02
 
 config MIPS_CPS
     bool
diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
index 2ecc464579..0e02d3693d 100644
--- a/hw/mips/octeon.c
+++ b/hw/mips/octeon.c
@@ -8,30 +8,337 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/datadir.h"
+#include "qapi/error.h"
+#include "hw/core/clock.h"
 #include "hw/core/boards.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "hw/core/sysbus.h"
+#include "hw/block/flash.h"
+#include "hw/mips/mips.h"
+#include "system/blockdev.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
+#include "system/reset.h"
+#include "qemu/error-report.h"
 #include "hw/mips/octeon_internal.h"
 #include "target/mips/cpu.h"
 
 #define TYPE_OCTEON_MACHINE MACHINE_TYPE_NAME("octeon3")
 OBJECT_DECLARE_SIMPLE_TYPE(OcteonMachineState, OCTEON_MACHINE)
 
+/*
+ * Clock defaults follow a Ubiquiti E1000 EBB7304 U-Boot banner.
+ * DDR follows the upstream EBB7304 U-Boot board default.
+ */
 #define OCTEON_DEFAULT_CPU_HZ       1800000000
 #define OCTEON_DEFAULT_REF_HZ       50000000
 #define OCTEON_DEFAULT_IO_HZ        1000000000
 #define OCTEON_DEFAULT_DDR_HZ       800000000
+
+/*
+ * The physical layout follows U-Boot's generic Octeon III
+ * OCTEON_MAX_PHY_MEM_SIZE value. Keep 1 GiB as the tested default.
+ */
 #define OCTEON_DEFAULT_RAM_SIZE     (1 * GiB)
+#define OCTEON_MAX_PHY_MEM_SIZE     (512 * GiB)
+
+/*
+ * The EBB7304 FDT exposes DRAM below and above the
+ * 0x10000000..0x1fffffff boot-bus/EJTAG hole.
+ */
+#define OCTEON_DR0_BASE             0x000000000ULL
+#define OCTEON_DR0_SIZE             (256 * MiB)
+#define OCTEON_DR1_BASE             0x020000000ULL
+#define OCTEON_DR1_SIZE             (OCTEON_MAX_PHY_MEM_SIZE - OCTEON_DR0_SIZE)
+
+/*
+ * QEMU-only backing for per-core CVMSEG. Keep it outside guest DRAM;
+ * the guest sees the virtual CVMSEG window, not this physical address.
+ */
+#define OCTEON_CVMSEG_BASE          0x10000000000ULL
+#define OCTEON_CVMSEG_SIZE          0x4000
+#define OCTEON_CVMSEG_TOTAL_SIZE    (OCTEON_MAX_CPUS * OCTEON_CVMSEG_SIZE)
+
+#define OCTEON_FLASH_BASE           0x1f400000ULL
+#define OCTEON_FLASH_RESET_BASE     0x1fc00000ULL
+#define OCTEON_FLASH_RESET_SIZE     (4 * MiB)
+#define OCTEON_FLASH_MAIN_SECTORS   127
+#define OCTEON_FLASH_MAIN_SECTOR_SIZE (64 * KiB)
+#define OCTEON_FLASH_ENV_SECTORS    8
+#define OCTEON_FLASH_ENV_SECTOR_SIZE 0x2000
+#define OCTEON_FLASH_SIZE           \
+    (OCTEON_FLASH_MAIN_SECTORS * OCTEON_FLASH_MAIN_SECTOR_SIZE + \
+     OCTEON_FLASH_ENV_SECTORS * OCTEON_FLASH_ENV_SECTOR_SIZE)
+#define OCTEON_FLASH_ENV_OFFSET     \
+    (OCTEON_FLASH_SIZE - OCTEON_FLASH_ENV_SECTOR_SIZE)
+#define OCTEON_FLASH_WIDTH          2
 
 struct OcteonMachineState {
     MachineState parent_obj;
+    OcteonState *board;
     uint64_t cpu_hz;
     uint64_t ref_hz;
     uint64_t io_hz;
     uint64_t ddr_hz;
 };
 
+static void octeon_validate_clocks(OcteonMachineState *oms)
+{
+    if (!oms->cpu_hz || !oms->ref_hz || !oms->io_hz || !oms->ddr_hz) {
+        error_report("octeon3 clock frequencies must be non-zero");
+        exit(1);
+    }
+
+    if (oms->cpu_hz % oms->ref_hz || oms->io_hz % oms->ref_hz) {
+        error_report("octeon3 CPU and IO clocks must be multiples of "
+                     "ref-clock-hz");
+        exit(1);
+    }
+}
+
+static void octeon_cpu_after_reset(OcteonCPUState *cs)
+{
+    CPUMIPSState *env = &cs->cpu->env;
+
+    env->CP0_CvmMemCtl = 0x100;
+    env->CP0_CvmCtl = 0;
+
+    if (cs->boot_cpu && cs->board->firmware_entry) {
+        env->active_tc.PC = cs->board->firmware_entry;
+    }
+}
+
+static void octeon_create_cpus(OcteonState *s)
+{
+    unsigned int i;
+
+    s->cpuclk = clock_new(OBJECT(s->machine), "cpu-refclk");
+    clock_set_hz(s->cpuclk, s->cpu_hz);
+    s->cpu_count = s->machine->smp.cpus;
+    for (i = 0; i < s->cpu_count; i++) {
+        DeviceState *dev = qdev_new(s->machine->cpu_type);
+
+        s->cpu[i].board = s;
+        s->cpu[i].boot_cpu = i == 0;
+        object_property_set_bool(OBJECT(dev), "big-endian", TARGET_BIG_ENDIAN,
+                                 &error_abort);
+        object_property_set_bool(OBJECT(dev), "start-powered-off", i != 0,
+                                 &error_abort);
+        qdev_connect_clock_in(dev, "clk-in", s->cpuclk);
+        qdev_realize(dev, NULL, &error_abort);
+        s->cpu[i].cpu = MIPS_CPU(dev);
+
+        cpu_mips_irq_init_cpu(s->cpu[i].cpu);
+        cpu_mips_clock_init(s->cpu[i].cpu);
+        qemu_register_resettable(OBJECT(dev));
+    }
+}
+
+static uint64_t octeon_map_ram_alias(OcteonState *s, MemoryRegion *alias,
+                                     const char *name, hwaddr base,
+                                     uint64_t offset, uint64_t size)
+{
+    MemoryRegion *sysmem = get_system_memory();
+
+    if (!size) {
+        return offset;
+    }
+
+    memory_region_init_alias(alias, NULL, name, s->machine->ram, offset, size);
+    memory_region_add_subregion(sysmem, base, alias);
+    return offset + size;
+}
+
+static void octeon_map_ram(OcteonState *s)
+{
+    MemoryRegion *sysmem = get_system_memory();
+    uint64_t offset = 0;
+    uint64_t remaining = s->machine->ram_size;
+    uint64_t size;
+
+    size = MIN(remaining, (uint64_t)OCTEON_DR0_SIZE);
+    offset = octeon_map_ram_alias(s, &s->dr0, "octeon.dr0",
+                                  OCTEON_DR0_BASE, offset, size);
+    remaining -= size;
+
+    size = MIN(remaining, (uint64_t)OCTEON_DR1_SIZE);
+    octeon_map_ram_alias(s, &s->dr1, "octeon.dr1",
+                         OCTEON_DR1_BASE, offset, size);
+
+    memory_region_init_ram(&s->cvmseg, NULL, "octeon.cvmseg",
+                           OCTEON_CVMSEG_TOTAL_SIZE, &error_fatal);
+    memory_region_add_subregion(sysmem, OCTEON_CVMSEG_BASE, &s->cvmseg);
+}
+
+static void octeon_load_firmware(OcteonState *s)
+{
+    g_autofree char *filename = NULL;
+    g_autofree gchar *contents = NULL;
+    g_autoptr(GError) err = NULL;
+    gsize len;
+    uint8_t *flash;
+
+    if (!s->machine->firmware) {
+        return;
+    }
+    if (!s->flash) {
+        error_report("Octeon boot flash is not initialized");
+        exit(1);
+    }
+
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, s->machine->firmware);
+    if (!filename) {
+        error_report("Could not find Octeon firmware '%s'",
+                     s->machine->firmware);
+        exit(1);
+    }
+
+    if (!g_file_get_contents(filename, &contents, &len, &err)) {
+        error_report("Could not load Octeon firmware '%s': %s",
+                     filename, err->message);
+        exit(1);
+    }
+
+    if (len == 0 || len > OCTEON_FLASH_ENV_OFFSET) {
+        error_report("Octeon firmware '%s' has invalid size %" G_GSIZE_FORMAT,
+                     filename, len);
+        exit(1);
+    }
+
+    flash = memory_region_get_ram_ptr(s->flash);
+    memcpy(flash, contents, len);
+    s->firmware_entry = cpu_mips_phys_to_kseg1(NULL, OCTEON_FLASH_RESET_BASE);
+}
+
+static MemTxResult octeon_boot_flash_read(void *opaque, hwaddr addr,
+                                          uint64_t *data, unsigned size,
+                                          MemTxAttrs attrs)
+{
+    OcteonState *s = opaque;
+    uint8_t buf[8];
+    MemTxResult result = MEMTX_OK;
+    unsigned int i;
+
+    for (i = 0; i < size; i++) {
+        uint64_t value;
+
+        result |= memory_region_dispatch_read(s->flash, addr + i, &value,
+                                              MO_8, attrs);
+        buf[i] = value;
+    }
+    *data = ldn_be_p(buf, size);
+    return result;
+}
+
+static MemTxResult octeon_boot_flash_write(void *opaque, hwaddr addr,
+                                           uint64_t value, unsigned size,
+                                           MemTxAttrs attrs)
+{
+    OcteonState *s = opaque;
+    unsigned access_size = MIN(size, 4);
+
+    if (size > access_size) {
+        access_size = OCTEON_FLASH_WIDTH;
+    }
+    return memory_region_dispatch_write(s->flash, addr, value,
+                                        size_memop(access_size) | MO_BE,
+                                        attrs);
+}
+
+static const MemoryRegionOps octeon_boot_flash_ops = {
+    .read_with_attrs = octeon_boot_flash_read,
+    .write_with_attrs = octeon_boot_flash_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
+static void octeon_init_flash(OcteonState *s)
+{
+    DriveInfo *dinfo = drive_get(IF_PFLASH, 0, 0);
+    DeviceState *dev;
+    uint8_t *flash;
+
+    dev = qdev_new(TYPE_PFLASH_CFI02);
+    if (dinfo) {
+        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo));
+    }
+    qdev_prop_set_uint32(dev, "num-blocks0", OCTEON_FLASH_MAIN_SECTORS);
+    qdev_prop_set_uint32(dev, "sector-length0",
+                         OCTEON_FLASH_MAIN_SECTOR_SIZE);
+    qdev_prop_set_uint32(dev, "num-blocks1", OCTEON_FLASH_ENV_SECTORS);
+    qdev_prop_set_uint32(dev, "sector-length1",
+                         OCTEON_FLASH_ENV_SECTOR_SIZE);
+    qdev_prop_set_uint8(dev, "width", OCTEON_FLASH_WIDTH);
+    qdev_prop_set_uint8(dev, "mappings", 1);
+    qdev_prop_set_uint8(dev, "big-endian", TARGET_BIG_ENDIAN);
+    qdev_prop_set_uint16(dev, "id0", 0x01);
+    qdev_prop_set_uint16(dev, "id1", 0x7e);
+    qdev_prop_set_uint16(dev, "id2", 0x00);
+    qdev_prop_set_uint16(dev, "id3", 0x00);
+    qdev_prop_set_uint16(dev, "unlock-addr0", 0x555);
+    qdev_prop_set_uint16(dev, "unlock-addr1", 0x2aa);
+    qdev_prop_set_string(dev, "name", "octeon.bootbus-flash");
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    s->flash = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    if (!dinfo) {
+        flash = memory_region_get_ram_ptr(s->flash);
+        memset(flash, 0xff, OCTEON_FLASH_SIZE);
+    }
+    memory_region_init_io(&s->boot_flash, NULL, &octeon_boot_flash_ops, s,
+                          "octeon.bootbus-flash-window", OCTEON_FLASH_SIZE);
+    memory_region_add_subregion(get_system_memory(), OCTEON_FLASH_BASE,
+                                &s->boot_flash);
+
+    memory_region_init_alias(&s->boot_flash_alias, NULL,
+                             "octeon.bootbus-flash-reset-alias",
+                             &s->boot_flash, 0, OCTEON_FLASH_RESET_SIZE);
+    memory_region_add_subregion(get_system_memory(), OCTEON_FLASH_RESET_BASE,
+                                &s->boot_flash_alias);
+}
+
 static void mips_octeon_init(MachineState *machine)
 {
+    OcteonMachineState *oms = OCTEON_MACHINE(machine);
+    OcteonState *s = g_new0(OcteonState, 1);
+
+    octeon_validate_clocks(oms);
+
+    oms->board = s;
+    s->machine = machine;
+    s->cpu_hz = oms->cpu_hz;
+    s->ref_hz = oms->ref_hz;
+    s->io_hz = oms->io_hz;
+    s->ddr_hz = oms->ddr_hz;
+
+    if (machine->kernel_filename) {
+        error_report("-kernel is not implemented for octeon3; "
+                     "boot via -bios and U-Boot");
+        exit(1);
+    }
+
+    octeon_map_ram(s);
+    octeon_init_flash(s);
+    octeon_load_firmware(s);
+    octeon_create_cpus(s);
+
+}
+
+static void octeon_machine_reset(MachineState *machine, ResetType type)
+{
+    OcteonState *s = OCTEON_MACHINE(machine)->board;
+    unsigned int i;
+
+    qemu_devices_reset(type);
+    for (i = 0; i < s->cpu_count; i++) {
+        octeon_cpu_after_reset(&s->cpu[i]);
+    }
 }
 
 static void octeon_machine_instance_init(Object *obj)
@@ -70,6 +377,7 @@ static void octeon_machine_class_init(ObjectClass *oc, const void *data)
 
     mc->desc = "Cavium Octeon III / EBB7304 EVK";
     mc->init = mips_octeon_init;
+    mc->reset = octeon_machine_reset;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("OcteonCN73XX");
     mc->default_ram_size = OCTEON_DEFAULT_RAM_SIZE;
     mc->default_ram_id = "octeon.ram";
diff --git a/hw/mips/octeon_internal.h b/hw/mips/octeon_internal.h
index 7cab7790bd..2e568c29ea 100644
--- a/hw/mips/octeon_internal.h
+++ b/hw/mips/octeon_internal.h
@@ -10,7 +10,35 @@
 #define HW_MIPS_OCTEON_INTERNAL_H
 
 #include "qemu/typedefs.h"
+#include "system/memory.h"
+#include "target/mips/cpu.h"
 
 #define OCTEON_MAX_CPUS             16
+typedef struct OcteonState OcteonState;
+
+typedef struct OcteonCPUState {
+    OcteonState *board;
+    MIPSCPU *cpu;
+    bool boot_cpu;
+} OcteonCPUState;
+
+struct OcteonState {
+    MachineState *machine;
+    Clock *cpuclk;
+    uint64_t cpu_hz;
+    uint64_t ref_hz;
+    uint64_t io_hz;
+    uint64_t ddr_hz;
+    OcteonCPUState cpu[OCTEON_MAX_CPUS];
+    unsigned int cpu_count;
+    uint64_t firmware_entry;
+
+    MemoryRegion dr0;
+    MemoryRegion dr1;
+    MemoryRegion *flash;
+    MemoryRegion boot_flash;
+    MemoryRegion boot_flash_alias;
+    MemoryRegion cvmseg;
+};
 
 #endif
-- 
2.56.0


