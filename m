Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD3AC5DF88
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 20:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx9BR-0000U7-Rh; Thu, 20 Aug 2026 16:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx9BQ-0000Rp-5g
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:16:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx9BN-00037Z-JA
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 16:16:15 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7ZLO4012743
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1U6iygIxAfvBnQx2biUKEFmmuR6Q3/g7yQC3HaajE30=; b=CUJNViZ0qVftx56f
 qAY6/oIPEw02fZ7t7GmNdS3ZA1cfHQJApNDniKCH0BQrdVgiX9JEb60IyolKB4fW
 nr4Hc+1O7FFN7dc07+nThibAOk7If2YId9cPemDCXr7V3GAAw3AYTZ08QZq/REXP
 /rQAasP4WrC3e5+ydcYggOw7id1Ddv9hsEIHeOkz9U73OfShB+ReTJTzZYmtv36e
 yMSeNK46eEp+kQYRDAQ5hBZ+4y65Bh1aNseTGSH9jXfMVbPjd4fuBqdTkIia4dYP
 h04sp60Pd9URtW3tnSxUOP+5wQOQg9/1gDyuwanTDpy8eCCnJqWpx2ABSbByV8+6
 4+VJDA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x29k5qd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 20:16:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e82060977so21601385a.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 13:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787256961; x=1787861761; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1U6iygIxAfvBnQx2biUKEFmmuR6Q3/g7yQC3HaajE30=;
 b=kD6PX/OAEGqF3D03stNbk3+7VnFp31VIbokgSQ+MjqVALn8uDirqCvED8lLn93nTNR
 Lc+ycS1nx2yZpctawM4Bj/7tGJRbHEvTYGGiPEC8J50pDQoCFUb/4LvQGSOEpQyh53CS
 76RzGVuJ1Fvlle52O8lIrJzbpIjuxRFUyQblrbyfAG5XTqQu7BJ9aJ1o2F3DnPpGUL4l
 yCfRE1CmYoO47gDNyRz8V1ZQT7U0V/y8O3t06pqtLmq/cWHh4u91Gpc8iXZLwey8g16e
 ZpV4QGJ4wSHe1nHWMvZRacTlSKNt3QiwWfcsLB47anFyBF80LySzIJ6l/bqYjptxpyca
 16kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256961; x=1787861761;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1U6iygIxAfvBnQx2biUKEFmmuR6Q3/g7yQC3HaajE30=;
 b=QRT8x97h9Qd9RwmPH3ngFZS2xJGsuqFPdPLP7PmgVzTIJzPAFHEbDNj7OXRalbOo5Y
 fbV/Emg8E415Pw9dujU6NHFg0Eagbpsu2jYrVQGHMReO/UARbO1wN6MkleAxDm1kB7+s
 YNsnZRmumbwiCr+Q7u2h4xyNOoD/WGkAirushat3gaQmF7rgUIpHoYVeHAPomtIli/5c
 5o6sqcvlHsS+Tdn3jIE0rQxq64HY5c/kDbFR5X3TRjaLOjzm2JxXcffiqFpQZ6un/bcN
 CvUViq1Ki9f++e1MrZDg/0GFNf3vMugJM0ZP1f5vjzFoJ3M8rOXaQtJsKsuQ9JTvk4Ly
 mrZg==
X-Gm-Message-State: AOJu0YxS3o0U+cXeiSEhT7rwTUS0u3tGryF4xjX8y5aksFVVRH+GvVSS
 CnAXQUXoIMn7e6HkQxXNOtGrHw7m/r/55un4SrKPjyEtEu50HrUzDL+tgCimPRkg5j+JtPXkTjN
 AhYck8H+lSzuxXEXe2FgL2p4atcgDI2MaAHovb7n0Z4dE6zalcOr6tv/0Bpf/BfW5nbtq
