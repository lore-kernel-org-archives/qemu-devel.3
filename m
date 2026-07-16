Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463D3C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQUg-0000uI-Ga; Thu, 16 Jul 2026 14:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUe-0000tS-Vt
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wkQUd-0001V1-AF
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 14:07:32 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGSaJm3274373
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9UrV+RpzLm4
 SQFf/YCtA70LWv9dPQi1KI6bnkivTxIE=; b=Lrhf7tZsLwEt7s3kRCGDPJRSo3/
 r/R4uMrTdGx4QGCO4O3zczcLvxaVzJw++YFRcEWVZW8nFCIWTyEdwDkh+2jVhjOi
 vAXFu9lylPBI/JM6NnPKUd4wmywMpkQTqE3UDyT6qssij9boZnRPKKuXrBfR+oIa
 agntDqNOvd4iUfFvKkm3K5+lpSGgTlD5QA0oEcLrKBE8/Kc7oPqpZy2WaHMNx7bo
 XI8rQOY4eL4QxZ1Ttdf+ZtLSOqdQCavaD3Q4glqBxtqMVYdQ4QDkp+k8QqaGIdob
 C4pAZmq2ls/L2PLzX6TGwW4kgWP8iQZyyq5wJObRAqoq5dmybXoiY/F1x3g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff2f2rjhw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 18:07:30 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c96b4f58ddcso3554842a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784225249; x=1784830049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9UrV+RpzLm4SQFf/YCtA70LWv9dPQi1KI6bnkivTxIE=;
 b=YpJzvGhm+aYzOonkuqsRj5VTK0oUcnOVEBAn1tPEbVRaRJVCJIY2MoPS0Oi1Yrwdbn
 jjYSpb10gD7zCXG/S5ko5jR9TbLwDb6MLbozHfyhHemQx/EuCSDTVhZTZeT+em0BcmoB
 4VgxfhKseJxzvy+bz8+Uwrazh95D9kiDGzU3vAe4A15E6C3bsbw3RT3MKqrlgai6kbw9
 zAUYQlL5EUglKqDLkGusEzqowaRUI1JqSz9R6lBJ/hMIE94XFYDOwdPVKBF8oK7svBhz
 dIPPRJoJyvhj5uTaW4YJmHn8+uFfTh6M3je+FOveqKnWVXqMEAcL6yoYLtSkmxD6kBtk
 7ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784225249; x=1784830049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9UrV+RpzLm4SQFf/YCtA70LWv9dPQi1KI6bnkivTxIE=;
 b=kW3OTUTaXDO+epUJfEvEMcKm8CdvLVE4d+dlFLXNyTcybuFkwLvX5yixl+gW5+W4wv
 KLmJ3/25wnUgctuYleMijjuqtbl8STPrjyINgwjqgFQUr1ofpk7JdIzub/2guDRX7E9c
 1S4q7X+YcX2KOJWMpMKO3Bl8dkHKt2HvLbx4GGMwfbb+Z0H3jHTzFtUDNKWgGuLvn8Ml
 hEpGfN8SXHTIkbMKIPVXB9rFu/Sz067X/GZdpd4SQGJG/tWE6IRMiljvhSVigdCD/e9Z
 nHhqBggkk8aAFOScSeBWdeobNgVZSdNXzYF3yYdnuozk6+YQ799iOemDcwfCMXqFcprZ
 QS3A==
X-Gm-Message-State: AOJu0Ywj4Fri/VovtyJJnH0A+Jco2qcgq5pz0VX2MYJsTHs67O5uAcFY
 K4rUGNbYTSadJNWD+IuTbm/a+99q5ncfxsBzP1B4GoxEvKQRpWRhBOqAD/zlk1ZXK28u5Bkl6tT
 qDqRmJHLleS+maruDDiNaXjLbEFuZxQA3O0UrrTv6+Jw4sCXXbZzkK26jEvLcgiiI6g==
