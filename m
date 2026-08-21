Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52FCC5DF97
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 21:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxWuA-0008Rs-D9; Fri, 21 Aug 2026 17:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxWu8-0008RJ-Bu
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 17:36:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxWu5-0008LJ-Kr
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 17:36:00 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67LI9xh24188056
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 21:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=9Q/9NxEPbhcUj1+MOfPPQVmI/UR1dk4OV4h
 4vZniAC4=; b=TdPKe2ScADrLaop8Tpq2O1OWKk+MTuAgmqGeOvhzkV0YndLcTDr
 M7va9xQpYJrf9BYasVlpIcJWumYeAz19GPEfNZGy9wloGVPlRaH/TUzvtGVCE9Sl
 3w2pHBzk6TvMX6L6XMvSpoEIEXrCOPxzE1ZlXqpNi94a8QDM3kOg5IXzeTlx4fwS
 kwRVbYcFGGID9xHr4u8DBxnv9kh0A9tamd43FHY9s6Zgn8j+FMraRTV08ReZ4oC4
 XMp6qwcDmMn4H7aifyJhDi/U5k+GjGbq7wgQQ/AVHUOzcN58gsgkigMqRpsZrSpr
 Sn58CPpgI3oKXbaDI/W5Il+YXx7S8mpqOJA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fg9umsf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 21:35:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d02df2bf09so13815025ad.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 14:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787348154; x=1787952954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9Q/9NxEPbhcUj1+MOfPPQVmI/UR1dk4OV4h4vZniAC4=;
 b=MNN7Ub3mTsujre0Ov3o+ASkvHfv6e2kyXQDkrX/osvB+RmKBEUE77xQpuNijdf+US8
 10KuIg4B90EjJo9o1ZVbyeMRVh1RsXFMUSRPffqBSc/ibPrrInVbvjMDSmZJ71CuellJ
 mishkqIQbvNPhFD7xG4FN8WtTN3WznOKFX1rzxGjLWu0PZ9Fh36660C3RCp8MDUjdhG5
 0HtR95cZWQPD4SdqbdE+FCxitqHtviCyzT0KnNX+vn/LVxGSgLm6J/OKntkK85LVVVIA
 82/g+lgMsy6aYnkbk2QVCciVGg6n72/gUi195AsxXjUdvZkG+Eq+F0PmRC3NJe1H4RZ0
 Ne/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787348154; x=1787952954;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9Q/9NxEPbhcUj1+MOfPPQVmI/UR1dk4OV4h4vZniAC4=;
 b=pv9OtRI4+12IXcNHIS8SsE3IiPIMFXWwALIOJxgsxYFKHXWvz7AxSUB4i+1EmOOL4T
 WvLDSxVQ6amupoRhdhV7oHQhXNZjJ2zcn6EWfb8KNCit6pGhEIRHqZp77CAhifchdPKz
 qY/Etqeoee3svWloqm6bj5ZCsE87z4lvxiBNEG8d3xU/fMxUTtMuZzlT1op7iDaQa+Un
 otIOFW9g1096ppnU1MRvpDmd8qicUlVE5Jflzk3NEJVrur+mmkX5LsOv1FLvcDOdwP7X
 2GNKUm38DA3tRdFpwCl/A7uDV7gXeYP31Y67stFVHE+p9MtMLjypLzc7R9ucUs20BOGy
 aG5Q==
X-Gm-Message-State: AFuF++ncRAx9cc4ZeW3Tm8y9Vvp8+iX+d5Qk8IVtG33lo5+7/J/+hzMw
 uSuBS+00sPBmBOREjTAuTWAJaOlxcMTsJmRIMuBHmHKVPDZ/5a0lVj8hOZYCY1KWw461ufa7NYZ
 pM9J3bEkTYOaSg4mrCCi3+54CbG30K+5j68Tn6FGLEBUt2wMmnb0IAYfZl8U8ofSNeA==
X-Gm-Gg: AR+sD11Ha8sYYB7lcQx2533Xa/DhQj3F8c5I+fK6OAgQBCsskEWtYlNwuUOPOjAE63j
 Ebg+9znnBDwzDxUtj0Cbchg/hsd+Z07lYNvbYEKnGcLVQl1DeQznxZTPkZ82VKHJ62Et8mhzyEN
 TRfUjGi4i1qIpjhsU7IZ3l4H37yd6ZvNeNV0TvkPPSev70lQLqcXtK2j+k7Q4I3njGAhzv89kfs
 JYDxt6C47Jfmgo+N//pKChhAXLt5K2BIqovDmmkBNwvDlDb+lijx+j9lJfWwpL1+t02DA8wNvHm
 bZsIjSzMWC8w3Spb5Vx5ODGcE9rBLgoVsj4WNW02fEqIHFhsLlknAO2T5UA0XAd+6edqbacxKB5
 Axj6GY5FiUS7lYjyldY2kGPgZ5/lfpbmDCu/P2ia1pZF7kCPt8p6aREPd0mc=