X-Gm-Gg: AR+sD12HaoOXmHlSFgfTOEl4DmfgsBJoYwqiGigGK4W6ivH/OyvsOQyT0wBoFaorfzL
 CwisKBRaZTu9cbNdM8fmaSvm/ygvACU0VhW8gw/5aW9/5uQBdZE7BykrJedAcRvdZRfmR3SjnA8
 3HFdeI4FmQy+Jg9uIZxowBLVSUZBYmTPIDhv/UN9umtUyRuWwyj+tYc9w+M6avlbB5jp34MoLEf
 1+fea2c1VbPZ5Moenhpgx5qzpiNhAHXHCjvZtBbYxSbmsFsdEYmmbf2tvGEH3FlCXNN+QnkeuXF
 RlkA1ux5ycBHBD8AULI/wE8hQcw3JEQ4DCcAJ1RFNQpigs1J5Iw4oNKIR2AQLlqReT8igFFdwYS
 K+3GMtIYXmti1ki7vDUbrdFYlEkWCx7Kc1X98q2/4rA==
X-Received: by 2002:a05:620a:438a:b0:933:ade:2daf with SMTP id
 af79cd13be357-9372852ccf6mr998926685a.18.1787256960504; 
 Thu, 20 Aug 2026 13:16:00 -0700 (PDT)
X-Received: by 2002:a05:620a:438a:b0:933:ade:2daf with SMTP id
 af79cd13be357-9372852ccf6mr998917185a.18.1787256959822; 
 Thu, 20 Aug 2026 13:15:59 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b7d23sm15615077f8f.22.2026.08.20.13.15.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 13:15:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Zhao Liu <zhao1.liu@intel.com>, Song Gao <17746591750@163.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 15/15] cpus: Constify @cpu in SysemuCPUOps::has_work()
 handler
Date: Thu, 20 Aug 2026 22:13:55 +0200
Message-ID: <20260820201356.29775-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820201356.29775-1-philmd@oss.qualcomm.com>
References: <20260820201356.29775-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gNjbzxsqixJNTUKCjOX1awEcm8yj0YGC
X-Authority-Analysis: v=2.4 cv=V8BNF+ni c=1 sm=1 tr=0 ts=6a876081 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=hf0YJCTCBZPsvBMCq-cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfX+sa9wGH+2fuY
 vYWjl2u3yzasphPf04h+7QMEkMeV2hTRM/SpYg36D7BFALl8DZlWD62qys7y/QNQFqulwXdODD3
 UfL6H1/HHqDV7J+Rdc7Bp9o9+edFnVJRY3HXz8jIpV5rC2DS90tu4/0XeXxzSSrYJni3C9uh/Ga
 T1mbpUptiXdUhl5AGf9+9VaedBtwmlDRmXac9tlcA72KYPPxUH2cEj6E4RJFccq/x51YciWxV9j
 qV1oBDp4jyEK/2Y8ENQ7TS/6U0MaOzKFVSEf+IisXuiOHfA7E7ed8JgGYmvNdBF0YOiN6gFdczE
 Z6IZZ8BYG9mhvhFcMnwmrnLao8QMPEjUOMlv7qoJ9VOM5oDeJwygd+4nFr+fykEtg2lpSvOj7vV
 OAzQmJlwSanVk51zJYC0fe2H0KTLYYKUY/xG9arC6IrOirHgjQw5JmPmRLQhzl6orQi18tkCwRS
 BQbVS5j4DCyVM727dKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE1MiBTYWx0ZWRfX4YPT46MMTU7l
 O80iciQIPtBO1lZSgQlPpbO19gFMr7h33ex3tIBSESXlJEm7Onu2l+aK1YAa24AKz+SAdqr7Gen
 TqvZfahGoqRs9McoqjHYse3q+ibNH1s=
