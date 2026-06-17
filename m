Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6889CD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtrO-0000SR-4x; Wed, 17 Jun 2026 13:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtqs-0000GP-N2
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:15:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtqq-0006aJ-MI
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:14:58 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFpKs23015136
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 paZaHfnqARyuzdyBchJ5nZVV2dKousWukxyV8h1bi4c=; b=TTLnT6sC8GJmRx29
 8YbSXUI6DpZ+MgIHrHf7P8VmvOe80dxya863UzYQ5Jry61cBDdVx/L4HGEdoyRaN
 cXdL+zI5qHZhPxZ1oBX+3+nT8uGwjRrmj2skFbolnvwkRjKRgaMclRn7UZBMROX7
 PQFGjWy8GSQQQpVLO3OQ/Qkcwc5hofgwih8Q/9EIUOupwIdGCS6pCP3QaG1B3slR
 oLKuGwHBadUV5LQahs/Q8mImjKTS/kWlqavzpzV8/IqbteEadDZnwGOFt8iZhtAq
 xDOsIhn0IvC6ePMyTJrSJUQpVyBuPZ4vafLomo8HDUIvSMo6ZpOWnnRXOP7/ZdEJ
 f4zDzw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euees4hbh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:14:55 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-966cf5e2a48so659693241.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781716495; x=1782321295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=paZaHfnqARyuzdyBchJ5nZVV2dKousWukxyV8h1bi4c=;
 b=JvrI3ZvuT8IxcLNX6w/VGEji/u6kbCK7SP8XfigKL5yOCNeK75SFNl0A+SeIco8O8g
 zavABvvgfIS7Ijdgb550yxlLhFGYhUgXnM0bQayUyp6GMQUqpTK+jHPHQSE6BxUinazQ
 TmRpMagdSAFvTxOKfCf6+r1BN10Z7tyLetI1uhcyqGVeE5mNsVwYXoLY8FnrbLTF7kDR
 Q9Y4fsfzo55qD+YYiiOj/9XAimwZLOHyDynsJtkfzagi/jR/auvpNxHCe0r+/fnjrNxi
 1+y1TxgOMzu8CVBbqC0tm9qC2yL+YKbiKPRCQOwmWXEWozX8la5A/kVO8CVXa/qYcieL
 Ubcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781716495; x=1782321295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=paZaHfnqARyuzdyBchJ5nZVV2dKousWukxyV8h1bi4c=;
 b=hOvdYwRqE9KIXiwzf+44FZhSzRfCyqTtkMPbyuLPa79OeRkCe88Dnr0s8KUMVVat2Y
 gLirFq9Jbmzb+ckVTh/9kwBa+q5HYXv1Q37qFY0DZzDOs0LS8dK5bHJRjU7n1y/hj7hk
 uPUG2QglPCnfhesjVHzW0Ufs7J4SRgBRXbxe9mqoBu2+jqYzs1dsSklNE+8mKvDNHeVE
 jKpjJgNMnyYFPhuBdeHoIZPBHjU0FH2PLwRjJMLsXF8zFiFpicGCL0OT2U0+ySbKkHcO
 MbUyDdaEKOW1Msa6NLByGZICLHdMFjaqF5aSp/76lZ8LLPWyTGsnDZPs8uML9UmYN38a
 BRiw==
X-Gm-Message-State: AOJu0YyktkUvyix3b8dJHuoxhfshQ9DEq+sJ8VrHgaSXdriRutfASZrb
 xUdRhu//0a25TxGzsbDjM890UplvSVTyLyNYDsTHrLgdKT5d2yh8OAWcSQ3w3fgAoWrrWieM+JJ
 RDJLEK1MYQtCojZNW5/Kjv5h45a/8U94NE94BOASm1zdLQkcR/W41ALa99qNgVsdm1w==
