Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625F7C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ24-00061g-IM; Fri, 10 Jul 2026 17:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1p-0005bs-8w
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1n-0003YO-OD
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:01 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3ico1648591
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6YJbvm99ixlJ3zgKnGe9j9cDKsYNJ6eszr2zP6pTdE0=; b=IKEmk6rJ1T1oC91P
 TYpinkqen12jMW5V0hR89cSDgV+VomQdZQYsFEGtco0bsdbYN5du5fkU0NJ7oYoP
 8Dypvb0HiS311NheeoXCEmBhkr2NUlVjehWSQprcrL3F99SHlpR++okjswbwSeye
 /6jk4cTWv2KYlhm6gvyyZSkYa+6FM04kABC0Ro37YGFmOcyMwnXYS7YWZ/ERUHre
 iesHzdX+KGrAVJafdgH3/nUiVhIP01nyu3dzHfZfC3ZCSAecDU/YnaZKoC3n5yQp
 fizvlztERNCjsxFCXe8q0JG4tFqgxxja7RPQmsoScaIr5K0cL2DZ3JsrpBcA88xA
 aoMRDg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2txhd3d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:48 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so947743a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719888; x=1784324688; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6YJbvm99ixlJ3zgKnGe9j9cDKsYNJ6eszr2zP6pTdE0=;
 b=kfUMAA3Bcr/51wA4gEYsEAjimeHTcS07Z/534MF+OvnhtMCyMPk2BptVzLjzw1Eojy
 sctUJoym3mwoyM/jHoP4KFs6vT0ODKrHbqL4QWDLptTf4bwVE8DCtM8a1FcfjZmqE2j0
 o6ohRAnvWSRa892lXBjMFUULbIJHxq0ZQDhtEJ4SNr6TH1FU+kJwObf8hgPiYEA+Beoa
 N8V+JoGsMxe9fGxd4jn4SnTn1sNLtlBhig0TuLwmW93+Le8uGGxx2AHVhAYIQ11RLLbu
 53ht5uECs9OED7rYnydehOa5VgR2xoA6J7XbgGCeXeKqVD8tUilQviGol7T2IYadI8Fm
 nggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719888; x=1784324688;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6YJbvm99ixlJ3zgKnGe9j9cDKsYNJ6eszr2zP6pTdE0=;
 b=pHiIuOgU+uib43dUi+GL0mqSduPPOl736cGtyrjAhzRXpA+7AufWdta9+xUgwqe7w9
 LRyRN77/i6xJjzF59h5orndB0Xoxq6XYbnVcR8XR/N4scxEMkN/uvHfM5QiAaEFNMUkm
 akg29IHl5AOmL+zmMto2w/1OE4awdwrYuCkyvTIrQU+FDqWMy5VaQGeV76gmPbqaBpZp
 xA1DeHp63NTOA/86mWSUBf8kdKETcw2nA59B8cypSTlvFkupvf3emk0nvLOpsLm8+weF
 ymxIYfddVsxHNHe8X88ay6l/vxBxcY9yGC0If9OEmGSty8hHhjxGg33j2jcmSr17O885
 xXvw==
X-Gm-Message-State: AOJu0YztcOv4XUoVuDA+rYJeLpq5ukMykGIMnJO5lm8o4su5yP5wU5xU
 Rio30muTlE99TYcZJmYOOl36Q2W/EIAz6u4toYtNhb29bCC60En1pEAMZV4fSAFYxC8LXyNk58M
 8bPWHPAGrSsK4rrs7MqkMu7/JdtVqea3uPX8/S+omOyi7tz28YgyIxtu8BVO191ayTw==
