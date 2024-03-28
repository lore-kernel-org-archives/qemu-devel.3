Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7229CD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 16:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps7X-0004n4-8V; Thu, 28 Mar 2024 11:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps6w-0003wg-Sf
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:17 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps6v-0002MF-4v
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:14 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-513e6777af4so1700414e87.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641371; x=1712246171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmBHuqnVEd7WMmkqyo1h18jdjcgOKQnVi/P8Phxm0vQ=;
 b=fzEr0irz5PJAPfF76k6gmP/7JU5ZehUhXTXtSzwvvpD79CxYiFu0aj1GtclTzaf98f
 AgPi27XB5szUYkWnv5nqrSbsiF9uZo7bItB07Wse95kCdSyje9uI0vR27jKqiVfpcVSn
 efHfnFueRmKNnlrfLNYArW0YJT8uAJ0ZZW3D9vMal/DMq8zr/Eb3EP87a6leOeKqCyLX
 wjQR9Aa7AGP/5sVI4kHqXp27B6s1OHo49WWSprlGPRz8obBNX2S66MViogAaNEQnErQf
 7X5wgmaMgk2mrsoYGVoTRfAGxNciMyamaUs4OT/ze+PB6SNKGDM7+eH4Ouc9R8dIWvx9
 /Hxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641371; x=1712246171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tmBHuqnVEd7WMmkqyo1h18jdjcgOKQnVi/P8Phxm0vQ=;
 b=YPTbbBeAUFwwbhB2ZZjdUeYAuIwn8b7OTTDc1BoNyK6Tgq0hXB3aDx3POBmCTLBacj
 e9JkJ34vXGHrL21Ew4/sjaGRptcHT0AKd+5vgkPBOT6uldsW30rlAY+DAPzwtLGc5qBW
 +b9yRU0GJi7ibRHhfQUG+iSDh4sSjIgKtEtoo8kV8Wfwy/O5fWu3gxhP/2OmUvrL4SoJ
 didUCiip5PZNo/62p7dUvKWsX6CtTvmZe/9iz4eNGEQheOfieMkIkeDKF1iZDn/MtuXW
 8JEXMJeGPSh3j8UdIf2hDMvPNXwtHzizWmT30oGfb012i8ZJ6fFufvyYZTJBwMlCoe5s
 IweQ==
X-Gm-Message-State: AOJu0YwM+r/QWY+16TDvBLb0hf6tmjpu9Qydm1NmjrKfX/VobTSApUJc
 OapJjPq7H8xjcxhY3Xr1Nd3E2yZ58SmvbRcRwyTW2WSEirG2ZtcZtS8zWRoIj/dCP1gQxAAJVcV
 R
X-Google-Smtp-Source: AGHT+IFUtefnyMETNOsHVcJ8GlW5rJsH0GdNooS/V5PGz6OttTSyM+Vcg71L2tN7ryhsnM23ZMka+w==
X-Received: by 2002:ac2:489c:0:b0:515:af1f:5bad with SMTP id
 x28-20020ac2489c000000b00515af1f5badmr2600673lfc.28.1711641370819; 
 Thu, 28 Mar 2024 08:56:10 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 ds17-20020a170907725100b00a471b5b25b9sm887001ejc.127.2024.03.28.08.56.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:56:10 -0700 (PDT)
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
Subject: [RFC PATCH-for-9.1 14/29] hw/i386/pc: Move pc_system_flash_create()
 to pc_pci_machine_initfn()
Date: Thu, 28 Mar 2024 16:54:22 +0100
Message-ID: <20240328155439.58719-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

pc_system_flash_create() is only useful for PCI-based machines.
Move the call to the PCI-based init() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c       |  2 +-
 hw/i386/pc_sysfw.c | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5b96daa414..33724791fd 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1679,7 +1679,6 @@ static void pc_machine_initfn(Object *obj)
     pcms->fd_bootchk = true;
     pcms->default_bus_bypass_iommu = false;
 
-    pc_system_flash_create(pcms);
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
     object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
                               OBJECT(pcms->pcspk), "audiodev");
@@ -1694,6 +1693,7 @@ static void pc_pci_machine_initfn(Object *obj)
 
     ppms->acpi_build_enabled = true;
 
+    pc_system_flash_create(PC_MACHINE(obj));
     cxl_machine_init(obj, &ppms->cxl_devices_state);
 
     ppms->machine_done.notify = pc_pci_machine_done;
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 541dcaef71..167ff24fcb 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -93,12 +93,10 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
 
 void pc_system_flash_create(PCMachineState *pcms)
 {
-    if (pc_machine_is_pci_enabled(pcms)) {
-        pcms->flash[0] = pc_pflash_create(pcms, "system.flash0",
-                                          "pflash0");
-        pcms->flash[1] = pc_pflash_create(pcms, "system.flash1",
-                                          "pflash1");
-    }
+    assert(pc_machine_is_pci_enabled(pcms));
+
+    pcms->flash[0] = pc_pflash_create(pcms, "system.flash0", "pflash0");
+    pcms->flash[1] = pc_pflash_create(pcms, "system.flash1", "pflash1");
 }
 
 void pc_system_flash_cleanup_unused(PCMachineState *pcms)
-- 
2.41.0


