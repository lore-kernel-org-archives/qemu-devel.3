Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F63C54E5C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYA3-00071f-48; Fri, 08 Mar 2024 06:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYA1-0006yL-0i
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:09 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riY9z-0001fM-4S
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:08 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dca3951ad9so15460535ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896385; x=1710501185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nKUnQpiqEsfkuxpcBtNOoRuARAYL0hyyjMYpQNS/5lA=;
 b=dwEDRWEetMgtrAha/qn+J3Vy3UNv2Jbqxm+mG4asXGANVf19i/n2XRzaIP1NeKLyG8
 IyxBJO6sIfCgmqo0zQVPcRETNFWC3Jtgb1SUcJlU4NjHKhKHUh1uSd64sp/cdodaPHEt
 xTSPtPpEPiR4IkY1q0qYHKTddyORK2p/IhexF56P0XWq4c9tFZlOJzpUQqt1Zd6LLlJD
 aEaZqJDa4vWKqzVQBfIqZipQ61wsRpeGAwgpJoYTg8n2gNEtBjw7Zoo6ZL0O57y6jtSl
 COBoJK3tP39OcdCnHXxMDOI4SLoJenCFBCJt82R5ZDwMzms3pIrA2sUxECrNzScWWTsl
 QgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896385; x=1710501185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nKUnQpiqEsfkuxpcBtNOoRuARAYL0hyyjMYpQNS/5lA=;
 b=buo3hTT7r29BG1fePnI//MGeNgMeEGJxgBzpmliHLE41vf4Z9VRQQmzR46z9frMIUY
 CUKTLZTKxlBq9iCBDNsRhorvdkIVMXQCtPMeMWMpafRIjkNdxvEcZf5BoltwUBpIKSSG
 fkiT2UwTkTEAf1qEbcCp45K+RaaWmfguGqrQm0SMKWSp/Ze6syjYHiUu+5EhM7luW74d
 DPqUupR9tUEvGZEt1s+8eWQsxOioI74c3lBW2DSsTJZxnlLpUf22laeVIEgqdadp1mey
 kXLoBy3H7lZjxNxK5cz0mkXjhD5HO2/gM5kA+zalkSP6Eoses8Wsk7E5peuRFhqdZOxW
 lTDA==
X-Gm-Message-State: AOJu0Yy9uq3m+CBmak/fEcVz7xQHX3C5VzlbDBsZV+07WdkZZ7VWY++U
 r9+XTHhz+9dW1kmaCZQXvPgtpVcCgew8SFke+HD5sK1WLzSGZQpGZp7yYojSzJJk8g==
X-Google-Smtp-Source: AGHT+IH7GLsOfktZbMKNqSq4oQIvo5b1hUpWOvkv564sjyYh4BXg5u0geNCNzuqcUYAAIet5BnCiDg==
X-Received: by 2002:a17:902:e747:b0:1dd:5f85:1197 with SMTP id
 p7-20020a170902e74700b001dd5f851197mr3273578plf.64.1709896385259; 
 Fri, 08 Mar 2024 03:13:05 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:13:04 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/34] hw/riscv/virt.c: make aclint compatible with 'qtest'
 accel
Date: Fri,  8 Mar 2024 21:11:37 +1000
Message-ID: <20240308111152.2856137-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The 'virt' machine makes assumptions on the Advanced Core-Local
Interruptor, or aclint, based on 'tcg_enabled()' conditionals.  This
will impact MSI related tests support when adding a RISC-V 'virt' libqos
machine. The accelerator used in that case, 'qtest', isn't being
accounted for and we'll error out if we try to enable aclint.

Create a new virt_aclint_allowed() helper to gate the aclint code
considering both TCG and 'qtest' accelerators. The error message is
left untouched, mentioning TCG only, because we don't expect the
regular user to be aware of 'qtest'.

We want to add 'qtest' support for aclint only, leaving the TCG specific
bits out of it. This is done by changing the current format we use
today:

if (tcg_enabled()) {
   if (s->have_aclint) { - aclint logic - }
   else { - non-aclint, TCG logic - }
}

into:

if (virt_aclint_allowed() && s->have_aclint) {
 - aclint logic -
} else if (tcg_enabled()) {
 - non-aclint, TCG logic -
}

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240217192607.32565-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 52 +++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 54ad809b44..a094af97c3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -48,6 +48,7 @@
 #include "sysemu/tcg.h"
 #include "sysemu/kvm.h"
 #include "sysemu/tpm.h"
