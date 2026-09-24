Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1A7C98321
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lL6-0003m2-JV; Thu, 24 Sep 2026 11:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lL1-0003Vf-Hq
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:26:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lKz-0000Xi-Na
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:26:19 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC4WoZ2749210
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LspDXWFA+IgaJM8a94tPA51Em6Z9mhnhpCi38nqINP0=; b=VPVtHmf71lWJvlnb
 FTQKXxMeA3yssgXGsSYwdxQeoZP+QVFC2sncpKUipXtNUGZq1G7EvA+r0p+5s5Xl
 RrAx54ALL90ZnOZAm2LcZG9p/+ZB6KoqJhuiwsods8NVfxZLZ8QOSSwdc9FU/d76
 fAfE53QAIyV969dr6SrBPvZT6ZvC/VTqqO8L2MU8yGKgOs2TAXPo5lCyxRa1MW4V
 He3vrG20t+ClWJL4RmYxvngyS1QTC2gfmYul4WfcIK8r1nvAlwiEJ0GqZFzdYlmm
 CPBDde9KWJwXdpNs4vSy6d1ygzIyFMlAsqS2DVd0ustKs6MKor+iNtIEFEd3Hjee
 KVTugA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1s919n0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:26:16 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-98304865f02so1773593241.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263576; x=1790868376; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LspDXWFA+IgaJM8a94tPA51Em6Z9mhnhpCi38nqINP0=;
 b=iA2yXx4EA15yUw/yOjU0AuiwEqYyrNr5NDDIxak14xUNmSy0CtmUm7YrEr2XpwC8vC
 oYEj2rPusXrgHkCik7k+/9UQVtbL/5Wme0hhow0KPOGbga2CasGtOm1lPX5mOLZoY+bG
 G/qWYC6pXmxPi6t/NswVQKWDQfhVm6Rtix2zZn9d+CP8xuL2vbIeGx1Q75OGGP+cJQYf
 oJrIfhldEFJjURVVw1FVxHplq+bRAimkII0JDgc1/jXuR+KlLTrO7Lv/Ub2n8XR84IPC
 YwxFftSot6UVz3p+OUCGvyfGykgfgMWwyxxCEJBSplxcfUFjoCkftr6l//7vWZWK8Lg7
 u0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263576; x=1790868376;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LspDXWFA+IgaJM8a94tPA51Em6Z9mhnhpCi38nqINP0=;
 b=dIqU9YnaNHRV6ZOjJPtfX22zjpcK3bPBgB/niykyvVVOuYIhW+C1YkRyzT9O4g6dLm
 SS33rTN+eFJ31ZABu8ePksSWp+vcFH7K/7clUSaNKgFq6vGvEMco9rNoNk27+B9zAkMi
 nenPP2yj9bgadXfNKm1hmJDY2EQnCxDMxf9C3h8DK4E50YFR2v21bvMoL5YUksj7gQzR
 J93+jx/30uh70zfZa2WoG5AsoaFTtUdUpgf8dEmIlX3mjG5LUmsc3vEZdibb6mlKLLe7
 G4aHeuTZMfRN+R9TwRFttjr4r6cKHjmd+6cLHdZIQqNicwJ2lSIKbPOb+L2AXi5j5AtT
 RFiw==
X-Gm-Message-State: AFuF++lKHBGLg/mv27jFG+vdhgzLUmaq/QKOTiWu/Q9VWp3mmGczpqC2
 cAdaKHRP4O1XRJY1o1zyM+EYKMQxdCXXawWEHJeEtoLsyhoeXzphcOvdayKfpUGHHkyELf3fJvI
 o+XtYFvZZ8obkMjm3+CU3iyyZjfYXk1ZrL6d+mmp9rGu4Lchv0ZAGFNuTM1MOaF/oSw==
