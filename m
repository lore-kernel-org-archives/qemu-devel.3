Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD89F417EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv8-0001gm-8W; Mon, 09 Mar 2026 10:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbv6-0001c3-DD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbv3-0005Kh-UL
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:20 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629DHMsR1379889
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 drZCSiR/Lb07j5mLq6FsfxF0pIT7Ny6NPQHOqeriHFU=; b=jrnhYfClUG+rrGX/
 KPRLofaAYOBeO6zeTDEpBdhR11vyQhc1Vl2vlYLHzx+Hh92Ses8RkrPd/E63avmF
 v3UjwXyrUgK1ztSrwIdSaQwOfd8iy9z+zGlmMmev9etSn5ormGcIdXRrDK5HYyGG
 CdRydAnbcWyC7Hqg5SsS1XTgFXIIK9fAClR6EjRtsS9tpjmieINSTDL8PQvNmyFE
 7YHy2CNrvZ0VSPDDZz9jjAwVGQTzQcjAp+3jQBT2AAXkJt8PC+kkoTIsJIcFBRT9
 T425EGgA9W7uxlPfJOTMuG+Ro7Va6mbaErm1Lde1QN48dhPeYFt0k9dU+y4yTOCm
 /LzJqA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csxy80a3w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:49:06 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2be27d4e3e5so79014522eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067746; x=1773672546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=drZCSiR/Lb07j5mLq6FsfxF0pIT7Ny6NPQHOqeriHFU=;
 b=NuCUVKNd6C+ZUUta2KCSs7g9tzOOzdraSG0y+/ZnKEPnnsRVdXsfq/Iscb/lEYQVrj
 COcd30okLw704alo2gQidId2sqIB7a2BPPOvC0tpf8ugOa0Vbyx9s18CQ37ec4honLMS
 Um/Z7osQDFBtLl10Br+d382TnL7T7JMHJLmRp+nPXZBG2DBLIClBO3G5Tt2F0dXoDZH+
 dHp7SQOHBUFczFIvivBEN5VJ/iHNWWv6FqK8L6Kqccm9pfW8IXCvxhSIRdv5fBp7QNS/
 4C7tzKhTR1y/aRTWchDgZb0efmSKMcrTlpBQugbV15eXIZvP3HJGZ/qmQNQ5ffdNSODG
 CpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067746; x=1773672546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=drZCSiR/Lb07j5mLq6FsfxF0pIT7Ny6NPQHOqeriHFU=;
 b=p/LhlV5A1X8T+Mk3+9oqGyWxnwhwtP+oxeYXVrXwG8q2P8vOPJ0qhSTN6hJV+uu5Kd
 OLIUlZqAGZG8rxpfKmob3LKLMKXzMpDHCvofUpv9inpilZdU9m/FvutojYCTBzujB2k3
 ElJQX6Zmm78/3yc4ZpXtSom4JoJp1UF/kSKCtJN9rr2uhh+tLi92vtTQJceDGFE0+/mv
 Hi62M1ue3QtBhr8mEILMOCn48w5yB1nuvXn+nSUCjRYcG9+gVSp3hQCLcnc7PsrR0AAu
 13K6cxK7xFwEwEyyqGEE6HxYtX4owkJnYq3Mf0jYCTdpNzKHd/EMckiJbFyCt+EHiXFs
 EIqg==
X-Gm-Message-State: AOJu0YxHM4G2dcSND5zQL9QYr9fu0744bKlStw2RO86znyArHhwvu6mQ
 8aSgOP1K6kRFzL0NV6ldPVwnkBkQFykvi3GTmijgdGMotgfDS0RC8DOSvDYM6BfYd1AoZJHIgB7
 bVBUC9baGan4dC3i56fOyhmKG7Fc+2fjkBZwBR879WRsVm9QlhhW2RUi6wAfl5JT0Tg==
