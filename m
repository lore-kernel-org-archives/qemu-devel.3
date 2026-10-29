Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B8C606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMJ0T-0007U3-5K; Thu, 29 Oct 2026 01:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xMIzn-00074H-H2; Thu, 29 Oct 2026 01:48:17 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xMIzj-0000dI-1a; Thu, 29 Oct 2026 01:48:15 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jFYDG6KGQz8XrrX;
 Thu, 29 Oct 2026 13:47:58 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl1.zte.com.cn with SMTP id 69T5lpwY079235;
 Thu, 29 Oct 2026 13:47:51 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Thu, 29 Oct 2026 13:47:53 +0800
X-Zmail-TransId: 3e816ae2de08027-e631f
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Wu Fei <wu.fei9@sanechips.com.cn>,
 Qingye Zhao <zhao.qingye@sanechips.com.cn>,
 Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH v2 01/14] linux-headers: Update iommufd.h header for
 RISC-V IOMMU nested translation
Date: Thu, 29 Oct 2026 13:47:38 +0800
Message-ID: <20261029054751.563493-2-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029054751.563493-1-gong.shuai@sanechips.com.cn>
References: <20261029054751.563493-1-gong.shuai@sanechips.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl1.zte.com.cn 69T5lpwY079235
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 29 Oct 2026 13:47:58 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE2DE0E.000/4jFYDG6KGQz8XrrX
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=gong.shuai@sanechips.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the RISC-V IOMMU UAPI needed by the accelerated IOMMU device.

Only the RISC-V IOMMU definitions of iommufd.h are taken, instead of
doing a full scripts/update-linux-headers.sh sync that would also pull
in unrelated changes.

The kernel UAPI this is taken from is not upstream yet, so this import
is a placeholder and will be replaced by a regular linux-headers sync
once the kernel patches are merged.

Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 linux-headers/linux/iommufd.h | 81 +++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/linux-headers/linux/iommufd.h b/linux-headers/linux/iommufd.h
index 3c61caadbf..4a39da3271 100644
--- a/linux-headers/linux/iommufd.h
+++ b/linux-headers/linux/iommufd.h
@@ -506,18 +506,46 @@ struct iommu_hwpt_amd_guest {
 	__aligned_u64 dte[4];
 };
 
+/**
+ * struct iommu_hwpt_riscv - RISC-V IOMMU stage-1 page table data
+ *			     (IOMMU_HWPT_DATA_RISCV_S1)
+ *
+ * @dc: The guest device-context (DC) in the base format defined in
+ *      "Leaf DDT entry" of the RISC-V IOMMU Architecture Specification,
+ *      refer to "Device-context fields" for the meaning of each
+ *      doubleword. Only the guest-owned doublewords are validated:
+ *      - dc[0] (tc): Allowed bits are V, EN_ATS, EN_PRI, T2GPA, DTF,
+ *        PRPR, SADE and SBE. GADE is owned by the host and the value
+ *        here is ignored. PDTV, DPE and SXL are not supported and must
+ *        be 0.
+ *      - dc[3] (fsc): Carries iosatp when tc.PDTV=0, allowed fields
+ *        are MODE (Bare, Sv39, Sv48, Sv57) and PPN; Carries pdtp when
+ *        tc.PDTV=1, which not supported now.
+ *
+ *      The host-owned doublewords dc[1] (iohgatp) and dc[2] (ta) are
+ *      ignored. iohgatp is installed by the kernel from the nesting
+ *      parent at attach time and ta is managed by the host. The
+ *      extended-format MSI doublewords are configured by the host for
+ *      interrupt remapping and are not passed via this structure.
+ */
+struct iommu_hwpt_riscv {
+	__aligned_u64 dc[4];
+};
+
 /**
  * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
  * @IOMMU_HWPT_DATA_NONE: no data
  * @IOMMU_HWPT_DATA_VTD_S1: Intel VT-d stage-1 page table
  * @IOMMU_HWPT_DATA_ARM_SMMUV3: ARM SMMUv3 Context Descriptor Table
  * @IOMMU_HWPT_DATA_AMD_GUEST: AMD IOMMU guest page table
+ * @IOMMU_HWPT_DATA_RISCV_S1: RISC-V IOMMU stage-1 page table
  */
 enum iommu_hwpt_data_type {
 	IOMMU_HWPT_DATA_NONE = 0,
 	IOMMU_HWPT_DATA_VTD_S1 = 1,
 	IOMMU_HWPT_DATA_ARM_SMMUV3 = 2,
 	IOMMU_HWPT_DATA_AMD_GUEST = 3,
+	IOMMU_HWPT_DATA_RISCV_S1 = 4,
 };
 
 /**
@@ -703,6 +731,28 @@ struct iommu_hw_info_amd {
 	__aligned_u64 efr2;
 };
 
+/**
+ * struct iommu_hw_info_riscv - RISC-V IOMMU device info
+ *                              (IOMMU_HW_INFO_TYPE_RISCV)
+ *
+ * @capabilities: Value of the RISC-V IOMMU capabilities register, defined
+ *                in "IOMMU capabilities (capabilities)" of the RISC-V
+ *                IOMMU Architecture Specification. The value is reported
+ *                raw by the hardware.
+ *
+ * The VMM is responsible to determine the appropriate fields to be
+ * exposed to the VM since certain features are not currently supported
+ * by the kernel for nested domains. Current list of supported fields:
+ * - capabilities[Sv39, Sv48, Sv57, END, AMO_HWAD]
+ *
+ * This list may expand in the future. It is important that VMMs do not
+ * expose bits outside the list to the VM, to allow for compatibility
+ * with future kernels.
+ */
+struct iommu_hw_info_riscv {
+	__aligned_u64 capabilities;
+};
+
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
  * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
