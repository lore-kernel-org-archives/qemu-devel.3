Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852ABC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bP-00015P-4X; Fri, 10 Jul 2026 02:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bN-000154-Dt
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bL-0004VY-NH
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:45 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nSt43803907
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tC6BEBeF6XDzwFZYudInSHr8bqIQqrfAofBlDfqI19I=; b=VpEMMkNib8XlBOQh
 yGCTehLIQkPpFcKNtMi1iPF8sqYCOkE9B0z4wg4WQXNzBKe36v/ZXEKATdG/0SRo
 +BHe2aPqDHbnyIG+jxmErtLF/lXUVgaMjq9/yMMCJeh9MkwW5C/8s2FoSVzA8Gvr
 sqXmwjUoCMq9y0Rypvj3xznSuSmnPp0CmLX7t3dbIatVy6/sgGhmtxXw7RsYj2xj
 j27Ajfkd6ufkdA/SQy0gV9ZVeCHUVST06T4GpYY9P5IzugjSgzLWprcArNhpi6oo
 qYEBk61Zu8hYxPLWJ39ULtRJJq82P0Isdz75xK9mSk5ACeLFdTOu3h71Y25oajE0
 4IHImw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5mttx2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:42 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c890bac374eso1048123a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664442; x=1784269242; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tC6BEBeF6XDzwFZYudInSHr8bqIQqrfAofBlDfqI19I=;
 b=JGqWLRY8ZT5ErCh4vpJYH2Yk5DcWRsm/QTSARZyZpdmzaNmsQXAbGRBdt8JS4+/fWO
 kJzmgwxlBuKHeXBMbVUsBfvwtdABnmXFuv2cK9HA+2A2kqsPOpSQJXMuTpyKOMjha7vk
 HbGsRHrx2Q8MybXTXuiAn9qL0sT/Lfu/brmpSmkTreVo+NmL5Qc4nPX3hJfBMbx1LdrL
 vj81wbGEQ2ohbnWFnRvXHJsNI9xzNlY/fUEp5A+Yy/NZa/l39rkq1Q1ebhOicaAUZl39
 xO0y870HVRKLOutYQmOAc6NS8K2+OjbOC4uQUkwlGX7VhVVNm0yy6i9m2esjyDh9A4bk
 m3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664442; x=1784269242;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tC6BEBeF6XDzwFZYudInSHr8bqIQqrfAofBlDfqI19I=;
 b=I47/TRNHwRfyzEznyw3NxDS3uVMp2SD3kA4myR4brDyD4suscg+diWy5snAufhlluD
 8kipWYHBvg8YrkKvVVPQG1Et1hWgaZJEehw7rnl7FeJMnDqGewx5pEBjYQuEb9VduGvw
 lrvp+HWw8ww8/srFz2kIhokhcLyxdKmGHNzaTXcqhqiObIx2H0aBNgUgSyRloScbmqpq
 hgBptikXYGhqgLMtwJIL5JGe68s5duZ0I7apcmw03M9j7WIYXns4yIWZ+RAsnul4oLHu
 f5BFwswSqVftGP/ah++rxa99ZE7IIH92tbPsRYKaEFHeaTOlrMfu26A8LdL9jUNGi58K
 tsvQ==
X-Gm-Message-State: AOJu0Yyg6yTOXtE9O4YPY+VCjXW78cc1ZSIyNfNLGu0lBVsRF9bX4dgc
 +UHDuBg/boK1PA6nfl3vwTa0W98wBZmqGV4egIfnoPDLhfafw5g50VCuY/cLDUYwCff7B4QfuSo
 iJDAlgAEdargI6HfTE6An4kX4PN98Qso0/oVrMfkuTHrEI1+Ya3nI7mppnjhHl5uBMA==
X-Gm-Gg: AfdE7clBBW1DrTBmi6Ys/ucE09Z8CJUNyfi9wc6Czx+aR8NMSdgnIg6gUfiQqGEX0IX
 IXlDNN2t95K47zsrn/TElVxKlRXq84alrQXfKaU7a1/h07i6kCXJc11lH52Ii7oGQh92JKOQ2DF
 MCMbWpcyHZAQjJK+99GHKvZTk1fU2+VUiyCCywj+PZ8w8aUrXg4q/eOg6bC5fR1NEGZQeNgRv3t
 WLVpkmQCfT03/WSRUwAaj/KFUudR9iX5K7fyS559nKKa1ke03pArBEOAHeRx0exfYoi6yjlDv17
 2D0qQszGRQLGTLK4QrKZFI4eYI34UbIWK0Ez5IsHLn9hZSbhkMr3mY0N3tdAbqc049evvfFX4/A
 rhzXxcF2Hl5bN3SnsACzJEKHhp+iogQplrP4zGFPjv3odK8JqXzX7pAfitrchLz7YQNKzIivxTN
 z98e6l+g==
