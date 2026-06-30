Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4FEC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegaC-0007R2-Pb; Tue, 30 Jun 2026 18:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegZ7-00058K-L9
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:04:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegZ6-0004Q2-9Z
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:04:25 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDjee2879934
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kfOhLANeVRTcU6AZF6U667w89IySuXAQrAYpIb1NK20=; b=czzL1N9gAlJma4qr
 cQ5Td0d7Ag8pVyHPYirwWgQ189gzHyIn8eZuCLfVH1H3LKykqF97y890oIrLNiQJ
 ONFPBVVOzvD+mmyrzvWM4W/3xRhZMyfbDKHmJhSZI1f40dR8elNUXGSSITyM+C4j
 p9B3PTekCdI+OUWtWz/ZItgzLFYkqB+sJzUEwufQxd0y9DrHeZ1driczZMiH6R1B
 lkfYwEVbF0WJHz6qezdyB5hBGFk+ZMRCwDMuWhBPJy8+x9gn452prl2IPrpcoBbt
 jA+un5aF9QG0DWP1/ze9snYxaSr7Sek2F5ciRPdFHC5jCkEkQW2KjQwdAXJBSgDF
 MFokLg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hfy9cpg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:04:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92d1cae5740so667885a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782857052; x=1783461852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kfOhLANeVRTcU6AZF6U667w89IySuXAQrAYpIb1NK20=;
 b=B5dEd4kSC3FwiNvfdojI/yXKCsIHiMPbCOnSYKgoicLRfJ6+3QUH76HY4/CE5tZXSu
 GtUVIZ3eyTao1ygA0XZbq9grazPBSgcpMf+mTU7L6iLJTzGnHQ731ptiU/N2mJOA8UXz
 xqX74RpRA2+zxsJzCl2MJX3HEz9OR9SV48DBlfgKylqDOKAMxJsXktlR9Mjgw5HaaYMI
 WyyeCTEXInWLqOgYKHQs1mk0ckqdGUYH/VZJQZL4nVisn8PrTKTJOkp6nObIcLno0Uiv
 iG5KLd01Fsi2fKZUg6alHljtallmB++QL1WkYieoazP0zLeyQpYV7LmFN5icKJ5gmif+
 pHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782857052; x=1783461852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kfOhLANeVRTcU6AZF6U667w89IySuXAQrAYpIb1NK20=;
 b=noAqN0bVEI8R5EdWTs/TnWmw/yOtSfE/hC46mjduglDEm+8+LQviB/PYDoJkJ+OU55
 5jSoStgGNovIVGOFQ1jei5u6bQCNJG6nMWeoFQHIoZNnhVh3NIDzQLrntmlCb1iSoPMQ
 1fZsg+OKPUOtF6gptAfVWkXU5zsUqIHMSIAtEFCzpDMrxLSHYLbC9wlpHjWRgaXrW1F1
 JJERM2zdAkyixUQgFn47/r/edK//bvLNaERoZ5QuYaCrH4UcQkNJsHrV4q9PJICIpQ0V
 t3Erln029sQVYiYYujDqIjBuGsK4nlkcNK+zHCjD738fcUNQr2FACnIr495jlmDMPLWp
 +/kw==
X-Gm-Message-State: AOJu0YyW/kq7bCMQV7VgvT2GYaafPaWbLjt9Ylw0vg5QEwOMs7eKmtBc
 NnAHhXYBZ77fbVtTCiVoCgTvwSj3epWSuTp3Fv8QVUkAyy2BTTGOkfUibccj/EZsZ3IMmDIwL5p
 faZlfseu3LcsaYKnoHWUpWesRwwDE/Or/j2DYG5ey6rp7/Frv/O9xqhUzIt/02FPXfw==
X-Gm-Gg: AfdE7clZdla2RxmoVsOc6KDHYO7LP7mVWTJgfM0dAZnmMpzlOc87MdNYtUGkadgnVbX
 OLQfA6f30lmzBO95qNe3NQtklE+eQ4PzwKyuvNvTgds4XtCt0gYM7RuQHlXUphm3M1i5LTMjHt+
 5m9Lrkgg2xjkcWODqtuFULm9Ck2rB/7PFPREF+OZ3vbNcWr+Y4jVZC0DL20f0UZVMJT+QTkzt7t
 X1e9jrfuHoqFkGP8qcM4g9JmkohDmCUm69pltLnJ7bS/hfyRJLAndNFiKncHiG2wPeT+OiwzUfq
 wpOtj87zRvL9/HKxdIwVSKCGXwLLJRuUpoQdV60BOfg9MnmrVwgNt+rMZgT0DZ/W65WJcyBGVL0
 BlgxAJT1iX3m1f+xf7AlPbbMW5Xh4EVW/1R+Mm+Pd0PW042MnpLJ+u9xHp+4SrEAo9QQJ
