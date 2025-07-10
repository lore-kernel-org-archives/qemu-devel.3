Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436E3C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 12:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZpxl-000228-0D; Thu, 10 Jul 2025 08:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZpxV-000099-B2
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:01:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZpxN-0005OY-CF
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752148846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wAgPvpLltwgD8D7dH7w634nKvGM2/vGXPJGLp3EpQP8=;
 b=OkQdB7B+uLi40aZOvPZltFkkF3g1b+O7I2u1XE1Wj1t10SFK2HWF2XHM9JDqTGWZoJ+3tq
 TfDze48oujpP5tVLS7VV/FBFBX9Dt0Hnpuw7pk6GIL/Lv5pNnnwLjWEMCjrAr0Cbj0G3Dk
 +gKi+VgC3q77YgqkJRrYROg+Qs71X28=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-vachEGl4OnqC18VSQR9Rhg-1; Thu,
 10 Jul 2025 08:00:42 -0400
X-MC-Unique: vachEGl4OnqC18VSQR9Rhg-1
X-Mimecast-MFC-AGG-ID: vachEGl4OnqC18VSQR9Rhg_1752148841
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7C3B1800289; Thu, 10 Jul 2025 12:00:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.72])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6081A19560A3; Thu, 10 Jul 2025 12:00:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] linux-headers: Remove the 32-bit arm headers
Date: Thu, 10 Jul 2025 14:00:35 +0200
Message-ID: <20250710120035.169376-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

KVM support for 32-bit arm has been dropped a while ago, so we don't
need these headers in QEMU anymore.

Fixes: 82bf7ae84ce ("target/arm: Remove KVM support for 32-bit Arm hosts")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure                             |   1 -
 linux-headers/asm-arm/bitsperlong.h   |   1 -
 linux-headers/asm-arm/kvm.h           | 312 --------------------
 linux-headers/asm-arm/mman.h          |   4 -
 linux-headers/asm-arm/unistd-common.h | 397 --------------------------
 linux-headers/asm-arm/unistd-eabi.h   |   5 -
 linux-headers/asm-arm/unistd-oabi.h   |  17 --
 linux-headers/asm-arm/unistd.h        |  41 ---
 scripts/update-linux-headers.sh       |   5 -
 9 files changed, 783 deletions(-)
 delete mode 100644 linux-headers/asm-arm/bitsperlong.h
 delete mode 100644 linux-headers/asm-arm/kvm.h
 delete mode 100644 linux-headers/asm-arm/mman.h
 delete mode 100644 linux-headers/asm-arm/unistd-common.h
 delete mode 100644 linux-headers/asm-arm/unistd-eabi.h
 delete mode 100644 linux-headers/asm-arm/unistd-oabi.h
 delete mode 100644 linux-headers/asm-arm/unistd.h

diff --git a/configure b/configure
index 2b2b3d65979..95f67c1a827 100755
--- a/configure
+++ b/configure
@@ -453,7 +453,6 @@ case "$cpu" in
   armv*b|armv*l|arm)
     cpu=arm
     host_arch=arm
-    linux_arch=arm
     ;;
 
   i386|i486|i586|i686)
