Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6D2C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lLS-0004RR-RY; Thu, 24 Sep 2026 11:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lL9-0003tR-3t
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:26:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lL7-0000Xu-7o
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:26:26 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC4bWU2749268
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TV4EnFsha7rDOnfHSyGGOu9kiFQhAyq3Fkz+DerTdDY=; b=ZsEaKv0UETb7diy4
 bQrglGTSYpF1iH/IkVBIpl6C/0YwbK2wEtpl4FuGA8bYdeQtrfqzCbZBxNBgGrxy
 rnUX+4OKfKfmmRKSC0mM8HFEbOlLEFAU9BLrPNNBeBINVgaM51jSg6v6PHTmIjeL
 h+oyS1z+HKKkVeCloeDTFADUVEuZn0RZduqSVV0y3Md+5KNunaqbDcORE65G8JHE
 OMJdoRlEgKLnnjEMXPbLjAplEC+hNnfMEO5CvPqiiw1aBkvYmwXhJFAfeVYk3hE6
 x/wbnV661fKJacG/HWbJoa6ncozrOBbvBmT+3V5sVG9/qhybQY2p5nEmNy5itwsh
 2GstMg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1s919nu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:26:23 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97e9cc5ac86so418111241.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263583; x=1790868383; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TV4EnFsha7rDOnfHSyGGOu9kiFQhAyq3Fkz+DerTdDY=;
 b=C5/wey8xZl38/yI/XwEgTm/l0mnHTkFthe9NixSHFFuTx/LklwsTuZxjLk4qKLfpph
 D4GZjTSigEMExP+DbEoYT1MM5KlL5uoDqnOdAA7iuh8YpD+DwVFw3k1UCVPvy9Nd2Fgd
 CCZMANSt5qfBmBpUoxHrc2ti+NBPu6sDG/phAGphKebuA9TRpChHSTY7Ifh18SSN1d/o
 GX2RA6OeCurlYNQWIkzJBQEwyAFLcyRV6nYxNvyTGmVOQJsgr3QPcS3hzc51u6GTW+md
 Fy5+Atd0aOGsdojybUIE4ESq6yc+oUlHf1Zog51KQ38uxxLBn+5yHuyvwgUHH6cRDFV0
 biBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263583; x=1790868383;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TV4EnFsha7rDOnfHSyGGOu9kiFQhAyq3Fkz+DerTdDY=;
 b=L9N9OY6SokjmANkwsxkD7awEpONJq/jY+c914QPI8F0x73W3aDsNwkN9AWdDssFlzy
 h33J6AOrV4+Du8ZbBkpysOAdwV6ZqRJSfASPZyRulx1YyeWRUN7sCwbn2kNf35fFrPBW
 95+fit11n4CtO8ZG0AaLKOf6f86lB+B3IQSKwNDp7p1Z18w3ozS/u3Yung8cXkwGsaoM
 XKEEUk61z7+0buTygERRkv3Vg7vkYSYnaz6GlHNTvXdPL8yrn8HY2FDCx7kMqT8zImb0
 eMgYVrjCwOCDH+W8BIQUML5xIWJORWbjuTrPQuYNkRIHnBovSmq+UEEd12+Tf6bfEKSY
 zV6w==
X-Gm-Message-State: AFuF++nu8DGpW1+CV4F1K/dleQm3+ATdB2Pll1nbAksKEjcmsZnJF2tq
 D7FKyIXYsrxGQO9GXludLwqmleftltdfFQse9LtnLG1Rji2V8KiNNzcFfSok76Ot2tedKs6asEm
 4kjqXhnx+nkWebX5bAviqbKcWfxFTa/S7XGCSvTMk7cCoJxpXbdX2Zv/Lbe41m00faA==
X-Gm-Gg: AYBFou26t7zjM57yNiu58jEh/6clfqRE+mmxiLm58PMvO+6k52Ofu6nfzPkQMemMhB3
 zZfd4DFH5arjBKJRY8YC9wt8g4Fn2gStqDzt2BHpbj5RyWqWBJTg4W+B2VBz1SLAAetcR3cbwY1
 mvsGYBf7JXDCBafDDIa3ja861gPBpColj/7eeUZ92ruM4Q7CPVN7uu6fI2Z8Nw9ZcsgCMhMSH13
 0YG+XnBmPEGarjHzE5iJWcokWLTip9ojHMgdrdArXJgzD4wd/bJ3Ats2dlRlqegSXYtQZTqmdxo
 2lKt3uHB6eZOJi2EqbsPNZ7iQrKa/xe8xzdzuldW8EM+xH7nfEArXYH65rs5hJO8T/jnrmaqqLA
 WZbAVmnrzM/5jHGtHXXKurZLra2/KHjkHR88aDGPF
X-Received: by 2002:a05:6102:50a8:b0:7a1:f980:e938 with SMTP id
 ada2fe7eead31-7af1e4f6eb1mr1149644137.20.1790263583315; 
 Thu, 24 Sep 2026 08:26:23 -0700 (PDT)
X-Received: by 2002:a05:6102:50a8:b0:7a1:f980:e938 with SMTP id
 ada2fe7eead31-7af1e4f6eb1mr1149632137.20.1790263582669; 
 Thu, 24 Sep 2026 08:26:22 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488687791cdsm14708435f8f.22.2026.09.24.08.26.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:26:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/18] target/arm: Access halt state atomically
