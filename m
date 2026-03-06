Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91238FCB61D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXs3-00080F-HO; Fri, 06 Mar 2026 11:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyXrv-0007NR-VJ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:17:42 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyXrs-0007kG-Ty
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:17:39 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4837584120eso72591345e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 08:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772813855; x=1773418655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mzSYGcm7/qr5Cg9HP7x8g6LlDTTQX7yElD9yTvaHjc=;
 b=u4n5NJzD/iYXIldQMpc8cxCny2yP/HQaHb8qtvvFfYBZ7LEn6364CfZhePUJO/XYwr
 f9McFSaRTQffrkDvhRWZVXN/0xvUaFycCahpbvBbl4EEeJVtiZ3gclW2USuPbLoA49XO
 axTQXkL2zeIig/BfcJ0c+lh+bZUHzD9zElTbddD1SfAPyH3mizChVy/yrH2FVvdpeDZw
 BgDFoinIxf/z5VRAbLTNDWHA8d9LPvpb/vd9+MUDeQbNixpCDOT/uNqpI6CYjRCm2jz5
 sK04IkHJI+pIw18l8d6MfRKuY8c5VwVan8PgUQplGWt9kUgm9Nfzb18Mb4iO8sDvb1Ii
 mCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772813855; x=1773418655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1mzSYGcm7/qr5Cg9HP7x8g6LlDTTQX7yElD9yTvaHjc=;
 b=L2JsvH7r90hANoCkq2Y0I8LBSALoK7hu3+M/oiM+lLdMjJSaLFgBXe4uZyWIccAK0+
 6G6rl0dMa5ZQbnYim0LrJ8HdBWdGaj29rfUgVAHZhA0Z5+ef7Zximy2DdCmKdV+uWaRV
 gOX/LI8VY/1d60/RZ7AP3OpwZJF7vX1/H93O0bvHVzGMm0hanKtI3B93sOKjE92N7Rh/
 LYaL4U8RacJSTIuP6uFMJEc2grn+0z0M1xeYDmVKQ7uBX5RheMjyRWZ3fNPvmiaVeRdj
 z4h5stGOFnxc4oZUaER5nrxzsQ+1XeBZjf8A05cqPIGFAj5qqD+oG21JCpeqncYvJ7H/
 8BPg==
X-Gm-Message-State: AOJu0YypNGidMdKY3mfai7+Fs48qyo0C9dwGti4nCmCXyYiLgtBhO7u/
 e66SSi+QWpiib3mOTx28s/W6c8fqOZffke1aQFiwfw0yu16i6c7wfzVQicTIOV0pUvo=
X-Gm-Gg: ATEYQzyjm13yeemd5Rkco5xrSkaC9DplHcS6v+wc98QwxthB6kRmjZ+SNpu0W01v3E9
 aUTx1/Wb773PmoDRJl0u5SE1NTfQCaUBnRidBC5ZaaUdP7rbbJ/Fdv0Z+M7wButMWnyVR1UDa7l
 AiKM3K99cY9w+SYKd3jX5VYQDa1phgz20Vleqf5DDXVDgPogcTJ3OXxB4oUH0nAfQ5hN1kGzExf
 N58NWhQkM9v1IzqEsIrFwnV+UDB8uOH6g88kd+rMnMrFNmp5SuUwm8SJpd7UJc4C2reTvg2YXfi
 dYeqV07VeN+3CuVuRQMCRVgm2lAXTpNAQ+ye+to3nm98aJG/LqB70xqOGJ2wI3Gxnkl2SRBgHOM
 ZxX4uXXrrbf+QXr1q6f5rFappYSpFnbYkyeDnFuM4Pl0k6tTrhi/tVlfFhE46UbdKAku1sF8b5g
 pBjxspPd50Td5NxFZbR5zP6fWPBnJTFK9Nww==
X-Received: by 2002:a05:600c:470d:b0:483:7f4e:fef6 with SMTP id
 5b1f17b1804b1-48526966afamr43721675e9.26.1772813855073; 
 Fri, 06 Mar 2026 08:17:35 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527686fa9sm55371075e9.8.2026.03.06.08.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:17:33 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5477D689D4;
 Fri, 06 Mar 2026 16:17:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 5/7] tests/functional: allow tests to define decompression
 target
Date: Fri,  6 Mar 2026 16:17:26 +0000
Message-ID: <20260306161728.2657486-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306161728.2657486-1-alex.bennee@linaro.org>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When dealing with multi-stage decompression we want to specify the
target file name lest we just overload the cache name. It also allows
for something is little more friendly than the cache hash.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/qemu_test/testcase.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index c2c916f6077..eaec1bea138 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -35,7 +35,7 @@
 
 class QemuBaseTest(unittest.TestCase):
 
-    def uncompress(self, compressed, format=None):
+    def uncompress(self, compressed, target=None, format=None):
         '''
         @params compressed: filename, Asset, or file-like object to uncompress
         @params format: optional compression format (gzip, lzma)
@@ -52,8 +52,11 @@ def uncompress(self, compressed, format=None):
         if isinstance(compressed, Asset):
             compressed.fetch()
 
-        (name, _ext) = os.path.splitext(str(compressed))
-        uncompressed = self.scratch_file(os.path.basename(name))
+        if target is not None:
+            uncompressed = self.scratch_file(target)
+        else:
+            (name, _ext) = os.path.splitext(str(compressed))
+            uncompressed = self.scratch_file(os.path.basename(name))
 
         uncompress(compressed, uncompressed, format)
 
-- 
2.47.3


