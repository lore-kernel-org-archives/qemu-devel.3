Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDBCC48BC0
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOg3-00024C-JB; Fri, 09 Feb 2024 06:04:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOdU-0007Yo-Nv
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:42 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOdI-0000sI-3D
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:01:29 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2909978624eso483731a91.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476482; x=1708081282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2Isq+lSm0bMbZy46fyVUoQUhU6zZEbq0sgAvXr2NLc=;
 b=QahLqF4+WDz5gJQjUq97aEytQf7JzR2aMfkXyY0AS1luSIY8k5ICZupQCGuPX8OiSk
 odGfJK0e1Sf1DehkNuglxvSqLMZTG1vzNiUAkGcwlJy239Rr0g2LkhfwfuFCOKM4Wlmm
 5Gu+Ox9xD6xWby0tiA1jBHkl/RkNvCiLFq3l3vj4Ll9sYNei91Jpq1j7JoMjwp/hHhmm
 R/4G73bTBj6st7rY83oEpMn/iS3vc8wk4cG+tP9/6G4kdNWuroUzZac9Qv/KKb87/Q7h
 HFJgJgEX4he24QfDEfUWCKS5s4OJ63aZwdL0tK6i0gn7IKaTT5Wc743gDeydUJxd4nsn
 hDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476482; x=1708081282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t2Isq+lSm0bMbZy46fyVUoQUhU6zZEbq0sgAvXr2NLc=;
 b=v83bRZ005V6zMWnEBT6OUJ0VQr644y8tuwEQ1JwE/0ovBmtaAV5k38xpfzHvnU9I8I
 E0HOGAQ3zSbRtlMrDh6B5RievfFeie3y4hs2TB1nJPMnUKDz/jCzCmPm4ZHMjiHmCM/M
 AKXVX8oTg8EiEW3YigswEbsTAt3JB27/ks6Jtw8vxoRD+6hzN9zL3qhVmFoLmPMC242x
 xtLADA7iA7eDovLifrbD2XZRl7bjkrL9E1HnnIgfi64SD/JdB77F2biX4o4KsPKu+Jmc
 u2GKZMbxs+W3ur6VQaQ34iSdKmwRSUNBqONVVVzctAQ6z/QwQmNcjtodNLdOQo20/d97
 8LGw==
X-Gm-Message-State: AOJu0Yxb1s5Y2cRWtIC0XCwbOy6S3Lke7ZBgaoLXs5IZlaUhU1gSMVyP
 gjPn8yA/JcTxqZMjT/A1fL9l3d2ysEIeo1+Cuhf8AAX7OjxGej3Pt5kBVx3vtx2X0w==
X-Google-Smtp-Source: AGHT+IG3BVcDVEK4kQhQ5/NqAtkCQcsqw9F1qyExoswUDzGB6dy6o/SZF/yOgLfpXYKhGE0TtNsgyQ==
X-Received: by 2002:a17:90a:f0cd:b0:296:abfd:1980 with SMTP id
 fa13-20020a17090af0cd00b00296abfd1980mr1093719pjb.23.1707476481914; 
 Fri, 09 Feb 2024 03:01:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXL3dqnxIv5/snkSLbOrJTtLHL5O/3eEwA40ElXmnRDoLWnYgGDyczKzkvNGcnVDrKHSO2D8K3+xH0PwWeyl+KOC/avWfaSDpNiqeJoH6PsQdXjvorHiZKhfbpdGfVPyCluY9gvwhpZ1+dEvu6yXOngxotNCzSer+PqDEkBZ3L5QNS86Kev/HMqY9zgTrH3k70f72aj0fcL4g==
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.03.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 03:01:21 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 54/61] target/riscv: support new isa extension detection
 devicetree properties
Date: Fri,  9 Feb 2024 20:58:06 +1000
Message-ID: <20240209105813.3590056-55-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1032.google.com
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

