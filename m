Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A413C624D0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LBQ-0008Cv-ES; Tue, 01 Sep 2026 05:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LBO-0008BH-IA
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:53:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LBM-0007aX-Rr
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:53:34 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68179Dcl1892410
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 09:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FYs3uPH5Pb8hS6ZkgeHaIaSrfIoM0pZKlpLy0wB+Gps=; b=IWHe0xexRQYq3q00
 s6WRSHF63KSSUgusAYjX7A4p4ZYJBtjhPn3FcE899hkplun2IcDucAiigjgZ+on+
 fsLcBKlDyTAupQl9gLZI0Oi4a2dCJc6XOBRtpnHjpzL4MLpBzvzDx1YaMryGoPs3
 2EETsRq81GgUkPtd+RsEWPKJgecLU3NixRyG8Zt6aOlrlpOy/SyE5+FVPCEKsArG
 BxMmQN43Rsy85e9EbnimpkD4znxAvgp0p4WRmqmu+nGXJr2pp28AkTvz8UZ9tGUj
 VndCgDaIOtcD9rSLDnI7GkvFMADQzH8RyXEkm6TH1uLfe1LFnJvqIS8ElvY/uUpZ
 57FZyw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdp7c9qs3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:53:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e53b8a302so662037485a.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788256410; x=1788861210; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FYs3uPH5Pb8hS6ZkgeHaIaSrfIoM0pZKlpLy0wB+Gps=;
 b=ePRJfCZL7cIRvP0SGq4J8XZQNiphTYNY5dToFcRXJB5E+tccBGJroni0BkQaYTSXQk
 V+1z0maEKw+zUBiRh9rTLaM0QiCxBPi0B/F9shFIzDvfvMYCIX51SOv0AdpLkd4eH4dt
 qI0a0RRz3tv7HyxKLTHyL4TFXqNaYvH5tcyr7Lh0/nsSBA1tGM5+0z1e/OcmgDzCHYaO
 cmIb0Qu47xhe12F21RN8fPTP+5GUv8Bfy8mAn91+MOSpANhAg0/f7K4prsnZL+0+VG3/
 22ornefxfNVHMy3na0oVfNDIMwvOmMgzNqH5kPtoWcNCtJNXGAgZtgTm1/Z604n7e/JF
 bmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788256410; x=1788861210;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FYs3uPH5Pb8hS6ZkgeHaIaSrfIoM0pZKlpLy0wB+Gps=;
 b=jAU6vgELPSXVp2qMe4Y6H2ZqpBdzdpTRm1YghYXx7ZwlHqM51N6AoFXsVMCsykzIGK
 /paG7vfjdLM7jJWor1ZvvRHduzyn1XEYRzec8sO7ob5bU78OY/G79xfr0JJ2WmCTqFnh
 Im246h8mcFF6UQ1NQ1J8gbHO4BHxv5Mcasbk3Oj/gLJln8tIHv24GlD9koghmEzTgbsf
 Tc3UY67HCI2HGLAlnNJNKoqZf/ins+b/H6RP7OonB1Ij7jLgVkenQoR+YUTPBG4Pt8Kw
 c6MRg6va5AaCtMgkzLv1Uavt1RBUDMKIZRXBk6TQWntGr3IXQNqtJiffk5rWpSt6UIKd
 hAeg==
X-Gm-Message-State: AFuF++nySzeJniKsO0rQqVjF7LDQku7BTcE7IoWJW68EJ/7E9Z0BtknW
 oo8pGolgzYki8pkiRa6l8kTPLeAksSdfLxAefT1TiFJ2Mn2M60zvd2foyfhaUmzB545YB9sW3cd
 sD/O0MgtmgCkFLC70AoRiOj0/J1Ox3dg6argiz3G4QlmVsKF/BiD3noL4AgQHXyvg1A==
X-Gm-Gg: AR+sD12I6+Jwt+hANRZklbRVYO73ILbQIDr6jhdV4T/+HQOBKPmia411plM84GyIpOh
 DtCOemL5eVRgJdS0sQ3E6a1+96zh93MJBP27Xzc43b5fUpGUoy98dv5NWyISZrTkOJChTCEtKmV
 lNsWygERpMv6SnrgUezz+kw7xe9caaAHPoZJp0r49RJnCyxrD1OIwFASumT4zHEyYFJqxYpXnEe
 NX12u24Q97AEXXF9ioEfCyzDkZR6qnAK0oe27Pjm4phy3ysFCF+1oX8nX2oyJE4qMiKDxTWgb6R
 mXv/ZghHiTC3eAXqpUF1isGG4aRg9pg77Mg0La7LRhLxXAyXMbL5Dzvj2ifOaqgXrdY9MRaVXek
 fRIxi4emXNuKve0aMIJ2k03f+cBZL/4ZoRprN0aM7
X-Received: by 2002:a05:620a:2304:20b0:936:c026:be61 with SMTP id
 af79cd13be357-93913798f13mr2882939785a.13.1788256410424; 
 Tue, 01 Sep 2026 02:53:30 -0700 (PDT)
