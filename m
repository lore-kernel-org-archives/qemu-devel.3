Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CD9D5AE67
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 06:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8w3Y-0005MF-1I; Thu, 07 Nov 2024 01:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1t8w3V-0005LJ-VR
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 01:31:46 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1t8w3U-0007q2-Bu
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 01:31:45 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20cbca51687so6002575ad.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 22:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1730961102; x=1731565902; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YDdbTYoPMhjYXjreSIr4Skljfe+f+d+VjOVVkLAy2RY=;
 b=j/F9eDemi3cMjZqV9OOihY/N/cYGpuK7qHoEre6uD9BzboaSI47kaFH2z/fhjHYFbF
 lXSPDdeYlVx37KBhN5ZuXyc7E+olRMCfV8fr1KT3z5gK7LkfAWNSHy6IFyXmRAcexR+e
 pTJXQJ/z49vH4PFq0Px69xzu4cPlFxUZ0KlTuvPYAUw4Z+4f7F8RjzqEWEY9+q6vTvmU
 YCBtx5VBqpezRBjpgKjv2dhONHpQRMccJzLKFlR8M5ThyAzkk1azTarPlhoBfBhyLqpY
 dODYdr4KFkG4XHJdR3Bqx7a75sS6xeRtRjn++v1fIDhIIKYmRh8tvqdrcnhPpMWP3FHa
 to8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730961102; x=1731565902;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YDdbTYoPMhjYXjreSIr4Skljfe+f+d+VjOVVkLAy2RY=;
 b=jUGV7bNOX6locKJv5uwJU3BBQSFMvF6ybXi++8OLXI33zIrkxV1JHiQAxgAT9EhX48
 aRNkDgrv/tud1cq9fkDUXBavD/w3up35IGyTMiR8YZ4V/IpG02HiHo/UJjyDPXG6c+i8
 D59ZrbzM7tx97yTaaIEdYy1EDLdM4W8qE6RrYN1QJJ6ubXgPB4zGLTT6dK/ffgrFZrs9
 NwqymQKYVhlZBE3fFS/12YpgXB9pk/k4i4D0Z1Q9h7blEz+sPcGhAFcsUYP89Ym+fdq2
 DcB4imocRn10iLpNZkBtcjzxeVbgy59IRfP/VgjrNhsWZ6wBH+M53byJi/Nw7zgxMbHa
 wRew==
X-Gm-Message-State: AOJu0Yyh4xEMpqxhjwJaMcsGzwX7axufmvSWFpV1ly26BJLP7YtVouC+
 S6NDgCmWpVDibmJG8HhXz6kHVdVNlVrrpnnDHstxcl7X/8SmCaE3lzNggQ+x4k5vqY66axMrZUG
 NZQEVxGRjdaBaEN4p9x3iJSh2E93VF2J7ZGZt4R5xQbVLRTfyGdWKdqjpI5RzUoNtztMOcGL0MS
 K5p0aDuiOTUPyq4DpCXnLCppp1HmBZqEsC2g==
X-Google-Smtp-Source: AGHT+IHLmhoESKKptk40mpxgBqLJBR4Ul+u072WvvlgQUx1lIjlHszlU9XNTnRLM7Puz0kUz0vWGxg==
X-Received: by 2002:a17:902:f551:b0:20c:9062:fb88 with SMTP id
 d9443c01a7336-2111aec8308mr274649765ad.1.1730961101975; 
 Wed, 06 Nov 2024 22:31:41 -0800 (PST)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc7cf8sm4995665ad.34.2024.11.06.22.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 22:31:41 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 1/3] hw/riscv: Support to load DTB after 3GB memory on
 64-bit system.
Date: Thu,  7 Nov 2024 14:31:31 +0800
Message-Id: <20241107063133.28339-2-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241107063133.28339-1-jim.shu@sifive.com>
References: <20241107063133.28339-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x629.google.com
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


