Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDED8CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNGi-0007Qg-UW; Sat, 30 Aug 2025 11:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryiQ-0001Bi-UL
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryiK-0008Or-KW
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H5XyWjtcymfCh9S1xq8Wstwa2XXrkJ5+hnuyZ3TJMF4=;
 b=QC5DT44/r0ZaXamkXRIc9u/JxDOW8XxwL5Ear01Yb/I5ZjjkpinRBGm7gvzsCexbxFtk9U
 6WO/0u/CM5A5wU0LzgGIYRoB4UjCW7Iu9f4XdQ+PeguZIW1cKGEy+arDOQTqiIJ+amxHqb
 3WTwxeXD+eQ2WKKNVMsRLLAqyx8ifx4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-FoZLBsEMOQ-Hqt9J3qTQZA-1; Fri, 29 Aug 2025 09:00:17 -0400
X-MC-Unique: FoZLBsEMOQ-Hqt9J3qTQZA-1
X-Mimecast-MFC-AGG-ID: FoZLBsEMOQ-Hqt9J3qTQZA_1756472416
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3c79f0a5ff1so922662f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472415; x=1757077215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H5XyWjtcymfCh9S1xq8Wstwa2XXrkJ5+hnuyZ3TJMF4=;
 b=whUXPPGGXRXQfTuR/eZDiszkFg9BOHQZbZrvLLpn6nTRuAbget2PkALYDI4+bfQ6w0
 7Qoz0j7Qf0u8DQRS4zXFvfB8owrK5rt6wMttNv/soK7C70yIMauom2k1FuctWyGIB7EC
 VhFMtYmTlzn8SSuSJESAz3BPd65vtRwr9xaq+NNhlAyL647Flf8rgPmbHAgr7NA23ckV
 DoyoPCS06H6tHcpz7LhwrDVW7jtYvRIhaPMtvxQXByF8CxcY6HxjqBFjjQE286DOu04H
 I7RyJ2ytELyu1n71/PRdycpOlQ6GaygpaGEVNFYB1IIbe6XQxcJ5JxOxsk/pUtkBDRqV
 YXRQ==
X-Gm-Message-State: AOJu0Yy0xVPRyhkKCMZoYrL7/atvzPxx/WWdjlv29PHsHAcJWtdSkT6Y
 77GYa8W0WXWMRhnm/dBSm+K5AK8Gq4Qi4/qpIa9JxP1Jld9VSIFpDwxil9d1UZOr52SX97UeRJ0
 UOAtVX/knz6vzq/FhMQwbHda6A/ewc2Q6ywPWsyCp2lLsHnJ2whs6JX8WM9JhM4MADUdnNBNGFL
 lB7De74IPO3nbi+VlmqL7coCymia68qHtpeBNsIZMG
X-Gm-Gg: ASbGncvULn4z3OtuTQoNMOyQu9pFydPMHNz3AKfCBIKo4ZfNBHOdzyAcbT6bKKrECvV
 +18Gk25X+j/txIOpPfi7Id4S8rtOCM0dNfr1/YwPA0AvjNKJJDuzUSLe8a0j2tOg4QDAdZ8z6eD
 xrVsOzie7uyKnVuQjtfM0CLzf7T+/KH9AKjtS9cfx7PRrONP0V2Nv9iG7XvzK3A51EVD7+AUn5K
 yLDgmZPdsZVU7H09T3Z4nFqmNPPVf0ChGV3pSaPoBdQlNnTSv/Jd6vQnrHOjW11s0VIDVGzguN8
 d5ffrCjzKPEu4fxdtLxurSfU8/JBqS/6KS1s6LU+X8YidtRbRksBVE8uOYXdzohAiGKCL6ADqvc
 YNGvOqonkBD8DgXbXaNzGtMoNT19YYFXfzjDSXZ3Osbw=
X-Received: by 2002:a05:6000:2289:b0:3c9:58b0:dad4 with SMTP id
 ffacd0b85a97d-3c958b0db85mr15058793f8f.35.1756472415467; 
 Fri, 29 Aug 2025 06:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZjB/BRd9ep+ScA2MqOT8Eq1UUz0XEjActCby77NbkoMJIeuOsI/S5OSNJmO8sagmHTw1J+w==
X-Received: by 2002:a05:6000:2289:b0:3c9:58b0:dad4 with SMTP id
 ffacd0b85a97d-3c958b0db85mr15058753f8f.35.1756472414891; 
 Fri, 29 Aug 2025 06:00:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fd01csm3455782f8f.12.2025.08.29.06.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:00:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 14/28] hw/i386/pc_piix.c: always initialise ISA IDE drives in
 pc_init_isa()
Date: Fri, 29 Aug 2025 14:59:21 +0200
Message-ID: <20250829125935.1526984-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

By definition an isapc machine must always use ISA IDE drives so ensure that they
are always enabled. At the same time also remove the surrounding CONFIG_IDE_ISA
define since it will be enabled via the ISAPC Kconfig.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250828111057.468712-15-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index fb936748bd1..72ddd9b149d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -445,6 +445,8 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
+    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    int i;
 
     /*
      * There is a small chance that someone unintentionally passes "-cpu max"
@@ -541,27 +543,20 @@ static void pc_init_isa(MachineState *machine)
 
     pc_nic_init(pcmc, isa_bus, NULL);
 
-#ifdef CONFIG_IDE_ISA
-    if (!pcmc->pci_enabled) {
-        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-        int i;
-
-        ide_drive_get(hd, ARRAY_SIZE(hd));
-        for (i = 0; i < MAX_IDE_BUS; i++) {
-            ISADevice *dev;
-            char busname[] = "ide.0";
-            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                               ide_irq[i],
-                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-            /*
-             * The ide bus name is ide.0 for the first bus and ide.1 for the
-             * second one.
-             */
-            busname[4] = '0' + i;
-            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-        }
+    ide_drive_get(hd, ARRAY_SIZE(hd));
+    for (i = 0; i < MAX_IDE_BUS; i++) {
+        ISADevice *dev;
+        char busname[] = "ide.0";
+        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                            ide_irq[i],
+                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+        /*
+         * The ide bus name is ide.0 for the first bus and ide.1 for the
+         * second one.
+         */
+        busname[4] = '0' + i;
+        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
     }
-#endif
 }
 #endif
 
-- 
2.51.0


