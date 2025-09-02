Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4920CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1i-00048u-BD; Mon, 01 Sep 2025 23:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1U-0002mg-L6
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1N-0004ck-3T
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:32 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S44V030068
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rKZUkZXmHGjGkE0fk0NlHjSjG0NxZ4KmA4MKCdCGXvI=; b=NNYRcAawFMNsq4lC
 dzSwwb/Xr8No1K5pZQ3T5tViYNlEAF8j3BwXxzSgCO2yVzl213zS2nkUVDrPlt+E
 c9ihHuOo7DZLVTtYJSKO8xHvRSRZ3V8FfT/x3UrwGC++a1Ij9IHRFJmdjN0JJMcO
 T769AtChOlBG5UHlXrno5XekwRKz5grjyS0RDBqfcpTXa++Mar16q+4BHezSWm9+
 gDivdC4RReJQADUa0If2v3PFUhHAPv4UV79yVQRHFipfumv4lrog4ZHkswi+dpAH
 w6X6Pn7hUF2tAMGn46Yhg8XRmvdG1iq4vJ1TLgxEpR7DFX7gRDZHlSycDVrgKhKe
 dji2xg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy26sd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:13 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-325b2959306so8238326a91.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784952; x=1757389752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rKZUkZXmHGjGkE0fk0NlHjSjG0NxZ4KmA4MKCdCGXvI=;
 b=aGvCcdZxCgLxTiJ5W3wVXyUmwp8mdL+1Bhww9ASgo4dH72h2YUlhl8jCwaLAAgbVfb
 gK7KswKaLKJMhVtdE6yIoQbwFM4LTILjpf0WCSBDRNvZtMR7kefiqU7ZrBcBZos0fIiD
 FwkcB9UkIkGT9TRi7vHeyiBEXWQCMuc65rwlMA6aHoJAGbtl8OsF98a1+7KIQxxTGdU9
 /vowzYZPFTM7pvyRZVS53e4I7u1uTZIQP1ypkqSYk0DQWZAeP39vIy1sbJCYH0Y7fnao
 9FZX7PD5jTQQprNbkyyz7xwWUcKmz2AAjiDGsMfbUgKlBfIE7LGtHrZ0fUKiaUZ20ebq
 tvUA==
X-Gm-Message-State: AOJu0YxSgMCxY4EA/2kt9NREeYhsJJVbCfnp6tE9ZEuU+Z7DcPGfFNWS
 rqzc6XcYY5aM9YBuiJ7UChdssn17YSKzIwNjohxKNZ7PvF10I78K+utlBonxfxAtQzAbo/XJIjU
 ysnoUvkJr+3mZL2vYFjEopytb6zRsLH0Qgcl+wUSlXgjmH/zK+DNloSQA4iONSA674SHH
X-Gm-Gg: ASbGncvFA17swBHvTSZHzPGUIWix/KkLlPPTYq7xDRO/wpCrx10XsaZgdIUpmoUVhK3
 MisBo1dHDimz4iYDftJh6eqChgH4rqsaGe8mMLHc2PNbcSEqRp5bY116G38Md3iIVT0wiflGVTv
 HD2PUJ6qcdttFz47ceXTZVK3a9z1pNah/ojSHJ0/6X8ZQl8TAXnu75tz1TMbteg/MfUcTkVQLPU
 s79Nl0QSZB53YqoikR6sS00GNqJzY+7PeUnFpXKOC+6sn3JogEQV9cnaw62YJKGZftdgVI8LVRU
 MMWdVFqZ/0fKPKYE2zilsKHNTqcTU0Ej+eFqSOW09zxVFKhObOWwAzXc0SkhhSvQzKxJLzAzOsn
 26S5qVMdzPb6a
