Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B40EB1049
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzub8-000756-2u; Tue, 10 Mar 2026 06:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzub6-00074v-Pa
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:45:56 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzub5-0005pR-8T
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:45:56 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439d8dc4ae4so2604732f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773139553; x=1773744353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dm2CjIc6aJ3cg2fzdq5ZPLjZ685+4GhYkIA6/nMpEFE=;
 b=MD6WhNbkAHmPRd4OzIqtzm60K22b90GqhKpMdtTH5DDmKIBToGa+cLhu2fmM52KPS2
 dRGfrA+lC3hb1JJFS1w88daPFBqMEkK6mcXmhKSEYtohyXxgot9rwaDuVWs/3CCzk/tb
 LuPERFgGVGOSS4K+SUJw5LnCns8gpOzjjWelB39+pBkK2rPOgnYORXQja/Zn0TdbaMc/
 EP0xCa0wu7RKCU09d6cNPaNYF4LLEfS72JR1ouPx33sLSLPf8WnaMZtQjRMT64B7MC/0
 IyK/sWBHeQj4jIcT7HNA9vH3RfMRgwpmyhFQ8LUDPkD2Y0oY0kvyaXX+3yM72DKeBtwg
 PBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139553; x=1773744353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Dm2CjIc6aJ3cg2fzdq5ZPLjZ685+4GhYkIA6/nMpEFE=;
 b=PfuHXfaSTBVA4vwCnGRvjej2ISKIVqKg8fK2r9yD+7LNlXTW2GxZBJWxu2D67rLd+E
 AB/4pwMv1tUWKrj4pzflOeKqlbRQS+e6Bm3/Ak64kucYJCPDS58MOb9jp96eDoAOyZbC
 5OaL58EOhGRUXi3jPQWrepreCfAm1N60MlL1jHEchKOUrihnSgZ79PCmOhsX3aXMY3li
 7ZMxIimQO7RDRboRFTMns+pacmW1kARM/QLMAO/MmAS0DdbOz3sbw4C1eAvmYCRhqLrm
 5q/7xWP/rTiiLWkQiBSs9RgDiILn6gjzClBc0HtVMv+FRf6jeCITiWB2LhHifc2HrqbY
 TA2Q==
X-Gm-Message-State: AOJu0Yyho7i2I4LRhyYSH4bV+PBghw6qu5BiIZDA9kCZ6QOrLkTgMlmC
 TRoiO6qjcqLU3b61DdC5eeRPLa2i5LAOr0DA0nxKIeZjXQV0vj9lOOMS4G/H9fZRVDJAetXFAFl
 MKpap5yk=
X-Gm-Gg: ATEYQzxxDC3YKZJAKTcqF9JRv1Hd/0D40CNjLB9vS65vsW2qfJ8L4vooDnQeXZLxevx
 5wILDppmH5uj8Hlb9kKmmsnj09E5mjMNLDpjAS8kLPD4iQtNA6kHcse7ySGJRqSd+dpN/cdtXGs
 UI31Hz3cy4sOatknrcPxJQNH4kxFLpTfbC2Xys5GrHNEXsT5v79zn+GXXu2ZJqUhLnzmuJ2se3O
 M7c3UX105R71Gtc0a3HIybgvAwqrum++uN9c++XryLkAgIVNZNJ+qWlepEFrZ98nvDVsEZr4QAY
 ROj49+eczUD0WaMstqikq/DY4migSyl2mwud7G+6hFWZnu7qgIq7Fun+gi8Y5F3S09ht5jvt4QK
 b15zS6/BGVqbyll3ftgvd5coDp/4QcFdI2uMIjmTyIrxZ/yx7Ta4SEoC+1m194YDz5b8VLEhqRt
 GEbYjrEdOSNloLoRWLc50mYxgiG5HH0SrzJHaVLHCLfXtoLofUzU+aUpcj9qFpkpNB6BfGoTZq
X-Received: by 2002:a05:6000:40de:b0:439:b79d:b99f with SMTP id
 ffacd0b85a97d-439da86f6c3mr24742967f8f.40.1773139553349; 
 Tue, 10 Mar 2026 03:45:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8d973sm32709821f8f.3.2026.03.10.03.45.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 03:45:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/16] tcg: target-dependent lowering of extract to shr/and
Date: Tue, 10 Mar 2026 11:45:01 +0100
Message-ID: <20260310104511.12670-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104511.12670-1-philmd@linaro.org>
References: <20260310104511.12670-1-philmd@linaro.org>
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

From: Paolo Bonzini <pbonzini@redhat.com>

Instead of assuming only small immediates are available for AND,
consult the backend in order to decide between SHL/SHR and SHR/AND.

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[rth: Split from a larger patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260303010833.1115741-7-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tcg-op.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 13a56d89fa1..d8ae57d6047 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -907,6 +907,8 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
 void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
                          unsigned int ofs, unsigned int len)
 {
+    uint32_t mask;
+
     tcg_debug_assert(ofs < 32);
     tcg_debug_assert(len > 0);
     tcg_debug_assert(len <= 32);
@@ -922,8 +924,10 @@ void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
         tcg_gen_op4ii_i32(INDEX_op_extract, ret, arg, ofs, len);
         return;
     }
+
+    mask = (1u << len) - 1;
     if (ofs == 0) {
-        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
+        tcg_gen_andi_i32(ret, arg, mask);
         return;
     }
 
@@ -934,18 +938,12 @@ void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
         return;
     }
 
-    /* ??? Ideally we'd know what values are available for immediate AND.
-       Assume that 8 bits are available, plus the special case of 16,
-       so that we get ext8u, ext16u.  */
-    switch (len) {
-    case 1 ... 8: case 16:
+    if (tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I32, mask)) {
         tcg_gen_shri_i32(ret, arg, ofs);
-        tcg_gen_andi_i32(ret, ret, (1u << len) - 1);
-        break;
-    default:
+        tcg_gen_andi_i32(ret, ret, mask);
+    } else {
         tcg_gen_shli_i32(ret, arg, 32 - len - ofs);
         tcg_gen_shri_i32(ret, ret, 32 - len);
-        break;
     }
 }
 
@@ -2121,6 +2119,8 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
 void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
                          unsigned int ofs, unsigned int len)
 {
+    uint64_t mask;
+
     tcg_debug_assert(ofs < 64);
     tcg_debug_assert(len > 0);
     tcg_debug_assert(len <= 64);
@@ -2136,8 +2136,10 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
         tcg_gen_op4ii_i64(INDEX_op_extract, ret, arg, ofs, len);
         return;
     }
+
+    mask = (1ull << len) - 1;
     if (ofs == 0) {
-        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
+        tcg_gen_andi_i64(ret, arg, mask);
         return;
     }
 
@@ -2148,18 +2150,12 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
         return;
     }
 
-    /* ??? Ideally we'd know what values are available for immediate AND.
-       Assume that 8 bits are available, plus the special cases of 16 and 32,
-       so that we get ext8u, ext16u, and ext32u.  */
-    switch (len) {
-    case 1 ... 8: case 16: case 32:
+    if (tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I64, mask)) {
         tcg_gen_shri_i64(ret, arg, ofs);
-        tcg_gen_andi_i64(ret, ret, (1ull << len) - 1);
-        break;
-    default:
+        tcg_gen_andi_i64(ret, ret, mask);
+    } else {
         tcg_gen_shli_i64(ret, arg, 64 - len - ofs);
         tcg_gen_shri_i64(ret, ret, 64 - len);
-        break;
     }
 }
 
-- 
2.53.0


