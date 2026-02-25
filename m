Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60C1FD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOD0-0000Py-UM; Wed, 25 Feb 2026 18:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOCp-0008SE-FD
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:22:12 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOCn-0004QN-DJ
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:22:11 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-483bd7354efso3566795e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061727; x=1772666527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rJR3a7jse2k+zOTTCK+12aHFKULfyak6qBcfUAT3KG4=;
 b=Xj6mMcusY/4GPqWxQYMWru2oUso2pLc9ysbPZNUZG4AuJ5I3JM6kF39z7udgpztZEf
 MJrGhJaIIm/YiEe9monfwHajo2ljdRpZwZbbmbBvGAnBO3I28Tn4d9qmtjepbGXtBlz6
 sVGHCboF30CEKdCjFTUHd53IGv+7MM9ljU+stlRXEQSVkq7z7IUBWhSP5y/eWRz7neWE
 prC784rkqIwsjc8bzZjS6VmmSe2N3jFviZP7HYyAXxCii+f2N768IKdQw0b+TrDOFBwU
 6o5l3d2jD8Qs5DkxExz2oQrTAijakqO2ZqYIPKbp2h+HnpJ2rLTcj3o4fGFlvISEalKF
 kMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061727; x=1772666527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rJR3a7jse2k+zOTTCK+12aHFKULfyak6qBcfUAT3KG4=;
 b=fOCQglL8dmbm4V2DGldWDQJwZfszMw8gxin1EzSMbGN6w0JPwnYAdMwv4O/eIxRcLv
 XMkTP7/zd9lvE9FE0DTyGu07QV5nVcSDFnJPaKuOBA9qGFCRTNy6eF8WQR3eyfWzU7dE
 r+gPQCEC4RA3pcH1MEMi0ZA//e1XdoZ/jlU+KRGP4pb+lFaTG2u3t/+VUR4qTeyTKqi0
 UQnsyYp7b65kGKGDR3CAWFpPMJVJ/mgC8AuZieX0vsORCEDfS6M5UEyXNMD/A5E0C7Hw
 G/5M3J9vqzbZuGyy2drdk/gDkwWI7755XoLIC8JVtzJm0zNr7yOmfmhlMOotm+tZAqgH
 x6MA==
X-Gm-Message-State: AOJu0YyWUlRjUNC5gGQZO25vIEPA4INeGimuL/W7F0FM55DnNKa8NOVV
 QdyNvPfwY6zYcMm9GWj5nF0oqI/8si6v+pbzmsFd2iwg7/pkAbmUGA/FdrVBt5qcjTBdDqHOswp
 ltCoD4ks=
X-Gm-Gg: ATEYQzz3Iom7chh/aT9Cmcd4V5BeeApm0dMuFkBtjRNdJJj+B6Ln3AbSdcxDgkynNgq
 Q7Sjz7bDiksWlrADUiyipqpyFrhs0tQJ3c643FK0zQWVwX3Qw25k3wPTkxkv4QlBlA2QQdZjMzl
 mQq9u2TcCCOYwLkcxWWD+H6wxF/pCT8zq0wnnSxz3EU/aWWVCo5vlsfphn+XFi29MAC8Dg3J99y
 HVTpy1UQk+/vkmBI3U3yw55sSw2iD3aaYBIkip0aqi7jmEnIjh3glaMp1mC9AMBLyjBq5RvpqEB
 firGTdUmcoNdXJoWO7vnuq7s42X0/Rpky0G2tj/8M4JxEFX8vAG3344K1HBCBgEWpqr5fLOOwdE
 ve1TLpMa9g48kiobz7BZhKrm4js8ajuq3Ni/VyMvc44/PzGibSV88yLeayvlmOanH1HLKkXQYNi
 BCwWjuMFc7BZSnf+kyb5APTRCLaHUoYBYrh4+5gUH9NqVOuubObUEJzwaXWHk7RyZh2giTewkp
X-Received: by 2002:a05:600c:3b8c:b0:483:43da:6c87 with SMTP id
 5b1f17b1804b1-483c21aa451mr36064515e9.33.1772061726799; 
 Wed, 25 Feb 2026 15:22:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f26d7sm111074775e9.3.2026.02.25.15.22.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:22:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 70/70] page-vary: Build migration_legacy_page_bits as common
 code
Date: Thu, 26 Feb 2026 00:14:10 +0100
Message-ID: <20260225231411.96482-71-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Use target_info->page_bits_init to implement
migration_legacy_page_bits.  Because this is the last
function within the file, rename page-vary-target.c
to page-vary-system.c and build once for system mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260217095106.598486-7-richard.henderson@linaro.org>
[PMD: Update MAINTAINERS]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                              |  2 +-
 meson.build                              |  2 +-
 page-vary-target.c => page-vary-system.c | 19 ++++++-------------
 3 files changed, 8 insertions(+), 15 deletions(-)
 rename page-vary-target.c => page-vary-system.c (74%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8da0b357fbb..606b16762cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -159,7 +159,7 @@ M: Richard Henderson <richard.henderson@linaro.org>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: system/watchpoint.c
-F: page-vary-target.c
+F: page-vary-system.c
 F: page-vary-common.c
 F: accel/tcg/
 F: accel/stubs/tcg-stub.c
diff --git a/meson.build b/meson.build
index d9a17eeefd3..3cd1d8dbc66 100644
--- a/meson.build
+++ b/meson.build
@@ -3833,7 +3833,7 @@ if get_option('b_lto')
   pagevary = declare_dependency(link_with: pagevary)
 endif
 common_ss.add(pagevary)
-specific_ss.add(files('page-vary-target.c'))
+system_ss.add(files('page-vary-system.c'))
 
 common_ss.add(files('target-info.c'))
 system_ss.add(files('target-info-qom.c'))
diff --git a/page-vary-target.c b/page-vary-system.c
similarity index 74%
rename from page-vary-target.c
rename to page-vary-system.c
index bc4d8931b68..6c49c10e23b 100644
--- a/page-vary-target.c
+++ b/page-vary-system.c
@@ -1,5 +1,5 @@
 /*
- * Variable page size handling -- target specific part.
+ * Variable page size handling -- system specific part.
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
@@ -17,24 +17,17 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#define IN_PAGE_VARY 1
-
 #include "qemu/osdep.h"
 #include "exec/page-vary.h"
-#include "exec/target_page.h"
-
-#ifndef CONFIG_USER_ONLY
 #include "exec/tlb-flags.h"
+#include "qemu/target-info-impl.h"
 
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & ((1u < TARGET_PAGE_BITS_MIN) - 1));
 
 int migration_legacy_page_bits(void)
 {
-#ifdef TARGET_PAGE_BITS_VARY
-    QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS_LEGACY < TARGET_PAGE_BITS_MIN);
-    return TARGET_PAGE_BITS_LEGACY;
-#else
-    return TARGET_PAGE_BITS;
-#endif
+    const TargetInfo *ti = target_info();
+
+    assert(ti->page_bits_init >= TARGET_PAGE_BITS_MIN);
+    return ti->page_bits_init;
 }
-#endif
-- 
2.52.0