X-Received: by 2002:a05:620a:2304:20b0:936:c026:be61 with SMTP id
 af79cd13be357-93913798f13mr2882936385a.13.1788256409813; 
 Tue, 01 Sep 2026 02:53:29 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b91c9cf95sm262624555e9.1.2026.09.01.02.53.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Sep 2026 02:53:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 08/21] target/hexagon: Constify CPUHexagonState in
 hexagon_thread_is_enabled()
Date: Tue,  1 Sep 2026 11:52:14 +0200
Message-ID: <20260901095229.72018-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901095229.72018-1-philmd@oss.qualcomm.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OcyoyBTY c=1 sm=1 tr=0 ts=6a96a09b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=XxrlQHdRtCO5bKJNttYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: nXYDj5RprLaRtoNSZfqOGrowVWOKE4cj
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX9xbCwQXLYfTa
 bgvXcoYmJcThzMkEEf1+XgaJarRW566lVkrbcxPAeaIxd61c64mdQp90ToHM4C0Hgnf5AVDBlUj
 /CCAvgVUNPh+WQdXmHlSaSzLNCByb2E=
X-Proofpoint-GUID: nXYDj5RprLaRtoNSZfqOGrowVWOKE4cj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfXyaODwexOQYYw
 41N6x2GaxdIkR50Wu6XXBlE2GzVqzvXCIhjSSo4VTkAIvyiAtkOdMccmEPtHhUgGyDV7K4RZ2Wt
 v0R7h+2BV7UG7MJpRk24IET3uOaHUnaeVfxMWowR8BwcPGlnSNyjtm6Cq7VtKeaXWl+Ip9zeVmr
 ul3iXqRPFjDaGRzfYChLkzxz8JrvyxGC67YGR/s4XEs6SDmL/wUCL96Xc4uGUaRnRcAe3xwabzJ
 Rhs1R7dO1d8HIfSAyZ6rXfrQznUmWogjy+hgkufxG6qLGRJ9ecDzJf7vzwZFXOncfDukGRmpSdD
 jss8xxZOaOf2WNfW3/iU+Z8nfFXv8r5ldLm4GGCSAeJ0HucJIi+kXg6UwbigDvG7wBkU1BeE5wG
 eDnPjFheTzr+mXkGI73ZIrkh1k2wqshbhmrsn/RKwjW+MjUSgOhaHGaM6TKwWjfVexxfxq8cs1x
 UaC88K7g83T3JGr/FNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010087
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

@env argument is accessed without modification in
hexagon_thread_is_enabled(), qualify it as const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h        | 2 +-
 target/hexagon/cpu_helper.h | 4 ++--
 target/hexagon/cpu.c        | 4 ++--
 target/hexagon/cpu_helper.c | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index c50fbb3f72a..e4f120eda17 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -216,7 +216,7 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
  * @return true if the @a thread_env hardware thread is
  * not stopped.
  */
-bool hexagon_thread_is_enabled(CPUHexagonState *thread_env);
+bool hexagon_thread_is_enabled(const CPUHexagonState *thread_env);
 uint32_t hexagon_greg_read(CPUHexagonState *env, uint32_t reg);
 void hexagon_cpu_soft_reset(CPUHexagonState *env);
 #endif
diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index d1767503156..a669091a89d 100644
--- a/target/hexagon/cpu_helper.h
+++ b/target/hexagon/cpu_helper.h
@@ -9,8 +9,8 @@
 
 uint32_t hexagon_get_pmu_counter(CPUHexagonState *cur_env, int index);
 void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old);
-int get_cpu_mode(CPUHexagonState *env);
-int get_exe_mode(CPUHexagonState *env);
+int get_cpu_mode(const CPUHexagonState *env);
+int get_exe_mode(const CPUHexagonState *env);
 void clear_wait_mode(CPUHexagonState *env);
 void hexagon_ssr_set_cause(CPUHexagonState *env, uint32_t cause);
 void hexagon_start_threads(CPUHexagonState *env, uint32_t mask);
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 9765716b516..4cc6bd67c28 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -345,9 +345,9 @@ static void hexagon_cpu_synchronize_from_tb(CPUState *cs,
 }
 
 #ifndef CONFIG_USER_ONLY
-bool hexagon_thread_is_enabled(CPUHexagonState *env)
+bool hexagon_thread_is_enabled(const CPUHexagonState *env)
 {
-    HexagonCPU *cpu = env_archcpu(env);
+    const HexagonCPU *cpu = env_archcpu(env);
     uint32_t modectl;
     uint32_t thread_enabled_mask;
     bool E_bit;
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index 64c5746c6d9..610e29a0503 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -212,9 +212,9 @@ void hexagon_ssr_set_cause(CPUHexagonState *env, uint32_t cause)
 }
 
 
-int get_exe_mode(CPUHexagonState *env)
+int get_exe_mode(const CPUHexagonState *env)
 {
-    HexagonCPU *cpu;
+    const HexagonCPU *cpu;
     uint32_t modectl, thread_enabled_mask, thread_wait_mask;
     uint32_t isdbst, debugmode;
     bool E_bit, W_bit, D_bit;
@@ -384,7 +384,7 @@ static int sys_in_user_mode_ssr(uint32_t ssr)
     return 0;
 }
 
-int get_cpu_mode(CPUHexagonState *env)
+int get_cpu_mode(const CPUHexagonState *env)
 {
     uint32_t ssr = env->t_sreg[HEX_SREG_SSR];
 
-- 
2.53.0


