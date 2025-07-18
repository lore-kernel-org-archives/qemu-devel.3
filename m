Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D315C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 11:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucitc-0002bJ-1m; Fri, 18 Jul 2025 07:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucitN-0002Vj-7d
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 07:04:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucitK-0005ma-Sa
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 07:04:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4563cfac19cso4444645e9.2
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 04:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752836677; x=1753441477; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zul+EPFf+TzuuiH6vyHLxY5TPUuTnHHzqa/2t4GYRqE=;
 b=Hpg9oNbD5uS8kjseMpKac6wwErBXyTebMTkV9XgWSsmKRyTcbrBtJTqhNXIuxbtnlb
 6ytVebf9FNj8blgp3iSGpJfGkJJ9mXRL004bMwY1Cx9xXySfSPLw0EkjuK76kk2+bLiI
 Z05d54gh538wMcz7G7eaNltDF7ZW/g+2jc4AjN7d/F6xILdh1mnmHcZh6indKvUAvUMr
 Cbo7KSY/oUf3uWRyJjF+Lhi6CGvK3PoZ+dzbhY15uWqZld+yGSEXDrVAGNivBdM+1MPN
 /TJylKW33DCi6RHgSs8LeWGmzql6McRcjOaji+YcitsOTS+MX2VoJy+G2MpMWe04aOHU
 pbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752836677; x=1753441477;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zul+EPFf+TzuuiH6vyHLxY5TPUuTnHHzqa/2t4GYRqE=;
 b=lLdjc32GVVzuq59IqJ/e4O8vTHGyKPnDIt5BndUqILLzILUfpHKvcYnkv82rUuZPZy
 c1QnPvXOJERCndj2e+8SW0s0g6YlXCjeZ1wWCidM3Sg0Fx9mUQGCdKtOQxsR3fk7aBxD
 su77Sc9vd5ThqME6cei/nKU5zMtiOYlgr5kasagnO25r5T/8s7V8M7Viy57R+o8f8TwU
 5iSbcnn0BTt0eGjd0vcB4G0Lp1Q/7muzPDxDiNA97OL06FSwo0ctOwKfW3lwcpwviJl6
 XGGVNKm0YFyVh/5TiMt3wBl2h48SvLXDS/4gzLMc7zQueYhVdtkd9ACpXsdk7rlBNkbr
 QIkg==
X-Gm-Message-State: AOJu0YzCmd683J4wAQsuYGdC5ifnqfbWQCTqtubS65Dwtzx5ZHvNLbfX
 u1irqvEZbg7gHTRqy3K8JPUn5S/X2eOlf4upH1HB+0MFhqeiifm8LgRycuHO4RMs2b0923cBOzg
 VZCb4
X-Gm-Gg: ASbGncvZJnDTiGS68JLhze3im5KL5C1oxDkroUYMXh6Y/AuyAjTdiwSII/EmGB3RR2e
 xrmoPhp18jC38tY69kBlXlptgAw1+tHi7N1+ElE4K6rua47XmqQ7KWQ8OPfDX/aLn0xT/625Rak
 mPMKrDfjCXmDkVpHMj0EHylp+C8TqT61vlrloK6ovvnBeRTUvK0+znIerbhKn1iAnteVCdPEIIN
 rB1kEmwIK5WfLDPP/cwczT62fwvRxD1rD7PvdqklpMv1/8OQtzMRR9Xtex30ZbRMJiR47Xx3xqP
 SoRzPax07YUWfXusXBVY48ltfV9FPXRCWMG7zuVh4gses8N8Ad7RIr7Kb9m88Bt0PRP6NfSEkWz
 JC7Cr4yvtB72ZC3rp7+cBTHhVWmwyfMxWWIWTpE1O1+jjZotTGvD9L/CFbdYAUWhE0Ck=
