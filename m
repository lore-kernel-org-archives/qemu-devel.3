Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A437C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QVs-0003g9-IH; Wed, 23 Sep 2026 13:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QVP-0003R6-5Y
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:11:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QVN-00011l-51
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:11:38 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGUHIL3106542
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4+Hm61vbLZRTj0yVKnQACRv0FSYIqQtRBRB3dZnU6TQ=; b=fFnbdV6A61S0S4UU
 VUQ2suoJRD9FzLf9dqjFghtiARh/C4l9OiqydsFIT6tmYRMOO0WotLQ8bKRcvIea
 Z7uumZhqGcWybBiR/UW9MCFDedeWJ19SfIb2+8aiV/Tgpqdh5SmZ7S18n502W7F1
 Qnsng+88oeTg4UaqQ1cFEI1t/fVO9xZA4MOgDwzY9kZFPua0SNNEYep1LuYB7j4W
 DvOOKCKNQK2HSERBS2wCzrVKZDICThOoQ/FUPcD7DJEo7pQ+JDGrVxRsGF+pvBee
 XKH0Cjihq+V5SbKNUQJ54JIbm4sjXX+G+Vv/FDDzNcOM+17EPCKCkT646FbJ10kG
 3qq5ZQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfmwh0te-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:11:34 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9806756ea40so949098241.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790183494; x=1790788294; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4+Hm61vbLZRTj0yVKnQACRv0FSYIqQtRBRB3dZnU6TQ=;
 b=UJqbWfNccvcW3XeUPHCU4hdQPd7/t68uJn9++e3IZWncJdU34iYbk5WAviREkCjZv4
 UBkJUG08wdBxwAxcGfb/iYm7cLnsJG7oralXK2SDYwrL/oMjlWc8qBoz+wgkbJ8jyQ58
 qUXdr4uXPtisfLKjgfdEgzr95QRvvig9cpfZxfGtC8ko8MeE7MgMGfUxIvQh+3sLxOCV
 nTR4EUU/+9YJsvNvf33bd9boF/3SaLjPypb5ipLm6sOfw/7R7My+biN3cDEcVv0gH7aP
 2i9mt0ucqvmeVSZH/bdyHC47k6r9A6xcvz4kqUzXv61YKlcbQdgkfcMe9R061YP4fWod
 p1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183494; x=1790788294;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4+Hm61vbLZRTj0yVKnQACRv0FSYIqQtRBRB3dZnU6TQ=;
 b=Gh6esTzKP4mK3C4zIKuwRIf65HfR0RyHqOQOkPGNX8j17ZO5WvKx86wHTCxLmPKV6s
 WweGagLIVCPQGCFj0ly2dN1Cq/0PKfNamnVWVtRS6nBeOD/uTyiOVUGLXXjdgoTvsUtI
 chxtbc90+FoP5qVvasczmw6w/tJdobzkShV4GDcu4sqbLW39yPwLm+2GmK/oHHvrIKME
 qcrXuWGN3iy08HMYKhed3h3auL1hzUZSmdXfuK92DKjQMBn0kOPNr3dS/7c+IPGuFx9L
 JG10Y8lU2vwsuLFQC3z8KcZDEXTM1BMQL1LNAVrBH/cT3rTEWpz4BYsbLCKnMjhjC9wd
 WhUw==
X-Gm-Message-State: AFuF++l1nRWI4cPI3cwnkNh9/R1Mn7XGykN0OQ1Rtll3kIPXgoahwx5M
 BwIKgg7dabfUP9n3Eha13hw/5eLi6xlinCtzhZkMjHF3LzBNtHNfjHf5bOokWituVYKzcBOolt1
 kqXp3j9LBLtE1hG/aqWgau6OQkmYfiWcJKiG6BpQ1szlcLTU4+19zIPWAh8EemSvDUSXF
X-Gm-Gg: AYBFou29JMaG/W6bvzFGAuHw/xBN1IEp6h59Fgm6m4B3ESxzTcfTi/hwoVk7Nw0x4Xa
 s8YoPw342rdHml2lPQKfDLBPN9FncjIZWKzOeMEHal5DZW7yEFa6icXbsuTXGFTX3eyOCSGuI6y
 7K61Anpijew4HbcSBhHF9g8QAnVfTFBruaTRLSTqXQWZugMQNPaDeTzDuKBQY4o32myzn/J1jCi
 dfFid965mRecrsyO332sBSesBbiy3stL/pdXVQsFdiqxAJBSixtQ9FFeesk5X8uUXjPku98pv1F
 Pg8iNQwkoAyAnpq4hFnVHT/Oh5vkBisR+B5TbfFFk8XFuyfICk9ZMZeFA23V/DxssbZkc48SDiY
 N7KIjA7nCbm9tqsSMEIYXgL/1SGTwZIsb4fpsrptx
X-Received: by 2002:a05:6102:4410:b0:7a7:19aa:8a86 with SMTP id
 ada2fe7eead31-7ac1d4db191mr3142895137.33.1790183493877; 
 Wed, 23 Sep 2026 10:11:33 -0700 (PDT)
