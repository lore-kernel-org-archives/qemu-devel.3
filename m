Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0042AC5DF88
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhkx-0001Tg-KE; Wed, 19 Aug 2026 10:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhk5-0000Ew-TW
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:58:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwhk3-0000eE-Ik
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:58:13 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JEbpMN588463
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fAMrmYSOA1vxbvpFqFNukNd1bA7aS0xkji6sTKzScfk=; b=WefyJzJuWmxF/xUn
 UAued40v62Sfz8E+fq+9j8X1cA9TFQkWVVX3mae1QGHAZRR1fM3qELOINHXsbDHe
 ZKW5mKH8AqnbU0H+T9ZbcSP2j8XUbFXte0DV0lJMkxDUhExIGZWILZdTXE4xpW1o
 b7MlFAdM9emKDSwajmye713Lak5aeYfqOhIRkKjFvPCncIRDOYevAvKDHJiZ+Ed2
 drqzEfvJNjMtZncjCMMxxpRkPYgQsi6mk4dZUXc1Bz9SavFklTTbbbGxgxECAEhO
 z4uUgaGH5SQcgYLvxuqw732PSJC2TTUqHUfO6tpFKft14rE/9hUQ8VyoqYRzJwIY
 RgSQ9w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfkbuu6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 14:58:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9309af14fd7so132993285a.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787151490; x=1787756290; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fAMrmYSOA1vxbvpFqFNukNd1bA7aS0xkji6sTKzScfk=;
 b=LTAH0K9dWvtK3sZFFatsIqXTuXFZWcIelwLhADy/Torh8edbyZfIWEs41V8bGRKtZx
 rHRe40UE8hV+JP93HEmMp1VJoKz/DuszGQOWdMcL0MRAeW6V7RwTWNJGlgjNGYOcWgjI
 1FQkMJDY0ftNT0S4fs+mOMg0aMqAnZFDokQkAWxhLMQxFRuxNh/jdJB6l/T5wi3TJtJb
 bCNjQq9StQ9wZ0QjtMpZMMBlsREQgNmmh4aye+ViFIaPv2EAbbDJHxJDBGVOfuE/JNco
 xYhwU4aDccFipQvimZXOkBhMjgac8HBenXtrwXeIxq7hN0KVIjyObtxFxYQpoLPsjAPW
 VYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787151490; x=1787756290;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fAMrmYSOA1vxbvpFqFNukNd1bA7aS0xkji6sTKzScfk=;
 b=QE/aCun/LouG3OY+/1B6ems/d+b0/epObEOsRKRqSXXn5ySfkDSMX5iLRvZQzU2I/5
 FmetCuR8pcfwKkEHHghD9PVxC2uWOkCltQZoiHxoBRW+tBq//K1RIborfcfOYJS8XEw3
 6O8bB6UyZP6xYb4vszy5aK9fn98wxcNsGUAEXCeGSGjN1RBCs6MXKkOeDmAAvJ2o6g9R
 GYWnu/idBzwZmuChU5oMRq6r132XxPP0pnC3xZTzWCRXEuM2bBbFHt3ACv/m7A//Fn6L
 9WSk0rrY8iir1kHDWMrT9UQ3y/S5vqLMJhI5VGoqUWRDn6a/u/RYmncCE8IoPmGiElP5
 ESdg==
X-Gm-Message-State: AOJu0YzJfALpxpNEFSU4H2oCsni00ictgVg4TJFUZTXo4iTDnDgjwvGi
 OzHFBMOlvvhb5iwubS1RmccEOAI4eTeN8cP/dXfplc/U8kEQPpaAY4AVnIYZVFKnWOdl96th5xu
 OpmG/qwOqPbuaXam1Euat6JwW/kNNoMoi5DCwqfyaObLXpZ/XaGvbp2Vsjrfaej+E+kLv
X-Gm-Gg: AR+sD12uh5xG0fdyeQ74jzsiRDmZJRIfJZ5suvBsd/aiFX7fAd5QJT6o7ER47kDMdMI
 hB36w9JnfmcQLOwQb4V19Yd0bHkV3jVbk/s3xVwiDpkT9kRBIdRe0lOwvMOoJX7Rv8/spjoKFrZ
 lOLyj6SzNxs+JPAdl9xfmINGeD1wHJmOtJuU7IHifr0NZzWe0gVXyqucqOS2V+7c3TSW426Eo6H
 wZaW2170dpzjkzp/Upw8OuWYpQmCb8a2Vepp+Q9Io+loz4fKcS5bqSW6gPohC91keVxsFtsjD1Q
 t1giMtC2XlP5fnQAFDAq9F6vUS3RMUDZ4QbdX3thgFQPOtmL02rDEryOPF9okVYglj114QE0cHK
 HM2BEbnBNEdomrlAT2iFP33ltfYR8C61S2/IaRSX7WA==
