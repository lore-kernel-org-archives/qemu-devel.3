Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C272FD45FB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO97-0004BP-Jg; Wed, 25 Feb 2026 18:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO8m-0003hg-TQ
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:18:04 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO8k-00039j-4Y
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:18:00 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48375f10628so1979515e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061476; x=1772666276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7d1eFFQbEOclqX67uZYYSXzl6X/j5CbETWLmC2Ltn6I=;
 b=r2dRMEymnpG3SqWLxDJFKaHyF8EBlKjj/Nun5i16+thXG3uST0+MW5q/x5knVvLYjF
 OWQ2D7V+EfPkKlhfGGbge3W6lpGPEGW10kVhvMZFjbL/1SB6F4tcWUL4llVF1Vin40r5
 zGLX8QPYr1/gm+GPLbteBw2tEu8bAQbt9Q2CVH6xERhWPJjnvTz3k06yhRj19BfbMkdm
 ceKXogXY6FvwgPSez9pBlYigRpvgtTbjdIxRd+hQH+w9QooiXYa+RP8BWA6ymqjqhxOW
 c9xhmzFI1tFenXnldmr1Nr+BO4Pg6ik7BOIIwu7C0JrkdBluCMCtZjw5V1MY/202Ftoq
 6DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061476; x=1772666276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7d1eFFQbEOclqX67uZYYSXzl6X/j5CbETWLmC2Ltn6I=;
 b=S2pUSn0DPUnEdiK3oq1DAGBTCb0jZSH/0LhEKt/Tex7RJLBDuo4jnSp9gdpgWSDeWh
 8cqaMCkt7B/1/0jywxYV/QLJrzox5M0NPMZPQNuJ7QkyCj7MhkO5KbCZFRZ+uGlpH3FQ
 SOo+9JE4aF2R6PilS5Hv1ubP5Qdemtaj9VP2ZoYvfzHEMlgygA56gI+vurgpLJK6psmb
 8dY10Dz642uwUWtkwRwZ1ljniC6Hku7koNOHARJLcsAN9Xles4PFVPC50hzdB9MwowEw
 ampK8rN+CQ96kUKw83vsynCk2Ckk5FlE5m4qXDiruIShUDZifL0ucoNihM3QprFQTJtc
 ozvA==
X-Gm-Message-State: AOJu0YzcJ7vMmiu5Emr/Hf8+/1oqeafZx9eF6L21tsC7g4Y8c/8eGT6q
 4ktCzx+PIKjP8K2HKqEfbv0OE8F/xZ1WJ8HGMl0tC8WOKhpNIEKSAt0egHyD0FmNs7TjLL3fvO/
 hc2y++to=
X-Gm-Gg: ATEYQzx2+tP+CFOdTrcmkEn3akzASgtGXS/LO6hUYAQNd1y0RT/LBkwPdGM8nvDdl5c
 S738wL9S8rcGENhjrnIMMBU+UDX63KrFuqSQDAAejjUsI4AtzUOUIrEyAY+UmOu8d7PPpStwwCS
 0lKcSRafQO5h9FLlkfcruNEthb+3c0J3/fA1wp/IpKwcWbqjWAoQ6L7C+pINDQIQcMTqp48ZgfI
 W02wmzZDMEnvm4U5GpE2Sdyvu1XQt9mf/TUWSkkOaDDy0TJ/KD7i7ZhYfN/UqNoTzNB3vioQlp2
 zuyLsp57CFpD8sizPqM+iYxr2syy/gj58jpzjHLcgUTqB+QJfC5CD8rRMnce8EZwmR6N4OWc7th
 bxAP/sZ/EkusuvjUi5+TUiWJizIRYMx7XBWliyA0VL/dZv83aVuVvtwsfh4zINV9IcUw85Ym5MM
 ZYCw6QxBNUijMUUJs1UVr+3Bltrp6KrY8PDIRQJukYLkMs4RB3XnzZSp6oqGtUTp67BH5HRAGk
X-Received: by 2002:a05:600c:4e8e:b0:47f:f952:d207 with SMTP id
 5b1f17b1804b1-483a95e251fmr274592245e9.19.1772061475786; 
 Wed, 25 Feb 2026 15:17:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43995056115sm2974279f8f.14.2026.02.25.15.17.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:17:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/70] target/ppc: Replace ldtul_p() -> ldn_p()
Date: Thu, 26 Feb 2026 00:13:33 +0100
Message-ID: <20260225231411.96482-34-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Prefer ldn_p(target_long_bits/8) over target-specific ldtul_p().

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-26-philmd@linaro.org>
---
 target/ppc/gdbstub.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index ece1e5c9bd7..e0aae9c9eaf 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -23,12 +23,12 @@
 #include "gdbstub/helpers.h"
 #include "internal.h"
 
-static int ppc_gdb_register_len(int n)
+static unsigned ppc_gdb_register_len(int n)
 {
     switch (n) {
     case 0 ... 31:
         /* gprs */
-        return sizeof(target_ulong);
+        return target_long_bits() / 8;
     case 66:
         /* cr */
     case 69:
@@ -42,7 +42,7 @@ static int ppc_gdb_register_len(int n)
         /* lr */
     case 68:
         /* ctr */
-        return sizeof(target_ulong);
+        return target_long_bits() / 8;
     default:
         return 0;
     }
@@ -85,7 +85,7 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
 {
     CPUPPCState *env = cpu_env(cs);
     uint8_t *mem_buf;
-    int r = ppc_gdb_register_len(n);
+    unsigned r = ppc_gdb_register_len(n);
 
     if (!r) {
         return r;
@@ -127,7 +127,7 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
 int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUPPCState *env = cpu_env(cs);
-    int r = ppc_gdb_register_len(n);
+    unsigned r = ppc_gdb_register_len(n);
 
     if (!r) {
         return r;
@@ -135,17 +135,17 @@ int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     ppc_maybe_bswap_register(env, mem_buf, r);
     if (n < 32) {
         /* gprs */
-        env->gpr[n] = ldtul_p(mem_buf);
+        env->gpr[n] = ldn_p(mem_buf, r);
     } else if (n < 64) {
         /* fprs */
         *cpu_fpr_ptr(env, n - 32) = ldq_p(mem_buf);
     } else {
         switch (n) {
         case 64:
-            env->nip = ldtul_p(mem_buf);
+            env->nip = ldn_p(mem_buf, r);
             break;
         case 65:
-            ppc_store_msr(env, ldtul_p(mem_buf));
+            ppc_store_msr(env, ldn_p(mem_buf, r));
             break;
         case 66:
             {
@@ -154,17 +154,17 @@ int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
                 break;
             }
         case 67:
-            env->lr = ldtul_p(mem_buf);
+            env->lr = ldn_p(mem_buf, r);
             break;
         case 68:
-            env->ctr = ldtul_p(mem_buf);
+            env->ctr = ldn_p(mem_buf, r);
             break;
         case 69:
             cpu_write_xer(env, ldl_p(mem_buf));
             break;
         case 70:
             /* fpscr */
-            ppc_store_fpscr(env, ldtul_p(mem_buf));
+            ppc_store_fpscr(env, ldn_p(mem_buf, r));
             break;
         }
     }
-- 
2.52.0