X-Received: by 2002:a05:620a:408c:b0:92b:67e6:8acc with SMTP id
 af79cd13be357-92e627fb238mr838723585a.70.1782857052218; 
 Tue, 30 Jun 2026 15:04:12 -0700 (PDT)
X-Received: by 2002:a05:620a:408c:b0:92b:67e6:8acc with SMTP id
 af79cd13be357-92e627fb238mr838716485a.70.1782857051580; 
 Tue, 30 Jun 2026 15:04:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47567a6f351sm11258341f8f.36.2026.06.30.15.04.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:04:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 25/33] target/arm: Factor arm_check_watchpoint_hit() out
Date: Wed,  1 Jul 2026 00:00:52 +0200
Message-ID: <20260630220100.1289-26-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=J5OaKgnS c=1 sm=1 tr=0 ts=6a443d5c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Hd2jv3Dtlm5kdhFzXvIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: buXcrQ98ZR7Uar7LpcAaCh7OJSFS6pI7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX1hsfA5yamyOd
 IK/krRHZls6b+x9PeIluTJNDqp8io5fMH3ZBGwDBXI4mPGnYZsScaRURRww+3QWIOQGFZqxudU+
 1Dl8Z3XoSffOi28zKRFmB4TxCXP8RPY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX3Jhm6mLgGocn
 adxGTJgRcafO/61JnJkikgDiV/A24BZFqTCW4tJc1u4/2bdG0vHggxK411Bnz2WJ7xryD5l4WZ6
 8qxOC89iQR5JzO1YDY1Z5GWPFq4Mc42FXmPNs7oviP2f0sRbIHPjh46vir8sB5QY4yppmkYXRht
 XLZQQfNVV3f7pc9pmT4c8uh6h6x9H2zppEMEN8tq23FI1WjsokGlGdNs2t7+1Cz9kgwyEbCg0J5
 af0wEjfwYi7QiazJSd60ImhSMhpq3BrbtpyN0UuWLtZZp6eYCNC13V6kNqEhcTa9Kn7R5X4x0si
 15A9e/YW7/S3hxnpSQcqExDKJmFyNRvTvt4a9hXx/KJev6kKqeGMbb76JreWz2Dd5b67Q+i5HaN
 mLXb6aPYgZg1o7S7r/FE5EHaS5CLEwTQSCbg3qE8JvcFW0ZutDfLwMeyNdbP8NlwvAbhkQfofj2
 MxZSy0vOnj5OTjwrH7Q==
X-Proofpoint-GUID: buXcrQ98ZR7Uar7LpcAaCh7OJSFS6pI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300215
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

Factor arm_check_watchpoint_hit() out of arm_debug_excp_handler().
No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/tcg/debug.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 7171501d400..775f1f04c6d 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -455,28 +455,35 @@ static uint32_t arm_debug_exception_fsr(CPUARMState *env)
     }
 }
 
+static bool arm_check_watchpoint_hit(CPUState *cs)
+{
+    CPUARMState *env = cpu_env(cs);
+    CPUWatchpoint *wp_hit = cs->watchpoint_hit;
+    bool wnr;
+
+    if (!wp_hit || !(wp_hit->flags & BP_CPU)) {
+        return false;
+    }
+
+    cs->watchpoint_hit = NULL;
+
+    env->exception.fsr = arm_debug_exception_fsr(env);
+    env->exception.vaddress = wp_hit->hitaddr;
+    wnr = (wp_hit->flags & BP_WATCHPOINT_HIT_WRITE) != 0;
+    raise_exception_debug(env, EXCP_DATA_ABORT,
+                          syn_watchpoint(0, 0, wnr));
+    return true;
+}
+
 void arm_debug_excp_handler(CPUState *cs)
 {
     /*
      * Called by core code when a watchpoint or breakpoint fires;
      * need to check which one and raise the appropriate exception.
      */
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    CPUWatchpoint *wp_hit = cs->watchpoint_hit;
+    CPUARMState *env = cpu_env(cs);
 
-    if (wp_hit) {
-        if (wp_hit->flags & BP_CPU) {
-            bool wnr = (wp_hit->flags & BP_WATCHPOINT_HIT_WRITE) != 0;
-
-            cs->watchpoint_hit = NULL;
-
-            env->exception.fsr = arm_debug_exception_fsr(env);
-            env->exception.vaddress = wp_hit->hitaddr;
-            raise_exception_debug(env, EXCP_DATA_ABORT,
-                                  syn_watchpoint(0, 0, wnr));
-        }
-    } else {
+    if (!arm_check_watchpoint_hit(cs)) {
         uint64_t pc = is_a64(env) ? env->pc : env->regs[15];
 
         /*
-- 
2.53.0


