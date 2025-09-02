Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E672CA100D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0a-0007XA-8H; Mon, 01 Sep 2025 23:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0G-000745-Vx
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0C-0004WA-AG
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:15 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S9VW013338
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CdQHjAoqrRHes3MJK+/dEWICrkK2GN2WR2UEEkfrfEs=; b=lXGRBiRHjzrNDMfK
 oEXClDtZJgeCcR5bJhZiZmJpQ2y6gJIMZZJV0InyCP8IchBf5G9Jb7bvI8e5/qop
 cXFEPMLCBQ01Mu7Ul2OmAb44YB3K0akOu2LgpkKQ4FE8089w+nlLFefbrK+g+1s8
 WWt8+CDPYlmulgZxyld30rFgyROSjjl+CkP5hFYMd6gTZz258oG7K5/cObQwYXSR
 RQD1bn4SwiuF/aZRkrSNZw3Ic0V0KSQ0gyp+GdKWIuoJa4ap5dD5A8bvotVF/p/J
 nt8DbtazNhi4jgzuF+QOQSUfl5cHBRoIk7RZ3izBr+QJziarTAYfnq0WzCBT1zIz
 E6dqLg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fea1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:48:00 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b4e1675ba95so2266522a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784879; x=1757389679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CdQHjAoqrRHes3MJK+/dEWICrkK2GN2WR2UEEkfrfEs=;
 b=YbEfo/uE3dtzEVelU/eDG6LiCbR5Wl5nXWlAaS0dkOO7VqxusOjgyl9cHrMh2aNCr3
 tMgu57oA8lMy0nlULS02wL5HjRneeSkwbb/eTvYqSyfbjp9IPPvR0kZRQKmRU8TR01Km
 +Y6BvnCJy92vgeMEoz+91hsWx8opCsNfUjSAseYuqD7q7luPgIvaGGCa/nY2cFvB8HQI
 i89isH7TpPr6iqAjz1mgfHMTR6iNOgOlvARFwB9xPxWuaY30hAfeFkAMR6Q5Nkqnfl/D
 5ynpmll9T73zjDnVf1ZA3lc1jLu5rAMoY09cAyJr3lqZaHsWG/6N0o6ysi0TTpIyd16J
 U/pw==
X-Gm-Message-State: AOJu0YycDXC7kwulk41IeHWn0AMzhI1DrXBv0CWQpUUV2DjTYJwUfp6T
 NbS49cBhy+SH4MFKqhtCrDSq2e4ir5vLcEawAKsDESkQc1JU09D+Bk4vKE/MH6pfTjas+wOBEwG
 lDx0O7Nad3nY/c9ECAe5DH5RrrycwENpXaYoC9z5wBsFnjRkCJPo0yKQucGoJ3/CRDhLn
X-Gm-Gg: ASbGncv1gdovt8meHcj6xnLKgQpjO0SBDp91dv/YN8BKS4cOS/8BVtZFZH8pwGcDMDW
 ZgEohiPyFm0RXBL0ox8/ROXcC+2MMwe08ubeYXSLRrhHZ2d1AS0u2nY5phpsst62seo0yh2ETMu
 ZylLaNdCBoUsiQnZXX7tAtb+aQGuhYIv5vc8Y/P9Py9w8E60jEWhVu6x9EZf3k0WmxfH7/Le/5x
 w2rGsztSqS01CDteQ8/1c+hTVZmu1TlEFYPXsx+oVz7DnaUI5hhMS8PG18smhXpM2lo5V++wHAZ
 HPzMR0+WqI9cJuojf5N4M/PF7DtRe2CbdrV1tYxZL6ckWtb5O591oMS1RcNl1GBAx8YyMcp3SLc
 32lGyh01JMxOM
X-Received: by 2002:a05:6a21:999a:b0:243:78a:82c6 with SMTP id
 adf61e73a8af0-243d5234e33mr15114945637.27.1756784879134; 
 Mon, 01 Sep 2025 20:47:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGjqB7GfcLoxrkkT/UIEREYXyVn+N8SEfVYfzjXolvcEVxMW9AYMxqnom9qE/FiabFO1nKSQ==
X-Received: by 2002:a05:6a21:999a:b0:243:78a:82c6 with SMTP id
 adf61e73a8af0-243d5234e33mr15114910637.27.1756784878546; 
 Mon, 01 Sep 2025 20:47:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>
