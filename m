Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B127FC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 09:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYMp5-0004jv-Ke; Fri, 09 Feb 2024 04:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMp4-0004jH-ID
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:05:26 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMp2-0000bP-NR
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:05:26 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-511234430a4so1303664e87.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 01:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707469521; x=1708074321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vn0lO7fh5ll882XNM15OEQ4KxY9WL2Xh4xTztqJQO94=;
 b=edHILDCthMQV2VSbp0SUmQzo9ipQryiR9tvPK4nykDjX92fKKTY/ENrqgTV9uMu5e0
 gJdsv+xMGW75zvvvjQlY3Rlbrti6HbK2QVJbc0cjduBBsfpzMQq3EO/QftqR+z7H+BKS
 mZTfw8f226nOYERlEAqcvl8/HHEv0UEfTLKrTMnzO0bhxS6ZPpwwOjvKab00ahAHKa7E
 MpIFQpkNcj0ApC2RndBHLRiMg6BuzUuYDsC/S6srOYs6Mz5baNnQ0CUuLzQZa1k5/OS3
 3pewlBIdE9aj2sivbSkkvFSpPfMpG4eroPFc93Cr8weF+MB5nncKTkaf3eMy+4MWR8T3
 rhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707469522; x=1708074322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vn0lO7fh5ll882XNM15OEQ4KxY9WL2Xh4xTztqJQO94=;
 b=vD4RXka+me0dsKm/pLKzHNSjTOsumdVF0j28jCqOYnFvMH8kuzb+F8lGfMGqQ3Uc5o
 4ihFbZ8vFdqpoC9BsFrRsm/3BNuTrqrLJRYHqWLqcUjFOSGYuIb7gC/c/7Ze+kyj7Ji8
 0DNMu6/hzCP8KQY7mbAoGlfTALS/49AqbOhJwKGIWQE/VpKdgwa1uxOZmpKvBgaqt1jS
 7q6LWSC8HoP7cP4UKk1GuQ8CVAC9TptPSjkgWtrefSY/yxq7Y11W5G8hNf3X5IhY0NbA
 f9Ii2xT7lQvK2udbB3s2a4b3suuO/aIQ6XHtKXwEN6ZXkG9YjW5iy985W3MOHX74+mXE
 h2Lg==
X-Gm-Message-State: AOJu0YwBDkC+zFJdbaFYg/f9Rp0phDIaYURc8QjriY3ndCIO6T0qu+1I
 byJvEexXKHZq5vwUNLgZMrh+iOpRtW24ZcDU7fbhpYXZ7RBHMFjz36g7g2gGvEkcSnyVdx1FxR7
 +tHA=
X-Google-Smtp-Source: AGHT+IHfpR8bDZdf8dOKlXroWnk+/FyfYGwozUQMChkDj9mF+lVlf02p8DrNeLk1VSzvJKD0DGbSog==
X-Received: by 2002:a05:6512:2095:b0:511:5eec:9b9a with SMTP id
 t21-20020a056512209500b005115eec9b9amr589026lfr.52.1707469521630; 
 Fri, 09 Feb 2024 01:05:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWfVt9ioVBAQp7E/L5r8u8qvyBkurRg1WzvG2XfIAeb+MmOpkhZZPmuCFKsjjN0unzqv466T5ns3qrAjX0w2Y9tMhoGDlo/WjlWPUj9uU5F/Sha1/PaoJDEhLW4Mzy9SNOIj0ewnWwTz15/EfHAgajkfXRY9CFw8meQDyBj3/Qsi78y6QrstTb8Tc90kTXqdhSahiEm+fwim+1UQOIbW2LfGSAOY5usvcrDRV9vIG+FfunyOI3JbefWQ40fy9JpBT8y29GDjaoH0AH03MlbLcDVcUuE1/aLHm7rG0NVvCDXDtxxO5rkJqKONmgpr9OyxRXeDjEnHG2xo5DuZAgs5R8FXrxp1iQ=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a05600c46c900b004101e93d276sm1926229wmo.14.2024.02.09.01.05.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 01:05:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [RFC PATCH 01/11] target/mips: Remove helpers accessing SAAR registers
