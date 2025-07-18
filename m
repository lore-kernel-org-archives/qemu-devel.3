Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD185C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 09:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uchEz-0006x3-Ma; Fri, 18 Jul 2025 05:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uch9u-0002NW-Hn
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 05:13:38 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uch9s-0000MR-MA
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 05:13:38 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so17902535e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 02:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752830015; x=1753434815; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5y0mBgXrmDS3hH/TI02TmHONGftjjb8PmM1JkTQOtQQ=;
 b=Aq8QE37k1dB5iYwkrlA60zv1bGcszqH7oGEUSx1S6cRDJpa3HGtPAxLlcKszDxhlQH
 q1ANIU/kUfsgRraGc5r9KGNAu0lkpmluD1nksRKkRn1q1NDISJTUsZumkeBcRqEAM0Rf
 DW/1sDWBgpPtTeChci+0tf5pqPqSNHi4oW9gg/6QoS6+vcWYCgIRIMmaq1qI21/vdi4b
 PrFpJmOdJFUrcUfblN2itz3ehMUKZZKOKCtEwR2CH6xfqUyVnnnw0PVNTLPdbm6mjQiL
 DwoPMd5LEA8xMZbRpFYwBG1b30SjuC5Hpi7gL4sUDENRCX9vRHAQ+s3kkak0YJ2AYsxa
 x9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752830015; x=1753434815;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5y0mBgXrmDS3hH/TI02TmHONGftjjb8PmM1JkTQOtQQ=;
 b=ftRr5p6DXDFk3fDXR7fYxmbcVdFCdyPlqTpaDtaLjqmCEk1XK4bj1fUbFeVAdwCzkh
 rpkBfvCGTN3PvNXEd5fAIeV7Di2zDtcCcHN5u4F1yMgLlFpQSxYee2xmBzgMvYM/dXvz
 IgLRWDYKI7QT9GnJUzn9qN72HQIO94cZkdQhW2A/mRTznCYqSbHaglTsT4kpTRMoY9mN
 6JWbskT883gGYKZS5y4mCTTSH4OvZwtIRuyx9EHVYHE35Zb2hq3eaQOIdZRjKA3q44mf
 gCJe+Gj7r97ms+AGjYmGx2yDI9bbWXEIiD23vhUSCsWz8QBBLHx8vsWL8yol/uIDoaBk
 k6Sw==
X-Gm-Message-State: AOJu0YyJGPaDdQeo1v2vvZeo9ygaGNRvEm5Ch/l6OsViPZVx8nr3OMHH
 Hmcw714PuoqkfTSCTaq9nNz5CoShkrs2komBYPPiILBr2MUGdRSjQEqfkuWUodvyxok=
X-Gm-Gg: ASbGnctsOMAnCJuSJzS0xqNq1/kaGYoe8km0NEzp5u3KSJgg9iN6gg3BP9WN5j7AYvv
 1+LOwNxSrNMQZsPYmpxvuz7k4EbwYFW9/JiJreiqWhp/maLlO43g1Q+Xiqg3zzWgb0gr5DnTut1
 MfvWcX5XrFzVHpVP/rQ8DHinxDxq/AHHV4P3V+vOD/3XnLmv/bc7YZiTmV7oZbrmZP5xzaXrwXv
 rOURznbZ8ZSFc+7Aeg/aGib5WdgatG6DqsKNdzd137vsxGJwaVKA79vwozJVkI+u9s6ZiZNCQOz
 3+2LiILSlUX8Zau7X45MkBc+o7IIEmx3Q3iDwIUt4YTikX8fQn7eMWtwREHQg2kGBwxOgld2vdN
 /E2iCIWe1MR3zIXsTctlRpXq6LW1+Afc3weFmW4hWvmrYJaKIRZkO56YP46edCawRI8N67ZgOuU
 rcgQ==