X-Gm-Gg: AfdE7cnTUcIj+PKEt5PVkY2mbnbQuJUr2aWiqkt14GHdjpCN+YRE6gs+CeS3VOLBFEj
 aw8nVsGygcUv7ZEWr3DVRdeVnVhce4h+YH1Q9QwOaXgORudznstENdt9YeH/QKJlTkQE2hNNmmm
 gZTx5fJyd6Ig9WAIq+3GbUdcQseKKB4YLisg7giqzzBWlEQjeXvCwo23Z1P/p4mWP/Wto/Bo5GG
 sawESeYoNDwHstiBiQnnk5/lUS61NDWGLhojpMfMpulD/drRjs9BFnCks8tHmWhU4/byOxvdoll
 DfppLOCjGKcl35DlYoZX8IUZneLpYknuTp9SXs7rPTo3TKbjAsXzgsrco+1/fZ78u/HYlznkM1Z
 bHGE4nlWfEKW8McqUl9xzBsIxsP68otqN4Kie+34RK3OWmA9qtoF7NFFkHBmCmZvQO6K4
X-Received: by 2002:a05:6102:5120:b0:631:4cda:3e86 with SMTP id
 ada2fe7eead31-727c7276211mr348097137.24.1781716494675; 
 Wed, 17 Jun 2026 10:14:54 -0700 (PDT)
X-Received: by 2002:a05:6102:5120:b0:631:4cda:3e86 with SMTP id
 ada2fe7eead31-727c7276211mr348074137.24.1781716494222; 
 Wed, 17 Jun 2026 10:14:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263945sm57481649f8f.8.2026.06.17.10.14.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 10:14:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 02/11] hw/s390x/ipl: Remove TCG dependency in
 handle_diag_308()
Date: Wed, 17 Jun 2026 19:14:29 +0200
Message-ID: <20260617171438.75914-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617171438.75914-1-philmd@oss.qualcomm.com>
References: <20260617171438.75914-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: g3OEZkSllJSCXCjr17ouw_5qmfEOUoA6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX5eQc3QfeLmdO
 9SIlDURiiZNmYz+WYbd6I8BHGl84nLkhbJMlQPfaBREplkb9bDm16pM7IJD/qC4rXoPdPN+/t/h
 PEwjdZ7+bTOqDEZ+k+o1JGGZMQQblaxrvwXRg0CKJw7oj//OZXp8+3P47f85jqx5lVC+wpi4EeW
 CibwbHJ03QKt4Gt9MngLvWcb9uIYa43VIMqkSvZxMc+d1BWugReeOrOPX62NWNnGv+8/d1lBxTZ
 m2aJSC6dT4GRVK2ByW/5Pp4AdaIHE22RTQTnwjgfKm5Dk09uuoo84vfYMzkor85wabg4sXw+7/r
 yf46vzT0jVN/4BoVngIsx61M1UX3EBWiSRTmYk8Dm//9wA9WzfBJpuzB+6AI3CRdEos4Z1LEg+B
 SuSxJL9Rep08RldPlhuRjm75GXxzcuaupZOeO5Z6yFNsYAu0uX6kbkvPJNYA0TMQaV6i5eq1JZd
 Cvy9468EgF5p6ONb0WQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX31CFieC+hGbT
 fQ6UeF1rxS/g4MriOsWdvRk0L3vT8LmlJrvmetogRXVWK2+HnfALwbyjYwmWa73rSrBTvl5vc0O
 HXNO7TZsOquqascBgNWJAo42qcQCj+I=
X-Authority-Analysis: v=2.4 cv=KeTidwYD c=1 sm=1 tr=0 ts=6a32d60f cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=O4nC0eKGiR0KFeLeyJoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: g3OEZkSllJSCXCjr17ouw_5qmfEOUoA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170166
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

Rather than calling a TCG specific method in s390_ipl_reset_request(),
have handle_diag_308() return whether a vCPU reset is pending, and use
that in the TCG DIAG helper to return to the main loop.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/s390x-internal.h  |  3 ++-
 hw/s390x/ipl.c                 |  5 -----
 target/s390x/diag.c            | 32 ++++++++++++++++----------------
 target/s390x/tcg/misc_helper.c |  5 ++++-
 4 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index e7e4f2b45d4..35d1e34ef4d 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -385,7 +385,8 @@ int mmu_translate_real(CPUS390XState *env, hwaddr raddr, int rw,
 
 /* misc_helper.c */
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
-void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
+/* Return whether a CPU reset is pending */
+bool handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
                      uintptr_t ra);
 
 
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index fa50749a7d3..4cca21c6217 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -18,7 +18,6 @@
 #include "system/physmem.h"
 #include "system/reset.h"
 #include "system/runstate.h"
