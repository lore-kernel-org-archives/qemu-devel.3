Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353FF606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 04:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=YvFH2TlZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLvKX-0007XE-LN; Wed, 28 Oct 2026 00:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xLvK4-0007U8-G5
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 00:31:38 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xLvK2-0001cX-9c
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 00:31:36 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3ae1a9e187aso69317a91.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 21:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1793161891; x=1793766691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8KV/JWmMLMTmMcW3oEws7TSmxlckucAfZ89o3DpFXzk=;
 b=YvFH2TlZFVPbQUaLn5kiWs/v46WHKm64yIuoympQV+vopzS2MB/gZf6ZKC3WYcbDPq
 ZOZjSzQLITD+5GIC6fXbCIdttveP3MoKL5yC7sNhHpVE5c3x66G6RKINWB69ZO+prglO
 Hj5UH+SQAbYPGp2rpYzaAOunZLd7f6oe2GI3OCCLXEVwZ65a3RLR5YBcgjT/mJoyQ+el
 7348a0JGXFR3pb1o3pOA7zdXcveNCVuwxuS0Vz7soqpB/LLG/5bEk/5XllARxDLtc1CR
 TmTo8vEBgCJxGobZNm6+EQa/lUsGSkJTB0pC4HlLHGaYEgEDgwJnMGZp/Qi2AQ4VBzMp
 2pvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793161891; x=1793766691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8KV/JWmMLMTmMcW3oEws7TSmxlckucAfZ89o3DpFXzk=;
 b=gMT4pItVv5PgZm3EyWMETY78n6Q5PHGXN2JmpSstT/UVa/cet6Gm1V20njbUM6vc0T
 QuK8F2CC8STdmitClh8WmIKpM+80pdgfxqSXRjRtdit6BxC2quW0/d/Sn8YAUM70G1/c
 qeOWdwd2WWGV54GZXgs2BNFhOesdN/4jf2e9t+rlcovQ87tpZjMzH/cFTSpG1gE8umQA
 NI4yO65/FBDgmuPkOuAgo6orn3JSvEYMxcN/HYfZkRUCoxVWLCrVMVKgpYLLkvM+yX0d
 7d0XI60CDp+wDl1/Z61araDkAjglbsk/IMqC5p2Qu+0V+2TyBNJv2oHURqb4uN3AvNyS
 KVXg==
X-Gm-Message-State: AFq9FYJ65SpdT2ahv0zrxZeDWGAHKUHM9lTUaq2fI7BJ4MO2Jh9ZIb0Q
 e2yGYBsM9KyOjQ0rnNxBv5/IQR6yI77RAaMow9/TNjCNgqktFJcN5oc/yUOEbrrpzAefy9GzGQi
 DPD7RZqk=
X-Gm-Gg: AYBFou1Z0F6Hl/y5zxXQO1nGBUTwjitwgfNBwstILBjy2A9MJEY25hjNhajYe/66LeU
 5Bdyym6TelUTpC7sDEvi+oTHUu2DgMdO8BjhUCIHHnt6AgINEFaHa8aYvaXHKDqnPtz+n3Nb/D5
 YHAPo+kGpCmLKTrezIuNBUtiBQ8LRgmfkylByQ37Ae7dZBlt20k4/mkUyTnuffQZqOySMZzBaV+
 NvJxjuX4yONSIbLIGMtcBD0OBhXig6ykSsNkxlv/rnoxwSao5V2HsvF2iCXHWEk4pkmhWMV3QSE
 Rdbg8F8aV6YZvkf3P1fI+l2F5i6kT1+n862dIIIdA/IzRHKCFgZ5vVlRYNAoCbFa6OEa1jD4mgh
 O4BUaWU7UNXoe+Ew0y2/3zTWer+milySmpCqLs8L6zo3Kc6pRk0GcwgD5mFvn+C/6/7aAvRfeA7
 DI9btC0cxvj7TWwmr5bvCa7J2TVnQkJfBcUkuRI1ddoqtCiofe7eNIV029/tqXm+nAjf9kp9XvH
 cc7Ec15nwnxNRzjkHJP3Rq9kOVKxR66WE0NPPPYLaItFPmbNgjNv3YCT0P7lTPbLafHLCyHw2uR
 FzyLyaMgefcB3YxuXK/JFjmtCr5szxbNc+d+BzvfBG+eGDfdSDE9M4kCxOX6tUhu+BE0c/hBTG0
 sfA==
