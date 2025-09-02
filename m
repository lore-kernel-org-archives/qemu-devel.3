Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FA6CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI2w-0007lF-MS; Mon, 01 Sep 2025 23:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2Z-0007I0-8E
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2V-0004xR-Vr
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:39 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S7TL030605
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=cmHumC5ToeVsNjzJmH0QFkzMTRIwHtIPnrPpsXwEdwc=; b=Ts
 fFlGrtodT5j7QKUWnC8dRYlnvlw05SVSk1nTdWOGha1tWJUBKM0mX57T7xvSi6vF
 XdT4MTEAhMc5gfXoS3IJuF8MANbYDh2yEfwlPgBuK9ndoU/Zi6f6gHz1Bb2ygzZZ
 7hSlQZPxe2Wkezvmmjz9A2FaPInMQu3n2fzBotGoDbvDgsJw6DOCmCKBqUrTmULF
 JQsSa2nXKeVytNyd2G5UVc6m8WBg20+MsfaOreMuaOWHgbjyRsw1npCs0mQqYkI/
 R+xTChGgfCThwrnnd74kyUAqjtUkbyc0ZudhIp/MT0bbVZbNVg7UKxSJ0T8ZZEQa
 RmEuTpeO9ktM+nBUldwA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8pc64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:50:24 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-329e07f7046so418505a91.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785014; x=1757389814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cmHumC5ToeVsNjzJmH0QFkzMTRIwHtIPnrPpsXwEdwc=;
 b=mltY0XOZBOuVsTBBNh176JFDYOErI9yfNdyd1w4fA9JsUJcntuIKsqljUBCNXm6nP5
 vzDhaRbM5okMUpFoOrWC1YPqxKzDPUERP7g9NDlTfYoTZ1iHkBmkLtEtIysy7SEDcCaj
 IXUXo4GEd29VrOFXmACXUwWwXZqZs2hHjl3bwjmHUp9f8MP7wzX4vZ+gUedlAx0AYKmU
 rBzLFCUFEbyKSh5T6EmIvNBYGQ0z3ygWQiAHMrZBWznUKcFk72oauJbfULUXS9WUaLXs
 Nmc7SNHiQYgvXPITKBbIDX2RNm9D2Fh8j3Yo99zN06wL8G3iHre8dmn5St7v4dcFp7/S
 iFjw==
X-Gm-Message-State: AOJu0YxyHI0zTQMEr+qAvO0Ye0vR2t1laS+0wwHBAPlfTHGb48JEzkuc
 KSDP8piXYEOW8EcCcb8mKeYx8qdF7wLKqp1qohH4h2tWIfBBjQbxX2uEW/z1U7Lti8uTU1QDTfo
 yabhl5NiN3iNvDOSJZ0PLnYmkR+jPLB1W+xYKZucgS7aHds5SDqE//BdS8O4TGieGZ5fO
X-Gm-Gg: ASbGncu5G0wDhJGdaQBp/IwbitUXjroS7s8yyIOCgCGnOcu1N5R2OReHygm1BkkYvl/
 OIphpyjxiVOBmRvemoqStjOKG2HgUw0QNjOggofEqyaTBRtsubkP1/dNhvlopntrEMyyymLUmjw
 WGEgo8W9XAK4kXf43oaydm0fPTz2sFvCNtRFtiWz9hxOKxTFGXixf/iEvgvn5sHcHum57xOv+wK
 y4bvxTdY763kLUg4LZJ65mZzUCIvRbAoP/rdqMeHvLGQHa8UiowJyRB/jCUJ92Qi2fRCuRMs2q3
 1F1FpCy4TmQAnU86lCLZs1+hpeEJPqL6aWQ3aX2500GNAxwoguoOxJSPNXkLtCD9qk5QYmHXj4y
 1xWEXut1gbPhG
X-Received: by 2002:a17:90b:1d48:b0:327:75c9:bea9 with SMTP id
 98e67ed59e1d1-328156b638amr14157215a91.24.1756785013513; 
 Mon, 01 Sep 2025 20:50:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+Nu6CDVOUMRAuEkmxOaeanJDzMxBaxJBahezHZyPw1MgG9KzFtMqIq3kVMuGdaIt4I9FKTA==