diff --git a/linux-headers/asm-arm/bitsperlong.h b/linux-headers/asm-arm/bitsperlong.h
deleted file mode 100644
index 6dc0bb0c13b..00000000000
--- a/linux-headers/asm-arm/bitsperlong.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/bitsperlong.h>
diff --git a/linux-headers/asm-arm/kvm.h b/linux-headers/asm-arm/kvm.h
deleted file mode 100644
index 0db5644e27a..00000000000
--- a/linux-headers/asm-arm/kvm.h
+++ /dev/null
@@ -1,312 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (C) 2012 - Virtual Open Systems and Columbia University
- * Author: Christoffer Dall <c.dall@virtualopensystems.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, version 2, as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
- */
-
-#ifndef __ARM_KVM_H__
-#define __ARM_KVM_H__
-
-#include <linux/types.h>
-#include <linux/psci.h>
-#include <asm/ptrace.h>
-
-#define __KVM_HAVE_GUEST_DEBUG
-#define __KVM_HAVE_IRQ_LINE
-#define __KVM_HAVE_READONLY_MEM
-#define __KVM_HAVE_VCPU_EVENTS
-
-#define KVM_COALESCED_MMIO_PAGE_OFFSET 1
-
-#define KVM_REG_SIZE(id)						\
-	(1U << (((id) & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT))
-
-/* Valid for svc_regs, abt_regs, und_regs, irq_regs in struct kvm_regs */
-#define KVM_ARM_SVC_sp		svc_regs[0]
-#define KVM_ARM_SVC_lr		svc_regs[1]
-#define KVM_ARM_SVC_spsr	svc_regs[2]
-#define KVM_ARM_ABT_sp		abt_regs[0]
-#define KVM_ARM_ABT_lr		abt_regs[1]
-#define KVM_ARM_ABT_spsr	abt_regs[2]
-#define KVM_ARM_UND_sp		und_regs[0]
-#define KVM_ARM_UND_lr		und_regs[1]
-#define KVM_ARM_UND_spsr	und_regs[2]
-#define KVM_ARM_IRQ_sp		irq_regs[0]
-#define KVM_ARM_IRQ_lr		irq_regs[1]
-#define KVM_ARM_IRQ_spsr	irq_regs[2]
-
-/* Valid only for fiq_regs in struct kvm_regs */
-#define KVM_ARM_FIQ_r8		fiq_regs[0]
-#define KVM_ARM_FIQ_r9		fiq_regs[1]
-#define KVM_ARM_FIQ_r10		fiq_regs[2]
-#define KVM_ARM_FIQ_fp		fiq_regs[3]
-#define KVM_ARM_FIQ_ip		fiq_regs[4]
-#define KVM_ARM_FIQ_sp		fiq_regs[5]
-#define KVM_ARM_FIQ_lr		fiq_regs[6]
-#define KVM_ARM_FIQ_spsr	fiq_regs[7]
-
-struct kvm_regs {
-	struct pt_regs usr_regs;	/* R0_usr - R14_usr, PC, CPSR */
-	unsigned long svc_regs[3];	/* SP_svc, LR_svc, SPSR_svc */
-	unsigned long abt_regs[3];	/* SP_abt, LR_abt, SPSR_abt */
-	unsigned long und_regs[3];	/* SP_und, LR_und, SPSR_und */
-	unsigned long irq_regs[3];	/* SP_irq, LR_irq, SPSR_irq */
-	unsigned long fiq_regs[8];	/* R8_fiq - R14_fiq, SPSR_fiq */
-};
-
-/* Supported Processor Types */
-#define KVM_ARM_TARGET_CORTEX_A15	0
-#define KVM_ARM_TARGET_CORTEX_A7	1
-#define KVM_ARM_NUM_TARGETS		2
-
-/* KVM_ARM_SET_DEVICE_ADDR ioctl id encoding */
-#define KVM_ARM_DEVICE_TYPE_SHIFT	0
-#define KVM_ARM_DEVICE_TYPE_MASK	(0xffff << KVM_ARM_DEVICE_TYPE_SHIFT)
-#define KVM_ARM_DEVICE_ID_SHIFT		16
-#define KVM_ARM_DEVICE_ID_MASK		(0xffff << KVM_ARM_DEVICE_ID_SHIFT)
-
-/* Supported device IDs */
-#define KVM_ARM_DEVICE_VGIC_V2		0
-
-/* Supported VGIC address types  */
-#define KVM_VGIC_V2_ADDR_TYPE_DIST	0
-#define KVM_VGIC_V2_ADDR_TYPE_CPU	1
-
-#define KVM_VGIC_V2_DIST_SIZE		0x1000
-#define KVM_VGIC_V2_CPU_SIZE		0x2000
-
-/* Supported VGICv3 address types  */
-#define KVM_VGIC_V3_ADDR_TYPE_DIST	2
-#define KVM_VGIC_V3_ADDR_TYPE_REDIST	3
-#define KVM_VGIC_ITS_ADDR_TYPE		4
-#define KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION	5
-
-#define KVM_VGIC_V3_DIST_SIZE		SZ_64K
-#define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
-#define KVM_VGIC_V3_ITS_SIZE		(2 * SZ_64K)
-
-#define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
-#define KVM_ARM_VCPU_PSCI_0_2		1 /* CPU uses PSCI v0.2 */
-
-struct kvm_vcpu_init {
-	__u32 target;
-	__u32 features[7];
-};
-
-struct kvm_sregs {
-};
-
-struct kvm_fpu {
-};
-
-struct kvm_guest_debug_arch {
-};
-
-struct kvm_debug_exit_arch {
-};
-
-struct kvm_sync_regs {
-	/* Used with KVM_CAP_ARM_USER_IRQ */
-	__u64 device_irq_level;
-};
-
-struct kvm_arch_memory_slot {
-};
-
-/* for KVM_GET/SET_VCPU_EVENTS */
-struct kvm_vcpu_events {
-	struct {
-		__u8 serror_pending;
-		__u8 serror_has_esr;
-		__u8 ext_dabt_pending;
-		/* Align it to 8 bytes */
-		__u8 pad[5];
-		__u64 serror_esr;
-	} exception;
-	__u32 reserved[12];
-};
-
-/* If you need to interpret the index values, here is the key: */
-#define KVM_REG_ARM_COPROC_MASK		0x000000000FFF0000
-#define KVM_REG_ARM_COPROC_SHIFT	16
-#define KVM_REG_ARM_32_OPC2_MASK	0x0000000000000007
-#define KVM_REG_ARM_32_OPC2_SHIFT	0
-#define KVM_REG_ARM_OPC1_MASK		0x0000000000000078
-#define KVM_REG_ARM_OPC1_SHIFT		3
-#define KVM_REG_ARM_CRM_MASK		0x0000000000000780
-#define KVM_REG_ARM_CRM_SHIFT		7
-#define KVM_REG_ARM_32_CRN_MASK		0x0000000000007800
-#define KVM_REG_ARM_32_CRN_SHIFT	11
-/*
- * For KVM currently all guest registers are nonsecure, but we reserve a bit
- * in the encoding to distinguish secure from nonsecure for AArch32 system
- * registers that are banked by security. This is 1 for the secure banked
- * register, and 0 for the nonsecure banked register or if the register is
- * not banked by security.
- */
-#define KVM_REG_ARM_SECURE_MASK	0x0000000010000000
-#define KVM_REG_ARM_SECURE_SHIFT	28
-
-#define ARM_CP15_REG_SHIFT_MASK(x,n) \
-	(((x) << KVM_REG_ARM_ ## n ## _SHIFT) & KVM_REG_ARM_ ## n ## _MASK)
-
-#define __ARM_CP15_REG(op1,crn,crm,op2) \
-	(KVM_REG_ARM | (15 << KVM_REG_ARM_COPROC_SHIFT) | \
-	ARM_CP15_REG_SHIFT_MASK(op1, OPC1) | \
-	ARM_CP15_REG_SHIFT_MASK(crn, 32_CRN) | \
-	ARM_CP15_REG_SHIFT_MASK(crm, CRM) | \
-	ARM_CP15_REG_SHIFT_MASK(op2, 32_OPC2))
-
-#define ARM_CP15_REG32(...) (__ARM_CP15_REG(__VA_ARGS__) | KVM_REG_SIZE_U32)
-
-#define __ARM_CP15_REG64(op1,crm) \
-	(__ARM_CP15_REG(op1, 0, crm, 0) | KVM_REG_SIZE_U64)
-#define ARM_CP15_REG64(...) __ARM_CP15_REG64(__VA_ARGS__)
-
-/* PL1 Physical Timer Registers */
-#define KVM_REG_ARM_PTIMER_CTL		ARM_CP15_REG32(0, 14, 2, 1)
-#define KVM_REG_ARM_PTIMER_CNT		ARM_CP15_REG64(0, 14)
-#define KVM_REG_ARM_PTIMER_CVAL		ARM_CP15_REG64(2, 14)
-
-/* Virtual Timer Registers */
-#define KVM_REG_ARM_TIMER_CTL		ARM_CP15_REG32(0, 14, 3, 1)
-#define KVM_REG_ARM_TIMER_CNT		ARM_CP15_REG64(1, 14)
-#define KVM_REG_ARM_TIMER_CVAL		ARM_CP15_REG64(3, 14)
-
-/* Normal registers are mapped as coprocessor 16. */
-#define KVM_REG_ARM_CORE		(0x0010 << KVM_REG_ARM_COPROC_SHIFT)
-#define KVM_REG_ARM_CORE_REG(name)	(offsetof(struct kvm_regs, name) / 4)
-
-/* Some registers need more space to represent values. */
-#define KVM_REG_ARM_DEMUX		(0x0011 << KVM_REG_ARM_COPROC_SHIFT)
-#define KVM_REG_ARM_DEMUX_ID_MASK	0x000000000000FF00
-#define KVM_REG_ARM_DEMUX_ID_SHIFT	8
-#define KVM_REG_ARM_DEMUX_ID_CCSIDR	(0x00 << KVM_REG_ARM_DEMUX_ID_SHIFT)
-#define KVM_REG_ARM_DEMUX_VAL_MASK	0x00000000000000FF
-#define KVM_REG_ARM_DEMUX_VAL_SHIFT	0
-
-/* VFP registers: we could overload CP10 like ARM does, but that's ugly. */
-#define KVM_REG_ARM_VFP			(0x0012 << KVM_REG_ARM_COPROC_SHIFT)
-#define KVM_REG_ARM_VFP_MASK		0x000000000000FFFF
-#define KVM_REG_ARM_VFP_BASE_REG	0x0
-#define KVM_REG_ARM_VFP_FPSID		0x1000
-#define KVM_REG_ARM_VFP_FPSCR		0x1001
-#define KVM_REG_ARM_VFP_MVFR1		0x1006
-#define KVM_REG_ARM_VFP_MVFR0		0x1007
-#define KVM_REG_ARM_VFP_FPEXC		0x1008
-#define KVM_REG_ARM_VFP_FPINST		0x1009
-#define KVM_REG_ARM_VFP_FPINST2		0x100A
-
-/* KVM-as-firmware specific pseudo-registers */
-#define KVM_REG_ARM_FW			(0x0014 << KVM_REG_ARM_COPROC_SHIFT)
-#define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM | KVM_REG_SIZE_U64 | \
-					 KVM_REG_ARM_FW | ((r) & 0xffff))
-#define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1	KVM_REG_ARM_FW_REG(1)
-	/* Higher values mean better protection. */
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_AVAIL		0
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_AVAIL		1
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1_NOT_REQUIRED	2
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2	KVM_REG_ARM_FW_REG(2)
-	/* Higher values mean better protection. */
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_AVAIL		0
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_UNKNOWN		1
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_AVAIL		2
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED	3
-#define KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_ENABLED	(1U << 4)
-
-/* Device Control API: ARM VGIC */
-#define KVM_DEV_ARM_VGIC_GRP_ADDR	0
-#define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
-#define KVM_DEV_ARM_VGIC_GRP_CPU_REGS	2
-#define   KVM_DEV_ARM_VGIC_CPUID_SHIFT	32
-#define   KVM_DEV_ARM_VGIC_CPUID_MASK	(0xffULL << KVM_DEV_ARM_VGIC_CPUID_SHIFT)
-#define   KVM_DEV_ARM_VGIC_V3_MPIDR_SHIFT 32
-#define   KVM_DEV_ARM_VGIC_V3_MPIDR_MASK \
-			(0xffffffffULL << KVM_DEV_ARM_VGIC_V3_MPIDR_SHIFT)
-#define   KVM_DEV_ARM_VGIC_OFFSET_SHIFT	0
-#define   KVM_DEV_ARM_VGIC_OFFSET_MASK	(0xffffffffULL << KVM_DEV_ARM_VGIC_OFFSET_SHIFT)
-#define   KVM_DEV_ARM_VGIC_SYSREG_INSTR_MASK (0xffff)
-#define KVM_DEV_ARM_VGIC_GRP_NR_IRQS	3
-#define KVM_DEV_ARM_VGIC_GRP_CTRL       4
-#define KVM_DEV_ARM_VGIC_GRP_REDIST_REGS 5
-#define KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS 6
-#define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO  7
-#define KVM_DEV_ARM_VGIC_GRP_ITS_REGS	8
-#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	10
-#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
-			(0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
-#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INTID_MASK 0x3ff
-#define VGIC_LEVEL_INFO_LINE_LEVEL	0
-
-/* Device Control API on vcpu fd */
-#define KVM_ARM_VCPU_PMU_V3_CTRL	0
-#define   KVM_ARM_VCPU_PMU_V3_IRQ	0
-#define   KVM_ARM_VCPU_PMU_V3_INIT	1
-#define KVM_ARM_VCPU_TIMER_CTRL		1
-#define   KVM_ARM_VCPU_TIMER_IRQ_VTIMER		0
-#define   KVM_ARM_VCPU_TIMER_IRQ_PTIMER		1
-
-#define   KVM_DEV_ARM_VGIC_CTRL_INIT		0
-#define   KVM_DEV_ARM_ITS_SAVE_TABLES		1
-#define   KVM_DEV_ARM_ITS_RESTORE_TABLES	2
-#define   KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES	3
-#define   KVM_DEV_ARM_ITS_CTRL_RESET		4
-
-/* KVM_IRQ_LINE irq field index values */
-#define KVM_ARM_IRQ_VCPU2_SHIFT		28
-#define KVM_ARM_IRQ_VCPU2_MASK		0xf
-#define KVM_ARM_IRQ_TYPE_SHIFT		24
-#define KVM_ARM_IRQ_TYPE_MASK		0xf
-#define KVM_ARM_IRQ_VCPU_SHIFT		16
-#define KVM_ARM_IRQ_VCPU_MASK		0xff
-#define KVM_ARM_IRQ_NUM_SHIFT		0
-#define KVM_ARM_IRQ_NUM_MASK		0xffff
-
-/* irq_type field */
-#define KVM_ARM_IRQ_TYPE_CPU		0
-#define KVM_ARM_IRQ_TYPE_SPI		1
-#define KVM_ARM_IRQ_TYPE_PPI		2
-
-/* out-of-kernel GIC cpu interrupt injection irq_number field */
-#define KVM_ARM_IRQ_CPU_IRQ		0
-#define KVM_ARM_IRQ_CPU_FIQ		1
-
-/*
- * This used to hold the highest supported SPI, but it is now obsolete
- * and only here to provide source code level compatibility with older
- * userland. The highest SPI number can be set via KVM_DEV_ARM_VGIC_GRP_NR_IRQS.
- */
-#define KVM_ARM_IRQ_GIC_MAX		127
-
-/* One single KVM irqchip, ie. the VGIC */
-#define KVM_NR_IRQCHIPS          1
-
-/* PSCI interface */
-#define KVM_PSCI_FN_BASE		0x95c1ba5e
-#define KVM_PSCI_FN(n)			(KVM_PSCI_FN_BASE + (n))
-
-#define KVM_PSCI_FN_CPU_SUSPEND		KVM_PSCI_FN(0)
-#define KVM_PSCI_FN_CPU_OFF		KVM_PSCI_FN(1)
-#define KVM_PSCI_FN_CPU_ON		KVM_PSCI_FN(2)
-#define KVM_PSCI_FN_MIGRATE		KVM_PSCI_FN(3)
-
-#define KVM_PSCI_RET_SUCCESS		PSCI_RET_SUCCESS
-#define KVM_PSCI_RET_NI			PSCI_RET_NOT_SUPPORTED
-#define KVM_PSCI_RET_INVAL		PSCI_RET_INVALID_PARAMS
-#define KVM_PSCI_RET_DENIED		PSCI_RET_DENIED
-
-#endif /* __ARM_KVM_H__ */
diff --git a/linux-headers/asm-arm/mman.h b/linux-headers/asm-arm/mman.h
deleted file mode 100644
index 41f99c573b9..00000000000
--- a/linux-headers/asm-arm/mman.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#include <asm-generic/mman.h>
-
-#define arch_mmap_check(addr, len, flags) \
-	(((flags) & MAP_FIXED && (addr) < FIRST_USER_ADDRESS) ? -EINVAL : 0)
diff --git a/linux-headers/asm-arm/unistd-common.h b/linux-headers/asm-arm/unistd-common.h
deleted file mode 100644
index 57cd1f21dbd..00000000000
--- a/linux-headers/asm-arm/unistd-common.h
+++ /dev/null
@@ -1,397 +0,0 @@
-#ifndef _ASM_ARM_UNISTD_COMMON_H
-#define _ASM_ARM_UNISTD_COMMON_H 1
-
-#define __NR_restart_syscall (__NR_SYSCALL_BASE + 0)
-#define __NR_exit (__NR_SYSCALL_BASE + 1)
-#define __NR_fork (__NR_SYSCALL_BASE + 2)
-#define __NR_read (__NR_SYSCALL_BASE + 3)
-#define __NR_write (__NR_SYSCALL_BASE + 4)
-#define __NR_open (__NR_SYSCALL_BASE + 5)
-#define __NR_close (__NR_SYSCALL_BASE + 6)
-#define __NR_creat (__NR_SYSCALL_BASE + 8)
-#define __NR_link (__NR_SYSCALL_BASE + 9)
-#define __NR_unlink (__NR_SYSCALL_BASE + 10)
-#define __NR_execve (__NR_SYSCALL_BASE + 11)
-#define __NR_chdir (__NR_SYSCALL_BASE + 12)
-#define __NR_mknod (__NR_SYSCALL_BASE + 14)
-#define __NR_chmod (__NR_SYSCALL_BASE + 15)
-#define __NR_lchown (__NR_SYSCALL_BASE + 16)
-#define __NR_lseek (__NR_SYSCALL_BASE + 19)
-#define __NR_getpid (__NR_SYSCALL_BASE + 20)
-#define __NR_mount (__NR_SYSCALL_BASE + 21)
-#define __NR_setuid (__NR_SYSCALL_BASE + 23)
-#define __NR_getuid (__NR_SYSCALL_BASE + 24)
-#define __NR_ptrace (__NR_SYSCALL_BASE + 26)
-#define __NR_pause (__NR_SYSCALL_BASE + 29)
-#define __NR_access (__NR_SYSCALL_BASE + 33)
-#define __NR_nice (__NR_SYSCALL_BASE + 34)
-#define __NR_sync (__NR_SYSCALL_BASE + 36)
-#define __NR_kill (__NR_SYSCALL_BASE + 37)
-#define __NR_rename (__NR_SYSCALL_BASE + 38)
-#define __NR_mkdir (__NR_SYSCALL_BASE + 39)
-#define __NR_rmdir (__NR_SYSCALL_BASE + 40)
-#define __NR_dup (__NR_SYSCALL_BASE + 41)
-#define __NR_pipe (__NR_SYSCALL_BASE + 42)
-#define __NR_times (__NR_SYSCALL_BASE + 43)
-#define __NR_brk (__NR_SYSCALL_BASE + 45)
-#define __NR_setgid (__NR_SYSCALL_BASE + 46)
-#define __NR_getgid (__NR_SYSCALL_BASE + 47)
-#define __NR_geteuid (__NR_SYSCALL_BASE + 49)
-#define __NR_getegid (__NR_SYSCALL_BASE + 50)
-#define __NR_acct (__NR_SYSCALL_BASE + 51)
-#define __NR_umount2 (__NR_SYSCALL_BASE + 52)
-#define __NR_ioctl (__NR_SYSCALL_BASE + 54)
-#define __NR_fcntl (__NR_SYSCALL_BASE + 55)
-#define __NR_setpgid (__NR_SYSCALL_BASE + 57)
-#define __NR_umask (__NR_SYSCALL_BASE + 60)
-#define __NR_chroot (__NR_SYSCALL_BASE + 61)
-#define __NR_ustat (__NR_SYSCALL_BASE + 62)
-#define __NR_dup2 (__NR_SYSCALL_BASE + 63)
-#define __NR_getppid (__NR_SYSCALL_BASE + 64)
-#define __NR_getpgrp (__NR_SYSCALL_BASE + 65)
-#define __NR_setsid (__NR_SYSCALL_BASE + 66)
-#define __NR_sigaction (__NR_SYSCALL_BASE + 67)
-#define __NR_setreuid (__NR_SYSCALL_BASE + 70)
-#define __NR_setregid (__NR_SYSCALL_BASE + 71)
-#define __NR_sigsuspend (__NR_SYSCALL_BASE + 72)
-#define __NR_sigpending (__NR_SYSCALL_BASE + 73)
-#define __NR_sethostname (__NR_SYSCALL_BASE + 74)
-#define __NR_setrlimit (__NR_SYSCALL_BASE + 75)
-#define __NR_getrusage (__NR_SYSCALL_BASE + 77)
-#define __NR_gettimeofday (__NR_SYSCALL_BASE + 78)
-#define __NR_settimeofday (__NR_SYSCALL_BASE + 79)
-#define __NR_getgroups (__NR_SYSCALL_BASE + 80)
-#define __NR_setgroups (__NR_SYSCALL_BASE + 81)
-#define __NR_symlink (__NR_SYSCALL_BASE + 83)
-#define __NR_readlink (__NR_SYSCALL_BASE + 85)
-#define __NR_uselib (__NR_SYSCALL_BASE + 86)
-#define __NR_swapon (__NR_SYSCALL_BASE + 87)
-#define __NR_reboot (__NR_SYSCALL_BASE + 88)
-#define __NR_munmap (__NR_SYSCALL_BASE + 91)
-#define __NR_truncate (__NR_SYSCALL_BASE + 92)
-#define __NR_ftruncate (__NR_SYSCALL_BASE + 93)
-#define __NR_fchmod (__NR_SYSCALL_BASE + 94)
-#define __NR_fchown (__NR_SYSCALL_BASE + 95)
-#define __NR_getpriority (__NR_SYSCALL_BASE + 96)
-#define __NR_setpriority (__NR_SYSCALL_BASE + 97)
-#define __NR_statfs (__NR_SYSCALL_BASE + 99)
-#define __NR_fstatfs (__NR_SYSCALL_BASE + 100)
-#define __NR_syslog (__NR_SYSCALL_BASE + 103)
-#define __NR_setitimer (__NR_SYSCALL_BASE + 104)
-#define __NR_getitimer (__NR_SYSCALL_BASE + 105)
-#define __NR_stat (__NR_SYSCALL_BASE + 106)
-#define __NR_lstat (__NR_SYSCALL_BASE + 107)
-#define __NR_fstat (__NR_SYSCALL_BASE + 108)
-#define __NR_vhangup (__NR_SYSCALL_BASE + 111)
-#define __NR_wait4 (__NR_SYSCALL_BASE + 114)
-#define __NR_swapoff (__NR_SYSCALL_BASE + 115)
-#define __NR_sysinfo (__NR_SYSCALL_BASE + 116)
-#define __NR_fsync (__NR_SYSCALL_BASE + 118)
-#define __NR_sigreturn (__NR_SYSCALL_BASE + 119)
-#define __NR_clone (__NR_SYSCALL_BASE + 120)
-#define __NR_setdomainname (__NR_SYSCALL_BASE + 121)
-#define __NR_uname (__NR_SYSCALL_BASE + 122)
-#define __NR_adjtimex (__NR_SYSCALL_BASE + 124)
-#define __NR_mprotect (__NR_SYSCALL_BASE + 125)
-#define __NR_sigprocmask (__NR_SYSCALL_BASE + 126)
-#define __NR_init_module (__NR_SYSCALL_BASE + 128)
-#define __NR_delete_module (__NR_SYSCALL_BASE + 129)
-#define __NR_quotactl (__NR_SYSCALL_BASE + 131)
-#define __NR_getpgid (__NR_SYSCALL_BASE + 132)
-#define __NR_fchdir (__NR_SYSCALL_BASE + 133)
-#define __NR_bdflush (__NR_SYSCALL_BASE + 134)
-#define __NR_sysfs (__NR_SYSCALL_BASE + 135)
-#define __NR_personality (__NR_SYSCALL_BASE + 136)
-#define __NR_setfsuid (__NR_SYSCALL_BASE + 138)
-#define __NR_setfsgid (__NR_SYSCALL_BASE + 139)
-#define __NR__llseek (__NR_SYSCALL_BASE + 140)
-#define __NR_getdents (__NR_SYSCALL_BASE + 141)
-#define __NR__newselect (__NR_SYSCALL_BASE + 142)
-#define __NR_flock (__NR_SYSCALL_BASE + 143)
-#define __NR_msync (__NR_SYSCALL_BASE + 144)
-#define __NR_readv (__NR_SYSCALL_BASE + 145)
-#define __NR_writev (__NR_SYSCALL_BASE + 146)
-#define __NR_getsid (__NR_SYSCALL_BASE + 147)
-#define __NR_fdatasync (__NR_SYSCALL_BASE + 148)
-#define __NR__sysctl (__NR_SYSCALL_BASE + 149)
-#define __NR_mlock (__NR_SYSCALL_BASE + 150)
-#define __NR_munlock (__NR_SYSCALL_BASE + 151)
-#define __NR_mlockall (__NR_SYSCALL_BASE + 152)
-#define __NR_munlockall (__NR_SYSCALL_BASE + 153)
-#define __NR_sched_setparam (__NR_SYSCALL_BASE + 154)
-#define __NR_sched_getparam (__NR_SYSCALL_BASE + 155)
-#define __NR_sched_setscheduler (__NR_SYSCALL_BASE + 156)
-#define __NR_sched_getscheduler (__NR_SYSCALL_BASE + 157)
-#define __NR_sched_yield (__NR_SYSCALL_BASE + 158)
-#define __NR_sched_get_priority_max (__NR_SYSCALL_BASE + 159)
-#define __NR_sched_get_priority_min (__NR_SYSCALL_BASE + 160)
-#define __NR_sched_rr_get_interval (__NR_SYSCALL_BASE + 161)
-#define __NR_nanosleep (__NR_SYSCALL_BASE + 162)
-#define __NR_mremap (__NR_SYSCALL_BASE + 163)
-#define __NR_setresuid (__NR_SYSCALL_BASE + 164)
-#define __NR_getresuid (__NR_SYSCALL_BASE + 165)
-#define __NR_poll (__NR_SYSCALL_BASE + 168)
-#define __NR_nfsservctl (__NR_SYSCALL_BASE + 169)
-#define __NR_setresgid (__NR_SYSCALL_BASE + 170)
-#define __NR_getresgid (__NR_SYSCALL_BASE + 171)
-#define __NR_prctl (__NR_SYSCALL_BASE + 172)
-#define __NR_rt_sigreturn (__NR_SYSCALL_BASE + 173)
-#define __NR_rt_sigaction (__NR_SYSCALL_BASE + 174)
-#define __NR_rt_sigprocmask (__NR_SYSCALL_BASE + 175)
-#define __NR_rt_sigpending (__NR_SYSCALL_BASE + 176)
-#define __NR_rt_sigtimedwait (__NR_SYSCALL_BASE + 177)
-#define __NR_rt_sigqueueinfo (__NR_SYSCALL_BASE + 178)
-#define __NR_rt_sigsuspend (__NR_SYSCALL_BASE + 179)
-#define __NR_pread64 (__NR_SYSCALL_BASE + 180)
-#define __NR_pwrite64 (__NR_SYSCALL_BASE + 181)
-#define __NR_chown (__NR_SYSCALL_BASE + 182)
-#define __NR_getcwd (__NR_SYSCALL_BASE + 183)
-#define __NR_capget (__NR_SYSCALL_BASE + 184)
-#define __NR_capset (__NR_SYSCALL_BASE + 185)
-#define __NR_sigaltstack (__NR_SYSCALL_BASE + 186)
-#define __NR_sendfile (__NR_SYSCALL_BASE + 187)
-#define __NR_vfork (__NR_SYSCALL_BASE + 190)
-#define __NR_ugetrlimit (__NR_SYSCALL_BASE + 191)
-#define __NR_mmap2 (__NR_SYSCALL_BASE + 192)
-#define __NR_truncate64 (__NR_SYSCALL_BASE + 193)
-#define __NR_ftruncate64 (__NR_SYSCALL_BASE + 194)
-#define __NR_stat64 (__NR_SYSCALL_BASE + 195)
-#define __NR_lstat64 (__NR_SYSCALL_BASE + 196)
-#define __NR_fstat64 (__NR_SYSCALL_BASE + 197)
-#define __NR_lchown32 (__NR_SYSCALL_BASE + 198)
-#define __NR_getuid32 (__NR_SYSCALL_BASE + 199)
-#define __NR_getgid32 (__NR_SYSCALL_BASE + 200)
-#define __NR_geteuid32 (__NR_SYSCALL_BASE + 201)
-#define __NR_getegid32 (__NR_SYSCALL_BASE + 202)
-#define __NR_setreuid32 (__NR_SYSCALL_BASE + 203)
-#define __NR_setregid32 (__NR_SYSCALL_BASE + 204)
-#define __NR_getgroups32 (__NR_SYSCALL_BASE + 205)
-#define __NR_setgroups32 (__NR_SYSCALL_BASE + 206)
-#define __NR_fchown32 (__NR_SYSCALL_BASE + 207)
-#define __NR_setresuid32 (__NR_SYSCALL_BASE + 208)
-#define __NR_getresuid32 (__NR_SYSCALL_BASE + 209)
-#define __NR_setresgid32 (__NR_SYSCALL_BASE + 210)
-#define __NR_getresgid32 (__NR_SYSCALL_BASE + 211)
-#define __NR_chown32 (__NR_SYSCALL_BASE + 212)
-#define __NR_setuid32 (__NR_SYSCALL_BASE + 213)
-#define __NR_setgid32 (__NR_SYSCALL_BASE + 214)
-#define __NR_setfsuid32 (__NR_SYSCALL_BASE + 215)
-#define __NR_setfsgid32 (__NR_SYSCALL_BASE + 216)
-#define __NR_getdents64 (__NR_SYSCALL_BASE + 217)
-#define __NR_pivot_root (__NR_SYSCALL_BASE + 218)
-#define __NR_mincore (__NR_SYSCALL_BASE + 219)
-#define __NR_madvise (__NR_SYSCALL_BASE + 220)
-#define __NR_fcntl64 (__NR_SYSCALL_BASE + 221)
-#define __NR_gettid (__NR_SYSCALL_BASE + 224)
-#define __NR_readahead (__NR_SYSCALL_BASE + 225)
-#define __NR_setxattr (__NR_SYSCALL_BASE + 226)
-#define __NR_lsetxattr (__NR_SYSCALL_BASE + 227)
-#define __NR_fsetxattr (__NR_SYSCALL_BASE + 228)
-#define __NR_getxattr (__NR_SYSCALL_BASE + 229)
-#define __NR_lgetxattr (__NR_SYSCALL_BASE + 230)
-#define __NR_fgetxattr (__NR_SYSCALL_BASE + 231)
-#define __NR_listxattr (__NR_SYSCALL_BASE + 232)
-#define __NR_llistxattr (__NR_SYSCALL_BASE + 233)
-#define __NR_flistxattr (__NR_SYSCALL_BASE + 234)
-#define __NR_removexattr (__NR_SYSCALL_BASE + 235)
-#define __NR_lremovexattr (__NR_SYSCALL_BASE + 236)
-#define __NR_fremovexattr (__NR_SYSCALL_BASE + 237)
-#define __NR_tkill (__NR_SYSCALL_BASE + 238)
-#define __NR_sendfile64 (__NR_SYSCALL_BASE + 239)
-#define __NR_futex (__NR_SYSCALL_BASE + 240)
-#define __NR_sched_setaffinity (__NR_SYSCALL_BASE + 241)
-#define __NR_sched_getaffinity (__NR_SYSCALL_BASE + 242)
-#define __NR_io_setup (__NR_SYSCALL_BASE + 243)
-#define __NR_io_destroy (__NR_SYSCALL_BASE + 244)
-#define __NR_io_getevents (__NR_SYSCALL_BASE + 245)
-#define __NR_io_submit (__NR_SYSCALL_BASE + 246)
-#define __NR_io_cancel (__NR_SYSCALL_BASE + 247)
-#define __NR_exit_group (__NR_SYSCALL_BASE + 248)
-#define __NR_lookup_dcookie (__NR_SYSCALL_BASE + 249)
-#define __NR_epoll_create (__NR_SYSCALL_BASE + 250)
-#define __NR_epoll_ctl (__NR_SYSCALL_BASE + 251)
-#define __NR_epoll_wait (__NR_SYSCALL_BASE + 252)
-#define __NR_remap_file_pages (__NR_SYSCALL_BASE + 253)
-#define __NR_set_tid_address (__NR_SYSCALL_BASE + 256)
-#define __NR_timer_create (__NR_SYSCALL_BASE + 257)
-#define __NR_timer_settime (__NR_SYSCALL_BASE + 258)
-#define __NR_timer_gettime (__NR_SYSCALL_BASE + 259)
-#define __NR_timer_getoverrun (__NR_SYSCALL_BASE + 260)
-#define __NR_timer_delete (__NR_SYSCALL_BASE + 261)
-#define __NR_clock_settime (__NR_SYSCALL_BASE + 262)
-#define __NR_clock_gettime (__NR_SYSCALL_BASE + 263)
-#define __NR_clock_getres (__NR_SYSCALL_BASE + 264)
-#define __NR_clock_nanosleep (__NR_SYSCALL_BASE + 265)
-#define __NR_statfs64 (__NR_SYSCALL_BASE + 266)
-#define __NR_fstatfs64 (__NR_SYSCALL_BASE + 267)
-#define __NR_tgkill (__NR_SYSCALL_BASE + 268)
-#define __NR_utimes (__NR_SYSCALL_BASE + 269)
-#define __NR_arm_fadvise64_64 (__NR_SYSCALL_BASE + 270)
-#define __NR_pciconfig_iobase (__NR_SYSCALL_BASE + 271)
-#define __NR_pciconfig_read (__NR_SYSCALL_BASE + 272)
-#define __NR_pciconfig_write (__NR_SYSCALL_BASE + 273)
-#define __NR_mq_open (__NR_SYSCALL_BASE + 274)
-#define __NR_mq_unlink (__NR_SYSCALL_BASE + 275)
-#define __NR_mq_timedsend (__NR_SYSCALL_BASE + 276)
-#define __NR_mq_timedreceive (__NR_SYSCALL_BASE + 277)
-#define __NR_mq_notify (__NR_SYSCALL_BASE + 278)
-#define __NR_mq_getsetattr (__NR_SYSCALL_BASE + 279)
-#define __NR_waitid (__NR_SYSCALL_BASE + 280)
-#define __NR_socket (__NR_SYSCALL_BASE + 281)
-#define __NR_bind (__NR_SYSCALL_BASE + 282)
-#define __NR_connect (__NR_SYSCALL_BASE + 283)
-#define __NR_listen (__NR_SYSCALL_BASE + 284)
-#define __NR_accept (__NR_SYSCALL_BASE + 285)
-#define __NR_getsockname (__NR_SYSCALL_BASE + 286)
-#define __NR_getpeername (__NR_SYSCALL_BASE + 287)
-#define __NR_socketpair (__NR_SYSCALL_BASE + 288)
-#define __NR_send (__NR_SYSCALL_BASE + 289)
-#define __NR_sendto (__NR_SYSCALL_BASE + 290)
-#define __NR_recv (__NR_SYSCALL_BASE + 291)
-#define __NR_recvfrom (__NR_SYSCALL_BASE + 292)
-#define __NR_shutdown (__NR_SYSCALL_BASE + 293)
-#define __NR_setsockopt (__NR_SYSCALL_BASE + 294)
-#define __NR_getsockopt (__NR_SYSCALL_BASE + 295)
-#define __NR_sendmsg (__NR_SYSCALL_BASE + 296)
-#define __NR_recvmsg (__NR_SYSCALL_BASE + 297)
-#define __NR_semop (__NR_SYSCALL_BASE + 298)
-#define __NR_semget (__NR_SYSCALL_BASE + 299)
-#define __NR_semctl (__NR_SYSCALL_BASE + 300)
-#define __NR_msgsnd (__NR_SYSCALL_BASE + 301)
-#define __NR_msgrcv (__NR_SYSCALL_BASE + 302)
-#define __NR_msgget (__NR_SYSCALL_BASE + 303)
-#define __NR_msgctl (__NR_SYSCALL_BASE + 304)
-#define __NR_shmat (__NR_SYSCALL_BASE + 305)
-#define __NR_shmdt (__NR_SYSCALL_BASE + 306)
-#define __NR_shmget (__NR_SYSCALL_BASE + 307)
-#define __NR_shmctl (__NR_SYSCALL_BASE + 308)
-#define __NR_add_key (__NR_SYSCALL_BASE + 309)
-#define __NR_request_key (__NR_SYSCALL_BASE + 310)
-#define __NR_keyctl (__NR_SYSCALL_BASE + 311)
-#define __NR_semtimedop (__NR_SYSCALL_BASE + 312)
-#define __NR_vserver (__NR_SYSCALL_BASE + 313)
-#define __NR_ioprio_set (__NR_SYSCALL_BASE + 314)
-#define __NR_ioprio_get (__NR_SYSCALL_BASE + 315)
-#define __NR_inotify_init (__NR_SYSCALL_BASE + 316)
-#define __NR_inotify_add_watch (__NR_SYSCALL_BASE + 317)
-#define __NR_inotify_rm_watch (__NR_SYSCALL_BASE + 318)
-#define __NR_mbind (__NR_SYSCALL_BASE + 319)
-#define __NR_get_mempolicy (__NR_SYSCALL_BASE + 320)
-#define __NR_set_mempolicy (__NR_SYSCALL_BASE + 321)
-#define __NR_openat (__NR_SYSCALL_BASE + 322)
-#define __NR_mkdirat (__NR_SYSCALL_BASE + 323)
-#define __NR_mknodat (__NR_SYSCALL_BASE + 324)
-#define __NR_fchownat (__NR_SYSCALL_BASE + 325)
-#define __NR_futimesat (__NR_SYSCALL_BASE + 326)
-#define __NR_fstatat64 (__NR_SYSCALL_BASE + 327)
-#define __NR_unlinkat (__NR_SYSCALL_BASE + 328)
-#define __NR_renameat (__NR_SYSCALL_BASE + 329)
-#define __NR_linkat (__NR_SYSCALL_BASE + 330)
-#define __NR_symlinkat (__NR_SYSCALL_BASE + 331)
-#define __NR_readlinkat (__NR_SYSCALL_BASE + 332)
-#define __NR_fchmodat (__NR_SYSCALL_BASE + 333)
-#define __NR_faccessat (__NR_SYSCALL_BASE + 334)
-#define __NR_pselect6 (__NR_SYSCALL_BASE + 335)
-#define __NR_ppoll (__NR_SYSCALL_BASE + 336)
-#define __NR_unshare (__NR_SYSCALL_BASE + 337)
-#define __NR_set_robust_list (__NR_SYSCALL_BASE + 338)
-#define __NR_get_robust_list (__NR_SYSCALL_BASE + 339)
-#define __NR_splice (__NR_SYSCALL_BASE + 340)
-#define __NR_arm_sync_file_range (__NR_SYSCALL_BASE + 341)
-#define __NR_tee (__NR_SYSCALL_BASE + 342)
-#define __NR_vmsplice (__NR_SYSCALL_BASE + 343)
-#define __NR_move_pages (__NR_SYSCALL_BASE + 344)
-#define __NR_getcpu (__NR_SYSCALL_BASE + 345)
-#define __NR_epoll_pwait (__NR_SYSCALL_BASE + 346)
-#define __NR_kexec_load (__NR_SYSCALL_BASE + 347)
-#define __NR_utimensat (__NR_SYSCALL_BASE + 348)
-#define __NR_signalfd (__NR_SYSCALL_BASE + 349)
-#define __NR_timerfd_create (__NR_SYSCALL_BASE + 350)
-#define __NR_eventfd (__NR_SYSCALL_BASE + 351)
-#define __NR_fallocate (__NR_SYSCALL_BASE + 352)
-#define __NR_timerfd_settime (__NR_SYSCALL_BASE + 353)
-#define __NR_timerfd_gettime (__NR_SYSCALL_BASE + 354)
-#define __NR_signalfd4 (__NR_SYSCALL_BASE + 355)
-#define __NR_eventfd2 (__NR_SYSCALL_BASE + 356)
-#define __NR_epoll_create1 (__NR_SYSCALL_BASE + 357)
-#define __NR_dup3 (__NR_SYSCALL_BASE + 358)
-#define __NR_pipe2 (__NR_SYSCALL_BASE + 359)
-#define __NR_inotify_init1 (__NR_SYSCALL_BASE + 360)
-#define __NR_preadv (__NR_SYSCALL_BASE + 361)
-#define __NR_pwritev (__NR_SYSCALL_BASE + 362)
-#define __NR_rt_tgsigqueueinfo (__NR_SYSCALL_BASE + 363)
-#define __NR_perf_event_open (__NR_SYSCALL_BASE + 364)
-#define __NR_recvmmsg (__NR_SYSCALL_BASE + 365)
-#define __NR_accept4 (__NR_SYSCALL_BASE + 366)
-#define __NR_fanotify_init (__NR_SYSCALL_BASE + 367)
-#define __NR_fanotify_mark (__NR_SYSCALL_BASE + 368)
-#define __NR_prlimit64 (__NR_SYSCALL_BASE + 369)
-#define __NR_name_to_handle_at (__NR_SYSCALL_BASE + 370)
-#define __NR_open_by_handle_at (__NR_SYSCALL_BASE + 371)
-#define __NR_clock_adjtime (__NR_SYSCALL_BASE + 372)
-#define __NR_syncfs (__NR_SYSCALL_BASE + 373)
-#define __NR_sendmmsg (__NR_SYSCALL_BASE + 374)
-#define __NR_setns (__NR_SYSCALL_BASE + 375)
-#define __NR_process_vm_readv (__NR_SYSCALL_BASE + 376)
-#define __NR_process_vm_writev (__NR_SYSCALL_BASE + 377)
-#define __NR_kcmp (__NR_SYSCALL_BASE + 378)
-#define __NR_finit_module (__NR_SYSCALL_BASE + 379)
-#define __NR_sched_setattr (__NR_SYSCALL_BASE + 380)
-#define __NR_sched_getattr (__NR_SYSCALL_BASE + 381)
-#define __NR_renameat2 (__NR_SYSCALL_BASE + 382)
-#define __NR_seccomp (__NR_SYSCALL_BASE + 383)
-#define __NR_getrandom (__NR_SYSCALL_BASE + 384)
-#define __NR_memfd_create (__NR_SYSCALL_BASE + 385)
-#define __NR_bpf (__NR_SYSCALL_BASE + 386)
-#define __NR_execveat (__NR_SYSCALL_BASE + 387)
-#define __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
-#define __NR_membarrier (__NR_SYSCALL_BASE + 389)
-#define __NR_mlock2 (__NR_SYSCALL_BASE + 390)
-#define __NR_copy_file_range (__NR_SYSCALL_BASE + 391)
-#define __NR_preadv2 (__NR_SYSCALL_BASE + 392)
-#define __NR_pwritev2 (__NR_SYSCALL_BASE + 393)
-#define __NR_pkey_mprotect (__NR_SYSCALL_BASE + 394)
-#define __NR_pkey_alloc (__NR_SYSCALL_BASE + 395)
-#define __NR_pkey_free (__NR_SYSCALL_BASE + 396)
-#define __NR_statx (__NR_SYSCALL_BASE + 397)
-#define __NR_rseq (__NR_SYSCALL_BASE + 398)
-#define __NR_io_pgetevents (__NR_SYSCALL_BASE + 399)
-#define __NR_migrate_pages (__NR_SYSCALL_BASE + 400)
-#define __NR_kexec_file_load (__NR_SYSCALL_BASE + 401)
-#define __NR_clock_gettime64 (__NR_SYSCALL_BASE + 403)
-#define __NR_clock_settime64 (__NR_SYSCALL_BASE + 404)
-#define __NR_clock_adjtime64 (__NR_SYSCALL_BASE + 405)
-#define __NR_clock_getres_time64 (__NR_SYSCALL_BASE + 406)
-#define __NR_clock_nanosleep_time64 (__NR_SYSCALL_BASE + 407)
-#define __NR_timer_gettime64 (__NR_SYSCALL_BASE + 408)
-#define __NR_timer_settime64 (__NR_SYSCALL_BASE + 409)
-#define __NR_timerfd_gettime64 (__NR_SYSCALL_BASE + 410)
-#define __NR_timerfd_settime64 (__NR_SYSCALL_BASE + 411)
-#define __NR_utimensat_time64 (__NR_SYSCALL_BASE + 412)
-#define __NR_pselect6_time64 (__NR_SYSCALL_BASE + 413)
-#define __NR_ppoll_time64 (__NR_SYSCALL_BASE + 414)
-#define __NR_io_pgetevents_time64 (__NR_SYSCALL_BASE + 416)
-#define __NR_recvmmsg_time64 (__NR_SYSCALL_BASE + 417)
-#define __NR_mq_timedsend_time64 (__NR_SYSCALL_BASE + 418)
-#define __NR_mq_timedreceive_time64 (__NR_SYSCALL_BASE + 419)
-#define __NR_semtimedop_time64 (__NR_SYSCALL_BASE + 420)
-#define __NR_rt_sigtimedwait_time64 (__NR_SYSCALL_BASE + 421)
-#define __NR_futex_time64 (__NR_SYSCALL_BASE + 422)
-#define __NR_sched_rr_get_interval_time64 (__NR_SYSCALL_BASE + 423)
-#define __NR_pidfd_send_signal (__NR_SYSCALL_BASE + 424)
-#define __NR_io_uring_setup (__NR_SYSCALL_BASE + 425)
-#define __NR_io_uring_enter (__NR_SYSCALL_BASE + 426)
-#define __NR_io_uring_register (__NR_SYSCALL_BASE + 427)
-#define __NR_open_tree (__NR_SYSCALL_BASE + 428)
-#define __NR_move_mount (__NR_SYSCALL_BASE + 429)
-#define __NR_fsopen (__NR_SYSCALL_BASE + 430)
-#define __NR_fsconfig (__NR_SYSCALL_BASE + 431)
-#define __NR_fsmount (__NR_SYSCALL_BASE + 432)
-#define __NR_fspick (__NR_SYSCALL_BASE + 433)
-#define __NR_pidfd_open (__NR_SYSCALL_BASE + 434)
-#define __NR_clone3 (__NR_SYSCALL_BASE + 435)
-#define __NR_openat2 (__NR_SYSCALL_BASE + 437)
-#define __NR_pidfd_getfd (__NR_SYSCALL_BASE + 438)
-#define __NR_faccessat2 (__NR_SYSCALL_BASE + 439)
-
-#endif /* _ASM_ARM_UNISTD_COMMON_H */
diff --git a/linux-headers/asm-arm/unistd-eabi.h b/linux-headers/asm-arm/unistd-eabi.h
deleted file mode 100644
index 266f1fcdfb3..00000000000
--- a/linux-headers/asm-arm/unistd-eabi.h
+++ /dev/null
@@ -1,5 +0,0 @@
-#ifndef _ASM_ARM_UNISTD_EABI_H
-#define _ASM_ARM_UNISTD_EABI_H 1
-
-
-#endif /* _ASM_ARM_UNISTD_EABI_H */
diff --git a/linux-headers/asm-arm/unistd-oabi.h b/linux-headers/asm-arm/unistd-oabi.h
deleted file mode 100644
index 47d9afb96d5..00000000000
--- a/linux-headers/asm-arm/unistd-oabi.h
+++ /dev/null
@@ -1,17 +0,0 @@
-#ifndef _ASM_ARM_UNISTD_OABI_H
-#define _ASM_ARM_UNISTD_OABI_H 1
-
-#define __NR_time (__NR_SYSCALL_BASE + 13)
-#define __NR_umount (__NR_SYSCALL_BASE + 22)
-#define __NR_stime (__NR_SYSCALL_BASE + 25)
-#define __NR_alarm (__NR_SYSCALL_BASE + 27)
-#define __NR_utime (__NR_SYSCALL_BASE + 30)
-#define __NR_getrlimit (__NR_SYSCALL_BASE + 76)
-#define __NR_select (__NR_SYSCALL_BASE + 82)
-#define __NR_readdir (__NR_SYSCALL_BASE + 89)
-#define __NR_mmap (__NR_SYSCALL_BASE + 90)
-#define __NR_socketcall (__NR_SYSCALL_BASE + 102)
-#define __NR_syscall (__NR_SYSCALL_BASE + 113)
-#define __NR_ipc (__NR_SYSCALL_BASE + 117)
-
-#endif /* _ASM_ARM_UNISTD_OABI_H */
diff --git a/linux-headers/asm-arm/unistd.h b/linux-headers/asm-arm/unistd.h
deleted file mode 100644
index 18b0825885e..00000000000
--- a/linux-headers/asm-arm/unistd.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- *  arch/arm/include/asm/unistd.h
- *
- *  Copyright (C) 2001-2005 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Please forward _all_ changes to this file to rmk@arm.linux.org.uk,
- * no matter what the change is.  Thanks!
- */
-#ifndef __ASM_ARM_UNISTD_H
-#define __ASM_ARM_UNISTD_H
-
-#define __NR_OABI_SYSCALL_BASE	0x900000
-
-#if defined(__thumb__) || defined(__ARM_EABI__)
-#define __NR_SYSCALL_BASE	0
-#include <asm/unistd-eabi.h>
-#else
-#define __NR_SYSCALL_BASE	__NR_OABI_SYSCALL_BASE
-#include <asm/unistd-oabi.h>
-#endif
-
-#include <asm/unistd-common.h>
-#define __NR_sync_file_range2		__NR_arm_sync_file_range
-
-/*
- * The following SWIs are ARM private.
- */
-#define __ARM_NR_BASE			(__NR_SYSCALL_BASE+0x0f0000)
-#define __ARM_NR_breakpoint		(__ARM_NR_BASE+1)
-#define __ARM_NR_cacheflush		(__ARM_NR_BASE+2)
-#define __ARM_NR_usr26			(__ARM_NR_BASE+3)
-#define __ARM_NR_usr32			(__ARM_NR_BASE+4)
-#define __ARM_NR_set_tls		(__ARM_NR_BASE+5)
-#define __ARM_NR_get_tls		(__ARM_NR_BASE+6)
-
-#endif /* __ASM_ARM_UNISTD_H */
diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index b43b8ef75a6..717c379f9e0 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -156,11 +156,6 @@ EOF
         cp "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-s390/"
         cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-s390/"
     fi
-    if [ $arch = arm ]; then
-        cp "$hdrdir/include/asm/unistd-eabi.h" "$output/linux-headers/asm-arm/"
-        cp "$hdrdir/include/asm/unistd-oabi.h" "$output/linux-headers/asm-arm/"
-        cp "$hdrdir/include/asm/unistd-common.h" "$output/linux-headers/asm-arm/"
-    fi
     if [ $arch = arm64 ]; then
         cp "$hdrdir/include/asm/sve_context.h" "$output/linux-headers/asm-arm64/"
         cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-arm64/"
-- 
2.50.0


