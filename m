Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86ABC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05YR-0001HB-Ts; Fri, 28 Aug 2026 19:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YI-0000lu-R1
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:00:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YG-0005nM-Pj
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:00:02 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMU2DJ1174723
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yA+zVvYMYmI
 S11ecqLqZUKevDZAwtzLxDa57wEdeW2k=; b=HOM34zgjuwsgQQU6fpki2/JMors
 mKQugpxjqlWzhOPIPl5p5iG1fMaXcgW3NcvutQOlJwEsan+SosYbqP0On/nlZE+y
 b7stDrgYh1faB10YedBN02n36aBVjDz2fTTQkt4G/JKjHcZYX0cIYxH81tKB29n2
 3e790LVOiOUloY8oVM5l+kpRxjRS3I8Gug/Kvk9p5XU3ZWQMdyh9b9XNetFVaLoW
 VE4UV2nOfXMFBtEIG6oFwbKQgD0c3FLYvO9InIgCyJiK3tqrXPOMd6E0fs8tZMSG
 Qo3VXKuoAklUjS+a68Hl+Yg5Xr1eUNR7z+XDnDynuU0RFmrHa7NLh4xrU7w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb8afjk6s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:49 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-381250979d5so1941538a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957988; x=1788562788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yA+zVvYMYmIS11ecqLqZUKevDZAwtzLxDa57wEdeW2k=;
 b=XEd+I4kjC9ceIIuo9To9YBKAm4iDLCgSOX956Pbo3RIIsHeDmANTUQn8cshNtt5eir
 wKlGkB6AJyhIrl5wDH1N93WQJ0iB1MeiKVHcqKqQCiJCDTEtdZ3D7bYB87BVJSMeXUi/
 j7qwHMXVtB29rBNv90xIsijvP2OTyQLD9un78Thx/uHVz8gar0tmNihDNQSV6cd56bRT
 ud7PX4McPaq2vP+fxxyKD4v1fotFocaJZtz5amgSPIzTPywId1x3xjmuCZTTRLNmcIDL
 VCY4fgWWAmou5LuCdUkYEVK5fXPYP98LFqttP8Iwih/QJLJRPAQGahcpJ8f4bL95d1mk
 iIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957988; x=1788562788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yA+zVvYMYmIS11ecqLqZUKevDZAwtzLxDa57wEdeW2k=;
 b=XyNgDrth8xPkIVgThwbClvYdIB5I/nOx3pilzcCsANIRctEh7QHk0Iu14QWga02i5Z
 Q0qipCK0aIvOUeIj0ufP1Sq4FU/6OeQdCZud4LlmIZbtVayN58npvJ+1KIx9I5A+hD3d
 fQqrSbhP77Li8Q5jZikUP692yCYQbhcvbp2nkNu4itEVjyFBLfZcrfvq3FpkGgcF8Ca9
 bwPOXWbfcD+tjEVbdQHzIfGcDoercT4B+auk6f8l2u0YaTqNu65ikopeYUKCSuSGXRP1
 ZAhV1MUAgmDQkNswPP6Ks8kC3OkmsNYd+7q3NYjGhk+FQ2mVJ21n4B9WDL4nFmRriIrg
 ChEw==
X-Gm-Message-State: AFuF++mYuqqbgNqVwiIiUPaYzW8EHhkrXriA4OGwd7FpYdUlYTvXW8iG
 9NKKLL5Go/Vfo/8fTJQK+iQVqmjzxFEvmwHusyo/IUULjkOuFBRRfRACROlD1pHoXUENuFGw9KZ
 Y70DANbDDlloEKp5nnoTWKsrSj+l2o1u1t6C1RkYKkGKXDVgN5b0dndYnaRsImEjRSQ==