X-Received: by 2002:a05:6102:4410:b0:7a7:19aa:8a86 with SMTP id
 ada2fe7eead31-7ac1d4db191mr3142874137.33.1790183493467; 
 Wed, 23 Sep 2026 10:11:33 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe0c3731fsm70878365e9.2.2026.09.23.10.11.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Sep 2026 10:11:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v3 02/21] target/s390x: Use s390_cpu_get_state() consistently
Date: Wed, 23 Sep 2026 19:10:56 +0200
Message-ID: <20260923171116.31276-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923171116.31276-1-philmd@oss.qualcomm.com>
References: <20260923171116.31276-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX6dM+SKsk0M8F
 CE/ROOFyqRFTM6JN77bvdNS9sYZGiDx3bOcTtjkiJTGsqoHRFiIMBaR1887LEZ36rtVconQdiIi
 Hc9wNfM9HQAxICAvtDp5HWKzpS6ytoILTUj0iMB//it8g8vnGEagp2MXlR9Z1MVTBdAVt6owqkI
 MjgFqphvMhq5K+m/GFOVP2x9DGq3tXNjKdL2FX2w1YKxIAH7YAKOHVYA4xcm2ZcpjT0MlgjlSIH
 wPnp4MCwry9yNH9LVlMR4PhaICNtdyv3v6+47C+kM7/cHqxVCiV33t/ZTgoxSyrcXpLvHIIemWB
 u5rnpkaY+0UQPsWByPX3q6o4CcDiW/5iQhatjhw2RJKAtOJsdccU6voYJuptb2pfkP4y0MWaaip
 EccyMoORSRUD9NdVIAW9hoE/yF6D/x3YKIu7MiJohsBRVyU0Snx/ZWxjSaWVM9xXFhv+oqFmrwe
 hL76fqgpXDEfavvfRaw==
X-Authority-Analysis: v=2.4 cv=WK/qzXsR c=1 sm=1 tr=0 ts=6ab40846 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=z94vmTcaOVfBjqTZL9kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX4nxTnX7pxoas
 QWY4FxYqiewzdr7oOeUmckdzm4AiWFMSU7Svdyb/Ut+VGaLxEQ2OpgJBQk0wM47sPxu6OXaZrIJ
 bcDUA5xy7p8f++ngRCHL6TQuX72V8a4=
X-Proofpoint-ORIG-GUID: 1Y3lBV47Mlz6lZzzvpdGM3f2GiIDd59M
X-Proofpoint-GUID: 1Y3lBV47Mlz6lZzzvpdGM3f2GiIDd59M
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

Replace direct reads of env::cpu_state with s390_cpu_get_state().
This keeps CPU state reads consistent across CPU transitions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
---
 target/s390x/cpu-system.c | 2 +-
 target/s390x/cpu.c        | 2 +-
 target/s390x/kvm/kvm.c    | 2 +-
 target/s390x/machine.c    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index cc9685221ae..c938c77d0bd 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -263,7 +263,7 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
                      cpu_state);
         exit(1);
     }
-    if (kvm_enabled() && cpu->env.cpu_state != cpu_state) {
+    if (kvm_enabled() && s390_cpu_get_state(cpu) != cpu_state) {
         kvm_s390_set_cpu_state(cpu, cpu_state);
     }
     cpu->env.cpu_state = cpu_state;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 7c725b8a4a4..85afc5dec9a 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -130,7 +130,7 @@ static void s390_query_cpu_fast(CPUState *cpu, CpuInfoFast *value)
 {
     S390CPU *s390_cpu = S390_CPU(cpu);
 
-    value->u.s390x.cpu_state = s390_cpu->env.cpu_state;
+    value->u.s390x.cpu_state = s390_cpu_get_state(s390_cpu);
 #if !defined(CONFIG_USER_ONLY)
     if (s390_has_topology()) {
         value->u.s390x.has_dedicated = true;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index b34a9127141..6622886032e 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -407,7 +407,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 {
     unsigned int max_cpus = MACHINE(qdev_get_machine())->smp.max_cpus;
     S390CPU *cpu = S390_CPU(cs);
-    kvm_s390_set_cpu_state(cpu, cpu->env.cpu_state);
+    kvm_s390_set_cpu_state(cpu, s390_cpu_get_state(cpu));
     cpu->irqstate = g_malloc0(VCPU_IRQ_BUF_SIZE(max_cpus));
     return 0;
 }
diff --git a/target/s390x/machine.c b/target/s390x/machine.c
index f714834a98a..b44fba43f14 100644
--- a/target/s390x/machine.c
+++ b/target/s390x/machine.c
@@ -32,7 +32,7 @@ static int cpu_post_load(void *opaque, int version_id)
      * than via cpu_synchronize_state, we need update kvm here.
      */
     if (kvm_enabled()) {
-        kvm_s390_set_cpu_state(cpu, cpu->env.cpu_state);
+        kvm_s390_set_cpu_state(cpu, s390_cpu_get_state(cpu));
         return kvm_s390_vcpu_interrupt_post_load(cpu);
     }
 
-- 
2.53.0