Subject: [PATCH v2 31/40] target/hexagon: Add sreg_{read,write} helpers
Date: Mon,  1 Sep 2025 20:47:06 -0700
Message-Id: <20250902034715.1947718-32-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX/H11H9cCMUnS
 kdkKdoEfvtuPR7cinHA32ZT30b9vMyYDE/4facX5Fd2Bf1Jny28h/O66+AOnVmqo28HSYL424B7
 aZ3cNt10WWP17aMqxqF1y86MVff5doieIylyhv8dmUtoGFy5qRh4a3/XucB2kVQPj+6R5hmvWYs
 u6gB3TbQg3G34fYDYXG9pbdBqQHoAu6W7+kpsHMNtgWRJefLdFgL3TYEGoJN0rflrIe3bXzMWVe
 NGfDglXM555pQ/+fvSj39EYMpGVm9WjSRYKCpTgBONiOdowcc6DLdM2ZJEFsVdz0LqrXon0V8b8
 V7QtCEXiNY6U1BouLm7XgcGi8xoArh5CT3kJRhtfkfIuD1q3KOToP5qzwV5ESEZjYt3ya+j9lLV
 aWQzAL/8
X-Proofpoint-ORIG-GUID: kzNYySnpRvi4HQT4EY91m-5nTeWpuSOK
X-Proofpoint-GUID: kzNYySnpRvi4HQT4EY91m-5nTeWpuSOK
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b668f0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=CWTooRxD2BlePtgY-i0A:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=TjNXssC_j7lpFel5tvFf:22
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

From: Brian Cain <bcain@quicinc.com>

Co-authored-by: Sid Manning <sidneym@quicinc.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu_helper.h |   8 ++
 target/hexagon/cpu.c        |   1 -
 target/hexagon/cpu_helper.c |  37 +++++++++
 target/hexagon/op_helper.c  | 152 +++++++++++++++++++++++++++++++++++-
 4 files changed, 193 insertions(+), 5 deletions(-)

diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index 194bcbf451..5f5f15149a 100644
--- a/target/hexagon/cpu_helper.h
+++ b/target/hexagon/cpu_helper.h
@@ -7,6 +7,14 @@
 #ifndef HEXAGON_CPU_HELPER_H
 #define HEXAGON_CPU_HELPER_H
 
+uint32_t hexagon_get_pmu_counter(CPUHexagonState *cur_env, int index);
+uint64_t hexagon_get_sys_pcycle_count(CPUHexagonState *env);
+uint32_t hexagon_get_sys_pcycle_count_low(CPUHexagonState *env);
+uint32_t hexagon_get_sys_pcycle_count_high(CPUHexagonState *env);
+void hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t);
+void hexagon_set_sys_pcycle_count_low(CPUHexagonState *env, uint32_t);
+void hexagon_set_sys_pcycle_count_high(CPUHexagonState *env, uint32_t);
+
 static inline void arch_set_thread_reg(CPUHexagonState *env, uint32_t reg,
                                        uint32_t val)
 {
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 39b45e6452..bdc9d18395 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -329,7 +329,6 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
 
     qemu_init_vcpu(cs);
     cpu_reset(cs);
-
     mcc->parent_realize(dev, errp);
 }
 
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index 01fdd6b28d..4b8697de65 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -29,10 +29,47 @@
 
 #ifndef CONFIG_USER_ONLY
 
+uint32_t hexagon_get_pmu_counter(CPUHexagonState *cur_env, int index)
+{
+    g_assert_not_reached();
+}
+
 uint32_t arch_get_system_reg(CPUHexagonState *env, uint32_t reg)
 {
     g_assert_not_reached();
 }
 
