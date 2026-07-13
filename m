Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243EFC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjMwD-0005gn-3k; Mon, 13 Jul 2026 16:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwB-0005g6-JO
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMw9-0006Py-Sp
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:35 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9NN82256614
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SGMBdLRODLT
 /TzLWbmVvB4D6KzD8CyV9Ai+U3sjvkRE=; b=DYBq/emIGSbNveTI6w71nTEpYh1
 k91b4uuIjJJZFSqH94/U+2uBuw6lqOfEXe8BEm3kC8lx70r1H2ox3ovvgL945Ppl
 sxW6Di6gnDaLSaqF95wcU3TBUA37HSAeh3CJz0hto2b7gyntAWuhb3MKg9B6jhjj
 Bs5e1sHSkDBBA2C5hBPBjR0w1rCKcYywtuE7nY565auLMQi/PK2nfCxAJO5cL/vV
 fC4I+/wmsczFYpz0Y3Rl8bVeV9vQVgysSnDgEpMa1o2mpH7xQnGRzQa6QRN0poVK
 jdCbjFkQPqvSRkqA/TqZHzkHlZtRza1cdC6fFUga7ZdbhrkJe3nTyqbk0jA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk9tdwh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:32 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38dc4401dc7so239573a91.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783973252; x=1784578052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SGMBdLRODLT/TzLWbmVvB4D6KzD8CyV9Ai+U3sjvkRE=;
 b=ZKSDBEXoOXicADhOLP8P1TlwmiPhbZ6tFvQDc5xyAZqghFL7deN3pvnr5A5jCI6RSt
 dap777UDyytUeImfDH6646pgUEbY5uCadlraxE2jQ6EINXzUwKJvvqJkEMRF7c1stt57
 MdTNLOiw3Q/v1BdORO3UjOMlQ5/jB6qBOLeKZqg6EqDreCXlqYUto8zyt1eg3KpWfaeK
 nm39ryT+hlC+g07HjkMbrWBnhz6AlIOR+5xbHV7TLTJOlqhJpoYqp9yFFFWjKlIO5Kv2
 T08eCJZ8MRuwtckbEaYhzyFIwxfX34gttt6iQd72u9b1i4VrBOFOmo+dfJ2bMC9P4yx1
 LDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783973252; x=1784578052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SGMBdLRODLT/TzLWbmVvB4D6KzD8CyV9Ai+U3sjvkRE=;
 b=DBUH2WVRgIRDzZlUea+eHVsHzMgsLiU+fSXur9NHw8si0LKJpHQFPtw4woI9zXnfsF
 LfeApnOOQS9e+RYhz8Klaldii+ygWErZP+1z57JLFa6s8/o/xX48/H7fp7ukcb5M4x0B
 llOsKnqH915r+sREdSUM/cwNdxcvP98FfUEHc2JpST2EgAxeTsCGgqsgwUYrPeuZtX+f
 KE6Xt9udcPO4tmZz7Tk7lNXgqAnW5d+fv14dX8rMmy3ug5E6Un4SVCbGptQ53/AJ++Yn
 HEljK2l/h5VjU1LahR7pjKAUNXLRnGtw64EUhUM/jECOetAxLakrrd6dxRKEnWXTG8kn
 LENg==
X-Gm-Message-State: AOJu0YyB17uXEBBpos+fVaLY1K4rZT/Ru3ns2+RlUZad7u2sa7I4mybe
 rhno+3QXCKlbdz2Y/AgIZJMXTwpoW22y3EYKKHhkB0d6kUn4509OXSRthXPsngZb78ojoof8a5U
 nK6CjJvfIExdkrLBfbpdilSOzlXSZ/M37qFKPmNmcT1WSnBhoA34YHfMy0skktL2gAKsb
