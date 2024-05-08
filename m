Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303B4C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4de1-0004SK-UY; Wed, 08 May 2024 05:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s4ddz-0004RL-Jb
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:31:23 -0400
Received: from wfhigh3-smtp.messagingengine.com ([64.147.123.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1s4ddx-0003QV-J8
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:31:23 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.west.internal (Postfix) with ESMTP id 92AEE1800438;
 Wed,  8 May 2024 05:31:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 08 May 2024 05:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1715160675; x=1715247075; bh=jX
 3jRPM5iIHqQ+6f+7oyx5qolQ10AFd01/QIe41Fe8k=; b=oQvVfIXKdCawS9Dchj
 5gK3W336rmKUWf9/wf1gM8xLSm3EU9l6vqHoBQiGP0kWvP1u4YgwFpyRhIpnu4Hu
 NkZC/M8nsGzOMBfjjGJ2P4g6vNz0VTS6lVs7X7jVL2kM5BNrmj6mjQQg+/vcqQLd
 3g+xrMdaLPsO8gj6NdpGIjtIA1QfTjLc2E/008Rj+EkCrdH7O/I4MNJDKIjpLYZE
 P8ssnJTcW89e+7gQbbP2o+9Ozd+3i8AGo5ofc0VL1614yDhHR+YLvgfgrxXBotMe
 vmjZ4sZcK3oG75BAR/xl6maMhmQ5zVvQUAlOVmrmy7fzmuIhUq1UkEPSoTvCamkS
 sNuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1715160675; x=1715247075; bh=jX3jRPM5iIHqQ
 +6f+7oyx5qolQ10AFd01/QIe41Fe8k=; b=awV8PDCGTC1J8+/GNBek9Y+S/v4Ng
 yD2/ip0jRbi1A/TJPLUZCriPQAqPUVqAzRxvr4ZSi419uKs6j1u+oL51bIgQVtdB
 sRH/AKD3PxRKg3BL4gWVwfxL9kLVVamYxCYWRu/2OfonIcSpqCJNoPpL/6JwK1lU
 DOhbf4MOjlk6D4lUYLejWP9N8eF9peIh0hKLHypvlgmMzYFDyGJ5oxKTa4u1iCW/
 JEpvy8FAl1MlYjtnlo4DR9jOgZwK7GC9ebDAXE+X/T4wOJZ0LsnSdcg+vTV0u4A9
 ey2Y5HMHGS7onfTKnibndrHgXsXWvgRlXXdjMQ0+IXiX0lacC7SF1F+bg==
X-ME-Sender: <xms:YkY7Zkf4w-9IRqjqigLFb1NFZR44TenryDmLpve9K3r_2mZJ08yz6Q>
 <xme:YkY7ZmOc6uKQD6TLwKyUDn4h9PKd714GBklp8sZdmjxmfbZiSAvPPL0FxrNqSLb23
 YvThIN_-PJBUkqMvcg>
X-ME-Received: <xmr:YkY7ZljgCWP01G8wLBiKbJuEUXCSSeTfBYs6jUUG6GFJQ31V3cbUxbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgudeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepffetueegkedtgfejveeuvdfghfegtddvgfehudeghfegheetuedu
 heduveejtefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:Y0Y7Zp8Bx3BWYwjNn2ojtb3n7CZxgpP11aBuyMWH9k-uGuJzxwX4ig>
 <xmx:Y0Y7ZgtPCG0Em9PZybVKvpBsUeywj2P7dNMkqkoduPr8WkLBDJty-Q>
 <xmx:Y0Y7ZgEmmMxo5H8He_NhXhOEnB5yC1RmxxdvHIiqPhVHZpJZpxuyZg>
 <xmx:Y0Y7ZvOldijfSqpRU2In0Ssurq9y4yQxo24AR2AxoCq20vvfTpR3vA>
 <xmx:Y0Y7ZiLgbSae07ONv5LPOQiq4iW9AgbLe52Q1oozaKXc8UpsF2tj0wck>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 05:31:14 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 08 May 2024 10:31:09 +0100
Subject: [PATCH] hw/mips/loongson3_virt: Emulate suspend function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-loongson3v-suspend-v1-1-186725524a39@flygoat.com>
X-B4-Tracking: v=1; b=H4sIAFxGO2YC/x3MQQqAIBBA0avErBM0K6qrRAvLqQZiFIciiO6et
 HyL/x8QTIQCQ/FAwouEAmeYsoBld7yhIp8Nla5q3ehOHSHwJoHtpeSUiOzV4r21zrQ9uhlyGBO
 udP/TcXrfDy3j74VkAAAA
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3530;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=FjgEq9nv9Wu3tjTBtpf2KLynllfJpuMeOVdE3qC7pik=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjRrt+SME+z2uxyU9SNWxkRv1Z34ZcuuqhMSN+0vcop0X
 f55tuJpRykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzEcCUjQ0viQelH8+w/1TVo
 SjFfe/r3Qkz0LDfvCg6pnbZn1e98qGdkmH239HCnAne21b4wsXMsBl0fHLjEK7caGnD92dM1+RY
 XDwA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
Received-SPF: pass client-ip=64.147.123.154;
 envelope-from=jiaxun.yang@flygoat.com; helo=wfhigh3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Suspend function is emulated as what hardware actually do.
Doorbell register fields are updates to include suspend value,
suspend vector is encoded in firmware blob and fw_cfg is updated
to include S3 bits as what x86 did.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/mips/loongson3_bootp.c |  1 +
 hw/mips/loongson3_virt.c  | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/hw/mips/loongson3_bootp.c b/hw/mips/loongson3_bootp.c
index f99af229327a..03a10b63c1b4 100644
--- a/hw/mips/loongson3_bootp.c
+++ b/hw/mips/loongson3_bootp.c
@@ -148,4 +148,5 @@ void init_reset_system(struct efi_reset_system_t *reset)
     reset->Shutdown = cpu_to_le64(0xffffffffbfc000a8);
     reset->ResetCold = cpu_to_le64(0xffffffffbfc00080);
     reset->ResetWarm = cpu_to_le64(0xffffffffbfc00080);
+    reset->DoSuspend = cpu_to_le64(0xffffffffbfc000d0);
 }
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 33eae01eca2b..f06518ad8f54 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -127,6 +127,9 @@ static void loongson3_pm_write(void *opaque, hwaddr addr,
     case 0x00:
         qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         return;
+    case 0x01:
+        qemu_system_suspend_request();
+        return;
     case 0xff:
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         return;
@@ -250,6 +253,17 @@ static void init_boot_rom(void)
         0x240D00FF,   /* li      t1, 0xff                                     */
         0xA18D0000,   /* sb      t1, (t0)                                     */
         0x1000FFFF,   /* 1:  b   1b                                           */
+        0x00000000,   /* nop                                                  */
+                      /* Suspend                                              */
+        0x3C0C9000,   /* dli     t0, 0x9000000010080010                       */
+        0x358C0000,
+        0x000C6438,
+        0x358C1008,
+        0x000C6438,
+        0x358C0010,
+        0x240D0001,   /* li      t1, 0x01                                     */
+        0xA18D0000,   /* sb      t1, (t0)                                     */
+        0x03e00008,   /* jr      ra                                           */
         0x00000000    /* nop                                                  */
     };
 
@@ -274,6 +288,10 @@ static void fw_conf_init(unsigned long ram_size)
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
     fw_cfg_add_i32(fw_cfg, FW_CFG_MACHINE_VERSION, 1);
     fw_cfg_add_i64(fw_cfg, FW_CFG_CPU_FREQ, get_cpu_freq_hz());
+
+    uint8_t suspend[6] = {128, 0, 0, 129, 128, 128};
+    fw_cfg_add_file(fw_cfg, "etc/system-states", g_memdup(suspend, 6), 6);
+
     qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
 }
 
@@ -551,6 +569,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
                            machine->ram, 0, virt_memmap[VIRT_LOWMEM].size);
     memory_region_init_io(iomem, NULL, &loongson3_pm_ops,
                            NULL, "loongson3_pm", virt_memmap[VIRT_PM].size);
+    qemu_register_wakeup_support();
 
     memory_region_add_subregion(address_space_mem,
                       virt_memmap[VIRT_LOWMEM].base, ram);

---
base-commit: d762bf97931b58839316b68a570eecc6143c9e3e
change-id: 20240508-loongson3v-suspend-cdd33a169eab

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>