From: Conor Dooley <conor.dooley@microchip.com>

A few months ago I submitted a patch to various lists, deprecating
"riscv,isa" with a lengthy commit message [0] that is now commit
aeb71e42caae ("dt-bindings: riscv: deprecate riscv,isa") in the Linux
kernel tree. Primarily, the goal was to replace "riscv,isa" with a new
set of properties that allowed for strictly defining the meaning of
various extensions, where "riscv,isa" was tied to whatever definitions
inflicted upon us by the ISA manual, which have seen some variance over
time.

Two new properties were introduced: "riscv,isa-base" and
"riscv,isa-extensions". The former is a simple string to communicate the
base ISA implemented by a hart and the latter an array of strings used
to communicate the set of ISA extensions supported, per the definitions
of each substring in extensions.yaml [1]. A beneficial side effect was
also the ability to define vendor extensions in a more "official" way,
as the ISA manual and other RVI specifications only covered the format
for vendor extensions in the ISA string, but not the meaning of vendor
extensions, for obvious reasons.

Add support for setting these two new properties in the devicetrees for
the various devicetree platforms supported by QEMU for RISC-V. The Linux
kernel already supports parsing ISA extensions from these new
properties, and documenting them in the dt-binding is a requirement for
new extension detection being added to the kernel.

A side effect of the implementation is that the meaning for elements in
"riscv,isa" and in "riscv,isa-extensions" are now tied together as they
are constructed from the same source. The same applies to the ISA string
provided in ACPI tables, but there does not appear to be any strict
definitions of meanings in ACPI land either.

Link: https://lore.kernel.org/qemu-riscv/20230702-eats-scorebook-c951f170d29f@spud/ [0]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/riscv/extensions.yaml [1]
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240124-unvarying-foothold-9dde2aaf95d4@spud>
[ Changes by AF:
 - Rebase on recent changes
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h  |  1 +
 hw/riscv/sifive_u.c |  7 ++----
 hw/riscv/spike.c    |  6 ++---
 hw/riscv/virt.c     |  4 +---
 target/riscv/cpu.c  | 54 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 9bc14056fa..f52dce78ba 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -515,6 +515,7 @@ int riscv_cpu_max_xlen(RISCVCPUClass *mcc);
 bool riscv_cpu_option_set(const char *optname);
 
 #ifndef CONFIG_USER_ONLY
+void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename);
 void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      vaddr addr, unsigned size,
                                      MMUAccessType access_type,
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 5207ec1fa5..af5f923f54 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -171,7 +171,6 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         int cpu_phandle = phandle++;
         nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        char *isa;
         qemu_fdt_add_subnode(fdt, nodename);
         /* cpu 0 is the management hart that does not have mmu */
         if (cpu != 0) {
@@ -180,11 +179,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
             } else {
                 qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
             }
-            isa = riscv_isa_string(&s->soc.u_cpus.harts[cpu - 1]);
+            riscv_isa_write_fdt(&s->soc.u_cpus.harts[cpu - 1], fdt, nodename);
         } else {
-            isa = riscv_isa_string(&s->soc.e_cpus.harts[0]);
+            riscv_isa_write_fdt(&s->soc.e_cpus.harts[0], fdt, nodename);
         }
-        qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
         qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
         qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
         qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
@@ -194,7 +192,6 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
         qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
         qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
-        g_free(isa);
         g_free(intc);
         g_free(nodename);
     }
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 81f7e53aed..64074395bc 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -59,7 +59,7 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
     MachineState *ms = MACHINE(s);
     uint32_t *clint_cells;
     uint32_t cpu_phandle, intc_phandle, phandle = 1;
-    char *name, *mem_name, *clint_name, *clust_name;
+    char *mem_name, *clint_name, *clust_name;
     char *core_name, *cpu_name, *intc_name;
     static const char * const clint_compat[2] = {
         "sifive,clint0", "riscv,clint0"
@@ -113,9 +113,7 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
             } else {
                 qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv48");
             }
