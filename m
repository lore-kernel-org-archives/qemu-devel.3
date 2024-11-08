Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7893FD5E140
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 07:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9J3W-0008Ux-CA; Fri, 08 Nov 2024 02:05:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1t9J3N-0008Q5-Bl
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 02:05:09 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1t9J3L-0006L0-DU
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 02:05:09 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7240fa50694so868250b3a.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 23:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1731049505; x=1731654305; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YDdbTYoPMhjYXjreSIr4Skljfe+f+d+VjOVVkLAy2RY=;
 b=eHO+nlJqiJoYivodVq+WF20XQwOWcyttroduWn+Y1CoaNgOl/W2TPQU4c019kQqccP
 IiT5Xu4DzLdQ302U/VMjDjDS4NZaGKPneCP8TE00CbDiO0u2eB1U/aTkPj5lMUqXB3nT
 eNrGfuq9l820EQ56KUvGg9qe6XP11ttfBluYZY2vo/uTNuhLRazJtVwxjDEIRTTwIUcj
 feOSXgO71NVdujBNunzvc0+3IEAiZLhI3ZHg4DBR+AsJh+eQ4J22XfODY0c9qpTSJD/V
 1msYiXv1I/5cRMb11PQ/FZADFLg8x5uQlSM69On399A+tW7uKO8wcyBngBB0pZGXKCe0
 cfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731049505; x=1731654305;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YDdbTYoPMhjYXjreSIr4Skljfe+f+d+VjOVVkLAy2RY=;
 b=gORbo1DB+ugqTrS9YKWB/HgWXnIzbckqWAYAGm/nLhBCSV0k13NjYDpUNlJPyXYGrH
 R/U/r0/IAdE86mUa90RLlLWWpJ8FlUJLBuRIrXMX2lvtZrNZe3Rr8+xYPyUkp4yPBTiL
 yJBU2MDN+XWKfOyLc7IdZO8TGpuBQpofaRU+WsoiETd2eDnbiApFxf7hChLhFGy0oKxA
 OlxfZsGPTHf4vAVDLyFVqb+v/U86sRVGH1iEV9ok5NtjxfubVjX3OJ92k4fluQt5x7Gn
 3SS4dJ4wTyjim2z5NG9K88VT5cWLhv7Q7fJn+i/LyZN/NVj11AlUpf/S0cMoRHT5j0oj
 F1mA==
X-Gm-Message-State: AOJu0Yy5VpNYYrBkPTpVqHfVXBhWRu4OOmFFOJd+BFCTzvI1LmoEgSFK
 kH8gMpKlkGZa5WtPXleQLsKflKexZSeEKciJ21eHF3zyj0aFQYo64qTBknQ0uSMt3lhIzwHEv49
 Q5kKsKjGP+CGCc1lhOVs3c8DNKJOv81pmS51dlL6BP3r+C0Efgq315O/Wblm5PS0g3ZOinNDAzc
 n035wHJ7lcfpsMVYB+AwCZcS+c83ZAs9nNmCWS
X-Google-Smtp-Source: AGHT+IE1t6jfbd4Gtt+4x/WmK0AjYggX1xKU8bcOm+MJfRQsJykU8uGJ5m4GQlxvDzgHrSQp+diSyg==
X-Received: by 2002:a05:6a00:3399:b0:71e:7d52:fa8c with SMTP id
 d2e1a72fcca58-7241338b59fmr2609493b3a.22.1731049504708; 
 Thu, 07 Nov 2024 23:05:04 -0800 (PST)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078a9058sm2900715b3a.77.2024.11.07.23.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 23:05:04 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 1/3] hw/riscv: Support to load DTB after 3GB memory on
 64-bit system.
Date: Fri,  8 Nov 2024 15:04:52 +0800
Message-Id: <20241108070454.12699-2-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241108070454.12699-1-jim.shu@sifive.com>
References: <20241108070454.12699-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Larger initrd image will overlap the DTB at 3GB address. Since 64-bit
system doesn't have 32-bit addressable issue, we just load DTB to the end
of dram in 64-bit system.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/riscv/boot.c            | 8 ++++++--
 hw/riscv/microchip_pfsoc.c | 4 ++--
 hw/riscv/sifive_u.c        | 4 ++--
 hw/riscv/spike.c           | 4 ++--
 hw/riscv/virt.c            | 2 +-
 include/hw/riscv/boot.h    | 2 +-
 6 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 2e319168db..4e4e106a2b 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -293,7 +293,7 @@ out:
  * The FDT is fdt_packed() during the calculation.
  */
 uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