X-Gm-Gg: ATEYQzwxCn/HPu3QqJXJCsYpZW8NbNFzMLD74becb/TX++6BTOihpmv7ITY8ftdemRE
 sTTdYyjMXVUb1n3AJWc5z/qu84h6HbOLdfh+DvdPnXTma2ktrVVLJNkeXylhlgp30Ans+fdMVIE
 vv+877jC4sR9CV0gkruVMz/1gaPZBi3BWpEeW48hdmau2b90wswbJYV+uOjK4uBdpXIjVQpnPZQ
 1xbl1+wVGrl3xxNwiEvDcnTPI7EVE5NWnAcKjxgtq/CJMG30PP6EIZQrQXejcFXIfN1RfO4BYGM
 z8715oPf5vEL3hCHZQLals3j/YHT2K5xJxTI6rFbwLg9I85/tTk+1HJIy7x5gLnwSdSPqS8zloT
 NuQYyHxOLTO7m4Wspy6gpQF2jv2Juo1/oO44Zao63+RXjGVynY9a4FQv5vO4RQmud05fCig==
X-Received: by 2002:a05:7301:4591:b0:2b6:ffb9:9633 with SMTP id
 5a478bee46e88-2be4de9a868mr4666596eec.15.1773067745451; 
 Mon, 09 Mar 2026 07:49:05 -0700 (PDT)
X-Received: by 2002:a05:7301:4591:b0:2b6:ffb9:9633 with SMTP id
 5a478bee46e88-2be4de9a868mr4666571eec.15.1773067744801; 
 Mon, 09 Mar 2026 07:49:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:49:04 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>, Michael Lambert <mlambert@quicinc.com>
Subject: [PATCH v4 35/35] target/hexagon: Add hex_interrupts support
Date: Mon,  9 Mar 2026 07:48:22 -0700
Message-Id: <20260309144822.877695-36-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SvmdKfO0 c=1 sm=1 tr=0 ts=69aedde2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VnV_t2xz1Vg1SzblAT0A:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=scEy_gLbYbu1JhEsrz4S:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: GPIGrgEPeO5db5sgGsFjyqxTCxW0yRIg
X-Proofpoint-ORIG-GUID: GPIGrgEPeO5db5sgGsFjyqxTCxW0yRIg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX2fiE/L0w/vka
 K1lIEyaEJA2Ehslv+XdBKdGDyTRB6g+sCjvz4p+xYckTAriR7VldwANOMQ2zb3pS1/f6vf3+sn3
 ZrLg/W1OuB7R795g1c0T50t/G4L06MKaTD8y8ladMrF4q2nlv0BLPtTKZffybpLYt0OR+OGzbeO
 PwvOaRowLgLZDQ3AdOIu3uK91byrmO8Aty8BhmcDuoW3XxWIGpuhjWpScbGW8rTJyNU9qAnET5d
 1VoKGDh5JGLVQJvQSsfXJeyFsPue6jVGge2gQrb58LoexCiRM4+dXhWggkWHYqrsXd/Odk9WlQO
 nQ4aI2pl0YbN6D9GFm0JUjPwAvcv6v2ptkBXW5VaXRyHRbVHsaN9Et6JVYj+DYCRtv045LIYx5d
 3XZTIXOilQSsZ6nacfL6X0JhOJvwxhky3Ow6W9W+Kbl202KLUyD5mttWIJt44mob6NRoF9hc/Wo
 7/HZPNMf5GxS53tgiiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Co-authored-by: Sid Manning <sidneym@quicinc.com>
Co-authored-by: Michael Lambert <mlambert@quicinc.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h            |   3 +
 target/hexagon/hex_interrupts.h |  15 ++
 target/hexagon/cpu.c            |   5 +
 target/hexagon/hex_interrupts.c | 375 ++++++++++++++++++++++++++++++++
 4 files changed, 398 insertions(+)
 create mode 100644 target/hexagon/hex_interrupts.h
 create mode 100644 target/hexagon/hex_interrupts.c

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index d8092cb6fe7..344f1cfdf5b 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -192,6 +192,9 @@ struct ArchCPU {
     bool short_circuit;
 #ifndef CONFIG_USER_ONLY
     struct HexagonTLBState *tlb;
+    uint32_t hvx_contexts;
+    uint32_t boot_addr;
+    struct HexagonGlobalRegState *globalregs;
     uint32_t htid;
 #endif
 };
