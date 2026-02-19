Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28344E9A04F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9cw-0006uv-GD; Thu, 19 Feb 2026 14:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9ce-0005Y6-Jh
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:36 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9cc-0008VC-N7
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:23:36 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso9550955e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529013; x=1772133813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ORxZRk5GfpOpGN2karLQcvtsyotrG6XvafLw6XoTvc0=;
 b=IcwkkuTBphib60DwL8NMvlxJYaPwnmp1SjoxW5UL+wzm7AAqI4npRrlSR3KWN2vR7N
 sc0N7Anen7mcg6DZ5az/YfTA/gSzmXX5TpO5YcpJfaCylD04PwFsu/3AAE46PKCQQ5EY
 utEXTZax+/jZ3I1+EroD/ud7iekp9mKRQzBUcKaHcURANS1WwyAp5T6kTbzgc0ZJGO6N
 GoiYf4KnFon8O1qmM5c0nYesxli1vvXPlgfcWQODyMpA3riQIx2EBLhVwxE7J9wsQvUH
 ywhXAwTk0gCWiXIQ7aGAnZ47H+Lyk8/wXk1/oC1htZ8OENQHmL6WcGxioD/OUzrgMa6J
 W3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529013; x=1772133813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ORxZRk5GfpOpGN2karLQcvtsyotrG6XvafLw6XoTvc0=;
 b=o1KKYfmNQWkQgQEf6T0hpgmdtOHke6nGeaCL1tbrvuezZobBE9XNKG8iSS/3FGPa8v
 V7kyoCXAu9AUfzEzqwuocRkEiGMCfdClfhz1Ompn22eTj1ct0YvAviBA959Ljn1/hyPV
 b32nNh6d6OfXfmD5/9DUjYeM0cSUDDypNskiityPaghtmrAjqxLmEa5Vc9lTbqvfQtw/
 +53z6NDp6VcDbY8uHlW/KMMWeXo0eUc7ImOaUCVC2gDhR5IebEkYjqjC47bPow/ZG91S
 OhbErwaCdJT+SNT3hxFjc4MfV7NEQux1vfwSN7K0/ydksj4pXKwAi/P5u1X+WvvuIZ8M
 Vjuw==
X-Gm-Message-State: AOJu0YwtTTwcAjbR50Ru5jzrF/nOA0kparKSqZLFBq/NzEXJNmnSDpKc
 Y4JRvfRGbFDqREzHe/S3iJTu6LklD2EiYFRMx+K+FabUw46QZgOHzzUYLaHtIhF7fuuz+Qoz9eE
 1MirvNL87gw==
X-Gm-Gg: AZuq6aKrF67cw288mIiPRss4l09jmOpuBIwim3Kf3XO81G5Xw+SRnw05ohCPhE7MmNA
 V7d/Djt2kg14QnASw6ItWjOf1XO8BWvwZH7JrPilQO6/R5uof3RPTH8jNq2k9RJxw1gjbip7lwg
 rZ6sJGs+Mc1+WdAuU1c50GjKue2u4SB4Fi5sCwEGX7ALQNmA4o4Y2yUh7urhwCuWITDDa05/7zb
 UZbcN02GWAMhIVU4Hr5VnKa7pezrLyQTdSHL685jxSaB3p4t4XYegEOYnhfSyc3IDphihfWTUri
 CVxU0+H3Xiwp7jrnse14+XR6F17INvqJxRtvRoxRjdzB0QvRJAL7kChKaYpmYWosvzQF84xe31m
 I+W2ajbm/jjBYKtoBpXyExJxcobou8+dbVnuBVXXuENmEbkK1UkCBCJNsl4dOH61mY1PenwtCVE
 ec3kkQcanl3dsydNvGlX8dcfeC5wK4/RZcm1/PHsHYyRKP+PrJaU9huKRNxNUCdTGHZjuBY/N8
X-Received: by 2002:a05:6000:2dca:b0:436:1a23:3949 with SMTP id
 ffacd0b85a97d-43958df369dmr14018313f8f.10.1771529012724; 
 Thu, 19 Feb 2026 11:23:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8209sm51744567f8f.30.2026.02.19.11.23.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:23:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 30/50] target/i386: Expand 64-bit definitions when
 TARGET_LONG_BITS == 64
Date: Thu, 19 Feb 2026 20:19:32 +0100
Message-ID: <20260219191955.83815-31-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Where both gdb_read/write_register() functions check for
'TARGET_LONG_BITS == 64' we can expand the following definitions:

  ldtul_p() -> ldq_p()

  gdb_get_regl() -> gdb_get_reg64()

Do the same in i386_cpu_gdb_get_egprs(): check TARGET_LONG_BITS to
effectively inline gdb_get_regl().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/gdbstub.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index f358bcf9e86..f1ce90a046e 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -129,7 +129,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
                 return gdb_get_reg64(mem_buf,
                                      env->regs[gpr_map[n]] & 0xffffffffUL);
             } else {
-                return gdb_get_regl(mem_buf, 0);
+                return gdb_get_reg64(mem_buf, 0);
             }
         } else {
             return gdb_get_reg32(mem_buf, env->regs[gpr_map32[n]]);
@@ -283,9 +283,9 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     if (n < CPU_NB_REGS) {
         if (TARGET_LONG_BITS == 64) {
             if (env->hflags & HF_CS64_MASK) {
-                env->regs[gpr_map[n]] = ldtul_p(mem_buf);
+                env->regs[gpr_map[n]] = ldq_p(mem_buf);
             } else if (n < CPU_NB_REGS32) {
-                env->regs[gpr_map[n]] = ldtul_p(mem_buf) & 0xffffffffUL;
+                env->regs[gpr_map[n]] = ldq_p(mem_buf) & 0xffffffffUL;
             }
             return sizeof(target_ulong);
         } else if (n < CPU_NB_REGS32) {
@@ -449,8 +449,10 @@ static int i386_cpu_gdb_get_egprs(CPUState *cs, GByteArray *mem_buf, int n)
         /* EGPRs can be only directly accessible in 64-bit mode. */
         if (env->hflags & HF_CS64_MASK) {
             return gdb_get_reg64(mem_buf, env->regs[gpr_map[n + CPU_NB_REGS]]);
+        } else if (TARGET_LONG_BITS == 64) {
+            return gdb_get_reg64(mem_buf, 0);
         } else {
-            return gdb_get_regl(mem_buf, 0);
+            return gdb_get_reg32(mem_buf, 0);
         }
     }
 
-- 
2.52.0


