Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B43EC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 17:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiyqP-0004c7-J2; Mon, 04 Aug 2025 13:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uiwum-0000fm-Gh
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 11:15:55 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uiwuj-0000Xo-Jf
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 11:15:51 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b79bd3b1f7so2447037f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754320548; x=1754925348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5I0P9zrEGMWC2opqsSuDg7PldX8TWbC7NgkKHaAdNlE=;
 b=rDwruqS5sQjngdFaB62Sceq/O1ANDq+fE2gbsgKSRMqbXT50gPIdri/b1PJKUmVZj/
 LD8a5R8Gkb8EsyY41OFLhbl1m73nCMhBciNZLGRcCKMCkYVrnO2laJPzUMDffq+aFy0h
 poln4jhkmM1NRke5l1ygA7E/20rIKso0aNTPmeMss1lsrymrsLBh8JsXHvBz1TFxe5Mt
 uKFqC31FI2dQAYq4txXtOGvdZr9ho6xsPM2lM00sN31PudZsga2Ud7O+tgJjSgsFWd12
 48Rxlk07rhKtT79f36L7nYy+VLS3WomsGV70GC6N4ypeG3cNF+DGdqV/V8IVvqbFFfvj
 u1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754320548; x=1754925348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5I0P9zrEGMWC2opqsSuDg7PldX8TWbC7NgkKHaAdNlE=;
 b=sg8RF8/JglOLxsqnM5F8msz32s8b/sXUHrvnspI50lhSxyG/tJQHzZA3oJLxV5tbyi
 yywXf32l9PthKoV/jpTPEdTPBJvhzUSzrk2mv7/TeUkaf6B8gOtRInXhgHN0Gpy1lbKp
 e/eEjxqIaCHAreKzXcmR/k/fmNPJmbqyXlslt3vH89RqZfQpEAfnfJz3oodNG+ZHK2lf
 67JvYsWlKXJK2Ho40Mz0+364e4PKqNBg+BfkjBffMuRIhqdNHnzG4S8eX6gJz23h17ro
 ajv3UIMWKLMy3HZ1+LmWsSE06nRmNWWigkWD+iodnfeHLZ/mqfK4tHUVpBluAMqkM4S2
 HZiw==
X-Gm-Message-State: AOJu0Yz9w41epcJ/s0fYDVnxsalEbCuRq24cyuHf8FbkpXEcd5qgj0Ix
 vXLL7ouTZMKeuUSHm+kXhcdcvHi+HZ5aJVcAAB2lmKgP/X1b4kEpSiWjNiDX205Am8zC9kkwm6O
 bZ7ND
X-Gm-Gg: ASbGncsTxPANM/+tW2StKoU6J3Z5Jjr+lUbzh3zL5JCteMfybqTCqxU5lpXNKmGxpUZ
 hTrQMM9j008z/bVkD4+cnqLnJ4bp70Be9bBVcZwxXkD3l1MJ/tNQ0rV/+gbaFls1pdNQ4fccR3o
 baoJetYL6Md+4IhLK9K6Li471vroZpN+pEMGK9cJ/NGILsHRXNGMqvq0zPC8/iGdRuqMJkyvYxD
 oo3AANBBHo4G+y+Hpl4Sg2U5GwERE6PnR8vCFZsx9gcL98qp0h7bKDwPAE1Xi7ldNGZOKHMFIY2
 B16YrTdjbVcWAvjsrzF0epPrEwhI5F2DU51EfehMI7wnW/OWXr7jCw4hvMOCmLPyjChd+sPzKtb
 ctn+OJOa8jhYCHbgzub5WXJE=
X-Google-Smtp-Source: AGHT+IHCXhQoCfQ3l5aqmuaZZiAY+csWNpKBrRrCAlzwD0yPhjxrj1x/bwmITBJKAVWRwW117NR8cA==
X-Received: by 2002:a05:6000:2408:b0:3a4:f663:acb9 with SMTP id
 ffacd0b85a97d-3b8d9468531mr7126767f8f.9.1754320547800; 
 Mon, 04 Aug 2025 08:15:47 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c46ee84sm15563644f8f.57.2025.08.04.08.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 08:15:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3C3BF5F88E;
 Mon, 04 Aug 2025 16:15:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 2/3] scripts/make-release: Go back to cloning all the EDK2
 submodules
Date: Mon,  4 Aug 2025 16:15:44 +0100
Message-ID: <20250804151545.311042-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804151545.311042-1-alex.bennee@linaro.org>
References: <20250804151545.311042-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In commit bd0da3a3d4f we changed make-release so that instead of
cloning every git submodule of EDK2 we only cloned a fixed list.
The original motivation for this was that one of the submodules:
 * was from a non-github repo
 * that repo had a "SSL certificate expired" failure
 * wasn't actually needed for the set of EDK2 binaries we build
and at the time we were trying to build the EDK2 binaries in one of
our CI jobs.

Unfortunately this change meant that we were exposed to bugs where
EDK2 adds a new submodule and the sources we ship in the release
tarball won't build any more.  In particular, in EDK2 commit
c6bb7d54beb05 the MipiSysTLib submodule was added, causing failure of
the ROM build in our tarball starting from QEMU release 8.2.0:

/tmp/qemu-10.0.0/roms/edk2/MdePkg/MdePkg.dec(32): error 000E: File/directory not found in workspace
        Library/MipiSysTLib/mipisyst/library/include is not found in packages path:
        /tmp/qemu-10.0.0/roms/.
        /tmp/qemu-10.0.0/roms/edk2

(Building from a QEMU git checkout works fine.)

In the intervening time EDK2 moved the submodule that had a problem
to be one they mirrored themselves (and at time of writing all their
submodules are hosted on github), and we stopped trying to build
EDK2 binaries in our own CI jobs with commit 690ceb71936f9037f6.

Go back to cloning every EDK2 submodule, so we don't have an
untested explicit list of submodules which will break without
our noticing it.

This increases the size of the QEMU tarball .tar.xz file from
133M to 139M in my testing.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3041
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20250721153341.2910800-1-peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/scripts/make-release b/scripts/make-release
index 4509a9fabf5..87f563ef5f7 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -62,17 +62,15 @@ meson subprojects download $SUBPROJECTS
 (cd roms/skiboot && ./make_version.sh > .version)
 # Fetch edk2 submodule's submodules, since it won't have access to them via
 # the tarball later.
-#
-# A more uniform way to handle this sort of situation would be nice, but we
-# don't necessarily have much control over how a submodule handles its
-# submodule dependencies, so we continue to handle these on a case-by-case
-# basis for now.
-(cd roms/edk2 && \
-    git submodule update --init --depth 1 -- \
-        ArmPkg/Library/ArmSoftFloatLib/berkeley-softfloat-3 \
-        BaseTools/Source/C/BrotliCompress/brotli \
-        CryptoPkg/Library/OpensslLib/openssl \
-        MdeModulePkg/Library/BrotliCustomDecompressLib/brotli)
+
+# As recommended by the EDK2 readme, we don't use --recursive here.
+# EDK2 won't use any code or feature from a submodule of a submodule,
+# so we don't need to add them to the tarball.
+# Although we don't necessarily need all of the submodules that EDK2
+# has, we clone them all, to avoid running into problems where EDK2
+# adds a new submodule or changes its use of an existing one and
+# the sources we ship in the tarball then fail to build.
+(cd roms/edk2 && git submodule update --init --depth 1)
 popd
 
 exclude=(--exclude=.git)
-- 
2.47.2