Date: Fri,  9 Feb 2024 10:05:02 +0100
Message-ID: <20240209090513.9401-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209090513.9401-1-philmd@linaro.org>
References: <20240209090513.9401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DisasContext::saar boolean is never set, so this code
is not reachable. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/sysemu_helper.h.inc |  5 ---
 target/mips/tcg/sysemu/cp0_helper.c | 55 -----------------------------
 target/mips/tcg/translate.c         | 42 ----------------------
 3 files changed, 102 deletions(-)

diff --git a/target/mips/tcg/sysemu_helper.h.inc b/target/mips/tcg/sysemu_helper.h.inc
index f163af1eac..78f7272208 100644
--- a/target/mips/tcg/sysemu_helper.h.inc
+++ b/target/mips/tcg/sysemu_helper.h.inc
@@ -31,8 +31,6 @@ DEF_HELPER_1(mftc0_tcschedule, tl, env)
 DEF_HELPER_1(mfc0_tcschefback, tl, env)
 DEF_HELPER_1(mftc0_tcschefback, tl, env)
 DEF_HELPER_1(mfc0_count, tl, env)
-DEF_HELPER_1(mfc0_saar, tl, env)
-DEF_HELPER_1(mfhc0_saar, tl, env)
 DEF_HELPER_1(mftc0_entryhi, tl, env)
 DEF_HELPER_1(mftc0_status, tl, env)
 DEF_HELPER_1(mftc0_cause, tl, env)
@@ -57,7 +55,6 @@ DEF_HELPER_1(dmfc0_lladdr, tl, env)
 DEF_HELPER_1(dmfc0_maar, tl, env)
 DEF_HELPER_2(dmfc0_watchlo, tl, env, i32)
 DEF_HELPER_2(dmfc0_watchhi, tl, env, i32)
-DEF_HELPER_1(dmfc0_saar, tl, env)
 #endif /* TARGET_MIPS64 */
 
 DEF_HELPER_2(mtc0_index, void, env, tl)
@@ -104,8 +101,6 @@ DEF_HELPER_2(mtc0_hwrena, void, env, tl)
 DEF_HELPER_2(mtc0_pwctl, void, env, tl)
 DEF_HELPER_2(mtc0_count, void, env, tl)
 DEF_HELPER_2(mtc0_saari, void, env, tl)
-DEF_HELPER_2(mtc0_saar, void, env, tl)
-DEF_HELPER_2(mthc0_saar, void, env, tl)
 DEF_HELPER_2(mtc0_entryhi, void, env, tl)
 DEF_HELPER_2(mttc0_entryhi, void, env, tl)
 DEF_HELPER_2(mtc0_compare, void, env, tl)
diff --git a/target/mips/tcg/sysemu/cp0_helper.c b/target/mips/tcg/sysemu/cp0_helper.c
index 62f6fb4bf6..f8883a3515 100644
--- a/target/mips/tcg/sysemu/cp0_helper.c
+++ b/target/mips/tcg/sysemu/cp0_helper.c
@@ -371,22 +371,6 @@ target_ulong helper_mfc0_count(CPUMIPSState *env)
     return (int32_t)cpu_mips_get_count(env);
 }
 
-target_ulong helper_mfc0_saar(CPUMIPSState *env)
-{
-    if ((env->CP0_SAARI & 0x3f) < 2) {
-        return (int32_t) env->CP0_SAAR[env->CP0_SAARI & 0x3f];
-    }
-    return 0;
-}
-
-target_ulong helper_mfhc0_saar(CPUMIPSState *env)
-{
-    if ((env->CP0_SAARI & 0x3f) < 2) {
-        return env->CP0_SAAR[env->CP0_SAARI & 0x3f] >> 32;
-    }
-    return 0;
-}
-
 target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
 {
     int other_tc = env->CP0_VPEControl & (0xff << CP0VPECo_TargTC);
@@ -514,13 +498,6 @@ target_ulong helper_dmfc0_watchhi(CPUMIPSState *env, uint32_t sel)
     return env->CP0_WatchHi[sel];
 }
 
