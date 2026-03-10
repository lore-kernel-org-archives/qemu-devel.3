Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D0BEB106D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzynn-0007bt-OZ; Tue, 10 Mar 2026 11:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vzynN-0006p6-RR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:14:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vzynL-0000Fa-Nq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:14:53 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A7F0sM1123654
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ONuKfYvFvEai5Z62s
 Q38HoXonILpjlJA700g5K9THRc=; b=kjz0yEM6Ag3Mlfp09PR72T5S66jc4bKHD
 CPxXkJioyXXhDrWjYg5K5LtY9B9NhzjwEhhR2ORv92WBczkumj6Kr6aj/DcCTzDO
 y4DJNHKeH4CFxR142rPXFD12DHbhfwFjlWxJfM7dJLsL5wKc/atb9Pjux/CjOKTu
 TBM68C6ctyUS3PGC1ualLgZie6DFAuWDUyGMnbIdb2pOhHITaOrCut4S/AVYnecn
 MMqXmMnezf1YldlhkFkMCfle+SW46GeZuA2GaiVsAk2y0zdkdVubhTC1mjEg0rJ7
 wZVg/+mDyLw45Lz2seOqrNltoq1u79ZMNvGT/WKh4cQ4IayKmwWxg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuybfyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AFCcqr029850
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6up8af-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:48 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AFEiUZ60490222
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 15:14:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 666802004E;
 Tue, 10 Mar 2026 15:14:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 073572004B;
 Tue, 10 Mar 2026 15:14:43 +0000 (GMT)
Received: from Mac.com (unknown [9.39.23.49])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 15:14:42 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PULL 02/10] ppc/mpipl: Implement S0 SBE interrupt
Date: Tue, 10 Mar 2026 20:44:22 +0530
Message-ID: <20260310151432.92531-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310151432.92531-1-harshpb@linux.ibm.com>
References: <20260310151432.92531-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69b03569 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=sHmFuGpciTfFc5QH0gQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzMSBTYWx0ZWRfX1zUKOn0RcKo3
 pUcEiHF9+jHeLhafi6EMJeW4i4u11SARVSdwgusMuLXhte4yYs5dNZhVQiz6N0f7EP6z+S5/Wi2
 DIRqCGeem2BvsrCK/cpYk/Vnl+w0guO6jwDfdppg0g6XbmsPzFNrkNu4S2SKxQi6jJXfirnDib+
 NqYEUcQmz8kRy2cqFkx7V14o5by90TXUBqKz7Qh9Bj1Q7hbYCVdobyoaJnBdei2oV6SPG+jIeV1
 qGqroY81Femw9K40McGfYFhr3jPFa8z1lClLo2bmSWK5+5h4L4dKz3hvheDunpIZeO8jxBkpKgk
 F+aSinHC8mPKn7VECyuF8Wtnf7rdGJbWNYWMsGaJ8sepqXoS/KCBEV6NIkSovcK42J0d6664eqt
 xJIXZeE2sQdz7ustMV4oWBRBkO/IGBoU4uuDMj/LRO2qwxqQHsoON5zi2Qt/VijVUsczpT6BIK2
 oTXY7mWXANCbtGq3S0g==
X-Proofpoint-GUID: q9GwbXwgA0PWlom7KWf84aqqPKGZN17a
X-Proofpoint-ORIG-GUID: q9GwbXwgA0PWlom7KWf84aqqPKGZN17a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100131
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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

From: Aditya Gupta <adityag@linux.ibm.com>

During MPIPL (aka fadump), after a kernel crash, the kernel does
opal_cec_reboot2 opal call, signifying an abnormal termination.
When OPAL receives this opal call, it further triggers SBE S0 interrupt,
to trigger a MPIPL boot.

Currently S0 interrupt is unimplemented in QEMU.

Implement S0 interrupt as 'pause_vcpus' + 'guest_reset' in QEMU, as the
SBE's implementation of S0 seems to be basically "stop all clocks" and
then "host reset".

pause_vcpus is done in a later patch when register preserving support is
added

See 'stopClocksS0' in SBE source code for more information.

Also log both S0 and S1 interrupts.

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260310124619.3909045-3-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/pnv.h       |  6 ++++++
 include/hw/ppc/pnv_mpipl.h | 19 +++++++++++++++++++
 hw/ppc/pnv_mpipl.c         | 26 ++++++++++++++++++++++++++
 hw/ppc/pnv_sbe.c           | 29 +++++++++++++++++++++++++++++
 hw/ppc/meson.build         |  1 +
 5 files changed, 81 insertions(+)
 create mode 100644 include/hw/ppc/pnv_mpipl.h
 create mode 100644 hw/ppc/pnv_mpipl.c

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 24f8843a40..7d73629f11 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -25,6 +25,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/ipmi/ipmi.h"
 #include "hw/ppc/pnv_pnor.h"
