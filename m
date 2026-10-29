Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B2D606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KvBvO+NK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTek-00066O-53; Thu, 29 Oct 2026 13:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xMTeg-000656-7l; Thu, 29 Oct 2026 13:11:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xMTed-0007y1-S1; Thu, 29 Oct 2026 13:11:09 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGEYZX410652; Thu, 29 Oct 2026 17:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5kfKI0
 9+2kO3jT68VAcnAvCW4rNcsJxWq24lH1L0P3Q=; b=KvBvO+NK639dvbVeNgLl5k
 AUvZZPC5iYSmMWq14DAdOWpxhsw+jExcaneQGu4z5Fje1XQe4xzg8+/3y9te2oze
 FdjLTR0qoxFfQk1YiXPbEKFStni9c6sEi+p25iHN+z4y2Y+XIt6Q+IgFgKjJ6rNd
 43kZYd3b+6oXaCvEBuhSaWaQmDxHcVx08BGBKiwlj1uGQNKF8gwkIdwjy6VgGpmk
 5UOZKSs7/LakqG2YK/7i2LUeCkA1v5hkvc2DCRj7A3E6dhQZepBI9DVGQldxcEfN
 JAFun9B15u0hw8juVJa8VOWmUJ1lcgnQSFmGEbPZvfYeLDZQW+70zhg6kgB1LWAw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3mkt69-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:10:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGJntJ3392668; Thu, 29 Oct 2026 17:10:58 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hm69e166k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:10:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69THAuUi4588508
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Oct 2026 17:10:56 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87FF558045;
 Thu, 29 Oct 2026 17:10:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 018BF58050;
 Thu, 29 Oct 2026 17:10:55 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Oct 2026 17:10:54 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v7 RESEND 1/9] qtest/phb5: Add testbench for PHB
Date: Thu, 29 Oct 2026 12:10:39 -0500
Message-ID: <20261029171047.3862430-2-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029171047.3862430-1-saif.abrar@linux.ibm.com>
References: <20261029171047.3862430-1-saif.abrar@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX5BVobwtr8jUA
 97v6aQTsvtgCovNPkcHtAT6HEAfAv4Ug2oUAtG0avg6sJno99QDpUCM9FL8HijMfj4Xui033624
 quvUzEt4H1CfYQKSw4UsDW1hHCfDsvY=
X-Proofpoint-ORIG-GUID: _RizoBGEDKreyWcy0V-fi36JEd1aNNZf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX0cDzRY45pyrT
 +Tbi2F1ns1jNdP/udCEj6r9TQp8XgHUThXfCO5WSRSrZoBdGJ+ezS8/tRYvxA6yZQ/BbJb7dDci
 dqlRD9CP3KRC9LqL/FgoGqAuVlBFbyDjAarl9ZV/18ET7mXwfK19uQN8I8I8xgkfV8s2JDBpFp4
 1Z+dkt+zER2B/EyFFYvuP4TaMtHxFTZxVycLobA+f7LEz0t+KUDfQbY0lhQH0rUsJ2oo2GqTOIZ
 6VfovYTHEnywPhkhXoCt3m864DtZKWvGOzjKP4wUDlwyTch8JMtCQu4l+Y9nVwwvUFFzvkb3BhI
 P4huTE0NGIhsm1fGb3o+Sw9nsqDN6qb4Z6iIfmzNTaecAIsALTSuGxRiYPH9+08u0zJq4IqPpUW
 W3kDckJJ6HlBxiHWIfbyw25kpUK1Lw==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae37e23 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=zHMdCkDpksyigQT-iYMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: ihvrS9_X-vgvAYrvYJIRyFE3oLno6FRZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290065
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>

New qtest testbench added for PHB[345].
Testbench reads PHB Version register and asserts that
bits[24:31] have value 0xA3, 0xA4 and 0xA5 respectively.

Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/qtest/meson.build         |  1 +
 tests/qtest/pnv-host-i2c-test.c | 13 +----
 tests/qtest/pnv-phb-test.c      | 99 +++++++++++++++++++++++++++++++++
 tests/qtest/pnv-qtest-common.h  | 24 ++++++++
 tests/qtest/pnv-xive2-common.h  |  7 +--
 5 files changed, 126 insertions(+), 18 deletions(-)
 create mode 100644 tests/qtest/pnv-phb-test.c
 create mode 100644 tests/qtest/pnv-qtest-common.h

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 46d4fc1d2b..5dc1ee1b35 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -197,6 +197,7 @@ qtests_ppc64 = \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xive2-test'] : []) +                 \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-spi-seeprom-test'] : []) +           \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-host-i2c-test'] : []) +              \
+  (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-phb-test'] : []) +                  \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['numa-test'] : []) +                      \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : []) +                      \
   (slirp.found() ? ['pxe-test'] : []) +              \
diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
index f97f6f65ee..176e7365da 100644
--- a/tests/qtest/pnv-host-i2c-test.c
+++ b/tests/qtest/pnv-host-i2c-test.c
@@ -11,18 +11,7 @@
 #include "hw/gpio/pca9554_regs.h"
 #include "hw/gpio/pca9552_regs.h"
 #include "pnv-xscom.h"
-
-#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
-#define PPC_BIT32(bit)          (0x80000000 >> (bit))
-#define PPC_BIT8(bit)           (0x80 >> (bit))
-#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
-#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
-                                 PPC_BIT32(bs))
-
-#define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
-#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
-#define SETFIELD(m, v, val) \
-        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))
+#include "pnv-qtest-common.h"
 
 #define PNV10_XSCOM_I2CM_BASE   0xa0000
 #define PNV10_XSCOM_I2CM_SIZE   0x1000
