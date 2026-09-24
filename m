Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D01C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lL0-0003P4-Ei; Thu, 24 Sep 2026 11:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lKv-00031I-07
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:26:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lKt-0000XE-4J
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:26:12 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC4hps2594275
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 utaDzMciMH88pwSyIMbGGsHos0NQm+jbaJRbElWB5bQ=; b=nDfWZgBWr3LBWFb6
 amWYJwlXMdHFWpsjT9d9TfS++YbVDDp0leHyj08wVpXjmKmVIIkT6XB3QC7kV0Ws
 0M+oXf7aOe2AdFk8OHAGeDm9nigNxJl7HnH7pmxZQBxIIukpvBtr0RxcXxgdWv/2
 yL8PU0gvEER3vqnz+Y3SrasitUZVNevOVKZl/TDF+oZLJ7PomAk2+/yA9aNlgo9E
 RfhGK453+z3P9o3IKkL1SPHT4uBbQnJSnhAxGJ5T738+7MjhjHUF5KtxbW5wjZRX
 UAdxGmkGpOjbCmmBS9qsHA8rEt4emhvT2k2nwWxNG8qlItnN8xjwksUgGeow9oaM
 kgrzQg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1tjh8x0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:26:09 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-78d25a8ff32so679408137.2
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263569; x=1790868369; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=utaDzMciMH88pwSyIMbGGsHos0NQm+jbaJRbElWB5bQ=;
 b=Ig1ix6WjSPBvI15Ms4/BsNjt3nPOAGEDCG5zhNHXRSddsr6MXww0eJQbuN8gxlo5Li
 8GzGgBBL5ZPVJUfWzbnWuyLvLP1RbiyZsbzJ/NMZFa1KgG9t3prQBnBfkOHszpgMdXlU
 YfUfHKil67XFVi8EDZ6gU+DSV5YKW0bPTwY355l4REqdVJcJRzm+58G05GDskTELN73a
 WxCY4JZQsDhF6ptlvEPbxkR9nBPPyrCef8l+luzzsX1suOn/mV7GyWPZWQ8xkI6wQkz6
 MuB79KKjX15DewjSu/clCgZEEcxTX2xFIwduyiVR6LwBImc2eH7eJm3lVePMbk5KJKYf
 5xeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263569; x=1790868369;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=utaDzMciMH88pwSyIMbGGsHos0NQm+jbaJRbElWB5bQ=;
 b=vH0dYEwhW27U2PuIeQTJI44e8JD6T7jexBJkKPwn+gGDOJW8ibVZD//TpSHPKlp4BJ
 o4unRs280OjQ2JehvgJsAm2K74pskO5sgaiJa8nlRz24+BkhuUTzIwkU8ZjdcUzJejVJ
 JqWDtZSFOnSEMugKhGXf69jOymNYEDR1mF0hqk2s2tCnHKtenjdKb9D5cpxokyhjorX+
 9aG6vTmLRuRxnm7by4sja7PjQH0taKt9bRKSCEsGVQP14saeVWYVupO3UtpDPHkr3FQs
 bcqC0yaWJsQDYyXOGbeiXWdu0J8rJUuS7bk4ogrv9h0eM3EMYluquqGHC6g7nYLn+cBk
 UiOQ==
X-Gm-Message-State: AFuF++nJO17FhSPMpLXARPfSTm/m/BVw+lXWzMOglE0E0130xzLejK5n
 lGJq/XsWp0CdqQjYGKfQ58dNNZxMZ/pvEQtTvElHwYgDZyHIiQ0jPAb7mUe5mIIRvmX8IIDcq8t
 VOkWEX3YWn852YFqnzrgU3HExhTNzwpvL9glZ2DnptnHgVxVB+6ONy7nRuS0pORtE+A==
X-Gm-Gg: AYBFou37BDTtMzDdRmIIPmDSIb023dsvCT+Lu0n4bAe8LRaFu97LxiSEiZ0AUopg5ul
 t2T3voFkRcBw5CaBH3ASLM7TQWDyUGb7v3qF+d3nNidoJTcWgO/stsSoCLqVQhhh/VY+YuzYb02
 hqzosd9aJxOJbh44hTmdyJKkDQpuIjUbejM1hrHw6UoTtQ/Ap5EzKc6j2uq+lupa376zx7ONSYI
 3bQVmSaVZJjb6sgUxaRfPALiBc9a7YfZycnmESEA2sWKJxMJg9I/NQtTXJSpx+1enrrjEkZtxuQ
 H5eQXEy9mEespkv9ZOeHK4KGR1lquO4B51NbklKV1tj4VBXXAKPZAujpLnOfGo7kGHu3P4MwGU6
 X9mSXBr9ag/zWsQ0kLRGqCHLPt4b6DRgy9Qar3ITY
X-Received: by 2002:a05:6102:41a9:b0:7a6:b18e:6d5a with SMTP id
 ada2fe7eead31-7af1e4f6363mr1250340137.17.1790263568343; 
 Thu, 24 Sep 2026 08:26:08 -0700 (PDT)
X-Received: by 2002:a05:6102:41a9:b0:7a6:b18e:6d5a with SMTP id
 ada2fe7eead31-7af1e4f6363mr1250320137.17.1790263567557; 
 Thu, 24 Sep 2026 08:26:07 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488684863d9sm15617050f8f.12.2026.09.24.08.26.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:26:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/18] target/arm: Un-inline arm_set_cpu_power_state()
Date: Thu, 24 Sep 2026 17:23:49 +0200
Message-ID: <20260924152353.36209-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: j0S_8hhmANLrGAYDnbYgs2JIkdmVc7ZH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX7N9H9E4XkiLQ
 NqFrTAvKqEdT1QD5xRCgRBo+SWP1ArmHMS3Vt3EyOFv8tmNbzo1C/L6xz02Mijv2VBmovNlmPxH
 MVhX/6o2k0FsmamB85YNlFkX5obF5n15TC2bQQ8BrxE16bjUK+OILUYIBB0gHS6WZ7/BNScZiOD
 9+Qf7U2eFaQiMjuusNAgnyAyRti4iRDyxs5f2zZckrLjPde7XqEZqtascBQtQiXhh7ZPoSx2kBt
 XdwsCHFcmz9oFXt6bqfjWhDB8y21dx29KBvB4BgQRhMBdXd5+25l5LnpNd9IWZ7RJZ9jft72dQe
 n3MjFw64nG7bOkYU3NNUyP2SFc4k9sRnKo0c6la6rFew940nbMZnpSyIDvY30j8k4XpU2QWsNea
 2v70dbBm1j38b30BPbK8EVS3VMZwJrnfi5A+7sQCuoy8oNmYptoauvUqHM1C3UR/WAcowS29488
 ARPWdjeSj8gV3CPb3MA==
X-Authority-Analysis: v=2.4 cv=cK11IVeN c=1 sm=1 tr=0 ts=6ab54111 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=or-B4SToQ6AIma83kDAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: j0S_8hhmANLrGAYDnbYgs2JIkdmVc7ZH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX1oBsZnH4OUKe
 /pkn7/JZFf/zZqJdpKTVzEvBA2FMHsc+5JemACT9Us1P6StWdRsUeeqUOicFBwo73pKG86iUjdt
 v5t9s2Kh6SJq5GOEsjp/eJq0uM3SKpg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
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

Move arm_set_cpu_power_state() from the header to arm-powerctl.c,
keeping the power-state helper with the other power-control code.
Restrict the call in arm_cpu_reset_hold() to system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260923171116.31276-7-philmd@oss.qualcomm.com>
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


