Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E967D31769
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 17:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8NC8-0001hi-Fg; Tue, 05 Nov 2024 12:18:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8NC7-0001hE-4H
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 12:18:19 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8NC5-0007qy-Cu
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 12:18:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso45153525e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 09:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730827095; x=1731431895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=si1GAzVFo9p7658TUKQsKQkHM9JnDZDIhZcoRXj69KM=;
 b=d6+s1AYuc/EjF0UFVJ3RhNSaj/DNdNjpcMnHakCLB9PXUDsm2134MmQd27obv017LF
 Z68J9A6TH2xBNtPF6IEbSHEqXAAIJKs8vYNVwPFCc4h/Iq6fOAsPXSH3ye/FU8ZfHAoo
 3DPlIx4qOJHKCryj0ivDEcjIfV/pIiPeYacppR/eGnD7umBo4lodCNLb8PgpylVMiqzf
 X2gSxfagk5beLowjm8TKNmaLFEyS9w02PRm4GIDZ2aIsqkskXn1fJDeHHumDlx7Blvuj
 tJcKIGt044/bYPGSXCGlZUb0wptk94kHpUnGH0XF2LNUG+riJnZjl76iO5trevS21PEX
 uR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730827095; x=1731431895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=si1GAzVFo9p7658TUKQsKQkHM9JnDZDIhZcoRXj69KM=;
 b=TEntwREauOjPTy1smLiUGzKhKxMdhwCFzZsKkPdB//RyTt7EzpKQkSJ50YOZ1ZuTsE
 sz9jV9codC2LJUipEOvby1lUeFvNGQd1CAhzaikEqpQyUXcUxTetoUbVIK8y8+RRz/zs
 yzEqW/oNZVHkE0X8vvGoIm87lJUzrWVEEibnzFX3mPfz6ZUzycagmpp88BlMYeQe5KFx
 ZOhoZGeUD1yqO94Jj+g8ubtQj5/Atrz1uoQXKXczI7IZsZe76goGnOTfcPIq6jOviOTc
 OKPAQuReZu3To6fqMfSrdiZLbpd6w+6jWIN/wElBr4ojpWjbfG4P96SAUW5m8ER9Oyap
 GrWw==
X-Gm-Message-State: AOJu0YyKg4CTnvWCdc8qcbtKtMCXbOVyOLc/9wDDCT8YMXnoyvJ6vOBt
 DIZnF6ICNK63508efKHT1PvEozcP61fgiGU2msxFxzG291l5IBGrDXylRbqV/1DClS+Wn/bl4Oz
 V
X-Google-Smtp-Source: AGHT+IFGSmz/Jy6/gaONdVJhHsv0rJnsI+bn/BrmkZNERox6s7mnYokPZp6uBuDqTgUhviOWbfuWWw==
X-Received: by 2002:a05:600c:1d1d:b0:42f:4f6:f8f3 with SMTP id
 5b1f17b1804b1-4319ac6fbf7mr323454725e9.7.1730827095190; 
 Tue, 05 Nov 2024 09:18:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd947c0esm235361215e9.24.2024.11.05.09.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 09:18:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH] hw/i386/pc: Don't try to init PCI NICs if there is no PCI bus
Date: Tue,  5 Nov 2024 17:18:13 +0000
Message-Id: <20241105171813.3031969-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The 'isapc' machine type has no PCI bus, but pc_nic_init() still
calls pci_init_nic_devices() passing it a NULL bus pointer.  This
causes the clang sanitizer to complain:

$ ./build/clang/qemu-system-i386 -M isapc
../../hw/pci/pci.c:1866:39: runtime error: member access within null pointer of type 'PCIBus' (aka 'struct PCIBus')
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/pci/pci.c:1866:39 in

This is because pci_init_nic_devices() does
 &bus->qbus
which is undefined behaviour on a NULL pointer even though we're not
actually dereferencing the pointer. (We don't actually crash as
a result, so if you aren't running a sanitizer build then there
are no user-visible effects.)

Make pc_nic_init() avoid trying to initialize PCI NICs on a non-PCI
system.

Cc: qemu-stable@nongnu.org
Fixes: 8d39f9ba14d64 ("hw/i386/pc: use qemu_get_nic_info() and pci_init_nic_devices()")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This shows up if you run "make check" on a ubsan build.
---
 hw/i386/pc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2047633e4cf..1af1a1a1823 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1251,7 +1251,9 @@ void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
     }
 
     /* Anything remaining should be a PCI NIC */
-    pci_init_nic_devices(pci_bus, mc->default_nic);
+    if (pci_bus) {
+        pci_init_nic_devices(pci_bus, mc->default_nic);
+    }
 
     rom_reset_order_override();
 }
-- 
2.34.1


