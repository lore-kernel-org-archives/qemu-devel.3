Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D664606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BO7NiW1l;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PvjxlnyO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nh-0001yb-Bs; Thu, 22 Oct 2026 17:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0ne-0001xd-5o
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nc-0000LJ-DH
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:13 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHIRI4086722
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xMKbdpJMgnq
 KWO91bdLzU/4Ep2Vj3tjVr0huqZEKlbw=; b=BO7NiW1lmOmaQHB8l5KhXqh2B97
 jEbAxsyvIBTjeYGf9LKAW8e3Tu2bts+fcflmMN2yKTHgy0uMKY8FyqDyoOc4kPpV
 yRTixFYJ7A/a0E2fxG0ZrlaC8srqZO7Mw+fOr0DBno4ryLWjvXXtU+TTRT1tEeha
 w9Nu9nR63Ot1NN6dI8bwPhaxitRayDHPwkZxyM0x1CTP6V4ESqd6++3Puo3YC6WR
 rRCpi7IpWIwed/68bNoH1HVZom5uwFPcuhk3yJ4MZy8yqVGoS8d3Qju8EA4TyVYl
 SZRZh+we7MKHtDA6L51EuBP9Y2dAYCBDPgVQbCIWetRtYNDk5Ate7SOIzhA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtrq5p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab7f1efe5dso431802a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706290; x=1793311090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xMKbdpJMgnqKWO91bdLzU/4Ep2Vj3tjVr0huqZEKlbw=;
 b=PvjxlnyOuUmMbsR2ZKPEe+xfxxy3bqoeG2hmygVNxhqa/n4rPF90T5pOV1caTxsDLa
 4xVFNrbqPmDZ0tiziQvX5rLuyfsB8OHS+KDGDV208XVanUEAkchZQ6Gp8BUuTOejZy/V
 VVPMEBwOyofv/tzqs1SLZHN/IwBpfvMTJ+a2sx/7KYQxoGH4eiTDqKPhyF762YKA74mk
 WilqwZ3KdtYRcpmFGlZrHPv2cHR/N2FhlWSglsU9pPWhObXfGsiASIlDGYso7N6oedul
 9f0HWUqbXHCaKGg2xaOxuvwcnhOkH+prAL/P3D6qQ8pW2/lzmtGGGCRHqAJDIGHPro0R
 yO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706290; x=1793311090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xMKbdpJMgnqKWO91bdLzU/4Ep2Vj3tjVr0huqZEKlbw=;
 b=0U0jsgWeHTo25k5mRqSCpAdsqcnKfg30WA04/ONwnT+vKrcA43gb8tWQeCDmaQvCjM
 Ue0+pLlpuHglfkvgz/+ZGs6zIri6v7av2Z4MVEfcZmKUENZCvtCS0sJelPBJ49XCJ0Yf
 D2yeaGQsSR/obG6A6z9lGiLOUMFMohKZ8fBZwnCrcRPYJOEQBhzTSXtFin64c6sx7L8E
 SrTU54H0wJ3SsdApQHkSehY8oKtAK7ggkLffITrjVtcTgpwv/G1IVtznQOMTsQ+X9EFB
 l8jNbOGpA0z45ApWLHfsFkjdqiQHRzEjEyP1FnQ2jOVD1c70OFPMDhzBA1iYKt1KwV/1
 m+zQ==
X-Gm-Message-State: AFq9FYKbQ10TwfPALVv8qHYedTUa4RfSELJ73n0/88Y3b9p8Gyn2IW2V
 5uoPyl66WC25BZML73vFWtsyVd0LAHzkgA7Cr50dvAMI8pBGyy27juSqRik6TFxGYJsT2+/NdnW
 ep+q+r/1mxStfUGdT2hXpdQFvdsZk6dPg5QcZZO3gT5EiP5CJ/zHPgTTRKcjvn+Dv8Q==
X-Gm-Gg: AYBFou0SsIOYu+A8dktTZZvcNEnj7Sxn7bOgzrAA9+5rgMyB5UXYuCy7+DYJzbzo11a
 rl8FrHXryX//wBF+TckMTH98n0T3XMlREJKQNVff84fC1uxtG5BQia/dclFPi8v8dEoO41cWDUM
 EKhXw2FoaYQzmA3mPPQ5u3T8OKhjBDITDVSLEwroF6EAvCllqUgB8bPA+TbtXsZDffSOX/wJJLB
 sS8t4gA1weQR+Ix20hQ2d539ijVgzjzZPktuc7mzRSHjuaH0/BYtyLOh1yoMj3LiWhW+CGL3aIg
 BgjvxilPAKRp17I+1/ooM9SW+4QZNhx6NQ5MaEYyUAo04YcnaeQgWpBbi5X1POlbfK/TgyoyB6q
 wj7GNLBvkuEXzTaL2yI4HWBUPQwOt4oM1fNDRGd2h6PGqwxRbSkJgznR7njPLxik=
