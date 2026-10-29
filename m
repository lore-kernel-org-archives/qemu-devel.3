Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1128F606A329
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=t1R1s4UF;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=OovLyFv/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMX1e-00010Y-Hn; Thu, 29 Oct 2026 16:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX14-0008CS-8m
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:33 -0400
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMX12-0007Tg-5g
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 16:46:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=q6C9TDM
 uT7W4N5YfdsSzu2TnYq4btAiCzchVKE3NMlT3tZD8asttl77CBx/8SXwR1a58J4XoLRJoh
 5a3VQD3SYzBLZ0pVr1oL2QNpuyBQLM1bk2t0oCT1bb10/bR5SPYoCzFHOEJAWQy+S8AvbY
 toCbQovT01PDOmOWZPcoioEsJ06mKQAjl6x2cilIAZLc/xHsJamspplTNVGYEq8KvDlIxW
 VsKaaNHJvU924fF0jP5hIuXoRwENgpNFBQLkxTuy4AIo5ZeCWk0ap1Yd4YdNIks6KAG7+n
 It0MGSgO1PCBQcH/eLgYcDIXkhRN3OYL/kvSfDhjf53CSmTqtxQ9qxg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=R
 OHmmAdJuaqwqEqY/6CUdxwOsDXqyAMTPOgGxdGxgLE=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=oUqn3f6zubm4pzrqH0b2wQ5gElka4acs+3yjzvgMWJ7M61MLOoubP1Ubd1dtMkcbzRs8
 Ryiz1A81JIPUayd9+/H1A2fkeiQv5YJYCaTiMqThjOQesRSzRycNMzDJpJd+IOUsm9CivN
 sgokviIqVqxSFNWNB6uZcgMF+2QfUybi2UgB1+aTj1S0+S3RjWQqg6UPBZdACOrICXIawd
 OiNqyonpX9FDfiTIPV0LOmsCYfDjvShr6IgUpndYS4uxkodF+SE4RoOWAOuJWo4hUC2EmD
 neHovVeOYCY7FhC922NSykCxnjNKNviIMTbmQYmSnTldldm/VBqHMNmsNxxPxPLw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=t1R1s4UF; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=OovLyFv/;
 arc=none; iprev=fail; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=ROHmmAdJ
 uaqwqEqY/6CUdxwOsDXqyAMTPOgGxdGxgLE=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=t1R1s4UFd+QDsGxw0yae2k0+aQIqYgTYIre
 Y+tx6yRR97MfcSGHd6IIhAAwfxnaNzrtxAv96Sd/AV/9228JM3X44pMbvDxf8G6WQeEzn9
 CvWJR7vxNkcMoNYGHyfhy6N49aPuwMe3DzLsoQiSI8EpEFAY3nO7NXRuG+7RJ2uYgV26Zu
 AGlI+cE7ve75yCDBCquxy6HeS3K8GuYZEqhIFoL5nPGivVKdPTTIMWccd97lqRBE77KMH3
 BO61sPlAp1tosEUtf2QhM1rfhjq+86Gn0hzYoLl1riLIl4BwhaJJBV+sA8A5iCpXBLhl/a
 yJQNDA7waMxirlnCz7sF10ErkXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=ROHmmAdJuaqwqEqY/6CUdxwOsDXqyAMTPOgGxdGxgLE=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=OovLyFv/WVOAu1tM7V
 zcDbYyTME7wCAPKw8Mmgd5rp5frZnVFeFh/iA0k7XvYNig3YCh8WDHb01+qybLj3UmCw==
Received: by mx1.catap.net (OpenSMTPD) id 7c902914;
 Thu, 29 Oct 2026 21:46:19 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id bc5cab8d;
 Thu, 29 Oct 2026 21:46:14 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>
Subject: [PATCH v5 22/26] hw/mips: add Octeon boot support registers
Date: Thu, 29 Oct 2026 21:44:07 +0100
Message-ID: <20261029204609.38989-23-kirill@korins.ky>
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

Add the small DPI, FPA, IPD, PKO, RNG and POW register windows needed
while firmware initializes the platform. Reuse the CSR bank for stored
values and compute clock and random values on demand.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/mips/octeon.c          | 218 ++++++++++++++++++++++++++++++++++++++
 hw/mips/octeon_internal.h |   6 ++
 2 files changed, 224 insertions(+)

diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
index 0553f8ea05..7e78511b8f 100644
--- a/hw/mips/octeon.c
+++ b/hw/mips/octeon.c
@@ -30,6 +30,7 @@
 #include "system/runstate.h"
 #include "system/system.h"
 #include "exec/cpu-interrupt.h"
