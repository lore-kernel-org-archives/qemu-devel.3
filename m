Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A211D1119A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ksn-0002Ql-Bw; Sun, 03 Nov 2024 19:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7ks2-0000oX-ET; Sun, 03 Nov 2024 19:23:02 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7ks0-0002qY-Kz; Sun, 03 Nov 2024 19:23:02 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-288fa5ce8f0so1733691fac.3; 
 Sun, 03 Nov 2024 16:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679778; x=1731284578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7sCsi0ShfKw+UnagbctVQNmT3UbBTzehfs7nr8RJ14=;
 b=TbUj2BE7MNr1XgD0sHUdNLxFWmCusFivzyaomPqXNqV/wDfM1CrqMVVFiGZ8VQgxl2
 ybncZwlyEq8VY/meU5uovJV36PqA8oIPfcD1VDY/OYIhdc3vNcYqUEfTBLrnFNdAZUDY
 cYnDOke5yW1zvW531vk7m71lOXQOx19T7FqzZq4g0hraCmDaKJ5EN3V83+YvTntswa6U
 4GE12SK2dh0AdhUv2u3qIpmPIBEOBpEFnKLmjna5UYfroFP1vteHCmIh8Hf6jpvjFjOT
 6oWjDZv6kLsWh2Auj8tMtUdcFuC3D90KLCI/C+bZk/4Euz6XSpqVd3r5l1EIM+oC1sif
 IY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679778; x=1731284578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y7sCsi0ShfKw+UnagbctVQNmT3UbBTzehfs7nr8RJ14=;
 b=qG1pPKNIHD9NMZkwL5IiRdYrHz5WC6ljarmyiVdQmq0GCn64T+T8VPkAdSRKCGU9x5
 uJUNe4SB15ab7mnLrEI1gaXv8RjapSTMqLLJSirJHeDcfIQApiKClv1x16B/83RrLpCF
 s7g2iPUdS9ierEmVaaTX5K7WeOmEiaii0YqF7kO8mrYjtGauVpn3KE0e6tdsbN7xwpRl
 J0TymDzlGi5QotV4f+ASSbSBZQ8KqDjDLavLcxMXlJEwmXZf+jANh97iqX3KOix2uRR7
 O1IE6jO3z4LxnxooNjS9mpq5hkfHRIi2VTBQYG5qavoiI7U8ByQtQ3Oa5fAZHsn1CYHH
 YBmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUATgOwo16XYdrBmZZDJTlKiOo76jS1pXQpAP4Ka8PaJJyIuMf43EjF9ZtoetDCp3RBcmNW+G2NPw==@nongnu.org
X-Gm-Message-State: AOJu0YwZz8bwDYK0alC2HZTVi2tjfTxAwR3E9HZB2vNB0nNY4OjDl3GH
 Exm9f8os/M+G3511Z528IDNHPw0YSlaVPKk3IQsQO//6sNZRmgwDNRCyEg==
X-Google-Smtp-Source: AGHT+IFDkv3CvTFKXEwsXXpKgffsEjftGgaAVWhYtcZd0yGNbomyeSsYtS/cSsiLNzF61zxGuYMStA==
X-Received: by 2002:a05:6870:1786:b0:27b:580f:3bdd with SMTP id
 586e51a60fabf-2949ed58057mr7220449fac.9.1730679778162; 
 Sun, 03 Nov 2024 16:22:58 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:22:57 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 63/67] hw/ppc: Consolidate e500 initial mapping creation
 functions
Date: Mon,  4 Nov 2024 10:18:52 +1000
Message-ID: <20241104001900.682660-64-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Add booke206_set_tlb() utility function and use it to replace very
similar create_initial_mapping functions in e500 machines.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/e500.c         | 41 +++++++++++++++++++----------------------
 hw/ppc/e500.h         |  2 --
 hw/ppc/ppce500_spin.c | 30 +++++++++---------------------
 include/hw/ppc/ppc.h  |  5 +++++
 4 files changed, 33 insertions(+), 45 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index b760c6d6a2..6433348072 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -721,11 +721,21 @@ static int ppce500_prep_device_tree(PPCE500MachineState *machine,
                                     kernel_base, kernel_size, true);
 }
 
-hwaddr booke206_page_size_to_tlb(uint64_t size)
+static hwaddr booke206_page_size_to_tlb(uint64_t size)
 {
     return 63 - clz64(size / KiB);
 }
 
+void booke206_set_tlb(ppcmas_tlb_t *tlb, target_ulong va, hwaddr pa,
+                      hwaddr len)
+{
+    tlb->mas1 = booke206_page_size_to_tlb(len) << MAS1_TSIZE_SHIFT;
+    tlb->mas1 |= MAS1_VALID;
+    tlb->mas2 = va & TARGET_PAGE_MASK;
+    tlb->mas7_3 = pa & TARGET_PAGE_MASK;
+    tlb->mas7_3 |= MAS3_UR | MAS3_UW | MAS3_UX | MAS3_SR | MAS3_SW | MAS3_SX;
+}
+
 static int booke206_initial_map_tsize(CPUPPCState *env)
 {
     struct boot_info *bi = env->load_info;
@@ -751,25 +761,6 @@ static uint64_t mmubooke_initial_mapsize(CPUPPCState *env)
     return (1ULL << 10 << tsize);
 }
 
