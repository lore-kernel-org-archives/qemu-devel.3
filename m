Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1449C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24uN-0004uk-Js; Thu, 03 Sep 2026 06:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24uM-0004pK-3v
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:43:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24uK-0006vD-GX
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:43:01 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHMku3852435
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Dr+UHkFO0LKPym6+nEOMInKURmEN//Y7+d3LTmdX+hk=; b=Pr6rF7ARSQXyuj1X
 wfqUKqB7VWdCztKy7c6JLdTLC3CIne3FqdHG8F/0xmkX+KnS0iNdAZozK9Cdm80L
 SYcwPvkxnekNDMYXHxge7OZtZp6HQa//YfGWB9S2Cj/5cNGSgSiZK5uIg+Fzdnto
 vmFX86GCtWjtWyqh0lMUoQfIzf994tAXvVc2IEm8QzA4j+IU52dyXFr2PTW8IhwD
 jo5OqPWJ6gFzUZuNbnMmLdBoT7HoRPx26eI4CiJoEUA0KhrsmMpvG5Uc6W7mWv6+
 +bqiqG1PbSAuPil+DIFP/3wuwZ2g/kh1jkcb1M83vu1FMqDhMkvo5XGzp5F6qOiX
 8y4x2Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf51m0nda-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:42:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e82060977so154162385a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432178; x=1789036978; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dr+UHkFO0LKPym6+nEOMInKURmEN//Y7+d3LTmdX+hk=;
 b=JEvvkfbs7AXcgdUCXnfWTJiL5FlD0X8ZXYTj245viIlVd/XiRHe1ys+mbXkzUiQetf
 yDmlRO8rQpbaHK2EKi+pkryeuMJPfJ24PJAvGi7d5+NlKlPjX4unyg9EcX3ExUpTRsdX
 kH8cwn2rhz78DuunkP8MqjIftLgaX8adYOy8BKlOug6t0IdEluwD2z8yEJyyAEBW0442
 e3xku4jWK4TdYpF35NuBzSzta0lTaj3SlIAkPOhcpuy5+PtEfLNXGb6RY5CcVT1Fsh+8
 cv/c8vMIEExDZ/wlqDT0kWdESH4zgAkER6QXOO2HEGGzm9U47t2Pa9MvXlii26o7WTpo
 QXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432178; x=1789036978;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dr+UHkFO0LKPym6+nEOMInKURmEN//Y7+d3LTmdX+hk=;
 b=StWdQJyzgJ+NRSi/4Nh1Eiu2djfkt//dnqeS1pV7+VOfMYrST8tci62RbXIQGTuQKk
 v28zIDklF4WvJpklo/urgYo67TnZVSZX/zkPFNu0xpKsa4Ikyl634FA/K0/KP7A95YcM
 EpYp+I+ozX3KGjjjrh2mzx3rKjfDSRcTmjwiDpvZU+e1QTOQT1vng01WFC5Dy5Rr4Vp8
 JtVK+80X2jFokO22RKuzrkSQMBemdRNeCqy05V67iDx8QqcYuiInxMmh2YUbVLxfbESL
 IGcZe8snfMUJyXqPS59Awg0TwiZ6hw8n6edgqt8akyokek0ZOGF3neSdZOj9H1orzsgO
 FL/g==
X-Gm-Message-State: AFuF++n7cRbuFFschJ8/mNe1VRoc3eOMHPOZj5GHY9m99Sk2jNORT0Rm
 B+snO5BupmkdiY8AeLlw6Gz8xvJjWippjj4ePIpPpDQIAm/sXEZMvxwd76zOkbYsqvS3iwbf7Iy
 jarX9MKm8mLgwCZbsDoMp2esahhZA2spoaGMwSyjIcio9otffQccG1qYLb3Ty9dhiag==
X-Gm-Gg: AYBFou2nCvKzpF0PBFoDqNh0ZzwTE0WJ8XWxVtBg0df75ZeFtPHYwlyuNXxM5fo7u2Q
 vtl+wfKkaaQu2m6ZQahnLlGk4U56ftBA1zSyW9njLRElbjUpsRlbPBn82w3UHNO07+Ws2P9vO/9
 b1aOI46UbZ5xr29t3XSzYqSfUfMOS54NzUHUd/z2EPtESGycE0Zpfau+BNx4WybV26TCxyPYChs
 VqyoR0gBVdA3uoQbQ/ROJQeP85ojXUNyPt+q8Ka8SWgi+hxob+R8yyCRDum9cklgiEQ16Bk0w3p
 wXMMZyqdktxLZswmzui0TDEwSms6JrNqmv/D4kW571EFXqWKadDSmWcaijLuNn3Jou4XUqdlVD0
 jzWlOayyBWSY+5p9lI3eiFJE355we+bxmQFk94oXp
