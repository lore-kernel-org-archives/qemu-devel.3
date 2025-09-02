Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59911CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1T-0002iU-TC; Mon, 01 Sep 2025 23:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1R-0002YZ-I2
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1O-0004d1-CV
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:29 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SgYr016289
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OzqQaAVC4JLXZ59GObACu1itKuL/W7b+voEqUxwhJ5c=; b=XoMBJVmSz2Mx6d25
 vjfk7brUkZxtknQbAquE196J2nkD9G3ysjNYTE1We8PjNRlvt53NtY0NorGygJrg
 JFxsIk7bFP/FeFT2n0YUVyreOD7GrpQKPD7/P4ru3bvLj8ABwH2x0MRtrm/QOnFD
 uhLU9Z7feFhKAEALILfYMgGq03AkoJyS1KsWchVmc3rVHh20Ri7koDz540JGLzJQ
 FH+1kpB7yikPi5jJ0jtKqlvIv4nuS3gEQsrhiQP5MFwuozGjhmuHDSX7YJWzYL7/
 aHTerSu3z/O4CIYkZJ94vb2lYcqqqm49u2E68vl6UTv5rPX+zwMsztbHLYRGVxQP
 K7aofw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urvyxdjw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:15 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-329b750757aso1302288a91.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784954; x=1757389754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OzqQaAVC4JLXZ59GObACu1itKuL/W7b+voEqUxwhJ5c=;
 b=kunpsMTRS5O8AIEqEycpfr6e4qed65Ed6zU9kAeTTCwKiw8DwKV/xbFEO6S5Wyl5kV
 /o7SobGSPnQzENAxK3vTAkcW1vm0IJ8Tc/MsQViXjQhhHdPQrx5OgNEnHWRqUwU3YAvY
 b7VChqDFf1iEc34bLjyM4fuWmTndmCAcOy1qF/y/jX8XzseDJ5wesrq8pqU0f2ecku2p
 LDCb3XQnF7LJfnW4syCHTRjX9K7644jWhlJo4ZgvciA89oImoBSmzVmq7HwwxYjMJlxe
 HKWis4Z7nevJBUtVAYxkIoXhtIkXuuxJXNHXgMcWZbrnDSa0hxxWUHb31J9HepaglRfi
 2m4g==
X-Gm-Message-State: AOJu0YyqbggOardgugo2pAK59qOB489tTdkrq9KWYaGzNYMkhbCnGtp9
 cbQoZshaHQGR8O9SL7MUgAXb7x6VvcnJ9P/sTxd3CBT5IXI5fZ2+JepXX2T23C9jcsyXdBUoLWG
 6bnDnQpf0U+yAdxUAhVEMvB7z/NGMfRCT8XCvrAluRvHWPtSo9BFWjjKVAv++2xElwF1v
X-Gm-Gg: ASbGncuTNNWNFznB9FZv/y3H/wlE+h/VQzHYWFQNe/uP/SuCuqgv63BQTUw+4TeJnCG
 5NM/kiB3TFI2BXPgMwriaEZ+bXiLmQS1y68vCRmEx7QaHpqGSBuYNrQWdIFkrIL8phRq49cRKw0
 rVwWyI03OC3a+GaCmFQLkDJlPlz4byCfW1ppHoJtIeLt4gqenSRb47Wa2DJWyh/apiM3IoSghVr
 lwfB6I/dAiTW3os758YklIYQgYKeQO7Nl0lmoYVyaOvTkmNoSAOwguAPvZAV0WZ1Zu0zDuOIcZg
 Eex9Ygu8XRtrcfylU6UQ+VcleM/7hpdetYE2LgfdhoyW8xUC7B8fVfz3REPUnhPgMMdMxVC/KE9
 j9LmN2aOapuDW
X-Received: by 2002:a17:90b:35c6:b0:321:b7ed:75f2 with SMTP id
 98e67ed59e1d1-328156e0537mr12152375a91.32.1756784953830; 
 Mon, 01 Sep 2025 20:49:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrSxv+u1n8za1j0mEwVor4LSkVmsIgkVIHqa5bGgdloWwALmm0h3SsoGraJ1+kvxDTb9OlFg==
X-Received: by 2002:a17:90b:35c6:b0:321:b7ed:75f2 with SMTP id
 98e67ed59e1d1-328156e0537mr12152338a91.32.1756784953164; 
 Mon, 01 Sep 2025 20:49:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 17/39] target/hexagon: Implement exec_interrupt, set_irq
Date: Mon,  1 Sep 2025 20:48:25 -0700
Message-Id: <20250902034847.1948010-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4FlcUM72S7R90ueK7smDRUdAlvU7s7nI
X-Proofpoint-ORIG-GUID: 4FlcUM72S7R90ueK7smDRUdAlvU7s7nI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXxPwoEiidez4Y
 ie1oJaDTbknU7TLf6BHNb1ZHrq7N42P0dQJPmi9LQv2XqMv5DDjN/rW6F8EU83CbbiUdza6Z9RA
 9DAw3+ydlZh98uK8w9U/1xcmzg2RnZnwAfegkWFi0KOeMOPE36dHGwzqD38Rv+HHE4hP0oP1XdR
 LMcq10h4Vpm5IyZFsA/UtDkYeC7XRGSUMrIHg8J/NsGT0fugjdKeONsExcfVz1qN7j80L1YVzPE
 /iqonm5sp/KauKDK7S3b2kegimWEdvwi2bYM/Zhh10NUeFHIpZcU5YjJDOjehE15eSvMYeCjr6m
 mtnWjNqkQ595YUcA2M0m0xLhxz6ZwRe9VkF9pwK5BTlwTvCsr+mOvQE2SbOHKpOxAmxLYvXvAca
 aJ+sa8Xo
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b6693b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=rIkxbyxcx7-xiWOMinkA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027
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

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h |  5 +++
 target/hexagon/cpu.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 354e9e9cbf..1491313d06 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -209,6 +209,11 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
                                             uintptr_t pc);
 
 #ifndef CONFIG_USER_ONLY