X-Received: by 2002:a17:90b:1d48:b0:327:75c9:bea9 with SMTP id
 98e67ed59e1d1-328156b638amr14157162a91.24.1756785012796; 
 Mon, 01 Sep 2025 20:50:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327c5fc5055sm14117932a91.14.2025.09.01.20.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:50:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Sid Manning <sidneym@quicinc.com>,
 Damien Hedde <damien.hedde@dahe.fr>,
 =?UTF-8?q?Tobias=20R=C3=B6hmel?= <quic_trohmel@quicinc.com>
Subject: [PATCH v2 10/11] hw/timer: Add QTimer device
Date: Mon,  1 Sep 2025 20:49:50 -0700
Message-Id: <20250902034951.1948194-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
References: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FhVAV4T0OQMy-yLGiKP035bN6N7XkEL3
X-Proofpoint-GUID: FhVAV4T0OQMy-yLGiKP035bN6N7XkEL3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfXxdLP1uliTDOO
 QHCLTkLW7LJ8WNP1Zm+0Ir1K9wSVU/7KbRSYzjsMqTJ30VTv99IheygkLjptV13nwUQBQfi4R6r
 mAKKDdrQeTGiyI5Db1mDqEKnFfVeA+fbrTcCnMQTZC0Zdk+L3RdevdazT7nzDBBcjSBgTr+ybi6
 QF+yd+MPwmrSCp8nTdhlwRUvLJBtYUmT+lTOqspeMaJCpdTrQdA0gFYidfBhtH6JuLB8K6PA1jI
 qA8GJuNAGzLzodEIMBvfI5Ll5JFZypei3g6fwRh7SSbG4Wv5xQbOALCr+MjhLH9vYtQpBoPttVt
 GpEYB37oXrogOdjxAkv2sRi6cKSsY9HjiQk9OddwSRAEXXarjyHaWU9mrvesfkDNOQ88ra5fpjm
 gn6yAxOw
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b66980 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=Sf4xSIS_LemWqHAq_qwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Sid Manning <sidneym@quicinc.com>

Note: QTimer was implemented before ARM SSE Timer was upstreamed, there may
be opportunity to use that device instead.

Co-authored-by: Damien Hedde <damien.hedde@dahe.fr>
Co-authored-by: Tobias Röhmel <quic_trohmel@quicinc.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 MAINTAINERS                    |   2 +
 include/hw/timer/qct-qtimer.h  |  85 ++++++
 hw/hexagon/hexagon_dsp.c       |   7 +-
 hw/hexagon/hexagon_globalreg.c |   9 +-
 hw/hexagon/virt.c              |  22 ++
 hw/timer/qct-qtimer.c          | 520 +++++++++++++++++++++++++++++++++
 hw/timer/meson.build           |   2 +
 7 files changed, 642 insertions(+), 5 deletions(-)
 create mode 100644 include/hw/timer/qct-qtimer.h
 create mode 100644 hw/timer/qct-qtimer.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e19fcf9e69..4f7748679b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -230,7 +230,9 @@ M: Brian Cain <brian.cain@oss.qualcomm.com>
 S: Supported
 F: target/hexagon/
 F: hw/hexagon/
+F: hw/timer/qct-qtimer.c
 F: include/hw/hexagon/
+F: include/hw/timer/qct-qtimer.h
 X: target/hexagon/idef-parser/
 X: target/hexagon/gen_idef_parser_funcs.py
 F: linux-user/hexagon/