diff --git a/target/hexagon/hex_interrupts.h b/target/hexagon/hex_interrupts.h
new file mode 100644
index 00000000000..6b6f5403633
--- /dev/null
+++ b/target/hexagon/hex_interrupts.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
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
index 5c937fa1cd1..7b340060344 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -61,6 +61,10 @@ static const Property hexagon_cpu_properties[] = {
 #if !defined(CONFIG_USER_ONLY)
     DEFINE_PROP_LINK("tlb", HexagonCPU, tlb, TYPE_HEXAGON_TLB,
                      HexagonTLBState *),
+    DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU, boot_addr, 0xffffffff),
+    DEFINE_PROP_UINT32("hvx-contexts", HexagonCPU, hvx_contexts, 0),
+    DEFINE_PROP_LINK("global-regs", HexagonCPU, globalregs,
+        TYPE_HEXAGON_GLOBALREG, HexagonGlobalRegState *),
     DEFINE_PROP_UINT32("htid", HexagonCPU, htid, 0),
 #endif
     DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
@@ -340,6 +344,7 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
     HexagonCPU *cpu = HEXAGON_CPU(cs);
     env->t_sreg[HEX_SREG_HTID] = cpu->htid;
     env->threadId = cpu->htid;
+    env->gpr[HEX_REG_PC] = cpu->boot_addr;
 #endif
     env->cause_code = HEX_EVENT_NONE;
 }
