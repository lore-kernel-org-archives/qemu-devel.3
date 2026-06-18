Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAC3CD98F7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBwf-0004KV-0d; Thu, 18 Jun 2026 08:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBwY-0004DH-QV
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:34:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBwW-0001cA-HJ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:34:02 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ICK7rA1789186
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zRs2KHSv5nfUnAHny9bbk2EinZ1jGbA966yOSVNvExc=; b=NEbZIVAFAXad6p6V
 LDlW6rNK9aYAlW0n/7mRhVpCr7FzCYk6qOLRRqnkje6MSxDnp0Z+DzLzClW26yVK
 +J0yg2Bm42o1MWifbtjCvWsy9oKPO20mIVUghTdLvUPI2Y7AVODitVJjva7EOZ/h
 bl7xNHCrd8C+S3RcmX9tBOzXdAjTGDJrIU2/q/fpvECSPneG1wZ2vHCrShTJZ5J7
 9scLFo2SpwDluLApGPPdumZZX44pHxlCzrrO+ttvkvMe3UePCX4QjlEzdVPBeFfV
 Hu6bbCO5lf50WrUxLUCtct14NWYB32eKFli+TRY/3GDXcrZpqtqC5D3W4pqu8SR6
 96leBw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2jvg6f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:33:59 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6c33d75153dso491496137.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781786039; x=1782390839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zRs2KHSv5nfUnAHny9bbk2EinZ1jGbA966yOSVNvExc=;
 b=ZyslPDM2N/k42dUnJ8Jy5swi3VafhCL/fNxcK0yaCVPu2kwV7yyMv9D0Q+tgympBb6
 IvloLim7J5LvF0pmu/xmpGNHQbP0PxCWcBk1SHZnBvoumcm7GZn5K133qnoLjC2EzKoZ
 Fsv6RinrfXAj29vABZzpeGqQ7XTAkGNVRKe0xTTMasEgBMy3PqsTCAgsJEYHSAi2DLrS
 mJfZZcwwoEdQOx+hJ2VZTpJpwE+C+gS0SQLbspAXg746FdrFOlnEbRUHy4/cEF/eU0xW
 n3GYMNe0lGkxymqNJqgHvULMvuwECt9vvtC37+zNxGWfEsz92OiAKdKB1l/6zL6WjgMK
 m5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781786039; x=1782390839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zRs2KHSv5nfUnAHny9bbk2EinZ1jGbA966yOSVNvExc=;
 b=Pf7ntreFEd0mZFgQQtNpbzJF1YkLxCzocmCRnLJ0y2TbiQvjaBOY8zq1Ek+5VyL1pj
 EEa587UXDzQXEde55ZokaD9u40NRWjgfWG2im5bRO7B+Xf2mY5QI+aGuD1wSTZ6o0l8v
 gRicNyS2+QpFBfgMavX9ADl3BAoYJWOvNI1DgfW79GoLIWoZz1mzNxworvHhlLbG/tQd
 rHWDRt1TsBg98w6q6UbZUK4Ohk03UaPweZkTtVAAXdY038BvcnoxmpIJQg6Lp/DTmrOI
 J7/jJPRztr1gnTEyJgd2ijcdq5NcE/eD2aIgaTs2v1+Zb6MpZvZCcGEbnq3bE3r6jyOp
 CPtA==
X-Gm-Message-State: AOJu0Yy3T4LR58Xddcb8rPwBxBmBbDTCVj1xBRmNDCaBwXtD5yeSrJiH
 2oS8HXWS3FgLHScqpXPG8bkVoB6JFlZVAcJTCjBCgC0Tw0GGMSOw02UQX2z0fPU2HqREK1h88Q4
 8oZcBJRpDuKfD4pM9GKTYrXdKcwrn9cb/zPprZynKORFCLp7GkHyxv4fIyF2WbWN+hg==
X-Gm-Gg: AfdE7ckv7M2xk7wvurwrvUZr2ecBXj42xnh7f73SeKtJxRxHL426zxRqQjHbpFevwbV
 UHkhOMSM658Brbw2FUjQC/aA83M4fnuLz8U8n86YLmJwc7VxA0I1bK/BbGRJDu8lU3DxlQn10ef
 gkIovce7C8FxQSCZeQaBqBbqre+YRrkLqEA9XXkTenDBhWl0lxUqkxph25drYKtrGxRztqRjB3s
 AMJNrwXlVfG7RUDCZ1R09UQANiCDDKfSTMC/9S+ZZMt5ryxQ9gskHIqjTuuk5HokhS6vckFlMen
 iC4m+yPh1uvbwFatGP2xph5Y+EIVcCxjegCDPnKOR1Y8rcvppwK/QFQVT6kwZIhlEI44wrrBxXi
 WU8jc0LbugxE83ocSCNJOjGhrjfD8/YkSrbpG+y6F0v1tqAiIzKcdvIbMzZQ5mjf7trW2
