Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CEACA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI17-0000xT-FD; Mon, 01 Sep 2025 23:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI14-0000pf-FF
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0z-0004as-WA
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822T6Yu032344
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RE+a8Ex8t/Lh3RzJuNpMC5woucbCQtUqXDFBADU31fU=; b=YBsX6f/Ka8i7IC9T
 /Y/Iwvzw54L+iAE/zJyTCLNSF4xSmS92QLIgo7Q4f3iFRMWHyNiniG3WygBHcOHn
 7BaVGVIKjt8opDL3CghZj3lSdo5RHzx2ri1yOV1QTTl1LobIBS48Cidl6MAjm0Qc
 mIJ1oS+LISYTMZQQdn2IlxZ66dtl9qwBj3WiBl63wy1clp7YD7w243JYfpQWmeUE
 eZnrXuVEiCDZuxuW3lJKdswFr4AYqg0GWwSSW2V8GueR2fR+DF7MbrcMd1Ox4XzQ
 GWLRfdBMvm/bpbedPnXEC/6OZhn/IJUkMpnJZFll5N2WgK6onoL5/UJ66PmNBaQm
 fK2sJA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8pc1w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:48:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3276575ae5bso4963642a91.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784938; x=1757389738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RE+a8Ex8t/Lh3RzJuNpMC5woucbCQtUqXDFBADU31fU=;
 b=Vv888zr58aVe/FXVk+rh17jZJAdPTAmLTa8ruibAVuA+t9Ie4vpFtp72TMAmIte8eZ
 Wwt2j7LHw3Su8ktg1ghOnEmaWopqhiU8lxrf6PtU5Mfe9JRi40AaxzLfr/sRP9ArjqIA
 AP2znaKEcstdnPkiaR2s/sNFc+F/GQyr7Awawkl5M9pg55gupKx4+YJmejJwOPDmjNSw
 2zC5fdMAW8UWAkw2UbzaKb5Pa2vrwglUmv6izaimBTM3JBefVusdR75krgV/1Hm9htbc
 gGYV3VTBdwnYsvnCp+q9Ed9qy6w0R5LNKIKa348Locel4BRnfgcl7UtvfdpDsHN9Jjq6
 YJQA==
X-Gm-Message-State: AOJu0YyF24tG5hs2Fd7WbtiO7K/Q7CkS7PRmrTXeDdbp0Twjo2UbqTJS
 Xww+qSziUUAgV1Rh5+shSlHtd4hg700YeTUNCwyWGzfGwG6tf63bcLS8nf0BUE+28pJXk/R9cnG
 Y3PaOQL4PKLPrr5moKIbPCXPX1lCt6HAsKTC0kl0fZ0LDL2ZWTz5VBpE/2yrY4aD7toDh
X-Gm-Gg: ASbGnctmV3BuwK7r85yJ/biBq41GtPADHd47pZc/hkYUVQch8QuxE5hvXFcdC1g6nLU
 HYHb/K+J75wGr7vz0zcl6HhPbexjztffsgDTmFHjw7Ts8J0hopMNorcYrkiAjR8fO19QrN1qszY
 NDLOLv0I4Jt7IoVgtkbcq2e8BlA8zSIc+SYDroWewzFw9EpQ7ZaiC3IgBWqYj/M3j3XOBmkjps3
 2XaWYEeMzvankZcy+dTB9Cv23cTZVrz2sfx4mcguF5ZNQCgh4TrqWQQCIHltU0CNCjpp1dAA3t8
 hJHe5z+fsj0/750iDWcjMO3S599Gzj0WeUOs05/ZUyDf9hsmOQSMbMr3rFkO9oewZdWxxbmPNOw
 Fsmk6jm0GZPNo
X-Received: by 2002:a17:90b:55c8:b0:327:41c8:8840 with SMTP id
 98e67ed59e1d1-32815709d7bmr13450861a91.37.1756784937645; 
 Mon, 01 Sep 2025 20:48:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGozArfzNMwO4brugBZhRnBIByQeVx+MqjVXgYfZjY9J+pqq0AQ8Oxlg8x58v2vLrX71jw4Pg==
X-Received: by 2002:a17:90b:55c8:b0:327:41c8:8840 with SMTP id
 98e67ed59e1d1-32815709d7bmr13450822a91.37.1756784937125; 
 Mon, 01 Sep 2025 20:48:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:48:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 04/39] target/hexagon: Implement start/stop helpers,
 soft reset
