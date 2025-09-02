Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83657CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0e-0007ig-68; Mon, 01 Sep 2025 23:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0Q-0007Fy-LE
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0O-0004Xu-1a
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:26 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S5IH013610
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NZNJP7Tt2VSeYOWvLu+7G4zCV4rtKzm3+hr1voXSqrc=; b=e+gucpU9HKvvBL2F
 IqlEny6MxFMsymHsUnBbMCfPPVFCcJCUlqPSPZwiF6Nn7KxMrbBeOXZVJA2MASFm
 vMu4dH83vf11iH0k8Ms8rjdq2JOn5tE96kOM6sl5om4i7y0WsdiAj/Cr4/Uq9z7i
 rw5YumXXLac8q5ACyUXMgHzGDJuePC2AZnx8JJ9X+J21L/Jyr+KalPd3qCz2e4Bs
 MsLiCheuxo5TjOKlSPTKLHgaCvamMtfu5lFFOOo/NIU5CGc8jsWxfrQ36b2LWJ2m
 /g8WMOvMXC6HbEDdKnzVuxHhE4MZo+Ewve0oJPbb8ijw6yK54qLuqW/ctnK4JHDO
 djZtCg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0eej6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:48:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-325e31cecd6so4776704a91.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784890; x=1757389690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZNJP7Tt2VSeYOWvLu+7G4zCV4rtKzm3+hr1voXSqrc=;
 b=cyt9WYEB+m3tQTNoB3ShCz2H755kB2FBIzbWKjXGKPbPw63iGYkWxyy/Y00FEhRMOs
 jbZ3kh8BhQRf/GMAyUKxPMwGyFp293/q8P18tr/ReKRABsdAXWygYb7Uo0Ji3TJjh/Id
 pfLWwoNPTBcCR8aCn0X5a7Jzcy9vPE1XGm2WmTUENLd6fKoEORKah3rBPUmjSrkMtAKV
 lxUuZq3RdLJCL3AG6kMdf7b/oTN3tDKFHk6ZNOfi+MRqVxkNl1KswtLxNEHI3q0tVP0e
 QFDv0pUepaVi+t9kEysHNXuuFVUQilnn/c0m4Jg4uzWuwLmDVcCcmlmTpDOujVjOb9f+
 C0Bw==
X-Gm-Message-State: AOJu0YwV8rJ/n6yiYoiD/xo+S62I8Ki333MysMifObiJY/LUVZUw2Wh2
 CSA+d/OqN9lZEIshLeXvz+fHBkHxFKANZu4BzY70OOjlWjlG8v7jO0Qa2GZRXsm2PB33ELbSjoC
 PF8cs1t3hIO9G9qQuJPuxCNxpE+LNwF4Pp8bqMVWrLzPZhfUtlcRTThOaGhE7mqKDdUH+
X-Gm-Gg: ASbGncshysXhNE/8VZmGoLZ7iRUXHHoGneiM9ia88ZqLO0d6G7F6EPIfs0ygU8ZUYew
 qcBBY7HVf79sQW4+XmLEzkpUmtJ5omKIWRCJ9baITO1hl/vGI8fNCRnZqZmUQksU9GyHJ+HBrJA
 DOBIfqrPRkKtw2Rcvyoff9GMbblCdYRlp8useC9fQLV47N9fPTTu5eQuqqPBjJH50Io0laZ7d0i
 ZQPtowH58hremIACntGDn7KCZe5gDsi7XYp5/NrkkkUoRb5yRYf9C9nENIJaAmKMB/sY/aVKcwd
 pqY3xHwuOxGsV4HwRa/lYFemYhvg94OoxCMTlomnP4wzZ317J/LIrslanev7eX3N29lxvhvVfxv
 PJC/VsLtXS6cn
X-Received: by 2002:a17:90b:58a6:b0:327:fb42:2472 with SMTP id
 98e67ed59e1d1-328156cc767mr7993468a91.28.1756784890118; 
 Mon, 01 Sep 2025 20:48:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxqYyUwr1CA/KUbJ9U+rEMLe7kt6bQk45lH+ns3N95R+qjdDz8/pQMzOGZ9A69zmCF5GN/kA==
X-Received: by 2002:a17:90b:58a6:b0:327:fb42:2472 with SMTP id
 98e67ed59e1d1-328156cc767mr7993425a91.28.1756784888987; 
 Mon, 01 Sep 2025 20:48:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:48:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>, Michael Lambert <mlambert@quicinc.com>
