Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FBFC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziOF-0006X0-8c; Thu, 27 Aug 2026 18:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziOD-0006NJ-2X
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziOA-0006BW-V2
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:04 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLuwK848976
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pina9xUkpaimkxo7Suy/F2+7P6bGM9KsfMCG/iYljXs=; b=XALSQvr0iN8tDxGa
 e6faUXKRSUfcl801gHV8O+JYQnkZkoD71/9Oux5M6ChX9jLxKyoj8fOJfKWXBmcQ
 bAppyXJc4Q4C3R8yVKBnfgnnAHRRcKm2V7fA0QF5RO6q+dvselP3nbcvTICx79U+
 aqT062rhf0GFRsKsjGry0uM2GHQicACA9j+pTy9AVMdX4v5AF+qnG4mbxuEkw2H/
 ar1AtM5jViVWYgUi7XobcJC6wWZNgtrCMLW9+YX41hkS+EIa2eGU93mg387uuExS
 EJxlvn6tdE5b3gDAb6WV6ODSt0GXNa3S08D+LM4ha4cB7dtZ9vzhlici06mppa7s
 dTVDsw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ganr6a74k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1c2f1acebso594238a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868951; x=1788473751; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pina9xUkpaimkxo7Suy/F2+7P6bGM9KsfMCG/iYljXs=;
 b=OuCR8d1E+C6VfjfMlxvIko7QiWzJfmV8/sdkLTMIanaBuF6Iq5fkgmPMaqeUK12Fke
 qMyrGNy6ezqGehGtRF5oDNYgmAMZZW3ftUrnuVNv6hpu3wfCYfOh7vRtR4/b4PCqCT1R
 CQY+0Sfm/pYNwjjuMcD5D3rkOYYJo4u200W9WsmmnuY6ebaFmx74QBVOreYhfJ9MMPYD
 C9ZCzE5vI9WLqE4AjuQVEOtWHTwTpYt2CJjKUyJYUGq6EjVOmedmc58Z01gC7Nm9dmTu
 LMEyQf93jGcXXOzq5/yZ3O9W/qWAJ5fVBwRmZ+wvPGuhjEbcWysFModAeaDpoHQTSWie
 JyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868951; x=1788473751;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pina9xUkpaimkxo7Suy/F2+7P6bGM9KsfMCG/iYljXs=;
 b=aRLhVqSIssDwb3jLApo5ucRyUFa9LssQtcOBED7yAD3Fq9ggFch6rUz7wn4xFHPEoM
 zd08eNmzOVYOwxQxkr+SsjD0KDWJk/C3JNc77CI+YhiDWBt2g1jf+G41q+HJ7DySJdQ+
 z+7zFjnK/8zjgOqJhqeGKJEznbfwWVzQTCtD4tf1ZpPR7ycKwhy+IOCQipiB7Sv5xmRQ
 1YvoReZ/LH+gxw3hP0MVo7HD+jtL6eCjx3oeEWN3hbcbfOi5WOceNhOnaY8PH5AnKBRO
 QPHqGPwsjVpAltf/4DICgkaQ1WtByt2ykQS6Kjh8M8u5IwQZqjsyHzbUb9rH9ECLU2E1
 LYaQ==
X-Gm-Message-State: AFuF++kYezjE0PTy4kMFaWMvIVjZbrb1BKRYE/65V0X7Gl28uP5Z4k6L
 zVQWMk3Y1PRAaV/RxZx/e+N9YGzBlZb474+2sVwVI0+P7/D4xq+8ztIU9TaVH2mg88pyf8RA282
 PGKoK8KzGaqeORVFxuz5VcqCIr0nlC+hls8jcCm9pEZaocaQQ/LzM3/qXZUl5+UJaWw==
X-Gm-Gg: AR+sD13ariCsSm0K+E2kDqY8Xv9DKQTVrweEO1jV3ib4tIi8HTxAHjHaPgvSgyJtiUX
 xoPH5Gl/6utUV2yDG7PyT790+p64Mc+HFfVbcatPC2Pvl2T4Fb5qVTHK/+k647WHHLxHFFVwq9B
 XhSG2iNHegshIIiHjTrs1Uf169KCE3ZmeRZx9ysM6EpIOsF/h+fVCH1ryekDNnVcSaOhD2Nq9+r
 vnNyVnrCzyCVkx8o1L2/fhbQYUMCl4hYxxiZaYgPdU7HQLSVLprRiVOYl2hj2flRiIenVLqkHE9
 GoZs7wPaqhrGowFKKcplFOB6utCpHyS73LiL091uIYPt/0I7OODZ1SltZArvd5UKVeS7IU3dFJ1
 gTgqWGPVJEafT2pGrx13v3De0VXCyYOpIh1OA0paCJ1jVjDuTkH7lnCp1Q1A=