+#include "qemu/guest-random.h"
 #include "qemu/error-report.h"
 #include "qemu/atomic.h"
 #include "hw/mips/octeon_internal.h"
@@ -140,6 +141,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonCsrBankState, OCTEON_CSR_BANK)
 #define OCTEON_CIU3_UART0_INTSN     0x8000
 #define OCTEON_CSR_BASE             0x1180000000000ULL
 #define OCTEON_CSR_SIZE             0x100000000ULL
+#define OCTEON_DPI_BASE             0x1df0000000000ULL
+#define OCTEON_DPI_SIZE             0x10000
 #define OCTEON_MIO_BOOT_REG_CFGX(x) \
     (0x0000000 + (x) * OCTEON_CSR_64BIT_SIZE)
 #define OCTEON_MIO_BOOT_REG_CFG_INDEX(reg) \
@@ -267,6 +270,23 @@ OBJECT_DECLARE_SIMPLE_TYPE(OcteonCsrBankState, OCTEON_CSR_BANK)
 #define OCTEON_RST_BOOT_C_MUL_SHIFT 30
 #define OCTEON_RST_BOOT_PNR_MUL_SHIFT 24
 
+#define OCTEON_FPA_BASE             0x1280000000000ULL
+#define OCTEON_FPA_SIZE             0x1000
+#define OCTEON_FPA_CLK_COUNT        0xf0
+
+#define OCTEON_IPD_BASE             0x14f0000000000ULL
+#define OCTEON_IPD_SIZE             0x1000
+#define OCTEON_IPD_CLK_COUNT        0x338
+
+#define OCTEON_PKO_BASE             0x1540000000000ULL
+#define OCTEON_PKO_SIZE             0x1000000
+
+#define OCTEON_RNG_BASE             0x1400000000000ULL
+#define OCTEON_RNG_SIZE             0x8
+
+#define OCTEON_POW_BASE             0x1670000000000ULL
+#define OCTEON_POW_SIZE             0x2000
+
 #define OCTEON_UART0_BASE           0x1180000000800ULL
 #define OCTEON_UART0_ALIAS_BASE     0x1180000000c00ULL
 #define OCTEON_UART_TX_REG          0x40
@@ -1955,6 +1975,174 @@ static const MemoryRegionOps octeon_csr_ops = {
     },
 };
 