X-Received: by 2002:a05:620a:a90b:b0:939:319f:d6e3 with SMTP id
 af79cd13be357-9396deadfa0mr420166485a.5.1788432178149; 
 Thu, 03 Sep 2026 03:42:58 -0700 (PDT)
X-Received: by 2002:a05:620a:a90b:b0:939:319f:d6e3 with SMTP id
 af79cd13be357-9396deadfa0mr420164485a.5.1788432177675; 
 Thu, 03 Sep 2026 03:42:57 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e72d2asm12204806f8f.8.2026.09.03.03.42.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:42:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/51] target/i386: Constify CPU*State for cpu_*_interrupt()
 getters
Date: Thu,  3 Sep 2026 12:39:11 +0200
Message-ID: <20260903103936.62355-28-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CL7OrMrtGt8nm7BobhlYpr8b1XajkDFU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX5ego1L7XstQg
 I1NjV/NBSN0arXOTrZp1FnLnrl1Wgw+LQ5bbnjdkz3VgzxNQZ69oYuchuvM8sVQoBt0QK9K6dj3
 NPB5uttd8BmJ9GbpcpjxLj8zcfU/JOCFcwQmNCdO+H75buJAm+c2vUi7JnOyqDy9K7FnD+ceo0+
 nIEcK7aa2d8y6V4gge3D2HR5UBFak8P0m6YJ0HQGxVrowVDAV+iBDoCjzBm1/74anL9S/MrPSoE
 YOdj11DeTE8CCUOeNa9eoxr2r9CRhUEM3ZA+f8wNWa+eone2Blih68cbC5GYqOoj3UaPSM77CQH
 o9HA4QMTTeS866+LwbQPNPrM1sCKCLo56d9m1Lv2DwSdb9PtBKleDMxikNB+m/tXRN7AQZOD+xd
 dVLagEQ2SPsOzYpMBoOQrmhw6a9n0TMFwMQoxBY0ILnS4YWOOCzcG3wKfg+gOX5ZC4hqyWyy4rW
 Su3vphTJpPqRrkVo4Xg==
X-Authority-Analysis: v=2.4 cv=X8Ji7mTe c=1 sm=1 tr=0 ts=6a994f33 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=xq8iPuMcQuy4J_Iq5XIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX7H8Lzn2iSPQO
 fpt0jHbWEaUY0fFWwHwXpTJvAzV7fWcSqOn03AOThO80BxqzFzjFdzW9Uy1OYYDGNUvIDEXL+Su
 Z05sQJz0ZKivcj2lXPG+bSLmDUi7t5Y=
X-Proofpoint-ORIG-GUID: CL7OrMrtGt8nm7BobhlYpr8b1XajkDFU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

x86_cpu_pending_interrupt() and x86_cpu_interrupts_enabled()
only read CPU state without modification, add the const
qualifiers to CPUState and CPUX86State parameters.
Simplify directly using cpu_env() in x86_cpu_pending_interrupt.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260901095229.72018-10-philmd@oss.qualcomm.com>
---
 target/i386/cpu.h | 4 ++--
 target/i386/cpu.c | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index dc5047cfb25..9ce8ca00381 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2596,7 +2596,7 @@ void x86_cpu_gdb_init(CPUState *cs);
 int cpu_x86_support_mca_broadcast(CPUX86State *env);
 
 #ifndef CONFIG_USER_ONLY
-int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request);
+int x86_cpu_pending_interrupt(const CPUState *cs, int interrupt_request);
 
 bool x86_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
                                  TranslateForDebugResult *result);
@@ -3104,7 +3104,7 @@ static inline bool ctl_has_irq(CPUX86State *env)
     return (env->int_ctl & V_IRQ_MASK) && (int_prio >= tpr);
 }
 
-static inline bool x86_cpu_interrupts_enabled(CPUX86State *env)
+static inline bool x86_cpu_interrupts_enabled(const CPUX86State *env)
 {
     return ((env->eflags & IF_MASK) &&
             !(env->hflags & HF_INHIBIT_IRQ_MASK)) ||
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 84e805ee85e..d01ff1948e5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10601,10 +10601,9 @@ static vaddr x86_cpu_get_pc(CPUState *cs)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
+int x86_cpu_pending_interrupt(const CPUState *cs, int interrupt_request)
 {
-    X86CPU *cpu = X86_CPU(cs);
-    CPUX86State *env = &cpu->env;
+    const CPUX86State *env = cpu_env(cs);
 
     if (interrupt_request & CPU_INTERRUPT_POLL) {
         return CPU_INTERRUPT_POLL;
-- 
2.53.0


