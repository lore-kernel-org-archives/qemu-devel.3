Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75661C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 17:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBdwT-0002zx-Ql; Mon, 27 May 2024 13:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sBdwK-0002xk-Ni
 for qemu-devel@nongnu.org; Mon, 27 May 2024 13:15:18 -0400
Received: from wfhigh3-smtp.messagingengine.com ([64.147.123.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sBdwG-0004dc-Tk
 for qemu-devel@nongnu.org; Mon, 27 May 2024 13:15:15 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.west.internal (Postfix) with ESMTP id 287CB1800131;
 Mon, 27 May 2024 13:15:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Mon, 27 May 2024 13:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716830110;
 x=1716916510; bh=jvNC3cWl9R/X7w/YW3guvENAd+31abtJId4SHxU/qLQ=; b=
 CkOt7UyAWVdOclErtyI1KWuvwY43iyJLr2D+Nw3DVGQ4S23KSZlSuekHJ/smj9B5
 lCSvagXAeiEFjuVxbUR24EWYF0w2DTx8bJC8J/t5TPx88/nObjDNDlvF4GdlF7mj
 u2GqIryTY4hSeaf+72+oDYhnkQ6qaPPNfNDfdKrQZUZ+lFFtZlf2MrJXMb/fKKX8
 opWGac3/60q6Nmg1YbXrGDNAK/+Xwhu3yubjR8KCsBkB+KMsHQGRRykfjEpBkgkH
 6nArJzg3OD8tUPqWQFtkwflVNxR4svY/3k90frnLMqEbz0XFVZZ+SX5qf3XkPzO0
 aecRuZy4KjHFWaaAJp3eyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716830110; x=
 1716916510; bh=jvNC3cWl9R/X7w/YW3guvENAd+31abtJId4SHxU/qLQ=; b=M
 pK+MJGjXtk8zZ0L+OfYFLcmQAyviiWTXaGXFe2TCwRUbBHinDOXrZqWbPyEe11dy
 5XASjU8qBp/OorUiWgNh4WszmXkLUN6GqhGKLyq97Vx+1d87XIm+F1oxVmaqQyRT
 o93l+DsnHkXXjQcf4/dqZdx2jWeJBbYElvoZihckuhYI94jkD1UjxLOP4d62fgXR
 R2GC9Y6BKI2jJpxvhnKO0ch0cx9g9v46ZaIyXqhyDF7vr2SbYO2RWFTJtxY8B/QI
 5juTYHVAirWV3aiPDbFd+IgBZfFcKwbqYKViq/dK1ngl3TcnfMsXXP7djKRYIjfg
 DUNDbbqEN91C3l5BpgMuA==
X-ME-Sender: <xms:nr9UZn0ZlJjuoipaeO0R9o3C7Oyo_rS_ZbZITXYbDjXi_rCK8YtMcQ>
 <xme:nr9UZmFEJzOpWe2DEeVwpexF-ZMDcFrOjA4UhiS9c_AL5iSUlbpPc5UWfaujDdZzw
 cDe-pPvLmNmIaeIHhM>
X-ME-Received: <xmr:nr9UZn6b8y34U7bVmhafcqnPKO8LAD6JnWIWXIyOqReZ_A4smmsVg94>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedguddtlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:nr9UZs3Ud0-byd2r22kYj9dFv0LhM4FVSG27NopGJAnnTLPkbJKS3Q>
 <xmx:nr9UZqGNda7NlBZ9xVK4BJxSuAW9WcJ_x21GawSAeDHaXKSdgBrMdg>
 <xmx:nr9UZt-PnpSdd7RSVttt83Ev7onmoJPJwbAhWyVNhPsfRGaZUhmdCQ>
 <xmx:nr9UZnkt9zJGbjTSqmBIMVr04BX8oq3WZlFtp0z7d6BInDab8pLO4Q>
 <xmx:nr9UZv7X3v0xbtW5SkscdBcPkXQdXIZT9pmGhSYrJFS0JJdCzAw94bNd>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 13:15:09 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 27 May 2024 18:15:05 +0100
Subject: [PATCH 2/4] hw/m68k/virt: Add fw_cfg controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-m68k-bios-v1-2-6de26552fa77@flygoat.com>
References: <20240527-m68k-bios-v1-0-6de26552fa77@flygoat.com>
In-Reply-To: <20240527-m68k-bios-v1-0-6de26552fa77@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3889;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=WHIaU6YdNuXiaOECEnngbdVzYw5RB6CGQXmlvSk15Vk=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSQ/TMf5P7p1fmzcNtuaxHlIlPt/3/mxlb1hG/8ZMa5f
 UvotVMfO0pZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BeAmX2ZkmFtWNGXvH/5+5kam
 DLUaqZokAS+N9dn/9qXqvT1X2mNTzshwvGJT1/YFCzco+s5WP/vQWEAv169cmCMz7+PZZIutWk6
 cAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=64.147.123.154;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfhigh3-smtp.messagingengine.com
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

Add a fw_cfg controller to pass essential information
to firmware.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/m68k/Kconfig                                   |  1 +
 hw/m68k/virt.c                                    | 25 ++++++++++++++++++++++-
 include/standard-headers/asm-m68k/bootinfo-virt.h |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index 66e63cd60b57..4501da56ff6d 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -40,6 +40,7 @@ config M68K_VIRT
     default y
     depends on M68K
     select M68K_IRQC
+    select FW_CFG_DMA
     select VIRT_CTRL
     select GOLDFISH_PIC
     select GOLDFISH_TTY
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 7b3917dcbd2b..7590e6515ac3 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -42,7 +42,8 @@
  * CPU IRQ #1 -> PIC #1
  *               IRQ #1 -> virt-ctrl
  *               IRQ #2 -> xhci
- *               IRQ #3 to IRQ #31 -> unused
+ *               IRQ #3 -> fw_cfg
+ *               IRQ #4 to IRQ #31 -> unused
  *               IRQ #32 -> goldfish-tty
  * CPU IRQ #2 -> PIC #2
  *               IRQ #1 to IRQ #32 -> virtio-mmio from 1 to 32
@@ -80,6 +81,10 @@
 #define VIRT_CTRL_MMIO_BASE 0xff009000    /* MMIO: 0xff009000 - 0xff009fff */
 #define VIRT_CTRL_IRQ_BASE  PIC_IRQ(1, 1) /* PIC: #1, IRQ: #1 */
 
+/* 1 fw_cfg */
+#define VIRT_FW_CFG_MMIO_BASE 0xff00a000    /* MMIO: 0xff00a000 - 0xff00afff */
+#define VIRT_FW_CFG_IRQ_BASE  PIC_IRQ(1, 3) /* PIC: #1, IRQ: #3 */
+
 /*
  * virtio-mmio size is 0x200 bytes
  * we use 4 goldfish-pic to attach them,
@@ -116,6 +121,12 @@ static void rerandomize_rng_seed(void *opaque)
                                 be16_to_cpu(*(uint16_t *)rng_seed->data));
 }
 
+static void fw_cfg_boot_set(void *opaque, const char *boot_device,
+                            Error **errp)
+{
+    fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
+}
+
 static void virt_init(MachineState *machine)
 {
     M68kCPU *cpu = NULL;
@@ -134,6 +145,7 @@ static void virt_init(MachineState *machine)
     SysBusDevice *sysbus;
     hwaddr io_base;
     int i;
+    FWCfgState *fw_cfg;
     ResetInfo *reset_info;
     uint8_t rng_seed[32];
 
@@ -210,6 +222,15 @@ static void virt_init(MachineState *machine)
     dev = sysbus_create_simple(TYPE_VIRT_CTRL, VIRT_CTRL_MMIO_BASE,
                                PIC_GPIO(VIRT_CTRL_IRQ_BASE));
 
+    /* fw_cfg */
+    fw_cfg = fw_cfg_init_mem_wide(VIRT_FW_CFG_MMIO_BASE + 8,
+                                  VIRT_FW_CFG_MMIO_BASE, 8,
+                                  VIRT_FW_CFG_MMIO_BASE + 16,
+                                  &address_space_memory);
+    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
+    qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
+    rom_set_fw(fw_cfg);
+
     /* virtio-mmio */
     io_base = VIRT_VIRTIO_MMIO_BASE;
     for (i = 0; i < 128; i++) {
@@ -288,6 +309,8 @@ static void virt_init(MachineState *machine)
             BOOTINFO2(param_ptr, BI_VIRT_XHCI_BASE,
                     VIRT_XHCI_MMIO_BASE, VIRT_XHCI_IRQ_BASE);
         }
+        BOOTINFO2(param_ptr, BI_VIRT_FW_CFG_BASE,
+                  VIRT_FW_CFG_MMIO_BASE, VIRT_FW_CFG_IRQ_BASE);
 
         if (kernel_cmdline) {
             BOOTINFOSTR(param_ptr, BI_COMMAND_LINE,
diff --git a/include/standard-headers/asm-m68k/bootinfo-virt.h b/include/standard-headers/asm-m68k/bootinfo-virt.h
index 1700c3ada765..7f90be1aa7bd 100644
--- a/include/standard-headers/asm-m68k/bootinfo-virt.h
+++ b/include/standard-headers/asm-m68k/bootinfo-virt.h
@@ -17,6 +17,7 @@
  * #define BI_VIRT_RNG_SEED	0x8006 */
 
 #define BI_VIRT_XHCI_BASE	0x8007
+#define BI_VIRT_FW_CFG_BASE	0x8008
 
 #define VIRT_BOOTI_VERSION	MK_BI_VERSION(2, 0)
 

-- 
2.43.0


