Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0603ECD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmYD-0001YR-Ss; Wed, 20 May 2026 15:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmXl-0001GH-DQ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:25:35 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmXj-0002G0-7H
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:25:24 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso55013525e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305121; x=1779909921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UV1UK52bSabfrT6zByPj5m8iMxPKxH4NciG4IFW+suo=;
 b=vjAkFIBeT7iNSo/w7MQEg564pcApsPH6nXgJMzw/S/6KDVgaXis2Hci4HRcnRCUJbR
 gfLrxGeJGDZBeZvAYsmnVjzhDHyCIeWtdjf9A1d1NTCW6TYxFho2QHxDfdtUd4Q3cgpf
 3zawSOORtsFnroLxgX2zg11hWiEcWfKmWfKFzatLjvelw7GpnREA7m/vIorB+P/5LYvn
 Ex7UEMCeN098vNNEi/+uQaIKSZpEcVDm4iJrE/gsHCwT3zPEKq2A6Uow2pDWaYhbbXxF
 4yJN4bJbppicgoL1QSo8kdEqC1gMeVJypz9g7rQBHkk/S7Ua97PkZwiUsJPZe9EbqwBb
 fRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305121; x=1779909921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UV1UK52bSabfrT6zByPj5m8iMxPKxH4NciG4IFW+suo=;
 b=U2AbuCVn8dTgSBJ8FPsvUbbcvP/wVYaosHivo6XLoPKVVhu9mtPy6U5I6HeTgXy73k
 TzJ3ZW9XVyQsyqyBWxcBfI9xApaxb6gColq3NJOskMRN3vOqEmeWFeI4YGfEjzUMg6nN
 O5eM4xGN1VFaQdIILrpphV7fOhldrGR1LwR+oLsZcGkmtLP8KsKI5Ds+XfZsxY6m/DS5
 D7r2dnUyx4UKGVYDXsa8X5BvdZlYiTg3Lpjcjhd3ioR4OVeQDpBodV9tL01XbtEmQoVS
 a4CnRIuJGWh4BX7nA3q7/Tn39tt5gBwrl3URktj+FPZHyAfKS4bceGxhUhSGycsubE/8
 +kFw==
X-Gm-Message-State: AOJu0YwPRis2d4KpFtda3WdT77wpXCBYCqAKiKZRMZcmuI62nl8udLF8
 CAZ7DrDM6sH6yNcSiqXjtEQ/Rfw/xekpiwvb2ZM5KSFODKOKxt9GZw7acYJWGsiVdgiCLBWUVZ9
 tkF/tfSc=
X-Gm-Gg: Acq92OHrfIuFFlHC8c24sPZWmWREwgh9ZgjDNRtUKcjggndlHlX9rj+fO0Nc2oWHCgA
 fUHKTo8ZAYFG9d5DPy4TuPHaVw9x51x/hf2Ns1HWEWTUsh5bTV7zNUNFwCobqIEw2n4ehR/8WoR
 iw15WfIEIwZhgJPDAcJHR56PtZNeO+0u+oZyJLcaBhpPBKjw+drxzcA1yGz+gIlTzFDb3mLEyAA
 26yVxpwZ92+qwKm/q/WqZzqY7O9ub0b0pgiUkGIMVTAlhEcbQkGE3j6aMde/JNzcacx60Mfcreo
 AgNd8iffd3B82SxhMSn5tn6FsejD1X7naWKc5uk/RDkjZyJCfW4J3qR2EyPTMIl5qZUMSs7sC50
 jFAgbiQ30iGmgo4uemTMT2hoIEQ5I00TiefY8fv/zRVjxzJ4624dIC2SKR6cHOrnYdZdpbDQIHu
 FguTeDD6P0KOU+/fCocnnkYJCpf9qvUl6AjWMo5PS7tEgrReAUQSao5Bhjh0PeDeBTtWrLdEtC
X-Received: by 2002:a05:600c:46ce:b0:48f:d2b5:d7 with SMTP id
 5b1f17b1804b1-48fe60edd2dmr373136285e9.12.1779305121532; 
 Wed, 20 May 2026 12:25:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d2fa88sm10442075e9.3.2026.05.20.12.25.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:25:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/33] target/mips: fix Octeon arithmetic destination handling
Date: Wed, 20 May 2026 21:23:19 +0200
Message-ID: <20260520192338.40036-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

BADDU and DMUL write their results to rd, not rt.  Route writes through
gen_store_gpr() so rd == $zero is handled consistently.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260520172313.23777-7-philmd@linaro.org>
---
 target/mips/tcg/octeon_translate.c            | 16 +++------
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 35 +++++++++++++++++++
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e1f52d444aa..4dd76268350 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -45,18 +45,14 @@ static bool trans_BADDU(DisasContext *ctx, arg_BADDU *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
     tcg_gen_add_i64(t0, t0, t1);
-    tcg_gen_andi_i64(cpu_gpr[a->rd], t0, 0xff);
+    tcg_gen_andi_i64(t0, t0, 0xff);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
@@ -64,17 +60,13 @@ static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
-    tcg_gen_mul_i64(cpu_gpr[a->rd], t0, t1);
+    tcg_gen_mul_i64(t0, t0, t1);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index aef23fb9465..b7610db812e 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -7,7 +7,42 @@
 #include <assert.h>
 #include <stdint.h>
 
+static uint64_t octeon_baddu(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095028\n\t" /* baddu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_dmul(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095003\n\t" /* dmul $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
 int main(void)
 {
+    assert(octeon_baddu(0x123, 0x0f0) == 0x13);
+    assert(octeon_dmul(0x12345678, 0x10) == 0x123456780);
+
     return 0;
 }
-- 
2.53.0


