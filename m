Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCEDD2E012
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9P-0007KH-Ut; Tue, 22 Oct 2024 23:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S9A-00071n-Ni
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:58 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S94-0008N3-PA
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:56 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71e4c2e36daso321838b3a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654489; x=1730259289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HK9N6tHG47O71NeOx8tuvupnWYQfP4K1YdBEoQRe2Fo=;
 b=gM5GL+3i0U9vKS/p3rEP5zmMarqsp3YvzHQM3IObdzyhcZYRKRPY5uItpKwLeaQxcC
 /15AegtE3Dutdd2yZYLJABbTPbaf9y5GF8MPKbtzg1NWxSoxkXEBRShYgzgDYaps6NGK
 Fd1DX+y/xIs5kdNrUOIcxmkFd32azA3lbF3WCV4Egv8QEaxBnTz1ulPG9EFNLBqjepnh
 edNRiREEB6FD4dYJG8HSw42UCiBTlHLeFQ9bTKAPGbzMtp/tUhrYGft5QSS3/QCqUz5u
 hw4hBH+vPNHbi9YHf9QrmKij/KHyLX/yzkAfMHqiY3mU4MoD2WxEQ6hapvELoeMZhLSV
 tynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654489; x=1730259289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HK9N6tHG47O71NeOx8tuvupnWYQfP4K1YdBEoQRe2Fo=;
 b=Y4FenPWUVaYEuJdnySuLgGvni4uOJrbFyy0xn9SmkT+8u5CAvNhfujBPjTXqpUR4VA
 2wtW1iKJPbaKfoxomvRj/svdjLuMgMPV5btNbUmsYcy7kf0HhVbA+dU8cCP2EikU0HR7
 dETgF3L50x8PhAIJHJImvz9ROE6OwSSzBRg3HkqSDp6wSfwZnBSWPfP7phwqGPTmF0/y
 rclwdq4x6pfaE7BwiZ3Y7hdaEAw951YRjH/kjBT7apubP4M4Wfr/7crugGlyPLqqRI8S
 12y2Jwix7OmXlMqqBMGfYWUDnGqBOVLJgD6yyLJI1IU0yni0O6/wnBzom7F81HQO152P
 gMwA==
X-Gm-Message-State: AOJu0YwkSFabLQ+/o1XXuq5yUbKyOegnyTgzXrZdhPabCYm86qUShCb5
 kviI7pxGQiPpog93ZCYrvtpHQEq4yYuSKhwanr24+zoIZNgs0jZPXDxXxemnXuAmFr3q4UGu3bK
 f
X-Google-Smtp-Source: AGHT+IHU/RkDqUromhu2bee4bdJO1Uktf7FvhWLK/K+4NCvytb9mV3uYrsT1TaMRvK0ObJgmPbVQJA==
X-Received: by 2002:a05:6a00:124b:b0:71e:5573:8dcd with SMTP id
 d2e1a72fcca58-72030f586b2mr1823397b3a.2.1729654488772; 
 Tue, 22 Oct 2024 20:34:48 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/24] target/i386: Remove ra parameter from ptw_translate
Date: Tue, 22 Oct 2024 20:34:27 -0700
Message-ID: <20241023033432.1353830-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

This argument is no longer used.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241013184733.1423747-4-richard.henderson@linaro.org>
---
 target/i386/tcg/sysemu/excp_helper.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 8b046ee4be..da187c8792 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -60,7 +60,7 @@ typedef struct PTETranslate {
     hwaddr gaddr;
 } PTETranslate;
 
-static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
+static bool ptw_translate(PTETranslate *inout, hwaddr addr)
 {
     int flags;
 
@@ -166,7 +166,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
                  * Page table level 5
                  */
                 pte_addr = (in->cr3 & ~0xfff) + (((addr >> 48) & 0x1ff) << 3);
-                if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+                if (!ptw_translate(&pte_trans, pte_addr)) {
                     return false;
                 }
             restart_5:
@@ -190,7 +190,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
              * Page table level 4
              */
             pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 39) & 0x1ff) << 3);
-            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+            if (!ptw_translate(&pte_trans, pte_addr)) {
                 return false;
             }
         restart_4:
@@ -210,7 +210,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
              * Page table level 3
              */
             pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 30) & 0x1ff) << 3);
-            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+            if (!ptw_translate(&pte_trans, pte_addr)) {
                 return false;
             }
         restart_3_lma:
@@ -237,7 +237,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
              * Page table level 3
              */
             pte_addr = (in->cr3 & 0xffffffe0ULL) + ((addr >> 27) & 0x18);
-            if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+            if (!ptw_translate(&pte_trans, pte_addr)) {
                 return false;
             }
             rsvd_mask |= PG_HI_USER_MASK;
@@ -259,7 +259,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          * Page table level 2
          */
         pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 21) & 0x1ff) << 3);
-        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+        if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
     restart_2_pae:
@@ -285,7 +285,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          * Page table level 1
          */
         pte_addr = (pte & PG_ADDRESS_MASK) + (((addr >> 12) & 0x1ff) << 3);
-        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+        if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
         pte = ptw_ldq(&pte_trans, ra);
@@ -303,7 +303,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          * Page table level 2
          */
         pte_addr = (in->cr3 & 0xfffff000ULL) + ((addr >> 20) & 0xffc);
-        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+        if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
     restart_2_nopae:
@@ -332,7 +332,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
          * Page table level 1
          */
         pte_addr = (pte & ~0xfffu) + ((addr >> 10) & 0xffc);
-        if (!ptw_translate(&pte_trans, pte_addr, ra)) {
+        if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
         pte = ptw_ldl(&pte_trans, ra);
-- 
2.43.0


