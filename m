Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EC4C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ26-00069a-Gm; Fri, 10 Jul 2026 17:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1p-0005bq-5Z
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1m-0003Xp-BK
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:00 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ALClpa1931558
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k4wVqmU15ysqKVljW32Ew3P+40ii1P2j1g5pR/gHCGY=; b=SjVzGrS0LDEmtxk4
 Fap7kP0GULhJPis4HiUipJOfHPHX+i10jtRNX3Tov7d6hPI9n1leEmFcEkqwLfc4
 olvoX7DmN3QSNMl8W/ITJNqp5BLYHnQrWRqzsBf+PNgjmgYHg/+xht9GPifwJf3G
 XTKgVj9QeA1ZBO1XEh1sAzAmmYk048YLMY4M8RNjx8a/9KS8HPdc9HBwbkihiUw1
 JKuPkbd+Sg8Z4lVVzRI+4I5zULWbJni7HinDhVpb1uMPzAjoXT7f0HqbFmd3HVEC
 scF5L4g/RkxkiN+bOc2h+tCcMnisOB5xZg9TNCwEfsYuSWj7RoNd/QTBY6yG2uHF
 ID6SAA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb8f2r2m8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:47 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c891ed872ddso2012427a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719886; x=1784324686; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k4wVqmU15ysqKVljW32Ew3P+40ii1P2j1g5pR/gHCGY=;
 b=L0u7DI0UuHigmtrSOB+CeZk6ANZZ8cXrOAdeMHfhk4xgrM9ykLlPuwPDon4W2jClwV
 NnXMrGrvJ9OgzOmME2QFrqX8/JDy39TaJXGm56/HPr029AyiVxRH+AYoXTJWjPDWU+V+
 AyMeuDAv+5NycKtIIHhga1+hHrEUeR/wxa8u4Xm+wDUvi7ZxoTcQSf/trqW3OUvvyhoa
 mrluWA4yBiJ4OXwvMljiorVukRNlHFdkgwb4IEExCzmrYGJqjapzT8At5JWXpfFZbqKt
 54Rwkz74bZG8AjP2eRREQRuVhsiGk3pB+ANQpMmEJfpesADjM2BWuSGOYR/Wh0K4UduA
 6cjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719886; x=1784324686;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k4wVqmU15ysqKVljW32Ew3P+40ii1P2j1g5pR/gHCGY=;
 b=Qy/r1qeYNpdfcxCeLQVHDcY5TStwje8iMutCXPjNUfn3OxNy9uEvwlz9MzZrvSxc5b
 Swh4CJSK7N2z3tk7ywOwYE2HmZBmajErwTNR4ZGMOV0JWTTPTsdbI9AKk78VVpzpNwgV
 xHLQBjULh5XcF3B93OgCEiFabejOl+cJZUELFY2DqPPMjdAoPEopkF7SHRCbOzPZ4GSB
 0T9cNnM5/qvKnjKengpYaIB51QJA4v++B+8vY+HJFXksvcC5WzLJeWwIeusyXbTUsbP/
 u5Y3oR/ldlFEYLIGPaS7w47Y+6BFEc8UM4QPQSvwEUEaWGRYnzMjAsFudlqENBN1wQqY
 xr2Q==
X-Gm-Message-State: AOJu0YxjugBbO1brfL0X+SR8RHEYSFdulWC/XWQLV4pCRg4A65voPLPz
 3Jqf4qnmj/csTsYdUe0eWMYT5eqWcWup6LlBYHv4u4Utb71b7ndMDgaeoXaXlwjJEt+lyhushQT
 ZNjvC+p14qwXUTeaOkKbdZmcs7rVhZw8UeT/Wp+tUUPikq2zv7PeeFXMWD16jbIr9Og==
X-Gm-Gg: AfdE7ckMSERS9qMsXJntCgX9JaVCorR+HijBRwPnicyr6dsxfcewU9CX83+5joTLi9j
 fgPkmQjBEkuIcSxpZ5NpaZhiGz1r1qTeGxcQczCLzQ1b/NOw/i7fUVDUM+3hrxLbVRDRvUfROPh
 MBw240ViRrEfZyb3+B1uthpwgBSdFn2G9rbqVDP3FJuen9lz8VdsOlMrkzarEXvVxDJxnQhVtO7
 Qo1yp3og9/7tGSBO1X2YS5dGHMQjdKSG1tbEEYMISU6UmdWkqNtYmtMInXjdwybtL/wClh5JtO2
 hlnBhDc0QwIau0BP7/DiiDO4Ab6f+ZK2ARXiJcxQGwuYjDlCizIiFhkBS0W9ZtfC7zEktwcPQbn
 8gQmEWSWbbg1hNkItqwbyFGNlYtuzwSCxGLrqqPtjFB8WjhZf6MTRzlzRnWHwfG/7sKpk1yZr6I
 R9dgeVfQ==
