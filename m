Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6ACDF4BB7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 19:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuy8b-0002nj-F6; Tue, 24 Feb 2026 14:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuy7b-0001sZ-CU
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:31:09 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuy7U-0000pA-Lx
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:31:02 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-483bd7354efso4195155e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771961452; x=1772566252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g2xKkJpEboPawLV+v3FvCyWeGhL4Wa6PCRD9MvOpmIE=;
 b=wMTkAKblyz59mxDWTn14kqMdOfanzI1WbeGzPExnqAaf2TReEPRlc9tpG/yoiPYyGZ
 UERsUW8kqbdZqvHV8X6LcIWJp5SN0Of6kF5Eyrl4B38b44BVHuUeAwWBNC3aETdoelnz
 KEfOzlUAAnrSxi9pw1lgHGV1yN8QLHfS0mkLTWVyH0V5ybV3APiLMCofQJC87WtipCUc
 pVXERt08r0amMUHFZZFp98pgHdPx4CntdijjRtoPjF6ykTNmRoZGQIFOz7YGC5k2C/v6
 z/8SICR7tQgC3QKqM221cIZZC9j2i7vEkRWOomDwY9FwwbsPgbZMNW5tY321pppjWdZm
 B9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771961452; x=1772566252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g2xKkJpEboPawLV+v3FvCyWeGhL4Wa6PCRD9MvOpmIE=;
 b=JFKzUbV1H3yfVyCu+avTYieGP2MSRCjl3kmk+zrTHGxVO7ED9ZvBHJUy+1DQseAhwj
 hyGuT+lfxV5zVNn13i4k+EPomhRV9PeHERMsbE0RYU31CvPkd75BS8nov83A6hrkRjK2
 SHb3y5TXnaN4nEnqcD8m9w+aaKGHUvhAh8XUQkSH+l/9SoWmnYF5vEvepKQgYguDigkW
 +d2qluAu4E+n98lqfdfpF2Vr4i+sjledktZNRthdjwtOEELZh/EP194qe0gHv8wwhCci
 z5efjLV+OOdYGAr0dwGGlm7FkYa2HUzRRa2sGUvp45Ytn6FQBuWtuf+tUdztgSFS3z+P
 LlFQ==
X-Gm-Message-State: AOJu0YzS3NDTJWRxZjMF7eZ+SVWP9kxeY/20fyeoxLrdamh7iq+/unEq
 OWmwu8unG/fZr68sBFPlzhDbPrqWnkrg+9E1DVH95OnpPWt7pMQQMxQW79boBDsjWaF1QKzvdsQ
 bpIDzxvg=
X-Gm-Gg: AZuq6aJyxuBoMSYm0lqOewvW/QqsaPxyBM6cQLpEVNQVpY43uawMBBD/bW/5Jdu+5+n
 GFyxrcJEb8RvqQBVZ1YdGg6QjcDmqqy8LMM6GdkYRO9MYS9nXnoE07McTmhAoY9gbTuua2C0NSo
 azKHTgFTurdVlsY2Qq0yfgPQjmEZWhxEf5x155CK/GbEZoBFt0JiRoYopKSO3XDREvP6FUMs7Zm
 ZvVlLltOFBjfTTXjtprgqPPn9py97xBI8GvcHXhaIc2A3BXr29I2wk6Jt0alT8i1/PDEunRJz5t
 VKAxwL7Mjiy/Sy8g10KJ7uuoG8E/UKMUFy+LvH2BOEnoVWE1SmS3i160w39Bpm+3s2FveTMaOHG
 BU1BEe2mJYYpuIYsK+E2Oqjt1s18IIbvljgw0VL1UNILaYmQFmP1fMa71Oobp613zg6DQz70g6i
 2bfymMLiRYu09txrVh0yi1WH5TGoTKjVepeCoojSy4KIml7nFPH633Q4qFgU6pM6p4GIGnUD0JG
 8g8j8k6z2o=
X-Received: by 2002:a05:600c:c4ac:b0:477:a219:cdb7 with SMTP id
 5b1f17b1804b1-483a95a3822mr226754315e9.0.1771961452425; 
 Tue, 24 Feb 2026 11:30:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43986aa2f84sm6184578f8f.7.2026.02.24.11.30.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 11:30:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [RFC PATCH 3/5] target/tcg: Rename unaligned_access() helpers