X-Received: by 2002:a05:6102:3f9f:b0:6f0:3ba3:7d84 with SMTP id
 ada2fe7eead31-7245d313751mr4740203137.5.1781786038606; 
 Thu, 18 Jun 2026 05:33:58 -0700 (PDT)
X-Received: by 2002:a05:6102:3f9f:b0:6f0:3ba3:7d84 with SMTP id
 ada2fe7eead31-7245d313751mr4740192137.5.1781786037967; 
 Thu, 18 Jun 2026 05:33:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-462236047c8sm18700453f8f.10.2026.06.18.05.33.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:33:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 45/48] accel/tcg: Move cpu_restore_state() out of
 'exec/cpu-common.h'
Date: Thu, 18 Jun 2026 14:28:22 +0200
Message-ID: <20260618122825.90331-46-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX7d3iVbj7wsTn
 6rvjgNd16SiAbPoLSuxeheM0IS1qPfu9KgaJ72vLi6+fJetNIRH8nmMtloanfeAxvYQ8v4wSw09
 SexdyWguc323db3lL7LEowWxKMB3GiB5XdgIQKmKyG6wO6ryFW/nNAaVqO5nR50Jg0DjB94Kfaa
 azelxVw3ux+IL3zgdxIlHPJSnayWt+AkR117ka6VcWHtlpCh3a3kNkb8VcFntbjG6YDZJPusIWD
 rA7eKriTF1O90WZdpsq+RMFtUEhvfBOu/JBMxBISrXVsVHhVf5ITPTWVQc/yqlr60cPKKBeOqF1
 bHq8s9/1eJ/cm2/oyOEpuXK14DqItyy9tM86Xu3AgSZJgXz54SlvyGEyB93ozAIqDgPzb85ihbv
 J3+HZtvCCLx3jhdSLXZRVBSbny7X2H+xySDZj5gCBC1kJVezDVpC/sxtJyQ8Twwz8WpwhW905+O
 Vlq+PsFjMcLerNtFhDA==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a33e5b7 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=7NYfQX0GWP59tyU10OEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: FVLHo_uzV4SoCNTVIH9NSWSRk7oiUhWb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXwwq34ZFYaa75
 HYtwLEIzOp5QyvL9ipVbxn9+nnUd1PacHOdVuRyQyIqKUnwsiLFxbksCK7vzDS48y04EmDeZ+Dq
 VNg/REOQaR3h4hh17JyyNH/vTpO/cEQ=
X-Proofpoint-GUID: FVLHo_uzV4SoCNTVIH9NSWSRk7oiUhWb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Move the TCG-specific cpu_restore_state() declaration out
of the generic "exec/cpu-common.h" header, to the recently
created "accel/tcg/cpu-loop.h" one.

Include "accel/tcg/cpu-loop.h" where appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260617171438.75914-8-philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-loop.h        | 12 ++++++++++++
 include/exec/cpu-common.h           | 12 ------------
 accel/tcg/cpu-exec-common.c         |  1 +
 accel/tcg/user-exec.c               |  1 +
 target/alpha/helper.c               |  1 +
 target/alpha/mem_helper.c           |  1 +
 target/arm/tcg/op_helper.c          |  1 +
 target/arm/tcg/tlb_helper.c         |  1 +
 target/hppa/cpu.c                   |  1 +
 target/hppa/mem_helper.c            |  1 +
 target/hppa/op_helper.c             |  1 +
 target/i386/tcg/system/svm_helper.c |  1 +
 target/m68k/op_helper.c             |  1 +
 target/microblaze/helper.c          |  1 +
 target/ppc/tcg-excp_helper.c        |  1 +
 target/s390x/tcg/excp_helper.c      |  1 +
 target/sh4/op_helper.c              |  1 +
 target/tricore/op_helper.c          |  1 +
 target/xtensa/helper.c              |  1 +
 19 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/accel/tcg/cpu-loop.h b/include/accel/tcg/cpu-loop.h
