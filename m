Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AD2109879F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3c8C-0007aY-PM; Fri, 20 Mar 2026 11:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c83-0007XO-Mm
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:15 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c80-0005Vw-Oo
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:15 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b97ed4ad579so133170166b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774021871; x=1774626671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Re1Z7KTF6pGt06r2qKUhhUG6rRUM2+jHUzT54RyU8Vo=;
 b=ONLR23h2OB3+66OF7Xx3ksY71yKh1fkffBSlRn0WYzlcGGVv6S301KIgJa3TZ/AnEB
 WdQyMjPNP+QVbbQfhnVVdKVBEcA4IN7+sH3BKVhtks/F2ymr/iihnhdO5+ZR8dY26H0+
 ZtdMvmnWmVe6bYwP0z2N+OeagcGNTkLu1XZL2k77lqOFgPAJir0piEwMfZCdETBchXaP
 bGFgv6TVWIcjqOytNvTYFizRJ4VGOAiE2BW7y0j4qlpfIcHkKUDtNW8YDPi3OaTYrljh
 CMt33nYSsePhh1zTdvbYZzUJ93yZG1RMYS3W4WI3/J9kn6MA+dSgozzmvvUbgWgfMxOO
 V/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021871; x=1774626671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Re1Z7KTF6pGt06r2qKUhhUG6rRUM2+jHUzT54RyU8Vo=;
 b=fiydjGRN1xV42ozbTN5jL+asVxtN9TxYhiJDEvNoLLzRpewZNK4QXhomt2veFK/FuU
 0wrW7afzea6xrpOOHfSVl5HfHMddAP7icOHRC1j7ofH0WpMcYWI3GgEOfvu90uahKM5d
 rvqhIsQaweb/T9jAn4YvVxqOw+uKqZylKaOkhYCEOZCwLOXiWINjZ8NorxOrnObBfTWH
 O0/dhyfQbwp+x3I9yG7PJrNw3hA+pFcvLj/tys8pjcPz7IGvyG6AcB4NMpLFMoR/ImsN
 4dblcZIMz4plazzX24BnQzRUJdWpyROzu7H/GZmtGL8t54iYPAM+jZjJnRebI7Q+IMgu
 nCww==
X-Gm-Message-State: AOJu0Yx1eBZKWMslgwBQqsG8nI6AJIQRQG2KYIaRal9yYt1Paa09ZZto
 Pv76nMaaeS5C33AJ0StjrHr7vC/PZJbyUNWROPqnerxgd9FcL949c06ZN5CypLTuJ8w=
X-Gm-Gg: ATEYQzyN36WIBPrDAKoHGmzN5bhbdITA7FUp+v9DU4g+TYl10r5+AUSrHX/zVcGbgh9
 rUahMs8n7sueMFJShjeHxj88fs722A9a0FnJ4qCE0WE0clwo44NTgByqX4QVohq9cs0KhMA+gXM
 Z5jJfIy6DxE4RpvXcaljhmQjBl3xRJOwKZNY1ddkG2vRWcW7u3xVrifEYOMQlSpxxtIINRzQ6Y2
 4C7RvsqCwu1sjHI/liTmIoIc8bbnNuLiFpqISxgWtQrGOvJEPhzWak8OMWscgrXiPqu7HEv8PTD
 I9/nMoIn8me1vK29izYlxuxRo5/Ly8xgPjdTieyHSbypwe2mf6R6QDNETL1EUiIe4ZhjW1xqbWo
 j7ehXE9KKb2m/vcu9eiv+e9K0fM5VwzUXHFdOzBcKmc2XomSMEGS2SwqK9LdBrbBH112iT0YRil
 FUQqFS/JSP9xR9xvPJJ4gIBPI=
X-Received: by 2002:a17:907:1604:b0:b97:edc1:f9c4 with SMTP id
 a640c23a62f3a-b982f1ed7b2mr288505466b.1.1774021871186; 
 Fri, 20 Mar 2026 08:51:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f8dc51sm169939766b.22.2026.03.20.08.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 08:51:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C8535F911;
 Fri, 20 Mar 2026 15:51:08 +0000 (GMT)
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
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 3/8] tests/functional: allow tests to define decompression
 target
Date: Fri, 20 Mar 2026 15:51:02 +0000
Message-ID: <20260320155107.2143191-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320155107.2143191-1-alex.bennee@linaro.org>
References: <20260320155107.2143191-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

When dealing with multi-stage decompression we want to specify the
target file name lest we just overload the cache name. It also allows
for something is little more friendly than the cache hash.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


