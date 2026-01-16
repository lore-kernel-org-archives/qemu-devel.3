Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE3BD4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgagX-0005Eg-7s; Thu, 15 Jan 2026 22:39:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagU-0005Dc-KA
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:38 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagT-0008Vv-2Y
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:38 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so10568795ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534775; x=1769139575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnW0mF2lM84XyAIXdpTSBn+2equ8zZi4b8HlvUKuVvM=;
 b=tuxrs/+iR8LRza4HpDlkvHIf4MR+OiaprBwPB/pHYbGT4gdotOXWOPbYsOexeCgIrP
 Yi+JMAK5sbyoNai0CVM3h73VaCDqCqfeh8qARwW3zV+nBg8uAxiVMPxNNcCv/0ak/Wnc
 NKeB8KrILhEeS5sbBdrCFN4+WaDEGYFl1/wHHOyB1L6mq/eQTCoeS4P3vaupp8wqVVU9
 82W+k4snvm7tN/VyRagjSeMH3ljrJ4PCJ3Q+RuUrGg/wyJcjxoK5WDUv8wk6vvP6LX97
 X1jMkeEX65dO6wglMWmWbhRbLtbUvaYwS0nbdDLLFWBs5yN8nQelCxrYXA47ENCV0bzQ
 VxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534775; x=1769139575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vnW0mF2lM84XyAIXdpTSBn+2equ8zZi4b8HlvUKuVvM=;
 b=GAMnlYd0zF6r0QcuzKQ9ySErKQe/9L0MixWi57bwoRCZzMo75fJ9mgI1Xak5UgO086
 XYxWrAVR1cn6mxlNnhZV9fVqgVo+pVgimUuOWkbIFHBTf+OPoQQLLC1awj4TEvLGj2DE
 iB1Dp8db+h5Ezp1nn9DhHMKh3eacG2dPoU0n22LksojCdM8gEt0QKZDrsH0nGly4RJzD
 saQlmH1Wl7x7Ytu5bTWNRjTJK2YiYFAQecjRoPCTxjvoh8WTy91CReqwH1jZTQS0yAuX
 ge3TX0Nwxk16n2AIvZ/2SmwFkkc10WPd4YmuajiyeZYC1oMShCO9Rs7YvUzmH/6R0x52
 C9mQ==
X-Gm-Message-State: AOJu0Yy4gz2bI4kaibfiNWK40J6d4i6Va7Kat0oWP2dSoq8EEnkFONY5
 UcHAf+qYoDwkNt/LHE7nkX3L9RgqCjWX3wAGshzYQ5lpcWKRrMaF1jO65aJwPrSTRYymcTLRQ9e
 IfSwMyarPEA==
X-Gm-Gg: AY/fxX6bk2SUYdvg9FJRBComputmzFVGW9bb1X9t20cYyE4Ks9ebcgQ0SWcMDPdEwL6
 S14P70trebjEvteORkkVmE28tf2FuTKQOd0foiO404oAAEhfKL0VzWNKZ6v+AfDvr8ap9JW+3qd
 Jo3sp8iDTThp9RRFsMA2XDmpXnai4fvTjAuVmgyolaX5qdl0E3iBOd6O/0ISHho3yPlDAOeRqXQ
 e32msyb5Pdzg+FBmO9S7GioSolwQvJEsc8O7+159yAltj6PYVOo0+686tyjIzJGhOI0x+tr9+7p
 9KhqQ/VMfnha6DNTbJSVMNb9IqcQz10uVedYcoksryFBkrrd6rnXMfsEFfX7i+bGPLueyvtWMKI
 9c2XlScpDA88qvJCGHIeP79B5HL2SaTyvyOfoR0zRcZdwc/ZQB+1ZVa1Z5Ug7cmGNKLVWr88WHu
 HHzLwdQRfdqwQzZRXHMQ==
X-Received: by 2002:a17:902:da82:b0:297:f09a:51cd with SMTP id
 d9443c01a7336-2a7188a590emr14079875ad.14.1768534775507; 
 Thu, 15 Jan 2026 19:39:35 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ca9d5sm6527975ad.25.2026.01.15.19.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:39:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 52/58] target/s390x: Simplify atomicity check in do_csst
Date: Fri, 16 Jan 2026 14:32:58 +1100
Message-ID: <20260116033305.51162-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
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

We should have used MO_{32,64} from the start, rather than
raw integer constants.  However, now that the CONFIG_ATOMIC64
test has been removed, we can remove the 'max' variable and
simplify the two blocks.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/mem_helper.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 0b8b6d3bbb..2a79a789f6 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -1813,13 +1813,10 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
      * restart early if we can't support either operation that is supposed
      * to be atomic.
      */
-    if (parallel) {
-        uint32_t max = 2;
-        max = 3;
-        if ((HAVE_CMPXCHG128 ? 0 : fc + 2 > max) ||
-            (HAVE_ATOMIC128_RW ? 0 : sc > max)) {
-            cpu_loop_exit_atomic(env_cpu(env), ra);
-        }
+    if (parallel &&
+        ((!HAVE_CMPXCHG128 && fc + 2 > MO_64) ||
+         (!HAVE_ATOMIC128_RW && sc > MO_64))) {
+        cpu_loop_exit_atomic(env_cpu(env), ra);
     }
 
     /*
-- 
2.43.0


