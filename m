Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B14C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93i3-0004Pc-Uw; Tue, 22 Sep 2026 12:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93hX-0004H7-Pk
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:50:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93hU-0002TR-9H
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:50:39 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEjowS3952916
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 72N0GXBzAI2IR3Q2JwAh1iUuA/4cXofbC72GnfMvljs=; b=A17rl21NYJSn4WOW
 Nuos9WqMytoQDEEkCz99z/UoWrqnmlcv6qghWNoISwzkVbm4A/Sqc4n3l7Qr5mTr
 5LrDoP56uBy4LOn5qTTpp+bXlghoX+LiRAAgsZeXAYcGInUCzJSITlBpK2naLenW
 HCol5uEdJHsvbFp+b6WVwp/bFlDb6hkQMJPJrnkYU+pRSelOI5+u98LYepMvcjFZ
 yCyOcjpHQ3s4cWBptS1Z2+YjkR96FmpAQbUunluYoDVUiM06dk+zrehWtZL7e1sv
 CX70lDkhfgEtxeFKvvn45aVhKG+Ii+s3EYMOgrbnWTYPIjH9OB7AQr4k/tcxPz4U
 qEmFew==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufsqbp5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:50:25 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5c83007a11cso31559e0c.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790095825; x=1790700625; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=72N0GXBzAI2IR3Q2JwAh1iUuA/4cXofbC72GnfMvljs=;
 b=KVbbLiYmfQdKG23yyv+lmAeXELJYZ+Al0p1/JeOu/1RQj7V1v5mvtefv7dWnsplzVM
 2lryLHH16ZoCKKi1ZS/fUTKp4UPzuecrHswxsBkmYSFpzTpx//SZSYaHTNZQno/41VsY
 7pjZ8dJAD7qi8WMeSHeeVLCxQfujV2zHHwn5pDWMHmelLgJUy6HO95GpSLBdPKu2rmDN
 /R1Dizx15fhML2fnDH1ZvYTvVvBAQK4owD5jAvVfTt7KK0sohaBTE8o29hSJEYxiVEko
 xyk7YQKvS5WHWJeCLRDPG0kJN+H+LzQfWVlvU0pv91J5zbOAWpw8zTeiEj1mFP9w7p3M
 mk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790095825; x=1790700625;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=72N0GXBzAI2IR3Q2JwAh1iUuA/4cXofbC72GnfMvljs=;
 b=ZgEFJEWcvHzA3oc0hHOgMECcgrltDqm/RhHP0tlzLW18Zg8OrytR/sbs+KwCteuULg
 6RI8icbkcMmMEpJExqbVEfz2Pu0DRqHTnbMzE6nPICgxFBk8gw+5WXbzbPStTFu/TXdI
 kR5LqJ8Al/gNHpU7K4UY94mh6hu3ybb8lLJ45n/yUqvFv2dQ/5k0e5KAG1y8QKNM3EIf
 jWDxyeULR0CbcGaHrAZroav+R1nzzZFST1HrvXM0vgVDEOB5vC/n1CZGN+1/2c3D8xUn
 HlmUGZBOkpnKKUumrXlL5X/uFdpt893Wp/XvkqS/kY/hWus4Po3LPEY4Ycc9N+4gKO/a
 w4IQ==
X-Gm-Message-State: AFuF++lJFxLQkPmH+jn0EwKrRddbp75JFtXFVGkhAoeK8LSgPXrgzAjc
 pcijK+5CuS60qv3uD0CcBHsj/LvW8WTe/NZgUCvPCEp3V05tPo837TdWAWnOE1XADPKMGNcY4pg
 EUm7JWcERVk1eHm7rp7tSLIdYlmKKmMaW/bpjjeVD+s39jJTZ4sBWbAhveUJ9EYX24w==
X-Gm-Gg: AYBFou3hEvys530Qw1X8PSGje85ZnBY3tGshS8OyEOJ1clU0spmYMOT76kNSaPLR6Pm
 QGx318x8e02Cg9YWLyCIXFwtfoXajEmt9ahF3vURyOMhmdMNv11tiI5oBGP7dy3HIf/0qHz7ct/
 /DxjHSN7/VTCLjLNHogD73HQDHEJGbZIENn0FMgubLnwuZoxlkgNPsUtOziQJlfWWSX/Evo4qmg
 dnNsHr3PlquQNK2Hkr+EqJMYbY60Ak6RPEtf/7qMSr1q4wBLAq7e4ETHXqGr7qXMInStcaZzd1w
 AjNVksxzlBkHDHDJMPcA7bp5gWFfYaA86i6pa/eC3WzvRzxs+s0+MOK5dbs26v/yu6242GfOQZ6
 9iPRZjhq5i/ShSFFrTF3R6a9ZTzjlAgjD7nnLkVg1
X-Received: by 2002:a05:6122:1312:b0:5c9:a60b:e5d5 with SMTP id
 71dfb90a1353d-5c9f1655c76mr124695e0c.15.1790095824509; 
 Tue, 22 Sep 2026 09:50:24 -0700 (PDT)