X-Proofpoint-GUID: gNjbzxsqixJNTUKCjOX1awEcm8yj0YGC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200152
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All functions called by target has_work() handler take a const @cpu
argument. We can now fulfill the comment added in commit c2804566f6
("target/arm: do not clear halting reason in has_work helper"),
qualifying the handler const to denote its idempotency.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/sysemu-cpu-ops.h | 4 ++--
 target/alpha/cpu.c               | 2 +-
 target/arm/cpu.c                 | 4 ++--
 target/avr/cpu.c                 | 3 ++-
 target/hexagon/cpu.c             | 4 ++--
 target/hppa/cpu.c                | 2 +-
 target/i386/cpu.c                | 2 +-
 target/loongarch/cpu.c           | 2 +-
 target/m68k/cpu.c                | 2 +-
 target/microblaze/cpu.c          | 2 +-
 target/mips/cpu.c                | 4 ++--
 target/or1k/cpu.c                | 2 +-
 target/ppc/cpu_init.c            | 2 +-
 target/riscv/cpu.c               | 2 +-
 target/rx/cpu.c                  | 2 +-
 target/s390x/cpu-system.c        | 4 ++--
 target/sh4/cpu.c                 | 2 +-
 target/sparc/cpu.c               | 2 +-
 target/tricore/cpu.c             | 2 +-
 target/xtensa/cpu.c              | 4 ++--
 20 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 9a45596169a..095bdcd997a 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -19,10 +19,10 @@ typedef struct SysemuCPUOps {
     /**
      * @has_work: Callback for checking if there is work to do.
      *
-     * This function should be idempotent (i.e. not change state) as
+     * This function is idempotent (i.e. not change state) as
      * it will likely be queried multiple times before a CPU resumes.
      */
-    bool (*has_work)(CPUState *cpu); /* MANDATORY NON-NULL */
+    bool (*has_work)(const CPUState *cpu); /* MANDATORY NON-NULL */
     /**
      * @get_memory_mapping: Callback for obtaining the memory mappings.
      */
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 7d1d036e1d3..21d4f8ac23b 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -77,7 +77,7 @@ static void alpha_restore_state_to_opc(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool alpha_cpu_has_work(CPUState *cs)
+static bool alpha_cpu_has_work(const CPUState *cs)
 {
     /* Here we are checking to see if the CPU should wake up from HALT.
        We will have gotten into this state only for WTINT from PALmode.  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 9761bb173c1..ba66359d410 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -141,9 +141,9 @@ int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
  * CPU_INTERRUPT_*NMI anyway. So we might as well accept NMI here
  * unconditionally.
  */
-static bool arm_cpu_has_work(CPUState *cs)
+static bool arm_cpu_has_work(const CPUState *cs)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
+    const ARMCPU *cpu = ARM_CPU(cs);
 
     /*
      * Only another PSCI call can wake the CPU up in which case the
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index a01e6fa4751..a96bef46ff1 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/qemu-print.h"
 #include "exec/translation-block.h"
 #include "system/address-spaces.h"
+#include "hw/core/cpu.h"
 #include "cpu.h"
 #include "disas/dis-asm.h"
 #include "tcg/debug-assert.h"
@@ -43,7 +44,7 @@ static vaddr avr_cpu_get_pc(CPUState *cs)
     return cpu->env.pc_w * 2;
 }
 
-static bool avr_cpu_has_work(CPUState *cs)
+static bool avr_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_RESET)
             && cpu_interrupts_enabled(cpu_env(cs));
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 4cc6bd67c28..868aef0cde4 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -364,9 +364,9 @@ bool hexagon_thread_is_enabled(const CPUHexagonState *env)
     return E_bit;
 }
 
-static bool hexagon_cpu_has_work(CPUState *cs)
+static bool hexagon_cpu_has_work(const CPUState *cs)
 {
-    CPUHexagonState *env = cpu_env(cs);
+    const CPUHexagonState *env = cpu_env(cs);
 
     return hexagon_thread_is_enabled(env) &&
         (cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_SWI
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 7b1309a7c38..dbf58466c24 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -134,7 +134,7 @@ static void hppa_restore_state_to_opc(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool hppa_cpu_has_work(CPUState *cs)
+static bool hppa_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1fc02cf94e6..0606ac16664 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10638,7 +10638,7 @@ int x86_cpu_pending_interrupt(const CPUState *cs, int interrupt_request)
     return 0;
 }
 
-static bool x86_cpu_has_work(CPUState *cs)
+static bool x86_cpu_has_work(const CPUState *cs)
 {
     return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
 }
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index b638ac25040..0ce18a89b63 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -96,7 +96,7 @@ bool cpu_loongarch_hw_interrupts_pending(const CPULoongArchState *env)
 #endif
 
 #ifndef CONFIG_USER_ONLY
-static bool loongarch_cpu_has_work(CPUState *cs)
+static bool loongarch_cpu_has_work(const CPUState *cs)
 {
     bool has_work = false;
 
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 523694d8fbf..da3681fab1f 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -76,7 +76,7 @@ static void m68k_restore_state_to_opc(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool m68k_cpu_has_work(CPUState *cs)
+static bool m68k_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
 }
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 6013a8def8e..d1d2f0ec7e3 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -127,7 +127,7 @@ static void mb_restore_state_to_opc(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool mb_cpu_has_work(CPUState *cs)
+static bool mb_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index c069aa1c0b7..0f39f8fe0a5 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -134,9 +134,9 @@ static vaddr mips_cpu_get_pc(CPUState *cs)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-static bool mips_cpu_has_work(CPUState *cs)
+static bool mips_cpu_has_work(const CPUState *cs)
 {
-    CPUMIPSState *env = cpu_env(cs);
+    const CPUMIPSState *env = cpu_env(cs);
     bool has_work = false;
 
     /*
diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
index 42d9351b6d7..10b13ae69cd 100644
--- a/target/or1k/cpu.c
+++ b/target/or1k/cpu.c
@@ -76,7 +76,7 @@ static void openrisc_restore_state_to_opc(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool openrisc_cpu_has_work(CPUState *cs)
+static bool openrisc_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_TIMER);
 }
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 85a91ff4bb6..fd63cd6ab09 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7224,7 +7224,7 @@ static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
 #endif /* CONFIG_TCG */
 
 #ifndef CONFIG_USER_ONLY
-static bool ppc_cpu_has_work(CPUState *cs)
+static bool ppc_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
 }
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4abf20d057a..3560fbd445e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -950,7 +950,7 @@ int riscv_cpu_vsirq_pending(const CPURISCVState *env)
                                     (irqs | irqs_f_vs), env->hviprio);
 }
 
