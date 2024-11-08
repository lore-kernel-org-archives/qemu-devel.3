Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026A2D5E141
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 07:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9J3Y-0008Vh-Ch; Fri, 08 Nov 2024 02:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1t9J3S-0008TN-Jz
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 02:05:15 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1t9J3P-0006Lt-S7
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 02:05:14 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7f12ba78072so1413116a12.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 23:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1731049509; x=1731654309; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=imX3pkNiDootTp+f5+lxB0xVp8x8ZcJGe7afU7mIDS8=;
 b=Mypfv6QsakUw48LRpSMxy/b5Gc7ZLmLB6x0/WIJg+AxTVlS4sXX8XY92C4WFbW4260
 zA4lsIrAYj11UnmfMZfkIZhW72WetD+SIhp6LUPrf2oZ/CK9ri0bZ7YoiUlSHNQzaxjM
 fEPydAnIyf9gnLx1myaOGqSQVyoOZaW/ASocHRzI7ILe7lXK8I5Jn9I1sbkbFAADH/I/
 r1oBgedgFa8ZNnfbMYC969tsKTX4tSBSJS0A8W+wqxu3l+qeMfosLicfOPgoR+EORV+m
 wMj66IemGySOssrMQCpGmWnGrG0qFiYGghOlHGeXl9TfIqlku6Zmsbl1XgUe6Onl9pZO
 gCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731049509; x=1731654309;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=imX3pkNiDootTp+f5+lxB0xVp8x8ZcJGe7afU7mIDS8=;
 b=Aoi4le+w0f00qFhF/FhjcKgHPD121BEFGsREqut8gQ0GY+ICwTFv+exn0SnZEbIIle
 ujh8NSAkLYZZUZYXnS1TT1PwcsTkj2sChMU362auSGcf2qA+kv+a0AoST7SBL1uWzxBQ
 1H1uhiMF8efiGwt+ENDyKX+skrkdEz2v8jmU8TgRnnFDSEY73Zbze2Fvfkw4djmDA1tD
 dscfYc2lZ8Aelorni4UOOc6zVjEdkbbvP9iLbHxNwz1+FaJ0LrE2qX3QAyWKOfyf2fAg
 G8zepg4JDqSeYS/MMHs8IdPR2Hp8NDqDk5oxaGw3Pe/4t3plYysvcMm3hijF0M4s43JK
 D5GA==
X-Gm-Message-State: AOJu0Yzs5o89rNxYKbU4KowbSr1nLhQ4lFB7PAJNy/hiYz9N3LYwd/S/
 /mlQK94qjUAgXG8vdIu1ZGl6ohoNHI/BP5ugyvGeIBH/A7ArIEDp41e7wa1GnFtL2zH304KmGsu
 ZMPPNbCWaoT6hacenDwPYS+uVipIumUkaQgegXsd8kHwW6YP4vJGHX/ZUE72MfkQAKiqkFPtN3t
 gIgG1+V4UuSBCkybUnhnZL50CNesY/7M60JHRi
X-Google-Smtp-Source: AGHT+IGK2+1pyilqknTNwGbcvMwDh5DpkoKN4ktGxfzPVUWUlxXegB7cg0E6ZVCseR3ScO9QOOPzaw==
X-Received: by 2002:a05:6a20:43a0:b0:1dc:2365:a114 with SMTP id
 adf61e73a8af0-1dc2365a23dmr2409704637.24.1731049509129; 
 Thu, 07 Nov 2024 23:05:09 -0800 (PST)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078a9058sm2900715b3a.77.2024.11.07.23.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 23:05:08 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 3/3] hw/riscv: Add the checking if DTB overlaps to kernel
 or initrd
Date: Fri,  8 Nov 2024 15:04:54 +0800
Message-Id: <20241108070454.12699-4-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241108070454.12699-1-jim.shu@sifive.com>
References: <20241108070454.12699-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=jim.shu@sifive.com; helo=mail-pg1-x530.google.com
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

DTB is placed to the end of memory, so we will check if the start
address of DTB overlaps to the address of kernel/initrd.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 hw/riscv/boot.c         | 25 ++++++++++++++++++++++++-
 include/hw/riscv/boot.h |  3 +++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index c7478d2365..d22d240854 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -70,6 +70,7 @@ char *riscv_plic_hart_config_string(int hart_count)
 void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts)
 {
     info->kernel_size = 0;
+    info->initrd_size = 0;
     info->is_32bit = riscv_is_32bit(harts);
 }
 
@@ -213,6 +214,9 @@ static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
         }
     }
 
+    info->initrd_start = start;
+    info->initrd_size = size;
+
     /* Some RISC-V machines (e.g. opentitan) don't have a fdt. */
     if (fdt) {
         end = start + size;
@@ -309,6 +313,7 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
     int ret = fdt_pack(ms->fdt);
     hwaddr dram_end, temp;
     int fdtsize;
+    uint64_t dtb_start, dtb_start_limit;
 
     /* Should only fail if we've built a corrupted tree */
     g_assert(ret == 0);
@@ -319,6 +324,17 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
         exit(1);
     }
 
+    if (info->initrd_size) {
+        /* If initrd is successfully loaded, place DTB after it. */
+        dtb_start_limit = info->initrd_start + info->initrd_size;
+    } else if (info->kernel_size) {
+        /* If only kernel is successfully loaded, place DTB after it. */
+        dtb_start_limit = info->image_high_addr;
+    } else {
+        /* Otherwise, do not check DTB overlapping */
+        dtb_start_limit = 0;
+    }
+
     /*
      * A dram_size == 0, usually from a MemMapEntry[].size element,
      * means that the DRAM block goes all the way to ms->ram_size.
@@ -338,7 +354,14 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
         temp = (dram_base < 3072 * MiB) ? MIN(dram_end, 3072 * MiB) : dram_end;
     }
 
-    return QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
+    dtb_start = QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
+
+    if (dtb_start_limit && (dtb_start < dtb_start_limit)) {
+        error_report("No enough memory to place DTB after kernel/initrd");
+        exit(1);
+    }
+
+    return dtb_start;
 }
 
 /*
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 719ee1fe5f..e309cc1a7f 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -32,6 +32,9 @@ typedef struct RISCVBootInfo {
     uint64_t image_low_addr;
     uint64_t image_high_addr;
 
+    hwaddr initrd_start;
+    ssize_t initrd_size;
+
     bool is_32bit;
 } RISCVBootInfo;
 
-- 
2.17.1