@@ -713,6 +763,7 @@ struct iommu_hw_info_amd {
  * @IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                     SMMUv3) info type
  * @IOMMU_HW_INFO_TYPE_AMD: AMD IOMMU info type
+ * @IOMMU_HW_INFO_TYPE_RISCV: RISC-V IOMMU info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE = 0,
@@ -721,6 +772,7 @@ enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
 	IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV = 3,
 	IOMMU_HW_INFO_TYPE_AMD = 4,
+	IOMMU_HW_INFO_TYPE_RISCV = 5,
 };
 
 /**
@@ -890,10 +942,12 @@ struct iommu_hwpt_get_dirty_bitmap {
  *                                        Data Type
  * @IOMMU_HWPT_INVALIDATE_DATA_VTD_S1: Invalidation data for VTD_S1
  * @IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3: Invalidation data for ARM SMMUv3
+ * @IOMMU_VIOMMU_INVALIDATE_DATA_RISCV: Invalidation data for RISC-V IOMMU
  */
 enum iommu_hwpt_invalidate_data_type {
 	IOMMU_HWPT_INVALIDATE_DATA_VTD_S1 = 0,
 	IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3 = 1,
+	IOMMU_VIOMMU_INVALIDATE_DATA_RISCV = 2,
 };
 
 /**
@@ -954,6 +1008,31 @@ struct iommu_viommu_arm_smmuv3_invalidate {
 	__aligned_le64 cmd[2];
 };
 
+/**
+ * struct iommu_viommu_riscv_invalidate - RISC-V IOMMU cache invalidation
+ *         (IOMMU_VIOMMU_INVALIDATE_DATA_RISCV)
+ * @cmd: 128-bit cache invalidation command that runs in the IOMMU command
+ *       queue, in the format defined by the "IOMMU Page-table cache
+ *       invalidation" section of the RISC-V IOMMU specification. Must be
+ *       little-endian.
+ *
+ * Supported command list only when passing in a vIOMMU via @hwpt_id:
+ *     IOTINVAL.VMA
+ *
+ * The isolation operands are owned by the kernel, which overwrites them
+ * before the command is issued:
+ *     GV = 1 and GSCID = the GSCID assigned to the vIOMMU
+ *     PSCV = 1 and PSCID = 0
+ *
+ * All other reserved bits must be 0.
+ *
+ * -EIO will be returned if the command is not supported, -EINVAL if it is
+ * malformed.
+ */
+struct iommu_viommu_riscv_invalidate {
+	__aligned_le64 cmd[2];
+};
+
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
@@ -1095,6 +1174,7 @@ struct iommu_fault_alloc {
  * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
  * @IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                    SMMUv3) enabled ARM SMMUv3 type
+ * @IOMMU_VIOMMU_TYPE_RISCV: RISC-V IOMMU driver specific type
  */
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
@@ -1105,6 +1185,7 @@ enum iommu_viommu_type {
 	 *   VMM must wire the HYP_OWN bit to 0 in guest VINTF_CONFIG register
 	 */
 	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
+	IOMMU_VIOMMU_TYPE_RISCV = 3,
 };
 
 /**
-- 
2.53.0


