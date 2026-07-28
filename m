Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50539C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfu-0005hY-K5; Tue, 28 Jul 2026 00:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZff-0005Co-29
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:44:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfd-0001dR-Gm
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:44:02 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S40iM01594057
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=sad9HBSMldD
 1WYvm45ZsPh5hjuD00aSGBTbILxUZ4lA=; b=g99//DK4utYgRx6CeXw78qtegZ+
 b3pd25WBvraJzNz1p3eCAEU8VBRjznFYifXuhO2sG17M8U9Syr1iF5vuoos2HB9z
 oDQIzx+8pyfW51MPI2ZRzu2P9KsKT00dB549o8Dz49eAM81M2K+gDMi7CcvK3j9b
 OpA8K2koba9HqlFFLCazTJxL3eumbAO0SYZvzRSxC2wcA6B4q7ZCk22qmB+DEQgX
 FOLLOoeeHYCILluDAfT3P7pbbrGIWEZu78iz/AunA0Z47C/R+26bQ40ExjUuOTBg
 s3iT27BKzr5cZPsRI+T/bdHyiHVTgafttvAm73JHr5TWlhwN2YYNVlanCVQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19g43c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:50 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca7c1e22995so5508314a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213829; x=1785818629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sad9HBSMldD1WYvm45ZsPh5hjuD00aSGBTbILxUZ4lA=;
 b=AzZAd7bWMLlbOYanIDw9yQNBnOPHs/ok4SKW4bszqCUBZjG7UVhlQwv5yjrSJKcr4N
 sWy8OnCyh3l3g6eb1HcbWl8TsZk3Ei9bmDMGAAPeHRrrgIORI1XYgfUCCP8/ZJWwGXuV
 eDKYCUefsIGmLvtS/J01uWjgzxLPviJwSB1caG6dkrs8Y4uA2yvJZVVlPuq6H9ytzVAU
 7jgfT1TfzPSmyrkLQx4LO8MZLha1/tF9XfK/4by/60I6akI84otXaGlNEo2FaJQsvGyp
 nmfv2lg+F5RP1/viEs55xkY4mfNN2LLf5cGB32y9Uy2qoLZNdC+afA/XGc3bbyfGOO9u
 cdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213829; x=1785818629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sad9HBSMldD1WYvm45ZsPh5hjuD00aSGBTbILxUZ4lA=;
 b=IFx3PCBTI5/kfo7K1cw/2cnlRauHUZ6D2CUQea2BeF1kg6f8kDnq3EQhOEpz69dFxE
 nbrxsXFpikVLs5puw5oYuVDLQwP1S4NgiFd2qiJQBeu+KJyjKfXxj5GoaWC58aiYyuJ0
 Rxp0ZOALc5Pn9VDCHWPrX4ANnjvhJK3KU9etVYqbQqFN3pbBsA0z2PDTT71PXVVK9i0Q
 3D7JiVryc4H6FuYNvWw7H7iCLtLLdIXy0hV+32gwRAay1sgtIifup9NEFCDWyNZCbER5
 fuV9feN0u86Cpe8qlYvNh/Zymi6TPJrjEMDn7fTiFPPW0iASUp3no3K7laWjNwhtlqnC
 kD4A==
X-Gm-Message-State: AOJu0YxSHv+9KOz+GJeHI6D9a6pZyLBBkTTcemtiNYvgn6xNInR6vQpL
 ZuVJ4FdRvuagfgcAKGs1k+fheYW5lud96To9ACbj3nB6eZTvUqxgR++h0WOYHOPLbL1JUYVUR4j
 8JKgIkxvUXxy93mYinBrnNJhf9iDn4HpHAK4weRbaefwfdyBV0zMcVO4M+ENcfnAj0Q==
X-Gm-Gg: AR+sD10CVq/Rv3G9YsEGVIW18PhAZISb4KS8ObztWlpACY7qLtAhAiQm+Bx82ol/Lf3
 lTZYRKnvLbL6ZEpWSH181c1usArTCOy8vySQO6SCEJ7Vgy8znWWusMoD7jzytE19DNujf6LXFar
 paFcKbu22pgtOyahcZEV4+tCeXAyrdTG8/RldCxD8mLBE4KpCOyd4bbAVMQyOdvssmSdFkyVBj2
 xdIg6M7gmXOKmI3QVDzG8MY6tnXURzNiZsvkwOAt1tFcISPpSZHy5fe+GFIaD/JBZZ6s2JV1Rus
 n84xpLSZCEes6cTz4Oh+sqLhOufn83ixX+P7DWmf6xJMxn0QrasZWNtg+UMi/ScUrhj0VsK1bHa
 mRycE9I/LJ8wpD+hSFNuq7jHbwUN1bpafQoP1S3thRuhvtAO2moy8YJzCYpOb7tnInNLHm2Y=
X-Received: by 2002:a05:6300:228c:b0:3c4:2036:3032 with SMTP id
 adf61e73a8af0-3c8ba472ac6mr1102100637.34.1785213829460; 
 Mon, 27 Jul 2026 21:43:49 -0700 (PDT)
X-Received: by 2002:a05:6300:228c:b0:3c4:2036:3032 with SMTP id
 adf61e73a8af0-3c8ba472ac6mr1102061637.34.1785213829022; 
 Mon, 27 Jul 2026 21:43:49 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 032/103] tests/tcg/Makefile: skip user/system tests if
 target Makefile is not present
Date: Mon, 27 Jul 2026 21:41:36 -0700
Message-ID: <20260728044248.137626-33-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a683386 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=bQBZ4AfKrqIn4QZ8WyYA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX9sCBIU4KISA+
 KlrG9zojjKpYp9nY6yDWeYUL70OZ0wQ0yfP/rgeYrkJZJuH3//IYNwL3he5i0bB6UQOhMDD8FQq
 rqdxYVMNdunNV1qXzQsrB4+HCWQI9yvrbn5yS9fUfJTcOfdXIB22iDZAUswtq/FVnEuw6G3SqCZ
 q/kNgaf79oLxz8FhlC72Kx6rOAEwmmd24Xyc8csui9ahxTjIhP7ysqM2Ys+WP0W1WbG+oaIFmbB
 Yk29Cvz2/8YUcef7BM6alxa/PNwqqiHa9cSTOJPBroo7ZckZJYOKduOlmf2fr4TTDU7St8cpr0Q
 duRXKhtDWv3SQNunQNyP0Jw1t7O8EajXB8bd+fn1sAu6o4TMawbW3Oihyoz8LBD+YfXzHko0KIp
 BbwAmS6j9Iu3kR6Xr203V16xjohNuaFMq0K6rtVMZqIbfaiRemKWKbw9Oq9quD3v7FmN0vDTG5N
 UV1Itz7brnVilzGrjHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX1HIJzSHaAFZF
 dN+aFQms5FNSXjwpYgpvES1uv86UBXS+OByiHggwRxgEE+S0imvq3d3DRBaX4/mGrJNsf9OusUv
 jaN8GxXPHspf0nsF09NIY8atVgB+vXw=
X-Proofpoint-GUID: ZbHSUPR6mtXJi-AfxjH0F23I-Hru-SE7
X-Proofpoint-ORIG-GUID: ZbHSUPR6mtXJi-AfxjH0F23I-Hru-SE7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280040
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