diff --git a/tests/qtest/pnv-phb-test.c b/tests/qtest/pnv-phb-test.c
new file mode 100644
index 0000000000..b4d75a1229
--- /dev/null
+++ b/tests/qtest/pnv-phb-test.c
@@ -0,0 +1,99 @@
+/*
+ * QTest testcase for PowerNV PHB
+ *
+ * Copyright (c) 2026, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/pci-host/pnv_phb4_regs.h"
+#include "pnv-xscom.h"
+#include "pnv-qtest-common.h"
+
+#define PHB3_PBCQ_SPCI_ASB_ADDR      0x0
+#define PHB3_PBCQ_SPCI_ASB_DATA      0x2
+
+#define PHB4_XSCOM              0x40084800ull
+
+/* SCOM to PCBA address conversion */
+#define SCOM_TO_PCBA(scom, addr) (((scom) >> 3) + (addr))
+
+/*
+ * Indirect XSCOM read::
+ * - Write 'Indirect Address Register' with register-offset to read.
+ * - Read 'Indirect Data Register' to get the value.
+ */
+static uint64_t pnv_phb_xscom_read(QTestState *qts, const PnvChip *chip,
+        uint64_t scom, uint32_t indirect_addr, uint32_t indirect_data,
+        uint64_t reg)
+{
+    qtest_writeq(qts, pnv_xscom_addr(chip, SCOM_TO_PCBA(scom, indirect_addr)),
+                 reg);
+    return qtest_readq(qts, pnv_xscom_addr(chip, SCOM_TO_PCBA(scom,
+                                                              indirect_data)));
+}
+
+/* Assert that 'PHB - Version Register' bits[24:31] are as expected */
+static void phb_version_test(const void *data)
+{
+    const PnvChip *chip = (PnvChip *)data;
+    QTestState *qts;
+    const char *machine = pnv_get_machine_type(chip->chip_type);
+
+    /* Defaults to PNV_CHIP_POWER8 */
+    uint64_t phb_xscom = 0x4809e000;
+    uint64_t reg_phb_version = PHB_VERSION;
+    uint32_t indirect_addr = PHB3_PBCQ_SPCI_ASB_ADDR;
+    uint32_t indirect_data = PHB3_PBCQ_SPCI_ASB_DATA;
+    uint32_t expected_ver = 0xA3;
+    uint64_t ver;
+
+    if (chip->chip_type == PNV_CHIP_POWER9) {
+        phb_xscom = 0x68084800;
+        indirect_addr = PHB_SCOM_HV_IND_ADDR;
+        indirect_data = PHB_SCOM_HV_IND_DATA;
+        reg_phb_version |= PPC_BIT(0);
+        expected_ver = 0xA4;
+    } else if ((chip->chip_type == PNV_CHIP_POWER10) ||
+               (chip->chip_type == PNV_CHIP_POWER11)) {
+        phb_xscom = PHB4_XSCOM;
+        indirect_addr = PHB_SCOM_HV_IND_ADDR;
+        indirect_data = PHB_SCOM_HV_IND_DATA;
+        reg_phb_version |= PPC_BIT(0);
+        expected_ver = 0xA5;
+    }
+
+    qts = qtest_initf("-M %s -accel tcg -cpu %s", machine, chip->cpu_model);
+
+    ver = pnv_phb_xscom_read(qts, chip, phb_xscom,
+                                indirect_addr, indirect_data, reg_phb_version);
+
+    /* PHB Version register bits [24:31] */
+    ver = GETFIELD(PPC_BITMASK(24, 31), ver);
+    g_assert_cmpuint(ver, ==, expected_ver);
+
+    qtest_quit(qts);
+}
+
+/* Verify versions of all supported PHB's */
+static void add_phbX_version_test(void)
+{
+    for (int i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
+        g_autofree char *tname = g_strdup_printf("pnv-phb/%s",
+                                      pnv_chips[i].cpu_model);
+        qtest_add_data_func(tname, &pnv_chips[i], phb_version_test);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    /* PHB[345] tests */
+    add_phbX_version_test();
+
+    return g_test_run();
+}
diff --git a/tests/qtest/pnv-qtest-common.h b/tests/qtest/pnv-qtest-common.h
new file mode 100644
index 0000000000..c2d1bae7bb
--- /dev/null
+++ b/tests/qtest/pnv-qtest-common.h
@@ -0,0 +1,24 @@
+/*
+ * PNV QTest common definitions
+ *
+ * Copyright (c) 2026, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef TEST_PNV_QTEST_COMMON_H
+#define TEST_PNV_QTEST_COMMON_H
+
+#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
+#define PPC_BIT32(bit)          (0x80000000 >> (bit))
+#define PPC_BIT8(bit)           (0x80 >> (bit))
+#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
+#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
+                                 PPC_BIT32(bs))
+
+#define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
+#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
+#define SETFIELD(m, v, val) \
+        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))
+
+#endif
diff --git a/tests/qtest/pnv-xive2-common.h b/tests/qtest/pnv-xive2-common.h
index 3b84227424..4b823a57e2 100644
--- a/tests/qtest/pnv-xive2-common.h
+++ b/tests/qtest/pnv-xive2-common.h
@@ -9,12 +9,7 @@
 #ifndef TEST_PNV_XIVE2_COMMON_H
 #define TEST_PNV_XIVE2_COMMON_H
 
-#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
-#define PPC_BIT32(bit)          (0x80000000 >> (bit))
-#define PPC_BIT8(bit)           (0x80 >> (bit))
-#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
-#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
-                                 PPC_BIT32(bs))
+#include "pnv-qtest-common.h"
 #include "hw/intc/pnv_xive2_regs.h"
 #include "hw/ppc/xive_regs.h"
 #include "hw/ppc/xive2_regs.h"
-- 
2.52.0


