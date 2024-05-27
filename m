Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381ACC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 17:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBdwQ-0002zT-OU; Mon, 27 May 2024 13:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sBdwM-0002yD-V6
 for qemu-devel@nongnu.org; Mon, 27 May 2024 13:15:18 -0400
Received: from wfhigh3-smtp.messagingengine.com ([64.147.123.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sBdwG-0004dO-JB
 for qemu-devel@nongnu.org; Mon, 27 May 2024 13:15:18 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.west.internal (Postfix) with ESMTP id F294F1800110;
 Mon, 27 May 2024 13:15:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Mon, 27 May 2024 13:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716830108;
 x=1716916508; bh=hYYUXh07/gcoXF51WzyMOORAJzyXrEZcGGa7G4S/qJM=; b=
 Unrv661kj8kfAT4BKmuCw9HE+V/+Tjdmw6p2GaDTLYpDD5hozbLpez4RrylRBkcG
 syTtZZGcc3RCO/f5xZ1McVMQM+ABtHOFFhrm7Bw6E/mzVY+QsuJM6M1AP1TPu3E+
 0q2VKD1C2ZGBSj6poEx3p5gi9gcCNAuroCfjwL3o7zs+WEf9789F1tqN0z5tzOoq
 UH7JT95pGnvl9jJNPHjxDqAYdKNLDIHogvrkW7RY0OM4vbLiKge/cuTK5/rafSLY
 wACg9m8ME13mvQSoSZmrcrdD15gZ8UL7vxwpiEoeuo63x7xbl4BjoJChMViAr2xQ
 zf08xYqD8AFkIjzofU522w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716830108; x=
 1716916508; bh=hYYUXh07/gcoXF51WzyMOORAJzyXrEZcGGa7G4S/qJM=; b=V
 5y6XDXLNce7gPGnUkLVqd5/wfOXw42OI8GOWD0X2zGlx3HXUfVdNn5r3ZLQ2ICl4
 YohjUynO1M8kGMdMKgjygqIa8QPJogHQ287on+yi3/g995kE7IUaBRJzxjboeb5C
 /9qhR3B0NpmApAMxzoX7DI8J9Y0duoWCzXeis1TarMmFn66AVT5WFU7RJyepyVGj
 c7bEjdJgVdEpE+JsZi/UY71nLWANwLnY0PSEpLJKKijurJcIbUhUE80r5zzRf0qr
 NB/PV+wLXNC7ZJrpLog2rujrsyAxgnNpWMrQiGPnvhBJ1a+FjA5dNcpvS20AL10+
 DQreKhnSpNEBk+cqm0gRQ==
X-ME-Sender: <xms:nL9UZnHQGvif13jDH2bQiYLQxXfiOixhOWPTPkjLNxUx3DkqHooJtA>
 <xme:nL9UZkVi0ijcVGFgIjRrAommviJ4aay5BIizCKZE0fIEy3r6iUXQGKI9NQzX1vyHz
 wyry5r60y3ZK4UPwOA>
X-ME-Received: <xmr:nL9UZpIt2sp4gKMUqiGhtb5EUe-BihT_v1HvSZPPusFieCkjZQiKsUE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedguddtkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:nL9UZlH_UUdPKo66lhcUYSymp4nH2aEzog3recb1C72wzQ1Mg_ilWA>
 <xmx:nL9UZtU_POKzw7ul4_O6F6R8tWgeYvKUQ3e6CFycTLeyMoVHn1ILPw>
 <xmx:nL9UZgMoQ4QmmIkQvFzsTGiEHjm5J4ZIZ5qzo65HY12r68EfmUpMPg>
 <xmx:nL9UZs1M7JWtqRPJX4NlBssEu4lNBhSMPp_9RQna7Re8aB_w_gY2JQ>
 <xmx:nL9UZvIzEbO3eT7s8vDr6g38qj5dRlmuGkH1gmVdfq_u38uMvgbRQXl->
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 13:15:07 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 27 May 2024 18:15:04 +0100
Subject: [PATCH 1/4] hw/m68k/virt: Add a XHCI controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-m68k-bios-v1-1-6de26552fa77@flygoat.com>
References: <20240527-m68k-bios-v1-0-6de26552fa77@flygoat.com>
In-Reply-To: <20240527-m68k-bios-v1-0-6de26552fa77@flygoat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3672;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=meVJ+Hif6qYmAV3H2p1MdJpBK1pNp/dXQjk1XyRz74k=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrSQ/TNfLGCflM33ef3eq4G+a00OPzPlFRe70t1rt8/yp
 +W6vyuMOkpZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAiylsY/ilP7N1ek7KfLTmm
 pPeIyLkFnbdUUoW3/XCe02Ju1JXMpM3IsHH+YfbM0z+l6o5P2zMzU6UqlqNNodiw8Jkmn5iWyrI
 aNgA=
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

VirtIO is somewhat limited on the diversity of devices.
We lack proper audio, webcam and so on support on m68k virt machine.

This can be improved by providing a XHCI controller, which enables
provision of many different discoverable devices.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/m68k/Kconfig                                   |  1 +
 hw/m68k/virt.c                                    | 22 +++++++++++++++++++++-
 include/standard-headers/asm-m68k/bootinfo-virt.h |  2 ++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index 0092cda4e9c8..66e63cd60b57 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -44,4 +44,5 @@ config M68K_VIRT
     select GOLDFISH_PIC
     select GOLDFISH_TTY
     select GOLDFISH_RTC
+    select USB_XHCI_SYSBUS
     select VIRTIO_MMIO
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 09bc9bdfefb2..7b3917dcbd2b 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -33,13 +33,16 @@
 #include "hw/char/goldfish_tty.h"
 #include "hw/rtc/goldfish_rtc.h"
 #include "hw/intc/goldfish_pic.h"
+#include "hw/usb/hcd-xhci-sysbus.h"
 #include "hw/virtio/virtio-mmio.h"
 #include "hw/virtio/virtio-blk.h"
 
 /*
  * 6 goldfish-pic for CPU IRQ #1 to IRQ #6
  * CPU IRQ #1 -> PIC #1
- *               IRQ #1 to IRQ #31 -> unused
+ *               IRQ #1 -> virt-ctrl
+ *               IRQ #2 -> xhci
+ *               IRQ #3 to IRQ #31 -> unused
  *               IRQ #32 -> goldfish-tty
  * CPU IRQ #2 -> PIC #2
  *               IRQ #1 to IRQ #32 -> virtio-mmio from 1 to 32
@@ -86,6 +89,9 @@
 #define VIRT_VIRTIO_MMIO_BASE 0xff010000     /* MMIO: 0xff010000 - 0xff01ffff */
 #define VIRT_VIRTIO_IRQ_BASE  PIC_IRQ(2, 1)  /* PIC: 2, 3, 4, 5, IRQ: ALL */
 
+#define VIRT_XHCI_MMIO_BASE 0xff020000    /* MMIO: 0xff020000 - 0xff023fff */
+#define VIRT_XHCI_IRQ_BASE  PIC_IRQ(1, 2) /* PIC: #1, IRQ: #2 */
+
 typedef struct {
     M68kCPU *cpu;
     hwaddr initial_pc;
@@ -216,6 +222,16 @@ static void virt_init(MachineState *machine)
         io_base += 0x200;
     }
 
+    /* xhci */
+    if (machine_usb(machine)) {
+        dev = qdev_new(TYPE_XHCI_SYSBUS);
+        qdev_prop_set_uint32(dev, "intrs", 1);
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, VIRT_XHCI_MMIO_BASE);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                        PIC_GPIO(VIRT_XHCI_IRQ_BASE));
+    }
+
     if (kernel_filename) {
         CPUState *cs = CPU(cpu);
         uint64_t high;
@@ -268,6 +284,10 @@ static void virt_init(MachineState *machine)
                   VIRT_CTRL_MMIO_BASE, VIRT_CTRL_IRQ_BASE);
         BOOTINFO2(param_ptr, BI_VIRT_VIRTIO_BASE,
                   VIRT_VIRTIO_MMIO_BASE, VIRT_VIRTIO_IRQ_BASE);
+        if (machine_usb(machine)) {
+            BOOTINFO2(param_ptr, BI_VIRT_XHCI_BASE,
+                    VIRT_XHCI_MMIO_BASE, VIRT_XHCI_IRQ_BASE);
+        }
 
         if (kernel_cmdline) {
             BOOTINFOSTR(param_ptr, BI_COMMAND_LINE,
diff --git a/include/standard-headers/asm-m68k/bootinfo-virt.h b/include/standard-headers/asm-m68k/bootinfo-virt.h
index 75ac6bbd7d73..1700c3ada765 100644
--- a/include/standard-headers/asm-m68k/bootinfo-virt.h
+++ b/include/standard-headers/asm-m68k/bootinfo-virt.h
@@ -16,6 +16,8 @@
 /* No longer used -- replaced with BI_RNG_SEED -- but don't reuse this index:
  * #define BI_VIRT_RNG_SEED	0x8006 */
 
+#define BI_VIRT_XHCI_BASE	0x8007
+
 #define VIRT_BOOTI_VERSION	MK_BI_VERSION(2, 0)
 
 #endif /* _UAPI_ASM_M68K_BOOTINFO_MAC_H */

-- 
2.43.0