diff --git a/include/hw/timer/qct-qtimer.h b/include/hw/timer/qct-qtimer.h
new file mode 100644
index 0000000000..90f7981ccf
--- /dev/null
+++ b/include/hw/timer/qct-qtimer.h
@@ -0,0 +1,85 @@
+/*
+ * Qualcomm QCT QTimer
+ *
+ * Copyright(c) 2019-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef TIMER_QCT_QTIMER_H
+#define TIMER_QCT_QTIMER_H
+
+#include "hw/ptimer.h"
+#include "hw/sysbus.h"
+
+#define TYPE_QCT_QTIMER "qct-qtimer"
+#define TYPE_QCT_HEXTIMER "qct-hextimer"
+OBJECT_DECLARE_SIMPLE_TYPE(QCTQtimerState, QCT_QTIMER)
+OBJECT_DECLARE_SIMPLE_TYPE(QCTHextimerState, QCT_HEXTIMER)
+
+struct QCTHextimerState {
+    QCTQtimerState *qtimer;
+    ptimer_state *timer;
+    uint64_t cntval; /*
+                      * Physical timer compare value interrupt when cntpct >
+                      * cntval
+                      */
+    uint64_t cntpct; /* Physical counter */
+    uint32_t control;
+    uint32_t cnt_ctrl;
+    uint32_t cntpl0acr;
+    uint64_t limit;
+    uint32_t freq;
+    uint32_t int_level;
+    qemu_irq irq;
+};
+
+#define QCT_QTIMER_TIMER_FRAME_ELTS (8)
+#define QCT_QTIMER_TIMER_VIEW_ELTS (2)
+struct QCTQtimerState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    MemoryRegion view_iomem;
+    uint32_t secure;
+    struct QCTHextimerState timer[QCT_QTIMER_TIMER_FRAME_ELTS];
+    uint32_t frame_id;
+    uint32_t freq;
+    uint32_t nr_frames;
+    uint32_t nr_views;
+    uint32_t cnttid;
+};
+
+#define QCT_QTIMER_AC_CNTFRQ (0x000)
+#define QCT_QTIMER_AC_CNTSR (0x004)
+#define QCT_QTIMER_AC_CNTSR_NSN_1 (1 << 0)
+#define QCT_QTIMER_AC_CNTSR_NSN_2 (1 << 1)
+#define QCT_QTIMER_AC_CNTSR_NSN_3 (1 << 2)
+#define QCT_QTIMER_AC_CNTTID (0x08)
+#define QCT_QTIMER_AC_CNTACR_0 (0x40)
+#define QCT_QTIMER_AC_CNTACR_1 (0x44)
+#define QCT_QTIMER_AC_CNTACR_2 (0x48)
+#define QCT_QTIMER_AC_CNTACR_RWPT (1 << 5) /* R/W of CNTP_* regs */
+#define QCT_QTIMER_AC_CNTACR_RWVT (1 << 4) /* R/W of CNTV_* regs */
+#define QCT_QTIMER_AC_CNTACR_RVOFF (1 << 3) /* R/W of CNTVOFF register */
+#define QCT_QTIMER_AC_CNTACR_RFRQ (1 << 2) /* R/W of CNTFRQ register */
+#define QCT_QTIMER_AC_CNTACR_RPVCT (1 << 1) /* R/W of CNTVCT register */
+#define QCT_QTIMER_AC_CNTACR_RPCT (1 << 0) /* R/W of CNTPCT register */
+#define QCT_QTIMER_VERSION (0x0fd0)
+#define QCT_QTIMER_CNTPCT_LO (0x000)
+#define QCT_QTIMER_CNTPCT_HI (0x004)
+#define QCT_QTIMER_CNT_FREQ (0x010)
+#define QCT_QTIMER_CNTPL0ACR (0x014)
+#define QCT_QTIMER_CNTPL0ACR_PL0CTEN (1 << 9)
+#define QCT_QTIMER_CNTPL0ACR_PL0TVEN (1 << 8)
+#define QCT_QTIMER_CNTPL0ACR_PL0VCTEN (1 << 1)
+#define QCT_QTIMER_CNTPL0ACR_PL0PCTEN (1 << 0)
+#define QCT_QTIMER_CNTP_CVAL_LO (0x020)
+#define QCT_QTIMER_CNTP_CVAL_HI (0x024)
+#define QCT_QTIMER_CNTP_TVAL (0x028)
+#define QCT_QTIMER_CNTP_CTL (0x02c)
+#define QCT_QTIMER_CNTP_CTL_ISTAT (1 << 2)
+#define QCT_QTIMER_CNTP_CTL_INTEN (1 << 1)
+#define QCT_QTIMER_CNTP_CTL_ENABLE (1 << 0)
+#define QCT_QTIMER_AC_CNTACR_START 0x40
+#define QCT_QTIMER_AC_CNTACR_END 0x5C
+
+#endif /* TIMER_QCT_QTIMER_H */
diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
index 510378280e..e0e39fca90 100644
--- a/hw/hexagon/hexagon_dsp.c
+++ b/hw/hexagon/hexagon_dsp.c
@@ -3,7 +3,6 @@
  * subsystem with few peripherals, like the Compute DSP.
  *
  * Copyright (c) 2020-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
