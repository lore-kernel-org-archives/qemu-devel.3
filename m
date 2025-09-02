Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D24ECA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI2a-0007Jo-9s; Mon, 01 Sep 2025 23:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2R-0006sD-8B
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2O-0004wc-2a
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:31 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SGBd030247
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UrDhPZtJLVtIKBvAx7rgg9kjRX/dlVATLOPeCcMw1ZM=; b=CUBqUyegjb8NvSy/
 icEjg2qZI/XJiRd0dDh36ZXDkhTd63YwQvYghXcrILfUPl2ifPSUY8MZGug4hYys
 ikfBSxi7X/2d6r0E0n7BpVUjuymgSksPWpKRbs70KjwmgYq6lNShDYoHW84fiUk4
 vPpV/6XJ4wDrXm3ZFsVmxrH7yDam0rqHPUmoXauW+eFMvwieod1XjgoBKEuEpRdW
 bFr6is2GfDVxATkSmC0svvp3WrAP8YQGv5Tbn6PtdeuSnSvOI5AhsjCl7awbGzPy
 k+NQPaKNfryYkehCyjPdkQKYrrFPfhRLYeqjNtu43CKocvUg/YR+ZX1eMooh38pF
 myb2/A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy26vp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:50:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3234811cab3so6086162a91.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785015; x=1757389815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UrDhPZtJLVtIKBvAx7rgg9kjRX/dlVATLOPeCcMw1ZM=;
 b=v3CNtlQxOKOc8/VW8BVPXWl6jTmMiicRtSCYUgOAqoPIlFZ6eC5O8T/pxHkDS5ofc6
 PJLDRQ+uQqWdV5P6lqPXb+AZumZjHj7+SqmgGK3coh2sXjL4IDPavakThU1exonYCr39
 oeMHTKKrmP5dZhk9QrPw77OwCjsW6EGARSD8hHWtNH4aMiJHbGHiJqJDbVC9jYK7tAu5
 GhdgwErDSMm2WzB2c+IUsETdcULydvITipBcL0UqUB6+aiVVp9of/ABObEgxFcnXLPRz
 Fbj4KE6qU8SQGfz1tIxXHGGlSGIQESlQejzFZJhLSCWd2T4Z/CbkKKRAj1qiPirs9NLa
 6e6A==
X-Gm-Message-State: AOJu0YzoIc1RKkFTZjQLlA6l8zgn/jZdJy4xoE3W1xLD5ceK9LdWK6Ky
 yVq5bmYSi9TzDoeRpRtej34164uY1hZzy9adZ9xngO2roj1rDvjYS5M4znYHtJpwLXVkCa82O+J
 +H/vEmGAYTU6RKlGSWcr5d4c3ATfFA6K3mVSPhVtt5DmhwR8sISn/AoOxGjaVKwjRCuJB
X-Gm-Gg: ASbGncstebyVOFfJF2vySKx4Kn5+13lI1rqwjEWt6S7nt3Yumn6GZI8YZGwxziwA1Vs
 WY4mMbgVZ8D4n7D8K25h3bqbB/DfGjtqBOlqlDngFkbW9/Tajr7qm2G7r5WoSSLAOVgSo/QCWbH
 sncEbO/MLOxK5PSa+SKFfc7Awikp4WnywOL3SBkHT+SCimsEqbDBmuQ8E67kIzs/owNcam6QHVh
 Rrh984n1hg5icthIHCMLDcC5E3wONDJR2bH0CbnwTtR7oMqsUNxHl6xki0Kd/n7j9vDXgWRj9YJ
 6hjp96lK9mrU8t2z8yd0Dn1okHYrXt/H1ZpP2Z1o006tQo2tO5e7boPrvc/WezKgHe2M+Zekpp4
 wzeBXp+tJWxdr
X-Received: by 2002:a17:90b:39c5:b0:321:c567:44bf with SMTP id
 98e67ed59e1d1-328156c9739mr11713943a91.29.1756785014648; 
 Mon, 01 Sep 2025 20:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG92VJFLhBkR7mpPulYB1tmcfYbLpwynzrCX/TM9zf18n1/zGSME/PRImuNyWlOiA2pqQHUUA==
