Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36892CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYsc-0000cH-IV; Tue, 16 Sep 2025 12:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uyYsM-0000Hx-J1
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:49:54 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uyYsI-0006TF-V0
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:49:53 -0400
Received: from localhost.localdomain (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 4EDF1201551E;
 Tue, 16 Sep 2025 09:49:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4EDF1201551E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1758041389;
 bh=sQoJ+yAE82XMq3pvjpHy4uGFa1HPK03qIx/3yJBt43A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NbW0ADXkSaLHK0NrpZY0o8wIrAWubQlOWKRu112xFxknOGjdOc6BTpr4CM4htSF3f
 5tXKj4JegXcGjrFvGJnT5pGpTlpJo5hvjN5HjN3RDO0mxuiKYEIWE/GrNrclyTpP6Q
 BwwqFHSMrl4mgaXTmAJcrb02L14EAqZzQQjCtshU=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 06/27] linux-headers/linux: Add mshv.h headers
Date: Tue, 16 Sep 2025 18:48:26 +0200
Message-Id: <20250916164847.77883-7-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

This file has been added to the tree by running `update-linux-header.sh`
on linux v6.16.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 linux-headers/linux/mshv.h | 291 +++++++++++++++++++++++++++++++++++++
 1 file changed, 291 insertions(+)
 create mode 100644 linux-headers/linux/mshv.h