-target_ulong helper_dmfc0_saar(CPUMIPSState *env)
-{
-    if ((env->CP0_SAARI & 0x3f) < 2) {
-        return env->CP0_SAAR[env->CP0_SAARI & 0x3f];
-    }
-    return 0;
-}
 #endif /* TARGET_MIPS64 */
 
 void helper_mtc0_index(CPUMIPSState *env, target_ulong arg1)
@@ -1108,38 +1085,6 @@ void helper_mtc0_saari(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void helper_mtc0_saar(CPUMIPSState *env, target_ulong arg1)
-{
-    uint32_t target = env->CP0_SAARI & 0x3f;
-    if (target < 2) {
-        env->CP0_SAAR[target] = arg1 & 0x00000ffffffff03fULL;
-        switch (target) {
-        case 0:
-            if (env->itu) {
-                itc_reconfigure(env->itu);
-            }
-            break;
-        }
-    }
-}
-
-void helper_mthc0_saar(CPUMIPSState *env, target_ulong arg1)
-{
-    uint32_t target = env->CP0_SAARI & 0x3f;
-    if (target < 2) {
-        env->CP0_SAAR[target] =
-            (((uint64_t) arg1 << 32) & 0x00000fff00000000ULL) |
-            (env->CP0_SAAR[target] & 0x00000000ffffffffULL);
-        switch (target) {
-        case 0:
-            if (env->itu) {
-                itc_reconfigure(env->itu);
-            }
-            break;
-        }
-    }
-}
-
 void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
 {
     target_ulong old, val, mask;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 12094cc1e7..173b19a090 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -5151,17 +5151,6 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CP0_REGISTER_09:
-        switch (sel) {
-        case CP0_REG09__SAAR:
-            CP0_CHECK(ctx->saar);
-            gen_helper_mfhc0_saar(arg, tcg_env);
-            register_name = "SAAR";
-            break;
-        default:
-            goto cp0_unimplemented;
-        }
-        break;
     case CP0_REGISTER_17:
         switch (sel) {
         case CP0_REG17__LLADDR:
@@ -5252,17 +5241,6 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         }
         break;
-    case CP0_REGISTER_09:
-        switch (sel) {
-        case CP0_REG09__SAAR:
-            CP0_CHECK(ctx->saar);
-            gen_helper_mthc0_saar(tcg_env, arg);
-            register_name = "SAAR";
-            break;
-        default:
-            goto cp0_unimplemented;
-        }
-        break;
     case CP0_REGISTER_17:
         switch (sel) {
         case CP0_REG17__LLADDR:
@@ -5680,11 +5658,6 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SAARI));
             register_name = "SAARI";
             break;
-        case CP0_REG09__SAAR:
-            CP0_CHECK(ctx->saar);
-            gen_helper_mfc0_saar(arg, tcg_env);
-            register_name = "SAAR";
-            break;
         default:
             goto cp0_unimplemented;
         }
@@ -6406,11 +6379,6 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_saari(tcg_env, arg);
             register_name = "SAARI";
             break;
-        case CP0_REG09__SAAR:
-            CP0_CHECK(ctx->saar);
-            gen_helper_mtc0_saar(tcg_env, arg);
-            register_name = "SAAR";
-            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7180,11 +7148,6 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SAARI));
             register_name = "SAARI";
             break;
-        case CP0_REG09__SAAR:
-            CP0_CHECK(ctx->saar);
-            gen_helper_dmfc0_saar(arg, tcg_env);
-            register_name = "SAAR";
-            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7892,11 +7855,6 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_saari(tcg_env, arg);
             register_name = "SAARI";
             break;
-        case CP0_REG09__SAAR:
-            CP0_CHECK(ctx->saar);
-            gen_helper_mtc0_saar(tcg_env, arg);
-            register_name = "SAAR";
-            break;
         default:
             goto cp0_unimplemented;
         }
-- 
2.41.0


