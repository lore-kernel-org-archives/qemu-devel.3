Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB62C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bM-00014j-Oo; Fri, 10 Jul 2026 02:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bM-00014L-0M
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bJ-0004VC-UT
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:43 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nTol3803912
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bdh7radn1hRnnwlU/oSd2yOSRemfszoZWLlFPmNtBUA=; b=X5R/iD8mFLySvUOI
 Pntv5e85E3MHHOW0Ucw+eQuz0QagQwzE8UjS9vRVZiQlhDi2OvbHi0wj47Jjtg4e
 VcQCwkH80owS++zXUhZ2tgbsbFDG02//bdcyc4TLuO9S53OL/HjCB4r3vrDsQkRj
 FPYQ8Wu5A9kIt5qMBHnsnKES7hcTbCpYqcOg1hHaFIxr2XfwUo2mw7Ru+0VyXQ6M
 pwxX0DM1v9+uH1zqlXfXWhBt9topfjnFFYqayW0yzfucfxm020BncjOLZ5ycQkrM
 7dBBEFmYa/eUcvHX0wQt83Awh53eiDodNcIy17glD4xo5d1ZLPx2XDn1pcmFdOFZ
 UCemqg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5mttww-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:40 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c8895156101so1010787a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664440; x=1784269240; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bdh7radn1hRnnwlU/oSd2yOSRemfszoZWLlFPmNtBUA=;
 b=C73OXOxRhw4DdXYZ4XOEdPNbdwXYYjkOxlliBtLHZptZsfzBKmy9mWfzAf0UOvmiOi
 1GiFuqq7/Fv1iOAGFDzOb7qnLRVZhf46S7gxpvv9DMl4MpX5xZsB33zLd0Ai8iFxfUSH
 CATRIFktcwsHamTr3qx6T02iNvXYTKe+mEUoFp3xCsTDXpHFRKGgeWKgaM92xxQVNTN1
 W8cIT0z6mLkatEO87W2AYI0gd9aQN5DW5ARf11DOvChl0oAwJCc4ffIyNt49fmraVx6s
 RX0WGIRGaBgfmWY8tjQlULta6ASU+MbhSTX2DTqx0fTXS0GlAFxvtz7/QAIM+1g0JPWE
 JlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664440; x=1784269240;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bdh7radn1hRnnwlU/oSd2yOSRemfszoZWLlFPmNtBUA=;
 b=JhztDaJgpm7IcirerPsOtpPdsn4fLy1vQJDEYmL8SyNslxXN+nBETzKCOH8/RnClQM
 YQH1up4qmTUoRoThl06BNSZ+5lVi/Etso6mC1JnmhaaxMGqiyEpu+Gh0NwItIJm3zzKW
 8dL7mU0X9vVZSOJbX9qYgVbukuQ339NXLPRgu5/z6X8tBI1ZkvBu9IOh+2gDk/61Pw/x
 WibG/TZTplIm6WdEm3vn3tMXCtm0/+zH6oDGXyhvRAivTz2ZZDYuMYn4MS36eQ9HXFoc
 oJMff7z7HwldmrJ0S+q5hLH3ZIjwSbNFuA0afSdziaLy/OwZJxPYSx05e3MZf85H7h3D
 raxw==
X-Gm-Message-State: AOJu0YyDv0obgwzfpZ/xcSmddPeyRtNJluTgmQSriWvkkQ0wQwqMSM3a
 D8w2TS2wXdeKtHCWwclxOMfJz690jLweb04epjpmTG/dYC7Gy/zwvn4Vp9+GTM9LeT5Lm6JWZqI
 FwkOgLZMfrH7WanwB5qkr6+zgxB5/Q/QRVPRj31J7DcEH+WVrCDK9Jytx//AnzHVJ8w==
X-Gm-Gg: AfdE7cl5bYxHXQuJxghYl/327bCsJ0wErnyjwtA7R9fwkjuWvqdadc+EA70rfW/lWFg
 PWF829FlezmdzemI/sxmJgX7yf7qJNZFhVVPfNCVag4EzpsznWUVMg0yiWZhOsuYXE2DTunOKT1
 OGLxAgD2vL5g5FC/0QWs/A/7QU9Nkwt4ziX4N7+qe+aWMcCftG+mEUilBeQybBMYSJeNudivbQS
 mqlnXYlir7GNgvn5e8vMIG/0nZxbiAxnetfSQxFx5HmbOn1y6naqoyak3rt80HPj6JOpnWsKbov
 kiNNDOkqc8imWhHttsEAFP17NF5X6pu6Aao1nGeIvY47WBbLqInKrNFfY1vL6pCqwwrwIH+cZ8x
 ZVfJXxQ4gGguCrBVIsavnQuhEWONUXT82o0uRVXiajRbAPfsCZ90DQ/IRZkfM7xCS1mgSzw9UfB
 9NcGPZBA==