Date: Mon,  1 Sep 2025 20:48:12 -0700
Message-Id: <20250902034847.1948010-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NIVJflrK2MWvcDk1F3-232VTvdyeUzfv
X-Proofpoint-GUID: NIVJflrK2MWvcDk1F3-232VTvdyeUzfv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX2YtT69KZda1P
 18uRvEDAUYLV2FhghNUFn6GhodlRaDNPrjv9MXQWy0K+h540p60FvuU26r6g1T8yapMclBlSTnF
 eOKNynSjHD4MxMBSJuIyQubtK3lyfklxlwWS/I+1ZCSQ6Zwr4mGTHOLGUauq0Zf5jDYdnR3WA37
 uK7u7vb/0h8TQwh7pimDxTWhbtrcYc8hnzSxR6UlGWPgY4iOOhkiZvhy1vu8sndVWHwll9O+CAo
 mvNT9w2KnMetJMXbbiDbLoXGMgOgtlrG2VJoriGIMtmJ73Hg3reXaubu+9b4JtmJ7Bxzp/+/g7j
 OmczaYKr13mj9SF2Fn6jZiB46rGZwA7l15ywK+GmMD2r1f93nivQNITqz7+gpJ94096O/6fZlPG
 gy33jqpd
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b6692b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=T1VtIrzwaUtDMXHdWn0A:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=TjNXssC_j7lpFel5tvFf:22
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

From: Brian Cain <bcain@quicinc.com>

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h        |  1 +
 target/hexagon/cpu_helper.h |  3 ++
 target/hexagon/cpu.c        | 18 ++++++-
 target/hexagon/cpu_helper.c | 94 +++++++++++++++++++++++++++++++++++++
 target/hexagon/op_helper.c  |  4 +-
 5 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index d369e104ae..a0448eba44 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -209,6 +209,7 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
 uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg);
 uint32_t hexagon_sreg_read(CPUHexagonState *env, uint32_t reg);
 void hexagon_gdb_sreg_write(CPUHexagonState *env, uint32_t reg, uint32_t val);
+void hexagon_cpu_soft_reset(CPUHexagonState *env);
 #endif
 
 typedef HexagonCPU ArchCPU;
diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index 6f0c6697ad..95a0cc0788 100644
--- a/target/hexagon/cpu_helper.h
+++ b/target/hexagon/cpu_helper.h
@@ -17,6 +17,9 @@ void hexagon_set_sys_pcycle_count_high(CPUHexagonState *env, uint32_t);
 void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old);
 int get_exe_mode(CPUHexagonState *env);
 void clear_wait_mode(CPUHexagonState *env);
+void hexagon_ssr_set_cause(CPUHexagonState *env, uint32_t cause);
+void hexagon_start_threads(CPUHexagonState *env, uint32_t mask);
+void hexagon_stop_thread(CPUHexagonState *env);
 
 static inline void arch_set_thread_reg(CPUHexagonState *env, uint32_t reg,
                                        uint32_t val)
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index c128f47ad3..e35ac92402 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -32,6 +32,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "sys_macros.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "qemu/main-loop.h"
 #endif
 
 static void hexagon_v66_cpu_init(Object *obj) { }
@@ -312,9 +313,23 @@ static void mmu_reset(CPUHexagonState *env)
         memset(env->hex_tlb, 0, sizeof(*env->hex_tlb));
     }
 }
+
+void hexagon_cpu_soft_reset(CPUHexagonState *env)
+{
+    BQL_LOCK_GUARD();
+    arch_set_system_reg(env, HEX_SREG_SSR, 0);
+    hexagon_ssr_set_cause(env, HEX_CAUSE_RESET);
+
+    HexagonCPU *cpu = env_archcpu(env);
+    if (cpu->globalregs) {
+        target_ulong evb = arch_get_system_reg(env, HEX_SREG_EVB);
+        arch_set_thread_reg(env, HEX_REG_PC, evb);
+    } else {
+        arch_set_thread_reg(env, HEX_REG_PC, cpu->boot_addr);
+    }
+}
 #endif
 
-
 static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -337,6 +352,7 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
 
     mmu_reset(env);
     arch_set_system_reg(env, HEX_SREG_HTID, cs->cpu_index);
