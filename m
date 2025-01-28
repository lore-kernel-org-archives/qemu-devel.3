Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DC2C02192
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 16:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcoEx-0005J1-QJ; Tue, 28 Jan 2025 11:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tcoEu-0005Hp-JU
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:15:00 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tcoEs-0002c1-Up
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:15:00 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 5B0D2A40FAC;
 Tue, 28 Jan 2025 16:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F36C4CEDF;
 Tue, 28 Jan 2025 16:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738080894;
 bh=S9HK0xeqqBFQ5Dh/ahazUko2s71TwD5ZiEw7SlIeLeU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bzpGrhO1zHjZnScmLs14a/jGKsJiYEFGEUb8ZZLTU2DeYCmgD86+X084+EhCL3Jhb
 vvtaSy/z0jJK1TzJwlVwaq998ZWisYvh+Afh1RC0qeFx/n2Q3SUU+DQXNkHZB5xSUA
 cMeyxdUxwm1z/hcUSTw16Rm6QYAbQqiqpzCu47IP/KXrNvJk1X6sj22M7pkblhJi6o
 bIgBybQna2sV4CSRjcduYWUVIWYvt+GYFHDFhAGIdH7UiOqTDPreWNcE0ncAONIsnY
 momZnTw360z4ON75hhOanS5aMOrBl76KqimGbk3AfiGjm/W4B5o76Jbro6tPB3ybOj
 4WF/osW0nMpPA==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/5] hppa: Sync contents of hppa_hardware.h header file with
 SeaBIOS-hppa
Date: Tue, 28 Jan 2025 17:14:46 +0100
Message-ID: <20250128161450.12975-2-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250128161450.12975-1-deller@kernel.org>
References: <20250128161450.12975-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Helge Deller <deller@gmx.de>

The hppa_hardware.h header file holds many constants for addresses and
offsets which are needed while building the firmware (SeaBIOS-hppa) and
while setting up the virtual machine in QEMU.

This patch brings it in sync between both source code repositories.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/hppa_hardware.h | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index a276240967..21c777cba6 100644
--- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -6,6 +6,11 @@
 
 #define FIRMWARE_START  0xf0000000
 #define FIRMWARE_END    0xf0800000
+#define FIRMWARE_HIGH   0xfffffff0  /* upper 32-bits of 64-bit firmware address */
+
+#define RAM_MAP_HIGH  0x0100000000  /* memory above 3.75 GB is mapped here */
+
+#define MEM_PDC_ENTRY       0x4800  /* PDC entry address */
 
 #define DEVICE_HPA_LEN  0x00100000
 
@@ -18,6 +23,7 @@
 #define LASI_UART_HPA   0xffd05000
 #define LASI_SCSI_HPA   0xffd06000
 #define LASI_LAN_HPA    0xffd07000
+#define LASI_RTC_HPA    0xffd09000
 #define LASI_LPT_HPA    0xffd02000
 #define LASI_AUDIO_HPA  0xffd04000
 #define LASI_PS2KBD_HPA 0xffd08000
@@ -27,16 +33,23 @@
 #define CPU_HPA         0xfffb0000
 #define MEMORY_HPA      0xfffff000
 
-#define PCI_HPA         DINO_HPA        /* PCI bus */
 #define IDE_HPA         0xf9000000      /* Boot disc controller */
+#define ASTRO_HPA       0xfed00000
+#define ELROY0_HPA      0xfed30000
+#define ELROY2_HPA      0xfed32000
+#define ELROY8_HPA      0xfed38000
+#define ELROYc_HPA      0xfed3c000
+#define ASTRO_MEMORY_HPA 0xfed10200
+
+#define SCSI_HPA        0xf1040000      /* emulated SCSI, needs to be in f region */
 
 /* offsets to DINO HPA: */
 #define DINO_PCI_ADDR           0x064
 #define DINO_CONFIG_DATA        0x068
 #define DINO_IO_DATA            0x06c
 
-#define PORT_PCI_CMD    (PCI_HPA + DINO_PCI_ADDR)
-#define PORT_PCI_DATA   (PCI_HPA + DINO_CONFIG_DATA)
+#define PORT_PCI_CMD    hppa_port_pci_cmd
+#define PORT_PCI_DATA   hppa_port_pci_data
 
 #define FW_CFG_IO_BASE  0xfffa0000
 
@@ -46,9 +59,24 @@
 #define HPPA_MAX_CPUS   16      /* max. number of SMP CPUs */
 #define CPU_CLOCK_MHZ   250     /* emulate a 250 MHz CPU */
 
+#define CR_PSW_DEFAULT  6       /* used by SeaBIOS & QEMU for default PSW */
 #define CPU_HPA_CR_REG  7       /* store CPU HPA in cr7 (SeaBIOS internal) */
 #define PIM_STORAGE_SIZE 600	/* storage size of pdc_pim_toc_struct (64bit) */
 
-#define RAM_MAP_HIGH  0x0100000000  /* memory above 3.75 GB is mapped here */
+#define ASTRO_BUS_MODULE        0x0a            /* C3700: 0x0a, others maybe 0 ? */
+
+/* ASTRO Memory and I/O regions */
+#define ASTRO_BASE_HPA            0xfffed00000
+#define ELROY0_BASE_HPA           0xfffed30000  /* ELROY0_HPA */
+
+#define ROPES_PER_IOC           8       /* per Ike half or Pluto/Astro */
+
+#define LMMIO_DIRECT0_BASE  0x300
+#define LMMIO_DIRECT0_MASK  0x308
+#define LMMIO_DIRECT0_ROUTE 0x310
+
+/* space register hashing */
+#define HPPA64_DIAG_SPHASH_ENABLE       0x200   /* DIAG_SPHASH_ENAB (bit 54) */
+#define HPPA64_PDC_CACHE_RET_SPID_VAL   0xfe0   /* PDC return value on 64-bit CPU */
 
 #endif
-- 
2.47.0


