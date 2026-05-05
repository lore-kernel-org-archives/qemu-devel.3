Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584B7CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 12:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKEs4-0001cW-WF; Tue, 05 May 2026 08:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKEs2-0001bu-KP
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:27:26 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKEs0-0002WN-Q1
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:27:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-44509921fbcso2682327f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 05:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777984043; x=1778588843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wJLx2Bpa6UvFBRYbopR5yB3HJjv1ofwchdbZfTiBWOk=;
 b=mkBLS8g9EUQOLjLWPRBxcfKQwDDW3NC+FBNrlMvOF51jGA/GsrQL5f/RFn8jNUZ3h0
 Ada9q0u7ppzOU2SpUhuWJVgElqQCur/oz6Lr5cuSu/aHg0euL1HLJ4AZF9oF7N/EEPpu
 bkTN68bCG5UF7CpgdEDem9SUe6i5ksq+i7H9hUr5IwWQtIfjlByJJMBIBq9vBVjqgjwX
 wE/vuDDxWzbwf+iCaYyAUcF20fvDDOTOiFMKMAoxwMibQHONaASbJjkLzXSNTGfULqwn
 TtQVOw3TC5PVdSeC56ZIjCs7VzzFv98e34YobgbJW5E8Tcg55ACZkPU0M1B9jt4mWyk7
 E5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777984043; x=1778588843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJLx2Bpa6UvFBRYbopR5yB3HJjv1ofwchdbZfTiBWOk=;
 b=GE10Iqe38YVx3mGgWyUcHaA9B1DA65tVIWdw9Efb/09f9r68AkHPY3j7OslsxgLHLI
 mfmigmGj43bVyuSPb+uL4chCjtFYZ7v7wVB3FUVPaDq+5dnrNl5z4LV7F2NLZBoD/mNM
 Gm0y5DQmIqpmtsBkDmsMHKnV3zSDbFLVD92CqkB2zMvnq37+NhpLINr7cNHdi6cowE2K
 IRuFeZRyZrwS9FbBPN8/RHVQW9VQXlE2wlgviyf+10DcfoK63gWb0H1jopyMo/SUzEK0
 irh6Z7gfmBj8ItTLjPccnpOVTF5lOXn02UOKJe4z05LRVL7eGlamAKwkmM6RR0MQHYyk
 1UpQ==
X-Gm-Message-State: AOJu0YxyZsv/xn/jkoVin1adA61A47AS74BABF+HDC0jbtUKWbmUDYii
 tMu5wcz1VxLh4LBjAvFSjo5n2ytbBjUx8hCxsW+yfsggHsRtOfwX5CXNus+S2r4ubtf5i/nNR56
 Gmv1L
X-Gm-Gg: AeBDievz1f539krFd74gTY7HKBcNaW/itrf0AiS4zhNtsITaGNVMvCElW9guyoGnQLv
 /gSFxnlbSl3kBrIbhXKMe1CCVbBuQROqLRoEYQpUQPB4e3Yay5ieNl6+qazPLiI/EJNC4Yr3Suj
 mioLIqEtsKLyp/i145s+x+tenHK8cH1GLbY/Oq3hQ083+ZGSD9B5G1ceevAiqaFMYWuJH2J7HOB
 WEN+63XSwqBlhHFOwYvL1J/tbzeXhP9PYZl5T2mx5qYEZ2BSZxw29giy9BjtJM1Xtf8A7UNHlbv
 kJwJEZIcQTyLMZ7wgt6yjs2ZuyBETei4CdgVP7zX9d4ADcb/W7ihTXky7SQJkYQeObYD9+8Os54
 MSXQqum4fR+z01pFKYsNtEeZMD7nGy8hfGAimrf+3yupSH15X8uIKCss/X35p6RBBX3NUy9lRP2
 XClzw9OxooLFFyl35MsYmy51RImn81IQoZV0lwzvZEQ+hh4rxxrDKrAYKNh9a2InFQmbTnqQIts
 2JNRBUCylvXNyRyKTLu34bibbSqqhDtm7EiM+2h7w==
X-Received: by 2002:a05:6000:26c4:b0:43c:ffee:ee94 with SMTP id
 ffacd0b85a97d-44bb34e6f03mr24536877f8f.11.1777984042831; 
 Tue, 05 May 2026 05:27:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960973sm4220017f8f.30.2026.05.05.05.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 05:27:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [RFC PATCH] .gitlab-ci.d: Define new clang sanitizer CI jobs
Date: Tue,  5 May 2026 13:27:21 +0100
Message-ID: <20260505122721.429174-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Define new CI jobs to build QEMU with all the clang sanitizers
enabled and run "make check".  The split jobs are patterned on
the existing build-cfi-aarch64 / check-cfi-aarch64 ones.

This patch is RFC because the resulting test job times out.  I'm
posting it for suggestions on how we want to try to do this, because
I do think that now we're very nearly at "clean pass on sanitizers"
that's worth defending in CI. (We ought also to be able to do
similar for "make check-functional", but that has an even longer
running and also in my local testing it seems to be flaky for
reasons unrelated to sanitizer fails and which I haven't tried
to track down.)

The build job is fine, but the "make check" job times out long before
it finishes: on the general gitlab runners that my personal QEMU
gitlab repo gets access to, it completed only 102/591 tests within
the hour:
    https://gitlab.com/pm215/qemu/-/jobs/14179464576

We could have multiple versions that split up the targets, but it
would be nice if we could build once and have multiple test jobs;
especially as we move more files into "build-once" having multiple
build jobs split by target means we're building those common files
more often than we need to.  But I don't think "make check" has a way
to say "limit by target".

Note: to get all the tests to pass you'll need a few patches that are
on list but still awaiting review/commit (one sparc patch, three mips
patches, Marc-André's fix for tpm), plus a patch to
lsan_suppressions.txt that silences warnings about target/riscv
leaking of hashtables.  You can find those (plus this patch) in
 https://gitlab.com/pm215/qemu/-/commits/asan-fails
(the branch as of commit a987eab2ed is what I tested with).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 4b1949a3a5..9c73b1a646 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -434,6 +434,32 @@ clang-system:
     TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu s390x-softmmu
     MAKE_CHECK_ARGS: check-qtest check-tcg
 
+# We split "build" and "check" here to keep the job times down
+# below the timeout
+build-clang-sanitizer:
+  extends:
+    - .native_build_job_template
+    - .native_build_artifact_template
+  needs:
+    - job: amd64-fedora-container
+  variables:
+    IMAGE: fedora
+    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-ubsan --enable-asan
+      --extra-cflags=-fno-sanitize-recover=undefined
+    MAKE_CHECK_ARGS: check-build
+
+check-clang-sanitizer:
+  extends: .native_test_job_template
+  needs:
+    - job: build-clang-sanitizer
+      artifacts: true
+  variables:
+    IMAGE: fedora
+    MAKE_CHECK_ARGS: check-qtest check-tcg
+    LSAN_OPTIONS: suppressions=../scripts/lsan_suppressions.txt
+    ASAN_OPTIONS: fast_unwind_on_malloc=0
+    TIMEOUT_MULTIPLIER: 3
+
 clang-user:
   extends: .native_build_job_template
   needs:
-- 
2.43.0