X-Received: by 2002:a17:90b:39c5:b0:321:c567:44bf with SMTP id
 98e67ed59e1d1-328156c9739mr11713896a91.29.1756785013910; 
 Mon, 01 Sep 2025 20:50:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327c5fc5055sm14117932a91.14.2025.09.01.20.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:50:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Sid Manning <sidneym@quicinc.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Damien Hedde <damien.hedde@dahe.fr>
Subject: [PATCH v2 11/11] hw/intc: Add l2vic interrupt controller
Date: Mon,  1 Sep 2025 20:49:51 -0700
Message-Id: <20250902034951.1948194-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
References: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b66978 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=RIXGA4eaRyz-QDbuLqUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: NZRYkY0tU7I-4vNG1b0mb8pwjGIU904I
X-Proofpoint-ORIG-GUID: NZRYkY0tU7I-4vNG1b0mb8pwjGIU904I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX/8lEVdNhkQn3
 VNoBsgRdcqA/5ycYCLoOnkFSB8R7VwDctyuGRyf0kaxMl77Qi+g8Amj3OXYi6j2n78NmiPLQT4V
 8xxCgIHLtehOr9SyiLx01d9ClepKOw9KL2ku+ZLTWVPLlQdz7ipilsJ80sQSC+AuL10B6fsSZ/z
 IlO2ZR08AiAUsdKauFzR/9NUhAdlk7h97o0K682AitEST8gbKK6QPxeuS7aoIXAjwp8McNnOrUq
 nj/3um4Q+//SvWyxKd0SJeMtbUWU8q5RWSv7168qfFQzu0HVXoQ+daJIlNJiZpsrAo+5suV1GSy
 AZpxgipMZMmFy/x3K0RZvvewWVGD8I9r+xNmQfzODqstPSsyigzM2sPWfO4rp5ECJ0vhwqomUD8
 UySpS7VB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101
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

Co-authored-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Co-authored-by: Damien Hedde <damien.hedde@dahe.fr>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 MAINTAINERS                    |   2 +
 docs/devel/hexagon-l2vic.rst   |  59 +++++
 docs/devel/index-internals.rst |   1 +
 include/hw/intc/l2vic.h        |  38 +++
 hw/intc/l2vic.c                | 421 +++++++++++++++++++++++++++++++++
 hw/hexagon/Kconfig             |   1 +
 hw/intc/Kconfig                |   3 +
 hw/intc/meson.build            |   2 +
 hw/intc/trace-events           |   4 +
 9 files changed, 531 insertions(+)
 create mode 100644 docs/devel/hexagon-l2vic.rst
 create mode 100644 include/hw/intc/l2vic.h
 create mode 100644 hw/intc/l2vic.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f7748679b..228b5b672f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -233,6 +233,7 @@ F: hw/hexagon/
 F: hw/timer/qct-qtimer.c
 F: include/hw/hexagon/
 F: include/hw/timer/qct-qtimer.h
+F: hw/intc/l2vic.[ch]
 X: target/hexagon/idef-parser/
 X: target/hexagon/gen_idef_parser_funcs.py
 F: linux-user/hexagon/
@@ -245,6 +246,7 @@ F: gdb-xml/hexagon*.xml
 F: docs/system/target-hexagon.rst
 F: docs/system/hexagon/cdsp.rst
 F: docs/devel/hexagon-sys.rst
+F: docs/devel/hexagon-l2vic.rst
 T: git https://github.com/quic/qemu.git hex-next
 
 Hexagon idef-parser
