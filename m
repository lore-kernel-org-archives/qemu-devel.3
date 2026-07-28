Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9867AC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZj7-0000UH-Jx; Tue, 28 Jul 2026 00:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZj1-0000Am-VR
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZj0-00023T-5k
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:31 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3alux1423461
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 abgSaJmyu/oDJ1AvF41ojTOcwpU79VteR0y1fwOQg8A=; b=CBVyC8xPEeds9iOb
 0a/HUiLj+cPTKeJ06YIAaH6L5peJsjrBPTJh0lTC/Ja25+R/Xp4s7E5jpYnKDwHK
 ukNctui0Trd3SwU6Lari/0KXZJuoneTEgh6ns5ignSTG2InFglITH74zS6ynu2dr
 72tV0bVpWsZahHIyjeUcnDMoHgEKH3dukFo3c45Tprdn9r6B/SEa3/Myu8/dPR8f
 4J2RYFGAiyQym3S1niZoKG0n2j392rpVgNQ7P2PD1Nlm1sgr/F2Bppqbb8ELQMJI
 oO9clHlvVVjwGAEBDyML3G6oJSCfnneU5v55Bn8Lpo2a1OKz/DwtzXiWUGcAZu5N
 CvjuGQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp3v2mps8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:29 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbb6433e9d4so4349598a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214048; x=1785818848; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=abgSaJmyu/oDJ1AvF41ojTOcwpU79VteR0y1fwOQg8A=;
 b=X9259+kiOimsPGxy7uYJQ2PpmMiYTvvvTpvIw1CWT5pDk5KTuDC2rDYgY5gMoj/rPj
 TWOMmsEF8sz3pJPecA2xkLbglu5ux+lYLu9wcxlkq7X4eqTBVL/jUGOSCCzY/kTdNvLZ
 2Q12bVjXRro9Z/XRbAFShF0iXRN5+KB1q3enINbNvU7Jqv3hjojCiD09mi66xDMxt2+d
 B7hRe+NaQgldGeiB8P212UVs3c944E+MtnwTlMCLkMh3a8Ea5eTc+SjXr2FV4SfuCvVN
 a0Rh1loWdOc66MCD2F8DNGDg9RMQx5YGDpsGdPdIgeOYLA6yznjMUAJ/CNZauVJfFikA
 5PCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214048; x=1785818848;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=abgSaJmyu/oDJ1AvF41ojTOcwpU79VteR0y1fwOQg8A=;
 b=qS6rhGsIKyV9kvK6N7BGxxOKkF8qGdiQUDcbySMHLJGRcwjhXNRWE+73Qv7SGSs0Wy
 CuyjsKIKcE/iJx/isZxcYFaI09v99QWfeKH3jB7RNZFXS7sx0LMlMgyCRlixrRyhi0PE
 GEJd0UIQl2WV7gcl7rHZPmliLExDL8ZnL1U9irOexEPGWR5HbfYLxQ71QYrw19E0KbQb
 SD9V/M6YiDHo1J0Jq07Vn1+gn4RYQgo8Z8XhujtNeIcl/6U/J6VuWuvgLVJIpNjrn0X3
 oR1BWNeyw0J8k75Jmi/EQQcCpN+bLNN6aXegyMr5PPZCQrbWfX6QbrqSD7a4W+f2d38e
 yX1Q==
X-Gm-Message-State: AOJu0YwCAFu0F3EaNDhWtlu6L5ONXyuL5B0zYZbHNo3OQIt/7fOsjQ7m
 DX2kYHz6y1C4SlbGnUdAVnKpqagjM+Pu+1L5TyoOco8nG2X2j1WdxKen8m4tFzTCjiA5qQOyCYK
 rbJRwAOqFSA4LOl5ESiG2T+Bv26ymYYdtxngD9pOfF3wr3i25sO0nPL2ZAYpbVjWVpg==
X-Gm-Gg: AR+sD12FRcnNdof2kaANxX5a0p9SwW90SGLqls0QPJOmdoGFxdleJy21QMO3STNC6Xx
 Z7fBpPW5ys/slGIO7eKE+MmWDfz+FIaHubOZYw/pGQxVCxEGSSykn0JAwBABqCdYFvvVLoPiAtY
 jsDuKukvCPTw8CcbNzCbjS3ny5e8l1cMVEEU8Tp19W2NTXSVDZxZhrlgh8op2y1365/vyEqmFi+
 cGVn+UarXFB4Pbgh2nrlkh03ay0Mf8LIQoQiwQKRNDKy63I3ROGU73wbkisl9+8boK9SgPAYM9y
 f6oDctQJtAThZGZV1ZZ3xxGrGeQDmUTb19y6YTGO0hFwp+mp4nyn8KDQIhYx4DBkGd7VAyu7WLn
 ls3MRtCbwaysEcVYeqPtTkgtnrZffIyzTs5Z5j0p1P+4Jbgark3lFSlq4foIFxZF8B45wYZE=