X-Received: by 2002:a17:90a:d40d:b0:327:e8d0:cb21 with SMTP id
 98e67ed59e1d1-328156f8332mr14717507a91.35.1756784952202; 
 Mon, 01 Sep 2025 20:49:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMSt1JSZxr5UiJVZjSlADCpt+E6I0nabSNzx1/n5yV67e7++dDvnYkFuhz/eFAbS5I0BDPKg==
X-Received: by 2002:a17:90a:d40d:b0:327:e8d0:cb21 with SMTP id
 98e67ed59e1d1-328156f8332mr14717471a91.35.1756784951625; 
 Mon, 01 Sep 2025 20:49:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Mike Lambert <mlambert@quicinc.com>
Subject: [PATCH v2 16/39] target/hexagon: Implement software interrupt
Date: Mon,  1 Sep 2025 20:48:24 -0700
Message-Id: <20250902034847.1948010-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b66939 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=Befq45VWmXQcvcAHDQIA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: NxAViiKcFtvHsy_x6IKx5XidqtcAiSdV
X-Proofpoint-ORIG-GUID: NxAViiKcFtvHsy_x6IKx5XidqtcAiSdV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfXxuEpSJg+33mj
 oBWdAbznqiG9ivYm9Qv2pzbwq2KvKR0kBRYCiFkMzoWTqyPJAMojJsSRfVb3c1pBTOlYbq8E75z
 dDi/S/s7RNOvaGO+EC6KwAwtuGBjJa3O8LXkTEx0zLC62LoRhOqoTTV4B4QpP4gbSn89Vk7aSRC
 oWNPrC4QGp3ugXd2qGA+n1JQcHAmIBQQ8IdBd89piS+r7QWHUb5YI+0VusMApljBDNWUWYV+TTx
 dDM0fWlw/ncPNBZo46YyuYy9iH8qXAffxpXV0jaZFFFmiaCl+wkZEOAyGeVdRWoqk3aemBl0xlP
 KO5q9BYp+CPNHafaEZndyY89Cor5pn0ro3cxDDiFbSO+ce03yGsMPEPAR/fLcFVTBVgSYolYwyS
 24lU4/GG
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

From: Brian Cain <bcain@quicinc.com>

Co-authored-by: Mike Lambert <mlambert@quicinc.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/hexswi.h    |  17 +++
 target/hexagon/cpu.c       |   2 +
 target/hexagon/hexswi.c    | 256 +++++++++++++++++++++++++++++++++++++
 target/hexagon/op_helper.c |   1 +
 4 files changed, 276 insertions(+)
 create mode 100644 target/hexagon/hexswi.h
 create mode 100644 target/hexagon/hexswi.c

diff --git a/target/hexagon/hexswi.h b/target/hexagon/hexswi.h
new file mode 100644
index 0000000000..5d232cb06c
--- /dev/null
+++ b/target/hexagon/hexswi.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright(c) 2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HEXSWI_H
+#define HEXSWI_H
+
+
+#include "cpu.h"
+
+void hexagon_cpu_do_interrupt(CPUState *cpu);
+void register_trap_exception(CPUHexagonState *env, int type, int imm,
+                             target_ulong PC);
+
+#endif /* HEXSWI_H */
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index b7e21c913f..22e21d401b 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -33,6 +33,8 @@
 #include "sys_macros.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "qemu/main-loop.h"
+#include "hex_interrupts.h"
+#include "hexswi.h"
 #endif
 
 static void hexagon_v66_cpu_init(Object *obj) { }
diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
new file mode 100644
index 0000000000..373133ed7f
--- /dev/null
+++ b/target/hexagon/hexswi.c
@@ -0,0 +1,256 @@
+/*
+ * Copyright(c) 2019-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_helper.h"
+#include "exec/helper-proto.h"
+#include "qemu/log.h"
+#include "qemu/main-loop.h"
+#include "arch.h"
+#include "internal.h"
+#include "macros.h"
+#include "sys_macros.h"
+#include "tcg/tcg-op.h"
+#include "hex_mmu.h"
+#include "hexswi.h"
+
+#ifdef CONFIG_USER_ONLY
+#error "This file is only used in system emulation"
+#endif
+
+static void set_addresses(CPUHexagonState *env, target_ulong pc_offset,
+                          target_ulong exception_index)
+
+{
+    HexagonCPU *cpu = env_archcpu(env);
+    uint32_t evb = cpu->globalregs ?
+        arch_get_system_reg(env, HEX_SREG_EVB) :
+        cpu->boot_addr;
+    arch_set_system_reg(env, HEX_SREG_ELR,
+                        arch_get_thread_reg(env, HEX_REG_PC) + pc_offset);
+    arch_set_thread_reg(env, HEX_REG_PC, evb | (exception_index << 2));
+}
+
+static const char *event_name[] = {
+    [HEX_EVENT_RESET] = "HEX_EVENT_RESET",
+    [HEX_EVENT_IMPRECISE] = "HEX_EVENT_IMPRECISE",
+    [HEX_EVENT_TLB_MISS_X] = "HEX_EVENT_TLB_MISS_X",
+    [HEX_EVENT_TLB_MISS_RW] = "HEX_EVENT_TLB_MISS_RW",
+    [HEX_EVENT_TRAP0] = "HEX_EVENT_TRAP0",
+    [HEX_EVENT_TRAP1] = "HEX_EVENT_TRAP1",
+    [HEX_EVENT_FPTRAP] = "HEX_EVENT_FPTRAP",
+    [HEX_EVENT_DEBUG] = "HEX_EVENT_DEBUG",
+    [HEX_EVENT_INT0] = "HEX_EVENT_INT0",
+    [HEX_EVENT_INT1] = "HEX_EVENT_INT1",
+    [HEX_EVENT_INT2] = "HEX_EVENT_INT2",
+    [HEX_EVENT_INT3] = "HEX_EVENT_INT3",
+    [HEX_EVENT_INT4] = "HEX_EVENT_INT4",
+    [HEX_EVENT_INT5] = "HEX_EVENT_INT5",
+    [HEX_EVENT_INT6] = "HEX_EVENT_INT6",
+    [HEX_EVENT_INT7] = "HEX_EVENT_INT7",
+    [HEX_EVENT_INT8] = "HEX_EVENT_INT8",
+    [HEX_EVENT_INT9] = "HEX_EVENT_INT9",
+    [HEX_EVENT_INTA] = "HEX_EVENT_INTA",
+    [HEX_EVENT_INTB] = "HEX_EVENT_INTB",
+    [HEX_EVENT_INTC] = "HEX_EVENT_INTC",
+    [HEX_EVENT_INTD] = "HEX_EVENT_INTD",
+    [HEX_EVENT_INTE] = "HEX_EVENT_INTE",
+    [HEX_EVENT_INTF] = "HEX_EVENT_INTF"
+};
+
+void hexagon_cpu_do_interrupt(CPUState *cs)
+
+{
+    CPUHexagonState *env = cpu_env(cs);
+    uint32_t ssr;
+
+    BQL_LOCK_GUARD();
+
+    qemu_log_mask(CPU_LOG_INT, "\t%s: event 0x%x:%s, cause 0x%x(%d)\n",
+                  __func__, cs->exception_index,
+                  event_name[cs->exception_index], env->cause_code,
+                  env->cause_code);
+
+    env->llsc_addr = ~0;
+
+    ssr = arch_get_system_reg(env, HEX_SREG_SSR);
+    if (GET_SSR_FIELD(SSR_EX, ssr) == 1) {
+        arch_set_system_reg(env, HEX_SREG_DIAG, env->cause_code);
+        env->cause_code = HEX_CAUSE_DOUBLE_EXCEPT;
+        cs->exception_index = HEX_EVENT_PRECISE;
+    }
+
+    switch (cs->exception_index) {
+    case HEX_EVENT_TRAP0:
+        if (env->cause_code == 0) {
+            qemu_log_mask(LOG_UNIMP,
+                          "trap0 is unhandled, no semihosting available\n");
+        }
+
+        hexagon_ssr_set_cause(env, env->cause_code);
+        set_addresses(env, 4, cs->exception_index);
+        break;
+
+    case HEX_EVENT_TRAP1:
+        hexagon_ssr_set_cause(env, env->cause_code);
+        set_addresses(env, 4, cs->exception_index);
+        break;
+
+    case HEX_EVENT_TLB_MISS_X:
+        switch (env->cause_code) {
+        case HEX_CAUSE_TLBMISSX_CAUSE_NORMAL:
+        case HEX_CAUSE_TLBMISSX_CAUSE_NEXTPAGE:
+            qemu_log_mask(CPU_LOG_MMU,
+                          "TLB miss EX exception (0x%x) caught: "
+                          "Cause code (0x%x) "
+                          "TID = 0x%" PRIx32 ", PC = 0x%" PRIx32
+                          ", BADVA = 0x%" PRIx32 "\n",
+                          cs->exception_index, env->cause_code, env->threadId,
+                          arch_get_thread_reg(env, HEX_REG_PC),
+                          arch_get_system_reg(env, HEX_SREG_BADVA));
+
+            hexagon_ssr_set_cause(env, env->cause_code);
+            set_addresses(env, 0, cs->exception_index);
+            break;
+
+        default:
+            cpu_abort(cs,
+                      "1:Hexagon exception %d/0x%x: "
+                      "Unknown cause code %d/0x%x\n",
+                      cs->exception_index, cs->exception_index, env->cause_code,
+                      env->cause_code);
+            break;
+        }
+        break;
+
+    case HEX_EVENT_TLB_MISS_RW:
+        switch (env->cause_code) {
+        case HEX_CAUSE_TLBMISSRW_CAUSE_READ:
+        case HEX_CAUSE_TLBMISSRW_CAUSE_WRITE:
+            qemu_log_mask(CPU_LOG_MMU,
+                          "TLB miss RW exception (0x%x) caught: "
+                          "Cause code (0x%x) "
+                          "TID = 0x%" PRIx32 ", PC = 0x%" PRIx32
+                          ", BADVA = 0x%" PRIx32 "\n",
+                          cs->exception_index, env->cause_code, env->threadId,
+                          env->gpr[HEX_REG_PC],
+                          arch_get_system_reg(env, HEX_SREG_BADVA));
+
+            hexagon_ssr_set_cause(env, env->cause_code);
+            set_addresses(env, 0, cs->exception_index);
+            /* env->sreg[HEX_SREG_BADVA] is set when the exception is raised */
+            break;
+
+        default:
+            cpu_abort(cs,
+                      "2:Hexagon exception %d/0x%x: "
+                      "Unknown cause code %d/0x%x\n",
+                      cs->exception_index, cs->exception_index, env->cause_code,
+                      env->cause_code);
+            break;
+        }
+        break;
+
+    case HEX_EVENT_FPTRAP:
+        hexagon_ssr_set_cause(env, env->cause_code);
+        arch_set_thread_reg(env, HEX_REG_PC,
+                            arch_get_system_reg(env, HEX_SREG_EVB) |
+                                (cs->exception_index << 2));
+        break;
+
+    case HEX_EVENT_DEBUG:
+        hexagon_ssr_set_cause(env, env->cause_code);
+        set_addresses(env, 0, cs->exception_index);
+        qemu_log_mask(LOG_UNIMP, "single-step exception is not handled\n");
+        break;
+
+    case HEX_EVENT_PRECISE:
+        switch (env->cause_code) {
+        case HEX_CAUSE_FETCH_NO_XPAGE:
+        case HEX_CAUSE_FETCH_NO_UPAGE:
+        case HEX_CAUSE_PRIV_NO_READ:
+        case HEX_CAUSE_PRIV_NO_UREAD:
+        case HEX_CAUSE_PRIV_NO_WRITE:
+        case HEX_CAUSE_PRIV_NO_UWRITE:
+        case HEX_CAUSE_MISALIGNED_LOAD:
+        case HEX_CAUSE_MISALIGNED_STORE:
+        case HEX_CAUSE_PC_NOT_ALIGNED:
+            qemu_log_mask(CPU_LOG_MMU,
+                          "MMU permission exception (0x%x) caught: "
+                          "Cause code (0x%x) "
+                          "TID = 0x%" PRIx32 ", PC = 0x%" PRIx32
+                          ", BADVA = 0x%" PRIx32 "\n",
+                          cs->exception_index, env->cause_code, env->threadId,
+                          env->gpr[HEX_REG_PC],
+                          arch_get_system_reg(env, HEX_SREG_BADVA));
+
+
+            hexagon_ssr_set_cause(env, env->cause_code);
+            set_addresses(env, 0, cs->exception_index);
+            /* env->sreg[HEX_SREG_BADVA] is set when the exception is raised */
+            break;
+
+        case HEX_CAUSE_DOUBLE_EXCEPT:
+        case HEX_CAUSE_PRIV_USER_NO_SINSN:
+        case HEX_CAUSE_PRIV_USER_NO_GINSN:
+        case HEX_CAUSE_INVALID_OPCODE:
+        case HEX_CAUSE_NO_COPROC_ENABLE:
+        case HEX_CAUSE_NO_COPROC2_ENABLE:
+        case HEX_CAUSE_UNSUPORTED_HVX_64B:
+        case HEX_CAUSE_REG_WRITE_CONFLICT:
+        case HEX_CAUSE_VWCTRL_WINDOW_MISS:
+            hexagon_ssr_set_cause(env, env->cause_code);
+            set_addresses(env, 0, cs->exception_index);
+            break;
+
+        case HEX_CAUSE_COPROC_LDST:
+            hexagon_ssr_set_cause(env, env->cause_code);
+            set_addresses(env, 0, cs->exception_index);
+            break;
+
+        case HEX_CAUSE_STACK_LIMIT:
+            hexagon_ssr_set_cause(env, env->cause_code);
+            set_addresses(env, 0, cs->exception_index);
+            break;
+
+        default:
+            cpu_abort(cs,
+                      "3:Hexagon exception %d/0x%x: "
+                      "Unknown cause code %d/0x%x\n",
+                      cs->exception_index, cs->exception_index, env->cause_code,
+                      env->cause_code);
+            break;
+        }
+        break;
+
+    case HEX_EVENT_IMPRECISE:
+        qemu_log_mask(LOG_UNIMP,
+                "Imprecise exception: this case is not yet handled");
+        break;
+
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                "Hexagon Unsupported exception 0x%x/0x%x\n",
+                  cs->exception_index, env->cause_code);
+        break;
+    }
+
+    cs->exception_index = HEX_EVENT_NONE;
+}
+
+void register_trap_exception(CPUHexagonState *env, int traptype, int imm,
+                             target_ulong PC)
+{
+    CPUState *cs = env_cpu(env);
+
+    cs->exception_index = (traptype == 0) ? HEX_EVENT_TRAP0 : HEX_EVENT_TRAP1;
+    ASSERT_DIRECT_TO_GUEST_UNSET(env, cs->exception_index);
+
+    env->cause_code = imm;
+    env->gpr[HEX_REG_PC] = PC;
+    cpu_loop_exit(cs);
+}
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 53bf0591ec..569e8271b3 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -40,6 +40,7 @@
 #include "hex_mmu.h"
 #include "hw/intc/l2vic.h"
 #include "hex_interrupts.h"
+#include "hexswi.h"
 #endif
 
 #define SF_BIAS        127
-- 
2.34.1


