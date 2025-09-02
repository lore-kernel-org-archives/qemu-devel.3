Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812C0CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1t-0005LC-U1; Mon, 01 Sep 2025 23:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1r-00057i-7W
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1i-0004gG-La
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:55 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RkKA016374
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m3Jy3qDy8UMtfwS27O7HCnbT1ahJwyKtcD8kQj9/kgQ=; b=oV8wiWuu3PJk7BLH
 dFp57XYiQHfbIqiJ8IvajsVgqeRt6X04rNBezv7tB7vgfHk72FE9bNyesNIDSlbj
 /kltj6tnjvFS6e0Tsru+RO5Mi2dB67BwXqvspX3utVJ6nJpF4QnHfC8LjBBDgojj
 ujClsNjLKuJb6FrTfcrRmoSZJUABrHLldfa/wDT2oY83F28z+XGdnVvXJ0fmlCKQ
 8IPLKV90lsbMcpOkgYhhV2zerDjyNhv5ySCmtrJBDj9RalbFQiKB3xnCayBGbsrK
 tROp+93cImhQxqge9+MB9lNsuHjh+UfdeVh1A/1r0sRuUXBoUN/dHsT7jw8bm+z2
 VrffOQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk8x8ar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24abc029ee3so18822655ad.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784974; x=1757389774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m3Jy3qDy8UMtfwS27O7HCnbT1ahJwyKtcD8kQj9/kgQ=;
 b=HTFx5j8R7VZNVViHuWdrxcrxaxlU0AxWX78VHXsc/SLE8bh5Got8YyYe36s/qwz+26
 7MRiI01kdsAPrLCOTgn0FGu2ag+jC1l7vzIlbSV7ftQkT8RJ8zJsl7p0NjUswvp71tC9
 x1JHa387ouXRBTahzbNHizu0dExJyHrudOgVeF4N+PZ9Roele4QGIBfhjKcAJNm6ZBgc
 PJNf0UqIyMLvP114u6qvsdMoxJxaEPs45vPpnLXNTwMYKM6ON/Xs5zgb6wwR3Mft6QA4
 crBYH2mRhAfDGla34j+DekxaPS/47ODrq510fcB6+17TEvU4qKImdw6pTfYLsK1Ph66l
 JbYQ==
X-Gm-Message-State: AOJu0YyCPT7jcuUyFm80o0kAsCtcOsALg7RSfz+7In6UxjWapylIa8jH
 6qTr/TswxNbltOd8Lpxq1qQghnvjpCSVFfSKwBnKIXt57eRlBg0Ab29B7TDzTSFXO1wpyzOl+uF
 9COfImWYCdgvT2KvUxqgflVDP41kMvviPMSqmwKi2Ut+vsuczWcJBaeb7VcDeZekL7AFk
X-Gm-Gg: ASbGncvipUr8UAFj4+moYN/qWsQWtv8wAuilrVsKYAaPkV2bCHFIr//eSK4Y+iaW0Id
 OnYA3zEqSKCRfPgZr8iOTZdF4q+3PvhRnwCVcGWoRLu9RgMSSLF1gjhGZkrj4BVSFama4uWMKtJ
 5isdUGcj0wZBZtXgqaldTewH0QDb4206BW+GLECwGP9Y3ic/E9zI67aaoFQGHxddRmT5bo8klJR
 h7b6HibFviCeUspHLgCktt8w+bxVVLKd1AFpfqcjdAz3WbwdXID4Vfgmha37OxyVcWF2ba5MVo6
 PxpG/1PRFJX8guzkzljb0ogqszGBnw0yzLVO2dHTcx18nurc6TUPFvoAinIYM2cGorf9poegy5a
 AGzJtN3rh4BvA
X-Received: by 2002:a17:902:e750:b0:24b:12ce:48bd with SMTP id
 d9443c01a7336-24b12ce4946mr15323865ad.17.1756784973940; 
 Mon, 01 Sep 2025 20:49:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGswUP6qStdwNIF/8fCiAUYsapjaEWjlCDJ7zPkrxgd09zewQresdZZvBdxWKgA7ige9AgkDw==
X-Received: by 2002:a17:902:e750:b0:24b:12ce:48bd with SMTP id
 d9443c01a7336-24b12ce4946mr15323585ad.17.1756784973457; 
 Mon, 01 Sep 2025 20:49:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 34/39] target/hexagon: Add TLB, k0 {un,}lock
Date: Mon,  1 Sep 2025 20:48:42 -0700
Message-Id: <20250902034847.1948010-35-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: c3iQJ5B-GOb-wrDA6B1hMLDSNkngS9Rl
X-Proofpoint-ORIG-GUID: c3iQJ5B-GOb-wrDA6B1hMLDSNkngS9Rl
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b6694f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=5qM_0fsqfvQKBOMFAjMA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX5+Z2pxCjHsGk
 gww47V5kDs+/umbvl5t07AZsBQtc8PtV0yzKiqe3sucN4giZ5Qnwm2tfWqxSIB/k1RR7FoH5Mr0
 csCAtB58aKIwWOI1tRFFxRYAcwt44HezOkvRuEBY7J/UaHLDEHyzvO49ohP6j6Sb9utsFltXXHE
 SP0p/EbsEC755fMcOd7kM38+w9m5u3YLCrGQt3Nd8J2MIkH7A5luwXAd5chlIKb/UnUQM61CGbo
 K5/DKBpst+NW+rLD/KVzQhiYpSu5W2/xV+ZTPi/sxbuDpJws9R/a5cFF/bkx4iozTZNPyNqLm5d
 VzhOCJ6B7CdWV3wDau1YdwblKtcGA0pMrfDcdHzydrx0H0VV2VzLtlvxccuTm02dnmY0uhpAyj5
 aFtMVqwm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042
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

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/sys_macros.h |   8 +--
 target/hexagon/op_helper.c  | 104 ++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 4 deletions(-)

