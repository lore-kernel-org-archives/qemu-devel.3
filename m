Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D28C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcB6-0006Uh-86; Sun, 16 Aug 2026 10:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcB5-0006Jf-2K
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:49:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcB2-0001He-Gf
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:49:34 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkmJk3226335
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5IiCecDbbvfrsNYqbdW15H4G8X7FiNxVC2HhAQiQbN8=; b=mQm0mp7CJoOINkpB
 pH9Iu8SDw77NA5lk9jXlKOwGAwtw8hfK8F+XzUxq3q7BXagezbKCJmO+mk2a1SuQ
 76i/IG7NqOF/u6X71PfcjOuSSeHax5CmZkFJisrUB3hj5O3KUtsP3HWXZHsxc9m1
 LydM88OFTTVZzaiDYodvS7CCXMaHPE44I9LDC3WoP+exsSs4hrrFMU5ShjDkwLPw
 CFKLY8pjVjfFt1qEQPTJjPW6qyaOsTgiMRf921C0c9Joi6R7hxLhEqgb1gw2U9tI
 W8efj1in3NviYWcdCnoOZv5ydvuzt03h535+Jo6jiEQW/Y7SOYDml9DuA5cqSdzN
 as5zig==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g322q99ab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:49:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52d7b3b6aa2so26920621cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891770; x=1787496570; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5IiCecDbbvfrsNYqbdW15H4G8X7FiNxVC2HhAQiQbN8=;
 b=Wyr8guJq15fUhCSwuNIURsmB2/dWtbjGhnlDzqrvunjF5J4p1A7m8epiCPcml18Bmr
 iWXKRdXmvIMcRTspBs3hGMByUrpppX92+IEffCcNq+YUvnvSB57fEAFD6LCwzItb4eMB
 XFnHx13whwtGVG9rwWDOp+n1r+Q0uC9fkXdKXFUCts7twYICVr6AP+6uzSbn2HXz3bZR
 wI0LiP1WiGWWGXS05H9xDiyLrCDRVO0eUbxmltrM0d+VXPILC6zk7F8riCCmJavmyYCq
 MC3qjY4a2n1uiZzy86a4XC5JqOny4fv8/lmN3JfNKZjrmldzJm0v3OnedH3PEofYPc5m
 K5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891770; x=1787496570;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5IiCecDbbvfrsNYqbdW15H4G8X7FiNxVC2HhAQiQbN8=;
 b=f24uW9SYh7q8E0eXc4xhUzrqt3CU1ADhTBKWhJziUJ9Lk6YOyL6BlnR0rKHK/jpHyU
 Pziv94QeTWIuH7VrB+c9wsdyEIrY1x6s9y/ARJAEDU94WWvzMjyKNtMX5V4lh5QIDU+Q
 y7IiZKT+jk3+DsWZZQKRSIUyPgs11FZtV6/cF7f3oK2jlI+JYSYfzwQ8KtxPCLzzFujG
 r+R2lIdo+nZM5a5vqcVlU2/rprSrJiUIBpGhe0tkSt85CRVoRhrPjuezXZ+mx46rrwHg
 9a6+46X8nXUQ1yrItYNFwr/kgbA9/X7pr4NC0H3DU2eLp8KbBpy/gpeke2fo/xMKVZBh
 PRQg==
X-Gm-Message-State: AOJu0YyoGW2BZp/OO5icG137Yeupo70US/cN7r3Jp2roxF3ryGUZA3KN
 vsEwIJ1SoOvKuCb5EipK5nBJL7MNdO9ZlWtF8mLe27ORH2R0z12cd40SpOJvoBC+elZeRMM1BhF
 dQ+g7P5xfDjAdVehPq/oA12yiy4/qeHAZQ4/IiEWYDE/EabjicoMAxAJGmm1WlMlWMg==
X-Gm-Gg: AR+sD13E38+pDehk+jT7qH3z47anwX2pdwhUZY0LNjNfneE1xGuUpgQqVt+vgisTTLi
 O9PPU3eKSnX6H799SgoTvoZ635FBJAEg+OGTl6u2OSVtiKGxUhOo0ewXSxBHG+nJEunZUCuRpFr
 093q8wCCq3DF6xy/zTvZPHAiDspYIpjbSeHGhDl2a9PzzQhsCoYdDMwDO6wZx7V2t9CEMvV1vOy
 CZK6AkVyJ0c0xKWQp1bA+uzgDoywc4k/b7q9LJyArvpaq6XTKi4EBIYsUaJWUHDD9Sq153GHfNJ
 PEVDcvHvO7cSe993PHKXvjG1f3u2Zt8uN86eXYg+wh2aMigvGB8NFVRnnhq56Jlxd5nx6PQ9v1G
 GHJErF59TBuYb1Vl8Fp9h4EbZI/u+Lyeoo1e1vw+UgQ==
X-Received: by 2002:a05:622a:5143:b0:51c:2633:9ddd with SMTP id
 d75a77b69052e-52d85583de7mr226925681cf.41.1786891769746; 
 Sun, 16 Aug 2026 07:49:29 -0700 (PDT)