X-Received: by 2002:a05:6122:1312:b0:5c9:a60b:e5d5 with SMTP id
 71dfb90a1353d-5c9f1655c76mr124660e0c.15.1790095824066; 
 Tue, 22 Sep 2026 09:50:24 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488626d29dasm6729910f8f.0.2026.09.22.09.50.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Sep 2026 09:50:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org
Subject: [PATCH v2 06/17] target/arm: Un-inline arm_set_cpu_power_state()
Date: Tue, 22 Sep 2026 18:49:24 +0200
Message-ID: <20260922164936.15189-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922164936.15189-1-philmd@oss.qualcomm.com>
References: <20260922164936.15189-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KE3igR3HHo_me6xYzSMV3ZFjm6rpgPDt
X-Proofpoint-GUID: KE3igR3HHo_me6xYzSMV3ZFjm6rpgPDt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX7Qe5LNBSiMSo
 Qs1DnMIbCD0fAgr9kplT23MdMcowwN9MGgQuXl/PWIRIu2qAAYbNNtrrrSorjgqpmckNDTcmMi/
 Sy1Wu+vPHiYRHGhjZAVdDg+noJpC0ME=
X-Authority-Analysis: v=2.4 cv=NKBAaE6g c=1 sm=1 tr=0 ts=6ab2b1d1 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=or-B4SToQ6AIma83kDAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfXzsT0DVNPVds3
 p5w8rgQMorVqLAUmcE14z9NIY4qWEKqheykfJFvIBVGWjAviTcpME3UZ4HceZOWPwbn7McQaLLY
 3d2dcRj1mkUHCjjiEi+HPjHk37TDafH11nsnIWoRB751skvLYOc8ks+l8Uefq7TMh+rT4QfK3RZ
 72/4Z4ky9VOgeOXzhT0MnnS8nGsSug0qQIEqlHKMr5GxE9xOQcCTaY6R83ABZm9otFFQHv5rz96
 nzoj77PmG6ayeyBspQ3plN1jon44n93B4IPMvV+q6CCH1C3IFq6f9Mdj/6l9NrRK3ZbGeJ3B2xK
 H0lB90xlC0wJDnvsD7xYXHb16E8ESq+wgZnorIBzbffjbXY6mc9BrQQ3z41Kygx6J58gMU17dRQ
 PlInYkGLmkl0i/dUSiCv6QF+7BZeq3Afw7xCrHetBDyJ53yUDGO4y5f7ycXTIvzpVTBZHLfN6+Z
 8lQVPDia1zDBePTazQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220246
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

Move arm_set_cpu_power_state() from the header to arm-powerctl.c,
keeping the power-state helper with the other power-control code.
Restrict the call in arm_cpu_reset_hold() to system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/internals.h    | 8 +-------
 target/arm/arm-powerctl.c | 7 +++++++
 target/arm/cpu.c          | 4 ++--
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1775835ad50..1efda543270 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -2082,12 +2082,6 @@ bool arm_cpu_match_cpreg_mig_tolerance(ARMCPU *cpu, uint64_t kvmidx,
 /**
  * arm_set_cpu_power_state() - set power state synced with halt_reason
  */
-static inline void arm_set_cpu_power_state(ARMCPU *cpu, ARMPSCIState state)
-{
-    CPUARMState *env = &cpu->env;
-
-    cpu->power_state = state;
-    env->halt_reason = state == PSCI_OFF ? HALT_PSCI : NOT_HALTED;
-}
+void arm_set_cpu_power_state(ARMCPU *cpu, ARMPSCIState state);
 
 #endif
diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index a06be5cc997..213e7ae056c 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -45,6 +45,13 @@ struct CpuOnInfo {
     bool target_aa64;
 };
 
+void arm_set_cpu_power_state(ARMCPU *cpu, ARMPSCIState state)
+{
+    CPUARMState *env = &cpu->env;
+
+    cpu->power_state = state;
+    env->halt_reason = state == PSCI_OFF ? HALT_PSCI : NOT_HALTED;
+}
 
 static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
                                       run_on_cpu_data data)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f58a1db843a..76aa47ac503 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -351,8 +351,6 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     env->vfp.xregs[ARM_VFP_MVFR1] = cpu->isar.mvfr1;
     env->vfp.xregs[ARM_VFP_MVFR2] = cpu->isar.mvfr2;
 
-    arm_set_cpu_power_state(cpu, cs->start_powered_off ? PSCI_OFF : PSCI_ON);
-
     if (arm_feature(env, ARM_FEATURE_AARCH64)) {
         /* 64 bit CPUs always start in 64 bit mode */
         env->aarch64 = true;
@@ -671,6 +669,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
     arm_set_ah_fp_behaviours(&env->vfp.fp_status[FPST_AH_F16]);
 
 #ifndef CONFIG_USER_ONLY
+    arm_set_cpu_power_state(cpu, cs->start_powered_off ? PSCI_OFF : PSCI_ON);
+
     if (kvm_enabled()) {
         kvm_arm_reset_vcpu(cpu);
     }
-- 
2.53.0


