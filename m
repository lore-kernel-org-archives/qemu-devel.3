Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001E9C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 14:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7cBs-0004Os-Vr; Thu, 16 May 2024 10:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1s7cBp-0004Kp-Hb; Thu, 16 May 2024 10:34:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_svaddagi@quicinc.com>)
 id 1s7cBm-0008Li-PO; Thu, 16 May 2024 10:34:37 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44GBLF5S008886;
 Thu, 16 May 2024 14:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=SnPAwMXXVZYe7Q+nI/EdBVzc4Z9dngQFeu9fGBE3f4Q=; b=Ji
 I9qA6CrckW0FsOPvEAz+0XgqT7owu8VBNjiecXI4fuhNleQARGGfBR23D0FEoxtN
 o7ghWeQnGHrZqPs4vdlQiNEluoInNa3i3ue6+eBIU7FAGaL/CCEK+jla6TXXZu9G
 55IkwTngzz4RIKX1zg6tUnMgyZ2SbX89JpuF35n+yJBch2KsVK2KdT3hZhKwRafI
 eKTPRQreQxPuH3iF7txCOe75ySGWHVSumsryp/eAs7GE563hvlzoBRkS9er1zEfq
 pBgTarabQWXe+Kjy7mCPSelUpGLqFMKYcVQjPyzurLm6f4ocHecamwhv7TJ90gOo
 kd931JgbXC36YcW+95tQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y3x51pwwj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 14:34:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44GEYDAU009227
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 May 2024 14:34:13 GMT
Received: from blr-ubuntu-31.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 16 May 2024 07:34:08 -0700
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: <peter.maydell@linaro.org>, <philmd@linaro.org>, <alex.bennee@linaro.org>, 
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <quic_svaddagi@quicinc.com>, <quic_tsoni@quicinc.com>,
 <quic_pheragu@quicinc.com>, <quic_eberman@quicinc.com>,
 <quic_yvasi@quicinc.com>, <quic_cvanscha@quicinc.com>,
 <quic_mnalajal@quicinc.com>
Subject: [RFC/PATCH v2 01/12] gunyah: UAPI header (NOT FOR MERGE)
Date: Thu, 16 May 2024 14:33:45 +0000
Message-ID: <20240516143356.1739402-2-quic_svaddagi@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240516143356.1739402-1-quic_svaddagi@quicinc.com>
References: <20240516143356.1739402-1-quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: d6aqF8afrE9RVLSG9NZbh0xMyi-iaP5K
X-Proofpoint-ORIG-GUID: d6aqF8afrE9RVLSG9NZbh0xMyi-iaP5K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 impostorscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405160103
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=quic_svaddagi@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Gunyah UAPI header file is provided for ease of use, until Gunyah kernel
driver is merged upstream. scripts/update-linux-headers.sh will be
updated via a separate patch after that for Qemu to pick up gunyah.h
UAPI header from Linux kernel sources.

This header file is based on the Gunyah driver present in Android-14.

https://android.googlesource.com/kernel/common
Branch: android14-6.1

Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
---
 linux-headers/linux/gunyah.h | 311 +++++++++++++++++++++++++++++++++++
 1 file changed, 311 insertions(+)
 create mode 100644 linux-headers/linux/gunyah.h

