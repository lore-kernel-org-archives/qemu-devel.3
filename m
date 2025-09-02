Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E1FCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0M-00076U-He; Mon, 01 Sep 2025 23:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzr-0006rC-Iz
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzp-0004UL-W2
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:51 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SAKA022312
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UzrS7Tmhe21fEajJCYweSyAeUNdh30A6PlYeRwWYTTg=; b=lP1jNOehdYE9uCXM
 MFktYgwWFpgQK19BViAJtV2tQ4slR1iAFUv6a6dyxky77doWfkqU8juohLu5BxNJ
 xYOKwoZ4Cqq9+6OgMdPOw2jdwCrj+vReLtcNAADi2dNDbTSn3tM9SGzQtQjQMkiE
 7qzsLI3cr9TQa6TGWNKtoNQZz0Yb/JZkVUjFQuQPjAxqHOBobKkfBDuVjC7TAjeT
 aKUHfLMiOE6ihVwur3O/mYDOAfuKPwmUKSD4XZAbMnhZSMIcBzJnsnRIWOsL+zbo
 I/CccEPGkL4Jyhx2cYuzVDOTtVmt86GYuxvET8U75P357Zatm6+WIchFjVj8Rarf
 QO8+uA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp6hr7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-772248bb841so5944938b3a.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784867; x=1757389667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UzrS7Tmhe21fEajJCYweSyAeUNdh30A6PlYeRwWYTTg=;
 b=ZO628hUge6oEstady5G+Oc71MPwg3m8TqPOzvhRdiXSIzC5gyqWsj/7UP2KCt9vVJj
 ZPcfzhrt9+5yl0m8bg2bXHXAKgS49poczKnZJ9C+j1OHge9XVF/3SX/GGOGcBc96up9V
 oAhQHOqv68VDbI/ONd8Lrx6vq1htsdl+8G8K+KeLvNThzMB+jQBJaEEmfUX+ibBRhAMs
 7bVs9XbVLE5ZVPcCoWhTkXEpBjTBngmk9VW7efX2nc9WOK+9HRngxe7FkQj8VqXY8xJk
 QHLCVbj/67GbJIAXNR9k+4hHqThPG4y78DJtk0JDPfAuO4fnqM4lH9ZFkYkjdN31E+Hy
 2j+w==
X-Gm-Message-State: AOJu0Yy360RId7GoCrupi3Miq3UGD/ajeVzBQP9rkVpeyGl/poIGyI01
 m9TUhIS6BafXuhD1QyzdTHr1Ig8+26rvCt7GivuZZ0IvSJHxR4wSSdNEap0XCNqzMLz6Ng1UYJ0
 yRc09fFTH4M1oDwnuhgOZY8XY1D7nx2GExrVW+KQbhzZpOJHIUL1MeB1u9h/eaRyQLx7w
X-Gm-Gg: ASbGncsVwfSOGVTE/6qx/+8WmKPO7mlQpkXLswC66bgGrA8E3Ihqg4jMnHVgmRpKjl7
 1gUVDpERCURdRinqge85RLnwAnzIVS8fIg1F3+1MxTdbsIV/AOvYL7CsLxcWz3O/yjKfNlQAhiO
 GuPHpMc1vrI8mqyJIXSW/moCTWEE1M+JLeZLxK3PwHA/C8Fkh03KpyX3JBBOSqZ3brkYWTXrki7
 cpLYrzxMihIHm4zaI83+KYV1dHvi8eIOvJYoufJz7fUSEt5+kmZuKxjh+fad5l5/RA7y85Hz3dq
 hreK9wpMhLmauExs6B2HbeeAELyJ6XNJTTWdgK8fmtblYIVeayRh6RXnviIEHZqRAFv17RMPIwp
 b8XgXzjfRAfBe
