Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2142E68156
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHkV-0002l8-HN; Tue, 17 Feb 2026 04:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsHkN-0002U0-Jv
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:51:59 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsHkF-0006AL-RO
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:51:56 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so39554075ad.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 01:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771321884; x=1771926684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNM7XgKmeqgrM8/J+m8bKIPPky9vmnlqRq/BAY1KTRs=;
 b=kYU7wyxZwI7PZWJFdLWK31ot/T0HmEt5yqZKvn3nZXC6l4Emdd9EGLPSufk9twnfjR
 hAbXjnODWdbBS+ZFVqa/tkzYRvUbxZTSlvC1LP8iWT9FgNqzPI/UspQUWk4PZNvVRVHQ
 Oq67/Yhtyut4NmB28taS+b8mwdiaF7uEKP555v234Gx0MK54KQICZzPMinVsX91p5urB
 GcSiZztKC48izq5gXubSpvzt2Wr7jKlZnQ8daYFA+FwI1WuVAqv/DH/pXwG8GXn1aoSE
 z3fWGO4IdLG9CLVQAxscia6lUinzVj49wxbUGdwCAvfzmM/1eEOyfpoV41i/SKvIR6Rr
 XF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771321884; x=1771926684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hNM7XgKmeqgrM8/J+m8bKIPPky9vmnlqRq/BAY1KTRs=;
 b=fIOkFnjZFXKsv/GPjIv9Q79K/+AFIu2hmfy3lXUjKyKSyIqYsjkfWiU19ModMIb37j
 s5J2xNWXXDeiLu/H2GAx4wKMnZ6svwmkJ64J9JzNdydErggML6Yzi8pOSrSXv4/UHXmW
 HNrIt/uSmBU/OcDKAb1+1oftThkiTw1EGNqy7B3QG1+sGGxNX7Uw/QGB1RJvI3/Mt9Lh
 h9eVGlU92i3alee9vHM9L79OCwHQGvGSftAkEyAf10vmNhc2L/7kqwcpnB5fLFwHyOsq
 Raj2rzoRsXqEdPKo6D2sVbGrXXFBwS7YrX2lT46d6c2y5elpQdn5UjZ8dCUiVSoF7sm4
 YYLQ==
X-Gm-Message-State: AOJu0YybqNpvH0qNjNquMEKvo5R8fA2wOoAYnnqCcw8Z/+GuM5Fja0/i
 hZ2K4dw8KuDpiEJ7a3LCYssvJWYQh++8u50E+GXyUVYTWNb+/fvJeimW9tDV5e5xjWJ2kNjfZ88
 MCc5n8n0=
X-Gm-Gg: AZuq6aILl3vLY603v9qKU7jFN9/mvNklciI8Le3jCObSGnTBIlOBdCAYOCMWBoWF7CJ
 j/r2nSTZCB7sBEIXllBBaxdO80VARtJQx05caeWpztVMboh/ILyqjj8nIVohN5Q2dfE0exi6ZuA
 UIe8eh8T6XSBswzqI1TK8YLURP424Jil2v694WZ/ivpqYjWGxffWb/jgEOU5bnBmcDMwvUYMg3W
 R5s4gL/0/QY/6UrA734PmMlX1/5VXVQAW0x+XSB5CIEMrg3fPptTp8p/L2XRDwMuPwcqqoZi+1w
 l6gyxo2jw/BtAF5v/RBQCoImKgB/0dAvQuwPfTDbbXQaFjF6vUtEpZHds6Ls5AR/IeCIJxTwyzO
 tlzsaGkX30c0S+EFZn9rlREMnX25RpsOFWEAcGaUQ6ApEpTJnnJXxfC57m1avPzqJNN5VsHjdAR
 xuoNtJeeetz4quMoTnoe572uAAM0irc4DKC/CkUqoU025fwU+j7XR5BOPl1I5xI05CfxuEBayqa
 0CLqlyB/JrEQZACXDY6XhSEGLIJzyLqdTcXzo4=
X-Received: by 2002:a17:903:3805:b0:2a1:3cd9:a737 with SMTP id
 d9443c01a7336-2ab50598d8fmr155781675ad.36.1771321883948; 
 Tue, 17 Feb 2026 01:51:23 -0800 (PST)
Received: from localhost.localdomain
 (2403-580b-742d-0-10a2-dce1-aa4a-dd32.ip6.aussiebb.net.
 [2403:580b:742d:0:10a2:dce1:aa4a:dd32])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a6fa33esm99108675ad.13.2026.02.17.01.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 01:51:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 5/7] page-vary: Build finalize_target_page_bits as common
 code
Date: Tue, 17 Feb 2026 19:51:04 +1000
Message-ID: <20260217095106.598486-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217095106.598486-1-richard.henderson@linaro.org>
References: <20260217095106.598486-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Use target_info->page_bits_init to merge
finalize_target_page_bits_common into
finalize_target_page_bits in page-vary-common.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/page-vary.h |  4 ----
 page-vary-common.c       | 15 +++++++++++----
 page-vary-target.c       | 12 ------------
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/include/exec/page-vary.h b/include/exec/page-vary.h
index c4dc56634b..f2d735bec2 100644
--- a/include/exec/page-vary.h
+++ b/include/exec/page-vary.h
@@ -40,10 +40,6 @@ typedef struct {
     uint64_t mask;
 } TargetPageBits;
 
-#ifdef IN_PAGE_VARY
-void finalize_target_page_bits_common(int min);
-#endif
-
 /**
  * set_preferred_target_page_bits:
  * @bits: number of bits needed to represent an address within the page
diff --git a/page-vary-common.c b/page-vary-common.c
index b41137c644..ddd0863378 100644
--- a/page-vary-common.c
+++ b/page-vary-common.c
@@ -50,11 +50,18 @@ bool set_preferred_target_page_bits(int bits)
     return true;
 }
 
-void finalize_target_page_bits_common(int min)
+void finalize_target_page_bits(void)
 {
-    if (target_page.bits == 0) {
-        target_page.bits = min;
+    int bits = target_page.bits;
+
+    if (bits == 0) {
+        const TargetInfo *ti = target_info();
+
+        bits = ti->page_bits_init;
+        assert(bits != 0);
+        target_page.bits = bits;
     }
-    target_page.mask = -1ull << target_page.bits;
+
+    target_page.mask = -1ull << bits;
     target_page.decided = true;
 }
diff --git a/page-vary-target.c b/page-vary-target.c
index d388c5c3d6..bc4d8931b6 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -38,15 +38,3 @@ int migration_legacy_page_bits(void)
 #endif
 }
 #endif
-
-void finalize_target_page_bits(void)
-{
-#ifndef TARGET_PAGE_BITS_VARY
-    finalize_target_page_bits_common(TARGET_PAGE_BITS);
-#elif defined(CONFIG_USER_ONLY)
-    assert(target_page.bits != 0);
-    finalize_target_page_bits_common(target_page.bits);
-#else
-    finalize_target_page_bits_common(TARGET_PAGE_BITS_LEGACY);
-#endif
-}
-- 
2.43.0