-#include "system/tcg.h"
 #include "elf.h"
 #include "hw/core/loader.h"
 #include "hw/core/qdev-properties.h"
@@ -690,10 +689,6 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
     } else {
         qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
     }
-    /* as this is triggered by a CPU, make sure to exit the loop */
-    if (tcg_enabled()) {
-        cpu_loop_exit(cs);
-    }
 }
 
 void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset_type)
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 01cc802eaed..80f09584789 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -95,7 +95,7 @@ static void s390_ipl_write(CPUS390XState *env, uint64_t addr,
     }
 }
 
-void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
+bool handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     bool valid;
     CPUState *cs = env_cpu(env);
@@ -105,34 +105,34 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
         s390_program_interrupt(env, PGM_PRIVILEGED, ra);
-        return;
+        return false;
     }
 
     if (subcode & ~0x0ffffULL) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-        return;
+        return false;
     }
 
     if (subcode >= DIAG308_PV_SET && !s390_has_feat(S390_FEAT_UNPACK)) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-        return;
+        return false;
     }
 
     switch (subcode) {
     case DIAG308_RESET_MOD_CLR:
         s390_ipl_reset_request(cs, S390_RESET_MODIFIED_CLEAR);
-        break;
+        return true;
     case DIAG308_RESET_LOAD_NORM:
         s390_ipl_reset_request(cs, S390_RESET_LOAD_NORMAL);
-        break;
+        return true;
     case DIAG308_LOAD_CLEAR:
         /* Well we still lack the clearing bit... */
         s390_ipl_reset_request(cs, S390_RESET_REIPL);
-        break;
+        return true;
     case DIAG308_SET:
     case DIAG308_PV_SET:
         if (diag308_parm_check(env, r1, addr, ra, false)) {
-            return;
+            return false;
         }
         iplb = g_new0(IplParameterBlock, 1);
         s390_ipl_read(env, addr, iplb, sizeof(iplb->len));
@@ -159,11 +159,11 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         env->regs[r1 + 1] = DIAG_308_RC_OK;
 out:
         g_free(iplb);
-        return;
+        return false;
     case DIAG308_STORE:
     case DIAG308_PV_STORE:
         if (diag308_parm_check(env, r1, addr, ra, true)) {
-            return;
+            return false;
         }
         if (subcode == DIAG308_PV_STORE) {
             iplb = s390_ipl_get_iplb_pv();
@@ -172,30 +172,30 @@ out:
         }
         if (!iplb) {
             env->regs[r1 + 1] = DIAG_308_RC_NO_CONF;
-            return;
+            return false;
         }
 
         s390_ipl_write(env, addr, iplb, be32_to_cpu(iplb->len));
         env->regs[r1 + 1] = DIAG_308_RC_OK;
-        return;
+        return false;
     case DIAG308_PV_START:
         iplb = s390_ipl_get_iplb_pv();
         if (!iplb) {
             env->regs[r1 + 1] = DIAG_308_RC_NO_PV_CONF;
-            return;
+            return false;
         }
 
         if (kvm_enabled() && kvm_s390_get_hpage_1m()) {
             error_report("Protected VMs can currently not be backed with "
                          "huge pages");
             env->regs[r1 + 1] = DIAG_308_RC_INVAL_FOR_PV;
-            return;
+            return false;
         }
 
         s390_ipl_reset_request(cs, S390_RESET_PV);
-        break;
+        return true;
     default:
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-        break;
+        return false;
     }
 }
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 3d13c8bd8ea..036be93fb32 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -135,7 +135,10 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
     case 0x308:
         /* ipl */
         bql_lock();
-        handle_diag_308(env, r1, r3, GETPC());
+        if (handle_diag_308(env, r1, r3, GETPC())) {
+            /* As reset is triggered by the CPU, make sure to exit the loop */
+            cpu_loop_exit(CPU(env_archcpu(env)));
+        }
         bql_unlock();
         r = 0;
         break;
-- 
2.53.0


