Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3004AC83F34
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 11:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucitm-0002h7-S4; Fri, 18 Jul 2025 07:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucitO-0002YD-Th
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 07:04:43 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucitN-0005om-5q
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 07:04:42 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a6e8b1fa37so1373970f8f.2
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 04:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752836679; x=1753441479; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nI52mj/NOpmVxIV/aC5RI+b8iaJ7jsY+o3+3JbLpnyM=;
 b=W0umaNY8+upSIlPPea+SGejreaoHFpIAYKYkbvKXla+pt50IBG2mmmuYJ/z6AsxL+H
 FbMbXXqOAh4ysm1Ba1Zpycbd4oKZF32lp2xnYf5jDMoqsHAMsxO+qT6+ceHHO3ZDf5nY
 +++eSoZPU+Ty8Ck8Tu+1L/9UYfDKt5XfKw8nbl5jPmmM6K5L9S4pWsykPWBWEmH3QIbH
 N4dwKChtXzhj6BKFnxfXhWWqHInnf/XJFOWFCV/kTo2F9RuqvVl9oWJ9f4EwqmFC6uAw
 dw2i0CYvRc54dvXZJT2Kr5Vq6/g/LlVm/n3jHQ2jBMnE/mq1pQTaauXtXcKkJxR2NmiY
 v37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752836679; x=1753441479;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nI52mj/NOpmVxIV/aC5RI+b8iaJ7jsY+o3+3JbLpnyM=;
 b=XvW2NiqcOKfnBP81+Yikp0goahygz+AsMAAUFGVHaFPcesbhHwaSXY89UNOlBrfNwL
 TFT18kf91cieEwQnDReDlJ5bTp/JcyTF/kjQd5UHeobIUPBDYA/L02X65B7vqZ0eXJMG
 YgiHyrCGk/pJz56yt0ziKiRsQcr8FT0xiJUEiPNyzGmHt/BB4hvJNUxVj/HIzfu7MrFz
 4F7BV5bCmxrIypV/Bg4B5gJj8dkivX1/oTLYg4+lbmpOpcmwj4KnHC8MpOf175AI4dqp
 CDLYc9EFQaMyISjgQ7irpA6B6Db6TNtW+OBKTdlf6SRK4g3Ze4/N5Ehb9xNF4wopkNrl
 6r/g==
X-Gm-Message-State: AOJu0YxiZ4lGBOXKYIWFV+hPWs6DZZETe/d3XI3FEiM9/qgsd2kcMlSG
 Agb/rCiTv8Y64fsEQd/FmoNEpu/jw5OpcXD7RYFRc3P/HlDGEQivQOC+tkX9llAPciTHkbQIvdo
 60Q2k
X-Gm-Gg: ASbGncuxr573QfoPCTKhnDfDsD7EWV23C0gCE6vdJ/p6uUYsEfR6WqZApvVDPefg+h7
 wwzQbsjv+dzOUeshjl8zLcCQ8jKqUrLkiDgMZvS4b36rNkq7quttgMx7rBc7+g9SMiSe70JydWr
 X2rzRNyCpA55LG7LpLA9bVJ8YabJ42mopohpO1jZeDdgaNebG0FFvZxDHfNZWpjc5zlxK65rhG9
 17ahDLuldp5NLDrzCQt/wFSty6dyrXJmsak0dBGcddjOS+lwNZnjhSaaPEs1O32y7WL/9f5iX3w
 B9yukpMAcERqkoe5NkdPUzc4bdJPwm06+xE/08DCTfEezbQA4GhuI7ydpjt8fRrSX/h+0XiAp+F
 +x87W7yTSWB/U2W3uLm1IvCPbBZ9fJFE8eZClcrL5Ye49/aFodpoSuggsMnNv9NT7MPg=