Date: Thu, 24 Sep 2026 17:23:51 +0200
Message-ID: <20260924152353.36209-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX3P6oMToJZQZ1
 9VY6JLIsxTrNB8x4q+F/RkLeGmtGBttpapKunr6Qtw8M1vATP+AB2sNmKRVCCyq5sTJf2Gs0qJa
 B53tuAoX14XQPgqfjA4+2rvPqfHKyP8KQb3s1Zc3F3lWH0zGYgv/Bb2Yd5JamN9upMhG+4lMPvG
 +GL51Oo/TgROuOhDHV4wED6VIZnWwLriwmQVNNmTiMXU8na/NVPx3HCG0j3nG/RF3hXNxqHEPvq
 j/YlxZaheCJZPLQq9X0yOG936Fn2V8lwEVAT3LtsEcuehavV/EPsLoyskw7PaCC4K/xhQiQiEp8
 /h/JoUCJp5VWxXUYsb2Q9CkSg/7WEFtf5tSr/RjcmuhrQhH3yVImoTMO0a97mei01Pg+72vWFwk
 k8BFJlUKHlKSo8aaS06RY+McOwd+6jLldHC2RHjPN3LHJQPNwI077HF93bOGNemoQX4s5DHkgNS
 vpYd394f0MIHVCv0VRg==
X-Authority-Analysis: v=2.4 cv=VPxIDNPX c=1 sm=1 tr=0 ts=6ab54120 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=BUppp-h3xPyjPovRqvQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfXy1EJsQT/VZ//
 CVNEWGe1ShEh/nUPa+1Q3YPG7Ml/N1IoVXLWYQvc3YSMXdgBU0NoBTBzKcBUjGEKptbGeXAZyfl
 tPg3fmQQ2d4Lz80hXSV7HVF+otX1xK8=
X-Proofpoint-ORIG-GUID: I5DaUyWM3o63hbkRSJ1USaBWT3M_H7EY
X-Proofpoint-GUID: I5DaUyWM3o63hbkRSJ1USaBWT3M_H7EY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240063
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

arm_cpu_has_work() runs without the BQL held and can inspect
halt_reason and event_register while other CPU contexts update
them. The WFxT timer may also consume HALT_WFE asynchronously.

Use atomic accesses for the halt state, including the WFI/WFE
and halt-exit stores. This keeps the halt/wakeup protocol
race-free and matches the atomic state transitions used by the
asynchronous wake-up paths.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260923171116.31276-10-philmd@oss.qualcomm.com>
---
 target/arm/cpu.c           | 7 ++++---
 target/arm/tcg/op_helper.c | 8 ++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5cfd3bcfc8e..090470da40a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -144,20 +144,21 @@ int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
 static bool arm_cpu_has_work(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
+    ARMHaltReason halt_reason = qatomic_read(&cpu->env.halt_reason);
 
     /*
      * Only another PSCI call can wake the CPU up in which case the
      * power_state would be set by arm_set_cpu_on_and_reset_async_work()
      */
     if (qatomic_read(&cpu->power_state) == PSCI_OFF) {
-        g_assert(cpu->env.halt_reason == HALT_PSCI);
+        g_assert(halt_reason == HALT_PSCI);
         return false;
     }
 
     /*
      * A wake-up event should only wake us if we are halted on a WFE
      */
-    if (cpu->env.halt_reason == HALT_WFE && cpu->env.event_register) {
+    if (halt_reason == HALT_WFE && qatomic_read(&cpu->env.event_register)) {
         return true;
     }
 
@@ -882,7 +883,7 @@ bool arm_cpu_exec_halt(CPUState *cs)
             timer_del(cpu->wfxt_timer);
         }
         /* clear the halt reason */
-        cpu->env.halt_reason = NOT_HALTED;
+        qatomic_set(&cpu->env.halt_reason, NOT_HALTED);
     }
     return leave_halt;
 }
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index c2b09176cb1..643b1482523 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -398,7 +398,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
                         target_el);
     }
 
-    env->halt_reason = HALT_WFI;
+    qatomic_set(&env->halt_reason, HALT_WFI);
     cs->exception_index = EXCP_HLT;
     cs->halted = 1;
     cpu_loop_exit(cs);
@@ -460,7 +460,7 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
     } else {
         timer_mod(cpu->wfxt_timer, nexttick);
     }
-    env->halt_reason = HALT_WFI;
+    qatomic_set(&env->halt_reason, HALT_WFI);
     cs->exception_index = EXCP_HLT;
     cs->halted = 1;
     cpu_loop_exit(cs);
@@ -629,7 +629,7 @@ void HELPER(wfe)(CPUARMState *env, uint32_t insn_len)
         }
     }
 
-    env->halt_reason = HALT_WFE;
+    qatomic_set(&env->halt_reason, HALT_WFE);
     cs->exception_index = EXCP_HLT;
     cs->halted = 1;
     cpu_loop_exit(cs);
@@ -723,7 +723,7 @@ void HELPER(wfet)(CPUARMState *env, uint32_t rd)
         }
     }
 
-    env->halt_reason = HALT_WFE;
+    qatomic_set(&env->halt_reason, HALT_WFE);
     cs->exception_index = EXCP_HLT;
     cs->halted = 1;
     cpu_loop_exit(cs);
-- 
2.53.0