-            name = riscv_isa_string(&s->soc[socket].harts[cpu]);
-            qemu_fdt_setprop_string(fdt, cpu_name, "riscv,isa", name);
-            g_free(name);
+            riscv_isa_write_fdt(&s->soc[socket].harts[cpu], fdt, cpu_name);
             qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
             qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
             qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 1c257e89d2..b4e80b0b0d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -220,7 +220,6 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
 
     for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
         RISCVCPU *cpu_ptr = &s->soc[socket].harts[cpu];
-        g_autofree char *name = NULL;
         g_autofree char *cpu_name = NULL;
         g_autofree char *core_name = NULL;
         g_autofree char *intc_name = NULL;
@@ -239,8 +238,7 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
             qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_name);
         }
 
-        name = riscv_isa_string(cpu_ptr);
-        qemu_fdt_setprop_string(ms->fdt, cpu_name, "riscv,isa", name);
+        riscv_isa_write_fdt(cpu_ptr, ms->fdt, cpu_name);
 
         if (cpu_ptr->cfg.ext_zicbom) {
             qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbom-block-size",
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7fc45660d7..6b5878c603 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -32,6 +32,7 @@
 #include "hw/core/qdev-prop-internal.h"
 #include "migration/vmstate.h"
 #include "fpu/softfloat-helpers.h"
+#include "sysemu/device_tree.h"
 #include "sysemu/kvm.h"
 #include "sysemu/tcg.h"
 #include "kvm/kvm_riscv.h"
@@ -2381,6 +2382,59 @@ char *riscv_isa_string(RISCVCPU *cpu)
     return isa_str;
 }
 
+#ifndef CONFIG_USER_ONLY
+static char **riscv_isa_extensions_list(RISCVCPU *cpu, int *count)
+{
+    int maxlen = ARRAY_SIZE(riscv_single_letter_exts) + ARRAY_SIZE(isa_edata_arr);
+    char **extensions = g_new(char *, maxlen);
+
+    for (int i = 0; i < sizeof(riscv_single_letter_exts) - 1; i++) {
+        if (cpu->env.misa_ext & RV(riscv_single_letter_exts[i])) {
+            extensions[*count] = g_new(char, 2);
+            snprintf(extensions[*count], 2, "%c",
+                     qemu_tolower(riscv_single_letter_exts[i]));
+            (*count)++;
+        }
+    }
+
+    for (const RISCVIsaExtData *edata = isa_edata_arr; edata->name; edata++) {
+        if (isa_ext_is_enabled(cpu, edata->ext_enable_offset)) {
+            extensions[*count] = g_strdup(edata->name);
+            (*count)++;
+        }
+    }
+
+    return extensions;
+}
+
+void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
+{
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
+    const size_t maxlen = sizeof("rv128i");
+    g_autofree char *isa_base = g_new(char, maxlen);
+    g_autofree char *riscv_isa;
+    char **isa_extensions;
+    int count = 0;
+    int xlen = riscv_cpu_max_xlen(mcc);
+
+    riscv_isa = riscv_isa_string(cpu);
+    qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", riscv_isa);
+
+    snprintf(isa_base, maxlen, "rv%di", xlen);
+    qemu_fdt_setprop_string(fdt, nodename, "riscv,isa-base", isa_base);
+
+    isa_extensions = riscv_isa_extensions_list(cpu, &count);
+    qemu_fdt_setprop_string_array(fdt, nodename, "riscv,isa-extensions",
+                                  isa_extensions, count);
+
+    for (int i = 0; i < count; i++) {
+        g_free(isa_extensions[i]);
+    }
+
+    g_free(isa_extensions);
+}
+#endif
+
 #define DEFINE_CPU(type_name, misa_mxl_max, initfn)         \
     {                                                       \
         .name = (type_name),                                \
-- 
2.43.0


