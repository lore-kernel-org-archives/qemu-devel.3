Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC1DC79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MNX-0003cT-V2; Fri, 04 Sep 2026 01:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MNV-0003Ws-W6
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:22:18 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MNT-0001Vw-08
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:22:17 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8485b358552so537490b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499333; x=1789104133; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EpDsK9uNC1ywGcGXw53YMKLUm7W9fYZOS++xQrA4wQs=;
 b=Z9EnaeMAJhKa7MCQ3obgYCimS9TyypPBWMXU1JZNaROdZhPDurynlQO91f67Q1PEM/
 M5cf0NiVrkOVLisAih3EQoLbvS6iorQz+kN4HAYDKMsX9M7cxb2AwFFpQsANwQf3s/m3
 ++p676eqMzytHb85MteY1sMHypYQNsTGeKcsLXJ4K5oAe5/MCMr32chHjjjKXUDRivbj
 IAwlFnwjN764V0k5X4mRwDWI8lok1hMKu/I4hfQmG4q0AXZtFTJcDmu73B0ZRFTzz1AJ
 wUjvFEAWwbhjSAIJ/mNGfu7Wqk+vRVSdsLNBUX3aynWmjxDGZ7soF5RCKcl73e851pJy
 8Mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499333; x=1789104133;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EpDsK9uNC1ywGcGXw53YMKLUm7W9fYZOS++xQrA4wQs=;
 b=StMP+VvzG6w33tTQVfzKhFI2z8iKzgnHf8Dydz2hE7UxQ5rtf6eT2iL1Y1TO1/Qly3
 3WOGwMReKijWeX+CeKHC8tuhTyiEfgBBh4EI/3gKSAzusziBgA3DPvj1YnAHRtTxpGjI
 kby9b2X9JmUCTkYb/sigtXVn8KVx6Vr6jNt49drBaCsVTPZ0k9kP8hpoPucHbrMmVIYc
 Owg/3tDoq5GyAyla1J30FNymwgzycf7whxhAMz2FRyu3WC+KYzjNAWr7pg3MIsGtScwi
 IUl4631c0Q228onLcEO415lpW0qQAsbjE/EWKj/LpGiHaz+XJ4XTQiUFaddxDCdYCG1E
 RhWA==
X-Gm-Message-State: AFuF++mqUjozNGO5BuDHST2vGKulrlL+NMgPBjkYj4x6taGUykQEwE7J
 hLEGRQSyZ4S4HT9UCLEqFx8PwkbPLhZn4qDrh1W4vSlrrbRL2fVaFOWZkJTduw==
X-Gm-Gg: AYBFou23eQ/SDYYoaHXTn0bxlYZ7Mol+GSJIht3wfl5SQw9VOT4iBzsda21fZBqZDqo
 EbTvQBbOutekj7A+fsjnDXuowxbOqU9eudEtyV5Lhd56+9B0fjvL7Qyq1z/0f1dT4i2kIO9iU7U
 7tzKM+D74XkN2nEdRzgb3Raz/ACc9+2pA5KxWba7dqjqOMgkISch1xMYJt1iLv7jgtcGwHlIpOr
 VVEhpiSQxeTpXxQ4UJzgXT0IOBhhiO4y5P319h6GbBkBjvTm7vNBK3EyX/2XtcvnbJ4HsRb2umF
 5agYaH68BMc6PjdxX0x9qh6Aui6WIIuB3wutw4NQebzDbWuEwgg0dXPal2oWGzr3nx1Jv7GLfUa
 mPB6YfQ/BfZUCVSmeZ52BPyf8fBDZ1TSsjFy64MEqsbHwPNz2uAjaFm4pEDfLus5WQG11HdF359
 F7eEqJJP/p9wIjiuIC9eH/PVglKlLpCueKgCxcGjvDk5hKpwjdiuVB5ydbkttQup5Bela3qtpyq
 rfaWw==
X-Received: by 2002:a05:6a00:2996:b0:848:4754:28e5 with SMTP id
 d2e1a72fcca58-86169e6ecb7mr5493199b3a.16.1788499333449; 
 Thu, 03 Sep 2026 22:22:13 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:22:13 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 44/47] hw/riscv/atlantis: Make TTAtlantisState own memory
 containers
Date: Fri,  4 Sep 2026 15:19:40 +1000
Message-ID: <20260904051943.799041-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
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

From: Joel Stanley <joel@jms.id.au>

The DRAM hi, DRAM low and bootrom memory containers can be owned by the
TTAtlantisState.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260903055131.257903-14-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/tt_atlantis.h |  4 ++++
 hw/riscv/tt_atlantis.c         | 15 ++++++---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 2ec283d0fd..9ca98bfb84 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -31,10 +31,14 @@ struct TTAtlantisState {
 
     MemoryRegion *memory;
     MemoryRegion *dram;
+    MemoryRegion ram_hi;
+    MemoryRegion ram_lo;
+
     RISCVHartArrayState cpus;
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
     UnimplementedDeviceState uart1;
+    MemoryRegion bootrom;
 };
 
 enum {
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 4b4f5ff241..2a46336674 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -483,9 +483,6 @@ static void tt_atlantis_machine_init(MachineState *machine)
 {
     TTAtlantisState *s = TT_ATLANTIS_MACHINE(machine);
 
-    MemoryRegion *ram_hi = g_new(MemoryRegion, 1);
-    MemoryRegion *ram_lo = g_new(MemoryRegion, 1);
-    MemoryRegion *bootrom = g_new(MemoryRegion, 1);
     ram_addr_t lo_ram_size, ram_size;
     int hart_count = machine->smp.cpus;
 
@@ -543,22 +540,22 @@ static void tt_atlantis_machine_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    memory_region_init_alias(ram_hi, OBJECT(machine), "ram.high", s->dram,
+    memory_region_init_alias(&s->ram_hi, OBJECT(machine), "ram.high", s->dram,
                              0, ram_size);
     memory_region_add_subregion(s->memory,
-                                s->memmap[TT_ATL_DDR_HI].base, ram_hi);
+                                s->memmap[TT_ATL_DDR_HI].base, &s->ram_hi);
 
     lo_ram_size = MIN(ram_size, s->memmap[TT_ATL_DDR_LO].size);
-    memory_region_init_alias(ram_lo, OBJECT(machine), "ram.low", s->dram,
+    memory_region_init_alias(&s->ram_lo, OBJECT(machine), "ram.low", s->dram,
                              0, lo_ram_size);
     memory_region_add_subregion(s->memory,
-                                s->memmap[TT_ATL_DDR_LO].base, ram_lo);
+                                s->memmap[TT_ATL_DDR_LO].base, &s->ram_lo);
 
     /* Boot ROM */
-    memory_region_init_rom(bootrom, NULL, "tt-atlantis.bootrom",
+    memory_region_init_rom(&s->bootrom, NULL, "tt-atlantis.bootrom",
                            s->memmap[TT_ATL_BOOTROM].size, &error_fatal);
     memory_region_add_subregion(s->memory, s->memmap[TT_ATL_BOOTROM].base,
-                                bootrom);
+                                &s->bootrom);
 
     /* UART1, the soc console (UART0 is for the boot microcontroller) */
     serial_mm_init(s->memory, s->memmap[TT_ATL_UART1].base, 2,
-- 
2.55.0