X-Gm-Gg: AfdE7ck2LheU2Y/OWrvtvmTFCEX7UR7/mBrfuwhcybRS6G3EUH9BSYBJdN06QpFM2PN
 Kq1yW1cxJjfMzhzE0hFoMVS2oR6VNHkx0rhTm9zTPyyKSRqG2TDDAgMXl1m660IhmODPMjpZEjy
 +NKFg4IU6XOcOkOLpZeOSujA35yQgmdPB7krujpmrOnsFvG5ZHyEN1Kdsqjm8mefGuF6GcnC4JC
 z0U8JHxuFSaZ53Lv6B3uyBWbDg4br0mMkcDWPzVgCXqaN5nxGXmRAdnDcZhI2U/0llC4oZXbj+/
 JXAOwqJSqowhjykABRkI0yS8olZ5Z7DoTLjUiQw0XobN6GO9ELJ1vhNqOcqPyGi6Ahgr4UEzlrV
 Yx9bM/EIDIvcrMODbR2k4kO2VUr0xvnomClPNZMBsflytwom+g7XBdc9diXbwcAU9DyXRlijtNn
 L8lGp+Tw==
X-Received: by 2002:a05:6a20:549d:b0:3c0:9c19:65a2 with SMTP id
 adf61e73a8af0-3c110b7d89bmr768435637.74.1783719887705; 
 Fri, 10 Jul 2026 14:44:47 -0700 (PDT)
X-Received: by 2002:a05:6a20:549d:b0:3c0:9c19:65a2 with SMTP id
 adf61e73a8af0-3c110b7d89bmr768422637.74.1783719887304; 
 Fri, 10 Jul 2026 14:44:47 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:46 -0700 (PDT)
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
Subject: [PATCH v5 31/98] tests/tcg/meson.build: add top-level 'tcg-tests'
 target
Date: Fri, 10 Jul 2026 14:42:35 -0700
Message-ID: <20260710214343.2065491-32-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ELM2FVZC c=1 sm=1 tr=0 ts=6a5167d0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=WK-hs4OApzzqMslTwvAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Y9o9oayQLgXGIkJ7uEBJldtBwjVC-Ge-
X-Proofpoint-GUID: Y9o9oayQLgXGIkJ7uEBJldtBwjVC-Ge-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXxNHX9Op5O86L
 mdkJqq1QfWcVQiIFJeh0WREvpHnXDZLx8Tonf/eEZGulqf9qq5ynu4EjLC8yqF8SAwLb3s0S2Ma
 cQRM17Vb3puNRlmq9DnRLznwq7WZ9j/9SL4ylOBgt5mkljP1shWB+D5A5Tt+hGTYpPtYRUd3RQh
 ShvmPAQALapaqTYUHgwh2s1DqFZFtY0Uqp1IzIAQFzmFk0cweIPQPrgruegBQqtwrAdqOI3q4D7
 tJiJCFdQpUQuvSSQps/oCDXuDSrIQabHsHcDWXFteleLMvAtVCXU8DTQu1Aqvt5i6o89v+UqpZc
 PMll+ePi3wkfp5TNRVOoJHI5EfcsZM/Lpp5nRX4FMM6lM5OOnlELufjhUpM5IIEi/GuuNA3WiNa
 gDIxeVdjusoeI60ifBwMiAW6VsK6+gMGDxW8bbUTTWzteY6z3HsWgyLjWJv5mIPfiSZSX2lTXuX
 0QFD2X2dM8H44jiNUAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX4kl3DylCqFnh
 1ggH/fJE3aCqjD7WZz7URC9k6RBz0Hqt1SulBbBALhGGkafJ3qVIv69PeT9Vr4jD1z/qQzK0uAM
 f506hmPON5vED4EIXp4MG9fGc8y1cNI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
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

Add a target to rebuild all tcg-tests at once.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 23a28890ce7..6408a21cce7 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -86,6 +86,7 @@ test_plugins = {}
 subdir('plugins')
 
 image_targets = {}
+exe_targets = []
 # Finally, we can create all test executables and test targets
 foreach target, plan: tcg_tests
   # Detect duplicated executables/tests, and report an error to force user to
@@ -296,6 +297,7 @@ foreach target, plan: tcg_tests
                             depends: exe_depends,
                             depend_files: build_test_depend_files,
                             build_by_default: false)
+        exe_targets += exe
         built_tests += {exe_name: exe}
       endif
 
@@ -378,3 +380,8 @@ foreach target, plan: tcg_tests
     endforeach
   endforeach
 endforeach
+
+if exe_targets.length() > 0
+  # finally create a top level target to rebuild all tests
+  alias_target('tcg-tests', exe_targets)
+endif
-- 
2.47.3


