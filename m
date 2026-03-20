Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94431098797
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3c83-0007Wx-5S; Fri, 20 Mar 2026 11:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c81-0007Vz-3S
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:13 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c7z-0005VB-5M
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:12 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b97f9587e6eso260075266b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774021870; x=1774626670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YhvJ30u4SjKjKGIAS0IRtyTM16wsKwTzLGcYfkxCVc0=;
 b=tjJRdRWMsDXLUItS0XY4kFlktsP+z85kwp8DDbXpdk3J1qXXHvIaCy9PtYu4pz0fZM
 3PmDm1DCPQhNUnNEoPlMlDRDxCN4zOmPt9hMkz+MPdnZFsfSFGhHTI4wOQ74FKgmfWVX
 FeoCxshp7zMU4yY/O2l6AOTyTAYmX56kLAkbt7psChu+A3VxpMk4JBZr0MYENghAtHEC
 TZmtmPX0BHSRDxQsH0jiKO+/vJR3ARZHNrpDB/go1/QxpXgRS6eWiMInA3NMup95qzSC
 4BENJ4NF02+CODexkfzYX8M4r9TSAs4Nrk6XtAVH/FDUzfB7YcMd6pI4xmukU08T/xz6
 l0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021870; x=1774626670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YhvJ30u4SjKjKGIAS0IRtyTM16wsKwTzLGcYfkxCVc0=;
 b=JJl3lN5m+4+nLHZfnlMSACudN+lgaYbiWY/jvp1MxWWsyDyWnnoK/vA2Wt7UTwxV1A
 Stywn5llRBG5570rpaOJkFJzjksubpcE8YOjOMAh5HwmStnp9BsZ9T+0XGqsYS5pzPoU
 iIafJjBE9uQuXybNGBqc7XcJ8X53fAS/Hv3T1j78hBmTd8HhLpNfaKPyuIaKWeA1Kp5q
 fZUsRtuWhxe3AaCWvlFd3U4HtGD/tiEFPwxFw2tchu2rOWOWKi32WOppDOfakCUoX+1q
 lfKwlfk7rJAQbJeV5/MPyyfC/cOrKHw2pnNNVqZoD6knAcTcRdP3Hj1XR/GgGCG7RyV8
 /ozg==
X-Gm-Message-State: AOJu0YxWD5oL8GGN/uJX2FYXluliZCjvaL+/zViHJ6O5d1D0I/pK9m4j
 j82op1xRNPsg96Z3Z89hoH3lgQTU1ZxkaVLtFz0ynH63Xes7uCbytRfjyhPJtB0MRKg=
X-Gm-Gg: ATEYQzyT0cu55w/1Je7kSDFgXyJzsQ1KyQwgsCRv6TaUoLmGgYrdrg+3BBGpktBf2bN
 3vD8kYVL/qD3c8gOJ2NaAW5HjPBCrueF6X9Pnqyhdtl7JYsJ3X3V4twXSGq36Mx6m+fBIdSrNXB
 Iz+uyzpZoWVb+ZWF+2XXdQFD74fcKs8M/mo+cq+Ppy2mrozewZiaLpSNB1AX5Ifi7VAx9QI83uP
 lD0NLW5rnLOGVvfmrVtKGK6DzATnwkYogrROY9b5gyK993wZHaS5/NxyKbrewiC31+KKvsQadGl
 bpxkKZDDZmGG1kUpPiy69eUnj/aVV0HEHIBh0VTj6PgOyHu928DzJs4+FZdtFvyoCZfW96ZtNje
 YbSpDrMU/X8sHab7ZwXG3jOIUJoneBxX4vij0ibc3jFXbj1gblHr9PgOszdY6PChpWG22KeikMr
 VdfI8W6oD/6sLYBL99eFI8M1I=
X-Received: by 2002:a17:907:c50a:b0:b94:858:5807 with SMTP id
 a640c23a62f3a-b982f235fabmr226643666b.25.1774021869554; 
 Fri, 20 Mar 2026 08:51:09 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832fd7147sm172006866b.27.2026.03.20.08.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 08:51:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E79F65F910;
 Fri, 20 Mar 2026 15:51:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, qemu-arm@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Brad Smith <brad@comstyle.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 2/8] tests/tcg/multiarch/linux-test: use portable
 alternative for dirent64
Date: Fri, 20 Mar 2026 15:51:01 +0000
Message-ID: <20260320155107.2143191-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320155107.2143191-1-alex.bennee@linaro.org>
References: <20260320155107.2143191-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


