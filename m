Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164E0C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24ui-0006KT-Ne; Thu, 03 Sep 2026 06:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24uh-0006BY-Ge
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:43:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24uf-0006xr-LV
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:43:23 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHHOR327193
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f0Skn+8bjf9L/XrkfsB3LtkwG3OP3OS/jIMH/4fHdro=; b=luTCsDC4vRMBoPKT
 SUhO0+qlFciICkEaVSrtEXAj0eCMrgShBsn7wa58tRin50lWETIFzFhgkKUEiLqD
 EF3wDOUvLIsjgG7WgqR8+8Hwen/7TJf95aIcjP3QbXKMlXC71no2Y7mGUozzNSQw
 N2dfsb6CWavrrDLqFsuY7wm7cwIbagUbcphVc9GkpZxd1aV/hmMlTbjnxUSS2vqn
 7LgxO2473u7MtmEgx44H6hdb78Byp36w7TWf/poA7RkeAd0oJssXDOqMjUH1y4Q8
 PrB3I68C+KRIXq2EPlGUXLeByZQuGAC9nfTwf3pS9j8vKvy1sXjt7tTCUfEBKvyZ
 4dRnlA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf4ekgts0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:43:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9394ad7f64aso430070485a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432200; x=1789037000; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f0Skn+8bjf9L/XrkfsB3LtkwG3OP3OS/jIMH/4fHdro=;
 b=YdAdDXZnxHUV3ZZWWSeXP+wyhG/j5hKurAXgqCitEAAj9p1Ai0cKH061iGIMPcf9x2
 qt5mZSe6x+cN2vyz03AsG801Nc3URMc+vveri9ercFHd9SNhZi34IsxRFZLFNu8OPpG9
 JKS/RnrJawmFhEcIzgoJrZsvl5dkFmHmastQh6yQkk7YBrN9VU1l1s7+sL277tTmzFZo
 1ZVBQ30GXQeKvhHpZ7hNEvkj/J6q2Wbm2srLZJLHoZB+c3WIaqh5nGEInMwiosxSeyW/
 DyNamkIY3dkXuoao9t0eiMWO9YigQaoR5n65Lw2gJKc+fiCe5kyhXsoSJwMBgnbhg00f
 AIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432200; x=1789037000;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f0Skn+8bjf9L/XrkfsB3LtkwG3OP3OS/jIMH/4fHdro=;
 b=sQEcswhXAd16MyNUH1vX4N3HbBYRy59z6FyOu5CNThpKVa7HCDrdUdEpEfxwzqW8yp
 BEEISJ4l6/XT+g7wp1V3CjL3W6IMk2jmHyYlQUCYr5ZVkmzbwkNfDIvCMc2RCz+nnc+r
 RI6STDZizsJ5y9dYxl2Np4WDVRFb8CjuNa/hi/KvTAwJPLSnh+relckjrJ0T3wI04yny
 HyknSc3U7PDfiZx9yvT3ESb3QTBN8MxY74Ud0K8mlX8NFmfF1mvAGHglIE3+KNl/szFz
 p6FVgEstYTiNGXVWIZW1vtoL5gdpMQ573BnbVhqlIP6GH2oQTrnSVndHgw+xoqN0GNGw
 UiEw==
X-Gm-Message-State: AFuF++mkI4uVdWFzsP1QRc28MLFA8Aaj6B2BWUFlvANmzkDeOf3fMUUr
 iU7GOZS8bR24Jy4K3s+Ai0i8n94vcYMOz37u/CgdFec4hwCORXCm8TttHLAV0CSFDAgnIg6q+QD
 6CBOVP3HZ4dAuqTwXwF9Z+QfWXRlaeaPiwLPefwgi3tbT6+4PVqCLmdZ6Q1FE39S9zA==
