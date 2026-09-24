Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F77C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lKw-00034O-CW; Thu, 24 Sep 2026 11:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lKY-0002Yf-N4
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:25:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lKX-0000VZ-0C
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:25:50 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC4hpr2594275
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 olFpzbrCioYQ8hyoLYIJ1a2ZDTPKs6gs8QpMhuGQnOA=; b=EprR/nThl/wlkeT4
 1IevEZMpEq1srImK85SmLY2gH7hPNLWAxn7caVN33FLDTUpjZ/oFNyRNjyA9pgNN
 drXfZ0ZVBv6CGb375AHgLk3Cxt3ttEXWvGOVfmOwFBlFbcp+ZxQxKfxoVnw3aCg2
 tDohlPXPuJKOpZ2tVrKe4rHW8W/7oZ8Mq/kt51bIqbOgV250Z++b8m7192RLCiol
 SlPA10dQSonakkaDRYbgzDpGDRZnc98uAzhu+8UPv1knM8HS3GSEPg4HdxLLlPOv
 kcS1YTyL3GRetxRBeCRqOU5LUxsU9EUOUryX/OCWetzbem/QnpFqV6br7BMU9hZU
 DNV0tQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1tjh8vx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:25:47 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7a5ed2517b7so559358137.2
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263547; x=1790868347; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=olFpzbrCioYQ8hyoLYIJ1a2ZDTPKs6gs8QpMhuGQnOA=;
 b=TZWEZZ8WODaG8NHiaSlj7sVOSMXEEygHnf97eAYq6wusFJSK0Fk5xpu5NrgldMZhyZ
 bS05e0Wmw9MMqTDl5EnWW41f5U7bl3ualnbdLo/wncon+XXks+Qoe8PmlSIqIsVwwz/H
 qSPAv54YKaT1twcn7MsHD8kSSsUxlsmmCw7nNb+TdnyGu3bJVMxSQp/OgUQjRlmI+qVx
 WnvdddDdxyHved1g9lNS2igwZUbepbVvWKB7W9nAM4tHmN4EiGpk0XwxSf4xwlgHJkIH
 H01/DaosqpB/9G9SH8KavaqDDmXLWNtUjgp1lV+/Ym9c5qXrPW35H4BDhrMiPgPJDDUG
 FcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263547; x=1790868347;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=olFpzbrCioYQ8hyoLYIJ1a2ZDTPKs6gs8QpMhuGQnOA=;
 b=eOgXEFGWDl+YF6JAYemHXGHbud30sOKpqwVGuus8ap/OH02JFEpr7dhRjl3Gtpjo9c
 rLJ9ORaR4l3XXr38RGbamoI1rrTcnhjDQpC/X5HOJ62mvCAgAJftNetz15TgoIxjb3U/
 E+1Qv43aENzfaC9tKWOVwPxdPWTrOJpL6J5sOsKxnFrei6Vn9qfImx+u99Tyu8it79qJ
 r7absm9rZDRCLaOOvMmgJRTvYyvH9Mq3SHox9btiR8VoAiwmJKQ8zvMlSnzaZ2qX1M8E
 CRcYdXTjLzVmRALsZgFUg078Dh6+detr+3sxNezrvquEUuMprkh1mtkU7jVe6mYOr3fg
 OuJg==
X-Gm-Message-State: AFuF++mAFeFwlxXobjP7Et9aU3P3kCWMvWpJkkvA8rHyseYe+551z/nY
 N3IPzZ4VjDWO/nN5g9nELdfKSkdozQijYelsOiIfIa3aiNLVRf2SM4EEGcctAGVSvP2ysSXdVGK
 t9yIMiQ60o1ZcNJ1/xlxoWByEE8y6EvwLzrgdGV9uRYqFcogZO1zCl2rEg4ziiXMWig==
X-Gm-Gg: AYBFou2KwfOIm7BNUX67s8uNL2Rtb1s/dEY4xXane5kcGE88XXmE4rxFzktd3LFv64S
 d55lzWxBbKMotGMmsYRAjctpUwSZbdH5PXe6GHlYA3BuzXdCCiLt6IbRkp/k6Ejj+uH/Mve7WZn
 0NpXhvhvbRBfIMIrYfuZKGERjr1UXKuY3i6vDKgu+M2CCs+HiySiRuYM2QmpNZSLVSZ/IU+Y74E
 0fOpF60920ZkdYEuYxpQaDuyJJiqXWLUs+9Ep5l8gYb5446coVRXHVNFNxw0RlmxWpGscpT5Lrj
 0ZfKpJ0j8St2UKlxaocKLaiuPsBYRnQ5ijxU8gtrOcoPUhbPo3Jli/AcJWl/yB1a7+2lGzgbN5S
 f+k1cQYZ9318+yn7pNIP7CHI4p7L63Kr3TqynvKdl
