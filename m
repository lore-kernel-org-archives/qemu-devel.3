Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048DBCCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lR1-0008Vk-PE; Thu, 09 Oct 2025 03:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lR0-0008VG-0e
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lQv-0004S7-O2
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ygv6RTzMSuQ3OP4FqjilFtENFefWJsZh6TTWfD7xr4=;
 b=TMXMx2fkd8yJOlB6c2KUh/jT4IJIaBk5Md/K6m0OPAeBz3WXo+Gh8gphRkkhJetavrGFNW
 tYIs0srZJue9Qth5vbSOfoqY8p+baTVCV3kwRqA5Ag0ePFCJQ0Ll6qAyCM8z5tr3AF4FT2
 GWlG7JE28d/Mt/SB6TXIs0VcYBHJY3Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-88hqiSnNPbeQUyDDa-NWJw-1; Thu, 09 Oct 2025 03:51:26 -0400
X-MC-Unique: 88hqiSnNPbeQUyDDa-NWJw-1
X-Mimecast-MFC-AGG-ID: 88hqiSnNPbeQUyDDa-NWJw_1759996285
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e38bd6680so4834995e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996284; x=1760601084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ygv6RTzMSuQ3OP4FqjilFtENFefWJsZh6TTWfD7xr4=;
 b=FKRbMu0d43j60JXEQViLl2xFPKhEq30JV88CWKsBrT9vblS+cqtemaFNdzKgqTdo/p
 i9jt+JqHtORz/yOWmS+GSn2euo2Ixa8SlOWfeyZzhmC0+0osKABWDEfDlFjzSLA7g/HT
 jxj52CwsYZfW5SvTNS5C3is2uxVYo46EjqtInZbILognkdx5z5+H/FeF0C5CWRL6BQ30
 V0T0qrkA1SVkIOnB2A5D67BC7nAuPtcQNurJRuB6OM2BphhqjQ2lQIBVbN3PEl01aoEK
 +mF7dH2gvfvJMqnc5Q5An87HQrdfFEFRdJW+tUypGhskMR0RWmzp1pk5VjTgMPf1HKro
 PpcA==
X-Gm-Message-State: AOJu0YwAR19qrWgJiSxvTCSTz2leQIw2tPkgqY1i/E74mBb0RbUtjwM7
 iPhHAGf8MaqBJL0KBsP6lPV9tGdsXWvAn3Zq0spTflcT/jbeunyFMunHeMA1QnW3u9/cBb4NUXM
 lCFC6I15XQNzzZuL2mdpLscxR4teR5rx8sQVjDIa2/3XqmT2ZFCUoYwxfh+Uv6y+OnC0Eo/ERiL
 W8YM7zkGd/d47hDvacmjpIffIxalcGMcprkQPXTlQAXNs=
X-Gm-Gg: ASbGncsqhfcBuIIFugEa12NlQA2nwxaUsPI8WRLZwdXsAwKC6Od8Wq6bHhWxy9NfRUb
 TJgZP0wixecUWtrKoij3qFBdgawGjqZKbKtPm4TfTky39gT2Z8X0jamT71v5uCHd4322GYL6yoh
 loDywT7ozcBdDqw/r5vgdJt395VXee5pbNMVh2wxZWOJGYJV32MTeQqJCwejDVBMJ/nxl+xMxL/
 rvz944TosfRqgc3FaOKp3f8gjynemCDLz7Jtma3R5vBjtvRYAhLDfljbnP2+iIVznGE+akNkUnC
 ehSklD6zyaQT3GGPSCVaBkUazNSFO81QB/MkT2QpcQAw/iMfO0lKrH0dZliLAY+x69o6gEgDcmn
 poWFQzRmvd0B/Z2fi66Smryn5oTtxBnwIFUCp23W8gk6DOwVY
X-Received: by 2002:a05:600c:3b08:b0:456:1b6f:c888 with SMTP id
 5b1f17b1804b1-46fa9af364bmr36956015e9.23.1759996284053; 
 Thu, 09 Oct 2025 00:51:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFByRBzrb00IRdWGsfwRCK6gIh+xhAjYmgtooCQ9lsVsG0U6TAXLMs5SyjaiPSYxXSGREsGBw==
X-Received: by 2002:a05:600c:3b08:b0:456:1b6f:c888 with SMTP id
 5b1f17b1804b1-46fa9af364bmr36955805e9.23.1759996283439; 
 Thu, 09 Oct 2025 00:51:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46faf105ad7sm33911095e9.4.2025.10.09.00.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:51:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 25/35] target/i386/mshv: Register MSRs with MSHV
Date: Thu,  9 Oct 2025 09:50:15 +0200
Message-ID: <20251009075026.505715-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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


