Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2EFCD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps78-00045l-Tk; Thu, 28 Mar 2024 11:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps6q-0003lr-G3
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:09 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps6o-0002J6-BG
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:07 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56c0bd07e7bso1371670a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641364; x=1712246164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fL5eL7xorZDz2tK167vrCTC41p6AHRY9fWJiDBIL8BM=;
 b=U5IWLHRodA+EjotpgdrESsIE43e6MyT3vhIRFYmFCm3+T04ngqC6DvFeGDxq8f++Ht
 Dyx6nCBUjVIdlXFCK5hg53+6LSKaaGar4XB//kbVuB1njIXpCviF0hUlMLWFSw77SS9V
 AAaTNJAiyuAdDVxaGE9KeZ4XLCL/WrUMpbKHX49gw8wdirSJs59oxw6xY3YhJdUiMNpu
 UgwgUM+PXGQq/ov+lMk6wAaZ3Yo9RuSkZoKOzGYaN+S3ApiOW1Gr2AXUjASLhGx16hf4
 DmoR8cUE3xOWfYyli6KC5XXwxt9Ns5Juj1R9gAdKQ3m+X3ODbSHki24BqpYKTGyA/OqC
 37ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641364; x=1712246164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fL5eL7xorZDz2tK167vrCTC41p6AHRY9fWJiDBIL8BM=;
 b=YTxY8OyI+XiLRDgSG8YvOG4ExJwpWJX+89YQwU4yC/LEFK0r1vVijtARIzvkzQEqFU
 /kpxZK0vSVB75DmYzMYpJU/McC7N6MZvJnqFmpheMgyxtXHEuBGBCIPPFMMYCE4HALy1
 vq90cxBT+54efPrMP27/q2+H+LVipNM2kstCEazaUOizfMBgVO0C6Jklo3Ogubjk8bQR
 S+Zi6OAhwVZRrd10BBZ+xvEmiUYLGr4NzKtgnpvfcQGB7xJ0tp0dC4LjlMAdaClXfZNB
 In7ntaDTsMgSQQwFPDrIFocyoNq2GU4r0mEerNH7OY9uEi7zsn0qSREx2S2Kj916t2tU
 f6yA==
X-Gm-Message-State: AOJu0YyioFVxYRqM51Y8O4Nbei8KyRCKadP45ZeGrQZoveSdirW1Vg2z
 TaoaOhP9fB+PmDj46x3Ur83ejIunoHAzwVFTM3Ze6xUs2t+ysEvFYqCAw/nrZlBV5WQfU3hIBKd
 7
X-Google-Smtp-Source: AGHT+IGYMyA4RPPygj+1esA4Svl7bwqA35pfEh79go4U6GODzZLQBPhA8oiV4mBtfx3NK33wxcn4Rg==
X-Received: by 2002:a50:d7d5:0:b0:56c:24e6:ca7e with SMTP id
 m21-20020a50d7d5000000b0056c24e6ca7emr2463412edj.2.1711641364572; 
 Thu, 28 Mar 2024 08:56:04 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 ev6-20020a056402540600b005682a0e915fsm970201edb.76.2024.03.28.08.56.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:56:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 13/29] hw/i386/pc: Remove non-PCI code from
 pc_system_firmware_init()
Date: Thu, 28 Mar 2024 16:54:21 +0100
Message-ID: <20240328155439.58719-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

x86_bios_rom_init() is the single non-PCI-machine call
from pc_system_firmware_init(). Extract it to the caller.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c       | 6 +++++-
 hw/i386/pc_sysfw.c | 5 +----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f184808e3e..5b96daa414 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -956,7 +956,11 @@ void pc_memory_init(PCMachineState *pcms,
     }
 
     /* Initialize PC system firmware */
-    pc_system_firmware_init(pcms, rom_memory);
+    if (pci_enabled) {
+        pc_system_firmware_init(pcms, rom_memory);
+    } else {
+        x86_bios_rom_init(machine, "bios.bin", rom_memory, true);
+    }
 
     option_rom_mr = g_malloc(sizeof(*option_rom_mr));
     memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 862a082b0a..541dcaef71 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -202,10 +202,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
     int i;
     BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
 
-    if (!pc_machine_is_pci_enabled(pcms)) {
-        x86_bios_rom_init(MACHINE(pcms), "bios.bin", rom_memory, true);
-        return;
-    }
+    assert(pc_machine_is_pci_enabled(pcms));
 
     /* Map legacy -drive if=pflash to machine properties */
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
-- 
2.41.0


