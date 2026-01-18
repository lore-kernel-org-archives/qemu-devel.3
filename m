Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7F1C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhaxd-0000oC-Mk; Sun, 18 Jan 2026 17:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxT-0000EN-3r
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:19 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxR-0001dT-NG
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:18 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0c09bb78cso27711075ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768774156; x=1769378956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3agDLlzr0Vtwe03Q0XoUK7yGFQ6c06YyHNp7mf4+w4w=;
 b=pBxiu2TyGqVMslBxChp7GSqvuS0pJFUFzWaoclxkG1Bi3LFZqgBLwv+ySwUaD3ggyO
 jsnd/dWFjxsuFLQOAu/ZuHqr5djEQjf41NORelDZfz/JwZ6OmE/wS0/iuSHehU2h2dCY
 i8KJsLGE53LAaEE0cytRyqR/eN/rU3UvYQXEcEsoquh9PY1L4UPZoGFYh2BnC6byvtkZ
 a7g/l+05PL02QHqj/kYZXPccWCPWDqSIWaOo9hxzxqpWLlypVnPFBHQH6gpWKrkmuv2j
 CRH1PLkK+BqjW8uW8EYD9+fiTLZ3KhQ6dus9JPq4cGuA4gEZ991ha3Eixznw8E4NTnR3
 N+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768774156; x=1769378956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3agDLlzr0Vtwe03Q0XoUK7yGFQ6c06YyHNp7mf4+w4w=;
 b=ob+zzdjVLtxB0WBFx1jbLK16v8l0Uaa/5jDZvpJCxrVrV6kOHzcC1dlS4N6SjqM1FS
 RTWlmlHw2yVyAAp4vfaozQJ6ZQvctccNgvs8oPrdLMP4C43BK3sja+k/RC8QejeKYwTU
 5c75Xr41R/Mpot8vYC77rqlit3b/u7zzNFKJf5T107pTgDEROAYEBpc/eYYO2FsIiCLI
 t8woajEhbc5iQ8Y9w4GG7enusVVIlOEhY9hQAQXVqWtZLre8skSn2BYkO4PS7KBINY2Y
 xJbxNfG0vuyIQKY28dwk2or9P2IywuBi1aNuN6lVT93+K+aBd2YomKY5d8IuEF9Rd2un
 yXVQ==
X-Gm-Message-State: AOJu0YyF22uSs7PYxJXAUCw1zDRJF9tNs35U51/UxvReWGenfDNBoepX
 6KfIDhmnWEDda11b9OlgcrsW/pYDH6h8jfEZ3tJ/1nRwvB2xOiLLykEzY9ZmwGGYyRVc00hG06S
 dWZimFTHkJg==
X-Gm-Gg: AY/fxX4QlrrszFBUWToJn3iKaW2UAB5wwUs8TEUKIeeEePn2UT4ISjS7N6Wptkfafur
 YdHpOy/ckYXNU3YcRqqHkhBV5+ddg/d5acSIdFI9B0vOqT1z1nD5THEkvn4RbPymCKGI/WgahTh
 AZ15gMLVcfH76sRQB4Y9W2tESTEMFtX8J3MKpSrUo0NU1wBXv8j6syDjNEHd9XZrkaY/32AmG6D
 YaRoNBieiBcwNxeWhTDaLfDT3zeo7EfYZI5eQt8fEs19k70zC1RyhoK+cNAkpDNDxg+/M/gMMNK
 JRr1SGmpl6+7uwU44G0i2exM2UpJOwg/K4Ke/xs7lGq/LNcQwWNA/mpqRC5GhJljvR3HOHm73r+
 qKnumcSAeEyr/NUgManggb1iZa0Xg/B3VS+Dn6G6Bk7UvIbJBGDMTD+LcIMYuJnYbxPlYS3Lb8y
 as9bhkCa+VF9ZJn5kXcg==
X-Received: by 2002:a17:902:f650:b0:2a3:ccfc:4de5 with SMTP id
 d9443c01a7336-2a700978f8bmr133427955ad.5.1768774156272; 
 Sun, 18 Jan 2026 14:09:16 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ab921sm73298205ad.8.2026.01.18.14.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:09:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 48/54] target/s390x: Simplify atomicity check in do_csst
Date: Mon, 19 Jan 2026 09:04:08 +1100
Message-ID: <20260118220414.8177-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


