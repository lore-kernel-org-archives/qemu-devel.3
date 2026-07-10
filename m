Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC18C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJAE-0003kw-3j; Fri, 10 Jul 2026 17:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJA2-0002nu-Hh
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJA0-0006Ug-Li
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:30 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3oBO1648758
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nVMjjJ4OH07
 2Y0/KWO5cHlOcsZLmQVqrGJd+g5ZdUMo=; b=RwtyGiPSfCrL21hi8UTPKeeqdWg
 SFWaaMz9kX9+vYqhSLFAwOYm1XnoJ7ZgoRhs2+2qkumc+LHOV4DHnPF8BlecWUAV
 7hbjXcM9fgcCNwiYUHXGPGv0DB7kgnmCECs/Roe6ilPhPdNO7exrzH6gFIpvToAF
 cc8TGbtdngCL0WNkn5Zd4D2obDOINo0d8FD6kIk4MxaIvtYwOSsNkPrfoJK+jWNW
 NpZ4PgPPlc6QKXc2/RqRS85GhFD3Rcvcgs9ivccbVvNuUPNKrY8b55Rd2Zq+D+AZ
 QgK5G7Oi0ICZEg4tVOz/ogJ1kiFxJ2AdeaOUAPTneP35E+J8kBOdfqpxiFA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2txhdvp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c8894570b58so889260a12.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720407; x=1784325207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nVMjjJ4OH072Y0/KWO5cHlOcsZLmQVqrGJd+g5ZdUMo=;
 b=GND458F8t/MLJKclW/w2Me062SG2sxcwRjxMunRhjtm4HtCwgrebZJ74kDaHqXr5Ly
 iGQDymigcAu6aqBexKTKkCbIDxLjTVZYqd21+DOYbfM/Wr4f8BcUz6YPN7ZPZ7hzUA/+
 rqOc2u2Tdf2noAbDSYVeS8dw52FP01PI6ECEcP4xFHQ+ErwsXJg+f3+RozWglvHjuuOc
 h5yneLsRUrG0lOeJPD1g+I1PCwjH2ccjqBFgzBt0t6peTKB+UXZdbUYoJMDhEhSGd0jK
 DWAOxzLG5GZE+zoRufh/QwSF4tdK8vEPnUTn2bYW0fKkFdOlgH5boUTp0MPD75sg8l+r
 9Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720407; x=1784325207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nVMjjJ4OH072Y0/KWO5cHlOcsZLmQVqrGJd+g5ZdUMo=;
 b=aHMMtqx4h6/ewclH5i9WBpajZN4rwjXc//ADej4ygTQOlvg/Nsqq1fJZeKl47fYKlh
 hJYt8xSZP9m9BF9crUGTpjObhBxZP05X/es0i+aPoTDQGZ7nH9eemE1Rj7pTKoEVsHVs
 9fFI7pYmbihhFw/u4aHprckgPrLjsabvwMBmgRumfT8g12fHevh6trwRwX3x4v37PTeF
 dvYYh2LphMPFpx5bc4W1riuPdxGlYeLqX4UV1SNwhdD0jv/Rv+HoA/ZLSxyUqCfY7XtL
 0yAtGDgBMKi6BDk+nYL39oPboXXtaP4eMoDxxcFUgYf6QGbP1X75l3NzvqNd0mbOI/+V
 U61g==
X-Gm-Message-State: AOJu0YzyIX98sCZ4xMUANvbVqubWOhTUeHMwTC2crzn039ZtKCNtQx3P
 1WNW1Ham9oIHceYAJ2AGmHXNsaEhKNhYbhbFA9zs3IjXo1GInrafbtUC5VyXxvIRARKMNY3OB5n
 TVB+igDrATtPNFdcGKh6fvT5LrQqub7Vr2xzMAnf2ZZ95FM+OeSebM9fNEO2MBfpvAA==
X-Gm-Gg: AfdE7cl5LD4e+gdPc8ZlfbD/kAm5xR/A/lFua7zT4e1vKWxU23XZ/JCpj7kWd6+bnVj
 I3H+xBK61hdSrA7RxtNpu3Uylp/3DmdPFaml+UIxMEAf5qzVf0cjrwhCTDv06vHBsg4meQb9P9K
 9ZVWlBltGCEKt5VPpJfJ2j6bEv0FPxJwqWoTaFV4Yak+OQ5RVrhLjSCE4setYH19t94r8nU5wa+
 vpbbdAhBTypTOCqZA7uDKtjFI/GSdzxpKTM8QS2UbdTw79VCSOTAnJhcMXb9+b4P+uC31zXctz6
 MOlKa7gN9X0qJSlYyex/8fTz9hp10nwnb78DDdEGXbtsjsXRibQ2Un1HYie7UEbm+QJfOfn9vdm
 Ibo98my0NEyFmBpnYGJBgdG1qkoj/0Zv/MZmpU4DVxvgYtIW0s3DKO0zzA/p2G9g54+uSdk1QuA
 nz/mHy8w==
