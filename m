Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF157CA5FAD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBjeS-00089G-14; Tue, 29 Sep 2026 22:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjeJ-000824-Dn
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:02:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjeH-00037x-Jm
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:02:23 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNPoSe1352929
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Q+E1/FePMnb
 QDEyy194apExFFV2m1Q7X1+HpCxYOrzg=; b=h7E0u3bH2GyhJRQqFhtzRFd+BV7
 DqR7ZhqODSJjoEBFQnIvUW3u31KGta3WcgaXik4PoL4StH/dO1H5UmGCgxsKCfuI
 Y2OD5Pog3wZmX7UdBNv6WrzC5rpt04W/HyqTtXJNJqizhR7Xvh7uZ6QV+xaOEyb+
 L6UZIh8rEhfOxgTs1aLtLeX/YpptjhrzJ+lMHMDtnt8ERgYEte7RtYYlgw26iCki
 Qukil8p2jv5tryI+qzVYUNumen8EI0ghtTtl3oOjcMIGVyW+aGhwQ+g8AKDeghQU
 3EBp+ysNjXzb/DPZs1J8XCW+DJST7U1In/yI02IO5cTK+FHsyO01jx8PlMQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0eswjs20-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:02:10 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso1728904eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733730; x=1791338530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q+E1/FePMnbQDEyy194apExFFV2m1Q7X1+HpCxYOrzg=;
 b=S04JFSSS8p1fZO3yEtfgN1LFclHfkJTIgu51hRRh645JzP1Sq+ZGGJGszibMRTDqP5
 GKZoks9THgpgDp77d6j5/Y9i1su49UXkpr5TSDFAHNCa6RTZwFCPRvxzlOsFWQrjmeTR
 al5thPDWUh7H0Rm/h1UjCp/K9kWXNVDE9yZGOmUiKZWnLuxe7cCZ28rIeBsh8Zs/F5bo
 spziHKJ+fRlFJiLAgAIZy3PP5NdYTCPXdywdIZzXvSjmWznTIufF9BBt6gGUyt8E0uBh
 mLh8d17Y7Fyzofj+lrMxhy25TZxy4BV7V+RY+YyoNCgcVZZMoTdyP2sHCyaSjns2DPfn
 ubkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733730; x=1791338530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q+E1/FePMnbQDEyy194apExFFV2m1Q7X1+HpCxYOrzg=;
 b=eaImk8Lr5fupQFkI1/rDhnj54hUmun09mZ5M+c3Vbd+6QQyzD6PKG0vTcYFIVJSVYq
 j2YjEX/Pxwhmjay1OZTHjuqcXN77z4Z0qv1UxQV+51Ufkvd0frNXbT3b10a6PTQXduCB
 O+5cK9ehPAHzmeh3iX0V4w8k1A4iaigoybS48GCh/zC20KM24xullEyBHo0dhlMdWctc
 7n25jdS9huN+j5UJEehNeHAKVym/vLNeglqbYMqFQ8yTbkPN6nMX5N/UjP3c0DOCP3n0
 flS7BLEYFhujzDuSmyW8iTa5PzdmFc/E5DpluXcr0hfcldC5nt1Dg8biuYLc8dxer3sJ
 EpqA==
X-Gm-Message-State: AFuF++nlEeC8qv/GQKAmSQYfzEqCXF0/QYr+ySPRsFG9oo70o/gW1cSK
 s25Y1qCdBj0nL1524iilyTdExlePVJoPtIPJN+yO4gYrZhUcsxz9bskog6tqow/yFCqWeIwsA9N
 AqdqjZjjHhp6IVsZw2Hihr9uKhpZNQAqsWyMjBPBW/ybcz4FLWUavmi48ZG/lLdL9EA==
