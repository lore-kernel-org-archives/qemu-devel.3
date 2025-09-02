Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E80CA100D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI2a-0007La-Nm; Mon, 01 Sep 2025 23:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2H-0006TQ-OS
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2E-0004wZ-1b
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:20 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RodB012377
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0dJd7rPBObktu7Dct4MA8bg8pCcWYHCPBssdWvlBGw8=; b=MLIOZee5iLHYeY73
 dnPma6J1hoBip2/WiykYqikr6ugbwvTiBAHxxd3wLy/EuM4kx9qhwtRYJtflkBAV
 b/8mKvrzTNiNZavsWZATamkYMSb8jAxFuqyZRUtjyoOVKww1p3QwHIUSsvSBfLQm
 SuPBUeCsE0rTF5gHF0emR+o+ZdcX4BoK/5nb+Nz/KyV7waJwaJnjE6Vwvgtdw82+
 1vf+Xsc0hqxu9dCTChoMEy/QfiigMJS0BFhA4PKZycwbs7Q2ajD5EpwwqxrPZIvm
 8YvsBuiSPOJ7Ys4jhIp26lc57AanUB/334isxLG0vgJBji4yRGr17WwzJMk/vkVx
 6fYVJA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fea7k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:50:15 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-76e2eb787f2so5321454b3a.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785004; x=1757389804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0dJd7rPBObktu7Dct4MA8bg8pCcWYHCPBssdWvlBGw8=;
 b=PLl8pmGwyO/uqn/S3p4f0INZn+clWxgvTU9gESUo/lxTQ7/0KqWJpYM23DinK8CA1X
 2Tpak5MPo5v7/ziMpZZN/y6uRiKeUKadJc0Kvrgyg89cFJ3zUUnKC6D57OVo6bCziJGO
 bN49lpu6O2dXwv4h/j14OzkyJdSlHdUEL79+rDxtK4vU7ZdQMo3FAVHvFSBIsb9Y0JyU
 3oIsecjnBPky3os3kfZUBNoXBpQ1DdmCnGyvuIeBQdBYMd6AZsbTE4lzo8MGT4IooFWg
 H3OM4YMqDbopplFT9Enx25y4J1Zal8aINYBn6iSD9t4TaS6wN9+8UKzdzB6zsd+Q1AJg
 6OYg==
X-Gm-Message-State: AOJu0YxA5KF7kFuVZbFcaKIJC3jtbGMZspjgUd7Nh6TihSY252EHYnsv
 QzqCrH5Dq7/KuNQ5U5vz+O2D/SYRcuqcTMAgQeyigpkV95znDnyZn6b+7ND4oe31s2QM3W73cbd
 Bp26qyEON9fgadyaOiH9VxV2Xg4lTTWPru9qjpxDV+ILVvOKJjieKL7hugIgNypfL1/C5
X-Gm-Gg: ASbGncvqVTPZ81pvX/EU6RQDkKOum3XgQf4BQ9/qZUKw5tbPrMTXImB4ph0WHJ3m1Cc
 LYBW8Wi1rJvfddFAoAz6o6XjNL08m8C5LUNgvPHt6xyUJxN8nsubLk3ehGoRF766+WhIRPtZcIl
 BN19onYhIkMXL01ZvKSEvGDOK4Cvl3mFJYMZ57SG7nyE/Sgb35JTDRVvwrQcsnBIEeybvP8ItI8
 FpDCkh8Kf/obmCAO/In8r4SlVUOqzD6s4H5RwMYCb+uB+DSLZgFJIbkqq4xM782goZUUm604CHn
 1E4yitaeK1ZvK7YfkSqNIcvxPPMI2ne2uyrfLmywjwMo6nM9zJ5bprVXE1Ggkdb8UbZDdbttPIU
 4r3k1Z1c19+5u
X-Received: by 2002:a05:6a20:3d1c:b0:243:d52d:729d with SMTP id
 adf61e73a8af0-243d6f0ba6dmr14145302637.34.1756785003706; 
 Mon, 01 Sep 2025 20:50:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMheqv0nNu/LJw+HDJx9VN9VGZMoO6URYuYYoBm5TrqdUCvHU9CHc655n2VmxsbceQU3xpBQ==
X-Received: by 2002:a05:6a20:3d1c:b0:243:d52d:729d with SMTP id
 adf61e73a8af0-243d6f0ba6dmr14145264637.34.1756785003150; 
 Mon, 01 Sep 2025 20:50:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327c5fc5055sm14117932a91.14.2025.09.01.20.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:50:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com