+uint64_t hexagon_get_sys_pcycle_count(CPUHexagonState *env)
+{
+    g_assert_not_reached();
+}
+
+uint32_t hexagon_get_sys_pcycle_count_high(CPUHexagonState *env)
+{
+    g_assert_not_reached();
+}
+
+uint32_t hexagon_get_sys_pcycle_count_low(CPUHexagonState *env)
+{
+    g_assert_not_reached();
+}
+
+void hexagon_set_sys_pcycle_count_high(CPUHexagonState *env,
+        uint32_t cycles_hi)
+{
+    g_assert_not_reached();
+}
+
+void hexagon_set_sys_pcycle_count_low(CPUHexagonState *env,
+        uint32_t cycles_lo)
+{
+    g_assert_not_reached();
+}
+
+void hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t cycles)
+{
+    g_assert_not_reached();
+}
+
 
 #endif
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 0aa9b91f85..7851f43475 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/log.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
+#include "qemu/main-loop.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 #include "cpu.h"
@@ -1397,25 +1398,168 @@ void HELPER(setimask)(CPUHexagonState *env, uint32_t pred, uint32_t imask)
     g_assert_not_reached();
 }
 
+static bool handle_pmu_sreg_write(CPUHexagonState *env, uint32_t reg,
+                                  uint32_t val)
+{
+    if (reg == HEX_SREG_PMUSTID0 || reg == HEX_SREG_PMUSTID1
+        || reg == HEX_SREG_PMUCFG || reg == HEX_SREG_PMUEVTCFG
+        || reg == HEX_SREG_PMUEVTCFG1
+        || (reg >= HEX_SREG_PMUCNT4 && reg <= HEX_SREG_PMUCNT3)) {
+        qemu_log_mask(LOG_UNIMP, "PMU registers not yet implemented");
+        return true;
+    }
+    return false;
+}
+
+static void modify_syscfg(CPUHexagonState *env, uint32_t val)
+{
+    g_assert_not_reached();
+}
+
+static void hexagon_set_vid(CPUHexagonState *env, uint32_t offset, int val)
+{
+    g_assert_not_reached();
+}
+
+static uint32_t hexagon_find_last_irq(CPUHexagonState *env, uint32_t vid)
+{
+    g_assert_not_reached();
+}
+
+static void hexagon_read_timer(CPUHexagonState *env, uint32_t *low,
+                               uint32_t *high)
+{
+    qemu_log_mask(LOG_UNIMP, "reading timer_hi/lo not yet supported\n");
+}
+
+static inline QEMU_ALWAYS_INLINE void sreg_write(CPUHexagonState *env,
+                                                 uint32_t reg, uint32_t val)
+
+{
+    g_assert(bql_locked());
+    if ((reg == HEX_SREG_VID) || (reg == HEX_SREG_VID1)) {
+        if (val != L2VIC_NO_PENDING) {
+            hexagon_set_vid(env,
+                            (reg == HEX_SREG_VID) ? L2VIC_VID_0 : L2VIC_VID_1,
+                            val);
+            arch_set_system_reg(env, reg, val);
+        }
+    } else if (reg == HEX_SREG_SYSCFG) {
+        modify_syscfg(env, val);
+    } else if (reg == HEX_SREG_IMASK) {
+        val = GET_FIELD(IMASK_MASK, val);
+        arch_set_system_reg(env, reg, val);
+    } else if (reg == HEX_SREG_PCYCLELO) {
+        hexagon_set_sys_pcycle_count_low(env, val);
+    } else if (reg == HEX_SREG_PCYCLEHI) {
+        hexagon_set_sys_pcycle_count_high(env, val);
+    } else if (!handle_pmu_sreg_write(env, reg, val)) {
+        if (reg >= HEX_SREG_GLB_START) {
+            arch_set_system_reg(env, reg, val);
+        } else {
+            arch_set_system_reg(env, reg, val);
+        }
+    }
+}
+
+static inline QEMU_ALWAYS_INLINE void
+sreg_write_masked(CPUHexagonState *env, uint32_t reg, uint32_t val)
+
+{
+    g_assert(bql_locked());
+    if ((reg == HEX_SREG_VID) || (reg == HEX_SREG_VID1)) {
+        HexagonCPU *cpu = env_archcpu(env);
+        val = hexagon_globalreg_masked_value(cpu, reg, val);
+        hexagon_set_vid(env,
+                        (reg == HEX_SREG_VID) ? L2VIC_VID_0 : L2VIC_VID_1,
+                        val);
+        arch_set_system_reg(env, reg, val);
+    } else if (reg == HEX_SREG_SYSCFG) {
+        modify_syscfg(env, val);
+    } else if (reg == HEX_SREG_IMASK) {
+        val = GET_FIELD(IMASK_MASK, val);
+        arch_set_system_reg_masked(env, reg, val);
+    } else if (reg == HEX_SREG_PCYCLELO) {
+        hexagon_set_sys_pcycle_count_low(env, val);
+    } else if (reg == HEX_SREG_PCYCLEHI) {
+        hexagon_set_sys_pcycle_count_high(env, val);
+    } else if (!handle_pmu_sreg_write(env, reg, val)) {
+        arch_set_system_reg_masked(env, reg, val);
+    }
+}
+
 void HELPER(sreg_write)(CPUHexagonState *env, uint32_t reg, uint32_t val)
 {
-    g_assert_not_reached();
+    BQL_LOCK_GUARD();
+    sreg_write(env, reg, val);
 }
 
 void HELPER(sreg_write_pair)(CPUHexagonState *env, uint32_t reg, uint64_t val)
