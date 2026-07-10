Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1995C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ27-0006E6-Il; Fri, 10 Jul 2026 17:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1q-0005fA-OB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1p-0003Yo-06
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:02 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AKtkXs1950649
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=sad9HBSMldD
 1WYvm45ZsPh5hjuD00aSGBTbILxUZ4lA=; b=GMbq8jdur2rRxDxADeKsjU+V91M
 QTuFQpzIMBCfVwF9kcyI1T3nNNo/S4hvlQM4zWjZe/Gt0jO+KStbZtykf7rhj7tP
 2OAkkVpXD12jc/wScvJotUk17DPLp5mc9/1exdBPboFI8dUS835PEccTYwnvPBzD
 YIu9o6siu/km3kVS5tm/+s3CO6aCXI/aV6UxTetmSWt7W7c7HSUuI2/FBr3u5PoQ
 6GjDhhz4jVbUhg5hgAenP/y+sDKEUeDeV7d4ya4BkffseemwaJKE7flieN4oSzXY
 unWH1TiKpxf0orxeIT28PHV4EdfXzgB3bYeJ2xF1mIrUM/lABj13xBXJclw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb86eg475-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c890bac374eso2577218a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719889; x=1784324689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sad9HBSMldD1WYvm45ZsPh5hjuD00aSGBTbILxUZ4lA=;
 b=aCCuRCVkdBlG9Nv0SZupmnoD2XV7yVnzlLuSnm1NPANOSHaJAiycv8QtboHD/BcZKn
 WqRsfaUkIw5cien6OUQt9CQ7Sxm8dSJ/mreRSl0cq2qXV9rYbPijqSZJxlmi2eAcyGgY
 PGtnka2DaRr5qdOsMGv5mo5STMtO15ZietsxnA5N97CuLv4Gv3dyNh8F4xUlV5v5E5i1
 hZo3fYizDcS6Lnc+vHQD5v+5d7Ow68K0dZBV8UcOuf27puBzqfex+gRR2/mS2RivnI69
 T+yYmL3zXaYiBflx9xMVZyV0LYpBnjTsMu+U4YzSInxhvzW2WLilGXdWXMRBUDW3L6h3
 W/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719889; x=1784324689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sad9HBSMldD1WYvm45ZsPh5hjuD00aSGBTbILxUZ4lA=;
 b=qLHiKl6cCL+42nE+BN15Oy0eghNquZJJkcFr6ajgwqb8Zm76q2SVorpF4vv5/684+F
 xkkDi55XN62HK7tXzIJcGAnMC4GAoEA13eOSFBwd78qUvp4CL2YR+mWVUOamnm+sptXd
 JNfl1tbh8BL7TaZJQsFymqU6hBVFT6o0HoF6/faHRZtKcWsFehlu3/DKh53gRBKkbF4t
 VBWEZm+8MVQTFpUzbuKFzV2LL03UnIiNnYOEjLTs/mYe9v52X0xs0lbJb/b1BdhQbU4U
 edBrYrBy1u2DR/tEP904hg+Cbe9Q631pb4QUzt0kUgpq6U7b/aPQ2Vm7k1b/Ly5H02Qw
 1Wzg==
X-Gm-Message-State: AOJu0YwjJpqo+2AklOmc0WPzCoFKk2Sv1m6XsNTr/hbiT9fq+QxgpJxd
 SPZwxyNKjFlL7Q4EZCw4Stblqc7Q3S9tJDVKJylW3fY32I8nOsJhxYSAIjl9OmJViSJALfXw8dk
 tsgiv2qhVkXYeDVY8b+ObW2GSwipuHoBqnQYxXRZ0FImr8NNJgH6Q0MMSgcYhSI4NSA==
X-Gm-Gg: AfdE7clb/asXMiRF1NggqiVdZKjzMnpaFxuNXp+KnUjdTdCdnyk7tXvWeDMkwza8MVV
 XdfolhRda6eCtrFuo9UAp29OcfH/etUlNYF7ywL/xKCElTFMGqu26GQnSt8PtRPE0++RbJfTP9V
 PMVoLRnBPiQa/L0FblKoIBXoJsyxpv7I+TVrLNG7y9gL86Pas2bm27rJTdUlKcvPq/qY0uN7dxS
 olZ77+MunUXOzwdq0J0a0ju576OFZeps26Jy26xQBHjUgv5AWDJh9X9JL1Tzx08t3tJypZ4UfeY
 93mRUWkGxKX9ZE3rqA5ojMO8nK5il9suZcytg486cwJB2pnURRrvGXi31Md9vZ+50kj5JgGdTi6
 VwYskoLNEHIZ1l2KCw4O8q4zkI+99GFJjD3at0UjWlDtUbB8+KecUw5hM/LbgIhoMG9Gb45fj2g
 kuDPzCew==
X-Received: by 2002:a05:6a21:682:b0:3c0:b9f6:96c4 with SMTP id
 adf61e73a8af0-3c1108cd47amr744929637.37.1783719889108; 
 Fri, 10 Jul 2026 14:44:49 -0700 (PDT)
X-Received: by 2002:a05:6a21:682:b0:3c0:b9f6:96c4 with SMTP id
 adf61e73a8af0-3c1108cd47amr744896637.37.1783719888674; 
 Fri, 10 Jul 2026 14:44:48 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 32/98] tests/tcg/Makefile: skip user/system tests if target
 Makefile is not present
Date: Fri, 10 Jul 2026 14:42:36 -0700
Message-ID: <20260710214343.2065491-33-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXxSoNyunvO3ds
 U5Aq2FAyZDwzyOyF2josQfrQugF3mWCAUC0DNnLAC/ragQYullte3zk9+LNI2Oit+bF2FEnqAjI
 B1oiMPRywHWw3Fo65st2Fv5Ho2StXCilSkOL+jmSP9LmxIYQ5+mIaQTCu/azX30pW6q/TrEnqhS
 ge6nsB1wWqDTB/XT5ahUJ+tDtWBQr6qxg0HS8qQN+LuOhYqXF5CtfDDGAjoV/BM+yvyvCaWPmAp
 GxeNtRJ3274x8rDpyIkxM/idiBnwFnjjzu7+NbllIkzYEcT8zcQWWyRXkBPleeacOxqvRR8+Ujk
 LA40SkE8Uy4HFPBs9KdpM3emY9QKQvYjkfvuIWmRGOwPsFoNEdt4hlmdpBYJLLHETPKEfntaALB
 0L/p8uX4CQK3nmSjiMRYpVC3xjMkLu9z/ZG2dVfBIcLGIgBZttGVXNNjrCsNPAWlzGX0slpbCCS
 KpEEHHNV2lzHmasGZKA==
X-Proofpoint-ORIG-GUID: KIP6bi8YfdyME1H7ljSiwYC_bnFmPl_c
X-Authority-Analysis: v=2.4 cv=IOQyzAvG c=1 sm=1 tr=0 ts=6a5167d2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=bQBZ4AfKrqIn4QZ8WyYA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX7KVM+YULk0Eb
 fp7I3v90hhzQXKYJ2528agbAMD3jfpybGDsNCY5k6jqAP8AP+SiLEOwnjA0DgOqjnyPVZp4+CBs
 K7s3g8aCi/T9Ce6xjKXaT64rYfBvg4U=
X-Proofpoint-GUID: KIP6bi8YfdyME1H7ljSiwYC_bnFmPl_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100218
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
2.47.3


