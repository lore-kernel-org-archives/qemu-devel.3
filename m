Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7156BD11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ksP-0001lw-N1; Sun, 03 Nov 2024 19:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7ks5-0001As-Sk; Sun, 03 Nov 2024 19:23:06 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7ks3-0002qr-J5; Sun, 03 Nov 2024 19:23:05 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e70c32cd7so3328358b3a.1; 
 Sun, 03 Nov 2024 16:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679781; x=1731284581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UISav0m9vxkk9EM0HaAGMzL4bYfq2w6Ob7g9lExAmmc=;
 b=atVqEOOkZjN370mxzzoEfpRTZ3R81Yky33kX+TTfq57weARecvjn1IqkrUsBe2oiu+
 lc+OLNSGy5TAmKOhRvsGWd17ZUv4waxw7+u40OTqwX3vVAgRI2CvG9lQBFv5krPNTuHB
 bUd5VAeTpoCNj3h/hF68aGkgZS84T/73Z914ZHusvSoeH+bwY/DQo9H7miTKnLffe1a8
 n41kkyzRnI5g+iB6YXxm72wWI7FEMRcMuUMbI6271IxpQVTr3UWjHtwOpwPCYAT0tHi8
 auJ3l23tJ7qSSQNrSE2Dontu41S/yV+kmonnwNGiwi/skmvmoJgyvKWgsBWWXM+yXuzz
 b0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679781; x=1731284581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UISav0m9vxkk9EM0HaAGMzL4bYfq2w6Ob7g9lExAmmc=;
 b=Lv4Ec21395femmjFXohMCwrAHoHNvrWlbIa/qW5/OZvwa4d4kz2TPt3JSPj8yh3wY4
 1K4UlI4pcuB2PA4/y/xYjIGGCI7A03RbOMWTZ27o0AZ499A/ToDwX6BCogLmIFqvPMuW
 oaPSR4X4nwTBhcuV+PwBN03jjo87I0+EKgoA5ZWHaSS5Ncz/C6FEqjeSdqfA2/TcIkp4
 OonLSHvgUFyZpmP2En1wMYAcRbK//fogser62cpGEi8hA4Q5KNgPRjHtc4I0Tc+BMj4S
 kliQ4QUr3fD1AOV0zKukHjADMBcHHWgNykC6Pyj9X2oSKMdeYcNna61sJGRvcgxwEeie
 jLcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIcN/QRzY+Wvimua+L+REhoyKRjBNSiejVPUM8FKnSX873Ibft861qxSxnTfxKYusbtSkuOVYj6g==@nongnu.org
X-Gm-Message-State: AOJu0YxjxiseB+iQXwpaKE7KXuumVGchX7SJlFvvuINoDWTUybXCn0q1
 vLN5UHBKHqj5Ie+qoav0u+CI4yGI7CRsyKRPjTYva/ad78O/0C2EArm0lQ==
X-Google-Smtp-Source: AGHT+IG93dvtbRp2pE5dX1FFdwIGWzW9einZsbCE8IlV93W7sLlZOOvmO3P8YLSGG+RCep9sLpKyCw==
X-Received: by 2002:a05:6a21:3a82:b0:1d9:8275:cd70 with SMTP id
 adf61e73a8af0-1d9a84d0918mr39297932637.40.1730679781479; 
 Sun, 03 Nov 2024 16:23:01 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:23:01 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 64/67] hw/ppc: Consolidate ppc440 initial mapping creation
 functions
Date: Mon,  4 Nov 2024 10:18:53 +1000
Message-ID: <20241104001900.682660-65-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

Add a utility function and use it to replace very similar
create_initial_mapping functions in 440 based machines.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc440_bamboo.c | 28 +++-----------------------
 hw/ppc/ppc_booke.c     | 10 ++++++++++
 hw/ppc/sam460ex.c      | 45 ++++++++++--------------------------------
 hw/ppc/virtex_ml507.c  | 28 +++-----------------------
 include/hw/ppc/ppc.h   |  2 ++
 5 files changed, 28 insertions(+), 85 deletions(-)

diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 96d9ce65c2..a55f108434 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -110,29 +110,6 @@ static int bamboo_load_device_tree(MachineState *machine,
     return 0;
 }
 
