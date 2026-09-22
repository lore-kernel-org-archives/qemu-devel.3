Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E58AC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93jY-0005v9-P8; Tue, 22 Sep 2026 12:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93hn-0004N4-7j
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:50:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93hi-0002Vn-Ml
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:50:54 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEjI29449492
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VWAPWAp+zhiL5Viz57fv4ZOSFOIrqkMoe1JjS/wZSI4=; b=P2WOBmfCgtkoa4gk
 AqiUrXvrD0z9QPbOpyMdMlGZeeEp2kGxb9Ey0Nt7/KIUc+RuohOgqlidnx59f92Y
 bc09Mgc2ggtTXy7Lhz8XYH4+/1MexSuoltYYzFZGLmET02X5i4Vkn3M/nK50MORs
 wluMJN/e0+/290Y7Fj8Eu8pow0LqfKmfBHaq2NuN0AZ0ZMDP2JcWVSkv/tYIEPW5
 Q6OpTjdyKb/xFyQJI/muGdsLr16hCBmcW4HK9/kT+0jb2iYULX1YfwN1P835Z0kg
 D7zK2HOE5g88tMYLz427Nt+U4qxrpA/baVWUSGoHYx7f62PaxHHcbf0scYBGx79z
 TrQa/Q==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gunjytfmf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:50:39 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c8487ce333so79173e0c.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790095839; x=1790700639; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VWAPWAp+zhiL5Viz57fv4ZOSFOIrqkMoe1JjS/wZSI4=;
 b=QUaUBKBWifXgJ890RNU0RB3odaB9HrfQvFwv2OvvGn9ghY6yyTbcxjEN7kGOxCjPaq
 6ixyTQBkfUr7gzE4Ruywyllbzl44PRgTt/2tqTuQOHc52+/gr9cmm1NK67ML7lKuMWig
 gXj4pnKAnCoWXV02XA42/MVPRyf9xc+1/ElBTc3cw91Te5zLFBUonKJW2+/Q8lAj2u18
 FoSlAXHkvkLyABHKP8uuErULCVjWbjOmgTWz8rdFWOjo5Eb0dXVoBRg2dtCoUWwVq3Z0
 jwljf9u7QsjP2pXb4Urcx5tmN5COg63pG35ws8SFOrfMLm9ymAD7G54UnFK5mMqOJsta
 e7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790095839; x=1790700639;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VWAPWAp+zhiL5Viz57fv4ZOSFOIrqkMoe1JjS/wZSI4=;
 b=qFWL2RwFUB6+ivjLJ1ZifUPp5/nObKzdquD5kckehqr6rPyWFddqDSPWlwkgxL9jD+
 hCS4Ac+50yqpjKqGBPPNZtiwkRuAtxlVc0kdAuudQwDdD2pbMRUaIytvsuDok5FHigio
 Fycx8nDQXSwZXyQFJDh1PpjrZOOdLGgvGJoPvFYFkyZIFSAVOUXpBjgKHk/5dfwx2a6S
 aFxdjaTRXpReOmznrPy03OM8hoobKRIrpjmV78qECX+MW5serZJgyd4uHjw0GrH7LuOD
 hdq1a6tRHAOujbDhrtlQYa0opsTWTRsO8XcJlkgEKxsdYhnlt6MhKOHxMGpdm+B1N39+
 uPsg==
X-Gm-Message-State: AFuF++nH2CDOXqvkWpFrGKk4ckakgDNJbOgKnv8m0QKPruK/Slo7yTaV
 9TbUBrRp+re8T6CqCESsEQM6ikIM+LdgCR79w1/m5a8X2GQ3ZeUKxXUNdQrWY1IULxKqztVMnoq
 WlmiLo/cvbe16L/VbNtRyxS51GOZ812sogojsykAJVXstjLKb9Ts3cYhterpjvGClPA==
X-Gm-Gg: AYBFou0YkA2YitKvfQdapp8KeINhosHMvqTIF7usolLpNvmFzEe3qLtoHq0tyJzFfbJ
 8GFalYJF/rBM/TXLSW9HaEf7dJuV/KVeuSzsfdpJLkNpYtfZz38LQ64zPCf3smHQHaLcBkoXn5y
 quAXCh4St0lGUEUp7+puoCn3AY0dCnjDzzak4gz+czrLm8FEejNsM5jaA36+c+n2hE1d7nvnWgb
 s1uUgdz/VdDDJv+7CEcbVcrKQS7r+4jAekvXF46kOHrDE6c37nYJFpERuIlRbZFokfqKsR2s28E
 my0ismgObCiodhUmuxVDl3yr0IT5jRQQIJW8l5VFKAzn69sJSw9EqesaKV4DOxN3X+0pL/nItnJ
 IwcsMiRD0WK5/ZQ0mWqKNPel0SQ75TI5Vek6gbauq