diff --git a/docs/devel/hexagon-l2vic.rst b/docs/devel/hexagon-l2vic.rst
new file mode 100644
index 0000000000..0885636274
--- /dev/null
+++ b/docs/devel/hexagon-l2vic.rst
@@ -0,0 +1,59 @@
+Hexagon L2 Vectored Interrupt Controller
+========================================
+
+
+.. code-block:: none
+
+              +-------+
+              |       |             +----------------+
+              | l2vic |             |  hexagon core  |
+              |       |             |                |
+              | +-----|             |                |
+        ------> |VID0 >------------->irq2 -\         |
+        ------> |     |             |      |         |
+         ...  > |     |             |      |         |
+        ------> |     |             | <int steering> |
+              | +-----|             |   / |  | \     |
+              |  ...  |             |  |  |  |  |    |
+              | +-----|             | t0 t1 t2 t3 ...|
+        ------> |VIDN |             |                |
+        ------> |     |             |                |
+        ------> |     |             |                |
+        ------> |     |             |                |
+              | +-----|             |                |
+              |       |             |Global SREG File|
+              | State |             |                |
+              | [    ]|<============|=>[VID ]        |
+              | [    ]|<============|=>[VID1]        |
+              | [    ]|             |                |
+              | [    ]|             |                |
+              |       |             |                |
+              +-------+             +----------------+
+
+L2VIC/Core Integration
+----------------------
+
+* hexagon core supports 8 external interrupt sources
+* l2vic supports 1024 input interrupts mapped among 4 output interrupts
+* l2vic has four output signals: { VID0, VID1, VID2, VID3 }
+* l2vic device has a bank of registers per-VID that can be used to query
+  the status or assert new interrupts.
+* Interrupts are 'steered' to threads based on { thread priority, 'EX' state,
+  thread interrupt mask, thread interrupt enable, global interrupt enable,
+  etc. }.
+* Any hardware thread could conceivably handle any input interrupt, dependent
+  on state.
+* The system register transfer instruction can read the VID0-VID3 values from
+  the l2vic when reading from hexagon core system registers "VID" and "VID1".
+* When l2vic VID0 has multiple active interrupts, it pulses the VID0 output
+  IRQ and stores the IRQ number for the VID0 register field.  Only after this
+  interrupt is cleared can the l2vic pulse the VID0 output IRQ again and provide
+  the next interrupt number on the VID0 register.
+* The ``ciad`` instruction clears the l2vic input interrupt and un-disables the
+  core interrupt.  If some/an l2vic VID0 interrupt is pending when this occurs,
+  the next interrupt should fire and any subseqeunt reads of the VID register
+  should reflect the newly raised interrupt.
+* In QEMU, on an external interrupt or an unmasked-pending interrupt,
+  all vCPUs are triggered (has_work==true) and each will grab the IO lock
+  while considering the steering logic to determine whether they're the thread
+  that must handle the interrupt.
diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index 0471db8064..6620497595 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -15,6 +15,7 @@ Details about QEMU's various subsystems including how to add features to them.
    clocks
    ebpf_rss
    hexagon-sys
+   hexagon-l2vic
    migration/index
    multi-process
    reset
