Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B145AC98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QWZ-0004by-O2; Wed, 23 Sep 2026 13:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QWQ-0004UM-Kj
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:12:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QWN-0001AU-S1
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:12:42 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGU37I3106209
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J/A1qo79auMktV306/mjb70NRnck9MYGHu4ee3LXFWo=; b=Q4rneli9ZFElyNQE
 KnJ81vlgx8945zrENznprdXF6mXBVd+A6of0lMapYP2cseC1PFUw3vwYHhr/G1q3
 VcU9hekHBmvGnqQHaA+yyWPZri3pY2gi42EvHuHujswzOKelXXxxXOr80vpp/+pT
 2HCl7xLUQJtmQzvZllW7HVRLQB6EFI8ivh3FDAgbUh0BCGpfbu5HBAZSeB3r1DWF
 vuHPQhaEDWLq4QyVxUMtSKGMJk3+lio6+t/cEnQkEzWFXc0saPcABmI4sEIUTvIX
 X28XNjmTU2D08fT0ImHXKBWdRpTwxZHah+tvL6tmc4YL8QSCm4blueMTzUHOPA7L
 QrCtoQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfmwh0xd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:12:28 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-790de8f0cecso353048137.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790183546; x=1790788346; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J/A1qo79auMktV306/mjb70NRnck9MYGHu4ee3LXFWo=;
 b=S6Sb7Ya8dPOSWVEClZgRZB9jnfxQOe0MRkYC5oF5ym2S8+DlL6Y9JL/5pKtNcyr2JV
 aGr8HV4xbZtNXiQlOcsh68P77DkH7TwAeWtZfHcHAEieznf2pwR4q1gep8vMXtxzF4UJ
 gpex8bfk9G0qC6cwDMdxHO0or6GLDr3n1OntnM86JsSbYJNW2mio6LTB9pu0dGdov6H8
 nmUa1W/1txqk2S2hHJ1B6fcfDq+gCFaf72caABVvBoEoeCvAhM0NAYAIwUkjYJd/KtLk
 9pTIUd1xbbyrvc2yEBnB3O5/gNZqhMO1rvlUTy1jTQ9z+tF9RyzKIRF2ygXr7zPYaddL
 mqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183546; x=1790788346;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J/A1qo79auMktV306/mjb70NRnck9MYGHu4ee3LXFWo=;
 b=A7VDO+W+g2oF9VG5i2BGmk3W7c4TdXkKe6kpYTIbXUfGYHwGv4uELE9SUGCC7n1oxK
 0GqwUg8GXN+nMSWJLQRqhMlZMn8RsTWGk4l4KA015RGORVtMtwCnMDCp7FjIZNeHPCxA
 nC+m+8IYeYWDjROV4OB8Cu8S6tpznjChbBL4k6CBd880/JaQZaxau1vhxdFW+HZBYZiW
 MR/yCBJ6jJdqUQ8xXAjiKB3h26oXQKLDDCVQPru8CA8cqPsyysXrWQqw37L9HUeD9NKd
 hl0N7TouJxqIc0Ox0JfywPCEVuy2MVgMHALhfPCKOohMsOMegbZ7w4JAMY3jwyFe1thZ
 /yFA==
X-Gm-Message-State: AFuF++mBvLtCt7uJ7b3fJPZji3lWTz08MQOYxoL9mEHr9Vz1pFfqX8en
 /eKOYoxVR2an9hlfhf2oD8qCAsQky56s2o+kXpmNrnjS/+rccWBrzjAmOVFwlN9T7WSmJczIHXt
 aaVU9BkMQRp0QFrwDg/kBRzMNKB5gqY2Me4s+khG8bqDMzRYWtdeKaWLhsP4DYQYHBacH