-/* Create reset TLB entries for BookE, spanning the 32bit addr space.  */
-static void mmubooke_create_initial_mapping(CPUPPCState *env,
-                                     target_ulong va,
-                                     hwaddr pa)
-{
-    ppcemb_tlb_t *tlb = &env->tlb.tlbe[0];
-
-    tlb->attr = 0;
-    tlb->prot = PAGE_VALID | ((PAGE_READ | PAGE_WRITE | PAGE_EXEC) << 4);
-    tlb->size = 1U << 31; /* up to 0x80000000  */
-    tlb->EPN = va & TARGET_PAGE_MASK;
-    tlb->RPN = pa & TARGET_PAGE_MASK;
-    tlb->PID = 0;
-
-    tlb = &env->tlb.tlbe[1];
-    tlb->attr = 0;
-    tlb->prot = PAGE_VALID | ((PAGE_READ | PAGE_WRITE | PAGE_EXEC) << 4);
-    tlb->size = 1U << 31; /* up to 0xffffffff  */
-    tlb->EPN = 0x80000000 & TARGET_PAGE_MASK;
-    tlb->RPN = 0x80000000 & TARGET_PAGE_MASK;
-    tlb->PID = 0;
-}
-
 static void main_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
@@ -143,8 +120,9 @@ static void main_cpu_reset(void *opaque)
     env->gpr[3] = FDT_ADDR;
     env->nip = entry;
 
-    /* Create a mapping for the kernel.  */
-    mmubooke_create_initial_mapping(env, 0, 0);
+    /* Create a mapping spanning the 32bit addr space. */
+    booke_set_tlb(&env->tlb.tlbe[0], 0, 0, 1U << 31);
+    booke_set_tlb(&env->tlb.tlbe[1], 0x80000000, 0x80000000, 1U << 31);
 }
 
 static void bamboo_init(MachineState *machine)
diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index ca22da196a..c8849e66ff 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -31,6 +31,16 @@
 #include "hw/loader.h"
 #include "kvm_ppc.h"
 
+void booke_set_tlb(ppcemb_tlb_t *tlb, target_ulong va, hwaddr pa,
+                   target_ulong size)
+{
+    tlb->attr = 0;
+    tlb->prot = PAGE_RWX << 4 | PAGE_VALID;
+    tlb->size = size;
+    tlb->EPN = va & TARGET_PAGE_MASK;
+    tlb->RPN = pa & TARGET_PAGE_MASK;
+    tlb->PID = 0;
+}
 
 /* Timer Control Register */
 
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 1fce093ac8..78e2a46e75 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -213,38 +213,6 @@ static int sam460ex_load_device_tree(MachineState *machine,
     return fdt_size;
 }
 
-/* Create reset TLB entries for BookE, mapping only the flash memory.  */
-static void mmubooke_create_initial_mapping_uboot(CPUPPCState *env)
-{
-    ppcemb_tlb_t *tlb = &env->tlb.tlbe[0];
-
-    /* on reset the flash is mapped by a shadow TLB,
-     * but since we don't implement them we need to use
-     * the same values U-Boot will use to avoid a fault.
-     */
-    tlb->attr = 0;
-    tlb->prot = PAGE_VALID | ((PAGE_READ | PAGE_WRITE | PAGE_EXEC) << 4);
-    tlb->size = 0x10000000; /* up to 0xffffffff  */
-    tlb->EPN = 0xf0000000 & TARGET_PAGE_MASK;
-    tlb->RPN = (0xf0000000 & TARGET_PAGE_MASK) | 0x4;
-    tlb->PID = 0;
-}
-
-/* Create reset TLB entries for BookE, spanning the 32bit addr space.  */
-static void mmubooke_create_initial_mapping(CPUPPCState *env,
-                                     target_ulong va,
-                                     hwaddr pa)
-{
-    ppcemb_tlb_t *tlb = &env->tlb.tlbe[0];
-
-    tlb->attr = 0;
-    tlb->prot = PAGE_VALID | ((PAGE_READ | PAGE_WRITE | PAGE_EXEC) << 4);
-    tlb->size = 1 << 31; /* up to 0x80000000  */
-    tlb->EPN = va & TARGET_PAGE_MASK;
-    tlb->RPN = pa & TARGET_PAGE_MASK;
-    tlb->PID = 0;
-}
-
 static void main_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