diff --git a/include/hw/intc/l2vic.h b/include/hw/intc/l2vic.h
new file mode 100644
index 0000000000..be845e360c
--- /dev/null
+++ b/include/hw/intc/l2vic.h
@@ -0,0 +1,38 @@
+/*
+ * QEMU L2VIC Interrupt Controller
+ *
+ * Copyright(c) 2020-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define L2VIC_VID_GRP_0 0x0 /* Read */
+#define L2VIC_VID_GRP_1 0x4 /* Read */
+#define L2VIC_VID_GRP_2 0x8 /* Read */
+#define L2VIC_VID_GRP_3 0xC /* Read */
+#define L2VIC_VID_0 0x10 /* Read SOFTWARE DEFINED */
+#define L2VIC_VID_1 0x14 /* Read SOFTWARE DEFINED NOT YET USED */
+#define L2VIC_INT_ENABLEn 0x100 /* Read/Write */
+#define L2VIC_INT_ENABLE_CLEARn 0x180 /* Write */
+#define L2VIC_INT_ENABLE_SETn 0x200 /* Write */
+#define L2VIC_INT_TYPEn 0x280 /* Read/Write */
+#define L2VIC_INT_STATUSn 0x380 /* Read */
+#define L2VIC_INT_CLEARn 0x400 /* Write */
+#define L2VIC_SOFT_INTn 0x480 /* Write */
+#define L2VIC_INT_PENDINGn 0x500 /* Read */
+#define L2VIC_INT_GRPn_0 0x600 /* Read/Write */
+#define L2VIC_INT_GRPn_1 0x680 /* Read/Write */
+#define L2VIC_INT_GRPn_2 0x700 /* Read/Write */
+#define L2VIC_INT_GRPn_3 0x780 /* Read/Write */
+
+#define L2VIC_INTERRUPT_MAX 1024
+#define L2VIC_CIAD_INSTRUCTION -1
+#define L2VIC_NO_PENDING 0xffffffff
+/*
+ * Note about l2vic groups:
+ * Each interrupt to L2VIC can be configured to associate with one of
+ * four groups.
+ * Group 0 interrupts go to IRQ2 via VID 0 (SSR: 0xC2, the default)
+ * Group 1 interrupts go to IRQ3 via VID 1 (SSR: 0xC3)
+ * Group 2 interrupts go to IRQ4 via VID 2 (SSR: 0xC4)
+ * Group 3 interrupts go to IRQ5 via VID 3 (SSR: 0xC5)
+ */
diff --git a/hw/intc/l2vic.c b/hw/intc/l2vic.c
new file mode 100644
index 0000000000..9753ba2d25
--- /dev/null
+++ b/hw/intc/l2vic.c
@@ -0,0 +1,421 @@
+/*
+ * QEMU L2VIC Interrupt Controller
+ *
+ * Arm PrimeCell PL190 Vector Interrupt Controller was used as a reference.
+ * Copyright(c) 2020-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/intc/l2vic.h"
+#include "trace.h"
+
+#define L2VICA(s, n) (s[(n) >> 2])
+
+#define TYPE_L2VIC "l2vic"
+OBJECT_DECLARE_SIMPLE_TYPE(L2VICState, L2VIC)
+
+#define SLICE_MAX (L2VIC_INTERRUPT_MAX / 32)
+
+typedef struct L2VICState {
+    SysBusDevice parent_obj;
+
+    QemuMutex active;
+    MemoryRegion iomem;
+    MemoryRegion fast_iomem;
+    uint32_t level;
+    /*
+     * offset 0:vid group 0 etc, 10 bits in each group
+     * are used:
+     */
+    uint32_t vid_group[4];
+    uint32_t vid0;
+    /* Clear Status of Active Edge interrupt, not used: */
+    uint32_t int_clear[SLICE_MAX] QEMU_ALIGNED(16);
+    /* Enable interrupt source */
+    uint32_t int_enable[SLICE_MAX] QEMU_ALIGNED(16);
+    /* Clear (set to 0) corresponding bit in int_enable */
+    uint32_t int_enable_clear;
+    /* Set (to 1) corresponding bit in int_enable */
+    uint32_t int_enable_set;
+    /* Present for debugging, not used */
+    uint32_t int_pending[SLICE_MAX] QEMU_ALIGNED(16);
+    /* Generate an interrupt */
+    uint32_t int_soft;
+    /* Which enabled interrupt is active */
+    uint32_t int_status[SLICE_MAX] QEMU_ALIGNED(16);
+    /* Edge or Level interrupt */
+    uint32_t int_type[SLICE_MAX] QEMU_ALIGNED(16);
+    /* L2 interrupt group 0-3 0x600-0x7FF */
+    uint32_t int_group_n0[SLICE_MAX] QEMU_ALIGNED(16);
+    uint32_t int_group_n1[SLICE_MAX] QEMU_ALIGNED(16);
+    uint32_t int_group_n2[SLICE_MAX] QEMU_ALIGNED(16);
+    uint32_t int_group_n3[SLICE_MAX] QEMU_ALIGNED(16);
+    qemu_irq irq[8];
+} L2VICState;
+
+
+/*
+ * Find out if this irq is associated with a group other than
+ * the default group
+ */
+static uint32_t *get_int_group(L2VICState *s, int irq)
+{
+    int n = irq & 0x1f;
+    if (n < 8) {
+        return s->int_group_n0;
+    }
+    if (n < 16) {
+        return s->int_group_n1;
+    }
+    if (n < 24) {
+        return s->int_group_n2;
+    }
+    return s->int_group_n3;
+}
+
+static int find_slice(int irq)
+{
+    return irq / 32;
+}
+
+static int get_vid(L2VICState *s, int irq)
+{
+    uint32_t *group = get_int_group(s, irq);
+    uint32_t slice = group[find_slice(irq)];
+    /* Mask with 0x7 to remove the GRP:EN bit */
+    uint32_t val = slice >> ((irq & 0x7) * 4);
+    if (val & 0x8) {
+        return val & 0x7;
+    } else {
+        return 0;
+    }
+}
+
+static inline bool vid_active(L2VICState *s)
+
+{
+    /* scan all 1024 bits in int_status arrary */
+    const int size = sizeof(s->int_status) * CHAR_BIT;
+    const int active_irq = find_first_bit((unsigned long *)s->int_status, size);
+    return ((active_irq != size)) ? true : false;
+}
+
+static bool l2vic_update(L2VICState *s, int irq)
+{
+    if (vid_active(s)) {
+        return true;
+    }
+
+    bool pending = test_bit(irq, (unsigned long *)s->int_pending);
+    bool enable = test_bit(irq, (unsigned long *)s->int_enable);
+    if (pending && enable) {
+        int vid = get_vid(s, irq);
+        set_bit(irq, (unsigned long *)s->int_status);
+        clear_bit(irq, (unsigned long *)s->int_pending);
+        clear_bit(irq, (unsigned long *)s->int_enable);
+        /* ensure the irq line goes low after going high */
+        s->vid0 = irq;
+        s->vid_group[get_vid(s, irq)] = irq;
+
+        /* already low: now call pulse */
+        /*     pulse: calls qemu_upper() and then qemu_lower()) */
+        qemu_irq_pulse(s->irq[vid + 2]);
+        trace_l2vic_delivered(irq, vid);
+        return true;
+    }
+    return false;
+}
+
+static void l2vic_update_all(L2VICState *s)
+{
+    for (int i = 0; i < L2VIC_INTERRUPT_MAX; i++) {
+        if (l2vic_update(s, i) == true) {
+            /* once vid is active, no-one else can set it until ciad */
+            return;
+        }
+    }
+}
+
+static void l2vic_set_irq(void *opaque, int irq, int level)
+{
+    L2VICState *s = (L2VICState *)opaque;
+    if (level) {
+        qemu_mutex_lock(&s->active);
+        set_bit(irq, (unsigned long *)s->int_pending);
+        qemu_mutex_unlock(&s->active);
+    }
+    l2vic_update(s, irq);
+}
+
+static void l2vic_write(void *opaque, hwaddr offset, uint64_t val,
+                        unsigned size)
+{
+    L2VICState *s = (L2VICState *)opaque;
+    qemu_mutex_lock(&s->active);
+    trace_l2vic_reg_write((unsigned)offset, (uint32_t)val);
+
+    if (offset == L2VIC_VID_0) {
+        if ((int)val != L2VIC_CIAD_INSTRUCTION) {
+            s->vid0 = val;
+        } else {
+            /* ciad issued: clear int_status */
+            clear_bit(s->vid0, (unsigned long *)s->int_status);
+        }
+    } else if (offset >= L2VIC_INT_ENABLEn &&
+               offset < (L2VIC_INT_ENABLE_CLEARn)) {
+        L2VICA(s->int_enable, offset - L2VIC_INT_ENABLEn) = val;
+    } else if (offset >= L2VIC_INT_ENABLE_CLEARn &&
+               offset < L2VIC_INT_ENABLE_SETn) {
+        L2VICA(s->int_enable, offset - L2VIC_INT_ENABLE_CLEARn) &= ~val;
+    } else if (offset >= L2VIC_INT_ENABLE_SETn && offset < L2VIC_INT_TYPEn) {
+        L2VICA(s->int_enable, offset - L2VIC_INT_ENABLE_SETn) |= val;
+    } else if (offset >= L2VIC_INT_TYPEn && offset < L2VIC_INT_TYPEn + 0x80) {
+        L2VICA(s->int_type, offset - L2VIC_INT_TYPEn) = val;
+    } else if (offset >= L2VIC_INT_STATUSn && offset < L2VIC_INT_CLEARn) {
+        L2VICA(s->int_status, offset - L2VIC_INT_STATUSn) = val;
+    } else if (offset >= L2VIC_INT_CLEARn && offset < L2VIC_SOFT_INTn) {
+        L2VICA(s->int_clear, offset - L2VIC_INT_CLEARn) = val;
+    } else if (offset >= L2VIC_INT_PENDINGn &&
+               offset < L2VIC_INT_PENDINGn + 0x80) {
+        L2VICA(s->int_pending, offset - L2VIC_INT_PENDINGn) = val;
+    } else if (offset >= L2VIC_SOFT_INTn && offset < L2VIC_INT_PENDINGn) {
+        L2VICA(s->int_enable, offset - L2VIC_SOFT_INTn) |= val;
+        /*
+         *  Need to reverse engineer the actual irq number.
+         */
+        int irq = find_first_bit((unsigned long *)&val,
+                                 sizeof(s->int_enable[0]) * CHAR_BIT);
+        hwaddr byteoffset = offset - L2VIC_SOFT_INTn;
+        g_assert(irq != sizeof(s->int_enable[0]) * CHAR_BIT);
+        irq += byteoffset * 8;
+
+        /* The soft-int interface only works with edge-triggered interrupts */
+        if (test_bit(irq, (unsigned long *)s->int_type)) {
+            qemu_mutex_unlock(&s->active);
+            l2vic_set_irq(opaque, irq, 1);
+            qemu_mutex_lock(&s->active);
+        }
+    } else if (offset >= L2VIC_INT_GRPn_0 && offset < L2VIC_INT_GRPn_1) {
+        L2VICA(s->int_group_n0, offset - L2VIC_INT_GRPn_0) = val;
+    } else if (offset >= L2VIC_INT_GRPn_1 && offset < L2VIC_INT_GRPn_2) {
+        L2VICA(s->int_group_n1, offset - L2VIC_INT_GRPn_1) = val;
+    } else if (offset >= L2VIC_INT_GRPn_2 && offset < L2VIC_INT_GRPn_3) {
+        L2VICA(s->int_group_n2, offset - L2VIC_INT_GRPn_2) = val;
+    } else if (offset >= L2VIC_INT_GRPn_3 && offset < L2VIC_INT_GRPn_3 + 0x80) {
+        L2VICA(s->int_group_n3, offset - L2VIC_INT_GRPn_3) = val;
+    } else {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: offset %" PRIx32 " unimplemented\n", __func__,
+                      (int)offset);
+    }
+    l2vic_update_all(s);
+    qemu_mutex_unlock(&s->active);
+    return;
+}
+
+static uint64_t l2vic_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint64_t value;
+    L2VICState *s = (L2VICState *)opaque;
+    qemu_mutex_lock(&s->active);
+
+    if (offset == L2VIC_VID_GRP_0) {
+        value = s->vid_group[0];
+    } else if (offset == L2VIC_VID_GRP_1) {
+        value = s->vid_group[1];
+    } else if (offset == L2VIC_VID_GRP_2) {
+        value = s->vid_group[2];
+    } else if (offset == L2VIC_VID_GRP_3) {
+        value = s->vid_group[3];
+    } else if (offset == L2VIC_VID_0) {
+        value = s->vid0;
+    } else if (offset >= L2VIC_INT_ENABLEn &&
+               offset < L2VIC_INT_ENABLE_CLEARn) {
+        value = L2VICA(s->int_enable, offset - L2VIC_INT_ENABLEn);
+    } else if (offset >= L2VIC_INT_ENABLE_CLEARn &&
+               offset < L2VIC_INT_ENABLE_SETn) {
+        value = 0;
+    } else if (offset >= L2VIC_INT_ENABLE_SETn && offset < L2VIC_INT_TYPEn) {
+        value = 0;
+    } else if (offset >= L2VIC_INT_TYPEn && offset < L2VIC_INT_TYPEn + 0x80) {
+        value = L2VICA(s->int_type, offset - L2VIC_INT_TYPEn);
+    } else if (offset >= L2VIC_INT_STATUSn && offset < L2VIC_INT_CLEARn) {
+        value = L2VICA(s->int_status, offset - L2VIC_INT_STATUSn);
+    } else if (offset >= L2VIC_INT_CLEARn && offset < L2VIC_SOFT_INTn) {
+        value = L2VICA(s->int_clear, offset - L2VIC_INT_CLEARn);
+    } else if (offset >= L2VIC_SOFT_INTn && offset < L2VIC_INT_PENDINGn) {
+        value = 0;
+    } else if (offset >= L2VIC_INT_PENDINGn &&
+               offset < L2VIC_INT_PENDINGn + 0x80) {
+        value = L2VICA(s->int_pending, offset - L2VIC_INT_PENDINGn);
+    } else if (offset >= L2VIC_INT_GRPn_0 && offset < L2VIC_INT_GRPn_1) {
+        value = L2VICA(s->int_group_n0, offset - L2VIC_INT_GRPn_0);
+    } else if (offset >= L2VIC_INT_GRPn_1 && offset < L2VIC_INT_GRPn_2) {
+        value = L2VICA(s->int_group_n1, offset - L2VIC_INT_GRPn_1);
+    } else if (offset >= L2VIC_INT_GRPn_2 && offset < L2VIC_INT_GRPn_3) {
+        value = L2VICA(s->int_group_n2, offset - L2VIC_INT_GRPn_2);
+    } else if (offset >= L2VIC_INT_GRPn_3 && offset < L2VIC_INT_GRPn_3 + 0x80) {
+        value = L2VICA(s->int_group_n3, offset - L2VIC_INT_GRPn_3);
+    } else {
+        value = 0;
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "L2VIC: %s: offset 0x%" PRIx32 "\n", __func__,
+                      (int)offset);
+    }
+
+    trace_l2vic_reg_read((unsigned)offset, value);
+    qemu_mutex_unlock(&s->active);
+
+    return value;
+}
+
+static const MemoryRegionOps l2vic_ops = {
+    .read = l2vic_read,
+    .write = l2vic_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .valid.unaligned = false,
+};
+
+#define FASTL2VIC_ENABLE 0x0
+#define FASTL2VIC_DISABLE 0x1
+#define FASTL2VIC_INT 0x2
+
+static void fastl2vic_write(void *opaque, hwaddr offset, uint64_t val,
+                            unsigned size)
+{
+    if (offset == 0) {
+        uint32_t cmd = (val >> 16) & 0x3;
+        uint32_t irq = val & 0x3ff;
+        uint32_t slice = (irq / 32) * 4;
+        val = 1 << (irq % 32);
+
+        if (cmd == FASTL2VIC_ENABLE) {
+            l2vic_write(opaque, L2VIC_INT_ENABLE_SETn + slice, val, size);
+        } else if (cmd == FASTL2VIC_DISABLE) {
+            l2vic_write(opaque, L2VIC_INT_ENABLE_CLEARn + slice, val, size);
+        } else if (cmd == FASTL2VIC_INT) {
+            l2vic_write(opaque, L2VIC_SOFT_INTn + slice, val, size);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: invalid write cmd %" PRId32 "\n",
+                          __func__, cmd);
+        }
+        return;
+    }
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid write offset 0x%08" HWADDR_PRIx
+            "\n", __func__, offset);
+}
+
+static const MemoryRegionOps fastl2vic_ops = {
+    .write = fastl2vic_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .valid.unaligned = false,
+};
+
+static void l2vic_reset_hold(Object *obj, G_GNUC_UNUSED ResetType res_type)
+{
+    L2VICState *s = L2VIC(obj);
+    memset(s->int_clear, 0, sizeof(s->int_clear));
+    memset(s->int_enable, 0, sizeof(s->int_enable));
+    memset(s->int_pending, 0, sizeof(s->int_pending));
+    memset(s->int_status, 0, sizeof(s->int_status));
+    memset(s->int_type, 0, sizeof(s->int_type));
+    memset(s->int_group_n0, 0, sizeof(s->int_group_n0));
+    memset(s->int_group_n1, 0, sizeof(s->int_group_n1));
+    memset(s->int_group_n2, 0, sizeof(s->int_group_n2));
+    memset(s->int_group_n3, 0, sizeof(s->int_group_n3));
+    s->int_soft = 0;
+    s->vid0 = 0;
+
+    l2vic_update_all(s);
+}
+
+
+static void reset_irq_handler(void *opaque, int irq, int level)
+{
+    L2VICState *s = (L2VICState *)opaque;
+    Object *obj = OBJECT(opaque);
+    if (level) {
+        l2vic_reset_hold(obj, RESET_TYPE_COLD);
+    }
+    l2vic_update_all(s);
+}
+
+static void l2vic_init(Object *obj)
+{
+    DeviceState *dev = DEVICE(obj);
+    L2VICState *s = L2VIC(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    int i;
+
+    memory_region_init_io(&s->iomem, obj, &l2vic_ops, s, "l2vic", 0x1000);
+    sysbus_init_mmio(sbd, &s->iomem);
+    memory_region_init_io(&s->fast_iomem, obj, &fastl2vic_ops, s, "fast",
+                          0x10000);
+    sysbus_init_mmio(sbd, &s->fast_iomem);
+
+    qdev_init_gpio_in(dev, l2vic_set_irq, L2VIC_INTERRUPT_MAX);
+    qdev_init_gpio_in_named(dev, reset_irq_handler, "reset", 1);
+    for (i = 0; i < 8; i++) {
+        sysbus_init_irq(sbd, &s->irq[i]);
+    }
+    qemu_mutex_init(&s->active); /* TODO: Remove this is an experiment */
+}
+
+static const VMStateDescription vmstate_l2vic = {
+    .name = "l2vic",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields =
+        (VMStateField[]){
+            VMSTATE_UINT32(level, L2VICState),
+            VMSTATE_UINT32_ARRAY(vid_group, L2VICState, 4),
+            VMSTATE_UINT32(vid0, L2VICState),
+            VMSTATE_UINT32_ARRAY(int_enable, L2VICState, SLICE_MAX),
+            VMSTATE_UINT32(int_enable_clear, L2VICState),
+            VMSTATE_UINT32(int_enable_set, L2VICState),
+            VMSTATE_UINT32_ARRAY(int_type, L2VICState, SLICE_MAX),
+            VMSTATE_UINT32_ARRAY(int_status, L2VICState, SLICE_MAX),
+            VMSTATE_UINT32_ARRAY(int_clear, L2VICState, SLICE_MAX),
+            VMSTATE_UINT32(int_soft, L2VICState),
+            VMSTATE_UINT32_ARRAY(int_pending, L2VICState, SLICE_MAX),
+            VMSTATE_UINT32_ARRAY(int_group_n0, L2VICState, SLICE_MAX),
+            VMSTATE_UINT32_ARRAY(int_group_n1, L2VICState, SLICE_MAX),
+            VMSTATE_UINT32_ARRAY(int_group_n2, L2VICState, SLICE_MAX),
+            VMSTATE_UINT32_ARRAY(int_group_n3, L2VICState, SLICE_MAX),
+            VMSTATE_END_OF_LIST() }
+};
+
+static void l2vic_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &vmstate_l2vic;
+    rc->phases.hold = l2vic_reset_hold;
+}
+
+static const TypeInfo l2vic_info = {
+    .name = TYPE_L2VIC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(L2VICState),
+    .instance_init = l2vic_init,
+    .class_init = l2vic_class_init,
+};
+
+static void l2vic_register_types(void)
+{
+    type_register_static(&l2vic_info);
+}
+
+type_init(l2vic_register_types)
diff --git a/hw/hexagon/Kconfig b/hw/hexagon/Kconfig
index dc74751d21..f51c381a12 100644
--- a/hw/hexagon/Kconfig
+++ b/hw/hexagon/Kconfig
@@ -3,6 +3,7 @@ config HEX_DSP
     default y
     depends on HEXAGON && TCG
     imply PTIMER