-                                MachineState *ms)
+                                MachineState *ms, RISCVHartArrayState *harts)
 {
     int ret = fdt_pack(ms->fdt);
     hwaddr dram_end, temp;
@@ -321,7 +321,11 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
      * Thus, put it at an 2MB aligned address that less than fdt size from the
      * end of dram or 3GB whichever is lesser.
      */
-    temp = (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : dram_end;
+    if (!riscv_is_32bit(harts)) {
+        temp = dram_end;
+    } else {
+        temp = (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : dram_end;
+    }
 
     return QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
 }
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index f9a3b43d2e..ba8b0a2c26 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -519,7 +519,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     bool kernel_as_payload = false;
     target_ulong firmware_end_addr, kernel_start_addr;
     uint64_t kernel_entry;
-    uint32_t fdt_load_addr;
+    uint64_t fdt_load_addr;
     DriveInfo *dinfo = drive_get(IF_SD, 0, 0);
 
     /* Sanity check on RAM size */
@@ -625,7 +625,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
         /* Compute the fdt load address in dram */
         fdt_load_addr = riscv_compute_fdt_addr(memmap[MICROCHIP_PFSOC_DRAM_LO].base,
                                                memmap[MICROCHIP_PFSOC_DRAM_LO].size,
-                                               machine);
+                                               machine, &s->soc.u_cpus);
         riscv_load_fdt(fdt_load_addr, machine->fdt);
 
         /* Load the reset vector */
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index c5e74126b1..05467e833a 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -519,7 +519,7 @@ static void sifive_u_machine_init(MachineState *machine)
     const char *firmware_name;
     uint32_t start_addr_hi32 = 0x00000000;
     int i;
-    uint32_t fdt_load_addr;
+    uint64_t fdt_load_addr;
     uint64_t kernel_entry;
     DriveInfo *dinfo;
     BlockBackend *blk;
@@ -606,7 +606,7 @@ static void sifive_u_machine_init(MachineState *machine)
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[SIFIVE_U_DEV_DRAM].base,
                                            memmap[SIFIVE_U_DEV_DRAM].size,
-                                           machine);
+                                           machine, &s->soc.u_cpus);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     if (!riscv_is_32bit(&s->soc.u_cpus)) {
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index fceb91d946..acd7ab1ae1 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -201,7 +201,7 @@ static void spike_board_init(MachineState *machine)
     hwaddr firmware_load_addr = memmap[SPIKE_DRAM].base;
     target_ulong kernel_start_addr;
     char *firmware_name;
-    uint32_t fdt_load_addr;
+    uint64_t fdt_load_addr;
     uint64_t kernel_entry;
     char *soc_name;
     int i, base_hartid, hart_count;
@@ -317,7 +317,7 @@ static void spike_board_init(MachineState *machine)
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[SPIKE_DRAM].base,
                                            memmap[SPIKE_DRAM].size,
-                                           machine);
+                                           machine, &s->soc[0]);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     /* load the reset vector */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 45a8c4f819..761bce3304 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1424,7 +1424,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
 
     fdt_load_addr = riscv_compute_fdt_addr(memmap[VIRT_DRAM].base,
                                            memmap[VIRT_DRAM].size,
-                                           machine);
+                                           machine, &s->soc[0]);
     riscv_load_fdt(fdt_load_addr, machine->fdt);
 
     /* load the reset vector */
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index f778b560de..34a80c5ff4 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -49,7 +49,7 @@ target_ulong riscv_load_kernel(MachineState *machine,
                                bool load_initrd,
                                symbol_fn_t sym_cb);
 uint64_t riscv_compute_fdt_addr(hwaddr dram_start, uint64_t dram_size,
-                                MachineState *ms);
+                                MachineState *ms, RISCVHartArrayState *harts);
 void riscv_load_fdt(hwaddr fdt_addr, void *fdt);
 void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts,
                                hwaddr saddr,
-- 
2.17.1


