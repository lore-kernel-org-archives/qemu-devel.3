Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4F3C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 23:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhzAG-0000SX-S6; Fri, 01 Aug 2025 19:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhz8w-0007Ur-4P
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 19:26:31 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhz8r-0005x0-Ag
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 19:26:29 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2405c0c431cso27690355ad.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 16:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754090784; x=1754695584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MAD79U4LT9iuyQ8dO/F2M38oxkHlL+RPoW3VQe2AtZA=;
 b=CA9fUU4F5QMeZsBRVni6cRrVniFqiHwPTziQ/P0ri3+IW0j8vgAzGun2xjDdlcXMwX
 Geyh0cWTkzoUohCUOHW3JIgVDgAaNWjkiddQYggSM4+YB9+gwpKBYOP/yQP2OIeTTb4j
 bUvKqMrXdYjYkhgk8YPqVaWylEXDNBxKEdOqzCFvXm6Xbkb1dWtY6Cetkthi7JZKF7UG
 s9IZ26+VjHIX2supueXHeEhjpinRwHs3sLXrNgrRLuNzCr/YjNks4dyFBI1LrmHLPINJ
 W0242jPkkDrZ/RV9D7PKZrnSR4aQ/mjKdNc0KP5QgMPa9IwLBJ835rLCAWcXyUJ8RRoF
 CrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754090784; x=1754695584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MAD79U4LT9iuyQ8dO/F2M38oxkHlL+RPoW3VQe2AtZA=;
 b=NkbkL8P9MGkxDo0q40KPufNFJ+iJ9PvXsTf/Nguzk/pA4u8mj6XogJmiLCp2vZwZAk
 LOKua3ZJGJmw944cxui21+naOHKAxnjRqQSGSu4M4HzpaY0HeRe1QaTw0IHFRNqapnSr
 dI8n8UbB2oEfeYGbQnCTZNI/l6M2NSxnm8aAu0twSu6nIDl38C9FJijXhUtERarYu+CT
 65lKPpdFBa8ofMXexdNWndzIJLS0Rvi7hRlyMCwX2o7qyspVY/sFYY1MvOdVY1sDuS/t
 ndudGB6Iy5UG48BDZizO0doLMuw50iIJcrJpUmQl3k/XqbVq6mWm5OPdzMK+etSu2KXa
 4jDA==
X-Gm-Message-State: AOJu0Yxf+/u+u2m6sbDVdEu7GzLtbxhMMmNYnmu6xltHLo98+SgWVR//
 pa8QbiOr09aPSsrQSq0yyExOKYzoeVxAa95DVFB3InDk5YIZrYPcNeTKn+EM0zTolxaEZISY7zy
 /hMItn1g=
X-Gm-Gg: ASbGncsL3cnOIvbcqZURH4brJKbIvIAv9cwDVTd3m7I6ZkUaQsdv1sQBMy9QXbaTKjt
 6sD/ZmZPX6SIz1aBsUUjf6X/3+WYi55El+LuXyt+bp24cJP9b1CScGqcoooTtijcVihXwg7oxTX
 kNgxmXtPdeOyRsGVf3RpmwEbCTU8VfL3myKlRed6IDdxDsEFQW1Rm88r4uQdkZ8T8QhwEQ2kBvq
 cm/r4Juu/mGi0wugddMeStWvBcfd6bLj53n0l+rYYWcXJZdNtA6F/urfRv6gDFScmdkET3mPXE9
 937hglUsmqnkoe3/BRB96EVzXIn7j27rY4/xWn63BsoX1HSQqNvX/sZOrHjrYFzToZdrhSaBJ8b
 qX6js1xpcud19bMHLQZHpUkdyMKkG9VvK
X-Google-Smtp-Source: AGHT+IE/kn1ICb177hhcpwa+yVHYtwDI7sG+v9+IU0NvQqDwU7dUX2YjJxI/D0wwIBLHtcFmrR2a9g==
X-Received: by 2002:a17:902:f1d2:b0:234:8ec1:4af6 with SMTP id
 d9443c01a7336-24247027524mr12359315ad.45.1754090783707; 
 Fri, 01 Aug 2025 16:26:23 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3207eca6d3asm5628217a91.23.2025.08.01.16.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 16:26:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 08/11] semihosting/arm-compat-semi: replace target_ulong
 with uint64_t
Date: Fri,  1 Aug 2025 16:26:06 -0700
Message-ID: <20250801232609.2744557-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250801232609.2744557-1-pierrick.bouvier@linaro.org>
References: <20250801232609.2744557-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 semihosting/arm-compat-semi.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index b56d882aa52..23319552a31 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -123,7 +123,7 @@ static GuestFD console_out_gf;
  */
 
 typedef struct LayoutInfo {
-    target_ulong rambase;
+    vaddr rambase;
     size_t ramsize;
     hwaddr heapbase;
     hwaddr heaplimit;
@@ -214,7 +214,7 @@ static LayoutInfo common_semi_find_bases(CPUState *cs)
  * global, and we assume that the guest takes care of avoiding any races.
  */
 #ifndef CONFIG_USER_ONLY
-static target_ulong syscall_err;
+static uint64_t syscall_err;
 
 #include "semihosting/uaccess.h"
 #endif
@@ -260,8 +260,8 @@ static void common_semi_rw_cb(CPUState *cs, uint64_t ret, int err)
 {
     /* Recover the original length from the third argument. */
     CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
-    target_ulong args = common_semi_arg(cs, 1);
-    target_ulong arg2;
+    uint64_t args = common_semi_arg(cs, 1);
+    uint64_t arg2;
     GET_ARG(2);
 
     if (err) {
@@ -300,9 +300,9 @@ static void common_semi_seek_cb(CPUState *cs, uint64_t ret, int err)
  * is defined by GDB's remote protocol and is not target-specific.)
  * We put this on the guest's stack just below SP.
  */
-static target_ulong common_semi_flen_buf(CPUState *cs)
+static uint64_t common_semi_flen_buf(CPUState *cs)
 {
-    target_ulong sp = common_semi_stack_bottom(cs);
+    vaddr sp = common_semi_stack_bottom(cs);
     return sp - 64;
 }
 
@@ -389,9 +389,9 @@ void semihosting_arm_compatible_init(void)
 void do_common_semihosting(CPUState *cs)
 {
     CPUArchState *env = cpu_env(cs);
-    target_ulong args;
-    target_ulong arg0, arg1, arg2, arg3;
-    target_ulong ul_ret;
+    uint64_t args;
+    uint64_t arg0, arg1, arg2, arg3;
+    uint64_t ul_ret;
     char * s;
     int nr;
     int64_t elapsed;
@@ -462,7 +462,7 @@ void do_common_semihosting(CPUState *cs)
 
     case TARGET_SYS_WRITEC:
         /*
-         * FIXME: the byte to be written is in a target_ulong slot,
+         * FIXME: the byte to be written is in a uint64_t slot,
          * which means this is wrong for a big-endian guest.
          */
         semihost_sys_write_gf(cs, common_semi_dead_cb,
@@ -688,11 +688,11 @@ void do_common_semihosting(CPUState *cs)
 
     case TARGET_SYS_HEAPINFO:
         {
-            target_ulong retvals[4];
+            uint64_t retvals[4];
             int i;
 #ifdef CONFIG_USER_ONLY
             TaskState *ts = get_task_state(cs);
-            target_ulong limit;
+            uint64_t limit;
 #else
             LayoutInfo info = common_semi_find_bases(cs);
 #endif
-- 
2.47.2


