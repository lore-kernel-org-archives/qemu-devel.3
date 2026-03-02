Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519E9C624C2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzU3-0001H5-0V; Mon, 02 Mar 2026 04:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vwzU0-0001F6-Ps
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 04:22:32 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vwzTy-0007fG-R0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 04:22:32 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48069a48629so46114655e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 01:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772443348; x=1773048148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wljGdEyS4Z9nZiKech0RsOezG0RP3oczbwrNM7h6IQs=;
 b=QKE8jOb1LK56HESk1k/u2NCagJ6uueaZDW1zAJUW/EYqbqQcNTcA0VBzEe7RaEQwkz
 IPwrRu1wpGb4zBa2TTuvQRWxNhhfuKWdLAd4dgCg7QOiE1XgP1L92EJhI1ur1bvKXUCu
 A/elhuYeon2iLQ/1twBIV9mGeOchHBjfKIVlDMZq841TxbLHW3XwOTDkWS6HidBeDKfG
 7xP1wwBxjmOriSr8pt/LQMel3AP0OTmMxtDAKINxUsfIjTCZJiRegpmXoB913dzIimMU
 8riogaUrpPDKd8oZPkuPuWkFQ9Ye53dXjyK8lKfergDlgZHRjoDuDuOSoUPaOSQJ8pXn
 MZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772443348; x=1773048148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wljGdEyS4Z9nZiKech0RsOezG0RP3oczbwrNM7h6IQs=;
 b=XrCGfn+STVxOLz2n1v7tsdnzRdQY4XsF/0JaNdivF8MDJCXVzgPBOwAu3X2Zny5moi
 U5wOa3MtU5TyRG7sd3Oiqf32XjybzEIsdKf5LpaDIquL+DP5oYdDs4/0mQi7L2m8Vkao
 HJfknGZPUcKqOoVgiZzKrgcXUvwE2oJlPASOu93Q1R6BPKAwwgRBwcgNHGNlVV2Fpy0q
 goA8PaaCj2fJoArDO5c6oQQZ2D+qMiNuvSMCNbPOpkIxrDLV6aTagKrZVZXKipjx3yqC
 wQlk+RLoUJHPvP0yctP/y3hYqEX5AWvwbfwpq7hR89Ou+3hDJu0aJvXfaSMLkLgR4Zmd
 l67g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoEYAHyLSE8dw2EnpKiOm86cOQqI4AsbAeLqx81Z9lJbIDgFXG1jiGghfE68sEBedAqlAIYdiiMEBe@nongnu.org
X-Gm-Message-State: AOJu0Yyb6GeH+1fKMMHSAoGja4AZc1FU+XZmgZEf08WEJexifhZgh0Wi
 8BD83biisRNcp7wI4c/Wo/fq/m02hMYzAGpIBg8y/lHS/LHd3HHMCZYTGCGLer/JmT0=
X-Gm-Gg: ATEYQzxePUexqKdNFDriz6IomLF6OqkhIO7J7Pja5cyp74lkXR/RWsKSwzDQx2I4fPw
 QTNepIO0QUGZp10vuRT53/BY+v7KuS2UYgVE78XRXnPguqdhfPrHZC27czPNUOxGBtdp51EmH+J
 FDD/SM9kJwj6qC2S073uHdkrQChyfMSUThZX4iQ4CRxHrvtGxrEfAasu0vnsfmi+bdW8XDEAL1Q
 Z3aZixK+dAGaWEarKa00v7+EXH/iPyrYSUi3QXOerr6vsYeJeRzrgDBY+OdzW6zmnMTw9R61QXa
 FDIO61TXUU8tlr7Efftv3lYsE0cQnMMb8zBvVjkqgYEoFsEy6jzoSkyvDXld1qwSLzadWp5rOUw
 7lapZe1msFvF640bXOU7mtttdX0G5pvooURRGPHzdoTh43CchVYE2j05O+/9832w7wja2rtkYdc
 vesdzGdMpBxJpASEQ/9RorwlF2DMMk5QbHOFUxb5sWhDHR2yVnzyDp7ahoDDQTzQi6Mp9TZJdhG
 8FuurX4hsu87r9kCgDCjnRSPZ5Q+to=
X-Received: by 2002:a05:600c:4fd4:b0:483:43d8:8d68 with SMTP id
 5b1f17b1804b1-483c9c191d0mr188677755e9.28.1772443348335; 
 Mon, 02 Mar 2026 01:22:28 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb9d9c6sm129435305e9.14.2026.03.02.01.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 01:22:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Yodel Eldar <yodel.eldar@yodel.dev>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 1/9] scripts: Move lsan_suppressions.txt out of oss-fuzz
 subdir
Date: Mon,  2 Mar 2026 09:22:17 +0000
Message-ID: <20260302092225.4088227-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302092225.4088227-1-peter.maydell@linaro.org>
References: <20260302092225.4088227-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

The oss-fuzz code uses an lsan_suppressions file to suppress certain
leak-sanitizer cases that are known issues or not our code's bug.
This is useful more widely than just for the fuzzer harness: if you
want to build QEMU with the leak sanitizer enabled and run 'make
check' then you will want to suppress some bogus leak reports.

Move the file up a directory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v2: just move the file so we keep git log --follow happy;
fix up reference in tests/docker/test-fuzz
---
 .gitlab-ci.d/buildtest.yml                   | 2 +-
 scripts/{oss-fuzz => }/lsan_suppressions.txt | 0
 tests/docker/test-fuzz                       | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename scripts/{oss-fuzz => }/lsan_suppressions.txt (100%)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 1b656b9eb0..7548057c54 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -626,7 +626,7 @@ build-oss-fuzz:
     IMAGE: fedora
   script:
     - mkdir build-oss-fuzz
-    - export LSAN_OPTIONS=suppressions=scripts/oss-fuzz/lsan_suppressions.txt
+    - export LSAN_OPTIONS=suppressions=scripts/lsan_suppressions.txt
     - CC="clang" CXX="clang++" CFLAGS="-fsanitize=address"
       ./scripts/oss-fuzz/build.sh
     - export ASAN_OPTIONS="fast_unwind_on_malloc=0"
diff --git a/scripts/oss-fuzz/lsan_suppressions.txt b/scripts/lsan_suppressions.txt
similarity index 100%
rename from scripts/oss-fuzz/lsan_suppressions.txt
rename to scripts/lsan_suppressions.txt
diff --git a/tests/docker/test-fuzz b/tests/docker/test-fuzz
index 7e506ae1f6..d2bdc8afba 100755
--- a/tests/docker/test-fuzz
+++ b/tests/docker/test-fuzz
@@ -18,7 +18,7 @@ cd "$BUILD_DIR"
 cp -a $QEMU_SRC .
 cd src
 mkdir build-oss-fuzz
-export LSAN_OPTIONS=suppressions=scripts/oss-fuzz/lsan_suppressions.txt
+export LSAN_OPTIONS=suppressions=scripts/lsan_suppressions.txt
 env CC="clang" CXX="clang++" CFLAGS="-fsanitize=address" ./scripts/oss-fuzz/build.sh
 export ASAN_OPTIONS="fast_unwind_on_malloc=0"
 for fuzzer in $(find ./build-oss-fuzz/DEST_DIR/ -executable -type f | grep -v slirp); do
-- 
2.43.0


