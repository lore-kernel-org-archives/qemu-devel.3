Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F368AC54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAbp-0002Zh-SD; Tue, 12 Mar 2024 18:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbY-0001vV-Lw
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbW-0004Wf-Df
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yc5lDH4MBP7afzT8lUJV0jnq7XYBGeFbKEEd+01/J0E=;
 b=hrAuymyFnI2ceU7nrKX5i05nsgnp2gUo4JiE0IaAeSb1cxE9/Cz4+es21uCYhjuXJpT9EZ
 ixHJe+qUZveT3X0/DVZNwPDb1tI7nlTOrBlelTAeiilK1yPuEmVtpxf6Gc6xjRV3Dv6OLo
 aik9zbStegQmF8rwa60Y7mKgnGQ+BxE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-RdPBmW4qNKq1xRnc8CPGBw-1; Tue, 12 Mar 2024 18:28:12 -0400
X-MC-Unique: RdPBmW4qNKq1xRnc8CPGBw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-564fec337b1so275606a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282491; x=1710887291;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yc5lDH4MBP7afzT8lUJV0jnq7XYBGeFbKEEd+01/J0E=;
 b=OuLcnMGJR5ulTtNSfXqD9bX9CRjKlN8OzQyRK51O/vVpzk1uoPsRCVAcokqqVy1KRX
 r00ScNMK7+hepmY+lT8hDGScKCwRWb5xH6IlLLr3r1EZn2rZN+BP9sVx83dVd0xV1zJz
 7HwyburdebV+lqNBBWbDUSwv6dZbs8584Tv+8CUK5CAmY7DL8top6+vakozLz4aVcvK3
 OcoV8u+sun2wQrwgaxpPE6WMOmCpXlbiJNKRv1YPSN8V+IKX08LiHgjwBX/aB0L8CVpI
 0p4y2DoWUeA1rVlrbGBmVFdF+NLKDJfTvhbejVndlxGuF7Xi8rKQibHR/95ItDyofRKd
 3rOg==
X-Gm-Message-State: AOJu0YyevzrnJrLw6PvdQUOBu+rgvxNQ48CeFVf9X4aDTlsyoR7xKt+H
 M7XI/ANHtmgNGP/w+2d6voD4ml7lP7YTFc7ppzb9rCtFPxnTqxjPfhqupSueVtSNRueAtdkQsX1
 Q1q5Jl89rNyfCWmJNrTbhoTRJ1hV8FlMGiDpU0HbQE5xEKwnp9QyfFbplA/8IToeXawf109zmil
 1fyPJIHXWeh8/Tz4djvahxXy2TQ74XGW6+
X-Received: by 2002:a50:8a93:0:b0:564:4211:faa3 with SMTP id
 j19-20020a508a93000000b005644211faa3mr923758edj.1.1710282491176; 
 Tue, 12 Mar 2024 15:28:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSg5Lt1vagvNktxkbfgl4aek3QdcvJCB+GRRByMcf7WDNYhy5GaDCN0nWebKUYDvUL/2OreQ==
X-Received: by 2002:a50:8a93:0:b0:564:4211:faa3 with SMTP id
 j19-20020a508a93000000b005644211faa3mr923716edj.1.1710282490660; 
 Tue, 12 Mar 2024 15:28:10 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 b2-20020aa7c902000000b00564e489ce9asm4412356edt.12.2024.03.12.15.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:28:10 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:28:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 49/68] Revert "hw/i386/pc: Confine system flash handling to
 pc_sysfw"
Message-ID: <f2cb9f34ad8591a7530ecec856f2302bb3efd71e.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

Specifying the property `-M pflash0` results in a regression:
  qemu-system-x86_64: Property 'pc-q35-9.0-machine.pflash0' not found
Revert the change for now until a solution is found.

This reverts commit 6f6ad2b24582593d8feb00434ce2396840666227.

Reported-by: Volker Rümelin <vr_qemu@t-online.de>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20240226215909.30884-3-shentey@gmail.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/pc.h | 2 ++
 hw/i386/pc.c         | 1 +
 hw/i386/pc_piix.c    | 1 +
 hw/i386/pc_sysfw.c   | 6 ++----
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index b958023187..8458487a5e 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -190,6 +190,8 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
 #define TYPE_PORT92 "port92"
 
 /* pc_sysfw.c */
+void pc_system_flash_create(PCMachineState *pcms);
+void pc_system_flash_cleanup_unused(PCMachineState *pcms);
 void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
 bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
                                int *data_len);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f5ff970acf..24e8879894 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1750,6 +1750,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->fd_bootchk = true;
     pcms->default_bus_bypass_iommu = false;
 
+    pc_system_flash_create(pcms);
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
     object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
                               OBJECT(pcms->pcspk), "audiodev");
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 319bc4b180..9dd9f5562e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -228,6 +228,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
 
+        pc_system_flash_cleanup_unused(pcms);
         if (machine->kernel_filename != NULL) {
             /* For xen HVM direct kernel boot, load linux here */
             xen_load_linux(pcms);
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index b9c1eb352d..3efabbbab2 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -91,7 +91,7 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
     return PFLASH_CFI01(dev);
 }
 
-static void pc_system_flash_create(PCMachineState *pcms)
+void pc_system_flash_create(PCMachineState *pcms)
 {
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
 
@@ -103,7 +103,7 @@ static void pc_system_flash_create(PCMachineState *pcms)
     }
 }
 
-static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
+void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 {
     char *prop_name;
     int i;
@@ -210,8 +210,6 @@ void pc_system_firmware_init(PCMachineState *pcms,
         return;
     }
 
-    pc_system_flash_create(pcms);
-
     /* Map legacy -drive if=pflash to machine properties */
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
         pflash_cfi01_legacy_drive(pcms->flash[i],
-- 
MST