+    select L2VIC
 
 config HEX_VIRT
     bool
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 7547528f2c..a5b136e2fa 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -8,6 +8,9 @@ config I8259
 config PL190
     bool
 
+config L2VIC
+    bool
+
 config IOAPIC
     bool
     select I8259
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 3137521a4a..9a5e0b3a73 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -67,6 +67,8 @@ specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('xics_spapr.c', 'spapr_xi
 specific_ss.add(when: 'CONFIG_XIVE', if_true: files('xive.c'))
 specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_XIVE'],
 		if_true: files('spapr_xive_kvm.c'))
+
+specific_ss.add(when: 'CONFIG_L2VIC', if_true: files('l2vic.c'))
 specific_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI_COMMON', if_true: files('loongson_ipi_common.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c'))
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 018c609ca5..327514f498 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -314,6 +314,10 @@ sh_intc_register(const char *s, int id, unsigned short v, int c, int m) "%s %u -
 sh_intc_read(unsigned size, uint64_t offset, unsigned long val) "size %u 0x%" PRIx64 " -> 0x%lx"
 sh_intc_write(unsigned size, uint64_t offset, unsigned long val) "size %u 0x%" PRIx64 " <- 0x%lx"
 sh_intc_set(int id, int enable) "setting interrupt group %d to %d"
+# l2vic.c
+l2vic_reg_write(unsigned int addr, uint32_t value) "addr: 0x%03x value: 0x%08"PRIx32
+l2vic_reg_read(unsigned int addr, uint32_t value) "addr: 0x%03x value: 0x%08"PRIx32
+l2vic_delivered(int irq, int vid) "l2vic: delivered %d (vid %d)"
 
 # loongson_ipi.c
 loongson_ipi_read(unsigned size, uint64_t addr, uint64_t val) "size: %u addr: 0x%"PRIx64 "val: 0x%"PRIx64
-- 
2.34.1


