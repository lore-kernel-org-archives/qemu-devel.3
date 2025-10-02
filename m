Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD23CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mvk-00019j-Ae; Thu, 02 Oct 2025 13:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvN-0000x0-TS
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvB-0005qj-Lf
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ygv6RTzMSuQ3OP4FqjilFtENFefWJsZh6TTWfD7xr4=;
 b=Pztr9GF51fjKehrkq6N8OShHRLJ7LDUWsKPuJ2KDNE6IlavNfGs7M89oY/C0+DPwBZ+4JA
 6xT3rR0X0UGO5V7BU3DGxSO7HkKEMPfb/w9aShuKFLrCL1n3745OdC7LG+jRIP9BdV9efq
 jNadu2Xqw+/1jf4ivn/GBBV4qhZyf2w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-Z25M1zCPONWcw5q5kX31LQ-1; Thu, 02 Oct 2025 13:16:39 -0400
X-MC-Unique: Z25M1zCPONWcw5q5kX31LQ-1
X-Mimecast-MFC-AGG-ID: Z25M1zCPONWcw5q5kX31LQ_1759425397
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b3d6645acd3so126635166b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425396; x=1760030196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ygv6RTzMSuQ3OP4FqjilFtENFefWJsZh6TTWfD7xr4=;
 b=JOncYmRETic3T6sy9JNKk5jxsEGOPcdnDKzxXYbJf1eNkG/4xd8DBD8AyMRp/pEYom
 YwK4oe6eYQJIP5zSSiNowPq+JoS3x5D6EIT3vqxQmg1HHCs8aFqz2bvFY0qrUGrdd0WZ
 JHcWjCaypBH14SRXPPw3Li/n9pSkBuUot2uxqsx5Y8NHULf2bipvRsKD5snemu5r0439
 pdOZ/Lp4M56muefE0b6/hh0jVJhNWSEhrhNpy14FRwZ8ai6JYMr8o99DuMKzjM6wyu6X
 AyqftpDSDU6/50bwmnvkqHgaJA4ah58QTuAzWBCGaA+vly7ql0dvQZjiue9JK5ZVPLXZ
 t1sQ==
X-Gm-Message-State: AOJu0YxlzaYGDRhiULcELDZ0AhFlLmji04tPV57CxpW+T0iiLMW7Zfqw
 ntDWomazuibX7owHefK8iWYfUMnAf7qZKt8G9dmeYIkd1XNaB1/4bjqVJ/mvbs2tXqBsua1dKDI
 b7uQJ/DUoNfNFMCOE+phLgDOaaIxfoykgl2tBKO9wSYe1FVcZHWSsb1HuKgt+eKpWgCwhvEkS0Q
 1aAEg/ISFUObcy0i/uBl/nD4RlEdv2Wl/eAkRidAKH
X-Gm-Gg: ASbGncuMpokag4dgcasddxZW9uPQhsTdQ2diCAlMMLO0NuHcMbP+IYdzrkt/O7GhwL1
 UgTkSQxwqgQekgGC4GnU4Tlyg7Un3c3pwp5p9oxE4qK1G8FvXdbYtx8p6yricatCOc4wD+ceoFE
 VlhrVX7A7FkvxoFUsDS3h8Ph8IOxsa+Lq0xs9A/DLLW6WCYgHs4HJQlWHI6gS00V5UibedWpINY
 yV06dtq5luojvvIkGZ6RkntRuSFW8Ex+sWlzlwx1+DckKWeEJeoVc9+Umo2scU30018XnOWCPZs
 GbP28GsysUG7bJlvU0jUIlLB0TJZLvKsxe2YMYxq53GSAKC3zl3i3Pxs3BBQcZDoHhi079Qqmtq
 v7ozUlu3Ing76yz6LvYzps+ypMMJkPsq3gXxi4kF+HbHYNsvC
X-Received: by 2002:a17:907:3d05:b0:b3f:5513:5cd0 with SMTP id
 a640c23a62f3a-b49c19769fbmr28530966b.19.1759425395846; 
 Thu, 02 Oct 2025 10:16:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiZXx+yjWPalYwQDrqDnpfjWkoO/W1zYV7ngjWmA9uFMI9p1l93Q31tcB9mOwZEsVlwXrLSA==
