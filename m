Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9B0C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 09:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uchEN-0006Ji-8K; Fri, 18 Jul 2025 05:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uch9r-0002KD-Ub
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 05:13:36 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uch9q-0000Lp-39
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 05:13:35 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso1098367f8f.1
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 02:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752830012; x=1753434812; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SKF3ehNzKZl68TtQb7ciFFbjhoSNV+hIsBspL//2FtQ=;
 b=NkCqqtgpquOyb81VaLqwOXxg81S1sEihpTGnbtAYxoELCiCkRbgYdmB8584w9b3OQX
 ianNIUeq2vVZKQdRK6GkFkJaaHo5J4fA/tJzhwrjR1ufhvN4DXUEtC/S54sCeIB6aDwu
 C5MqUTAUEVkI7T9YiCv4hwsQr4bUnr/iOZimqwy66UX12ZEhEUArL+sQcH4TWssJ9sN8
 7GYGFzT69I5HyI/IXdNVdIg7Z6CELfrJDoRLbcMU/KU4qKWKQKIFckQcD/IGN9jIVmX4
 iXdwGvJSUuCsKK/KSdF85IXblabmojIfLjmvs9jD7pfaaAqiy/nxZFqQwSE4cjbGOn/O
 zj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752830012; x=1753434812;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SKF3ehNzKZl68TtQb7ciFFbjhoSNV+hIsBspL//2FtQ=;
 b=BSC57BO0N8O9EMPQsxWTe3HrCNmHP+WQWaj0VKbnXlk7ly3fhx1Df+JhvyYvKyq4pc
 mRlVMKIw6UHHu1BgsLoMGvpbT58tbUiVrRmQT+zxWjvv1J+/7qylgXDfmp4/FxQpYW6r
 BhjyMmGt4y7vCQ9jYeQmN8an7cGEPp2zpk7+CdDRLym03CzTQXSkUbigMiXDlWSHAcaq
 5VSNtgy8yjof/9d0fwLFm4diDjb4+56qKvZsQh8N7qQfpI0oCACYdvzujSSRY4iG4GA7
 ReKO69jfKBgcImHdUtXA6LLmh3vmqjHLKDu5AWcFvxLbxN5RqTw8YzBcIihT68xYX5/+
 eAlA==
X-Gm-Message-State: AOJu0YwrwT6V5GxZbSm5izJIfC74JMOPd7X0O35YwkQQuE+st44+qRwf
 UacNI3mqUQwEh0pr4EjJaN0aS5MDqOGsq6cb7WPNvoFiY1GwzDfZS7s6ivHc86FdE/o=
X-Gm-Gg: ASbGncv1EtuFEcsEdOVXBV1+eDNGosCn4difOQG2S/YjG8fVzLi7J9I081j9WyUTX0d
 cDxRuJlEzFpNLN5u9Q2R5YSWxZq232wpTVFP5rdFvBUpqHAIaXa+QpQplDF+ZEau8C6eDxxBTLH
 OSC+S8QxJxHNGjlVzaexe2rn3c3VTnii7kLaaJ1X9M27z99wCSYEzmkkSUW2w8fh71TT+BpGuJP
 xeBU+93nXP1ULhC9NbtkKfJRkf5L6rEU0lupbYornFkb0kWnBPX396b+//a+DhiNKccUWUECHZv
 lgshAcfoR1ZT2u36JFzDrtd9Tx9WQa2WxkfIIvZZoQ92yx0supHXaUK2GDM3ymRlRQ2lILHQPQa
 LB/PsDOm7YLuQL5v9hT98cydksDiwUxUdxbiReF1Z2i0H2zOvui5S0vlnEpUutL33Kbs=
