Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE666C87FCD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 09:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEw8-0008Ab-3N; Fri, 25 Jul 2025 05:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ufEvv-0007wM-R8
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:41:47 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ufEvt-0006Nk-W2
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:41:43 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ae3be3eabd8so426157666b.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 02:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753436500; x=1754041300; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XM5OB303OsLObnsO70x9zZIJY/dDj9tedjFVb26nI4Q=;
 b=XfXpOuo6Kbv+p8yrp3ixg2OpSNa+6yrrDvhCilxRYspHcouKbG+g6hP1vjHp3b8hUY
 SDg97aeVclQRzG5ajPabpK+b/I4ruPN7sL1RvlucRYgvi1M35uUg/pINfLLnyBz9of1H
 IADH/vHvkY+vIkq1FO1kKto7/Z4rqxNKd2jgu69YZzZRcbu9E/ATrr0pg5bfkdwhtsky
 XDqqNQLspALoH7fbmHATydeP6OQ6KrXKRQ1cH2eEHPPlhqFxND+aSbOeRsImg+/ZMOF/
 AbfSw8tqMM20oVuf2WYT7AGpRNdhIz59uP9Z1LwjSB8QSh9JfPcP311Eu+G44WPJI5Fr
 KSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753436500; x=1754041300;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XM5OB303OsLObnsO70x9zZIJY/dDj9tedjFVb26nI4Q=;
 b=ItACm20KvcfCQ16FVvpdxy2BBTA8MNISJpl63NGVrritSx9Xqn7i1e05d04j3c1nUy
 o21oh3P8LYlYMRd70xMcVG/R8qhFM8wI8YY/KOAKyQj8KqKWrZAA2PTQ4My+FxHk8j9F
 ootsyTy9r8Q3oZut9c07aOxaKYMMDGaqMq7IVPmyLBEmA24SPUCioUSL1CboG4cgsf7B
 rj3f6IMGxfGp34DQF1lQnTADA1oyoIk7SfUShGREbAs5uJFcR3NOyEYFFTh5VLGpu83G
 7rRtbbWaEen3+g5d5V5/rycb96S1qbiJqig0Az3F2ibF0zUow4z/z/iEO3SxCCWY9DEs
 h6wA==
X-Gm-Message-State: AOJu0Yx/HwSw/epwf07dff+Llt0z7qZkIZC63M9LI7yr4uL9N/fVsyV+
 PwvBcD+BJrClh4mZzl2BC3VH9zBen1j5Ah63gXf9mivadcj1xfrHkh3+92VkmJOdb8ivfSw4GrO
 qn+4R
X-Gm-Gg: ASbGnctDfjcOeT9MOKZ+xdF3FcKIGzEq8mYTg6U7KEpCawpGucDr+63eT1dE1a3681t
 Mk2EzFmI2dPIfzBCqmXoogfuwQmXT6Wcq7JZmIQLLrxTyzUO7ZkG90dPHbS4sjGO2Okt/Sg6urX
 KJ98L0PlI4NRUqXWibLK60ZdWEopKspaIdcl1P/eqgD9eNF5KeddN4zGT6azDfE/47sWBW2c6Y0
 N960yhqflCJTKYo6vcSFTBd6JXYehi6b5hUGt0bFYwsQmyUGJaeTex7Ouva89B7Ydx3NKrDAHVa
 JKR+Y/+UQ6AU7EahGklVq36Pi2bUBnSamRZ6vY/R0emkQ7VjKvHEuNb/Qh7Pncgy0VGPsXtVSSD
 tI4l8svfGPktsxaPPvH+ci3L5LBCBp99uH00l7uHB6/UFcs+U5ov/yjU10VaEKvcXdpU=