Subject: [PATCH v2 40/40] target/hexagon: Add hex_interrupts support
Date: Mon,  1 Sep 2025 20:47:15 -0700
Message-Id: <20250902034715.1947718-41-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: u1p14EeOHLIrPzjgYhel8SrxsEHGnJSj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX57zrgYERd++5
 df4wuoko2j0cmkGPzUcIdSU+0CONIfpMPvK/EB8OCRcJGH62tfIoo+M01dquDRqukQfmUnJIOfV
 a73Iks/1pAwQRq5e5Y54vwtBegPgZBXogTg7OeFNcR0fuMUfrqqxpXUfVcaZDPBqsJGp1pSJ2BS
 2ttYldNfGmWrlf1vQU5Yz44o52T8h6vBqGc4qa6Em5M/TqezGhoM0E0pGmdHDHa2LtPWiUYAbaZ
 tg++GVFoDulb8TjZ0fX3+gTOHAYb/xTSxpSngYoVKQ+AT4BtLuSPcWxBdMOnJdf0UCXbQTRisgV
 UnD3o4q8qLHP8SQWZe6SSCLGpu4lOnX37OGi+DK+ZAICkqWk9GY8j0wqvggJt65EZ4JbapuVOkE
 XJxPmshN
X-Proofpoint-ORIG-GUID: u1p14EeOHLIrPzjgYhel8SrxsEHGnJSj
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b668fb cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=zxlTluI1IHozTE2Gj6wA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004
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

From: Brian Cain <bcain@quicinc.com>

Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Co-authored-by: Sid Manning <sidneym@quicinc.com>
Co-authored-by: Michael Lambert <mlambert@quicinc.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h            |   1 +
 target/hexagon/hex_interrupts.h |  15 ++
 target/hexagon/cpu.c            |   2 +
 target/hexagon/hex_interrupts.c | 327 ++++++++++++++++++++++++++++++++
 4 files changed, 345 insertions(+)
 create mode 100644 target/hexagon/hex_interrupts.h
 create mode 100644 target/hexagon/hex_interrupts.c

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index f25b483188..d369e104ae 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -192,6 +192,7 @@ struct ArchCPU {
     bool short_circuit;
 #ifndef CONFIG_USER_ONLY
     uint32_t num_tlbs;
+    uint32_t l2vic_base_addr;
 #endif
 };
 