X-Received: by 2002:a05:620a:6502:b0:936:b923:4828 with SMTP id
 af79cd13be357-9371e635758mr534371785a.31.1787151489702; 
 Wed, 19 Aug 2026 07:58:09 -0700 (PDT)
X-Received: by 2002:a05:620a:6502:b0:936:b923:4828 with SMTP id
 af79cd13be357-9371e635758mr534364885a.31.1787151489088; 
 Wed, 19 Aug 2026 07:58:09 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c45d1sm5305426f8f.30.2026.08.19.07.58.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Aug 2026 07:58:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 11/11] accel/tcg: Remove the now redundant cpu_exec_halt() hook
Date: Wed, 19 Aug 2026 16:56:49 +0200
Message-ID: <20260819145649.23439-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819145649.23439-1-philmd@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yDD0_yy1jTEHzVEKg3kngPt4b-sUeeyw
X-Proofpoint-ORIG-GUID: yDD0_yy1jTEHzVEKg3kngPt4b-sUeeyw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfX5ozbde1H8nWM
 ZwrmLO95cBUy7JdS5KT6Kasm2Xbmn+k0eZ179bpIFJTGaYWbi9C+XAQq1FRg3ipZgu6cM9f43Sd
 lxqoNfzeSR2YHDW3Apc5Z+oCeoovc8GjL2Hk/Z9y7KjlzTivC+wvB8kiNFRKq9yv7ifjMW7puWL
 264GojVKwxUt2ly5r2daN7D3Pnfl0/amF3BU+L3P6lKGjtQvma1a3GITixkcUI49FrZmeDz0mG6
 EO2tOHqU1KXzqNhBaSBuA/UwM9ZD3mGZJzd6UGSjKXvQ9nRDK16gF0guHz4S8dLCaatnLeBTamC
 mevbdLp6J8Jg7S7bhT+V1iWOhEpdoACqO4kr5cT2y8bhc6dMpTGDRDo3A2fUMulJbXtft5orH0k
 yjB44wTmpg1Vnith4Mf8XxnCyM9/z86L6RCxZ/7r96tFwHryxKQylucKT425e7GcVL6Z2QMQ0jY
 pl92bOSFcBKh2rbIITg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExNiBTYWx0ZWRfX6ifaI96feIJD
 UvKL3Huq6rZPL7s6WcHDw6bKn/w9HT4OUZ5c9pM2tnaJUjKRMEZ3b2VHGY4nE+j4ZWbDz3XlpSm
 ICDNvP/24RuOTYk8AabOQYjl5GuqBM0=
X-Authority-Analysis: v=2.4 cv=fvfsol4f c=1 sm=1 tr=0 ts=6a85c482 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=wNXIhiCuMrYgSUWmQ_0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190116
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

Every target setting the cpu_exec_halt callback alias it to
their cpu_has_work() function, making the callback redundant.