X-Received: by 2002:a17:90b:3b84:b0:3ac:e6a:1b2b with SMTP id
 98e67ed59e1d1-3adcd799794mr234660a91.0.1792706290390; 
 Thu, 22 Oct 2026 14:58:10 -0700 (PDT)
X-Received: by 2002:a17:90b:3b84:b0:3ac:e6a:1b2b with SMTP id
 98e67ed59e1d1-3adcd799794mr234643a91.0.1792706289950; 
 Thu, 22 Oct 2026 14:58:09 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:58:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 23/27] target/i386: rename qmp_query_cpu_model_expansion to
 qmp_query_i386_cpu_model_expansion
Date: Thu, 22 Oct 2026 14:57:42 -0700
Message-ID: <20261022215747.2479440-24-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6ada86f3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=7UvLiwb0lT3xj6fr-RYA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: MZvDt9_quZLlhwxHyyOXJXHOZCxqkEal
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX3/LDVpbRgA/U
 JNpkAJ1Z0K4e4AxkJCUvQ0ZNC/HnTv8d7H4VeM5ogpwWg4xPj4sAHNXIpMisrK/HBxBEyH3AhOu
 usyFWo11wmJvXUeEjqEDtUKHUr13zSqcKTUgB4Ql4LSkA9SYUE5rtAtd3hBipOwLdR8/n4qtj/0
 xdY07/E3pmrY3wuc833Vl9jTO0QVPrz1+x3bvTNEFL+NNJWjdAhE7XQRbGqUO+wq/26nU+Rq/XB
 K2BWVU9/7GKTBZG8k9dPYHT8ekjnAMESzToAVd0WeIosalWtvVel2SlNSnOMnyDll6fEpp91Dmr
 QlOAN/VUtwKp8pbVL83Z67SSufCktw690qwillpWslcbcIy6TZ5JttWB7iKCqwHKX9o5z92ynck
 IYysgI1y/rJ/Xd5qhIk9kPWZKUDdyORTy7jPuNnhZKEkrFxEl50Cu1ulPbuGbx/ekowLOnlQCy0
 CTI43hzeIz5gei1IpNQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX+qDn3B24Sd8A
 V1px3NSfuPM+qKX1uyHaxY/ofUvJBFb2SZiOHBlg2plpRl2OZtlZ8ujQ0p5LX+VOa6nvb/9YujE
 HwP46b4DXoCKl/hNevJsub/y0QIZ+TI=
X-Proofpoint-ORIG-GUID: MZvDt9_quZLlhwxHyyOXJXHOZCxqkEal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220087
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Acked-by: Yonggang Luo <luoyonggang@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20261016162509.24854-3-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/qmp-cpu.h |  4 ++++
 target/i386/cpu-system.c | 15 ++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/system/qmp-cpu.h b/include/system/qmp-cpu.h
index d2e7c76ca25..cbf8ae7867a 100644
--- a/include/system/qmp-cpu.h
+++ b/include/system/qmp-cpu.h
@@ -21,5 +21,9 @@ CpuModelExpansionInfo *
 qmp_query_arm_cpu_model_expansion(CpuModelExpansionType type,
                                   CpuModelInfo *model,
                                   Error **errp);
+CpuModelExpansionInfo *
+qmp_query_i386_cpu_model_expansion(CpuModelExpansionType type,
+                                   CpuModelInfo *model,
+                                   Error **errp);
 
 #endif
diff --git a/target/i386/cpu-system.c b/target/i386/cpu-system.c
index c8bbf0cbafd..f85dc4a7036 100644
--- a/target/i386/cpu-system.c
+++ b/target/i386/cpu-system.c
@@ -27,6 +27,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qom/qom-qobject.h"
 #include "qapi/qapi-commands-machine.h"
+#include "system/qmp-cpu.h"
 
 #include "cpu-internal.h"
 
@@ -189,9 +190,9 @@ out:
 }
 
 CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                                                      CpuModelInfo *model,
-                                                      Error **errp)
+qmp_query_i386_cpu_model_expansion(CpuModelExpansionType type,
+                                   CpuModelInfo *model,
+                                   Error **errp)
 {
     X86CPU *xc = NULL;
     Error *err = NULL;
@@ -241,6 +242,14 @@ out:
     return ret;
 }
 
+CpuModelExpansionInfo *
+qmp_query_cpu_model_expansion(CpuModelExpansionType type,
+                              CpuModelInfo *model,
+                              Error **errp)
+{
+    return qmp_query_i386_cpu_model_expansion(type, model, errp);
+}
+
 void cpu_clear_apic_feature(CPUX86State *env)
 {
     env->features[FEAT_1_EDX] &= ~CPUID_APIC;
-- 
2.47.3