Subject: [PATCH v2 01/11] hw/hexagon: Add globalreg model
Date: Mon,  1 Sep 2025 20:49:41 -0700
Message-Id: <20250902034951.1948194-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
References: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX+09BFDLzRFkj
 rgMlQQhWZee1a1MeQoiMDwPe3Bf+WclBBOpWTzWdLlbbs4oy9+D15AJovgD7hzGyALch4BfXOja
 +X7NUQXpJw9/8/zHmcopuEdxw+aBfMNiRvrc9qxIrPNNMUL2/R7Ab1sjzRJI76bSLhfxTnqg3vP
 J5kSwNBa45giFS6sDryY6gxJSK3i5/MUXCKqteMjHrZmAeSyH1s7af/n1jLtT30dzApt6sgERU8
 JLJajsI/DpGm0npLDKMVBdrLsxBUqe4cmyz1cWYpqG0HJNgzVMqV5DvaOdV0/PGuSKSWLJwgXJT
 SbWDFdCsWUEKFf/jkONXwRd2s0EIac3G+5jSHgagulW45cOlX/xbXo9RltGJCkrrbzEp9J7nVWg
 G3p3trrC
X-Proofpoint-ORIG-GUID: hEFjbdnYYBFEbwwoo9eAt1itcQywg0UT
X-Proofpoint-GUID: hEFjbdnYYBFEbwwoo9eAt1itcQywg0UT
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b66978 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VMLKkawWpi7FIoa_xNcA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Some of the system registers are shared among all threads
in the core.  This object contains the representation and
interface to the system registers.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 include/hw/hexagon/hexagon_globalreg.h |  60 ++++++
 target/hexagon/cpu.h                   |   1 +
 hw/hexagon/hexagon_globalreg.c         | 269 +++++++++++++++++++++++++
 target/hexagon/cpu.c                   |   2 +
 4 files changed, 332 insertions(+)
 create mode 100644 include/hw/hexagon/hexagon_globalreg.h
 create mode 100644 hw/hexagon/hexagon_globalreg.c

diff --git a/include/hw/hexagon/hexagon_globalreg.h b/include/hw/hexagon/hexagon_globalreg.h
new file mode 100644
index 0000000000..01eac06056
--- /dev/null
+++ b/include/hw/hexagon/hexagon_globalreg.h
@@ -0,0 +1,60 @@
+/*
+ * Hexagon Global Registers QOM Object
+ *
+ * Copyright(c) 2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HEXAGON_GLOBALREG_H
+#define HEXAGON_GLOBALREG_H
+
+#include "hw/qdev-core.h"
+#include "hw/sysbus.h"
+#include "qom/object.h"
+#include "target/hexagon/cpu.h"
+
+#define TYPE_HEXAGON_GLOBALREG "hexagon-globalreg"
+OBJECT_DECLARE_SIMPLE_TYPE(HexagonGlobalRegState, HEXAGON_GLOBALREG)
+
+struct HexagonGlobalRegState {
+    SysBusDevice parent_obj;
+
+    /* Array of system registers */
+    target_ulong regs[NUM_SREGS];
+
+    /* Global performance cycle counter base */
+    uint64_t g_pcycle_base;
+
+    /* Properties for global register reset values */
+    uint32_t boot_evb;           /* Boot Exception Vector Base (HEX_SREG_EVB) */
+    uint64_t config_table_addr;  /* Configuration table base */
+    uint32_t dsp_rev;           /* DSP revision register (HEX_SREG_REV) */
+
+    /* ISDB properties */
+    bool isdben_etm_enable;     /* ISDB ETM enable bit */
+    bool isdben_dfd_enable;     /* ISDB DFD enable bit */
+    bool isdben_trusted;        /* ISDB trusted mode bit */
+    bool isdben_secure;         /* ISDB secure mode bit */
+
+    /* Hardware base addresses */
+    uint32_t qtimer_base_addr;  /* QTimer hardware base address */
+};
+
+/* Public interface functions */
+uint32_t hexagon_globalreg_read(HexagonCPU *cpu, uint32_t reg);
+void hexagon_globalreg_write(HexagonCPU *cpu, uint32_t reg,
+                             uint32_t value);
+uint32_t hexagon_globalreg_masked_value(HexagonCPU *cpu, uint32_t reg,
+                                        uint32_t value);
+void hexagon_globalreg_write_masked(HexagonCPU *cpu, uint32_t reg,
+                                    uint32_t value);
+void hexagon_globalreg_reset(HexagonCPU *cpu);
+
+/* Global performance cycle counter access */
+uint64_t hexagon_globalreg_get_pcycle_base(HexagonCPU *cpu);
+void hexagon_globalreg_set_pcycle_base(HexagonCPU *cpu, uint64_t value);
+
+/* Hardware base address access */
+uint32_t hexagon_globalreg_get_qtimer_base_addr(HexagonCPU *cpu);
+
+#endif /* HEXAGON_GLOBALREG_H */
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 39d6983263..89c634a09c 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -197,6 +197,7 @@ struct ArchCPU {
     uint32_t num_tlbs;
     uint32_t l2vic_base_addr;
     uint32_t boot_addr;
+    struct HexagonGlobalRegState *globalregs;
 #endif
 };
 
