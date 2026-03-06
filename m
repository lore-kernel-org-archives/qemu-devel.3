Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1D7FCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXs4-00087v-G4; Fri, 06 Mar 2026 11:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyXru-0007Ln-Se
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:17:42 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyXrr-0007js-55
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:17:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-483487335c2so79620385e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 08:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772813854; x=1773418654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8UxgbQsvSQBKFdx+AfZhaXSCPSowJMiI/wfdv1r8smw=;
 b=YILes6DTX/iXGbph0hDaeI9FdWc14OAVN2GZzZx2lmX9hStUV4AmoaWacXAqbTpF92
 wq0SA4mWoDGhf31p2mzDGmBAaJFT/FYic4InAcbFk8sLVJIvxhzwZVqOC1uavxNapWqd
 H/ZzModWehgDxAWW1sRWV4A5xm13hhMfES2UuU/cV9hnmeqqL/ehzQ++yDvoS3Xp3+NB
 9ttYJdQrLyClGknAQXELM6AFCoB/apOQGFj53jSLL/QTEQVdRwc+zBPDG3aYGF0Hb9Q/
 luULm+L0VCWDiisj6ysG+bpjmAdOiOldsNjjj76QY7dPOf1eUQtsAgz27wPqu7X3wBNJ
 KSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772813854; x=1773418654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8UxgbQsvSQBKFdx+AfZhaXSCPSowJMiI/wfdv1r8smw=;
 b=T3l/ZvRxsCedz9x2GH8Fez/K/Pc0p7wYBQvlQ5VrXC+aCZBDtT+9LtT5E/rKARlzTO
 zQNMm04oPEiIxpKtWlo9jl73vesZMksx4+/Ljc6azVUje79/wnWwnSwFSxZY8S0g0Qw7
 5V0jDn+naGSQ5dUUncEgYYOg5NhDg+n28fa6YRYp3xWy3htELL8f73ROdf2Id7ecDcA8
 ds6xiPI6BrIeENZoCPCfBde8lw5cDaC1vzTrJrvCHbI04Z5eCLr9yhjSQd/oUVi/Kta1
 PQxAtgDf3PYPpGCztYXIkBKPsm/xQ5VLviQSO1fBzEfdUYKkAaXmc7IJAzmyC/zBPSQJ
 U0GQ==
X-Gm-Message-State: AOJu0Yz4fHb8MD20+BWVz0/OB/bvpiHS/fPPPtNqwkV7PULpS7e0Q1p6
 JZ+1nUeo1l0c99zorqdy/aeFlRH94SuD+m6C8d9U8QXh2PWZ2IjxolxR7hvRNClaxVQ=
X-Gm-Gg: ATEYQzzbTy9PuOWipW+MutzwpymCzeQKlQS0IsYgQeExkh9cwknz9LnW3LbYhRuCu41
 Loaiil+WsMdCdl2lgba+pd0KOKl6G+WN+7L+qbHM3jJgWJzGlPDsaF4r9m6+m/XzWS3I4IV9cq3
 Fm4eLk1JxIwddKsUO510UMNYFaWDzplAimhx7JvdHYxB9Cr9m1hgf1hoK9JZ7Xrbu2vg2kp73Mq
 /zfvx/AZt+V0yzj0F108yCF4NScDfA0Lwrd6yuDBgvRilgHqFnwP6529GQqGklDTMFty3V8Eh8X
 peD4FfpufwBbPr9w3WD+txA2tdeM0dkkVLAODIQQObyZTbii4wNnUaUwsWTEP5tA43fbbkcEWwN
 qfpufJVs8ynYo2TfGdYwa4qBnXiDrHWptwCjuOGjrIQY2Y8HH9lRZ7fo4V7+A4j07vMTSSD2SxX
 a8vDhseJlB5b4Pq7rdqAq4lBI=
X-Received: by 2002:a05:600c:6085:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-4852692fec0mr46154375e9.15.1772813853662; 
 Fri, 06 Mar 2026 08:17:33 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fad2812sm207962835e9.1.2026.03.06.08.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:17:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 26982689D2;
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 3/7] tests/tcg/multiarch/linux-test: use portable alternative
 for dirent64
Date: Fri,  6 Mar 2026 16:17:24 +0000
Message-ID: <20260306161728.2657486-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306161728.2657486-1-alex.bennee@linaro.org>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>

dirent64 and readdir64 are glibc-specific and not portable to other
C libraries such as musl. Define _FILE_OFFSET_BITS=64 instead, which
portably instructs all libc implementations to use 64-bit file offsets,
making readdir() and struct dirent equivalent to their 64-bit variants.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Message-ID: <af31d21c4d668cfb940ba4159f584fa6454c3d82.1772107448.git.matheus.bernardino@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/linux/linux-test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/multiarch/linux/linux-test.c b/tests/tcg/multiarch/linux/linux-test.c
index bf6e0fda262..0fa3165602f 100644
--- a/tests/tcg/multiarch/linux/linux-test.c
+++ b/tests/tcg/multiarch/linux/linux-test.c
@@ -16,6 +16,7 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+#define _FILE_OFFSET_BITS 64
 #define _GNU_SOURCE
 #include <stdarg.h>
 #include <stdlib.h>
@@ -83,7 +84,7 @@ static void test_file(void)
     struct utimbuf tbuf;
     struct iovec vecs[2];
     DIR *dir;
-    struct dirent64 *de;
+    struct dirent *de;
     /* TODO: make common tempdir creation for tcg tests */
     char template[] = "/tmp/linux-test-XXXXXX";
     char *tmpdir = mkdtemp(template);
@@ -191,7 +192,7 @@ static void test_file(void)
         error("opendir");
     len = 0;
     for(;;) {
-        de = readdir64(dir);
+        de = readdir(dir);
         if (!de)
             break;
         if (strcmp(de->d_name, ".") != 0 &&
-- 
2.47.3