diff --git a/linux-headers/linux/gunyah.h b/linux-headers/linux/gunyah.h
new file mode 100644
index 0000000000..c8d250a834
--- /dev/null
+++ b/linux-headers/linux/gunyah.h
@@ -0,0 +1,311 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _LINUX_GUNYAH_H
+#define _LINUX_GUNYAH_H
+
+/*
+ * Userspace interface for /dev/gunyah - gunyah based virtual machine
+ */
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define GH_IOCTL_TYPE			'G'
+
+/*
+ * ioctls for /dev/gunyah fds:
+ */
+#define GH_CREATE_VM			_IO(GH_IOCTL_TYPE, 0x0) /* Returns a Gunyah VM fd */
+
+/*
+ * ioctls for VM fds
+ */
+
+/**
+ * enum gh_mem_flags - Possible flags on &struct gh_userspace_memory_region
+ * @GH_MEM_ALLOW_READ: Allow guest to read the memory
+ * @GH_MEM_ALLOW_WRITE: Allow guest to write to the memory
+ * @GH_MEM_ALLOW_EXEC: Allow guest to execute instructions in the memory
+ */
+enum gh_mem_flags {
+	GH_MEM_ALLOW_READ	= 1UL << 0,
+	GH_MEM_ALLOW_WRITE	= 1UL << 1,
+	GH_MEM_ALLOW_EXEC	= 1UL << 2,
+};
+
+/**
+ * struct gh_userspace_memory_region - Userspace memory descripion for GH_VM_SET_USER_MEM_REGION
+ * @label: Identifer to the region which is unique to the VM.
+ * @flags: Flags for memory parcel behavior. See &enum gh_mem_flags.
+ * @guest_phys_addr: Location of the memory region in guest's memory space (page-aligned)
+ * @memory_size: Size of the region (page-aligned)
+ * @userspace_addr: Location of the memory region in caller (userspace)'s memory
+ *
+ * See Documentation/virt/gunyah/vm-manager.rst for further details.
+ */
+struct gh_userspace_memory_region {
+	__u32 label;
+	__u32 flags;
+	__u64 guest_phys_addr;
+	__u64 memory_size;
+	__u64 userspace_addr;
+};
+
+#define GH_VM_SET_USER_MEM_REGION	_IOW(GH_IOCTL_TYPE, 0x1, \
+						struct gh_userspace_memory_region)
+
+/**
+ * struct gh_vm_dtb_config - Set the location of the VM's devicetree blob
+ * @guest_phys_addr: Address of the VM's devicetree in guest memory.
+ * @size: Maximum size of the devicetree including space for overlays.
+ *        Resource manager applies an overlay to the DTB and dtb_size should
+ *        include room for the overlay. A page of memory is typicaly plenty.
+ */
+struct gh_vm_dtb_config {
+	__u64 guest_phys_addr;
+	__u64 size;
+};
+#define GH_VM_SET_DTB_CONFIG	_IOW(GH_IOCTL_TYPE, 0x2, struct gh_vm_dtb_config)
+
+#define GH_VM_START		_IO(GH_IOCTL_TYPE, 0x3)
+
+/**
+ * enum gh_fn_type - Valid types of Gunyah VM functions
+ * @GH_FN_VCPU: create a vCPU instance to control a vCPU
+ *              &struct gh_fn_desc.arg is a pointer to &struct gh_fn_vcpu_arg
+ *              Return: file descriptor to manipulate the vcpu.
+ * @GH_FN_IRQFD: register eventfd to assert a Gunyah doorbell
+ *               &struct gh_fn_desc.arg is a pointer to &struct gh_fn_irqfd_arg
+ * @GH_FN_IOEVENTFD: register ioeventfd to trigger when VM faults on parameter
+ *                   &struct gh_fn_desc.arg is a pointer to &struct gh_fn_ioeventfd_arg
+ */
+enum gh_fn_type {
+	GH_FN_VCPU = 1,
+	GH_FN_IRQFD,
+	GH_FN_IOEVENTFD,
+};
+
+#define GH_FN_MAX_ARG_SIZE		256
+
+/**
+ * struct gh_fn_vcpu_arg - Arguments to create a vCPU.
+ * @id: vcpu id
+ *
+ * Create this function with &GH_VM_ADD_FUNCTION using type &GH_FN_VCPU.
+ *
+ * The vcpu type will register with the VM Manager to expect to control
+ * vCPU number `vcpu_id`. It returns a file descriptor allowing interaction with
+ * the vCPU. See the Gunyah vCPU API description sections for interacting with
+ * the Gunyah vCPU file descriptors.
+ */
+struct gh_fn_vcpu_arg {
+	__u32 id;
+};
+
+/**
+ * enum gh_irqfd_flags - flags for use in gh_fn_irqfd_arg
+ * @GH_IRQFD_FLAGS_LEVEL: make the interrupt operate like a level triggered
+ *                        interrupt on guest side. Triggering IRQFD before
+ *                        guest handles the interrupt causes interrupt to
+ *                        stay asserted.
+ */
+enum gh_irqfd_flags {
+	GH_IRQFD_FLAGS_LEVEL		= 1UL << 0,
+};
+
+/**
+ * struct gh_fn_irqfd_arg - Arguments to create an irqfd function.
+ *
+ * Create this function with &GH_VM_ADD_FUNCTION using type &GH_FN_IRQFD.
+ *
+ * Allows setting an eventfd to directly trigger a guest interrupt.
+ * irqfd.fd specifies the file descriptor to use as the eventfd.
+ * irqfd.label corresponds to the doorbell label used in the guest VM's devicetree.
+ *
+ * @fd: an eventfd which when written to will raise a doorbell
+ * @label: Label of the doorbell created on the guest VM
+ * @flags: see &enum gh_irqfd_flags
+ * @padding: padding bytes
+ */
+struct gh_fn_irqfd_arg {
+	__u32 fd;
+	__u32 label;
+	__u32 flags;
+	__u32 padding;
+};
+
+/**
+ * enum gh_ioeventfd_flags - flags for use in gh_fn_ioeventfd_arg
+ * @GH_IOEVENTFD_FLAGS_DATAMATCH: the event will be signaled only if the
+ *                                written value to the registered address is
+ *                                equal to &struct gh_fn_ioeventfd_arg.datamatch
+ */
+enum gh_ioeventfd_flags {
+	GH_IOEVENTFD_FLAGS_DATAMATCH	= 1UL << 0,
+};
+
+/**
+ * struct gh_fn_ioeventfd_arg - Arguments to create an ioeventfd function
+ * @datamatch: data used when GH_IOEVENTFD_DATAMATCH is set
+ * @addr: Address in guest memory
+ * @len: Length of access
+ * @fd: When ioeventfd is matched, this eventfd is written
+ * @flags: See &enum gh_ioeventfd_flags
+ * @padding: padding bytes
+ *
+ * Create this function with &GH_VM_ADD_FUNCTION using type &GH_FN_IOEVENTFD.
+ *
+ * Attaches an ioeventfd to a legal mmio address within the guest. A guest write
+ * in the registered address will signal the provided event instead of triggering
+ * an exit on the GH_VCPU_RUN ioctl.
+ */
+struct gh_fn_ioeventfd_arg {
+	__u64 datamatch;
+	__u64 addr;        /* legal mmio address */
+	__u32 len;         /* 1, 2, 4, or 8 bytes; or 0 to ignore length */
+	__s32 fd;
+	__u32 flags;
+	__u32 padding;
+};
+
+/**
+ * struct gh_fn_desc - Arguments to create a VM function
+ * @type: Type of the function. See &enum gh_fn_type.
+ * @arg_size: Size of argument to pass to the function. arg_size <= GH_FN_MAX_ARG_SIZE
+ * @arg: Pointer to argument given to the function. See &enum gh_fn_type for expected
+ *       arguments for a function type.
+ */
+struct gh_fn_desc {
+	__u32 type;
+	__u32 arg_size;
+	__u64 arg;
+};
+
+#define GH_VM_ADD_FUNCTION	_IOW(GH_IOCTL_TYPE, 0x4, struct gh_fn_desc)
+#define GH_VM_REMOVE_FUNCTION	_IOW(GH_IOCTL_TYPE, 0x7, struct gh_fn_desc)
+
+/*
+ * ioctls for vCPU fds
+ */
+
+/**
+ * enum gh_vm_status - Stores status reason why VM is not runnable (exited).
+ * @GH_VM_STATUS_LOAD_FAILED: VM didn't start because it couldn't be loaded.
+ * @GH_VM_STATUS_EXITED: VM requested shutdown/reboot.
+ *                       Use &struct gh_vm_exit_info.reason for further details.
+ * @GH_VM_STATUS_CRASHED: VM state is unknown and has crashed.
+ */
+enum gh_vm_status {
+	GH_VM_STATUS_LOAD_FAILED	= 1,
+	GH_VM_STATUS_EXITED		= 2,
+	GH_VM_STATUS_CRASHED		= 3,
+};
+
+/*
+ * Gunyah presently sends max 4 bytes of exit_reason.
+ * If that changes, this macro can be safely increased without breaking
+ * userspace so long as struct gh_vcpu_run < PAGE_SIZE.
+ */
+#define GH_VM_MAX_EXIT_REASON_SIZE	8u
+
+/**
+ * struct gh_vm_exit_info - Reason for VM exit as reported by Gunyah
+ * See Gunyah documentation for values.
+ * @type: Describes how VM exited
+ * @padding: padding bytes
+ * @reason_size: Number of bytes valid for `reason`
+ * @reason: See Gunyah documentation for interpretation. Note: these values are
+ *          not interpreted by Linux and need to be converted from little-endian
+ *          as applicable.
+ */
+struct gh_vm_exit_info {
+	__u16 type;
+	__u16 padding;
+	__u32 reason_size;
+	__u8 reason[GH_VM_MAX_EXIT_REASON_SIZE];
+};
+
+/**
+ * enum gh_vcpu_exit - Stores reason why &GH_VCPU_RUN ioctl recently exited with status 0
+ * @GH_VCPU_EXIT_UNKNOWN: Not used, status != 0
+ * @GH_VCPU_EXIT_MMIO: vCPU performed a read or write that could not be handled
+ *                     by hypervisor or Linux. Use @struct gh_vcpu_run.mmio for
+ *                     details of the read/write.
+ * @GH_VCPU_EXIT_STATUS: vCPU not able to run because the VM has exited.
+ *                       Use @struct gh_vcpu_run.status for why VM has exited.
+ */
+enum gh_vcpu_exit {
+	GH_VCPU_EXIT_UNKNOWN,
+	GH_VCPU_EXIT_MMIO,
+	GH_VCPU_EXIT_STATUS,
+};
+
+/**
+ * struct gh_vcpu_run - Application code obtains a pointer to the gh_vcpu_run
+ *                      structure by mmap()ing a vcpu fd.
+ * @immediate_exit: polled when scheduling the vcpu. If set, immediately returns -EINTR.
+ * @padding: padding bytes
+ * @exit_reason: Set when GH_VCPU_RUN returns successfully and gives reason why
+ *               GH_VCPU_RUN has stopped running the vCPU. See &enum gh_vcpu_exit.
+ * @mmio: Used when exit_reason == GH_VCPU_EXIT_MMIO
+ *        The guest has faulted on an memory-mapped I/O instruction that
+ *        couldn't be satisfied by gunyah.
+ * @mmio.phys_addr: Address guest tried to access
+ * @mmio.data: the value that was written if `is_write == 1`. Filled by
+ *        user for reads (`is_write == 0`).
+ * @mmio.len: Length of write. Only the first `len` bytes of `data`
+ *       are considered by Gunyah.
+ * @mmio.is_write: 1 if VM tried to perform a write, 0 for a read
+ * @status: Used when exit_reason == GH_VCPU_EXIT_STATUS.
+ *          The guest VM is no longer runnable. This struct informs why.
+ * @status.status: See &enum gh_vm_status for possible values
+ * @status.exit_info: Used when status == GH_VM_STATUS_EXITED
+ */
+struct gh_vcpu_run {
+	/* in */
+	__u8 immediate_exit;
+	__u8 padding[7];
+
+	/* out */
+	__u32 exit_reason;
+
+	union {
+		struct {
+			__u64 phys_addr;
+			__u8  data[8];
+			__u32 len;
+			__u8  is_write;
+		} mmio;
+
+		struct {
+			enum gh_vm_status status;
+			struct gh_vm_exit_info exit_info;
+		} status;
+	};
+};
+
+#define GH_VCPU_RUN		_IO(GH_IOCTL_TYPE, 0x5)
+#define GH_VCPU_MMAP_SIZE	_IO(GH_IOCTL_TYPE, 0x6)
+
+/**
+ * ANDROID: android14-6.1 unfortunately contains UAPI that won't be carried
+ * in kernel.org. Expose orthogonal ioctls that will never conflict with
+ * kernel.org for these UAPIs. See b/268234781.
+ */
+#define GH_ANDROID_IOCTL_TYPE		'A'
+
+#define GH_VM_ANDROID_LEND_USER_MEM	_IOW(GH_ANDROID_IOCTL_TYPE, 0x11, \
+						struct gh_userspace_memory_region)
+
+struct gh_vm_firmware_config {
+	__u64 guest_phys_addr;
+	__u64 size;
+};
+
+#define GH_VM_ANDROID_SET_FW_CONFIG	_IOW(GH_ANDROID_IOCTL_TYPE, 0x12, \
+						struct gh_vm_firmware_config)
+
+#endif
-- 
2.25.1