+    hexagon_cpu_soft_reset(env);
     memset(env->t_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
     memset(env->greg, 0, sizeof(target_ulong) * NUM_GREGS);
     env->threadId = cs->cpu_index;
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index 00f47e5a07..74ce59adf4 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -89,8 +89,102 @@ void clear_wait_mode(CPUHexagonState *env)
     }
 }
 
+void hexagon_ssr_set_cause(CPUHexagonState *env, uint32_t cause)
+{
+    g_assert(bql_locked());
+
+    const uint32_t old = arch_get_system_reg(env, HEX_SREG_SSR);
+    SET_SYSTEM_FIELD(env, HEX_SREG_SSR, SSR_EX, 1);
+    SET_SYSTEM_FIELD(env, HEX_SREG_SSR, SSR_CAUSE, cause);
+    const uint32_t new = arch_get_system_reg(env, HEX_SREG_SSR);
+
+    hexagon_modify_ssr(env, new, old);
+}
+
+
 int get_exe_mode(CPUHexagonState *env)
 {
     g_assert_not_reached();
 }
+
+static void set_enable_mask(CPUHexagonState *env)
+{
+    g_assert(bql_locked());
+
+    const uint32_t modectl = arch_get_system_reg(env, HEX_SREG_MODECTL);
+    uint32_t thread_enabled_mask = GET_FIELD(MODECTL_E, modectl);
+    thread_enabled_mask |= 0x1 << env->threadId;
+    SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_E, thread_enabled_mask);
+}
+
+static uint32_t clear_enable_mask(CPUHexagonState *env)
+{
+    g_assert(bql_locked());
+
+    const uint32_t modectl = arch_get_system_reg(env, HEX_SREG_MODECTL);
+    uint32_t thread_enabled_mask = GET_FIELD(MODECTL_E, modectl);
+    thread_enabled_mask &= ~(0x1 << env->threadId);
+    SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_E, thread_enabled_mask);
+    return thread_enabled_mask;
+}
+static void do_start_thread(CPUState *cs, run_on_cpu_data tbd)
+{
+    BQL_LOCK_GUARD();
+
+    CPUHexagonState *env = cpu_env(cs);
+
+    hexagon_cpu_soft_reset(env);
+
+    set_enable_mask(env);
+
+    cs->halted = 0;
+    cs->exception_index = HEX_EVENT_NONE;
+    cpu_resume(cs);
+}
+
+void hexagon_start_threads(CPUHexagonState *current_env, uint32_t mask)
+{
+    CPUState *cs;
+    CPU_FOREACH(cs) {
+        CPUHexagonState *env = cpu_env(cs);
+        if (!(mask & (0x1 << env->threadId))) {
+            continue;
+        }
+
+        if (current_env->threadId != env->threadId) {
+            async_safe_run_on_cpu(cs, do_start_thread, RUN_ON_CPU_NULL);
+        }
+    }
+}
+
+/*
+ * When we have all threads stopped, the return
+ * value to the shell is register 2 from thread 0.
+ */
+static target_ulong get_thread0_r2(void)
+{
+    CPUState *cs;
+    CPU_FOREACH(cs) {
+        CPUHexagonState *thread = cpu_env(cs);
+        if (thread->threadId == 0) {
+            return thread->gpr[2];
+        }
+    }
+    g_assert_not_reached();
+}
+
+void hexagon_stop_thread(CPUHexagonState *env)
+
+{
+    BQL_LOCK_GUARD();
+
+    uint32_t thread_enabled_mask = clear_enable_mask(env);
+    CPUState *cs = env_cpu(env);
+    cpu_interrupt(cs, CPU_INTERRUPT_HALT);
+    if (!thread_enabled_mask) {
+        /* All threads are stopped, exit */
+        exit(get_thread0_r2());
+    }
+}
+
 #endif
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 74f8c1bf4f..4b1fc23a15 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1455,12 +1455,12 @@ uint32_t HELPER(iassignr)(CPUHexagonState *env, uint32_t src)
 
 void HELPER(start)(CPUHexagonState *env, uint32_t imask)
 {
-    g_assert_not_reached();
+    hexagon_start_threads(env, imask);
 }
 
 void HELPER(stop)(CPUHexagonState *env)
 {
-    g_assert_not_reached();
+    hexagon_stop_thread(env);
 }
 
 void HELPER(wait)(CPUHexagonState *env, target_ulong PC)
-- 
2.34.1


