Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7989FC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 09:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYMpj-0005cz-Md; Fri, 09 Feb 2024 04:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMpi-0005bD-Nh
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:06:06 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYMph-0000hB-5M
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 04:06:06 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d094bc2244so7117841fa.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 01:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707469562; x=1708074362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nKmjKPYaXqxtBmNfQKEzaMf5GSszmv9atx7nueaYzHE=;
 b=zwCjor+mCs1SK+cbeG8yxb+5MML7Gno+GUMtsmDwu+hL+7aAzTeYIr2VNx0jFW9x5Y
 K/BvU1JM9IKDrdENT9kzp08Nb5gIDcExHjt2qOhDYNewNpcdZ9nmpQ0/lOY168VzVCew
 ayYtlqhbx6JjSYWT4IhLhNYl3TtVqoXerge3eB8SHxLKpQmoAtpxEDZanxgluF6KvJfc
 Wc++6KFmE4aPv+J/ZYjegRErNw3z1oUgDEXKY0w1Y9bHCGASfh4mRGK5SQ7nw2fvaBu3
 whcLxEIGOUzeHC24SiTDrY4fQl4O4BvVRQOHWqPzwGB2eFGC4al4ZBd8aZUAtoL3ls7s
 PgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707469562; x=1708074362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nKmjKPYaXqxtBmNfQKEzaMf5GSszmv9atx7nueaYzHE=;
 b=RIY0/lKYdiCf0WNHVY+entB8ZEla/c7YE8i0l/6iiEywat3kWMFRoTkyGiYDyRjIUe
 3QHawnJRdIfF1ACSUGoxBucSImv5I/LblIRJ7Gj3ABZEaCZYnSUKFA8XX5bt0OxIhLNO
 v93Su83oca6J5tuXqd6+XnxYOpz8GzDFtV2DwfsrAbltERctxzd8itkTuSX0k1HoAqPO
 eYgbDYrBnzpbJuXdy6hb07bTSaLNukIvQYRlFGvf4mqFRRa4mtkgke0VoxzRun8nT977
 CaZhn4yfwx3c8DqKdXIYta6iORakRrcOME8TACEtR8rCtlnp/w57s5OJGvJa4sC7mXrd
 SkbQ==
X-Gm-Message-State: AOJu0YzNJxlj64TaGmHdqF5+c+L4FPiVHvW81lA3J+gxdKST7wcOBDrf
 1fE7YpYtm/7YI94l33bE0CWmST3hrqX62wwGYh6MK4wF1M15IeD3PO6pDqYgft6QkX5zoFxQR3Y
 snqw=
X-Google-Smtp-Source: AGHT+IECxt3xMNP44d+95TZ0Ucw7hJLhgQw3SP7zAg24Ni6Z5LE1bwxxpy/x/sB24PEtuq2tgAdEEg==
X-Received: by 2002:a2e:a44a:0:b0:2d0:bef5:2483 with SMTP id
 v10-20020a2ea44a000000b002d0bef52483mr739863ljn.3.1707469562269; 
 Fri, 09 Feb 2024 01:06:02 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUlsvG6eEzZlKIevH0ydJHwOiZrC4bdhHrkEgKHjq72O46W2hjEyeYzSV67/wuAx9039QyAyG+tlhLlvLBzh5BuP4Qy+gX6oxvUDJD/0qs8Qhwn0xevZj2M4MVgEaeTNP19VF2zHKxSr4N/KEfauq9+OoWKjxhSEhqdPD009cLL/lqI/r5ZDB+zCYrfE1+ntdWKpAz0q4z++tGPC/pM+Ta1G0BUve1PJecL3OSAVarbOt+H1KkjucKZbvp1Yso8k/TXR+CvGV7rySNgWujufHRqYsPvgJMjN1mpoFy4wangIETPVTH+VTnGkRed7Dyir4zCcAzx9Ubq0WhcdaZqzeL2PkIS4Ts=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 f17-20020adfdb51000000b0033b599c61besm1277791wrj.34.2024.02.09.01.06.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 01:06:01 -0800 (PST)
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
Subject: [RFC PATCH 08/11] target/mips: Remove helpers accessing SAARI register
Date: Fri,  9 Feb 2024 10:05:09 +0100
Message-ID: <20240209090513.9401-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209090513.9401-1-philmd@linaro.org>
References: <20240209090513.9401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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
 target/mips/tcg/sysemu_helper.h.inc |  1 -
 target/mips/tcg/sysemu/cp0_helper.c |  8 --------
 target/mips/tcg/translate.c         | 20 --------------------
 3 files changed, 29 deletions(-)

diff --git a/target/mips/tcg/sysemu_helper.h.inc b/target/mips/tcg/sysemu_helper.h.inc
index 78f7272208..1861d538de 100644
--- a/target/mips/tcg/sysemu_helper.h.inc
+++ b/target/mips/tcg/sysemu_helper.h.inc
@@ -100,7 +100,6 @@ DEF_HELPER_2(mtc0_srsconf4, void, env, tl)
 DEF_HELPER_2(mtc0_hwrena, void, env, tl)
 DEF_HELPER_2(mtc0_pwctl, void, env, tl)
 DEF_HELPER_2(mtc0_count, void, env, tl)
-DEF_HELPER_2(mtc0_saari, void, env, tl)
 DEF_HELPER_2(mtc0_entryhi, void, env, tl)
 DEF_HELPER_2(mttc0_entryhi, void, env, tl)
 DEF_HELPER_2(mtc0_compare, void, env, tl)
diff --git a/target/mips/tcg/sysemu/cp0_helper.c b/target/mips/tcg/sysemu/cp0_helper.c
index f8883a3515..ded6c78e9a 100644
--- a/target/mips/tcg/sysemu/cp0_helper.c
+++ b/target/mips/tcg/sysemu/cp0_helper.c
@@ -1077,14 +1077,6 @@ void helper_mtc0_count(CPUMIPSState *env, target_ulong arg1)
     cpu_mips_store_count(env, arg1);
 }
 
-void helper_mtc0_saari(CPUMIPSState *env, target_ulong arg1)
-{
-    uint32_t target = arg1 & 0x3f;
-    if (target <= 1) {
-        env->CP0_SAARI = target;
-    }
-}
-
 void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
 {
     target_ulong old, val, mask;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 173b19a090..3ba2101647 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -5653,11 +5653,6 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             ctx->base.is_jmp = DISAS_EXIT;
             register_name = "Count";
             break;
-        case CP0_REG09__SAARI:
-            CP0_CHECK(ctx->saar);
-            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SAARI));
-            register_name = "SAARI";
-            break;
         default:
             goto cp0_unimplemented;
         }
@@ -6374,11 +6369,6 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_count(tcg_env, arg);
             register_name = "Count";
             break;
-        case CP0_REG09__SAARI:
-            CP0_CHECK(ctx->saar);
-            gen_helper_mtc0_saari(tcg_env, arg);
-            register_name = "SAARI";
-            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7143,11 +7133,6 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             ctx->base.is_jmp = DISAS_EXIT;
             register_name = "Count";
             break;
-        case CP0_REG09__SAARI:
-            CP0_CHECK(ctx->saar);
-            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_SAARI));
-            register_name = "SAARI";
-            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7850,11 +7835,6 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_helper_mtc0_count(tcg_env, arg);
             register_name = "Count";
             break;
-        case CP0_REG09__SAARI:
-            CP0_CHECK(ctx->saar);
-            gen_helper_mtc0_saari(tcg_env, arg);
-            register_name = "SAARI";
-            break;
         default:
             goto cp0_unimplemented;
         }
-- 
2.41.0