X-Received: by 2002:a17:90b:2250:b0:3ac:73c7:9c07 with SMTP id
 98e67ed59e1d1-3ae57bc221amr1474223a91.0.1793161890574; 
 Tue, 27 Oct 2026 21:31:30 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a5d45a8sm1024470a91.17.2026.10.27.21.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 21:31:30 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Ellerman <mpe@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 03/10] hw/riscv/atlantis: Store Ascalon memory in cluster
 struct
Date: Wed, 28 Oct 2026 14:30:52 +1000
Message-ID: <20261028043059.600498-4-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028043059.600498-1-portias@oss.tenstorrent.com>
References: <20261028043059.600498-1-portias@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The system memory is the memory view of the Ascalon CPU. Store the
memory directly in the TTAscalonClusterState and set it to
system_memory. There is no need to track it at the machine level,
get_system_memory() can be used when needed.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 hw/riscv/tt_atlantis.c         | 43 ++++++++++++++--------------------
 include/hw/riscv/tt_atlantis.h |  3 +--
 2 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 7f9231e6ff..9b37e845da 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -558,18 +558,19 @@ static void tt_ascalon_cluster_realize(DeviceState *dev, Error **errp)
 {
     TTAscalonClusterState *ac = TT_ASCALON_CLUSTER(dev);
 
-    if (!ac->memory) {
-        error_setg(errp, "'memory' link is not set");
-        return;
-    }
     ac->memmap = tt_atlantis_memmap;
 
+    /* Ascalon's memory view is system memory */
+    memory_region_init(&ac->memory, OBJECT(ac),
+                       "tt-ascalon-memory", UINT64_MAX);
+    memory_region_add_subregion(get_system_memory(), 0, &ac->memory);
+
     /* Boot ROM */
     if (!memory_region_init_rom(&ac->bootrom, OBJECT(ac), "tt-atlantis.bootrom",
                                 ac->memmap[TT_ATL_BOOTROM].size, errp)) {
         return;
     }
-    memory_region_add_subregion(ac->memory, ac->memmap[TT_ATL_BOOTROM].base,
+    memory_region_add_subregion(&ac->memory, ac->memmap[TT_ATL_BOOTROM].base,
                                 &ac->bootrom);
 
     /* CPUs */
@@ -583,7 +584,7 @@ static void tt_ascalon_cluster_realize(DeviceState *dev, Error **errp)
                             ac->memmap[TT_ATL_BOOTROM].base,
                             &error_abort);
     object_property_set_link(OBJECT(&ac->cpus), "memory",
-                             OBJECT(ac->memory),
+                             OBJECT(&ac->memory),
                              &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&ac->cpus), errp)) {
         return;
@@ -593,8 +594,6 @@ static void tt_ascalon_cluster_realize(DeviceState *dev, Error **errp)
 static const Property tt_ascalon_cluster_props[] = {
     DEFINE_PROP_STRING("cpu-type", TTAscalonClusterState, cpu_type),
     DEFINE_PROP_UINT32("num-harts", TTAscalonClusterState, num_harts, 8),
-    DEFINE_PROP_LINK("memory", TTAscalonClusterState, memory,
-                     TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
 static void tt_ascalon_cluster_class_init(ObjectClass *oc, const void *data)
@@ -653,7 +652,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
 
     ram_size = memory_region_size(s->dram);
 
-    s->irqchip = riscv_create_aia(ac->memory,
+    s->irqchip = riscv_create_aia(&ac->memory,
                                   true, TT_IMSIC_GUESTS,
                                   TT_IMSIC_STRIDE,
                                   TT_IMSIC_STRIDE,
@@ -666,7 +665,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
                                   TT_IRQCHIP_NUM_MSIS,
                                   TT_IRQCHIP_NUM_PRIO_BITS);
 
-    riscv_aclint_mtimer_create(ac->memory,
+    riscv_aclint_mtimer_create(&ac->memory,
             ac->memmap[TT_ATL_ACLINT].base,
             TT_ACLINT_MTIME_SIZE,
             0, hart_count,
@@ -688,13 +687,13 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
 
     memory_region_init_alias(&s->ram_hi, OBJECT(s), "ram.high", s->dram,
                              0, ram_size);
-    memory_region_add_subregion(ac->memory,
+    memory_region_add_subregion(&ac->memory,
                                 ac->memmap[TT_ATL_DDR_HI].base, &s->ram_hi);
 
     lo_ram_size = MIN(ram_size, ac->memmap[TT_ATL_DDR_LO].size);
     memory_region_init_alias(&s->ram_lo, OBJECT(s), "ram.low", s->dram,
                              0, lo_ram_size);
-    memory_region_add_subregion(ac->memory,
+    memory_region_add_subregion(&ac->memory,
                                 ac->memmap[TT_ATL_DDR_LO].base, &s->ram_lo);
 
     /* 4 PRCM blocks */
@@ -703,7 +702,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(
-        ac->memory, ac->memmap[TT_ATL_PRCM_RCPU].base,
+        &ac->memory, ac->memmap[TT_ATL_PRCM_RCPU].base,
         sysbus_mmio_get_region(
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_RCPU]), 0));
 
@@ -712,7 +711,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(
-        ac->memory, ac->memmap[TT_ATL_PRCM_HSIO].base,
+        &ac->memory, ac->memmap[TT_ATL_PRCM_HSIO].base,
         sysbus_mmio_get_region(
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_HSIO]), 0));
 
@@ -721,7 +720,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(
-        ac->memory, ac->memmap[TT_ATL_PRCM_PCIE].base,
+        &ac->memory, ac->memmap[TT_ATL_PRCM_PCIE].base,
         sysbus_mmio_get_region(
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_PCIE]), 0));
 
@@ -730,7 +729,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(
-        ac->memory, ac->memmap[TT_ATL_PRCM_MM].base,
+        &ac->memory, ac->memmap[TT_ATL_PRCM_MM].base,
         sysbus_mmio_get_region(
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_MM]), 0));
 