X-Received: by 2002:a05:622a:5143:b0:51c:2633:9ddd with SMTP id
 d75a77b69052e-52d85583de7mr226925301cf.41.1786891769085; 
 Sun, 16 Aug 2026 07:49:29 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2c1307sm25375501f8f.27.2026.08.16.07.49.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:49:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/56] hw/cpu: Rename cpu_exec_realizefn() ->
 cpu_common_realize()
Date: Sun, 16 Aug 2026 16:45:24 +0200
Message-ID: <20260816144556.69009-26-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX/uGaUNiNftpt
 5pyYgf44NwI59EM258+7c8yEj+F07h/J3h0IL0/n6GrqQzVV9UZxJOpfDhthmR0lzvvTdY2nhuk
 HqXhznd244mKdJrjhG/k6e5NMxMPgfM=
X-Proofpoint-GUID: KFku-wx15G0SshgyJNnQ7oc4odd7omy4
X-Authority-Analysis: v=2.4 cv=C5PZDwP+ c=1 sm=1 tr=0 ts=6a81cdfb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=V_ZmIUVNQuF7PYEw5wMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX67BGv8fEf6CV
 khHY8NtI54MBOKt1duW8fHTmpwSKuU7cOrcSAHVLO54sjlx/WcMiOcWnxSXKhT2u+4wE0kR1j2E
 eKjlE1i21aTLkKk2E/RT3IHu8NMwSoMXCEREKfNqFIZjqTWwhqr/YBLXZnUVb2VkEui5zVagZSj
 wOuUZByG585FOpk6QTHRaBSkhN5yPv6Qz3HtlYWfzqxS2ZLf4yq3zavZ0bcdG8XZG2m/fJDD/1w
 wwOu0ta7MLQbkYgFLX4nj+s7D6yjP4CqzPLQjJRIit3wtcoLwYH/otP3z1qF5FfjhTMcG3/Oh9k
 7FLi6IDs17WWszDXznM+4FFzUPWgtACbpS/nGmVT96UnLR7Y28r3k34lhm/UsRu4Ae3t2YS4sHI
 xWqqZNAHBz/Bs9qsWXRJHpQhQjrJT49Mjf6SfCztsvWGgZlPJP2/G+kmMPgWWK0dLZxYPvTL2ok
 lAerzk8DY4JGyiGaYJw==
X-Proofpoint-ORIG-GUID: KFku-wx15G0SshgyJNnQ7oc4odd7omy4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Keep cpu_common_*() pattern for publicly exposed common methods
used by target code. Use cpu_exec_*() pattern for internal ones,
mostly to distinct between system / user mode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260811183410.22428-6-philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h      |  3 ++-
 hw/core/cpu-common.c       |  2 +-
 target/alpha/cpu.c         |  2 +-
 target/arm/cpu.c           |  2 +-
 target/avr/cpu.c           |  2 +-
 target/hexagon/cpu.c       |  2 +-
 target/hppa/cpu.c          |  2 +-
 target/i386/cpu.c          | 10 +++++-----
 target/i386/kvm/kvm-cpu.c  |  2 +-
 target/loongarch/cpu.c     |  2 +-
 target/m68k/cpu.c          |  2 +-
 target/microblaze/cpu.c    |  2 +-
 target/mips/cpu.c          |  2 +-
 target/or1k/cpu.c          |  2 +-
 target/ppc/cpu_init.c      |  2 +-
 target/riscv/cpu.c         |  2 +-
 target/riscv/kvm/kvm-cpu.c |  2 +-
 target/riscv/tcg/tcg-cpu.c |  2 +-
 target/rx/cpu.c            |  2 +-
 target/s390x/cpu.c         |  2 +-
 target/sh4/cpu.c           |  2 +-
 target/sparc/cpu.c         |  2 +-
 target/tricore/cpu.c       |  2 +-
 target/xtensa/cpu.c        |  2 +-
 24 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 6490fb070f2..7b7cf330cde 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1178,7 +1178,8 @@ G_NORETURN void cpu_abort(CPUState *cpu, const char *fmt, ...)
  */
 void qemu_process_cpu_events(CPUState *cpu);
 
-bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
+/** cpu_common_realize: CPU DeviceRealize common handler */
+bool cpu_common_realize(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 void cpu_exec_reset_hold(CPUState *cpu);
 
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 33e349d4402..732e32fade2 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -230,7 +230,7 @@ const char *parse_cpu_option(const char *cpu_option)
     return cpu_type;
 }
 
-bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
+bool cpu_common_realize(CPUState *cpu, Error **errp)
 {
     if (!accel_cpu_common_realize(cpu, errp)) {
         return false;
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 0c35067b202..12e86021663 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -117,7 +117,7 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
     cs->tcg_cflags |= CF_PCREL;
 #endif
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 787e4dc7ab2..77aa78f00e2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1891,7 +1891,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 35912192126..f8409f32ab9 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -131,7 +131,7 @@ static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
     AVRCPUClass *mcc = AVR_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 0ddd898e6e9..7067e5b70f7 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -457,7 +457,7 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
     HexagonCPUClass *mcc = HEXAGON_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index a68152f9682..07b49e51326 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -181,7 +181,7 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
     HPPACPUClass *acc = HPPA_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7a2c3cf358d..e5ffb10d156 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10164,7 +10164,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * These may be set by the accel-specific code,
      * and the results are subsequently checked / assumed in this function.
      */
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
@@ -10179,7 +10179,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     if (cpu->guest_phys_bits == -1) {
         /*
          * If it was not set by the user, or by the accelerator via
-         * cpu_exec_realizefn, clear.
+         * cpu_common_realize, clear.
          */
         cpu->guest_phys_bits = 0;
     }
@@ -10188,7 +10188,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         /*
          * The default is the same as KVM's. Note that this check
          * needs to happen after the evenual setting of ucode_rev in
-         * accel-specific code in cpu_exec_realizefn.
+         * accel-specific code in cpu_common_realize.
          */
         if (IS_AMD_CPU(env)) {
             cpu->ucode_rev = 0x01000065;
@@ -10201,7 +10201,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * mwait extended info: needed for Core compatibility
      * We always wake on interrupt even if host does not have the capability.
      *
-     * requires the accel-specific code in cpu_exec_realizefn to
+     * requires the accel-specific code in cpu_common_realize to
      * have already acquired the CPUID data into cpu->mwait.
      */
     cpu->mwait.ecx |= CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
@@ -10230,7 +10230,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * Note that this code assumes features expansion has already been done
      * (as it checks for CPUID_EXT2_LM), and also assumes that potential
      * phys_bits adjustments to match the host have been already done in
-     * accel-specific code in cpu_exec_realizefn.
+     * accel-specific code in cpu_common_realize.
      */
     if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
         if (cpu->phys_bits && cpu->phys_bits < 32) {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index e164cef2036..da8d77ade06 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -57,7 +57,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      *
      * x86_cpu_realizefn():
      *   x86_cpu_expand_features()
-     *   cpu_exec_realizefn():
+     *   cpu_common_realize():
      *      accel_cpu_common_realize()
      *        kvm_cpu_realizefn()
      *          host_cpu_realizefn()
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index fb03424ffa8..cb07f15110f 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -704,7 +704,7 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
     LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9ad3057d91c..ce2707dee5a 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -389,7 +389,7 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
 
     register_m68k_insns(&cpu->env);
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index a97c92a7b68..389a5124b12 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -251,7 +251,7 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
     int i = 0;
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index d72044aef61..669c7d99bb7 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -544,7 +544,7 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     }
     mips_cp0_period_set(cpu);
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
index ea29b2e01fa..66c00c0930c 100644
--- a/target/or1k/cpu.c
+++ b/target/or1k/cpu.c
@@ -170,7 +170,7 @@ static void openrisc_cpu_realizefn(DeviceState *dev, Error **errp)
     OpenRISCCPUClass *occ = OPENRISC_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index f404c7e549d..b07e9c3ff9c 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6921,7 +6921,7 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5a82e6563bf..23b5023dd37 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1226,7 +1226,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 495cb42dc89..97069bf597a 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -2006,7 +2006,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
  * We'll get here via the following path:
  *
  * riscv_cpu_realize()
- *   -> cpu_exec_realizefn()
+ *   -> cpu_common_realize()
  *      -> kvm_cpu_realize() (via accel_cpu_common_realize())
  */
 static bool kvm_cpu_realize(CPUState *cs, Error **errp)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 4af5cd9c731..9e3cc87f8a3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1304,7 +1304,7 @@ static void riscv_cpu_set_profile(RISCVCPU *cpu,
  * We'll get here via the following path:
  *
  * riscv_cpu_realize()
- *   -> cpu_exec_realizefn()
+ *   -> cpu_common_realize()
  *      -> tcg_cpu_realize() (via accel_cpu_common_realize())
  */
 static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 20b188c24cd..9b8473d71cf 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -147,7 +147,7 @@ static void rx_cpu_realize(DeviceState *dev, Error **errp)
     RXCPUClass *rcc = RX_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index c074e12ba2d..641ea96c8ea 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -249,7 +249,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
-    cpu_exec_realizefn(cs, &err);
+    cpu_common_realize(cs, &err);
     if (err != NULL) {
         goto out;
     }
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 763424695c6..ad2ec28c1b7 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -250,7 +250,7 @@ static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
     SuperHCPUClass *scc = SUPERH_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 13ebb122a38..1bc14b586bb 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -892,7 +892,7 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     /* Default NaN value: sign bit clear, all frac bits set */
     set_float_default_nan_pattern(0b01111111, &env->fp_status);
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 472c24ae32d..96e2817dee7 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -99,7 +99,7 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
     CPUTriCoreState *env = &cpu->env;
     Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 2015a4e3d0d..7c25b9ab707 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -257,7 +257,7 @@ static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
     xtensa_irq_init(&XTENSA_CPU(dev)->env);
 #endif
 
-    cpu_exec_realizefn(cs, &local_err);
+    cpu_common_realize(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         return;
-- 
2.53.0


