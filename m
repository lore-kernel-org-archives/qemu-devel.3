Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D34EF99C6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 18:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqxtT-0007Ff-8R; Fri, 13 Feb 2026 13:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxtR-0007FW-AW
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:27:53 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqxtP-00064C-S0
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 13:27:53 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-436356740e6so1360269f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 10:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771007270; x=1771612070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsrTVhXyENyB3MoHInBSDRjS9vH5n3zQs9EUXUebqfk=;
 b=Su6PigSqiklNvdXEVIJNGJzbQfENSIfsoQeKi3RdqxklON0tvJwCnDf+RIWHCD/hbn
 XTz0VMiv8FKgVcVlJVPchd771am08D4Z8XRihOC3ZZP50VzGDYGKO63PuDqOko8acI6P
 qwTHcTvj6d7T/ZrBU9k+dYgB3rabdz8f6L1vgfC6HwJ2njuat8oD6D52h7BYxmSAI54l
 4iQWswQT7sMNV7Gd/g6Ue0l8RidUgyGW/SbPFpfoK0DOvOjokF8GOL1YTRxqrLPTAyTu
 czaPJYHc+vqqonlgFlrDAl9BQIsYIjOTz2Kzk21OBuKYKuRKRDVF6s0TwbHMbsPlmw9H
 d+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771007270; x=1771612070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tsrTVhXyENyB3MoHInBSDRjS9vH5n3zQs9EUXUebqfk=;
 b=NwhLX40US2kGzFiM2ZsdHUB4nABIICX2dOwsL+7UVduR5Wff1dtDHnRbbv1BI9bFmm
 VsI31ShHG92ZuQAp92zxyufgrySbomIxGhHA6GM+uAx3xdTcP2uVCk8hgTdZVJG7W+N/
 fp/Fb0kFJ40c3Lih3nYRNfpBCGa50TvYjqFZW+2DCXtKx5Lk8ZDsKOqa0wPbtQwS3o+Z
 jZCYesnPzUVQs/URfUc8CyKIu4QwLQtB6d/bjZh+2H6zvEdvQJBQvOtzadQbWCcu0iwk
 o2F9FfQDjjm3/kxkAUaJJmeZMnLyQ7l2gzDY07413q7x+kAbQ+UfbBKAlWvkNr9NqQ8T
 +dig==
X-Gm-Message-State: AOJu0YyqMFzJQYqhsWUw6t5DRAtABTBxtnZOMZMrpfKvMKV+W7YAbT9S
 Lld3yPMnbAYlGWn++PgrLMhhuHApHxrHjwNXCc8TpL1/0eLA34rrravVf4xS8/qd2KIBxFOb3Lf
 uJys0eok=
X-Gm-Gg: AZuq6aKb/v/VxdYr3Hip1shse1WIWbfv6tDfCkxRUpzqnp3/wotWTMfkyOKd151ZXME
 gtv778CmgYLhswaCQn8Axolcf5YCRURHLqLkMJaFHFIwPjxmsOJSqmS17NvVMITdIrv1e6tkEMs
 Dn2DD1GxYzvJkRB60L6a/DpSfgwg9clTpUtqZ0I/ldjFFhIpm7QCEk9Hzu5tHH+VhIykhCMVd7z
 c/abbAkybuYCumsNIIhgdvEAQvzB4/GmjIEGUmKB/ARqEt7rfbRoCI5fhjo+r1Dr0pSpUYhU9FF
 T7LJ0Q4vXGrXJh9h5mogvgqm0LHPmxRL+hSA4E5UsryT4az/TJMC8WqGO4mV6Hmlxv3x2w06CZ3
 w7BzJKCPWacXhpHLNWYYGLOQ4UY6WhJUx8ZzuN/fsiaIzyttzEqBYMEHbYMezzPIfgX7NjNetmr
 wmbMndtKkaMOFbOHkvU4tlkyHmknBDf6hvlKe/+LbOLJPOUNtZ3/YxoBeSaU0L7LsemlLmsFAu
X-Received: by 2002:a05:6000:2203:b0:436:173c:b8e3 with SMTP id
 ffacd0b85a97d-4379db93b3amr793442f8f.29.1771007270053; 
 Fri, 13 Feb 2026 10:27:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5acaasm7209327f8f.6.2026.02.13.10.27.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 10:27:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5/5] page-vary: Inline set_preferred_target_page_bits_common()
Date: Fri, 13 Feb 2026 19:27:13 +0100
Message-ID: <20260213182713.44924-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213182713.44924-1-philmd@linaro.org>
References: <20260213182713.44924-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

set_preferred_target_page_bits_common() is only used once
in set_preferred_target_page_bits(): inline it there and
remove its prototype.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/page-vary.h |  1 -
 page-vary-common.c       | 33 +++++++++++++++------------------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/include/exec/page-vary.h b/include/exec/page-vary.h
index 3c77689ca52..c4dc56634bc 100644
--- a/include/exec/page-vary.h
+++ b/include/exec/page-vary.h
@@ -41,7 +41,6 @@ typedef struct {
 } TargetPageBits;
 
 #ifdef IN_PAGE_VARY
-bool set_preferred_target_page_bits_common(int bits);
 void finalize_target_page_bits_common(int min);
 #endif
 
diff --git a/page-vary-common.c b/page-vary-common.c
index a2417354cc5..e2ccc7b0ead 100644
--- a/page-vary-common.c
+++ b/page-vary-common.c
@@ -27,29 +27,26 @@
 
 TargetPageBits target_page;
 
-bool set_preferred_target_page_bits_common(int bits)
-{
-    /*
-     * The target page size is the lowest common denominator for all
-     * the CPUs in the system, so we can only make it smaller, never
-     * larger. And we can't make it smaller once we've committed to
-     * a particular size.
-     */
-    if (target_page.bits == 0 || target_page.bits > bits) {
-        if (target_page.decided) {
-            return false;
-        }
-        target_page.bits = bits;
-    }
-    return true;
-}
-
 bool set_preferred_target_page_bits(int bits)
 {
     assert(bits >= TARGET_PAGE_BITS_MIN);
+
     if (target_page_bits_vary()) {
-        return set_preferred_target_page_bits_common(bits);
+        /*
+         * The target page size is the lowest common denominator for all
+         * the CPUs in the system, so we can only make it smaller, never
+         * larger. And we can't make it smaller once we've committed to
+         * a particular size.
+         */
+        if (target_page.bits == 0 || target_page.bits > bits) {
+            if (target_page.decided) {
+                return false;
+            }
+            target_page.bits = bits;
+        }
+        return true;
     }
+
     return true;
 }
 
-- 
2.52.0


