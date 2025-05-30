Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FD0C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtzQ-0007py-DD; Fri, 30 May 2025 03:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwV-000288-Mh
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwT-0006x5-Sc
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQ/BwSgwmbub3MAbN+Z00asSvuJ0Grx4VxYgqtnMhH4=;
 b=Uaa1CpZt6ifkx0IXzAvsAGB0xIUAytdLf4nWPgbD4gmxykd9b77AlVsbJziNeW4y+BKoj9
 NhQMcOL1UC+bk1FivifPmkf8u1QHYGNyjD41mnhT41xfFj8aPB9cQbPxyVpju5GCr3evuL
 hmvupDjXCaTuphHWRi06kxLwKSG5Kg4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-AfvGXiPcOu--4zqrlpv_Xw-1; Fri, 30 May 2025 03:14:10 -0400
X-MC-Unique: AfvGXiPcOu--4zqrlpv_Xw-1
X-Mimecast-MFC-AGG-ID: AfvGXiPcOu--4zqrlpv_Xw_1748589250
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-acf16746a74so115999166b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589249; x=1749194049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yQ/BwSgwmbub3MAbN+Z00asSvuJ0Grx4VxYgqtnMhH4=;
 b=qbkIwvVp2cPX5IoeD73QSw1jJyajMe8DwCYjmn8OkAstU/aJ6ja+mlbg6SeNbCvTSW
 BKM/lhAJYCWJPq5YTZDWJVlZ4/J1Wxo5rMf5wmaJMSrfyKY8zuy2eEj9FyhagHmffnBl
 i1J0jWOXCWlNc3IafJBJZraa2jmOo3JBlbx2J7JcG2r/tU7vrzc4/cA+pEFU1JCf49e3
 0bvDSU/eZjjO/+u5vwmBy2ig+4/7Mv2HuVWdberMqDPNeji/PtrTJ7sWsanwhEjVkxnk
 D+zB5uB6mM0cwyEBmhHO8ePgeRIkZ1erqlxAZvXIPfPyrj8MMts8YMJvNxlKxMjUUVjc
 mm5A==
X-Gm-Message-State: AOJu0YyUkh4BJmoaLMDoaLUgqHulb5KkbZ1NA9fOMtVzq/tLNgpiInu1
 gtziIFgj8h0bnxCYzPKrObuPgWwPCeYt6RU/HI0tnc03bQuI04cHaRl3JA1XJ6J0AJrlI1MB0IO
 1ybuxHf5iQMUNNLbcnNunXvBzjuJzkT1ykqPMt4tAiB5MA3XrnX/HQfOKJ/7CmXjkzfveXd4S7D
 WL+6aPQqyeM2zadtXLPOYruMDy7Xm4gMiL4xBsQ56+
X-Gm-Gg: ASbGnct67D+Zu2KLcNQU5BNjoVaSN6nLm6qdhQ6Nou08rGYOZJP0YeTAvQ0ycvJc3Oo
 iGQhv7bP1Nnf3q7skmRIJvVZkXkaqGxnkhdmtLWQECQHaFCToFz8xvhM3S1cELb31/z5nMjP6dY
 HdtyKT5mV5cmZYL1+h22WD3rrb4lzA3+mmhqC6JbFpMKQTOWRb6BCm3UETpTg6N1igDYND3zC3F
 HjmnFwyr0tR/tKH59+/5rcLpf4hSSmuWQUAgTzCHSCk0Ns2z0IXCJmab6tj84WwAP7lkxX+35Xo
 X6YbPNCY70ogH0UfC2d219hK
X-Received: by 2002:a17:907:2d10:b0:adb:7f8:9ecf with SMTP id
 a640c23a62f3a-adb32301978mr201455066b.45.1748589249183; 
 Fri, 30 May 2025 00:14:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrfdR58BsX73JAnqKhJP+JgvXt6woRvEY8Sd3tviy3ZJau0xYb1tWFwIiPqozjsOzyzr5h/A==
X-Received: by 2002:a17:907:2d10:b0:adb:7f8:9ecf with SMTP id
 a640c23a62f3a-adb32301978mr201452266b.45.1748589248761; 
 Fri, 30 May 2025 00:14:08 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82e88csm279235766b.62.2025.05.30.00.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 31/77] i386/tdx: Don't initialize pc.rom for TDX VMs
Date: Fri, 30 May 2025 09:12:01 +0200
Message-ID: <20250530071250.2050910-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

For TDX, the address below 1MB are entirely general RAM. No need to
initialize pc.rom memory region for TDs.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-20-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 70656157ca0..a403987a642 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -44,6 +44,7 @@
 #include "system/xen.h"
 #include "system/reset.h"
 #include "kvm/kvm_i386.h"
+#include "kvm/tdx.h"
 #include "hw/xen/xen.h"
 #include "qobject/qlist.h"
 #include "qemu/error-report.h"
@@ -976,21 +977,23 @@ void pc_memory_init(PCMachineState *pcms,
     /* Initialize PC system firmware */
     pc_system_firmware_init(pcms, rom_memory);
 
-    option_rom_mr = g_malloc(sizeof(*option_rom_mr));
-    if (machine_require_guest_memfd(machine)) {
-        memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
-                                           PC_ROM_SIZE, &error_fatal);
-    } else {
-        memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
-                               &error_fatal);
-        if (pcmc->pci_enabled) {
-            memory_region_set_readonly(option_rom_mr, true);
+    if (!is_tdx_vm()) {
+        option_rom_mr = g_malloc(sizeof(*option_rom_mr));
+        if (machine_require_guest_memfd(machine)) {
+            memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
+                                            PC_ROM_SIZE, &error_fatal);
+        } else {
+            memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
+                                &error_fatal);
+            if (pcmc->pci_enabled) {
+                memory_region_set_readonly(option_rom_mr, true);
+            }
         }
+        memory_region_add_subregion_overlap(rom_memory,
+                                            PC_ROM_MIN_VGA,
+                                            option_rom_mr,
+                                            1);
     }
-    memory_region_add_subregion_overlap(rom_memory,
-                                        PC_ROM_MIN_VGA,
-                                        option_rom_mr,
-                                        1);
 
     fw_cfg = fw_cfg_arch_create(machine,
                                 x86ms->boot_cpus, x86ms->apic_id_limit);
-- 
2.49.0


