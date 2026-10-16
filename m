Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA60CCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhaQ-0007jF-6m; Fri, 16 Oct 2026 09:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXu-00061x-G9
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:14 -0400
Received: from out203-205-221-239.mail.qq.com ([203.205.221.239])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>) id 1xHeXm-0007kE-P1
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792144080; bh=d80W43ChscoU7zAsGea84IB+ToRkS49hdup/a1jqC3Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=zZk4pAlMk+iZWdu9Txxnz7p9JFBlGTLpJRi/x8AStmSs21KoGFPDnUsUpWSXNAHAR
 oo19KR0bRwr51otGM+vLHYIZo+q4qaXdCnEQ36ZS1xdskj1mJ8r9j406CdMEo8aQst
 GTbWrvhDNORZ6XM/5/mf2vwAWSHb0ULf+vnB7u2g=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id BF4A1837; Fri, 16 Oct 2026 17:47:52 +0800
X-QQ-mid: xmsmtpt1792144078tsc6hrixx
Message-ID: <tencent_25A9B619D0E3909582B4CF096744805B6107@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5QTwvf03QHb5T+wHjsekUOWpgoXmcBTZglUZwwikAOYZKrsJNm8
 S/Wx+yCtFdDZlO6j2D1H0UXk1FJdW7oDQgq0ToMPl2Sb/F3/rAqL09k1CBxrXLv35+MdzX7sNs1o
 No5u5pFZcH4xADS3dWZSk165bL8buIEXV0YPr3tYq97xix+QjYPBo6CkjKcLJYSLXQa3TQPORESu
 ohD+BKRNNXJ+8ZXi6lxYeAl3ucKVoCkTOiKcdLT+XhpydQlVcoXdyV1DnCd5+MEdHWvFskHcbGWo
 /AFDUjvwJ+OibdeCk6I4SejFXMo++WLDGHuChdjR9aw4S8N4wrD2CLTcxIoqxrNT4/OxrARARrFt
 9BK73veoFXSpVT36Xt/PZDjkufX3xfqvp7YaK7YYRZujLug7qyfZw6AGC6exLz3xyJ4sN9vNCfWx
 NR9fLUnlgStktWXZ02oQg//nk2/e5Vfl5RqRbCYlzu7kat1oh5YdptjQxOXTJjc40BEaAprW45nA
 nX++x74LAIRYUPfxKdrfgQnqjxsCW4J9jp8N07VJb7zwQnkSq6vBGPEj+q3/2wtWKJWa7+MCwhmu
 wK2cVS3bIaKdpE0KgNl2mUrbeOAOpV6qGJbhEyXPfwB3eCPmh/ogjpZmhqS/dyeDHetq4ig1NYf8
 zfuaqSevv5+eUx1xiiyv059qCtP0qRPHs08l2zN42fPJJoXPiz7W6ZwfHuVcFQ2SW1h5DSxJLtuY
 BX2UfMjiUAS2pEJQwgontvU2MtBHfiVUynN5BuOklKx5yaygOsrgvrT+x1WDSzTALjeBMSfkAgd/
 jlh+tBjLQqrW32Pr71AFiNxBHYwfn1rqpprEWxwDV2UvyT31T4Y+/WUqzWlgXM0fAF3Unu4s0bqR
 YcPjbpnEU3U05Oije6aiL2woqtkaLcrb1HiWnxRMvAXdqmKUmopxhs2Yk+ND5rWgX1MHWVGvEJbj
 CbccibfKYC8daRRNkoPdTPuA1uw4j2VsRaLP6K7l/MzWcBUbn/cnNMS7qQ/BnJWpR2uE4I4FtzaK
 YGwZOzpC1lg8nmCVB8JHy3FUAHu0fi3Sn86uhn/zZIkAKOTOVE4tm9ZnUxSPsD5eNzo0vB3gbeDA
 NZ4N/NubiaHFergyoP5LQcITXToYvdFlkDCSn6
X-QQ-XMRINFO: NV153Ut7BKVGEBPxNGBppa2DJCr1urzIPw==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 05/37] hw/arm/mpam: Add MPAM MSC register map
Date: Fri, 16 Oct 2026 17:46:59 +0800
X-OQ-MSGID: <20261016094733.1898485-6-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016094733.1898485-1-2118537295@qq.com>
References: <20261016094733.1898485-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.239; envelope-from=2118537295@qq.com;
 helo=out203-205-221-239.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:33 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add the MMIO register map of an MPAM 1.1 Memory System Component