@@ -744,7 +743,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        memory_region_add_subregion(ac->memory,
+        memory_region_add_subregion(&ac->memory,
                                     ac->memmap[TT_ATL_UART0 + i].base,
                                     sysbus_mmio_get_region(sbd, 0));
         sysbus_connect_irq(sbd, 0,
@@ -758,7 +757,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(sbd, errp)) {
             return;
         }
-        memory_region_add_subregion(ac->memory,
+        memory_region_add_subregion(&ac->memory,
                                     ac->memmap[TT_ATL_I2C0 + i].base,
                                     sysbus_mmio_get_region(sbd, 0));
         sysbus_connect_irq(sbd, 0,
@@ -787,10 +786,6 @@ static void tt_atlantis_machine_init(MachineState *machine)
     TTAtlantisSoCState *s = &ams->soc;
     TTAscalonClusterState *ac = &s->ascalon;
 
-    memory_region_init(&ams->soc_memory, OBJECT(machine),
-                       "tt-atlantis.soc-memory", UINT64_MAX);
-    memory_region_add_subregion(get_system_memory(), 0, &ams->soc_memory);
-
     object_initialize_child(OBJECT(machine), "soc", &ams->soc,
                             TYPE_TT_ATLANTIS_SOC);
 
@@ -802,9 +797,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
                             machine->smp.cpus,
                             &error_abort);
 
-    object_property_set_link(OBJECT(ac), "memory",
-                             OBJECT(&ams->soc_memory), &error_abort);
-    object_property_set_link(OBJECT(&ams->soc), "dram", OBJECT(machine->ram),
+    object_property_set_link(OBJECT(s), "dram", OBJECT(machine->ram),
                              &error_abort);
 
     qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 4e3d5d4b5f..52b44504ae 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -37,7 +37,7 @@ struct TTAscalonClusterState {
     /*< public >*/
     const MemMapEntry *memmap;
 
-    MemoryRegion *memory;
+    MemoryRegion memory;
 
     RISCVHartArrayState cpus;
     MemoryRegion bootrom;
@@ -70,7 +70,6 @@ struct TTAtlantisState {
     /*< public >*/
     Notifier machine_done;
 
-    MemoryRegion soc_memory;
     TTAtlantisSoCState soc;
 };
 
-- 
2.43.0