X-Gm-Gg: AYBFou2gkjoGsCDtiSqH3oy7FU1IoDM3JD2LEGTE44UhelOjZ0JQO6s+yq3sp61qcEM
 UJf0Q4wr3FNkbF9gVNxfwp7cJ0bGKxT5MhK7t1f2EsepowmGL5Sxrb+TmxZw/vmNvIsrMN8Q839
 nEyw77z3bInFjwzWy8XkEJCqKTOpQzG/4Yf6ymnteHrZHAcAZP5WG2z34nrGHghNzXt440atKFm
 WoIJq3g6By4XGbB+RZa36XREZv5+B5v67C7LeiF6D3Xf92LaaT7u4RnCr6Nzc/W/bztQgnmHNa8
 rTgUSfG8GEJBtyeDGBKsbPh35qqrX6FPcfCizHP2mDWeBKKIqHleK6XaLPkmHkVwKJ90UWWfPEw
 sZ1oxY4I02jDyj+YwHt9ji/yUlqzux18B9xKdwiWa8mFMZupoxc7Xo3E8xV2i
X-Received: by 2002:a05:7300:c8c3:b0:341:c6ca:1df3 with SMTP id
 5a478bee46e88-34cdbeca2a7mr109952eec.14.1790733729536; 
 Tue, 29 Sep 2026 19:02:09 -0700 (PDT)
X-Received: by 2002:a05:7300:c8c3:b0:341:c6ca:1df3 with SMTP id
 5a478bee46e88-34cdbeca2a7mr109927eec.14.1790733728889; 
 Tue, 29 Sep 2026 19:02:08 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:02:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 20/21] target/or1k: prefix symbols conflicting with other
 arch
Date: Wed, 30 Sep 2026 02:01:07 +0000
Message-ID: <20260930020108.217892-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfXxUGXReAvMi4l
 lq3bMRdZnbUDL8LN9xtefY5uS5xeInO05Bq4AowF9198LcS3Jvg1+ex7PzKF+vT/RiojQefLlja
 GLEWT3FZ7PayVSkym0Vf3Qy/foQ+0u01U8lkD1J6nW1DOlnC3cbWUbdJ0a0AJW34Wg+4TYzP4Gh
 oc/PJ54/CqYg0a1TNCl8oxpoPzyuFlJmgqLobZHp/v4u/Tz32S/YVFh6NShAVd1LUrYYWqOGCnQ
 aLuV5mwAvJ5m0q1BCryYPwbltdCGswMv3SBkhh9+hep28ncvUIj7iBu41QyJ7KAQtUgyPdu72Fy
 ADKeREnC/uijZmDZwHENZKeIJY5MtjBNniyuKkr3HU+RrCZtaGeMyBpmah6SSHw94tfyb8m8URA
 0AnQr6l0wdxPPyW1zNNtBL4krGvDVeAHkaiwpfj8+yFXxVEimnOMlAWsRdn6cgm+gF24OXOacWj
 PLic3K6vFw+tshziRwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX4AznSq0Wj7kS
 GtATFvPIx7UqfmuvEVeA3jf0caGEOx5Xb2g4e4Szss+5CUatot2S0I7O63BGn1toDvE7N23VyPL
 t2K91kOlpE+RoKaixZg2cLhHilLfBIc=
X-Authority-Analysis: v=2.4 cv=LaWpeTfi c=1 sm=1 tr=0 ts=6abc6da2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=jjLCjK4Ajx7i9SFt9zwA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 8c5E1X2Wd4WEuSbIa6VByo_G8tafmI4R
X-Proofpoint-ORIG-GUID: 8c5E1X2Wd4WEuSbIa6VByo_G8tafmI4R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300007
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/or1k/exception.c        | 2 +-
 target/or1k/exception.h        | 2 +-
 target/or1k/exception_helper.c | 2 +-
 target/or1k/helper.h           | 2 +-
 target/or1k/interrupt_helper.c | 2 +-
 target/or1k/sys_helper.c       | 6 +++---
 target/or1k/translate.c        | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/or1k/exception.c b/target/or1k/exception.c
index 0479a069592..785181ef2ed 100644
--- a/target/or1k/exception.c
+++ b/target/or1k/exception.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exception.h"
 