X-Gm-Gg: AYBFou0oIp2a3esW70QVfVZ5lUbfp33syjzCwTsHc8imS2ZKWFrXHGarAiqnwFXadQm
 lvAhj8CTEgRfdq0MrilelT+AlAhl+ARVlBXAZfj688crYLI6tKKWC12l+Aam73HGbr+xap+nWWE
 GbTp3es8Kkzj8ocNgoVEM8LtJTU1lD7vXHNL4+2spb+1KaGeSYW3VegGR6ycFBGmRcnJCQ7T1pi
 pKF9I5GmKD9sC7HIjplQ2tsycMBJJ2Ft9zwgSJRB+IICZfhX0OdIJEb+uaXaksQ5Isi+l23xLZJ
 tH9AdziyVLWkoo+BxNDzwJeNWh/nJJFpHIOKENNOTtNp2bvDqLCHKtTZTPIW5m9KnMv7Hkkyx2H
 D8iZrFXZgv6yRtZfcPoh9dkJrQ7s9jCdjPq7Rg4rg09/mdfdP48A=
X-Received: by 2002:a05:6102:dc6:b0:7a8:10eb:96cc with SMTP id
 ada2fe7eead31-7ac1b1f54d5mr3038148137.8.1790183546096; 
 Wed, 23 Sep 2026 10:12:26 -0700 (PDT)
X-Received: by 2002:a05:6102:dc6:b0:7a8:10eb:96cc with SMTP id
 ada2fe7eead31-7ac1b1f54d5mr3038122137.8.1790183545708; 
 Wed, 23 Sep 2026 10:12:25 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cc9a37sm608385e9.11.2026.09.23.10.12.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Sep 2026 10:12:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 09/21] target/arm: Access halt state atomically
Date: Wed, 23 Sep 2026 19:11:03 +0200
Message-ID: <20260923171116.31276-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923171116.31276-1-philmd@oss.qualcomm.com>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX3716HW3czeSH
 90alzV+W3jTWEG/fm9yl/rJ4t2N9OzgrGWT387E9jaBPuO6XsllDVf9Z+gJR83RkaAJnJ9G6n52
 794D6d6tj571eJhxmlmj30x2Y9xHetG/DotT8MGEwJtZ43vEs6jmNJrpL3axoreWVBk9ozJoDnj
 GgnZTwAAzJQ2sJUqteaYFIOgC1+5eA55MwZhRcpdnUqzXnQ6kMMyX4yl6hJB4DA7WU+QjERHk0a
 b7hYWKSNM3Y44HwQDUU96hM3HqXlXUyN97xSWGRALHP79jDScpWl1BcG/zlElWRVimR5t0hhAdD
 nkZ+JirVxpaPWiGWK0iVqKQOPi3ICOHn2YJ70Ya6OTpxwBj4YCmcJZpCFudsDttIpPOIzOXO6iY
 W7TYgNMjmxjQkdVyfd8HblSFLW1dVvuk8zy3Mf2rR6wyu+qkRDNTJuLUpk9OdPnJwdNeM1sCxbC
 VvX2Mb/uNwBnh8UtEEg==
X-Authority-Analysis: v=2.4 cv=WK/qzXsR c=1 sm=1 tr=0 ts=6ab4087c cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=BUppp-h3xPyjPovRqvQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX0ZG1pPtb3rZO
 VFt6DbXZ4xsJTKBxWZiNxWgTFbJYxtwqg3V6auNRzgM52xKn9bv62/ch6rA9XEoUdYQVOalbXBu
 8a9PlhUQptIBy58wDWpNqZFF6kIpDPQ=
X-Proofpoint-ORIG-GUID: Z8hxhpBckrgx01cA8RrdzX8Roc7H_Dvm
X-Proofpoint-GUID: Z8hxhpBckrgx01cA8RrdzX8Roc7H_Dvm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

arm_cpu_has_work() runs without the BQL held and can inspect
halt_reason and event_register while other CPU contexts update
them. The WFxT timer may also consume HALT_WFE asynchronously.

Use atomic accesses for the halt state, including the WFI/WFE
and halt-exit stores. This keeps the halt/wakeup protocol
race-free and matches the atomic state transitions used by the
asynchronous wake-up paths.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
v3: Dropped rth's R-b because of HELPER()s call also updated
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


