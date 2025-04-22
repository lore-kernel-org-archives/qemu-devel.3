Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6638C369D8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JPP-0006Kd-SJ; Tue, 22 Apr 2025 15:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLn-0000sS-W1
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:12 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLj-0006f3-Ts
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:10 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-225477548e1so56981905ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350326; x=1745955126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FNsYq0CLsO6lFu+oOVVyImJDoiCdKLFU/pHo4cHTdc0=;
 b=ILG8taac1OfMepSdtGLz5MfYvotv6r/uaz8W625e6R3Sm4LfUljQx1wB8KScQZWYP3
 ign3wF+b0ZIKTl8Mew9s+0QtAErR/CRJPypElolxbSYVFAf5gt0X6+di9TiJX51OBHv1
 I4VApXUpHz/JgvaDRpJgkk1EMmqbX0JCqUKzH+xA5J4AAbGY2fU9e4Rp1tT/DB8b1WeP
 6V/uZAp0uBBkf95pFInPuCSj27RLiXwsHINzX56sE7YWp3Yl7ly5D2luSFLvCLKyHFDG
 egnV5CYP00mRpgXHXTqpScVcndLrurkvowKMZFonEj9QbUfhtebg/7sL89x/86pnO/XR
 cxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350326; x=1745955126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FNsYq0CLsO6lFu+oOVVyImJDoiCdKLFU/pHo4cHTdc0=;
 b=g4VYgFMj70uXGGpAT1M5PYSnRcnwzIv9KGUdTApzZKiFNPusyLUKBf80xW+TAKjJIJ
 WMNJPLeg3hI21vAUD1Lgd53vU7j4jxfivd+E5OOZgETke0tjxpScKuvMMnn+dvZqTxjM
 W7tJfe9hlVogQ062misWN4Q4CC0ua12f5BJpYdUwrKhsXdVBJ9lcUWYXSuuvCKZeq4QX
 6KQ20a+fqrOQiIwdFAYNkrbaycA2C7D+vPEuI/tXw/C0H6KRLJzYVuSeLmH6oipMBdhv
 sJC63+DWMjteBEftm2MWM6ztC0ueRbDCzTxOO5sXKJs/Gs3VbkVPjBYBgelMIvM+vn9U
 ypIQ==
X-Gm-Message-State: AOJu0YxxE1fSrdmAqqTNYwGaM2W6xcVrCGZr02BJGcL/bS/QzNiu+6yK
 +96Cp2/MSj7qJiLe9lXXnVWkLyvUIg+CsN+3ZH+aUi8HMStZdPf3qvhE1E/I6hN+Mghk/2f4PuN
 G
X-Gm-Gg: ASbGnctRFJOeMHPvtA7iCufvIlLuit3Ij1dP8nQUNDxOSXDQC0WEd4kHyKb4yRTeCQ3
 6XZ43ZK2jVsgOTPV6UiPu3wNfLZ9tLlb9Y9RTRftR/BQ1tSPVQGchutTHbOiNrO1BVtSol2OS7x
 9ItPPWDS1+q2kN/3RMlai2nfWljsh8ouQBfLA2+nNbCH2/Oh8fN1+3yuFh1vWqtXZMD0hd/rVmZ
 O4tiAl7By7iW1l143GUJJFcMhimKQzP1f5EmqO3ADl+IPFFxG0b53/RfAz20JtBH0xQiybIjlc2
 NYjKf6SAxVdxiyTro7pQZ+ovuQdZS1euoBABSMtXr0IBSARvXMXtElVi6DFEXiWisGJp9eoTbd0
 =
X-Google-Smtp-Source: AGHT+IH8tyNJAPlcoThH61nxsi9AvyxPX8UEI+4Dxg66XlIu1kNlAAMzTLQdh21BOn/uRh2xR9Y9+w==
X-Received: by 2002:a17:902:ef0a:b0:22c:35c5:e30a with SMTP id
 d9443c01a7336-22c53580d0dmr229724425ad.16.1745350325938; 
 Tue, 22 Apr 2025 12:32:05 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:32:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 069/147] accel/tcg: Remove page_protect
Date: Tue, 22 Apr 2025 12:26:58 -0700
Message-ID: <20250422192819.302784-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Merge the user-only page_protect function with the user-only
implementation of tb_lock_page0.  This avoids pulling
page-protection.h into tb-internal.h.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-internal.h        | 11 +++--------
 include/user/page-protection.h |  1 -
 accel/tcg/user-exec.c          |  2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index 68aa8d17f4..f7c2073e29 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -51,28 +51,23 @@
 
 #endif /* CONFIG_SOFTMMU */
 
+void tb_lock_page0(tb_page_addr_t);
+
 #ifdef CONFIG_USER_ONLY
-#include "user/page-protection.h"
 /*
  * For user-only, page_protect sets the page read-only.
  * Since most execution is already on read-only pages, and we'd need to
  * account for other TBs on the same page, defer undoing any page protection
  * until we receive the write fault.
  */
-static inline void tb_lock_page0(tb_page_addr_t p0)
-{
-    page_protect(p0);
-}
-
 static inline void tb_lock_page1(tb_page_addr_t p0, tb_page_addr_t p1)
 {
-    page_protect(p1);
+    tb_lock_page0(p1);
 }
 
 static inline void tb_unlock_page1(tb_page_addr_t p0, tb_page_addr_t p1) { }
 static inline void tb_unlock_pages(TranslationBlock *tb) { }
 #else
-void tb_lock_page0(tb_page_addr_t);
 void tb_lock_page1(tb_page_addr_t, tb_page_addr_t);
 void tb_unlock_page1(tb_page_addr_t, tb_page_addr_t);
 void tb_unlock_pages(TranslationBlock *);
diff --git a/include/user/page-protection.h b/include/user/page-protection.h
index 51daa18648..d5c8748d49 100644
--- a/include/user/page-protection.h
+++ b/include/user/page-protection.h
@@ -16,7 +16,6 @@
 #include "exec/target_long.h"
 #include "exec/translation-block.h"
 
-void page_protect(tb_page_addr_t page_addr);
 int page_unprotect(tb_page_addr_t address, uintptr_t pc);
 
 int page_get_flags(target_ulong address);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 667c5e0354..72a9809c2d 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -657,7 +657,7 @@ target_ulong page_find_range_empty(target_ulong min, target_ulong max,
     }
 }
 
-void page_protect(tb_page_addr_t address)
+void tb_lock_page0(tb_page_addr_t address)
 {
     PageFlagsNode *p;
     target_ulong start, last;
-- 
2.43.0