X-Received: by 2002:a17:907:3d05:b0:b3f:5513:5cd0 with SMTP id
 a640c23a62f3a-b49c19769fbmr28525866b.19.1759425395248; 
 Thu, 02 Oct 2025 10:16:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b486970b2desm241541566b.48.2025.10.02.10.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:16:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 19/27] target/i386/mshv: Register MSRs with MSHV
Date: Thu,  2 Oct 2025 19:15:28 +0200
Message-ID: <20251002171536.1460049-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Build and register the guest vCPU's model-specific registers using
the MSHV interface.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-20-magnuskulke@linux.microsoft.com
[mshv.h/mshv_int.h split. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h   |  17 ++
 target/i386/cpu.h           |   2 +
 accel/mshv/msr.c            | 375 ++++++++++++++++++++++++++++++++++++
 target/i386/mshv/mshv-cpu.c |  33 ++++
 accel/mshv/meson.build      |   1 +
 5 files changed, 428 insertions(+)
 create mode 100644 accel/mshv/msr.c

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 0ea8d504fa5..66494383134 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -14,6 +14,8 @@
 #ifndef QEMU_MSHV_INT_H
 #define QEMU_MSHV_INT_H
 
+#define MSHV_MSR_ENTRIES_COUNT 64
+
 typedef struct hyperv_message hv_message;
 
 struct AccelCPUState {
@@ -102,6 +104,21 @@ typedef struct MshvMemoryRegion {
 void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
                        bool add);
 
+/* msr */
+typedef struct MshvMsrEntry {
+  uint32_t index;
+  uint32_t reserved;
+  uint64_t data;
+} MshvMsrEntry;
+
+typedef struct MshvMsrEntries {
+    MshvMsrEntry entries[MSHV_MSR_ENTRIES_COUNT];
+    uint32_t nmsrs;
+} MshvMsrEntries;
+
+int mshv_configure_msr(const CPUState *cpu, const MshvMsrEntry *msrs,
+                       size_t n_msrs);
+
 /* interrupt */
 void mshv_init_msicontrol(void);
 int mshv_reserve_ioapic_msi_routes(int vm_fd);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3aec8fd41c8..8b7c173838e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -435,9 +435,11 @@ typedef enum X86Seg {
 #define MSR_SMI_COUNT                   0x34
 #define MSR_CORE_THREAD_COUNT           0x35
 #define MSR_MTRRcap                     0xfe
+#define MSR_MTRR_MEM_TYPE_WB            0x06
 #define MSR_MTRRcap_VCNT                8
 #define MSR_MTRRcap_FIXRANGE_SUPPORT    (1 << 8)
 #define MSR_MTRRcap_WC_SUPPORTED        (1 << 10)
+#define MSR_MTRR_ENABLE                 (1 << 11)
 
 #define MSR_IA32_SYSENTER_CS            0x174
 #define MSR_IA32_SYSENTER_ESP           0x175
diff --git a/accel/mshv/msr.c b/accel/mshv/msr.c
new file mode 100644
index 00000000000..e6e5baef507
--- /dev/null
+++ b/accel/mshv/msr.c
@@ -0,0 +1,375 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors: Magnus Kulke  <magnuskulke@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/mshv.h"
+#include "system/mshv_int.h"
+#include "hw/hyperv/hvgdk_mini.h"
+#include "linux/mshv.h"
+#include "qemu/error-report.h"
+
+static uint32_t supported_msrs[64] = {
+    IA32_MSR_TSC,
+    IA32_MSR_EFER,
+    IA32_MSR_KERNEL_GS_BASE,
+    IA32_MSR_APIC_BASE,
+    IA32_MSR_PAT,
+    IA32_MSR_SYSENTER_CS,
+    IA32_MSR_SYSENTER_ESP,
+    IA32_MSR_SYSENTER_EIP,
+    IA32_MSR_STAR,
+    IA32_MSR_LSTAR,
+    IA32_MSR_CSTAR,
+    IA32_MSR_SFMASK,
+    IA32_MSR_MTRR_DEF_TYPE,
+    IA32_MSR_MTRR_PHYSBASE0,
+    IA32_MSR_MTRR_PHYSMASK0,
+    IA32_MSR_MTRR_PHYSBASE1,
+    IA32_MSR_MTRR_PHYSMASK1,
+    IA32_MSR_MTRR_PHYSBASE2,
+    IA32_MSR_MTRR_PHYSMASK2,
+    IA32_MSR_MTRR_PHYSBASE3,
+    IA32_MSR_MTRR_PHYSMASK3,
+    IA32_MSR_MTRR_PHYSBASE4,
+    IA32_MSR_MTRR_PHYSMASK4,
+    IA32_MSR_MTRR_PHYSBASE5,
+    IA32_MSR_MTRR_PHYSMASK5,
+    IA32_MSR_MTRR_PHYSBASE6,
+    IA32_MSR_MTRR_PHYSMASK6,
+    IA32_MSR_MTRR_PHYSBASE7,
+    IA32_MSR_MTRR_PHYSMASK7,
+    IA32_MSR_MTRR_FIX64K_00000,
+    IA32_MSR_MTRR_FIX16K_80000,
+    IA32_MSR_MTRR_FIX16K_A0000,
+    IA32_MSR_MTRR_FIX4K_C0000,
+    IA32_MSR_MTRR_FIX4K_C8000,
+    IA32_MSR_MTRR_FIX4K_D0000,
+    IA32_MSR_MTRR_FIX4K_D8000,
+    IA32_MSR_MTRR_FIX4K_E0000,
+    IA32_MSR_MTRR_FIX4K_E8000,
+    IA32_MSR_MTRR_FIX4K_F0000,
+    IA32_MSR_MTRR_FIX4K_F8000,
+    IA32_MSR_TSC_AUX,
+    IA32_MSR_DEBUG_CTL,
+    HV_X64_MSR_GUEST_OS_ID,
+    HV_X64_MSR_SINT0,
+    HV_X64_MSR_SINT1,
+    HV_X64_MSR_SINT2,
+    HV_X64_MSR_SINT3,
+    HV_X64_MSR_SINT4,
+    HV_X64_MSR_SINT5,
+    HV_X64_MSR_SINT6,
+    HV_X64_MSR_SINT7,
+    HV_X64_MSR_SINT8,
+    HV_X64_MSR_SINT9,
+    HV_X64_MSR_SINT10,
+    HV_X64_MSR_SINT11,
+    HV_X64_MSR_SINT12,
+    HV_X64_MSR_SINT13,
+    HV_X64_MSR_SINT14,
+    HV_X64_MSR_SINT15,
+    HV_X64_MSR_SCONTROL,
+    HV_X64_MSR_SIEFP,
+    HV_X64_MSR_SIMP,
+    HV_X64_MSR_REFERENCE_TSC,
+    HV_X64_MSR_EOM,
+};
+static const size_t msr_count = ARRAY_SIZE(supported_msrs);
+
+static int compare_msr_index(const void *a, const void *b)
+{
+    return *(uint32_t *)a - *(uint32_t *)b;
+}
+
+__attribute__((constructor))
+static void init_sorted_msr_map(void)
+{
+    qsort(supported_msrs, msr_count, sizeof(uint32_t), compare_msr_index);
+}
+
+static int mshv_is_supported_msr(uint32_t msr)
+{
+    return bsearch(&msr, supported_msrs, msr_count, sizeof(uint32_t),
+                   compare_msr_index) != NULL;
+}
+
+static int mshv_msr_to_hv_reg_name(uint32_t msr, uint32_t *hv_reg)
+{
+    switch (msr) {
+    case IA32_MSR_TSC:
+        *hv_reg = HV_X64_REGISTER_TSC;
+        return 0;
+    case IA32_MSR_EFER:
+        *hv_reg = HV_X64_REGISTER_EFER;
+        return 0;
+    case IA32_MSR_KERNEL_GS_BASE:
+        *hv_reg = HV_X64_REGISTER_KERNEL_GS_BASE;
+        return 0;
+    case IA32_MSR_APIC_BASE:
+        *hv_reg = HV_X64_REGISTER_APIC_BASE;
+        return 0;
+    case IA32_MSR_PAT:
+        *hv_reg = HV_X64_REGISTER_PAT;
+        return 0;
+    case IA32_MSR_SYSENTER_CS:
+        *hv_reg = HV_X64_REGISTER_SYSENTER_CS;
+        return 0;
+    case IA32_MSR_SYSENTER_ESP:
+        *hv_reg = HV_X64_REGISTER_SYSENTER_ESP;
+        return 0;
+    case IA32_MSR_SYSENTER_EIP:
+        *hv_reg = HV_X64_REGISTER_SYSENTER_EIP;
+        return 0;
+    case IA32_MSR_STAR:
+        *hv_reg = HV_X64_REGISTER_STAR;
+        return 0;
+    case IA32_MSR_LSTAR:
+        *hv_reg = HV_X64_REGISTER_LSTAR;
+        return 0;
+    case IA32_MSR_CSTAR:
+        *hv_reg = HV_X64_REGISTER_CSTAR;
+        return 0;
+    case IA32_MSR_SFMASK:
+        *hv_reg = HV_X64_REGISTER_SFMASK;
+        return 0;
+    case IA32_MSR_MTRR_CAP:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_CAP;
+        return 0;
+    case IA32_MSR_MTRR_DEF_TYPE:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_DEF_TYPE;
+        return 0;
+    case IA32_MSR_MTRR_PHYSBASE0:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0;
+        return 0;
+    case IA32_MSR_MTRR_PHYSMASK0:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0;
+        return 0;
+    case IA32_MSR_MTRR_PHYSBASE1:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1;
+        return 0;
+    case IA32_MSR_MTRR_PHYSMASK1:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1;
+        return 0;
+    case IA32_MSR_MTRR_PHYSBASE2:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2;
+        return 0;
+    case IA32_MSR_MTRR_PHYSMASK2:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2;
+        return 0;
+    case IA32_MSR_MTRR_PHYSBASE3:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3;
+        return 0;
+    case IA32_MSR_MTRR_PHYSMASK3:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3;
+        return 0;
+    case IA32_MSR_MTRR_PHYSBASE4:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4;
+        return 0;
+    case IA32_MSR_MTRR_PHYSMASK4:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4;
+        return 0;
+    case IA32_MSR_MTRR_PHYSBASE5:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5;
+        return 0;
+    case IA32_MSR_MTRR_PHYSMASK5:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5;
+        return 0;
+    case IA32_MSR_MTRR_PHYSBASE6:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6;
+        return 0;
+    case IA32_MSR_MTRR_PHYSMASK6:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6;
+        return 0;
+    case IA32_MSR_MTRR_PHYSBASE7:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7;
+        return 0;
+    case IA32_MSR_MTRR_PHYSMASK7:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7;
+        return 0;
+    case IA32_MSR_MTRR_FIX64K_00000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX64K00000;
+        return 0;
+    case IA32_MSR_MTRR_FIX16K_80000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX16K80000;
+        return 0;
+    case IA32_MSR_MTRR_FIX16K_A0000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX16KA0000;
+        return 0;
+    case IA32_MSR_MTRR_FIX4K_C0000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KC0000;
+        return 0;
+    case IA32_MSR_MTRR_FIX4K_C8000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KC8000;
+        return 0;
+    case IA32_MSR_MTRR_FIX4K_D0000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KD0000;
+        return 0;
+    case IA32_MSR_MTRR_FIX4K_D8000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KD8000;
+        return 0;
+    case IA32_MSR_MTRR_FIX4K_E0000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KE0000;
+        return 0;
+    case IA32_MSR_MTRR_FIX4K_E8000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KE8000;
+        return 0;
+    case IA32_MSR_MTRR_FIX4K_F0000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KF0000;
+        return 0;
+    case IA32_MSR_MTRR_FIX4K_F8000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KF8000;
+        return 0;
+    case IA32_MSR_TSC_AUX:
+        *hv_reg = HV_X64_REGISTER_TSC_AUX;
+        return 0;
+    case IA32_MSR_BNDCFGS:
+        *hv_reg = HV_X64_REGISTER_BNDCFGS;
+        return 0;
+    case IA32_MSR_DEBUG_CTL:
+        *hv_reg = HV_X64_REGISTER_DEBUG_CTL;
+        return 0;
+    case IA32_MSR_TSC_ADJUST:
+        *hv_reg = HV_X64_REGISTER_TSC_ADJUST;
+        return 0;
+    case IA32_MSR_SPEC_CTRL:
+        *hv_reg = HV_X64_REGISTER_SPEC_CTRL;
+        return 0;
+    case HV_X64_MSR_GUEST_OS_ID:
+        *hv_reg = HV_REGISTER_GUEST_OS_ID;
+        return 0;
+    case HV_X64_MSR_SINT0:
+        *hv_reg = HV_REGISTER_SINT0;
+        return 0;
+    case HV_X64_MSR_SINT1:
+        *hv_reg = HV_REGISTER_SINT1;
+        return 0;
+    case HV_X64_MSR_SINT2:
+        *hv_reg = HV_REGISTER_SINT2;
+        return 0;
+    case HV_X64_MSR_SINT3:
+        *hv_reg = HV_REGISTER_SINT3;
+        return 0;
+    case HV_X64_MSR_SINT4:
+        *hv_reg = HV_REGISTER_SINT4;
+        return 0;
+    case HV_X64_MSR_SINT5:
+        *hv_reg = HV_REGISTER_SINT5;
+        return 0;
+    case HV_X64_MSR_SINT6:
+        *hv_reg = HV_REGISTER_SINT6;
+        return 0;
+    case HV_X64_MSR_SINT7:
+        *hv_reg = HV_REGISTER_SINT7;
+        return 0;
+    case HV_X64_MSR_SINT8:
+        *hv_reg = HV_REGISTER_SINT8;
+        return 0;
+    case HV_X64_MSR_SINT9:
+        *hv_reg = HV_REGISTER_SINT9;
+        return 0;
+    case HV_X64_MSR_SINT10:
+        *hv_reg = HV_REGISTER_SINT10;
+        return 0;
+    case HV_X64_MSR_SINT11:
+        *hv_reg = HV_REGISTER_SINT11;
+        return 0;
+    case HV_X64_MSR_SINT12:
+        *hv_reg = HV_REGISTER_SINT12;
+        return 0;
+    case HV_X64_MSR_SINT13:
+        *hv_reg = HV_REGISTER_SINT13;
+        return 0;
+    case HV_X64_MSR_SINT14:
+        *hv_reg = HV_REGISTER_SINT14;
+        return 0;
+    case HV_X64_MSR_SINT15:
+        *hv_reg = HV_REGISTER_SINT15;
+        return 0;
+    case IA32_MSR_MISC_ENABLE:
+        *hv_reg = HV_X64_REGISTER_MSR_IA32_MISC_ENABLE;
+        return 0;
+    case HV_X64_MSR_SCONTROL:
+        *hv_reg = HV_REGISTER_SCONTROL;
+        return 0;
+    case HV_X64_MSR_SIEFP:
+        *hv_reg = HV_REGISTER_SIEFP;
+        return 0;
+    case HV_X64_MSR_SIMP:
+        *hv_reg = HV_REGISTER_SIMP;
+        return 0;
+    case HV_X64_MSR_REFERENCE_TSC:
+        *hv_reg = HV_REGISTER_REFERENCE_TSC;
+        return 0;
+    case HV_X64_MSR_EOM:
+        *hv_reg = HV_REGISTER_EOM;
+        return 0;
+    default:
+        error_report("failed to map MSR %u to HV register name", msr);
+        return -1;
+    }
+}
+
+static int set_msrs(const CPUState *cpu, GList *msrs)
+{
+    size_t n_msrs;
+    GList *entries;
+    MshvMsrEntry *entry;
+    enum hv_register_name name;
+    struct hv_register_assoc *assoc;
+    int ret;
+    size_t i = 0;
+
+    n_msrs = g_list_length(msrs);
+    hv_register_assoc *assocs = g_new0(hv_register_assoc, n_msrs);
+
+    entries = msrs;
+    for (const GList *elem = entries; elem != NULL; elem = elem->next) {
+        entry = elem->data;
+        ret = mshv_msr_to_hv_reg_name(entry->index, &name);
+        if (ret < 0) {
+            g_free(assocs);
+            return ret;
+        }
+        assoc = &assocs[i];
+        assoc->name = name;
+        /* the union has been initialized to 0 */
+        assoc->value.reg64 = entry->data;
+        i++;
+    }
+    ret = mshv_set_generic_regs(cpu, assocs, n_msrs);
+    g_free(assocs);
+    if (ret < 0) {
+        error_report("failed to set msrs");
+        return -1;
+    }
+    return 0;
+}
+
+
+int mshv_configure_msr(const CPUState *cpu, const MshvMsrEntry *msrs,
+                       size_t n_msrs)
+{
+    GList *valid_msrs = NULL;
+    uint32_t msr_index;
+    int ret;
+
+    for (size_t i = 0; i < n_msrs; i++) {
+        msr_index = msrs[i].index;
+        /* check whether index of msrs is in SUPPORTED_MSRS */
+        if (mshv_is_supported_msr(msr_index)) {
+            valid_msrs = g_list_append(valid_msrs, (void *) &msrs[i]);
+        }
+    }
+
+    ret = set_msrs(cpu, valid_msrs);
+    g_list_free(valid_msrs);
+
+    return ret;
+}
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 2b7a81274b3..1f43dfc58ac 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -872,6 +872,33 @@ static int set_lint(int cpu_fd)
     return set_lapic(cpu_fd, &lapic_state);
 }
 
+static int setup_msrs(const CPUState *cpu)
+{
+    int ret;
+    uint64_t default_type = MSR_MTRR_ENABLE | MSR_MTRR_MEM_TYPE_WB;
+
+    /* boot msr entries */
+    MshvMsrEntry msrs[9] = {
+        { .index = IA32_MSR_SYSENTER_CS, .data = 0x0, },
+        { .index = IA32_MSR_SYSENTER_ESP, .data = 0x0, },
+        { .index = IA32_MSR_SYSENTER_EIP, .data = 0x0, },
+        { .index = IA32_MSR_STAR, .data = 0x0, },
+        { .index = IA32_MSR_CSTAR, .data = 0x0, },
+        { .index = IA32_MSR_LSTAR, .data = 0x0, },
+        { .index = IA32_MSR_KERNEL_GS_BASE, .data = 0x0, },
+        { .index = IA32_MSR_SFMASK, .data = 0x0, },
+        { .index = IA32_MSR_MTRR_DEF_TYPE, .data = default_type, },
+    };
+
+    ret = mshv_configure_msr(cpu, msrs, 9);
+    if (ret < 0) {
+        error_report("failed to setup msrs");
+        return -1;
+    }
+
+    return 0;
+}
+
 /*
  * TODO: populate topology info:
  *
@@ -891,6 +918,12 @@ int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
         return -1;
     }
 
+    ret = setup_msrs(cpu);
+    if (ret < 0) {
+        error_report("failed to setup msrs");
+        return -1;
+    }
+
     ret = set_cpu_state(cpu, fpu, xcr0);
     if (ret < 0) {
         error_report("failed to set cpu state");
diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
index f88fc8678c3..d3a2b325811 100644
--- a/accel/mshv/meson.build
+++ b/accel/mshv/meson.build
@@ -2,6 +2,7 @@ mshv_ss = ss.source_set()
 mshv_ss.add(if_true: files(
   'irq.c',
   'mem.c',
+  'msr.c',
   'mshv-all.c'
 ))
 
-- 
2.51.0