+#include "sysemu/qtest.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/display/ramfb.h"
@@ -61,6 +62,11 @@ static bool virt_use_kvm_aia(RISCVVirtState *s)
     return kvm_irqchip_in_kernel() && s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
 }
 
+static bool virt_aclint_allowed(void)
+{
+    return tcg_enabled() || qtest_enabled();
+}
+
 static const MemMapEntry virt_memmap[] = {
     [VIRT_DEBUG] =        {        0x0,         0x100 },
     [VIRT_MROM] =         {     0x1000,        0xf000 },
@@ -725,14 +731,12 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
 
         create_fdt_socket_memory(s, memmap, socket);
 
-        if (tcg_enabled()) {
-            if (s->have_aclint) {
-                create_fdt_socket_aclint(s, memmap, socket,
-                    &intc_phandles[phandle_pos]);
-            } else {
-                create_fdt_socket_clint(s, memmap, socket,
-                    &intc_phandles[phandle_pos]);
-            }
+        if (virt_aclint_allowed() && s->have_aclint) {
+            create_fdt_socket_aclint(s, memmap, socket,
+                                     &intc_phandles[phandle_pos]);
+        } else if (tcg_enabled()) {
+            create_fdt_socket_clint(s, memmap, socket,
+                                    &intc_phandles[phandle_pos]);
         }
     }
 
@@ -1409,7 +1413,7 @@ static void virt_machine_init(MachineState *machine)
         exit(1);
     }
 
-    if (!tcg_enabled() && s->have_aclint) {
+    if (!virt_aclint_allowed() && s->have_aclint) {
         error_report("'aclint' is only available with TCG acceleration");
         exit(1);
     }
@@ -1446,23 +1450,22 @@ static void virt_machine_init(MachineState *machine)
                                 hart_count, &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
 
-        if (tcg_enabled()) {
-            if (s->have_aclint) {
-                if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
-                    /* Per-socket ACLINT MTIMER */
-                    riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
+        if (virt_aclint_allowed() && s->have_aclint) {
+            if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
+                /* Per-socket ACLINT MTIMER */
+                riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
                             i * RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                         RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
                         base_hartid, hart_count,
                         RISCV_ACLINT_DEFAULT_MTIMECMP,
                         RISCV_ACLINT_DEFAULT_MTIME,
                         RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
-                } else {
-                    /* Per-socket ACLINT MSWI, MTIMER, and SSWI */
-                    riscv_aclint_swi_create(memmap[VIRT_CLINT].base +
+            } else {
+                /* Per-socket ACLINT MSWI, MTIMER, and SSWI */
+                riscv_aclint_swi_create(memmap[VIRT_CLINT].base +
                             i * memmap[VIRT_CLINT].size,
                         base_hartid, hart_count, false);
-                    riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
+                riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
                             i * memmap[VIRT_CLINT].size +
                             RISCV_ACLINT_SWI_SIZE,
                         RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
@@ -1470,21 +1473,20 @@ static void virt_machine_init(MachineState *machine)
                         RISCV_ACLINT_DEFAULT_MTIMECMP,
                         RISCV_ACLINT_DEFAULT_MTIME,
                         RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
-                    riscv_aclint_swi_create(memmap[VIRT_ACLINT_SSWI].base +
+                riscv_aclint_swi_create(memmap[VIRT_ACLINT_SSWI].base +
                             i * memmap[VIRT_ACLINT_SSWI].size,
                         base_hartid, hart_count, true);
-                }
-            } else {
-                /* Per-socket SiFive CLINT */
-                riscv_aclint_swi_create(
+            }
+        } else if (tcg_enabled()) {
+            /* Per-socket SiFive CLINT */
+            riscv_aclint_swi_create(
                     memmap[VIRT_CLINT].base + i * memmap[VIRT_CLINT].size,
                     base_hartid, hart_count, false);
-                riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
+            riscv_aclint_mtimer_create(memmap[VIRT_CLINT].base +
                         i * memmap[VIRT_CLINT].size + RISCV_ACLINT_SWI_SIZE,
                     RISCV_ACLINT_DEFAULT_MTIMER_SIZE, base_hartid, hart_count,
                     RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
                     RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, true);
-            }
         }
 
         /* Per-socket interrupt controller */
-- 
2.44.0