X-Received: by 2002:a05:6a20:a124:b0:3bf:b50f:71bb with SMTP id
 adf61e73a8af0-3c110a99c8cmr743199637.27.1783719886402; 
 Fri, 10 Jul 2026 14:44:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:a124:b0:3bf:b50f:71bb with SMTP id
 adf61e73a8af0-3c110a99c8cmr743178637.27.1783719885944; 
 Fri, 10 Jul 2026 14:44:45 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:45 -0700 (PDT)
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
Subject: [PATCH v5 30/98] tests/tcg/meson.build: introduce depends
Date: Fri, 10 Jul 2026 14:42:34 -0700
Message-ID: <20260710214343.2065491-31-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLavDxGx c=1 sm=1 tr=0 ts=6a5167cf cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=aZLzzxQjhWCqgOQfChsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: b7iP5Bj0wE5a6IxqapJApZxnb7VTUpcT
X-Proofpoint-ORIG-GUID: b7iP5Bj0wE5a6IxqapJApZxnb7VTUpcT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX0uh9J5D4dApP
 j5l23jcR02Z8UVn9g6FpCIvOeO6k2QWYD3R4GpNOOBcLmNmjfu/Qv7lNlvlkKxseGS5GeRs2NLW
 r1ozB16xOXqJ6AAsW7WuSTdcwDPxVKY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX0T2uH/OyBHH8
 3N2sAATMoDNVByIBAMy/KpTrWIe0UG0IpsF47yzanc0ZO+SmCJGKgV7GvdgwHv3hYC4sX0CHWQq
 LSelW6DcM54Mv5ByCoLjSs3zXGHSoQRPe+/cJ2TbcOZoRpShq5rC76c3TBJVx2fFqG652K/+RnW
 F8KJpQiLwjN7cWZTK55s2b55RmEAXBqo0I7QcvV3/J7NSwq9OB1k1wMRqIODh4R2Yapf5x4m2M2
 hGauj82dDrlNahqiCS0ZBBc4a3pQKd4IOI6WQpIZqvZoFAW5rLWDipT9VZ7shOLWMrmnxOJYFAL
 RFimZSuoKYoKZikGeKojyEFwIa9YKo6z78cC/MfCAPfHQmVE4PXg+FvegEkU2cY0l+M1jKoR0TN
 fFn+z3csTIfteSa9YnMSoCHoOA2sjL4EUsXNrBd5lvkiVknxTw5v1iER7DmOI+ix5AG4ToGzhkX
 erUwY2m2DURdxqkz9jg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100218
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

This can be used to declare dependencies for a given test executable.
Useful when generating headers (like x86_64 does).

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 6fd6f5bd187..23a28890ce7 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -40,6 +40,7 @@ tcg_tests = {}
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
+#           'depends': [meson_dependency, ...],
 #           'cc_feat': 'feature name, must be present in cc_feat_cflags',
 #           'qemu_args': ['qemu command line flags', ...],
 #           'expected_output': 'file_to_compare_output',
@@ -176,7 +177,7 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
-                   'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
+                   'depends', 'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
                    'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
@@ -275,6 +276,11 @@ foreach target, plan: tcg_tests
         built_tests += {exe_name: exe_name}
       endif
 
+      exe_depends = build_test_depends
+      if 'depends' in setup
+        exe_depends += setup['depends']
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
@@ -287,13 +293,13 @@ foreach target, plan: tcg_tests
                                       cflags],
                             depfile: exe_name + '.d',
                             output: exe_name + '.test',
-                            depends: build_test_depends,
+                            depends: exe_depends,
                             depend_files: build_test_depend_files,
                             build_by_default: false)
         built_tests += {exe_name: exe}
       endif
 
-      depends = []
+      test_depends = []
       qemu_args = []
       if 'qemu_args' in setup
         qemu_args = setup['qemu_args']
@@ -310,7 +316,7 @@ foreach target, plan: tcg_tests
         plugin_args = ','.join(plugin_args)
 
         # since we turn plugin into a string, add dependency explicitly
-        depends += plugin
+        test_depends += plugin
         qemu_args = ['-plugin', plugin.full_path() + plugin_args, qemu_args]
       endif
 
@@ -365,7 +371,7 @@ foreach target, plan: tcg_tests
       endif
 
       test(test_name, env, args: cmd,
-           depends: depends,
+           depends: test_depends,
            timeout: 120,
            suite: ['tcg', 'tcg-' + target])
       added_tests += {test_name: true}
-- 
2.47.3


