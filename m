Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A9F606A324
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 04:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=Rbu8PMcu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMdsE-0002DY-5J; Fri, 30 Oct 2026 00:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xMdsA-0002Ch-1U
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 00:05:47 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xMds8-0004or-1u
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 00:05:45 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-33bb5afa736so55681eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 21:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1793333143; x=1793937943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eFaQWCtZcxUVq9iHzu9TKc9GWSooUMKRzguLIKQFbgk=;
 b=Rbu8PMcu0319E41Q4MI1UOrz2XjUpcJlYIPZEQSKw1Kb5o908Z87/57/x3H1y6oHdo
 AX7QcB/35ojfkxrNfG0hDZDDs69vXxCqZ5T++YmCOTTSe9vR+EX5c7M/1uY9XAUMS4Ra
 qzXFy2+BkllTILT1syy3MsiXPcx9i/Eix5QIHI4qk2HuB5fKgwvkHQY4wxvImYHudgj6
 l0sWNdUswwv95pjJvJl0Gn5epN4byzAhL/tAfCCgtjzUTw3WmOjbAvzOkkledUpgYzGq
 uw2G7tQyEBav8OtTGCLS7+/oY/eWIC3TFLz7OFmTvZJnJN3dqUKgRLAbksALFM0/wJkW
 Jshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793333143; x=1793937943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eFaQWCtZcxUVq9iHzu9TKc9GWSooUMKRzguLIKQFbgk=;
 b=E90f1QJxUX+ha2qMFNyG1zzpKwN716dzfRyCjdKFcYviMvwe+KA38p8wSACEVXm90m
 CAQ/XiPDibvN6JRKSBhD/xtvF/1ABfqK3TohM3XWuMgb6S3O1GqbXBiVwxU9zkqkDOZu
 bHjpblzFUQnCnjhb99wAXmv7X4NpYf2DRpAn4xepTuJh2bGNaoG2vkOuuYQy1qfhovqJ
 iMxK4HsGZVBpdquRPwnZ+P57DFxq03QTGgSXcFWF7CHfbjznN/1wvP0dvREzTEJpYLPd
 +gPkabutIaW1yt5Ux6CKGQjtoL04m0ygI4xU9Hj3BTxGXnpD7/FA64OEotv4IIA9B3Vx
 U3cA==
X-Gm-Message-State: AFq9FYLKZf0dAb8DJieB1xTDC6dXm5oaExCYAzl1DhfcX8xtH1/k7ssw
 pB4yph2LvR0RD+Zf2rL0g9Q2Rarei6ZgjPRGOC0Edy7x0kgcPzTAaQ58TpJ0BO4nx1SUtQpL8a+
 gCiDnm1Q=
X-Gm-Gg: AYBFou08r55kjMnEOuX2IzFsS1csMwoe9Sw6GDROILBm351i3LHhJHlSopVv5wJ1hlf
 eGW7Y3+8QNwdpsBpNcTk7exfgfL+fV76wtbrXxmGSuZ3VmdrvP2zbnnSxaQWUfsjBQdAyJ+fwB6
 Wl21fbEHEDg5U4UlNfZ15RV1BoCbvW77/YoOYFZ5dlyGW4tKkzwsbZHPh1kuKRakZbWU8Ix27D0
 moJql5oz5hrttprElA1TZri4CZX9t7ggZCctXNjVqndKorGvy2g3NA7uRMloy+PVB/xo05j8+c/
 uLBG7qBry1JIj14BfCtGmhgqx4lLowV4wINw8vJXqCqbRqwq4yzu9lUMORFigex2aAV/K4NlX9p
 8AX07s8pz0NRb4CeufeusL3/FQpeN/sqUwO3R00ynWtBKAq3FmokxnxV6wOj+dym0Mp/wNOixUS
 WhpFQwmtl7eSC8Xs21/gX0ZqRnY0n69KnfVcCsWccgyupS49zVoj837WtdmKm9ZopEUnfUfe5QV
 rbznmzoGOuU6SOfUd0/cRC5rPVwwGKgKGuP55jxjlJFTkTC6c1KPqBj2HB7ZsJ+vX8lZAQBkPlH
 WxobabjIm1OGOApLftX/Ymd8frkwxH9nsPBnw8cjiAhsox9YQ8pgH23P2WDhU7A2bCr7cg02Vil
 dqGltz6Pt4JInHcwgfo8SlcY=
