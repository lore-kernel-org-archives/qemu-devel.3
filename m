Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FBEC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 17:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBdwQ-0002zB-1K; Mon, 27 May 2024 13:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sBdwK-0002xl-Nm
 for qemu-devel@nongnu.org; Mon, 27 May 2024 13:15:18 -0400
Received: from wfout8-smtp.messagingengine.com ([64.147.123.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sBdwI-0004eM-Qv
 for qemu-devel@nongnu.org; Mon, 27 May 2024 13:15:16 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.west.internal (Postfix) with ESMTP id 516791C00101;
 Mon, 27 May 2024 13:15:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Mon, 27 May 2024 13:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716830112;
 x=1716916512; bh=PDOlHUdSMFMmwhGnB9Nfy+pD/I3z/lyl57D5tIw/ew8=; b=
 FcGHxfH+NkoUyFqYRP9CfD109luutqb74qYMdsoE6y7p4wi3e5n5iH+cReM5WJ6c
 oKswXt1b95o67ZmZ/7TZ7exD24kN1zHFVrYaoUv9CYehUdEtQAcEC+M16Bq/JgzF
 8ATRmoLU/wD8tXcNTQiQWc6rPlrs0btUoJrIJZX5kwANFxDh92m4BuK8/mS322U8
 mS1qLjr3fZUPxhtvEHaelyQxuWL7sG0BopPfhvHuFVoqkr/chwVnFOx+7y5NKYUa
 KFeQdEhx0c8p8BOvV6cnKABfDZ1RTV0EtG32IoU8tqJOc6QOmZA5vHXrqmIXA1bv
 BZ0Mqh9Uni3AoXDhnK1Kdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716830112; x=
 1716916512; bh=PDOlHUdSMFMmwhGnB9Nfy+pD/I3z/lyl57D5tIw/ew8=; b=f
 rPTprox4nwPPx6CcMMH50eWoaBnfdIJ9QfQ2a4BgxPbybsimHVpVB8lKycxA0ttM
 9nKYKiZFjCHxClfGzm5VmSzgXAhrecZDgeGzJiESsoJDR3zXQ0Wvouq87pMuhrMe
 rRSeYVO5LqwuCFZ8WKhy8s/h07tcOd6LTS+aqIjhDThwBlclov9KTRa2eyrm1924
 +ivopHIwpqk4OvLnQls+jI0wan/boQsFDFGbxoe2pcdWaTjTmqVgpLM4bzJYFrvB
 dGk1duLjKFQ6KxxxqpCb10dJzvo1qjHRhwn7SNTCzcF9G2n4wdw5CFO+NHV2h3Iz
 nH3UFiVEI3CFqFK7g6y1g==
X-ME-Sender: <xms:oL9UZvU-0c3Ax7ZecZ1_4KkENAV5nEF6pW-b1JYaxI5qsRmqJQ0y4Q>
 <xme:oL9UZnkIemgAzHPwPsXptlnbbw9vKcUJT43daZp6memEruLiD7sbZNRy6tJInOL-3
 sl4uqRSc43_xlai9ng>
X-ME-Received: <xmr:oL9UZrapftTEjOSU4LvaMMv8a6FR6EH4uznFq5-Ls6etEr0ZBBZuU-k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedguddtkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:oL9UZqUyE9O4e5EOgKtuICc0mc7Rpd3j_xrkKMTTRcO_tQPI_9mzxg>
 <xmx:oL9UZpmSDCHm9CDOJ_NcDQqsmNDmzHx98fHXmmgBMATJ0ilX0OUcOw>
 <xmx:oL9UZnd9ArI4w9pTOdthSO6MMC6LLfFUPJWogUpg7SmjGP0wx8sANA>
 <xmx:oL9UZjHnGVZkR8NFXCV5yOTrOFpDLxpgXmOS7hYKcHH3MSPnG25HRQ>
 <xmx:oL9UZnZLEPfFzy8xsPcwNMS0E4nYZSyf2L071Lk-7g1pBuy6H4v0y-hQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 13:15:11 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 27 May 2024 18:15:06 +0100
Subject: [PATCH 3/4] hw/m68k/virt: Add a pflash controller for BIOS
 firmware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-m68k-bios-v1-3-6de26552fa77@flygoat.com>
References: <20240527-m68k-bios-v1-0-6de26552fa77@flygoat.com>
In-Reply-To: <20240527-m68k-bios-v1-0-6de26552fa77@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4712;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=2B4K90KB5IO8QrMlToSRMNmgqJiaPI2aG2lLp41ikuY=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSQ/TPnSvVwLhSfJSe+5/zDe6z1jjM1rk+xZp6wT0BNy
 5fnkL9NRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExklxfD/+ITwiGnSuKTWaxX
 BV5LX9i5wY4hu2Tt9IwNX3nq5tfrHWD4XxT/VNXv2tPNkXfUV93dKMrH+W7qH1/jby8mmC6y3C1
 twwIA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=64.147.123.151;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfout8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Add a 8 MiB pflash controller for BIOS firmware, and boot
from it if possible.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/m68k/Kconfig                                   |  1 +
 hw/m68k/virt.c                                    | 44 +++++++++++++++++++++++
 include/standard-headers/asm-m68k/bootinfo-virt.h |  1 +
 3 files changed, 46 insertions(+)

diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index 4501da56ff6d..f233a5948f19 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -42,6 +42,7 @@ config M68K_VIRT
     select M68K_IRQC
     select FW_CFG_DMA
     select VIRT_CTRL
+    select PFLASH_CFI01
     select GOLDFISH_PIC
     select GOLDFISH_TTY
     select GOLDFISH_RTC
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 7590e6515ac3..a2eebc0f2243 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/guest-random.h"
 #include "sysemu/sysemu.h"
@@ -28,6 +29,7 @@
 #include "sysemu/runstate.h"
 #include "sysemu/reset.h"
 
+#include "hw/block/flash.h"
 #include "hw/intc/m68k_irqc.h"
 #include "hw/misc/virt_ctrl.h"
 #include "hw/char/goldfish_tty.h"
@@ -97,6 +99,10 @@
 #define VIRT_XHCI_MMIO_BASE 0xff020000    /* MMIO: 0xff020000 - 0xff023fff */
 #define VIRT_XHCI_IRQ_BASE  PIC_IRQ(1, 2) /* PIC: #1, IRQ: #2 */
 
+#define VIRT_PFLASH_MMIO_BASE 0xff800000      /* MMIO: 0xff800000 - 0xffffffff */
+#define VIRT_PFLASH_SIZE      0x800000        /* 8 MiB */
+#define VIRT_PFLASH_SECTOR_SIZE (128 * KiB)   /* 64 KiB */
+
 typedef struct {
     M68kCPU *cpu;
     hwaddr initial_pc;
@@ -139,6 +145,7 @@ static void virt_init(MachineState *machine)
     const char *initrd_filename = machine->initrd_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     hwaddr parameters_base;
+    DriveInfo *dinfo;
     DeviceState *dev;
     DeviceState *irqc_dev;
     DeviceState *pic_dev[VIRT_GF_PIC_NB];
@@ -165,6 +172,8 @@ static void virt_init(MachineState *machine)
     cpu = M68K_CPU(cpu_create(machine->cpu_type));
 
     reset_info->cpu = cpu;
+    reset_info->initial_pc = VIRT_PFLASH_MMIO_BASE;
+    reset_info->initial_stack = ram_size;
     qemu_register_reset(main_cpu_reset, reset_info);
 
     /* RAM */
@@ -253,6 +262,39 @@ static void virt_init(MachineState *machine)
                         PIC_GPIO(VIRT_XHCI_IRQ_BASE));
     }
 
+    /* pflash */
+    dinfo = drive_get(IF_PFLASH, 0, 0);
+    pflash_cfi01_register(VIRT_PFLASH_MMIO_BASE,
+                          "virt.pflash0",
+                           VIRT_PFLASH_SIZE,
+                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
+                           VIRT_PFLASH_SECTOR_SIZE, 4,
+                           0x89, 0x18, 0, 0, 1);
+
+    if (machine->firmware) {
+        char *fn;
+        int image_size;
+
+        if (drive_get(IF_PFLASH, 0, 0)) {
+            error_report("The contents of the first flash device may be "
+                         "specified with -bios or with -drive if=pflash... "
+                         "but you cannot use both options at once");
+            exit(1);
+        }
+        fn = qemu_find_file(QEMU_FILE_TYPE_BIOS, machine->firmware);
+        if (!fn) {
+            error_report("Could not find ROM image '%s'", machine->firmware);
+            exit(1);
+        }
+        image_size = load_image_targphys(fn, VIRT_PFLASH_MMIO_BASE,
+                                         VIRT_PFLASH_SIZE);
+        g_free(fn);
+        if (image_size < 0) {
+            error_report("Could not load ROM image '%s'", machine->firmware);
+            exit(1);
+        }
+    }
+
     if (kernel_filename) {
         CPUState *cs = CPU(cpu);
         uint64_t high;
@@ -311,6 +353,8 @@ static void virt_init(MachineState *machine)
         }
         BOOTINFO2(param_ptr, BI_VIRT_FW_CFG_BASE,
                   VIRT_FW_CFG_MMIO_BASE, VIRT_FW_CFG_IRQ_BASE);
+        BOOTINFO2(param_ptr, BI_VIRT_PFLASH_BASE,
+                    VIRT_PFLASH_MMIO_BASE, 0);
 
         if (kernel_cmdline) {
             BOOTINFOSTR(param_ptr, BI_COMMAND_LINE,
diff --git a/include/standard-headers/asm-m68k/bootinfo-virt.h b/include/standard-headers/asm-m68k/bootinfo-virt.h
index 7f90be1aa7bd..21c9a98d2912 100644
--- a/include/standard-headers/asm-m68k/bootinfo-virt.h
+++ b/include/standard-headers/asm-m68k/bootinfo-virt.h
@@ -18,6 +18,7 @@
 
 #define BI_VIRT_XHCI_BASE	0x8007
 #define BI_VIRT_FW_CFG_BASE	0x8008
+#define BI_VIRT_PFLASH_BASE	0x8009
 
 #define VIRT_BOOTI_VERSION	MK_BI_VERSION(2, 0)
 

-- 
2.43.0


