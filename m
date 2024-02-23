Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792E9C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXrc-0006Pb-Pk; Fri, 23 Feb 2024 10:53:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXhb-0004ls-G3; Fri, 23 Feb 2024 10:43:08 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rdXhZ-00064Q-R1; Fri, 23 Feb 2024 10:43:07 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dc0e5b223eso7724495ad.1; 
 Fri, 23 Feb 2024 07:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708702983; x=1709307783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qY6dAGjuanBxfUNkm+Wp8HJhSgEw1pVuG7LX12CZpas=;
 b=cxxWGvKPzJwwfivqSoB2+7wTaK0LyswMPT3w/Jy+QNI8UI3Vg27a3CVTHnnJVMnB9P
 ggL0wArCmhIu45Ac1TXnxUKO4BG9fjPW8FnlcxOK00rBBqlb9SzqwmhQoP7KIaeOd1a1
 dFGGtTD0o5xKzfzgqBJlWaFRYbtlbEfCC0V+QaZC3dat5+sLmQNoBHg7jE5KEzMYl9N9
 6v0YY8ay3brf+OHrO4dzlI25nsui1Bdf+K0TfuBky3y4E/gMBt9RAM6A+mmQutjGyvPg
 EMr/QlOt+x8gz8cCMVEB82B8M+Ym9g8yteARXOB5E5HOnA8fOOvfzN9I+Xsxb/Yf23if
 FmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708702983; x=1709307783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qY6dAGjuanBxfUNkm+Wp8HJhSgEw1pVuG7LX12CZpas=;
 b=DWVg+qOidEXynI8gwmOgiNvFAr7dezUoyh387K/OJU6WkyqWTWOVTZ1Pt5+oY735SY
 AGWdbxZq08dFTency0Y/f66rUh9V97rtase94z4yRkVdjmpA56muGlGVDrrv2UJK/Yke
 b2QKJotsgcPYBHLux1rnFJo1z7sR1abijkK4yrjq08m9f4+afPfowOB4DFdmIJSSRIB3
 xweIXe3VnBCqG/q3xiLg10Als+NTuu7f2aL/rjbaITTjdjiGtC9GZ44hu0aGgpTAEw5z
 eHCWVbV8aUixYa06mH0V5xGXgie8xTbvgWk24n9X/qK5DKikxE8sg+AqVYOdg6cdbO14
 EhLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0hxnlrw/HYFHUiXDHHMQxgdDjlJ4p4b7JRF7p6KImns3GJ1ahF0K9xKHWd/pZb23crwEu9LQHM1I0PA+Qdc+IUx9i
X-Gm-Message-State: AOJu0YxNDem07tHSwkAT09+JKYx2fIJnwqyBWr1goocklt243KT18MgE
 8x+0xEOEZrweR/i0cfdrUCG5SdD4YtwIC8QaONGBpc/IyWjIs6qKdDsrwzfD
X-Google-Smtp-Source: AGHT+IHrBbDbyOPOdD4aAylp4Cvl1wOf/b4Xl9Ar9H6ILM9MV4w8c8ul2RVAqxNvjH7yTs0c9dZy/g==
X-Received: by 2002:a17:903:8c7:b0:1dc:7362:7365 with SMTP id
 lk7-20020a17090308c700b001dc73627365mr209232plb.4.1708702983234; 
 Fri, 23 Feb 2024 07:43:03 -0800 (PST)
Received: from wheely.local0.net (220-235-194-103.tpgi.com.au.
 [220.235.194.103]) by smtp.gmail.com with ESMTPSA id
 h18-20020a170902f2d200b001d913992d8csm11808208plc.242.2024.02.23.07.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 07:43:02 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 03/47] tests/avocado: mark boot_linux.py long runtime instead
 of flaky
Date: Sat, 24 Feb 2024 01:41:22 +1000
Message-ID: <20240223154211.1001692-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
References: <20240223154211.1001692-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The ppc64 and s390x tests were first marked skipIf GITLAB_CI by commit
c0c8687ef0f ("tests/avocado: disable BootLinuxPPC64 test in CI"), and
commit 0f26d94ec9e ("tests/acceptance: skip s390x_ccw_vrtio_tcg on
GitLab") due to being very heavy-weight for gitlab CI.

Commit 9b45cc99318 ("docs/devel: rationalise unstable gitlab tests under
FLAKY_TESTS") changed this to being flaky but it isn't really, it just
had a long runtime.

So take the SPEED=slow variable from qtests and introduce it to avocado,
and make these tests require it.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/devel/testing.rst      | 11 +++++++++++
 tests/avocado/boot_linux.py |  8 ++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index aa96eacec5..fa28e3ecb2 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -1346,6 +1346,17 @@ the environment.
 The definition of *large* is a bit arbitrary here, but it usually means an
 asset which occupies at least 1GB of size on disk when uncompressed.
 
+SPEED
+^^^^^
+Tests which have a long runtime will not be run unless ``SPEED=slow`` is
+exported on the environment.
+
+The definition of *long* is a bit arbitrary here, and it depends on the
+usefulness of the test too. A unique test is worth spending more time on,
+small variations on existing tests perhaps less so. As a rough guide,
+a test or set of similar tests which take more than 100 seconds to
+complete.
+
 AVOCADO_ALLOW_UNTRUSTED_CODE
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 There are tests which will boot a kernel image or firmware that can be
diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
index 7c4769904e..de4c8805f7 100644
--- a/tests/avocado/boot_linux.py
+++ b/tests/avocado/boot_linux.py
@@ -93,13 +93,11 @@ class BootLinuxPPC64(LinuxTest):
 
     timeout = 360
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
+    @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
     def test_pseries_tcg(self):
         """
         :avocado: tags=machine:pseries
         :avocado: tags=accel:tcg
-        :avocado: tags=flaky
         """
         self.require_accelerator("tcg")
         self.vm.add_args("-accel", "tcg")
@@ -113,13 +111,11 @@ class BootLinuxS390X(LinuxTest):
 
     timeout = 240
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
+    @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
     def test_s390_ccw_virtio_tcg(self):
         """
         :avocado: tags=machine:s390-ccw-virtio
         :avocado: tags=accel:tcg
-        :avocado: tags=flaky
         """
         self.require_accelerator("tcg")
         self.vm.add_args("-accel", "tcg")
-- 
2.42.0