+static uint64_t octeon_stateful_io_read(OcteonState *s, uint64_t base,
+                                        hwaddr addr, unsigned size)
+{
+    uint64_t value;
+    uint64_t reg = base + (addr & ~7ULL);
+
+    if (!octeon_csr_lookup(s, reg, &value)) {
+        value = 0;
+    }
+
+    return octeon_read64(value, addr, size);
+}
+
+static void octeon_stateful_io_write(OcteonState *s, uint64_t base,
+                                     hwaddr addr, uint64_t value,
+                                     unsigned size)
+{
+    uint64_t reg = base + (addr & ~7ULL);
+    uint64_t old;
+
+    if (!octeon_csr_lookup(s, reg, &old)) {
+        old = 0;
+    }
+
+    octeon_csr_store(s, reg, octeon_write64(old, addr, value, size));
+}
+
+static uint64_t octeon_dpi_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return octeon_stateful_io_read(opaque, OCTEON_DPI_BASE, addr, size);
+}
+
+static void octeon_dpi_write(void *opaque, hwaddr addr,
+                             uint64_t value, unsigned size)
+{
+    octeon_stateful_io_write(opaque, OCTEON_DPI_BASE, addr, value, size);
+}
+
+static const MemoryRegionOps octeon_dpi_ops = {
+    .read = octeon_dpi_read,
+    .write = octeon_dpi_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
+static uint64_t octeon_fpa_read(void *opaque, hwaddr addr, unsigned size)
+{
+    OcteonState *s = opaque;
+    hwaddr reg = addr & ~7ULL;
+
+    if (reg == OCTEON_FPA_CLK_COUNT) {
+        return octeon_read64(octeon_clock_count(s->io_hz), addr, size);
+    }
+
+    return 0;
+}
+
+static void octeon_fpa_write(void *opaque, hwaddr addr,
+                             uint64_t value, unsigned size)
+{
+}
+
+static const MemoryRegionOps octeon_fpa_ops = {
+    .read = octeon_fpa_read,
+    .write = octeon_fpa_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
+static uint64_t octeon_ipd_read(void *opaque, hwaddr addr, unsigned size)
+{
+    OcteonState *s = opaque;
+    hwaddr reg = addr & ~7ULL;
+
+    if (reg == OCTEON_IPD_CLK_COUNT) {
+        return octeon_read64(octeon_clock_count(s->io_hz), addr, size);
+    }
+
+    return 0;
+}
+
+static void octeon_ipd_write(void *opaque, hwaddr addr,
+                             uint64_t value, unsigned size)
+{
+}
+
+static const MemoryRegionOps octeon_ipd_ops = {
+    .read = octeon_ipd_read,
+    .write = octeon_ipd_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
+static uint64_t octeon_pko_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return octeon_stateful_io_read(opaque, OCTEON_PKO_BASE, addr, size);
+}
+
+static void octeon_pko_write(void *opaque, hwaddr addr,
+                             uint64_t value, unsigned size)
+{
+    octeon_stateful_io_write(opaque, OCTEON_PKO_BASE, addr, value, size);
+}
+
+static const MemoryRegionOps octeon_pko_ops = {
+    .read = octeon_pko_read,
+    .write = octeon_pko_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
+static uint64_t octeon_rng_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint64_t value;
+
+    qemu_guest_getrandom_nofail(&value, sizeof(value));
+    return octeon_read64(value, addr, size);
+}
+
+static void octeon_rng_write(void *opaque, hwaddr addr,
+                             uint64_t value, unsigned size)
+{
+}
+
+static const MemoryRegionOps octeon_rng_ops = {
+    .read = octeon_rng_read,
+    .write = octeon_rng_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
+static uint64_t octeon_pow_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return octeon_stateful_io_read(opaque, OCTEON_POW_BASE, addr, size);
+}
+
+static void octeon_pow_write(void *opaque, hwaddr addr,
+                             uint64_t value, unsigned size)
+{
+    octeon_stateful_io_write(opaque, OCTEON_POW_BASE, addr, value, size);
+}
+
+static const MemoryRegionOps octeon_pow_ops = {
+    .read = octeon_pow_read,
+    .write = octeon_pow_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
+
 void octeon_irq_set(void *opaque, int irq, int level)
 {
     OcteonState *s = opaque;
@@ -2573,6 +2761,36 @@ static void mips_octeon_init(MachineState *machine)
     memory_region_add_subregion_overlap(get_system_memory(), OCTEON_CSR_BASE,
                                         &s->csr_bank->csr, -1);
 
+    memory_region_init_io(&s->dpi, NULL, &octeon_dpi_ops, s,
+                          "octeon.dpi", OCTEON_DPI_SIZE);
+    memory_region_add_subregion(get_system_memory(), OCTEON_DPI_BASE,
+                                &s->dpi);
+
+    memory_region_init_io(&s->fpa, NULL, &octeon_fpa_ops, s,
+                          "octeon.fpa", OCTEON_FPA_SIZE);
+    memory_region_add_subregion(get_system_memory(), OCTEON_FPA_BASE,
+                                &s->fpa);
+
+    memory_region_init_io(&s->ipd, NULL, &octeon_ipd_ops, s,
+                          "octeon.ipd", OCTEON_IPD_SIZE);
+    memory_region_add_subregion(get_system_memory(), OCTEON_IPD_BASE,
+                                &s->ipd);
+
+    memory_region_init_io(&s->pko, NULL, &octeon_pko_ops, s,
+                          "octeon.pko", OCTEON_PKO_SIZE);
+    memory_region_add_subregion(get_system_memory(), OCTEON_PKO_BASE,
+                                &s->pko);
+
+    memory_region_init_io(&s->rng, NULL, &octeon_rng_ops, s,
+                          "octeon.rng", OCTEON_RNG_SIZE);
+    memory_region_add_subregion(get_system_memory(), OCTEON_RNG_BASE,
+                                &s->rng);
+
+    memory_region_init_io(&s->pow, NULL, &octeon_pow_ops, s,
+                          "octeon.pow", OCTEON_POW_SIZE);
+    memory_region_add_subregion(get_system_memory(), OCTEON_POW_BASE,
+                                &s->pow);
+
     octeon_realize_peripherals(s);
 }
 
diff --git a/hw/mips/octeon_internal.h b/hw/mips/octeon_internal.h
index 96443a9d64..f2daa35cdb 100644
--- a/hw/mips/octeon_internal.h
+++ b/hw/mips/octeon_internal.h
@@ -71,6 +71,12 @@ struct OcteonState {
     MemoryRegion boot_flash;
     MemoryRegion boot_flash_alias;
     MemoryRegion cvmseg;
+    MemoryRegion dpi;
+    MemoryRegion fpa;
+    MemoryRegion ipd;
+    MemoryRegion pko;
+    MemoryRegion rng;
+    MemoryRegion pow;
     OcteonMioState *mio;
     OcteonEmmState *emm;
     OcteonRstState *rst;
-- 
2.56.0


