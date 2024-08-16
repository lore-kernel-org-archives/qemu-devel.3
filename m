Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961BAC531DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 16:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sezUX-0006u4-8e; Fri, 16 Aug 2024 12:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sezUV-0006of-VW
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:07:52 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sezUT-0006da-CY
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:07:51 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7de4364ca8so262034866b.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1723824468; x=1724429268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GxovKyc8hSR1GEckXAnxRaRBhpyLQnXSUFgpG27gYb0=;
 b=XRe6Sb9hV1MO3Pqlw5UPVi6e0f7kUCX8G0N0S/GAqFeNOhjfWtLwSwRByiOceskU71
 tu8nncXX3a+oa1NjYw9vg1ibr1yd+LsZwHbjmY05thdbm02BJw1fQkP6yQlszqGxKVaH
 L8eW0ARBletXhZCvIajM5zrAPSREz+BV190Z4xgKX18Sx5i98xTfcPVnkqKx4IatFwZ0
 1hq7+8QpX//F43M6L2K8zuLEWVsZwKUuJKilqDLr0M94AKWQx9LcmdKuiB8iEHOSCc2L
 5k/LLbY2XjTrlphVihccGXwsbywZ8GjTSv5jEhc9mJdA6tOpVKUQT26EL/PT3954yb3G
 cDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723824468; x=1724429268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GxovKyc8hSR1GEckXAnxRaRBhpyLQnXSUFgpG27gYb0=;
 b=l0nG5AOmHO1Nsf3CpENgGCDK7tKRusuFVARvK2CzVqIWX2VMgs3EPWjs5QLIz+j2i6
 9c9jkD82mEy0i47lr31lH7QF7R4FvZprvI6utbNLnPvn89GK/nzvbjvb5WTvOnKnhzR7
 IKPoH5ja0K05BgCqD8BLqdrre4EhJdub74NlT9a9lvbkjcCiIb51N9ezryOiEbDuQrZf
 kFcvArbYxU/Xy+CToVqHqWrhJRcnt2S9MwSzK34RKsdqPVkssg+haw7qe935HOh5WZgt
 nFvCLOH+l3BaNjOGvKbOWfJzEgsE4LbbsD9bT5BZPwZIqUkgaLWN6T4wWD7knNDOh+eA
 ScRA==
X-Gm-Message-State: AOJu0YxsFtDna319xpCBEboKUr38bTLZzwGKeuX9yKarsNj0rlmJKsdM
 L5U3gUDws7nLRhMJo3A18cAPXHPtM+WjwgTyAuL/Lir5ETKCr/uL7OfUpztsw2gM44M63tkFqkT
 W6bQ=
X-Google-Smtp-Source: AGHT+IGQ9CXXgk4hQTnMfvSjmNwFM8UZMT20jPrwzyKKVc/ZJF7VhB8Qc/nrRpXhn0v97pp7wgPM4g==
X-Received: by 2002:a17:907:6d05:b0:a7a:aa35:408c with SMTP id
 a640c23a62f3a-a8392886ac8mr253294766b.8.1723824467317; 
 Fri, 16 Aug 2024 09:07:47 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a838393571bsm276095266b.98.2024.08.16.09.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:07:46 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 dbarboza@ventanamicro.com, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 2/2] hw/riscv/virt: Introduce strict-dt
Date: Fri, 16 Aug 2024 18:07:46 +0200
Message-ID: <20240816160743.220374-6-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240816160743.220374-4-ajones@ventanamicro.com>
References: <20240816160743.220374-4-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Older firmwares and OS kernels which use deprecated device tree
properties or are missing support for new properties may not be
tolerant of fully compliant device trees. When divergence to the
bindings specifications is harmless for new firmwares and OS kernels
which are compliant, then it's probably better to also continue
supporting the old firmwares and OS kernels by generating
non-compliant device trees. The '#msi-cells=<0>' property of the
imsic is one such property. Generating that property doesn't provide
anything necessary (no '#msi-cells' property or an '#msi-cells'
property with a value of zero mean the same thing) but it does
cause PCI devices to fail to find the MSI controller on Linux and,
for that reason, riscv virt doesn't currently generate it despite
that putting the DT out of compliance. For users that want a
compliant DT and know their software supports it, introduce a machine
property 'strict-dt' to do so. We also drop the one redundant
property that uses a deprecated name when strict-dt is enabled.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 docs/system/riscv/virt.rst | 11 ++++++++++
 hw/riscv/virt.c            | 43 ++++++++++++++++++++++++++++++--------
 include/hw/riscv/virt.h    |  1 +
 3 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 9a06f95a3444..f08d0a053051 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -116,6 +116,17 @@ The following machine-specific options are supported:
   having AIA IMSIC (i.e. "aia=aplic-imsic" selected). When not specified,
   the default number of per-HART VS-level AIA IMSIC pages is 0.
 