+{
+    BQL_LOCK_GUARD();
+    sreg_write(env, reg, val & 0xFFFFFFFF);
+    sreg_write(env, reg + 1, val >> 32);
+}
+
+void HELPER(sreg_write_pair_masked)(CPUHexagonState *env, uint32_t reg,
+                                    uint64_t val)
+
+{
+    BQL_LOCK_GUARD();
+    sreg_write_masked(env, reg, val & 0xFFFFFFFF);
+    sreg_write_masked(env, reg + 1, val >> 32);
+}
 
+static inline QEMU_ALWAYS_INLINE uint32_t sreg_read(CPUHexagonState *env,
+                                                    uint32_t reg)
 {
-    g_assert_not_reached();
+    g_assert(bql_locked());
+    if (reg == HEX_SREG_PMUSTID0 || reg == HEX_SREG_PMUSTID1
+        || reg == HEX_SREG_PMUCFG || reg == HEX_SREG_PMUEVTCFG
+        || reg == HEX_SREG_PMUEVTCFG1
+        || (reg >= HEX_SREG_PMUCNT4 && reg <= HEX_SREG_PMUCNT3)) {
+        qemu_log_mask(LOG_UNIMP, "PMU registers not yet implemented");
+        return 0;
+    }
+    if ((reg == HEX_SREG_VID) || (reg == HEX_SREG_VID1)) {
+        const uint32_t vid = hexagon_find_last_irq(env, reg);
+        arch_set_system_reg(env, reg, vid);
+    } else if ((reg == HEX_SREG_TIMERLO) || (reg == HEX_SREG_TIMERHI)) {
+        uint32_t low = 0;
+        uint32_t high = 0;
+        hexagon_read_timer(env, &low, &high);
+        arch_set_system_reg(env, HEX_SREG_TIMERLO, low);
+        arch_set_system_reg(env, HEX_SREG_TIMERHI, high);
+    } else if (reg == HEX_SREG_BADVA) {
+        target_ulong ssr = arch_get_system_reg(env, HEX_SREG_SSR);
+        if (GET_SSR_FIELD(SSR_BVS, ssr)) {
+            return arch_get_system_reg(env, HEX_SREG_BADVA1);
+        }
+        return arch_get_system_reg(env, HEX_SREG_BADVA0);
+    }
+    return arch_get_system_reg(env, reg);
 }
 
 uint32_t HELPER(sreg_read)(CPUHexagonState *env, uint32_t reg)
 {
-    g_assert_not_reached();
+    BQL_LOCK_GUARD();
+    return sreg_read(env, reg);
 }
 
 uint64_t HELPER(sreg_read_pair)(CPUHexagonState *env, uint32_t reg)
 {
-    g_assert_not_reached();
+    BQL_LOCK_GUARD();
+    if (reg == HEX_SREG_TIMERLO) {
+        uint32_t low = 0;
+        uint32_t high = 0;
+        hexagon_read_timer(env, &low, &high);
+        arch_set_system_reg(env, HEX_SREG_TIMERLO, low);
+        arch_set_system_reg(env, HEX_SREG_TIMERHI, high);
+    } else if (reg == HEX_SREG_PCYCLELO) {
+        return hexagon_get_sys_pcycle_count(env);
+    }
+    return   (uint64_t)sreg_read(env, reg) |
+           (((uint64_t)sreg_read(env, reg + 1)) << 32);
 }
 
 uint32_t HELPER(greg_read)(CPUHexagonState *env, uint32_t reg)
-- 
2.34.1


