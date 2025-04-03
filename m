Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43F7C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UK3-0000u5-6u; Thu, 03 Apr 2025 19:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UK0-0000k6-06
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:08 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UJx-0000VE-L2
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:07 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so810785f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724204; x=1744329004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zdkIZVCk0oK1AHydxn4CXLts02MNjyPOTlWUooOm/tw=;
 b=abfsmUeeBqROTADd5ddB16yN5Bn0HBLa3Hnxk5HeN9tQIPsEmjMHQQtCT4sGrgd2iV
 LgTpXB2rodemD5jM6T/OadrJFso+JpPORTlb6vtliEISTyD2K/gOAa7tchUp6P/x+BW7
 qTzCyNAWxgu563w6Ch7GaJa6QtkFkZDWbQC3jS3ui1cV2CZznrXobpK8VDkewh9n1o2l
 EF3RgG87G1cwCGERgcCVqBXG2yWoj72Mowxj2a6JLty+MBOXqzxKtFslW22RYg0shY/c
 gXtfRADjNZ2fCItaQEBtCXVVGAKd83zjhX6QYlbbTGr4W9YAx/Uq7oOakvD9HxCJEv85
 L+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724204; x=1744329004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zdkIZVCk0oK1AHydxn4CXLts02MNjyPOTlWUooOm/tw=;
 b=r9LWLGXiKEdBZh4IZgNWJ9cf5iBziihgb5kKsIKKyMcLwUPdU5HyOlomYn4pMBTMke
 VzovnmwY+pexXMtk3DtD3yvBoNYJSp16h7b3aEcg2yr6ER5+cTpkmi3OBuhj7+USEepn
 GWcNLoTReoyoZb7Z0MC0Ofxks46oUukdmsAJnGjMnmrjC3jqJvBFrm2HVvQr5jpcw8W6
 9okuZxho0FImz/9iWFhhd+pluITZ2cx5g/UCKJUnGEd5UfdltttCGTF/WTrzYMegL0KU
 +nzRBsfcXraaBWAWjVLbixlDEwaOqioXrhuv5q1orQXHE6VSw4Kl+m2NdqH/9m9LDHkB
 jmXA==
X-Gm-Message-State: AOJu0YzHk4fpIQVJTVZ/L7FShoai/A35RWGYAM+oOTGcvnX4OEEBOCQn
 d4CW8B4NvOZG/AtjU2+9uv+LR/xSIIPhFNPpSS/rzY8ZuzrgJCKGUyhBbe4ZOYrGXicJEfRhr0D
 j
X-Gm-Gg: ASbGncvCjMTYk6SoLPEFv868E9bBw55GPoIWpNTz0UGv1Wpbp7AiP0F+oKyfOR/kCFN
 hqr6F3fNhZsB0bBfR0/Hf+eoSlbhjtUyiUxdRGUv2Tkn4Tbq3R6/XiS1xvjfW2Z4EUdzWGxVl+8
 FHy1jJLzPCWwjpFsL1E0IPqhjcc+a4ULBeKURixa3gjzkTC5wJC1wKcp5EyJkcDyUO1WwfZr5QX
 AKRT4hn9pBCcpN7LA1sSarNGHq8CdXA9vX5bJ6EJ7mW/NAWK17spBJ+I4KnGSApJs6CVisMLb0X
 7fMb/z6AnPhHnUI7d7/6NQQzJYjw7zw0WN+4kHX9W5amqovyu5MovPEe9dTe6Q4Aplnb6n6zsCz
 pFYCCWHfIbZJrSOX/CBk=
X-Google-Smtp-Source: AGHT+IGJc7xf48j7MctoqfOOUopvibIJsAcYZUdY+TDZCXDR6W+Sp2SZdRgUpKo5a6+BPy5NCfzH8A==
X-Received: by 2002:a05:6000:220b:b0:39c:2692:4259 with SMTP id
 ffacd0b85a97d-39cb35981fdmr991805f8f.21.1743724203828; 
 Thu, 03 Apr 2025 16:50:03 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec3174cf0sm32222245e9.0.2025.04.03.16.50.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:50:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 07/19] target/hppa: Replace TARGET_LONG_BITS ->
 target_long_bits()
Date: Fri,  4 Apr 2025 01:49:02 +0200
Message-ID: <20250403234914.9154-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/mem_helper.c | 3 ++-
 target/hppa/translate.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 554d7bf4d14..03cd103f284 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/target_info.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
@@ -101,7 +102,7 @@ static void hppa_flush_tlb_ent(CPUHPPAState *env, HPPATLBEntry *ent,
 
     tlb_flush_range_by_mmuidx(cs, ent->itree.start,
                               ent->itree.last - ent->itree.start + 1,
-                              HPPA_MMU_FLUSH_MASK, TARGET_LONG_BITS);
+                              HPPA_MMU_FLUSH_MASK, target_long_bits());
 
     /* Never clear BTLBs, unless forced to do so. */
     is_btlb = ent < &env->tlb[HPPA_BTLB_ENTRIES(env)];
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 14f38333222..81f535589cf 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target_info.h"
 #include "cpu.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
@@ -3731,7 +3732,7 @@ static bool trans_shrp_imm(DisasContext *ctx, arg_shrp_imm *a)
     t2 = load_gpr(ctx, a->r2);
     if (a->r1 == 0) {
         tcg_gen_extract_i64(dest, t2, sa, width - sa);
-    } else if (width == TARGET_LONG_BITS) {
+    } else if (width == target_long_bits()) {
         tcg_gen_extract2_i64(dest, t2, cpu_gr[a->r1], sa);
     } else {
         assert(!a->d);
-- 
2.47.1


