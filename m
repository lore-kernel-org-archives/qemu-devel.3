Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B98A606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aI3L0mTg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gBeyw+rR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOcMt-0006LC-Pt; Wed, 04 Nov 2026 09:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOcMr-0006Jl-9x
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:53:37 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOcMp-0003gK-K5
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:53:37 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4BZt23608380
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 14:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mw6RaUGCbl+/ZnFwaHsCCuDpOSYFCgHjsN4XoRXijlQ=; b=aI3L0mTg+gz/YEF3
 zp+sArsgVuoopjtr3qP1GuWrPgTERhmHarPnHXuaLFyhQHuILFw9ueKmkCIhr/re
 WDdv3tzdxabPy+YX/6GYu2a/Aq6/3tbwBdJU5bjSG+CmP6SoCfqhk2b4lbF08h2+
 Q/0wEdm+A0dQmlcaB+1BHG5Uafm8mQlwg19VW3pQS1Lvdt2jlTtHFOP7qO3IZMXP
 LNKBawoiMPtxleiohXZQoQbjLt6CkLz+S40E+l5rzh2cXSBT0row21RPbsVHGRL0
 wuEZ6l+N+pAMYXQN0cB09IQe04UabeOUWgem0wxFqvnKuIXaH/qO6cyRjF5Y8bSJ
 g3ZFgA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr3r80sqb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 14:53:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb71b1443so197968385a.2
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 06:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793804014; x=1794408814; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mw6RaUGCbl+/ZnFwaHsCCuDpOSYFCgHjsN4XoRXijlQ=;
 b=gBeyw+rR16nKXNiiEahYl5qUcqIz+rQYayxmAbJ6Ny/S1tFmtr7t6znuOdfGg4O+ao
 Clt6pxG26nZk/VSGvt6cZ/02bFsx69cN88OpqKwk42WGQHtnUVZGSU5w1/69ik28NTJr
 dG91HCvbJvg9nrfI7eny5tyU6fFJnjdCVtgtZ6vBbXxx3rc7jjMtnw+y6+vqfiBilFXy
 dIziq9qk9C12eFNv5u94zChn2qKhipPJGiGYxGLF8M84RR7SEymVbZeJsXSZIMN6a31a
 6HF1nLhjYWvtCU4/bspI064i6ib5B1cf+fD4C1VW+ZByZTAiLTYifXk1SQh99XXQUPpW
 fJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793804014; x=1794408814;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mw6RaUGCbl+/ZnFwaHsCCuDpOSYFCgHjsN4XoRXijlQ=;
 b=gt+9hneI7Q4CeGICGC4aeSQzEOgjsYmNTkKdcGdfBQgJid7z5yBSlIOxL2v6wW1LTf
 wlFOD+Epi5R4n4ZeDKsCq3JJ4eiwgKfBVCRGK6hssQi7Fn7V/JeCnRstHU15Td8J0TnN
 RIalGxchZDNAOPwduxXlZ6n9Eh/PNvpkHf2/0YMM9ccZc35f5+oll/eQO+5NJcHCPFmW
 nfKjkNpJUe+jIuKP4l0TbPAhsix8Lbnu1SEMyaXhai71g/6UeowBR6Ew4I+/mlh7+jeg
 DhiyzUH/sN8aynHIl1dSMAOZ1LHVHwMD/gXiTMmyROexUuItv1Rh9BMLDm9tLPMuXgu1
 EDew==
X-Gm-Message-State: APuU4Z9TwHfOrcd6QYlmTX/W41dKCnzJjrLs0CcRgVBvLEnnSnc9f05J
 pFzsnrK0fZCrVqRxpdc1y3vWcYstnw+7Kl/dNC7FZGl0Lzi8N2v/9Td1lFN/Xwm1FBkCofo2tZT
 BufYIAUT2HTxruFNzdE6NVkM4U9m3/3iwQg4fc4pBiX3E6cXIdUe9nLm3fH9EDfiHYg==
X-Gm-Gg: AYBFou3Chk8R1CUvmN1ICRhrOjMFjGx0Ot0SOy9kdDAT45D0PCAT3Ip5E/0Nl0w6gmz
 ItLk3uVOSToP3oto3SUzuaIHXH2qyBFAtrloGiwnfTY8UWN9ibT2k5ODs74CkBT+sABa1f8aPaR
 eWKZ6gxgY9FlQP9siSyJZGYMk5mTWjHvS+qjs9ob7wGxwwxQnBEzYEELM2/Xr4IfHoLSdvu32Fl
 kSLB7SZErOeTUHCEKcfXbU0/j90W0YVPPjPVGABKWAy2o0UpBXH4J4sUraX5+IVdI+Au352Ay7h
 M3FLEqNh4q8yFrDKoHb/9cs7ziogrdj4CUmA5/wy3IUFeA6GqZN2t39Hss8J2aqb5jDTFycbgYB
 AzpTkzSoc6huN3aQyTo8Z1+KO4HtAak1d4zTDv19kXuzMdAm1cZea6wTnvc93H+NfKFTjo8ZL3K
 avx9Zs1ouSkrKWoQ==
X-Received: by 2002:a05:620a:3183:b0:93e:f4f4:346 with SMTP id
 af79cd13be357-94421796ea3mr2706735185a.39.1793804013546; 
 Wed, 04 Nov 2026 06:53:33 -0800 (PST)
X-Received: by 2002:a05:620a:3183:b0:93e:f4f4:346 with SMTP id
 af79cd13be357-94421796ea3mr2706731185a.39.1793804013091; 
 Wed, 04 Nov 2026 06:53:33 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b414b170d0sm42239525e9.1.2026.11.04.06.53.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Nov 2026 06:53:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/5] tests/qtest/npcm7xx: Replace deprecated sprintf() with
 snprintf()
