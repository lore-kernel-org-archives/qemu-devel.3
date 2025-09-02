Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06564CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1Z-00039N-EA; Mon, 01 Sep 2025 23:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1V-0002rs-An
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1T-0004ds-CQ
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:32 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SfFe031364
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pZnRC3HENBfki3YLZk3iWRX/U9z3kpAJ4PJq5gDz0vQ=; b=II2mEGcvYToP76RW
 bf8huBzvGZw01DsQDqKCMuFFNicHV4ItbUrBGv8Tjbon6e8yq+OStza3tHCmFGNS
 XIRNL2NZ+4sLC1LZhgEZnG2psJ8TPhObZjU8aQmRVDABDapBj77aRrvVevhaNRzh
 lpCbakBqCkYmvroNyNXTBGUJpjT2AxzkQRiyh5k8v4FmzzCYoiCRfrZJz2EIFhOU
 c7b6YbXluQW5Vf2p0m861+CFXrA3JY3zBiysTGdqrHPGO36i4Vn+7bvM9h1vtbif
 6NCxJTdjhE1cFG1II1QpI+fFDer5KfqM+r/TSGZFs90gW4kbBwJTMTCotVxuziPI
 6ZGN+Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush2xamr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:19 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-324e4c3af5fso5183492a91.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784958; x=1757389758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZnRC3HENBfki3YLZk3iWRX/U9z3kpAJ4PJq5gDz0vQ=;
 b=QVv9BJ0ZjLkOWKruW7ItztK0EJApAbIxrJjOAwCVZNFc1vqpj8piQB6R8zpuveQNtF
 hZLzPHAUzpP8JvmMqQ6VO675CslzbicNz/E7urfrSdVsa61JTSXFOZTN4mYRZf7G/l4y
 EDtpSsulJUeGjOs2UGNL0ZfAr0HrNTaSte/EmjzGH1FVGheKqm/pO65xIhfvkGi+PC8u
 JFaJ+YYid3DF7XIXL/znLgiMoo8Bm8bnAvXAPJmOdUBgSpLcsLOX8UXSY4IpH+rVMGxv
 IbymIZP+LfCEIuBW9k59R7JhqxiWzcZv0I9CJajZjqxSJK9tdwirbY+zE1C4sDgYzMP/
 vJkw==
X-Gm-Message-State: AOJu0YzUuANwzicm4FRHKZGaoNjm8kGVpcanA5qxC35ZJYeTa9+xwL8/
 JED8DKDndW5vEiKX7wnxjPnowIpTkUn1F800ddtEfPJVfAFfflb1El7+sx6XLfWn0SoKl8Y7Q4l
 6ypv1ZTKzimXf/U8xDQAeT3V/8TslSD4UXE+JriNKqSuC0Wy8gmQqFe/8mNHYUzhHdUdy
X-Gm-Gg: ASbGncvL4zUBy7QVl1yGLx9/iwMIV9DOvTOZgeI/fvrfIFr9ReFU8o7YWez49pcEXd/
 GphlvxWQC56qlmJyYN3kOmEYeLKb/ZB1bwDFuPfxMxtuiSFmsO4crObTiv1XrElPuVJzt3xfSfX
 d1txPb5h+krS+IbBZtkSVmbaJi5DcoX1lILg+VxpCvwvI47JGtlcqBu9lBWcm3M+P0b5hnnelFB
 rOW9en5L9LpnhSAVNw9/bAT4xImNcPaw7SxGvxecEEqv/FbCxIM+k+6QowKXXyhL4ad6mrb/3z7
 fiSCM7Uc19L+DVnz9LVi/xgCfo3FC4O+RHxX++Q4UK8XWGeDqwK8/uD5HFXN3jY7HWYeQz8+SD5
 HZ9lJZZ0+ehMs
X-Received: by 2002:a17:90b:5111:b0:327:b310:b325 with SMTP id
 98e67ed59e1d1-328156baa7emr13807103a91.18.1756784958366; 
 Mon, 01 Sep 2025 20:49:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxEtwN56SymWMKPOTfuDE6/FS11uCfIRTT0OvyCTPMTxP3DnERV7gG+5tU3yXObHTqVURTWw==
X-Received: by 2002:a17:90b:5111:b0:327:b310:b325 with SMTP id
 98e67ed59e1d1-328156baa7emr13807065a91.18.1756784957864; 
 Mon, 01 Sep 2025 20:49:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:17 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 21/39] target/hexagon: Implement hexagon_resume_threads()
Date: Mon,  1 Sep 2025 20:48:29 -0700
Message-Id: <20250902034847.1948010-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXw1CBxCRQ4gaX
 DlmIq5p0JPP7DFBqfRbIkn4zbX6/5WZq96VsfU656pkHEDcD7qiuVswbNRaspGzcR0cDmEJwdmF
 BSAA4r4rr3oiSlC7zk2ixhgVc8sGOBZiG+/R+5haxrRRHYINCsAR827wWhQfptlCtrakqTwVLPq
 gyPJa+pK3xi3nCU8QswLjwa0r48j5xqbQkkE5MkWdTUmfzK94sXHoYx8rBzyC+yOGXEXM3KxOna
 mYw89ZAqe13bC4unPVI5hb0p7woc4qYQ/Q2B9pnG2pFI7QrAI2xoVkdYDMyQoFq45XOf03Wxkvb
 Z3RS/71pAepiK58ABhy36bcGCl3Ef1QsmP4CoNeVpzoORrgWHdKtkAFSmbWph3K6MminOw/xb+Y
 P3jadcgV