- *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
@@ -126,7 +125,11 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
          */
         qdev_prop_set_bit(DEVICE(cpu), "start-powered-off", (i != 0));
         qdev_prop_set_uint32(DEVICE(cpu), "l2vic-base-addr", m_cfg->l2vic_base);
-        qdev_prop_set_uint32(DEVICE(cpu), "config-table-addr", m_cfg->cfgbase);
+        if (!object_property_set_link(OBJECT(cpu), "global-regs",
+                                      OBJECT(glob_regs_dev), errp)) {
+            error_report("Failed to link global system registers to CPU %d", i);
+            return;
+        }
         qdev_prop_set_uint32(DEVICE(cpu), "hvx-contexts",
                              m_cfg->cfgtable.ext_contexts);
         qdev_prop_set_uint32(DEVICE(cpu), "jtlb-entries",
diff --git a/hw/hexagon/hexagon_globalreg.c b/hw/hexagon/hexagon_globalreg.c
index fcbf2ae4b2..c94d2c4c7f 100644
--- a/hw/hexagon/hexagon_globalreg.c
+++ b/hw/hexagon/hexagon_globalreg.c
@@ -14,6 +14,7 @@
 #include "migration/vmstate.h"
 #include "qom/object.h"
 #include "target/hexagon/cpu.h"
+#include "hw/timer/qct-qtimer.h"
 #include "target/hexagon/hex_regs.h"
 #include "qemu/log.h"
 #include "trace/trace-hw_hexagon.h"
@@ -137,9 +138,11 @@ static inline uint32_t apply_write_mask(uint32_t new_val, uint32_t cur_val,
 
 static void read_timer(HexagonGlobalRegState *s, uint32_t *low, uint32_t *high)
 {
-    /* Not yet implemented */
-    *low = 0;
-    *high = 0;
+    const hwaddr low_addr  = s->qtimer_base_addr + QCT_QTIMER_CNTPCT_LO;
+    const hwaddr high_addr = s->qtimer_base_addr + QCT_QTIMER_CNTPCT_HI;
+
+    cpu_physical_memory_read(low_addr, low, sizeof(*low));
+    cpu_physical_memory_read(high_addr, high, sizeof(*high));
 }
 
 uint32_t hexagon_globalreg_read(HexagonCPU *cpu, uint32_t reg)
diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
index 615fde773d..c93d19ff89 100644
--- a/hw/hexagon/virt.c
+++ b/hw/hexagon/virt.c
@@ -17,6 +17,8 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
 #include "hw/register.h"
+#include "hw/timer/qct-qtimer.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
 #include "qemu/units.h"
@@ -256,6 +258,25 @@ static void fdt_add_virtio_devices(const HexagonVirtMachineState *vms)
     }
 }
 