X-Gm-Gg: AfdE7cnPQy2JFNjPv5zGFLCEtKf9KzspfW7k/BN/W/Vetn/T0/w/ee9PaC3DzOpRkXb
 gTIKDSevxqUAy+NPilTBcnZa1NAABE/AW374D/Hwt4TQTe0SS5nk30zeqmAMJ0gFiapEOVFT9ax
 aVUOKuZDS7lmw8XWQfAhUM5NalR/ecmf7Rbh15k9mUCTGjRBsNaesYGK/ndNwQo7OXIUKWM0gw8
 kFc+en+2EUPUNlikeMBaLl0Tgw8TRhCtYXbvGEZwfITaE7HCeB0FU26nVFm5JKsaJ+TV93iqb3n
 MlYXoCoZrVB9gKKVeSg7ctvqfCxslegD44eIqC+g4d3F3t5FWWoqu0SS/jDpZKYBGBD06lBuKCJ
 Uu5MIF4zH7WVp8ajm7nzlk0ZiYIp+vXrhjI5iwpq98m8Y6SWGzgQTnvC4h0qlM5BRcj7zOapOVw
 ==
X-Received: by 2002:a17:90b:2cce:b0:38d:c834:2106 with SMTP id
 98e67ed59e1d1-38dc834255bmr9318956a91.28.1783973251792; 
 Mon, 13 Jul 2026 13:07:31 -0700 (PDT)
X-Received: by 2002:a17:90b:2cce:b0:38d:c834:2106 with SMTP id
 98e67ed59e1d1-38dc834255bmr9318938a91.28.1783973251372; 
 Mon, 13 Jul 2026 13:07:31 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313cb804197sm24106543eec.13.2026.07.13.13.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:07:30 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH 04/14] hexagon: cpu_helper: add reg reading/writing helpers
Date: Mon, 13 Jul 2026 13:07:12 -0700
Message-Id: <636d47e381c5370c38c058f324c290c39265b10f.1783973054.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX9KEvm2cD21ii
 kDvHSBlkw4ODRWWOYiVDp+imdWmpa4Cj35hebkltGOGcYNfj26CfwBL0qWfl60A9BJngJO81jpU
 29xcTPvZim6iU1G6y45gDaMCLzhR30DMPe7eAeS8rxApyU6CwmG0Y10d89X1mgcLkgCPtTG19FT
 xYikjCsqZ0j6kwRYUCenJVrDyt0VMhDrG96YMJ62qrhQmXjNVxVW6tPODBeO35i4XwrMyTNkeBt
 5pyHz/ZE01xKZ5guRsOd9e6u3xldKq1SD1AVKPb+zlFVZ1EZWe5isYXi3O+Jy1xLxkMVwC/4RLW
 UE5MWNQRNc2KPO79rsoRPV6fegMeIaDWK+Bi8R+HWl0xK1lmUuOkKaXn33pumtfy6HwlQl7IQtK
 5zDBjm87lhLTWpVOEygeMIGn8zUMyyXvgDCWWIBs9B7FP5Pc3kdkctPo1lfuxs65FjfeJYZXEKM
 flwIl2dmyxT53TWrVKw==
X-Proofpoint-ORIG-GUID: QGi1EG4dnNelXx3_xxG6pNKOw3ycyd6M
X-Authority-Analysis: v=2.4 cv=UMHt2ify c=1 sm=1 tr=0 ts=6a554584 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=nXchshz6agspm-bXmVMA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: QGi1EG4dnNelXx3_xxG6pNKOw3ycyd6M
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX5VJRyG9OVwnQ
 VbCYJAMl4o8PhAlThLOAY+6dC54NwnHbGU8I2G+4Wbf+UGAesYhh2l1WH1IxOYTxz7ISBcrvSdn
 C3RkJRPkojHqv1IZ9wwtgSD54GFLOZw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130208
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

And adjust op_helper to use those. They will also be used on upcoming
semihosting commits.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/cpu_helper.h | 18 +++++++++++++++++
 target/hexagon/cpu_helper.c | 40 +++++++++++++++++++++++++++++++++++++
 target/hexagon/op_helper.c  | 18 ++---------------
 3 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index f6a31ecbab0..af286dbe05a 100644
--- a/target/hexagon/cpu_helper.h
+++ b/target/hexagon/cpu_helper.h
@@ -7,6 +7,24 @@
 #ifndef HEXAGON_CPU_HELPER_H
 #define HEXAGON_CPU_HELPER_H
 