X-Received: by 2002:a05:6a20:244f:b0:240:dc9:71cf with SMTP id
 adf61e73a8af0-243d6f03832mr14550444637.38.1756784867520; 
 Mon, 01 Sep 2025 20:47:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8GJWPA0L3v4t5GP3fTx+2CAUIJU82RWAo4VY5a8Q7WCI6v+fFLo/mGIpmrSlk09ZBrfUr3A==
X-Received: by 2002:a05:6a20:244f:b0:240:dc9:71cf with SMTP id
 adf61e73a8af0-243d6f03832mr14550410637.38.1756784867066; 
 Mon, 01 Sep 2025 20:47:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 21/40] target/hexagon: Add vmstate representation
Date: Mon,  1 Sep 2025 20:46:56 -0700
Message-Id: <20250902034715.1947718-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8KuA2P9zIP1_yrbKuK0oaZ4XcLSG9vep
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b668e5 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=0_PaYugFIasnaV_c4v8A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 8KuA2P9zIP1_yrbKuK0oaZ4XcLSG9vep
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfXzy4Lh41erF+L
 odaWVfArjq2aK4D2JIxncuNuvpAwVQeFaTT1RZoWrw34rbAYoHrofRhijDISas5pXM1LkGm3san
 LA2Xn9g4FcFcnpPsvRl8rvzd41DDPK7N+5hxhe8YyfI/RlWnRJwsyp4iLWgwCa/6WQT58opmfFI
 ZsrWhBXCd41TveYQNDMlRDnWD1O5n3LXCWdJ0uukBBTfDw6+cgc8k2mLugh7bi1zJBwIno/wJNy
 7DnZ8EK3s2VYzccwsuIFuW6WjzL+xeJqyoH0va/FGnhhjKq/CBp8UvycQDku6yisiSdcouKikit
 Ds8C1iHJbkaJeQF7QuORB7WqKQFhe21gLga2vZmcS7To3qfUTSSxhDSadVvudVUHGmL4rFEWo68
 Q0hqPM/6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001
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

From: Brian Cain <bcain@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/internal.h |  4 ++++
 target/hexagon/cpu.c      |  3 +++
 target/hexagon/machine.c  | 25 +++++++++++++++++++++++++
 3 files changed, 32 insertions(+)
 create mode 100644 target/hexagon/machine.c

diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index 32e96f00d9..9658141316 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -31,4 +31,8 @@ void hexagon_debug(CPUHexagonState *env);
 
 extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];
 
+#ifndef CONFIG_USER_ONLY
+extern const VMStateDescription vmstate_hexagon_cpu;
+#endif
+
 #endif
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index fa52ad7453..39b45e6452 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -377,6 +377,9 @@ static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
     cc->gdb_stop_before_watchpoint = true;
     cc->gdb_core_xml_file = "hexagon-core.xml";
     cc->disas_set_info = hexagon_cpu_disas_set_info;
+#ifndef CONFIG_USER_ONLY
+    dc->vmsd = &vmstate_hexagon_cpu;
+#endif
     cc->tcg_ops = &hexagon_tcg_ops;
 }
 
diff --git a/target/hexagon/machine.c b/target/hexagon/machine.c
new file mode 100644
index 0000000000..988ede06e9
--- /dev/null
+++ b/target/hexagon/machine.c
@@ -0,0 +1,25 @@
+/*
+ * Copyright(c) 2023-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "migration/cpu.h"
+#include "cpu.h"
+
+
+const VMStateDescription vmstate_hexagon_cpu = {
+    .name = "cpu",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT(parent_obj, HexagonCPU, 0, vmstate_cpu_common, CPUState),
+        VMSTATE_UINTTL_ARRAY(env.gpr, HexagonCPU, TOTAL_PER_THREAD_REGS),
+        VMSTATE_UINTTL_ARRAY(env.pred, HexagonCPU, NUM_PREGS),
+        VMSTATE_UINTTL_ARRAY(env.t_sreg, HexagonCPU, NUM_SREGS),
+        VMSTATE_UINTTL_ARRAY(env.greg, HexagonCPU, NUM_GREGS),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
-- 
2.34.1


