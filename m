Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A28C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MNW-0003a8-NK; Fri, 04 Sep 2026 01:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MNS-0003IX-02
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:22:14 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MNP-0001VX-SS
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:22:13 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-853c947bfefso512296b3a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499330; x=1789104130; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JcqyT89XMLYEQdZ+Sp1u+vXlhJ/pCbVerWKVJ3eXiKw=;
 b=PPJoph7EF4DvvqIFWA9h0u9Pj9eJ80ZrS3WTNrZFvAGYZUL/PATeoaE9VgtEcdIKma
 IbuDhR9R4kLtf2QekFKF244j/aj9DlBLCoRqJscTmHSij3yEE+5A7r7EYv3t44+wDA+X
 AzOCEVhz6npa4c2vMxKmsFfEYl8wvKYA6WeScd6vee1uEKtb39ibLjEnP/rRKcS3xg8b
 FCWMG/RN0JtNUV8NUIft5fZ4lCMYpqyy1UpZDkrZVmJ6cECkgMghea2g9g0wtU7+g3sV
 GsUBo/4dFVlASUNoBrYTIRSrGpP2IxGsrPr0/qA72uROyYifIFBwk4MXlHyRhyOMbLiv
 BLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499330; x=1789104130;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JcqyT89XMLYEQdZ+Sp1u+vXlhJ/pCbVerWKVJ3eXiKw=;
 b=f/I9mHedoC403wbfs6F4ttMK6IG1DyVIHez8pDZytsFl/Te3c7YKkMetyrS2sNouGZ
 V68orPpqYMwixdww14SdhVxt9f0h+/k3HYb7rh7qCBclHK8bFB/tbVWZw0Q/0snetGkC
 Juv1OLc6CADO/26OCcIT6tlfG+Y1ZlAc2j3kDCxdXhWOhJdQNPQuYe6Mh+gyrG8dHfGG
 g0KjzV2slpeBHThbMBYT6wAWtwB7CEXBgUdfWrxzrEIg8jZeLV/tCnZy3QEtaESfWb1j
 8mXNEvPWjzUo5ySPwFwShFDFmZuD9EhMUNx+tlq0aR+yFgErjnl2IFncPZLBVE/zf6EJ
 +XsQ==
X-Gm-Message-State: AFuF++kvQn5DRVoZz6MZ6Y+21kVIGrbL0RIdcKw2Jmt+nEJ2dyVV3rfw
 7SOZOMdnp5rrVMP0KIRyytvcFMrSF/IJtqoBXXpPJxy3dAtWCzYGEySYRvjbEQ==
X-Gm-Gg: AYBFou2BKxC2NTXt4WN3n3C0fALa0FSO2ArBie87Cczz4nNQts+Z0JoEPs/lElzRITS
 szBZw1Q0VTl+5pDkrLUip+Qc1csl5wxhRxhJAH1f62N0XalzJNzpJsw6h3kb0VYMoyJmi+sR23Z
 LoDzF+VFTpcu/iPqpxhuVGe4qJyFgNsaRKnQ+r8gC904zNX4zdIjk2Mr8x+hnWWaJ6EljYBMD/L
 H1B/5CCilYu7uSYUf4oRrS3cXLLv+tADNVg8XnCARgbJMSEGFaVZnA0RDvxmlXTXpoOuAcVoqV9
 EEODeyvrIINVRIVaYkpgiTdo+uo1sER7wy3gmkIbSELyOg+kKJjVtCfzMz1NBMRiB2Eb6Depi3f
 9TwTfICtnzoG4I1bdSJBykcZafR80ed86iDER+C71g9feJ5ZlyVPx/EaofFPxMqJmgEJld3Kkj2
 fx3LOWkpDcyv5FNxYa8pO4AM3LvNHyYkeDulapkmT0DqiQnBX1PYSbIzRY3ZyeeIS+fudDhOrS3
 puibw==
X-Received: by 2002:a05:6a00:2996:b0:853:430e:6b60 with SMTP id
 d2e1a72fcca58-85ffe10a136mr8830929b3a.14.1788499330238; 
 Thu, 03 Sep 2026 22:22:10 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:22:09 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 43/47] hw/riscv/atlantis: Decouple RAM size from MachineState
