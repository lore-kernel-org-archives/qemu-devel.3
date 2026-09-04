Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD15C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MM5-0006dd-0r; Fri, 04 Sep 2026 01:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MM3-0006Xo-OC
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:47 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MM1-0001Io-Lr
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:47 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8568e3ed034so451038b3a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499244; x=1789104044; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rwqHdoAdHYOlyhFrz09zLrL6ZmmTV0JXsPJWF1/IFQA=;
 b=W6tuhunbKio9VJQuSm7+bCAMuEsTyMHquvEsTFqai8NjjAx1dq4P6zeoj+wQbZJGP7
 KBiXpDV/r2CShM9O7VT8g+rKY/HJF91AHJD68k67+i+4zTYIJ7LOgdGxy9eNes2qEADV
 0sC64OAZoctpS/n/q/VRcMwtKsZpCmU8odgO8k+QO1vV33TGRIBedUUl8lUletwaV4hp
 +zDKFNXOgaN6ItpKdTnFmMgi73U90kKNaT0cOIqbS6SHIqLWhXdn8kW8+CQ5f3XijwUe
 8QMXDct3A/ya/IUr9KYH+Jp/Nq9ej+95NN/zkdHWf9N5aPr0lUuM2dGnC1CrBK7uETMr
 7fEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499244; x=1789104044;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rwqHdoAdHYOlyhFrz09zLrL6ZmmTV0JXsPJWF1/IFQA=;
 b=D9xY5tMXY+jGXUUBuUAn/CVWuS9SVqYtDT1law58GJFeSSiawQBT7BZBCKcbwXjxtM
 oGvQ6jSkGHqH5BCrWelcfrhTd7uMTkYCbkjMlJ9uLzXSd+JKHXh/d6POObx8V9NlmCA/
 IYgHQq/zWUy+OFI9m63dL3x+tKymvfMrgIT39nCLBrKOPzcuk80SWUL1WAbyM1I8blrr
 jPjr8nHpwAE/kMcJirZNkCpEkpONx1tcw6uEq+tunnk1B2Yg3EfjFOdRPcmIpVnlmMZU
 ECKIjs/8v840qhBo5WFAlQ63fkzNLfUTwwzAva5wzjhH+Ti+834AOgP5QjlU6wzK8y3L
 oJvQ==
X-Gm-Message-State: AFuF++mbL+6vhpCa4xIJYNErbvqoOGXADubvDnNe+DLOX93QjqFuqMvg
 Ii5q1Kif8WK7RJxYskxmcj7Mqx4SUFxqEEdidFp6YbxNmCo7zxI3ce85t/8GcA==
X-Gm-Gg: AYBFou01hpjRG/qIRVUuXsiES1QwsgB8e3Fr4bce12meJlRGfII31wraAhbah5Wyfcd
 sm2xzyFUu4ILp2UwgIBfkTe0TIkwWunpdW5zRRFzDDnBn7B+Ox83/pPNwVXl43wTee7lsOMM9ev
 Ha61I5XYob0jrVLxS2n7KOsyYLLbSuWWUdfsorvj89GxsFIW12X989Efl9clEmA0vtuwGo94K3R
 Pw+e43QwpnrF/P2TRsJ1TN5WkFMG7cJuxErFQ+kQPdyikd+dNIOCSgFarcO1DCMBL0edEufnWw1
 6+x7jE4aBwxO85qOFWTjFq3FcNYE2eceUy4YS0PP3b7x7rpMaG6aGLeIAOZUxYEJclGck4y4Yek
 uCDW7YqnvxTeLc7ZVMaPGBW0MVZSi+++0cKwuMTbJDA2vb3Y/lFI4Safse7E0L5VsBB0F0pAKS4
 FpCMA6MED6TXgOIBGy+falyvZ9gEtDeSGERMhMheveorXxvzDSs2GkoEXYpKKB4g0K9PA3rYkm4
 TMchrf2PhxUuMqe
X-Received: by 2002:a05:6300:2284:b0:3c2:dcdd:a85a with SMTP id
 adf61e73a8af0-3da39ffc3efmr5536391637.13.1788499244126; 
 Thu, 03 Sep 2026 22:20:44 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:20:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/47] hw/riscv/fdt-common,
 virt.c: add riscv_create_fdt_syscon()
Date: Fri,  4 Sep 2026 15:19:12 +1000
Message-ID: <20260904051943.799041-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The soon to be added riscv-server-ref board will declare a syscon FDT
similar to what the 'virt' board already does.

It won't have a 'sifive,test0' and 'sifive,test1' compat string though,
hence we'll add a flag to enable/disable these additional properties.

The FDT is slightly changed: the subnode is now named 'soc/syscon' instead
of 'soc/test' to be compatible with the latest device-tree docs.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260828203918.350131-4-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/fdt-common.h |  4 +++
 hw/riscv/fdt-common.c         | 54 +++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               | 46 +++--------------------------
 3 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index b422da6aef..e377682b32 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -39,4 +39,8 @@ void riscv_create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
                            bool numa_enabled, int socket);
 void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 void riscv_create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize);
+void riscv_create_fdt_syscon(void *fdt, uint32_t *next_phandle,
+                             hwaddr addr, hwaddr size,
+                             uint32_t reboot, uint32_t poweroff,
+                             bool sifive_test_compat);
 #endif
diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 6fcc1ce21f..eac5ca9322 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -295,3 +295,57 @@ void riscv_create_fdt_flash(void *fdt, hwaddr flashbase, hwaddr flashsize)
                                  2, flashbase + flashsize, 2, flashsize);
     qemu_fdt_setprop_cell(fdt, name, "bank-width", 4);
 }
+
+/*
+ * @sifive_test_compat is used to create a FDT that declares
+ * compat with "sifive,test1" and "sifive,test0".  This happens
+ * to be the case for the 'virt' machine that also creates a
+ * 'sifive_test' syscon device.
+ */
+void riscv_create_fdt_syscon(void *fdt, uint32_t *next_phandle,
+                             hwaddr addr, hwaddr size,
+                             uint32_t reboot, uint32_t poweroff,
+                             bool sifive_test_compat)
+{
+    uint32_t syscon_phandle;
+    char *name;
+
+    name = g_strdup_printf("/soc/syscon@%"HWADDR_PRIx, addr);
+    qemu_fdt_add_subnode(fdt, name);
+
+    if (sifive_test_compat) {
+        static const char * const compat[3] = {
+            "sifive,test1", "sifive,test0", "syscon"
+        };
+
+        qemu_fdt_setprop_string_array(fdt, name, "compatible",
+                                      (char **)&compat, ARRAY_SIZE(compat));
+    } else {
+        qemu_fdt_setprop_string(fdt, name, "compatible", "syscon");
+    }
+
+    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
+                                 2, addr,
+                                 2, size);
+
+    syscon_phandle = next_phandle ? (*next_phandle)++ : qemu_fdt_alloc_phandle(fdt);
+    qemu_fdt_setprop_cell(fdt, name, "phandle", syscon_phandle);
+
+    g_free(name);
+
+    name = g_strdup_printf("/reboot");
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "syscon-reboot");
+    qemu_fdt_setprop_cell(fdt, name, "regmap", syscon_phandle);
+    qemu_fdt_setprop_cell(fdt, name, "offset", 0x0);
+    qemu_fdt_setprop_cell(fdt, name, "value", reboot);
+    g_free(name);
+
+    name = g_strdup_printf("/poweroff");
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "syscon-poweroff");
+    qemu_fdt_setprop_cell(fdt, name, "regmap", syscon_phandle);
+    qemu_fdt_setprop_cell(fdt, name, "offset", 0x0);
+    qemu_fdt_setprop_cell(fdt, name, "value", poweroff);
+    g_free(name);
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index fec5f6d17a..1f7b4343d3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -767,47 +767,6 @@ static void create_fdt_pcie(RISCVVirtState *s,
     create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
 }
 
-static void create_fdt_reset(RISCVVirtState *s, uint32_t *phandle)
-{
-    char *name;
-    uint32_t test_phandle;
-    MachineState *ms = MACHINE(s);
-
-    test_phandle = (*phandle)++;
-    name = g_strdup_printf("/soc/test@%"HWADDR_PRIx,
-                           s->memmap[VIRT_TEST].base);
-    qemu_fdt_add_subnode(ms->fdt, name);
-    {
-        static const char * const compat[3] = {
-            "sifive,test1", "sifive,test0", "syscon"
-        };
-        qemu_fdt_setprop_string_array(ms->fdt, name, "compatible",
-                                      (char **)&compat, ARRAY_SIZE(compat));
-    }
-    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
-                                 2, s->memmap[VIRT_TEST].base,
-                                 2, s->memmap[VIRT_TEST].size);
-    qemu_fdt_setprop_cell(ms->fdt, name, "phandle", test_phandle);
-    test_phandle = qemu_fdt_get_phandle(ms->fdt, name);
-    g_free(name);
-
-    name = g_strdup_printf("/reboot");
-    qemu_fdt_add_subnode(ms->fdt, name);
-    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-reboot");
-    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", test_phandle);
-    qemu_fdt_setprop_cell(ms->fdt, name, "offset", 0x0);
-    qemu_fdt_setprop_cell(ms->fdt, name, "value", FINISHER_RESET);
-    g_free(name);
-
-    name = g_strdup_printf("/poweroff");
-    qemu_fdt_add_subnode(ms->fdt, name);
-    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-poweroff");
-    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", test_phandle);
-    qemu_fdt_setprop_cell(ms->fdt, name, "offset", 0x0);
-    qemu_fdt_setprop_cell(ms->fdt, name, "value", FINISHER_PASS);
-    g_free(name);
-}
-
 static void create_fdt_uart(RISCVVirtState *s,
                             uint32_t irq_mmio_phandle, int memId, int irqNo)
 {
@@ -993,7 +952,10 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_pcie(s, irq_pcie_phandle, msi_pcie_phandle,
                     iommu_sys_phandle);
 
-    create_fdt_reset(s, &phandle);
+    riscv_create_fdt_syscon(MACHINE(s)->fdt, &phandle,
+                            s->memmap[VIRT_TEST].base,
+                            s->memmap[VIRT_TEST].size,
+                            FINISHER_RESET, FINISHER_PASS, true);
 
     create_fdt_uarts(s, irq_mmio_phandle);
 
-- 
2.55.0