X-Received: by 2002:a05:6122:1d08:b0:5bf:b3a0:388c with SMTP id
 71dfb90a1353d-5c9f15a1910mr164133e0c.6.1790095838954; 
 Tue, 22 Sep 2026 09:50:38 -0700 (PDT)
X-Received: by 2002:a05:6122:1d08:b0:5bf:b3a0:388c with SMTP id
 71dfb90a1353d-5c9f15a1910mr164091e0c.6.1790095838531; 
 Tue, 22 Sep 2026 09:50:38 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488627314d2sm6503348f8f.2.2026.09.22.09.50.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Sep 2026 09:50:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org
Subject: [PATCH v2 08/17] target/arm: Access PSCI state atomically
Date: Tue, 22 Sep 2026 18:49:26 +0200
Message-ID: <20260922164936.15189-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922164936.15189-1-philmd@oss.qualcomm.com>
References: <20260922164936.15189-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UW40keXrv0I7c6X4uwPHJR7qffNRmRBZ
X-Authority-Analysis: v=2.4 cv=KqHYSmWN c=1 sm=1 tr=0 ts=6ab2b1df cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=MMc1H2EL_fK9NYWBrJgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX+E7PMseWwDer
 e0Ulj03rHWgAw1+lJPKXRace1vsMyeIV6ERAtd5p7/xEXpZW6Z7v4QC5WrlRWmFZ3HJQjLpmkFw
 eZQ1bAf6by+caWJcdtMWx0dAceC0vve9Z201edTDgv1DXg68H663eWAPdex5YIE/Gd63ZWEzmmU
 92m0p6Ki/Zin4oy+st8dLs199DoDmKUhkLUmun8kTas2ywbgeuRfmy5p/aTi321VuuqisKsw2Gd
 8SpA3smrArR7qKiXaELjHuEH7rN33AvIW3TWIcHTUBRUpW54geQToc6uQnjjRB6uX1bPUy1K5NC
 impzSfD3VJCN4f9qd4V7e6IO3b44VMGZ/7H7BZzF6CUKtLppLcjrKk7x1w3XqPU+DEdp3UK+cdr
 NaOLTp9B8MnhQCaqv0OSYxXyGUVWgYOvrQ23Bs0lojzEZelOxEfoZls1dm1OXWvUIPk5ngoYQUh
 C3VFsYOQ/j6wyTT8X/g==
X-Proofpoint-ORIG-GUID: UW40keXrv0I7c6X4uwPHJR7qffNRmRBZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX2YdQ4GeU+u3H
 zVPrxEmm58nrKni+Ux1kydV/q53re083zk+6pTz2UCeC+FKdQrYBwHVvcCZpp0aicSygO1V+96G
 /qHCm75jT2G3rx/qTENqFp6CC5oIKIE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
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

Use qatomic_set() when updating ARMCPU::power_state and
CPUARMState::halt_reason. Read ARMCPU::power_state atomically in
arm_cpu_has_work(), which can run without the BQL held.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/arm-powerctl.c | 5 +++--
 target/arm/cpu.c          | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 1bd8a549cc9..fcac26d9190 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -50,8 +50,9 @@ void arm_set_cpu_power_state(ARMCPU *cpu, ARMPSCIState state)
     CPUARMState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
 
-    cpu->power_state = state;
-    env->halt_reason = state == PSCI_OFF ? HALT_PSCI : NOT_HALTED;
+    qatomic_set(&cpu->power_state, state);
+    qatomic_set(&env->halt_reason, state == PSCI_OFF ? HALT_PSCI
+                                                     : NOT_HALTED);
 
     if (!qemu_cpu_is_self(cs)) {
         qemu_cpu_kick(cs);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 76aa47ac503..5cfd3bcfc8e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -149,7 +149,7 @@ static bool arm_cpu_has_work(CPUState *cs)
      * Only another PSCI call can wake the CPU up in which case the
      * power_state would be set by arm_set_cpu_on_and_reset_async_work()
      */
-    if (cpu->power_state == PSCI_OFF) {
+    if (qatomic_read(&cpu->power_state) == PSCI_OFF) {
         g_assert(cpu->env.halt_reason == HALT_PSCI);
         return false;
     }
-- 
2.53.0