+/*
+ * @return true if the @a thread_env hardware thread is
+ * not stopped.
+ */
+bool hexagon_thread_is_enabled(CPUHexagonState *thread_env);
 uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg);
 uint32_t hexagon_sreg_read(CPUHexagonState *env, uint32_t reg);
 void hexagon_gdb_sreg_write(CPUHexagonState *env, uint32_t reg, uint32_t val);
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 22e21d401b..85ccf9893a 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -30,11 +30,13 @@
 #include "hex_mmu.h"
 
 #ifndef CONFIG_USER_ONLY
+#include "macros.h"
 #include "sys_macros.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "qemu/main-loop.h"
 #include "hex_interrupts.h"
 #include "hexswi.h"
+#include "exec/cpu-interrupt.h"
 #endif
 
 static void hexagon_v66_cpu_init(Object *obj) { }
@@ -310,6 +312,34 @@ static void hexagon_cpu_synchronize_from_tb(CPUState *cs,
     cpu_env(cs)->gpr[HEX_REG_PC] = tb->pc;
 }
 
+#ifndef CONFIG_USER_ONLY
+bool hexagon_thread_is_enabled(CPUHexagonState *env)
+{
+    HexagonCPU *cpu = env_archcpu(env);
+    if (!cpu->globalregs) {
+        return true;
+    }
+    target_ulong modectl = arch_get_system_reg(env, HEX_SREG_MODECTL);
+    uint32_t thread_enabled_mask = GET_FIELD(MODECTL_E, modectl);
+    bool E_bit = thread_enabled_mask & (0x1 << env->threadId);
+
+    return E_bit;
+}
+#endif
+
+static bool hexagon_cpu_has_work(CPUState *cs)
+{
+#ifndef CONFIG_USER_ONLY
+    CPUHexagonState *env = cpu_env(cs);
+
+    return hexagon_thread_is_enabled(env) &&
+        (cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_SWI
+            | CPU_INTERRUPT_K0_UNLOCK | CPU_INTERRUPT_TLB_UNLOCK));
+#else
+    return true;
+#endif
+}
+
 static void hexagon_restore_state_to_opc(CPUState *cs,
                                          const TranslationBlock *tb,
                                          const uint64_t *data)
@@ -431,10 +461,58 @@ static int hexagon_cpu_mmu_index(CPUState *cs, bool ifetch)
     return MMU_USER_IDX;
 }
 
+#if !defined(CONFIG_USER_ONLY)
+static void hexagon_cpu_set_irq(void *opaque, int irq, int level)
+{
+    HexagonCPU *cpu = HEXAGON_CPU(opaque);
+    CPUState *cs = CPU(cpu);
+    CPUHexagonState *env = cpu_env(cs);
+
+    switch (irq) {
+    case HEXAGON_CPU_IRQ_0 ... HEXAGON_CPU_IRQ_7:
+        qemu_log_mask(CPU_LOG_INT, "%s: irq %d, level %d\n",
+                      __func__, irq, level);
+        if (level) {
+            hex_raise_interrupts(env, 1 << irq, CPU_INTERRUPT_HARD);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+#endif
+
 static void hexagon_cpu_init(Object *obj)
 {
+#if !defined(CONFIG_USER_ONLY)
+    HexagonCPU *cpu = HEXAGON_CPU(obj);
+    qdev_init_gpio_in(DEVICE(cpu), hexagon_cpu_set_irq, 8);
+#endif
 }
 
+#ifndef CONFIG_USER_ONLY
+
+static bool hexagon_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+    CPUHexagonState *env = cpu_env(cs);
+    if (interrupt_request & CPU_INTERRUPT_TLB_UNLOCK) {
+        cs->halted = false;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_TLB_UNLOCK);
+        return true;
+    }
+    if (interrupt_request & CPU_INTERRUPT_K0_UNLOCK) {
+        cs->halted = false;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_K0_UNLOCK);
+        return true;
+    }
+    if (interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_SWI)) {
+        return hex_check_interrupts(env);
+    }
+    return false;
+}
+
+#endif
+
 static const TCGCPUOps hexagon_tcg_ops = {
     /* MTTCG not yet supported: require strict ordering */
     .guest_default_memory_order = TCG_MO_ALL,
@@ -445,6 +523,9 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
     .restore_state_to_opc = hexagon_restore_state_to_opc,
     .mmu_index = hexagon_cpu_mmu_index,
+#if !defined(CONFIG_USER_ONLY)
+    .cpu_exec_interrupt = hexagon_cpu_exec_interrupt,
+#endif /* !CONFIG_USER_ONLY */
 };
 
 static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
-- 
2.34.1


