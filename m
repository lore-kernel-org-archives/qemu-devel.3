Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77601C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLrF-0001rB-Vf; Wed, 26 Aug 2026 18:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLrF-0001r3-DL
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:12:33 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLrD-0006bm-NJ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:12:32 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so74036a91.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787782350; x=1788387150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YAXZV6zAbM1l8BTrMY8dps++9Fqi8o3MB24YeyVs67U=;
 b=SLvM8RlWMpigXPp7eLZdKmmDlOaY5rRMxeU2tb+mGZYZBAS+AWIj819lOvMyh+cjoV
 a5kX7QAlLGQOSXsiuhnL3Oo3/1D7sfTVRnsJ0FsyF0uFjO/KId4HgCnmnVRmggP086Cs
 B/mjVd0PwCZgmpHJf22bDT69ptiW8IU0sFb7pikG1ALJvkieQvS14Ox4lUBV/In3yiFI
 ElOrt2BBKF6T0y0e6rU6HGuSlAqcBQAz0wQu62bplFAUKXojjmtIPhAly9Njz8Hs6S7P
 fYDuYaLeakystlwua+49ZtKWBlonwidl//M+QkdnP/nJLir/57vA6McG+nkJwFBPvc07
 gToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787782350; x=1788387150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YAXZV6zAbM1l8BTrMY8dps++9Fqi8o3MB24YeyVs67U=;
 b=EZncUT93djWk2kIW3ctO6aVThnQjQylhB011+DtzNT7TPyK1dTtqQBUnNyAnPQU45D
 Ocm8FAT3E9rOl/rPRQzJETH5y4SkSBkUlTgIO+hSNGXrZJCQKaz5HhvoE/OyvwQBFTxK
 z8VXg+bwElIQ37YEUXZqs9YZueszWjtTe2fnLXi6cGT4FXFniuZ2vdwr+78PI2CFHnEp
 sOipaxnoUFAe/NaA6kk7C4XvmnVqyK9o8cu4KqaTmwCgejO3RDKF1qaQQGxFyjHypCJa
 OUcX8Ysqp+wYLtqEroVaLUoazkkgV43KA/SGV1ncDcpQ6aB2/HkY6L8gM2Nswgwkz8sF
 Up3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9nIDk3lfDS/Vg/BpgmwTC0ks/YKk9b+wkOOmtEqzktOAJTRtbLa/J+8K4AC+tRJE9yLV2zbXGkSWX@nongnu.org
X-Gm-Message-State: AFuF++lzsUGJwB8AirSNT96Ne3UixSV2neSN/sDwXKZfze9xCCVqNiU+
 kWScEvjqoCR0uWGGtDpzm2uAu2ga3R1LWjm3YtbVcrORvQwNIh7FD4mp
X-Gm-Gg: AR+sD11ltRNVdibqt5SU8iA3bWPbLByYViFBkKp2+y4HqNbGuoOJCaGP7YASUNKnXUe
 wjjvkWgPueeNGr5auVLYyfRmRl3FD9fFbe748C3YlGfGVa/YQuH1W1lt2Ww7xic92QoNywQWo6d
 HuDsvPq7Gyb1lex6t4lySZXrKAeORp/uMa/s5A/umUemcjp9nb0A58R6Zxl0ZsLu1QC+59j5my0
 RTLfp98+T7Kgf2pK7RhA8uqy3xdSb+SjrDMnM6FJ70qEj1XfqmlxlNa5amybidNq3YxsvlwNSEF
 t/C2jKIUD1R52XlZkvZlh61A+yC4NDXk0KVU04byHY2QnUFWpj8uuCzx8UPUH2nwRufZQ5rKZBz
 y5uRc5gGV783O9S829lSElg4o2Bwsi+YDTQsnp+gIHjYl/QMkCsdGqyagDS2PQCsFdFH46gHm7i
 NhB5KgBjt9C88qa47DYqF6r5lFhI1/+9wh5T0+A032hxgqIy4XqOA+M3aQedGBSz+OJHJnc8VVn
 CMcFwP2RK+KOBbju06Jr4DBXba09iXz/HVuspMee0uN1uxned4JeCllnI7MI6nF1v1hO1UjNIUl
 C3MVG5WAqRwLI7LeMYdx
X-Received: by 2002:a17:90b:2247:b0:38e:6aa7:68ad with SMTP id
 98e67ed59e1d1-3966d1847c6mr19076054a91.5.1787782350309; 
 Wed, 26 Aug 2026 15:12:30 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0d3d7fbsm17459a91.3.2026.08.26.15.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 15:12:29 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 13/16] hw/riscv/atlantis: Make TTAtlantisState own memory
 containers
Date: Thu, 27 Aug 2026 07:41:49 +0930
Message-ID: <20260826221154.54577-5-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260826221154.54577-1-joel@jms.id.au>
References: <20260826220528.54516-1-joel@jms.id.au>
 <20260826221154.54577-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The DRAM hi, DRAM low and bootrom memory containers can be owned by the
TTAtlantisState.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/tt_atlantis.h |  4 ++++
 hw/riscv/tt_atlantis.c         | 15 ++++++---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 2ec283d0fd7b..9ca98bfb8478 100644
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
index 7a9f5872c7c0..b80bdf54c40b 100644
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
2.47.3