X-Gm-Gg: AYBFou2g4MDrRQeXnEfIciYWiPcOguGSMIbIZAlPGt9YYNB1gjjUtDdWHDr27yLm/H4
 rEoL/lRuf3FoZIzWfHryi6SwEb/VG+hU/wW0z5+kkfmixD1ZudaJYg6AJwqfR1YWr3loa1Eo1Qg
 HypIntFA/QapMyAwjcly5IBW0DNs/G7FLiSfaLpLakrfg/4Kmwjo/MqYGiTWrAr0nvvSktsKSgE
 dzEkRpo9mANb/Hvy7KABRnk0Tzn6lzrlTh0BsrtoPWXJ/+JHuCIoCwDou7+rZMy8LEoNUBqvuCh
 7rWGqaD2yyF0aj5TdjTNr3eDCA+xysyrWR4aKgHWBZeOm+l0GCrv5yn5jaxu01eeRfPh5nL8Ikt
 tZnKmq/XeGDsZyN0uWq4zf/lvQdwGucErZjPrmqwu
X-Received: by 2002:a05:6102:3752:b0:79d:cfe4:7202 with SMTP id
 ada2fe7eead31-7af1cc9e29dmr1606381137.11.1790263575577; 
 Thu, 24 Sep 2026 08:26:15 -0700 (PDT)
X-Received: by 2002:a05:6102:3752:b0:79d:cfe4:7202 with SMTP id
 ada2fe7eead31-7af1cc9e29dmr1606355137.11.1790263574989; 
 Thu, 24 Sep 2026 08:26:14 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cbd77bsm89740685e9.8.2026.09.24.08.26.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:26:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/18] target/arm: Access PSCI state atomically
Date: Thu, 24 Sep 2026 17:23:50 +0200
Message-ID: <20260924152353.36209-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX4k0bvAVISP5v
 RWoeDVYo3RqOv0/vNGgajtdpWHZLTqMS02n0tzu2qHMt3FBMKCLpc2HRQta26esrMPb34Zem9+F
 95yE7y3TiSW2kbU/ydi0jM9dMiKcOl5eaoqXwuDxgj9DiZKejavdeUjvifI+wn8h4vyBLotesfO
 5NTThscbr1wcifakA62aoyVANhJJMG8X2phWrZS+Ea8XCe8+s65l0irxlYK6qn+tG01aVfIUjbX
 yRUHFLQnfrI+B6JmRZxY8e7DfxUHGWvQB3QZDB7xTG95zfy1bqE7SGq5xLiTV36UTBW2tocYk/P
 EEX+txg7fAwaatpmfZv9RGFlaUGDZHVPYbbJNcLAwRvTzWqqJKNUjUJbslQebURCKNKq8R/vZ9m
 YCDRPgg+TQtAcIjOMrVB1AiP5/bZ85gHr5Zb778Zxt3jhDqcYmkt9nNnxa+Xkq+PR/PUWYCDErn
 odrXUzgaAOe03voCp8w==
X-Authority-Analysis: v=2.4 cv=VPxIDNPX c=1 sm=1 tr=0 ts=6ab54118 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=MMc1H2EL_fK9NYWBrJgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX85/A5RBln+ge
 3lQNu0nSKpUkBgIzarp0RyHCE2AlmhQoEiEpPDlDGm04DGBgzmfzmpLoS46Oq5BASYu4abFjLxk
 29GDaIaOD8vk6HN681jCC7jpZE0QOSo=
X-Proofpoint-ORIG-GUID: FH3LFrkU0mOuedAVYb6_qAnTkH6BD5gb
X-Proofpoint-GUID: FH3LFrkU0mOuedAVYb6_qAnTkH6BD5gb
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

Use qatomic_set() when updating ARMCPU::power_state and
CPUARMState::halt_reason. Read ARMCPU::power_state atomically in
arm_cpu_has_work(), which can run without the BQL held.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260923171116.31276-9-philmd@oss.qualcomm.com>
---
 target/arm/arm-powerctl.c | 4 ++--
 target/arm/cpu.c          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 213e7ae056c..ef14a1f8a94 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -49,8 +49,8 @@ void arm_set_cpu_power_state(ARMCPU *cpu, ARMPSCIState state)
 {
     CPUARMState *env = &cpu->env;
 
-    cpu->power_state = state;
-    env->halt_reason = state == PSCI_OFF ? HALT_PSCI : NOT_HALTED;
+    qatomic_set(&cpu->power_state, state);
+    qatomic_set(&env->halt_reason, state == PSCI_OFF ? HALT_PSCI : NOT_HALTED);
 }
 
 static void arm_set_cpu_on_async_work(CPUState *target_cpu_state,
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