diff --git a/target/hexagon/hex_interrupts.c b/target/hexagon/hex_interrupts.c
new file mode 100644
index 00000000000..f1be67d5116
--- /dev/null
+++ b/target/hexagon/hex_interrupts.c
@@ -0,0 +1,375 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
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
+#include "hw/hexagon/hexagon_globalreg.h"
+
+static bool hex_is_qualified_for_int(CPUHexagonState *env, int int_num);
+
+static bool get_syscfg_gie(CPUHexagonState *env)
+{
+    HexagonCPU *cpu = env_archcpu(env);
+    uint32_t syscfg = cpu->globalregs ?
+        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_SYSCFG,
+                               env->threadId) : 0;
+    return GET_SYSCFG_FIELD(SYSCFG_GIE, syscfg);
+}
+
+static bool get_ssr_ex(CPUHexagonState *env)
+{
+    uint32_t ssr = env->t_sreg[HEX_SREG_SSR];
+    return GET_SSR_FIELD(SSR_EX, ssr);
+}
+
+static bool get_ssr_ie(CPUHexagonState *env)
+{
+    uint32_t ssr = env->t_sreg[HEX_SREG_SSR];
+    return GET_SSR_FIELD(SSR_IE, ssr);
+}
+
+/* Do these together so we only have to call hexagon_modify_ssr once */
+static void set_ssr_ex_cause(CPUHexagonState *env, int ex, uint32_t cause)
+{
+    uint32_t old = env->t_sreg[HEX_SREG_SSR];
+    SET_SYSTEM_FIELD(env, HEX_SREG_SSR, SSR_EX, ex);
+    SET_SYSTEM_FIELD(env, HEX_SREG_SSR, SSR_CAUSE, cause);
+    uint32_t new = env->t_sreg[HEX_SREG_SSR];
+    hexagon_modify_ssr(env, new, old);
+}
+
+static bool get_iad_bit(CPUHexagonState *env, int int_num)
+{
+    HexagonCPU *cpu = env_archcpu(env);
+    uint32_t ipendad = cpu->globalregs ?
+        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_IPENDAD,
+                               env->threadId) : 0;
+    uint32_t iad = GET_FIELD(IPENDAD_IAD, ipendad);
+    return extract32(iad, int_num, 1);
+}
+
+static void set_iad_bit(CPUHexagonState *env, int int_num, int val)
+{
+    HexagonCPU *cpu = env_archcpu(env);
+    uint32_t ipendad = cpu->globalregs ?
+        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_IPENDAD,
+                               env->threadId) : 0;
+    uint32_t iad = GET_FIELD(IPENDAD_IAD, ipendad);
+    iad = deposit32(iad, int_num, 1, val);
+    fSET_FIELD(ipendad, IPENDAD_IAD, iad);
+    if (cpu->globalregs) {
+        hexagon_globalreg_write(cpu->globalregs, HEX_SREG_IPENDAD,
+                                ipendad, env->threadId);
+    }
+}
+
+static uint32_t get_ipend(CPUHexagonState *env)
+{
+    HexagonCPU *cpu = env_archcpu(env);
+    uint32_t ipendad = cpu->globalregs ?
+        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_IPENDAD,
+                               env->threadId) : 0;
+    return GET_FIELD(IPENDAD_IPEND, ipendad);
+}
+
+static inline bool get_ipend_bit(CPUHexagonState *env, int int_num)
+{
+    HexagonCPU *cpu = env_archcpu(env);
+    uint32_t ipendad = cpu->globalregs ?
+        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_IPENDAD,
+                               env->threadId) : 0;
+    uint32_t ipend = GET_FIELD(IPENDAD_IPEND, ipendad);
+    return extract32(ipend, int_num, 1);
+}
+
+static void clear_ipend(CPUHexagonState *env, uint32_t mask)
+{
+    HexagonCPU *cpu = env_archcpu(env);
+    uint32_t ipendad = cpu->globalregs ?
+        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_IPENDAD,
+                               env->threadId) : 0;
+    uint32_t ipend = GET_FIELD(IPENDAD_IPEND, ipendad);
+    ipend &= ~mask;
+    fSET_FIELD(ipendad, IPENDAD_IPEND, ipend);
+    if (cpu->globalregs) {
+        hexagon_globalreg_write(cpu->globalregs, HEX_SREG_IPENDAD,
+                                ipendad, env->threadId);
+    }
+}
+
+static void set_ipend(CPUHexagonState *env, uint32_t mask)
+{
+    HexagonCPU *cpu = env_archcpu(env);
+    uint32_t ipendad = cpu->globalregs ?
+        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_IPENDAD,
+                               env->threadId) : 0;
+    uint32_t ipend = GET_FIELD(IPENDAD_IPEND, ipendad);
+    ipend |= mask;
+    fSET_FIELD(ipendad, IPENDAD_IPEND, ipend);
+    if (cpu->globalregs) {
+        hexagon_globalreg_write(cpu->globalregs, HEX_SREG_IPENDAD,
+                                ipendad, env->threadId);
+    }
+}
+
+static void set_ipend_bit(CPUHexagonState *env, int int_num, int val)
+{
+    HexagonCPU *cpu = env_archcpu(env);
+    uint32_t ipendad = cpu->globalregs ?
+        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_IPENDAD,
+                               env->threadId) : 0;
+    uint32_t ipend = GET_FIELD(IPENDAD_IPEND, ipendad);
+    ipend = deposit32(ipend, int_num, 1, val);
+    fSET_FIELD(ipendad, IPENDAD_IPEND, ipend);
+    if (cpu->globalregs) {
+        hexagon_globalreg_write(cpu->globalregs, HEX_SREG_IPENDAD,
+                                ipendad, env->threadId);
+    }
+}
+
+static bool get_imask_bit(CPUHexagonState *env, int int_num)
+{
+    uint32_t imask = env->t_sreg[HEX_SREG_IMASK];
+    return extract32(imask, int_num, 1);
+}
+
+static uint32_t get_prio(CPUHexagonState *env)
+{
+    uint32_t stid = env->t_sreg[HEX_SREG_STID];
+    return extract32(stid, reg_field_info[STID_PRIO].offset,
+                     reg_field_info[STID_PRIO].width);
+}
+
+static void set_elr(CPUHexagonState *env, uint32_t val)
+{
+    env->t_sreg[HEX_SREG_ELR] = val;
+}
+
+static bool get_schedcfgen(CPUHexagonState *env)
+{
+    HexagonCPU *cpu = env_archcpu(env);
+    uint32_t schedcfg = cpu->globalregs ?
+        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_SCHEDCFG,
+                               env->threadId) : 0;
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
+    HexagonCPU *cpu = env_archcpu(env);
+    uint32_t evb = cpu->globalregs ?
+        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_EVB,
+                               env->threadId) : 0;
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
+                          "%s: thread[" TARGET_FMT_ld "] "
+                          "pc = 0x" TARGET_FMT_lx
+                          " found int %d\n",
+                          __func__, env->threadId,
+                          env->gpr[HEX_REG_PC], i);
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
+                          "%s: thread[" TARGET_FMT_ld "] "
+                          "int %d not handled, qualified: %d, "
+                          "schedcfg_en: %d, low prio %d\n",
+                          __func__, env->threadId, i,
+                          hex_is_qualified_for_int(env, i), schedcfgen,
+                          is_lowest_prio(env, i));
+
+            qemu_log_mask(CPU_LOG_INT,
+                          "%s: thread[" TARGET_FMT_ld "] "
+                          "int %d not handled, GIE %d, iad %d, "
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
+                cpu_interrupt(cs, CPU_INTERRUPT_SWI);
+                cpu_resume(cs);
+            }
+        }
+    }
+}
-- 
2.34.1