+static inline void arch_set_thread_reg(CPUHexagonState *env, uint32_t reg,
+                                       uint32_t val)
+{
+    g_assert(reg < TOTAL_PER_THREAD_REGS);
+    env->gpr[reg] = val;
+}
+
+static inline uint32_t arch_get_thread_reg(CPUHexagonState *env, uint32_t reg)
+{
+    g_assert(reg < TOTAL_PER_THREAD_REGS);
+    return env->gpr[reg];
+}
+
+void arch_set_system_reg(CPUHexagonState *env, uint32_t reg, uint32_t val);
+void arch_set_system_reg_masked(CPUHexagonState *env, uint32_t reg,
+                                uint32_t val);
+uint32_t arch_get_system_reg(CPUHexagonState *env, uint32_t reg);
+
 void hexagon_read_memory(CPUHexagonState *env, target_ulong vaddr, int size,
                          void *retptr, uintptr_t retaddr);
 void hexagon_write_memory(CPUHexagonState *env, target_ulong vaddr,
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index 1ab2564e3dc..ead0cf9d7ca 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -27,6 +27,46 @@
 
 #ifndef CONFIG_USER_ONLY
 
+uint32_t arch_get_system_reg(CPUHexagonState *env, uint32_t reg)
+{
+    if (reg == HEX_SREG_PCYCLELO) {
+        return hexagon_get_sys_pcycle_count_low(env);
+    } else if (reg == HEX_SREG_PCYCLEHI) {
+        return hexagon_get_sys_pcycle_count_high(env);
+    }
+
+    g_assert(reg < NUM_SREGS);
+    if (reg < HEX_SREG_GLB_START) {
+        return env->t_sreg[reg];
+    } else {
+        HexagonCPU *cpu = env_archcpu(env);
+        return hexagon_globalreg_read(cpu->globalregs, reg, env->threadId);
+    }
+}
+
+void arch_set_system_reg(CPUHexagonState *env, uint32_t reg, uint32_t val)
+{
+    g_assert(reg < NUM_SREGS);
+    if (reg < HEX_SREG_GLB_START) {
+        env->t_sreg[reg] = val;
+    } else {
+        HexagonCPU *cpu = env_archcpu(env);
+        hexagon_globalreg_write(cpu->globalregs, reg, val, env->threadId);
+    }
+}
+
+void arch_set_system_reg_masked(CPUHexagonState *env, uint32_t reg,
+                                uint32_t val)
+{
+    g_assert(reg < NUM_SREGS);
+    if (reg < HEX_SREG_GLB_START) {
+        env->t_sreg[reg] = val;
+    } else {
+        HexagonCPU *cpu = env_archcpu(env);
+        hexagon_globalreg_write_masked(cpu->globalregs, reg, val);
+    }
+}
+
 static bool hexagon_read_memory_small(CPUHexagonState *env, target_ulong addr,
                                       int byte_count, unsigned char *dstbuf,
                                       int mmu_idx, uintptr_t retaddr)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 125952aee59..4859d8a484e 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1839,28 +1839,14 @@ void HELPER(setimask)(CPUHexagonState *env, uint32_t tid, uint32_t imask)
 void HELPER(sreg_write_masked)(CPUHexagonState *env, uint32_t reg, uint32_t val)
 {
     BQL_LOCK_GUARD();
-    if (reg < HEX_SREG_GLB_START) {
-        env->t_sreg[reg] = val;
-    } else {
-        HexagonCPU *cpu = env_archcpu(env);
-        if (cpu->globalregs) {
-            hexagon_globalreg_write_masked(cpu->globalregs, reg, val);
-        }
-    }
+    arch_set_system_reg_masked(env, reg, val);
 }
 
 static inline QEMU_ALWAYS_INLINE uint32_t sreg_read(CPUHexagonState *env,
                                                     uint32_t reg)
 {
-    HexagonCPU *cpu;
-
     g_assert(bql_locked());
-    if (reg < HEX_SREG_GLB_START) {
-        return env->t_sreg[reg];
-    }
-    cpu = env_archcpu(env);
-    return cpu->globalregs ?
-        hexagon_globalreg_read(cpu->globalregs, reg, env->threadId) : 0;
+    return arch_get_system_reg(env, reg);
 }
 
 uint32_t HELPER(sreg_read)(CPUHexagonState *env, uint32_t reg)
-- 
2.37.2