X-Gm-Gg: AfdE7ckmxotweauTv7Y5F9yuxs3a8JJQkF9WtlMDghh6bBKEBwIrh6WQxpYVbpHv2mj
 ybH+93MtLvFdxuOoiVHH0fRI1va3E/MUeMxwq7NUnAQQN8wAG7zr6Pa/+2dSCMecn9GdJ1V99Rv
 G1Bzwkjxyd83EV/ZJp13vi7AQ1KxNfoWfFyFnRmSLxP0B1Hvicje7ShQSBkuquu5dWOP9jwPPQY
 lScSsMdE1l+HHwx0JIYelOSA5Z119FOQtYWOVUTMtZwR+wP4hOZCD7nb9OZvGYdt1e+y6YJdJnV
 fHm+hGcwURsUeZOHuFhSQ2qR7IeKqK4I+Wy/3FsSbSgzmMqvi8l0GGO4H1cqsiKMrvWlBy1c8AG
 QYaKzI8LNYDRKc/dsSMBxB649Kvkd7ViQ5Q6tu5vRAjT+eZnk05u2n1wy/aE58l4=
X-Received: by 2002:a17:90b:52d0:b0:387:e0db:bc30 with SMTP id
 98e67ed59e1d1-38e467be1damr563568a91.38.1784225248992; 
 Thu, 16 Jul 2026 11:07:28 -0700 (PDT)
X-Received: by 2002:a17:90b:52d0:b0:387:e0db:bc30 with SMTP id
 98e67ed59e1d1-38e467be1damr563534a91.38.1784225248528; 
 Thu, 16 Jul 2026 11:07:28 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm17131184eec.11.2026.07.16.11.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 11:07:27 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v2 05/14] hexagon: cpu_helper: add reg reading/writing helpers
Date: Thu, 16 Jul 2026 11:06:49 -0700
Message-Id: <5b16ff40a6e22b05af8caf12299cbf0726ccb336.1784225209.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1784225209.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kyWBCeAQfuid-Aj9lpqGZAm27j_4n_FS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfX6FyNVjLW9gE5
 wqORw/Gk7PC20PQi2izJIZEtlir4YSsz4+PNIkrAJA0TZD96NTey4vj2oFaDoy061ZC0+tL2Bb4
 Peqg9EI0R2FKmz1yLF5ea6suDFIpI3g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE4NSBTYWx0ZWRfX/nxVpAiKir2s
 fJMlqgiNF+eaYl8XqQrAMUeT7An6MY/WQIDjH41eLUzeUhqqhbhckdeSTEXbt6Krdkf7rjTLMF9
 AsCWCLnOQmAJ3SWi0GTK6vNXHISBomC6gCKrqpIah6XETKp8PE00jZTDrP2RmlCtnU2XQwGb7Jy
 OBXS2zDVr5WD1d+6Y8DDuUIoAUEPtn/KZD5Hc3mBxrNYaYPCrzNJVB/gsFHB6A9E5ZBB3YMaD96
 yPdFi+JTuCWJINLYUWnKoO8eQDr0+uwsYlbyTv5YHyAitvMMCRHgYg8G10jeEKwOXCvnzieYDl4
 idoknZnJhW/Fb48ky/DeuxDov7sQkrYFa/AGa7u2GqUR5gv/Y/Gp6sCNNrrQDzPY7lA/un83R2q
 YJlTeX9u/KTup4rEZTkXEzPKWYgbxC7TZHBr2fMDvYRi3lC8BkiFozZdPSTM2AFrCWH7Vmj3xWB
 WqYFWFDFEV0DE0TOCJg==
X-Authority-Analysis: v=2.4 cv=NcTWEWD4 c=1 sm=1 tr=0 ts=6a591de2 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=nXchshz6agspm-bXmVMA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: kyWBCeAQfuid-Aj9lpqGZAm27j_4n_FS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160185
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/cpu_helper.h | 18 +++++++++++++++++
 target/hexagon/cpu_helper.c | 40 +++++++++++++++++++++++++++++++++++++
 target/hexagon/op_helper.c  | 18 ++---------------
 3 files changed, 60 insertions(+), 16 deletions(-)

diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index ca2e13ab1d1..757a49fc4d4 100644
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
index e981e11a35d..98ce599571e 100644
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