X-Google-Smtp-Source: AGHT+IGuoABJQ9QQxPkvN6zyPWhTbX+Egy29RYjEKwX5eorrS12ZcEYXDAivZye69Qy7eVwPGsgMug==
X-Received: by 2002:a05:600c:310b:b0:453:9b7:c214 with SMTP id
 5b1f17b1804b1-4562e29c33emr92628035e9.29.1752836676555; 
 Fri, 18 Jul 2025 04:04:36 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-210-241.home.otenet.gr. [2.86.210.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e8ab891sm76117585e9.35.2025.07.18.04.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 04:04:36 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 18 Jul 2025 14:04:25 +0300
Subject: [PATCH v2 1/3] tests/functional: add --keep-scratch CLI arg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250718-functional_tests_args-v2-1-cde6e08bf98e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2102;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=6NIq2ZkKScjqA7t42lY2yX+T5zJ+KW32NQ4ekf9u8Ns=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9laXBCWE5UTmRPbVdYTWF5M0pNcFpaZ0JacHhiClVZUWwwNmFrY3lVS0pLa0hu
 c2lKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUhvcVFRQUt
 DUkIzS2Nkd2YzNEowQWYwRUFDU1FWTjZiTkFURG5VMmNwbkp6STVNcHRMb3FKU3hjV282eXVzdQ
 pCRE1ETmZTNm50a1FYcURSRlFhRHVPWXI5clBBNmFLaFJpOHNWanNzOGhXSlJZMllITFg0Z0UzN
 3VYTWJpOFQxCnZRd0tsN3NHTW5HL3ZhTmZQamNCSlk0MDZRblNUK3p6ZU5PWHRuTCtWWWQ4ZTlk
 RTc5UEFmcUlQN3lyU3pvM2YKQWxmRWtNMmtvbnRzcGhkZFp6UWVGSE9ZZ3BTeW5YT283KzdDdEp
 ybFlIbWZLRFVRMndFUlhmV2JVU2g4R3ZGYwpxWDg4TTRkL2c2aEhrUi80ZFA3MXFrUStFV0VGcl
 pCZXBTc3o1Q1pnRExlRE9UQ0dJakk5Z3dzVHFyU1JDMFpWCjk4cWhiQzl6Z010aUluVGR2cEtnb
 nJrTGthaHhqL2xYeHBES0hvcWxNZ1JjVFlxQ1ljZUh6cUJrUWg3elRWU3IKYkJ0ZnlLRzNrYWh1
 UE1Jb1ljdmNRY0ZzWEliTDNaRE0zbzZtdWsxaStXUDBwU0FTVnNpazVHbmUvOWRUWW1ZcgphUGR
 DWWhZaHF6cnVENytLNUdGWmtGOGJ5YVR2Q1BvZnZZRjFRa1djVHVoOUZPMXlEa1lEOE5TUDVPbV
 pldCtzCkl6cU10OEpQR05xMGh2cXVrbE1VMmc4ZUlMQkpwN3MyYzRoek4ydEZLTzdnL1lTR0NDc
 0xQL0NldlJSZmlvcEoKd2tpUGk4ZXRlZGlFTVBXcjZQUkFhTFZ4OHZtRnVYdFUzeXpqNG9SMHd1
 NmZveVNrc1krcjdZaWRQU203eENmZQpTVnB3KzJySzVuOHBtNVErd1A0RmdqMmYxWmdYZ01haXZ
 NSTZTWWNNT3oyQ3hlTkxUZU1KL0gxdG4yS2daTFdlCm5Fa3BzUT09Cj1yR2ZVCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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
 tests/functional/qemu_test/testcase.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 3ecaaeffd4df2945fb4c44b4ddef6911527099b9..9b00c63e6ca7a2a669fd456f1d1b51501ce4a726 100644
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
 
 
@@ -214,6 +221,9 @@ def setUp(self):
         path = os.path.basename(sys.argv[0])[:-3]
         args = parse_args(path)
         self.stdout_handler = None
+        self.keep_scratch = (
+            "QEMU_TEST_KEEP_SCRATCH" in os.environ or args.keep_scratch
+        )
         if args.debug:
             self.stdout_handler = logging.StreamHandler(sys.stdout)
             self.stdout_handler.setLevel(logging.DEBUG)
@@ -255,8 +265,10 @@ def setUp(self):
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