-/* Create -kernel TLB entries for BookE. */
-static void mmubooke_create_initial_mapping(CPUPPCState *env)
-{
-    ppcmas_tlb_t *tlb = booke206_get_tlbm(env, 1, 0, 0);
-    hwaddr size;
-    int ps;
-
-    ps = booke206_initial_map_tsize(env);
-    size = (ps << MAS1_TSIZE_SHIFT);
-    tlb->mas1 = MAS1_VALID | size;
-    tlb->mas2 = 0;
-    tlb->mas7_3 = 0;
-    tlb->mas7_3 |= MAS3_UR | MAS3_UW | MAS3_UX | MAS3_SR | MAS3_SW | MAS3_SX;
-
-#ifdef CONFIG_KVM
-    env->tlb_dirty = true;
-#endif
-}
-
 static void ppce500_cpu_reset_sec(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
@@ -786,6 +777,8 @@ static void ppce500_cpu_reset(void *opaque)
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     struct boot_info *bi = env->load_info;
+    uint64_t map_size = mmubooke_initial_mapsize(env);
+    ppcmas_tlb_t *tlb = booke206_get_tlbm(env, 1, 0, 0);
 
     cpu_reset(cs);
 
@@ -796,11 +789,15 @@ static void ppce500_cpu_reset(void *opaque)
     env->gpr[4] = 0;
     env->gpr[5] = 0;
     env->gpr[6] = EPAPR_MAGIC;
-    env->gpr[7] = mmubooke_initial_mapsize(env);
+    env->gpr[7] = map_size;
     env->gpr[8] = 0;
     env->gpr[9] = 0;
     env->nip = bi->entry;
-    mmubooke_create_initial_mapping(env);
+    /* create initial mapping */
+    booke206_set_tlb(tlb, 0, 0, map_size);
+#ifdef CONFIG_KVM
+    env->tlb_dirty = true;
+#endif
 }
 
 static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
index 8c09ef92e4..01db102625 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -41,8 +41,6 @@ struct PPCE500MachineClass {
 
 void ppce500_init(MachineState *machine);
 
-hwaddr booke206_page_size_to_tlb(uint64_t size);
-
 #define TYPE_PPCE500_MACHINE      "ppce500-base-machine"
 OBJECT_DECLARE_TYPE(PPCE500MachineState, PPCE500MachineClass, PPCE500_MACHINE)
 
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index e08739a443..93b16320d4 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -33,6 +33,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "sysemu/hw_accel.h"
+#include "hw/ppc/ppc.h"
 #include "e500.h"
 #include "qom/object.h"
 
@@ -70,30 +71,12 @@ static void spin_reset(DeviceState *dev)
     }
 }
 
-static void mmubooke_create_initial_mapping(CPUPPCState *env,
-                                     target_ulong va,
-                                     hwaddr pa,
-                                     hwaddr len)
-{
-    ppcmas_tlb_t *tlb = booke206_get_tlbm(env, 1, 0, 1);
-    hwaddr size;
-
-    size = (booke206_page_size_to_tlb(len) << MAS1_TSIZE_SHIFT);
-    tlb->mas1 = MAS1_VALID | size;
-    tlb->mas2 = (va & TARGET_PAGE_MASK) | MAS2_M;
-    tlb->mas7_3 = pa & TARGET_PAGE_MASK;
-    tlb->mas7_3 |= MAS3_UR | MAS3_UW | MAS3_UX | MAS3_SR | MAS3_SW | MAS3_SX;
-#ifdef CONFIG_KVM
-    env->tlb_dirty = true;
-#endif
-}
-
 static void spin_kick(CPUState *cs, run_on_cpu_data data)
 {
     CPUPPCState *env = cpu_env(cs);
     SpinInfo *curspin = data.host_ptr;
-    hwaddr map_size = 64 * MiB;
-    hwaddr map_start;
+    hwaddr map_start, map_size = 64 * MiB;
+    ppcmas_tlb_t *tlb = booke206_get_tlbm(env, 1, 0, 1);
 
     cpu_synchronize_state(cs);
     stl_p(&curspin->pir, env->spr[SPR_BOOKE_PIR]);
@@ -107,7 +90,12 @@ static void spin_kick(CPUState *cs, run_on_cpu_data data)
     env->gpr[9] = 0;
 
     map_start = ldq_p(&curspin->addr) & ~(map_size - 1);
-    mmubooke_create_initial_mapping(env, 0, map_start, map_size);
+    /* create initial mapping */
+    booke206_set_tlb(tlb, 0, map_start, map_size);
+    tlb->mas2 |= MAS2_M;
+#ifdef CONFIG_KVM
+    env->tlb_dirty = true;
+#endif
 
     cs->halted = 0;
     cs->exception_index = -1;
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index d5d119ea7f..070524b02e 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -116,6 +116,11 @@ enum {
 
 #define PPC_SERIAL_MM_BAUDBASE 399193
 
+#ifndef CONFIG_USER_ONLY
+void booke206_set_tlb(ppcmas_tlb_t *tlb, target_ulong va, hwaddr pa,
+                      hwaddr len);
+#endif
+
 /* ppc_booke.c */
 void ppc_booke_timers_init(PowerPCCPU *cpu, uint32_t freq, uint32_t flags);
 #endif
-- 
2.45.2


