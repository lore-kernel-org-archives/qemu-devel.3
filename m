Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242DEE6894E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 03:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MFd-0007DW-Pi; Wed, 30 Oct 2024 23:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFc-0007DG-8w
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:36 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MFa-0003sg-HO
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:53:36 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20c693b68f5so5832605ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346813; x=1730951613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8jPqU1u91/bvSwOR04NsIfK/88xElvIo76xw8RLdAv8=;
 b=e0iji0sjVpozJdg0BJv3FySJMS/SZ0bLiveP7ebSfrQ1xOYqb/eFKCMEcaZ1Bj6QZq
 Prb4qVMstP7U7FMFQcy228nnT8CKZD1qZS6Zz+nYTW4TqMhjJVlTI9bt5bS6m5cDfCxc
 3U8tb+HT0J+YphNS3loL95RHouRzLGo8GXHwrWtwMiAaxOaaqsdmcrKVEsOk8Rt3kc1H
 eWlWHB8QUlFCqdfUGwNkxGmtl6spjEnCOT1nCyBpjxN619teAgLptHSeTEaUXpvvyij/
 7Fu2h7/sCmFwK9pZj/CVgRxDhl+h+ksbDWAiBQwtNBPGM0lFYWI6fWScsDsBsbAVY+Hy
 dMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346813; x=1730951613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8jPqU1u91/bvSwOR04NsIfK/88xElvIo76xw8RLdAv8=;
 b=PJDvdEE6O0cQu/yJb35PWxrOUYWBUDhfSte2kn+euiUoFGMh76SKYMEqHm6bMKs4Ib
 hw3wmQKGX4wuqtgfWsJkjDy8kz6TxCmE57ymgJ3gGef+mFsv7MJVC+KE1qPIcceYqOax
 iIwaWZWTSkTAJSIWpkc4rI7jHy4T8D28BEiotyALG+q9qhBQ8IVR3uOggAXP5NIGnq4s
 uzcFAOwVDGv/I/W//yOXbB/xpZ0aKc7vGdFbNRmskfLDw8R5dSQKY85AE5DRAFupjeoh
 CQY/ouqhD0sJFJgP3DNInsfgOKsBOxI5BWcsJDDXASQEYFjl+7Tj2zN0IohlxZrf+pqn
 rzLg==
X-Gm-Message-State: AOJu0Yy2at+er+AIeUQrfa6OR2q238TZ/0+nsCa1AVCbCJUDufW+S4O1
 pI4VvQh9beDnKWWNOH1mdPFD25EX+c2iFGbki/e/leA47sNg7TvkRU76+hlg
X-Google-Smtp-Source: AGHT+IGOWhtrvQPRuv5QLFl/4FLuqI3Kbqlm+xazclLMOotKFwq4iF2Db/lWCXarVNKpp8/xVPSN4g==
X-Received: by 2002:a17:902:d4c6:b0:20c:d2d9:765c with SMTP id
 d9443c01a7336-21103acd304mr25343285ad.15.1730346812780; 
 Wed, 30 Oct 2024 20:53:32 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:53:32 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/50] target/riscv: Add fw_dynamic_info32 for booting RV32
 OpenSBI
Date: Thu, 31 Oct 2024 13:52:30 +1000
Message-ID: <20241031035319.731906-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

RV32 OpenSBI need a fw_dynamic_info parameter with 32-bit fields instead
of target_ulong.

In RV64 QEMU, target_ulong is 64. So it is not right for booting RV32 OpenSBI.
We create a fw_dynmaic_info32 struct for this purpose.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240919055048.562-2-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/boot.h         |  4 +++-
 include/hw/riscv/boot_opensbi.h | 29 +++++++++++++++++++++++++++
 hw/riscv/boot.c                 | 35 ++++++++++++++++++++++-----------
 hw/riscv/sifive_u.c             |  3 ++-
 4 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 18bfe9f7bf..f778b560de 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -56,7 +56,9 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
                                hwaddr rom_base, hwaddr rom_size,
                                uint64_t kernel_entry,
                                uint64_t fdt_load_addr);