(IHI 0099 sections 4-6) as registerfields definitions:
- The feature IDRs (MPAMF_IDR, IIDR/AIDR, CPOR/CCAP/MBW/PRI/PARTID_NRW,
  MSMON family)
- The error registers (ERR_MSI block, ECR, ESR)
- The configuration registers (PART_SEL, CMAX/CMIN/CASSOC,
  MBW_MIN/MAX/PBM/PROP, PRI, INTPARTID, CPBM/MBW_PBM arrays) and their
  write masks
- The portion-width constants of this model.

Based on an RFC series by Jonathan Cameron.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/Kconfig        |   4 +
 hw/arm/meson.build    |   1 +
 hw/arm/mpam.c         | 223 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/mpam.h |  20 ++++
 4 files changed, 248 insertions(+)
 create mode 100644 hw/arm/mpam.c
 create mode 100644 include/hw/arm/mpam.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4445f16..6a2a36a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -37,6 +37,7 @@ config ARM_VIRT
     select ACPI_CXL
     select ACPI_HMAT
     select WDT_SBSA
+    select MPAM
 
 config CUBIEBOARD
     bool
@@ -650,6 +651,9 @@ config ARM_SMMUV3
     select ARM_SMMUV3_ACCEL if IOMMUFD
     imply TEGRA241_CMDQV
 
+config MPAM
+    bool
+
 config FSL_IMX6UL
     bool
     default y
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index bcc068d..42ca75b 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -106,6 +106,7 @@ arm_common_ss.add(when: 'CONFIG_NETDUINO2', if_true: files('netduino2.c'))
 arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
 arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_peripherals.c'))
 arm_common_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
+arm_common_ss.add(when: 'CONFIG_MPAM', if_true: files('mpam.c'))
 arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