-static bool riscv_cpu_has_work(CPUState *cs)
+static bool riscv_cpu_has_work(const CPUState *cs)
 {
     CPURISCVState *env = cpu_env(cs);
     /*
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 69946928995..dfa09a85bce 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -73,7 +73,7 @@ static void rx_restore_state_to_opc(CPUState *cs,
     cpu->env.pc = data[0];
 }
 
-static bool rx_cpu_has_work(CPUState *cs)
+static bool rx_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
 }
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index 84faceb3338..3a0ff46e144 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -39,9 +39,9 @@
 #include "system/tcg.h"
 #include "hw/core/sysemu-cpu-ops.h"
 
-static bool s390_cpu_has_work(CPUState *cs)
+static bool s390_cpu_has_work(const CPUState *cs)
 {
-    S390CPU *cpu = S390_CPU(cs);
+    const S390CPU *cpu = S390_CPU(cs);
 
     /* STOPPED cpus can never wake up */
     if (s390_cpu_get_state(cpu) != S390_CPU_STATE_LOAD &&
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 55c73a1da35..b0ed356d0f7 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -107,7 +107,7 @@ static bool superh_io_recompile_replay_branch(CPUState *cs,
     return false;
 }
 
-static bool superh_cpu_has_work(CPUState *cs)
+static bool superh_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
 }
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 2baa5036871..8dd9b0d5ee3 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -783,7 +783,7 @@ static void sparc_restore_state_to_opc(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool sparc_cpu_has_work(CPUState *cs)
+static bool sparc_cpu_has_work(const CPUState *cs)
 {
     return cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
            cpu_interrupts_enabled(cpu_env(cs));
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 82b56c3cd56..357f3737053 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -111,7 +111,7 @@ static void tricore_cpu_reset_hold(Object *obj, ResetType type)
     cpu_state_reset(cpu_env(cs));
 }
 
-static bool tricore_cpu_has_work(CPUState *cs)
+static bool tricore_cpu_has_work(const CPUState *cs)
 {
     /* Interrupts are not implemented */
     return true;
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 99c8bd4b5fb..1b299568776 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -140,9 +140,9 @@ static void xtensa_restore_state_to_opc(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-static bool xtensa_cpu_has_work(CPUState *cs)
+static bool xtensa_cpu_has_work(const CPUState *cs)
 {
-    CPUXtensaState *env = cpu_env(cs);
+    const CPUXtensaState *env = cpu_env(cs);
 
     return !env->runstall && env->pending_irq_level;
 }
-- 
2.53.0