X-Gm-Gg: AYBFou1ToSs5sNT2pGg/ZRhyWkg1Tm0eAdNFCUv3F511ZjevM3PCXr4tphFRpzlR7+i
 xNgs0azBygo1JuG50K0LXt0Ys1uT5k2rtB4BmqpQFsXpWPW01GvtfIhmdDqotUKBiianVaj1NTg
 BA4r64lHoRGPwTsxgUq4+J9bioEEgtKWdrCltC8vp1WKyRMV2iwApIGtLPhW7xO1p8Ir3+Y8+HQ
 e8FCmyZQBVwn8hiYtiNiQv/RU0ufg5CNyaKzKQNxeeyDwHRcA3zrgpvMN+TlMX2rRxb/S9LXjHy
 GHHw5aEy3oKakaSpE2FBIbrw2DTPfHZl1IzNtwRaGF62grM3FkBFc0Z+VFRnS34AAH1tCuC5pxN
 P0zbcMaaVsz5Q3BteyRRjJGnOvdkHMZMn7nA0NsFpujnX81pgm8I+upw7fSs=
X-Received: by 2002:a17:90b:4ac4:b0:37f:e1b6:4c7d with SMTP id
 98e67ed59e1d1-396d0e20f0bmr16299434a91.6.1787957988501; 
 Fri, 28 Aug 2026 15:59:48 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac4:b0:37f:e1b6:4c7d with SMTP id
 98e67ed59e1d1-396d0e20f0bmr16299381a91.6.1787957988041; 
 Fri, 28 Aug 2026 15:59:48 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 32/47] target/arm: filter cpus from target
Date: Fri, 28 Aug 2026 22:58:46 +0000
Message-ID: <20260828225901.367438-33-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AERzoXZs8Y2FYj-Q_ZUQViOA6Xq2hUvQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX+Aj5W4ueJrz7
 aHQ7F7GUwqlEdILntno+sAxng+XtaADVVQ9NxguU94LZXMmj8PDo4eAnkBImFLYU0wXFyAfhb+p
 ru1G8qAFzLcpxDNmhtcQdjKR2F20H2I=
X-Authority-Analysis: v=2.4 cv=IPoyzAvG c=1 sm=1 tr=0 ts=6a9212e5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=j3gmtOcTUOW2rAdhTjEA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXx+46sOrgk/ep
 iPa256cucLbjD+s+aE+PtZHQP7su9ShqhfE3sjI1xihg63N/qMrM9ct4fiMvOxBLs8VrfMDkWSd
 0BjpJoi0sYhf7RMS2XsV0Ltyq82HikUTT6dao2H2UWQ55p8aikc6vXkhO3CVagD1drkkZQ8E7Pj
 inIs1cKHys+PIReC0bcH9Id9Tqd2TBkKsnI5nx5fr70U5LAa/i1liTpEbMb1SihzuaNXtfLpDub
 SVFjw4YDw35mI8UEptUMIrKwnR3GxB8Bh9cZ7uPiBjLcGo0/C64s//ewY2fOFKIpaYlbUam6zXo
 Gn8/g90aDRjy+6psb2RP2e3zHZXuZgploDZjslW44VGzvLLdHkcOFIwcn2Hajyl5IwK8EVeIapx
 90ZOtsBIR2WupHU1dOYDN7nGaMKwSRgmqei4tkLCRrqAVJ27YFkdGSV1qDh0t0zdWqZnV2/IMtM
 Fkqe/+1XXRBCggIzMSw==
X-Proofpoint-ORIG-GUID: AERzoXZs8Y2FYj-Q_ZUQViOA6Xq2hUvQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

We add a new callback to arm_cpu_register, that will be used for
.is_available field in matching TypeInfo.