X-Google-Smtp-Source: AGHT+IE6AiflDnatX31QFul2w7FK2lYVC/cT9RI3+d4u0PWxx5vC16EqPttF8Y8+0j3D580V1o1b9g==
X-Received: by 2002:a05:6000:4b1e:b0:3b4:b4d:6861 with SMTP id
 ffacd0b85a97d-3b60e50fe9cmr7635945f8f.27.1752836679144; 
 Fri, 18 Jul 2025 04:04:39 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-210-241.home.otenet.gr. [2.86.210.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e8ab891sm76117585e9.35.2025.07.18.04.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 04:04:38 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 18 Jul 2025 14:04:27 +0300
Subject: [PATCH v2 3/3] tests/functional: add -k TEST_NAME_PATTERN CLI arg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-functional_tests_args-v2-3-cde6e08bf98e@linaro.org>
References: <20250718-functional_tests_args-v2-0-cde6e08bf98e@linaro.org>
In-Reply-To: <20250718-functional_tests_args-v2-0-cde6e08bf98e@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2179;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=1CgM+Kp1f+WKnkXx4AdXZu8CWuCTr/dCbXb3gkwdtYU=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9laXBDZURNR2lDNS9EWTZQV01xZm9pSTd4VjRTCjlEVDhnelJNVGhwanRxbDlL
 aVdKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUhvcVFnQUt
 DUkIzS2Nkd2YzNEowUFQwRC8wZVpWbTM0VE9sZUlqMTdjYjlvN0J5OXlRYkluN1ZucVdkRWhWTQ
 phbGVpM0RhQnlHTkxOcEF3bzhRV2xwV1ZaMlVZTVVtSFVlQWd0ci9yUUh3WGhHT3o5Ni93Y0pwR
 m1aTmhuVXQ2CjlVTlo5VStlQ3VYMFk5dHN2RU5WRTc4WVRWbjJDcDJFVnNFMmRleG0wRmY1UVVI
 SGlheHhTM3A1RGRNYzlqTlgKMFhsSi95UVE2QTgwMXVLb0hEMUp5djErNE5kWDBzYkFvQ3d4U3h
 zbHZRV1VmbmdSQVUrczQwdGowK2xzbkdXeApIaTl0K3ZOdjZJWkxrUXhDTklqY0dPT1VJNXR1aX
 BrZVcraFBsMU1vOEl0UnJGcFNtSkZaRVk0eDcvblhqWnZCCi9vWWdKZWZnU0ZLRUljNUkzNGxmM
 zd0RHdMbWNKTEU1QUl6NzJvVnJjdVRqUjhWbUl4WHpoZnVPcWQ2M25nVmwKaHRlMFNXQUZmZFIx
 dVJDVWdiOGF0L3F3bUl2SmdIcWxjTXk2d0RUcFFCKys1dHl3NXNvbnRMNVo3RnhpV2xESQpIc1V
 wUnljVVJYWjBILzhFOGJBcDA4M2tWMWJCM1pjcHJtbnNXcGhwVGtpdHFqbU1ua1dhcDR4Q0E5M1
 hiMVF2CmVKYnJtSUxVNmtzT2VwL3VkR0RRWDJiZVFsNVg5cFIwb1JYY0tRSStyaWZQb2tDbjlKc
 UlrSlV4cEtwMzFpakYKWFZ2WkVWUzBzK2FJTWwyT0FWcFhwbFc0RG9tNkt1eW1WQnNtN2R5S1pm
 MEtGT2E5RFZxSzl6d3ZrdmF6MHpBWgoxb01QaWgzQkhGZjhrcHl1UHd2VTRpZktUSnBNTURza3J
 CZDNZRnlOK3F0VVZwQ0lVczJHWmRnN0xjRHI4eVZSClZjY1Rsdz09Cj1DcUJTCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a CLI argument that takes fnmatch(3)-style patterns as value and can
be specified many times. Only tests that match the pattern will be
executed. This argument is passed to unittest.main which takes the same
argument.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 tests/functional/qemu_test/testcase.py | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index bfee6638edf6f9853ead1e3809ae3c9152089406..e137c05baf91f6f88d6228d86d98aa9498797382 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -16,6 +16,7 @@
 import os
 from pathlib import Path
 import pycotap
+import itertools
 import shutil
 from subprocess import run
 import sys
@@ -55,6 +56,14 @@ def parse_args(test_name: str) -> argparse.Namespace:
         action="store_true",
         help="List all tests that would be executed and exit.",
     )
+    parser.add_argument(
+        "-k",
+        dest="test_name_patterns",
+        action="append",
+        type=str,
+        help="Only run tests which match the given substring. "
+        "This argument is passed to unittest.main verbatim.",
+    )
     return parser.parse_args()
 
 
@@ -300,8 +309,16 @@ def main():
 
         tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
                                    test_output_log = pycotap.LogMode.LogToError)
-        res = unittest.main(module = None, testRunner = tr, exit = False,
-                            argv=["__dummy__", path])
+        argv = ["__dummy__", path] + (
+            list(
+                itertools.chain.from_iterable(
+                    ["-k", x] for x in args.test_name_patterns
+                )
+            )
+            if args.test_name_patterns
+            else []
+        )
+        res = unittest.main(module=None, testRunner=tr, exit=False, argv=argv)
         for (test, message) in res.result.errors + res.result.failures:
 
             if hasattr(test, "log_filename"):

-- 
2.47.2