X-Received: by 2002:a05:6a21:1309:b0:3b4:b24e:27b4 with SMTP id
 adf61e73a8af0-3c11077668bmr740402637.1.1783720406651; 
 Fri, 10 Jul 2026 14:53:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:1309:b0:3b4:b24e:27b4 with SMTP id
 adf61e73a8af0-3c11077668bmr740380637.1.1783720406209; 
 Fri, 10 Jul 2026 14:53:26 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311b00048a3sm14268659eec.5.2026.07.10.14.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:53:25 -0700 (PDT)
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
Subject: [PATCH v5 94/98] tests/tcg/xtensa: xtensaeb system tests
Date: Fri, 10 Jul 2026 14:43:38 -0700
Message-ID: <20260710214343.2065491-95-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ELM2FVZC c=1 sm=1 tr=0 ts=6a5169d7 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=Gpx40EtBKFK82MPJ2IoA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: dHwR_SswDQaYH3tOhk2kqR8ecORnVhJq
X-Proofpoint-GUID: dHwR_SswDQaYH3tOhk2kqR8ecORnVhJq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX3T+TKkhHqntA
 vLJj8uXapW2sxtGh2XT+V0MgIUkSwh3/5rBa4k4BzC2FwtQkGvgiUulwoX9hx1F/vBGXCueWMLK
 XOHSSXUnSirB5QtKi4V0e01QfBRptKNLSEbWhOM1YtOkMK8miPF3pmkufMwQxXjsx99fiiqqWvE
 Jhzw6pXKTqkPKWExs8oWHnSpB50tzMJ0bmUefbvisPohkJ7xYYQZPSzbkDLnmkcMTVoJIh3NgLf
 7MQWV7ScHwSSJ85HOmf+JGFqMj7SfQymiOGL2HqJ1cJsjlJnsNBltJXUzndArSrb2hjsVB6W7ng
 59K3+svq9TjBk8hipViJSCiagTVgVoxm0QUWqvTxpuDEF3KIM9SD6Uqd76MxXIxpS8nlAtIJ5rY
 0zeB++a0wC52I6hUnhue7p2Iv6LRDYLWeZyMOZC1KgdB6FJeDhd3Ul53mYDTiLFWDWOFuD8QKiu
 UNt5v/oiRRxqYTUbSoQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX4OyH897rjG/X
 w1o1iQfH/dwvM/w+ZgG6ni46kJF2hzf2atpyfbzCyvmrQkAP7hISq9iSsUrPebWKkB8aldfzmt2
 wftp041KUIxi9ZhaB3HauhZ7H40uhqU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100220
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

Deactivate test_timer which is flaky with xtensaeb (25% of the time)
 ./build/pyvenv/bin/meson test -C build xtensaeb-softmmu-test_timer --repeat 100 -j 100

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/xtensa/meson.build               | 16 +++++++++++++++-
 tests/tcg/xtensaeb/Makefile.softmmu-target |  5 -----
 2 files changed, 15 insertions(+), 6 deletions(-)
 delete mode 100644 tests/tcg/xtensaeb/Makefile.softmmu-target

diff --git a/tests/tcg/xtensa/meson.build b/tests/tcg/xtensa/meson.build
index 7c3c4f7cd62..680fa02ff5d 100644
--- a/tests/tcg/xtensa/meson.build
+++ b/tests/tcg/xtensa/meson.build
@@ -1,5 +1,5 @@
 tests_per_core = {}
-cores = ['dc232b']
+cores = ['dc232b', 'test_kc705_be']
 
 foreach core: cores
   tests = []
@@ -94,3 +94,17 @@ if 'qemu-system-xtensa' in emulators
     }
   }
 endif
+
+if 'qemu-system-xtensaeb' in emulators
+  tcg_tests += {
+    'xtensaeb-softmmu': {
+      'cc': 'xtensa-test_kc705_be-elf-gcc',
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'xtensa',
+      'gdb_arch': 'xtensaeb',
+      'qemu': emulators['qemu-system-xtensaeb'],
+      'tests': tests_per_core['test_kc705_be'],
+    }
+  }
+endif
diff --git a/tests/tcg/xtensaeb/Makefile.softmmu-target b/tests/tcg/xtensaeb/Makefile.softmmu-target
deleted file mode 100644
index 3df131acea7..00000000000
--- a/tests/tcg/xtensaeb/Makefile.softmmu-target
+++ /dev/null
@@ -1,5 +0,0 @@
-#
-# Xtensa system tests
-#
-
-#include $(SRC_PATH)/tests/tcg/xtensa/Makefile.softmmu-target
-- 
2.47.3