diff --git a/linux-headers/linux/mshv.h b/linux-headers/linux/mshv.h
new file mode 100644
index 0000000000..5bc83db6a3
--- /dev/null
+++ b/linux-headers/linux/mshv.h
@@ -0,0 +1,291 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace interfaces for /dev/mshv* devices and derived fds
+ *
+ * This file is divided into sections containing data structures and IOCTLs for
+ * a particular set of related devices or derived file descriptors.
+ *
+ * The IOCTL definitions are at the end of each section. They are grouped by
+ * device/fd, so that new IOCTLs can easily be added with a monotonically
+ * increasing number.
+ */
+#ifndef _LINUX_MSHV_H
+#define _LINUX_MSHV_H
+
+#include <linux/types.h>
+
+#define MSHV_IOCTL	0xB8
+
+/*
+ *******************************************
+ * Entry point to main VMM APIs: /dev/mshv *
+ *******************************************
+ */
+
+enum {
+	MSHV_PT_BIT_LAPIC,
+	MSHV_PT_BIT_X2APIC,
+	MSHV_PT_BIT_GPA_SUPER_PAGES,
+	MSHV_PT_BIT_COUNT,
+};
+
+#define MSHV_PT_FLAGS_MASK ((1 << MSHV_PT_BIT_COUNT) - 1)
+
+enum {
+	MSHV_PT_ISOLATION_NONE,
+	MSHV_PT_ISOLATION_COUNT,
+};
+
+/**
+ * struct mshv_create_partition - arguments for MSHV_CREATE_PARTITION
+ * @pt_flags: Bitmask of 1 << MSHV_PT_BIT_*
+ * @pt_isolation: MSHV_PT_ISOLATION_*
+ *
+ * Returns a file descriptor to act as a handle to a guest partition.
+ * At this point the partition is not yet initialized in the hypervisor.
+ * Some operations must be done with the partition in this state, e.g. setting
+ * so-called "early" partition properties. The partition can then be
+ * initialized with MSHV_INITIALIZE_PARTITION.
+ */
+struct mshv_create_partition {
+	__u64 pt_flags;
+	__u64 pt_isolation;
+};
+
+/* /dev/mshv */
+#define MSHV_CREATE_PARTITION	_IOW(MSHV_IOCTL, 0x00, struct mshv_create_partition)
+
+/*
+ ************************
+ * Child partition APIs *
+ ************************
+ */
+
+struct mshv_create_vp {
+	__u32 vp_index;
+};
+
+enum {
+	MSHV_SET_MEM_BIT_WRITABLE,
+	MSHV_SET_MEM_BIT_EXECUTABLE,
+	MSHV_SET_MEM_BIT_UNMAP,
+	MSHV_SET_MEM_BIT_COUNT
+};
+
+#define MSHV_SET_MEM_FLAGS_MASK ((1 << MSHV_SET_MEM_BIT_COUNT) - 1)
+
+/* The hypervisor's "native" page size */
+#define MSHV_HV_PAGE_SIZE	0x1000
+
+/**
+ * struct mshv_user_mem_region - arguments for MSHV_SET_GUEST_MEMORY
+ * @size: Size of the memory region (bytes). Must be aligned to
+ *        MSHV_HV_PAGE_SIZE
+ * @guest_pfn: Base guest page number to map
+ * @userspace_addr: Base address of userspace memory. Must be aligned to
+ *                  MSHV_HV_PAGE_SIZE
+ * @flags: Bitmask of 1 << MSHV_SET_MEM_BIT_*. If (1 << MSHV_SET_MEM_BIT_UNMAP)
+ *         is set, ignore other bits.
+ * @rsvd: MBZ
+ *
+ * Map or unmap a region of userspace memory to Guest Physical Addresses (GPA).
+ * Mappings can't overlap in GPA space or userspace.
+ * To unmap, these fields must match an existing mapping.
+ */
+struct mshv_user_mem_region {
+	__u64 size;
+	__u64 guest_pfn;
+	__u64 userspace_addr;
+	__u8 flags;
+	__u8 rsvd[7];
+};
+
+enum {
+	MSHV_IRQFD_BIT_DEASSIGN,
+	MSHV_IRQFD_BIT_RESAMPLE,
+	MSHV_IRQFD_BIT_COUNT,
+};
+
+#define MSHV_IRQFD_FLAGS_MASK	((1 << MSHV_IRQFD_BIT_COUNT) - 1)
+
+struct mshv_user_irqfd {
+	__s32 fd;
+	__s32 resamplefd;
+	__u32 gsi;
+	__u32 flags;
+};
+
+enum {
+	MSHV_IOEVENTFD_BIT_DATAMATCH,
+	MSHV_IOEVENTFD_BIT_PIO,
+	MSHV_IOEVENTFD_BIT_DEASSIGN,
+	MSHV_IOEVENTFD_BIT_COUNT,
+};
+
+#define MSHV_IOEVENTFD_FLAGS_MASK	((1 << MSHV_IOEVENTFD_BIT_COUNT) - 1)
+
+struct mshv_user_ioeventfd {
+	__u64 datamatch;
+	__u64 addr;	   /* legal pio/mmio address */
+	__u32 len;	   /* 1, 2, 4, or 8 bytes    */
+	__s32 fd;
+	__u32 flags;
+	__u8  rsvd[4];
+};
+
+struct mshv_user_irq_entry {
+	__u32 gsi;
+	__u32 address_lo;
+	__u32 address_hi;
+	__u32 data;
+};
+
+struct mshv_user_irq_table {
+	__u32 nr;
+	__u32 rsvd; /* MBZ */
+	struct mshv_user_irq_entry entries[];
+};
+
+enum {
+	MSHV_GPAP_ACCESS_TYPE_ACCESSED,
+	MSHV_GPAP_ACCESS_TYPE_DIRTY,
+	MSHV_GPAP_ACCESS_TYPE_COUNT		/* Count of enum members */
+};
+
+enum {
+	MSHV_GPAP_ACCESS_OP_NOOP,
+	MSHV_GPAP_ACCESS_OP_CLEAR,
+	MSHV_GPAP_ACCESS_OP_SET,
+	MSHV_GPAP_ACCESS_OP_COUNT		/* Count of enum members */
+};
+
+/**
+ * struct mshv_gpap_access_bitmap - arguments for MSHV_GET_GPAP_ACCESS_BITMAP
+ * @access_type: MSHV_GPAP_ACCESS_TYPE_* - The type of access to record in the
+ *               bitmap
+ * @access_op: MSHV_GPAP_ACCESS_OP_* - Allows an optional clear or set of all
+ *             the access states in the range, after retrieving the current
+ *             states.
+ * @rsvd: MBZ
+ * @page_count: Number of pages
+ * @gpap_base: Base gpa page number
+ * @bitmap_ptr: Output buffer for bitmap, at least (page_count + 7) / 8 bytes
+ *
+ * Retrieve a bitmap of either ACCESSED or DIRTY bits for a given range of guest
+ * memory, and optionally clear or set the bits.
+ */
+struct mshv_gpap_access_bitmap {
+	__u8 access_type;
+	__u8 access_op;
+	__u8 rsvd[6];
+	__u64 page_count;
+	__u64 gpap_base;
+	__u64 bitmap_ptr;
+};
+
+/**
+ * struct mshv_root_hvcall - arguments for MSHV_ROOT_HVCALL
+ * @code: Hypercall code (HVCALL_*)
+ * @reps: in: Rep count ('repcount')
+ *	  out: Reps completed ('repcomp'). MBZ unless rep hvcall
+ * @in_sz: Size of input incl rep data. <= MSHV_HV_PAGE_SIZE
+ * @out_sz: Size of output buffer. <= MSHV_HV_PAGE_SIZE. MBZ if out_ptr is 0
+ * @status: in: MBZ
+ *	    out: HV_STATUS_* from hypercall
+ * @rsvd: MBZ
+ * @in_ptr: Input data buffer (struct hv_input_*). If used with partition or
+ *	    vp fd, partition id field is populated by kernel.
+ * @out_ptr: Output data buffer (optional)
+ */
+struct mshv_root_hvcall {
+	__u16 code;
+	__u16 reps;
+	__u16 in_sz;
+	__u16 out_sz;
+	__u16 status;
+	__u8 rsvd[6];
+	__u64 in_ptr;
+	__u64 out_ptr;
+};
+
+/* Partition fds created with MSHV_CREATE_PARTITION */
+#define MSHV_INITIALIZE_PARTITION	_IO(MSHV_IOCTL, 0x00)
+#define MSHV_CREATE_VP			_IOW(MSHV_IOCTL, 0x01, struct mshv_create_vp)
+#define MSHV_SET_GUEST_MEMORY		_IOW(MSHV_IOCTL, 0x02, struct mshv_user_mem_region)
+#define MSHV_IRQFD			_IOW(MSHV_IOCTL, 0x03, struct mshv_user_irqfd)
+#define MSHV_IOEVENTFD			_IOW(MSHV_IOCTL, 0x04, struct mshv_user_ioeventfd)
+#define MSHV_SET_MSI_ROUTING		_IOW(MSHV_IOCTL, 0x05, struct mshv_user_irq_table)
+#define MSHV_GET_GPAP_ACCESS_BITMAP	_IOWR(MSHV_IOCTL, 0x06, struct mshv_gpap_access_bitmap)
+/* Generic hypercall */
+#define MSHV_ROOT_HVCALL		_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcall)
+
+/*
+ ********************************
+ * VP APIs for child partitions *
+ ********************************
+ */
+
+#define MSHV_RUN_VP_BUF_SZ 256
+
+/*
+ * VP state pages may be mapped to userspace via mmap().
+ * To specify which state page, use MSHV_VP_MMAP_OFFSET_ values multiplied by
+ * the system page size.
+ * e.g.
+ * long page_size = sysconf(_SC_PAGE_SIZE);
+ * void *reg_page = mmap(NULL, MSHV_HV_PAGE_SIZE, PROT_READ|PROT_WRITE,
+ *                       MAP_SHARED, vp_fd,
+ *                       MSHV_VP_MMAP_OFFSET_REGISTERS * page_size);
+ */
+enum {
+	MSHV_VP_MMAP_OFFSET_REGISTERS,
+	MSHV_VP_MMAP_OFFSET_INTERCEPT_MESSAGE,
+	MSHV_VP_MMAP_OFFSET_GHCB,
+	MSHV_VP_MMAP_OFFSET_COUNT
+};
+
+/**
+ * struct mshv_run_vp - argument for MSHV_RUN_VP
+ * @msg_buf: On success, the intercept message is copied here. It can be
+ *           interpreted using the relevant hypervisor definitions.
+ */
+struct mshv_run_vp {
+	__u8 msg_buf[MSHV_RUN_VP_BUF_SZ];
+};
+
+enum {
+	MSHV_VP_STATE_LAPIC,		/* Local interrupt controller state (either arch) */
+	MSHV_VP_STATE_XSAVE,		/* XSAVE data in compacted form (x86_64) */
+	MSHV_VP_STATE_SIMP,
+	MSHV_VP_STATE_SIEFP,
+	MSHV_VP_STATE_SYNTHETIC_TIMERS,
+	MSHV_VP_STATE_COUNT,
+};
+
+/**
+ * struct mshv_get_set_vp_state - arguments for MSHV_[GET,SET]_VP_STATE
+ * @type: MSHV_VP_STATE_*
+ * @rsvd: MBZ
+ * @buf_sz: in: 4k page-aligned size of buffer
+ *          out: Actual size of data (on EINVAL, check this to see if buffer
+ *               was too small)
+ * @buf_ptr: 4k page-aligned data buffer
+ */
+struct mshv_get_set_vp_state {
+	__u8 type;
+	__u8 rsvd[3];
+	__u32 buf_sz;
+	__u64 buf_ptr;
+};
+
+/* VP fds created with MSHV_CREATE_VP */
+#define MSHV_RUN_VP			_IOR(MSHV_IOCTL, 0x00, struct mshv_run_vp)
+#define MSHV_GET_VP_STATE		_IOWR(MSHV_IOCTL, 0x01, struct mshv_get_set_vp_state)
+#define MSHV_SET_VP_STATE		_IOWR(MSHV_IOCTL, 0x02, struct mshv_get_set_vp_state)
+/*
+ * Generic hypercall
+ * Defined above in partition IOCTLs, avoid redefining it here
+ * #define MSHV_ROOT_HVCALL			_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcall)
+ */
+
+#endif
-- 
2.34.1