X-Google-Smtp-Source: AGHT+IH26TZOlXiKMAJessNtnfGni0jwKCETPsuSn0RMVzw5SdxHeD3t9dV6o2Heksn/H/nGLccErA==
X-Received: by 2002:a05:600c:a305:b0:453:8bc7:5e53 with SMTP id
 5b1f17b1804b1-4562e853505mr84291485e9.0.1752830014628; 
 Fri, 18 Jul 2025 02:13:34 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-210-241.home.otenet.gr. [2.86.210.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca487fdsm1267145f8f.48.2025.07.18.02.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 02:13:34 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 18 Jul 2025 12:12:54 +0300
Subject: [PATCH 3/3] tests/functional: add -k TEST_NAME_PATTERN CLI arg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-functional_tests_args-v1-3-54d4c6207690@linaro.org>
References: <20250718-functional_tests_args-v1-0-54d4c6207690@linaro.org>
In-Reply-To: <20250718-functional_tests_args-v1-0-54d4c6207690@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1844;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=80H8891T8c/kBfQKrgmGneoP6IgO83uKmcWZ5Z0ox8U=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9laEE1bUNRaGVjSzg3dVY0VnR4TXlZZ2FCWFljCmdTaE4rdkJzRmxOV1YxOUlU
 ZGVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUhvUU9RQUt
 DUkIzS2Nkd2YzNEowSVlyRC93TVc3ajRIYTZWQk5QRjFteURnaHU4dVY3SFdwTzNIVzU5U0RGRQ
 pGWGpLWElIRWJTWCtOUmFXR2kxdS9vU0FZUXl4VnMyNFFqUEllcWNxNTVzQkxHUm8yU0V6dXFKY
 UhwbHBpK2JUCjhrZXczeXM5bThjVEUyYnZoRTl0M2lyOTBmYkpPTFpNdlFGWG9NSHkrNXNWVnBw
 UCs2V2ZBeUpGRDA4eHNEZVgKM0VkV3ZlRERhRFBoVGJZS2xoaEM3LzR0eEdoSTdBejBpazQ5NE1
 CUjR3T0tPQ09sbGNYTzU5ZlBSVUhmY0NBKwoxZStqc3dnSjJhSHdhL3BaU2dQb2hmT01CaDNaak
 05RUZJZ3JHMHVCVU5HZktLUDB4TGZFOE9STVdkMWJnSDBiClQvK0NBR3diWVBocFNsZGFQa3g4b
 FNDbnNVR0ttVVZqZzI0L0xTWjhmeCtFRVVJN1BXWlhDRVUraDBWdW9iMEsKbjdLMTdjb2hqWTFo
 Q2VacDBMMkRKSkx0REJqdW5HSWtWb1h1TEZRc3loMmI2cUpseUpJQUFnWVJ4NGlWS0szeAppYXl
 UblNINUxoZDl6dnAySUc5VzlyeDlkdkppbS8zVWR3QVlRem53NFFmZnRjTll1NWsrQlV1eVd4TH
 NsYVg2ClQ1b1pFUS9mMXJUWmo1T0NCMzNpcU9FeHpPUGEwRzVueU9GeXV4R3R4M0JHM2Jid2dXe
 kxDY3FPUnJwMklmMlIKN2xxT1Bnb0F1TEhvUzVIUDJ1TVg2eEFKcFZ6VStyMkNUUFRGandpUDdP
 ejJ6VHJCTjNSNXRKa20ra0pPU3RxYwpmTHdxaHVpSm0xUTJ6Mks1bUJENzQ2VEsvTVpGcW9Ob1o
 3Yk16TjMzdDZ0YVpUb2VDZWRnUzlZdktwZWJpV2p2Ck9yakxEQT09Cj1iUTQ2Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
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
 tests/functional/qemu_test/testcase.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 4455fcc38016c14db04019bbd64eaae9b47363c1..b7a660fd729afe39ff8cf7a0be97c2fc2f2f573f 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -55,6 +55,14 @@ def parse_args(test_name: str) -> argparse.Namespace:
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
 
 
@@ -301,8 +309,12 @@ def main():
 
         tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
                                    test_output_log = pycotap.LogMode.LogToError)
+        argv = ["__dummy__", path] + (
+            (["-k"] + args.test_name_patterns)
+            if args.test_name_patterns else []
+        )
         res = unittest.main(module = None, testRunner = tr, exit = False,
-                            argv=["__dummy__", path])
+                            argv=argv)
         for (test, message) in res.result.errors + res.result.failures:
 
             if hasattr(test, "log_filename"):

-- 
2.47.2


