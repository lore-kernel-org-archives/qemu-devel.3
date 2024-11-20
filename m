Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEC7D711B4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 15:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDmo5-0003c3-Mm; Wed, 20 Nov 2024 10:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1tDmo4-0003bG-0i
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 10:39:52 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1tDmo1-000610-Fz
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 10:39:51 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71e953f4e7cso3084301b3a.3
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 07:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1732117188; x=1732721988; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2KZqQE/UUmVgsvRJGOS0j9UuW1/93sgKbbyM+lCyFz4=;
 b=c2FMkU4Y7BIJBP3MeDGag8N4Us4Ea0VVtdTpaaXLb1ZiNdrJH7NsKerJotO25uKrCe
 3IaidDgLXcc2G3NntMysTSV1S3dcPS9pNS2XQUn+QK7BvvpBCW78wG1WMhnHWAXr2bNz
 b7lEqUdTdLMoVrgYnmJt7qF9qe6vMhuItZxjHoS8KvcbG73ImBxaYJpACs6aR9v17kRF
 UGRxVBF2RC6xgaspl1iXLztZ06gWJw7FFWXGi4hE1img9l4V9gUJHUgaSYB8oN6HwT4z
 QBrAq5xzM5YGkvSSK5xL+Fp/NEJEMehqq2cASk7cd2Tp9TFSLUXIMINYRuMG7MZL404P
 jVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732117188; x=1732721988;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2KZqQE/UUmVgsvRJGOS0j9UuW1/93sgKbbyM+lCyFz4=;
 b=SOhDKUvPtaiz8uXwv24RT4GRdj4oviXVst6RS1pk2myBYH0U/5oi4DfuJD5sA6/yvz
 bLrzZCf91eeN+iwjoDKXqz5vT6UQX5ZMKl0K7h/JUCZywYS6biLRvk6c6TcXB60hPj5v
 FwwXZsoAn4wKxArOjLehH+NW+e8LpFQtBjG6b4qWcgBedNKm/vHJvHm6HYJEYSiWvKGT
 un816roW/eJP6LfWdWkv8+dzZX7pBZYItlZkIHmS9EbLe4l8zDf0xIrnkILJw8ZM0nFE
 Q0Ondhy1HSPGRVrvJZpHegtCZbOuM4EyS6vLpBKk1O+x0vXYnkIPL1ZTlIwSeJCjcAnU
 xuBA==
X-Gm-Message-State: AOJu0YzDiseHG00QiHkYB44tG7LGZRk4b8fYuFQBKY8upUdvAKEl4d8y
 fy48D8CetXLtZ/g9CXazyOqQXqezI7gp9bXDlfb3PvgaLyg7FnMF1+5lguZE00eCWDehkLwE/hs
 dGp7Vsoauxbbb1bUBAOkfdYoVzH6sgifGxPTt8A3j0DVQ9v3qWZ3L/+eml8jXBHd2dU4ObITEap
 F2cPxpcuBFF0JW5OtIwzzDJWN3vqKlhVCKtvdq
X-Google-Smtp-Source: AGHT+IGF3bacYwqDii80+IvMeZTPV28U8Y7akDXQInprbO3IStychSVfUBDnR85ZGLeFPn4iQXO1Kw==
X-Received: by 2002:aa7:88c6:0:b0:71e:e4f:3e58 with SMTP id
 d2e1a72fcca58-724bede9bbbmr4335605b3a.17.1732117187509; 
 Wed, 20 Nov 2024 07:39:47 -0800 (PST)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724bef8da6asm1838903b3a.123.2024.11.20.07.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 07:39:47 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v4 3/3] hw/riscv: Add the checking if DTB overlaps to kernel
 or initrd
Date: Wed, 20 Nov 2024 23:39:35 +0800
Message-Id: <20241120153935.24706-4-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241120153935.24706-1-jim.shu@sifive.com>
References: <20241120153935.24706-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x433.google.com
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
index 81d27f935e..bc8074fec8 100644
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
index 06b51ed086..7d59b2e6c6 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -32,6 +32,9 @@ typedef struct RISCVBootInfo {
     hwaddr image_low_addr;
     hwaddr image_high_addr;
 
+    hwaddr initrd_start;
+    ssize_t initrd_size;
+
     bool is_32bit;
 } RISCVBootInfo;
 
-- 
2.17.1