diff --git a/target/hexagon/sys_macros.h b/target/hexagon/sys_macros.h
index 3c4c3c7aa5..e5dc1ce0ab 100644
--- a/target/hexagon/sys_macros.h
+++ b/target/hexagon/sys_macros.h
@@ -143,11 +143,11 @@
 #define fDCINVIDX(REG)
 #define fDCINVA(REG) do { REG = REG; } while (0) /* Nothing to do in qemu */
 
-#define fSET_TLB_LOCK()       g_assert_not_reached()
-#define fCLEAR_TLB_LOCK()     g_assert_not_reached()
+#define fSET_TLB_LOCK()       hex_tlb_lock(env);
+#define fCLEAR_TLB_LOCK()     hex_tlb_unlock(env);
 
-#define fSET_K0_LOCK()        g_assert_not_reached()
-#define fCLEAR_K0_LOCK()      g_assert_not_reached()
+#define fSET_K0_LOCK()        hex_k0_lock(env);
+#define fCLEAR_K0_LOCK()      hex_k0_unlock(env);
 
 #define fTLB_IDXMASK(INDEX) \
     ((INDEX) & (fPOW2_ROUNDUP(fCAST4u(env_archcpu(env)->num_tlbs)) - 1))
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index e283c5c809..5efd644fa7 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1186,6 +1186,110 @@ void HELPER(modify_ssr)(CPUHexagonState *env, uint32_t new, uint32_t old)
     BQL_LOCK_GUARD();
     hexagon_modify_ssr(env, new, old);
 }
+
+static void hex_k0_lock(CPUHexagonState *env)
+{
+    BQL_LOCK_GUARD();
+    g_assert((env->k0_lock_count == 0) || (env->k0_lock_count == 1));
+
+    uint32_t syscfg = arch_get_system_reg(env, HEX_SREG_SYSCFG);
+    if (GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg)) {
+        if (env->k0_lock_state == HEX_LOCK_QUEUED) {
+            env->next_PC += 4;
+            env->k0_lock_count++;
+            env->k0_lock_state = HEX_LOCK_OWNER;
+            SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 1);
+            return;
+        }
+        if (env->k0_lock_state == HEX_LOCK_OWNER) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Double k0lock at PC: 0x%x, thread may hang\n",
+                          env->next_PC);
+            env->next_PC += 4;
+            CPUState *cs = env_cpu(env);
+            cpu_interrupt(cs, CPU_INTERRUPT_HALT);
+            return;
+        }
+        env->k0_lock_state = HEX_LOCK_WAITING;
+        CPUState *cs = env_cpu(env);
+        cpu_interrupt(cs, CPU_INTERRUPT_HALT);
+    } else {
+        env->next_PC += 4;
+        env->k0_lock_count++;
+        env->k0_lock_state = HEX_LOCK_OWNER;
+        SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 1);
+    }
+
+}
+
+static void hex_k0_unlock(CPUHexagonState *env)
+{
+    BQL_LOCK_GUARD();
+    g_assert((env->k0_lock_count == 0) || (env->k0_lock_count == 1));
+
+    /* Nothing to do if the k0 isn't locked by this thread */
+    uint32_t syscfg = arch_get_system_reg(env, HEX_SREG_SYSCFG);
+    if ((GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg) == 0) ||
+        (env->k0_lock_state != HEX_LOCK_OWNER)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "thread %d attempted to unlock k0 without having the "
+                      "lock, k0_lock state = %d, syscfg:k0 = %d\n",
+                      env->threadId, env->k0_lock_state,
+                      GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg));
+        g_assert(env->k0_lock_state != HEX_LOCK_WAITING);
+        return;
+    }
+
+    env->k0_lock_count--;
+    env->k0_lock_state = HEX_LOCK_UNLOCKED;
+    SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 0);
+
+    /* Look for a thread to unlock */
+    unsigned int this_threadId = env->threadId;
+    CPUHexagonState *unlock_thread = NULL;
+    CPUState *cs;
+    CPU_FOREACH(cs) {
+        CPUHexagonState *thread = cpu_env(cs);
+
+        /*
+         * The hardware implements round-robin fairness, so we look for threads
+         * starting at env->threadId + 1 and incrementing modulo the number of
+         * threads.
+         *
+         * To implement this, we check if thread is a earlier in the modulo
+         * sequence than unlock_thread.
+         *     if unlock thread is higher than this thread
+         *         thread must be between this thread and unlock_thread
+         *     else
+         *         thread higher than this thread is ahead of unlock_thread
+         *         thread must be lower then unlock thread
+         */
+        if (thread->k0_lock_state == HEX_LOCK_WAITING) {
+            if (!unlock_thread) {
+                unlock_thread = thread;
+            } else if (unlock_thread->threadId > this_threadId) {
+                if (this_threadId < thread->threadId &&
+                    thread->threadId < unlock_thread->threadId) {
+                    unlock_thread = thread;
+                }
+            } else {
+                if (thread->threadId > this_threadId) {
+                    unlock_thread = thread;
+                }
+                if (thread->threadId < unlock_thread->threadId) {
+                    unlock_thread = thread;
+                }
+            }
+        }
+    }
+    if (unlock_thread) {
+        cs = env_cpu(unlock_thread);
+        unlock_thread->k0_lock_state = HEX_LOCK_QUEUED;
+        SET_SYSCFG_FIELD(unlock_thread, SYSCFG_K0LOCK, 1);
+        cpu_interrupt(cs, CPU_INTERRUPT_K0_UNLOCK);
+    }
+
+}
 #endif
 
 
-- 
2.34.1