X-Received: by 2002:a05:6a21:4cc3:b0:3b3:2703:115 with SMTP id
 adf61e73a8af0-3c0bcfea2a8mr12026857637.16.1783664439729; 
 Thu, 09 Jul 2026 23:20:39 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cc3:b0:3b3:2703:115 with SMTP id
 adf61e73a8af0-3c0bcfea2a8mr12026818637.16.1783664439234; 
 Thu, 09 Jul 2026 23:20:39 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 07/97] tests/tcg/meson.build: introduce test_name
Date: Thu,  9 Jul 2026 23:18:45 -0700
Message-ID: <20260710062016.1818125-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gaCxLvYboflvwXhNVgh64qvNVch7U3kH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX6P9vgmp+RJEp
 DggGrxVUa35xxnJ+G8/obmDPqaZXq97niNSWwzN4aVcQPEEy0cQfXpUoL5m3tVLLvrCL/za1bgn
 dNLlTdRaiL2e+327MlvIWkyFDbBSy7Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX4n1ry83b0Jdz
 MRJUGljPIiXcV7UV4eT+N04T9Iu7WsyRHWEtGGxfbHxrdzyvmHEt5NBS7EqE9+ADz2vybgVjlxf
 DELs83Y3Y8kPVXMB+NGOL/eBpd/rzzJy0P7TIdPwwvd63wH83tbU+uWVCF02Zu6e8BYMyhaomfX
 Kt+Ld3nK8PM8IzBhc6YsSmunG0D3oCEZyZovlCY+ADRh5MjkhksbvYJA5cD1O7eUpgQuxToIasW
 t2XHG3BHHfgEooI9S/kPxrVIb7DB4OLobVdXQISUc+GdOpKFAVvuVDtNEYi46Bti0fGzXzXULHp
 og4pElV+lCHjj/G8/AfKMR4GdP2Fo/UPuTuCnoHZbEXGBaWz14R4Ul3j9YwS97geN4x41TdzU5l
 Of96VO4wuRpbYnx03Ozt9imkHpnbPuN81DwCig8MmChNyaystQ7+PDiXgbcW9s5PQijG+Bmwq2O
 T36LYswSFqHpyh8OmZA==
X-Proofpoint-GUID: gaCxLvYboflvwXhNVgh64qvNVch7U3kH
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a508f38 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=FnD13UrixhZlOC8LVz4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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

We add possibility to duplicate a test for a given src. This allows to
declare several tests that still share the same executable, thus saving
space and compile time.

A side note to mention that meson perfectly supports declaring several
tests with the same name. However, we prevent that to force dev to
clarify what is the intent of each individual test.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1719eac0d51..3eee3847b58 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -12,6 +12,7 @@ tcg_tests = {}
 #       {
 #         'src_file': {
 #           'exe_name': ['provide an alternative binary name'],
+#           'test_name': ['provide an alternative test name'],
 #         }
 #       },
 #       ...
@@ -21,8 +22,9 @@ tcg_tests = {}
 #
 # Every test executable, identified by 'exe_name' is built only once.
 # Tests for a given src use the same executable by default, and their definition
-# is guaranteed to be unique also.
-# Default name is derived from src if 'exe_name' is omitted.
+# is guaranteed to be unique also. Several tests for the same executable can
+# declared using 'test_name'.
+# Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
 # plugins come first, as we need to build the list
 subdir('plugins')
@@ -52,7 +54,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name']
+        allowed = ['exe_name', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -67,8 +69,13 @@ foreach target, plan: tcg_tests
         exe_name = setup['exe_name']
       endif
 
-      exe_name = target + '-' + exe_name
       test_name = exe_name
+      if 'test_name' in setup
+        test_name = setup['test_name']
+      endif
+
+      exe_name = target + '-' + exe_name
+      test_name = target + '-' + test_name
 
       if test_name in added_tests
         error('test ' + test_name + ' was already added: ' +
-- 
2.47.3