X-Received: by 2002:a05:6a20:c99a:b0:3c3:7ac4:dac0 with SMTP id
 adf61e73a8af0-3c8aaf295c8mr1044393637.13.1785214048044; 
 Mon, 27 Jul 2026 21:47:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:c99a:b0:3c3:7ac4:dac0 with SMTP id
 adf61e73a8af0-3c8aaf295c8mr1044368637.13.1785214047650; 
 Mon, 27 Jul 2026 21:47:27 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:47:27 -0700 (PDT)
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
Subject: [PATCH v6 042/103] tests/tcg/aarch64_be: user tests
Date: Mon, 27 Jul 2026 21:41:46 -0700
Message-ID: <20260728044248.137626-43-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfXz0MlH4FCjnKv
 MPOnIicESHjXyBA+nTzcrFMEuvQpq9k6uwVJ8+CbvrYfoDCHvTDA4qY9aEOA1yTkUwu5xAqgS+S
 e7bXdlqo40tC084vE1u510LVxK0Np2E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX4RwlKiHNVx05
 IsR0OldXzWDA+YlQjbnNVhE/42Jg5MhSZBP5k1ubzjiP9ZHcXp8sK4HhmxCIEKgHzBbe+GGrL66
 wk0LBP2mblN95UHC4qLQmghjy0eIuioiFi6CggWnrOxEQC25Zr3/bWI1qrl7YMK+JK9htQb0QHV
 MzYVkFHWtjt9C5toPeZmMyqSdHDIovJ49+/bmpUa5yvyo2fKtn4di34c3+k7FifKXOPdH+4Xxkq
 zqf62F67WFH0e1q6GWsjytplxR3+MfloTkm3g97RMsDJnT2MtjhV7q6S5FJeSFzyzXOfLf1SqTz
 +DMnLlVx/Un7zcVcMjWf25WHP8GpkK4DfXzrxjcuT8VbbhzyXbLqv2w+M97l/oJciK2rIlPw/ju
 pvnzcM0oHSYCW/B6+Rdbk4azU+5MGj7KZGB9xdce1bgbf5b8ezQqlbngm84cg+xWba9li0kvoEn
 +MXHSftAxfsbfVZnc0g==
X-Proofpoint-GUID: wBgOZrvIagKfm1ifSX98JwkDS7FKtISR
X-Authority-Analysis: v=2.4 cv=KJ9qylFo c=1 sm=1 tr=0 ts=6a683461 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=cU6hyqZTfTbaeHUSQJ8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: wBgOZrvIagKfm1ifSX98JwkDS7FKtISR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64_be/Makefile.target | 17 -----------------
 tests/tcg/aarch64_be/meson.build     | 22 ++++++++++++++++++++++
 tests/tcg/meson.build                |  1 +
 3 files changed, 23 insertions(+), 17 deletions(-)
 delete mode 100644 tests/tcg/aarch64_be/Makefile.target
 create mode 100644 tests/tcg/aarch64_be/meson.build

diff --git a/tests/tcg/aarch64_be/Makefile.target b/tests/tcg/aarch64_be/Makefile.target
deleted file mode 100644
index cbe5fa0b2db..00000000000
--- a/tests/tcg/aarch64_be/Makefile.target
+++ /dev/null
@@ -1,17 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# A super basic AArch64 BE makefile. As we don't have any big-endian
-# libc available the best we can do is a basic Hello World.
-
-AARCH64BE_SRC=$(SRC_PATH)/tests/tcg/aarch64_be
-VPATH += $(AARCH64BE_SRC)
-
-AARCH64BE_TEST_SRCS=$(notdir $(wildcard $(AARCH64BE_SRC)/*.c))
-AARCH64BE_TESTS=$(AARCH64BE_TEST_SRCS:.c=)
-#MULTIARCH_TESTS = $(MULTIARCH_SRCS:.c=)
-
-# We need to specify big-endian cflags
-CFLAGS +=-mbig-endian -ffreestanding
-LDFLAGS +=-nostdlib
-
-TESTS += $(AARCH64BE_TESTS)
diff --git a/tests/tcg/aarch64_be/meson.build b/tests/tcg/aarch64_be/meson.build
new file mode 100644
index 00000000000..9ea111f9885
--- /dev/null
+++ b/tests/tcg/aarch64_be/meson.build
@@ -0,0 +1,22 @@
+tests = []
+
+# As we don't have any big-endian libc available,
+# the best we can do is a basic Hello World.
+tests += {
+  'hello.c': {'cflags': ['-mbig-endian', '-ffreestanding', '-nostdlib']},
+}
+
+if 'qemu-aarch64_be' in emulators
+  tcg_tests += {
+    'aarch64_be-linux-user': {
+      'cc': 'aarch64-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'aarch64_be',
+      'gdb_arch': 'aarch64_be',
+      'qemu': emulators['qemu-aarch64_be'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index dd5818920f5..0b1ab5b5921 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -137,6 +137,7 @@ endforeach
 
 # Now let's go through all architectures
 subdir('aarch64')
+subdir('aarch64_be')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