X-Gm-Gg: AYBFou1BavcqDw/UwmxYxr2EZFPRYxP11Z6IBYeOLCQgZtJo8c33sKtk0caXZL59Kca
 Bts/MZPv/e0eDVrywAPsvdUvlFkT/AemVotDu4ekauDuK5SJZZsqpKH75fuKIo602vJ3O9A+nh9
 V+PqEQBiExnF7dmheYLlE/0TZm2tV7+SOK3akgEw03VeSW2ftKFZbMLgKKDxJ/ZNCN2oGWFGy4z
 eh/6lEWp3N68GGSibUiq9mGcAgTmM6adelHlcXItry3+EO+6NtCd15uSY8XuvI84IvonOS6Bfuk
 CFrQKADUcRPxhSBkKnp0XqKAYH36juCPcFrcRr1pIHdBJK+XP3/UuUamD+S27ZWBxgDoEjvT7Jz
 wwyRkY0E0nba9CjRRkahIPYAh8kuXuS0VZwxkAkWI
X-Received: by 2002:a05:620a:398f:b0:938:fd9b:c615 with SMTP id
 af79cd13be357-93960fdc482mr920186985a.40.1788432200018; 
 Thu, 03 Sep 2026 03:43:20 -0700 (PDT)
X-Received: by 2002:a05:620a:398f:b0:938:fd9b:c615 with SMTP id
 af79cd13be357-93960fdc482mr920185485a.40.1788432199612; 
 Thu, 03 Sep 2026 03:43:19 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d9db2sm63340755e9.8.2026.09.03.03.43.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:43:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/51] target/s390x: Constify S390CPU for cpu_has_*() getters
Date: Thu,  3 Sep 2026 12:39:14 +0200
Message-ID: <20260903103936.62355-31-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PHvLMalNfNowUmzkCfO-5uwotJhjf7rQ
X-Proofpoint-GUID: PHvLMalNfNowUmzkCfO-5uwotJhjf7rQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX2wfmZXDCQLKT
 vZhnhwtzbJBJlkUDTM8RcCYEihZKgblgWUSKu0up1omRCDto8h6t9Sl8nWrEzQ0SUOQu3CCwVa0
 RMUq9ygCePSPgb6OHN2a2z6+viEAxLMziQCPSBn1kcUw11nDyETTwICiAI9gwhb+WiPzN1RiMh/
 X9vqwJgKzIaT+xHXIoQAYLZ7jyPlHF45OIDcDxeRgV72eEZ+8RYVIe5/jx4fJplxODaPza7KnHs
 U+aHQpYvvvltk3VkJ/u5ePYu0f7eA3+fpP+2E0vAOltDBCOlADagTS9Mii1KQMlmYwxB6pMfVoX
 ximu55X5qsjNG1S+yXg0rV3MU5FK1vLLuGwSuc25rwJe2dgB630ChjeowBxmsyJAX3CibQzemxJ
 JyIDiive0IZbwvxeFwcnMiyuRcPU8KHt4idQOQcKRcP1OlmpiT13m0PicuD9x2u8r6GOs2aG4tx
 VTsohS6ZCzubsUiTK7w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX5rQVHDvPlH3i
 GfHnzaVutX/GjNGeuF23llPQRN4EH7/QRTEJByDQCliWPqn5QnfDJfv/IErMecXpumSXdJhyAcW
 WXKSuaTQUGEwEen07n6XqJsRYergkEg=
X-Authority-Analysis: v=2.4 cv=PKc/P/qC c=1 sm=1 tr=0 ts=6a994f48 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=mU8mmpTTODwToQi1tsoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

Add the const qualifier to S390CPU when the argument
is accessed without modification.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20260901095229.72018-15-philmd@oss.qualcomm.com>
---
 target/s390x/cpu.h            |  2 +-
 target/s390x/s390x-internal.h | 12 ++++++------
 target/s390x/interrupt.c      | 22 +++++++++++-----------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index f55b79ef8ac..998bbb0d7ff 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -854,7 +854,7 @@ static inline unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
     return 0;
 }
 #endif /* CONFIG_USER_ONLY */