+#include "hw/ppc/pnv_mpipl.h"
 
 #define TYPE_PNV_CHIP "pnv-chip"
 
@@ -111,6 +112,8 @@ struct PnvMachineState {
 
     bool         big_core;
     bool         lpar_per_core;
+
+    MpiplPreservedState mpipl_state;
 };
 
 PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_id);
@@ -290,4 +293,7 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
 
 #define PNV11_OCC_SENSOR_BASE(chip) PNV10_OCC_SENSOR_BASE(chip)
 
+/* MPIPL helpers */
+void do_mpipl_preserve(PnvMachineState *pnv);
+
 #endif /* PPC_PNV_H */
diff --git a/include/hw/ppc/pnv_mpipl.h b/include/hw/ppc/pnv_mpipl.h
new file mode 100644
index 0000000000..c544984dc7
--- /dev/null
+++ b/include/hw/ppc/pnv_mpipl.h
@@ -0,0 +1,19 @@
+/*
+ * Emulation of MPIPL (Memory Preserving Initial Program Load), aka fadump
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PNV_MPIPL_H
+#define PNV_MPIPL_H
+
+#include "qemu/osdep.h"
+
+typedef struct MpiplPreservedState MpiplPreservedState;
+
+/* Preserved state to be saved in PnvMachineState */
+struct MpiplPreservedState {
+    bool       is_next_boot_mpipl;
+};
+
+#endif
diff --git a/hw/ppc/pnv_mpipl.c b/hw/ppc/pnv_mpipl.c
new file mode 100644
index 0000000000..d8c9b7a428
--- /dev/null
+++ b/hw/ppc/pnv_mpipl.c
@@ -0,0 +1,26 @@
+/*
+ * Emulation of MPIPL (Memory Preserving Initial Program Load), aka fadump
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/runstate.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_mpipl.h"
+
+void do_mpipl_preserve(PnvMachineState *pnv)
+{
+    /* Mark next boot as Memory-preserving boot */
+    pnv->mpipl_state.is_next_boot_mpipl = true;
+
+    /*
+     * Do a guest reset.
+     * Next reset will see 'is_next_boot_mpipl' as true, and trigger MPIPL
+     *
+     * Requirement:
+     * GUEST_RESET is expected to NOT clear the memory, as is the case when
+     * this is merged
+     */
+    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+}
diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index 247617338a..5a2b3342d1 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -26,6 +26,9 @@
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/pnv_sbe.h"
+#include "hw/ppc/pnv_mpipl.h"
+#include "system/cpus.h"
+#include "system/runstate.h"
 #include "trace.h"
 
 /*
@@ -113,11 +116,37 @@ static uint64_t pnv_sbe_power9_xscom_ctrl_read(void *opaque, hwaddr addr,
 static void pnv_sbe_power9_xscom_ctrl_write(void *opaque, hwaddr addr,
                                        uint64_t val, unsigned size)
 {
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+    PnvSBE *sbe = opaque;
     uint32_t offset = addr >> 3;
 
     trace_pnv_sbe_xscom_ctrl_write(addr, val);
 
     switch (offset) {
+    case SBE_CONTROL_REG_RW:
+        switch (val) {
+        case SBE_CONTROL_REG_S0:
+            qemu_log_mask(LOG_UNIMP, "SBE: S0 Interrupt triggered\n");
+
+            pnv_sbe_set_host_doorbell(sbe, sbe->host_doorbell | SBE_HOST_RESPONSE_MASK);
+
+            /* Preserve memory regions and CPU state, if MPIPL is registered */
+            do_mpipl_preserve(pnv);
+
+            /*
+             * Control may not come back here as 'do_mpipl_preserve' triggers
+             * a guest reboot
+             */
+            break;
+        case SBE_CONTROL_REG_S1:
+            qemu_log_mask(LOG_UNIMP, "SBE: S1 Interrupt triggered\n");
+            break;
+        default:
+            qemu_log_mask(LOG_UNIMP,
+                "SBE: CONTROL_REG_RW: Unknown value: Ox%."
+                  HWADDR_PRIx "\n", val);
+        }
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "SBE Unimplemented register: Ox%"
                       HWADDR_PRIx "\n", addr >> 3);
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index f7dac87a2a..c61fba4ec8 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -56,6 +56,7 @@ ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
   'pnv_pnor.c',
   'pnv_nest_pervasive.c',
   'pnv_n1_chiplet.c',
+  'pnv_mpipl.c',
 ))
 # PowerPC 4xx boards
 ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
-- 
2.52.0