-void riscv_rom_copy_firmware_info(MachineState *machine, hwaddr rom_base,
+void riscv_rom_copy_firmware_info(MachineState *machine,
+                                  RISCVHartArrayState *harts,
+                                  hwaddr rom_base,
                                   hwaddr rom_size,
                                   uint32_t reset_vec_size,
                                   uint64_t kernel_entry);
diff --git a/include/hw/riscv/boot_opensbi.h b/include/hw/riscv/boot_opensbi.h
index 1b749663dc..18664a174b 100644
--- a/include/hw/riscv/boot_opensbi.h
+++ b/include/hw/riscv/boot_opensbi.h
@@ -58,4 +58,33 @@ struct fw_dynamic_info {
     target_long boot_hart;
 };
 
+/** Representation dynamic info passed by previous booting stage */
+struct fw_dynamic_info32 {
+    /** Info magic */
+    int32_t magic;
+    /** Info version */
+    int32_t version;
+    /** Next booting stage address */
+    int32_t next_addr;
+    /** Next booting stage mode */
+    int32_t next_mode;
+    /** Options for OpenSBI library */
+    int32_t options;
+    /**
+     * Preferred boot HART id
+     *
+     * It is possible that the previous booting stage uses same link
+     * address as the FW_DYNAMIC firmware. In this case, the relocation
+     * lottery mechanism can potentially overwrite the previous booting
+     * stage while other HARTs are still running in the previous booting
+     * stage leading to boot-time crash. To avoid this boot-time crash,
+     * the previous booting stage can specify last HART that will jump
+     * to the FW_DYNAMIC firmware as the preferred boot HART.
+     *
+     * To avoid specifying a preferred boot HART, the previous booting
+     * stage can set it to -1UL which will force the FW_DYNAMIC firmware
+     * to use the relocation lottery mechanism.
+     */
+    int32_t boot_hart;
+};
 #endif
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 9115ecd91f..2e319168db 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -343,27 +343,33 @@ void riscv_load_fdt(hwaddr fdt_addr, void *fdt)
                         rom_ptr_for_as(&address_space_memory, fdt_addr, fdtsize));
 }
 
-void riscv_rom_copy_firmware_info(MachineState *machine, hwaddr rom_base,
-                                  hwaddr rom_size, uint32_t reset_vec_size,
+void riscv_rom_copy_firmware_info(MachineState *machine,
+                                  RISCVHartArrayState *harts,
+                                  hwaddr rom_base, hwaddr rom_size,
+                                  uint32_t reset_vec_size,
                                   uint64_t kernel_entry)
 {
+    struct fw_dynamic_info32 dinfo32;
     struct fw_dynamic_info dinfo;
     size_t dinfo_len;
 
-    if (sizeof(dinfo.magic) == 4) {
-        dinfo.magic = cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_VALUE);
-        dinfo.version = cpu_to_le32(FW_DYNAMIC_INFO_VERSION);
-        dinfo.next_mode = cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
-        dinfo.next_addr = cpu_to_le32(kernel_entry);
+    if (riscv_is_32bit(harts)) {
+        dinfo32.magic = cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_VALUE);
+        dinfo32.version = cpu_to_le32(FW_DYNAMIC_INFO_VERSION);
+        dinfo32.next_mode = cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
+        dinfo32.next_addr = cpu_to_le32(kernel_entry);
+        dinfo32.options = 0;
+        dinfo32.boot_hart = 0;
+        dinfo_len = sizeof(dinfo32);
     } else {
         dinfo.magic = cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VALUE);
         dinfo.version = cpu_to_le64(FW_DYNAMIC_INFO_VERSION);
         dinfo.next_mode = cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
         dinfo.next_addr = cpu_to_le64(kernel_entry);
+        dinfo.options = 0;
+        dinfo.boot_hart = 0;
+        dinfo_len = sizeof(dinfo);
     }
-    dinfo.options = 0;
-    dinfo.boot_hart = 0;
-    dinfo_len = sizeof(dinfo);
 
     /**
      * copy the dynamic firmware info. This information is specific to
@@ -375,7 +381,10 @@ void riscv_rom_copy_firmware_info(MachineState *machine, hwaddr rom_base,
         exit(1);
     }
 
-    rom_add_blob_fixed_as("mrom.finfo", &dinfo, dinfo_len,
+    rom_add_blob_fixed_as("mrom.finfo",
+                           riscv_is_32bit(harts) ?
+                           (void *)&dinfo32 : (void *)&dinfo,
+                           dinfo_len,
                            rom_base + reset_vec_size,
                            &address_space_memory);
 }
@@ -431,7 +440,9 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
     }
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           rom_base, &address_space_memory);
-    riscv_rom_copy_firmware_info(machine, rom_base, rom_size, sizeof(reset_vec),
+    riscv_rom_copy_firmware_info(machine, harts,
+                                 rom_base, rom_size,
+                                 sizeof(reset_vec),
                                  kernel_entry);
 }
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9b3dcf3a7a..c5e74126b1 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -645,7 +645,8 @@ static void sifive_u_machine_init(MachineState *machine)
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           memmap[SIFIVE_U_DEV_MROM].base, &address_space_memory);
 
-    riscv_rom_copy_firmware_info(machine, memmap[SIFIVE_U_DEV_MROM].base,
+    riscv_rom_copy_firmware_info(machine, &s->soc.u_cpus,
+                                 memmap[SIFIVE_U_DEV_MROM].base,
                                  memmap[SIFIVE_U_DEV_MROM].size,
                                  sizeof(reset_vec), kernel_entry);
 
-- 
2.47.0