X-Received: by 2002:a05:7301:1c9f:b0:368:5521:612f with SMTP id
 5a478bee46e88-36a4206296dmr2726390eec.0.1793333142280; 
 Thu, 29 Oct 2026 21:05:42 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1easm2957687eec.5.2026.10.29.21.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 21:05:41 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Michael Ellerman <mpe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Zhao Liu <zhao1.liu@intel.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Joel Stanley <joel@jms.id.au>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v3 3/9] hw/riscv/atlantis: Store Ascalon memory in cluster
 struct
Date: Fri, 30 Oct 2026 14:05:09 +1000
Message-ID: <20261030040516.853444-4-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030040516.853444-1-portias@oss.tenstorrent.com>
References: <20261030040516.853444-1-portias@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=portias@tenstorrent.com; helo=mail-dy1-x1333.google.com
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The system memory is the memory view of the Ascalon CPU. Store the
memory directly in the TTAscalonClusterState and set it to
system_memory. There is no need to track it at the machine level,
get_system_memory() can be used when needed.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/tt_atlantis.c         | 43 ++++++++++++++--------------------
 include/hw/riscv/tt_atlantis.h |  3 +--
 2 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 8bcab69f8a..b514aaaa68 100644
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
@@ -655,7 +654,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
 
     ram_size = memory_region_size(s->dram);
 
-    s->irqchip = riscv_create_aia(ac->memory,
+    s->irqchip = riscv_create_aia(&ac->memory,
                                   true, TT_IMSIC_GUESTS,
                                   TT_IMSIC_STRIDE,
                                   TT_IMSIC_STRIDE,
@@ -668,7 +667,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
                                   TT_IRQCHIP_NUM_MSIS,
                                   TT_IRQCHIP_NUM_PRIO_BITS);
 
-    riscv_aclint_mtimer_create(ac->memory,
+    riscv_aclint_mtimer_create(&ac->memory,
             ac->memmap[TT_ATL_ACLINT].base,
             TT_ACLINT_MTIME_SIZE,
             0, hart_count,
@@ -690,13 +689,13 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
 
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
@@ -705,7 +704,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(
-        ac->memory, ac->memmap[TT_ATL_PRCM_RCPU].base,
+        &ac->memory, ac->memmap[TT_ATL_PRCM_RCPU].base,
         sysbus_mmio_get_region(
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_RCPU]), 0));
 
@@ -714,7 +713,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(
-        ac->memory, ac->memmap[TT_ATL_PRCM_HSIO].base,
+        &ac->memory, ac->memmap[TT_ATL_PRCM_HSIO].base,
         sysbus_mmio_get_region(
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_HSIO]), 0));
 
@@ -723,7 +722,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(
-        ac->memory, ac->memmap[TT_ATL_PRCM_PCIE].base,
+        &ac->memory, ac->memmap[TT_ATL_PRCM_PCIE].base,
         sysbus_mmio_get_region(
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_PCIE]), 0));
 
@@ -732,7 +731,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(
-        ac->memory, ac->memmap[TT_ATL_PRCM_MM].base,
+        &ac->memory, ac->memmap[TT_ATL_PRCM_MM].base,
         sysbus_mmio_get_region(
             SYS_BUS_DEVICE(&s->prcm[TT_ATLANTIS_PRCM_DOMAIN_MM]), 0));
 
@@ -746,7 +745,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        memory_region_add_subregion(ac->memory,
+        memory_region_add_subregion(&ac->memory,
                                     ac->memmap[TT_ATL_UART0 + i].base,
                                     sysbus_mmio_get_region(sbd, 0));
         sysbus_connect_irq(sbd, 0,
@@ -760,7 +759,7 @@ static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
         if (!sysbus_realize(sbd, errp)) {
             return;
         }
-        memory_region_add_subregion(ac->memory,
+        memory_region_add_subregion(&ac->memory,
                                     ac->memmap[TT_ATL_I2C0 + i].base,
                                     sysbus_mmio_get_region(sbd, 0));
         sysbus_connect_irq(sbd, 0,
@@ -789,10 +788,6 @@ static void tt_atlantis_machine_init(MachineState *machine)
     TTAtlantisSoCState *s = &ams->soc;
     TTAscalonClusterState *ac = &s->ascalon;
 
-    memory_region_init(&ams->soc_memory, OBJECT(machine),
-                       "tt-atlantis.soc-memory", UINT64_MAX);
-    memory_region_add_subregion(get_system_memory(), 0, &ams->soc_memory);
-
     object_initialize_child(OBJECT(machine), "soc", &ams->soc,
                             TYPE_TT_ATLANTIS_SOC);
 
@@ -804,9 +799,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
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


