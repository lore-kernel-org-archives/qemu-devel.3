Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54850CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf3Y-0007A7-Lk; Wed, 20 May 2026 07:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf2I-0004s4-P9
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:24:26 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf2D-00037f-RP
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:24:26 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-67179ed133dso5726211a12.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276260; x=1779881060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRLKVH14QDYQaVrfjU+onWCMIThdi8GoEYRTGd4kc9Y=;
 b=rSkYb2IxDsGBekQLtCcA3MQbAc62kKbVZ2j3Fofqxee3sa1gh4XBPO5MNQ01qLDCdU
 +bxme46stSoU0LjAcV7vBi2eJByrpp1iOvC1PiWXDnogs8fQpTNzwbX3CHoDPCl0N065
 zpo71jmWrY6yU4E3tUnUDKXAg9KrejvSLLzvvVmgL8LkerxPOD4tl3mUjEJyfk8L9r1L
 GD1x5r3JO3wU2SfQ+9DI35DaPg0CiNpOSBmlarkQ+m1HJXmyIpMW8nmT+bQRVMfreJs4
 Oz1KFola8GFWvuQiL+X4QswVtTR8sRah7B6QJU2mI4aBvr7Y5LoF6DDNQCfQtFyof4VB
 GEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276260; x=1779881060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LRLKVH14QDYQaVrfjU+onWCMIThdi8GoEYRTGd4kc9Y=;
 b=HK26BVrCsTf0xVwGo4Pze2lRNuW12MIuIA4OxRC+ImnW9n8DXw6ElAjzczNwtVre7R
 w8CX5HKz5vWiUa0qmSAqIn9R/9NRV3k9iJFdYbTWet8/TzIIm51ohr1BzdAjZccQNiC1
 nGVfJgYP5iPbgUOQI8h0jIb26x6nS9TQfs7tnbnfIrJr2Qp+hkwzM/lBoYgpAyuI9uwz
 qLiryNP2BKYAqX8UPQQJia2MmnxyrQkKL6GowwYFTa7z5XzdIe1QS7Ihg38V9I7jqrvB
 MH40zsX4koMpMscAyfQ7HdxvVjrIkuYYUxTJQWAmOkgubxZe/+7KGoxFGMKCePjGD7Jp
 tKzw==
X-Gm-Message-State: AOJu0Yxa1rRnL7RjbhIPLIfKnTMnaM6METfHJkQXH4LGSaUIk0QYdClI
 1nboawFM8Tnp1lVjN+OQ1gk1QDBNCu6vPFajBatRgwbkOR5MqcTvIp2u8WW6N5MMX5Qgiy8P1E/
 8gQzTDBw=
X-Gm-Gg: Acq92OEtQchFeW+gUdh6X9ecOFE20stMw1WP6vWnIOmC/z6bGwSDhn2euxbwj0M8uUL
 nJTA6DzNuuY+tyuqnz52yJ8wY9NAnBPvWV/1Lv1JGNgQ39cB2NZyKz/IH441pNwGGQlFC+NmI5F
 L0wxwblUaHnvrmKQDRxl0bK4Q5aC1ONkOM11KInZ+tJUYiwaJdeLK6A0ihXspNA79EUfXx4xKkC
 +8S1ec9utto1rrVmwHDudhrIo7O9rgbbAxPhcB62NwgXHnhCwp2A22mZurHrWsw7osFKZ0F3Wbz
 a/TwXJMdsXYVojreoUcPdmRJYjxBy3liTpKUwWQK5t/AWawERY/z+TGptUgynlkiXSEF/o9qEDU
 ZvxOHxq7J2HBMEN4bT/tOCxmBAbip/+BkszVcwxLL3NQIz9osHXHjNZS9CtuIskxLhDSgwcSf2A
 g9WbdlqTBE3XMhiGlYY1BUuJNH15o7DBS8qdRHOxE9VN3kfFf4Sotdw9k8CTcr5/CaHiJU7hnC2
 rVPJ1tyrFxqaorN
X-Received: by 2002:a05:6000:240b:b0:43c:f1a5:56f6 with SMTP id
 ffacd0b85a97d-45e5c5a8dc8mr38797178f8f.43.1779272342831; 
 Wed, 20 May 2026 03:19:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm53728771f8f.36.2026.05.20.03.19.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:19:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 07/24] target/mips: drop Octeon zero-register fast paths
Date: Wed, 20 May 2026 12:17:48 +0200
Message-ID: <20260520101807.9971-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

EXTS, CINS, and POP route their destination writes through
gen_store_gpr(), which already discards writes to $zero. Remove the
remaining translator fast paths for destination $zero so these Octeon
instructions follow the same shape as BADDU/DMUL and the generic MIPS
translator helpers.

Add a mips64/mips64el linux-user TCG smoke test for representative
Octeon population count instruction paths.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon_translate.c            | 15 ---------------
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 4dd76268350..b7531653e58 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -74,11 +74,6 @@ static bool trans_EXTS(DisasContext *ctx, arg_EXTS *a)
 {
     TCGv_i64 t0;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     tcg_gen_sextract_i64(t0, t0, a->p, a->lenm1 + 1);
@@ -90,11 +85,6 @@ static bool trans_CINS(DisasContext *ctx, arg_CINS *a)
 {
     TCGv_i64 t0;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     tcg_gen_deposit_z_i64(t0, t0, a->p, a->lenm1 + 1);
@@ -106,11 +96,6 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
 {
     TCGv_i64 t0;
 
-    if (a->rd == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     if (!a->dw) {
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index b7610db812e..f406726fc11 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -39,10 +39,26 @@ static uint64_t octeon_dmul(uint64_t rs, uint64_t rt)
     return rd;
 }
 
+static uint64_t octeon_dpop(uint64_t rs)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        ".word 0x7100502d\n\t" /* dpop $10, $8 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs)
+        : "$8", "$10");
+
+    return rd;
+}
+
 int main(void)
 {
     assert(octeon_baddu(0x123, 0x0f0) == 0x13);
     assert(octeon_dmul(0x12345678, 0x10) == 0x123456780);
+    assert(octeon_dpop(0xf0f0f0f0f0f0f0f0ULL) == 32);
 
     return 0;
 }
-- 
2.53.0


