Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A99CCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpZ6-0002i0-HK; Tue, 26 May 2026 07:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYm-0002ZY-9j
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:02:57 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYj-00067T-5N
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:02:55 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so10182403f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779793371; x=1780398171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpNFrHwCTegluEwEkg7Y+CXfscfOfe38FMBiShMQhEM=;
 b=I22g7ic+dKyJE6x9j5ggXN4LZOOpY03bIRiPQtzd2Cv5Hj7opQ0C/i85R+5AF7C370
 QrL/pbHHD/ZygVT/PZ19LnwNbSOucYLE+VzhIy6MLNNJq4tN4JmwCaTErp+hWk9uX7BF
 xH95hAA3tKVOIRKhX460z/s+JHA25i7+TSsrbrm7XaOCZ57bop5U0THWR59k0M6TbYrY
 ZSyjADcB19WmX7IevOol+uaiU2ziVLd5dffH9YZOgAQvas8OA+2Fzj+KJFYZKfdNtXZG
 e+dRSkKGEJ4nzYCSOMaLPW8BpXzJKRRAYSkiTknmP+buoxcZouLlgE7DUX7/UjQIudZ/
 k3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793371; x=1780398171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GpNFrHwCTegluEwEkg7Y+CXfscfOfe38FMBiShMQhEM=;
 b=cnYPPasuNS3HmxT6zcNLHMu5sCLu1vxmo5zBgVzJS2JwJzzgYNKof6tUkCe3fpaa1c
 Zx8kMVGhO0WuiCJsH1Km71AfOWdlp26yz297OGBrE6bdkaCPGhOGA85GFi6CcqJ5Q6Tx
 8y1pSmQvTdlhlJBDXYYJ5KFIPRIHIuqk0ZlLueN652U4Lzm0xR2EbfC9BIaJGSQ9xd+x
 tRhRJKBhra9fFALC9f5O0FlwF2zz9xfzHgRXS46YM2mFN5bguOeZUjEmwU3Fk8pIWr1V
 3m2VqzMlFVZhQlbqzKQ/iTIIfcIiu/zW7rroRcYxm2Jhj1UZ9Xo4wjV24FcR+3Hcs4m/
 sV8g==
X-Gm-Message-State: AOJu0Yzhc0iUYY2akGQapwhgmgTEY/jy2vnrHPAq7AVxXpiFkRCj7UiO
 VxwcV5eUch6ApB/D9pwTxx1vCTJaM2jatgaOwpic4Y3Y2BehqBGZ+WkuJvWyqLDnON8=
X-Gm-Gg: Acq92OGQHS/1c5ow1GFZnnh9YBq1KYVkIsGEPu6+NzNsd8OMIeBWxHDxMSwz2w36kzD
 HV0Z7GHkK4NIvW856NJEv0Cbqveqtepf9FPh72wGiP6c6psgzVymgCqsTwf0KJEGnRrFNO0rRfh
 AHXj2IoSsqiRGKo7m9dK10KaqcO5J3ic3FFpq/jTs674h8gb6/xjKexf4jHb6vzFrugsALg4YkB
 iSgyi4F+MW07UI6W12Q0o5ccY9pxIwhD1NzfIznSjkoH5a/b3XLotm2p++Nt9zYrnyeqJfigbb3
 D+w33eZjc41M93u1zH+oRrhNGBtrrawfYEu375r9b5W9NYOwE6tnlZTXyl8kn65gPgd+kjN8xrr
 TMT8hOxnwKUOMeARtWSJbmHdjJYWfbozsgjb2gzKBQJdkpC+PvOwd36WJQvVZ+/JWf2gCWZ8hCq
 xVIVdm+gZ5VyfVmhYScVjZYVs=
X-Received: by 2002:a05:600c:1c0b:b0:488:b187:3c with SMTP id
 5b1f17b1804b1-490426aa7acmr338149405e9.14.1779793371347; 
 Tue, 26 May 2026 04:02:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454ac6a6sm326948035e9.12.2026.05.26.04.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:02:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2FE8360434;
 Tue, 26 May 2026 12:02:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Kyle Evans <kevans@freebsd.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 07/14] gitlab: add MacOS 26 job on gitlab runner
Date: Tue, 26 May 2026 12:02:35 +0100
Message-ID: <20260526110243.470002-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526110243.470002-1-alex.bennee@linaro.org>
References: <20260526110243.470002-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

gitlab supports 3 MacOS images with 15 and 26 being the current
supported ones. To get ahead of the curve lets enable 26 as well.

It re-uses the same brew list but also attempts to work around python
configure failure by setting DYLD_LIBRARY_PATH:
/opt/homebrew/opt/expat/lib/

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---

v2
  - call runners directly, seems to be working now
  - drop debug lines
---
 .gitlab-ci.d/macos.yml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index c93bf12a294..f61750a3f4a 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -45,3 +45,19 @@ aarch64-macos-15-build:
         --cross-prefix-x86_64=x86_64-elf-
         --disable-plugins
     TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-tests-i386-softmmu run-tcg-tests-x86_64-softmmu
+
+aarch64-macos-26-build:
+  extends: .macos_job_template
+  image: macos-26-xcode-26
+  variables:
+    NAME: macos-26
+    DYLD_LIBRARY_PATH: /opt/homebrew/opt/expat/lib/
+    PATH_EXTRA: /opt/homebrew/gettext/bin
+    PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
+    CONFIGURE_ARGS:
+        --target-list=aarch64-softmmu,i386-softmmu,x86_64-softmmu
+        --cross-prefix-aarch64=aarch64-elf-
+        --cross-prefix-i386=i686-elf-
+        --cross-prefix-x86_64=x86_64-elf-
+        --disable-plugins
+    TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-tests-i386-softmmu run-tcg-tests-x86_64-softmmu
-- 
2.47.3