-static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
+static inline uint8_t s390_cpu_get_state(const S390CPU *cpu)
 {
     return cpu->env.cpu_state;
 }
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 81da207a5f4..da60b2b1fd4 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -334,12 +334,12 @@ void cpu_inject_clock_comparator(S390CPU *cpu);
 void cpu_inject_cpu_timer(S390CPU *cpu);
 void cpu_inject_emergency_signal(S390CPU *cpu, uint16_t src_cpu_addr);
 int cpu_inject_external_call(S390CPU *cpu, uint16_t src_cpu_addr);
-bool s390_cpu_has_io_int(S390CPU *cpu);
-bool s390_cpu_has_ext_int(S390CPU *cpu);
-bool s390_cpu_has_mcck_int(S390CPU *cpu);
-bool s390_cpu_has_int(S390CPU *cpu);
-bool s390_cpu_has_restart_int(S390CPU *cpu);
-bool s390_cpu_has_stop_int(S390CPU *cpu);
+bool s390_cpu_has_io_int(const S390CPU *cpu);
+bool s390_cpu_has_ext_int(const S390CPU *cpu);
+bool s390_cpu_has_mcck_int(const S390CPU *cpu);
+bool s390_cpu_has_int(const S390CPU *cpu);
+bool s390_cpu_has_restart_int(const S390CPU *cpu);
+bool s390_cpu_has_stop_int(const S390CPU *cpu);
 void cpu_inject_restart(S390CPU *cpu);
 void cpu_inject_stop(S390CPU *cpu);
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index 1dca835c5d8..d7e3fd45e4b 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -139,10 +139,10 @@ void s390_crw_mchk(void)
     fsc->inject_crw_mchk(fs);
 }
 
-bool s390_cpu_has_mcck_int(S390CPU *cpu)
+bool s390_cpu_has_mcck_int(const S390CPU *cpu)
 {
     QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     if (!(env->psw.mask & PSW_MASK_MCHECK)) {
         return false;
@@ -157,10 +157,10 @@ bool s390_cpu_has_mcck_int(S390CPU *cpu)
     return false;
 }
 
-bool s390_cpu_has_ext_int(S390CPU *cpu)
+bool s390_cpu_has_ext_int(const S390CPU *cpu)
 {
     QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     if (!(env->psw.mask & PSW_MASK_EXT)) {
         return false;
@@ -199,10 +199,10 @@ bool s390_cpu_has_ext_int(S390CPU *cpu)
     return false;
 }
 
-bool s390_cpu_has_io_int(S390CPU *cpu)
+bool s390_cpu_has_io_int(const S390CPU *cpu)
 {
     QEMUS390FLICState *flic = s390_get_qemu_flic(s390_get_flic());
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     if (!(env->psw.mask & PSW_MASK_IO)) {
         return false;
@@ -211,21 +211,21 @@ bool s390_cpu_has_io_int(S390CPU *cpu)
     return qemu_s390_flic_has_io(flic, env->cregs[6]);
 }
 
-bool s390_cpu_has_restart_int(S390CPU *cpu)
+bool s390_cpu_has_restart_int(const S390CPU *cpu)
 {
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     return env->pending_int & INTERRUPT_RESTART;
 }
 
-bool s390_cpu_has_stop_int(S390CPU *cpu)
+bool s390_cpu_has_stop_int(const S390CPU *cpu)
 {
-    CPUS390XState *env = &cpu->env;
+    const CPUS390XState *env = &cpu->env;
 
     return env->pending_int & INTERRUPT_STOP;
 }
 
-bool s390_cpu_has_int(S390CPU *cpu)
+bool s390_cpu_has_int(const S390CPU *cpu)
 {
     if (!tcg_enabled()) {
         return false;
-- 
2.53.0