X-Proofpoint-ORIG-GUID: DBNd_Ct_XZ5zLMk4dXfS3IJMUBlkzQO_
X-Proofpoint-GUID: DBNd_Ct_XZ5zLMk4dXfS3IJMUBlkzQO_
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b6693f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=AJ2bX_oiER2d6UdsYA0A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032
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

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h        |  1 +
 target/hexagon/cpu_helper.h |  1 +
 target/hexagon/cpu_helper.c | 76 +++++++++++++++++++++++++++++++++++++
 target/hexagon/op_helper.c  |  3 +-
 4 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 1491313d06..92b32f434b 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -51,6 +51,7 @@ typedef struct CPUHexagonTLBContext CPUHexagonTLBContext;
 #define PRED_WRITES_MAX 5                   /* 4 insns + endloop */
 #define VSTORES_MAX 2
 #define MAX_TLB_ENTRIES 1024
+#define THREADS_MAX 8
 
 #define CPU_RESOLVING_TYPE TYPE_HEXAGON_CPU
 #ifndef CONFIG_USER_ONLY
diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index f7400031ef..c8b0a37b7f 100644
--- a/target/hexagon/cpu_helper.h
+++ b/target/hexagon/cpu_helper.h
@@ -21,6 +21,7 @@ void hexagon_ssr_set_cause(CPUHexagonState *env, uint32_t cause);
 void hexagon_start_threads(CPUHexagonState *env, uint32_t mask);
 void hexagon_stop_thread(CPUHexagonState *env);
 void hexagon_wait_thread(CPUHexagonState *env, target_ulong PC);
+void hexagon_resume_threads(CPUHexagonState *env, uint32_t mask);
 
 static inline void arch_set_thread_reg(CPUHexagonState *env, uint32_t reg,
                                        uint32_t val)
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index f540eadef4..18c929bf5f 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -146,6 +146,82 @@ void hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t cycles)
     }
 }
 
+static void set_wait_mode(CPUHexagonState *env)
+{
+    g_assert(bql_locked());
+
+    const uint32_t modectl = arch_get_system_reg(env, HEX_SREG_MODECTL);
+    uint32_t thread_wait_mask = GET_FIELD(MODECTL_W, modectl);
+    thread_wait_mask |= 0x1 << env->threadId;
+    SET_SYSTEM_FIELD(env, HEX_SREG_MODECTL, MODECTL_W, thread_wait_mask);
+}
+
+void hexagon_wait_thread(CPUHexagonState *env, target_ulong PC)
+{
+    g_assert(bql_locked());
+
+    if (qemu_loglevel_mask(LOG_GUEST_ERROR) &&
+        (env->k0_lock_state != HEX_LOCK_UNLOCKED ||
+         env->tlb_lock_state != HEX_LOCK_UNLOCKED)) {
+        qemu_log("WARNING: executing wait() with acquired lock"
+                 "may lead to deadlock\n");
+    }
+    g_assert(get_exe_mode(env) != HEX_EXE_MODE_WAIT);
+
+    CPUState *cs = env_cpu(env);
+    /*
+     * The addtion of cpu_has_work is borrowed from arm's wfi helper
+     * and is critical for our stability
+     */
+    if ((cs->exception_index != HEX_EVENT_NONE) ||
+        (cpu_has_work(cs))) {
+        qemu_log_mask(CPU_LOG_INT,
+            "%s: thread %d skipping WAIT mode, have some work\n",
+            __func__, env->threadId);
+        return;
+    }
+    set_wait_mode(env);
+    env->wait_next_pc = PC + 4;
+
+    cpu_interrupt(cs, CPU_INTERRUPT_HALT);
+}
+
+static void hexagon_resume_thread(CPUHexagonState *env)
+{
+    CPUState *cs = env_cpu(env);
+    clear_wait_mode(env);
+    /*
+     * The wait instruction keeps the PC pointing to itself
+     * so that it has an opportunity to check for interrupts.
+     *
+     * When we come out of wait mode, adjust the PC to the
+     * next executable instruction.
+     */
+    env->gpr[HEX_REG_PC] = env->wait_next_pc;
+    cs = env_cpu(env);
+    ASSERT_DIRECT_TO_GUEST_UNSET(env, cs->exception_index);
+    cs->halted = false;
+    cs->exception_index = HEX_EVENT_NONE;
+    qemu_cpu_kick(cs);
+}
+
+void hexagon_resume_threads(CPUHexagonState *current_env, uint32_t mask)
+{
+    CPUState *cs;
+    CPUHexagonState *env;
+
+    g_assert(bql_locked());
+    CPU_FOREACH(cs) {
+        env = cpu_env(cs);
+        g_assert(env->threadId < THREADS_MAX);
+        if ((mask & (0x1 << env->threadId))) {
+            if (get_exe_mode(env) == HEX_EXE_MODE_WAIT) {
+                hexagon_resume_thread(env);
+            }
+        }
+    }
+}
+
 void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old)
 {
     g_assert(bql_locked());
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index b887302d3c..63b9dda9a3 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1483,7 +1483,8 @@ void HELPER(wait)(CPUHexagonState *env, target_ulong PC)
 
 void HELPER(resume)(CPUHexagonState *env, uint32_t mask)
 {
-    g_assert_not_reached();
+    BQL_LOCK_GUARD();
+    hexagon_resume_threads(env, mask);
 }
 
 uint32_t HELPER(getimask)(CPUHexagonState *env, uint32_t tid)
-- 
2.34.1