X-Google-Smtp-Source: AGHT+IHgQyhFlUJs2PEJu+gYnhmMJabWpzZ4B5zplCflJHyBTajVvjsRm7PEO03elzmKtjJEtVVjBQ==
X-Received: by 2002:a17:906:4fd6:b0:adb:2f9b:e16f with SMTP id
 a640c23a62f3a-af61df590eemr145282266b.16.1753436500060; 
 Fri, 25 Jul 2025 02:41:40 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-210-241.home.otenet.gr. [2.86.210.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47ff42fc5sm243280266b.143.2025.07.25.02.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 02:41:39 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 25 Jul 2025 12:41:23 +0300
Subject: [PATCH v3 2/4] tests/functional: add --keep-scratch CLI arg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250725-functional_tests_debug_arg-v3-2-b89921baf810@linaro.org>
References: <20250725-functional_tests_debug_arg-v3-0-b89921baf810@linaro.org>
In-Reply-To: <20250725-functional_tests_debug_arg-v3-0-b89921baf810@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2095;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=lTEBmaVIcOg7XE2IMXRsNH+9p1M+nUMOfAZ/dVUkjyk=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9nMUZQd3lXRy9YTk9ITHVCUllJeWh6eENBYmM3CmpkNzZoN3R3VEJqSnoyVnpC
 YnVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUlOUlR3QUt
 DUkIzS2Nkd2YzNEowSHloRC8wZHl1RU9mQkQ3a2lOVEJlSGRzV1lNUE5HNlQ3dmFYQjdiY3VKbw
 pxVDV4cWpDRVFFUm9xZ1Vwc2U2aFVFVERRM3NmcUtjb0w1c2pYNmhHS0FiUEE1NThVZTFJWGFjO
 XFXbnk3c0xHCnBIZ2ZVWFdGVHI0WHJveVRZZGlFRjVNR01kdG00Q05MaXl1VVdDUkEwQ0JkWWxX
 aVU4WUlrYlhMTkRRdVRaUkkKRVNIQkk4TWk4UTgwc013eXdmWWEvK0g1MVNoQUdPVUVmc3ZRdm1
 3eEkxQzFMaE95ZmdhOGtZZFBLSmpDdDNmQQpuZUFxZjVER2QxcHcveDErTHZLWVZJV2pubXZoSk
 F5ZGg4T3N0Zk5QUGVxSXhnU0Z5VkhtV2RnOXZrYXhlWW16Cjg4eG1uaTU0NEJ5QnRoSC9SM2I5S
 kYrRnhieHZQbm1WaHJYek5UK2tRcS9yRmRRUEQzN3NjOC83QlEyVFBheW8KUGNYa29yTDFnMXUy
 MkV3TUJTOWgveGlodHp5M25XLzA4NFFEZXAvVEZGdWM5S0F0SDJTVW1uUnhZK0xnM1pFcApROEh
 SRGkyY2JHTHhkMURQM3ZzOUR6aFpkR04rUy94QUs2Rll5eFZZQlVPTFZ1TXFzWkJUQUtCU3hNQn
 FIMjFoCitXMVRncWNUcDArbEpSU1pndko4amtqd3hpV3d4Ym1VK0FCbjVDb2FtYUx2bm9UR0lQR
 DZhVjVOYTByUFRQQ0QKV3hueWM4dndnTnpvVFF3a3NPNEVRdG1ZaTNjTzYyaGpaaUhyY0EzUEdN
 MUoxU2U2bk5kTXBiQWxmWGc4S2IxTwpOcXFXTWhtVDhBUjBGTEEzU0ljVzlGK1hhZFFvWEVmVFl
 CRzA1Tjh1WHlxaXJlbzRvZS9kN2JSYVB2Z1dTRnZWCkMzQ3N3QT09Cj1nbmNnCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
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
Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 tests/functional/qemu_test/testcase.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index eedca7f1ad29c9e654cf56535acf9639d679f5c4..f7e306cf749e8b24a712b09dfe8673660cbb5085 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -35,6 +35,7 @@
 
 class QemuBaseTest(unittest.TestCase):
     debug: bool = False
+    keep_scratch: bool = "QEMU_TEST_KEEP_SCRATCH" in os.environ
 
     """
     Class method that initializes class attributes from given command-line
@@ -53,8 +54,16 @@ def parse_args():
             help="Also print test and console logs on stdout. This will make "
             "the TAP output invalid and is meant for debugging only.",
         )
+        parser.add_argument(
+            "--keep-scratch",
+            action="store_true",
+            help="Do not purge any scratch files created during the tests. "
+            "This is equivalent to setting QEMU_TEST_KEEP_SCRATCH=1 in the "
+            "environment.",
+        )
         args = parser.parse_args()
         QemuBaseTest.debug = args.debug
+        QemuBaseTest.keep_scratch |= args.keep_scratch
         return
 
     '''
@@ -262,8 +271,10 @@ def setUp(self):
             self.skipTest('One or more assets is not available')
 
     def tearDown(self):
-        if "QEMU_TEST_KEEP_SCRATCH" not in os.environ:
+        if not QemuBaseTest.keep_scratch:
             shutil.rmtree(self.workdir)
+        else:
+            self.log.info(f"Kept scratch files in {self.workdir}")
         if self.socketdir is not None:
             shutil.rmtree(self.socketdir.name)
             self.socketdir = None

-- 
2.47.2


