Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E4BD5AE67
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 06:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8w3l-0005NW-2r; Thu, 07 Nov 2024 01:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1t8w3a-0005Mb-SB
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 01:31:52 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1t8w3Y-0007uz-LG
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 01:31:49 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20caccadbeeso6385155ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 22:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1730961106; x=1731565906; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TfKLwFIwOJ8McnAVkO7CKA9p3IkEodbwexFiFB6Ay14=;
 b=EBN1EKJbbHwkoHz7EWmUU3FgTlTS81Tr3+onzlEzwEIKr6Jr9auBBWK1G2ZcyVBjhb
 /lRcV4VcYnZHCnZxdQrU5xfsIWgpVaU9l+ll+jfhq7lq5FbHLd/WtVnQY9Eza3AcjdkF
 wiM/GqKeFvOZ5cn/VSVBTjwGBWXOyhXLJz4vSWG/Hd0Ozza9krhdyiG25s2g+OuVLoQS
 gbxfOlOSlHzx3FUXTx28k7R/qf70TgBEnYktzbi1EDD86IetKxELIDn3iW85mX8xQGJn
 UgeO24/W7UsCqVVHnd0oFtUkXGXsDwyUxJqBbr7nLKNFoKrH2WKfRAnN7lqyWHylUdRt
 BuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730961106; x=1731565906;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TfKLwFIwOJ8McnAVkO7CKA9p3IkEodbwexFiFB6Ay14=;
 b=wDsTdIyU4cReB4HpMAew1dYIOyI2Am1DRWmYCkFmN9wtIMql3bQJotJeAgeyW7j976
 PnFPUIWNJmVd8TEPr1bbciwZalLpdpAIZz7L3K6+bB7oe0SQW1rV9kbfNvpIEmSk1eG2
 qRlbL6t+R1XEz1qcl3nteXuPyH5d1lfMrt2adDZvXZ09TPyUzS3hDE7cfHzbKcK/btHI
 nwMBWp4VTY9I/OYLtw8lKUT4xgNdqivFV7XiZVSUG/z/FpuVumzRyLypny1mLsYjeTg6
 fQuGhj7XEXSt9qr153vbNwVpINoK9BM/pjARp7WKGowaLTt/Sc5ohoZrq/ra2RK/I1zg
 EbeQ==
X-Gm-Message-State: AOJu0YwMasNIg2YEyCab/D6G+2CGA15yy+zMfOZpOZ385bj2+v9N4Dy4
 S+60DIaxudU6/7kM+O7ovs0OvfJM1IZ4cGCkyO4INwhIEyi64ecFmmCr0Y0MPnI26RQzCU/rxZP
 +sAz8br+f56jM1zSVyvaMsC+JsDjXAtHl0tSMBQAC+R5hdFeg7scfeAgwZWGD/IELsPSonXJp3s
 0BQJ9cDP1k0N/SdPe1T3+XE95jOaxLfvZFbQ==
X-Google-Smtp-Source: AGHT+IH6iPHq+kcTTrzMlYWb3QKRlcgpB3Eq5EefjcQvjScLuLpOEdyf8LfQ9y2UVGvGcbApbnM4LQ==
X-Received: by 2002:a17:902:dac4:b0:20c:805a:524 with SMTP id
 d9443c01a7336-211786800a5mr9104555ad.39.1730961106398; 
 Wed, 06 Nov 2024 22:31:46 -0800 (PST)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc7cf8sm4995665ad.34.2024.11.06.22.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 22:31:45 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 3/3] hw/riscv: Add the checking if DTB overlaps to kernel
 or initrd
Date: Thu,  7 Nov 2024 14:31:33 +0800
Message-Id: <20241107063133.28339-4-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241107063133.28339-1-jim.shu@sifive.com>
References: <20241107063133.28339-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x633.google.com
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
 hw/riscv/boot.c         | 24 +++++++++++++++++++++++-
 include/hw/riscv/boot.h |  3 +++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index e5bd54bd73..d22d240854 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -214,6 +214,9 @@ static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
         }
     }
 
+    info->initrd_start = start;
+    info->initrd_size = size;
+
     /* Some RISC-V machines (e.g. opentitan) don't have a fdt. */
     if (fdt) {
         end = start + size;
@@ -310,6 +313,7 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
     int ret = fdt_pack(ms->fdt);
     hwaddr dram_end, temp;
     int fdtsize;
+    uint64_t dtb_start, dtb_start_limit;
 
     /* Should only fail if we've built a corrupted tree */
     g_assert(ret == 0);
@@ -320,6 +324,17 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
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
@@ -339,7 +354,14 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
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