+static void create_qtimer(HexagonVirtMachineState *vms,
+                          const hexagon_machine_config *m_cfg)
+{
+    Error **errp = NULL;
+    QCTQtimerState *qtimer = QCT_QTIMER(qdev_new(TYPE_QCT_QTIMER));
+
+    object_property_set_uint(OBJECT(qtimer), "nr_frames", 2, errp);
+    object_property_set_uint(OBJECT(qtimer), "nr_views", 1, errp);
+    object_property_set_uint(OBJECT(qtimer), "cnttid", 0x111, errp);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(qtimer), errp);
+
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(qtimer), 1, m_cfg->qtmr_region);
+    sysbus_connect_irq(SYS_BUS_DEVICE(qtimer), 0,
+                       qdev_get_gpio_in(vms->l2vic, irqmap[VIRT_QTMR0]));
+    sysbus_connect_irq(SYS_BUS_DEVICE(qtimer), 1,
+                       qdev_get_gpio_in(vms->l2vic, irqmap[VIRT_QTMR1]));
+}
+
 static void virt_instance_init(Object *obj)
 {
     HexagonVirtMachineState *vms = HEXAGON_VIRT_MACHINE(obj);
@@ -395,6 +416,7 @@ static void virt_init(MachineState *ms)
     fdt_add_clocks(vms);
     fdt_add_uart(vms, VIRT_UART0);
     fdt_add_gpt_node(vms);
+    create_qtimer(vms, m_cfg);
 
     rom_add_blob_fixed_as("config_table.rom", &m_cfg->cfgtable,
                           sizeof(m_cfg->cfgtable), m_cfg->cfgbase,
diff --git a/hw/timer/qct-qtimer.c b/hw/timer/qct-qtimer.c
new file mode 100644
index 0000000000..bd7123264c
--- /dev/null
+++ b/hw/timer/qct-qtimer.c
@@ -0,0 +1,520 @@
+/*
+ * Qualcomm QCT QTimer
+ *
+ * Copyright(c) 2019-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+
+#include "qemu/osdep.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/timer/qct-qtimer.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+
+/* Common timer implementation.  */
+
+#define QTIMER_MEM_SIZE_BYTES 0x1000
+#define QTIMER_MEM_REGION_SIZE_BYTES 0x1000
+#define QTIMER_DEFAULT_FREQ_HZ 19200000ULL
+#define QTMR_TIMER_INDEX_MASK (0xf000)
+#define HIGH_32(val) (0x0ffffffffULL & (val >> 32))
+#define LOW_32(val) (0x0ffffffffULL & val)
+
+/*
+ * QTimer version reg:
+ *
+ *    3                   2                   1
+ *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ * | Major |         Minor         |           Step                |
+ * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ */
+static unsigned int TIMER_VERSION = 0x20020000;
+
+/*
+ * qct_qtimer_read/write:
+ * if offset < 0x1000 read restricted registers:
+ * QCT_QTIMER_AC_CNTFREQ/CNTSR/CNTTID/CNTACR/CNTOFF_(LO/HI)/QCT_QTIMER_VERSION
+ */
+static uint64_t qct_qtimer_read(void *opaque, hwaddr offset, unsigned size)
+{
+    QCTQtimerState *s = (QCTQtimerState *)opaque;
+    uint32_t frame = 0;
+
+    switch (offset) {
+    case QCT_QTIMER_AC_CNTFRQ:
+        return s->freq;
+    case QCT_QTIMER_AC_CNTSR:
+        return s->secure;
+    case QCT_QTIMER_AC_CNTTID:
+        return s->cnttid;
+    case QCT_QTIMER_AC_CNTACR_START ... QCT_QTIMER_AC_CNTACR_END:
+        frame = (offset - 0x40) / 0x4;
+        if (frame >= s->nr_frames) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: QCT_QTIMER_AC_CNT: Bad offset %x\n", __func__,
+                          (int)offset);
+            return 0x0;
+        }
+        return s->timer[frame].cnt_ctrl;
+    case QCT_QTIMER_VERSION:
+        return TIMER_VERSION;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: QCT_QTIMER_AC_CNT: Bad offset %" PRIx32 "\n",
+                      __func__, (int)offset);
+        return 0x0;
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" PRIx32 "\n", __func__,
+                  (int)offset);
+    return 0;
+}
+
+static void qct_qtimer_write(void *opaque, hwaddr offset, uint64_t value,
+                             unsigned size)
+{
+    QCTQtimerState *s = (QCTQtimerState *)opaque;
+    uint32_t frame = 0;
+
+    if (offset < 0x1000) {
+        switch (offset) {
+        case QCT_QTIMER_AC_CNTFRQ:
+            s->freq = value;
+            return;
+        case QCT_QTIMER_AC_CNTSR:
+            if (value > 0xFF)
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: QCT_QTIMER_AC_CNTSR: Bad value %x\n",
+                              __func__, (int)value);
+            else
+                s->secure = value;
+            return;
+        case QCT_QTIMER_AC_CNTACR_START ... QCT_QTIMER_AC_CNTACR_END:
+            frame = (offset - QCT_QTIMER_AC_CNTACR_START) / 0x4;
+            if (frame >= s->nr_frames) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: QCT_QTIMER_AC_CNT: Bad offset %x\n",
+                              __func__, (int)offset);
+                return;
+            }
+            s->timer[frame].cnt_ctrl = value;
+            return;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: QCT_QTIMER_AC_CNT: Bad offset %x\n", __func__,
+                          (int)offset);
+            return;
+        }
+    } else
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %" PRIx32 "\n", __func__,
+                      (int)offset);
+}
+
+static const MemoryRegionOps qct_qtimer_ops = {
+    .read = qct_qtimer_read,
+    .write = qct_qtimer_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static const VMStateDescription vmstate_qct_qtimer = {
+    .name = "qct-qtimer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]){ VMSTATE_END_OF_LIST() }
+};
+
+static void qct_qtimer_init(Object *obj)
+{
+    QCTQtimerState *s = QCT_QTIMER(obj);
+
+    object_property_add_uint32_ptr(obj, "secure", &s->secure,
+                                   OBJ_PROP_FLAG_READ);
+    object_property_add_uint32_ptr(obj, "frame_id", &s->frame_id,
+                                   OBJ_PROP_FLAG_READ);
+}
+
+static void hex_timer_update(QCTHextimerState *s)
+{
+    /* Update interrupts.  */
+    int level = s->int_level && (s->control & QCT_QTIMER_CNTP_CTL_ENABLE);
+    qemu_set_irq(s->irq, level);
+}
+
+static MemTxResult hex_timer_read(void *opaque, hwaddr offset, uint64_t *data,
+                                  unsigned size, MemTxAttrs attrs)
+{
+    QCTQtimerState *qct_s = (QCTQtimerState *)opaque;
+    uint32_t slot_nr = (offset & 0xF000) >> 12;
+    uint32_t reg_offset = offset & 0xFFF;
+    uint32_t view = slot_nr % qct_s->nr_views;
+    uint32_t frame = slot_nr / qct_s->nr_views;
+
+    if (frame >= qct_s->nr_frames) {
+        *data = 0;
+        return MEMTX_ACCESS_ERROR;
+    }
+    QCTHextimerState *s = &qct_s->timer[frame];
+
+
+    /*
+     * This is the case where we have 2 views, but the second one is not
+     * implemented.
+     */
+    if (view && !(qct_s->cnttid & (0x4 << (frame * 4)))) {
+        *data = 0;
+        return MEMTX_OK;
+    }
+
+    switch (reg_offset) {
+    case (QCT_QTIMER_CNT_FREQ): /* Ticks/Second */
+        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RFRQ)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        if (view && !((s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0PCTEN) ||
+                      (s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0VCTEN))) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        *data = s->freq;
+        return MEMTX_OK;
+    case (QCT_QTIMER_CNTP_CVAL_LO): /* TimerLoad */
+        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        *data = LOW_32((s->cntval));
+        return MEMTX_OK;
+    case (QCT_QTIMER_CNTP_CVAL_HI): /* TimerLoad */
+        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        *data = HIGH_32((s->cntval));
+        return MEMTX_OK;
+    case QCT_QTIMER_CNTPCT_LO:
+        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RPCT)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0PCTEN)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        *data = LOW_32((s->cntpct + (ptimer_get_count(s->timer))));
+        return MEMTX_OK;
+    case QCT_QTIMER_CNTPCT_HI:
+        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RPCT)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0PCTEN)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        *data = HIGH_32((s->cntpct + (ptimer_get_count(s->timer))));
+        return MEMTX_OK;
+    case (QCT_QTIMER_CNTP_TVAL): /* CVAL - CNTP */
+        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        *data =
+            (s->cntval - (HIGH_32((s->cntpct + (ptimer_get_count(s->timer)))) +
+                          LOW_32((s->cntpct + (ptimer_get_count(s->timer))))));
+        return MEMTX_OK;
+    case (QCT_QTIMER_CNTP_CTL): /* TimerMIS */
+        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        *data = s->int_level;
+        return MEMTX_OK;
+    case QCT_QTIMER_CNTPL0ACR:
+        if (view) {
+            *data = 0;
+        } else {
+            *data = s->cntpl0acr;
+        }
+        return MEMTX_OK;
+
+    case QCT_QTIMER_VERSION:
+        *data = TIMER_VERSION;
+        return MEMTX_OK;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %" PRIx32 "\n", __func__,
+                      (int)offset);
+        *data = 0;
+        return MEMTX_ACCESS_ERROR;
+    }
+}
+
+/*
+ * Reset the timer limit after settings have changed.
+ * May only be called from inside a ptimer transaction block.
+ */
+static void hex_timer_recalibrate(QCTHextimerState *s, int reload)
+{
+    uint64_t limit;
+    /* Periodic.  */
+    limit = s->limit;
+    ptimer_set_limit(s->timer, limit, reload);
+}
+
+static MemTxResult hex_timer_write(void *opaque, hwaddr offset, uint64_t value,
+                                   unsigned size, MemTxAttrs attrs)
+{
+    QCTQtimerState *qct_s = (QCTQtimerState *)opaque;
+    uint32_t slot_nr = (offset & 0xF000) >> 12;
+    uint32_t reg_offset = offset & 0xFFF;
+    uint32_t view = slot_nr % qct_s->nr_views;
+    uint32_t frame = slot_nr / qct_s->nr_views;
+
+    if (frame >= qct_s->nr_frames) {
+        return MEMTX_ACCESS_ERROR;
+    }
+    QCTHextimerState *s = &qct_s->timer[frame];
+
+    /*
+     * This is the case where we have 2 views, but the second one is not
+     * implemented.
+     */
+    if (view && !(qct_s->cnttid & (0x4 << (frame * 4)))) {
+        return MEMTX_OK;
+    }
+
+    switch (reg_offset) {
+    case (QCT_QTIMER_CNTP_CVAL_LO): /* TimerLoad */
+        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+
+        s->int_level = 0;
+        s->cntval = value;
+        ptimer_transaction_begin(s->timer);
+        if (s->control & QCT_QTIMER_CNTP_CTL_ENABLE) {
+            /*
+             * Pause the timer if it is running.  This may cause some
+             * inaccuracy due to rounding, but avoids other issues.
+             */
+            ptimer_stop(s->timer);
+        }
+        hex_timer_recalibrate(s, 1);
+        if (s->control & QCT_QTIMER_CNTP_CTL_ENABLE) {
+            ptimer_run(s->timer, 0);
+        }
+        ptimer_transaction_commit(s->timer);
+        break;
+    case (QCT_QTIMER_CNTP_CVAL_HI):
+        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        break;
+    case (QCT_QTIMER_CNTP_CTL): /* Timer control register */
+        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        ptimer_transaction_begin(s->timer);
+        if (s->control & QCT_QTIMER_CNTP_CTL_ENABLE) {
+            /*
+             * Pause the timer if it is running.  This may cause some
+             * inaccuracy due to rounding, but avoids other issues.
+             */
+            ptimer_stop(s->timer);
+        }
+        s->control = value;
+        hex_timer_recalibrate(s, s->control & QCT_QTIMER_CNTP_CTL_ENABLE);
+        ptimer_set_freq(s->timer, s->freq);
+        ptimer_set_period(s->timer, 1);
+        if (s->control & QCT_QTIMER_CNTP_CTL_ENABLE) {
+            ptimer_run(s->timer, 0);
+        }
+        ptimer_transaction_commit(s->timer);
+        break;
+    case (QCT_QTIMER_CNTP_TVAL): /* CVAL - CNTP */
+        if (!(s->cnt_ctrl & QCT_QTIMER_AC_CNTACR_RWPT)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        if (view && !(s->cntpl0acr & QCT_QTIMER_CNTPL0ACR_PL0CTEN)) {
+            return MEMTX_ACCESS_ERROR;
+        }
+
+        ptimer_transaction_begin(s->timer);
+        if (s->control & QCT_QTIMER_CNTP_CTL_ENABLE) {
+            /*
+             * Pause the timer if it is running.  This may cause some
+             * inaccuracy due to rounding, but avoids other issues.
+             */
+            ptimer_stop(s->timer);
+        }
+        s->cntval = s->cntpct + value;
+        ptimer_set_freq(s->timer, s->freq);
+        ptimer_set_period(s->timer, 1);
+        if (s->control & QCT_QTIMER_CNTP_CTL_ENABLE) {
+            ptimer_run(s->timer, 0);
+        }
+        ptimer_transaction_commit(s->timer);
+        break;
+    case QCT_QTIMER_CNTPL0ACR:
+        if (view) {
+            break;
+        }
+
+        s->cntpl0acr = value;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %" PRIx32 "\n", __func__,
+                      (int)offset);
+        return MEMTX_ACCESS_ERROR;
+    }
+    hex_timer_update(s);
+    return MEMTX_OK;
+}
+
+static void hex_timer_tick(void *opaque)
+{
+    QCTHextimerState *s = (QCTHextimerState *)opaque;
+    if ((s->cntpct >= s->cntval) && (s->int_level != 1)) {
+        s->int_level = 1;
+        hex_timer_update(s);
+        return;
+    }
+    s->cntpct += s->limit;
+}
+
+static const MemoryRegionOps hex_timer_ops = {
+    .read_with_attrs = hex_timer_read,
+    .write_with_attrs = hex_timer_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static const VMStateDescription vmstate_hex_timer = {
+    .name = "hex_timer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]){ VMSTATE_UINT32(control, QCTHextimerState),
+                                VMSTATE_UINT32(cnt_ctrl, QCTHextimerState),
+                                VMSTATE_UINT64(cntpct, QCTHextimerState),
+                                VMSTATE_UINT64(cntval, QCTHextimerState),
+                                VMSTATE_UINT64(limit, QCTHextimerState),
+                                VMSTATE_UINT32(int_level, QCTHextimerState),
+                                VMSTATE_PTIMER(timer, QCTHextimerState),
+                                VMSTATE_END_OF_LIST() }
+};
+
+static void qct_qtimer_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    QCTQtimerState *s = QCT_QTIMER(dev);
+    unsigned int i;
+
+    if (s->nr_frames > QCT_QTIMER_TIMER_FRAME_ELTS) {
+        error_setg(errp, "nr_frames too high");
+        return;
+    }
+
+    if (s->nr_views > QCT_QTIMER_TIMER_VIEW_ELTS) {
+        error_setg(errp, "nr_views too high");
+        return;
+    }
+
+    memory_region_init_io(&s->iomem, OBJECT(sbd), &qct_qtimer_ops, s, "qutimer",
+                          QTIMER_MEM_SIZE_BYTES);
+    sysbus_init_mmio(sbd, &s->iomem);
+
+    memory_region_init_io(&s->view_iomem, OBJECT(sbd), &hex_timer_ops, s,
+                          "qutimer_views",
+                          QTIMER_MEM_SIZE_BYTES * s->nr_frames * s->nr_views);
+    sysbus_init_mmio(sbd, &s->view_iomem);
+
+    for (i = 0; i < s->nr_frames; i++) {
+        s->timer[i].limit = 1;
+        s->timer[i].control = QCT_QTIMER_CNTP_CTL_ENABLE;
+        s->timer[i].cnt_ctrl =
+            (QCT_QTIMER_AC_CNTACR_RWPT | QCT_QTIMER_AC_CNTACR_RWVT |
+             QCT_QTIMER_AC_CNTACR_RVOFF | QCT_QTIMER_AC_CNTACR_RFRQ |
+             QCT_QTIMER_AC_CNTACR_RPVCT | QCT_QTIMER_AC_CNTACR_RPCT);
+        s->timer[i].qtimer = s;
+        s->timer[i].freq = QTIMER_DEFAULT_FREQ_HZ;
+
+        s->secure |= (1 << i);
+
+        sysbus_init_irq(sbd, &(s->timer[i].irq));
+
+        (s->timer[i]).timer =
+            ptimer_init(hex_timer_tick, &s->timer[i], PTIMER_POLICY_LEGACY);
+        vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_hex_timer,
+                         &s->timer[i]);
+    }
+}
+
+static const Property qct_qtimer_properties[] = {
+    DEFINE_PROP_UINT32("freq", QCTQtimerState, freq, QTIMER_DEFAULT_FREQ_HZ),
+    DEFINE_PROP_UINT32("nr_frames", QCTQtimerState, nr_frames, 2),
+    DEFINE_PROP_UINT32("nr_views", QCTQtimerState, nr_views, 1),
+    DEFINE_PROP_UINT32("cnttid", QCTQtimerState, cnttid, 0x11),
+};
+
+static void qct_qtimer_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *k = DEVICE_CLASS(klass);
+
+    device_class_set_props(k, qct_qtimer_properties);
+    k->realize = qct_qtimer_realize;
+    k->vmsd = &vmstate_qct_qtimer;
+}
+
+static const TypeInfo qct_qtimer_info = {
+    .name = TYPE_QCT_QTIMER,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(QCTQtimerState),
+    .instance_init = qct_qtimer_init,
+    .class_init = qct_qtimer_class_init,
+};
+
+static void qct_qtimer_register_types(void)
+{
+    type_register_static(&qct_qtimer_info);
+}
+
+type_init(qct_qtimer_register_types)
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 178321c029..69468672bc 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -34,3 +34,5 @@ specific_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_timer.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_PWM', if_true: files('sifive_pwm.c'))
 
 specific_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
+
+specific_ss.add(when: 'CONFIG_HEX_DSP', if_true: files('qct-qtimer.c'))
-- 
2.34.1