X-Received: by 2002:a05:6102:a15c:b0:7af:893b:da04 with SMTP id
 ada2fe7eead31-7af893bda4cmr268695137.25.1790263547179; 
 Thu, 24 Sep 2026 08:25:47 -0700 (PDT)
X-Received: by 2002:a05:6102:a15c:b0:7af:893b:da04 with SMTP id
 ada2fe7eead31-7af893bda4cmr268688137.25.1790263546535; 
 Thu, 24 Sep 2026 08:25:46 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cbd134sm74919435e9.9.2026.09.24.08.25.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:25:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/18] target/s390x: Make s390_cpu_set_state() return void
Date: Thu, 24 Sep 2026 17:23:46 +0200
Message-ID: <20260924152353.36209-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YyrmnliYPNG9mvULsna0z7LkhYiZ2-Yj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX9WDmpKwqSn1b
 ZcXMe1SqOG/jk+MDDkohQVd3QlcA5WnCbak4p86upbJVHhgB+IMxvEYBEoe/tAa2elmcf2EWFgb
 f8MFt2ryn365mfliVqRqPhPFtmowK46JN4lmsbk+I1xNyVYh1/0DUXFIt7eyOxFcS9mmk3Xxtef
 44m7qfJ7GM1rqilt/ybm3zp3AyAguCoeq4Hp5Znbv+qilrL2FLNyxWmNUBj3SXTCVlIHPWUgEJq
 FSNvE5+ST4Xg6bF7P+GthsdinXcdajw6d40yH1JLrU27D7lKKtWX7WlwnGcAPB7gCJPEZf815ig
 UrUU1uiihIvtzWNvHBaN6Wgtk8IaaAsZEPMB9TDxLf2g8XU68Gv+RJ4wjmx1nu/HmqOxVoUFAP1
 TLm/qrcVnyJScglNXUyqPM8wKSHfNCSXhs68wC2AM1GPcYYp1LHPZwNOyFd7l/WN7ubhNIdWKF5
 /aUZRdUz+jKULd9Pggw==
X-Authority-Analysis: v=2.4 cv=cK11IVeN c=1 sm=1 tr=0 ts=6ab540fb cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=otiJeUf2ZByGLVp8V8QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: YyrmnliYPNG9mvULsna0z7LkhYiZ2-Yj
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX9919pkeTPdrR
 MA4FophyAsF4h7SmA3+BiugsmG6V7FdRR21L5XvLBqB4oDDWqeZQuvVRFL0DTwTG6NKu3JpoADy
 v4S5vMqUI/WKSnBTebymTamtI1+7Ifk=
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The return value of s390_cpu_set_state() is only used by the STOP
interrupt handler. Make the setter return void and count running
CPUs directly at that call site.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20260923171116.31276-4-philmd@oss.qualcomm.com>
---
 target/s390x/cpu.h        | 5 ++---
 target/s390x/cpu-system.c | 4 +---
 target/s390x/sigp.c       | 3 ++-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 998bbb0d7ff..2d1dcc7045c 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -847,11 +847,10 @@ void s390_do_cpu_set_diag318(CPUState *cs, run_on_cpu_data arg);
 int s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch_id,
                                 int vq, bool assign);
 #ifndef CONFIG_USER_ONLY
-unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
+void s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
 #else
-static inline unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
+static inline void s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
 {
-    return 0;
 }
 #endif /* CONFIG_USER_ONLY */
 static inline uint8_t s390_cpu_get_state(const S390CPU *cpu)
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index f12ef1bd1cc..e1335d9be66 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -240,7 +240,7 @@ void s390_cpu_unhalt(S390CPU *cpu)
     }
 }
 
-unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
+void s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
  {
     trace_cpu_set_state(CPU(cpu)->cpu_index, cpu_state);
 
@@ -271,8 +271,6 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
         kvm_s390_set_cpu_state(cpu, cpu_state);
     }
     cpu->env.cpu_state = cpu_state;
-
-    return s390_count_running_cpus();
 }
 
 void s390_cmma_reset(void)
diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index b6d44c5c31b..1801b8caa6e 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -617,7 +617,8 @@ void do_stop_interrupt(CPUS390XState *env)
         s390_store_status(cpu, S390_STORE_STATUS_DEF_ADDR, true);
     }
     env->sigp_order = 0;
-    if (s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu) == 0) {
+    s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
+    if (s390_count_running_cpus() == 0) {
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
     }
     env->pending_int &= ~INTERRUPT_STOP;
-- 
2.53.0