Date: Wed,  4 Nov 2026 15:53:13 +0100
Message-ID: <20261104145316.18841-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104145316.18841-1-philmd@oss.qualcomm.com>
References: <20261104145316.18841-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 57DMq70dO_RMZjQyN_uT8-MQFYL6HXy3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1OSBTYWx0ZWRfXxbWp+cLYtMpG
 Sf3YG4SI4p0N3kzffJBCO2SxW7SBP41ndeGlGNkoT7AqANowJ5GhRsXX2wQHTbEWRhHcuPqZkKi
 ogsBA9UvhvLZstpKEx/dtDOTxt160+6kFTZYtnQHz5P3YG4Ge6LAaxRgIqDj2tpxyKx9fdmCXUT
 4h9f4t6Z/OihvkGnEMcPChPpgyNz5fjn2Z/+2wj31Vkl4hKMb5hyJh/fp0tdyG/BNwO/5FL9MvG
 WPhkLvHYaMiye2MHwENdLaXRlIgMeLF1N6w5jKoEwLr8uXwsp8HJSmOqFItW5hpRYfsd0QuiYGJ
 kH/9feEL0FrpkSNky3U6jwkX1YW7sE5C+wGWOAq5c3wnpQCy8Mi4uNKiEtcKWKCwGKkFU8V+wI+
 LR2iuKw0NqhczYwU+TItKNZgbG6SMuZukWaKbJjHbs4iwJWE2C9gBpZHOrQyzJ0UKMTPExRmchP
 7HV/lPPFaXPHDY3S7yA==
X-Proofpoint-GUID: 57DMq70dO_RMZjQyN_uT8-MQFYL6HXy3
X-Authority-Analysis: v=2.4 cv=UuP2pOwB c=1 sm=1 tr=0 ts=6aeb46ee cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=BSerAQQimkaHbVtXvo0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1OSBTYWx0ZWRfX7WQZ4rZXzQdC
 rFSEJJHE6s0u4D+eIBuU+1skmupjNqyvK352qBMxUey4MLnxf4KKrE38tSFNWD8RyMIscCsLie+
 Ga/RV7wMyyDw+O4C3a5FqbkytsbS0DM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040059
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace sprintf() by safer snprintf() to fill the QOM path and
property names. This silences when using Apple clang 17.0.0:

  ../tests/qtest/npcm7xx_adc-test.c:140:5: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]
  ../tests/qtest/npcm7xx_adc-test.c:322:9: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]
  ../tests/qtest/npcm7xx_pwm-test.c:244:5: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]
  ../tests/qtest/npcm7xx_pwm-test.c:245:5: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]
  ../tests/qtest/npcm7xx_pwm-test.c:255:5: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]
  ../tests/qtest/npcm7xx_pwm-test.c:256:5: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/qtest/npcm7xx_adc-test.c | 5 +++--
 tests/qtest/npcm7xx_pwm-test.c | 8 ++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/npcm7xx_adc-test.c b/tests/qtest/npcm7xx_adc-test.c
index 8bc89b8a8b9a..f2fee1c32c81 100644
--- a/tests/qtest/npcm7xx_adc-test.c
+++ b/tests/qtest/npcm7xx_adc-test.c
@@ -137,7 +137,7 @@ static void adc_write_input(QTestState *qts, const ADC *adc,
 {
     char name[100];
 
-    sprintf(name, "adci[%u]", index);
+    snprintf(name, sizeof(name), "adci[%u]", index);
     adc_qom_set(qts, adc, name, value);
 }
 
@@ -319,7 +319,8 @@ static void test_calibrate(gconstpointer adc_p)
         char buf[100];
         QTestState *qts;
 
-        sprintf(buf, "-machine quanta-gsj -global npcm7xx-adc.iref=%u", iref);
+        snprintf(buf, sizeof(buf),
+                 "-machine quanta-gsj -global npcm7xx-adc.iref=%u", iref);
         qts = qtest_init(buf);
 
         /* Check the converted value is correct using the calibration value. */
diff --git a/tests/qtest/npcm7xx_pwm-test.c b/tests/qtest/npcm7xx_pwm-test.c
index 052ea876621a..cf24ba8de346 100644
--- a/tests/qtest/npcm7xx_pwm-test.c
+++ b/tests/qtest/npcm7xx_pwm-test.c
@@ -241,8 +241,8 @@ static uint64_t pwm_get_freq(QTestState *qts, int module_index, int pwm_index)
     char path[100];
     char name[100];
 
-    sprintf(path, "/machine/soc/pwm[%d]", module_index);
-    sprintf(name, "freq[%d]", pwm_index);
+    snprintf(path, sizeof(path), "/machine/soc/pwm[%d]", module_index);
+    snprintf(name, sizeof(name), "freq[%d]", pwm_index);
 
     return pwm_qom_get(qts, path, name);
 }
@@ -252,8 +252,8 @@ static uint64_t pwm_get_duty(QTestState *qts, int module_index, int pwm_index)
     char path[100];
     char name[100];
 
-    sprintf(path, "/machine/soc/pwm[%d]", module_index);
-    sprintf(name, "duty[%d]", pwm_index);
+    snprintf(path, sizeof(path), "/machine/soc/pwm[%d]", module_index);
+    snprintf(name, sizeof(name), "duty[%d]", pwm_index);
 
     return pwm_qom_get(qts, path, name);
 }
-- 
2.55.0