X-Google-Smtp-Source: AGHT+IGSTLDDWNho2cSUsFwUTQm9wJm8GdFyiyhOJ/hFnBmZQEM9zGiju1OaUCEI/3tNR9Y9oOdYrg==
X-Received: by 2002:a05:6000:5c2:b0:3a5:39bb:3d61 with SMTP id
 ffacd0b85a97d-3b613e982e0mr4489067f8f.27.1752830012170; 
 Fri, 18 Jul 2025 02:13:32 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-210-241.home.otenet.gr. [2.86.210.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca487fdsm1267145f8f.48.2025.07.18.02.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 02:13:31 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 18 Jul 2025 12:12:52 +0300
Subject: [PATCH 1/3] tests/functional: add --keep-scratch CLI arg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250718-functional_tests_args-v1-1-54d4c6207690@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2126;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=K5a2gnPN4N6QNLdI0OMBeHelXA8feQoDvJsJwXPmMHY=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9laEE1REYzWStyMFVEUTFRYTA0dFlKa0htTzBwCk1kbFNVZmRPdkdONVBpaEJS
 T21KQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUhvUU9RQUt
 DUkIzS2Nkd2YzNEowSmtaRUFDQ1ZnbFVUUE5tV1g3WlBNL09LNFNpL2p2N3I0M204TFdGYUt0TQ
 p1RzVDVFNlV2UyQVYwd21mNnBNTU5IdXBCZmErajg5TW9XMjBQWTFQWnhvWUdOVFdIUVU0VGxJY
 XB4RVE1RTdlCnErZ0JMdFZrcHFvREVoREExTzFHdFVCVVJsTitHVDZmdENvYXdkTm15YmtpVS9l
 QTZQVE9NcGlqN2ZjOEdYQ3EKbEtjN01iWXRVdzRIRVNpWGFDelhRUlRGQ2pCeGgvM0xoK2ZKSEx
 yd0F1dnBmdU1meHNTMmFJWDRPTVNMZHdwSgoyUGFpWnhHVWZ0ZldQN1hxMEk1TkJSUFNNR0tWUD
 FlU1o2NlJhMmY3dEFFb2pkbUZKaUFaR0M5eTRob1lkWDhGCnJIcU81MFBkNUc0NUh3Y2xtZnkwV
 ERpcjNyODlzaWpkak1IQkNGS3owa2NXUWF4UEVySDBqWmlLQU9aaklRSDMKYkVhblM2UEtnajJh
 Yi9kaVFyNzY0TSt0YzhPZFBDV09yNXNPcUtjV3JXdWpOS1R2Y3BOY2ZiMGpSaURKN1QyaQpBOHh
 CTmNacTFTQ1FmK2dLcWREYi8xQU1JZWdDcFZ2alg3WlJUczJjM2NiWktIQW1SMWtNd250Y3lFQi
 tXVUo2CitENEJWazdiNDMyekpSTXBEOXZwQWNqWUQvdElwMlVTa1VtQUZpbWRta2tBL0F0clRNd
 TZOYjVTVGZaeDlMVGEKUzU3TzdmLzV2ZGxMcmNGcUFVWERhalg5dnhEWm9uM3hCdmJVOFExTS9D
 UmEyTEpJb282aEZ3RHY5eFFsZVNLcQozcHRiendIbFNab2Uzc016OXl3MXdOVDNaS1FJM09Wb0J
 4bnUxUXh3WjlIcUlRNWxxandyZnMzZk9NeVpadVNjCnVtY1dyQT09Cj0vU3d4Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x435.google.com
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

Add CLI arg to keep scratch files after test execution, equivalent to
setting QEMU_TEST_KEEP_SCRATCH env var.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 tests/functional/qemu_test/testcase.py | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 3ecaaeffd4df2945fb4c44b4ddef6911527099b9..24f0b452964012532530a92018b2c4367b39fb77 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -43,6 +43,13 @@ def parse_args(test_name: str) -> argparse.Namespace:
         help="Also print test and console logs on stdout. This will make the"
         " TAP output invalid and is meant for debugging only.",
     )
+    parser.add_argument(
+        "--keep-scratch",
+        action="store_true",
+        help="Do not purge any scratch files created during the tests. "
+        "This is equivalent to setting QEMU_TEST_KEEP_SCRATCH=1 in the "
+        "environment.",
+    )
     return parser.parse_args()
 
 
@@ -214,6 +221,10 @@ def setUp(self):
         path = os.path.basename(sys.argv[0])[:-3]
         args = parse_args(path)
         self.stdout_handler = None
+        self.keep_scratch = (
+                "QEMU_TEST_KEEP_SCRATCH" in os.environ
+                or args.keep_scratch
+        )
         if args.debug:
             self.stdout_handler = logging.StreamHandler(sys.stdout)
             self.stdout_handler.setLevel(logging.DEBUG)
@@ -255,8 +266,10 @@ def setUp(self):
             self.skipTest('One or more assets is not available')
 
     def tearDown(self):
-        if "QEMU_TEST_KEEP_SCRATCH" not in os.environ:
+        if not self.keep_scratch:
             shutil.rmtree(self.workdir)
+        else:
+            self.log.info(f"Kept scratch files in {self.workdir}")
         if self.socketdir is not None:
             shutil.rmtree(self.socketdir.name)
             self.socketdir = None

-- 
2.47.2