Date: Tue, 24 Feb 2026 20:30:25 +0100
Message-ID: <20260224193028.2370-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224193028.2370-1-philmd@linaro.org>
References: <20260224193028.2370-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

In order to avoid symbol name clash when building
a single binary, rename TCG helpers prefixing with
the target name.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/helper-a64-defs.h | 2 +-
 target/microblaze/helper.h       | 2 +-
 target/arm/tcg/helper-a64.c      | 4 ++--
 target/arm/tcg/translate-a64.c   | 4 ++--
 target/microblaze/helper.c       | 2 +-
 target/microblaze/translate.c    | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index b6008b5a3ac..b329d7eb6a6 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -113,7 +113,7 @@ DEF_HELPER_FLAGS_2(ldgm, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_3(stgm, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(stzgm_tags, TCG_CALL_NO_WG, void, env, i64, i64)
 
-DEF_HELPER_FLAGS_4(unaligned_access, TCG_CALL_NO_WG,
+DEF_HELPER_FLAGS_4(arm_unaligned_access, TCG_CALL_NO_WG,
                    noreturn, env, i64, i32, i32)
 
 DEF_HELPER_3(setp, void, env, i32, i32)
diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 01eba592b26..1429c1727ef 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -27,7 +27,7 @@ DEF_HELPER_FLAGS_3(put, TCG_CALL_NO_RWG, void, i32, i32, i32)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_FLAGS_3(mmu_read, TCG_CALL_NO_RWG, i32, env, i32, i32)
 DEF_HELPER_FLAGS_4(mmu_write, TCG_CALL_NO_RWG, void, env, i32, i32, i32)
-DEF_HELPER_FLAGS_2(unaligned_access, TCG_CALL_NO_WG, noreturn, env, i64)
+DEF_HELPER_FLAGS_2(microblaze_unaligned_access, TCG_CALL_NO_WG, noreturn, env, i64)
 DEF_HELPER_FLAGS_2(lbuea, TCG_CALL_NO_WG, i32, env, i64)
 DEF_HELPER_FLAGS_2(lhuea_be, TCG_CALL_NO_WG, i32, env, i64)
 DEF_HELPER_FLAGS_2(lhuea_le, TCG_CALL_NO_WG, i32, env, i64)
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 2dec587d386..f824c662a3a 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -835,8 +835,8 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
     clear_helper_retaddr();
 }
 
-void HELPER(unaligned_access)(CPUARMState *env, uint64_t addr,
-                              uint32_t access_type, uint32_t mmu_idx)
+void HELPER(arm_unaligned_access)(CPUARMState *env, uint64_t addr,
+                                  uint32_t access_type, uint32_t mmu_idx)
 {
     arm_cpu_do_unaligned_access(env_cpu(env), addr, access_type,
                                 mmu_idx, GETPC());
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5d261a5e32b..c17ddf9e70e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -381,8 +381,8 @@ static void check_lse2_align(DisasContext *s, int rn, int imm,
 
     type = is_write ? MMU_DATA_STORE : MMU_DATA_LOAD,
     mmu_idx = get_mem_index(s);
-    gen_helper_unaligned_access(tcg_env, addr, tcg_constant_i32(type),
-                                tcg_constant_i32(mmu_idx));
+    gen_helper_arm_unaligned_access(tcg_env, addr, tcg_constant_i32(type),
+                                    tcg_constant_i32(mmu_idx));
 
     gen_set_label(over_label);
 
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index a1857b72172..24a9b50183d 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -69,7 +69,7 @@ void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 
 #ifndef CONFIG_USER_ONLY
 
-void HELPER(unaligned_access)(CPUMBState *env, uint64_t addr)
+void HELPER(microblaze_unaligned_access)(CPUMBState *env, uint64_t addr)
 {
     mb_unaligned_access_internal(env_cpu(env), addr, GETPC());
 }
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 2af67beecec..8b896abf0e5 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -689,7 +689,7 @@ static void gen_alignment_check_ea(DisasContext *dc, TCGv_i64 ea, int rb,
         record_unaligned_ess(dc, rd, size, store);
 
         tcg_gen_brcondi_i64(TCG_COND_TSTEQ, ea, (1 << size) - 1, over);
-        gen_helper_unaligned_access(tcg_env, ea);
+        gen_helper_microblaze_unaligned_access(tcg_env, ea);
         gen_set_label(over);
     }
 }
-- 
2.52.0