-G_NORETURN void raise_exception(OpenRISCCPU *cpu, uint32_t excp)
+G_NORETURN void or1k_raise_exception(OpenRISCCPU *cpu, uint32_t excp)
 {
     CPUState *cs = CPU(cpu);
 
diff --git a/target/or1k/exception.h b/target/or1k/exception.h
index f62fc314c1f..ff42f91d2a1 100644
--- a/target/or1k/exception.h
+++ b/target/or1k/exception.h
@@ -22,6 +22,6 @@
 
 #include "cpu.h"
 
-G_NORETURN void raise_exception(OpenRISCCPU *cpu, uint32_t excp);
+G_NORETURN void or1k_raise_exception(OpenRISCCPU *cpu, uint32_t excp);
 
 #endif /* TARGET_OPENRISC_EXCEPTION_H */
diff --git a/target/or1k/exception_helper.c b/target/or1k/exception_helper.c
index 3bd82b29719..a5c21d1b65d 100644
--- a/target/or1k/exception_helper.c
+++ b/target/or1k/exception_helper.c
@@ -27,7 +27,7 @@ void HELPER(exception)(CPUOpenRISCState *env, uint32_t excp)
 {
     OpenRISCCPU *cpu = env_archcpu(env);
 
-    raise_exception(cpu, excp);
+    or1k_raise_exception(cpu, excp);
 }
 
 static G_NORETURN
diff --git a/target/or1k/helper.h b/target/or1k/helper.h
index e0a8d402271..9f74bed93af 100644
--- a/target/or1k/helper.h
+++ b/target/or1k/helper.h
@@ -59,7 +59,7 @@ FOP_CMP(ult)
 #undef FOP_CMP
 
 /* interrupt */
-DEF_HELPER_FLAGS_1(rfe, 0, void, env)
+DEF_HELPER_FLAGS_1(or1k_rfe, 0, void, env)
 
 /* sys */
 DEF_HELPER_FLAGS_3(mtspr, 0, void, env, i32, i32)
diff --git a/target/or1k/interrupt_helper.c b/target/or1k/interrupt_helper.c
index 1553ebc71b0..91dd2227442 100644
--- a/target/or1k/interrupt_helper.c
+++ b/target/or1k/interrupt_helper.c
@@ -22,7 +22,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 
-void HELPER(rfe)(CPUOpenRISCState *env)
+void HELPER(or1k_rfe)(CPUOpenRISCState *env)
 {
     env->pc = env->epcr;
     env->lock_addr = -1;
diff --git a/target/or1k/sys_helper.c b/target/or1k/sys_helper.c
index 8ffa31b84fd..ee0cc434675 100644
--- a/target/or1k/sys_helper.c
+++ b/target/or1k/sys_helper.c
@@ -58,7 +58,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, uint32_t spr, uint32_t rb)
     }
 
     if (is_user(env)) {
-        raise_exception(cpu, EXCP_ILLEGAL);
+        or1k_raise_exception(cpu, EXCP_ILLEGAL);
     }
 
 #ifndef CONFIG_USER_ONLY
@@ -157,7 +157,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, uint32_t spr, uint32_t rb)
             cpu_restore_state(cs, GETPC());
             env->pc += 4;
             cs->halted = 1;
-            raise_exception(cpu, EXCP_HALTED);
+            or1k_raise_exception(cpu, EXCP_HALTED);
         }
         break;
     case TO_SPR(9, 0):  /* PICMR */
@@ -231,7 +231,7 @@ uint32_t HELPER(mfspr)(CPUOpenRISCState *env, uint32_t rd, uint32_t spr)
     }
 
     if (is_user(env)) {
-        raise_exception(cpu, EXCP_ILLEGAL);
+        or1k_raise_exception(cpu, EXCP_ILLEGAL);
     }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/or1k/translate.c b/target/or1k/translate.c
index e00ef45b9b7..6972dc7d630 100644
--- a/target/or1k/translate.c
+++ b/target/or1k/translate.c
@@ -1110,7 +1110,7 @@ static bool trans_l_rfe(DisasContext *dc, arg_l_rfe *a)
     if (is_user(dc)) {
         gen_illegal_exception(dc);
     } else {
-        gen_helper_rfe(tcg_env);
+        gen_helper_or1k_rfe(tcg_env);
         dc->base.is_jmp = DISAS_EXIT;
     }
     return true;
-- 
2.43.0