index 88333d39200..d98a8a2e0cd 100644
--- a/include/accel/tcg/cpu-loop.h
+++ b/include/accel/tcg/cpu-loop.h
@@ -33,4 +33,16 @@ void cpu_exec_step_atomic(CPUState *cpu);
  */
 bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
 
+/**
+ * cpu_restore_state:
+ * @cpu: the cpu context
+ * @host_pc: the host pc within the translation
+ * @return: true if state was restored, false otherwise
+ *
+ * Attempt to restore the state for a fault occurring in translated
+ * code. If @host_pc is not in translated code no state is
+ * restored and the function returns false.
+ */
+bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc);
+
 #endif
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 7c9631efb06..db67c7bb864 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -61,18 +61,6 @@ void list_cpus(void);
 #ifdef CONFIG_TCG
 #include "qemu/atomic.h"
 
-/**
- * cpu_restore_state:
- * @cpu: the cpu context
- * @host_pc: the host pc within the translation
- * @return: true if state was restored, false otherwise
- *
- * Attempt to restore the state for a fault occurring in translated
- * code. If @host_pc is not in translated code no state is
- * restored and the function returns false.
- */
-bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc);
-
 /**
  * cpu_loop_exit_requested:
  * @cpu: The CPU state to be tested
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index c5c513f1e4a..e48ea31373f 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -21,6 +21,7 @@
 #include "exec/log.h"
 #include "system/tcg.h"
 #include "qemu/plugin.h"
+#include "accel/tcg/cpu-loop.h"
 #include "internal-common.h"
 
 bool tcg_allowed;
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index d283d3cc724..7704e4017dd 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -25,6 +25,7 @@
 #include "qemu/bitops.h"
 #include "qemu/rcu.h"
 #include "accel/tcg/cpu-ldst-common.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/helper-retaddr.h"
 #include "accel/tcg/probe.h"
 #include "user/cpu_loop.h"
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 2abf07c1919..c3614ecafda 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -28,6 +28,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/qemu-print.h"
 #include "system/memory.h"
+#include "accel/tcg/cpu-loop.h"
 #include "qemu/plugin.h"
 
 
diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index 572ea9cb418..b3988417e4b 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 
 static void do_unaligned_access(CPUAlphaState *env, vaddr addr, uintptr_t retaddr)
 {
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 504526153a6..9f9ea39be5a 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -23,6 +23,7 @@
 #include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/probe.h"
 #include "cpregs.h"
 
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index cbef9cb03ef..4c3f16dc2aa 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -8,6 +8,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "helper.h"
+#include "accel/tcg/cpu-loop.h"
 #include "internals.h"
 #include "cpu-features.h"
 #include "hw/intc/armv7m_nvic.h"
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 6443122cf1a..a68152f9682 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -29,6 +29,7 @@
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
 #include "hw/hppa/hppa_hardware.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-ops.h"
 
 static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index f5076492264..01e6149c811 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "accel/tcg/probe.h"
 #include "exec/page-protection.h"
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index f961046e4c5..76a8d8a0d34 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/probe.h"
 #include "qemu/timer.h"
 #include "trace.h"
diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
index d5ffabc2f4d..52a234e7fac 100644
--- a/target/i386/tcg/system/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -23,6 +23,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "tcg/helper-tcg.h"
 
 /* Secure Virtual Machine helpers */
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 8148a8852e7..38f7a689814 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "semihosting/semihost.h"
 #include "qemu/plugin.h"
 
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 6a982c18c0f..05a90f5ecb2 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
+#include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 5e6c1e326d4..b04f07a6377 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "target/ppc/cpu.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "exec/helper-proto.h"
 #include "system/runstate.h"
 
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 05e448d3f20..d952bb20cf1 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -24,6 +24,7 @@
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
 #include "exec/target_page.h"
+#include "accel/tcg/cpu-loop.h"
 #include "s390x-internal.h"
 #include "tcg_s390x.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index cf0f80e4a54..90c065b217b 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "fpu/softfloat.h"
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 3cff5000c73..46b17da2bc6 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-loop.h"
 #include "qemu/plugin.h"
 #include <zlib.h> /* for crc32 */
 
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 2d93b45036d..5a0e8655146 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -32,6 +32,7 @@
 #include "exec/target_page.h"
 #include "gdbstub/helpers.h"
 #include "exec/helper-proto.h"
+#include "accel/tcg/cpu-loop.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "qemu/host-utils.h"
-- 
2.53.0