diff --git a/target/hexagon/hex_interrupts.h b/target/hexagon/hex_interrupts.h
new file mode 100644
index 0000000000..17a243946c
--- /dev/null
+++ b/target/hexagon/hex_interrupts.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright(c) 2022-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HEX_INTERRUPTS_H
+#define HEX_INTERRUPTS_H
+
+bool hex_check_interrupts(CPUHexagonState *env);
+void hex_clear_interrupts(CPUHexagonState *env, uint32_t mask, uint32_t type);
+void hex_raise_interrupts(CPUHexagonState *env, uint32_t mask, uint32_t type);
+void hex_interrupt_update(CPUHexagonState *env);
+
+#endif
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index eb3adebb60..c128f47ad3 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -59,6 +59,8 @@ static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
 static const Property hexagon_cpu_properties[] = {
 #if !defined(CONFIG_USER_ONLY)
     DEFINE_PROP_UINT32("jtlb-entries", HexagonCPU, num_tlbs, MAX_TLB_ENTRIES),
+    DEFINE_PROP_UINT32("l2vic-base-addr", HexagonCPU, l2vic_base_addr,
+        0xffffffffULL),
 #endif
     DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
     DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_adjust, 0,
diff --git a/target/hexagon/hex_interrupts.c b/target/hexagon/hex_interrupts.c
new file mode 100644
index 0000000000..b555565e55
--- /dev/null
+++ b/target/hexagon/hex_interrupts.c
@@ -0,0 +1,327 @@
+/*
+ * Copyright(c) 2022-2025 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/main-loop.h"
+#include "cpu.h"
+#include "cpu_helper.h"
+#include "exec/cpu-interrupt.h"
+#include "hex_interrupts.h"
+#include "macros.h"
+#include "sys_macros.h"
+#include "system/cpus.h"
+
+static bool hex_is_qualified_for_int(CPUHexagonState *env, int int_num);
+
+static bool get_syscfg_gie(CPUHexagonState *env)
+{
+    target_ulong syscfg = arch_get_system_reg(env, HEX_SREG_SYSCFG);
+    return GET_SYSCFG_FIELD(SYSCFG_GIE, syscfg);
+}
+
+static bool get_ssr_ex(CPUHexagonState *env)
+{
+    target_ulong ssr = arch_get_system_reg(env, HEX_SREG_SSR);
+    return GET_SSR_FIELD(SSR_EX, ssr);
+}
+
+static bool get_ssr_ie(CPUHexagonState *env)
+{
+    target_ulong ssr = arch_get_system_reg(env, HEX_SREG_SSR);
+    return GET_SSR_FIELD(SSR_IE, ssr);
+}
+
+/* Do these together so we only have to call hexagon_modify_ssr once */
+static void set_ssr_ex_cause(CPUHexagonState *env, int ex, uint32_t cause)
+{
+    target_ulong old = arch_get_system_reg(env, HEX_SREG_SSR);
+    SET_SYSTEM_FIELD(env, HEX_SREG_SSR, SSR_EX, ex);
+    SET_SYSTEM_FIELD(env, HEX_SREG_SSR, SSR_CAUSE, cause);
+    target_ulong new = arch_get_system_reg(env, HEX_SREG_SSR);
+    hexagon_modify_ssr(env, new, old);
+}
+
+static bool get_iad_bit(CPUHexagonState *env, int int_num)
+{
+    target_ulong ipendad = arch_get_system_reg(env, HEX_SREG_IPENDAD);
+    target_ulong iad = GET_FIELD(IPENDAD_IAD, ipendad);
+    return extract32(iad, int_num, 1);
+}
+
+static void set_iad_bit(CPUHexagonState *env, int int_num, int val)
+{
+    target_ulong ipendad = arch_get_system_reg(env, HEX_SREG_IPENDAD);
+    target_ulong iad = GET_FIELD(IPENDAD_IAD, ipendad);
+    iad = deposit32(iad, int_num, 1, val);
+    fSET_FIELD(ipendad, IPENDAD_IAD, iad);
+    arch_set_system_reg(env, HEX_SREG_IPENDAD, ipendad);
+}
+
+static uint32_t get_ipend(CPUHexagonState *env)
+{
+    target_ulong ipendad = arch_get_system_reg(env, HEX_SREG_IPENDAD);
+    return GET_FIELD(IPENDAD_IPEND, ipendad);
+}
+
+static inline bool get_ipend_bit(CPUHexagonState *env, int int_num)
+{
+    target_ulong ipendad = arch_get_system_reg(env, HEX_SREG_IPENDAD);
+    target_ulong ipend = GET_FIELD(IPENDAD_IPEND, ipendad);
+    return extract32(ipend, int_num, 1);
+}
+
+static void clear_ipend(CPUHexagonState *env, uint32_t mask)
+{
+    target_ulong ipendad = arch_get_system_reg(env, HEX_SREG_IPENDAD);
+    target_ulong ipend = GET_FIELD(IPENDAD_IPEND, ipendad);
+    ipend &= ~mask;
+    fSET_FIELD(ipendad, IPENDAD_IPEND, ipend);
+    arch_set_system_reg(env, HEX_SREG_IPENDAD, ipendad);
+}
+
+static void set_ipend(CPUHexagonState *env, uint32_t mask)
+{
+    target_ulong ipendad = arch_get_system_reg(env, HEX_SREG_IPENDAD);
+    target_ulong ipend = GET_FIELD(IPENDAD_IPEND, ipendad);
+    ipend |= mask;
+    fSET_FIELD(ipendad, IPENDAD_IPEND, ipend);
+    arch_set_system_reg(env, HEX_SREG_IPENDAD, ipendad);
+}
+
+static void set_ipend_bit(CPUHexagonState *env, int int_num, int val)
+{
+    target_ulong ipendad = arch_get_system_reg(env, HEX_SREG_IPENDAD);
+    target_ulong ipend = GET_FIELD(IPENDAD_IPEND, ipendad);
+    ipend = deposit32(ipend, int_num, 1, val);
+    fSET_FIELD(ipendad, IPENDAD_IPEND, ipend);
+    arch_set_system_reg(env, HEX_SREG_IPENDAD, ipendad);
+}
+
+static bool get_imask_bit(CPUHexagonState *env, int int_num)
+{
+    target_ulong imask = arch_get_system_reg(env, HEX_SREG_IMASK);
+    return extract32(imask, int_num, 1);
+}
+
+static uint32_t get_prio(CPUHexagonState *env)
+{
+    target_ulong stid = arch_get_system_reg(env, HEX_SREG_STID);
+    return extract32(stid, reg_field_info[STID_PRIO].offset,
+                     reg_field_info[STID_PRIO].width);
+}
+
+static void set_elr(CPUHexagonState *env, target_ulong val)
+{
+    arch_set_system_reg(env, HEX_SREG_ELR, val);
+}
+
+static bool get_schedcfgen(CPUHexagonState *env)
+{
+    target_ulong schedcfg = arch_get_system_reg(env, HEX_SREG_SCHEDCFG);
+    return extract32(schedcfg, reg_field_info[SCHEDCFG_EN].offset,
+                     reg_field_info[SCHEDCFG_EN].width);
+}
+
+static bool is_lowest_prio(CPUHexagonState *env, int int_num)
+{
+    uint32_t my_prio = get_prio(env);
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        CPUHexagonState *hex_env = cpu_env(cs);
+        if (!hex_is_qualified_for_int(hex_env, int_num)) {
+            continue;
+        }
+
+        /* Note that lower values indicate *higher* priority */
+        if (my_prio < get_prio(hex_env)) {
+            return false;
+        }
+    }
+    return true;
+}
+
+static bool hex_is_qualified_for_int(CPUHexagonState *env, int int_num)
+{
+    bool syscfg_gie = get_syscfg_gie(env);
+    bool iad = get_iad_bit(env, int_num);
+    bool ssr_ie = get_ssr_ie(env);
+    bool ssr_ex = get_ssr_ex(env);
+    bool imask = get_imask_bit(env, int_num);
+
+    return syscfg_gie && !iad && ssr_ie && !ssr_ex && !imask;
+}
+
+static void clear_pending_locks(CPUHexagonState *env)
+{
+    g_assert(bql_locked());
+    if (env->k0_lock_state == HEX_LOCK_WAITING) {
+        env->k0_lock_state = HEX_LOCK_UNLOCKED;
+    }
+    if (env->tlb_lock_state == HEX_LOCK_WAITING) {
+        env->tlb_lock_state = HEX_LOCK_UNLOCKED;
+    }
+}
+
+static bool should_not_exec(CPUHexagonState *env)
+{
+    return (get_exe_mode(env) == HEX_EXE_MODE_WAIT);
+}
+
+static void restore_state(CPUHexagonState *env, bool int_accepted)
+{
+    CPUState *cs = env_cpu(env);
+    cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_SWI);
+    if (!int_accepted && should_not_exec(env)) {
+        cpu_interrupt(cs, CPU_INTERRUPT_HALT);
+    }
+}
+
+static void hex_accept_int(CPUHexagonState *env, int int_num)
+{
+    CPUState *cs = env_cpu(env);
+    target_ulong evb = arch_get_system_reg(env, HEX_SREG_EVB);
+    const int exe_mode = get_exe_mode(env);
+    const bool in_wait_mode = exe_mode == HEX_EXE_MODE_WAIT;
+
+    set_ipend_bit(env, int_num, 0);
+    set_iad_bit(env, int_num, 1);
+    set_ssr_ex_cause(env, 1, HEX_CAUSE_INT0 | int_num);
+    cs->exception_index = HEX_EVENT_INT0 + int_num;
+    env->cause_code = HEX_EVENT_INT0 + int_num;
+    clear_pending_locks(env);
+    if (in_wait_mode) {
+        qemu_log_mask(CPU_LOG_INT,
+            "%s: thread " TARGET_FMT_ld " resuming, exiting WAIT mode\n",
+            __func__, env->threadId);
+        set_elr(env, env->wait_next_pc);
+        clear_wait_mode(env);
+        cs->halted = false;
+    } else if (env->k0_lock_state == HEX_LOCK_WAITING) {
+        g_assert_not_reached();
+    } else {
+        set_elr(env, env->gpr[HEX_REG_PC]);
+    }
+    env->gpr[HEX_REG_PC] = evb | (cs->exception_index << 2);
+    if (get_ipend(env) == 0) {
+        restore_state(env, true);
+    }
+}
+
+
+bool hex_check_interrupts(CPUHexagonState *env)
+{
+    CPUState *cs = env_cpu(env);
+    bool int_handled = false;
+    bool ssr_ex = get_ssr_ex(env);
+    int max_ints = 32;
+    bool schedcfgen;
+
+    /* Early exit if nothing pending */
+    if (get_ipend(env) == 0) {
+        restore_state(env, false);
+        return false;
+    }
+
+    BQL_LOCK_GUARD();
+    /* Only check priorities when schedcfgen is set */
+    schedcfgen = get_schedcfgen(env);
+    for (int i = 0; i < max_ints; i++) {
+        if (!get_iad_bit(env, i) && get_ipend_bit(env, i)) {
+            qemu_log_mask(CPU_LOG_INT,
+                          "%s: thread[" TARGET_FMT_ld "] pc = 0x" TARGET_FMT_lx " found int %d\n", __func__,
+                          env->threadId, env->gpr[HEX_REG_PC], i);
+            if (hex_is_qualified_for_int(env, i) &&
+                (!schedcfgen || is_lowest_prio(env, i))) {
+                qemu_log_mask(CPU_LOG_INT,
+                              "%s: thread[" TARGET_FMT_ld "] int %d handled_\n",
+                              __func__, env->threadId, i);
+                hex_accept_int(env, i);
+                int_handled = true;
+                break;
+            }
+            bool syscfg_gie = get_syscfg_gie(env);
+            bool iad = get_iad_bit(env, i);
+            bool ssr_ie = get_ssr_ie(env);
+            bool imask = get_imask_bit(env, i);
+
+            qemu_log_mask(CPU_LOG_INT,
+                          "%s: thread[" TARGET_FMT_ld "] int %d not handled, qualified: %d, "
+                          "schedcfg_en: %d, low prio %d\n",
+                          __func__, env->threadId, i,
+                          hex_is_qualified_for_int(env, i), schedcfgen,
+                          is_lowest_prio(env, i));
+
+            qemu_log_mask(CPU_LOG_INT,
+                          "%s: thread[" TARGET_FMT_ld "] int %d not handled, GIE %d, iad %d, "
+                          "SSR:IE %d, SSR:EX: %d, imask bit %d\n",
+                          __func__, env->threadId, i, syscfg_gie, iad, ssr_ie,
+                          ssr_ex, imask);
+        }
+    }
+
+    /*
+     * If we didn't handle the interrupt and it wasn't
+     * because we were in EX state, then we won't be able
+     * to execute the interrupt on this CPU unless something
+     * changes in the CPU state.  Clear the interrupt_request bits
+     * while preserving the IPEND bits, and we can re-assert the
+     * interrupt_request bit(s) when we execute one of those instructions.
+     */
+    if (!int_handled && !ssr_ex) {
+        restore_state(env, int_handled);
+    } else if (int_handled) {
+        assert(!cs->halted);
+    }
+
+    return int_handled;
+}
+
+void hex_clear_interrupts(CPUHexagonState *env, uint32_t mask, uint32_t type)
+{
+    if (mask == 0) {
+        return;
+    }
+
+    /*
+     * Notify all CPUs that the interrupt has happened
+     */
+    BQL_LOCK_GUARD();
+    clear_ipend(env, mask);
+    hex_interrupt_update(env);
+}
+
+void hex_raise_interrupts(CPUHexagonState *env, uint32_t mask, uint32_t type)
+{
+    g_assert(bql_locked());
+    if (mask == 0) {
+        return;
+    }
+
+    /*
+     * Notify all CPUs that the interrupt has happened
+     */
+    set_ipend(env, mask);
+    hex_interrupt_update(env);
+}
+
+void hex_interrupt_update(CPUHexagonState *env)
+{
+    CPUState *cs;
+
+    g_assert(bql_locked());
+    if (get_ipend(env) != 0) {
+        CPU_FOREACH(cs) {
+            CPUHexagonState *hex_env = cpu_env(cs);
+            const int exe_mode = get_exe_mode(hex_env);
+            if (exe_mode != HEX_EXE_MODE_OFF) {
+                cs->interrupt_request |= CPU_INTERRUPT_SWI;
+                cpu_resume(cs);
+            }
+        }
+    }
+}
-- 
2.34.1


