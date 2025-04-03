Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CC9C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 22:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Sg4-0008Fk-Hc; Thu, 03 Apr 2025 18:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sg1-0008Ex-K4
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:04:45 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0Sfz-0003kY-L7
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:04:45 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3996af42857so1720502f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 15:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743717882; x=1744322682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGrFJ4R/UrCSTPkLctl7uvnpTFEBVznWA25W+AuvYOI=;
 b=kroefLfLWs4XvRTkD5kxLBpYsE6r9NEBlwZgsn7vWVLbYLntuXJUkT9jV+BRbaCMFK
 F11gqZZHz0JfKeSilWoo5uJg6Iki1+FU0WoiZZ71jeKJ151TFSplCemm5B6jkdzwpdK+
 pNydrZx0vBcPFJVELqPeRn0EmrQKdDFaXi6ejCFTJsGUS4VC4ig135QAUdoKLDetWJr6
 IsLfAGpHUcb1C2mZgFTLF85+g1LvjKXysTYcS4t3wZnWci6tFaaqp3rw7cV5Fmi74aw7
 qyID4SrDvNC2Wx6726/ecUmrpnoy1084M/uI61p/tCOebFYVWTBY+z0pT+zftVGRFJfV
 gwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743717882; x=1744322682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GGrFJ4R/UrCSTPkLctl7uvnpTFEBVznWA25W+AuvYOI=;
 b=RTzNRTqyoRmt1Xaw0RLA1PAJn7t5EH6/TmzcJjT4rAU/OX3HjbAvr+IjCFkocSyGue
 rrUf0IdjJ2t6+qVbaT0ZijZiewr7wsHjxLhokCvnN/lOiAk8FbW4KbKQR4lYEXk1mSqq
 80t2xkuwNKWad8hGBwpqlfbPah5agXbMsWILeBAZS3lva/v3J8iEj9SUES3v2xq718BT
 wDhBggMm5hrXtgyxVYv5HWvalYWEqhWYlsYYxynMNFTNtR5B6WSPTHjA+1wcOA1o9A4H
 u6e6eHZ+GdUKjuwYA/AWflYSVsOoLfSgU3BDvcy18RTp1csqSfjCqbNu/PVTJXJy8xUI
 yTRw==
X-Gm-Message-State: AOJu0YyihWPjqaBUnVOsIBCCrBPAQ9EorEcl/rZWSN/2AcvO6nkGpoMy
 84/X+XrMP7pnq3A0et4xcK9YDa32jJeBo40H3+vjrSArqTG+D2T27v56T4ZgbV0aL8ByUkcLoFd
 U
X-Gm-Gg: ASbGncu77oxrW71f5Xdne5vTJgigqc7mn/bqd+BLtW4duXJp34JX8ULD2y89oBLMrJx
 cZy4BS3aNEvwVSBSRBoGW2WhSUEtiPfW8SOpj+73XHuI9kR0eKnH6rImRSXb7Es8qCpPMMC2iNs
 MDIHZOvtRgrOGuk1ZLhwlzSeh0YeUcJfk7enpZLf/5aznn8qiaqUAsjRidPAQqv+5iKQY7bXeSx
 +6YKP4Q30JkagsPjoAsK/0pyxLD/0dkZhPhgMg3joHTrz+Pm0NrJp0wONVmN5lLo463n1Y1KxTD
 lGBdfa47fcgOjvTzZkfQsKiS9rNMWeOInXLykyYHzvrO1tHwTOyKZB71g9VYz9jB7Ge3U9sNPGB
 9d4FHqVAW2bwz15WLwvFuCi4o
X-Google-Smtp-Source: AGHT+IH0h0wnuUERf6CwMGHWgxQDlLzwQXjJQ0zOSi5PUkSuWCVRVO+eClgyVkBxd4gVFDm5gqS79A==
X-Received: by 2002:a5d:5f8e:0:b0:39b:32fc:c025 with SMTP id
 ffacd0b85a97d-39c2e5f50f4mr3901408f8f.2.1743717881841; 
 Thu, 03 Apr 2025 15:04:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096861sm2867966f8f.14.2025.04.03.15.04.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 15:04:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v3 04/19] tcg: Always define
 TARGET_INSN_START_EXTRA_WORDS
Date: Fri,  4 Apr 2025 00:04:04 +0200
Message-ID: <20250403220420.78937-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403220420.78937-1-philmd@linaro.org>
References: <20250403220420.78937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Do not define TARGET_INSN_START_EXTRA_WORDS under the
hood, have each target explicitly define it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/insn-start-words.h | 4 ----
 include/tcg/tcg-op.h           | 2 +-
 target/alpha/cpu-param.h       | 2 ++
 target/avr/cpu-param.h         | 2 ++
 target/hexagon/cpu-param.h     | 2 ++
 target/loongarch/cpu-param.h   | 2 ++
 target/ppc/cpu-param.h         | 2 ++
 target/rx/cpu-param.h          | 2 ++
 target/tricore/cpu-param.h     | 2 ++
 target/xtensa/cpu-param.h      | 2 ++
 10 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/tcg/insn-start-words.h b/include/tcg/insn-start-words.h
index c439c09f2fe..d416d19bcf9 100644
--- a/include/tcg/insn-start-words.h
+++ b/include/tcg/insn-start-words.h
@@ -8,10 +8,6 @@
 
 #include "cpu-param.h"
 
-#ifndef TARGET_INSN_START_EXTRA_WORDS
-# define TARGET_INSN_START_WORDS 1
-#else
 # define TARGET_INSN_START_WORDS (1 + TARGET_INSN_START_EXTRA_WORDS)
-#endif
 
 #endif /* TARGET_INSN_START_WORDS */
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index bc46b5570c4..cded92a4479 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -23,7 +23,7 @@
 # error
 #endif
 
-#ifndef TARGET_INSN_START_EXTRA_WORDS
+#if TARGET_INSN_START_EXTRA_WORDS == 0
 static inline void tcg_gen_insn_start(target_ulong pc)
 {
     TCGOp *op = tcg_emit_op(INDEX_op_insn_start, 64 / TCG_TARGET_REG_BITS);
diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index 63989e71c06..dd44feb1793 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -24,6 +24,8 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
 #endif
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 /* Alpha processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
 
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index f5248ce9e79..9d37848d97d 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -25,6 +25,8 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 24
 #define TARGET_VIRT_ADDR_SPACE_BITS 24
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #define TCG_GUEST_DEFAULT_MO 0
 
 #endif
diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 45ee7b46409..635d509e743 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -23,4 +23,6 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 36
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #endif
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index 52437946e56..dbe414bb35a 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -13,6 +13,8 @@
 
 #define TARGET_PAGE_BITS 12
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #define TCG_GUEST_DEFAULT_MO (0)
 
 #endif
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index 553ad2f4c6a..d0651d2ac89 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -37,6 +37,8 @@
 # define TARGET_PAGE_BITS 12
 #endif
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #define TCG_GUEST_DEFAULT_MO 0
 
 #endif
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index ef1970a09e9..84934f3bcaf 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -24,4 +24,6 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #endif
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index 790242ef3d2..eb33a67c419 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -12,4 +12,6 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #endif
diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
index 5e4848ad059..e7cb747aaae 100644
--- a/target/xtensa/cpu-param.h
+++ b/target/xtensa/cpu-param.h
@@ -16,6 +16,8 @@
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 /* Xtensa processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
 
-- 
2.47.1