X-Received: by 2002:a17:903:46ce:b0:2cc:9179:335 with SMTP id
 d9443c01a7336-2d64ae3ac93mr188337275ad.8.1787348154419; 
 Fri, 21 Aug 2026 14:35:54 -0700 (PDT)
X-Received: by 2002:a17:903:46ce:b0:2cc:9179:335 with SMTP id
 d9443c01a7336-2d64ae3ac93mr188336555ad.8.1787348153981; 
 Fri, 21 Aug 2026 14:35:53 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d62d58a81csm23521445ad.21.2026.08.21.14.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 14:35:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] target/arm/tcg/cpu32: make compilation unit common
Date: Fri, 21 Aug 2026 21:35:36 +0000
Message-ID: <20260821213536.433273-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDE3MiBTYWx0ZWRfX/fpMFe3+wEYn
 ZSO/PkZ81XezTxmjtK6RQmrYzlBFyeLCqsdQJf4C6awhaz+RWUwM8O8B/Z1R4GunV3YFZSdUo09
 opgWw8/W5f30UI7p4QLSKa/4Rk9/HRsp+UR7x4STbnjLysQXB7+l+PijHcHyKGfiNtsSsa8wq52
 kWoOlEp6iNodnpNCw1BwOg3XUnUiNDwNPD5b85g+XH/HT+LjmBwdzcAweZW7vURiLA0vDppMWM+
 0MeMqJEzc6EfnX7DUMGFvvKqM8Dyrlk5pw9eMaCYA4rKsfApHLvQVg8oE0KmgfXZ2bo4pPnMVBV
 596zXUCumrXbl6RiVvwR83mFfmv8v0X1tJ4yXUBwZrdSbjSp/3J6Ep1kytB2DnI5KZKdbbi0TWt
 uwoMq36oqy4e7I4AG0Tm12DZLEd6npHbtq6xriqSqStzm4Y3zpLoOOAGx7yJ8XaQqYyh9meph7F
 c3raqR2dxNIVQWjVFDA==
X-Proofpoint-ORIG-GUID: 5oDA5QMITyuTCJPTVtcWwvfZ7NdlOAv9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDE3MiBTYWx0ZWRfX72ZYobmrQIz0
 +AijpF6FYfPQ3voWFrVEAZSH0aMyZUUlu0PyxZovcQ0ZU/CT3rxN3MlGIsHStnozoF9A5A+fokp
 vDffCbUwPplplySLGoqT8KPqUgSu1Hw=
X-Authority-Analysis: v=2.4 cv=Av/eGu9P c=1 sm=1 tr=0 ts=6a88c4bb cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=74m_pMBB0AtYWRivFzkA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 5oDA5QMITyuTCJPTVtcWwvfZ7NdlOAv9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_06,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210172
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

We just need to remove TARGET_AARCH64. Simply expose all the code and
conditionnally register types.
This fixes single-binary with arm + aarch64 targets.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/tcg/cpu32.c     | 13 +++++++------
 target/arm/tcg/meson.build |  2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index bc07e33877a..c0fd8fb83da 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -18,10 +18,6 @@
 #endif
 #include "cpregs.h"
 
-
-/* CPU models. These are not needed for the AArch64 linux-user build. */
-#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
-
 static void arm926_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -750,6 +746,13 @@ static void arm_tcg_cpu_register_types(void)
 {
     size_t i;
 
+    /* CPU models. These are not needed for the AArch64 linux-user build. */
+#ifdef CONFIG_USER_ONLY
+    if (target_aarch64()) {
+        return;
+    }
+#endif
+
     for (i = 0; i < ARRAY_SIZE(arm_tcg_cpus); ++i) {
         arm_cpu_register(&arm_tcg_cpus[i]);
     }
@@ -757,8 +760,6 @@ static void arm_tcg_cpu_register_types(void)
 
 type_init(arm_tcg_cpu_register_types)
 
-#endif /* !CONFIG_USER_ONLY || !TARGET_AARCH64 */
-
 /* Share AArch32 -cpu max features with AArch64. */
 void aa32_max_features(ARMCPU *cpu)
 {
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index cbfac0036e7..99dddfd45fd 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,7 +30,7 @@ translate32_d = [
 arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
 arm_stubs_ss.add(files('stubs32.c'))
 
-arm_ss.add(files(
+arm_common_user_system_ss.add(files(
   'cpu32.c',
 ))
 
-- 
2.43.0