+- strict-dt=[on|off]
+
+  Older firmwares and OS kernels which use deprecated device tree properties
+  or are missing support for new properties may not be tolerant of fully
+  compliant device trees. When divergence to the bindings specifications is
+  harmless for new firmwares and OS kernels which are compliant, then it's
+  considered better to also continue supporting the old firmwares and OS
+  kernels by generating non-compliant device trees, and doing so is the default
+  behavior. This option may be enabled in order to force QEMU to only generate
+  compliant device trees.
+
 Running Linux kernel
 --------------------
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index cef41c150aaf..6a6e73b96362 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -552,6 +552,9 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
                           FDT_IMSIC_INT_CELLS);
     qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, 0);
     qemu_fdt_setprop(ms->fdt, imsic_name, "msi-controller", NULL, 0);
+    if (s->strict_dt) {
+        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#msi-cells", 0);
+    }
     qemu_fdt_setprop(ms->fdt, imsic_name, "interrupts-extended",
                      imsic_cells, ms->smp.cpus * sizeof(uint32_t) * 2);
     qemu_fdt_setprop(ms->fdt, imsic_name, "reg", imsic_regs,
@@ -650,15 +653,18 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
         qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegation",
                                aplic_child_phandle, 0x1,
                                VIRT_IRQCHIP_NUM_SOURCES);
-        /*
-         * DEPRECATED_9.1: Compat property kept temporarily
-         * to allow old firmwares to work with AIA. Do *not*
-         * use 'riscv,delegate' in new code: use
-         * 'riscv,delegation' instead.
-         */
-        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
-                               aplic_child_phandle, 0x1,
-                               VIRT_IRQCHIP_NUM_SOURCES);
+
+        if (!s->strict_dt) {
+            /*
+             * DEPRECATED_9.1: Compat property kept temporarily
+             * to allow old firmwares to work with AIA. Do *not*
+             * use 'riscv,delegate' in new code: use
+             * 'riscv,delegation' instead.
+             */
+            qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
+                                   aplic_child_phandle, 0x1,
+                                   VIRT_IRQCHIP_NUM_SOURCES);
+        }
     }
 
     riscv_socket_fdt_write_id(ms, aplic_name, socket);
@@ -1732,6 +1738,20 @@ static void virt_set_acpi(Object *obj, Visitor *v, const char *name,
     visit_type_OnOffAuto(v, name, &s->acpi, errp);
 }
 
+static bool virt_get_strict_dt(Object *obj, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    return s->strict_dt;
+}
+
+static void virt_set_strict_dt(Object *obj, bool value, Error **errp)
+{
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(obj);
+
+    s->strict_dt = value;
+}
+
 static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
                                                         DeviceState *dev)
 {
@@ -1822,6 +1842,11 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                               NULL, NULL);
     object_class_property_set_description(oc, "acpi",
                                           "Enable ACPI");
+
+    object_class_property_add_bool(oc, "strict-dt",
+                                   virt_get_strict_dt, virt_set_strict_dt);
+    object_class_property_set_description(oc, "strict-dt",
+        "Set to 'on' to generate a fully-compliant DT without deprecated properties");
 }
 
 static const TypeInfo virt_machine_typeinfo = {
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index c0dc41ff9a1a..c3b4c000b80a 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -62,6 +62,7 @@ struct RISCVVirtState {
     OnOffAuto acpi;
     const MemMapEntry *memmap;
     struct GPEXHost *gpex_host;
+    bool strict_dt;
 };
 
 enum {
-- 
2.45.2