X-Received: by 2002:a05:6a21:4e02:b0:3c0:9c19:65c1 with SMTP id
 adf61e73a8af0-3c0bcd20167mr11457254637.73.1783664441592; 
 Thu, 09 Jul 2026 23:20:41 -0700 (PDT)
X-Received: by 2002:a05:6a21:4e02:b0:3c0:9c19:65c1 with SMTP id
 adf61e73a8af0-3c0bcd20167mr11457214637.73.1783664440927; 
 Thu, 09 Jul 2026 23:20:40 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:40 -0700 (PDT)
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
Subject: [PATCH v4 08/97] tests/tcg/meson.build: introduce cflags
Date: Thu,  9 Jul 2026 23:18:46 -0700
Message-ID: <20260710062016.1818125-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Hi10c0YsQRgsSj-2zsY-Hdx1JUyEPy_l
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX/x9/bc1ciiDF
 nmV0wUHyn75ghSKhkfxRQ4VNS6VUflMC8/BsiCwywuheebLdncw1fjbnWaZaCehmSEY7rA3pubB
 gfnJvZ+PhFeJKOa4LuuatVAolwL3uyE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX6lvGOEjHSLcV
 z0BsCP4D4GLYhxG3EbeM73DilnBcFY+lzgLddowKzgUzZrOO9YEfHeNw052XMHOfVPlNnhf/NNL
 Ao7i3N+eXu5dfqGrUFqfcE+y+Ep7+U0gUhgUY/eomZSZq4CunPNhliE7jUvETrHgN2j/cmgYWif
 SflFR6OGpnkR3svxtTdA4l/26pnycI828buYJvw660qNsRQx03D0wrZ86OA9/0tWU6yXmhfE/xR
 jyY0hN6Ve4cLT2l9H7enRXe5PVMqhfZjFG0z/102C3Jeb3VfAYzMpp6CcINkIqGFCT+2Ajq2O7L
 hyu8DY/4R88Mq5+Jr4jMQqHXo31hYm7hkQzKXU7dC3uMna5Ojs08xXyJ1B1lyrz/3mH9mMKQ3w0
 EHBHIR+1O5TOyC4nPpw5dqQl+Ch24KgWMz7xNq1uW3k4U3zm9X4RAkZgfIeLu3pinRmoa+saO0C
 mbiSNEc+FZojRl8xmkw==
X-Proofpoint-GUID: Hi10c0YsQRgsSj-2zsY-Hdx1JUyEPy_l
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a508f3a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=xYeKZKBo3MRtsS0M5EUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
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

We add possibility to declare cflags for a given test. Since we want to
preserve the uniqueness of test binaries, we prevent repeating those
cflags later, for an existing binary.

This ensures one executable == one set of cflags, and if dev needs
duplication, they can use a custom 'exe_name' to override this.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 3eee3847b58..495c1d672f0 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -13,6 +13,7 @@ tcg_tests = {}
 #         'src_file': {
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
+#           'cflags': ['additional cflags to compile test', ...],
 #         }
 #       },
 #       ...
@@ -20,7 +21,8 @@ tcg_tests = {}
 #   }
 # }
 #
-# Every test executable, identified by 'exe_name' is built only once.
+# Every test executable, identified by 'exe_name' is built only once, and we
+# ensure cflags are specified only once, on first declaration.
 # Tests for a given src use the same executable by default, and their definition
 # is guaranteed to be unique also. Several tests for the same executable can
 # declared using 'test_name'.
@@ -54,7 +56,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'test_name']
+        allowed = ['exe_name', 'cflags', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -82,6 +84,15 @@ foreach target, plan: tcg_tests
               'specify a different \'test_name\'')
       endif
 
+      cflags = []
+      if 'cflags' in setup
+        if exe_name in built_tests
+          error('test ' + exe_name + ' was already built with cflags: ' +
+                'remove cflags or set \'exe_name\' (if cflags are different)')
+        endif
+        cflags = setup['cflags']
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
@@ -91,7 +102,7 @@ foreach target, plan: tcg_tests
                                       '-MMD', '-MF', '@DEPFILE@',
                                       '-Wall', '-Werror',
                                       '-O0', '-g', '-fno-strict-aliasing',
-                                      ],
+                                      cflags],
                             depfile: exe_name + '.d',
                             output: exe_name + '.test',
                             build_by_default: false)
-- 
2.47.3