Date: Fri,  4 Sep 2026 15:19:39 +1000
Message-ID: <20260904051943.799041-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
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

Keep a reference to the machine's RAM MemoryRegion in TTAtlantisState,
and get the MemoryRegion's size where the configured RAM size is
required.

This allows reading the RAM size without needing a pointer to
MachineState, decoupling the memory layout setup from the machine.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260903055131.257903-13-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/tt_atlantis.h |  1 +
 hw/riscv/tt_atlantis.c         | 20 ++++++++++++--------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index a29c67c1cf..2ec283d0fd 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -30,6 +30,7 @@ struct TTAtlantisState {
     const MemMapEntry *memmap;
 
     MemoryRegion *memory;
+    MemoryRegion *dram;
     RISCVHartArrayState cpus;
     DeviceState *irqchip;
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 6555da02f0..4b4f5ff241 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -81,12 +81,13 @@ static uint32_t next_phandle(void)
 
 static void create_fdt_memory(void *fdt, TTAtlantisState *s)
 {
-    hwaddr size_lo = MACHINE(s)->ram_size;
+    hwaddr ram_size = memory_region_size(s->dram);
+    hwaddr size_lo = ram_size;
     hwaddr size_hi = 0;
 
     if (size_lo > s->memmap[TT_ATL_DDR_LO].size) {
         size_lo = s->memmap[TT_ATL_DDR_LO].size;
-        size_hi = MACHINE(s)->ram_size - size_lo;
+        size_hi = ram_size - size_lo;
     }
 
     riscv_create_fdt_socket_memory(fdt, s->memmap[TT_ATL_DDR_LO].base,
@@ -485,11 +486,14 @@ static void tt_atlantis_machine_init(MachineState *machine)
     MemoryRegion *ram_hi = g_new(MemoryRegion, 1);
     MemoryRegion *ram_lo = g_new(MemoryRegion, 1);
     MemoryRegion *bootrom = g_new(MemoryRegion, 1);
-    ram_addr_t lo_ram_size;
+    ram_addr_t lo_ram_size, ram_size;
     int hart_count = machine->smp.cpus;
 
     s->memory = get_system_memory();
 
+    s->dram = machine->ram;
+    ram_size = memory_region_size(s->dram);
+
     s->memmap = tt_atlantis_memmap;
 
     object_initialize_child(OBJECT(machine), "soc", &s->cpus,
@@ -532,20 +536,20 @@ static void tt_atlantis_machine_init(MachineState *machine)
      * The high address is where RAM lives. It is always present and may be
      * up to 64GB. The low address is an alias of the first 2GB of that RAM.
      */
-    if (machine->ram_size > s->memmap[TT_ATL_DDR_HI].size) {
+    if (ram_size > s->memmap[TT_ATL_DDR_HI].size) {
         char *sz = size_to_str(s->memmap[TT_ATL_DDR_HI].size);
         error_report("RAM size is too large, maximum is %s", sz);
         g_free(sz);
         exit(EXIT_FAILURE);
     }
 
-    memory_region_init_alias(ram_hi, OBJECT(machine), "ram.high", machine->ram,
-                             0, machine->ram_size);
+    memory_region_init_alias(ram_hi, OBJECT(machine), "ram.high", s->dram,
+                             0, ram_size);
     memory_region_add_subregion(s->memory,
                                 s->memmap[TT_ATL_DDR_HI].base, ram_hi);
 
-    lo_ram_size = MIN(machine->ram_size, s->memmap[TT_ATL_DDR_LO].size);
-    memory_region_init_alias(ram_lo, OBJECT(machine), "ram.low", machine->ram,
+    lo_ram_size = MIN(ram_size, s->memmap[TT_ATL_DDR_LO].size);
+    memory_region_init_alias(ram_lo, OBJECT(machine), "ram.low", s->dram,
                              0, lo_ram_size);
     memory_region_add_subregion(s->memory,
                                 s->memmap[TT_ATL_DDR_LO].base, ram_lo);
-- 
2.55.0


