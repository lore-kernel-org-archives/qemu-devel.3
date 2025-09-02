Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC53CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1d-0003Zu-Ah; Mon, 01 Sep 2025 23:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1X-0002z4-50
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1U-0004e0-Ho
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S9eh013671
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=vO09PguiJvsNsCrY1kFOKrQbz5IYjPfLPbK3g08GdlY=; b=T7
 A9WKgMSCmSS8JwTH/7alMmQ3N/DAo6vIrhPIbgl05Q2AHgnJZTIMhjvNDii8EjCv
 ycQ679J3s2fPOS2uztcgfrZCC+/IO0vjUsmTAIjFsTbHhHlKjtj7IerWPRCzRpz8
 B0bO2rIsbflfAFHsFFAlpmz3VXiaWP+PabEOX+tnpxas9i2YsOQHhtqY5F3UASrd
 tvBjzSEs049Ok/9vAEtvJSKJ9BXwnnhXc9qoeXx2thXYrUsOqGLdEwMZD0CRl46F
 Rcwe9FedVENDWNY79dCi83J73OfGcNGHyzlB+zSrgy+exJNhEH1kjSGl/u/Z4U5Z
 yPmu+5PKnH7gIwvgxAbg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0eej9h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24458345f5dso55448205ad.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784959; x=1757389759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vO09PguiJvsNsCrY1kFOKrQbz5IYjPfLPbK3g08GdlY=;
 b=uxoBkzEtu9aD2OTj8xozJF4UmEk8dr36lTe0YLjRv38LteVjZPdWng4WqUdIBE3ia4
 SYecTgo6OGwQY/B5eLmlBfv71xORUTVcIFGrONgbaeGNNWzDJaXyxmhJQS6s+1hbhkAY
 YdPl7OXVXTG13sA7pYjDmjPvz9saoxl7mW24WKcndNYB3ZkvZkVYvKI+1h0bCiAxl/Qd
 bv3n+HqTY+wupFVgEljYeTW4QVZaglmmasi+idDBt7Zi/p+CCjpvkWtKQ918eT2Xjm9t
 c+Q05TCLqrcsAoTTQFwDiTO2TgsLJprR7TeQ9TmJ7SUsyToxA2TaAGMCjhmcU7YAUlJA
 WzwQ==
X-Gm-Message-State: AOJu0Ywy7VYJUL9gDDvN6wDEWyE92g1kKnx4N1/+ulOlzhfHqZDKE9cv
 SF5oD06ljgEyiFnvGaVIkoiEy+51qHOGhldjG/4/XgRgUQ4rh8a5bAhn5KbQfZH4yYWS1AStGyv
 BYFakU1RlkUaQYnthTLPnMUSw6i10uunTU4lfmrgWnCzmBu2cakdyZ+qtjgkjLMjDebY8
X-Gm-Gg: ASbGncvpqRIjNphrPBskx+wa43PdPuU5ZiwhquKfKGalZMdCvaqImNE3IyBeIiCRh6e
 g6WV0wQzK0KE0NpGvOQmJGkCvp9IQjkEXNk6QFFOdzwHdZ+zntnrWZVRkBUvqVFgN17AEMHvYBM
 KUQsCBD0mhdro49AoLVwSvE/rcgD8CNbHV27fOWtHNmVuRS6NCSq2+Zu4rb7Kl+TWiuc0fy6LpC
 GFboYSe1nRsWDp1DAcbJo8YhC/jPvUGjAFFgS7PzAyxA+/f+Kky1duZ4MhkgudZOP9jpn52ynk+
 v1Z5X7/np5V3TfIo2fDUHWFkSpBBMLSAu7ui9HOKM3MNJMJyqZNeX7AG03v8vlRmfRRHHnKBpkK
 uWQw182fbecRO
X-Received: by 2002:a17:902:d501:b0:245:f1bb:9bf9 with SMTP id
 d9443c01a7336-24944870959mr156109815ad.12.1756784959368; 
 Mon, 01 Sep 2025 20:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6ZCqScf6kNOsvnh8lFAVv89GsuV33cDGjjWzXJVXc2UotnW1jwbJ8Cpohy4tm8GVn8fj6Mw==
X-Received: by 2002:a17:902:d501:b0:245:f1bb:9bf9 with SMTP id
 d9443c01a7336-24944870959mr156109535ad.12.1756784958889; 
 Mon, 01 Sep 2025 20:49:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 22/39] target/hexagon: Implement setprio, resched
Date: Mon,  1 Sep 2025 20:48:30 -0700
Message-Id: <20250902034847.1948010-23-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HQOVEGqj-4QYM0RlHIiTOYBdTvXoz9mm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX9bIJdPuJvsO7
 /sH2mKBjLZPp99XjoWcHV3urmERrsDcgiZEDNCZ4sgtcVMhTFLv4QNatpOHmAkDs38Wd8afmYgY
 j3N9x/tUlpXKYN+Lej/CYuIB/S5NtyBxwXfOgJgTNTRNfoqkupLDeNukfRNXAFBCzXYn+uKwBr9
 3y37X6T4WYHcMe5ExGhriWM/uFs5QqBmSTo0jHw0v5PpsucPmvMUJvslQpko/lArjbLOIM+dV9Y
 DM/UiMVeGOLaY2LJNl4KDXgixNNT2fMfMKEVi6IM1I8n/9shLY86hNCJZ0Dn5OwuP54k4BSHwXC
 f3Tn8qbxMUthGUq1AJWiLhdS4eIBUW6Uy21bxg0eNB5nTcxPNb7MbKNYYeH3cJxqBklV+dXXGIa
 qS3oNhje