@@ -253,20 +221,27 @@ static void main_cpu_reset(void *opaque)
 
     cpu_reset(CPU(cpu));
 
-    /* either we have a kernel to boot or we jump to U-Boot */
+    /*
+     * On reset the flash is mapped by a shadow TLB, but since we
+     * don't implement them we need to use the same values U-Boot
+     * will use to avoid a fault.
+     * either we have a kernel to boot or we jump to U-Boot
+     */
     if (bi->entry != UBOOT_ENTRY) {
         env->gpr[1] = (16 * MiB) - 8;
         env->gpr[3] = FDT_ADDR;
         env->nip = bi->entry;
 
         /* Create a mapping for the kernel.  */
-        mmubooke_create_initial_mapping(env, 0, 0);
+        booke_set_tlb(&env->tlb.tlbe[0], 0, 0, 1 << 31);
         env->gpr[6] = tswap32(EPAPR_MAGIC);
         env->gpr[7] = (16 * MiB) - 8; /* bi->ima_size; */
 
     } else {
         env->nip = UBOOT_ENTRY;
-        mmubooke_create_initial_mapping_uboot(env);
+        /* Create a mapping for U-Boot. */
+        booke_set_tlb(&env->tlb.tlbe[0], 0xf0000000, 0xf0000000, 0x10000000);
+        env->tlb.tlbe[0].RPN |= 4;
     }
 }
 
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 235281e939..f378e5c4a9 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -67,29 +67,6 @@ static struct boot_info
     void *vfdt;
 } boot_info;
 
-/* Create reset TLB entries for BookE, spanning the 32bit addr space.  */
-static void mmubooke_create_initial_mapping(CPUPPCState *env,
-                                     target_ulong va,
-                                     hwaddr pa)
-{
-    ppcemb_tlb_t *tlb = &env->tlb.tlbe[0];
-
-    tlb->attr = 0;
-    tlb->prot = PAGE_VALID | ((PAGE_READ | PAGE_WRITE | PAGE_EXEC) << 4);
-    tlb->size = 1U << 31; /* up to 0x80000000  */
-    tlb->EPN = va & TARGET_PAGE_MASK;
-    tlb->RPN = pa & TARGET_PAGE_MASK;
-    tlb->PID = 0;
-
-    tlb = &env->tlb.tlbe[1];
-    tlb->attr = 0;
-    tlb->prot = PAGE_VALID | ((PAGE_READ | PAGE_WRITE | PAGE_EXEC) << 4);
-    tlb->size = 1U << 31; /* up to 0xffffffff  */
-    tlb->EPN = 0x80000000 & TARGET_PAGE_MASK;
-    tlb->RPN = 0x80000000 & TARGET_PAGE_MASK;
-    tlb->PID = 0;
-}
-
 static PowerPCCPU *ppc440_init_xilinx(const char *cpu_type, uint32_t sysclk)
 {
     PowerPCCPU *cpu;
@@ -139,8 +116,9 @@ static void main_cpu_reset(void *opaque)
     env->gpr[3] = bi->fdt;
     env->nip = bi->bootstrap_pc;
 
-    /* Create a mapping for the kernel.  */
-    mmubooke_create_initial_mapping(env, 0, 0);
+    /* Create a mapping spanning the 32bit addr space. */
+    booke_set_tlb(&env->tlb.tlbe[0], 0, 0, 1U << 31);
+    booke_set_tlb(&env->tlb.tlbe[1], 0x80000000, 0x80000000, 1U << 31);
     env->gpr[6] = tswap32(EPAPR_MAGIC);
     env->gpr[7] = bi->ima_size;
 }
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 070524b02e..8a14d623f8 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -119,6 +119,8 @@ enum {
 #ifndef CONFIG_USER_ONLY
 void booke206_set_tlb(ppcmas_tlb_t *tlb, target_ulong va, hwaddr pa,
                       hwaddr len);
+void booke_set_tlb(ppcemb_tlb_t *tlb, target_ulong va, hwaddr pa,
+                   target_ulong size);
 #endif
 
 /* ppc_booke.c */
-- 
2.45.2


