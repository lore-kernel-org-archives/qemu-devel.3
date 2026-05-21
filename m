Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F6FCD5BB3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3Hm-00045m-Ng; Thu, 21 May 2026 09:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3Hf-00041p-4h
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:17:56 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3HV-0008QA-Ox
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:17:50 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so4894995f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779369462; x=1779974262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Nc2l0giGtf+QZho3vf9MYXoNK00y4me0CSnyD/ZW0g=;
 b=x7/PXaYgfZxOCVQ44BhDT9jG1eVepm68xqVdGaIHhwU4rm+XRMLsSgzwqLPE940cgI
 FqmNzPUqeuprDoB6UmkCdNugqbxtblaGYkdweSZ8LkrxIeGPbR0cPBHC7BvB5oyOBbUa
 wcauAZTBSaL0vWTrG6Yw+7+bPMIkgDVUpv1Zc4DlCtKEmvRbrUGybbd3mJOhgpNiq8Im
 S8NhqmbjEoWbYslO4uOIEKjC/rlrJmWaW9/6FxB2ki01ZfxJpOerNw4+L6IlOJH9kVRk
 v+QIuxjGg9INcRj3g12tWPOwy9B9KQhBneIWMwioGLdWy4rej9EPgavmb5PyBjx6pAwA
 fZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779369462; x=1779974262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0Nc2l0giGtf+QZho3vf9MYXoNK00y4me0CSnyD/ZW0g=;
 b=GKchZ8LDXUf+3MBak5FfThATHfUbBVyJzoRiJ77+W039WpCkziSKbMpGfIN4gCoO7o
 UI2dujvJlghtQXbbadw9QbJxYVDQDr+fkHLtVjgfuEw4dMBTZFgkNDL0ilinckAxEVMg
 DII2diIcce92jT9o0qTpGY/TRBQvfDbD1LdFKAKejYBZ0kVGOvoK1sAd4wtjh2BQ1D9r
 pbbriwGv8g616JfakF2K+8g33o1DBllXuYNz0hhKQHawn1sdJoq+jPUrRg/Q/auQ7tWW
 1HPy0mQyntGhB5Ps5H7D3QMDijqi1/kELn1wno67PfUNjBZSS1asPmDV0KMKI6wRW5Hi
 gDMA==
X-Gm-Message-State: AOJu0Yya3Mi8noHt4jcMx6SNts/Gm3qXbRYmU2Ck/8kKZ3t6w98IN9yE
 z0PjZZXq1fQorsaVEN8OkfC77/r5YJePGWZluHItQYY0cJDK9GYvamy5lopwCsHyHHs=
X-Gm-Gg: Acq92OGgH2SgfM2wsT9CRkPCOB402GKDmLKdaqG+idT8ya+FiiX5ejk4vuhK8H3VwmX
 B2GOo2STG08v3CUTQNYIiaS9Apk4p8oNNTK/x7d2+fDGyRJTstlIykT0Y3S6JKIEIQRkg0g/Yj/
 I+j2EhTYhjE5sUfdl/aPHPfjZGsQ/terRRNJw//zFC/zIDF7QWZYgLXEfxDzFXGN1el6t24WUm9
 69COHDNafk1hn66sSE7V6QzoaI30tFYtXgY1LE/5cu4KjRKC0tkXwxb0SzcyRUF2S8ZNu2ljN+V
 Kfnlc3k9UqAqmHychPYZL7TzBrX/4xFIjz1dprsy1VqA9Ljo5khUziADSPkgUtgyoJHz2oDIabM
 NhYA/xIUyrGlIC2wcUkWK2HvK1ZVTybFQXcOyCnVmt9tsJunaX/B/g1dgQZgi4i8oFSDWnqfbWu
 EsjCq6Key2/tfeSXHkNE8aDDg=
X-Received: by 2002:a05:6000:430b:b0:448:908a:398b with SMTP id
 ffacd0b85a97d-45ea319686amr4306945f8f.14.1779369461553; 
 Thu, 21 May 2026 06:17:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa92f622sm3155839f8f.24.2026.05.21.06.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:17:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 55CEB5FA07;
 Thu, 21 May 2026 14:17:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 01/16] Makefile: include tests/Makefile.include before
 ninja calculation
Date: Thu, 21 May 2026 14:17:23 +0100
Message-ID: <20260521131739.540157-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521131739.540157-1-alex.bennee@linaro.org>
References: <20260521131739.540157-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

As the tests Makefile sets .ninja-goals we need it to be included
before we do the calculations in the main Makefile.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 54547a37b1a..829c51e364c 100644
--- a/Makefile
+++ b/Makefile
@@ -45,6 +45,8 @@ include config-host.mak
 include Makefile.prereqs
 Makefile.prereqs: config-host.mak
 
+include $(SRC_PATH)/tests/Makefile.include
+
 # 0. ensure the build tree is okay
 
 # Check that we're not trying to do an out-of-tree build from
@@ -180,8 +182,6 @@ endif # config-host.mak does not exist
 
 SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet)
 
-include $(SRC_PATH)/tests/Makefile.include
-
 all: recurse-all
 
 SUBDIR_RULES=$(foreach t, all clean distclean, $(addsuffix /$(t), $(SUBDIRS)))
-- 
2.47.3