diff --git a/hw/hexagon/hexagon_globalreg.c b/hw/hexagon/hexagon_globalreg.c
new file mode 100644
index 0000000000..da943f7261
--- /dev/null
+++ b/hw/hexagon/hexagon_globalreg.c
@@ -0,0 +1,269 @@
+/*
+ * Hexagon Global Registers
+ *
+ * Copyright(c) 2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hexagon/hexagon.h"
+#include "hw/hexagon/hexagon_globalreg.h"
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "hw/resettable.h"
+#include "migration/vmstate.h"
+#include "qom/object.h"
+#include "target/hexagon/cpu.h"
+#include "target/hexagon/hex_regs.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+
+#define IMMUTABLE (~0)
+#define INVALID_REG_VAL 0xdeadbeef
+
+/* Global system register mutability masks */
+static const uint32_t global_sreg_immut_masks[NUM_SREGS] = {
+    [HEX_SREG_EVB] = 0x000000ff,
+    [HEX_SREG_MODECTL] = IMMUTABLE,
+    [HEX_SREG_SYSCFG] = 0x80001c00,
+    [HEX_SREG_IPENDAD] = IMMUTABLE,
+    [HEX_SREG_VID] = 0xfc00fc00,
+    [HEX_SREG_VID1] = 0xfc00fc00,
+    [HEX_SREG_BESTWAIT] = 0xfffffe00,
+    [HEX_SREG_IAHL] = 0x00000000,
+    [HEX_SREG_SCHEDCFG] = 0xfffffee0,
+    [HEX_SREG_CFGBASE] = IMMUTABLE,
+    [HEX_SREG_DIAG] = 0x00000000,
+    [HEX_SREG_REV] = IMMUTABLE,
+    [HEX_SREG_ISDBST] = IMMUTABLE,
+    [HEX_SREG_ISDBCFG0] = 0xe0000000,
+    [HEX_SREG_BRKPTPC0] = 0x00000003,
+    [HEX_SREG_BRKPTCFG0] = 0xfc007000,
+    [HEX_SREG_BRKPTPC1] = 0x00000003,
+    [HEX_SREG_BRKPTCFG1] = 0xfc007000,
+    [HEX_SREG_ISDBMBXIN] = IMMUTABLE,
+    [HEX_SREG_ISDBMBXOUT] = 0x00000000,
+    [HEX_SREG_ISDBEN] = 0xfffffffe,
+    [HEX_SREG_TIMERLO] = IMMUTABLE,
+    [HEX_SREG_TIMERHI] = IMMUTABLE,
+};
+
+static void hexagon_globalreg_init(Object *obj)
+{
+    HexagonGlobalRegState *s = HEXAGON_GLOBALREG(obj);
+
+    memset(s->regs, 0, sizeof(target_ulong) * NUM_SREGS);
+}
+
+static inline uint32_t apply_write_mask(uint32_t new_val, uint32_t cur_val,
+                                        uint32_t reg_mask)
+{
+    if (reg_mask) {
+        return (new_val & ~reg_mask) | (cur_val & reg_mask);
+    }
+    return new_val;
+}
+
+static void read_timer(HexagonGlobalRegState *s, uint32_t *low, uint32_t *high)
+{
+    /* Not yet implemented */
+    *low = 0;
+    *high = 0;
+}
+
+uint32_t hexagon_globalreg_read(HexagonCPU *cpu, uint32_t reg)
+{
+    g_assert(reg < NUM_SREGS);
+    g_assert(reg >= HEX_SREG_GLB_START);
+    HexagonGlobalRegState *s = cpu->globalregs;
+    g_assert(s);
+
+    uint32_t value;
+    uint32_t low;
+    uint32_t high;
+    if ((reg == HEX_SREG_TIMERLO) || (reg == HEX_SREG_TIMERHI)) {
+        read_timer(s, &low, &high);
+        value = (reg == HEX_SREG_TIMERLO) ? low : high;
+    } else {
+        value = s->regs[reg];
+    }
+
+    return value;
+}
+
+void hexagon_globalreg_write(HexagonCPU *cpu, uint32_t reg,
+                             uint32_t value)
+{
+    HexagonGlobalRegState *s = cpu->globalregs;
+    g_assert(s);
+    g_assert(reg < NUM_SREGS);
+    g_assert(reg >= HEX_SREG_GLB_START);
+    s->regs[reg] = value;
+}
+
+uint32_t hexagon_globalreg_masked_value(HexagonCPU *cpu, uint32_t reg,
+                                        uint32_t value)
+{
+    HexagonGlobalRegState *s = cpu->globalregs;
+    g_assert(s);
+    g_assert(reg < NUM_SREGS);
+    g_assert(reg >= HEX_SREG_GLB_START);
+    const uint32_t reg_mask = global_sreg_immut_masks[reg];
+    return reg_mask == IMMUTABLE ?
+            s->regs[reg] :
+            apply_write_mask(value, s->regs[reg], reg_mask);
+}
+
+void hexagon_globalreg_write_masked(HexagonCPU *cpu, uint32_t reg,
+                                    uint32_t value)
+{
+    HexagonGlobalRegState *s = cpu->globalregs;
+    g_assert(s);
+    s->regs[reg] = hexagon_globalreg_masked_value(cpu, reg, value);
+}
+
+uint64_t hexagon_globalreg_get_pcycle_base(HexagonCPU *cpu)
+{
+    HexagonGlobalRegState *s = cpu->globalregs;
+    g_assert(s);
+    return s->g_pcycle_base;
+}
+
+void hexagon_globalreg_set_pcycle_base(HexagonCPU *cpu, uint64_t value)
+{
+    HexagonGlobalRegState *s = cpu->globalregs;
+    g_assert(s);
+    s->g_pcycle_base = value;
+}
+
+uint32_t hexagon_globalreg_get_qtimer_base_addr(HexagonCPU *cpu)
+{
+    HexagonGlobalRegState *s = cpu->globalregs;
+    g_assert(s);
+    return s->qtimer_base_addr;
+}
+
+static void do_hexagon_globalreg_reset(HexagonGlobalRegState *s)
+{
+    g_assert(s);
+    memset(s->regs, 0, sizeof(target_ulong) * NUM_SREGS);
+
+    s->g_pcycle_base = 0;
+
+    s->regs[HEX_SREG_EVB] = s->boot_evb;
+    s->regs[HEX_SREG_CFGBASE] = HEXAGON_CFG_ADDR_BASE(s->config_table_addr);
+    s->regs[HEX_SREG_REV] = s->dsp_rev;
+
+    target_ulong isdben_val = 0;
+    if (s->isdben_etm_enable) {
+        isdben_val |= (1 << 0);  /* ETM enable bit */
+    }
+    if (s->isdben_dfd_enable) {
+        isdben_val |= (1 << 1);  /* DFD enable bit */
+    }
+    if (s->isdben_trusted) {
+        isdben_val |= (1 << 2);  /* Trusted bit */
+    }
+    if (s->isdben_secure) {
+        isdben_val |= (1 << 3);  /* Secure bit */
+    }
+    s->regs[HEX_SREG_ISDBEN] = isdben_val;
+    s->regs[HEX_SREG_MODECTL] = 0x1;
+
+    /*
+     * These register indices are placeholders in these arrays
+     * and their actual values are synthesized from state elsewhere.
+     * We can initialize these with invalid values so that if we
+     * mistakenly generate reads, they will look obviously wrong.
+     */
+    s->regs[HEX_SREG_PCYCLELO] = INVALID_REG_VAL;
+    s->regs[HEX_SREG_PCYCLEHI] = INVALID_REG_VAL;
+    s->regs[HEX_SREG_TIMERLO] = INVALID_REG_VAL;
+    s->regs[HEX_SREG_TIMERHI] = INVALID_REG_VAL;
+    s->regs[HEX_SREG_PMUCNT0] = INVALID_REG_VAL;
+    s->regs[HEX_SREG_PMUCNT1] = INVALID_REG_VAL;
+    s->regs[HEX_SREG_PMUCNT2] = INVALID_REG_VAL;
+    s->regs[HEX_SREG_PMUCNT3] = INVALID_REG_VAL;
+    s->regs[HEX_SREG_PMUCNT4] = INVALID_REG_VAL;
+    s->regs[HEX_SREG_PMUCNT5] = INVALID_REG_VAL;
+    s->regs[HEX_SREG_PMUCNT6] = INVALID_REG_VAL;
+    s->regs[HEX_SREG_PMUCNT7] = INVALID_REG_VAL;
+}
+
+static void hexagon_globalreg_realize(DeviceState *dev, Error **errp)
+{
+}
+
+void hexagon_globalreg_reset(HexagonCPU *cpu)
+{
+    do_hexagon_globalreg_reset(cpu->globalregs);
+}
+
+static void hexagon_globalreg_reset_hold(Object *obj, ResetType type)
+{
+    HexagonGlobalRegState *s = HEXAGON_GLOBALREG(obj);
+    do_hexagon_globalreg_reset(s);
+}
+
+static const VMStateDescription vmstate_hexagon_globalreg = {
+    .name = "hexagon_globalreg",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]){
+        VMSTATE_UINT32_ARRAY(regs, HexagonGlobalRegState, NUM_SREGS),
+        VMSTATE_UINT64(g_pcycle_base, HexagonGlobalRegState),
+        VMSTATE_UINT32(boot_evb, HexagonGlobalRegState),
+        VMSTATE_UINT64(config_table_addr, HexagonGlobalRegState),
+        VMSTATE_UINT32(dsp_rev, HexagonGlobalRegState),
+        VMSTATE_BOOL(isdben_etm_enable, HexagonGlobalRegState),
+        VMSTATE_BOOL(isdben_dfd_enable, HexagonGlobalRegState),
+        VMSTATE_BOOL(isdben_trusted, HexagonGlobalRegState),
+        VMSTATE_BOOL(isdben_secure, HexagonGlobalRegState),
+        VMSTATE_UINT32(qtimer_base_addr, HexagonGlobalRegState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property hexagon_globalreg_properties[] = {
+    DEFINE_PROP_UINT32("boot-evb", HexagonGlobalRegState, boot_evb, 0x0),
+    DEFINE_PROP_UINT64("config-table-addr", HexagonGlobalRegState,
+                       config_table_addr, 0xffffffffULL),
+    DEFINE_PROP_UINT32("dsp-rev", HexagonGlobalRegState, dsp_rev, 0),
+    DEFINE_PROP_BOOL("isdben-etm-enable", HexagonGlobalRegState,
+                     isdben_etm_enable, false),
+    DEFINE_PROP_BOOL("isdben-dfd-enable", HexagonGlobalRegState,
+                     isdben_dfd_enable, false),
+    DEFINE_PROP_BOOL("isdben-trusted", HexagonGlobalRegState,
+                     isdben_trusted, false),
+    DEFINE_PROP_BOOL("isdben-secure", HexagonGlobalRegState,
+                     isdben_secure, false),
+    DEFINE_PROP_UINT32("qtimer-base-addr", HexagonGlobalRegState,
+                       qtimer_base_addr, 0),
+};
+
+static void hexagon_globalreg_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = hexagon_globalreg_realize;
+    rc->phases.hold = hexagon_globalreg_reset_hold;
+    dc->vmsd = &vmstate_hexagon_globalreg;
+    dc->user_creatable = false;
+    device_class_set_props(dc, hexagon_globalreg_properties);
+}
+
+static const TypeInfo hexagon_globalreg_info = {
+    .name = TYPE_HEXAGON_GLOBALREG,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(HexagonGlobalRegState),
+    .instance_init = hexagon_globalreg_init,
+    .class_init = hexagon_globalreg_class_init,
+};
+
+static void hexagon_globalreg_register_types(void)
+{
+    type_register_static(&hexagon_globalreg_info);
+}
+
+type_init(hexagon_globalreg_register_types)
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 751ba613cc..256fdc177e 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -70,6 +70,8 @@ static const Property hexagon_cpu_properties[] = {
     DEFINE_PROP_UINT32("l2vic-base-addr", HexagonCPU, l2vic_base_addr,
         0xffffffffULL),
     DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU, boot_addr, 0xffffffffULL),
+    DEFINE_PROP_LINK("global-regs", HexagonCPU, globalregs,
+                     TYPE_HEXAGON_GLOBALREG, HexagonGlobalRegState *),
 #endif
     DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
     DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_adjust, 0,
-- 
2.34.1


