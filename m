Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D197C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyIC-00011c-A0; Tue, 13 Feb 2024 14:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rZyIA-0000xW-Hi
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:18:06 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rZyI8-0001sD-Vj
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:18:06 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d8aadc624dso35199615ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 11:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1707851883; x=1708456683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQZdlA+J2exDC9wjNiFgijFm8SaLmaYBocZ9xASmStk=;
 b=Aq3tYS6ObR10N4iX3CSdRNGtrkHy2Z/AOA9bxqwokQiLbKSH8weeMA4WSbuuvJ0Fi3
 5Nt1jqQUkpKwAu6JIwr3xnQBvYn+IwDEeNfT0jcmbkPT31IE6xyj9Roiu+PBIYm7yh/w
 BlbASm+z6ru8As7T9XaZqgN9soEMkLcUwEfToA8uqRAwJjchIuR77/pCl7U1kvj+Qirh
 l1099jdrUbeBkbm2QsYi2bsD9syUVRO5vbnEtaW8pxv2dxr+dJ6ul/p6G0i//WWppVpP
 07jj+oIWBb/dF8OH/B3ezi0XwsN37ND/Rdp0y8KN+fPEWNTVPK+VIV+dbc5su9DJ5Bgd
 uimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707851883; x=1708456683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JQZdlA+J2exDC9wjNiFgijFm8SaLmaYBocZ9xASmStk=;
 b=Ug9Sua3xztJbeoI4sWwpGWqKiNt1gLPvu/f2+gEFR6ABqET64tMNF1m9TOEjCO3fEC
 4MW3Xiv3Hc4qCBVMXI1Je745nk40nTPTgna+OJ9z2LyTHz8tg4yTWN7vFmvaIj8+AGdJ
 XgfniwLSapI17BDd2IAqbtw8kujDIAe+x52En479zmQ9MtWJ2x3lz5bt6z+hcLhsWL5r
 lur5GINkZqonr8FAI7zzW7CSw8rzF3UbQn/KpfR6x1/bimaO8RKa1nrAlf33hKd4YXwZ
 ZwKOp7b8oLZpTciYewur8oKhUbmncEQHgxB6rxB8sQbCyWZ72Bp6Gvf/4biAKnxnII2x
 mcBw==
X-Gm-Message-State: AOJu0Yxar9wGypsaNHetb3b0nJQQTA9L/IeLQv0AzbK1grRxjMkX94pG
 67PJkEDKDz6m/3+Bq4LJofe47W0/budjRLe5GelH3550o6yJAFNvMeWoVIhypDUNxgKN0RyiPL1
 V
X-Google-Smtp-Source: AGHT+IEWO+CLqOi/i725p/P6jQRu+C6MX+esdXzJbSXqN65raWvoeGbEH3jbQk3E8ZcDe7qhV3vkLg==
X-Received: by 2002:a17:902:ce8e:b0:1d9:e180:478c with SMTP id
 f14-20020a170902ce8e00b001d9e180478cmr575616plg.24.1707851882956; 
 Tue, 13 Feb 2024 11:18:02 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVed4QeFyUxHP/AYODYBtnYLLc0T0rWyhsX0qXlpA/HUf3D2BjF5l5+eJUweldFBicYrbp3luJhD7BpuN8BzSkov5P/YTvaQ9R0dmmx6t4hbBclZrR1a8HtFPnEayUE5BAXJhfIqgN6HGTM5J7YLW7EokUtikh5vfxiCPAviGUqAl0LCYjsJmEI9xCoUv8i79mNUbEAzpNjaPi2k8UYHzdp78jy/tFOBRjmgYZo4IubnWpkhUv8iCwDEGj+TDnWrPQNum6PZ0rCe0qXxIz9PS6J8LV9qTkZsuvDGszDfX0ypjlvX1Fj7o7qDYrwLI01IsbJdth/iDSlh1350EG+Bv1Gt/V4EcY/YL5Vu2ZkgcIKP0O6JS4ECR/4Q9B85DB6JJh45uMGHvck1PMC
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902d60500b001d8f81ecea1sm2416335plp.172.2024.02.13.11.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 11:18:02 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 ajones@ventanamicro.com, alex.bennee@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 5/6] hw/riscv/virt.c: make aclint compatible with 'qtest' accel
Date: Tue, 13 Feb 2024 16:17:35 -0300
Message-ID: <20240213191736.733334-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213191736.733334-1-dbarboza@ventanamicro.com>
References: <20240213191736.733334-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
2.43.0