X-Received: by 2002:a05:6a00:2913:b0:84f:dc19:b77d with SMTP id
 d2e1a72fcca58-8562a2f3ea1mr4541032b3a.12.1787868950997; 
 Thu, 27 Aug 2026 15:15:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:2913:b0:84f:dc19:b77d with SMTP id
 d2e1a72fcca58-8562a2f3ea1mr4540948b3a.12.1787868950555; 
 Thu, 27 Aug 2026 15:15:50 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 033/105] tests/tcg/Makefile: skip user/system tests if
 target Makefile is not present
Date: Thu, 27 Aug 2026 22:13:54 +0000
Message-ID: <20260827221506.91574-34-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX6nllrnDp4In+
 sP7MYyNF1SDsc+JkDEDhZFogebA747tSyvflW24hGcz+1uD0TruTOknv9O2lxnNqu9dzisrNrH2
 H6uBbuIKjyFQaePSiorjKeTlqKasTLxGrtyCLD2isQjfu0m6O19dW5gv4YxxPPRVrPZjXEx+uUc
 0V7JvIEcpMovbHxubQNGeQ86/vf8PKdyR/0W0wUyyibna+fLZ5CAccOVGKXOEguiubSzGGf4gV/
 MQyuBHUM0E2vgxPJYvENskQl8q9S+jXISn9A2nJ3sk4M2zdg3DTMmLxclnto2ajctSey8sb5iV4
 PDvRF+Fb8jjOcdtBRK9p9rs3wRrlAE2NKQuYLxFIrI5H8j+h5yBtXXVouGtg/WWRajZE4WKVbsX
 Mr0QBt2l9ZhAYKmk91pwTm91nG91lMV/rAFohgLZqlasQ9oLGMIn8PotluMxQmJQo5Ea2sTQrDx
 zn8IFNEIKjoECfVXJyg==
X-Authority-Analysis: v=2.4 cv=d5DFDxjE c=1 sm=1 tr=0 ts=6a90b717 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=bQBZ4AfKrqIn4QZ8WyYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: pqOphxeNULJY4Az38hOiXuQKTjGdIvdw
X-Proofpoint-ORIG-GUID: pqOphxeNULJY4Az38hOiXuQKTjGdIvdw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX47y6X/Bd2iJk
 e2NWU6/znmZ6tMAJhYUGcLz5j46T65JEF9vRTV9bx021uug68cqWP/VVjI6Pjv0QjS3oxJ6jnnu
 7H4+AOFDQglk9hBDWiQ7G/yEHLdbKgA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

In the next commits, we'll port each architecture from Makefile to
meson, and it's easier to review those changes if we remove Makefiles
step by step.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/Makefile.target | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 1b83824ff4e..836fccaca23 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -105,7 +105,9 @@ ifeq ($(filter %-softmmu, $(TARGET)),)
 # $(TARGET_NAME)/Makefile.target to include the common parent
 # architecture in its VPATH. However some targets are so minimal we
 # can't even build the multiarch tests.
-ifneq ($(filter $(TARGET_NAME),aarch64_be),)
+ifeq ($(wildcard $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target),)
+# skip user tests if Makefile.target is not present
+else ifneq ($(filter $(TARGET_NAME),aarch64_be),)
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.target
 else
 -include $(SRC_PATH)/tests/tcg/multiarch/Makefile.target
@@ -135,7 +137,11 @@ ifneq ($(filter $(TARGET_NAME),$(MULTIARCH_SOFTMMU_TARGETS)),)
 -include $(SRC_PATH)/tests/tcg/minilib/Makefile.target
 -include $(SRC_PATH)/tests/tcg/multiarch/system/Makefile.softmmu-target
 endif
+ifeq ($(wildcard $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target),)
+# skip system tests if Makefile.target is not present
+else
 -include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.softmmu-target
+endif
 
 endif
 
-- 
2.43.0