With this change, we now have filtered all cpus/machines/devices between
arm and aarch64 targets.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/cpu-max.c        | 2 +-
 target/arm/cpu.c            | 3 ++-
 target/arm/cpu64.c          | 2 +-
 target/arm/internals.h      | 2 +-
 target/arm/tcg/cpu-max-v8.c | 2 +-
 target/arm/tcg/cpu-v7m.c    | 2 +-
 target/arm/tcg/cpu32.c      | 2 +-
 target/arm/tcg/cpu64.c      | 2 +-
 8 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 739500a04fc..d55e711acec 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -127,7 +127,7 @@ static const ARMCPUInfo arm_max_cpu = {
 
 static void arm_max_cpu_register_types(void)
 {
-    arm_cpu_register(&arm_max_cpu);
+    arm_cpu_register(&arm_max_cpu, target_base_arm);
 }
 
 type_init(arm_max_cpu_register_types)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 77aa78f00e2..e062456526c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2670,13 +2670,14 @@ static void cpu_register_class_init(ObjectClass *oc, const void *data)
     }
 }
 
-void arm_cpu_register(const ARMCPUInfo *info)
+void arm_cpu_register(const ARMCPUInfo *info, bool (*is_available)(void))
 {
     TypeInfo type_info = {
         .parent = TYPE_ARM_CPU,
         .instance_init = arm_cpu_instance_init,
         .class_init = info->class_init ?: cpu_register_class_init,
         .class_data = info,
+        .is_available = is_available,
     };
 
     type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 4e8c4725308..e55275d9661 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -832,7 +832,7 @@ static void aarch64_cpu_register_types(void)
     size_t i;
 
     for (i = 0; i < ARRAY_SIZE(aarch64_cpus); ++i) {
-        arm_cpu_register(&aarch64_cpus[i]);
+        arm_cpu_register(&aarch64_cpus[i], target_aarch64);
     }
 }
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1775835ad50..cfe3544054e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -406,7 +406,7 @@ static inline int r14_bank_number(int mode)
     return (mode == ARM_CPU_MODE_HYP) ? BANK_USRSYS : bank_number(mode);
 }
 
-void arm_cpu_register(const ARMCPUInfo *info);
+void arm_cpu_register(const ARMCPUInfo *info, bool (*is_available)(void));
 
 void arm_do_plugin_vcpu_discon_cb(CPUState *cs, uint64_t from);
 void register_cp_regs_for_features(ARMCPU *cpu);
diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
index 65f851f2006..c6cbb90bb86 100644
--- a/target/arm/tcg/cpu-max-v8.c
+++ b/target/arm/tcg/cpu-max-v8.c
@@ -125,6 +125,6 @@ static void cpu_max_v8_register_type(void)
         { .name = "max-v8", .initfn = aarch32_max_v8_tcg_initfn },
         { .name = "max-v8", .initfn = aarch64_max_v8_tcg_initfn },
     };
-    arm_cpu_register(&max_v8[target_aarch64()]);
+    arm_cpu_register(&max_v8[target_aarch64()], target_base_arm);
 }
 type_init(cpu_max_v8_register_type)
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index dc249ce1f14..9ffd2becb66 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -297,7 +297,7 @@ static void arm_v7m_cpu_register_types(void)
     size_t i;
 
     for (i = 0; i < ARRAY_SIZE(arm_v7m_cpus); ++i) {
-        arm_cpu_register(&arm_v7m_cpus[i]);
+        arm_cpu_register(&arm_v7m_cpus[i], target_base_arm);
     }
 }
 
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 2d642ef8787..86560d8d254 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -748,7 +748,7 @@ static void arm_tcg_cpu_register_types(void)
     size_t i;
 
     for (i = 0; i < ARRAY_SIZE(arm_tcg_cpus); ++i) {
-        arm_cpu_register(&arm_tcg_cpus[i]);
+        arm_cpu_register(&arm_tcg_cpus[i], target_base_arm);
     }
 }
 
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 251c4b3cf60..20399d42ef3 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1548,7 +1548,7 @@ static void aarch64_cpu_register_types(void)
     size_t i;
 
     for (i = 0; i < ARRAY_SIZE(aarch64_cpus); ++i) {
-        arm_cpu_register(&aarch64_cpus[i]);
+        arm_cpu_register(&aarch64_cpus[i], target_aarch64);
     }
 }
 
-- 
2.43.0