diff --git a/hw/arm/mpam.c b/hw/arm/mpam.c
new file mode 100644
index 0000000..772a120
--- /dev/null
+++ b/hw/arm/mpam.c
@@ -0,0 +1,223 @@
+/*
+ * ARM MPAM emulation
+ *
+ * Copyright (c) 2023 Huawei
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/registerfields.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+#include "hw/arm/mpam.h"
+
+REG64(MPAMF_IDR, 0)
+    FIELD(MPAMF_IDR, PART_ID_MAX, 0, 16)
+    FIELD(MPAMF_IDR, PMG_MAX, 16, 8)
+    FIELD(MPAMF_IDR, HAS_CCAP_PART, 24, 1)
+    FIELD(MPAMF_IDR, HAS_CPOR_PART, 25, 1)
+    FIELD(MPAMF_IDR, HAS_MBW_PART, 26, 1)
+    FIELD(MPAMF_IDR, HAS_PRI_PART, 27, 1)
+    FIELD(MPAMF_IDR, EXT, 28, 1)
+    FIELD(MPAMF_IDR, HAS_IMPL_IDR, 29, 1)
+    FIELD(MPAMF_IDR, HAS_MSMON, 30, 1)
+    FIELD(MPAMF_IDR, HAS_PARTID_NRW, 31, 1)
+    FIELD(MPAMF_IDR, HAS_RIS, 32, 1)
+    FIELD(MPAMF_IDR, NO_IMPL_PART, 36, 1)
+    FIELD(MPAMF_IDR, NO_IMPL_MSMON, 37, 1)
+    FIELD(MPAMF_IDR, HAS_EXTD_ESR, 38, 1)
+    FIELD(MPAMF_IDR, HAS_ESR, 39, 1)
+    FIELD(MPAMF_IDR, HAS_ERR_MS, 40, 1)
+    FIELD(MPAMF_IDR, SP4, 41, 1)
+    FIELD(MPAMF_IDR, HAS_ENDIS, 42, 1)
+    FIELD(MPAMF_IDR, HAS_NFU, 43, 1)
+    FIELD(MPAMF_IDR, RIS_MAX, 56, 4)
+
+REG32(MPAMF_IIDR, 0x0018)
+    FIELD(MPAMF_IIDR, IMPLEMENTER, 0, 12)
+    FIELD(MPAMF_IIDR, REVISION, 12, 4)
+    FIELD(MPAMF_IIDR, VARIANT, 16, 4)
+    FIELD(MPAMF_IIDR, PRODUCT_ID, 20, 12)
+
+REG32(MPAMF_AIDR, 0x0020)
+    FIELD(MPAMF_AIDR, ARCH_MINOR_REV, 0, 4)
+    FIELD(MPAMF_AIDR, ARCH_MAJOR_REV, 4, 4)
+
+REG32(MPAMF_IMPL_IDR, 0x0028)
+REG32(MPAMF_CPOR_IDR, 0x0030)
+    FIELD(MPAMF_CPOR_IDR, CPBM_WD, 0, 16)
+
+REG32(MPAMF_CCAP_IDR, 0x0038)
+    FIELD(MPAMF_CCAP_IDR, CMAX_WD, 0, 6)
+    FIELD(MPAMF_CCAP_IDR, CASSOC_WD, 8, 5)
+    FIELD(MPAMF_CCAP_IDR, HAS_CASSOC, 28, 1)
+    FIELD(MPAMF_CCAP_IDR, HAS_CMIN, 29, 1)
+    FIELD(MPAMF_CCAP_IDR, NO_CMAX, 30, 1)
+    FIELD(MPAMF_CCAP_IDR, HAS_CMAX_SOFTLIM, 31, 1)
+
+REG32(MPAMF_MBW_IDR, 0x0040)
+    FIELD(MPAMF_MBW_IDR, BWA_WD, 0, 6)
+    FIELD(MPAMF_MBW_IDR, HAS_MIN, 10, 1)
+    FIELD(MPAMF_MBW_IDR, HAS_MAX, 11, 1)
+    FIELD(MPAMF_MBW_IDR, HAS_PBM, 12, 1)
+    FIELD(MPAMF_MBW_IDR, HAS_PROP, 13, 1)
+    FIELD(MPAMF_MBW_IDR, WINDWR, 14, 1)
+    FIELD(MPAMF_MBW_IDR, BWPBM_WD, 16, 13)
+
+REG32(MPAMF_PRI_IDR, 0x0048)
+    FIELD(MPAMF_PRI_IDR, HAS_INTPRI, 0, 1)
+    FIELD(MPAMF_PRI_IDR, INTPRI_0_IS_LOW, 1, 1)
+    FIELD(MPAMF_PRI_IDR, INTPRI_WD, 4, 6)
+    FIELD(MPAMF_PRI_IDR, HAS_DSPRI, 16, 1)
+    FIELD(MPAMF_PRI_IDR, DSPRI_0_IS_LOW, 17, 1)
+    FIELD(MPAMF_PRI_IDR, DSPRI_WD, 20, 6)
+
+REG32(MPAMF_PARTID_NRW_IDR, 0x0050)
+    FIELD(MPAMF_PARTID_NRW_IDR, INTPARTID_MAX, 0, 16)
+
+REG32(MPAMF_MSMON_IDR, 0x080)
+    FIELD(MPAMF_MSMON_IDR, MSMON_CSU, 16, 1)
+    FIELD(MPAMF_MSMON_IDR, MSMON_MBWU, 17, 1)
+    FIELD(MPAMF_MSMON_IDR, HAS_OFLOW_SR, 28, 1)
+    FIELD(MPAMF_MSMON_IDR, HAS_OFLW_MS, 29, 1)
+    FIELD(MPAMF_MSMON_IDR, NO_OFLW_INTR, 30, 1)
+    FIELD(MPAMF_MSMON_IDR, HAS_LOCAL_CAPT_EVNT, 31, 1)
+
+REG32(MPAMF_CSUMON_IDR, 0x0088)
+    FIELD(MPAMF_CSUMON_IDR, NUM_MON, 0, 16)
+    FIELD(MPAMF_CSUMON_IDR, HAS_OFLOW_CAPT, 24, 1)
+    FIELD(MPAMF_CSUMON_IDR, HAS_CEVNT_OFLW, 25, 1)
+    FIELD(MPAMF_CSUMON_IDR, HAS_OFSR, 26, 1)
+    FIELD(MPAMF_CSUMON_IDR, HAS_OFLOW_LNKG, 27, 1)
+    FIELD(MPAMF_CSUMON_IDR, HAS_XCL, 29, 1)
+    FIELD(MPAMF_CSUMON_IDR, CSU_RO, 30, 1)
+    FIELD(MPAMF_CSUMON_IDR, HAS_CAPTURE, 31, 1)
+
+REG32(MPAMF_MBWUMON_IDR, 0x0090)
+    FIELD(MPAMF_MBWUMON_IDR, NUM_MON, 0, 16)
+    FIELD(MPAMF_MBWUMON_IDR, SCALE, 16, 5)
+    FIELD(MPAMF_MBWUMON_IDR, HAS_OFLOW_CAPT, 24, 1)
+    FIELD(MPAMF_MBWUMON_IDR, HAS_CEVNT_OFLW, 25, 1)
+    FIELD(MPAMF_MBWUMON_IDR, HAS_OFSR, 26, 1)
+    FIELD(MPAMF_MBWUMON_IDR, HAS_OFLOW_LNKG, 27, 1)
+    FIELD(MPAMF_MBWUMON_IDR, HAS_RWBW, 28, 1)
+    FIELD(MPAMF_MBWUMON_IDR, LWD, 29, 1)
+    FIELD(MPAMF_MBWUMON_IDR, HAS_LONG, 30, 1)
+    FIELD(MPAMF_MBWUMON_IDR, HAS_CAPTURE, 31, 1)
+
+REG32(MPAMF_ERR_MSI_MPAM, 0x00dc)
+REG32(MPAMF_ERR_MSI_ADDR_L, 0x00e0)
+REG32(MPAMF_ERR_MSI_ADDR_H, 0x00e4)
+REG32(MPAMF_ERR_MSI_DATA, 0x00e8)
+REG32(MPAMF_ERR_MSI_ATTR, 0x00ec)
+
+REG32(MPAMF_ECR, 0x00f0)
+    FIELD(MPAMF_ECR, INTEN, 0, 1)
+#define MPAMF_ECR_WRITE_MASK ( \
+    R_MPAMF_ECR_INTEN_MASK)
+
+REG64(MPAMF_ESR, 0x00f8)
+    FIELD(MPAMF_ESR, PARID_MON, 0, 16)
+    FIELD(MPAMF_ESR, PMG, 16, 8)
+    FIELD(MPAMF_ESR, ERR_CODE, 24, 4)
+    FIELD(MPAMF_ESR, OVRWR, 31, 1)
+    FIELD(MPAMF_ESR, RIS, 32, 4)
+
+REG32(MPAMF_CFG_PART_SEL, 0x0100)
+    FIELD(MPAMF_CFG_PART_SEL, PARTID_SEL, 0, 16)
+    FIELD(MPAMF_CFG_PART_SEL, INTERNAL, 16, 1)
+    FIELD(MPAMF_CFG_PART_SEL, RIS, 24, 4)
+#define MPAMF_CFG_PART_SEL_WRITE_MASK ( \
+    R_MPAMF_CFG_PART_SEL_PARTID_SEL_MASK | \
+    R_MPAMF_CFG_PART_SEL_INTERNAL_MASK | \
+    R_MPAMF_CFG_PART_SEL_RIS_MASK)
+
+REG32(MPAMF_MPAMCFG_CMAX, 0x0108)
+    FIELD(MPAMF_MPAMCFG_CMAX, CMAX, 0, 16)
+    FIELD(MPAMF_MPAMCFG_CMAX, SOFTLIM, 31, 1)
+#define MPAMF_MPAMCFG_CMAX_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_CMAX_CMAX_MASK | \
+    R_MPAMF_MPAMCFG_CMAX_SOFTLIM_MASK)
+
+REG32(MPAMF_MPAMCFG_CMIN, 0x0110)
+    FIELD(MPAMF_MPAMCFG_CMIN, CMIN, 0, 16)
+#define MPAMF_MPAMCFG_CMIN_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_CMIN_CMIN_MASK)
+
+REG32(MPAMF_MPAMCFG_CASSOC, 0x0118)
+    FIELD(MPAMF_MPAMCFG_CASSOC, CASSOC, 0, 16)
+#define MPAMF_MPAMCFG_CASSOC_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_CASSOC_CASSOC_MASK)
+
+REG32(MPAMF_MPAMCFG_MBW_MIN, 0x0200)
+    FIELD(MPAMF_MPAMCFG_MBW_MIN, MIN, 0, 16)
+#define MPAMF_MPAMCFG_MBW_MIN_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_MBW_MIN_MIN_MASK)
+
+REG32(MPAMF_MPAMCFG_MBW_MAX, 0x0208)
+    FIELD(MPAMF_MPAMCFG_MBW_MAX, MAX, 0, 16)
+    FIELD(MPAMF_MPAMCFG_MBW_MAX, HARDLIM, 31, 1)
+#define MPAMF_MPAMCFG_MBW_MAX_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_MBW_MAX_MAX_MASK | \
+    R_MPAMF_MPAMCFG_MBW_MAX_HARDLIM_MASK)
+
+REG32(MPAMF_MPAMCFG_WINWD, 0x0220)
+    FIELD(MPAMF_MPAMCFG_WINWD, US_FRAC, 0, 8)
+    FIELD(MPAMF_MPAMCFG_WINWD, US_INT, 8, 16)
+#define MPAMF_MPAMCFG_WINWD_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_WINWD_US_FRAC | \
+    R_MPAMF_MPAMCFG_WINWD_US_INT)
+
+REG32(MPAMF_MPAMCFG_EN, 0x0300)
+    FIELD(MPAMF_MPAMCFG_EN, PARTID, 0, 16)
+#define MPAMF_MPAMCFG_EN_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_EN_PARTID_MASK)
+
+REG32(MPAMF_MPAMCFG_DIS, 0x0310) /* WHat is this for? */
+    FIELD(MPAMF_MPAMCFG_DIS, PARTID, 0, 16)
+    FIELD(MPAMF_MPAMCFG_DIS, NFU, 31, 1)
+#define MPAMF_MPAMCFG_DIS_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_DIS_PARTID_MASK | \
+    R_MPAMF_MPAMCFG_DIS_NFU)
+
+REG32(MPAMF_MPAMCFG_EN_FLAGS, 0x320)
+
+REG32(MPAMF_MPAMCFG_PRI, 0x400)
+    FIELD(MPAMF_MPAMCFG_PRI, INTPRI, 0, 16)
+    FIELD(MPAMF_MPAMCFG_PRI, DSPRI, 16, 16)
+#define MPAMF_MPAMCFG_PRI_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_PRI_INTPRI_MASK | \
+    R_MPAMF_MPAMCFG_PRI_DSPRI_MASK)
+
+REG32(MPAMF_MPAMCFG_MBW_PROP, 0x500)
+    FIELD(MPAMF_MPAMCFG_MBW_PROP, STRIDEM1, 0, 16)
+    FIELD(MPAMF_MPAMCFG_MBW_PROP, EN, 31, 1)
+#define MPAMF_MPAMCFG_MBW_PROP_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_MBW_PROP_STRIDEM1_MASK | \
+    R_MPAMF_MPAMCFG_MBW_PROP_EN_MASK)
+
+REG32(MPAMF_MPAMCFG_INTPARTID, 0x600)
+    FIELD(MPAMF_MPAMCFG_INTPARTID, INTPARTID, 0, 16)
+    FIELD(MPAMF_MPAMCFG_INTPARTID, INTERNAL, 16, 1)
+#define MPAMF_MPAMCFG_INTPARTID_WRITE_MASK ( \
+    R_MPAMF_MPAMCFG_INTPARTID_INTPARTID_MASK | \
+    R_MPAMF_MPAMCFG_INTPARTID_INTERNAL_MASK)
+
+REG32(MPAMF_MPAMCFG_CPBM0, 0x1000)
+
+REG32(MPAMF_MPAMCFG_MBW_PBM0, 0x2000)
+
+#define TYPE_MPAM_MSC "mpam-msc"
+/*
+ * Max number of portions this model exposes for the cache-portion (CPOR)
+ * bitmap and the memory-bandwidth-portion (MBW_PBM) bitmap.  IHI 0099
+ * dimensions CPBM_WD/BWPBM_WD by these widths (see MPAMF_CPOR/MBW_IDR).
+ */
+#define MPAM_MBW_PART 4
+#define MPAM_CACHE_PART 32
+/* MPAMF_IIDR.IMPLEMENTER: ARM JEP106 code for Huawei (0x736). */
+#define MPAM_IIDR_IMPLEMENTER 0x736
diff --git a/include/hw/arm/mpam.h b/include/hw/arm/mpam.h
new file mode 100644
index 0000000..e7557a9
--- /dev/null
+++ b/include/hw/arm/mpam.h
@@ -0,0 +1,20 @@
+/*
+ * QEMU MPAM emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef _MPAM_H_
+#define _MPAM_H_
+
+#include "qom/object.h"
+
+#define TYPE_MPAM_MSC_MEM "mpam-msc-mem"
+#define TYPE_MPAM_MSC_CACHE "mpam-msc-cache"
+
+/*
+ * MMIO window of one MSC: IHI 0099 places the register block in a 16 KiB
+ * region (0x4000).  The virt board reserves a 1 MiB slot for up to 256 MSCs.
+ */
+#define MPAM_SIZE 0x4000
+
+#endif /* _MPAM_H_ */
-- 
2.43.0