Call cpu_has_work() directly in accel/tcg/cpu-exec.c
cpu_has_work_after_processing_async_events() and remove the
boilerplate cpu_exec_halt hook registration. No functional
impact expected.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-ops.h    | 17 -----------------
 accel/tcg/cpu-exec.c           | 23 ++++++++---------------
 target/alpha/cpu.c             |  1 -
 target/avr/cpu.c               |  1 -
 target/hexagon/cpu.c           |  1 -
 target/hppa/cpu.c              |  1 -
 target/loongarch/tcg/tcg_cpu.c |  1 -
 target/m68k/cpu.c              |  1 -
 target/microblaze/cpu.c        |  1 -
 target/mips/cpu.c              |  1 -
 target/or1k/cpu.c              |  1 -
 target/ppc/cpu_init.c          |  1 -
 target/riscv/tcg/tcg-cpu.c     |  1 -
 target/rx/cpu.c                |  1 -
 target/s390x/cpu.c             |  1 -
 target/sh4/cpu.c               |  1 -
 target/sparc/cpu.c             |  1 -
 target/tricore/cpu.c           |  1 -
 target/xtensa/cpu.c            |  1 -
 19 files changed, 8 insertions(+), 49 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 16c19da997d..a88cc4dc572 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -189,23 +189,6 @@ struct TCGCPUOps {
     bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
     /** @cpu_exec_reset: Callback for reset in cpu_exec.  */
     void (*cpu_exec_reset)(CPUState *cpu);
-    /**
-     * @cpu_exec_halt: Callback for handling halt in cpu_exec.
-     *
-     * The target CPU should do any special processing here that it needs
-     * to do when the CPU is in the halted state.
-     *
-     * Return true to indicate that the CPU should now leave halt, false
-     * if it should remain in the halted state. (This should generally
-     * be the same value that cpu_has_work() would return.)
-     *
-     * Either %transition_halt_to_exec() or this method must be provided.
-     * If the target does not need to
-     * do anything special for halt, the same function used for its
-     * SysemuCPUOps::has_work method can be used here, as they have the
-     * same function signature.
-     */
-    bool (*cpu_exec_halt)(CPUState *cpu);
     /**
      * @tlb_fill_align: Handle a softmmu tlb miss
      * @cpu: cpu context
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 54561ed31c1..bfdc42ab6a0 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -48,7 +48,6 @@
 #include "internal-common.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "accel/tcg/iommu.h"
-#include "hw/core/sysemu-cpu-ops.h"
 #endif
 
 /* -icount align implementation. */
@@ -659,21 +658,16 @@ static bool cpu_has_work_after_processing_async_events(CPUState *cpu)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
+    if (tcg_ops->process_async_events) {
+        tcg_ops->process_async_events(cpu);
+    }
+
+    if (!cpu_has_work(cpu)) {
+        return false;
+    }
+
     if (tcg_ops->transition_halt_to_exec) {
-        assert(!tcg_ops->cpu_exec_halt);
-        if (tcg_ops->process_async_events) {
-            tcg_ops->process_async_events(cpu);
-        }
-        if (!cpu_has_work(cpu)) {
-            return false;
-        }
         tcg_ops->transition_halt_to_exec(cpu);
-    } else {
-        assert(!tcg_ops->process_async_events);
-        assert(cpu->cc->sysemu_ops->has_work == tcg_ops->cpu_exec_halt);
-        if (!tcg_ops->cpu_exec_halt(cpu)) {
-            return false;
-        }
     }
 
     cpu->halted = 0; /* allow execution */
@@ -1072,7 +1066,6 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         /* Check mandatory TCGCPUOps handlers */
         const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 #ifndef CONFIG_USER_ONLY
-        assert(tcg_ops->cpu_exec_halt || tcg_ops->transition_halt_to_exec);
         assert(tcg_ops->cpu_exec_interrupt);
         assert(tcg_ops->cpu_exec_reset);
         assert(tcg_ops->pointer_wrap);
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 12e86021663..7d1d036e1d3 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -265,7 +265,6 @@ static const TCGCPUOps alpha_tcg_ops = {
     .tlb_fill = alpha_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_notreached,
     .cpu_exec_interrupt = alpha_cpu_exec_interrupt,
-    .cpu_exec_halt = alpha_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = alpha_cpu_do_interrupt,
     .do_transaction_failed = alpha_cpu_do_transaction_failed,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index f8409f32ab9..a01e6fa4751 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -246,7 +246,6 @@ static const TCGCPUOps avr_tcg_ops = {
     .restore_state_to_opc = avr_restore_state_to_opc,
     .mmu_index = avr_cpu_mmu_index,
     .cpu_exec_interrupt = avr_cpu_exec_interrupt,
-    .cpu_exec_halt = avr_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .tlb_fill = avr_cpu_tlb_fill,
     .do_interrupt = avr_cpu_do_interrupt,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 7067e5b70f7..9765716b516 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -768,7 +768,6 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .cpu_exec_reset = cpu_reset,
     .tlb_fill = hexagon_tlb_fill,
     .do_unaligned_access = hexagon_cpu_do_unaligned_access,
-    .cpu_exec_halt = hexagon_cpu_has_work,
     .do_interrupt = hexagon_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 07b49e51326..7b1309a7c38 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -270,7 +270,6 @@ static const TCGCPUOps hppa_tcg_ops = {
     .tlb_fill_align = hppa_cpu_tlb_fill_align,
     .pointer_wrap = cpu_pointer_wrap_notreached,
     .cpu_exec_interrupt = hppa_cpu_exec_interrupt,
-    .cpu_exec_halt = hppa_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = hppa_cpu_do_interrupt,
     .do_unaligned_access = hppa_cpu_do_unaligned_access,
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 4b1d44a1644..7ea2a1eb933 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -327,7 +327,6 @@ const TCGCPUOps loongarch_tcg_ops = {
     .tlb_fill = loongarch_cpu_tlb_fill,
     .pointer_wrap = loongarch_pointer_wrap,
     .cpu_exec_interrupt = loongarch_cpu_exec_interrupt,
-    .cpu_exec_halt = loongarch_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = loongarch_cpu_do_interrupt,
     .do_transaction_failed = loongarch_cpu_do_transaction_failed,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index ce2707dee5a..f349013ad41 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -643,7 +643,6 @@ static const TCGCPUOps m68k_tcg_ops = {
     .tlb_fill = m68k_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
-    .cpu_exec_halt = m68k_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = m68k_cpu_do_interrupt,
     .do_transaction_failed = m68k_cpu_transaction_failed,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 389a5124b12..6013a8def8e 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -448,7 +448,6 @@ static const TCGCPUOps mb_tcg_ops = {
     .tlb_fill = mb_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = mb_cpu_exec_interrupt,
-    .cpu_exec_halt = mb_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = mb_cpu_do_interrupt,
     .do_transaction_failed = mb_cpu_transaction_failed,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 669c7d99bb7..cebc2283599 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -664,7 +664,6 @@ static const TCGCPUOps mips_tcg_ops = {
     .tlb_fill = mips_cpu_tlb_fill,
     .pointer_wrap = mips_pointer_wrap,
     .cpu_exec_interrupt = mips_cpu_exec_interrupt,
-    .cpu_exec_halt = mips_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = mips_cpu_do_interrupt,
     .do_transaction_failed = mips_cpu_do_transaction_failed,
diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
index 66c00c0930c..42d9351b6d7 100644
--- a/target/or1k/cpu.c
+++ b/target/or1k/cpu.c
@@ -266,7 +266,6 @@ static const TCGCPUOps openrisc_tcg_ops = {
     .tlb_fill = openrisc_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = openrisc_cpu_exec_interrupt,
-    .cpu_exec_halt = openrisc_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = openrisc_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index e3a1075aad3..85a91ff4bb6 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7498,7 +7498,6 @@ static const TCGCPUOps ppc_tcg_ops = {
   .tlb_fill = ppc_cpu_tlb_fill,
   .pointer_wrap = ppc_pointer_wrap,
   .cpu_exec_interrupt = ppc_cpu_exec_interrupt,
-  .cpu_exec_halt = ppc_cpu_has_work,
   .cpu_exec_reset = cpu_reset,
   .do_interrupt = ppc_cpu_do_interrupt,
   .cpu_exec_enter = ppc_cpu_exec_enter,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 9e3cc87f8a3..cd303660f1f 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -287,7 +287,6 @@ const TCGCPUOps riscv_tcg_ops = {
     .tlb_fill = riscv_cpu_tlb_fill,
     .pointer_wrap = riscv_pointer_wrap,
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
-    .cpu_exec_halt = riscv_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = riscv_cpu_do_interrupt,
     .do_transaction_failed = riscv_cpu_do_transaction_failed,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 9b8473d71cf..69946928995 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -227,7 +227,6 @@ static const TCGCPUOps rx_tcg_ops = {
     .pointer_wrap = cpu_pointer_wrap_uint32,
 
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
-    .cpu_exec_halt = rx_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = rx_cpu_do_interrupt,
 };
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 641ea96c8ea..efbfb072bbf 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -382,7 +382,6 @@ static const TCGCPUOps s390_tcg_ops = {
     .tlb_fill = s390_cpu_tlb_fill,
     .pointer_wrap = s390_pointer_wrap,
     .cpu_exec_interrupt = s390_cpu_exec_interrupt,
-    .cpu_exec_halt = s390_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = s390_cpu_do_interrupt,
     .debug_excp_handler = s390x_cpu_debug_excp_handler,
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index ad2ec28c1b7..8d53e11006d 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -298,7 +298,6 @@ static const TCGCPUOps superh_tcg_ops = {
     .tlb_fill = superh_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_notreached,
     .cpu_exec_interrupt = superh_cpu_exec_interrupt,
-    .cpu_exec_halt = superh_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = superh_cpu_do_interrupt,
     .do_unaligned_access = superh_cpu_do_unaligned_access,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 1bc14b586bb..2baa5036871 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1073,7 +1073,6 @@ static const TCGCPUOps sparc_tcg_ops = {
     .tlb_fill = sparc_cpu_tlb_fill,
     .pointer_wrap = sparc_pointer_wrap,
     .cpu_exec_interrupt = sparc_cpu_exec_interrupt,
-    .cpu_exec_halt = sparc_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = sparc_cpu_do_interrupt,
     .do_transaction_failed = sparc_cpu_do_transaction_failed,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 96e2817dee7..f79d6fe5d5d 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -192,7 +192,6 @@ static const TCGCPUOps tricore_tcg_ops = {
     .tlb_fill = tricore_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
-    .cpu_exec_halt = tricore_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
 };
 
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 7c25b9ab707..99c8bd4b5fb 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -325,7 +325,6 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .tlb_fill = xtensa_cpu_tlb_fill,
     .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = xtensa_cpu_exec_interrupt,
-    .cpu_exec_halt = xtensa_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .do_interrupt = xtensa_cpu_do_interrupt,
     .do_transaction_failed = xtensa_cpu_do_transaction_failed,
-- 
2.53.0