X-Proofpoint-ORIG-GUID: HQOVEGqj-4QYM0RlHIiTOYBdTvXoz9mm
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b66940 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=X_cK7RZiQvhuwfy_UrAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
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

The hardware-assisted scheduler helps manage tasks on the run queue
and interrupt steering.

This instruction is defined in the Qualcomm Hexagon V71 Programmer's Reference
Manual -
https://docs.qualcomm.com/bundle/publicresource/80-N2040-51_REV_AB_Hexagon_V71_ProgrammerS_Reference_Manual.pdf
See §11.9.2 SYSTEM MONITOR.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/op_helper.c | 71 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 63b9dda9a3..37a5b45e75 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1472,6 +1472,57 @@ void HELPER(stop)(CPUHexagonState *env)
     hexagon_stop_thread(env);
 }
 
+static inline QEMU_ALWAYS_INLINE void resched(CPUHexagonState *env)
+{
+    uint32_t schedcfg;
+    uint32_t schedcfg_en;
+    int int_number;
+    CPUState *cs;
+    uint32_t lowest_th_prio = 0; /* 0 is highest prio */
+    uint32_t bestwait_reg;
+    uint32_t best_prio;
+
+    BQL_LOCK_GUARD();
+    qemu_log_mask(CPU_LOG_INT, "%s: check resched\n", __func__);
+    schedcfg = arch_get_system_reg(env, HEX_SREG_SCHEDCFG);
+    schedcfg_en = GET_FIELD(SCHEDCFG_EN, schedcfg);
+    int_number = GET_FIELD(SCHEDCFG_INTNO, schedcfg);
+
+    if (!schedcfg_en) {
+        return;
+    }
+
+    CPU_FOREACH(cs) {
+        HexagonCPU *thread = HEXAGON_CPU(cs);
+        CPUHexagonState *thread_env = &(thread->env);
+        uint32_t th_prio = GET_FIELD(
+            STID_PRIO, arch_get_system_reg(thread_env, HEX_SREG_STID));
+        if (!hexagon_thread_is_enabled(thread_env)) {
+            continue;
+        }
+
+        lowest_th_prio = (lowest_th_prio > th_prio)
+            ? lowest_th_prio
+            : th_prio;
+    }
+
+    bestwait_reg = arch_get_system_reg(env, HEX_SREG_BESTWAIT);
+    best_prio = GET_FIELD(BESTWAIT_PRIO, bestwait_reg);
+
+    /*
+     * If the lowest priority thread is lower priority than the
+     * value in the BESTWAIT register, we must raise the reschedule
+     * interrupt on the lowest priority thread.
+     */
+    if (lowest_th_prio > best_prio) {
+        qemu_log_mask(CPU_LOG_INT,
+                "%s: raising resched int %d, cur PC 0x" TARGET_FMT_lx "\n",
+                __func__, int_number, arch_get_thread_reg(env, HEX_REG_PC));
+        SET_SYSTEM_FIELD(env, HEX_SREG_BESTWAIT, BESTWAIT_PRIO, ~0);
+        hex_raise_interrupts(env, 1 << int_number, CPU_INTERRUPT_SWI);
+    }
+}
+
 void HELPER(wait)(CPUHexagonState *env, target_ulong PC)
 {
     BQL_LOCK_GUARD();
@@ -1495,7 +1546,8 @@ uint32_t HELPER(getimask)(CPUHexagonState *env, uint32_t tid)
         CPUHexagonState *found_env = &found_cpu->env;
         if (found_env->threadId == tid) {
             target_ulong imask = arch_get_system_reg(found_env, HEX_SREG_IMASK);
-            qemu_log_mask(CPU_LOG_INT, "%s: tid %d imask = 0x%x\n",
+            qemu_log_mask(CPU_LOG_INT,
+                          "%s: tid " TARGET_FMT_lx " imask = 0x%x\n",
                           __func__, env->threadId,
                           (unsigned)GET_FIELD(IMASK_MASK, imask));
             return GET_FIELD(IMASK_MASK, imask);
@@ -1515,7 +1567,7 @@ void HELPER(setimask)(CPUHexagonState *env, uint32_t pred, uint32_t imask)
 
         if (pred == found_env->threadId) {
             SET_SYSTEM_FIELD(found_env, HEX_SREG_IMASK, IMASK_MASK, imask);
-            qemu_log_mask(CPU_LOG_INT, "%s: tid %d imask 0x%x\n",
+            qemu_log_mask(CPU_LOG_INT, "%s: tid " TARGET_FMT_lx " imask 0x%x\n",
                           __func__, found_env->threadId, imask);
             hex_interrupt_update(env);
             return;
@@ -1764,6 +1816,21 @@ uint64_t HELPER(greg_read_pair)(CPUHexagonState *env, uint32_t reg)
 
 void HELPER(setprio)(CPUHexagonState *env, uint32_t thread, uint32_t prio)
 {
+    CPUState *cs;
+
+    BQL_LOCK_GUARD();
+    CPU_FOREACH(cs) {
+        HexagonCPU *found_cpu = HEXAGON_CPU(cs);
+        CPUHexagonState *found_env = &found_cpu->env;
+        if (thread == found_env->threadId) {
+            SET_SYSTEM_FIELD(found_env, HEX_SREG_STID, STID_PRIO, prio);
+            qemu_log_mask(CPU_LOG_INT,
+                          "%s: tid " TARGET_FMT_lx " prio = 0x%x\n",
+                          __func__, found_env->threadId, prio);
+            resched(env);
+            return;
+        }
+    }
     g_assert_not_reached();
 }
 
-- 
2.34.1


